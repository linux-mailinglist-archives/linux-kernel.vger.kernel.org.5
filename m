Return-Path: <linux-kernel+bounces-46003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D518084391E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148891C28FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D90605CC;
	Wed, 31 Jan 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lDQSfraS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16A5DF17;
	Wed, 31 Jan 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689934; cv=none; b=atcT0o8Fj1PLP3IseHZ+kM+mcvCfiTUJHbmBKzEZtJMl2hLW1HGR0fYlYQqO2W258Klevna315evt3Gk7xj6E/BkQoIJ/u0F5ZVYK0Qkti0nD8mLU5WIVJhZ41/4VO/3Eduqsh6x3tItzSSDYO7qWptHEn0wY7XMCGazQy9FUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689934; c=relaxed/simple;
	bh=LnrH8a5zYVpmAlRagGxradQPGUkv1B0XDLbxWC6rdmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ksl/91ngH02Nys0nrzpgyW1ooSmTpWrGA5lCHDsFYrC+jT2wbf9mB03BaG1IzJ28eWWnCxgjAfEZGoe8Y40Nm1F7fYhh8feUWHkfU5R4AaAqknsDRH1yfyPU6JI/L0/43pZTmVWlxVsa5WwelExbuiz0wdzpgA8uh+eQNclgoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lDQSfraS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706689930;
	bh=LnrH8a5zYVpmAlRagGxradQPGUkv1B0XDLbxWC6rdmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lDQSfraSCJwGUPW5n9z/BbT0hc5H5woZFWcMz7OmWUoONNJNka8sk8fzhPQ5ZJVX4
	 JtOqZTULJOVS9Lgl0KpXtULLXUqRyNZDpA2HtRPC46jTEktXLhyGAcx1s7+VfQCF/Z
	 8JwIwnbiuU6exVHUMgZo6Pfxc+9CabHXbXmq4n9/6P44t7Lu6bsUSERmjUjUL5bcDc
	 OHYI5CSyg0uLDfrerIBBUoC1dGX8qf3St3mRTTFKB10c7csVzrIFMj1osey0ATMvV0
	 7wPxXxJoQn3Tc4p+V3zz8JkS4RsqJuKTIgg28MNC/j8X1xhPmtPYMgl052FgMQrz5d
	 7bAyDN6ldt/1A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4543F37803EE;
	Wed, 31 Jan 2024 08:32:09 +0000 (UTC)
Message-ID: <7574acab-4a4e-4213-a477-5ef1870fe98a@collabora.com>
Date: Wed, 31 Jan 2024 09:32:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the
 json-schema
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240123082100.7334-1-zajec5@gmail.com>
 <20240123082100.7334-3-zajec5@gmail.com>
 <e17b85b1-7f1f-4b60-89b7-43f560466cc2@collabora.com>
 <20240130203413.GA2290196-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240130203413.GA2290196-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/01/24 21:34, Rob Herring ha scritto:
> On Tue, Jan 23, 2024 at 12:20:29PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 23/01/24 09:20, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> This helps validating DTS files. Introduced changes:
>>> 1. Documented "reg" property
>>> 2. Adjusted "reg" in example
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>    .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 +++++++++++++++++++
>>>    .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
>>>    2 files changed, 47 insertions(+), 25 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>>    delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>> new file mode 100644
>>> index 000000000000..7340a2512402
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
>>
>> I think that we should really move all those clock controller yaml files to their
>> proper directory, which would be
>>
>> Documentation/devicetree/bindings/clock/
>>
>> ...because those are clock controllers anyway and the fact that they do also
>> provide a reset controller doesn't really justify having them in arm/mediatek.
>>
>> Besides, I would appreciate if you could also move mt8186/92/95 and eventual
>> others that are there to clock/.
> 
> Yes, please move it.
> 
>>
>>> @@ -0,0 +1,47 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pciesys.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek PCIESYS controller
>>> +
>>> +description:
>>> +  The MediaTek PCIESYS controller provides various clocks to the system.
>>> +
>>> +maintainers:
>>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - mediatek,mt7622-pciesys
>>> +          - mediatek,mt7629-pciesys
>>> +      - const: syscon
>>
>> I know that there's syscon all over the place and, even if I admit I didn't check,
>> I am fairly sure that there's absolutely no reason to have syscon there, and that
>> the syscon compatible never did anything for (most of, or all of) those clock
>> controllers, at all.
>>
>> I'm not sure - though - if removing syscon during the txt->yaml conversion is
>> acceptable (yeah we'd be cheating a bit), but something makes me say it is, because
>> the bindings couldn't validate before that one as well.
> 
> As long as you state why you are removing it in the commit msg.
> 
>>
>> Of course you'd have to remove the syscon compatible from the affected device trees
>> as well as omitting it here.
> 
> You could also do 'minItems: 1' and 'deprecated' in the 2nd item.
> 

That too. Yes. But I still really want to see the syscon compatible removed from
the device trees on those nodes because it doesn't make any sense to have it :-)

>> However, to be sure that we're doing the right thing here, I have to summon someone
>> that can actually give a definitive answer to what I just said.....
>>
>> Krzysztof, please? :-)




