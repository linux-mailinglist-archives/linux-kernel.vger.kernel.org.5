Return-Path: <linux-kernel+bounces-64959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D4854529
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996AC286C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA71642A;
	Wed, 14 Feb 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4uggz3V0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19651429C;
	Wed, 14 Feb 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902880; cv=none; b=XE58aZvStvjhIznJ/mUrji2H5u6HQOnxM5+Q02p9TGUrummMpupbVzxDPg6gb8yaQNmtGhax1T3/w/w5QNaRu6j4K50gvGuRmjilzUEOC0wZATlEIQrZvd6E1uce6jVwS4YvIwPY+xYNFs25za4CNmosZ+ei8QkPYIdjMwGS/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902880; c=relaxed/simple;
	bh=R7/bEBifI4lBAh8QUwfn+H3MAcMLkC8MOxtp6x/n10M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLLP0nyULMPB05MmIOFj/C7ttkD8947q1sQDtHVXm0lhzjEqbRkP+J2u675Y6zAkISwtKv969zMQIk2hmLnuo7qVLdaDrKFnUpp3C7Z0hy3adl/TN7dtf4ju3PUOhqX1DoClROrf4aUakC6D/c4CcIwV4h+TeDjzn2T4Bkyy7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4uggz3V0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707902876;
	bh=R7/bEBifI4lBAh8QUwfn+H3MAcMLkC8MOxtp6x/n10M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4uggz3V0Edxv8IP6cRbU05flDUjer1IhQ4PFjTRlQUhgVduHUEqnpHW8Yyrkwsz1z
	 sjZU2G8VmNpGDZ/ZLCnoWGrsECWcSlKn+UrXq0aJARQmubB0T9vXZNDct5ks00j1xp
	 gouKT9E02DbzrkddLKKJnCfwm0z0SmFeC6KjChIh2b5d9un4TFz7S0lAX3YDDjLi2i
	 OVDzwPrPBVsr8eHkabjEMthfceQ2mC49sVxKGSR+ts4dE2KhXN0vhmgecQXbG2csbq
	 HK3kP2gG+VcB6Dfnu6p3GxbPtxBPPvaNsRGhjGhQiq+NzvRLEa1wL08BAbxB6AA7Fc
	 pnQhu/Fs7tksg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3AD113781FEF;
	Wed, 14 Feb 2024 09:27:55 +0000 (UTC)
Message-ID: <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>
Date: Wed, 14 Feb 2024 10:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for
 MT7988
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
 <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/24 07:34, Rafał Miłecki ha scritto:
> On 13.02.2024 19:18, Conor Dooley wrote:
>> On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> MT7988 has on-SoC controller that can control up to 8 PWMs.
>>
>> I see a binding and a dts patch, but no driver patch, how come?
> 
> I believe that to avoid cross-trees patchsets (which are sometimes
> tricky for maintainers) there are two ways of submiting such changes:
> 1. dt-binding + driver; then (separately) DTS
> 2. dt-binding + DTS; then (separately) driver
> 
> I chose later in this case as my personal priority right now is to deal
> with all MediaTek DTS files.
> 
> Is that wrong or unacceptable?
> 

It's not wrong but it's partially unacceptable, at least on my side.

In my opinion (and I believe many do agree with me), sending the binding along
with the driver is the right choice, and if you also want to include the dts
that is also appreciated: series can go through multiple maintainers applying
subsets - it's ok to do.

I want to put emphasis on sending the binding with the driver, as this allows
for a better review on everyone's side because we do see the full picture and
we can give better advices: in this case, I'm not sure whether adding a new
compatible for MT7988 in an enum is a good idea, as the compatible string may
be shared with one of the *eleven* SoCs that are supported in the PWM driver,
meaning that (hardware speaking!) the PWM controller in 7988 might be the same
as the one in mt1234.

Thanks for the great work that you're doing on the bindings btw.
Keep it up!
Angelo

> 
>> Also, what makes this incompatibly different with the other devices in
>> the binding, like the 8183?
> 
> It can control 8 PWMs unlike any other SoC block except for MT2712.
> It uses different registers than MT2712 thought.
> 
> 
>> Cheers,
>> Conor.
>>
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml 
>>> b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>>> index 0fbe8a6469eb..a5c308801619 100644
>>> --- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
>>> @@ -24,6 +24,7 @@ properties:
>>>             - mediatek,mt7629-pwm
>>>             - mediatek,mt7981-pwm
>>>             - mediatek,mt7986-pwm
>>> +          - mediatek,mt7988-pwm
>>>             - mediatek,mt8183-pwm
>>>             - mediatek,mt8365-pwm
>>>             - mediatek,mt8516-pwm
>>> -- 
>>> 2.35.3
>>>
> 



