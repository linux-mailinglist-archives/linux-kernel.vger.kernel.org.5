Return-Path: <linux-kernel+bounces-158932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428148B26F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE43C2851DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2814E2E0;
	Thu, 25 Apr 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+2bBlbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD014E2D4;
	Thu, 25 Apr 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064185; cv=none; b=adXx+PFDQDqDi5yZ+owZ36u9i7EUyfSj5OuAjdzUq8lhXMsbYI2+9guDqB8u1CPM/8U+jIETKPsauiYTWlhm2m1/CYKyDhpmJ8Z2aVuxj02kSr/ohrgE8o77TuD/HcV6NNLcmRcUao4Qz65l8RGkI/I+Oo6bHjYmZy3vWzdxU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064185; c=relaxed/simple;
	bh=Atp8C0xu28D1QHhbI+/+kdM/y7paXO13iMBXxeH1mio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9jSqf7VfmAbGE5gJlTVdWf629EhCBMnZteMsv+57+6gXoflLRw6KCXiPDkyQiO0YNx/w4nPsoOgZV7NZ4I9Cdgj9dXv3XchyEMByxd4VEFUOqZ3aDYm4zuZERdFM2NqMh08LiY1K3o1k1PrBeDSR4yABwN1VsYwFti6279xZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+2bBlbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E60BC2BD11;
	Thu, 25 Apr 2024 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714064185;
	bh=Atp8C0xu28D1QHhbI+/+kdM/y7paXO13iMBXxeH1mio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I+2bBlbpL2K3sB0dWqKbW0KQfb2IzQPEX5hqGNNJqrBN/zYVee98UFMadRfUxr4O0
	 MhhMnj4Hq165xgullAd5Zdt310Uu2fzyUxUlAKum5btv9PZnaZmiMuYfb/kijQnZji
	 Vk5VlvFjAYJxGgLpEkOeVIqmav6W0meYNDAyJhXnsQ/t6QqXlQloDQTdsAyJpfiU7m
	 TtMPLSYuTdlz/QKg6FhttG8qrr+gkwsxAbWF3Btw9CPArc42wmWNX+phP+gsQrMKKH
	 ro+OGtnZ+SfQqjd9kDtlTzhcaD1lMMCZhTFgkfTO6s2o2/0ZIMtyQHjPQyoJl8GLpj
	 KLasmAGQIktmw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so14276451fa.3;
        Thu, 25 Apr 2024 09:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiHM7Kq7i7Hb+pcjUjV70rw+2q3hscJjejEcCwEC14bCYPj4IULU/LAlX9C0fx5Mos8h4T6O3bkwnQ69eMJNALtO7PyOOKweuqrk4n2+1aADpTo5laRiI42b1DJRJbNhD8RmTZQMn44A==
X-Gm-Message-State: AOJu0YxmkBaQpr9xON7VcyK0KEXUpJ5abvQlaTMpRJdDuRufKaeWTMb2
	9EvAS4ouTBE1v/lZ9+pDyH69t0WtcgUP6iqfphx0YxzEx2QvlP5WjnXG/8Qmpi3CikRkZpxJbSb
	pbDkte1M8bRc2WdK6Z2f4Jp7/OQ==
X-Google-Smtp-Source: AGHT+IH7YfbmVhza2t6tUTycBo8DCokXEg7YYW8Q+9NWxtxjdzxdEjMKAXck7iiq7K7XPtBsRZhxcaXy0YjHPFrw/yI=
X-Received: by 2002:a05:651c:2116:b0:2de:d48a:953b with SMTP id
 a22-20020a05651c211600b002ded48a953bmr2463543ljq.23.1714064183502; Thu, 25
 Apr 2024 09:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com> <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 25 Apr 2024 11:56:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJG3NuUcfK3CGhUa1g1eHEpjmmkWQtJoiWimiCsUwhq+Q@mail.gmail.com>
Message-ID: <CAL_JsqJG3NuUcfK3CGhUa1g1eHEpjmmkWQtJoiWimiCsUwhq+Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: Add initial support for Blaize BLZP1600 CB2
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>, 
	Neil Jones <neil.jones@blaize.com>, Matt Redfearn <matthew.redfearn@blaize.com>, 
	James Cowgill <james.cowgill@blaize.com>, 
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>, "sre@kernel.org" <sre@kernel.org>, 
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, 
	"andre.przywara@arm.com" <andre.przywara@arm.com>, "rafal@milecki.pl" <rafal@milecki.pl>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andersson@kernel.org" <andersson@kernel.org>, 
	"konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, 
	"nfraprado@collabora.com" <nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 4:15=E2=80=AFAM Niko Pasaloukos
<nikolaos.pasaloukos@blaize.com> wrote:
>
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.
>
> The blaize-blzp1600.dtsi is the common part for the SoC,
> blaize-blzp1600-som.dtsi is the common part for the SoM and
> blaize-blzp1600-cb2.dts is the board specific file.
>
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>  .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 209 ++++++++++++++++++
>  5 files changed, 319 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/blaize/Makefile
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
>
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 30dd6347a929..601b6381ea0c 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -9,6 +9,7 @@ subdir-y +=3D apm
>  subdir-y +=3D apple
>  subdir-y +=3D arm
>  subdir-y +=3D bitmain
> +subdir-y +=3D blaize
>  subdir-y +=3D broadcom
>  subdir-y +=3D cavium
>  subdir-y +=3D exynos
> diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/bl=
aize/Makefile
> new file mode 100644
> index 000000000000..595e7a350300
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-cb2.dtb
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/ar=
m64/boot/dts/blaize/blaize-blzp1600-cb2.dts
> new file mode 100644
> index 000000000000..0bdec7e81380
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0

Preferred license is GPL-2.0 plus a permissive license.

> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.

2024 now.

> + */
> +
> +/dts-v1/;
> +
> +#include "blaize-blzp1600-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +       model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
> +
> +       compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200";
> +       };
> +};
> +
> +&i2c0 {
> +       clock-frequency =3D <100000>;
> +       status =3D "okay";
> +};
> +
> +&i2c1 {
> +       clock-frequency =3D <100000>;
> +       status =3D "okay";
> +};
> +
> +&i2c3 {
> +       clock-frequency =3D <100000>;
> +       status =3D "okay";
> +
> +       gpio_expander: gpio@74 {
> +               compatible =3D "ti,tca9539";
> +               reg =3D <0x74>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               gpio-line-names =3D "RSP_PIN_7",  /* GPIO_0 */
> +                                 "RSP_PIN_11", /* GPIO_1 */
> +                                 "RSP_PIN_13", /* GPIO_2 */
> +                                 "RSP_PIN_15", /* GPIO_3 */
> +                                 "RSP_PIN_27", /* GPIO_4 */
> +                                 "RSP_PIN_29", /* GPIO_5 */
> +                                 "RSP_PIN_31", /* GPIO_6 */
> +                                 "RSP_PIN_33", /* GPIO_7 */
> +                                 "RSP_PIN_37", /* GPIO_8 */
> +                                 "RSP_PIN_16", /* GPIO_9 */
> +                                 "RSP_PIN_18", /* GPIO_10 */
> +                                 "RSP_PIN_22", /* GPIO_11 */
> +                                 "RSP_PIN_28", /* GPIO_12 */
> +                                 "RSP_PIN_32", /* GPIO_13 */
> +                                 "RSP_PIN_36", /* GPIO_14 */
> +                                 "TP31";       /* GPIO_15 */
> +       };
> +
> +       gpio_expander_m2: gpio@75 {
> +               compatible =3D "ti,tca9539";
> +               reg =3D <0x75>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               gpio-line-names =3D "M2_W_DIS1_N",        /* GPIO_0 */
> +                                 "M2_W_DIS2_N",        /* GPIO_1 */
> +                                 "M2_UART_WAKE_N",     /* GPIO_2 */
> +                                 "M2_COEX3",           /* GPIO_3 */
> +                                 "M2_COEX_RXD",        /* GPIO_4 */
> +                                 "M2_COEX_TXD",        /* GPIO_5 */
> +                                 "M2_VENDOR_PIN40",    /* GPIO_6 */
> +                                 "M2_VENDOR_PIN42",    /* GPIO_7 */
> +                                 "M2_VENDOR_PIN38",    /* GPIO_8 */
> +                                 "M2_SDIO_RST_N",      /* GPIO_9 */
> +                                 "M2_SDIO_WAKE_N",     /* GPIO_10 */
> +                                 "M2_PETN1",           /* GPIO_11 */
> +                                 "M2_PERP1",           /* GPIO_12 */
> +                                 "M2_PERN1",           /* GPIO_13 */
> +                                 "UIM_SWP",            /* GPIO_14 */
> +                                 "UART1_TO_RSP";       /* GPIO_15 */
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/a=
rm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> new file mode 100644
> index 000000000000..efac0d6b3d60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include "blaize-blzp1600.dtsi"
> +
> +/ {
> +       memory@1000 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x00001000 0xfffff000>;

Memory starting at 4K. That's odd. I suspect you have something
reserved there and memory really starts at 0? If so, it is preferred
that you describe memory including that 4KB and then reserve it in
/memreserve/ section or /reserved-memory node.


> +       };
> +};
> +
> +/* i2c4 bus is available only on the SoM, not on the board */
> +&i2c4 {
> +       clock-frequency =3D <100000>;
> +       status =3D "okay";
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64=
/boot/dts/blaize/blaize-blzp1600.dtsi
> new file mode 100644
> index 000000000000..26d8943d60ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       interrupt-parent =3D <&gic>;
> +       #address-cells =3D <2>;
> +       #size-cells =3D <1>;
> +
> +       cpus {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <0>;
> +
> +               cpu0: cpu@0 {
> +                       compatible =3D "arm,cortex-a53";
> +                       device_type =3D "cpu";
> +                       enable-method =3D "psci";
> +                       reg =3D <0x0 0x0>;
> +                       next-level-cache =3D <&l2>;
> +               };
> +
> +               cpu1: cpu@1 {
> +                       compatible =3D "arm,cortex-a53";
> +                       device_type =3D "cpu";
> +                       enable-method =3D "psci";
> +                       reg =3D <0x0 0x1>;
> +                       next-level-cache =3D <&l2>;
> +               };
> +
> +               l2: l2-cache0 {
> +                       compatible =3D "cache";
> +                       cache-level =3D <2>;
> +                       cache-unified;
> +               };
> +       };
> +
> +       timer {
> +               compatible =3D "arm,armv8-timer";
> +               interrupts =3D /* Physical Secure PPI */
> +                            <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            /* Physical Non-Secure PPI */
> +                            <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            /* Hypervisor PPI */
> +                            <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            /* Virtual PPI */
> +                            <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
> +                                         IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       psci {
> +               compatible =3D "arm,psci-1.0", "arm,psci-0.2";
> +               method =3D "smc";
> +       };
> +
> +       pmu {
> +               compatible =3D "arm,cortex-a53-pmu";
> +               interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-affinity =3D <&cpu0>, <&cpu1>;
> +       };
> +
> +       sram@0 {
> +               /*
> +                * On BLZP1600 there is no general purpose (non-secure) S=
RAM.
> +                * A small DDR memory space has been reserved for general=
 use.
> +                */
> +               compatible =3D "mmio-sram";
> +               reg =3D <0x0 0x00000000 0x00001000>;

Ah, there it is. This isn't mmio-sram.

> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges =3D <0 0x0 0x00000000 0x1000>;
> +
> +               /* SCMI reserved buffer space on DDR space */
> +               scmi0_shm: scmi-sram@800 {
> +                       compatible =3D "arm,scmi-shmem";
> +                       reg =3D <0x800 0x80>;
> +               };

Just put this node into /reserved-memory.

> +       };
> +
> +       firmware {
> +               scmi {
> +                       compatible =3D "arm,scmi-smc";
> +                       arm,smc-id =3D <0x82002000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       shmem =3D <&scmi0_shm>;
> +
> +                       scmi_clk: protocol@14 {
> +                               reg =3D <0x14>;
> +                               #clock-cells =3D <1>;
> +                       };
> +
> +                       scmi_rst: protocol@16 {
> +                               reg =3D <0x16>;
> +                               #reset-cells =3D <1>;
> +                       };
> +               };
> +       };
> +
> +       soc {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <2>;
> +               #size-cells =3D <1>;
> +               ranges;

It is preferred if you limit this to actual ranges needed. Looks like
nothing below 0x200000000, but I imagine this is incomplete.

Rob

