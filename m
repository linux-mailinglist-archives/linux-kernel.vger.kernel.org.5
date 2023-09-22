Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498DE7AAD57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjIVJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjIVJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:03:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6EFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:03:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32001d16a14so1785727f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1695373417; x=1695978217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwCuwBRzQRtzIIEcUqVCtqKyAERbE1Vs3ON90clTwDo=;
        b=RHLtSQ/dcfFp/hTxnjPBGQj74xTbBt7b4lGy81ESxwdy37hrR09Em98GhyGJDhTwiQ
         WtvfCQx3Vmq48trhhrz4YQ7E1RnTu8fm07ef1/DpD6INrVqVZi2ZxFIVCrtild+EHdPW
         VUfdG+i//mewoeGxwN0qahTbL91gArR+GTpTp8zD+L/5J0uurY23MnaR7c638eEEEN9a
         r7F0V/MNqgdRjh+px7thyS/pOaH0KsNu/No9deG04BGQveDUufQjk4Zg/OZqQqrDMad/
         57qfoo/jSqdqgy7kLB9Fd7nSFQb3kMRNzRRDfiK9Q5m45VReUYgxTSlhFO6wOE9DrPu0
         1b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695373417; x=1695978217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwCuwBRzQRtzIIEcUqVCtqKyAERbE1Vs3ON90clTwDo=;
        b=Qvipt/vZawiFL0om7ijuvZbQ6zDu3aw5QUk4VI+xPEufLQAHiTSM+0I/7p6uwMW7MG
         koXCuoHBKhkDdkmHjJmxVBFMa677KjW4Phq8gGDFh/vW4GBofGUl9Oc335ODy6rthTz0
         vCNvS6ZvjrJoxWRNmHg3uVS6dfSshZOQnahJf3eklKcP3Z0QiwzDmDUdCrCSzFZOOtai
         xymTj8qZK3E4GiaDphU+DT0tF7K6ljF1VMj1q6tifHRVgsg5FLkBWxdQa1RNLFZK/f5W
         i4MDlt+ViZhuRL97p88Gv7Nz51Pv9pXpyjuTK3APDxPEoyLWlObK7tlLO+YmKH3p3Sp1
         QQ0Q==
X-Gm-Message-State: AOJu0YyVr3EW1XzatWNQvVQ/E1oyvfciv3RArQd6eOU7pD5csPrFE9dd
        4gFA1bynl0WW4IVV1VDFgI3injpArgmWEK07Yc23lA==
X-Google-Smtp-Source: AGHT+IFeB10/VQrvywgM5PXIIic/lGYOF01ufz889h5rxkcb+djbm+QO4vNfMX9sYbEOBbVgKOQ24g==
X-Received: by 2002:adf:e7c9:0:b0:317:3f70:9dc4 with SMTP id e9-20020adfe7c9000000b003173f709dc4mr6353076wrn.31.1695373417393;
        Fri, 22 Sep 2023 02:03:37 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm3917553wru.105.2023.09.22.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:03:36 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Fri, 22 Sep 2023 11:03:29 +0200
Message-ID: <20230922090330.1570350-1-naresh.solanki@9elements.com>
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

