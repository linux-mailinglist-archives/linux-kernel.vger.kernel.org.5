Return-Path: <linux-kernel+bounces-95729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B48751CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C1E1F234AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588EC12E1CE;
	Thu,  7 Mar 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PIS1IorO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306D12C80A;
	Thu,  7 Mar 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821579; cv=none; b=DzPOFdiQ6fQFq5DMWhfGDhp09co1fh3NNUAgXJG2YEGClaxOBV8ilh4qwVpZfBu+JSbn2i+zh4vPTSR1EVN0jIlz+p+GcIaSHMv6fYiDQnLwsiCuk1k3pdA++iyVhj0cPYSW42P999V3iTMNSI62dLvDU1WZVFKy8TjWbkyGrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821579; c=relaxed/simple;
	bh=zuG49lDm461OS0LXDvrKEdM3DKMWByyShdxfkM/iKeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAYGpCNC7ajXY3FSq4mNCL7v4UtdWwWo7gB9Q+3+ENaG5Lb/4r+HjAiqtw5ObJGWBYTYPOrNnAvaFHgWVm9qoipjbdhWU1+YhCl1qIOK7716cSSeMGSainDNp7q22TrxWvsBMJcNGQrxR8ceLNABxI6VFtIC/CuLJVbZ8oodcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PIS1IorO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709821575;
	bh=zuG49lDm461OS0LXDvrKEdM3DKMWByyShdxfkM/iKeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PIS1IorOJ8seJQ91WxX7LitzHeOqiTMMCX1i0SX8RuBJWIekJxJvBaBfnO8RztfdA
	 V1O7QLfYDnyKqa5TPQL+wS7iztNrFyb4hN3IHcySPVz5uFMUJ0c6IvWBFuKR6jZKoH
	 vdMhYqsgP8jbQEaM0TmcFNmW7ehXXRVqfrH0ezl3oBIqu3Z8DgKXNbKRcg7xv5y2aQ
	 qN2Ec3YXAkLBLbzsQMSqvQZuZjXnmUjBPmMFIPwTIKiofbaxUx+ZUFyGaoFg90BqWl
	 afU31KaOJLE2qMKfbyRS+KXR1uxr0EFjbr/bOvGdFj/sfCyR66P2wxk3KHbMT1cRGP
	 RB0q8/JebPvWg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0DDB837809D0;
	Thu,  7 Mar 2024 14:26:13 +0000 (UTC)
Message-ID: <7fa3cd50-4603-4983-8396-ec8c90fd43fa@collabora.com>
Date: Thu, 7 Mar 2024 15:26:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] ASoC: dt-bindings: mt8192: Document audio-routing
 and dai-link subnode
Content-Language: en-US
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
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
 <20240227120939.290143-20-angelogioacchino.delregno@collabora.com>
 <20240304142341.GA156846-robh@kernel.org>
 <0aa3dc07-67c8-40a4-9e83-f702979765c5@collabora.com>
 <CAL_JsqLNsS_Rx5z5F1vrYbr2g+5-wGYOq6mhtfUd7Db11F0W+Q@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAL_JsqLNsS_Rx5z5F1vrYbr2g+5-wGYOq6mhtfUd7Db11F0W+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/03/24 15:03, Rob Herring ha scritto:
> On Tue, Mar 5, 2024 at 5:20 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 04/03/24 15:23, Rob Herring ha scritto:
>>> On Tue, Feb 27, 2024 at 01:09:36PM +0100, AngeloGioacchino Del Regno wrote:
>>>> Document the dai-link subnodes and the audio-routing property, allowing
>>>> to describe machine specific audio hardware and links in device tree.
>>>>
>>>> While at it, also deprecate the old properties which were previously
>>>> used with the driver's partially hardcoded configuration.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 129 ++++++++++++++++--
>>>>    1 file changed, 121 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>>>> index 7e50f5d65c8f..78e221003750 100644
>>>> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>>>> @@ -20,6 +20,15 @@ properties:
>>>>          - mediatek,mt8192_mt6359_rt1015p_rt5682
>>>>          - mediatek,mt8192_mt6359_rt1015p_rt5682s
>>>>
>>>> +  audio-routing:
>>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>>
>>> Already defined in sound-card-common.yaml. Add a $ref.
>>>
>>
>> Right. Done for v2.
>>
>>>> +    description:
>>>> +      A list of the connections between audio components. Each entry is a
>>>> +      pair of strings, the first being the connection's sink, the second
>>>> +      being the connection's source.
>>>> +      Valid names could be the input or output widgets of audio components,
>>>> +      power supplies, MicBias of codec and the software switch.
>>>
>>> Generally the names are defined here.
>>>
>>
>> ...but those drivers want to support multiple codecs and multiple boards, so
>> for each board we would maybe have to add (software defined) names in here
>> which don't always correspond to a HW pin name (but that's not really a problem).
>>
>> Sure a subset of the names can't change but, on the other hand, some others
>> can (as in, may be added).
>>
>> Hence the question:
>>
>> Is it mandatory to define the names in an enum here, or can that be avoided?
>> If it is, I can add them no problem.
> 
> Does the OS depend on what the names are? As-in if a name was "bar"
> and it changed to "baz" in either the DT or the kernel, would that
> break things? If yes, then yes, you need them defined here.
> 

Yes, I need them defined here, definitely.

>>
>>>> +
>>>>      mediatek,platform:
>>>>        $ref: /schemas/types.yaml#/definitions/phandle
>>>>        description: The phandle of MT8192 ASoC platform.
>>>> @@ -27,10 +36,12 @@ properties:
>>>>      mediatek,hdmi-codec:
>>>>        $ref: /schemas/types.yaml#/definitions/phandle
>>>>        description: The phandle of HDMI codec.
>>>> +    deprecated: true
>>>>
>>>>      headset-codec:
>>>>        type: object
>>>>        additionalProperties: false
>>>> +    deprecated: true
>>>>
>>>>        properties:
>>>>          sound-dai:
>>>> @@ -41,6 +52,7 @@ properties:
>>>>      speaker-codecs:
>>>>        type: object
>>>>        additionalProperties: false
>>>> +    deprecated: true
>>>>
>>>>        properties:
>>>>          sound-dai:
>>>> @@ -51,13 +63,83 @@ properties:
>>>>        required:
>>>>          - sound-dai
>>>>
>>>> +patternProperties:
>>>> +  ".*-dai-link$":
>>>> +    type: object
>>>> +    description:
>>>> +      Container for dai-link level properties and CODEC sub-nodes.
>>>> +
>>>> +    properties:
>>>> +      link-name:
>>>> +        description: Indicates dai-link name and PCM stream name
>>>> +        items:
>>>> +          enum:
>>>> +            - I2S0
>>>> +            - I2S1
>>>> +            - I2S2
>>>> +            - I2S3
>>>> +            - I2S4
>>>> +            - I2S5
>>>> +            - I2S6
>>>> +            - I2S7
>>>> +            - I2S8
>>>> +            - I2S9
>>>> +            - TDM
>>>> +
>>>> +      codec:
>>>> +        description: Holds subnode which indicates codec dai.
>>>> +        type: object
>>>> +        additionalProperties: false
>>>> +        properties:
>>>> +          sound-dai:
>>>> +            minItems: 1
>>>> +            maxItems: 2
>>>> +        required:
>>>> +          - sound-dai
>>>> +
>>>> +      dai-format:
>>>> +        description: audio format
>>>> +        items:
>>>> +          enum:
>>>> +            - i2s
>>>> +            - right_j
>>>> +            - left_j
>>>> +            - dsp_a
>>>> +            - dsp_b
>>>> +
>>>> +      mediatek,clk-provider:
>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>> +        description: Indicates dai-link clock master.
>>>> +        items:
>>>> +          enum:
>>>> +            - cpu
>>>> +            - codec
>>>> +
>>>> +    additionalProperties: false
>>>
>>> Move this before properties.
>>>
>>
>> Done for v2.
>>
>>>> +
>>>> +    required:
>>>> +      - link-name
>>>> +
>>>>    additionalProperties: false
>>>>
>>>>    required:
>>>>      - compatible
>>>>      - mediatek,platform
>>>> -  - headset-codec
>>>> -  - speaker-codecs
>>>> +
>>>> +allOf:
>>>> +  # Disallow dai-link-xxx nodes if the legacy properties are specified
>>>
>>> xxx-dai-link?
>>>
>>
>> Oh! Yes, thanks for catching this.
>>
>> That's what I initially wanted to do, but then I opted for xxx-dai-link and
>> forgot to update this comment.
>>
>> Fixed for v2.
>>
>>>> +  - if:
>>>> +      patternProperties:
>>>> +        ".*-dai-link$": false
>>>> +    then:
>>>> +      required:
>>>> +        - headset-codec
>>>> +        - speaker-codecs
>>>> +    else:
>>>> +      properties:
>>>> +        headset-codec: false
>>>> +        speaker-codecs: false
>>>> +        mediatek,hdmi-codec: false
>>>
>>> Allowing both would preserve compatibility. That's not needed? If so,
>>> say why in the commit msg.
>>>
>>
>> I'm thinking of writing:
>>
>> "Since describing machine specific audio hardware and links replaces the
>> now deprecated old logic doing the same in a driver hardcoded fashion,
>> it is not allowed to have both the old and new properties together."
> 
> What happened to that. Instead you just sent a new version with
> nothing about this.
> 

The same thing that happened to that card "model" error that shouldn't have
been there because I catched it before sending and fixed, then...

..I have ultimately sent the wrong changeset. My bad.

Anyway - since that's a bigger series, I'll wait for a few days and will
send the v3 with the names added to the audio-routing and this mentioned
in the commit description (so, that's happening next week).

>> ...but in short - both the old and the new can do exactly the same, but
>> imo it doesn't make any sense to actually rely on both as:
>>    1. It's redundant (and one set of them makes the other useless);
>>    2. I want to avoid confusion (as the other set won't be parsed);
>>    3. I'm trying to *enforce* consistency as MTK cards have different
>>       bindings for .. really, no good reason;
>>    4. I want to see custom stuff disappear completely (and/or as much as
>>       possible anyway) and use something that is (at least somewhat) common
>>       between all MTK and non-MTK or anyway as a start at least consistent
>>       between MTK cards.
>>
>> In theory, though, speaking of the driver side, there's nothing preventing
>> you from specifying both audio-routing xxx-dai-link and mediatek,hdmi-codec,
>> as the drivers' action will be, in short
>>      if (new_bindings)
>>        forget_about_old_bindings_use_the_new_ones();
>>      else
>>        use_old_hardcoded_stuff(); /* and be sad */
> 
> That works for newer kernels with this change, but existing kernels
> will only have:
> 
> use_old_hardcoded_stuff(); /* and not know it's sad */
> 
> If you want to support a new DT and old kernel, you need to populate
> both properties.
> 
>> For that, I really don't want to allow both sets of properties - please, please,
>> tell me that I don't *have to* remove this block :-)
> 
> Ultimately it is your decision as Mediatek maintainer, not mine. My
> only requirement is the commit message explain why the above
> combination is not important for these platforms.
> 
> You could leave it, but keep both in the dts files for some time
> period. That will cause warnings, but what's a few more. The ABI
> doesn't have to be a forever thing. Things evolve and there will be
> other reasons to upgrade.
> 

Thanks for explaining.

Cheers,
Angelo



