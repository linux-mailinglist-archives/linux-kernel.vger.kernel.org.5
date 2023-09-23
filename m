Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7D7ABE89
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjIWHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjIWHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0207CC3;
        Sat, 23 Sep 2023 00:40:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so3191814f8f.0;
        Sat, 23 Sep 2023 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454852; x=1696059652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZxo1B/VHfhPPPS7W1orDfRrMmOmst2RNRIjfpEvVPA=;
        b=eoIYFcn+Me5PoGK3SgmaKD3cvcS1vGLp1CN2aChxezzh+bnrvVyUqPwBQGjGTyEvkN
         g2pjZvnpI6GAZfDQK6Rr1CFzOqCL9ZjtUsq2iJmRPwaZZi3oyzNFq13eEVC4lE20qqVl
         Tp3G1ASbLxVNQXdHNQhx6vAjsmA3nakR7BbtLTxjfquAk8ZcAr9W0PwTF3dAbZpO90vL
         s1pFwalbyaOdWc1AMfpa4NWC2SpNta725AptvhYNOi8dbqdV1G6nHnVoWxp0ByXy6D4v
         ZDF1j5Z3YyLGle1lk0hdAG37kYFzDaPDmyzF6QVkwp9YbgehyBskc9Fdn4A1plU5S4m3
         Go4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454852; x=1696059652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZxo1B/VHfhPPPS7W1orDfRrMmOmst2RNRIjfpEvVPA=;
        b=aTVyRbqw5vfTMBJARVemV4MpL9ObcYbjonJMsiV9QTM37qpQI6laj5HAC7YQtOYKIG
         /qjGqRpaPwteQt0S8CoJat3L7o3IM+cCNdZQIlUokmU1Y5K8gH4LShVGlaWUp7W2rGIv
         hNSZPznhmdwnEfezAHW1X7xUmBPDUmNwhOv4R01q8oz0Rds3A4DiWBB2Txq1m4pAq09+
         L5pJU4qmy0o2+gqZOk9FsIa/6AnD3QlQf15qjYcSXM3tTBy3udCyuc6T4yeElXaNo5pN
         rM993aqX/eWKtD6p+txizfB63deEmeIAOjQJnc365sU4+1P+dd8j67LFnZQWL+d6/+ji
         gt0A==
X-Gm-Message-State: AOJu0YxP7wK+L/oNwr6YXIBwo+3hiWnfBJAXTGQ34pkbKx66Epe+DXPY
        k9FiEE6Du2LilrtfNjX1emo=
X-Google-Smtp-Source: AGHT+IEioOh9c2dNWHVfB9J/mFt72tg5I583iGBfuj1LI3yeHE5gRoQEqHCZxl9C1VzCVWd5Fc2xAQ==
X-Received: by 2002:a5d:4e83:0:b0:319:785a:fce5 with SMTP id e3-20020a5d4e83000000b00319785afce5mr1454983wru.38.1695454851878;
        Sat, 23 Sep 2023 00:40:51 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:51 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 10/14] USB: typec: Add port registration for tps25750
Date:   Sat, 23 Sep 2023 03:39:55 -0400
Message-Id: <20230923073959.86660-11-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes in v6:
  - Add port registration to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 66 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 10 +++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ee53011ec5e2..cfaad9a917a2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -39,6 +39,7 @@
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
+#define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
 
@@ -107,6 +108,7 @@ struct tipd_data {
 	irq_handler_t irq_handler;
 	int (*read_events)(struct tps6598x *tps, void *events);
 	int (*clear_events)(struct tps6598x *tps, void *events);
+	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 };
 
 struct tps6598x {
@@ -211,6 +213,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
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
@@ -1051,20 +1058,77 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
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
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.read_events = tps6598x_read_events,
 	.clear_events = tps6598x_clear_events,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps6598x_interrupt,
 	.read_events = tps25750_read_events,
 	.clear_events = tps25750_clear_events,
+	.register_port = tps25750_register_port,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
@@ -1167,7 +1231,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_role_put;
 
-	ret = tps6598x_register_port(tps, fwnode);
+	ret = tps->cb.register_port(tps, fwnode);
 	if (ret)
 		goto err_role_put;
 
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

