Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C67D0D55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377002AbjJTKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376989AbjJTKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:36:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62310D67
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:35:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ba081173a3so106895566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697798152; x=1698402952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpUgRpro849XsHd37T9qHH8WNDWZQTZ1RSHBQlvkvCI=;
        b=N47yRFrWN5+sbSx6Hr9l6iE3wCxPV5mgvpa20FVtt9ntTGJaOp1Ti4V0E4sYZdlCdG
         5kIla/MULS9psLExWjbOofBnWKoyO331ZSFWRuW4FR3JbXAUjA6zJzFdCvF7cXSN87dB
         bp+DevuCTL0w5bX6psWQDYrVQlPr9APu9pMFeDRCq/UpKqp3VV0ChbNGrb8wkY3DJs+U
         LaXxwXNFYfXEk7N4GtLvIHSUSAtR1NDWFYX/XJKXPWXU4mGUMSm3TqNrnG1ltHgvEU6q
         mMnCr9Cp51aqmUTnMKJB3g4d3WkrInZNGNVm5UNKjnhRm70hY6e8sfALlBgF/g+5+7DX
         5wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798152; x=1698402952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpUgRpro849XsHd37T9qHH8WNDWZQTZ1RSHBQlvkvCI=;
        b=n0+pnAUYiaTDMruG1UjFVYWUnxjDTBUX1yIdPUqG4mK4R9Ww9z3Dot/XYoZuA8pOK/
         4MS/ZzUyDiaEDdZerfVSPZYhVh3haZ27A8n14O4+p2jwqfqy51l/KBypfXMQ7dNNwyhF
         lTJ/kgOqDU5NM+bUpNnW292RU3CHbt6LGfMtvDbMOrsg+TGYxTbbOt5hVLXMZGYA7JZU
         /57iuOpDWXH8317WaJRrgTEKVTwLrfprv7OKXU/a5FEIEC3NY6mIE0fClovJavIj7XQw
         6LnCwBREATJVB6qDaPt5vO611jDQ+9+j12w5fGdrUjUoye+UzOF/YkqXvILq9IvT2o37
         axUQ==
X-Gm-Message-State: AOJu0Ywvss+WwouhZm68qHoKBvSwaamovXAz2+kMtANTlPpkUe47fuoF
        /VOG/6HljxCp3X65J5Aq0IFsFCuZAtevsyo7gLLXPw==
X-Google-Smtp-Source: AGHT+IEjR1RmItSSh2MYWBSnCmqAh7jKwbfhaugIepR3NcJo0YM/2Q/bQjVp9M8FXr/5BhVe5kcVBw==
X-Received: by 2002:a17:907:9815:b0:9be:7b67:1674 with SMTP id ji21-20020a170907981500b009be7b671674mr1047496ejc.3.1697798151819;
        Fri, 20 Oct 2023 03:35:51 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709063c0700b0099c53c4407dsm1226701ejg.78.2023.10.20.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:35:51 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 20 Oct 2023 12:35:47 +0200
Subject: [PATCH v2 2/2] usb: typec: add support for PTN36502 redriver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-ptn36502-v2-2-b37a337d463e@fairphone.com>
References: <20231020-ptn36502-v2-0-b37a337d463e@fairphone.com>
In-Reply-To: <20231020-ptn36502-v2-0-b37a337d463e@fairphone.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the NXP PTN36502 Type-C USB 3.1 Gen 1 and DisplayPort
v1.2 combo redriver.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/usb/typec/mux/Kconfig    |  10 +
 drivers/usb/typec/mux/Makefile   |   1 +
 drivers/usb/typec/mux/ptn36502.c | 444 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 65da61150ba7..816b9bd08355 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -46,4 +46,14 @@ config TYPEC_MUX_NB7VPQ904M
 	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
 	  redriver chip found on some devices with a Type-C port.
 
+config TYPEC_MUX_PTN36502
+	tristate "NXP PTN36502 Type-C redriver driver"
+	depends on I2C
+	depends on DRM || DRM=n
+	select DRM_PANEL_BRIDGE if DRM
+	select REGMAP_I2C
+	help
+	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
+	  found on some devices with a Type-C port.
+
 endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index 76196096ef41..9d6a5557b0bd 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
 obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
 obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
+obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
new file mode 100644
index 000000000000..72ae38a1b2be
--- /dev/null
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP PTN36502 Type-C driver
+ *
+ * Copyright (C) 2023 Luca Weiss <luca.weiss@fairphone.com>
+ *
+ * Based on NB7VPQ904M driver:
+ * Copyright (C) 2023 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+ */
+
+#include <drm/drm_bridge.h>
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
+
+#define PTN36502_CHIP_ID_REG				0x00
+#define PTN36502_CHIP_ID				0x02
+
+#define PTN36502_CHIP_REVISION_REG			0x01
+#define PTN36502_CHIP_REVISION_BASE_MASK		GENMASK(7, 4)
+#define PTN36502_CHIP_REVISION_METAL_MASK		GENMASK(3, 0)
+
+#define PTN36502_DP_LINK_CTRL_REG			0x06
+#define PTN36502_DP_LINK_CTRL_LANES_MASK		GENMASK(3, 2)
+#define PTN36502_DP_LINK_CTRL_LANES_2			(2)
+#define PTN36502_DP_LINK_CTRL_LANES_4			(3)
+#define PTN36502_DP_LINK_CTRL_LINK_RATE_MASK		GENMASK(1, 0)
+#define PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS		(2)
+
+/* Registers for lane 0 (0x07) to lane 3 (0x0a) have the same layout */
+#define PTN36502_DP_LANE_CTRL_REG(n)			(0x07 + (n))
+#define PTN36502_DP_LANE_CTRL_RX_GAIN_MASK		GENMASK(6, 4)
+#define PTN36502_DP_LANE_CTRL_RX_GAIN_3DB		(2)
+#define PTN36502_DP_LANE_CTRL_TX_SWING_MASK             GENMASK(3, 2)
+#define PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD         (2)
+#define PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_MASK		GENMASK(1, 0)
+#define PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB	(1)
+
+#define PTN36502_MODE_CTRL1_REG				0x0b
+#define PTN36502_MODE_CTRL1_PLUG_ORIENT_MASK		GENMASK(5, 5)
+#define PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE		(1)
+#define PTN36502_MODE_CTRL1_AUX_CROSSBAR_MASK		GENMASK(3, 3)
+#define PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON		(1)
+#define PTN36502_MODE_CTRL1_MODE_MASK			GENMASK(2, 0)
+#define PTN36502_MODE_CTRL1_MODE_OFF			(0)
+#define PTN36502_MODE_CTRL1_MODE_USB_ONLY		(1)
+#define PTN36502_MODE_CTRL1_MODE_USB_DP			(2)
+#define PTN36502_MODE_CTRL1_MODE_DP			(3)
+
+#define PTN36502_DEVICE_CTRL_REG			0x0d
+#define PTN36502_DEVICE_CTRL_AUX_MONITORING_MASK	GENMASK(7, 7)
+#define PTN36502_DEVICE_CTRL_AUX_MONITORING_EN		(1)
+
+struct ptn36502 {
+	struct i2c_client *client;
+	struct regulator *vdd18_supply;
+	struct regmap *regmap;
+	struct typec_switch_dev *sw;
+	struct typec_retimer *retimer;
+
+	struct typec_switch *typec_switch;
+
+	struct drm_bridge bridge;
+
+	struct mutex lock; /* protect non-concurrent retimer & switch */
+
+	enum typec_orientation orientation;
+	unsigned long mode;
+	unsigned int svid;
+};
+
+static int ptn36502_set(struct ptn36502 *ptn)
+{
+	bool reverse = (ptn->orientation == TYPEC_ORIENTATION_REVERSE);
+	unsigned int ctrl1_val = 0;
+	unsigned int lane_ctrl_val = 0;
+	unsigned int link_ctrl_val = 0;
+
+	switch (ptn->mode) {
+	case TYPEC_STATE_SAFE:
+		/* Deep power saving state */
+		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG,
+			     FIELD_PREP(PTN36502_MODE_CTRL1_MODE_MASK,
+					PTN36502_MODE_CTRL1_MODE_OFF));
+		return 0;
+
+	case TYPEC_STATE_USB:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> X
+		 * D -> X
+		 * Flipped Orientation (CC2)
+		 * A -> X
+		 * B -> X
+		 * C -> USB TX
+		 * D -> USB RX
+		 */
+
+		/* USB 3.1 Gen 1 only */
+		ctrl1_val = FIELD_PREP(PTN36502_MODE_CTRL1_MODE_MASK,
+				       PTN36502_MODE_CTRL1_MODE_USB_ONLY);
+		if (reverse)
+			ctrl1_val |= FIELD_PREP(PTN36502_MODE_CTRL1_PLUG_ORIENT_MASK,
+						PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE);
+
+		regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
+		return 0;
+
+	default:
+		if (ptn->svid != USB_TYPEC_DP_SID)
+			return -EINVAL;
+
+		break;
+	}
+
+	/* DP Altmode Setup */
+
+	switch (ptn->mode) {
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> DP3
+		 * B -> DP2
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> DP2
+		 * D -> DP3
+		 */
+
+		/* 4-lane DP */
+		ctrl1_val |= FIELD_PREP(PTN36502_MODE_CTRL1_MODE_MASK,
+					PTN36502_MODE_CTRL1_MODE_DP);
+		link_ctrl_val |= FIELD_PREP(PTN36502_DP_LINK_CTRL_LANES_MASK,
+					    PTN36502_DP_LINK_CTRL_LANES_4);
+		break;
+
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_F: /* State F is deprecated */
+		/*
+		 * Normal Orientation (CC1)
+		 * A -> USB RX
+		 * B -> USB TX
+		 * C -> DP1
+		 * D -> DP0
+		 * Flipped Orientation (CC2)
+		 * A -> DP0
+		 * B -> DP1
+		 * C -> USB TX
+		 * D -> USB RX
+		 */
+
+		/* USB 3.1 Gen 1 and 2-lane DP */
+		ctrl1_val |= FIELD_PREP(PTN36502_MODE_CTRL1_MODE_MASK,
+					PTN36502_MODE_CTRL1_MODE_USB_DP);
+		link_ctrl_val |= FIELD_PREP(PTN36502_DP_LINK_CTRL_LANES_MASK,
+					    PTN36502_DP_LINK_CTRL_LANES_2);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Enable AUX monitoring */
+	regmap_write(ptn->regmap, PTN36502_DEVICE_CTRL_REG,
+		     FIELD_PREP(PTN36502_DEVICE_CTRL_AUX_MONITORING_MASK,
+				PTN36502_DEVICE_CTRL_AUX_MONITORING_EN));
+
+	/* Enable AUX switch path */
+	ctrl1_val |= FIELD_PREP(PTN36502_MODE_CTRL1_AUX_CROSSBAR_MASK,
+				PTN36502_MODE_CTRL1_AUX_CROSSBAR_SW_ON);
+	if (reverse)
+		ctrl1_val |= FIELD_PREP(PTN36502_MODE_CTRL1_PLUG_ORIENT_MASK,
+					PTN36502_MODE_CTRL1_PLUG_ORIENT_REVERSE);
+	regmap_write(ptn->regmap, PTN36502_MODE_CTRL1_REG, ctrl1_val);
+
+	/* DP Link rate: 5.4 Gbps (HBR2) */
+	link_ctrl_val |= FIELD_PREP(PTN36502_DP_LINK_CTRL_LINK_RATE_MASK,
+				    PTN36502_DP_LINK_CTRL_LINK_RATE_5_4GBPS);
+	regmap_write(ptn->regmap, PTN36502_DP_LINK_CTRL_REG, link_ctrl_val);
+
+	/*
+	 * For all lanes:
+	 * - Rx equivalization gain: 3 dB
+	 * - TX output swing control: 800 mVppd
+	 * - Pre-emphasis control: 3.5 dB
+	 */
+	lane_ctrl_val = FIELD_PREP(PTN36502_DP_LANE_CTRL_RX_GAIN_MASK,
+				   PTN36502_DP_LANE_CTRL_RX_GAIN_3DB) |
+			FIELD_PREP(PTN36502_DP_LANE_CTRL_TX_SWING_MASK,
+				   PTN36502_DP_LANE_CTRL_TX_SWING_800MVPPD) |
+			FIELD_PREP(PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_MASK,
+				   PTN36502_DP_LANE_CTRL_PRE_EMPHASIS_3_5DB);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(0), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(1), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(2), lane_ctrl_val);
+	regmap_write(ptn->regmap, PTN36502_DP_LANE_CTRL_REG(3), lane_ctrl_val);
+
+	return 0;
+}
+
+static int ptn36502_sw_set(struct typec_switch_dev *sw, enum typec_orientation orientation)
+{
+	struct ptn36502 *ptn = typec_switch_get_drvdata(sw);
+	int ret;
+
+	ret = typec_switch_set(ptn->typec_switch, orientation);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ptn->lock);
+
+	if (ptn->orientation != orientation) {
+		ptn->orientation = orientation;
+
+		ret = ptn36502_set(ptn);
+	}
+
+	mutex_unlock(&ptn->lock);
+
+	return ret;
+}
+
+static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
+{
+	struct ptn36502 *ptn = typec_retimer_get_drvdata(retimer);
+	int ret = 0;
+
+	mutex_lock(&ptn->lock);
+
+	if (ptn->mode != state->mode) {
+		ptn->mode = state->mode;
+
+		if (state->alt)
+			ptn->svid = state->alt->svid;
+		else
+			ptn->svid = 0; // No SVID
+
+		ret = ptn36502_set(ptn);
+	}
+
+	mutex_unlock(&ptn->lock);
+
+	return ret;
+}
+
+static int ptn36502_detect(struct ptn36502 *ptn)
+{
+	struct device *dev = &ptn->client->dev;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(ptn->regmap, PTN36502_CHIP_ID_REG,
+			  &reg_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
+
+	if (reg_val != PTN36502_CHIP_ID)
+		return dev_err_probe(dev, -ENODEV, "Unexpected chip ID: %x\n", reg_val);
+
+	ret = regmap_read(ptn->regmap, PTN36502_CHIP_REVISION_REG,
+			  &reg_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read chip revision\n");
+
+	dev_dbg(dev, "Chip revision: base layer version %lx, metal layer version %lx\n",
+		FIELD_GET(PTN36502_CHIP_REVISION_BASE_MASK, reg_val),
+		FIELD_GET(PTN36502_CHIP_REVISION_METAL_MASK, reg_val));
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
+static int ptn36502_bridge_attach(struct drm_bridge *bridge,
+				  enum drm_bridge_attach_flags flags)
+{
+	struct ptn36502 *ptn = container_of(bridge, struct ptn36502, bridge);
+	struct drm_bridge *next_bridge;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	next_bridge = devm_drm_of_get_bridge(&ptn->client->dev, ptn->client->dev.of_node, 0, 0);
+	if (IS_ERR(next_bridge)) {
+		dev_err(&ptn->client->dev, "failed to acquire drm_bridge: %pe\n", next_bridge);
+		return PTR_ERR(next_bridge);
+	}
+
+	return drm_bridge_attach(bridge->encoder, next_bridge, bridge,
+				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+
+static const struct drm_bridge_funcs ptn36502_bridge_funcs = {
+	.attach	= ptn36502_bridge_attach,
+};
+
+static int ptn36502_register_bridge(struct ptn36502 *ptn)
+{
+	ptn->bridge.funcs = &ptn36502_bridge_funcs;
+	ptn->bridge.of_node = ptn->client->dev.of_node;
+
+	return devm_drm_bridge_add(&ptn->client->dev, &ptn->bridge);
+}
+#else
+static int ptn36502_register_bridge(struct ptn36502 *ptn)
+{
+	return 0;
+}
+#endif
+
+static const struct regmap_config ptn36502_regmap = {
+	.max_register = 0x0d,
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ptn36502_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_retimer_desc retimer_desc = { };
+	struct ptn36502 *ptn;
+	int ret;
+
+	ptn = devm_kzalloc(dev, sizeof(*ptn), GFP_KERNEL);
+	if (!ptn)
+		return -ENOMEM;
+
+	ptn->client = client;
+
+	ptn->regmap = devm_regmap_init_i2c(client, &ptn36502_regmap);
+	if (IS_ERR(ptn->regmap)) {
+		dev_err(&client->dev, "Failed to allocate register map\n");
+		return PTR_ERR(ptn->regmap);
+	}
+
+	ptn->mode = TYPEC_STATE_SAFE;
+	ptn->orientation = TYPEC_ORIENTATION_NONE;
+
+	mutex_init(&ptn->lock);
+
+	ptn->vdd18_supply = devm_regulator_get_optional(dev, "vdd18");
+	if (IS_ERR(ptn->vdd18_supply))
+		return PTR_ERR(ptn->vdd18_supply);
+
+	ptn->typec_switch = fwnode_typec_switch_get(dev->fwnode);
+	if (IS_ERR(ptn->typec_switch))
+		return dev_err_probe(dev, PTR_ERR(ptn->typec_switch),
+				     "Failed to acquire orientation-switch\n");
+
+	ret = regulator_enable(ptn->vdd18_supply);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+
+	ret = ptn36502_detect(ptn);
+	if (ret)
+		goto err_disable_regulator;
+
+	ret = ptn36502_register_bridge(ptn);
+	if (ret)
+		goto err_disable_regulator;
+
+	sw_desc.drvdata = ptn;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = ptn36502_sw_set;
+
+	ptn->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(ptn->sw)) {
+		ret = dev_err_probe(dev, PTR_ERR(ptn->sw),
+				    "Failed to register typec switch\n");
+		goto err_disable_regulator;
+	}
+
+	retimer_desc.drvdata = ptn;
+	retimer_desc.fwnode = dev->fwnode;
+	retimer_desc.set = ptn36502_retimer_set;
+
+	ptn->retimer = typec_retimer_register(dev, &retimer_desc);
+	if (IS_ERR(ptn->retimer)) {
+		ret = dev_err_probe(dev, PTR_ERR(ptn->retimer),
+				    "Failed to register typec retimer\n");
+		goto err_switch_unregister;
+	}
+
+	return 0;
+
+err_switch_unregister:
+	typec_switch_unregister(ptn->sw);
+
+err_disable_regulator:
+	regulator_disable(ptn->vdd18_supply);
+
+	return ret;
+}
+
+static void ptn36502_remove(struct i2c_client *client)
+{
+	struct ptn36502 *ptn = i2c_get_clientdata(client);
+
+	typec_retimer_unregister(ptn->retimer);
+	typec_switch_unregister(ptn->sw);
+
+	regulator_disable(ptn->vdd18_supply);
+}
+
+static const struct i2c_device_id ptn36502_table[] = {
+	{ "ptn36502" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ptn36502_table);
+
+static const struct of_device_id ptn36502_of_table[] = {
+	{ .compatible = "nxp,ptn36502" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ptn36502_of_table);
+
+static struct i2c_driver ptn36502_driver = {
+	.driver = {
+		.name = "ptn36502",
+		.of_match_table = ptn36502_of_table,
+	},
+	.probe		= ptn36502_probe,
+	.remove		= ptn36502_remove,
+	.id_table	= ptn36502_table,
+};
+module_i2c_driver(ptn36502_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
+MODULE_DESCRIPTION("NXP PTN36502 Type-C driver");
+MODULE_LICENSE("GPL");

-- 
2.42.0

