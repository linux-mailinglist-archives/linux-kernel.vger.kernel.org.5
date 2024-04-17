Return-Path: <linux-kernel+bounces-148430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787488A8276
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26B41F22E90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C00140369;
	Wed, 17 Apr 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="V3PyjJal";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DXUHK/AO"
Received: from c180-41.smtp-out.ap-south-1.amazonses.com (c180-41.smtp-out.ap-south-1.amazonses.com [76.223.180.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52C13DDD7;
	Wed, 17 Apr 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354602; cv=none; b=PP3AAi89IIITH/kNchK0t5y8Pb3qxXGK1EcPPZkff7SEdqZybsy/mxN46M4u0ZVqK1dV/YDLHBwKLsyEzpBpj9wB0rxOuC5+/0N6n1LeY8z260rfbggtXVOyTRmCouSEbNCxyFFtrkFSRr5YVxIkhfYs2zB8mXBj75am2ELENFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354602; c=relaxed/simple;
	bh=1gMX5bo0GFeYRXKHCNluOUds4LsT0ZpSan3/q316atY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6YMVjYAvyp5kFaqVw3VtX9LpRotm4kbwaileDh9WWczUOU5d2F9ftsKjElD3mT8VBw1a5rJyCwa37nwbxV+KFsShnL2sR5B6eWFKxmugRawbnyfo1NyhI93GoJvQDyFXds5AvBiC00Vez9a/au7Cn971iuTPfNxMVnyYgcpdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=V3PyjJal; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DXUHK/AO; arc=none smtp.client-ip=76.223.180.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354597;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1gMX5bo0GFeYRXKHCNluOUds4LsT0ZpSan3/q316atY=;
	b=V3PyjJall+Oi5RB5o0Xcu3Q5fV0Eqmv3g+wl3QLueZzc+UaoDGtrWDIEgvfYFYgt
	yVQN7BYmm2LDiZwDIJdXH4m0kYpslkZlaOeBwrdcmHoRlUlOwMjuOJB5yqTzXJBR7wf
	WPGReN4f83dSCaqBFh4ob/K4bnd7GfrZco1mtVwMA3Opa9+1dFNneOb/TeSJkZNSS4T
	RmtdhOC4jbHVsSN6cd0jFmZd73Hn0CByQJ3vgXgRdBvobxhY1VuVQaRMcbOSlaN4Nj/
	hTGD926in7XKtVp3sMfsTpa1uCtZJdQFHIljzppH6ydEUYX0XUemPNk8KYtkBWa2AI2
	kUbQ4O0CsA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354597;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=1gMX5bo0GFeYRXKHCNluOUds4LsT0ZpSan3/q316atY=;
	b=DXUHK/AO9NHlj0DbjNF/XJHapHNsvCnJGErQ9aQYmLwrAMWVxslN31JsNjsbGzmT
	DUlLtW7qs3zr5P1+XjcWbNKjuVg23UUot0KUHvtj+KnvJP7l6nOWAp5ydKzUhcVWAU5
	QXtyUZ2rd007Luku9PKTfiahn2mNE3O5xph6CQVU=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v7 06/10] mfd: tps6594-core: Add TI TPS65224 PMIC core
Date: Wed, 17 Apr 2024 11:49:57 +0000
Message-ID: <0109018eebe462ee-636f1fa5-535d-43fe-9c3b-e3be3fe15554-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417114934.186248-1-bhargav.r@ltts.com>
References: <20240417114934.186248-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.41

Add functionality of the TPS65224 PMIC to the TPS6594 core driver. This
includes adding IRQ resource, MFD cells, and device initialization for
TPS65224.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-core.c | 237 ++++++++++++++++++++++++++++++++++---
 1 file changed, 219 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 089ab8cc8..c59f3d7e3 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Core functions for TI TPS6594/TPS6593/LP8764 PMICs
+ * Core functions for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -278,16 +278,159 @@ static const unsigned int tps6594_irq_reg[] = {
 	TPS6594_REG_RTC_STATUS,
 };
 
+/* TPS65224 Resources */
+
+static const struct resource tps65224_regulator_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BUCK1_UVOV, TPS65224_IRQ_NAME_BUCK1_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BUCK2_UVOV, TPS65224_IRQ_NAME_BUCK2_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BUCK3_UVOV, TPS65224_IRQ_NAME_BUCK3_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BUCK4_UVOV, TPS65224_IRQ_NAME_BUCK4_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_LDO1_UVOV, TPS65224_IRQ_NAME_LDO1_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_LDO2_UVOV, TPS65224_IRQ_NAME_LDO2_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_LDO3_UVOV, TPS65224_IRQ_NAME_LDO3_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_VCCA_UVOV, TPS65224_IRQ_NAME_VCCA_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_VMON1_UVOV, TPS65224_IRQ_NAME_VMON1_UVOV),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_VMON2_UVOV, TPS65224_IRQ_NAME_VMON2_UVOV),
+};
+
+static const struct resource tps65224_pinctrl_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO1, TPS65224_IRQ_NAME_GPIO1),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO2, TPS65224_IRQ_NAME_GPIO2),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO3, TPS65224_IRQ_NAME_GPIO3),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO4, TPS65224_IRQ_NAME_GPIO4),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO5, TPS65224_IRQ_NAME_GPIO5),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_GPIO6, TPS65224_IRQ_NAME_GPIO6),
+};
+
+static const struct resource tps65224_pfsm_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_VSENSE, TPS65224_IRQ_NAME_VSENSE),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_ENABLE, TPS65224_IRQ_NAME_ENABLE),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_PB_SHORT, TPS65224_IRQ_NAME_PB_SHORT),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_FSD, TPS65224_IRQ_NAME_FSD),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_SOFT_REBOOT, TPS65224_IRQ_NAME_SOFT_REBOOT),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BIST_PASS, TPS65224_IRQ_NAME_BIST_PASS),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_EXT_CLK, TPS65224_IRQ_NAME_EXT_CLK),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_REG_UNLOCK, TPS65224_IRQ_NAME_REG_UNLOCK),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_TWARN, TPS65224_IRQ_NAME_TWARN),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_PB_LONG, TPS65224_IRQ_NAME_PB_LONG),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_PB_FALL, TPS65224_IRQ_NAME_PB_FALL),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_PB_RISE, TPS65224_IRQ_NAME_PB_RISE),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_TSD_ORD, TPS65224_IRQ_NAME_TSD_ORD),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BIST_FAIL, TPS65224_IRQ_NAME_BIST_FAIL),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_REG_CRC_ERR, TPS65224_IRQ_NAME_REG_CRC_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_RECOV_CNT, TPS65224_IRQ_NAME_RECOV_CNT),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_TSD_IMM, TPS65224_IRQ_NAME_TSD_IMM),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_VCCA_OVP, TPS65224_IRQ_NAME_VCCA_OVP),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_PFSM_ERR, TPS65224_IRQ_NAME_PFSM_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_BG_XMON, TPS65224_IRQ_NAME_BG_XMON),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_IMM_SHUTDOWN, TPS65224_IRQ_NAME_IMM_SHUTDOWN),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_ORD_SHUTDOWN, TPS65224_IRQ_NAME_ORD_SHUTDOWN),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_MCU_PWR_ERR, TPS65224_IRQ_NAME_MCU_PWR_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_SOC_PWR_ERR, TPS65224_IRQ_NAME_SOC_PWR_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_COMM_ERR, TPS65224_IRQ_NAME_COMM_ERR),
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_I2C2_ERR, TPS65224_IRQ_NAME_I2C2_ERR),
+};
+
+static const struct resource tps65224_adc_resources[] = {
+	DEFINE_RES_IRQ_NAMED(TPS65224_IRQ_ADC_CONV_READY, TPS65224_IRQ_NAME_ADC_CONV_READY),
+};
+
+static const struct mfd_cell tps65224_common_cells[] = {
+	MFD_CELL_RES("tps65224-adc", tps65224_adc_resources),
+	MFD_CELL_RES("tps6594-pfsm", tps65224_pfsm_resources),
+	MFD_CELL_RES("tps6594-pinctrl", tps65224_pinctrl_resources),
+	MFD_CELL_RES("tps6594-regulator", tps65224_regulator_resources),
+};
+
+static const struct regmap_irq tps65224_irqs[] = {
+	/* INT_BUCK register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_BUCK1_UVOV, 0, TPS65224_BIT_BUCK1_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_BUCK2_UVOV, 0, TPS65224_BIT_BUCK2_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_BUCK3_UVOV, 0, TPS65224_BIT_BUCK3_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_BUCK4_UVOV, 0, TPS65224_BIT_BUCK4_UVOV_INT),
+
+	/* INT_VMON_LDO register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_LDO1_UVOV, 1, TPS65224_BIT_LDO1_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_LDO2_UVOV, 1, TPS65224_BIT_LDO2_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_LDO3_UVOV, 1, TPS65224_BIT_LDO3_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_VCCA_UVOV, 1, TPS65224_BIT_VCCA_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_VMON1_UVOV, 1, TPS65224_BIT_VMON1_UVOV_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_VMON2_UVOV, 1, TPS65224_BIT_VMON2_UVOV_INT),
+
+	/* INT_GPIO register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO1, 2, TPS65224_BIT_GPIO1_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO2, 2, TPS65224_BIT_GPIO2_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO3, 2, TPS65224_BIT_GPIO3_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO4, 2, TPS65224_BIT_GPIO4_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO5, 2, TPS65224_BIT_GPIO5_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_GPIO6, 2, TPS65224_BIT_GPIO6_INT),
+
+	/* INT_STARTUP register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_VSENSE, 3, TPS65224_BIT_VSENSE_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_ENABLE, 3, TPS6594_BIT_ENABLE_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_PB_SHORT, 3, TPS65224_BIT_PB_SHORT_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_FSD, 3, TPS6594_BIT_FSD_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_SOFT_REBOOT, 3, TPS6594_BIT_SOFT_REBOOT_INT),
+
+	/* INT_MISC register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_BIST_PASS, 4, TPS6594_BIT_BIST_PASS_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_EXT_CLK, 4, TPS6594_BIT_EXT_CLK_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_REG_UNLOCK, 4, TPS65224_BIT_REG_UNLOCK_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_TWARN, 4, TPS6594_BIT_TWARN_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_PB_LONG, 4, TPS65224_BIT_PB_LONG_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_PB_FALL, 4, TPS65224_BIT_PB_FALL_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_PB_RISE, 4, TPS65224_BIT_PB_RISE_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_ADC_CONV_READY, 4, TPS65224_BIT_ADC_CONV_READY_INT),
+
+	/* INT_MODERATE_ERR register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_TSD_ORD, 5, TPS6594_BIT_TSD_ORD_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_BIST_FAIL, 5, TPS6594_BIT_BIST_FAIL_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_REG_CRC_ERR, 5, TPS6594_BIT_REG_CRC_ERR_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_RECOV_CNT, 5, TPS6594_BIT_RECOV_CNT_INT),
+
+	/* INT_SEVERE_ERR register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_TSD_IMM, 6, TPS6594_BIT_TSD_IMM_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_VCCA_OVP, 6, TPS6594_BIT_VCCA_OVP_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_PFSM_ERR, 6, TPS6594_BIT_PFSM_ERR_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_BG_XMON, 6, TPS65224_BIT_BG_XMON_INT),
+
+	/* INT_FSM_ERR register */
+	REGMAP_IRQ_REG(TPS65224_IRQ_IMM_SHUTDOWN, 7, TPS6594_BIT_IMM_SHUTDOWN_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_ORD_SHUTDOWN, 7, TPS6594_BIT_ORD_SHUTDOWN_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_MCU_PWR_ERR, 7, TPS6594_BIT_MCU_PWR_ERR_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_SOC_PWR_ERR, 7, TPS6594_BIT_SOC_PWR_ERR_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_COMM_ERR, 7, TPS6594_BIT_COMM_ERR_INT),
+	REGMAP_IRQ_REG(TPS65224_IRQ_I2C2_ERR, 7, TPS65224_BIT_I2C2_ERR_INT),
+};
+
+static const unsigned int tps65224_irq_reg[] = {
+	TPS6594_REG_INT_BUCK,
+	TPS6594_REG_INT_LDO_VMON,
+	TPS6594_REG_INT_GPIO,
+	TPS6594_REG_INT_STARTUP,
+	TPS6594_REG_INT_MISC,
+	TPS6594_REG_INT_MODERATE_ERR,
+	TPS6594_REG_INT_SEVERE_ERR,
+	TPS6594_REG_INT_FSM_ERR,
+};
+
 static inline unsigned int tps6594_get_irq_reg(struct regmap_irq_chip_data *data,
 					       unsigned int base, int index)
 {
 	return tps6594_irq_reg[index];
 };
 
+static inline unsigned int tps65224_get_irq_reg(struct regmap_irq_chip_data *data,
+						unsigned int base, int index)
+{
+	return tps65224_irq_reg[index];
+};
+
 static int tps6594_handle_post_irq(void *irq_drv_data)
 {
 	struct tps6594 *tps = irq_drv_data;
 	int ret = 0;
+	unsigned int regmap_reg, mask_val;
 
 	/*
 	 * When CRC is enabled, writing to a read-only bit triggers an error,
@@ -299,10 +442,17 @@ static int tps6594_handle_post_irq(void *irq_drv_data)
 	 * COMM_ADR_ERR_INT bit set. Clear immediately this bit to avoid raising
 	 * a new interrupt.
 	 */
-	if (tps->use_crc)
-		ret = regmap_write_bits(tps->regmap, TPS6594_REG_INT_COMM_ERR,
-					TPS6594_BIT_COMM_ADR_ERR_INT,
-					TPS6594_BIT_COMM_ADR_ERR_INT);
+	if (tps->use_crc) {
+		if (tps->chip_id == TPS65224) {
+			regmap_reg = TPS6594_REG_INT_FSM_ERR;
+			mask_val = TPS6594_BIT_COMM_ERR_INT;
+		} else {
+			regmap_reg = TPS6594_REG_INT_COMM_ERR;
+			mask_val = TPS6594_BIT_COMM_ADR_ERR_INT;
+		}
+
+		ret = regmap_write_bits(tps->regmap, regmap_reg, mask_val, mask_val);
+	}
 
 	return ret;
 };
@@ -319,6 +469,18 @@ static struct regmap_irq_chip tps6594_irq_chip = {
 	.handle_post_irq = tps6594_handle_post_irq,
 };
 
+static struct regmap_irq_chip tps65224_irq_chip = {
+	.ack_base = TPS6594_REG_INT_BUCK,
+	.ack_invert = 1,
+	.clear_ack = 1,
+	.init_ack_masked = 1,
+	.num_regs = ARRAY_SIZE(tps65224_irq_reg),
+	.irqs = tps65224_irqs,
+	.num_irqs = ARRAY_SIZE(tps65224_irqs),
+	.get_irq_reg = tps65224_get_irq_reg,
+	.handle_post_irq = tps6594_handle_post_irq,
+};
+
 static const struct regmap_range tps6594_volatile_ranges[] = {
 	regmap_reg_range(TPS6594_REG_INT_TOP, TPS6594_REG_STAT_READBACK_ERR),
 	regmap_reg_range(TPS6594_REG_RTC_STATUS, TPS6594_REG_RTC_STATUS),
@@ -330,17 +492,35 @@ const struct regmap_access_table tps6594_volatile_table = {
 };
 EXPORT_SYMBOL_GPL(tps6594_volatile_table);
 
+static const struct regmap_range tps65224_volatile_ranges[] = {
+	regmap_reg_range(TPS6594_REG_INT_TOP, TPS6594_REG_STAT_SEVERE_ERR),
+};
+
+const struct regmap_access_table tps65224_volatile_table = {
+	.yes_ranges = tps65224_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tps65224_volatile_ranges),
+};
+EXPORT_SYMBOL_GPL(tps65224_volatile_table);
+
 static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
 {
 	int ret;
+	unsigned int regmap_reg, mask_val;
+
+	if (tps->chip_id == TPS65224) {
+		regmap_reg = TPS6594_REG_CONFIG_2;
+		mask_val = TPS65224_BIT_I2C1_SPI_CRC_EN;
+	} else {
+		regmap_reg = TPS6594_REG_SERIAL_IF_CONFIG;
+		mask_val = TPS6594_BIT_I2C1_SPI_CRC_EN;
+	};
 
 	/*
 	 * Check if CRC is enabled.
 	 * Once CRC is enabled, it can't be disabled until next power cycle.
 	 */
 	tps->use_crc = true;
-	ret = regmap_test_bits(tps->regmap, TPS6594_REG_SERIAL_IF_CONFIG,
-			       TPS6594_BIT_I2C1_SPI_CRC_EN);
+	ret = regmap_test_bits(tps->regmap, regmap_reg, mask_val);
 	if (ret == 0) {
 		ret = -EIO;
 	} else if (ret > 0) {
@@ -355,6 +535,15 @@ static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
 static int tps6594_set_crc_feature(struct tps6594 *tps)
 {
 	int ret;
+	unsigned int regmap_reg, mask_val;
+
+	if (tps->chip_id == TPS65224) {
+		regmap_reg = TPS6594_REG_CONFIG_2;
+		mask_val = TPS65224_BIT_I2C1_SPI_CRC_EN;
+	} else {
+		regmap_reg = TPS6594_REG_FSM_I2C_TRIGGERS;
+		mask_val = TPS6594_BIT_TRIGGER_I2C(2);
+	}
 
 	ret = tps6594_check_crc_mode(tps, true);
 	if (ret) {
@@ -363,8 +552,7 @@ static int tps6594_set_crc_feature(struct tps6594 *tps)
 		 * on primary PMIC.
 		 */
 		tps->use_crc = false;
-		ret = regmap_write_bits(tps->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
-					TPS6594_BIT_TRIGGER_I2C(2), TPS6594_BIT_TRIGGER_I2C(2));
+		ret = regmap_write_bits(tps->regmap, regmap_reg, mask_val, mask_val);
 		if (ret)
 			return ret;
 
@@ -420,6 +608,9 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 {
 	struct device *dev = tps->dev;
 	int ret;
+	struct regmap_irq_chip *irq_chip;
+	const struct mfd_cell *cells;
+	int n_cells;
 
 	if (enable_crc) {
 		ret = tps6594_enable_crc(tps);
@@ -433,26 +624,35 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set PMIC state\n");
 
-	tps6594_irq_chip.irq_drv_data = tps;
-	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
-					       dev->driver->name, tps->chip_id, tps->reg);
+	if (tps->chip_id == TPS65224) {
+		irq_chip = &tps65224_irq_chip;
+		n_cells = ARRAY_SIZE(tps65224_common_cells);
+		cells = tps65224_common_cells;
+	} else {
+		irq_chip = &tps6594_irq_chip;
+		n_cells = ARRAY_SIZE(tps6594_common_cells);
+		cells = tps6594_common_cells;
+	}
+
+	irq_chip->irq_drv_data = tps;
+	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
+					dev->driver->name, tps->chip_id, tps->reg);
 
-	if (!tps6594_irq_chip.name)
+	if (!irq_chip->name)
 		return -ENOMEM;
 
 	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
-				       0, &tps6594_irq_chip, &tps->irq_data);
+				       0, irq_chip, &tps->irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add regmap IRQ\n");
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, tps6594_common_cells,
-				   ARRAY_SIZE(tps6594_common_cells), NULL, 0,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cells, NULL, 0,
 				   regmap_irq_get_domain(tps->irq_data));
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add common child devices\n");
 
-	/* No RTC for LP8764 */
-	if (tps->chip_id != LP8764) {
+	/* No RTC for LP8764 and TPS65224 */
+	if (tps->chip_id != LP8764 && tps->chip_id != TPS65224) {
 		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, tps6594_rtc_cells,
 					   ARRAY_SIZE(tps6594_rtc_cells), NULL, 0,
 					   regmap_irq_get_domain(tps->irq_data));
@@ -465,5 +665,6 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 EXPORT_SYMBOL_GPL(tps6594_device_init);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_AUTHOR("Bhargav Raviprakash <bhargav.r@ltts.com");
 MODULE_DESCRIPTION("TPS6594 Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1


