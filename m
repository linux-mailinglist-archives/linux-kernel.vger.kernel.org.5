Return-Path: <linux-kernel+bounces-138874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F589FB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72EC1C220B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47F16EC1A;
	Wed, 10 Apr 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K1g8NZ9X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5615D5C0;
	Wed, 10 Apr 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762929; cv=none; b=UBD+HwTDxdsl0+qtuylTyyz//6sCxzfvA90hlXAi7nQgpukh8m03OHauBOEDyne1xLqMlT/v1Q0HalyD0P9962fpWM6gfjjUq+ZvqHm8EdrVXDttiMgtyDelhW5xCnMqX9Ut+S8r7XuvlRegW8cUIqHDRWriP23KikJj68WKoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762929; c=relaxed/simple;
	bh=CKYJu7WyQjbgodgDBQk/bD0aZ+5Ih4b2bRRph8ajJNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUfXNTzDM+j2e+MTs1GZod6OhS0zB6zyLgeCRRXmv0db7/rc80xML9Z2ltTeQbogX5EQ6xp4idmSgqMhhyG+K+tvZHsB4/V6l2Sk+Ee9ZKis5aWc8Z8xlfDmzLoD0iu7MKmOSAqfYDv1pQucBSJU+sk7LKzH4KOwBPlEpUjm204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K1g8NZ9X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712762924;
	bh=CKYJu7WyQjbgodgDBQk/bD0aZ+5Ih4b2bRRph8ajJNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K1g8NZ9XR3lakU90fT945gzq+DiAo/FRpF8YT7T6u+aQZmErduUjLkdbPHkFjx8pu
	 mzrRW1tBX48RU8nBach238E42fYVQLFIvISoTqSysZhQeyZRkdXYnEHB78EC60oPHs
	 HcAah3gmFWgu5zRhllO7O8W1tC98QU5Xc6BgbldS76U0M9dPM1Vw68ZgGPP9D1G5R4
	 dCTniLg2gjCeqAcr5rFQDwfICu23kOxzIWORkG44Xmu1YRVXkgd2ISRqssYHuleWcZ
	 2riMyfqkOmZ9NXXLB+wUCSUs577ZiwKxtmL1FoSDrtAxskh8Uj1CoNZCDrihogfJW5
	 HhS7bd8w+H66w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89F423780C13;
	Wed, 10 Apr 2024 15:28:42 +0000 (UTC)
Message-ID: <636411e6-05fd-4e32-8e3c-6bcc0c9ec063@collabora.com>
Date: Wed, 10 Apr 2024 17:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] ASoC: mediatek: mt8192: Migrate to
 mtk_soundcard_common_probe
To: Alexandre Mergnat <amergnat@baylibre.com>, broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
 <20240409113310.303261-6-angelogioacchino.delregno@collabora.com>
 <cf0184c4-2b3e-4074-9e30-bf65ec7f0aaa@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cf0184c4-2b3e-4074-9e30-bf65ec7f0aaa@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/04/24 15:59, Alexandre Mergnat ha scritto:
> 
> 
> On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
>> @@ -1211,52 +1196,85 @@ static int mt8192_mt6359_dev_probe(struct platform_device 
>> *pdev)
>>           if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
>>               strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
>>               dai_link->ops = &mt8192_rt1015_i2s_ops;
>> -
>> -        if (!dai_link->platforms->name)
>> -            dai_link->platforms->of_node = platform_node;
>> -    }
>> -
>> -    priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> -    if (!priv) {
>> -        ret = -ENOMEM;
>> -        goto err_probe;
>> -    }
>> -    snd_soc_card_set_drvdata(card, priv);
>> -
>> -    ret = mt8192_afe_gpio_init(&pdev->dev);
>> -    if (ret) {
>> -        dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
> 
> I don't think __func__ is necessary.
> 
>> -        goto err_probe;
>>       }
>> -    ret = devm_snd_soc_register_card(&pdev->dev, card);
>> -    if (ret)
>> -        dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", 
>> __func__);
> 
> I don't think __func__ is necessary.

I am removing the line, here :-P

> 
>> -
>> -err_probe:
>>       of_node_put(headset_codec);
>>   err_headset_codec:
>>       of_node_put(speaker_codec);
>>   err_speaker_codec:
>> -    of_node_put(platform_node);
>> -err_platform_node:
>> -    of_node_put(hdmi_codec);
>> +    if (hdmi_codec)
>> +        of_node_put(hdmi_codec);
>> +
>>       return ret;
>>   }
>> +static int mt8192_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data, 
>> bool legacy)
>> +{
>> +    struct mtk_platform_card_data *card_data = soc_card_data->card_data;
>> +    struct snd_soc_card *card = card_data->card;
>> +    int ret;
>> +
>> +    if (legacy) {
>> +        ret = mt8192_mt6359_legacy_probe(soc_card_data);
>> +        if (ret)
>> +            return ret;
>> +    } else {
>> +        struct snd_soc_dai_link *dai_link;
>> +        int i;
>> +
>> +        for_each_card_prelinks(card, i, dai_link)
>> +            if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
>> +                strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
>> +                dai_link->ops = &mt8192_rt1015_i2s_ops;
>> +    }
>> +
>> +    ret = mt8192_afe_gpio_init(card->dev);
>> +    if (ret)
>> +        return dev_err_probe(card->dev, ret, "%s init gpio error\n", __func__);
> 
> I don't think __func__ is necessary.
> 

That was on purpose.
I'm migrating things, but I am leaving the prints as they were.

Cheers,
Angelo

>> +
>> +    return 0;
>> +}
> 
> Beside that,
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> 




