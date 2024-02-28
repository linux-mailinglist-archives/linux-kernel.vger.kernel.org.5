Return-Path: <linux-kernel+bounces-84752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482786AB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6A3B22D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71832C92;
	Wed, 28 Feb 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D+ffl35w"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7502E651
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111924; cv=none; b=MqxEUuoWNn+kHrGbjLv2KIBmL1Tia0G7MRhZtX4oVi6OFoAdNGj0XAk7IrtR2/Kv9Q5M3V1HNHKwgqZgT3VgtCCMI/qvI89taR8SwVRZE5nomzecD0sY/2XhBZytleonCCN96UlT0IU0c7bw2UC8rmBkTCGsn9MXPg8u3k7WD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111924; c=relaxed/simple;
	bh=WZLBLNg+kP4bFj20885+NwvSGeS+zQiSUEHm+m2WCvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7GJa1Bt+TSLF+eS2VRCdy/ciO+o6dPZ7Usf7WzLssTjvckKwLEYvf7wIU37LFOoYvFjReYNqlQNdXzI9njgpd8YOpPzAVABg5G2trudxT3Ocrf+5cAXPQt1kKaBWv8/WnwNrpWPKVbXwM32mB09Lr74aiibjQFHFR6H5s1Xigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D+ffl35w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so2915301f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709111920; x=1709716720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMmaHFxsdOxXG7OCPRHkrxQe1P3t75LjLh+737W0FeA=;
        b=D+ffl35wLHxDH8NF6bwf43hsbzTb6G2LsgCcTRpGO9ne97Jk/qozbuFMeuSWUAneOW
         ENuKQAYesSHyoFlqWusJegeqkV/hovUwMQKxRAbciQLx0/gdB+3yMxkNnloxv8Gajfl7
         /eMAAhDVZ9M/L4KTa/WUFR9AcJEwRfpG8/uUn0RZH6mModMz0feWJjjF8Cc6ahE0szjT
         ODbrNwKUoCaLaoax4Vbm0kq4AkOFLPfy/K1ct+zTrrXSuKCyGTqz5XlMvE3dYYJAVv01
         K0wt4WlHb+crZ3YWmEWFYnqk6nOnlBKbiYX7XXUlrl6jIksMuyAk+yTwts9x6wMHGNy3
         NovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111920; x=1709716720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMmaHFxsdOxXG7OCPRHkrxQe1P3t75LjLh+737W0FeA=;
        b=Do2jchmHDSFyR5cagvNBXA7IIaOyGxIWMn3dQq5mdF8tiobEDDx0es0MFBjJcdb2Kt
         mcT9P5Dq7HsqMiWCv7StyxREhqeIdBvAAC8u33PrX+dn8zGggmY5ZDYQm7fbBWzBvNkd
         +2kuKTXuElfhXfi3ZwZgJ1ftZ+eStEhUaeZxAWYpNla2W4lQHlw0U7qOs25judyhHrRo
         ciONS/UVL/GpWC6GU6v8bKmkhbKPaatfUkN9bJPmFJHjDFq0CW6AlA8nKXd+BQ+Mg1TH
         ABA8s9mSr3sdGK+lZLAsUiAQjjqh9uvQ7KLKXEmebY5E/V5mSvSZc+6sU2DgOE/CZANc
         kPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8LJoVuCwmqhCZGH7qURIm7vV8cBmIIuqpZ7FrbkGaM2e7pnAaBAC9EIYu8/a5KxBx3BxjwF59l0cj65f8wDZ4b5XMqqpqBQ5jf/uc
X-Gm-Message-State: AOJu0YwuwueHKIm6HDnS5VAmeuMP5cDrfcpC1bZHBdgEpb/TdtvZSESd
	/UztHgd3l2Ljcn4YLEmKTSCfuhbxklW7IxpCWM3Rrq+vly7QqdyfX9PynIPLWww=
X-Google-Smtp-Source: AGHT+IHl+T1jJDOelrcnlLr/v3d1Q6gKha6LkXJVtKyTJdnBjWcimArxu7uFwJpoiZ24rSsAKDTJ4Q==
X-Received: by 2002:adf:fd8e:0:b0:33d:af84:2a59 with SMTP id d14-20020adffd8e000000b0033daf842a59mr7977078wrr.28.1709111919598;
        Wed, 28 Feb 2024 01:18:39 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600003ce00b0033dd06e628asm10602047wrg.27.2024.02.28.01.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:18:39 -0800 (PST)
Message-ID: <77509c18-a4a8-4803-8370-cdcaa175ada1@baylibre.com>
Date: Wed, 28 Feb 2024 10:18:38 +0100
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
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
 <e0907559-121f-4cdf-8b5a-744295ec85b3@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <e0907559-121f-4cdf-8b5a-744295ec85b3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/02/2024 13:38, AngeloGioacchino Del Regno wrote:
> Il 27/02/24 11:23, Alexandre Mergnat ha scritto:
>>
>>
>> On 26/02/2024 16:30, AngeloGioacchino Del Regno wrote:
>>> Il 26/02/24 15:01, Alexandre Mergnat ha scritto:
>>>> Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.
>>>>
>>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>>> ---
>>>>   .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 127 
>>>> +++++++++++++++++++++
>>>>   1 file changed, 127 insertions(+)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>>>> new file mode 100644
>>>> index 000000000000..f469611ec6b6
>>>> --- /dev/null
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>>>> @@ -0,0 +1,127 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/sound/mediatek,mt8365-mt6357.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Mediatek MT8365 sound card with MT6357 sound codec.
>>>> +
>>>> +maintainers:
>>>> +  - Alexandre Mergnat <amergnat@baylibre.com>
>>>> +
>>>> +description:
>>>> +  This binding describes the MT8365 sound card.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: mediatek,mt8365-mt6357
>>>> +
>>>> +  mediatek,hp-pull-down:
>>>> +    description:
>>>> +      Earphone driver positive output stage short to the
>>>> +      audio reference ground.
>>>> +      Default value is false.
>>>> +    type: boolean
>>>> +
>>>> +  mediatek,micbias0-microvolt:
>>>> +    description: |
>>>
>>> description: Selects MIC Bias 0 output voltage
>>>
>>>> +      Selects MIC Bias 0 output voltage.
>>>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>>
>>> No, you don't say 0 1 2 3 4 to a property that says "microvolt", 
>>> that's simply
>>> wrong.
>>>
>>> mediatek,micbias0-microvolt = <2100000>;
>>>
>>> ...so you want a binding that says
>>> enum: [ 1700000, 1800000, this, that, 2700000]
>>>
>>
>> Is it correct if I put "description: Selects MIC Bias 0 output voltage 
>> index" ?
>>
> 
> No, it's still not correct. You have to pass microvolt values.
> 
> The driver will then transform the microvolt values to the index and 
> subsequently
> write the index value to the hardware registers.
> 
> The bindings shall be generic, in the sense that they shall not express 
> hardware
> register values... and this is especially true when we have a value that 
> *does*
> actually have means to be expressed in common units.
> 
> Besides, in the cases in which there's no common units involved, the 
> values most
> probably won't be suited for devicetree//bindings, so those would be 
> hardcoded in
> the driver as platform data.
> 
> This is not the case, so, please keep this property but specify 
> microvolts in the
> bindings (and obviously in devicetree).

Got it, thx !

> 
>>>> +
>>>> +  mediatek,micbias1-microvolt:
>>>> +    description: |
>>>> +      Selects MIC Bias 1 output voltage.
>>>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>>>
>>> same here.
>>>
>>>> +
>>>> +  mediatek,platform:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: The phandle of MT8365 ASoC platform.
>>>> +
>>>> +  pinctrl-names:
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - const: aud_default
>>>> +      - const: aud_dmic
>>>> +      - const: aud_miso_off
>>>> +      - const: aud_miso_on
>>>> +      - const: aud_mosi_off
>>>> +      - const: aud_mosi_on
>>>> +
>>>> +  vaud28-supply:
>>>> +    description:
>>>> +      2.8 volt supply for the audio codec
>>>> +
>>>> +patternProperties:
>>>> +  "^dai-link-[0-9]+$":
>>>> +    type: object
>>>> +    description:
>>>> +      Container for dai-link level properties and CODEC sub-nodes.
>>>> +
>>>> +    properties:
>>>> +      codec:
>>>> +        type: object
>>>> +        description: Holds subnode which indicates codec dai.
>>>> +
>>>> +        properties:
>>>> +          sound-dai:
>>>> +            maxItems: 1
>>>> +            description: phandle of the codec DAI
>>>> +
>>>> +        additionalProperties: false
>>>> +
>>>> +      link-name:
>>>> +        description:
>>>> +          This property corresponds to the name of the BE dai-link 
>>>> to which
>>>> +          we are going to update parameters in this node.
>>>> +        items:
>>>> +          const: 2ND I2S BE
>>>> +
>>>> +      sound-dai:
>>>> +        maxItems: 1
>>>> +        description: phandle of the CPU DAI
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +    required:
>>>> +      - link-name
>>>> +      - sound-dai
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - mediatek,platform
>>>> +  - pinctrl-names
>>>> +  - vaud28-supply
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    sound {
>>>> +        compatible = "mediatek,mt8365-mt6357";
>>>> +        mediatek,platform = <&afe>;
>>>
>>> Please:
>>>
>>> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>
>> Is it about the wrong pinctrl-names tab alignment ?
>> Also, 2ND I2S BE => 2ND_I2S_BE ?
>> Otherwise, I don't get it sorry.
>>
> 
> ...as Krzysztof already clarified, won't repeat :-P

Yes it is, I will fix that.

> 
> Cheers!
> 
>>>
>>> Regards,
>>> Angelo
>>>
>>>> +        pinctrl-names = "aud_default",
>>>> +            "aud_dmic",
>>>> +            "aud_miso_off",
>>>> +            "aud_miso_on",
>>>> +            "aud_mosi_off",
>>>> +            "aud_mosi_on";
>>>> +        pinctrl-0 = <&aud_default_pins>;
>>>> +        pinctrl-1 = <&aud_dmic_pins>;
>>>> +        pinctrl-2 = <&aud_miso_off_pins>;
>>>> +        pinctrl-3 = <&aud_miso_on_pins>;
>>>> +        pinctrl-4 = <&aud_mosi_off_pins>;
>>>> +        pinctrl-5 = <&aud_mosi_on_pins>;
>>>> +        vaud28-supply = <&mt6357_vaud28_reg>;
>>>> +
>>>> +        /* hdmi interface */
>>>> +        dai-link-0 {
>>>> +            sound-dai = <&afe>;
>>>> +            link-name = "2ND I2S BE";
>>>> +
>>>> +            codec {
>>>> +                sound-dai = <&it66121hdmitx>;
>>>> +            };
>>>> +        };
>>>> +    };
>>>>
>>>
>>
> 
> 

-- 
Regards,
Alexandre

