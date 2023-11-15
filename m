Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1477ED550
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbjKOVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjKOVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:09 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADDEAB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:56 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so27126fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082176; x=1700686976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqS2umDahExgvUp9vYjVtRrP0HXmO16NeUGqzSCCh8k=;
        b=G0xULteVwLcZRCu+qHpibkXEQLcCiwVFREWyero8Zgp+/mgjqiXkL/Wuu25FGz+oGd
         7+FWTMjGjgBJE2e91oL5mvFTas6mSt6/klJdSXjUsSGG9BCwVxzWrlzxQbHSzBtQDuuB
         /591K5ohABLUuzh9ZgUiTlu+cNPhZGayp2+UQgnggmjgR6jeKhOCuwZbXu7tTRMpIxQP
         2n83Ecr6oOyaRslsobwRgNUTYQ3M4V9PDQHlr6DSr9NYb9gVQY2Rr5WkdEKscQNMXkws
         OnBqkKu+uzBlyYmQWscIoZwH6Z9rTfwtdBU4AwxpgBhPfNjvKG/q+wzAUzZJiY5bKw+N
         CiUw==
X-Gm-Message-State: AOJu0YwvjlXal4EQ4UeKkVvcPxBnH1Cs3du372gQ0SqxIV5YnmzsBr12
        19w7I+Cj39/DCl+pX5h4Q6vD5FV7kg==
X-Google-Smtp-Source: AGHT+IGjXydHagjHksyzJF7HiwPBQUknb8zDIfsjVC6BwxVRyhA5W9oi3Ts6H4fnJqfs3BK2JqTaAw==
X-Received: by 2002:a05:6870:8895:b0:1ef:b16f:d29d with SMTP id m21-20020a056870889500b001efb16fd29dmr15609299oam.18.1700082175882;
        Wed, 15 Nov 2023 13:02:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g6-20020a0568300a4600b006ce28044207sm690053otu.58.2023.11.15.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:02:54 -0800 (PST)
Received: (nullmailer pid 3744821 invoked by uid 1000);
        Wed, 15 Nov 2023 21:02:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:02:44 -0600
Message-ID: <20231115210245.3744589-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/auxdisplay/img-ascii-lcd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index fa23e415f260..c16a14becdfc 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -8,9 +8,9 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -225,17 +225,12 @@ MODULE_DEVICE_TABLE(of, img_ascii_lcd_matches);
  */
 static int img_ascii_lcd_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct img_ascii_lcd_config *cfg;
 	struct device *dev = &pdev->dev;
 	struct img_ascii_lcd_ctx *ctx;
 	int err;
 
-	match = of_match_device(img_ascii_lcd_matches, dev);
-	if (!match)
-		return -ENODEV;
-
-	cfg = match->data;
+	cfg = device_get_match_data(&pdev->dev);
 	ctx = devm_kzalloc(dev, sizeof(*ctx) + cfg->num_chars, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-- 
2.42.0

