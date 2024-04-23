Return-Path: <linux-kernel+bounces-155721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E18AF629
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96741C247B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233D144D3B;
	Tue, 23 Apr 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgZ9lMjf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8035143C6F;
	Tue, 23 Apr 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895174; cv=none; b=ByMMk24WWYYEwKNmung7bcK7xDvN8wLpSz7Yyn7grAJTLp26efFSCT7tJYmsqMTfNk5PHYHpk3rmzeZ1gXd+hRJClzOtLtAj+e4XRFV5I/NL0VQqK4xRIiz+Rg0aQx07UpwvT2m/ucq8pXylE/fr+XsXV+lWbQdiD2KsifkexJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895174; c=relaxed/simple;
	bh=JM2mRqpDBRblBzr7A+RrHdUgIcSBQBDa9NjVpzLYq64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7AJJwJkdB3bbJmU2aTthkju84nbNHEnL1A7cfx8WTn6qa/MW+IEU7PaDx+r8rH6JSLMR9/ER8mSslaBXIy6Gr7UIF/mOxRNhVvmPqDZTqmjteXv21QSCbjyAlIksW5MGg40dR+daPneEh9XDHyRUQiHle+jQUT1ysv+U4vOtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgZ9lMjf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso32645025e9.2;
        Tue, 23 Apr 2024 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895170; x=1714499970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UlZJOdbrr4w7IN8RhsDHqQQd56vqfihEwOWI2Dp2Zg=;
        b=DgZ9lMjfSgMq08CqbK6z4N+eRAT7Cdss1UzhPQ+SXYD4y3A9etlXyMmwFC3DJJGMZn
         qbidI2CTAbEfS1pxifvCB+EQZ04ol//qfQxPEqjgU80hHlMOvpvGoKsGscg7uF+u7jTJ
         dxP2Uf/AKOaXAs99gEYUZlgxCESe0+Xgoie7PYxu3ssUPeEsdcSkoJ9oewWMsL3rK67Q
         I6mJ9eiKq9sOPjb3ExtCn/HketEtxfGIvB0n2mYTGDtMfU8+q+5rWAcba/EYPL6fpFeP
         lW7GabyYLgXssKrKF0rpN/IsVzDOeUdxB6+lg+yXeBBe2HSyfZKCUbdfx0/hDuoU7jLo
         yNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895170; x=1714499970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UlZJOdbrr4w7IN8RhsDHqQQd56vqfihEwOWI2Dp2Zg=;
        b=qjCJZ9KMJwYj3Xrn9NN0D3WkGD5y13qQk23D/bZL5fN90I5NDBCvaLFEpHhBAxMqxh
         Y+sKy1RuF9tRboN0rt/4DOO0+ZE5lOhjz5Ku5hp9xEX0vg+BVoWQm5s3baatTH9hdDW1
         biB29fUvBWW4UsVQyBIV17WCUzu/cPnMadpauQ8IuB2VYC+NXI1m9mkbIRlZ8fj63i06
         hnmjkc9OIhuZgtIE5HVodJK+NuPOXDGGsh31PbvUxWWbFH2AAmequXr8ZilDL+3Z7mkE
         TBoR3PGu8lrA+R8aQtO1eRzbHVAft81RZNgP0g8FvL0xgzUWAF6X5vIZTzbczBvEcLA8
         ARfg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCoKVJ3B3Ty3/LoUwmEr45Hnd6ZeKYHdMzoBgaPcJhbtx6jKut9H4aFiM67HXIgwTkMRd4jAc0LBwsGtj3pC28CP+ToPAT1th2ikgi+OcGFD77D1jafeFoY7G18e/0J+HaGXAlE1sU8hYnqfoTcC0Jmq63IKgJDkfvYdEYNM/Snl/14CUth6WoJ67
X-Gm-Message-State: AOJu0YyXV2sjlAGCVB5CA5KznELbUs3HesqTjeeW74na/JbBUVZEutcD
	x53ieW6JhrysXMUWRO6Gv/m8PcI0YMCLz9H2r0jsdSc78vRYH2Mk
X-Google-Smtp-Source: AGHT+IHgont4897T904JKXHafu3TUc10hFLHse2iO2Aq9GMGS+gTZEt1PTJxMKsD51hgvdGxQ2UGXg==
X-Received: by 2002:a05:600c:1f0b:b0:41a:c33d:772f with SMTP id bd11-20020a05600c1f0b00b0041ac33d772fmr16040wmb.8.1713895170217;
        Tue, 23 Apr 2024 10:59:30 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 13/13] pinctrl: renesas: pinctrl-rzg2l: Add support for RZ/V2H SoC
Date: Tue, 23 Apr 2024 18:59:00 +0100
Message-Id: <20240423175900.702640-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add pinctrl driver support for RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- Renamed renesas-rzv2h,output-impedance -> renesas,output-impedance
- Dropped IOLH groups
- Fixed dedicated pin configs
- Updated r9a09g057_variable_pin_cfg
- Added support OEN
- Added support for bias settings
- Added function pointers for pwpr (un)lock
- Added support for slew-rate
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 419 +++++++++++++++++++++++-
 1 file changed, 415 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 7e3ed18e0745..ee0dcdd7921a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -59,6 +59,10 @@
 #define PIN_CFG_OEN			BIT(15)
 #define PIN_CFG_VARIABLE		BIT(16)
 #define PIN_CFG_NOGPIO_INT		BIT(17)
+#define PIN_CFG_OPEN_DRAIN		BIT(18)
+#define PIN_CFG_SCHMIT_CTRL		BIT(19)
+#define PIN_CFG_ELC			BIT(20)
+#define PIN_CFG_IOLH_RZV2H		BIT(21)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -73,6 +77,10 @@
 #define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
 					 PIN_CFG_SOFT_PS)
 
+#define RZV2H_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(RZV2H) | \
+					 PIN_CFG_OPEN_DRAIN | \
+					 PIN_CFG_SR)
+
 #define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
@@ -128,13 +136,15 @@
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
 #define ETH_MODE		(0x3018)
+#define PFC_OEN			(0x3C40) /* known on RZ/V2H(P) only */
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
 
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
-#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
+#define PWPR_PFCWE		BIT(6)	/* PFC (and PMC on RZ/V2H) Register Write Enable */
+#define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable, known only in RZ/V2H(P) */
 
 #define PM_MASK			0x03
 #define PFC_MASK		0x07
@@ -153,6 +163,19 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/* Custom pinconf parameters */
+#define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
+
+static const struct pinconf_generic_params renesas_rzv2h_custom_bindings[] = {
+	{ "renesas,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, 1 },
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item renesas_rzv2h_conf_items[] = {
+	PCONFDUMP(RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, "output-impedance", "x", true),
+};
+#endif
+
 /* Read/write 8 bits register */
 #define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)	\
 	do {						\
@@ -330,6 +353,8 @@ struct rzg2l_pinctrl {
 	spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 
+	raw_spinlock_t			pwpr_lock; /* serialize PWPR register access */
+
 	struct rzg2l_pinctrl_pin_settings *settings;
 	struct rzg2l_pinctrl_reg_cache	*cache;
 	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
@@ -354,6 +379,39 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+static const struct rzg2l_variable_pin_cfg r9a09g057_variable_pin_cfg[] = {
+	{
+		.port = 11,
+		.pin = 0,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 11,
+		.pin = 1,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 2,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 3,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 4,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 5,
+		.cfg = RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+};
+
 #ifdef CONFIG_RISCV
 static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 	{
@@ -480,6 +538,19 @@ static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *
 	writeb(val, addr);
 }
 
+static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	raw_spin_lock(&pctrl->pwpr_lock);
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_PFCWE, pctrl->base + regs->pwpr);
+	writeb(val, addr);
+	writeb(pwpr & ~PWPR_PFCWE, pctrl->base + regs->pwpr);
+	raw_spin_unlock(&pctrl->pwpr_lock);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1120,14 +1191,107 @@ static int rzg2l_get_bias_val(enum pin_config_param param)
 	return -EINVAL;
 }
 
+static int rzv2h_get_bias_param(u8 val)
+{
+	switch (val) {
+	case 0:
+	case 1:
+		return PIN_CONFIG_BIAS_DISABLE;
+	case 2:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	case 3:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rzv2h_get_bias_val(enum pin_config_param param)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return 0;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return 2;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return 3;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, u32 offset)
+{
+	static const char * const pin_names[] = { "ET0_TXC_TXCLK", "ET1_TXC_TXCLK",
+						  "XSPI0_RESET0N", "XSPI0_CS0N",
+						  "XSPI0_CKN", "XSPI0_CKP" };
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	u8 bit_array[] = { 0, 1, 2, 3, 4, 5 };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(bit_array); i++) {
+		if (!strcmp(pin_desc->name, pin_names[i]))
+			return bit_array[i];
+	}
+
+	/* Should not happen. */
+	return 0;
+}
+
+static u32 rzv2h_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin)
+{
+	u8 bit;
+
+	if (!(caps & PIN_CFG_OEN))
+		return 0;
+
+	bit = rzv2h_pin_to_oen_bit(pctrl, offset);
+
+	return !(readb(pctrl->base + PFC_OEN) & BIT(bit));
+}
+
+static int rzv2h_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	unsigned long flags;
+	u8 val, bit;
+	u8 pwpr;
+
+	if (!(caps & PIN_CFG_OEN))
+		return -EINVAL;
+
+	bit = rzv2h_pin_to_oen_bit(pctrl, offset);
+	spin_lock_irqsave(&pctrl->lock, flags);
+	val = readb(pctrl->base + PFC_OEN);
+	if (oen)
+		val &= ~BIT(bit);
+	else
+		val |= BIT(bit);
+
+	raw_spin_lock(&pctrl->pwpr_lock);
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	writeb(val, pctrl->base + PFC_OEN);
+	writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	raw_spin_unlock(&pctrl->pwpr_lock);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
+	u32 param = pinconf_to_config_param(*config);
 	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
 	u32 off;
@@ -1240,6 +1404,14 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	}
 
+	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE: {
+		if (!(cfg & PIN_CFG_IOLH_RZV2H))
+			return -EINVAL;
+
+		arg = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		break;
+	}
+
 	default:
 		return -ENOTSUPP;
 	}
@@ -1259,9 +1431,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
 	u64 *pin_data = pin->drv_data;
-	enum pin_config_param param;
 	unsigned int i, arg, index;
-	u32 off;
+	u32 off, param;
 	u64 cfg;
 	int ret;
 	u8 bit;
@@ -1367,6 +1538,17 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 
+		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
+			arg = pinconf_to_config_argument(_configs[i]);
+
+			if (!(cfg & PIN_CFG_IOLH_RZV2H))
+				return -EINVAL;
+
+			if (arg > 3)
+				return -EINVAL;
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, arg);
+			break;
+
 		default:
 			return -EOPNOTSUPP;
 		}
@@ -1814,6 +1996,39 @@ static const u64 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
 };
 
+static const char * const rzv2h_gpio_names[] = {
+	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
+	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
+	"P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
+	"P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
+	"P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47",
+	"P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
+	"P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
+	"P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
+	"P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
+	"P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97",
+	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
+	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
+};
+
+static const u64 r9a09g057_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P0 */
+	RZG2L_GPIO_PORT_PACK(6, 0x21, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P1 */
+	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_COMMON_PIN_FUNCS(RZV2H) |
+				      PIN_CFG_OPEN_DRAIN),				/* P2 */
+	RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(8, 0x24, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(8, 0x25, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P5 */
+	RZG2L_GPIO_PORT_PACK(8, 0x26, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL |
+				      PIN_CFG_ELC),					/* P6 */
+	RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P7 */
+	RZG2L_GPIO_PORT_PACK(8, 0x28, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL |
+				      PIN_CFG_ELC),					/* P8 */
+	RZG2L_GPIO_PORT_PACK(8, 0x29, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* P9 */
+	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_SCHMIT_CTRL),	/* PA */
+	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),				/* PB */
+};
+
 static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1940,6 +2155,138 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 						       PIN_CFG_IO_VMC_SD1)) },
 };
 
+static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] = {
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
+						PIN_CFG_FILCLKSEL)) },
+	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_IEN)) },
+	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD | PIN_CFG_OPEN_DRAIN)) },
+	{ "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD | PIN_CFG_OPEN_DRAIN)) },
+	{ "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_CKP", RZG2L_SINGLE_PIN_PACK(0x7, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CKN", RZG2L_SINGLE_PIN_PACK(0x7, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CS0N", RZG2L_SINGLE_PIN_PACK(0x7, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						       PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_DS", RZG2L_SINGLE_PIN_PACK(0x7, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_RESET0N", RZG2L_SINGLE_PIN_PACK(0x7, 4, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+							  PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_RSTO0N", RZG2L_SINGLE_PIN_PACK(0x7, 5, (PIN_CFG_PUPD)) },
+	{ "XSPI0_INT0N", RZG2L_SINGLE_PIN_PACK(0x7, 6, (PIN_CFG_PUPD)) },
+	{ "XSPI0_ECS0N", RZG2L_SINGLE_PIN_PACK(0x7, 7, (PIN_CFG_PUPD)) },
+	{ "XSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0x8, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0x8, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0x8, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0x8, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO4", RZG2L_SINGLE_PIN_PACK(0x8, 4, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO5", RZG2L_SINGLE_PIN_PACK(0x8, 5, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO6", RZG2L_SINGLE_PIN_PACK(0x8, 6, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO7", RZG2L_SINGLE_PIN_PACK(0x8, 7, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						   PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1CLK", RZG2L_SINGLE_PIN_PACK(0xb, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "SD1CMD", RZG2L_SINGLE_PIN_PACK(0xb, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						   PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT0", RZG2L_SINGLE_PIN_PACK(0xc, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT1", RZG2L_SINGLE_PIN_PACK(0xc, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT2", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT3", RZG2L_SINGLE_PIN_PACK(0xc, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "PCIE0_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "PCIE1_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR)) },
+	{ "ET0_MDIO", RZG2L_SINGLE_PIN_PACK(0xf, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "ET0_MDC", RZG2L_SINGLE_PIN_PACK(0xf, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						    PIN_CFG_PUPD)) },
+	{ "ET0_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_PUPD)) },
+	{ "ET0_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET0_TXER", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXER", RZG2L_SINGLE_PIN_PACK(0x10, 3, (PIN_CFG_PUPD)) },
+	{ "ET0_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 5, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET0_CRS", RZG2L_SINGLE_PIN_PACK(0x10, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_COL", RZG2L_SINGLE_PIN_PACK(0x10, 7, (PIN_CFG_PUPD)) },
+	{ "ET0_TXD0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXD0", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD1", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD2", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD3", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_MDIO", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "ET1_MDC", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "ET1_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_PUPD)) },
+	{ "ET1_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET1_TXER", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						       PIN_CFG_PUPD)) },
+	{ "ET1_RXER", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_PUPD)) },
+	{ "ET1_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 4, (PIN_CFG_PUPD)) },
+	{ "ET1_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 5, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET1_CRS", RZG2L_SINGLE_PIN_PACK(0x13, 6, (PIN_CFG_PUPD)) },
+	{ "ET1_COL", RZG2L_SINGLE_PIN_PACK(0x13, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_TXD0", RZG2L_SINGLE_PIN_PACK(0x14, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD1", RZG2L_SINGLE_PIN_PACK(0x14, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD2", RZG2L_SINGLE_PIN_PACK(0x14, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD3", RZG2L_SINGLE_PIN_PACK(0x14, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_RXD0", RZG2L_SINGLE_PIN_PACK(0x14, 4, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD1", RZG2L_SINGLE_PIN_PACK(0x14, 5, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD2", RZG2L_SINGLE_PIN_PACK(0x14, 6, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD3", RZG2L_SINGLE_PIN_PACK(0x14, 7, (PIN_CFG_PUPD)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
@@ -2476,6 +2823,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzv2h_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -2498,6 +2848,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
+	raw_spin_lock_init(&pctrl->pwpr_lock);
 	mutex_init(&pctrl->mutex);
 	atomic_set(&pctrl->wakeup_path, 0);
 
@@ -2747,6 +3098,32 @@ static void rzg2l_pwpr_pfc_lock(struct rzg2l_pinctrl *pctrl)
 	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
 }
 
+static void rzv2h_pwpr_pfc_unlock(struct rzg2l_pinctrl *pctrl)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	/*
+	 * lock is acquired in pfc unlock call back and then released in
+	 * pfc lock callback
+	 */
+	raw_spin_lock(&pctrl->pwpr_lock);
+	/* Set the PWPR register to allow PFC and PMC register to write */
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(PWPR_PFCWE | pwpr, pctrl->base + regs->pwpr);
+}
+
+static void rzv2h_pwpr_pfc_lock(struct rzg2l_pinctrl *pctrl)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	/* Set the PWPR register to be write-protected */
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr & ~PWPR_PFCWE, pctrl->base + regs->pwpr);
+	raw_spin_unlock(&pctrl->pwpr_lock);
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
@@ -2792,6 +3169,12 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
 };
 
+static const struct rzg2l_hwcfg rzv2h_hwcfg = {
+	.regs = {
+		.pwpr = 0x3c04,
+	},
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -2846,6 +3229,30 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.get_bias_val = &rzg2l_get_bias_val,
 };
 
+static struct rzg2l_pinctrl_data r9a09g057_data = {
+	.port_pins = rzv2h_gpio_names,
+	.port_pin_configs = r9a09g057_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a09g057_gpio_configs),
+	.dedicated_pins = rzv2h_dedicated_pins,
+	.n_port_pins = ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzv2h_dedicated_pins),
+	.hwcfg = &rzv2h_hwcfg,
+	.variable_pin_cfg = r9a09g057_variable_pin_cfg,
+	.n_variable_pin_cfg = ARRAY_SIZE(r9a09g057_variable_pin_cfg),
+	.num_custom_params = ARRAY_SIZE(renesas_rzv2h_custom_bindings),
+	.custom_params = renesas_rzv2h_custom_bindings,
+#ifdef CONFIG_DEBUG_FS
+	.custom_conf_items = renesas_rzv2h_conf_items,
+#endif
+	.pwpr_pfc_unlock = &rzv2h_pwpr_pfc_unlock,
+	.pwpr_pfc_lock = &rzv2h_pwpr_pfc_lock,
+	.pmc_writeb = &rzv2h_pmc_writeb,
+	.read_oen = &rzv2h_read_oen,
+	.write_oen = &rzv2h_write_oen,
+	.get_bias_param = &rzv2h_get_bias_param,
+	.get_bias_val = &rzv2h_get_bias_val,
+};
+
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{
 		.compatible = "renesas,r9a07g043-pinctrl",
@@ -2859,6 +3266,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 		.compatible = "renesas,r9a08g045-pinctrl",
 		.data = &r9a08g045_data,
 	},
+	{
+		.compatible = "renesas,r9a09g057-pinctrl",
+		.data = &r9a09g057_data,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.34.1


