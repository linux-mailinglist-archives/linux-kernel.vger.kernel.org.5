Return-Path: <linux-kernel+bounces-22486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD5829E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC401C22942
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA54CB43;
	Wed, 10 Jan 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qmws0A1G"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8A4CB34;
	Wed, 10 Jan 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704903743;
	bh=fWksZuLZmBIAQaeN87h+Fg9aj3iHVlHAOWhw+aWFtaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qmws0A1G1dDswCVMuYycXSg3Uv1G54mgUifepkTH3kieXHd6decqVrVAnSTlZYqLr
	 NaSDuGxB0hOarSnsLnfp/dtIsAQD2SKaPguZaVXYFy46ohJwpI7TOYH4sY7cX/BAMY
	 5JXkJ4sPhuZREaZlppHK7VXTf0P1mNcKlmiqACGQ3pdAfJaXGVMb9M+61HkAXkaztZ
	 fDcZ3sm4PnlBjzKyV4LH9axRKU3mvHVHDor3NMLCecThpnEfqIWffPH0O702azJpkQ
	 HvNCIYOE+h9TnwnpDCJsLaJ0YGt2imaUd1heQA1ex7t1j17JUIOKYbeFzmOBZnJ5A1
	 RNecLUMnZmrWQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 84E8E37809D0;
	Wed, 10 Jan 2024 16:22:22 +0000 (UTC)
Message-ID: <ffc8a175-64e6-410a-9340-07f98226d6ca@collabora.com>
Date: Wed, 10 Jan 2024 17:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: Add initial MT7981B and Xiaomi
 AX3000T
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240110095118.25598-1-zajec5@gmail.com>
 <20240110095118.25598-2-zajec5@gmail.com>
 <34bda5e0-0587-459b-b31c-46112b1b10fa@collabora.com>
 <557cf463-5ffa-4d81-8b38-44f610b26163@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <557cf463-5ffa-4d81-8b38-44f610b26163@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 16:41, Rafał Miłecki ha scritto:
> On 10.01.2024 14:38, AngeloGioacchino Del Regno wrote:
>> Il 10/01/24 10:51, Rafał Miłecki ha scritto:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> MT7981B (AKA MediaTek Filogic 820) is a dual-core ARM Cortex-A53 SoC.
>>> One of market devices using this SoC is Xiaomi AX3000T.
>>>
>>> This is initial contribution with basic SoC support. More hardware block
>>> will get added later. Some will need their bindings (like auxadc).
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>>   .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   |  15 +++
>>>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 108 ++++++++++++++++++
>>>   3 files changed, 124 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index 0a189d5d8006..8bff11acfe1f 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts 
>>> b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>>> new file mode 100644
>>> index 000000000000..a314c3e05e50
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>>> @@ -0,0 +1,15 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "mt7981b.dtsi"
>>> +
>>> +/ {
>>> +    compatible = "xiaomi,ax3000t", "mediatek,mt7981b";
>>> +    model = "Xiaomi AX3000T";
>>> +
>>> +    memory@40000000 {
>>> +        reg = <0 0x40000000 0 0x10000000>;
>>> +        device_type = "memory";
>>> +    };
>>> +};
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi 
>>> b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>>> new file mode 100644
>>> index 000000000000..ce878ad55204
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>>> @@ -0,0 +1,108 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +
>>> +#include <dt-bindings/clock/mediatek,mt7981-clk.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +/ {
>>> +    compatible = "mediatek,mt7981b";
>>> +    interrupt-parent = <&gic>;
>>> +    #address-cells = <2>;
>>> +    #size-cells = <2>;
>>> +
>>> +    cpus {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        cpu@0 {
>>> +            compatible = "arm,cortex-a53";
>>> +            reg = <0x0>;
>>> +            device_type = "cpu";
>>> +            enable-method = "psci";
>>> +        };
>>> +
>>> +        cpu@1 {
>>> +            compatible = "arm,cortex-a53";
>>> +            reg = <0x1>;
>>> +            device_type = "cpu";
>>> +            enable-method = "psci";
>>> +        };
>>> +    };
>>> +
>>> +    oscillator-40m {
>>> +        compatible = "fixed-clock";
>>> +        clock-frequency = <40000000>;
>>> +        clock-output-names = "clkxtal";
>>> +        #clock-cells = <0>;
>>> +    };
>>> +
>>> +    psci {
>>> +        compatible = "arm,psci-0.2";
>>
>> PSCI 0.2? I invite you to check a kernel log for a string like this one:
>>
>> `PSCIv%d.%d detected in firmware`
>> ...because of course if it says v1.0, this should be "arm,psci-1.0".
>>
>> This is just a nitpick anyway, so you can already get my
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> P.S.: but please, confirm or deny that PSCI thing ASAP :-)
>> P.P.S.: For next time - I'd be happy if you could add a cover letter to your
>> patch series..!
> 
> You were right, good catch!
> 
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> 
> I'll fix that in V2. Thanks!
> 

Cool! You're welcome!

For v1.1 it's still "arm,psci-1.0" btw :-)
You can keep my R-b tag with that compatible change, no need to drop it.

Cheers,
Angelo


