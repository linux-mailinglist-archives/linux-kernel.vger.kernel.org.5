Return-Path: <linux-kernel+bounces-86372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E686C48C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1848BB2466C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB658100;
	Thu, 29 Feb 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KtDTxq4V"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8756B9F;
	Thu, 29 Feb 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197858; cv=none; b=aTPUub+1gfIK5de6OMoFfkqu6FMpP6iWzaJ69Z5+lUH1B+6dbI5u6xfCr+1PpoI3u1aDos+AVhJDFh5/F8A0KvNsGL1LD1H9kTOMGzTWvG+NqRrEIN/zUTCp+ZhOrrQGaUupj06TXaYAy0uPOrY2/frE9e3ovbJJtB1eTFapHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197858; c=relaxed/simple;
	bh=tMoK6FUDrp+xEG8MXayhffSTRD7uxqUF1bkVnmBImMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4vY0dn3vpRSaRFug4S9uagJ94UZHI8wxMNJ37OISHD+KQYlRZ/cqAeh2ti5+pULq+Af1UfNyWkReC/tTSFc5MRUSgsoqcFhqiOFtKxteLDAs5yNa51T5M32s7qsvpcmCALj//Gnfxyzt2AZ1MniG+s8t78debQsW8hllmDL/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KtDTxq4V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709197854;
	bh=tMoK6FUDrp+xEG8MXayhffSTRD7uxqUF1bkVnmBImMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KtDTxq4V3x/7beEZJLQtt9sgmRHBSvg/iHZy67n6EW9QHLdWyqz81tEjnaKTyzSZV
	 5WX3+Ap8ApXEP73J+CLua4FBE+2PbaZkEb3oVvx5CDWVWuDC7EFVGbrTESfNhSNnup
	 a7cMbtqfDTELG+px0dKfZ1jqSgl0uBKjlqfEz8yOsbAaIXS5nhFxaU+nc3ETL6uc0c
	 L4r6N4ONHDMOxQhGcj+hBK2CTYFLUSOsHTmj3W2h8o3vS8Ut5bBwwy00iRNUApmRhz
	 tIXsllfe4sETzKGc6dgkUyCYFCzFQQeI+qeteGp4EO3AJ1lMPuL40wE55DsGC6+knB
	 cXmIUlEmkuPVw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 764DB3780F7F;
	Thu, 29 Feb 2024 09:10:52 +0000 (UTC)
Message-ID: <37181fc1-a485-427c-b3d2-2fcfb192e6e9@collabora.com>
Date: Thu, 29 Feb 2024 10:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] ASoC: dt-bindings: mt8195: Document audio-routing
 and dai-link subnode
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, broonie@kernel.org
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
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
 <20240227120939.290143-19-angelogioacchino.delregno@collabora.com>
 <32ff2f66-7a94-41ed-b77b-f78da2e57446@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <32ff2f66-7a94-41ed-b77b-f78da2e57446@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 09:25, Krzysztof Kozlowski ha scritto:
> On 27/02/2024 13:09, AngeloGioacchino Del Regno wrote:
>> Document the dai-link subnodes and the audio-routing property, allowing
>> to describe machine specific audio hardware and links in device tree.
>>
>> While at it, also deprecate the old properties which were previously
>> used with driver hardcoded configuration.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> 
>>   
>>     mediatek,adsp:
>>       $ref: /schemas/types.yaml#/definitions/phandle
>> @@ -45,12 +56,75 @@ properties:
>>         A list of the desired dai-links in the sound card. Each entry is a
>>         name defined in the machine driver.
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
> 
> That's not a list, but just enum.
> 

Ok! Will change for v2.

>> +          enum:
>> +            - DPTX_BE
>> +            - ETDM1_IN_BE
>> +            - ETDM2_IN_BE
>> +            - ETDM1_OUT_BE
>> +            - ETDM2_OUT_BE
>> +            - ETDM3_OUT_BE
>> +            - PCM1_BE
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
> 
> Ditto
> 
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
> 
> Ditto
> 
>> +          enum:
>> +            - cpu
>> +            - codec
>> +
>> +    additionalProperties: false
> 
> This goes either to the top of the section (after type:object) for
> readability or after required: block below.
> 

I think I actually saw this in some other binding, that's why it's there... or
maybe I am confusing something else - whatever.

I'll move it, anyway - thanks

>> +
>> +    required:
>> +      - link-name
>> +
>>   additionalProperties: false
> 
>>   
>>   required:
>>     - compatible
>>     - mediatek,platform
>>   
>> +# Disallow legacy properties if dai-link-xxx nodes are specified
>> +if:
>> +  not:
> 
> I don't think this works. To test if node is present or node, you would
> need to use required.
> https://elixir.bootlin.com/linux/v6.4-rc7/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L174
> 
> Are you sure this if:then: works as expected?
> 

Honestly, coming up with something that worked took me almost a full hour.
I was going a bit crazy over this one :-)

btw - Yes, it does work.

If you wanna give it a shot too, patch 21 and 22 are introducing the audio-routing
and (x)-dai-link nodes in (respectively) mt8195-cherry.dtsi and mt8186-corsola.dtsi
devicetrees - and those do validate just fine both with and without those patches.

I also tested this by adding the forbidden dptx-codec/hdmi-codec properties along
with the dai-link nodes in the example of this yaml file, and I've verified that
adding those makes the validation fail as expected.

Exactly, this is what I want and also what I've tested with dtbs/dt_binding_check:

fmt: (test nodes/properties) <- (result)

x-dai-link { ... }; mediatek,dptx-codec = <...>; <- FAIL (OK)
x-dai-link { ... }; mediatek,hdmi-codec = <...>; <- FAIL (OK)
x-dai-link { ... }; mediatek,dptx-codec = ..; mediatek,hdmi-codec .. <- FAIL (OK)

x-dai-link { ... }; (none of those two) <- PASS (OK)

(NO x-dai-link) mediatek,dptx-codec = <...> <- PASS (OK)
(NO x-dai-link) mediatek,hdmi-codec = <...> <- PASS (OK)
(NO x-dai-link) mediatek,dptx-codec = <...> mediatek,hdmi-codec = <...> <- PASS(OK)

..and of course, also tested the easy part
dai-link-x { ... }; <- FAIL (OK)    :-)

Cheers,
Angelo

> 
>> +    patternProperties:
>> +      ".*-dai-link$": false
>> +then:
>> +  properties:
>> +    mediatek,dptx-codec: false
>> +    mediatek,hdmi-codec: false
>> +
>>   examples:
>>     - |
>>   
> 
> 
> Best regards,
> Krzysztof
> 




