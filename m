Return-Path: <linux-kernel+bounces-148837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA48A87F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753E1288BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B415B98B;
	Wed, 17 Apr 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hmincq7d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7133E493;
	Wed, 17 Apr 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368357; cv=none; b=uAx7pV4bhAgy31QacDohxkRuJx0i9zqcXZl5RGkwwJDWnhVZLt/0mLtGIVax16Q+DR/PQvQ3dsyAaIyxgoi8MmCkAXzv4vu7MU/FSwavFwWPhITsWFsSkV4ac9ymCQyFpvmyWsb0Si3wtouvoRkKrHr/etWV311fnAoo9EX8PB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368357; c=relaxed/simple;
	bh=I5hIRtUrBrDsG+h5jPN51ir1mk5P5T2b5m9gyZaZzmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMNqa6JFSSl2MEQwnJH2dDlBZtPoJ/qBRjg6VnmdGmp7fLWwNjUSHdNOJu1SM0rZrdrMf9hiHu+Mk3tc9ZZ5wWMIiHHjZzB13B+Ff+WTGPwgMroist8ymXFjIUI/vjL9r7Grk5u6sPFek0kCfL144QqgH6Dp7BlY+Y1TH4vIGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hmincq7d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713368354;
	bh=I5hIRtUrBrDsG+h5jPN51ir1mk5P5T2b5m9gyZaZzmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hmincq7dtHvoqMye61mzj+V5WEVKSIUpZh581SxDvrE5HZRosL7ef6VdLEsNenLC9
	 +c5680W/rLZjaqGTsrV3q0KvkAsPTpL4UHiJaAhki7uJJBA0wH2TPNOjeEaL2D93Ja
	 zittO0N3e/ytrc6hf1BfFV8NyA56jm+kxAaRojPcJTLR5a8vqmybHMNdF8IByHpvXm
	 FOyh1UvJ9OaISUFUur90F8Hx/uBl26jqPYUVjRFvzScQP0uZ5O62La2wLjY/JuONJn
	 NZK6I2z5GK/VI39wAq7gSjCFblL1jYv0TW8AGzy5isdvuK4dLLsOkuAnDIUmBHreTM
	 MMpMHxJ0sfhNg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 76BB83780629;
	Wed, 17 Apr 2024 15:39:13 +0000 (UTC)
Message-ID: <b728478d-d9c9-4256-aeab-a234316d81cc@collabora.com>
Date: Wed, 17 Apr 2024 17:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for MediaTek
 DVFSRC Regulators
To: Rob Herring <robh@kernel.org>
Cc: djakov@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
 henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
 <20240417145238.GA2348962-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240417145238.GA2348962-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/24 16:52, Rob Herring ha scritto:
> On Wed, Apr 17, 2024 at 11:14:36AM +0200, AngeloGioacchino Del Regno wrote:
>> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
>> are controlled with votes to the DVFSRC hardware.
>>
>> This adds support for the regulators found in MT6873, MT8183, MT8192
>> and MT8195 SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>> new file mode 100644
>> index 000000000000..446f1dab4d2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek DVFSRC-controlled Regulators
>> +
>> +description:
>> +  The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
>> +  are controlled with votes to the DVFSRC hardware.
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6873-dvfsrc-regulator
>> +      - mediatek,mt8183-dvfsrc-regulator
>> +      - mediatek,mt8192-dvfsrc-regulator
>> +      - mediatek,mt8195-dvfsrc-regulator
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  dvfsrc-vcore:
>> +    description: DVFSRC-controlled SoC Vcore regulator
>> +    $ref: regulator.yaml#
> 
>         unevaluatedProperties: false
> 

Will do!

>> +
>> +  dvfsrc-vscp:
>> +    description: DVFSRC-controlled System Control Processor regulator
>> +    $ref: regulator.yaml#
> 
> ditto
> 
>> +
>> +required:
>> +  - compatible
> 
> 'reg' is never optional. And how is no regulators at all valid?
> 

The two nodes that I'm adding with this series don't need reg, but others
that are not present in this do... but anyway, let's postpone that problem
for the future me, or the future-anyone-else implementing the rest, I will
remove the 'reg' property as it is indeed not needed for this node.

And yeah it's invalid to add that node without any regulator. Will check the
other regulator bindings on how they're doing it.


>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
> 
> Drop the example here. Just one complete example in the MFD doc.
> 

Oki, dropping in v3! That also resolves the circular dependency thing, so
that's even better.

>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        system-controller@10012000 {
>> +            compatible = "mediatek,mt8195-dvfsrc";
>> +            reg = <0 0x10012000 0 0x1000>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            regulators@0 {
>> +                compatible = "mediatek,mt8195-dvfsrc-regulator";
>> +                reg = <0>;
> 
> What does 'reg' value represent here? 0 and 1 seem pretty much made up.
> 

Gets removed in v3, tomorrow.

Cheers,
Angelo



