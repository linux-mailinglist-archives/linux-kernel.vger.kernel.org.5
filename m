Return-Path: <linux-kernel+bounces-118599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1688BD20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008601F3C6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA74CE18;
	Tue, 26 Mar 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xVo5qX9g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15F3A1D7;
	Tue, 26 Mar 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443689; cv=none; b=FP05D9C6Tkhetp2uMdRrapc+pV6xawF9XrAheDYUZyBw0r8bxt+6HwFJNhBAR2k4V4NdMl+IPzJoATSS6UC3CFqGjq/YCVKlkBG8qpz0oBiDv5To9kDMQLYqqIyVwvYs8d8FpXZyEfh13X8yMlStx96onGFCPKvkOgIornVXVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443689; c=relaxed/simple;
	bh=ixR84/hC5ObDuk4xPuGOBtJ9kzC3VnB6M3PMiFfGYYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8+IBb4pMZmDEQ5QH1xiTufMtElF5+J2E6wc8wF1w+guDqk57ldGPC+gu1kbu4RSXjdSj8DhZA53EcROpADo0L/d8jqBQ5iO0gyauBoB6cHLPfuFV3/cG0zUy53usDGcxknBKX2qChO4BDHr03JVPA4yt+WVBH//fDaZQi5Sf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xVo5qX9g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711443682;
	bh=ixR84/hC5ObDuk4xPuGOBtJ9kzC3VnB6M3PMiFfGYYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xVo5qX9gWM7zCDSwnSrhWrJ89WQvr7Mbc8CNeGAKCYK8/DNDNUah7EFJtxQsJQteW
	 pwHub4vWv7+ankvLH9iVnb3NilI/G/gn5g4ssqgBuAMsTkG0XhBKVGw4mg2Qq5nPpO
	 croR8uM9EiMqWkOpeGDYUWP4vMdJbgFKuUn/xTItahZ7+NaWD3vz2hgCiZGvbbtZ+a
	 oWifTWYZw2g2fRnlXx8xQYfX9I7Pn6yFQyGaKZnyTth+SqgOzxAhMeo6rwwjZaKjAd
	 3cevRIaBA+SSmFVdKAFeITWqCF0EzI7DS2OH7ViPquRFEKRIM+JoZaqX4qhH3fEzVH
	 jl47zmQ8nbWbA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 15BA33782082;
	Tue, 26 Mar 2024 09:01:20 +0000 (UTC)
Message-ID: <eb4b5b1d-90dc-4355-8fb0-5fb7f2bb2426@collabora.com>
Date: Tue, 26 Mar 2024 10:01:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/22] ASoC: mediatek: Add common machine soundcard
 driver probe mechanism
To: Mark Brown <broonie@kernel.org>
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com,
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
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
 <20240313110147.1267793-6-angelogioacchino.delregno@collabora.com>
 <6b9dd2ad-a24e-497a-8a5c-c7c04475cf5d@sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6b9dd2ad-a24e-497a-8a5c-c7c04475cf5d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/03/24 15:18, Mark Brown ha scritto:
> On Wed, Mar 13, 2024 at 12:01:30PM +0100, AngeloGioacchino Del Regno wrote:
>> Add a common machine soundcard driver probe function that supports both
>> DSP and AFE-direct usecases and also provides a hook for legacy machine
>> soundcard driver probe mechanisms.
>>
>> Note that the hook is there because, even for legacy probe, a lot of the
>> actual code can still be commonized, hence still reducing duplication
>> for the legacy devicetree retrocompatibility cases.
>>
>> This common probe function deprecates all of the inconsistent previous
>> probe mechanisms and aims to settle all of the MediaTek card drivers on
>> consistent and common devicetree properties describing wanted DAIs,
>> device specific DAI configuration and DAI links to codecs found on
>> each device/board.
> 
> This breaks allmodconfig builds:

Oops. Forgot to test this commit without the next one constifying stuff around.
I'll recheck and make this one right. Good catch!

Thanks for notifying!

Cheers,
Angelo

> 
> 
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In function ‘mtk_sof_dai_link_fixup’:
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:18:41: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     18 |         struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>        |                                         ^~~~~~~~~~~~~
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In function ‘mtk_sof_card_probe’:
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:58:41: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     58 |         struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>        |                                         ^~~~~~~~~~~~~
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In function ‘mtk_sof_find_tplg_be’:
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:76:41: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     76 |         struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>        |                                         ^~~~~~~~~~~~~
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In function ‘mtk_sof_check_tplg_be_dai_link_fixup’:
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:116:41: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    116 |         struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>        |                                         ^~~~~~~~~~~~~
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In function ‘mtk_sof_card_late_probe’:
> /build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:147:41: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    147 |         struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
>        |                                         ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 

