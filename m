Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD647B4615
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjJAIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjJAIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED293CF0;
        Sun,  1 Oct 2023 01:15:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so2122184866b.2;
        Sun, 01 Oct 2023 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148136; x=1696752936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGYlNfvaZDrRZ6mlHOh7dP8thvXpReQRJZihrjwW+H0=;
        b=L9eX9k49u5WI3argnmUTwCC6SeVfGsvRwo3faI2B1J15QSRG9qz5sn+3TbbyOYDea4
         IKR/M8UEQsalL25uYuM9VSXHLK56NF5Hf2HQ/VyrEzFBTAs/rQeH4PoJreFSj9sAQLcK
         weO0Yb/t9LPnKNLtyGmvQXCClJEmA5w8+E348g3whmKwPpPwAVYOsARSwn4NFMywCgLe
         jp5DWQNwb6bH6r4wCi0cP6Zyps8UOAtIV16vA8GLgeRXoHk1OW1Oc06AFHZTsLejCaOS
         xfOxPneru87pGKPjJ/roOHvW+k1yp3lQtz7HcqQNibGnwc7SjbP0+i3+GxmJAGHDLppI
         rjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148136; x=1696752936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGYlNfvaZDrRZ6mlHOh7dP8thvXpReQRJZihrjwW+H0=;
        b=GK7yE9rzUzF0m031Xgh75maM1cu/SfleonMY6+RTTvXE6eiJCfctz+9AO+JeV5vt3z
         jxVgeRNmo3tHLud8rg6hrYQ5GqDr75j/hFj6eWWp2Vmavqyvp7fVgs9d+Z0VjojZfSdG
         couNVThpfL1xBR11R5Nkv7/n146wdNsRzKpsjkEgc1QYt4yxTj2ZF4QLpEp8SWHSUfz2
         BAQZ0JCf5eln6idEBl3U+GiXHbbH3TXtszMtdo+gVrllThtaRM1PDHRkf4XNZXLtRBVI
         5XS43DViTIK8n5XYMjwbDVCS4TG8Ug7a8xrQ3XUWGSKsCzY1IZw/LYDoRr+ZgkfyOsv1
         IEnw==
X-Gm-Message-State: AOJu0YwMYMcRMCRSSTGkaS1MNHX/WcSCiXwUPvP5xbX5jZhJuGIPkJ8F
        /FyNP6xpnLguVrG28sK4JF8=
X-Google-Smtp-Source: AGHT+IFB7vD1v9pS13p4d0xoEijQn1bwS6WaUsAvLFSGUWMgByWmAoJoEZ/UQ6JMht81G82egGq4rw==
X-Received: by 2002:a17:906:9a:b0:9b2:be12:d9bd with SMTP id 26-20020a170906009a00b009b2be12d9bdmr7272292ejc.77.1696148135599;
        Sun, 01 Oct 2023 01:15:35 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:35 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 10/14] USB: typec: tps6598x: Add port registration for tps25750
Date:   Sun,  1 Oct 2023 04:11:30 -0400
Message-Id: <20231001081134.37101-11-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 doesn't have system configuration register to get dr/pr of the
current applied binary configuration.

Get data role from the device node and power role from PD status register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v9:
  - Move device data structs to the top of of_device_id
Changes in v8:
  - Change tps->cb to tps->data
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Add port registration to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 68 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 10 +++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0195eabd96bf..ae08c5306707 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -40,6 +40,7 @@
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
+#define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
 
@@ -102,8 +103,11 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tps6598x;
+
 struct tipd_data {
 	irq_handler_t irq_handler;
+	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 };
 
 struct tps6598x {
@@ -208,6 +212,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
+static inline int tps6598x_write8(struct tps6598x *tps, u8 reg, u8 val)
+{
+	return tps6598x_block_write(tps, reg, &val, sizeof(u8));
+}
+
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
 	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
@@ -1084,6 +1093,60 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
 }
 
+static int
+tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	struct typec_capability typec_cap = { };
+	const char *data_role;
+	u8 pd_status;
+	int ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
+	if (ret) {
+		dev_err(tps->dev, "data-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_data_role(data_role);
+	if (ret < 0) {
+		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
+		return ret;
+	}
+
+	typec_cap.data = ret;
+	typec_cap.revision = USB_TYPEC_REV_1_3;
+	typec_cap.pd_revision = 0x300;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
+	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
+		typec_cap.type = TYPEC_PORT_DRP;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
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
 static int tps6598x_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
@@ -1183,7 +1246,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_role_put;
 
-	ret = tps6598x_register_port(tps, fwnode);
+	ret = tps->data->register_port(tps, fwnode);
 	if (ret)
 		goto err_role_put;
 
@@ -1308,14 +1371,17 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
+	.register_port = tps25750_register_port,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index c000170f4547..3a9a43394134 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -203,4 +203,14 @@
 #define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
 #define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
 
+/* PD STATUS REG */
+#define TPS_REG_PD_STATUS_PORT_TYPE_MASK	GENMASK(5, 4)
+#define TPS_PD_STATUS_PORT_TYPE(x) \
+	TPS_FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, x)
+
+#define TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE	0
+#define TPS_PD_STATUS_PORT_TYPE_SINK		1
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

