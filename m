Return-Path: <linux-kernel+bounces-39900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4583D72F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668BB1C2B3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE866B54;
	Fri, 26 Jan 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CFE0E9XX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCC65BBB;
	Fri, 26 Jan 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260373; cv=none; b=kpRRRBQ87m5DPN80MHQG5yUUhz6c33z3w3KyQmAJkcZ3CqM61YpO1XOVDwqMC6mWwXSr5oili88wrD3DFRjQQfccqM8SFT9kHex/aYoHDFM995yIhE9GvgGhNvBM038T5prrbv9utpwsA2ozoZtwBfM5GKwkLJTHTixWmyJK9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260373; c=relaxed/simple;
	bh=ZoRSJvoWqKga1SG2FFzE2w6OD+wWH46tFmixAACobBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NymuNqwF7EIStNPPzfo6ysjo0T1xChGXF+nYUOmVutnwSMROdmOVyMwtMBQUIGpKEaZZQsBZ0XRcKcboqmjPMpVxkPNsPta6Tt1qfYCjRIqxq5A+3s8HWc8vCWgMB/aj/R+i4tglXTvWGI8MCMNrxFbiq9gCWWGojur7mf6usSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CFE0E9XX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260370;
	bh=ZoRSJvoWqKga1SG2FFzE2w6OD+wWH46tFmixAACobBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFE0E9XXR9BWxs45HlGn7FRIOAj7TxaAi78vLgkJJbntjVkegYxIJ2ZIByVPlrRCM
	 8UGtochIV68ovE5QoG+zzAS0OIzy5Kbj86EiqA3NgXQL8Bt9hjnLyPzg0o7Cin8+ot
	 VNWTOx9qO16+aPEHIFL0TJ+vwHh2wqdSGeS9SbNWL+hGZbR1n1E5nHZyKl11AVd7zZ
	 hadui7C8Gv4rcFkeidmOzxTqKO3asz/XZUm2zjYqpguY5Cr5UYMCcl8voFmLn9G6CE
	 GEn/BBbP/HhwypxMtQPK+qtDEHfPos50OH1vm3tHZGt4VnqiQK0oqol4voiNP6yGQF
	 ExZYWNJedohGQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7EB853782072;
	Fri, 26 Jan 2024 09:12:49 +0000 (UTC)
Message-ID: <dc6f77bd-6671-43eb-8658-626b2591415d@collabora.com>
Date: Fri, 26 Jan 2024 10:12:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240125095240.2308340-1-wenst@chromium.org>
 <20240125095240.2308340-2-wenst@chromium.org>
 <68249675-4081-48d9-abbb-1b2e49894fae@collabora.com>
 <CAGXv+5GG+Ko4nZKCvpQ2TnjeHDKWi5qS_SWAgLcrZ6fn_ySiug@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GG+Ko4nZKCvpQ2TnjeHDKWi5qS_SWAgLcrZ6fn_ySiug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/01/24 04:26, Chen-Yu Tsai ha scritto:
> On Thu, Jan 25, 2024 at 7:39 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 25/01/24 10:52, Chen-Yu Tsai ha scritto:
>>> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
>>> SDIO. While the Bluetooth function is fully discoverable, the chip
>>> has a pin that can reset just the Bluetooth side, as opposed to the
>>> full chip. This needs to be described in the device tree.
>>>
>>> Add a device tree binding for MT7921S Bluetooth over SDIO specifically
>>> ot document the reset line.
>>>
>>> Cc: Sean Wang <sean.wang@mediatek.com>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>    .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
>>>    MAINTAINERS                                   |  1 +
>>>    2 files changed, 50 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
>>> new file mode 100644
>>> index 000000000000..bbe240e7cc40
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek MT7921S Bluetooth
>>> +
>>
>> title:
>>
>> maintainers:
>>
>> description:
>>
>> ... and then, you missed
>>
>> allOf:
>>     - $ref: bluetooth-controller.yaml#
> 
> (facepalm)
> 
>> Everything else looks good.
>>
>> Cheers,
>> Angelo
>>
>>> +description:
>>
>> MT7921S is a (dual?) SDIO-attached dual-radio WiFi+Bluetooth combo chip;
>> this chip has two dedicated reset lines, one of which is used to reset
>> the Bluetooth core.
>> The WiFi part of this chip is described in ....where? :-)
> 
> The function itself is fully probable and the implementation doesn't make
> use of the WiFi's reset line, so I don't see any reason to describe it?
> I don't actually know what the reset line does in the chip hardware.
> This patch is just described what is already used.
> 
>>> +  This binding describes the Bluetooth side of the SDIO-attached MT7921S
>>> +  WiFi+Bluetooth combo chips. These chips are dual-radio chips supporting
>>> +  WiFi and Bluetooth. Bluetooth works over SDIO just like WiFi. Bluetooth
>>> +  has its own reset line, separate from WiFi, which can be used to reset
>>> +  the Bluetooth core.
>>> +
>>> +maintainers:
>>> +  - Sean Wang <sean.wang@mediatek.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt7921s-bluetooth
>>> +  reg:
>>> +    const: 2
>>> +
>>> +  reset-gpios:
>>> +    maxItems: 1
>>> +    description: A GPIO line connected to the Bluetooth subsystem reset line.
>>> +      Typically the W_DISABLE2# pin on M.2 E-key modules. If present this
>>> +      shall be flagged as active low.
>>
>> description:
>>     An active-low reset line connected for the Bluetooth core;
> 
> connected to?

Eh yes, sorry - I edited that statement multiple times and that "for" stuck
there for reasons :-)

> 
>>     on typical M.2 Key-E modules this is the W_DISABLE2# pin.
> 
> Otherwise this looks better. Thanks.

You're welcome!

Cheers!

> 
> 
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    mmc {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        bluetooth@2 {
>>> +            compatible = "mediatek,mt7921s-bluetooth";
>>> +            reg = <2>;
>>> +            reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
>>> +        };
>>> +    };
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b64a64ca7916..662957146852 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13657,6 +13657,7 @@ M:    Sean Wang <sean.wang@mediatek.com>
>>>    L:  linux-bluetooth@vger.kernel.org
>>>    L:  linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>>>    S:  Maintained
>>> +F:   Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
>>>    F:  Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
>>>    F:  drivers/bluetooth/btmtkuart.c
>>>
>>



