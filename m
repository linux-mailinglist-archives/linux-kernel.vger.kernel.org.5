Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5FE756FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGQWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGQWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:25:48 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2592B1;
        Mon, 17 Jul 2023 15:25:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9defb366eso578262a34.2;
        Mon, 17 Jul 2023 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632743; x=1692224743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZFSpPeABBzG5XwaWyUoAc/E/gXj2NoOgUk68JvYyRY=;
        b=WP6VAqBtcBpW6Hrw19ysTmnUuDGdUskCQXcX2Qz1ytlSCUFXustKh+YQhs5ydL6Rju
         002hnHCV039FxxmavVVUosZ+fwVk+Fg2z/3ys8FRkdmkFJN20xuaO8MzUDLO+vE9lTZD
         e0jCvKGeweqlABLKO2GzHnk2RkoBZtVbCnpYDJ2VC2MQF2y9r15lCdVoIG5dAOECktNz
         MZqtfArNw+NE0tenCexfRL5aUDdoUsakEH/olq/Up7xx0DXpNp5dTgA01VITUfHagnHy
         a80FAp8gVRO3OF2G6qh8b+Tjsrn2ID+3nuiCZ9GuUblrEyoui49LMLKVhTrky+QwZ+SC
         UNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632743; x=1692224743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZFSpPeABBzG5XwaWyUoAc/E/gXj2NoOgUk68JvYyRY=;
        b=U5VWleMYCl+L0+saaDTJ1zzsBIN32Vd6+JCQUklpjb0OWrrqpchviWb0MTQo++Bnaz
         hOmM7bI4mTR4XMipm7zrjqDT/E81c/25FTd1aFCXBSmKtdhhRosYbjDPzip4h0njjutc
         ml4oV5MUKz4/jxJLexIWpk6/uVrQ1Vx/VY6E6wX0diXRkip9Dz7pT1PUFZw7NHfjFuq0
         3/2g45QbkyihirqGFU1brGFvyfQkSwmwqE52/b2uwTobSiwkQaXhm1QY6yg13GR+pKUN
         aW5/i7lNPMRvzyK2t+B1TDsEXU51sL2xu1ru0ubzPeKHudRMa2Vc1wuxVgaUcOiRCx8S
         ep1g==
X-Gm-Message-State: ABy/qLa5BeWyprFuuwhllx4sTHDGMVoXoZnb/LWxVziYtaQjM0e02+g/
        AqGt7Lr9L75YLHKXOMOXkVhZaJ2kAgk=
X-Google-Smtp-Source: APBJJlG1PnkyQzgUo4lcXtryj5QJWnlr+8+ntS4Vf4URmQNg7t5w3AFD4e/BYAgRZ5zQvM8qxOMsrQ==
X-Received: by 2002:a05:6870:c8aa:b0:1ad:2e18:7090 with SMTP id er42-20020a056870c8aa00b001ad2e187090mr13026815oab.32.1689632743205;
        Mon, 17 Jul 2023 15:25:43 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870374700b001ba72480f2fsm385553oak.43.2023.07.17.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:25:42 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 2/2] hwmon: (oxp-sensors) Move board detection to the init function
Date:   Mon, 17 Jul 2023 19:25:16 -0300
Message-ID: <20230717222526.229984-3-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717222526.229984-1-samsagax@gmail.com>
References: <20230717222526.229984-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move detection logic to the start of init() function so we won't
instantiate the driver if the board is not compatible.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 1e1cc67bcdea..ea9602063eab 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -434,23 +434,9 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
 /* Initialization logic */
 static int oxp_platform_probe(struct platform_device *pdev)
 {
-	const struct dmi_system_id *dmi_entry;
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
 
-	/*
-	 * Have to check for AMD processor here because DMI strings are the
-	 * same between Intel and AMD boards, the only way to tell them apart
-	 * is the CPU.
-	 * Intel boards seem to have different EC registers and values to
-	 * read/write.
-	 */
-	dmi_entry = dmi_first_match(dmi_table);
-	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
-		return -ENODEV;
-
-	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
-
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
@@ -469,6 +455,21 @@ static struct platform_device *oxp_platform_device;
 
 static int __init oxp_platform_init(void)
 {
+	const struct dmi_system_id *dmi_entry;
+
+	/*
+	 * Have to check for AMD processor here because DMI strings are the
+	 * same between Intel and AMD boards, the only way to tell them apart
+	 * is the CPU.
+	 * Intel boards seem to have different EC registers and values to
+	 * read/write.
+	 */
+	dmi_entry = dmi_first_match(dmi_table);
+	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return -ENODEV;
+
+	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
+
 	oxp_platform_device =
 		platform_create_bundle(&oxp_platform_driver,
 				       oxp_platform_probe, NULL, 0, NULL, 0);
-- 
2.41.0

