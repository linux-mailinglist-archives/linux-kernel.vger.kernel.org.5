Return-Path: <linux-kernel+bounces-47752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709484525D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC02F1C236F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD89158D81;
	Thu,  1 Feb 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWqZe4sP"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7B1586D3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774858; cv=none; b=VbdsrqxBlKvxMxSL+JTyEkL9eCXoH03JY7R+grTq+cpaohWIvqJa01Sll65toKrJGlzohkBwQMJvOEuwq0vaLrl8ILEFFq1/DtlfdkCFwABpdcBWXo/GNxxNVD51DbsCrc5nr439pWMxXRJ+jmaurQDBiBeGAOkT+SETfdHZDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774858; c=relaxed/simple;
	bh=sb5qYpUob31qciMfj8+LxWNDzKybEkRj04oi2nYf3DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmyky5UwN7JrvU404XTXEnrMa7E98NUCQnFRfMJnD9/pXYuBjMKBRXfRqRLpJfQ3LRT0TpL3Dk3cgS2sYilSKs1MIyilvPOb6R9HGopYiC8MG9enNMSFGEyZ8plYPGxO8gfnGhz1K7q8aVfArZIy7GQdN8DKtaaAXE/qv1q5qO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWqZe4sP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55eedf5a284so721247a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706774854; x=1707379654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAvJSpelRjNBFxPj6S/HIO6kCDmVIfmCpRrsUawbjIk=;
        b=eWqZe4sPtK51dCbGet1II7ii0qnA5+RtM/Xv7K3SAOz/wVeLFk2dze40VY6vSIWW3j
         XvStbUDlm4jo/PFjx+UCR73sg6eWJ7V+pjH89zE0/Iha1AZaj82g6hj4fdRq0jTKK5Ke
         pOrYWtuL1I4GosuzokH4z7aWz8y54l5wFdfFCPRigBIbhzVt90PUEiY9yTlfQiK/EkxG
         jR3+AsNdRuzOzkc0mJXQ0PlQW+tJ6lkv6CYcFfxToJqCDXb70o9HN7nA71iG36xupp/y
         qIGdVXPoFqMEwzuy62loNcHI36G/8aDc/pQQOD/EGF16NGaky4LgzyKGlnYiJ+in7xxq
         9jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706774854; x=1707379654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAvJSpelRjNBFxPj6S/HIO6kCDmVIfmCpRrsUawbjIk=;
        b=atwuIb+HgqdMtHgOnQ6PGfEa3jdiBo5c50W0ceAJt0xi2zh0UybbN3zuXmfw7k/ofW
         m3QXFfy8w1WNjkAuivpx6hTilOBQssZ1sKXVbLPK6i43zMDv0j/u+fDQ9oPFipb9imQa
         dPkQ1ODXhFtrl5iwtnznN4Yq9DxJqZANXAb/oK9mptpNlKeVmyaRxJznW1ITz6Fujx6C
         PT1cVHpI++T/UT2sz5uAXUy0X2fpAEMG1Vxv1um0GRecdG3qL3iT6MoxaOqCZscP9Swd
         DKtI1KZ2dUJGiijBr648N8Sry86pOFRBY9O2DySzMRGL5GKRONuvmZL42DUEGDoAxQh+
         mCGg==
X-Gm-Message-State: AOJu0YzP+crbtZQ+lWP9z7oi6YZ8WvIbNKqOsSERK7R5N+Hu2FrOdeON
	8t2rQisK1LAgXK5/h6aLhEPFs+Qtuek//GBPHvb5COsm7L2QNRTIL0ul4BptkcA=
X-Google-Smtp-Source: AGHT+IED6stdxmgsD+YTTsOO5XS3/6oJ9tH7HJkgFoxi9vMKAziwOyBNDzzBe13AJthKGKMJ3rlTuA==
X-Received: by 2002:a17:906:b58:b0:a36:c8d4:1a40 with SMTP id v24-20020a1709060b5800b00a36c8d41a40mr433755ejg.59.1706774854381;
        Thu, 01 Feb 2024 00:07:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxg5dW9vulv1nU7F96ku8R+qUO0EfwU9sCZGHo5UiJTuLdlr8h474+XD+V7lgDfLLvMn7QslCrLxoMyPxlol0JaFnqwZLx6pJAqlxbt9pZvvZwvR+j3+O5tslnVgPMQ8YCeIXRyOcEhcRPYn+gKu8fkIadXskbPVJ2uWC7k7gvBj14E2ABc8k6//TkOsVpojW/yqyovi713VaZ/vuPORT8YIv9IWkqc5Z+nNECp2KAnCquw26bJy7bdp+Nisg/H7JC0Lhd0hz5IB5DslMVHJEY49QMRZmcYvnuTDjE9PnezBARuc6J+w==
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tx18-20020a1709078e9200b00a3604597618sm2957289ejc.178.2024.02.01.00.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:07:32 -0800 (PST)
Date: Thu, 1 Feb 2024 10:07:31 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
Message-ID: <ZbtRQ9BHfQJgyi33@linaro.org>
References: <20240129-phy-qcom-eusb2-repeater-fixes-v3-1-9a61ef3490de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-phy-qcom-eusb2-repeater-fixes-v3-1-9a61ef3490de@linaro.org>

On 24-01-29 15:03:24, Abel Vesa wrote:
> The device match config init table already has zero values, so rework
> the container struct to hold a copy of the init table that can be
> override be the DT specified values. By doing this, only the number of
> vregs remain in the device match config that will be later needed, so
> instead of holding the cfg after probe, store the number of vregs in the
> container struct.
> 

I'll have to respin this as the commit message needs updating.

> Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v3:
> - Reworked so that it uses base + reg-index.
> - Link to v2: https://lore.kernel.org/r/20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org
> 
> Changes in v2:
> - The regfields is being dropped from the repeater init, but it's done
>   in the second patch in order to not break bisectability, as it is
>   still needed by the zero-out loop.
> - Added Konrad's R-b tag to the first patch. Did not add Elliot's T-b
>   tag as the second patch has been reworked massively.
> - The zero-out loop is dropped now by holding a copy of the init_tlb in
>   the container struct. This led to dropping the cfg from the container
>   struct (see second patch commit message for more details).
> - Link to v1: https://lore.kernel.org/r/20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 166 +++++++++----------------
>  1 file changed, 62 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index a623f092b11f..a43e20abb10d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -37,56 +37,28 @@
>  #define EUSB2_TUNE_EUSB_EQU		0x5A
>  #define EUSB2_TUNE_EUSB_HS_COMP_CUR	0x5B
>  
> -#define QCOM_EUSB2_REPEATER_INIT_CFG(r, v)	\
> -	{					\
> -		.reg = r,			\
> -		.val = v,			\
> -	}
> -
> -enum reg_fields {
> -	F_TUNE_EUSB_HS_COMP_CUR,
> -	F_TUNE_EUSB_EQU,
> -	F_TUNE_EUSB_SLEW,
> -	F_TUNE_USB2_HS_COMP_CUR,
> -	F_TUNE_USB2_PREEM,
> -	F_TUNE_USB2_EQU,
> -	F_TUNE_USB2_SLEW,
> -	F_TUNE_SQUELCH_U,
> -	F_TUNE_HSDISC,
> -	F_TUNE_RES_FSDIF,
> -	F_TUNE_IUSB2,
> -	F_TUNE_USB2_CROSSOVER,
> -	F_NUM_TUNE_FIELDS,
> -
> -	F_FORCE_VAL_5 = F_NUM_TUNE_FIELDS,
> -	F_FORCE_EN_5,
> -
> -	F_EN_CTL1,
> -
> -	F_RPTR_STATUS,
> -	F_NUM_FIELDS,
> -};
> -
> -static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
> -	[F_TUNE_EUSB_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_EUSB_HS_COMP_CUR, 0, 1),
> -	[F_TUNE_EUSB_EQU] = REG_FIELD(EUSB2_TUNE_EUSB_EQU, 0, 1),
> -	[F_TUNE_EUSB_SLEW] = REG_FIELD(EUSB2_TUNE_EUSB_SLEW, 0, 1),
> -	[F_TUNE_USB2_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_USB2_HS_COMP_CUR, 0, 1),
> -	[F_TUNE_USB2_PREEM] = REG_FIELD(EUSB2_TUNE_USB2_PREEM, 0, 2),
> -	[F_TUNE_USB2_EQU] = REG_FIELD(EUSB2_TUNE_USB2_EQU, 0, 1),
> -	[F_TUNE_USB2_SLEW] = REG_FIELD(EUSB2_TUNE_USB2_SLEW, 0, 1),
> -	[F_TUNE_SQUELCH_U] = REG_FIELD(EUSB2_TUNE_SQUELCH_U, 0, 2),
> -	[F_TUNE_HSDISC] = REG_FIELD(EUSB2_TUNE_HSDISC, 0, 2),
> -	[F_TUNE_RES_FSDIF] = REG_FIELD(EUSB2_TUNE_RES_FSDIF, 0, 2),
> -	[F_TUNE_IUSB2] = REG_FIELD(EUSB2_TUNE_IUSB2, 0, 3),
> -	[F_TUNE_USB2_CROSSOVER] = REG_FIELD(EUSB2_TUNE_USB2_CROSSOVER, 0, 2),
> -
> -	[F_FORCE_VAL_5] = REG_FIELD(EUSB2_FORCE_VAL_5, 0, 7),
> -	[F_FORCE_EN_5] = REG_FIELD(EUSB2_FORCE_EN_5, 0, 7),
> -
> -	[F_EN_CTL1] = REG_FIELD(EUSB2_EN_CTL1, 0, 7),
> -
> -	[F_RPTR_STATUS] = REG_FIELD(EUSB2_RPTR_STATUS, 0, 7),
> +enum eusb2_reg_layout {
> +	TUNE_EUSB_HS_COMP_CUR,
> +	TUNE_EUSB_EQU,
> +	TUNE_EUSB_SLEW,
> +	TUNE_USB2_HS_COMP_CUR,
> +	TUNE_USB2_PREEM,
> +	TUNE_USB2_EQU,
> +	TUNE_USB2_SLEW,
> +	TUNE_SQUELCH_U,
> +	TUNE_HSDISC,
> +	TUNE_RES_FSDIF,
> +	TUNE_IUSB2,
> +	TUNE_USB2_CROSSOVER,
> +	NUM_TUNE_FIELDS,
> +
> +	FORCE_VAL_5 = NUM_TUNE_FIELDS,
> +	FORCE_EN_5,
> +
> +	EN_CTL1,
> +
> +	RPTR_STATUS,
> +	LAYOUT_SIZE,
>  };
>  
>  struct eusb2_repeater_cfg {
> @@ -98,10 +70,11 @@ struct eusb2_repeater_cfg {
>  
>  struct eusb2_repeater {
>  	struct device *dev;
> -	struct regmap_field *regs[F_NUM_FIELDS];
> +	struct regmap *regmap;
>  	struct phy *phy;
>  	struct regulator_bulk_data *vregs;
>  	const struct eusb2_repeater_cfg *cfg;
> +	u32 base;
>  	enum phy_mode mode;
>  };
>  
> @@ -109,10 +82,10 @@ static const char * const pm8550b_vreg_l[] = {
>  	"vdd18", "vdd3",
>  };
>  
> -static const u32 pm8550b_init_tbl[F_NUM_TUNE_FIELDS] = {
> -	[F_TUNE_IUSB2] = 0x8,
> -	[F_TUNE_SQUELCH_U] = 0x3,
> -	[F_TUNE_USB2_PREEM] = 0x5,
> +static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
> +	[TUNE_IUSB2] = 0x8,
> +	[TUNE_SQUELCH_U] = 0x3,
> +	[TUNE_USB2_PREEM] = 0x5,
>  };
>  
>  static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
> @@ -140,47 +113,42 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
>  
>  static int eusb2_repeater_init(struct phy *phy)
>  {
> -	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
>  	struct device_node *np = rptr->dev->of_node;
> -	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
> -	u8 override;
> +	struct regmap *regmap = rptr->regmap;
> +	const u32 *init_tbl = rptr->cfg->init_tbl;
> +	u8 tune_usb2_preem = init_tbl[TUNE_USB2_PREEM];
> +	u8 tune_hsdisc = init_tbl[TUNE_HSDISC];
> +	u8 tune_iusb2 = init_tbl[TUNE_IUSB2];
> +	u32 base = rptr->base;
>  	u32 val;
>  	int ret;
> -	int i;
> +
> +	of_property_read_u8(np, "qcom,tune-usb2-amplitude", &tune_iusb2);
> +	of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &tune_hsdisc);
> +	of_property_read_u8(np, "qcom,tune-usb2-preem", &tune_usb2_preem);
>  
>  	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
>  	if (ret)
>  		return ret;
>  
> -	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
> +	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
>  
> -	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
> -		if (init_tbl[i]) {
> -			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
> -		} else {
> -			/* Write 0 if there's no value set */
> -			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
> -
> -			regmap_field_update_bits(rptr->regs[i], mask, 0);
> -		}
> -	}
> -	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_HS_COMP_CUR, init_tbl[TUNE_EUSB_HS_COMP_CUR]);
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_EQU, init_tbl[TUNE_EUSB_EQU]);
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_SLEW, init_tbl[TUNE_EUSB_SLEW]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_HS_COMP_CUR, init_tbl[TUNE_USB2_HS_COMP_CUR]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_EQU, init_tbl[TUNE_USB2_EQU]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_SLEW, init_tbl[TUNE_USB2_SLEW]);
> +	regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, init_tbl[TUNE_SQUELCH_U]);
> +	regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, init_tbl[TUNE_RES_FSDIF]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_CROSSOVER, init_tbl[TUNE_USB2_CROSSOVER]);
>  
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))
> -		init_tbl[F_TUNE_IUSB2] = override;
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, tune_usb2_preem);
> +	regmap_write(regmap, base + EUSB2_TUNE_HSDISC, tune_hsdisc);
> +	regmap_write(regmap, base + EUSB2_TUNE_IUSB2, tune_iusb2);
>  
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &override))
> -		init_tbl[F_TUNE_HSDISC] = override;
> -
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &override))
> -		init_tbl[F_TUNE_USB2_PREEM] = override;
> -
> -	for (i = 0; i < F_NUM_TUNE_FIELDS; i++)
> -		regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
> -
> -	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
> -					     val, val & RPTR_OK, 10, 5);
> +	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, val, val & RPTR_OK, 10, 5);
>  	if (ret)
>  		dev_err(rptr->dev, "initialization timed-out\n");
>  
> @@ -191,6 +159,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  				   enum phy_mode mode, int submode)
>  {
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +	struct regmap *regmap = rptr->regmap;
> +	u32 base = rptr->base;
>  
>  	switch (mode) {
>  	case PHY_MODE_USB_HOST:
> @@ -199,10 +169,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  		 * per eUSB 1.2 Spec. Below implement software workaround until
>  		 * PHY and controller is fixing seen observation.
>  		 */
> -		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
> -					 F_CLK_19P2M_EN, F_CLK_19P2M_EN);
> -		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
> -					 V_CLK_19P2M_EN, V_CLK_19P2M_EN);
> +		regmap_write(regmap, base + EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
> +		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
>  		break;
>  	case PHY_MODE_USB_DEVICE:
>  		/*
> @@ -211,10 +179,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  		 * repeater doesn't clear previous value due to shared
>  		 * regulators (say host <-> device mode switch).
>  		 */
> -		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
> -					 F_CLK_19P2M_EN, 0);
> -		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
> -					 V_CLK_19P2M_EN, 0);
> +		regmap_write(regmap, base + EUSB2_FORCE_EN_5, 0);
> +		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, 0);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -243,9 +209,8 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
>  	struct device_node *np = dev->of_node;
> -	struct regmap *regmap;
> -	int i, ret;
>  	u32 res;
> +	int ret;
>  
>  	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
>  	if (!rptr)
> @@ -258,22 +223,15 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
>  	if (!rptr->cfg)
>  		return -EINVAL;
>  
> -	regmap = dev_get_regmap(dev->parent, NULL);
> -	if (!regmap)
> +	rptr->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!rptr->regmap)
>  		return -ENODEV;
>  
>  	ret = of_property_read_u32(np, "reg", &res);
>  	if (ret < 0)
>  		return ret;
>  
> -	for (i = 0; i < F_NUM_FIELDS; i++)
> -		eusb2_repeater_tune_reg_fields[i].reg += res;
> -
> -	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
> -					   eusb2_repeater_tune_reg_fields,
> -					   F_NUM_FIELDS);
> -	if (ret)
> -		return ret;
> +	rptr->base = res;
>  
>  	ret = eusb2_repeater_init_vregs(rptr);
>  	if (ret < 0) {
> 
> ---
> base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
> change-id: 20240104-phy-qcom-eusb2-repeater-fixes-c9201113032c
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

