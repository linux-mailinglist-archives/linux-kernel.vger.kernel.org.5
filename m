Return-Path: <linux-kernel+bounces-120057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395488D0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF3BB23648
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861D1419B1;
	Tue, 26 Mar 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPgoSSzS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F591411CB;
	Tue, 26 Mar 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492219; cv=none; b=uO7bWVEEsagQdLX+p2aW5TQQ1ZBAX2Zg3yW4uCyIWRGhZWyN0WO1XWRsmA2N0gkwJLtZ8WoZzZXSvyEw3zw+EPJPCFUisgZsy9db0c8uPBUGC9ZJOO7+zyBk30ls6YOX268Bg2lycVGYtrmgwIu1A69YPkt6aQZcV/PM7KQXgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492219; c=relaxed/simple;
	bh=JwJWMDuWKG7jB0KKjrnJyPt1GfNoAJUbekvIJ+GaHhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UthXukDJFMDMHxEy6xM166aGPDVeEZPNo/SEe+fXbhiBCQ7YC9IEKoZdFZV/3q8YNbjBQo8HZ4L/PsRwe6570qsufxajURk+u3dAR/RkHy57plWych1+vLm2HLBDZQFpXPN5OdugTzlQ7XlKvyGEJlM3TkKdEdK/aWzZYgzyBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPgoSSzS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341cf77b86bso1754431f8f.2;
        Tue, 26 Mar 2024 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492215; x=1712097015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoIu7Td2GlNTSNXOZJhq13YmHgWD3Jk9mFKbP6NmLHg=;
        b=OPgoSSzSRVvqOWQYsRE46Cw5RiWJc/uaYook34yyXsH8rA5tsMfieuuKgZMMtxhNr/
         vQ9o6iV8LtHsr9v5L4vP7x8boescUJvhnSjge4CJSawUDv40rRU5SX5Zvv62z6h3kLTW
         0Wj1MJ5IUrDwHW1ch+qGZyhwfRBj7Ax0r4wDGBrHli6nmDcIwNLtELHqqoEELn1EgV6O
         w9gtjzeAYWolf9NAj0oh7tWgdWYvari2RtgbZ1xZpssDLXnpa/1ScItcr3PwbDIeXE8i
         56Xhm85tNtIMDYu4mI5YfhXdQeaK4nbBexvePdkehhCZoAby8iAVyxp93/h2q0pbcGN7
         QXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492215; x=1712097015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoIu7Td2GlNTSNXOZJhq13YmHgWD3Jk9mFKbP6NmLHg=;
        b=BUewrECsbCwxDMrqMvg7JFgrCPDD+spXoZj8ayG75uw/d054KhdYbi7Jywf0PtCZ42
         PFldNcuV6Zeq+4t1BFaWhNRv8aUb8Lqqsqr+aHptq+yADuavvXa5nWO5qypd03Xand1E
         hbet+qkXdDdWlaoHjcifvlK6vagOQr7/PQhxUSG+pdowdqtwtKVPPTr8K5gwnqeULKT+
         qK8wQvxOdDCSG93G6WDVhcxkl98rbj7aVWgdGF7og36os5TktJsNtAd966dpE/x+qw46
         /5Zt6EHGUTRyYX+JbkL6aM1nT1YDlvkNLdQJHmaE5JHaHxBTNDJthrFaqGiChgA1fMJK
         hm4g==
X-Forwarded-Encrypted: i=1; AJvYcCW2b2S6xShI3uGCxLiLaOkeFm7negsiqYomjjJhsf+QMJdF6k4GNZ1Piuczmvf3vzDX5L19vNJcb/AWnG4gSouuh67mFYRRFe41S/PZz34F5Bvhl5cfHqTnyGHvddiqz75IrhqhRmjjG0N/WWosLWRCftT779a9n7oqSRERb3we4O1UEj0=
X-Gm-Message-State: AOJu0YwsZIG4TO2teGKlN3C0e2SjoDTSVn/wsZF80CJu1e3v8XPUdElr
	i8iIeWrYYAt/8cPQX6XHOtYy3+8z0BP2d8R5Meij7gLDSRopGva4
X-Google-Smtp-Source: AGHT+IF40tcB4K2nTuKxHMWi+PQSLrXQKqNzTdOt0RCe4doJH42o0HJ5Vlc+ApB68YRE6z+yb1ic2Q==
X-Received: by 2002:a5d:5b88:0:b0:33e:c0a9:79c with SMTP id df8-20020a5d5b88000000b0033ec0a9079cmr581527wrb.23.1711492214853;
        Tue, 26 Mar 2024 15:30:14 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:13 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 13/13] pinctrl: renesas: pinctrl-rzg2l: Add support for RZ/V2H SoC
Date: Tue, 26 Mar 2024 22:28:44 +0000
Message-Id: <20240326222844.1422948-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 483 +++++++++++++++++++++++-
 1 file changed, 481 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6f0c85bb97a8..716c11ca5a8f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -59,6 +59,13 @@
 #define PIN_CFG_OEN			BIT(15)
 #define PIN_CFG_VARIABLE		BIT(16)
 #define PIN_CFG_NOGPIO_INT		BIT(17)
+#define PIN_CFG_OPEN_DRAIN		BIT(18)
+#define PIN_CFG_SCHMIT_CTRL		BIT(19)
+#define PIN_CFG_ELC			BIT(20)
+#define PIN_CFG_IOLH_1			BIT(21)
+#define PIN_CFG_IOLH_2			BIT(22)
+#define PIN_CFG_IOLH_3			BIT(23)
+#define PIN_CFG_IOLH_4			BIT(24)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -70,6 +77,10 @@
 #define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
 					 PIN_CFG_SR)
 
+#define RZV2H_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
+					 PIN_CFG_OPEN_DRAIN | \
+					 PIN_CFG_SR)
+
 #define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
 					 PIN_CFG_SOFT_PS)
 
@@ -133,6 +144,8 @@
 
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
+#define PWPR_REGWE_A		BIT(6)	/* PFC and PMC Register Write Enable */
+#define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable */
 
 #define PM_MASK			0x03
 #define PFC_MASK		0x07
@@ -149,6 +162,19 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/* Custom pinconf parameters */
+#define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
+
+static const struct pinconf_generic_params renesas_rzv2h_custom_bindings[] = {
+	{ "renesas-rzv2h,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, 1 },
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
@@ -324,6 +350,8 @@ struct rzg2l_pinctrl {
 	spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 
+	raw_spinlock_t			pwpr_lock; /* serialize PWPR register access */
+
 	struct rzg2l_pinctrl_pin_settings *settings;
 	struct rzg2l_pinctrl_reg_cache	*cache;
 	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
@@ -348,6 +376,79 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+static const struct rzg2l_variable_pin_cfg r9a09g057_variable_pin_cfg[] = {
+	{
+		.port = 9,
+		.pin = 0,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 1,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 2,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 3,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 4,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 5,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 6,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 9,
+		.pin = 7,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 11,
+		.pin = 0,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL,
+	},
+	{
+		.port = 11,
+		.pin = 1,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 2,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 3,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 4,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+	{
+		.port = 11,
+		.pin = 5,
+		.cfg = RZV2H_MPXED_PIN_FUNCS(2) | PIN_CFG_SCHMIT_CTRL | PIN_CFG_IEN,
+	},
+};
+
 #ifdef CONFIG_RISCV
 static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 	{
@@ -474,6 +575,19 @@ static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *
 	writeb(val, addr);
 }
 
+static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, void __iomem *addr)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	raw_spin_lock(&pctrl->pwpr_lock);
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);
+	writeb(val, addr);
+	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
+	raw_spin_unlock(&pctrl->pwpr_lock);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -512,6 +626,47 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
 
+static void rzv2h_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
+				       u8 pin, u8 off, u8 func)
+{
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	unsigned long flags;
+	u32 reg;
+	u8 pwpr;
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+
+	/* Set pin to 'Non-use (Hi-Z input protection)'  */
+	reg = readw(pctrl->base + PM(off));
+	reg &= ~(PM_MASK << (pin * 2));
+	writew(reg, pctrl->base + PM(off));
+
+	/* Set the PWPR register to allow PFC and PMC register to write */
+	raw_spin_lock(&pctrl->pwpr_lock);
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(PWPR_PFCWE | pwpr, pctrl->base + regs->pwpr);
+
+	/* Temporarily switch to GPIO mode with PMC register */
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
+
+	/* Select Pin function mode with PFC register */
+	reg = readl(pctrl->base + PFC(off));
+	reg &= ~(PFC_MASK << (pin * 4));
+	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
+
+	/* Switch to Peripheral pin function with PMC register */
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg | BIT(pin), pctrl->base + PMC(off));
+
+	/* Set the PWPR register to be write-protected */
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr & ~PWPR_PFCWE, pctrl->base + regs->pwpr);
+	raw_spin_unlock(&pctrl->pwpr_lock);
+
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+};
+
 static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
 				 unsigned int group_selector)
@@ -1087,14 +1242,26 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8
 	return 0;
 }
 
+static u32 rzv2h_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin)
+{
+	/* stub */
+	return 0;
+}
+
+static int rzv2h_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen)
+{
+	/* stub */
+	return -EINVAL;
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
 	u32 off, cfg;
@@ -1180,6 +1347,30 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	}
 
+	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE: {
+		u8 val;
+
+		if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 | PIN_CFG_IOLH_3 | PIN_CFG_IOLH_4)))
+			return -EINVAL;
+
+		val = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		switch (val) {
+		case 0:
+			arg = 1;
+			break;
+		case 1:
+			arg = 2;
+			break;
+		case 2:
+			arg = 4;
+			break;
+		default:
+			arg = 6;
+			break;
+		}
+		break;
+	}
+
 	default:
 		return -ENOTSUPP;
 	}
@@ -1199,9 +1390,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
 	u64 *pin_data = pin->drv_data;
-	enum pin_config_param param;
 	unsigned int i, arg, index;
 	u32 cfg, off;
+	u32 param;
 	int ret;
 	u8 bit;
 
@@ -1283,6 +1474,32 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 
+		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
+			arg = pinconf_to_config_argument(_configs[i]);
+
+			if (!(cfg & (PIN_CFG_IOLH_1 | PIN_CFG_IOLH_2 |
+				     PIN_CFG_IOLH_3 | PIN_CFG_IOLH_4)))
+				return -EINVAL;
+
+			switch (arg) {
+			case 1:
+				index = 0;
+				break;
+			case 2:
+				index = 1;
+				break;
+			case 4:
+				index = 2;
+				break;
+			case 6:
+				index = 3;
+				break;
+			default:
+				return -EINVAL;
+			}
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
+			break;
+
 		default:
 			return -EOPNOTSUPP;
 		}
@@ -1730,6 +1947,38 @@ static const u64 r9a08g045_gpio_configs[] = {
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
+	RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P0 */
+	RZG2L_GPIO_PORT_PACK(6, 0x21, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P1 */
+	RZG2L_GPIO_PORT_PACK(2, 0x22, RZV2H_MPXED_PIN_FUNCS(4)),			/* P2 */
+	RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(8, 0x24, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(8, 0x25, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P5 */
+	RZG2L_GPIO_PORT_PACK(8, 0x26, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL |
+			     PIN_CFG_ELC),						/* P6 */
+	RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* P7 */
+	RZG2L_GPIO_PORT_PACK(8, 0x28, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL |
+			    PIN_CFG_ELC),						/* P8 */
+	RZG2L_GPIO_PORT_PACK(8, 0x29, PIN_CFG_VARIABLE),				/* P9 */
+	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS(3) | PIN_CFG_SCHMIT_CTRL),	/* PA */
+	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),				/* PB */
+};
+
 static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1856,6 +2105,139 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 						       PIN_CFG_IO_VMC_SD1)) },
 };
 
+static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] = {
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
+						PIN_CFG_FILCLKSEL)) },
+	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						      PIN_CFG_IEN)) },
+	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
+	{ "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_CKP", RZG2L_SINGLE_PIN_PACK(0x7, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CKN", RZG2L_SINGLE_PIN_PACK(0x7, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CS0N", RZG2L_SINGLE_PIN_PACK(0x7, 2, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+						       PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_DS", RZG2L_SINGLE_PIN_PACK(0x7, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_RESET0N", RZG2L_SINGLE_PIN_PACK(0x7, 4, (PIN_CFG_IOLH_1 | PIN_CFG_SR |
+							  PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_RSTO0N", RZG2L_SINGLE_PIN_PACK(0x7, 5, (PIN_CFG_PUPD)) },
+	{ "XSPI0_INT0N", RZG2L_SINGLE_PIN_PACK(0x7, 6, (PIN_CFG_PUPD)) },
+	{ "XSPI0_ECS0N", RZG2L_SINGLE_PIN_PACK(0x7, 7, (PIN_CFG_PUPD)) },
+	{ "XSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0x8, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0x8, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0x8, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0x8, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO4", RZG2L_SINGLE_PIN_PACK(0x8, 4, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO5", RZG2L_SINGLE_PIN_PACK(0x8, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO6", RZG2L_SINGLE_PIN_PACK(0x8, 6, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO7", RZG2L_SINGLE_PIN_PACK(0x8, 7, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
+	{ "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
+	{ "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IOLH_2 | PIN_CFG_PUPD)) },
+	{ "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0xb, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR)) },
+	{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0xb, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1_DAT0", RZG2L_SINGLE_PIN_PACK(0xc, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1_DAT1", RZG2L_SINGLE_PIN_PACK(0xc, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1_DAT2", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1_DAT3", RZG2L_SINGLE_PIN_PACK(0xc, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "PCIE0_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 0, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
+	{ "PCIE1_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 1, (PIN_CFG_IOLH_1 | PIN_CFG_SR)) },
+	{ "ET0_MDIO", RZG2L_SINGLE_PIN_PACK(0xf, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "ET0_MDC", RZG2L_SINGLE_PIN_PACK(0xf, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						    PIN_CFG_PUPD)) },
+	{ "ET0_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_PUPD)) },
+	{ "ET0_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET0_TXER", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXER", RZG2L_SINGLE_PIN_PACK(0x10, 3, (PIN_CFG_PUPD)) },
+	{ "ET0_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET0_CRS", RZG2L_SINGLE_PIN_PACK(0x10, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_COL", RZG2L_SINGLE_PIN_PACK(0x10, 7, (PIN_CFG_PUPD)) },
+	{ "ET0_TXD0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXD0", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD1", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD2", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD3", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_MDIO", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_SR | PIN_CFG_IEN |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_MDC", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						     PIN_CFG_PUPD)) },
+	{ "ET1_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_PUPD)) },
+	{ "ET1_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET1_TXER", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						       PIN_CFG_PUPD)) },
+	{ "ET1_RXER", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_PUPD)) },
+	{ "ET1_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 4, (PIN_CFG_PUPD)) },
+	{ "ET1_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 5, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET1_CRS", RZG2L_SINGLE_PIN_PACK(0x13, 6, (PIN_CFG_PUPD)) },
+	{ "ET1_COL", RZG2L_SINGLE_PIN_PACK(0x13, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_TXD0", RZG2L_SINGLE_PIN_PACK(0x14, 0, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD1", RZG2L_SINGLE_PIN_PACK(0x14, 1, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD2", RZG2L_SINGLE_PIN_PACK(0x14, 2, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD3", RZG2L_SINGLE_PIN_PACK(0x14, 3, (PIN_CFG_IOLH_2 | PIN_CFG_SR |
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
@@ -2380,6 +2762,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzv2h_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -2402,6 +2787,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
+	raw_spin_lock_init(&pctrl->pwpr_lock);
 	mutex_init(&pctrl->mutex);
 	atomic_set(&pctrl->wakeup_path, 0);
 
@@ -2578,6 +2964,65 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
 }
 
+static void rzv2h_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	u8 pwpr;
+
+	/* Set the PWPR register to allow PFC + PMC register to write. */
+	raw_spin_lock(&pctrl->pwpr_lock);
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);	/* REGWE_A=1 */
+
+	/* Restore port registers. */
+	for (u32 port = 0; port < nports; port++) {
+		unsigned long pinmap;
+		u8 pmc = 0, max_pin;
+		u32 off, pfc = 0;
+		u64 cfg;
+		u16 pm;
+		u8 pin;
+
+		cfg = pctrl->data->port_pin_configs[port];
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
+		max_pin = fls(pinmap);
+
+		pm = readw(pctrl->base + PM(off));
+		for_each_set_bit(pin, &pinmap, max_pin) {
+			struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+
+			/* Nothing to do if PFC was not configured before. */
+			if (!(cache->pmc[port] & BIT(pin)))
+				continue;
+
+			/* Set pin to 'Non-use (Hi-Z input protection)' */
+			pm &= ~(PM_MASK << (pin * 2));
+			writew(pm, pctrl->base + PM(off));
+
+			/* Temporarily switch to GPIO mode with PMC register */
+			pmc &= ~BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+
+			/* Select Pin function mode. */
+			pfc &= ~(PFC_MASK << (pin * 4));
+			pfc |= (cache->pfc[port] & (PFC_MASK << (pin * 4)));
+			writel(pfc, pctrl->base + PFC(off));
+
+			/* Switch to Peripheral pin function. */
+			pmc |= BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+		}
+	}
+
+	/* Set the PWPR register to be write-protected. */
+	pwpr = readb(pctrl->base + regs->pwpr);
+	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);	/* REGWE_A=0 */
+	raw_spin_unlock(&pctrl->pwpr_lock);
+}
+
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 {
 	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
@@ -2682,6 +3127,14 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
 };
 
+static const struct rzg2l_hwcfg rzv2h_hwcfg = {
+	.regs = {
+		.pwpr = 0x3c04,
+		.sd_ch = 0x0,
+		.eth_poc = 0x0,
+	},
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -2732,6 +3185,28 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.write_oen = &rzg2l_write_oen,
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
+	.set_pfc_mode = &rzv2h_pinctrl_set_pfc_mode,
+	.pm_set_pfc = &rzv2h_pinctrl_pm_setup_pfc,
+	.pmc_writeb = &rzv2h_pmc_writeb,
+	.read_oen = &rzv2h_read_oen,
+	.write_oen = &rzv2h_write_oen,
+};
+
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{
 		.compatible = "renesas,r9a07g043-pinctrl",
@@ -2745,6 +3220,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
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


