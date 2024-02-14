Return-Path: <linux-kernel+bounces-64623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8238540FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF770B23712
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C4BE4C;
	Wed, 14 Feb 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU0+MDQS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7CBA45;
	Wed, 14 Feb 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872084; cv=none; b=JxJS2D1MQIDKJD2NuMk1JexpibEV41fPyk6KEV4ICxj/mAtXLktLPMj35LbkrJPi8wc9KC5QfT4ldUc9K5h0cTmj9SuDOusyCqzqUioAOmuaVlqufgjNGTt5MK/jlXygjmNAIaJWMXvTpayFA8aCBu7F2iVltjb+Ir8xY2lOauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872084; c=relaxed/simple;
	bh=hOaFIyeFEphFhH4pYBV+V5h0EBz50ziLoFCM4ZqhWfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODZ8C4Nk7uM9QdbCGoMkreXypYUuqstArOGBOK9/qhLS3c1R0IvLkEtXN2lkENQvGOSEKmYJ7+wa5UInoEVEbYVSmJWKai063uxY3Y+uMQVLtLHV6qaMiUtMYk/aXLPr5YCzrWRmO1SglsVamUHen1WQ/IH5L77vYeqVa7Izi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU0+MDQS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0a4823881so2071851b3a.0;
        Tue, 13 Feb 2024 16:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872082; x=1708476882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIKXDBK00dVi+0QWmrTHbh/l72GcdDhpXRjOOpOYJHk=;
        b=nU0+MDQSL6sZDGWEpqpSr7qZtSgd4mFA64DOpfT+IQ8F2wfW5Y1tgY+wPpVqrhT7lM
         T2/TynesMAjeQ2Pd3xXmAqKDBhPl1Wr8dtw74GCWEhHn+FSrk2DRY5pvgponGOIc2OGk
         xEsRciGIsdl7/2EuJa1i/ZNseI8aLzje/ePgzlUvk0ddGZA4G4K4yXiv7gh1iyrM96V0
         yvFp2DF6NpAZbtbcpzLF7nyBC/UjRXBH91gURp09/csQ9owP0m6Kq5UaektOXRTp0KCj
         kujS2raiPNLrRIVg5m/F5KsYipcIR71ykKnW995Qjl9qJy1JL785sk0vjKOA35S0kWJm
         VReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872082; x=1708476882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIKXDBK00dVi+0QWmrTHbh/l72GcdDhpXRjOOpOYJHk=;
        b=v5B8+Toe6gmlqlW2Eq4ULcy2y9jy1F+sWayindzQDNvimiqrMoyEq2WthN/wmmeBBL
         PosQvLxJyLoijOQq2UOuuuxwx1aM5K+zGXbhSr3nAVD0NWJ2wxXeJHS9F8WnsGaps8nW
         bITgk4fmqBkZVrcf9M6hNaAtWFaaEHBpG5nmD2n3d2/Pp4+QC+7eBkBJK0P+uoNbN+L4
         ToWQXsTeK6s/z63X6vLkwVCiEvsEqZ0HEmBcztGXaUZ4EbOu3ignAiFEWNDzSsHsFm5i
         0SxILun3qSpJJiuKKKiwT8LlOTz0KaFFwMOqSlu8chFZw8ONgFq7OhpbeYUFe/FU+va8
         BSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+rTq8gobwAoVwSg2fhiNvcn+2f827Gyi/0/VE/yWKSLq8qgqyz9nqGmitJcBS84RTcQdFO8WGJNqi41fQG1niJS7Rj6i8Pwj7nYu/r6TLzp7VfPGoG2jib4KlvCBMoGs9ZhOIn7+/w==
X-Gm-Message-State: AOJu0YzO0+3qfCHUII6WUtx8nC54/9wP+bi5kQQoUX3o4g7omCgb/DmJ
	OWtVtYCEC8e20FHxVnEf23sOKHYguOQLJ66SEJXVgbZE/uQVCCM7
X-Google-Smtp-Source: AGHT+IE9249CS1p/Wjj2hfUPTG+PlFRkt8Gmr/jd6ZbSfmuQvzCIgCGbxeUshLdCBmL8AXhCq7M5dg==
X-Received: by 2002:a05:6a00:2d81:b0:6dd:e398:2a84 with SMTP id fb1-20020a056a002d8100b006dde3982a84mr1103792pfb.7.1707872081909;
        Tue, 13 Feb 2024 16:54:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVornoi0FNm3lIOcWTmePAO9Su7SuL2vx44bdYyxQnKpQSMuSKtXeF4CQ55Rz//zn+tEVJ3BfpH2PSY6kbaPsW64qJzS4+Dqa11lm+SQJfwmeZv/+tXYgkxnZAjB9g++VIuXrgO8yz7OQVT8cNHZ1rCpeaXXhdt613P9/vBwX6X4Ca8aKFYtSI7Ve0787c90rUptFDU8hH8Ql4NFyrvQB8fdmhtWK7cJMCVsNRCuO7DMgf+XOFLvIh6/Xz74n80g+eBqpff9PkWU7JK5hXoq1PtOxK4ZQQ98vf+5/iWmM6GTxFIWEGgwp01YNgd2JupqbIEU/kYWWdISHEyHdnI7p2RVp2Cca7GkSwdMM2nT6pqy0zHzw6UnLtp7uAeAF7ld732W4daj31E9c+7HtaYG44oDRGzO5IOz7tpUVaKUktdZn2L3wONoAoeI1Iv5xtwrzzTRfkLib+jER5jWPA5O7X+X/aSMzwRiy1SutVirpHi/E3n8OXbv2i8W1CkIFA=
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b006e094bf05f4sm8005694pfl.213.2024.02.13.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:54:41 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 13 Feb 2024 21:54:17 -0300
Subject: [PATCH net-next v3 3/3] net: dsa: realtek: support reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
In-Reply-To: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4326; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=hOaFIyeFEphFhH4pYBV+V5h0EBz50ziLoFCM4ZqhWfU=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlzA89+ufvAP4Ps9YpHGyvpsXt5yLU0XYlvyQLQ
 IXybpnxTPuJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcwPPQAKCRC7Edu60Qc7
 VpL3B/97jc0w6iKhquAMcFrpzlFXBQP455yQ28HMDQygCsm1joeSSt7cyE+lZrBskt4XQTBuXzV
 nfoZFBz38ri/2t6nPDicl9DR4UxgeojekHgNOuN9lCtSA1doBTFKFMAOASN/fZwkPsvbMsGUJGk
 Rz0zTOgGrz8btgWLaqJoANL7hBwSAR1lZb8d0bAL51Ej1JvRGqxnjd8N++MD1mzjTDlYSFPUpYD
 OLXSkiK1iGgyh/pdP210EF+b6qLdTd+U0Rs+0PW5Squs2SCIVZW71SEYriswc5/IUldYTyaqzbA
 3BLb9B9bb8PvViXGmyctnltINiju0GaID5yKsP3xCcznD5HV
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The 'reset-gpios' will not work when the switch reset is controlled by a
reset controller.

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset state was asserted, the driver will
not detect it.

The reset controller will take precedence over the reset GPIO.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h |  2 ++
 drivers/net/dsa/realtek/rtl83xx.c | 52 +++++++++++++++++++++++++++++++++++----
 drivers/net/dsa/realtek/rtl83xx.h |  2 ++
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b80bfde1ad04..e0b1aa01337b 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#include <linux/reset.h>
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -48,6 +49,7 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+	struct reset_control    *reset_ctl;
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 801873754df2..3d1f541936b8 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -184,6 +184,13 @@ rtl83xx_probe(struct device *dev,
 						    "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		dev_err_probe(dev, ret, "failed to get reset control\n");
+		return ERR_CAST(priv->reset_ctl);
+	}
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
@@ -192,11 +199,11 @@ rtl83xx_probe(struct device *dev,
 
 	dev_set_drvdata(dev, priv);
 
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		rtl83xx_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		rtl83xx_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -292,11 +299,46 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
 void rtl83xx_remove(struct realtek_priv *priv)
 {
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
+void rtl83xx_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_assert(priv->reset_ctl);
+		if (!ret)
+			return;
+
+		dev_warn(priv->dev,
+			 "Failed to assert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, true);
+}
+
+void rtl83xx_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_deassert(priv->reset_ctl);
+		if (!ret)
+			return;
+
+		dev_warn(priv->dev,
+			 "Failed to deassert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, false);
+}
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 0ddff33df6b0..c8a0ff8fd75e 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -18,5 +18,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv);
 void rtl83xx_unregister_switch(struct realtek_priv *priv);
 void rtl83xx_shutdown(struct realtek_priv *priv);
 void rtl83xx_remove(struct realtek_priv *priv);
+void rtl83xx_reset_assert(struct realtek_priv *priv);
+void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
 #endif /* _RTL83XX_H */

-- 
2.43.0


