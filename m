Return-Path: <linux-kernel+bounces-59153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E501E84F230
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EC91C214FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8567735;
	Fri,  9 Feb 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tFvDqK+k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC265BDB;
	Fri,  9 Feb 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470510; cv=none; b=OOqAkWkOhXLYOZJcN2726KqCo3dVvkh1u9uW8WsXuuJRt0s46c4m21KRXS9Q6LVT9QK4Yn/O3BCk7PYGW9S2+5XYt3SzRQIbbT+xEffAOBtpItm2T0Ww4m2rYbMExYC59NMe79rok/9A5i5bNwOzcmlQe9wri8XwPMtbF1L0gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470510; c=relaxed/simple;
	bh=JbZ74A9tk2UWT+VrLIApBOpqqPN0+cze41j1I55Ge6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF+R0NiCqHN4kCiqMUbgQ+I+/6iBZSog8OFcPoU0VTCbGB4E8U+Lg0IYeg5SAs5QjAMrNqMqBWmZDsUnTusY1TEANkoHabD/8/i2u0YW/uNhWVA+v2utImiJNjNYH5iD5mihKHWp4/TOSzlaWDQ8hIShWe+/F5YV9Hccn37IxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tFvDqK+k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707470507;
	bh=JbZ74A9tk2UWT+VrLIApBOpqqPN0+cze41j1I55Ge6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFvDqK+klPRWkB14WAgjKKUsbzaEZMT8Qt6Dtt0PHCBG3BTF+I7tmwXivMImqGlqk
	 DagdXAySSBDsAELUumgQ90DPTHZUHhKgAvW4sQhwhND6TX35JgguzCaOvyTb/SfDAP
	 hzgf5v2gDCsFqLXznwjS9ZW+lqpCuF+wCsEzju29gDkwSlXO7xW/yMiMK682HUEM3j
	 51/YLR51n2eL9Bqk8fWDMzddA4jsT1lCPwZqfwbvnn1HJVl1mK4isy5twQjsD3kdNn
	 sWDtug2YaCF+E/e73GFO1BorESezwL7SbmGBcRem4+8YETBlEXTsXTgA5rB2tc2P2T
	 VffYn3elHpc6A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 74EE837811F4;
	Fri,  9 Feb 2024 09:21:46 +0000 (UTC)
Message-ID: <185865bb-983e-467f-be2d-4978c8f4d6dc@collabora.com>
Date: Fri, 9 Feb 2024 10:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: mediatek: convert hifsys to the
 json-schema clock
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240208215926.10085-1-zajec5@gmail.com>
 <20240208215926.10085-2-zajec5@gmail.com>
 <d4a4a468-4a81-413e-9de6-060c2ba9e0b6@collabora.com>
 <502836d9-5a57-4614-b908-2adc0f01df33@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <502836d9-5a57-4614-b908-2adc0f01df33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/02/24 10:17, Krzysztof Kozlowski ha scritto:
> On 09/02/2024 09:53, AngeloGioacchino Del Regno wrote:
>> Il 08/02/24 22:59, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> This helps validating DTS files. Introduced changes:
>>> 1. Documented "reg" property
>>> 2. Documented "#reset-cells" property
>>> 3. Dropped "syscon" as it was incorrectly used
>>> 4. Adjusted "compatible" and "reg" in example
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>    .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
>>>    .../clock/mediatek,mt2701-hifsys.yaml         | 51 +++++++++++++++++++
>>>    2 files changed, 51 insertions(+), 26 deletions(-)
>>>    delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>>>    create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>>> deleted file mode 100644
>>> index 323905af82c3..000000000000
>>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>>> +++ /dev/null
>>> @@ -1,26 +0,0 @@
>>> -Mediatek hifsys controller
>>> -============================
>>> -
>>> -The Mediatek hifsys controller provides various clocks and reset
>>> -outputs to the system.
>>> -
>>> -Required Properties:
>>> -
>>> -- compatible: Should be:
>>> -	- "mediatek,mt2701-hifsys", "syscon"
>>> -	- "mediatek,mt7622-hifsys", "syscon"
>>> -	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
>>> -- #clock-cells: Must be 1
>>> -
>>> -The hifsys controller uses the common clk binding from
>>> -Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> -The available clocks are defined in dt-bindings/clock/mt*-clk.h.
>>> -
>>> -Example:
>>> -
>>> -hifsys: clock-controller@1a000000 {
>>> -	compatible = "mediatek,mt2701-hifsys", "syscon";
>>> -	reg = <0 0x1a000000 0 0x1000>;
>>> -	#clock-cells = <1>;
>>> -	#reset-cells = <1>;
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>>> new file mode 100644
>>> index 000000000000..eb429337cdf4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>>> @@ -0,0 +1,51 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek hifsys controller
>>
>> Please, "MediaTek HIFSYS controller"
> 
> Them maybe "clock controller" or "clock and reset controller"?

Yeah, that's right, let's prefer "clock and reset controller", as this binding does
describe exactly only those two functionalities of the whole HIFSYS block.

Cheers,
Angelo

> 
> 
> Best regards,
> Krzysztof
> 




