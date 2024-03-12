Return-Path: <linux-kernel+bounces-100157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3A8792B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B6F1C218BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383B7995C;
	Tue, 12 Mar 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+lZkKDj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB069D0C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241671; cv=none; b=kZFL+RhcPCZpjqGB+M3R5iuahbE3VzWc7o+boH5I5hLOC/ZyJQYhSFUHontpVH0sZlvgEbUbKgQKZPL3iY8siWJ0mTlarYr2pebyHHHbHR0EKVC6wYvCdpgYAmpIipQCV9FL+WCMy4Cu8xjEGLW+9ZUDit5cpH9TuAJ+uQYQTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241671; c=relaxed/simple;
	bh=MmhrOasdT6Y/pnrhGjGokwxbalIfRJx5zYSaOB0QgCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUcBiKZV70gmwfXj9MjRSIXBqqlrz6FBBqdwkzsh920/PzvnpeOD4QB/dfQEga6TWz0FqZX8cgJfIMfjt4kXg83f//wuuwm0XwuxnhedpCXoSzFoLyuIDQf727DSc41JlDcWoDPlrU3phfz2WZMP6qgZx5hrxp76cqMov1u3+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+lZkKDj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e99915809so1558881f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710241668; x=1710846468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPeEGWoW+IoEdT4+n4ujFIP7VtdCdwMH4+qLi484W70=;
        b=s+lZkKDjciUSqWbjQTQeZ1y08esUMCuuROjh+3uF4GAiJoyUdkdQQuC3SqZ9NEpoyq
         khl7D8Vtk761JJ22KmdiTd6NvhURRyeS95x9KJ6IUiQHTMkKWOLu05GmmcW1e5Ll1R9V
         iaPeUiQsUkaDv5Uxx6/U9SwZ98QeMDGX3dF0GustCIyHmbA2jSzDhKfm2aowFv2QJxVb
         9R7tdS8HREaI5wGu+S4o0nlWbawqbovnV/jLoImc8g2L+ZIaIKUunAFffW1a8A3YHzgn
         3nAbYU/lpzoDNwMQf9VF0c6r+ehzUwnx8s/6vZIy8T7jTcyUZqwadDHV1kgXAsXwBjOr
         gwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241668; x=1710846468;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPeEGWoW+IoEdT4+n4ujFIP7VtdCdwMH4+qLi484W70=;
        b=Hyy5IhmJ1Gi9PEATPnukF3j3iXRjEsDqFYUdAGqtdgH7SD7Ur5dKq6y+Oat9lEmW2p
         lGdafTpsNnTnUassb86a/53SRVMQ9bfOlhh2G1feISss4CRXY4FWYDlnMciOFiskeTxX
         WTNook0241WUBJyP+T21wCwuICOtlFgOywP0BXkzwTaFlhSXs3eE+K+26PH/g78uCxmY
         5A+hEBeg7fa+TwVPVnF1uFkTqKCpLcesPaCsy8P1DLUryHTznnyv5gLziJ/77rQ3+KVb
         aPStAnBkmHl9aH6PXOjL/A5XcD5sLoipLwvJgp+6ETQP4ogRnvWWwG5+TfPw/rJzD5tX
         /86A==
X-Forwarded-Encrypted: i=1; AJvYcCW+wF803+eyx/ibELwZDEMsz8nryioGcVMLawywvNjLva+O7MJvs8MnLmP/QPF4uybC6wYyuIpdMDA/93W13qivLfP0Dwif2n0QFKxm
X-Gm-Message-State: AOJu0YzPlIdA2VqorFvGLdc+y0ya/ktfRz48CCEzYq1zLLq9US42nwHL
	eFQxkjRbcbkBKT09llW1UKJIZ0CQwRJQMda/jlL4DIO29He+Du0dDo1NHVgrfZo=
X-Google-Smtp-Source: AGHT+IH3aqWGudol2v0PS1/6Fw2zy0xkYpQr7TX3+YfUm+B0nQCIl3urEDvYpupkptHmvzKEXfVJ8w==
X-Received: by 2002:a05:6000:18e:b0:33d:1eea:4346 with SMTP id p14-20020a056000018e00b0033d1eea4346mr6014945wrx.37.1710241668000;
        Tue, 12 Mar 2024 04:07:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bs15-20020a056000070f00b0033e9f6997c7sm2800461wrb.66.2024.03.12.04.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:07:47 -0700 (PDT)
Message-ID: <2e222e07-6a14-4cf6-9d62-8e6d73b25f8d@linaro.org>
Date: Tue, 12 Mar 2024 12:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Content-Language: en-US
To: xianwei.zhao@amlogic.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 10:18, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Amlogic A4 is an application processor designed for smart audio
> and IoT applications.
> 
> Add basic support for the A4 based Amlogic BA400 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART.
> These are capable of booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>  .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 43 ++++++++++
>  arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 99 ++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 1ab160bf928a..9a50ec11bb8d 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>  dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>  dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>  dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
> new file mode 100644
> index 000000000000..60f9f23858c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-a4.dtsi"
> +
> +/ {
> +	model = "Amlogic A113L2 ba400 Development Board";
> +	compatible = "amlogic,ba400","amlogic,a4";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_b;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 52 MiB reserved for ARM Trusted Firmware */
> +		secmon_reserved:linux,secmon {

Missing space after:, unusual format of node name. Are you sure this
fits DTS coding convention?

> +			compatible = "shared-dma-pool";
> +			no-map;
> +			alignment = <0x0 0x400000>;
> +			reg = <0x0 0x05000000 0x0 0x3400000>;
> +		};
> +	};
> +};
> +
> +&uart_b {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> new file mode 100644
> index 000000000000..7e8745010b52
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x2000>,
> +			      <0x0 0xfff04000 0 0x2000>,
> +			      <0x0 0xfff06000 0 0x2000>;

Odd order of properties... reg is usually the second.



Best regards,
Krzysztof


