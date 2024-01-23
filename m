Return-Path: <linux-kernel+bounces-35220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F053838DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2023F1F2497B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CAC5D91C;
	Tue, 23 Jan 2024 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TeJxYeeY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E775D8F7;
	Tue, 23 Jan 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010727; cv=none; b=HOpc96EXzZ8kyipAt3tv1z4HK5EpBj4GRxX0ST0sKYh31YC67K4sE0AUas63NCl354dBwgSUEHnMFHM5yMkLWLL06WLFkMxd+bT0antKt3fiCMBPcJbkeSy/u8rbzLMtobZOlYm219mRDfl0qBZavytFlGV+XFbePDPv8HAVQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010727; c=relaxed/simple;
	bh=CTJyc7lWxBIMIku8+r43eFfZ6jrdhpZoucjgq5lQsds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgXQUjDFN54M3VQy0HtAA0xvrnNuPm6j03cxEFA6QJOpJKnW4iALWp5arKPS+hDApWKs4P3nEPJ1azp081Q7sGfX7N68WXAL/F0Q3um6yZ16SEjiaGkMEu0xGyrqE/ZbvsEoV8i8GqCOZwZwrvwamB8Cs/kh8ZWJ3vruee5QQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TeJxYeeY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706010724;
	bh=CTJyc7lWxBIMIku8+r43eFfZ6jrdhpZoucjgq5lQsds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeJxYeeYccoqWHsL0SfusKYd5T5m+UBKllmxMZLU0x++aiKOUxmMEzgR0UXQJLEru
	 yF8wVjawFulrJaXP3yDjEXbJt/17DEeuaboXGA0WEK1RhwWP9RO8BpxdDBo99wRaE7
	 8DDnejk/6IB0gdiPj+tNyrDmLTwMhtqW/QnWKurJgoF629e42UZrpo98DknhmjormF
	 ezVRPT6W+95Cxc/KMyisWpEL8L7EPzd4Dq5bNg5fRFtNihkXMlL1M5TLUt2pAg1T2W
	 g9h5LMBcqLVhkeXCB4QfwgljsUFCriqpVJ6QbniMGSmjl4oEIQi8AvxKZu9IWnm5dj
	 z8d6sY4IAprRQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F26FC3781FD9;
	Tue, 23 Jan 2024 11:52:02 +0000 (UTC)
Message-ID: <ba53cd50-dedd-43a7-9183-83caca16b637@collabora.com>
Date: Tue, 23 Jan 2024 12:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
 dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
 andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
 tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
 <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
 <20240119-remedial-unripe-2a3a46b4f117@spud>
 <9605c20a-12ad-49ad-8114-d59f2f772514@collabora.com>
 <20240122-delouse-popsicle-a6f94cce9fb4@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240122-delouse-popsicle-a6f94cce9fb4@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/01/24 19:06, Conor Dooley ha scritto:
> On Mon, Jan 22, 2024 at 11:27:11AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 19/01/24 17:18, Conor Dooley ha scritto:
>>> On Fri, Jan 19, 2024 at 01:58:11PM +0100, AngeloGioacchino Del Regno wrote:
>>>> Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
>>>> used for connecting, disconnecting and switching orientation and
>>>> control the SBU signals for alternate modes on USB Type-C ports.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../devicetree/bindings/usb/ite,it5205.yaml   | 72 +++++++++++++++++++
>>>>    1 file changed, 72 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/ite,it5205.yaml b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
>>>> new file mode 100644
>>>> index 000000000000..36ec4251b5f2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: ITE IT5202 Type-C USB Alternate Mode Passive MUX
>>>> +
>>>> +maintainers:
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +  - Tianping Fang <tianping.fang@mediatek.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: ite,it5205
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  vcc-supply:
>>>> +    description: Power supply for VCC pin (3.3V)
>>>> +
>>>> +  mode-switch:
>>>> +    description: Flag the port as possible handle of altmode switching
>>>> +    type: boolean
>>>> +
>>>> +  orientation-switch:
>>>> +    description: Flag the port as possible handler of orientation switching
>>>> +    type: boolean
>>>> +
>>>> +  ite,ovp-enable:
>>>> +    description: Enable Over Voltage Protection functionality
>>>> +    type: boolean
>>>
>>> Bitta devil's advocacy perhaps, but why is this DT property? Is it not
>>> known whether or not this is supported based on the compatible, and
>>> whether or not to enable it is a decision for the operating system to
>>> make?
>>>
>>>
>>
>> AFAIK, not all board designs can use the OVP. On some, this may be unstable - the
>> use case where this can be safely enabled is when there's nothing in between the
>> mux and the controller, and between the mux and the port.
> 
> Okay, if it varies based on the configuration that makes sense. Perhaps
> in the future consider mentioning stuff like that in the commit message.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

You're right, it's totally sensible to write that in the commit message,
will do next time.

P.S.: I have been too much impatient and already sent a v3 because I had to
fix an issue with the code, could you please give your R-b to the v3 as well?
There's no change in the bindings commit.

https://lore.kernel.org/r/20240122110446.140226-2-angelogioacchino.delregno@collabora.com

Thanks again,
Angelo



