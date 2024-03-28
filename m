Return-Path: <linux-kernel+bounces-123675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189D890C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5452929B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825813AD00;
	Thu, 28 Mar 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pcWtuIDa"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8524380
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661302; cv=none; b=ixzVuN/ovSunlHbDGkO9v1B5v+fPoOeHRtfSad/B5tteU4GXP6mPB1/zl3MHg+GgJGKqZ8W5ze4KZyQpBcefVGXwtC8S9YbeHlz+6sOJ0Dx2Kl5bqe1TYTvzAR52DOMr7GgANsRztQogbkuCNldErb6Ozu6SOjT8B2kklOqThtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661302; c=relaxed/simple;
	bh=Mdr43Xs70/jkD3vHSHG6rkd8UAawVU82XRKfqKy5tSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mpk2g3wJ5W2DYEtKfbF6lCcBkxTp53pNXfR1C6EerDz4fSkiARzBIj5F+OL5i4oNcvX7Asgx4Y81wW3CMyHLpKnkN0AJUezHKj8qdQktOp0B7NKTT/Ay50LPAntu/HX6m6tB95CuV7OYL/l7/rPIWvyl4eyij6oU6ltQqWNe8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pcWtuIDa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DA9042494
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711661297;
	bh=5ko95O3gC1sLJn6IH23zULppCGnOBuRUTKkxrCf7TS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=pcWtuIDaQUv5XW/NB3YB6ANX511yskKICJiFeLCcyukLTZUW8iih2qaLQYKuCyF7u
	 rvN0nfb9yxwFOCMWZXwNo5sGubB7VU5vHJ2SV2JOs/bFQzq3WHcjdRaa2UYxhD3gWe
	 3i1PjykFImlhZn7dtNrVvpNI3jRJOc8uY7FgcpFz1crhq1vYONBtewpw5xUWaohhaX
	 E+AEvyXoFHUMsyA45OcWaudYLwEpoPWAHnY78g5xsfUzrFB2EyJp+LgMwG+aWrjDpY
	 NkKMvoNafz9b7m2xjq9QobtnK9XFUokv4u4mmqKNqIlXKzfAmiTZnuHJ7+i+HoC2jD
	 8Ch7O22XyuhdQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e4397540bso773647f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661297; x=1712266097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ko95O3gC1sLJn6IH23zULppCGnOBuRUTKkxrCf7TS4=;
        b=f20vFgqK3RFuHQQK9DkRLk2bKjwvQJaXjiAsPFWgQYPC/uwi8JbNng6ayEyfZ/TJod
         4QY2FROcJ6pznu5ECAXQRtLkl7+cg16HE9VR3Wdvw138Wpg2M9HCSbf5GzbaW5ILEnGo
         eqI8T2jfCytljcsPqCqHig6ho0pKt/yhCPZ/Yj6QdPrekcdO922x1MVDNIqvz0CLbqUq
         h5ya7MQksGLTQz89HPoaZzJq6Lm6hoQ+jBJqnqaWxIRZZi+C5BCC5moPaxM7cFDYO0j6
         yOkE7scCfmrAGkyanmQi/QFLF41H1Iu4oy8qeX4bgciBoH8650EbUSpySFRqgns/n9oe
         LVyg==
X-Forwarded-Encrypted: i=1; AJvYcCWTTIzYTjoGShgMTi6gGuTlH3nZdNjFiaO2oSIkJTjryPjGBsesLm2uMj1HMSJu0GINEK/Gc3UDXY42hU/utdGTalQKynC/tMvrP1ez
X-Gm-Message-State: AOJu0Yz7wlhHCv5xjW9i9tpPZT8k/epoyWotd/LyVrZvL9GhW10Rl+Vp
	xURTYXXS5s+0Zp+RXqIzA6ybLUF7Vpb4B6dnxdtIz3b5l8FUNk5CQ5kfGhIGymCzHb7w/eYwWkO
	grgDSPlUvAl2U+jhDGXeSnziexGUuIYTrrfS3RwN7vWDls2kiEe6D4p88U1rhGVHv7cHib+kfXX
	tShQ==
X-Received: by 2002:adf:f28a:0:b0:341:ddd9:c034 with SMTP id k10-20020adff28a000000b00341ddd9c034mr147980wro.65.1711661296803;
        Thu, 28 Mar 2024 14:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3aWLpJ7UToopXtObbatmYTPGekahPHltbJUAha1+RnYVQUR9NuugKZrIExJ3M4EMn+YHwyw==
X-Received: by 2002:adf:f28a:0:b0:341:ddd9:c034 with SMTP id k10-20020adff28a000000b00341ddd9c034mr147960wro.65.1711661296382;
        Thu, 28 Mar 2024 14:28:16 -0700 (PDT)
Received: from [192.168.123.161] (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
        by smtp.gmail.com with ESMTPSA id gb17-20020a056000459100b003432db356easm2622729wrb.98.2024.03.28.14.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 14:28:15 -0700 (PDT)
Message-ID: <43918921-0d05-41d3-a19b-f137314e868d@canonical.com>
Date: Thu, 28 Mar 2024 22:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240206-magma-deem-2c88e45a545a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/24 20:13, Conor Dooley wrote:
> On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
>> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
>> The board features:
>>
>> - JH7110 SoC
>> - 1/2/4/8 GiB LPDDR4 DRAM
>> - AXP15060 PMIC
>> - 40 pin GPIO header
>> - 3x USB 3.0 host port
>> - 1x USB 2.0 host port
>> - 1x M.2 E-Key
>> - 1x eMMC slot
>> - 1x MicroSD slot
>> - 1x QSPI Flash
>> - 1x 1Gbps Ethernet port
>> - 1x HDMI port
>> - 1x 2-lane DSI and 1x 4-lane DSI
>> - 1x 2-lane CSI
>>
>> Add the devicetree file describing the currently supported features,
>> namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Got a dtbs_check issue in the patchwork CI:
> 
>    +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property
>    +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
>    +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clock: 'clock-frequency' is a required property
>    +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> 
> Can you fix that please? Also, I applied some patches the other day that
> seem to conflict quite a bit with the common board dts patch. Would you
> please do a rebase on top of that please?
> 
> Cheers,
> Conor.
> 
>> ---
>>   arch/riscv/boot/dts/starfive/Makefile         |  1 +
>>   .../boot/dts/starfive/jh7110-milkv-mars.dts   | 35 +++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
>>
>> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
>> index 0141504c0f5c..2fa0cd7f31c3 100644
>> --- a/arch/riscv/boot/dts/starfive/Makefile
>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>> @@ -8,5 +8,6 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
>>   dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
>>   dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>>   
>> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>>   dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>>   dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
>> new file mode 100644
>> index 000000000000..de600e799e7d
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
>> @@ -0,0 +1,35 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>> + */
>> +
>> +/dts-v1/;
>> +#include "jh7110-visionfive2-mars-common.dtsi"
>> +
>> +/ {
>> +	model = "Milk-V Mars";
>> +	compatible = "milkv,mars", "starfive,jh7110";
>> +};
>> +
>> +&gmac0 {
>> +	starfive,tx-use-rgmii-clk;
>> +	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>> +	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
>> +};
>> +
>> +
>> +&phy0 {
>> +	motorcomm,tx-clk-adj-enabled;
>> +	motorcomm,tx-clk-10-inverted;
>> +	motorcomm,tx-clk-100-inverted;
>> +	motorcomm,tx-clk-1000-inverted;
>> +	motorcomm,rx-clk-drv-microamp = <3970>;
>> +	motorcomm,rx-data-drv-microamp = <2910>;
>> +	rx-internal-delay-ps = <1500>;
>> +	tx-internal-delay-ps = <1500>;
>> +};
>> +
>> +&mmc1 {
>> +	disable-wp;

Due to which difference is 'disable-wp' necessary for the Mars board and 
not necessary for the VisionFive 2 board?

>> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;

On my VisionFive 2 1.2B, and 1.3A boards GPIO 41 reflects if an SD-card 
is inserted (as shown in U-Boot by gpio status -a). So shouldn't this 
value be moved to the common include 
"jh7110-visionfive2-mars-common.dtsi" and broken-cd removed from the 
VisionFive2 board?

https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf
has a line

     GPIO41 | SD_SDIO0_CD_GPIO41 | Micro SD：J10

Best regards

Heinrich

>> +};
>> -- 
>> 2.43.0


