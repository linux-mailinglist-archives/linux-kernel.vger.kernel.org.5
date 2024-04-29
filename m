Return-Path: <linux-kernel+bounces-162838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B503D8B613C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBB51C220EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30512A157;
	Mon, 29 Apr 2024 18:40:39 +0000 (UTC)
Received: from mail.schimsalabim.eu (vps01.schimsalabim.eu [85.214.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08067A14;
	Mon, 29 Apr 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416038; cv=none; b=oWi/e7cHWJZlFY5/mPV67YebLcgprx2xJf9FQBiAmvQ5cZdudL2taieC7miiryB5iZ+pFC2vYuRYiX0S/pLwrcZo+Nwjz61lsBOva+TCcT1VvdQ/rRsHPvFVtjiQffsca6Mzkw1e1zSW51DOnIXdhypb/5zv66l1AU0kbRwC54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416038; c=relaxed/simple;
	bh=JKKbafSuoPn8Q0v0LpzntyGjrFoJpfFeVfyKmby/OBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PChfq4ldKHa26U5AEC/oEwbl4mlxeEdpsyjDj2G1EvTHIMW14PNktKjzY5kKSyac3JglpR1ZFnuRzy10hyEbHNd1ko42IWIyB8QP7YpwhxdhaLcEAHI6Q8GBx9euuwZ+GLOeKThm7R8RvCVQYTUVnv1fq/9rhONv2+76GdFY3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=schimsalabim.eu; spf=pass smtp.mailfrom=schimsalabim.eu; arc=none smtp.client-ip=85.214.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=schimsalabim.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schimsalabim.eu
Received: from [192.168.0.158] (82-217-109-137.cable.dynamic.v4.ziggo.nl [82.217.109.137])
	(authenticated bits=0)
	by h2374449.stratoserver.net (8.14.7/8.14.7) with ESMTP id 43TIdTVN028081
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Apr 2024 20:39:29 +0200
Message-ID: <534a73a7-bc41-42a7-a060-bc1465f3a21e@schimsalabim.eu>
Date: Mon, 29 Apr 2024 20:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: sunxi: DMIC: Add controls for adjusting the mic
 gains
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20240422150213.4040734-1-joao@schimsalabim.eu>
 <5772237.DvuYhMxLoT@jernej-laptop>
 <e256942d-eba1-4800-bd02-c490167dea12@schimsalabim.eu>
 <2262648.iZASKD2KPV@jernej-laptop>
Content-Language: en-US
From: Joao Schim <joao@schimsalabim.eu>
In-Reply-To: <2262648.iZASKD2KPV@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/24 16:39, Jernej Škrabec wrote:
> Dne četrtek, 25. april 2024 ob 13:03:56 GMT +2 je Joao Schim napisal(a):
>> On 4/24/24 20:42, Jernej Škrabec wrote:
>>> Hi Joao,
>> Hi Jernej,  thanks for your prompt response.
>>> Dne ponedeljek, 22. april 2024 ob 17:02:13 GMT +2 je Joao Schim napisal(a):
>>>> The AllWinner H6 and later SoCs that sport a DMIC block contain a set of registers to control
>>>> the gain (left + right) of each of the four supported channels.
>>>>
>>>> Add ASoC controls for changing each of the stereo channel gains using alsamixer and alike
>>> Add SoB tag.
>> Yeah, i realized that too late. Thanks for bringing that to my
>> attention. I will add it in v1.
>>>> ---
>>>>    sound/soc/sunxi/sun50i-dmic.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
>>>> index c76628bc86c6..f8613d8c3462 100644
>>>> --- a/sound/soc/sunxi/sun50i-dmic.c
>>>> +++ b/sound/soc/sunxi/sun50i-dmic.c
>>>> @@ -14,6 +14,7 @@
>>>>    #include <sound/dmaengine_pcm.h>
>>>>    #include <sound/pcm_params.h>
>>>>    #include <sound/soc.h>
>>>> +#include <sound/tlv.h>
>>>>    
>>>>    #define SUN50I_DMIC_EN_CTL			(0x00)
>>>>    	#define SUN50I_DMIC_EN_CTL_GLOBE			BIT(8)
>>>> @@ -43,6 +44,17 @@
>>>>    	#define SUN50I_DMIC_CH_NUM_N_MASK			GENMASK(2, 0)
>>>>    #define SUN50I_DMIC_CNT				(0x2c)
>>>>    	#define SUN50I_DMIC_CNT_N				(1 << 0)
>>>> +#define SUN50I_DMIC_D0D1_VOL_CTR		(0x30)
>>>> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0R			(0)
>>>> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0L			(8)
>>>> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1R			(16)
>>>> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1L			(24)
>>>> +#define SUN50I_DMIC_D2D3_VOL_CTR                (0x34)
>>>> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2R                     (0)
>>>> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2L                     (8)
>>>> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3R                     (16)
>>>> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3L                     (24)
>>>> +
>>>>    #define SUN50I_DMIC_HPF_CTRL			(0x38)
>>>>    #define SUN50I_DMIC_VERSION			(0x50)
>>>>    
>>>> @@ -273,8 +285,30 @@ static const struct of_device_id sun50i_dmic_of_match[] = {
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
>>>>    
>>>> +static const DECLARE_TLV_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, 1);
>>> DECLARE_TLV_DB_SCALE is old name, SNDRV_CTL_TLVD_DECLARE_DB_SCALE should be
>>> used instead.
>> I can't seem to find that define in HEAD. what code-base are you
>> referring to that i should checkout ?
> Here is define:
> https://elixir.bootlin.com/linux/v6.9-rc1/source/include/uapi/sound/tlv.h#L52
>
> However, I'm not sure if this message means DECLARE_TLV_DB_SCALE is
> deprecated or not:
> https://elixir.bootlin.com/linux/v6.9-rc1/source/include/sound/tlv.h#L12

Right, apparently i sneaked in another D in the name. That explains i 
could not find it.

Will send v1 in a few minutes. Thanks.

Kind regards,

Joao

> Best regards,
> Jernej
>
>>> Other than that, it looks fine.
>> Thanks.
>>
>>> Best regards,
>>> Jernej
>>>
>>>> +
>>>> +static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
>>>> +
>>>> +        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
>>>> +                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
>>>> +                       0xFF, 0, sun50i_dmic_vol_scale),
>>>> +        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
>>>> +                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
>>>> +                       0xFF, 0, sun50i_dmic_vol_scale),
>>>> +        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
>>>> +                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
>>>> +                       0xFF, 0, sun50i_dmic_vol_scale),
>>>> +        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
>>>> +                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
>>>> +                       0xFF, 0, sun50i_dmic_vol_scale),
>>>> +
>>>> +
>>>> +};
>>>> +
>>>>    static const struct snd_soc_component_driver sun50i_dmic_component = {
>>>>    	.name           = "sun50i-dmic",
>>>> +	.controls	= sun50i_dmic_controls,
>>>> +	.num_controls	= ARRAY_SIZE(sun50i_dmic_controls),
>>>>    };
>>>>    
>>>>    static int sun50i_dmic_runtime_suspend(struct device *dev)
>>>>
>>>
>>>
>> Kind regards,
>>
>> Joao
>>
>>
>
>
>

