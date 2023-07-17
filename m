Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490BB756FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGQWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGQWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:25:42 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA45A4;
        Mon, 17 Jul 2023 15:25:41 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b0156a1c4bso2926574fac.1;
        Mon, 17 Jul 2023 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632740; x=1692224740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1qZZ12UUcyh7MC4/8VfW/JbiMsQYzwZiADUBxxW3ZU=;
        b=WE/g78ykwS8n1IYgJUG/HeBuqdwWrCAUaobsGZPbooyhjGSoo5kAJU/i9M9QQh3whh
         Tc+x6c9HzzZMapPHepnbiA8ByJ0V6PuNyRHA5B0Dqome6VqyT7INBJWLzu2UEgJUdEZc
         h0n/EjWAst8hAobLv2fFyxnUlpAobwihzYLEfvtmRmz4Tpl2sb70VJIrW0FoYWGF388n
         T0oakLW4rV5RB9+YVg8rc2V1Ifou3LS1qxCTBS/YiDXAOZJeCMaIEeuvofw+H8hqqFGE
         djpeCQJqD0/KGxZb8WMKupDfQp7u/h9DZqsbN+xu413Zfr2D8hRsLmLgamPcOkqmk8+y
         RqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632740; x=1692224740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1qZZ12UUcyh7MC4/8VfW/JbiMsQYzwZiADUBxxW3ZU=;
        b=ITy7WDge/2lhv+b9gTy1ycpGq/nzZS2DcfJSj4JEmNdsZj6pAMB0rSemKgt1p0An8c
         ngk63wgaxtfWJJqEQHtwXDxg0lo+aQlZicZQN0UH/riil6Kp0mezSvPgwQAsyI1uK73V
         Iv73elkUk1Mhh4Y+XSd++Ycj7SO3z6yumU0wTMio3Gkbm7Z7pUDZBDwTfnjCDhlq6YMR
         R4hZl5wxigAwJ/tCP67kOPGxhr1bjE0nfUUaYdMs4dnMcP/+SWfWoV5EmO4RI44oehCT
         /udecN0zj3YjvCsfoXfq5Z8ZWuU9vY9Cf3kN88v/IkakmXrAKKi9U1jq715gq+6A3BY0
         5vGA==
X-Gm-Message-State: ABy/qLYT7ndYpECI+m1y76gNJmmL4X9WMhfcKR7MfB9SmRHpK1TZ8KQW
        XJmzs5zPFhb18/f0HjkDSL0=
X-Google-Smtp-Source: APBJJlGFbq3U0SsJCN0WYgOqcRXKEo1ZFeXpFc2isxdgsrIT8Z1uxPG0rgbeFxh4XCqckhRhq1wBzg==
X-Received: by 2002:a05:6870:1496:b0:1ba:1998:c11b with SMTP id k22-20020a056870149600b001ba1998c11bmr11752603oab.55.1689632740467;
        Mon, 17 Jul 2023 15:25:40 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870374700b001ba72480f2fsm385553oak.43.2023.07.17.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:25:40 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 1/2] hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups
Date:   Mon, 17 Jul 2023 19:25:15 -0300
Message-ID: <20230717222526.229984-2-samsagax@gmail.com>
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

A driver should not be manually adding groups in its probe function (it will
race with userspace), so replace the call to devm_device_add_groups() to use
the platform dev_groups callback instead.

This will allow for removal of the devm_device_add_groups() function.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
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

