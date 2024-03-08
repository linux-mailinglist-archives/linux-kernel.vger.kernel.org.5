Return-Path: <linux-kernel+bounces-96662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F6875FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EB1C213C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D434F8AB;
	Fri,  8 Mar 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rvngq1IG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1250200DB;
	Fri,  8 Mar 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886912; cv=none; b=oCZoZidGKXuHZ+JIzxDpEQh1lS3Gy9K2w6feyYALtWpEs7ZULi1zLTNVdyxtQDmEueaTgz22P3wBLjuqNKxIP5IkfTnjJVk8udE9Jqiadu8V806OwdMvLjthWp+HBAR6uZNfM4Km3mUaRUlo2yY/6RYDH8d6I9AzykZDVknJu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886912; c=relaxed/simple;
	bh=Pzu0gaWkTDesifP6Q2YOgfjmau3I8TTI4fcSFW4LqO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qftchoj82EYWDly7X5vPweMFcAfAhx+9nnkqKNPL36jUsGh5icCaTYOF6HM6lZgbBCQ3dWPuUaN1ZA0xHKKzA26QT6GXqhxinC/WoLSzrcdR52/Q80S6mg5Ulp4YKTmUguOEOcP0B0NxxNOCl3tW6+MoqenfWBmP1OufFGXb+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rvngq1IG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709886907;
	bh=Pzu0gaWkTDesifP6Q2YOgfjmau3I8TTI4fcSFW4LqO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rvngq1IGeh+RcP8rkLUgR3vxThFsprDzFgDjGcGG+mms1y5TwzyBtcrHJT4hIJN21
	 fTDOqY8Dlovk1QHdUIBtd/Lw4XKmIIXPSOF0GTBMOlMoRJLKlNCOcsaK2+H3xCPLlW
	 V+lrASTtZ0n3k9r8Ts5VUFjAXbb2LH83Q+jFapF2QW9Yr9LP3d0FUeTPRn1cNjPEJi
	 g/5PElyi1RT47FWOMr8baVeb6i2xiuPdYby/IQ6ov7DH5FL+ExA48uMk+nou7wwoH+
	 BzCIUPnzk9fc6GtHSudp5mnaPUK49lmkEQlS/VD6m5XcGPsjfcRy1X9srcrb5eUMUc
	 VTSIBPn03Xh/A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9DFD737813CA;
	Fri,  8 Mar 2024 08:35:05 +0000 (UTC)
Message-ID: <25a93c67-35d8-4ce6-86f0-780559d58e96@collabora.com>
Date: Fri, 8 Mar 2024 09:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/22] ASoC: dt-bindings: mt8192: Document
 audio-routing and dai-link subnode
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, wenst@chromium.org, lgirdwood@gmail.com,
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
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
 <20240307114445.196981-20-angelogioacchino.delregno@collabora.com>
 <20240307141228.GA2491015-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240307141228.GA2491015-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 15:12, Rob Herring ha scritto:
> On Thu, Mar 07, 2024 at 12:44:42PM +0100, AngeloGioacchino Del Regno wrote:
>> Document the dai-link subnodes and the audio-routing property, allowing
>> to describe machine specific audio hardware and links in device tree.
>>
>> While at it, also deprecate the old properties which were previously
>> used with the driver's partially hardcoded configuration.
>>
> 
> I replied on v1, but one more thing here.
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 124 ++++++++++++++++--
>>   1 file changed, 115 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> index 7e50f5d65c8f..449454c50dcc 100644
>> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> @@ -13,6 +13,9 @@ maintainers:
>>   description:
>>     This binding describes the MT8192 sound card.
>>   
>> +allOf:
>> +  - $ref: sound-card-common.yaml#
>> +
>>   properties:
>>     compatible:
>>       enum:
>> @@ -20,6 +23,14 @@ properties:
>>         - mediatek,mt8192_mt6359_rt1015p_rt5682
>>         - mediatek,mt8192_mt6359_rt1015p_rt5682s
>>   
>> +  audio-routing:
>> +    description:
>> +      A list of the connections between audio components. Each entry is a
>> +      pair of strings, the first being the connection's sink, the second
>> +      being the connection's source.
>> +      Valid names could be the input or output widgets of audio components,
>> +      power supplies, MicBias of codec and the software switch.
>> +
>>     mediatek,platform:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description: The phandle of MT8192 ASoC platform.
>> @@ -27,10 +38,12 @@ properties:
>>     mediatek,hdmi-codec:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description: The phandle of HDMI codec.
>> +    deprecated: true
> 
> The deprecated keyword doesn't do anything at the moment, but my plan
> there is to add a mode to the tools which disables all deprecated
> properties. That will give you want you want in terms of disallowing
> these properties.

That would definitely be awesome - looking forward to it!

> 
> That would require dropping them from "required" which I'm fine with you
> doing. (Though technically that's still an ABI change)
> 

Then instead of waiting for you to add that mode and then remove stuff later,
I'll just omit the `else: required:` block on v3, so that we avoid commit
noise and all the warnings when the deprecated check gets released.

I guess that's fine, right?

Cheers,
Angelo

