Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA57ED5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjKOVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjKOVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:11:29 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB5BD;
        Wed, 15 Nov 2023 13:02:15 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso56667a34.0;
        Wed, 15 Nov 2023 13:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082134; x=1700686934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2Lx7bpHkEQXXmBaZiy/OLdr3mXj8JC+CtgHgux9ZD0=;
        b=h8zn7uSeAdlpB+yTkww06+Wf5rYiVB62uuyTVbUb9sBjz5+gr9gwy/+7nRWYpI0tlo
         /bODdTezf050cKsec5NIt2sSyB13jd5uhpGxpXbQCQVJoTrFC+hOymfwiPQGoJalTM1R
         CFEgwT5gyQMHaPR3YJGyZmJ35tHrv6oZqsnLEFnrH3nlSFA+cQfstIjSbOYypJAbNCxP
         W5NaL6glCKdDwD8m1MrlIFpQrKblJR++KusyiIKfqakmrca/E0vDEIVW9cX1YxT/76zF
         objDxMkk5pB/g6IAin/LJBibdhnBOXej8kNHSX3zJzMh2Q6Qkdx98ASMdyXjTQR5PP3H
         aX+g==
X-Gm-Message-State: AOJu0YxWLYaJgfhulYbty7gYm1eO9bv9mUP7hzBJ0lQg0h/haxW095Mj
        cwOFqKiuIS+8zkdMTklPkQ==
X-Google-Smtp-Source: AGHT+IHF9xNKIrGqT7/hCzzhhO/f/Ss+YhiO4n+OnUXCarrX9ozu4waz/7x1ZbmM6jWxeDRyItFHYg==
X-Received: by 2002:a05:6830:4109:b0:6ba:865b:ca72 with SMTP id w9-20020a056830410900b006ba865bca72mr7119247ott.31.1700082134428;
        Wed, 15 Nov 2023 13:02:14 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d774f000000b006d653b68fdesm692218otl.55.2023.11.15.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:02:13 -0800 (PST)
Received: (nullmailer pid 3743815 invoked by uid 1000);
        Wed, 15 Nov 2023 21:02:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] EDAC: altera: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:02:01 -0600
Message-ID: <20231115210201.3743564-1-robh@kernel.org>
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
 drivers/edac/altera_edac.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..541acf5eba05 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -279,7 +280,6 @@ static int a10_unmask_irq(struct platform_device *pdev, u32 mask)
 
 static int altr_sdram_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *id;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	struct altr_sdram_mc_data *drvdata;
@@ -290,10 +290,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	int irq, irq2, res = 0;
 	unsigned long mem_size, irqflags = 0;
 
-	id = of_match_device(altr_sdram_ctrl_of_match, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-
 	/* Grab the register range from the sdr controller in device tree */
 	mc_vbase = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						   "altr,sdr-syscon");
@@ -304,8 +300,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	}
 
 	/* Check specific dependencies for the module */
-	priv = of_match_node(altr_sdram_ctrl_of_match,
-			     pdev->dev.of_node)->data;
+	priv = device_get_match_data(&pdev->dev);
 
 	/* Validate the SDRAM controller has ECC enabled */
 	if (regmap_read(mc_vbase, priv->ecc_ctrl_offset, &read_reg) ||
-- 
2.42.0

