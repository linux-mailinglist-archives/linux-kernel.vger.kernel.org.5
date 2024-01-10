Return-Path: <linux-kernel+bounces-22440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0429829DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE23B21D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B64C3B1;
	Wed, 10 Jan 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H379gDj5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C14C3B0;
	Wed, 10 Jan 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so5064456a12.2;
        Wed, 10 Jan 2024 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901310; x=1705506110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsR/ATrfPdIgLGIZ2coCrOAOA9UzCcQEuLMVPEYRm48=;
        b=H379gDj5Fr3y3dhqbYqYutsgayjMME/FLi2jbzF8S2MqTq9Z4YlCNINvSi8Btb023y
         zD3W+gP0eBIL2YVHdLITntwRd21fyJGcbyc2iz59gMbFPdpCSGNPYdCmAng/o3Ebp1CK
         Ysm5uqAK0LS6uWTHYT08H60oWNryArl3R7oMdRFrTgpbOSz5F2fffZZsa5ajL+As2Kmb
         xI95ntWv7gDZ2UH1nSiEHB6L/3eOQ75TDHEHCS6Fme2mfscqq/OuKrtCQL811DNDmi9E
         bUylz9kjIQakfW4EkE/qr2fPJ0bQgJoqVKRJcvz8D3ifME1KpIYIwRWGTDczHtoBlgnl
         uWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901310; x=1705506110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsR/ATrfPdIgLGIZ2coCrOAOA9UzCcQEuLMVPEYRm48=;
        b=a99jC/9LnFmKD/fY5AAuT7jH5JURkvAEARJ1VOumCnTjNrkzrKXKzfrItw5DQLmYjc
         S7vXgVyTszXOT5bzynrW0iSsjVaz1cGsiAaz37byhxtJw0BSR1p9FT7T9TDWdXa5O6mO
         rZCPDyaANXNSQEyiAPA2+whiJNWk9B34nS3quW6SPC/eGLNyDG93bK/jujzwHXXHJF/2
         77tjwHwNhVloSVL04PGMZzV8BIF/wBbwvuQBi/ns6G6Ht0qG3ZdjZMRe8I5IBcH6js9D
         zL0pi47XWUjijzHTCekxH17Wh6KxnXt/8T5+zdPiVZ6qw5bWXqqjztRO9uLewGr89oOg
         yqBA==
X-Gm-Message-State: AOJu0Yz2gojlqy02OyL1JU3xM+xGf0NrlLLM66p7YPV+wzsnZ2823HVk
	f0QYiDf1H5AwUV6oXYE1Qks=
X-Google-Smtp-Source: AGHT+IEpzs8YcWbD9Zfpq1vhLm5OkWGSL3+lkBeN5CTV4dvVJhPvEdFa+MGe40p0nNRxX1INZDFyPQ==
X-Received: by 2002:a17:907:6016:b0:a28:a79e:7f5b with SMTP id fs22-20020a170907601600b00a28a79e7f5bmr362566ejc.221.1704901309935;
        Wed, 10 Jan 2024 07:41:49 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id g19-20020a170906349300b00a2a2426728bsm2223958ejb.178.2024.01.10.07.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:41:49 -0800 (PST)
Message-ID: <557cf463-5ffa-4d81-8b38-44f610b26163@gmail.com>
Date: Wed, 10 Jan 2024 16:41:47 +0100
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
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <34bda5e0-0587-459b-b31c-46112b1b10fa@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.01.2024 14:38, AngeloGioacchino Del Regno wrote:
> Il 10/01/24 10:51, Rafał Miłecki ha scritto:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> MT7981B (AKA MediaTek Filogic 820) is a dual-core ARM Cortex-A53 SoC.
>> One of market devices using this SoC is Xiaomi AX3000T.
>>
>> This is initial contribution with basic SoC support. More hardware block
>> will get added later. Some will need their bindings (like auxadc).
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>   .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   |  15 +++
>>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 108 ++++++++++++++++++
>>   3 files changed, 124 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>> index 0a189d5d8006..8bff11acfe1f 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>> new file mode 100644
>> index 000000000000..a314c3e05e50
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +
>> +/dts-v1/;
>> +
>> +#include "mt7981b.dtsi"
>> +
>> +/ {
>> +    compatible = "xiaomi,ax3000t", "mediatek,mt7981b";
>> +    model = "Xiaomi AX3000T";
>> +
>> +    memory@40000000 {
>> +        reg = <0 0x40000000 0 0x10000000>;
>> +        device_type = "memory";
>> +    };
>> +};
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>> new file mode 100644
>> index 000000000000..ce878ad55204
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +
>> +#include <dt-bindings/clock/mediatek,mt7981-clk.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +    compatible = "mediatek,mt7981b";
>> +    interrupt-parent = <&gic>;
>> +    #address-cells = <2>;
>> +    #size-cells = <2>;
>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        cpu@0 {
>> +            compatible = "arm,cortex-a53";
>> +            reg = <0x0>;
>> +            device_type = "cpu";
>> +            enable-method = "psci";
>> +        };
>> +
>> +        cpu@1 {
>> +            compatible = "arm,cortex-a53";
>> +            reg = <0x1>;
>> +            device_type = "cpu";
>> +            enable-method = "psci";
>> +        };
>> +    };
>> +
>> +    oscillator-40m {
>> +        compatible = "fixed-clock";
>> +        clock-frequency = <40000000>;
>> +        clock-output-names = "clkxtal";
>> +        #clock-cells = <0>;
>> +    };
>> +
>> +    psci {
>> +        compatible = "arm,psci-0.2";
> 
> PSCI 0.2? I invite you to check a kernel log for a string like this one:
> 
> `PSCIv%d.%d detected in firmware`
> ...because of course if it says v1.0, this should be "arm,psci-1.0".
> 
> This is just a nitpick anyway, so you can already get my
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> P.S.: but please, confirm or deny that PSCI thing ASAP :-)
> P.P.S.: For next time - I'd be happy if you could add a cover letter to your
> patch series..!

You were right, good catch!

[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0

I'll fix that in V2. Thanks!


