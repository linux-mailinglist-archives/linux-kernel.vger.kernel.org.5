Return-Path: <linux-kernel+bounces-118220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756C788B682
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEECFB2AA35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B818E1E;
	Tue, 26 Mar 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rsf453z1"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E21B28D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413721; cv=none; b=m9L/HJSTfMw4SNhi+7OCswaiOhuDxjPYPvR14nxgpLj/4wXbZFAcSwLaMLmUginW1xGoQr6CXRZl/hbS2nBaR8rV0uKMAOyvW3jge/FjU3fwv7n8xIyzGnqoNu765cgzlByPLJ7Hz6SmUG9/uYptfNby36Q2OVgcjBy2cIc0n8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413721; c=relaxed/simple;
	bh=QVsSkNt9pgnUMPhWE69+PeK+7XEnYUycjIycH8MVul8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L2NF5MFElYAQIY2j4Lvt9wnwzeud/B/GpPo3UWlP9ND9wx36nA5KfG0uiGzlCNuW18jXI3RuWOhYYQu76U9hG3ArUkHAXc042u30viRYcJh2pKgHRyCMPfX1yzRdL7RjLcfbwpffko/EpKFR8fCjz8GbGL3f7veR7rtvHtIU0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rsf453z1; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E2F41120002;
	Tue, 26 Mar 2024 03:41:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E2F41120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711413715;
	bh=GUwFIrijniX6tWOtmBIV4uX2Els9gfR5OyRHtM8oZJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=rsf453z1Okw4SLnv2UFa+1Weco2QHBe2yDbrtP00RdTiCVOmnVFydSkjL3l0kUZ8G
	 9TTa9lIBfD7+rnABLNRsBZXFmdht3xC1gx4zLM3kZme6rKB63HzyRbVj0rXT7JXmYH
	 quGOHeulx6YlFrQenBr/sXUcQK63nogixUBc5XMWDhrQTO3urtv//VQ6OlqTLF3rhd
	 9oobc8gzKZHCrm04Ype9lxwbBCcNcsWRah0Q+TI0iMRYQeyGxTbxCLEHOMxsf7jn46
	 yjntfmqemFh6i2zU8ovDNlnzFFmdA4mOkC/AjpG1XLmeLLfVjh0Lmhi50TFs3V5d+i
	 AD198bynLVz7A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 03:41:55 +0300 (MSK)
Received: from [172.28.66.90] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 03:41:55 +0300
Message-ID: <37cb9bc9-88c0-4e2b-8f46-0f67b91bc5be@salutedevices.com>
Date: Tue, 26 Mar 2024 03:41:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] iio: adc: meson: consistently use bool/enum in
 struct meson_sar_adc_param
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<neil.armstrong@linaro.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<linux-amlogic@lists.infradead.org>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
 <20240323231309.415425-3-martin.blumenstingl@googlemail.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240323231309.415425-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184404 [Mar 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/25 18:32:00 #24438765
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Martin

On 3/24/24 02:13, Martin Blumenstingl wrote:
> Consistently use bool for any register bit that enables/disables
> functionality and enum for register values where there's a choice
> between different settings. The aim is to make the code easier to read
> and understand by being more consistent. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/iio/adc/meson_saradc.c | 47 +++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2615d74534df..6b2af0c2bbc7 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -156,9 +156,9 @@
>   #define MESON_SAR_ADC_REG11					0x2c
>   	#define MESON_SAR_ADC_REG11_BANDGAP_EN			BIT(13)
>   	#define MESON_SAR_ADC_REG11_CMV_SEL                     BIT(6)
> -	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE                BIT(5)
> -	#define MESON_SAR_ADC_REG11_EOC                         BIT(1)
> -	#define MESON_SAR_ADC_REG11_VREF_SEL                    BIT(0)
> +	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE		BIT(5)
> +	#define MESON_SAR_ADC_REG11_EOC				BIT(1)
> +	#define MESON_SAR_ADC_REG11_VREF_SEL			BIT(0)
>   
>   #define MESON_SAR_ADC_REG13					0x34
>   	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
> @@ -224,6 +224,11 @@ enum meson_sar_adc_vref_sel {
>   	VREF_VDDA = 1,
>   };
>   
> +enum meson_sar_adc_vref_voltage {
> +	VREF_VOLTAGE_0V9 = 0,
> +	VREF_VOLTAGE_1V8 = 1,
> +};
> +
>   enum meson_sar_adc_avg_mode {
>   	NO_AVERAGING = 0x0,
>   	MEAN_AVERAGING = 0x1,
> @@ -321,13 +326,13 @@ struct meson_sar_adc_param {
>   	u8					temperature_trimming_bits;
>   	unsigned int				temperature_multiplier;
>   	unsigned int				temperature_divider;
> -	u8					disable_ring_counter;
> +	bool					disable_ring_counter;
>   	bool					has_reg11;
>   	bool					has_vref_select;
> -	u8					vref_select;
> -	u8					cmv_select;
> -	u8					adc_eoc;


The reason to choose u8 type over bool was that those are not actually
bool values but direct values of hw register bits. We have little 
information about real meaning of these bits so it won't help much to
add bool layer and keep real values in the init code instead of param 
section (adc_eoc, cmv_select).
bool disable_ring_counter will look deceptive too because it doesn't
say whether disable ring_counter or not (we always disable it) but
how to disable it (write 0 or 1)

I think the poor choice was not the type of variables but their names:
u8 adc_eoc_bit;
u8 cmv_select_bit;
u8 disable_ring_counter_bit;

would be clearer.


> -	enum meson_sar_adc_vref_sel		vref_voltage;
> +	bool					cmv_select;
> +	bool					adc_eoc;
> +	enum meson_sar_adc_vref_sel		vref_select;
> +	enum meson_sar_adc_vref_voltage		vref_voltage;
>   };
>   
>   struct meson_sar_adc_data {
> @@ -982,14 +987,16 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>   				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
>   	}
>   
> -	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
> -			    priv->param->disable_ring_counter);
> +	if (priv->param->disable_ring_counter)
> +		regval = MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN;
> +	else
> +		regval = 0;
>   	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>   			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
>   			   regval);
>   
>   	if (priv->param->has_reg11) {
> -		regval = FIELD_PREP(MESON_SAR_ADC_REG11_EOC, priv->param->adc_eoc);
> +		regval = priv->param->adc_eoc ? MESON_SAR_ADC_REG11_EOC : 0;
>   		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>   				   MESON_SAR_ADC_REG11_EOC, regval);
>   
> @@ -1005,8 +1012,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>   		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>   				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
>   
> -		regval = FIELD_PREP(MESON_SAR_ADC_REG11_CMV_SEL,
> -				    priv->param->cmv_select);
> +		regval = priv->param->cmv_select ? MESON_SAR_ADC_REG11_CMV_SEL : 0;
>   		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>   				   MESON_SAR_ADC_REG11_CMV_SEL, regval);
>   	}
> @@ -1225,8 +1231,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
>   	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>   	.resolution = 10,
>   	.has_reg11 = true,
> -	.vref_voltage = 1,
> -	.cmv_select = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
> +	.cmv_select = true,
>   };
>   
>   static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
> @@ -1237,8 +1243,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>   	.resolution = 12,
>   	.disable_ring_counter = 1,
>   	.has_reg11 = true,
> -	.vref_voltage = 1,
> -	.cmv_select = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
> +	.cmv_select = true,
>   };
>   
>   static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> @@ -1249,10 +1255,10 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
>   	.resolution = 12,
>   	.disable_ring_counter = 1,
>   	.has_reg11 = true,
> -	.vref_voltage = 1,
> +	.vref_voltage = VREF_VOLTAGE_1V8,
>   	.has_vref_select = true,
>   	.vref_select = VREF_VDDA,
> -	.cmv_select = 1,
> +	.cmv_select = true,
>   };
>   
>   static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
> @@ -1263,7 +1269,8 @@ static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>   	.resolution = 12,
>   	.disable_ring_counter = 1,
>   	.has_reg11 = true,
> -	.adc_eoc = 1,
> +	.vref_voltage = VREF_VOLTAGE_0V9,
> +	.adc_eoc = true,
>   	.has_vref_select = true,
>   	.vref_select = VREF_VDDA,
>   };

-- 
Best regards
George

