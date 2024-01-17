Return-Path: <linux-kernel+bounces-28718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94570830237
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158AF283C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3D14A93;
	Wed, 17 Jan 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrrY6tP0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB914A8F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483342; cv=none; b=iWo9aapSkEEbknRI5TTtgZSpLpp9P2aQ/1RujK0yquF7NZoi1oNn9Lq1cAsvptO4ygDy3zUzQCrHbAq2oumSDlNuhTtIKGWBzn6TjJI2A87n3BbVyWwL+6zN7bggcx5oyNGBKBFZLbs2hz6+zJrmbETC/WeattgAHrRRpPHzhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483342; c=relaxed/simple;
	bh=dpzglzJurMxSCQTFl+XPfTckslJTglJLwWuLrOLgk9c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=a5MUVNPTJAPIJsFbVL+19VbTUCfFlLjebBP922itvSP2gBgq+OGb2YBPjLscKNSDv1S61c+jI8a1Ip6H/H/2btXyo/6m8LJZ62BRO7ofDs/EV9F+f/SCBqOeOwOrRE9U11VJ0axkJwEqy86LsO0hIOjixgU4G7YhatPG04hXIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DrrY6tP0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so1177778566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705483338; x=1706088138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRmXVvhWhoxEmcKKaFlNQWbRI1Exhmn/kr3PCN1HDEw=;
        b=DrrY6tP07EDWBmeovuHSQ4rsZuWW9vofDh5eME5J1y06HgLc/0bbEMoo8A8HVG9aMs
         qw09JbJLt1ev+w852kcIkBbO/NRFm7CzYOFfwNNQ8C1THq/0CVK0jv7gl21p4UXaWDFo
         OVOmKWpbdbxKOpHN+bLtFU2khmcZTwZacAoOPBPZF68CVqlO8Btinz1P1e6uMPi+JQhR
         AC+kfSSotpiPCLO9Es5iaSFW89x35LL2h2gtgVTC5Z3TH4m0HCEhVpM2aAVf+k9dATNr
         UHjZGlyhA8d6EY89crHfupZAgGe4krOkrQoR9G1JUVCYB/rDDWLrCMRAlUzj+BDEvnZ1
         b4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705483338; x=1706088138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRmXVvhWhoxEmcKKaFlNQWbRI1Exhmn/kr3PCN1HDEw=;
        b=mwz4ElHVw1Nt2FwghvlFwe8w3PK2BjWqOwwwD3UKA9Lfy8lSpBtGPpWg4VGKC0yo0p
         eXp6EjKzdVZUiD2noRvVGHTblNVZYqlV/ZGxMhoCrzJAGXL+UHK+aHfhM8+JOEQAdSjE
         +MtBYrI5qZxDH1m1ufagunyusx/bvA+OuU33WkgGCbZBsxxWJ5paWIqADNAtwR1Vx65t
         VTOtr7/X6EfxrHzW4ues6DKRKw25G/D5OOoWK6xCJFLtXYP81ywfvQgJwMqFDMxipDq8
         ajiQ+sMuwDPFMa7ocZhdlEQpJNcQdF2u8qdqomIJgqvq0NAKdsK+iDRvcvVB8AMqH3b6
         eLVQ==
X-Gm-Message-State: AOJu0YzIw/hdTCPHw62p2iKqcIV99ZbzIPVTkEUDEy9QcHVrabcUTrR8
	NJGP795AE4vIRmb//J1FmY8cCSdzxoRG0g==
X-Google-Smtp-Source: AGHT+IESdSba8yshOtaaMo6hhj4oAlQExRWri+qaeiNrgD572/lV8nV1nkko9YqY6Zi1G8lMN3EXLw==
X-Received: by 2002:a17:906:4907:b0:a28:e0a7:258e with SMTP id b7-20020a170906490700b00a28e0a7258emr4610787ejq.22.1705483338586;
        Wed, 17 Jan 2024 01:22:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906561200b00a2e99c12ea5sm1286967ejq.157.2024.01.17.01.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 01:22:18 -0800 (PST)
Message-ID: <b798a7cc-c9fd-4bc3-bb14-401e10e4eeb8@linaro.org>
Date: Wed, 17 Jan 2024 10:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for
 rk817 audio codec
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, Conor Dooley <conor@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-2-tim@feathertop.org>
 <20240116-mangle-parish-93b5cd672d17@spud>
 <72ed509c-f754-4e65-a65e-130185777c53@feathertop.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <72ed509c-f754-4e65-a65e-130185777c53@feathertop.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/01/2024 10:19, Tim Lunn wrote:
> 
> On 1/17/24 04:06, Conor Dooley wrote:
>> On Wed, Jan 17, 2024 at 12:21:00AM +1100, Tim Lunn wrote:
>>> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
>>> using the same rk817_codec driver. However it is missing from the
>>> bindings.
>>>
>>> Update dt-binding documentation for rk809 to include the audio codec
>>> properties. This fixes the following warning from dtb check:
>>>
>>> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>>>     'clock-names', 'clocks', 'codec' do not match any of the regexes:
>>>     'pinctrl-[0-9]+'
>>>
>>> Signed-off-by: Tim Lunn<tim@feathertop.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>> index 839c0521f1e5..bac2e751e2f2 100644
>>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>> @@ -12,7 +12,7 @@ maintainers:
>>>   
>>>   description: |
>>>     Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
>>> -  that includes regulators, an RTC, and power button.
>>> +  that includes regulators, an RTC, a power button, and an audio codec.
>>>   
>>>   properties:
>>>     compatible:
>>> @@ -93,6 +93,34 @@ properties:
>>>           unevaluatedProperties: false
>>>       unevaluatedProperties: false
>>>   
>>> +  clocks:
>>> +    description:
>>> +      The input clock for the audio codec.
>>> +
>>> +  clock-names:
>>> +    description:
>>> +      The clock name for the codec clock.
>>> +    items:
>>> +      - const: mclk
>> You have one clock only, why do you need to have clock-names?
> This is just documenting the existing rk817 codec driver, which is using 
> the name to get the clock:
> 
> devm_clk_get(pdev->dev.parent, "mclk");
> 
> Thus i dont think clock-names can  be removed in this case? atleast not 
> without patching the driver as well?
>>

Your commit msg claims this is for existing driver using rk817_codec. So
what about rk817? It does not use clocks?

Best regards,
Krzysztof


