Return-Path: <linux-kernel+bounces-119356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7788C79A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF131C640D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17813CAAF;
	Tue, 26 Mar 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ePA7RZGi"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF6FC0E;
	Tue, 26 Mar 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467597; cv=none; b=MfbOC/YioSuKfRc2aNBQUo24+yevm8HQvvaIKwUfjR3yuSi6LXENNyLKMkOTl85tPbBRk5LZcs/BN7lxAcydhmT29fpRwKIgdnUQUD2Kj68q+txwNZDZw6WNzQALaZm5NxingsWwwMd2GHO2jxZUQLVH4jEmuPsFyDqC/yN760U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467597; c=relaxed/simple;
	bh=X1kX69Jlpw+6CmX8mQiJm4O+sWo7JoMK2tt6HDIjWZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/DKJYlTSmgbroEuBCA3DNXpjc0Q2+0txoRi7LZ8bbKVkKJPbinChGSgYsvOi72Eq66d3c9Dm/ol8L4/ztOgJ5kk4t7wX28F6QtXN7t26rh4jNCmlO5C0vW+hJaLxwrtGWpu5pJvbKXuEIgtJ64LlbqTYGiUyxK8RvZHShxDES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ePA7RZGi; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B15B9120004;
	Tue, 26 Mar 2024 18:39:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B15B9120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711467590;
	bh=BspCg4rrPJ0Kpig9Yf6f5Zh/R+hA73hjDZvRIpKseLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ePA7RZGi1LFC23l7KSsw/4S8dcZ2KX7MSOkB/o4z7Kk2vlwHcGfjZwFTTSddxMF+f
	 URyiU38kBwTwoJt/UMLBrUizr1BgaYdV4ur+KuUm83f1EozvmNDZ9cpdkeUnpSqQuw
	 1drQJP1WX826/tyNAVRms1daZhOuqIEHvqQLsIC+JCu+9ywl2hDy5YQDDnBdKRfQvD
	 pj8lzOMMbooGkBUAhXtSGhBv0LHmcIPKS1BFyB+YOywk42LakpkX/wKKFjbJBw+WEo
	 z3xSGvHF6QNA37l/vjQL+zyxidP40CmEf+/uQkGuApvFmVpnxMJwDPazWs1VmAbs9x
	 B2Fcv3mMDFswA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 18:39:50 +0300 (MSK)
Received: from [192.168.20.2] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 18:39:50 +0300
Message-ID: <13bfb247-9210-48ae-902b-629d850cbae7@salutedevices.com>
Date: Tue, 26 Mar 2024 18:38:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] ASoC: meson: g12a-toacodec: rework the definition
 of bits
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325235311.411920-1-jan.dakinevich@salutedevices.com>
 <1j34sd9fur.fsf@starbuckisacylon.baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j34sd9fur.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184425 [Mar 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 12 0.3.12 d1a01b14eb3fc102c904d35fe6c2622ed2d1c16e, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/26 11:48:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/26 11:48:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/26 13:11:00 #24452135
X-KSMG-AntiVirus-Status: Clean, skipped



On 3/26/24 18:15, Jerome Brunet wrote:
> 
> On Tue 26 Mar 2024 at 02:53, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> There is a lot of defines, but almost all of them are not used. Lets
>> rework them:
> 
> Thanks for noticing. Please start by removing what's unused.
> 

I mean, that some values are named. But then numbers are used instead names.

>>
>>  - keep separate the definition for different platforms to make easier
>>    checking that they match documentation.
>>
>>  - use LSB/MSB sufixes for uniformity.
> 
> I'd be in favor of dropping these suffixes completely.
> 
>>
>>  - don't use hard-coded values for already declared defines.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>> Links:
>>
>>  [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
>>
>> Changes v1 -> v2:
>>  - Detached from v1's series (patch 7).
>>  - Fixed my wrong understanding of SOC_SINGLE's input parameters.
>>
>>  sound/soc/meson/g12a-toacodec.c | 79 ++++++++++++++++++++-------------
>>  1 file changed, 49 insertions(+), 30 deletions(-)
>>
>> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
>> index 531bb8707a3e..22181f4bab72 100644
>> --- a/sound/soc/meson/g12a-toacodec.c
>> +++ b/sound/soc/meson/g12a-toacodec.c
>> @@ -20,26 +20,37 @@
>>  #define G12A_TOACODEC_DRV_NAME "g12a-toacodec"
>>  
>>  #define TOACODEC_CTRL0			0x0
>> -#define  CTRL0_ENABLE_SHIFT		31
>> -#define  CTRL0_DAT_SEL_SM1_MSB		19
>> -#define  CTRL0_DAT_SEL_SM1_LSB		18
>> -#define  CTRL0_DAT_SEL_MSB		15
>> -#define  CTRL0_DAT_SEL_LSB		14
>> -#define  CTRL0_LANE_SEL_SM1		16
>> -#define  CTRL0_LANE_SEL			12
>> -#define  CTRL0_LRCLK_SEL_SM1_MSB	14
>> -#define  CTRL0_LRCLK_SEL_SM1_LSB	12
>> -#define  CTRL0_LRCLK_SEL_MSB		9
>> -#define  CTRL0_LRCLK_SEL_LSB		8
>> -#define  CTRL0_LRCLK_INV_SM1		BIT(10)
>> -#define  CTRL0_BLK_CAP_INV_SM1		BIT(9)
>> -#define  CTRL0_BLK_CAP_INV		BIT(7)
>> -#define  CTRL0_BCLK_O_INV_SM1		BIT(8)
>> -#define  CTRL0_BCLK_O_INV		BIT(6)
>> -#define  CTRL0_BCLK_SEL_SM1_MSB		6
>> -#define  CTRL0_BCLK_SEL_MSB		5
>> -#define  CTRL0_BCLK_SEL_LSB		4
>> -#define  CTRL0_MCLK_SEL			GENMASK(2, 0)
>> +
>> +/* Common bits */
>> +#define CTRL0_ENABLE_SHIFT		31
>> +#define CTRL0_MCLK_SEL			GENMASK(2, 0)
>> +
>> +/* G12A bits */
>> +#define CTRL0_DAT_SEL_G12A_MSB		15
>> +#define CTRL0_DAT_SEL_G12A_LSB		14
>> +#define CTRL0_LANE_SEL_G12A_MSB		13
>> +#define CTRL0_LANE_SEL_G12A_LSB		12
>> +#define CTRL0_LANE_SEL_G12A_MAX		3
>> +#define CTRL0_LRCLK_SEL_G12A_MSB	9
>> +#define CTRL0_LRCLK_SEL_G12A_LSB	8
>> +#define CTRL0_BLK_CAP_INV_G12A		BIT(7)
>> +#define CTRL0_BCLK_O_INV_G12A		BIT(6)
>> +#define CTRL0_BCLK_SEL_G12A_MSB		5
>> +#define CTRL0_BCLK_SEL_G12A_LSB		4
>> +
>> +/* SM1 bits */
>> +#define CTRL0_DAT_SEL_SM1_MSB		19
>> +#define CTRL0_DAT_SEL_SM1_LSB		18
>> +#define CTRL0_LANE_SEL_SM1_MSB		17
>> +#define CTRL0_LANE_SEL_SM1_LSB		16
>> +#define CTRL0_LANE_SEL_SM1_MAX		3
>> +#define CTRL0_LRCLK_SEL_SM1_MSB		14
>> +#define CTRL0_LRCLK_SEL_SM1_LSB		12
>> +#define CTRL0_LRCLK_INV_SM1		BIT(10)
>> +#define CTRL0_BLK_CAP_INV_SM1		BIT(9)
>> +#define CTRL0_BCLK_O_INV_SM1		BIT(8)
>> +#define CTRL0_BCLK_SEL_SM1_MSB		6
>> +#define CTRL0_BCLK_SEL_SM1_LSB		4
>>  
>>  #define TOACODEC_OUT_CHMAX		2
>>  
>> @@ -108,7 +119,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
>>  }
>>  
>>  static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
>> -			    CTRL0_DAT_SEL_LSB,
>> +			    CTRL0_DAT_SEL_G12A_LSB,
>>  			    g12a_toacodec_mux_texts);
>>  
>>  static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
>> @@ -210,7 +221,7 @@ static int g12a_toacodec_component_probe(struct snd_soc_component *c)
>>  {
>>  	/* Initialize the static clock parameters */
>>  	return snd_soc_component_write(c, TOACODEC_CTRL0,
>> -				       CTRL0_BLK_CAP_INV);
>> +				       CTRL0_BLK_CAP_INV_G12A);
>>  }
>>  
>>  static int sm1_toacodec_component_probe(struct snd_soc_component *c)
>> @@ -229,11 +240,13 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
>>  };
>>  
>>  static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
>> -	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
>> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_G12A_LSB,
>> +		   CTRL0_LANE_SEL_G12A_MAX, 0),
>>  };
>>  
>>  static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
>> -	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
>> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1_LSB,
>> +		   CTRL0_LANE_SEL_SM1_MAX, 0),
>>  };
>>  
>>  static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>> @@ -266,16 +279,22 @@ static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>  
>>  static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
>>  	.component_drv	= &g12a_toacodec_component_drv,
>> -	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, 14, 15),
>> -	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 8, 9),
>> -	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, 4, 5),
>> +	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_G12A_LSB,
>> +				    CTRL0_DAT_SEL_G12A_MSB),
>> +	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_G12A_LSB,
>> +				     CTRL0_LRCLK_SEL_G12A_MSB),
>> +	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_G12A_LSB,
>> +				    CTRL0_BCLK_SEL_G12A_MSB),
>>  };
>>  
>>  static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
>>  	.component_drv	= &sm1_toacodec_component_drv,
>> -	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, 18, 19),
>> -	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
>> -	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, 4, 6),
>> +	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_SM1_LSB,
>> +				    CTRL0_DAT_SEL_SM1_MSB),
>> +	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_SM1_LSB,
>> +				     CTRL0_LRCLK_SEL_SM1_MSB),
>> +	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_SM1_LSB,
>> +				    CTRL0_BCLK_SEL_SM1_MSB),
> 
> Those defines are already platform specific by the structure holding
> them and the defines you have added are not helping readability.
> 

These values are duplicated. Would it be reasonable to remove them from
defines?

> I don't see the point to see.
> I'd prefer to keep the field defined as they are.
> 

Main goal of this patch is to rearrange definitions by platforms. From
my point it is quite difficult to read things like this:

#define  CTRL0_LANE_SEL_SM1		16
#define  CTRL0_LANE_SEL			12
#define  CTRL0_LRCLK_SEL_SM1_MSB	14
#define  CTRL0_LRCLK_SEL_SM1_LSB	12
#define  CTRL0_LRCLK_SEL_MSB		9
#define  CTRL0_LRCLK_SEL_LSB		8

I am going to add one more platforms, and this will get worse.

>>  };
>>  
>>  static const struct of_device_id g12a_toacodec_of_match[] = {
> 
> 

-- 
Best regards
Jan Dakinevich

