Return-Path: <linux-kernel+bounces-92257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA81871D96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C71F27754
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D05A4CD;
	Tue,  5 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TnYwIv7J"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493FC54BFA;
	Tue,  5 Mar 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637628; cv=none; b=ipIaA2msvDAoOn5YHpVeMgORd9OQuC0pQWvqDy5oqQHEyXb6XV7K2zJORqLIT7GwWvQwz9w3dQmk8DCqeBl/P5agkeDiwGCeQUVzB6RcJaP1IQAO5SJTBDdxoNhsS0hjPixco4a7pdGwyomWhzbAwY/GnlIROqNb6TaVAl2i58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637628; c=relaxed/simple;
	bh=GXsOiAtv6TjNhMlnQXhWlrYVpj/iqWoURTS8NBhzIFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzBof1bd+j5FibgCVrAaVBV60RKQbYGKlFw5jltShdWd/mPihIPjZ8358W0w2Wc400IMfr6DIUjimlXJLO5OLntbKJfwBzFQw9zE+WVS/WCBdpnk0/+K2Gz6xnPG/zxJM2DmYMmGPoQXp3Gg9mt9RnmIow6s7RUiAV7sntPZjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TnYwIv7J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709637624;
	bh=GXsOiAtv6TjNhMlnQXhWlrYVpj/iqWoURTS8NBhzIFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnYwIv7JyXG+1tKJY1L6QFhBK6hLNXIqXnVmCOWEAOQdyPpnpkH5LPB+kuT2LVCG/
	 Fj5f7vQbFC94/wLeTSHyQ3BNyuNUJQ8SHB1e5B7Uezm00IVPVQTOJr11SGWf4HqtzB
	 EYUbJxHjOQgVEGBpkDYQRtw08lcQvjiG8H1BAu5Px3MK3YNUxGvdqwQGUPtac5/l7P
	 aX9+cqGioGIisgyXez/GeONzviu8jgT1hqL6+wy0j9M3x4lpyfZYoTUlyh49nfc9mj
	 LkY/NUiCWcQ5e+Ljb4uHWVVR7xNtq1rkq/51wjcy2bq6zTvIahX2HEu+a2BYIIqyzs
	 /S9Y+DAD6lG+A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E69093780029;
	Tue,  5 Mar 2024 11:20:21 +0000 (UTC)
Message-ID: <0aa3dc07-67c8-40a4-9e83-f702979765c5@collabora.com>
Date: Tue, 5 Mar 2024 12:20:21 +0100
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240304142341.GA156846-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/03/24 15:23, Rob Herring ha scritto:
> On Tue, Feb 27, 2024 at 01:09:36PM +0100, AngeloGioacchino Del Regno wrote:
>> Document the dai-link subnodes and the audio-routing property, allowing
>> to describe machine specific audio hardware and links in device tree.
>>
>> While at it, also deprecate the old properties which were previously
>> used with the driver's partially hardcoded configuration.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 129 ++++++++++++++++--
>>   1 file changed, 121 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> index 7e50f5d65c8f..78e221003750 100644
>> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
>> @@ -20,6 +20,15 @@ properties:
>>         - mediatek,mt8192_mt6359_rt1015p_rt5682
>>         - mediatek,mt8192_mt6359_rt1015p_rt5682s
>>   
>> +  audio-routing:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> 
> Already defined in sound-card-common.yaml. Add a $ref.
> 

Right. Done for v2.

>> +    description:
>> +      A list of the connections between audio components. Each entry is a
>> +      pair of strings, the first being the connection's sink, the second
>> +      being the connection's source.
>> +      Valid names could be the input or output widgets of audio components,
>> +      power supplies, MicBias of codec and the software switch.
> 
> Generally the names are defined here.
> 

..but those drivers want to support multiple codecs and multiple boards, so
for each board we would maybe have to add (software defined) names in here
which don't always correspond to a HW pin name (but that's not really a problem).

Sure a subset of the names can't change but, on the other hand, some others
can (as in, may be added).

Hence the question:

Is it mandatory to define the names in an enum here, or can that be avoided?
If it is, I can add them no problem.

>> +
>>     mediatek,platform:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description: The phandle of MT8192 ASoC platform.
>> @@ -27,10 +36,12 @@ properties:
>>     mediatek,hdmi-codec:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>       description: The phandle of HDMI codec.
>> +    deprecated: true
>>   
>>     headset-codec:
>>       type: object
>>       additionalProperties: false
>> +    deprecated: true
>>   
>>       properties:
>>         sound-dai:
>> @@ -41,6 +52,7 @@ properties:
>>     speaker-codecs:
>>       type: object
>>       additionalProperties: false
>> +    deprecated: true
>>   
>>       properties:
>>         sound-dai:
>> @@ -51,13 +63,83 @@ properties:
>>       required:
>>         - sound-dai
>>   
>> +patternProperties:
>> +  ".*-dai-link$":
>> +    type: object
>> +    description:
>> +      Container for dai-link level properties and CODEC sub-nodes.
>> +
>> +    properties:
>> +      link-name:
>> +        description: Indicates dai-link name and PCM stream name
>> +        items:
>> +          enum:
>> +            - I2S0
>> +            - I2S1
>> +            - I2S2
>> +            - I2S3
>> +            - I2S4
>> +            - I2S5
>> +            - I2S6
>> +            - I2S7
>> +            - I2S8
>> +            - I2S9
>> +            - TDM
>> +
>> +      codec:
>> +        description: Holds subnode which indicates codec dai.
>> +        type: object
>> +        additionalProperties: false
>> +        properties:
>> +          sound-dai:
>> +            minItems: 1
>> +            maxItems: 2
>> +        required:
>> +          - sound-dai
>> +
>> +      dai-format:
>> +        description: audio format
>> +        items:
>> +          enum:
>> +            - i2s
>> +            - right_j
>> +            - left_j
>> +            - dsp_a
>> +            - dsp_b
>> +
>> +      mediatek,clk-provider:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        description: Indicates dai-link clock master.
>> +        items:
>> +          enum:
>> +            - cpu
>> +            - codec
>> +
>> +    additionalProperties: false
> 
> Move this before properties.
> 

Done for v2.

>> +
>> +    required:
>> +      - link-name
>> +
>>   additionalProperties: false
>>   
>>   required:
>>     - compatible
>>     - mediatek,platform
>> -  - headset-codec
>> -  - speaker-codecs
>> +
>> +allOf:
>> +  # Disallow dai-link-xxx nodes if the legacy properties are specified
> 
> xxx-dai-link?
> 

Oh! Yes, thanks for catching this.

That's what I initially wanted to do, but then I opted for xxx-dai-link and
forgot to update this comment.

Fixed for v2.

>> +  - if:
>> +      patternProperties:
>> +        ".*-dai-link$": false
>> +    then:
>> +      required:
>> +        - headset-codec
>> +        - speaker-codecs
>> +    else:
>> +      properties:
>> +        headset-codec: false
>> +        speaker-codecs: false
>> +        mediatek,hdmi-codec: false
> 
> Allowing both would preserve compatibility. That's not needed? If so,
> say why in the commit msg.
> 

I'm thinking of writing:

"Since describing machine specific audio hardware and links replaces the
now deprecated old logic doing the same in a driver hardcoded fashion,
it is not allowed to have both the old and new properties together."

..but in short - both the old and the new can do exactly the same, but
imo it doesn't make any sense to actually rely on both as:
  1. It's redundant (and one set of them makes the other useless);
  2. I want to avoid confusion (as the other set won't be parsed);
  3. I'm trying to *enforce* consistency as MTK cards have different
     bindings for .. really, no good reason;
  4. I want to see custom stuff disappear completely (and/or as much as
     possible anyway) and use something that is (at least somewhat) common
     between all MTK and non-MTK or anyway as a start at least consistent
     between MTK cards.

In theory, though, speaking of the driver side, there's nothing preventing
you from specifying both audio-routing xxx-dai-link and mediatek,hdmi-codec,
as the drivers' action will be, in short
    if (new_bindings)
      forget_about_old_bindings_use_the_new_ones();
    else
      use_old_hardcoded_stuff(); /* and be sad */


For that, I really don't want to allow both sets of properties - please, please,
tell me that I don't *have to* remove this block :-)

Cheers,
Angelo


