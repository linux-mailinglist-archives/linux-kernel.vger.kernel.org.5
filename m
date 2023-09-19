Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E907A59D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjISGSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:18:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280C100
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:18:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso85956891fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1695104284; x=1695709084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwCuwBRzQRtzIIEcUqVCtqKyAERbE1Vs3ON90clTwDo=;
        b=Au7WZgORoyt06tGYafXGAdU1O9nwX7MTNzY2bicOAzxqRZTC+MkJ+oifL5QU0+1g7z
         +AKkC2Q1uVk2zIenDCyaQnex3lASJrgfSSVoXb9bXm7yG196QoJBBrEAjJFW75YVnvNg
         oUBsKMhNZim4xWTjegNC63RFLhFRllAbICHvjjsJgaiSnIGQC49VdnP4xSNwhr4hSfDC
         kP/YH2l4+9KwNhiDj11DF04BOTD7ccADg9jfrsqg0OOwpjCDIm6bn+xLU5F5A1LGvCS1
         KICqGnSFe+JnZ3YJ1wqAqOr9I9AdnqPrDXZFnKEKbgldax/ngrQIHEpFn1rySh9W9NQc
         m3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695104284; x=1695709084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwCuwBRzQRtzIIEcUqVCtqKyAERbE1Vs3ON90clTwDo=;
        b=HLPJlGkJPj7OGKwyesNX4+E7jhWrPECuTbFDTt5Vlc9yBLFaWahbv2rMC/ob78qjd3
         +lyiOyjkPoR7VKn53RuxTL8ZMYgc4Zl7Y7vaNgy18+Trvwx7SvsYazMUxh/GmcOB3awa
         dqAYhRJ4Be7UuhjZReKno5oqOC3bBJcFgL3zMLHy4om01YS5RMQa0yomeZHUkCd7Go7Q
         cSFvX+sIKLdQr1moqShkfM/MSAxo6/Wcz/rzAJAiceBwUDlz6rBIxme6fNuYlhWiw9iQ
         65RCs9A2qBWaUy3gOP7lVVQ+RvalUN+SFY68BaS0WEKKdRfN/NifbtBPQSwlYcDtqUg0
         xzlA==
X-Gm-Message-State: AOJu0YztnZYnE9K0BqKw9Nd8NfqPVy6hDnOW14kAQPeIcjaReEv6eeva
        5N3JmQKz1TbXdw3fuI3onqQUZw==
X-Google-Smtp-Source: AGHT+IGPFh5FcduRJGI4YKpEDgCZvjBZH1t+KucIuHfiJ7cL3fNcheTIF/XJCNAYPiYdu22aOh5vUw==
X-Received: by 2002:a2e:bc29:0:b0:2c0:14e2:1f5c with SMTP id b41-20020a2ebc29000000b002c014e21f5cmr4532343ljf.5.1695104283788;
        Mon, 18 Sep 2023 23:18:03 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b009ad778a68c5sm7368534eje.60.2023.09.18.23.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:18:03 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Tue, 19 Sep 2023 08:17:55 +0200
Message-ID: <20230919061755.3412016-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naresh Solanki <Naresh.Solanki@9elements.com>

Instead of hardcoding a single supply, retrieve supplies from DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 43 ++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..a3d3e1e6ca74 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -115,11 +115,32 @@ static const struct attribute_group attr_group = {
 	.is_visible =  attr_visible,
 };
 
+#define SUPPLY_SUFFIX "-supply"
+#define SUPPLY_SUFFIX_LEN 7
+
+static int get_num_supplies(struct platform_device *pdev)
+{
+	struct  property *prop;
+	int num_supplies = 0;
+
+	for_each_property_of_node(pdev->dev.of_node, prop) {
+		const char *prop_name = prop->name;
+		int len = strlen(prop_name);
+
+		if (len > SUPPLY_SUFFIX_LEN &&
+		    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
+			num_supplies++;
+		}
+	}
+	return num_supplies;
+}
+
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
+	struct  property *prop;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -131,11 +152,27 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		memset(pdata, 0, sizeof(*pdata));
 
 		pdata->no_autoswitch = true;
-		pdata->num_supplies = 1;
-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
+		pdata->num_supplies = get_num_supplies(pdev);
+
+		pdata->supplies = devm_kzalloc(&pdev->dev, pdata->num_supplies *
+					       sizeof(*pdata->supplies), GFP_KERNEL);
 		if (!pdata->supplies)
 			return -ENOMEM;
-		pdata->supplies[0].supply = "vout";
+
+		for_each_property_of_node(pdev->dev.of_node, prop) {
+			const char *prop_name = prop->name;
+			int len = strlen(prop_name);
+
+			if (len > SUPPLY_SUFFIX_LEN &&
+			    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
+				char *supply_name = devm_kzalloc(&pdev->dev,
+								 len - SUPPLY_SUFFIX_LEN + 1,
+								 GFP_KERNEL);
+				strscpy(supply_name, prop_name, len - SUPPLY_SUFFIX_LEN);
+				supply_name[len - SUPPLY_SUFFIX_LEN] = '\0';
+				pdata->supplies[0].supply = supply_name;
+			}
+		}
 	}
 
 	if (pdata->num_supplies < 1) {

base-commit: 451e85e29c9d6f20639d4cfcff4b9dea280178cc
-- 
2.41.0

