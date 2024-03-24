Return-Path: <linux-kernel+bounces-112706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69E887D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABCB1C20B62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9F18037;
	Sun, 24 Mar 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKtBRc8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14717C98
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289291; cv=none; b=QgCf2ibSRLdjj/buqMEBtGJeItffdb9c/sws43uLiKhQTIYxa/NEhL5OIs/tjgtjFjHbqAm1BVUbpG8gGq2tjOodZR3WesJyB0flWw1MbZ3XMp/jeLPtsMSyb3G5gzZ7bTVosemkjmjVF4S/gBltA7ADXaz5XEuuBNrpBDjHrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289291; c=relaxed/simple;
	bh=6V3Q2RdPQIrSAxzAaeNyfPw/spOm0CyhaOieNGwfiPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZIX2HZnEH4xVR8yVy+RJmM0xcUfoykjep2yIWEs+m5yjP9C0Lk/l1/f+SgsmsS/oy9hTGbIAXRTBwdwZgy37encSJEcEB98QH8kRcAno3YarlkXsfk01pMb131GZlyNoF6cLhA+FeUB82no67HUfL+1TSlzarG6AUVp0vVqT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKtBRc8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A31C433F1;
	Sun, 24 Mar 2024 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711289291;
	bh=6V3Q2RdPQIrSAxzAaeNyfPw/spOm0CyhaOieNGwfiPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKtBRc8iosUr0U+8ZjIOeeZM6NYEcNL54k8W66vihoOZED0CUy54F98lN4YU2i5Xf
	 6+0QDjyhnQyVBJB7VK6DVBnmw+OaA+nfA30Id4kb/kecufQA5W+3qKnlZgYoC225AO
	 TCkE/PkONgX3pEfedzaSXDeIxwQ6NS+T/H05W80ulaioEFq2GTDMSixIrUj6SlTA90
	 vNMwECLe/noqZd4i8yaqo7SM23ycH/0s8KUpMn8T2Y08YbgDqC/a2flNxVVCyPk2uZ
	 f/BAiVJOYYdZkETkOyl3naBlJxKTwloPQpYDZrPclADRRAFloIpx1+mDNehde6LV2/
	 aRFpWSv0xo3YA==
Date: Sun, 24 Mar 2024 14:07:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gnstark@salutedevices.com,
 neil.armstrong@linaro.org, lars@metafoo.de
Subject: Re: [PATCH v1 2/3] iio: adc: meson: consistently use bool/enum in
 struct meson_sar_adc_param
Message-ID: <20240324140756.5d001387@jic23-huawei>
In-Reply-To: <20240323231309.415425-3-martin.blumenstingl@googlemail.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
	<20240323231309.415425-3-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Mar 2024 00:13:08 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Consistently use bool for any register bit that enables/disables
> functionality and enum for register values where there's a choice
> between different settings. The aim is to make the code easier to read
> and understand by being more consistent. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 47 +++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2615d74534df..6b2af0c2bbc7 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -156,9 +156,9 @@
>  #define MESON_SAR_ADC_REG11					0x2c
>  	#define MESON_SAR_ADC_REG11_BANDGAP_EN			BIT(13)
>  	#define MESON_SAR_ADC_REG11_CMV_SEL                     BIT(6)
> -	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE                BIT(5)
> -	#define MESON_SAR_ADC_REG11_EOC                         BIT(1)
> -	#define MESON_SAR_ADC_REG11_VREF_SEL                    BIT(0)
> +	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE		BIT(5)
> +	#define MESON_SAR_ADC_REG11_EOC				BIT(1)
> +	#define MESON_SAR_ADC_REG11_VREF_SEL			BIT(0)

Looks like a spaces to tab conversion.  Not related to rest of patch so
put them back as spaces.  If you really want to tidy that up with tabs
later, separate patch please.

Otherwise LGTM

>  
>  #define MESON_SAR_ADC_REG13					0x34
>  	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
> @@ -224,6 +224,11 @@ enum meson_sar_adc_vref_sel {
>  	VREF_VDDA = 1,
>  };
>  
> +enum meson_sar_adc_vref_voltage {
> +	VREF_VOLTAGE_0V9 = 0,
> +	VREF_VOLTAGE_1V8 = 1,
> +};
> +
>  enum meson_sar_adc_avg_mode {
>  	NO_AVERAGING = 0x0,
>  	MEAN_AVERAGING = 0x1,
> @@ -321,13 +326,13 @@ struct meson_sar_adc_param {
>  	u8					temperature_trimming_bits;
>  	unsigned int				temperature_multiplier;
>  	unsigned int				temperature_divider;
> -	u8					disable_ring_counter;
> +	bool					disable_ring_counter;
>  	bool					has_reg11;
>  	bool					has_vref_select;
> -	u8					vref_select;
> -	u8					cmv_select;
> -	u8					adc_eoc;
> -	enum meson_sar_adc_vref_sel		vref_voltage;
> +	bool					cmv_select;
> +	bool					adc_eoc;
> +	enum meson_sar_adc_vref_sel		vref_select;
> +	enum meson_sar_adc_vref_voltage		vref_voltage;
>  };
>  
>  struct meson_sar_adc_data {
> @@ -982,14 +987,16 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
>  	}
>  
> -	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
> -			    priv->param->disable_ring_counter);
> +	if (priv->param->disable_ring_counter)
> +		regval = MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN;
> +	else
> +		regval = 0;
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>  			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
>  			   regval);
>  
>  	if (priv->param->has_reg11) {
> -		regval = FIELD_PREP(MESON_SAR_ADC_REG11_EOC, priv->param->adc_eoc);
> +		regval = priv->param->adc_eoc ? MESON_SAR_ADC_REG11_EOC : 0;
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>  				   MESON_SAR_ADC_REG11_EOC, regval);
>  
> @@ -1005,8 +1012,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>  				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
>  
> -		regval = FIELD_PREP(MESON_SAR_ADC_REG11_CMV_SEL,
> -				    priv->param->cmv_select);
> +		regval = priv->param->cmv_select ? MESON_SAR_ADC_REG11_CMV_SEL : 0;
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>  				   MESON_SAR_ADC_REG11_CMV_SEL, regval);
>  	}
> @@ -1225,8 +1231,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
>  	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>  	.resolution = 10,
>  	.has_reg11 = true,
> -	.vref_voltage = 1,
> -	.cmv_select = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
> +	.cmv_select = true,
>  };
>  
>  static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
> @@ -1237,8 +1243,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>  	.resolution = 12,
>  	.disable_ring_counter = 1,
>  	.has_reg11 = true,
> -	.vref_voltage = 1,
> -	.cmv_select = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
> +	.cmv_select = true,
>  };
>  
>  static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> @@ -1249,10 +1255,10 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
>  	.resolution = 12,
>  	.disable_ring_counter = 1,
>  	.has_reg11 = true,
> -	.vref_voltage = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
>  	.has_vref_select = true,
>  	.vref_select = VREF_VDDA,
> -	.cmv_select = 1,
> +	.cmv_select = true,
>  };
>  
>  static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
> @@ -1263,7 +1269,8 @@ static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>  	.resolution = 12,
>  	.disable_ring_counter = 1,
>  	.has_reg11 = true,
> -	.adc_eoc = 1,
> +	.vref_voltage = VREF_VOLTAGE_0V9,
> +	.adc_eoc = true,
>  	.has_vref_select = true,
>  	.vref_select = VREF_VDDA,
>  };


