Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC578A12F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjH0TeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjH0TeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:34:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA98C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:34:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bcade59b24so1995307a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693164842; x=1693769642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfuobNFZiIqUm1JZsSbHScwqD8twWVWxz8M0FngOBaU=;
        b=W6NguLYdal3s4o4UZi28iQ9mrJ62+WJTdtaZbaZ3UUf6GaxfwmPvKNzF0RUDxKhgfJ
         JO/3y11wS8z1VjCTiAnZd8/ppM+OPPXWLzKi7zv3wxQAhG8rveMpuAQs6ccRFl6jsZvA
         R6C9xlGCbpkD/Uslb4IYlsBma08JrXcdauwuqAuP/s1HFxT5UAJuD2RnzAsOd4pGOqhY
         y+KHDPZo4uVuJBkBB3dmnX78w1ucxoqZaN1m1NXp25CXZSN8wQfZ51sVl4mi7hrMUjXL
         uaNOpYaZNQ3J6sD+SXA5Z2GKvd2s3sMCvOc5NH2pe0Tx1qyVGRGC64xNHVXDGbU1rrcX
         QJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693164842; x=1693769642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfuobNFZiIqUm1JZsSbHScwqD8twWVWxz8M0FngOBaU=;
        b=GgL87f789CJ9YQJFBauPbVMoIe7faRNejQjcVNkhocH0CgSVbTxJkT7BPYFDhE7pEk
         OMtT/Pk2T7KqHIi278tTBbLHy96nDm55rTe9OKp+1r21v1NOlFwQfxrKvQzY/kjXRQOJ
         GVFDNOh27FRJv6WREEILR63MdI6RgRxt3CVmXOgRHqCbcgti99d0C5oLjuAmrKgWxIiM
         pf1gSmY5Nsz8sPMfMz68eI409D1GRoNyOyZsX2LwO6kEI8CezfHZKTzh9GQASpqQeqaS
         t14K+qElDlpdcf0ol02CCG4jiniQ9FKcYw3u7j8znNsGFPKuTnFPlN0TdxyiCeUwryJP
         CsuA==
X-Gm-Message-State: AOJu0YxMnl7x1t20QtC9HL+i8eZDVXIqGjwcG2RTYJiHs2u7au5lUc3t
        gYI9VNnj3sOy4N4JC+XTrpI=
X-Google-Smtp-Source: AGHT+IFF4sh2E0Dky2o8LohJbQLJcVgHVTEO1rtPT6IhI606JqnU5iu2NedcasdSsl1mHsQvibQqHw==
X-Received: by 2002:a05:6830:45b:b0:6bd:bba9:2d63 with SMTP id d27-20020a056830045b00b006bdbba92d63mr12999917otc.9.1693164841915;
        Sun, 27 Aug 2023 12:34:01 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006b96384ba1csm1640272otk.77.2023.08.27.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 12:34:01 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH v4 4/4] staging: vme_user: fix check unnecessary space after a cast in vme_fake.c
Date:   Sun, 27 Aug 2023 16:32:55 -0300
Message-ID: <603976b29ad4d9a0e4cbd8452ff674ec70a227a8.1693164540.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693164540.git.alexondunkan@gmail.com>
References: <cover.1693164540.git.alexondunkan@gmail.com>
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

Fixed all CHECK: No space is necessary after a cast
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

Changes in v3:
- Sent patch series in a single email thread, noted by Nam Cao

Changes in v4:
- Versioning the patch series with the forgotten information
about the changes in the previous versions, noted by Greg KH

 drivers/staging/vme_user/vme_fake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 4258ed6033e7..4ccb16dd0d0b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -95,7 +95,7 @@ static void fake_VIRQ_tasklet(unsigned long data)
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
 
-	fake_bridge = (struct vme_bridge *) data;
+	fake_bridge = (struct vme_bridge *)data;
 	bridge = fake_bridge->driver_priv;
 
 	vme_irq_handler(fake_bridge, bridge->int_level, bridge->int_statid);
@@ -1092,7 +1092,7 @@ static int __init fake_init(void)
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-		     (unsigned long) fake_bridge);
+		     (unsigned long)fake_bridge);
 
 	strcpy(fake_bridge->name, driver_name);
 
-- 
2.41.0

