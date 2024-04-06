Return-Path: <linux-kernel+bounces-133953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4A89AB5F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1905B1C20D91
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A92E84E;
	Sat,  6 Apr 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iv76KWbq"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E41E4B1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414262; cv=none; b=guF+3BLdWXloGfvy8eXjUAPbwBuU3KZfevVqFQaYw9A6WxV8JJUdfHZLcVAVxRlN8Vm13zXOk/8qochYNos0oraXr1UsS5OjYFjDVhi+LdZRJEBcHmhpRwWlAGFWQyvDpI9qEEwtisZT94M0wh4XcIZm0aCUOS5XQTakeNiF3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414262; c=relaxed/simple;
	bh=yjTL/ZTuf36w8UTifbBcyVvgMmPk/731lQFJw4Eb2z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by5dcQCA06w1yJod9U4eDrASMDYKFt3TPhjo0hecGMt2vhY8ubXFGx1m/MushmkRBkYqz8fScmYMMcf9o4G2OXuVqAut8jfkJ+e2ydOJsXvSN1x25yBAGWGnKa3/tQWlV+li3XGT1k7dbk6SPPBx9bjF3cSqtlgipEWb6NdJv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iv76KWbq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ddda842c399so3271536276.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712414259; x=1713019059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Mefx1C53IonuCxNMUPhGjeg/dbk1cQUIbCnXqixLs=;
        b=Iv76KWbqzt/BayqECbF8+euQMRi1vGDKF/1eQQNP/dCI36XFNexF46UvpMZhDEW45k
         y388idtVH52PvhCg5OmSac7PERcegLoMVWBPJr5xK6cTWJ4GqIVstUdRb01ygzUo2AJ1
         IafpkSHsoleKUAMVfBx91uhdbvVqy0GkgZ/p659PXkfLwOH3a1iQZTQ3ivMo/RGJ3icd
         xA6jD2FVoJsNs9mY2B9REXJflugyjPzr7Mkxc/sF4aNTWddElkGZhNs+LDnoWmGUHMs2
         DpfjMCSDJkNIBdXrgDtAvTCqQKGpPj4xujeqv6h2MHviZLhHpisTNUIuurFteZBQraPW
         bElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712414259; x=1713019059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8Mefx1C53IonuCxNMUPhGjeg/dbk1cQUIbCnXqixLs=;
        b=hsj2SnBytl454h5pVJc9qBfkEA+r6GL2uWR/oQg2fdx7Q3CcXQ6TMIahPfm/JIov9a
         6VP1AOFV00xkw+niXMUOkuxQq9FRWasnTEY5IGMkWvsDw0wkGxDn94tGOqcH0xRCoi6b
         RCfwvHTiRJObP86/0SwKlE9t6rfS8LbXggmlZ29KhEbbN0hIPGMTSD3NskjCrAZAaIox
         pjwhpuEG7zCfH3iVwBH6sGZNU22u5N4fPCobz2xLz8n6kykoC0NEwZKSJtudhnJ4npYx
         +zzvtS8GqwF41sdC9c+mCHqlGY/JYqGVJavDDnPOPV/veoWNQLWfG0kBqpJJeOGj22do
         HJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh/k/+PwdgQ+US921D/mt6x4bg/dghS47gUP1CrTBZ/55UuL03KXBoJ97mdzqv7xolPNn6jmIyP01qwah7KDuYKXf6hcn8p8rv3wbv
X-Gm-Message-State: AOJu0YznZMH8tBeq0XMBTEOFJUgpEd7Yp9Y5eZPGigqnB1GQiTXg+xQK
	qjeImBCGkSxSS/T9pIJUcCwfZZ0PVbHmDRirz/NtZVwddvR67aSfSl2ElSGL7B5+h/MDGRUDpSY
	44uF/RdaY1J4fpJF+cyYe4H2I7UyKJglZYd+9Cw==
X-Google-Smtp-Source: AGHT+IFf8wiwIOw7VyP41Yux/IOXNoXuXttt8BU0rwH9bAkkpbtahMgHNxEdp20ti4dk+js3ICAp/5hItA5+vNAqyAI=
X-Received: by 2002:a25:6942:0:b0:dc7:42b8:2561 with SMTP id
 e63-20020a256942000000b00dc742b82561mr3803674ybc.34.1712414259392; Sat, 06
 Apr 2024 07:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-6-mr.nuke.me@gmail.com> <ZhEMB0HP0g1YwPvE@matsya>
In-Reply-To: <ZhEMB0HP0g1YwPvE@matsya>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 6 Apr 2024 17:37:28 +0300
Message-ID: <CAA8EJpqYV537aCbkwTRUeZJzcn4wMXFqGxQHSdDFraGV_2zbQQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
To: Vinod Koul <vkoul@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kishon Vijay Abraham I <kishon@kernel.org>, ansuelsmth@gmail.com, 
	robimarko@gmail.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Apr 2024 at 11:47, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 02-04-24, 14:25, Alexandru Gagniuc wrote:
> > Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> > 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> > being reused from IPQ8074 and IPQ6018 PHYs.
> >
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
> >  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
> >  2 files changed, 149 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 8836bb1ff0cc..f07bd27e3b7a 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -487,6 +487,100 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
> >       QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> >  };
> >
> > +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0F),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0F),
>
> Lower case here and everywhere please

For hex values

>
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xFF),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3F),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xAA),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xAB),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xD4),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xA0),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0A),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0A),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xAA),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xA0),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xB4),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
> > +     QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7D),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
> > +     QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0A),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
> > +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0b),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2a),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
> > +     QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> > +};
> > +
> >  static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
> >       QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
> >       QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> > @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
> >
> >  /* list of clocks required by phy */
> >  static const char * const qmp_pciephy_clk_l[] = {
> > -     "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> > +     "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"
>
> How about older platforms which dont have these clocks

The driver uses devm_clk_bulk_get_optional(), so it should be fine.
But the more important question should be why the platform needs
anoc/snoc clocks here.

>
> >  };
> >
> >  /* list of regulators */
> > @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x1 = {
> >       .rx             = 0x0400,
> >  };
> >
> > +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> > +     .serdes         = 0,
> > +     .pcs            = 0x1000,
> > +     .pcs_misc       = 0x1400,
> > +     .tx             = 0x0200,
> > +     .rx             = 0x0400,
> > +     .tx2            = 0x0600,
> > +     .rx2            = 0x0800,
> > +};
> > +
> >  static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
> >       .serdes         = 0,
> >       .pcs            = 0x0a00,
> > @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
> >       .phy_status             = PHYSTATUS,
> >  };
> >
> > +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
> > +     .lanes                  = 2,
> > +
> > +     .offsets                = &qmp_pcie_offsets_ipq9574,
> > +
> > +     .tbls = {
> > +             .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
> > +             .serdes_num     = ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> > +             .tx             = ipq8074_pcie_gen3_tx_tbl,
> > +             .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> > +             .rx             = ipq6018_pcie_rx_tbl,
> > +             .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
> > +             .pcs            = ipq6018_pcie_pcs_tbl,
> > +             .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
> > +             .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
> > +             .pcs_misc_num   = ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> > +     },
> > +     .reset_list             = ipq8074_pciephy_reset_l,
> > +     .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
> > +     .vreg_list              = NULL,
> > +     .num_vregs              = 0,
> > +     .regs                   = pciephy_v4_regs_layout,
> > +
> > +     .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> > +     .phy_status             = PHYSTATUS,
> > +};
> > +
> >  static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
> >       .lanes                  = 2,
> >
> > @@ -3935,6 +4066,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
> >       }, {
> >               .compatible = "qcom,ipq8074-qmp-pcie-phy",
> >               .data = &ipq8074_pciephy_cfg,
> > +     }, {
> > +             .compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
> > +             .data = &ipq9574_pciephy_gen3x2_cfg,
> >       }, {
> >               .compatible = "qcom,msm8998-qmp-pcie-phy",
> >               .data = &msm8998_pciephy_cfg,
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> > index a469ae2a10a1..fa15a03055de 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> > @@ -11,8 +11,22 @@
> >  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2         0x0c
> >  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4         0x14
> >  #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE               0x20
> > +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L       0x44
> > +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H       0x48
> > +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L       0x4c
> > +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H       0x50
> >  #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1         0x54
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1            0x5c
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2            0x60
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4            0x68
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2              0x7c
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4              0x84
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5              0x88
> > +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6              0x8c
> >  #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS            0x94
> > +#define QPHY_V5_PCS_PCIE_EQ_CONFIG1                  0xa4
> >  #define QPHY_V5_PCS_PCIE_EQ_CONFIG2                  0xa8
> > +#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE                      0xc0
> > +#define QPHY_V5_PCS_PCIE_PRESET_P10_POST             0xe4
> >
> >  #endif
> > --
> > 2.40.1
>
> --
> ~Vinod
>


-- 
With best wishes
Dmitry

