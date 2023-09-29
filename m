Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B887B355F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjI2Oci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjI2OcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA27CE6;
        Fri, 29 Sep 2023 07:32:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso18449270a12.1;
        Fri, 29 Sep 2023 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997932; x=1696602732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHnX5ViB2blcrR3noBsF7rZaPABwO4T0sI7Bvq4+gXM=;
        b=dDjk+43PhwSt4prA8hdqTOd6fExstgLu8BAJZyvfQd+hBcjzz8bnqQDD7ZwlT3mc95
         LoR8//oOR3gePKotMWZ445a/yfFhvYANUb56ZdPd7KTqMSX081aNHjtKNz2S8JiO+nlg
         T7GI4ekY56CyGaJFDF0cfKyQHGXtTzQiEt46IKU8HyBXIBwUcrQ55HbLPlg9dJc2z7NJ
         1rLbsGFg7LCLFKe9bvYoglGUADmsELg34j4X1PAgHQPAlkS5I8s7ibdqOMm9LNFzodKv
         5bpM8hx2ikmALS1uyre9YffjE6ncfE0Tr78gA9auGQ5BALCGe3PJvWpMIUrrg3Nb4AeV
         W8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997932; x=1696602732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHnX5ViB2blcrR3noBsF7rZaPABwO4T0sI7Bvq4+gXM=;
        b=ieDKjowFQ+Ouxv1WwjPIyVd/krQwNIevmNHK8NWVZduFZ8KtV4d3r4wiJ0sSQrIEpf
         zMgYnF85E+CFqq7U9UCttSZ/n4nfXQoiT1XZDdmO1C8N1Q9GGQqgiAkLotHbbYGZha1n
         hmiSNvpHW2ydO0xyBXaVpeW3gAp6jcSTj4cFDiYU1/vpHMuHHJqKZD7MEDC7oVQqVdyq
         PtEwqKMbR6r2YUbKGjjfn9ZTIa5o0/CLiIyjyssiprXn+na2+NQFDnZyhr0RqEfb2FqE
         mz8L+KU3J9wr2tzbBtg1vhUeYDDqvOu4GNQ/+U+wd5l4lyL4p7yldK/Ynfu9+689JYic
         kIew==
X-Gm-Message-State: AOJu0YwyR5PskRa2hsMz/prk1FlLIByn+NglzI/xpHR4tHz9OVa8JdJ0
        EfldjCfDiQ5THW8YcS/TYhU=
X-Google-Smtp-Source: AGHT+IG5xfZ7z6XCE8by9nztP1Sh4Z+bwtg2ZO3/PiPlcDv+a0F2z2L1mqvrfqjhwTA2/tLoH+3q3g==
X-Received: by 2002:a17:906:225c:b0:9a1:cfd5:1f3a with SMTP id 28-20020a170906225c00b009a1cfd51f3amr4539743ejr.13.1695997932433;
        Fri, 29 Sep 2023 07:32:12 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:12 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 09/14] USB: typec: tps6598x: Refactor tps6598x port registration
Date:   Fri, 29 Sep 2023 10:30:50 -0400
Message-Id: <20230929143055.31360-10-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps6598x and cd321x use TPS_REG_SYSTEM_CONF to get dr/pr roles
where other similar devices don't have this register such as tps25750.

Move tps6598x port registration to its own function

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 9dc4c3ae5c60..580680986f66 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1032,6 +1032,58 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int
+tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u32 conf;
+	struct typec_capability typec_cap = { };
+
+	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
+	if (ret)
+		return ret;
+
+	typec_cap.revision = USB_TYPEC_REV_1_2;
+	typec_cap.pd_revision = 0x200;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+
+	switch (TPS_SYSCONF_PORTINFO(conf)) {
+	case TPS_PORTINFO_SINK_ACCESSORY:
+	case TPS_PORTINFO_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_UFP_DRD:
+	case TPS_PORTINFO_DRP_DFP_DRD:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DRD;
+		break;
+	case TPS_PORTINFO_DRP_UFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_DFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	case TPS_PORTINFO_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	tps->port = typec_register_port(tps->dev, &typec_cap);
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
+
+	return 0;
+}
+
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 };
@@ -1055,12 +1107,10 @@ MODULE_DEVICE_TABLE(of, tps6598x_of_match);
 static int tps6598x_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
-	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	const struct of_device_id *match;
 	u32 status;
-	u32 conf;
 	u32 vid;
 	int ret;
 	u64 mask1;
@@ -1135,10 +1185,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_clear_mask;
 	trace_tps6598x_status(status);
 
-	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
-	if (ret < 0)
-		goto err_clear_mask;
-
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
 	 * struct device. Instead we simply parse it to read the properties.
@@ -1156,50 +1202,13 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_fwnode_put;
 	}
 
-	typec_cap.revision = USB_TYPEC_REV_1_2;
-	typec_cap.pd_revision = 0x200;
-	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
-	typec_cap.driver_data = tps;
-	typec_cap.ops = &tps6598x_ops;
-	typec_cap.fwnode = fwnode;
-
-	switch (TPS_SYSCONF_PORTINFO(conf)) {
-	case TPS_PORTINFO_SINK_ACCESSORY:
-	case TPS_PORTINFO_SINK:
-		typec_cap.type = TYPEC_PORT_SNK;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_UFP_DRD:
-	case TPS_PORTINFO_DRP_DFP_DRD:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DRD;
-		break;
-	case TPS_PORTINFO_DRP_UFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_DFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	case TPS_PORTINFO_SOURCE:
-		typec_cap.type = TYPEC_PORT_SRC;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	default:
-		ret = -ENODEV;
-		goto err_role_put;
-	}
-
 	ret = devm_tps6598_psy_register(tps);
 	if (ret)
 		goto err_role_put;
 
-	tps->port = typec_register_port(&client->dev, &typec_cap);
-	if (IS_ERR(tps->port)) {
-		ret = PTR_ERR(tps->port);
+	ret = tps6598x_register_port(tps, fwnode);
+	if (ret)
 		goto err_role_put;
-	}
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-- 
2.34.1

