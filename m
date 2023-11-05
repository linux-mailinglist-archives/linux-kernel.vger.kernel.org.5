Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1C7E126E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKEHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:20:07 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FCFFB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 00:20:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2b1af964dso2284139b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699168804; x=1699773604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkBJYB+0amHU7Uh6j8q6rO4qnVt0jhVk588GzDZ5r/s=;
        b=AwhM0TiEfB3gZyfLA9NALxVHOVBGbmqGC8i7B9SjQihNbf+ItwSf29QUmkX/cuhPf4
         wvLrhsMwHz6LE6uI44aYya6R36sixI936E2766mmfJHXaffgertgTnSLkNq7c2Me0qXP
         dhZQ05/JODZg41CQce8TtTsdEaxwLqH7KKsGvR4WHe0XcMfb3zQCO+IJK+0tKuGPuEPR
         s6+0M8Ytzk6c6ck5Bqc4sENM1tqhZXmLKJU7F8jJWGmin+m7lZbnNeig7D0ZFNYNUiyv
         +9uvdSuglerKHqKLO2p0JOVt06erTZboQ+1FkyenVlVMxp6eLJdwl6pdWukqdB7vk6Vy
         Z7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699168804; x=1699773604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkBJYB+0amHU7Uh6j8q6rO4qnVt0jhVk588GzDZ5r/s=;
        b=IozFF079Bv5g9DAVjxdbByOFMUXiXQFwxDcwsvl6DJPdf9ej7ez3TSe+YAjBrdaI/M
         Qatz3a1HOAGo7tLEEpvzkMVfhz/P9qPc4hMziAAFJyxtcJrgJx128ufM2FMmnTZ43/zv
         yB2QXlC78bDVdiSCI4EcY/6G3K7T/w/76hoS/sM+xoFHq23tUfECpDVATZNUI6KCaw0y
         XQ2p9W/wiUfG/QAty3n+ogW5EgsMcz+m9gBj+3+5wOoNQ5cg0qIjgxXNQY8TCURnQw9B
         2WYnDRnFJfzGcaXrZLpI2KNmX/oIP62odWpEUj51i6zBohgvWV3EBN9om42/LJHga+KY
         V3ew==
X-Gm-Message-State: AOJu0Yxfo6yz1vXFSqZVpUnx9C7LVhq5P6M1mJfli0XEtSCbqVgMgcDU
        ejwu0fnAQNudWiEmG/ncuFSbD1KiWFmonw==
X-Google-Smtp-Source: AGHT+IGeZs1dYM5jzBN7R9cDEt1OZ4CuAZXg8IqiD3aV4gOf9Rpc0yNTlTG8Cp9K4cRfEoZzsbPVRQ==
X-Received: by 2002:a54:4883:0:b0:3b2:f2e0:1ecd with SMTP id r3-20020a544883000000b003b2f2e01ecdmr29246556oic.4.1699168804264;
        Sun, 05 Nov 2023 00:20:04 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:d1f4:b6cb:ff09:d775])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm3813324pfm.142.2023.11.05.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 00:20:03 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] mm/page_owner: record and dump free_pid and free_tgid
Date:   Sun,  5 Nov 2023 20:19:48 +1300
Message-Id: <20231105071948.44079-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating some complex memory allocation and free bugs
especially in multi-processes and multi-threads cases, from time
to time, I feel the free stack isn't sufficient as a page can be
freed by processes or threads other than the one allocating it.
And other processes and threads which free the page often have
the exactly same free stack with the one allocating the page. We
can't know who free the page only through the free stack though
the current page_owner does tell us the pid and tgid of the one
allocating the page. This makes the bug investigation often hard.

Thus, This patch adds free pid and tgid in page_owner, so that we
can easily figure out if the freeing is crossing processes or
threads.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_owner.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f13ce7d2452..767ec15da8da 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -32,6 +32,8 @@ struct page_owner {
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
 	pid_t tgid;
+	pid_t free_pid;
+	pid_t free_tgid;
 };
 
 static bool page_owner_enabled __initdata;
@@ -152,6 +154,8 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->free_pid = current->pid;
+		page_owner->free_tgid = current->tgid;
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
@@ -495,7 +499,8 @@ void __dump_page_owner(const struct page *page)
 	if (!handle) {
 		pr_alert("page_owner free stack trace missing\n");
 	} else {
-		pr_alert("page last free stack trace:\n");
+		pr_alert("page last free pid %d tgid %d stack trace:\n",
+			  page_owner->free_pid, page_owner->free_tgid);
 		stack_depot_print(handle);
 	}
 
-- 
2.34.1

