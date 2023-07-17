Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38047562F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGQMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGQMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:40:54 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1010D7;
        Mon, 17 Jul 2023 05:40:53 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b38121a011so3336631fac.2;
        Mon, 17 Jul 2023 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689597652; x=1692189652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1245q7RdkHHn0geBQ7otTdkqOOaXep5soyGm2gOl4DI=;
        b=HDshjTlgf6EKSidSjTNxj8gmqnCRUllPK4Z2XU4oL2qj6/CRoomQcBVNBvkvlkIDA1
         7wiox/XvvUXb81+Sgijbi4ElgTbLvIwDZ1TcLGDSMrCAdlBkjPOfl/HD8G3mFy02ggzw
         4hKScY0ARpfhAC/i8U+y8FZzZNjKox+wydJGKPGadaw86uHsVMegNlWvX6b67IsoVq+o
         l529n/WslD++ATVi24LRdcz1J0W2pbq7ENv1vcu3PBZY4263FFu+kzQtcb5ruvveFOVJ
         B5ko0N6Q3rOdj6LzwERMEYIhGCHILHufi6rsUVstVibVcX1ly9WsNZJODzeEo+JCt+kd
         p2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597652; x=1692189652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1245q7RdkHHn0geBQ7otTdkqOOaXep5soyGm2gOl4DI=;
        b=RO0o+1RyneFkTKj/REd/P4T+dvUdqueFCVhFrANJnDyLWnFiJyzU38XVvjzplkxdcj
         wzlghutufzh2IT97RgcNmm8JKWOvkJ3TiKz7LBSWA5adcVuTLSwCBOBVGTJ//+I5F2uV
         K+hY705sB3p33lAWGFGSwtUjyIMghgzlZ2BT9Px678OI+LUNWjyI4e1t0HlHa/QMH0nR
         8k/rqKncvP+WrjrL71N+WN9O4IaI/z9RiAMCIrQejMrMe6nSmQwyTlqXb5Rbb8jUUbKT
         cJai/nr4RGFuMegtaGJkGYsvrYHv2DV1RvqR353v72+G2FTYdlYLHVBTrQaON3wlIdSn
         +aNQ==
X-Gm-Message-State: ABy/qLacq60gaawlVe4zoQ7dQ2UGWuAU24uQ0kt1WcgY7f6v/QkHMCnb
        RHRmBxZbLKxo+i3wnU8/VZo=
X-Google-Smtp-Source: APBJJlFxOe6NsX7ch3zGLNn+HwDWmIwqr+3YB9RJGcU5Dw9LVGbqJamH3G3pq78vxMSSxl3NLflxBw==
X-Received: by 2002:a05:6870:ac07:b0:1b0:7eac:70ae with SMTP id kw7-20020a056870ac0700b001b07eac70aemr12561509oab.33.1689597652728;
        Mon, 17 Jul 2023 05:40:52 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id em30-20020a0568705b9e00b001b02a3426ddsm7032173oab.14.2023.07.17.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:40:52 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 3/3] hwmon: (oxp-sensors) Refactor init() and remove probe()
Date:   Mon, 17 Jul 2023 09:40:06 -0300
Message-ID: <20230717124013.38796-5-samsagax@gmail.com>
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

Since the driver is not hotpluggable the probe() funtion is not used
more than once.

Move all attribute registration logic to the init() function.
---
 drivers/hwmon/oxp-sensors.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index c70d9355eeba..39de49c8a392 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -431,32 +431,20 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
 	.info = oxp_platform_sensors,
 };
 
-/* Initialization logic */
-static int oxp_platform_probe(struct platform_device *pdev)
-{
-	const struct dmi_system_id *dmi_entry;
-	struct device *dev = &pdev->dev;
-	struct device *hwdev;
-
-	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
-						     &oxp_ec_chip_info, NULL);
-
-	return PTR_ERR_OR_ZERO(hwdev);
-}
-
 static struct platform_driver oxp_platform_driver = {
 	.driver = {
 		.name = "oxp-platform",
 		.dev_groups = oxp_ec_groups,
 	},
-	.probe = oxp_platform_probe,
 };
 
 static struct platform_device *oxp_platform_device;
 
+/* Initialization logic */
 static int __init oxp_platform_init(void)
 {
 	const struct dmi_system_id *dmi_entry;
+	struct device *hwdev;
 
 	/*
 	 * Have to check for AMD processor here because DMI strings are the
@@ -472,10 +460,21 @@ static int __init oxp_platform_init(void)
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
 	oxp_platform_device =
-		platform_create_bundle(&oxp_platform_driver,
-				       oxp_platform_probe, NULL, 0, NULL, 0);
+		platform_create_bundle(&oxp_platform_driver, NULL, NULL, 0,
+				       NULL, 0);
+	if (IS_ERR(oxp_platform_device))
+		return PTR_ERR(oxp_platform_device);
 
-	return PTR_ERR_OR_ZERO(oxp_platform_device);
+	hwdev = devm_hwmon_device_register_with_info(&oxp_platform_device->dev,
+						     "oxpec", NULL,
+						     &oxp_ec_chip_info, NULL);
+	if (IS_ERR(hwdev)) {
+		platform_device_unregister(oxp_platform_device);
+		platform_driver_unregister(&oxp_platform_driver);
+		return PTR_ERR(hwdev);
+	}
+
+	return 0;
 }
 
 static void __exit oxp_platform_exit(void)
-- 
2.41.0

