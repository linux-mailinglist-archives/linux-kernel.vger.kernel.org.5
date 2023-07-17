Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CF7562EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGQMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGQMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:40:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A81B0;
        Mon, 17 Jul 2023 05:40:46 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b03ec2015fso2956902fac.3;
        Mon, 17 Jul 2023 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689597645; x=1692189645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CST2V5HUJAp534l0pQswZcm6gl2QiyFZ0HpK2IOlhFU=;
        b=ARJps01w3DllVpl2+KbVZuXzWSgNsiVPaWlIpiXecckN56qqjVG3GAjYVmozjx8xEJ
         nnXYwf0m8+vhhRVAvS+Ewp86moeXHJA1l1cTnVAXt1xxAxcH83sHC+zJxgX6VrO3wv3e
         Wow53E/FWfEr/pnS9dTbPVloF4HM9FTmjzItR/j2JXZPZCAqzxYtacBZQcrIAxuYEPFt
         15vHzavixeXjjM1XihRbuXrVACXlGbjvA97nA5eUxcsWP16vphon5duI2agJJT2JwANb
         ukFxKT9v4V9loswL6bOuvHyVVUvLby95IndKDzDyeU3kSqgwBwzASmA/I2f5hyT8c79Z
         FlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597645; x=1692189645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CST2V5HUJAp534l0pQswZcm6gl2QiyFZ0HpK2IOlhFU=;
        b=X6MhSpH1oJCywytYaDY3tc6BCQmFuzHNUpPZSfGlyUy1OLF1B8iVNI1ka2Ct2AIo/u
         1xxMAL2e468CrYDbJOQxu3yFmPLsbZO/IfaIqq2tINmb1ayIB1yZxeLWdX2+Ne+RliyM
         FZowJfLaDHVz+Ck7P3rdy6j0CoXFFkhQ3Z5yyFnvlOEYLV3ALrWyCn+muvSxaLLrIw0B
         s7ZXfC9GzAfHsaCvj7FI/+zt8FgyhKlkwMKIUfa7g2Np3rBQohqQVw3uoxRmvLuZ4Mlx
         7E1ikNT6ahEFX4molmMcziHlyeteUiuJdNgYz8nuDCJvrEbGVL4XFRAzbdoV2D8dOkob
         tpRQ==
X-Gm-Message-State: ABy/qLZ4ytNHjOlaxHNPWNq/ykNrNRO0YpCb7zg+ZKzfKBy5S5VG+9Jp
        VyZJ1OCIkxf9/f18hDoUH1k=
X-Google-Smtp-Source: APBJJlFH4o7Ybil9AUgrIfIPVAtUsxS31uEVLlevGHqE4qMzPBGTHIju6u0FhA6GqiOBZ/oywT3HgA==
X-Received: by 2002:a05:6870:5623:b0:1b3:738e:a341 with SMTP id m35-20020a056870562300b001b3738ea341mr11780347oao.46.1689597645617;
        Mon, 17 Jul 2023 05:40:45 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id em30-20020a0568705b9e00b001b02a3426ddsm7032173oab.14.2023.07.17.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:40:45 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/3] hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups
Date:   Mon, 17 Jul 2023 09:40:04 -0300
Message-ID: <20230717124013.38796-3-samsagax@gmail.com>
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

A driver should not be manually adding groups in its probe function (it will
race with userspace), so replace the call to devm_device_add_groups() to use
the platform dev_groups callback instead.

This will allow for removal of the devm_device_add_groups() function.
---
 drivers/hwmon/oxp-sensors.c | 38 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index e1a907cae820..1e1cc67bcdea 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -220,6 +220,20 @@ static int tt_toggle_disable(void)
 }
 
 /* Callbacks for turbo toggle attribute */
+static umode_t tt_toggle_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	switch (board) {
+	case aok_zoe_a1:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+		return attr->mode;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static ssize_t tt_toggle_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
@@ -396,7 +410,15 @@ static struct attribute *oxp_ec_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(oxp_ec);
+static struct attribute_group oxp_ec_attribute_group = {
+	.is_visible = tt_toggle_is_visible,
+	.attrs = oxp_ec_attrs,
+};
+
+static const struct attribute_group *oxp_ec_groups[] = {
+	&oxp_ec_attribute_group,
+	NULL
+};
 
 static const struct hwmon_ops oxp_ec_hwmon_ops = {
 	.is_visible = oxp_ec_hwmon_is_visible,
@@ -415,7 +437,6 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	const struct dmi_system_id *dmi_entry;
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
-	int ret;
 
 	/*
 	 * Have to check for AMD processor here because DMI strings are the
@@ -430,18 +451,6 @@ static int oxp_platform_probe(struct platform_device *pdev)
 
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
-	switch (board) {
-	case aok_zoe_a1:
-	case oxp_mini_amd_a07:
-	case oxp_mini_amd_pro:
-		ret = devm_device_add_groups(dev, oxp_ec_groups);
-		if (ret)
-			return ret;
-		break;
-	default:
-		break;
-	}
-
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
@@ -451,6 +460,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 static struct platform_driver oxp_platform_driver = {
 	.driver = {
 		.name = "oxp-platform",
+		.dev_groups = oxp_ec_groups,
 	},
 	.probe = oxp_platform_probe,
 };
-- 
2.41.0

