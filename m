Return-Path: <linux-kernel+bounces-64978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DD854563
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FFC292BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C714A93;
	Wed, 14 Feb 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rDMgrC6r"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77D91427F;
	Wed, 14 Feb 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903242; cv=none; b=MkM+wdcvl4wEYTf0Z6LE+oQ3EWuW9s275wDubuMYqtPeD8klT1A9lQFHl9nbTC+cdvTT+MK3VtY2SicpuwegqOQDAaMfYdQudBEhVwuRgv7fEf9DByTplxK6Vg9URN0H4vRTnutnEJurtseTKaS8h9eQ48oyiAM8GwPfvjKEsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903242; c=relaxed/simple;
	bh=U4bNMH+xtiCB6Y3mK6uVJUXqmlGYS1dPqnhcpgvAQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GspFXtVWEyJwsckBJSiBWZ6P9CoK5Rzn/i8y9XGGHwGGNBnSZlmTOfg1clDc9DtWtAaJ/RtY4GpFNbqaKRuBHjyVIJGrejShrT8ygkLJUVOD7DC7dy8c+/st7NxChkdelQkOmDpQ25tSqBKzXd1Tx2IIdQkW0Cl4zOV1aNLMO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rDMgrC6r; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707903238;
	bh=U4bNMH+xtiCB6Y3mK6uVJUXqmlGYS1dPqnhcpgvAQPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rDMgrC6rjZB/wQwJNDPBTssIhx6YtdbvO59smkyyIL2/OBTXaqrPZL+cF4R45oZs1
	 /HdY2mIKiqSR1mfojtQ2NUox3hQnvpMy1WZlMVPDuhBFwPE0wYXiNMUhOPhT+PdcGA
	 Si20XPPYL7ZSjL93bDlF68G8vD+9Kv9ESDhHcDkDUi7ThJm66cwp5XpxaDWLux9hqs
	 rdQHyJDWST73v+C4egSDmNxCdIN4ulD9+YSybmD8yPt+FhXxZUzcyF38b3VVrkbaZq
	 h02UjL0Y32yX4y7TSEeotI54jaHGLGrbNhe6rFBiKBZqO3lBEDUQ6FP7JWv/xrcyR1
	 WMp9oKkBefdCw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0AEF23782076;
	Wed, 14 Feb 2024 09:33:57 +0000 (UTC)
Message-ID: <b5dce02f-414a-42df-8210-3e80a769e324@collabora.com>
Date: Wed, 14 Feb 2024 10:33:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7988: add PWM controller
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213164633.25447-2-zajec5@gmail.com>
 <36baacb4-4aa9-421f-bde0-c4be7d7f4aa1@collabora.com>
 <bbacfaad-a182-4df5-8317-640e32a1954a@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <bbacfaad-a182-4df5-8317-640e32a1954a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/24 10:24, Rafał Miłecki ha scritto:
> On 14.02.2024 10:09, AngeloGioacchino Del Regno wrote:
>> Il 13/02/24 17:46, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Add binding for on-SoC controller that can control up to 8 PWMs.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 21 ++++++++++++++++++++-
>>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi 
>>> b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> index bba97de4fb44..67007626b5cd 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>>> @@ -1,5 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   / {
>>> @@ -78,7 +79,7 @@ gic: interrupt-controller@c000000 {
>>>               #interrupt-cells = <3>;
>>>           };
>>> -        clock-controller@10001000 {
>>> +        infracfg: clock-controller@10001000 {
>>>               compatible = "mediatek,mt7988-infracfg", "syscon";
>>>               reg = <0 0x10001000 0 0x1000>;
>>>               #clock-cells = <1>;
>>> @@ -103,6 +104,24 @@ clock-controller@1001e000 {
>>>               #clock-cells = <1>;
>>>           };
>>> +        pwm@10048000 {
>>> +            compatible = "mediatek,mt7988-pwm";
>>
>> I can't take this unless there's a driver that supports your device.
> 
> I'd argue you should rather look for a documented binding rather than a
> (Linux?) driver. Otherwise you would refuse changes that are not
> strictly Linux related. DTS files are meant to describe hardware in a
> generic way and not be driven by Linux drivers / design.
> 

Of course, devicetree describes hardware - that is pretty much globally known.

As I wrote in the bindings patch, I still anyway want to see the driver part
for this block before deciding if your description of this hardware is correct.

Regards,
Angelo


