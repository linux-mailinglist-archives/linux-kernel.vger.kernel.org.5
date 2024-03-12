Return-Path: <linux-kernel+bounces-100090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D218791A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78DF1C220CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956A7829A;
	Tue, 12 Mar 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gj/i2jSd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1879DA2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237811; cv=none; b=aKIjHHXN49J5tuf8I1zfQOoSyqqgS4rsc21frxyMj+6D/SLBM3Mw6szXaXnVBMwYayP9QOOtrYwIu1nS530fgOlxSpwiWd5SQnfA9kzxP2qJhNX1nXYDnfFpcKibN6FQo6XBQo8a0U0OJjXrQNIdrKAXlcGFE6nyDcsO7ZoXfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237811; c=relaxed/simple;
	bh=DbcSmcTIJFR29lweI8AtpPtEE/MH4RA8MyskSm4u9lg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=F7DpLrwbc7a7FR5yg6HyrhE6ePAJVXSkO6dDGQFzRjlyhYyLooaaZo5/Oeimq5NVc1Wt8SXTNDAoi5IRM4uxU/iOrnL/XxKZKB1ta0RyzFMx3uGMbtHYUTcxUX3kfl7UGFot8Te9xXG8M/N2XvHuvzt/N5PorLxw6Zmkn8NHnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gj/i2jSd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412f1961101so40342845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710237806; x=1710842606; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+6NBK9GZFZcA1mqhksqU9TzRXZJpQpDT2fBbPUtZjzY=;
        b=gj/i2jSdnJjGhnZMJgjD/irGXqvu0njamlmF6D+AY223zvgj8njALaADf23EgOuZjk
         TTNRRldDxmCNd9DNNSn7IvXraaQhXjBmIMB639Hkasy8r9AUAyHsYEpjQOixtksjFBfe
         sKo7De9izcoqxJY+N9SEgzBzOnwRUCHqT5M7GjBDqjo1pGsv2fYGNraw5KqqZ3guIHr4
         86BZJTokZLK1AnXN4N9Hvbd6jk/1jVN0ZxjkxPMLxl2aCzgfP0/MbE4CoY+VnRLDr+AU
         u8FsZb/QpqyKVPh65QllE0eyAU3mvwbR5aGfgW/tRYNYugN8leRQGIZdaG7hR9GvP6VH
         M8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710237806; x=1710842606;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6NBK9GZFZcA1mqhksqU9TzRXZJpQpDT2fBbPUtZjzY=;
        b=Ye+2FEKFJhCJ0mgLp2xIQeZRW0KCbRFvtXU/ahlvR5ww5zI8Xycpx72+53HOsMzA/9
         bd5K/YqjwtDV7Bk//Vpv/hYAlvCvREkclxubgaI5CLzbdjv9lmw1GNLVEMM6ATOWoCFD
         bIPiCbQOvdbU5BfQMBPWyc/kfIwd4Ew8wUfDCCpcZKvt2hw9MyCIxIwNBNLLwQ4MVTfU
         C4CLTq3Pyn1aMRZ8jjPswkGgNe0pKhRGcE4zffghiSuTbs6tqphR0S+c0+bJGBT2eXC6
         Jg4vxBRnPLD4EVmsd1ripXGoz47S/5qIJNyQQ1uBA5z9gqgB05ebzJenePh+OeYHW5c/
         KZZg==
X-Forwarded-Encrypted: i=1; AJvYcCViCIWEtURtDEdpGDeDdwvbZblsP7/QXuvE8UEvp/vluXXFaSFscmlzOLIgL3pIs6k7aiiesUNOVNX44Hey0y0EYt1mSxrtg16WLScZ
X-Gm-Message-State: AOJu0Yx5ZhuXuey6qMsyAxri1eU9X5eQi+K20dyGuBWIhY4fUVTi+Du5
	5W3wAgjocmlQDsKry0qQEd1yWFJDV8dGjz7CwufzEELyJqFiylQ9Hj1QEj+1S5c=
X-Google-Smtp-Source: AGHT+IFwmAwXZJLUTdK6OfZHgdYWyHu7gnRIhGHS72jZJ+Xk3H6cq0glt8xuBj/czyH8RrBJrrq57g==
X-Received: by 2002:a05:600c:4f0f:b0:413:117e:fd4a with SMTP id l15-20020a05600c4f0f00b00413117efd4amr6520264wmq.3.1710237805350;
        Tue, 12 Mar 2024 03:03:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:af7b:cf60:208b:83f4])
        by smtp.gmail.com with ESMTPSA id h2-20020a056000000200b0033e433cb471sm8660214wrx.79.2024.03.12.03.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:03:24 -0700 (PDT)
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Date: Tue, 12 Mar 2024 10:55:46 +0100
In-reply-to: <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
Message-ID: <1jsf0vephv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 12 Mar 2024 at 17:18, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

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

Could you describe how the a4 and a5 differs from each other ?
The description given in the commit description is the same.

Beside the a53 vs a55, I'm not seeing much of a difference.
Admittedly, there is not much yet but I wonder if a4 and a5 should have
a common dtsi.

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

That's a lot of memory to blindly reserve.
Any chance we can stop doing that and have u-boot amend reserved memory
zone based on the actual needs of the device ?

> +		secmon_reserved:linux,secmon {
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

Really ? still on the that old version ?

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
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +			uart_b: serial@7a000 {
> +				compatible = "amlogic,meson-s4-uart",
> +					     "amlogic,meson-ao-uart";
> +				reg = <0x0 0x7a000 0x0 0x18>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};


-- 
Jerome

