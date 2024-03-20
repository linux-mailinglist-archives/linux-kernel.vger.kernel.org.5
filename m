Return-Path: <linux-kernel+bounces-108742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A72880F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE0EB22F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3823CF51;
	Wed, 20 Mar 2024 10:15:26 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBE2A1B2;
	Wed, 20 Mar 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929726; cv=none; b=AzS8Sm7POeYHjPp2ZMJhWfWMOmGk25ziuYJP1izCnxLF++lCy2gf7544/Ew6N6OoXNVQH45xApJqF7FMcfqwxCgNms4oZJ3L1XWoKc6XIzWq22fW0hjAD4KmUxh544osMNb/9h4+vrNXKf8NhA4uIc2e8ZRqLa8SuxG+wamz/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929726; c=relaxed/simple;
	bh=zfDLbqWgOH8d1+adp9RxEyhJRbc2lOUnCC4kwPqZ5qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LseY4B1DSI2HDsGmJvjolHjO3up1hhZe0RzxKRh6ISLGP/NPDKrimwnNCTIEIzVbzSkN7eqzNluqnV1b0rson5F93gvUOpKz0lBndnhoxdun03w6kEqyKKrWYRitXynXllfUQBfIVy1ry4XzBIA0p96Zz9h0Zbrv41jvou5Anpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: oQrzJEPhxgP8uSFlXa+okPvyeBYCfJjsBKwDc4F+mjozrIdneuUGtuGjWkX3CLcm3b42JOf9Tz
 bIziGp9kJiug==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 20 Mar 2024 15:44:07 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: jpanis@baylibre.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	eblanc@baylibre.com,
	gregkh@linuxfoundation.org,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v3 01/11] mfd: tps6594: Add register definitions for TI TPS65224 PMIC
Date: Wed, 20 Mar 2024 15:43:54 +0530
Message-Id: <20240320101354.463936-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <44295772-4635-42c2-b7b5-cdc37505715e@baylibre.com>
References: <44295772-4635-42c2-b7b5-cdc37505715e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Fri, 8 Mar 2024 12:24:40 +0100, Julien wrote:
> On 3/8/24 11:34, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> >
> > Extend TPS6594 PMIC register and field definitions to support TPS65224
> > power management IC.
> >
> > TPS65224 is software compatible to TPS6594 and can re-use many of the
> > same definitions, new definitions are added to support additional
> > controls available on TPS65224.
> >
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> > ---
> >   include/linux/mfd/tps6594.h | 354 ++++++++++++++++++++++++++++++++++--
> >   1 file changed, 342 insertions(+), 12 deletions(-)
> 
> [...]
> 
> > +/* IRQs */
> > +enum tps65224_irqs {
> > +	/* INT_BUCK register */
> > +	TPS65224_IRQ_BUCK1_UVOV,
> > +	TPS65224_IRQ_BUCK2_UVOV,
> > +	TPS65224_IRQ_BUCK3_UVOV,
> > +	TPS65224_IRQ_BUCK4_UVOV,
> > +	/* INT_LDO_VMON register */
> > +	TPS65224_IRQ_LDO1_UVOV,
> > +	TPS65224_IRQ_LDO2_UVOV,
> > +	TPS65224_IRQ_LDO3_UVOV,
> > +	TPS65224_IRQ_VCCA_UVOV,
> > +	TPS65224_IRQ_VMON1_UVOV,
> > +	TPS65224_IRQ_VMON2_UVOV,
> > +	/* INT_GPIO register */
> > +	TPS65224_IRQ_GPIO1,
> > +	TPS65224_IRQ_GPIO2,
> > +	TPS65224_IRQ_GPIO3,
> > +	TPS65224_IRQ_GPIO4,
> > +	TPS65224_IRQ_GPIO5,
> > +	TPS65224_IRQ_GPIO6,
> > +	/* INT_STARTUP register */
> > +	TPS65224_IRQ_VSENSE,
> > +	TPS65224_IRQ_ENABLE,
> > +	TPS65224_IRQ_PB_SHORT,
> > +	TPS65224_IRQ_FSD,
> > +	TPS65224_IRQ_SOFT_REBOOT,
> > +	/* INT_MISC register */
> > +	TPS65224_IRQ_BIST_PASS,
> > +	TPS65224_IRQ_EXT_CLK,
> > +	TPS65224_IRQ_REG_UNLOCK,
> > +	TPS65224_IRQ_TWARN,
> > +	TPS65224_IRQ_PB_LONG,
> > +	TPS65224_IRQ_PB_FALL,
> > +	TPS65224_IRQ_PB_RISE,
> > +	TPS65224_IRQ_ADC_CONV_READY,
> > +	/* INT_MODERATE_ERR register */
> > +	TPS65224_IRQ_TSD_ORD,
> > +	TPS65224_IRQ_BIST_FAIL,
> > +	TPS65224_IRQ_REG_CRC_ERR,
> > +	TPS65224_IRQ_RECOV_CNT,
> > +	/* INT_SEVERE_ERR register */
> > +	TPS65224_IRQ_TSD_IMM,
> > +	TPS65224_IRQ_VCCA_OVP,
> > +	TPS65224_IRQ_PFSM_ERR,
> > +	TPS65224_IRQ_BG_XMON,
> > +	/* INT_FSM_ERR register */
> > +	TPS65224_IRQ_IMM_SHUTDOWN,
> > +	TPS65224_IRQ_ORD_SHUTDOWN,
> > +	TPS65224_IRQ_MCU_PWR_ERR,
> > +	TPS65224_IRQ_SOC_PWR_ERR,
> > +	TPS65224_IRQ_COMM_ERR,
> > +	TPS65224_IRQ_I2C2_ERR,
> > +	/* INT_ESM register */
> > +	TPS65224_IRQ_ESM_MCU_PIN,
> > +	TPS65224_IRQ_ESM_MCU_FAIL,
> > +	TPS65224_IRQ_ESM_MCU_RST,
> 
> You should remove the 3 lines above for ESM_MCU, since there is none
> linux driver for ESM_MCU.
> 
> > +};
> > +
> > +#define TPS65224_IRQ_NAME_BUCK1_UVOV		"buck1_uvov"
> > +#define TPS65224_IRQ_NAME_BUCK2_UVOV		"buck2_uvov"
> > +#define TPS65224_IRQ_NAME_BUCK3_UVOV		"buck3_uvov"
> > +#define TPS65224_IRQ_NAME_BUCK4_UVOV		"buck4_uvov"
> > +#define TPS65224_IRQ_NAME_LDO1_UVOV		"ldo1_uvov"
> > +#define TPS65224_IRQ_NAME_LDO2_UVOV		"ldo2_uvov"
> > +#define TPS65224_IRQ_NAME_LDO3_UVOV		"ldo3_uvov"
> > +#define TPS65224_IRQ_NAME_VCCA_UVOV		"vcca_uvov"
> > +#define TPS65224_IRQ_NAME_VMON1_UVOV		"vmon1_uvov"
> > +#define TPS65224_IRQ_NAME_VMON2_UVOV		"vmon2_uvov"
> > +#define TPS65224_IRQ_NAME_GPIO1			"gpio1"
> > +#define TPS65224_IRQ_NAME_GPIO2			"gpio2"
> > +#define TPS65224_IRQ_NAME_GPIO3			"gpio3"
> > +#define TPS65224_IRQ_NAME_GPIO4			"gpio4"
> > +#define TPS65224_IRQ_NAME_GPIO5			"gpio5"
> > +#define TPS65224_IRQ_NAME_GPIO6			"gpio6"
> > +#define TPS65224_IRQ_NAME_VSENSE	        "vsense"
> > +#define TPS65224_IRQ_NAME_ENABLE		"enable"
> > +#define TPS65224_IRQ_NAME_PB_SHORT		"pb_short"
> > +#define TPS65224_IRQ_NAME_FSD			"fsd"
> > +#define TPS65224_IRQ_NAME_SOFT_REBOOT		"soft_reboot"
> > +#define TPS65224_IRQ_NAME_BIST_PASS		"bist_pass"
> > +#define TPS65224_IRQ_NAME_EXT_CLK		"ext_clk"
> > +#define TPS65224_IRQ_NAME_REG_UNLOCK		"reg_unlock"
> > +#define TPS65224_IRQ_NAME_TWARN			"twarn"
> > +#define TPS65224_IRQ_NAME_PB_LONG		"pb_long"
> > +#define TPS65224_IRQ_NAME_PB_FALL		"pb_fall"
> > +#define TPS65224_IRQ_NAME_PB_RISE		"pb_rise"
> > +#define TPS65224_IRQ_NAME_ADC_CONV_READY	"adc_conv_ready"
> > +#define TPS65224_IRQ_NAME_TSD_ORD		"tsd_ord"
> > +#define TPS65224_IRQ_NAME_BIST_FAIL		"bist_fail"
> > +#define TPS65224_IRQ_NAME_REG_CRC_ERR		"reg_crc_err"
> > +#define TPS65224_IRQ_NAME_RECOV_CNT		"recov_cnt"
> > +#define TPS65224_IRQ_NAME_TSD_IMM		"tsd_imm"
> > +#define TPS65224_IRQ_NAME_VCCA_OVP		"vcca_ovp"
> > +#define TPS65224_IRQ_NAME_PFSM_ERR		"pfsm_err"
> > +#define TPS65224_IRQ_NAME_BG_XMON		"bg_xmon"
> > +#define TPS65224_IRQ_NAME_IMM_SHUTDOWN		"imm_shutdown"
> > +#define TPS65224_IRQ_NAME_ORD_SHUTDOWN		"ord_shutdown"
> > +#define TPS65224_IRQ_NAME_MCU_PWR_ERR		"mcu_pwr_err"
> > +#define TPS65224_IRQ_NAME_SOC_PWR_ERR		"soc_pwr_err"
> > +#define TPS65224_IRQ_NAME_COMM_ERR		"comm_err"
> > +#define TPS65224_IRQ_NAME_I2C2_ERR		"i2c2_err"
> > +#define TPS65224_IRQ_NAME_ESM_MCU_PIN		"esm_mcu_pin"
> > +#define TPS65224_IRQ_NAME_ESM_MCU_FAIL		"esm_mcu_fail"
> > +#define TPS65224_IRQ_NAME_ESM_MCU_RST		"esm_mcu_rst"
> 
> You should remove the 3 lines above for ESM_MCU.
> 
> Julien

Thanks! will get it done in the next version.

Regards,
Bhargav

