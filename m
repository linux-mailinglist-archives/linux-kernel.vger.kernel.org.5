Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBF78C716
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjH2OPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjH2OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:14:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D875AAB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:14:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so3447414f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693318466; x=1693923266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFPTtA3XCUKdAaFOU5c7e+UXQ9Y4a2WdpxP2XoiaKc0=;
        b=KS46UfLFspv9moR5Rw3Mu5y8AS/xA6BNLJjOsgC2lVoSYMUny9p8ctXPvM8wSEwtyx
         Rsfh3g4I9P4cKt7gvxzGA3n/Q6V7zxSe9SKF/HBCpYKyZo1aA+zez4lrmWFLuOFoIaAC
         BY6dVNNlYfhNFa9Eh36xz2JzinT2/NpUF9mi5EGqLnSLGgHqQzquY9Djbe3WSFy1rQPg
         QIe5BwRs3lJPHQxDuAATQSrVgrD4nhX15t3nD0y1OS+6pKd12qlUGWRobQe7KdtkZHV2
         tnuDrXnR0bNNPCjgzYjJtGV0SNpju5Rz0H0So7lrUDUB29l838vJ179qf80ge4fKzCUk
         s4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318466; x=1693923266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFPTtA3XCUKdAaFOU5c7e+UXQ9Y4a2WdpxP2XoiaKc0=;
        b=JRk5sRuEzKjToyOA8vYrj7xxP/sb8ru6BtPbyvDK11DXnIZYhqxNCHDt4cGtt5z9JW
         l7ghm64BbkzGuRytmOjIrfzfAWFV7aoL/AYaVK2mafqLjQXW6EJIXlXQpJT82BZQanuR
         50ziWVGRtkztJlfNoM+ZpL45eWwIdKfcfNiDNXxQpKc68W0zNzCsEu8xqW2gRpab6T4V
         jz2uYesW7ULmnHAwIwqdbyGFX/8ZQ21bbBVdz2jS3k9YMkX/hZOeq3q7y4zKp54UYq4e
         6cqMR8Pw00un+FL8ak+fiin+OrNLhZTsI38RaPShuZ3L3s7jCINUZ4+mzDmMcR/iT6Jv
         r9/g==
X-Gm-Message-State: AOJu0YzUf31N8vNjigCswjyD3nczH+7nMWSt4hfRfAjBzZMS55TmtpLS
        zWMhTVhH/bRz6FXNEQeAKN/Jag==
X-Google-Smtp-Source: AGHT+IGwkat/DGsti9wkyTwrViZMau7x0f5QHaDgrMbuMoI+ffv9J1uLFhtLi9UQv9rgOqPYKCi5Kg==
X-Received: by 2002:adf:de09:0:b0:313:e391:e492 with SMTP id b9-20020adfde09000000b00313e391e492mr2074430wrm.17.1693318466180;
        Tue, 29 Aug 2023 07:14:26 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id y14-20020adfee0e000000b0031c56218984sm13824638wrn.104.2023.08.29.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:14:25 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Tue, 29 Aug 2023 16:14:13 +0200
Message-ID: <20230829141413.2605621-1-Naresh.Solanki@9elements.com>
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

