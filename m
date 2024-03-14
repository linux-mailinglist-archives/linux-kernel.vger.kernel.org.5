Return-Path: <linux-kernel+bounces-103018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390287B9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C1B1C220F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3F6BFA7;
	Thu, 14 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/xNrJQ7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207126BB48
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407084; cv=none; b=OdngitWeb+45Yl0mHO+VC1Tm9ba8Tb22B4qBSIR57pOVQRW1n8XygjW7Acep2lp2HhL2FuhcYyeGppapdyBlYtZk4cvU3MfKbVCUYV7OutFd+JWCf/RBPBzjm0j2r/26utvk4leytZHfy2VRP6MLa5XQ3kd4VSQFr6pJTWfWWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407084; c=relaxed/simple;
	bh=YzFcKEtjUr6Z65sB75UEzOrUBGfhlTeicSDKg/bAjlI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k3BYWYCCTE9Qo6BfTg/Rm2ohjj/+SRg13uBe1bGkQLeBsiYvUnas/i/0pryE8Rhzr5VLffP6rYNtzWaMmAUdEJOe6k0jqbRyPPiEz3hp7FU/mekjR0lm9wTketeq4U/OOTTmka59/4HJjntVdRsCvYGUsbD9r/efyww2RQHO9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/xNrJQ7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e9df3416bso494171f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710407080; x=1711011880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6yLCzr8IjIPSmXUxMzp8GWR0SnYRq6V0f2szvKU+sU=;
        b=W/xNrJQ7xgBalmEv7jab369io4/RIULlI08eRcPZtLzQhEN2bJxTYtLyd6zoi4NEYP
         eOI1iAOK8kkjtqR1E5XhTxZLPXk38bWVDqwdcT7iW8x4qlRFEJPQO4NkL+1MhgFK7LQi
         4bxPYVNmXvWw3Z9W8GS4uS0fndDzRij8uQDKEstGHITauDcX5qZOAvOMItVxHbZRnF3j
         nb3NtVtoti2nNiE2oURJntgVXZPb1Yqg1NWz20sJHtH9kfiyFv11qH4CeeBOuN1MOs3W
         IMDrY53sgG3pd6Tqds1FK5A741iR/ZxJTIjHOmwPf4BWQ4PZsnuTMB2Qei3olY2QYX2l
         8koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407080; x=1711011880;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6yLCzr8IjIPSmXUxMzp8GWR0SnYRq6V0f2szvKU+sU=;
        b=WVxdQ5YdZJcgcox/yRmgHh7ZQX8Tk8b4g/jYjdTTJ9LVhlK+CLXEf6Bi9KLNLvYLLx
         D2RyqGod4NNXnh87TjbMR5wbVqhynjpgGL/jlp6HGLZW+BvZ/66rMKd4YlcbQy1jbu5F
         tR8YpaHRmSDutFmJjy9cGO2wtvzK/5ItYXMTBXy+pDgkpJ4b/7lQnSZ849N3UBft3Rqd
         oUfUqL3L6SpLez5oa/XHaki2QSwMb0hc06WrkR6nCXTzRt9mgqyy3eAMhZpERx/zXq6O
         laCk7Cg2z8OKfd9Xc9q5Ts8WoNFGRtMwWhGhOWbTnh/Y5eDbNe3ZbDWbPBRTxf1Mnu5Y
         a6fg==
X-Forwarded-Encrypted: i=1; AJvYcCXDpG79TFI9ypeUuu1XGV5hEEUXm2F2aNACTb9YAq8WMenYZ9aFxLYfS0ES91JoqzllnMrBkeNwxMajdKZEVFOtYfJH/8OIN9cy0Tgm
X-Gm-Message-State: AOJu0Yz8EiVmKcY0Gc+lxHbmwmMHakCcRuAGbBwcZ97U/bo5qzwiSkLg
	6ficAGTu3OGzU4+/vYaxsCzECssDU7fO3DXxEinhnplxlL1bXuZEqxQVzaFUidI=
X-Google-Smtp-Source: AGHT+IFo5T2dddFDvag2IQ8tZd2pmdFQ4TnpWzZEglPwMIBYcfDL3UZ53sjDiK7ULzpqPg3vYZK8xw==
X-Received: by 2002:adf:f04a:0:b0:33e:c389:66a7 with SMTP id t10-20020adff04a000000b0033ec38966a7mr805795wro.16.1710407080289;
        Thu, 14 Mar 2024 02:04:40 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b0033ec6ebf878sm244683wrm.93.2024.03.14.02.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 02:04:39 -0700 (PDT)
Message-ID: <024b8567-af4c-4522-9b9d-594c42930442@linaro.org>
Date: Thu, 14 Mar 2024 10:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [DMARC error][DKIM error] [PATCH 3/4] arm64: dts: add support for
 A4 based Amlogic BA400
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
 <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/03/2024 06:19, Xianwei Zhao wrote:
> Hi Dmitry,
>     Thanks for your review.
> 
> On 2024/3/13 17:53, Dmitry Rokosov wrote:
>> [????????? ddrokosov@salutedevices.com ????????? https://aka.ms/LearnAboutSenderIdentification?????????????]
>>
>> [ EXTERNAL EMAIL ]
>>
>> Hello Xianwei,
>>
>> On Tue, Mar 12, 2024 at 05:18:59PM +0800, Xianwei Zhao via B4 Relay wrote:
>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> Amlogic A4 is an application processor designed for smart audio
>>> and IoT applications.
>>>
>>> Add basic support for the A4 based Amlogic BA400 board, which describes
>>> the following components: CPU, GIC, IRQ, Timer and UART.
>>> These are capable of booting up into the serial console.
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>>>   .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 43 ++++++++++
>>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 99 ++++++++++++++++++++++
>>>   3 files changed, 143 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index 1ab160bf928a..9a50ec11bb8d 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -1,4 +1,5 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>>> new file mode 100644
>>> index 000000000000..60f9f23858c6
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>>> @@ -0,0 +1,43 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "amlogic-a4.dtsi"
>>> +
>>> +/ {
>>> +     model = "Amlogic A113L2 ba400 Development Board";
>>> +     compatible = "amlogic,ba400","amlogic,a4";
>>> +     interrupt-parent = <&gic>;
>>> +     #address-cells = <2>;
>>> +     #size-cells = <2>;
>>> +
>>> +     aliases {
>>> +             serial0 = &uart_b;
>>> +     };
>>> +
>>> +     memory@0 {
>>> +             device_type = "memory";
>>> +             reg = <0x0 0x0 0x0 0x40000000>;
>>> +     };
>>> +
>>> +     reserved-memory {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +
>>> +             /* 52 MiB reserved for ARM Trusted Firmware */
>>> +             secmon_reserved:linux,secmon {
>>> +                     compatible = "shared-dma-pool";
>>> +                     no-map;
>>> +                     alignment = <0x0 0x400000>;
>>> +                     reg = <0x0 0x05000000 0x0 0x3400000>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&uart_b {
>>> +     status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>> new file mode 100644
>>> index 000000000000..7e8745010b52
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>> @@ -0,0 +1,99 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +/ {
>>> +     cpus {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <0>;
>>> +
>>> +             cpu0: cpu@0 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a53";
>>> +                     reg = <0x0 0x0>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +
>>> +             cpu1: cpu@1 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a53";
>>> +                     reg = <0x0 0x1>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +
>>> +             cpu2: cpu@2 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a53";
>>> +                     reg = <0x0 0x2>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +
>>> +             cpu3: cpu@3 {
>>> +                     device_type = "cpu";
>>> +                     compatible = "arm,cortex-a53";
>>> +                     reg = <0x0 0x3>;
>>> +                     enable-method = "psci";
>>> +             };
>>> +     };
>>> +
>>> +     timer {
>>> +             compatible = "arm,armv8-timer";
>>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +     };
>>> +
>>> +     psci {
>>> +             compatible = "arm,psci-0.2";
>>> +             method = "smc";
>>> +     };
>>> +
>>> +     xtal: xtal-clk {
>>> +             compatible = "fixed-clock";
>>> +             clock-frequency = <24000000>;
>>> +             clock-output-names = "xtal";
>>> +             #clock-cells = <0>;
>>> +     };
>>> +
>>> +     soc {
>>> +             compatible = "simple-bus";
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +
>>> +             gic: interrupt-controller@fff01000 {
>>> +                     compatible = "arm,gic-400";
>>> +                     #interrupt-cells = <3>;
>>> +                     #address-cells = <0>;
>>> +                     interrupt-controller;
>>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>>> +                           <0x0 0xfff02000 0 0x2000>,
>>> +                           <0x0 0xfff04000 0 0x2000>,
>>> +                           <0x0 0xfff06000 0 0x2000>;
>>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>> +             };
>>> +
>>> +             apb@fe000000 {
>>> +                     compatible = "simple-bus";
>>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <2>;
>>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>> +
>>> +                     uart_b: serial@7a000 {
>>> +                             compatible = "amlogic,meson-s4-uart",
>>
>> If I'm not wrong, you need to create dt-binding alias for meson-a4-uart
>> and use it as 3rd compatible string.

Please add an A4 and A5 compatible using amlogic,meson-s4-uart as fallback,
and drop the ao-uart since there's no more AO uart.

Follow how it was done for the T7 in Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml

The amlogic,meson-s4-uart will provide an earlycon like ao-uart did.

Thanks,
Neil

>>
> On UART module, A4 and A5 SoCs exactly the same as S4. There's no difference.
>>> +                                          "amlogic,meson-ao-uart";
>>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>>> +                             interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>>> +                             clock-names = "xtal", "pclk", "baud";
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +     };
>>> +};
>>>
>>> -- 
>>> 2.37.1
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
>> -- 
>> Thank you,
>> Dmitry


