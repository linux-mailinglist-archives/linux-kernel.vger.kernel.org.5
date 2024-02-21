Return-Path: <linux-kernel+bounces-74511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC185D552
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32E5B21F76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9223D97A;
	Wed, 21 Feb 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8D0QgDY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B83B198;
	Wed, 21 Feb 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510737; cv=none; b=r2lrrEAk/Csq2/nZmREUnPQDdtBi+lfS3k6isHSjd7e2bSKPpEPKowB+2I1ESbNNWCGFHJMwNlaU7+E1tIiWOVqchCIEDosd+rV2BLnCVWWJ6SyhIudRsdIV0m+th+Be54oTHZHtcxfrBi0mOOUIbMYV9lb009RCfdfz6OdPNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510737; c=relaxed/simple;
	bh=g5i637/KCdjSuewFOCudFOu2YCYdZfEM4Frnyo4ETjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9z6T9pxFr3iEPWIG2qpJKwk4EVWHV7BKZplA2ymDFsTIpGZ3wh+czuZ9DgjgdDM8DtYEg8dTe7JwoYkT1LFOFgw2hBpH1FVe9ZoLZtG3Yf7IA4fs1sJ6Qus533mXG46Tvh3Gb9NkbKFv2JlukR1VR7cADrnJk5brAon/SqDmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8D0QgDY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso51193751fa.2;
        Wed, 21 Feb 2024 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708510733; x=1709115533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxYy/oCllbVJu1lUjrqdo3aNdYciiuAnqI38767Tw8k=;
        b=l8D0QgDYLNqM7jVm1XZa4mcjapqaSpMRnvW6VF5mzBJ2/hgnAti9xLNFZdONEAzj+z
         +TkooNzRyBMKm+S8hh9Mvyn+v9z4FaYy/2VR+u0B0pIam+1KgVhnKUtUb3TpEj8XxjSu
         j/UG0l3pqfwTag2k28oqddIYqk/nfdYY9TbKRjXFW4dG625oBcEBvCJuNMi7qSVwx5eU
         Qr2Vbb2SmXT7M6K8HEkeJDiHOtGIhK1Nl1bFg3CYlh9GkhVm68TJR6k0uHf1rOTy0MBB
         idbd03KwRWMXTT+WWXQoF7Di3HSK1w5r3/Ws+3APQndD8xGPIDnvbEFtOKGnXwP88Ryl
         CTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510733; x=1709115533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxYy/oCllbVJu1lUjrqdo3aNdYciiuAnqI38767Tw8k=;
        b=H+YUcCCBUcPQbEYV4VCQMMctpXwRKbb4gch97rttlHPT9U2hAPPVPlCRYpdm/DdbAX
         kWuVkE5kz9+v36W6/Kiu3qO0W4g5ukK37ALP/lx5e3cLyPVSiPn3LGYluoUXlcAu1GP6
         3FAW0AZiOWbpwRDZ3fl5ctvTNoQ49nit9D0eqeF35wPpvPX/AbkOhcL64HSMQvg/D3kA
         w47XxK5mHzs08CDAxWcshYVoDVrqr1MC4OvhvmiyqPhcdYUWVUdZIxP8JaZVQqxZW6ap
         /rvVF3rUp4MNEdksvVXHc2rbrFdQ20gJztiyIhM0k7x4GEKUrvJNL0AUiXkS4PZkzp1O
         zFTg==
X-Forwarded-Encrypted: i=1; AJvYcCXKHQRacl89Bsu+H3SANc4Fe48L+sdU2HT10DC2UPJDs+ju+27H1nhktnHMHyrkhVWRsfBfKyOb8E4Wi6FWqBNjqE9FOOqFdnywHdVsXd05W00z2vnz7sXAD4XfZQoDTumThthJ47VH/g==
X-Gm-Message-State: AOJu0Yxz8iboDqKTdAgnsE31XrGQKAVUb5Pw4vEVyOMKN2X9mdAX2ATq
	46eSjh1Ep1tI3/533YamKPsbnd0kkDY981Z0DK9PEJQGm6BZAKds
X-Google-Smtp-Source: AGHT+IFTdBLcdX+mNatMOQW4Ps2MUiqJKNUfiZQWmGfDF5dJHJtDnU58iVGJ9gek14cZwh5wfP1jew==
X-Received: by 2002:a2e:9192:0:b0:2d2:50ba:e5b6 with SMTP id f18-20020a2e9192000000b002d250bae5b6mr1780390ljg.10.1708510733213;
        Wed, 21 Feb 2024 02:18:53 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id l12-20020a2ea30c000000b002d2191e20e1sm1799512lje.92.2024.02.21.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 02:18:52 -0800 (PST)
Message-ID: <b4e8d3c6-5113-4324-9af5-c4e89cd89349@gmail.com>
Date: Wed, 21 Feb 2024 11:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240221073524.20947-1-zajec5@gmail.com>
 <20240221073524.20947-5-zajec5@gmail.com>
 <2fdf724e-4994-4873-971a-56c19b9fc471@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <2fdf724e-4994-4873-971a-56c19b9fc471@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.02.2024 11:11, AngeloGioacchino Del Regno wrote:
> Il 21/02/24 08:35, Rafał Miłecki ha scritto:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
>> has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
>> Ethernet ports.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>>   .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>> index 37b4ca3a87c9..96da4ad640aa 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-acelink-ew-7886cax.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
>> new file mode 100644
>> index 000000000000..cb36a089518a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +#include "mt7981b.dtsi"
>> +
>> +/ {
>> +    compatible = "cudy,wr3000-v1", "mediatek,mt7981b";
>> +    model = "Cudy WR3000 V1";
>> +
>> +    memory@40000000 {
>> +        reg = <0 0x40000000 0 0x10000000>;
>> +        device_type = "memory";
>> +    };
>> +
>> +    keys {
>> +        compatible = "gpio-keys";
>> +
>> +        key-wps {
>> +            label = "WPS";
>> +            gpios = <&pio 0 GPIO_ACTIVE_LOW>;
>> +            linux,code = <KEY_WPS_BUTTON>;
>> +        };
>> +
>> +        key-reset {
>> +            label = "RESET";
>> +            gpios = <&pio 1 GPIO_ACTIVE_LOW>;
>> +            linux,code = <KEY_RESTART>;
>> +        };
>> +    };
>> +
>> +    leds {
>> +        compatible = "gpio-leds";
>> +
>> +        led-0 {
>> +            function = LED_FUNCTION_WAN;
>> +            color = <LED_COLOR_ID_BLUE>;
>> +            gpios = <&pio 5 GPIO_ACTIVE_LOW>;
> 
> Can we please order those properties alphabetically, as it doesn't impact
> on human readability in any way?
> Just a nitpick, anyway.
> 
> color = <LED_COLOR_ID_BLUE>;
> function = LED_FUNCTION_WAN;
> gpios = <&pio 5 GPIO_ACTIVE_LOW>;

If I understand [1] correctly alphabetical / alpha-numerical order
applies to non-addresses nodes only.

Here I put "function" first as that seemed more important than a color.

Perhaps you could suggest an addition to Devicetree Sources (DTS) Coding
Style or point me to the missed part, please?

[1] https://www.kernel.org/doc/html/next/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node



>> +        };
>> +
>> +        led-1 {
>> +            function = LED_FUNCTION_WLAN_2GHZ;
>> +            color = <LED_COLOR_ID_BLUE>;
>> +            gpios = <&pio 6 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        led-2 {
>> +            function = LED_FUNCTION_WLAN_5GHZ;
>> +            color = <LED_COLOR_ID_BLUE>;
>> +            gpios = <&pio 7 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        led-3 {
>> +            function = LED_FUNCTION_LAN;
>> +            color = <LED_COLOR_ID_BLUE>;
>> +            gpios = <&pio 9 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        led-4 {
>> +            function = LED_FUNCTION_STATUS;
>> +            color = <LED_COLOR_ID_BLUE>;
>> +            gpios = <&pio 10 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        led-5 {
>> +            function = "online";
> 
> Uhm, what does "online" mean?
> 
> Are you sure that you can't use any of the LED_FUNCTION_XXX standard definitions?

This device has:
1. "WAN Port" LED that indicates "WAN Port has connection" state
2. "Internet" LED that indicates "Connected to the Internet" state

I couldn't find any define that would fit Internet access LED case.

