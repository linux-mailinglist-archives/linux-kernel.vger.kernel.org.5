Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490257AF1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjIZRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjIZRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:37:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E8DC;
        Tue, 26 Sep 2023 10:37:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c61c511cbeso7780335ad.1;
        Tue, 26 Sep 2023 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695749865; x=1696354665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avIZNP/kVwTxfUJrkUHAHZVU2AnGKIlWeQ7L/YwCkE0=;
        b=HM34oUXHfI2Zs87uI9vWG9+KcDkKcaPMwusPKXS4UdY9Rh7edyNscZYGcvz799BlnG
         EnTxvSG6A4Wewf0Z2WDO6H79+Up2+fcAT3IWE/v7xYwu+1ycoJSj2vtW8ZUE+RIxrJXR
         cjGDGM6AYjGaN+LjXZoml/TwwA/hVuKFyEZeDAwCR5ZXe3IHWMyabWOA5jwWNnjYI8NA
         LWntGGdgecpvTD0OZfLh2LYzpfiYQN54wRiqVuWiwjd27Jmh5xpCgfzCVnGGMJ3oANuA
         cMaAL/mJxUnq252VEB7FoAiT240tk516U17CTsavRDfH4MNp+PNIuFi7nV0G4BafYXUl
         ZHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695749865; x=1696354665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avIZNP/kVwTxfUJrkUHAHZVU2AnGKIlWeQ7L/YwCkE0=;
        b=aXL6Ve+cgKFvOHfPKfIU+8EafXZT/KEin6X6JSQv2HSUewdMye5QS39cXAUURMDEKk
         etjaqfB5SWqYHQSgQ504Y6MJdBZ/FiO7hohBX8p0VGIgqCiTnogMpapyRC2qj61bHXAe
         ux5+xZv5gZftM35gxpjfs+pFDwPGYNa89ORAmBAoTv4M5dkxRNej8Jci1QYMGbxGml0P
         WKZQdTdXtX6Ydyb5A4FdX4CeDhRRfG9wBeAsfa4OI7kZzM6JuIlWDtEU3AsQgju0TxXv
         RcOl/46qasIa7NQLC+ayS/6g7zCYJi1Ji5RnrQ1Wl1F52xIqZK3KqjTF4BMdp9fbWaKu
         3BSQ==
X-Gm-Message-State: AOJu0YzfVu1Lf/HCbSLSd2//XJK3gAPbTSIj2Dl7vrTR55x1I7CF2ay+
        WB/vzRkEMzzZfBivAHfVe7E=
X-Google-Smtp-Source: AGHT+IF2tkOY68FSq4ob220vK3b9PCoX1xYhW2HvjiAkuH7E9cmpvhwghAKGXUqqf6g3b/L04fLlgA==
X-Received: by 2002:a17:902:d4c5:b0:1c3:a4f2:7c99 with SMTP id o5-20020a170902d4c500b001c3a4f27c99mr11781313plg.4.1695749865561;
        Tue, 26 Sep 2023 10:37:45 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001adf6b21c77sm11310927plb.107.2023.09.26.10.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:37:44 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] tools/thermal: remove unused 'mds' and 'nrhandler' variables
Date:   Wed, 27 Sep 2023 01:37:36 +0800
Message-Id: <20230926173736.1142420-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <93c87b5c-ae8f-d27d-0342-faa884a3142e@linaro.org>
References: <93c87b5c-ae8f-d27d-0342-faa884a3142e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous code, the 'mds' and 'nrhandler' variables were not
utilized in the codebase. Additionally, there was a potential NULL
pointer dereference and memory leak due to improper handling of memory
reallocation failure.

This patch removes the unused 'mds' and 'nrhandler' variables along with
the associated code, addressing the unused variable issue, NULL pointer
dereference issue and the memory leak issue.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes since v1:
 * Remove the unused 'mds' and 'nrhandler' variables along with the
   associated code.

 tools/thermal/lib/mainloop.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/thermal/lib/mainloop.c b/tools/thermal/lib/mainloop.c
index 94cbbcbd1c14..bf4c1b730d7b 100644
--- a/tools/thermal/lib/mainloop.c
+++ b/tools/thermal/lib/mainloop.c
@@ -9,7 +9,6 @@
 #include "log.h"
 
 static int epfd = -1;
-static unsigned short nrhandler;
 static sig_atomic_t exit_mainloop;
 
 struct mainloop_data {
@@ -18,8 +17,6 @@ struct mainloop_data {
 	int fd;
 };
 
-static struct mainloop_data **mds;
-
 #define MAX_EVENTS 10
 
 int mainloop(unsigned int timeout)
@@ -61,13 +58,6 @@ int mainloop_add(int fd, mainloop_callback_t cb, void *data)
 
 	struct mainloop_data *md;
 
-	if (fd >= nrhandler) {
-		mds = realloc(mds, sizeof(*mds) * (fd + 1));
-		if (!mds)
-			return -1;
-		nrhandler = fd + 1;
-	}
-
 	md = malloc(sizeof(*md));
 	if (!md)
 		return -1;
@@ -76,7 +66,6 @@ int mainloop_add(int fd, mainloop_callback_t cb, void *data)
 	md->cb = cb;
 	md->fd = fd;
 
-	mds[fd] = md;
 	ev.data.ptr = md;
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) < 0) {
@@ -89,14 +78,9 @@ int mainloop_add(int fd, mainloop_callback_t cb, void *data)
 
 int mainloop_del(int fd)
 {
-	if (fd >= nrhandler)
-		return -1;
-
 	if (epoll_ctl(epfd, EPOLL_CTL_DEL, fd, NULL) < 0)
 		return -1;
 
-	free(mds[fd]);
-
 	return 0;
 }
 
-- 
2.25.1

