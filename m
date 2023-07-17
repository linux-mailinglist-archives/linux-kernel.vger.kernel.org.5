Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200147562F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGQMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGQMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:40:52 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF6E56;
        Mon, 17 Jul 2023 05:40:50 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso3477792fac.0;
        Mon, 17 Jul 2023 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689597649; x=1692189649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NResrH/dwxJIXwvQtz2wBMlaGEhGmTQmAGoAye4iGiI=;
        b=Nbd+0cMgqaIZOZVN4VrsMWp34BzbhFFNwvhTlMuMffSsup3fWX8AV9ahT/1rQroW1I
         B3K60HBPRNne9Oqusn95f/yWJtpiDB+H3gzTnwMUmBIhe5voHUEmasN/PlXQcylCx5Xq
         usxV9PIFcu9cr0yH0X35ed0lNwxKBbBEvhNTfc61Hoj2MBXDeDrKk+nCmMSMvWOriNo4
         XKA3CbVYTCY0/mxEBkRSKCkjlZ1H8Rtm8MOi2sak8gD7cuLHbPuGwtbomhs4iRvrEJ7W
         iXglIPogO0kT29aQrqgrWj+k/I1NhpIv3K9qgehqUKu+DvB7Nz80stXwejm3FGSoNYLP
         B/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597649; x=1692189649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NResrH/dwxJIXwvQtz2wBMlaGEhGmTQmAGoAye4iGiI=;
        b=Stm4WBNPlmxQ0+35cbI4RRGVM+/xmseCs9S2RNhdzFY2rPeoQoTNycx7IExrhjDL1X
         CRkhY9tyy7R5YEgpeJWedVbNJO15kZfsQF1ZQc5u18Yas+pS5FpuhCuP40ejbpf3JBWr
         ZjbKCgR5XVu/vILjr5WyZCM8rp5mxhu2WD/v7QDmIOcKPOnC/en3DKN1kOn9g/bHUW2C
         lvdGEi2MwigFZkcCZ9BdVNxp9BsEhMha9KIkRQFzAW/bnZIOfsV24wvGVJK1ll2RaWzV
         HGubB5y8nx05scR3js1G5IboxoV3g7kjq4HY62m/KsYnUQvhdnL+nOQ9B++pkuXCzl4g
         LqgA==
X-Gm-Message-State: ABy/qLaTP/IxHKLCRHeUiZArjSTa2cBguiR54VFXpiBqSwgHpK+AMq8d
        qIXExoE/85Fks2BMxRnxZF0=
X-Google-Smtp-Source: APBJJlEjR4llcJpJlZj85F1owd8zUWXyMZoIaHXT8X79AbQ/5V/POwh841ShoduTD1EGqLy+2nWvkw==
X-Received: by 2002:a05:6871:b0c:b0:1b0:3433:7664 with SMTP id fq12-20020a0568710b0c00b001b034337664mr12647885oab.40.1689597649554;
        Mon, 17 Jul 2023 05:40:49 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id em30-20020a0568705b9e00b001b02a3426ddsm7032173oab.14.2023.07.17.05.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:40:49 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/3] hwmon: (oxp-sensors) Move board detection to the init function
Date:   Mon, 17 Jul 2023 09:40:05 -0300
Message-ID: <20230717124013.38796-4-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717124013.38796-2-samsagax@gmail.com>
References: <20230717124013.38796-2-samsagax@gmail.com>
MIME-Version: 1.0
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

This driver is not hotpluggable by nature so it makes more sense to
detect the board on init() instead of on probe().

Move detection logic to the start of init() function so we won't
instantiate the driver if the board is not compatible.
---
 drivers/hwmon/oxp-sensors.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 1e1cc67bcdea..c70d9355eeba 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -438,19 +438,6 @@ static int oxp_platform_probe(struct platform_device *pdev)
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
 
@@ -469,6 +456,21 @@ static struct platform_device *oxp_platform_device;
 
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

