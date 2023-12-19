Return-Path: <linux-kernel+bounces-4831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C881829A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9032B1F24494
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA011725;
	Tue, 19 Dec 2023 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui7vmOAZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C411709
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso4515846a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702972471; x=1703577271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUqoC8a0H1m/IB5uqfFibRkj3TyPUEB/KnzqmOxxopE=;
        b=Ui7vmOAZezGzzPLmX/lvczl26RBNihR8pgvgmdYfllyqnBzauPrqTAW0nr5mVOO2eN
         ZZB40E5dmG8TbDcWvgTpcD1LTHDF+IyTqNkWqjZoZrL0ZQ5ZnPmsq3UpPbVsomEEaqRc
         /23fKQTZ0NsEorz3pQvKpP12fyIwkgUa0HEUEAMtO60N+scUdCU1jhx2nec2UdmcjQFI
         J6/LezjfQ2H9WgkIjWOsVKwG/ZkEppEKlLIHr1cBkyDTTDU90xx4p9+HeT50AZjCjQXS
         37TZgxvvnH7QpSKMHhW24yzD7Xhh7yYr5n/KV0FzTPBRGkXZoRfEHsn5qnETRVmy+ZGY
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972471; x=1703577271;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUqoC8a0H1m/IB5uqfFibRkj3TyPUEB/KnzqmOxxopE=;
        b=ienJcr35iJIkiuj+shbhFP6SZTqGxMuhFTv8G6vO0SubggO3dboyFk3aihL3NrwwxX
         ecDcr5htS9LxKlh4CWlfWKGNel0Sg4pcg8WoGjKgmadO0L+5TZVOm6kDRJMNdhVB4GUl
         9wLrpPW572FlrcrtKxh0pcrHMaJos2qynFq5JeKWB6dSW8IkKdIR/eyBr506tDqq2DGl
         gBSz7bCsu4zHEt7GRByXFo4oHkAoedYNzitZwQTBkeFTX6r/cSXpmG+iFwWlD1T3R+hL
         mKEbdfRMJ+MbAciphHDHukNiPmpTYpplBi2KfoOyFh8/64IUAdI1Hx4pS3T3zUg8UJk+
         3sAA==
X-Gm-Message-State: AOJu0YzaR10Sv4GBOha5JAV8R/yfuS0pArWkS5H6t3PzbCLnNnKuOAwU
	/HcwvAC9lghaUECor1BETAKe+w==
X-Google-Smtp-Source: AGHT+IFZhSSOtAwCVsHJJJf1rWRdIu++pdX+mz1mPY1jqEuAeU9MVhqoKeuGcqXpokEyhg3CMGyrug==
X-Received: by 2002:a17:906:207:b0:a22:fb54:6a49 with SMTP id 7-20020a170906020700b00a22fb546a49mr4821316ejd.138.1702972470714;
        Mon, 18 Dec 2023 23:54:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090648d700b00a233515c391sm3220702ejt.158.2023.12.18.23.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:54:30 -0800 (PST)
Message-ID: <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
Date: Tue, 19 Dec 2023 08:54:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 17:36, Jan Kiszka wrote:
> From: Baocheng Su <baocheng.su@siemens.com>
> 
> Main differences between the new variant and Advanced PG2:

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> 1. Arduino interface is removed. Instead, an new ASIC is added for
>    communicating with PLC 1200 signal modules.
> 2. USB 3.0 type A connector is removed, only USB 2.0 type A connector is
>    avaiable.
> 3. DP interface is tailored down. Instead, to communicate with the
>    PLC 1200 signal modules, a USB 3.0 type B connector is added but the
>    signal is not USB.
> 4. DDR size is increased to 4 GB.
> 5. Two sensors are added, one tilt sensor and one light sensor.
> 
> The light sensor it not yet added to the DT at this stage as it depends
> on to-be-added bindings.
> 
> Co-developed-by: Chao Zeng <chao.zeng@siemens.com>
> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> Co-developed-by: Li Hua Qian <huaqian.li@siemens.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> [Jan: rebase over arduino refactoring, split-out light sensor]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 210 ++++++++++++++++++
>  2 files changed, 211 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 77a347f9f47d..9b15eaad284c 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -53,6 +53,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-sm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
> new file mode 100644
> index 000000000000..ab3eef683890
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2023
> + *
> + * Authors:
> + *   Baocheng Su <baocheng.su@siemens.com>
> + *   Chao Zeng <chao.zeng@siemens.com>
> + *   Huaqian Li <huaqian.li@siemens.com>
> + *
> + * AM6548-based (quad-core) IOT2050 SM variant, Product Generation 2
> + * 4 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
> + *
> + * Product homepage:
> + * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am6548-iot2050-advanced-common.dtsi"
> +#include "k3-am65-iot2050-common-pg2.dtsi"
> +
> +/ {
> +	compatible = "siemens,iot2050-advanced-sm", "ti,am654";
> +	model = "SIMATIC IOT2050 Advanced SM";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 4G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	aliases {
> +		spi1 = &main_spi0;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>, <&user1_led_pins>;
> +
> +		user-led1-red {

led-0

> +			gpios = <&wkup_gpio0 52 GPIO_ACTIVE_HIGH>;

Missing function, missing color. Color goes as property, not as node name.

> +		};
> +
> +		user-led1-green {

led-1

> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;

Ditto


> +
> +&dwc3_0 {
> +	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
> +				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
> +	/delete-property/ phys;
> +	/delete-property/ phy-names;

If your board need to remove phys from the SoC node, something is wrong.
Either your board or SoC.

Any removal of properties in DTS is weird and unexpected. It deserves
comments.

> +};
> +
> +&usb0 {
> +	maximum-speed = "high-speed";
> +	/delete-property/ snps,dis-u1-entry-quirk;
> +	/delete-property/ snps,dis-u2-entry-quirk;

Same questions. If SoC has quirks, how can your board be fixed? It's SoC
property... or you are using different SoC.

Best regards,
Krzysztof


