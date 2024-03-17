Return-Path: <linux-kernel+bounces-105413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35887DD90
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224CAB20B67
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328351C288;
	Sun, 17 Mar 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNFPo6F/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CC1C68F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687064; cv=none; b=ZUf/uNszIv82yNJIsZs0vwff5lpkSSszMLNeIByseuPlVTzC93BS/QwVUVF8sUBYC+1NLNpmE1djREJ5TrPE7yGkLce4syPG+8GgKFfJakGgJhB/QgTA00slCRjvkBDlFnmuEvu4MqGemAIphm/GBRAz5lCTrmDFwsxLrtSJhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687064; c=relaxed/simple;
	bh=iaP6b8w9lrE8ipKBPTJXmKuSuzrUGzo7G9823oibSis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzTGbjmqdDn2OCqY93f/i6HSZcVFKjLGQq9qggCP2DQNYDWTH8GkaPjDjRNa4eOWJfu0t/lukos3NZ4II00gtYc8+2qkbKSwoKxmH9fK7iDfv0sxQkQqA9S5NNBuGSqVZP6woiTw9BaRHWRaQF5bi6+kHbCX1EovElLRm7M+c2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NNFPo6F/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso419312266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710687060; x=1711291860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzkgJIRc2tYmJ3Btk0xVIO9rDn0mpVtYOI9YDc2eSB4=;
        b=NNFPo6F/jgZQNg2aYAeEdseRfPyNRRXXhCW/IoMScMjd3yj7rYGPHkaG3QnIdw0vqi
         3lcHXO4XfDLZVfw16hDmwbU8z3SLqkuVVkNWbtwZL3u7UsulfD0quYX4s99GHNePIj5d
         LgT5HjnYce6Iqaj1YbBZm2uZcU6bqhpTJqocJGUgknwoIxUmVw5R78OFtnQh1ml1xrtS
         oeos2J5pyQw5XuZd2eerkzX1qnU8LMophtHgvXAYhEOm8zu9Kzlel1+yZy/peMb9/tUd
         tciptpoedF41ms1sKONeT5WqvqPZNhgr44gBCvQF5UNxnILOEct0cCMjwpnCIQEHvgFM
         9zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710687060; x=1711291860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzkgJIRc2tYmJ3Btk0xVIO9rDn0mpVtYOI9YDc2eSB4=;
        b=RKzNRxitVI0/OMKdQaUj9j+8uKcL61G5jS3LOOcEv6pbaeih0MzC3uqBCDoTAtF2O5
         hw3soksQI3jKcpmpFZlNcZphuqaxdMiuC1k+48PxQc89AmsqE65axHk3ayZ5wvMYhAOt
         X9BV/zPuxoiMiAKqbUQNvMKhw8YpWUxB+GO4qnDxEIWk0566WDgw8P6r33JOH20wh89R
         Osd6VZ4YOOmwd33LSSnRQYo2/uta0OY789/s/G6r6AxpZdihCDcqE2zrpnjRAcpdicBE
         gqQe88xpFVK+CHPT432nfvGJ6GOjEYRIkl2JB3PP26gCzXQZ/+nlhZswrYgQtMjm0LbP
         xQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0KL+BSsHvA0XPRc2bm2B3LQtZ/TfSVyvyrrlueKobft577w+Bl0ZBQyMUibNjsRMNIrKJLDsofMnqBUeviFDEBuVPa4sH/Y/0Nfyz
X-Gm-Message-State: AOJu0Yx/gnc29nDEHx8Jl6aS5TmkWOBJuoe/AythN+vllVPJXatSuM7k
	8Lx7CtOo1prO5JuZsb8byDC/p3LOETNNPn4VWWhM93KQRcYC1Wh9cVWZ9yD1PHo=
X-Google-Smtp-Source: AGHT+IEh9mfhHobJDKbSW8F2c89QW3ynMelBgP21Gj4W8BGI1tkkbQZK51shego22/azCsTJcxmG0A==
X-Received: by 2002:a17:906:c411:b0:a46:635b:bb3e with SMTP id u17-20020a170906c41100b00a46635bbb3emr5701615ejz.52.1710687059641;
        Sun, 17 Mar 2024 07:50:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709064a0d00b00a453b2261b4sm3797814eju.184.2024.03.17.07.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 07:50:59 -0700 (PDT)
Message-ID: <cc55daa1-0256-48d1-97a4-0f755fb4951b@linaro.org>
Date: Sun, 17 Mar 2024 15:50:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Content-Language: en-US
To: Wadim Mueller <wafgo01@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Johannes Zink <j.zink@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Swee Leong Ching <leong.ching.swee@intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-2-wafgo01@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315222754.22366-2-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 23:27, Wadim Mueller wrote:
> This commit adds device tree support for the NXP S32G3-based
> S32G-VNP-RDB3 Board (Vehicle Networking Platform - Reference Design Board) [1].
> 
> The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.
> 
> The device tree files are derived from the official NXP downstream Linux tree [2].
> 
> This addition encompasses a limited selection of peripherals that are upstream-supported. Apart from the ARM System Modules (GIC, Generic Timer, etc.), the following IPs have been validated:
> 
>     UART: fsl-linflexuart
>     SDHC: fsl-imx-esdhc
>     Ethernet: synopsys gmac/stmac
> 
> Clock settings for the chip rely on ATF Firmware [3]. Pin control integration into the device tree is pending and currently relies on Firmware/U-Boot settings [4].
> 
> These changes were validated using the latest BSP39 Firmware/U-Boot from NXP [5].
> 
> The modifications enable booting the official Ubuntu 22.04 from NXP on
> the RDB3 with default settings from the SD card and eMMC.
> 
> [1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
> [2] https://github.com/nxp-auto-linux/linux
> [3] https://github.com/nxp-auto-linux/arm-trusted-firmware
> [4] https://github.com/nxp-auto-linux/u-boot
> [5] https://github.com/nxp-auto-linux/auto_yocto_bsp
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 352 ++++++++++++++++++
>  .../boot/dts/freescale/s32g399a-rdb3.dts      |  57 +++
>  .../dt-bindings/clock/nxp,s32-scmi-clock.h    | 158 ++++++++

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Bindings are not DTS.

>  4 files changed, 568 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
>  create mode 100644 include/dt-bindings/clock/nxp,s32-scmi-clock.h
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2cb0212b63c6..e701008dbc7b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -252,3 +252,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> +dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> new file mode 100644
> index 000000000000..481ddcfd3a6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/nxp,s32-scmi-clock.h>
> +/ {
> +	compatible = "nxp,s32g3";

Order your patches correctly. Bindings come before users.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <0x02>;
> +	#size-cells = <0x02>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			clocks = <&dfs S32_SCMI_CLK_A53>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cluster0_l2_cache: l2-cache0 {

l2-cache-0

> +			compatible = "cache";
> +			status = "okay";

Why do you need it? It's enabled by default.

Anyway it incomplete:
It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		};
> +
> +		cluster1_l2_cache: l2-cache1 {

l2-cache-1

> +			compatible = "cache";
> +			status = "okay";
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* virt */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* hyp-virt */
> +		             <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> +		             <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* phys */
> +		always-on;
> +	};
> +
> +	reserved-memory  {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_tx_buf: shm@d0000000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0xd0000000 0x0 0x80>;
> +			no-map;
> +		};
> +
> +		scmi_rx_buf: shm@d0000080 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0xd0000080 0x0 0x80>;
> +			no-map;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			mbox-names = "tx", "rx";
> +			shmem = <&scmi_tx_buf>, <&scmi_rx_buf>;
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "okay";

Drop or explain why is it needed.

> +			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "p2a_notif";
> +
> +			dfs: protocol@13 {
> +				reg = <0x13>;
> +				#clock-cells = <1>;
> +			};
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			reset: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +
> +			pinctrl_scmi: protocol@80 {
> +				reg = <0x80>;
> +				#pinctrl-cells = <2>;
> +
> +				status = "disabled";
> +			};
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0x80000000>;
> +
> +		uart0: serial@401c8000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401c8000 0x3000>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@401cc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401cc000 0x3000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@402bc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x402bc000 0x3000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@50800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x50800000 0x10000>,
> +			      <0x50900000 0x200000>,
> +			      <0x50400000 0x2000>,
> +			      <0x50410000 0x2000>,
> +			      <0x50420000 0x2000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			mbi-ranges = <167 16>;
> +		};
> +
> +		qspi: spi@40134000 {

Keep order by unit address.

> +			compatible = "nxp,s32g3-qspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x00000000 0x0 0x20000000>,
> +				<0x0 0x40134000 0x0 0x1000>;
> +			reg-names = "QuadSPI-memory", "QuadSPI";
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "qspi_en", "qspi";
> +			clocks = <&clks S32_SCMI_CLK_QSPI_FLASH1X>,
> +				 <&clks S32_SCMI_CLK_QSPI_FLASH1X>;
> +			spi-max-frequency = <200000000>;
> +			spi-num-chipselects = <2>;
> +			status = "disabled";
> +		};
> +
> +		usdhc0: mmc@402f0000 {
> +			compatible = "nxp,s32g3-usdhc",
> +			             "nxp,s32g2-usdhc";
> +			reg = <0x402f0000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks S32_SCMI_CLK_USDHC_MODULE>,
> +				 <&clks S32_SCMI_CLK_USDHC_AHB>,
> +				 <&clks S32_SCMI_CLK_USDHC_CORE>;
> +			clock-names = "ipg", "ahb", "per";
> +			status = "disabled";
> +		};
> +
> +		gmac0: ethernet@4033c000 {
> +			status = "disabled";

Random code... sorry, but status does not come first. Put it last and
please read carefully DTS coding style.

> +			compatible = "nxp,s32-dwmac";
> +			reg = <0x4033c000 0x2000>, /* gmac IP */
> +			      <0x4007c004 0x4>;    /* S32 CTRL_STS reg */
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			tx-fifo-depth = <20480>;
> +			rx-fifo-depth = <20480>;
> +			dma-coherent;
> +			snps,mtl-rx-config = <&mtl_rx_setup_gmac0>;
> +			snps,mtl-tx-config = <&mtl_tx_setup_gmac0>;
> +			clocks = <&clks S32_SCMI_CLK_GMAC0_AXI>,
> +				 <&clks S32_SCMI_CLK_GMAC0_AXI>,
> +				 <&clks S32_SCMI_CLK_GMAC0_TX_SGMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_TX_RGMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_TX_RMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_TX_MII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_RX_SGMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_RX_RGMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_RX_RMII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_RX_MII>,
> +				 <&clks S32_SCMI_CLK_GMAC0_TS>;
> +			clock-names = "stmmaceth", "pclk",
> +				      "tx_sgmii", "tx_rgmii",
> +				      "tx_rmii", "tx_mii",
> +				      "rx_sgmii", "rx_rgmii",
> +				      "rx_rmii", "rx_mii",
> +				      "ptp_ref";
> +
> +			mtl_rx_setup_gmac0: rx-queues-config {
> +				snps,rx-queues-to-use = <5>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				queue@0 {};
> +				queue@1 {};
> +				queue@2 {};
> +				queue@3 {};
> +				queue@4 {};
> +			};
> +
> +			mtl_tx_setup_gmac0: tx-queues-config {
> +				snps,tx-queues-to-use = <5>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				queue@0 {};
> +				queue@1 {};
> +				queue@2 {};
> +				queue@3 {};
> +				queue@4 {};
> +			};
> +
> +			gmac0_mdio: mdio0 {

mdio?

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> new file mode 100644
> index 000000000000..707b503c0165
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
> + */
> +
> +/dts-v1/;
> +
> +#include "s32g3.dtsi"
> +
> +/ {
> +	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
> +	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";

Missing bindings.



Best regards,
Krzysztof


