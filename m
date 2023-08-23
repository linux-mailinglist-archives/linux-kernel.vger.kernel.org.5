Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894247861A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbjHWUgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjHWUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:36:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2610D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:36:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40097f233fdso1398495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692822970; x=1693427770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFPTtA3XCUKdAaFOU5c7e+UXQ9Y4a2WdpxP2XoiaKc0=;
        b=bU9tL0EaQ/uxwGvqdhHbgBUez1nGuGY27VSkcB9WFEg+Qy3bz4JxOgfngz1bdI2GmZ
         aRycttmo17PgdMl5kbej/4JsNj7i4yFG7oGZJHKCxqF4amRga2prjwTwws5fr4AuK9gp
         IsDq49yPIgHs4NkfbG0PJbFFzrMV2daaCgESdTIRCdV1iElT07HyRf1zqEpnmC7M3PYf
         JLDa3locqR9j5ah2ahYD70wjPbJACtbi+lDTp/p0jDsT7zvJoOR6CeayZwiwa24nnhjZ
         9jwghdVPhop7bDPaPlG0AlFIC0DNAAZ26Hr0zZFiLeiqlvHtLZk5tV620+ZTJbNdxAay
         cD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692822970; x=1693427770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFPTtA3XCUKdAaFOU5c7e+UXQ9Y4a2WdpxP2XoiaKc0=;
        b=PxIBWYJ0JLgVhLrRLNoWe+Uxlu4IXtJydxYSi33SDq7qK0t3/Oihc0Hfz+XC4jAeY/
         kpBsCsIgi3DdX2KN2Ag7/7GccLgEaxsGCJ2fwoArmaqOz4eInRpkew6gAoodltv2y4T2
         /oXHSfmWADOysbZteaTW+KexxlTqWfqCLDuHnV0k3WJzNOuxYPxxBxUNu1LPNIJKF/zI
         Es8T2tqWK0w8eGawgGJm+Ubn2WwomaUDhIXYB9VYb4xvjFdT51/emfsU/PQu0etIO5s0
         vLZV0qd1XHyaFacEGAG12W6HNlo607Ssz5dlV2aF2OCtoyaN5UFgC6ZtFPlTjxeftOVu
         raPA==
X-Gm-Message-State: AOJu0Yztj5wTheDxrLBmUtWrt0eugumTKj8eIBNu8MEBRxeaOMUM5kjE
        hY5wCgULnZzgK4dRNNiaB7S13w==
X-Google-Smtp-Source: AGHT+IFW8OXHvoeS5ezLXWRn98TYU67oOYjULgwz6sr61umeBcxLcSyxhHFdrB9TCvb0E1RgNl6s7Q==
X-Received: by 2002:a05:600c:3d1a:b0:3fe:d67d:5040 with SMTP id bh26-20020a05600c3d1a00b003fed67d5040mr11487495wmb.5.1692822970088;
        Wed, 23 Aug 2023 13:36:10 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c235300b003fe4548188bsm554040wmq.48.2023.08.23.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:36:09 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Wed, 23 Aug 2023 22:35:30 +0200
Message-ID: <20230823203531.1382044-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding a single supply, retrieve supplies from DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 43 ++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index a0b980022993..830681446807 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -153,11 +153,32 @@ static int regulator_userspace_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
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
+		if (len > SUPPLY_SUFFIX_LEN && \
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
 	int i, ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -169,11 +190,27 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		memset(pdata, 0, sizeof(*pdata));
 
 		pdata->no_autoswitch = true;
-		pdata->num_supplies = 1;
-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
+		pdata->num_supplies = get_num_supplies(pdev);
+
+		pdata->supplies = devm_kzalloc(&pdev->dev, pdata->num_supplies * \
+					       sizeof(*pdata->supplies), GFP_KERNEL);
 		if (!pdata->supplies)
 			return -ENOMEM;
-		pdata->supplies[0].supply = "vout";
+
+		for_each_property_of_node(pdev->dev.of_node, prop) {
+			const char *prop_name = prop->name;
+			int len = strlen(prop_name);
+
+			if (len > 7 && \
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

base-commit: 8950c4a350c188deb5f5b05df3244d4db82fe3d8
-- 
2.41.0

