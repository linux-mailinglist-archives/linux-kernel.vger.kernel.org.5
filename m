Return-Path: <linux-kernel+bounces-31186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A91832A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4731C21253
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F73537FD;
	Fri, 19 Jan 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kntq0pj/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCA537E1;
	Fri, 19 Jan 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670400; cv=none; b=Q+EmDGlSd+i6DKyQxPGwXF2obOdzH7FeFXQII32A9ZALsdCnJj2rXjyApvKWQeoQBguNz44KIi+OyHRofwWaZC9cl+rWocR7o3i7kXD6P6FlePLQWWni4xFfR66ixFXDr/XZHUX9sDoSB5ngTyHbHDirBOpZH1JSWkTz9OWmOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670400; c=relaxed/simple;
	bh=cPa1Njg/pCuY3hx52fxHbNB8p1VX2bLRjH+N58V6590=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqFS38CwoH+ab6HuAeilujdLydphO3/RDYjqzH6h0YFX/4H8In8xs9zEn/20HlSyJ4/5Lpc9NNli66On3qII9wFxKgA4afVTfOib8KNgdp2e2P2V4mtAaAARQx/9XFm+0hoGwWX5iJAHVOzNYt7nXcO4gKgyWbuBVeDJ3PCsmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kntq0pj/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705670393;
	bh=cPa1Njg/pCuY3hx52fxHbNB8p1VX2bLRjH+N58V6590=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kntq0pj/dyZLGPDThya0vlrTj9ypbAVXXLMv2GVYTQ31sdSGevdDfdHytIOlJB9tp
	 mubrSa35sRTBvZwn4c5ZWH+c9Og/dBg0RXZWGhdosS9J0Nuv0d2jW2GKJ3fgxTRrOr
	 Viv52EpaMISDqdViPzxWwOd8Ht8oCSUi8pU4+2v/PRkZOvjLoliOXmBFKx4lgbDXrz
	 gRY8VsVcHokc8XIDM+Gp2te4LoKXs5ZkxWUjRb0bgE0oy9EO5FJnc8BS6tsRfBrxbx
	 lOl/i7ISn5WY5lBHAEVaCKUXMJZxhnZacelZOey2aLt+s/W9lIFt3Gg8tdsoFXUvtd
	 i70O/nBagX4yg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 23541378206B;
	Fri, 19 Jan 2024 13:19:53 +0000 (UTC)
Message-ID: <420e5184-fe35-4725-95c4-782cc096252f@collabora.com>
Date: Fri, 19 Jan 2024 14:19:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@collabora.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20231213150435.4134390-1-wenst@chromium.org>
 <20231213150435.4134390-7-wenst@chromium.org>
 <13c8ccbc-0eef-43f5-ae37-29ec64d1606b@collabora.com>
 <CAGXv+5HO+TW6H9kLv62Dp7cihHW7fs99gzUBMWvAEnzdrNY7mg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HO+TW6H9kLv62Dp7cihHW7fs99gzUBMWvAEnzdrNY7mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/12/23 15:37, Chen-Yu Tsai ha scritto:
> On Thu, Dec 14, 2023 at 7:31 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 13/12/23 16:04, Chen-Yu Tsai ha scritto:
>>> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
>>> Krabby design.
>>>
>>> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
>>> convertible device with touchscreen and stylus.
>>>
>>> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
>>> device. It does not have a touchscreen or stylus.
>>>
>>> The two devices both have two variants. The difference is a second
>>> source touchpad controller that shares the same address as the original,
>>> but is incompatible.
>>>
>>> The extra SKU IDs for the Tentacruel devices map to different sensor
>>> components attached to the Embedded Controller. These are not visible
>>> to the main processor.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>> Changes since v3:
>>> - Reorder some properties to conform better to the newly proposed DT
>>>     style guidelines
>>> - Drop unused labels
>>> - Rename bt-sco node name to bt-sco-codec
>>> - Drop i2s*-share properties from afe node
>>> - Drop aud_gpio_tdm_{on,off} pinctrl nodes
>>> - Replace interrupts with interrupts-extended in tpm node
>>> - Enable adsp device
>>>
>>> Changes since v2:
>>> - Picked up Conor's ack
>>> - Rename touchpad to trackpad
>>> - Drop pinctrl properties from trackpad in tentacruel/tentacool second
>>>     source trackpad
>>>
>>> Changes since v1:
>>> - Reorder SKU numbers in descending order.
>>> - Fixed pinconfig node names
>>> - Moved pinctrl-* properties after interrupts-*
>>> - Switched to interrupts-extended for external components
>>> - Marked ADSP as explicitly disabled, with a comment explaining that it
>>>     stalls the system
>>> - Renamed "touchpad" to "trackpad"
>>> - Dropped bogus "no-laneswap" property from it6505 node
>>> - Moved "realtek,jd-src" property to after all the regulator supplies
>>> - Switched to macros for MT6366 regulator "regulator-allowed-modes"
>>> - Renamed "vgpu" regulator name to allow coupling, with a comment
>>>     containing the name used in the design
>>> - Renamed "cr50" node name to "tpm"
>>> - Moved trackpad_pins reference up to i2c2; workaround for second source
>>>     component resource sharing.
>>> - Fix copyright year
>>> - Fixed touchscreen supply name
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>>>    .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
>>>    .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
>>>    .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
>>>    .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>>>    .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
>>>    .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1707 +++++++++++++++++
>>>    7 files changed, 1991 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index e6e7592a3645..442af61b1305 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>>
>> ..snip..
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>> new file mode 100644
>>> index 000000000000..447b57b12b41
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>>> @@ -0,0 +1,26 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright 2023 Google LLC
>>> + */
>>> +
>>> +#include "mt8186-corsola-tentacruel-sku262144.dts"
>>> +
>>> +/ {
>>> +     compatible = "google,tentacruel-sku262151", "google,tentacruel-sku262150",
>>> +                  "google,tentacruel-sku262149", "google,tentacruel-sku262148",
>>> +                  "google,tentacruel", "mediatek,mt8186";
>>> +};
>>> +
>>> +/* This variant replaces only the trackpad controller. */
>>> +&i2c2 {
>>> +     /delete-node/ trackpad@15;
>>> +
>>> +     trackpad@15 {
>>> +             compatible = "hid-over-i2c";
>>> +             reg = <0x15>;
>>> +             interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>> +             hid-descr-addr = <0x0001>;
>>> +             vdd-supply = <&pp3300_s3>;
>>> +             wakeup-source;
>>> +     };
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>> new file mode 100644
>>> index 000000000000..adbeb0c765d3
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
>>> @@ -0,0 +1,1707 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2022 MediaTek Inc.
>>> + */
>>> +/dts-v1/;
>>> +#include "mt8186.dtsi"
>>> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/input/gpio-keys.h>
>>> +#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&i2c2 {
>>> +     pinctrl-names = "default";
>>> +     /*
>>> +      * Trackpad pin put here to work around second source components
>>> +      * sharing the pinmux in steelix designs.
>>> +      */
>>> +     pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
>>> +     clock-frequency = <400000>;
>>> +     i2c-scl-internal-delay-ns = <10000>;
>>> +     status = "okay";
>>> +
>>> +     trackpad@15 {
>>> +             compatible = "elan,ekth3000";
>>
>> You forgot to change this one.
>>
>> Remove compatible from this node and stop using /delete-node/ in device specific
>> devicetrees.
> 
> I believe I already replied to the previous version why we can't and shouldn't
> do that.
> 
> "elan,ekth3000" and "hid-over-i2c" have incompatible bindings, specifically
> the former uses "vcc-supply" while the latter uses "vdd-supply".
> 
> One has to track down if a property is a "sharable" property or not,
> then put it in the correct place, otherwise getting DT binding validation
> errors.
> 
> To me it seems cleaner to just delete the node wholesale to not have any
> remnants of the original node, i.e. start from a clean slate. Trying to
> "share" common properties is asking for a headache.
> 
> This feels more like a preference thing. I also asked if deleting the node
> through the label would be cleaner, but you didn't reply.
> 

I am truly sorry for not replying to that - and for replying to this one very late.

Ok, in that case, I still don't really like seeing /delete-node/ statements... and
unless there is a truly valid reason to have those, can we please just get each
node to each *.dts?

Just to clarify, a valid scenario to have a /delete-node/ statement there would be
the following:
  - Same platform, like Corsola in this case
  - Four devices
    - Three have one trackpad (better if expected more with the same TP)
    - One has the other trackpad

Even though I am flexible with that, I just don't see the value in deleting the
trackpad because we've got a 50-50 situation here!

At this point IMO it's worth defining the trackpad twice + twice instead... but
if you expect to have more devices, conforming to the valid scenario that I have
described above, then okay - keep going with /delete-node/.

> Also, "elan,ekth3000" is the one that was designed and tested on the Corsola
> reference design, so I think it rightfully belongs there. The Tentacruel
> SKU replaced it with another part, so the original part should be disabled,
> or in this case, deleted, because otherwise there would be a conflict.

If you really want to document the fact that the Corsola Reference Design
suggests to use a Elan eKTH3000 part, you can always leave a comment in the
dtsi, though, that's interesting mostly only to OEMs... but anyway I'm not
against having a comment, at all.

Cheers,
Angelo

> 
> 
> Regards
> ChenYu
> 
> 
> 
>>> +             reg = <0x15>;
>>> +             interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>> +             vcc-supply = <&pp3300_s3>;
>>> +             wakeup-source;
>>> +     };
>>> +};
>>
>>
>> corsola.dtsi (here):
>>
>> &i2c2 {
>>          pinctrl-names = "default";
>>          /*
>>           * Trackpad pin put here to work around second source components
>>           * sharing the pinmux in steelix designs.
>>           */
>>          pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
>>          clock-frequency = <400000>;
>>          i2c-scl-internal-delay-ns = <10000>;
>>          status = "okay";
>>
>>          trackpad_i2c2_15: trackpad@15 {
>>                  /*
>>                   * Those are common properties for i2c2 trackpad on Corsola boards.
>>                   * The compatible string is declared in device specific devicetrees
>>                   */
>>                  reg = <0x15>;
>>                  interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>>                  vcc-supply = <&pp3300_s3>;
>>                  wakeup-source;
>>                  status = "disabled";
>>          };
>> };
>>
>> corsola-some-device.dts:
>>
>> &trackpad_i2c2_15 {
>>          compatible = "hid-over-i2c";
>>          hid-descr-addr = <0x0001>;
>>          status = "okay";
>> };
>>
>> corsola-some-other-device.dts:
>>
>> &trackpad_i2c2_15 {
>>          compatible = "elan,ekth3000";
>>          status = "okay";
>> };
>>
>> ....everything else looks good.
>>
>> Cheers,
>> Angelo




