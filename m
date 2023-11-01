Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9507DE923
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjKAXxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKAXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:53:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA216C2;
        Wed,  1 Nov 2023 16:53:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f61322fso2592935e9.1;
        Wed, 01 Nov 2023 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698882814; x=1699487614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BgQx+ZoqpwlxPpWNlIrALpYgnFDkCJPO5cLrhzB9PI=;
        b=jrz+Tcfe+05NnCxvv+djkcm27Tvx3reP9M+pszJXOQlvsz5uw2DSKlbJ1Sbs3ifcLU
         jCDHbKcr1k45NxC0BVg551I12+WT7Pm8KJxLeMes+wnEIrvA4gpDPrfntk2ga1bfQFPa
         MlK01oR9egNfMQHPQQX64/RZ6Vz5woA/BlvIAHDl48Zumc5nFYwgfZnYnhCMS4GQiZk2
         qOoxu/kkP62zQ6d/1xth7jyFW9946UKLiKd1eJzmeDd8qxAn1cxFBS/VXHQ2mp6ZVpV2
         PJQG9UjLYlcmbvUbTYJ3noA6a9A7m0rQXVWaeeClH4W433exi0S17vForREvF11O8f60
         EC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698882814; x=1699487614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BgQx+ZoqpwlxPpWNlIrALpYgnFDkCJPO5cLrhzB9PI=;
        b=VpkyOBTrD4lv3PNDuZR4w8u4g1UO8VsKpOVA6COKVpBLuNn+zcBesMGXGNIfNXUQBM
         PFF3ifKQz2rZQiHbTwIWr1V5kg4pPi2d2T145n2AGR558YRzlvKuooR/JTlkIlRuUs81
         4MucaFgRIMf3eD/GJdk/rZBrfdBD9VifnTvwd3B7GmD1VLSFXSkgiE93If/g0E0HIDe1
         ivSxEVBhlKGnlWAQgd2M3Nfqexfl11JdAz+Lrfbi9yhXj0k34ejNi4R2Ir3S/hJBYl+G
         lsqjvC+fpkJtApSpLnO78tnCE3xMvIojNV7kA39c0OirMSEzbPfo3bJj9Z65vImXsR04
         onoA==
X-Gm-Message-State: AOJu0YyBB2TVUnqmGWVvaUJ7QS5vIJ/Honp6hXUUzCPiiEZYOYUQA1uL
        Mqj36PXgvdOGzrb0ZKVi3QE=
X-Google-Smtp-Source: AGHT+IGo5bIUIzQ8KJtHM9VlInvkNOfDXo2WDE5tMgw3TN28eWBB5DdK4IiQ1cmKvQ8keolWoy+MNA==
X-Received: by 2002:a05:600c:1f87:b0:406:411f:742e with SMTP id je7-20020a05600c1f8700b00406411f742emr14103113wmb.34.1698882813966;
        Wed, 01 Nov 2023 16:53:33 -0700 (PDT)
Received: from archlinux.. ([88.127.172.169])
        by smtp.gmail.com with ESMTPSA id y20-20020a1c4b14000000b00406408dc788sm1031347wma.44.2023.11.01.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:53:33 -0700 (PDT)
From:   dimadrumspro@gmail.com
X-Google-Original-From: dimadrumspro@@gmail.com
To:     dimaac@bk.ru
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        dimaaac <dimadrumspro@gmail.com>
Subject: [PATCH 2/2] drivers: tty: vt: vt.c: fixed segmentation fault in vt.c
Date:   Thu,  2 Nov 2023 00:53:32 +0100
Message-ID: <20231101235332.4314-1-dimadrumspro@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dimaaac <dimadrumspro@gmail.com>

The previous code lacked proper synchronization, leading to potential data corruption and crashes. Added a spin lock to protect shared variable 'scrollback_delta' to prevent concurrent access.

Signed-off-by: dimaaac <dimaac@bk.ru>
---
 drivers/tty/vt/vt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c47f77804f0..29cf7fe11662 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -301,12 +301,13 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 }
 
 /* Called  from the keyboard irq path.. */
+static DEFINE_SPINLOCK(scrolldelta_lock);
+
 static inline void scrolldelta(int lines)
 {
-	/* FIXME */
-	/* scrolldelta needs some kind of consistency lock, but the BKL was
-	   and still is not protecting versus the scheduled back end */
+	spin_lock(&scrolldelta_lock);
 	scrollback_delta += lines;
+	spin_unlock(&scrolldelta_lock);
 	schedule_console_callback();
 }
 
-- 
2.42.0

