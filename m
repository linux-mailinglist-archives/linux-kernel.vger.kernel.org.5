Return-Path: <linux-kernel+bounces-118180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799D88B585
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB641C3B9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9D84A2A;
	Mon, 25 Mar 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="lTtqT0T+"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA35B5DD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410317; cv=none; b=dltwtuABFUN+7rofW5osCbd/Jc2IXqkXQOMVlP8zCK21j/mPEq/ba4RQP6sdOAKa3y3gHRmYbmpP8b/1jjizAN8XXzkgTld1w9wBHnJtLbZrxyEZHlt7F7glrS5G7gX94IsLq3iXgbGHdw+PDeSz7O1dsVE6/B4tEOjNjw7kwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410317; c=relaxed/simple;
	bh=0nJsvdEI0ElcnuBUHb7s/AXeEmkB1YCmJiMzxMcCo5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZTvQ2tLDGFqhu11+iO7P/ALGc4EFM6hJ38YU1y0IEht+SgTt0TEVDhIPVaBS6NlDW+XkejfYospOj3dla7zPT9bPStMW6ZIuLqLhw9Cl6PZnwrDjHHYn5QGiv822539j5K+WkiNxM3iZJy7ExFMI5IX/jyGedwxLVJ3xICAuTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=lTtqT0T+; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 86EA112000A;
	Tue, 26 Mar 2024 02:45:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 86EA112000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711410309;
	bh=91P4lNc44NYeFCF+MWL/12Wr501dy9/O7s42tFe1Ij8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=lTtqT0T+jsR4+rxdet7hruJe9jJZIcVXU3f6tDDYX2biy7R0jKkm/mqtldWrmZNPa
	 I55+0CKvza3vxOLjfmvb3JvK74rCsq5tLTogX8KdQgx1y34D5rb5mHI1GbjUIKjbBc
	 5QJJwS354Pt+MAMGfmDUon/B3vBWs81xivPmssI5+7uPqeAikECCg9L/TP083JM8TS
	 eUhzgSC5dkksVKZdOmLemWcLrfJOzb/n4NWadFrJZc4nGsd19SFoDLwPhhCwdD+2aR
	 cLak7pPUtgzfJyNtk5/6mNnryLIWk2l5BMUxyV78kYLXBuQor4eXCVB2/+vXfkCPVB
	 hzecKsaKJJMiQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 02:45:09 +0300 (MSK)
Received: from [172.28.66.90] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 02:45:08 +0300
Message-ID: <117365b8-ece1-4bc0-93f1-3e8c2861758d@salutedevices.com>
Date: Tue, 26 Mar 2024 02:45:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iio: adc: meson: fix voltage reference selection
 field name typo
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<neil.armstrong@linaro.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<linux-amlogic@lists.infradead.org>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
 <20240323231309.415425-2-martin.blumenstingl@googlemail.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240323231309.415425-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/25 18:32:00 #24438765
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Martin

Thanks for the patch

Should the tag
Fixes: 90c6241860bf ("iio: adc: meson: init voltage control bits")
be added?

On 3/24/24 02:13, Martin Blumenstingl wrote:
> The field should be called "vref_voltage", without a typo in the word
> voltage. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/iio/adc/meson_saradc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 13b473d8c6c7..2615d74534df 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -327,7 +327,7 @@ struct meson_sar_adc_param {
>   	u8					vref_select;
>   	u8					cmv_select;
>   	u8					adc_eoc;
> -	enum meson_sar_adc_vref_sel		vref_volatge;
> +	enum meson_sar_adc_vref_sel		vref_voltage;
>   };
>   
>   struct meson_sar_adc_data {
> @@ -1001,7 +1001,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>   		}
>   
>   		regval = FIELD_PREP(MESON_SAR_ADC_REG11_VREF_VOLTAGE,
> -				    priv->param->vref_volatge);
> +				    priv->param->vref_voltage);
>   		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>   				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
>   
> @@ -1225,7 +1225,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
>   	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>   	.resolution = 10,
>   	.has_reg11 = true,
> -	.vref_volatge = 1,
> +	.vref_voltage = 1,
>   	.cmv_select = 1,
>   };
>   
> @@ -1237,7 +1237,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>   	.resolution = 12,
>   	.disable_ring_counter = 1,
>   	.has_reg11 = true,
> -	.vref_volatge = 1,
> +	.vref_voltage = 1,
>   	.cmv_select = 1,
>   };
>   
> @@ -1249,7 +1249,7 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
>   	.resolution = 12,
>   	.disable_ring_counter = 1,
>   	.has_reg11 = true,
> -	.vref_volatge = 1,
> +	.vref_voltage = 1,
>   	.has_vref_select = true,
>   	.vref_select = VREF_VDDA,
>   	.cmv_select = 1,

-- 
Best regards
George

