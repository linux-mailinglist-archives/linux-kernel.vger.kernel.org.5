Return-Path: <linux-kernel+bounces-83243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBA8690BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CA1F263AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553B13AA2C;
	Tue, 27 Feb 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="evMyTP2k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D461CFA9;
	Tue, 27 Feb 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037525; cv=none; b=urmoEuqSTsmYY/nTXpprnxvmh+smruOIx4/fad4jg57ZGiIxqIcl+4ak/Dg0og6grVdssZek4x1VUA9WR0rib0ZVW5tfAb2lU/bzoYlGFNjs7EEVrInajCOzV7iRWVzrcuSIcgW0PaUhkmObaoPgFqRFZn2cJ0u7mP3jMrOcxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037525; c=relaxed/simple;
	bh=wIFETi/MZvXW9/FAsIozT825+vybcsyNan5jzXcLPQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3KCOza2gHgl5L6KKHPzNkaMj91yW12AfY+FRUvO0FIHeOKsf7o5Z6bSxjt8CyQ4sT8bryyeXoD5I7suKR4tWXvOiZKWyunkgcgManSwgG1zuu1Y/23tQ1aoaqfrdkHbsuf23GAlNU1spiPyNfu4ticZxCVg0UTsNjRIT69f/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=evMyTP2k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709037521;
	bh=wIFETi/MZvXW9/FAsIozT825+vybcsyNan5jzXcLPQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=evMyTP2kJ2qJhKVWh8x49Jwu/aes3ZGEKemzrZ61lFaUHq/IycOxxot4qKk41kzxl
	 cqrVwpwI2NQI8YcQOgzdaf/bXWHrbZjaU1J64If8Ew92UnrwNxcp/T8UsMnbar6tMb
	 1yT36QOG2Ht1R2By9rJ3rSWkkqsaLdTPVC2VTXqOZ+l+PbPg723HKrlFHzIvcjjtMg
	 TE+w7uKNuh0laf1rPtuaRrPg9XIBZD19vQxaBPoxzvi9cPLcias50byRUGVTT2c6gt
	 stWeZQARKK5MlueSNvTX44aEHsI3GAuCRJpH4qXv3dcqhIMpFJT0AywZDSBymXtvG+
	 xRKNlrETnAaAw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D93BE37813B6;
	Tue, 27 Feb 2024 12:38:39 +0000 (UTC)
Message-ID: <e0907559-121f-4cdf-8b5a-744295ec85b3@collabora.com>
Date: Tue, 27 Feb 2024 13:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add
 audio sound card document
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-2-4fa1cea1667f@baylibre.com>
 <e15fdb18-d4de-495f-b90b-ba0e787cbef4@collabora.com>
 <92b9e9ac-6265-4611-888d-ba74bb871be5@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <92b9e9ac-6265-4611-888d-ba74bb871be5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 27/02/24 11:23, Alexandre Mergnat ha scritto:
> 
> 
> On 26/02/2024 16:30, AngeloGioacchino Del Regno wrote:
>> Il 26/02/24 15:01, Alexandre Mergnat ha scritto:
>>> Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.
>>>
>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>> ---
>>>   .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 127 +++++++++++++++++++++
>>>   1 file changed, 127 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml 
>>> b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>>> new file mode 100644
>>> index 000000000000..f469611ec6b6
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>>> @@ -0,0 +1,127 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/mediatek,mt8365-mt6357.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek MT8365 sound card with MT6357 sound codec.
>>> +
>>> +maintainers:
>>> +  - Alexandre Mergnat <amergnat@baylibre.com>
>>> +
>>> +description:
>>> +  This binding describes the MT8365 sound card.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt8365-mt6357
>>> +
>>> +  mediatek,hp-pull-down:
>>> +    description:
>>> +      Earphone driver positive output stage short to the
>>> +      audio reference ground.
>>> +      Default value is false.
>>> +    type: boolean
>>> +
>>> +  mediatek,micbias0-microvolt:
>>> +    description: |
>>
>> description: Selects MIC Bias 0 output voltage
>>
>>> +      Selects MIC Bias 0 output voltage.
>>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>
>> No, you don't say 0 1 2 3 4 to a property that says "microvolt", that's simply
>> wrong.
>>
>> mediatek,micbias0-microvolt = <2100000>;
>>
>> ...so you want a binding that says
>> enum: [ 1700000, 1800000, this, that, 2700000]
>>
> 
> Is it correct if I put "description: Selects MIC Bias 0 output voltage index" ?
> 

No, it's still not correct. You have to pass microvolt values.

The driver will then transform the microvolt values to the index and subsequently
write the index value to the hardware registers.

The bindings shall be generic, in the sense that they shall not express hardware
register values... and this is especially true when we have a value that *does*
actually have means to be expressed in common units.

Besides, in the cases in which there's no common units involved, the values most
probably won't be suited for devicetree//bindings, so those would be hardcoded in
the driver as platform data.

This is not the case, so, please keep this property but specify microvolts in the
bindings (and obviously in devicetree).

>>> +
>>> +  mediatek,micbias1-microvolt:
>>> +    description: |
>>> +      Selects MIC Bias 1 output voltage.
>>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>
>> same here.
>>
>>> +
>>> +  mediatek,platform:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: The phandle of MT8365 ASoC platform.
>>> +
>>> +  pinctrl-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: aud_default
>>> +      - const: aud_dmic
>>> +      - const: aud_miso_off
>>> +      - const: aud_miso_on
>>> +      - const: aud_mosi_off
>>> +      - const: aud_mosi_on
>>> +
>>> +  vaud28-supply:
>>> +    description:
>>> +      2.8 volt supply for the audio codec
>>> +
>>> +patternProperties:
>>> +  "^dai-link-[0-9]+$":
>>> +    type: object
>>> +    description:
>>> +      Container for dai-link level properties and CODEC sub-nodes.
>>> +
>>> +    properties:
>>> +      codec:
>>> +        type: object
>>> +        description: Holds subnode which indicates codec dai.
>>> +
>>> +        properties:
>>> +          sound-dai:
>>> +            maxItems: 1
>>> +            description: phandle of the codec DAI
>>> +
>>> +        additionalProperties: false
>>> +
>>> +      link-name:
>>> +        description:
>>> +          This property corresponds to the name of the BE dai-link to which
>>> +          we are going to update parameters in this node.
>>> +        items:
>>> +          const: 2ND I2S BE
>>> +
>>> +      sound-dai:
>>> +        maxItems: 1
>>> +        description: phandle of the CPU DAI
>>> +
>>> +    additionalProperties: false
>>> +
>>> +    required:
>>> +      - link-name
>>> +      - sound-dai
>>> +
>>> +additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - mediatek,platform
>>> +  - pinctrl-names
>>> +  - vaud28-supply
>>> +
>>> +examples:
>>> +  - |
>>> +    sound {
>>> +        compatible = "mediatek,mt8365-mt6357";
>>> +        mediatek,platform = <&afe>;
>>
>> Please:
>>
>> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
> Is it about the wrong pinctrl-names tab alignment ?
> Also, 2ND I2S BE => 2ND_I2S_BE ?
> Otherwise, I don't get it sorry.
> 

..as Krzysztof already clarified, won't repeat :-P

Cheers!

>>
>> Regards,
>> Angelo
>>
>>> +        pinctrl-names = "aud_default",
>>> +            "aud_dmic",
>>> +            "aud_miso_off",
>>> +            "aud_miso_on",
>>> +            "aud_mosi_off",
>>> +            "aud_mosi_on";
>>> +        pinctrl-0 = <&aud_default_pins>;
>>> +        pinctrl-1 = <&aud_dmic_pins>;
>>> +        pinctrl-2 = <&aud_miso_off_pins>;
>>> +        pinctrl-3 = <&aud_miso_on_pins>;
>>> +        pinctrl-4 = <&aud_mosi_off_pins>;
>>> +        pinctrl-5 = <&aud_mosi_on_pins>;
>>> +        vaud28-supply = <&mt6357_vaud28_reg>;
>>> +
>>> +        /* hdmi interface */
>>> +        dai-link-0 {
>>> +            sound-dai = <&afe>;
>>> +            link-name = "2ND I2S BE";
>>> +
>>> +            codec {
>>> +                sound-dai = <&it66121hdmitx>;
>>> +            };
>>> +        };
>>> +    };
>>>
>>
> 



