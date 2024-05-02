Return-Path: <linux-kernel+bounces-166632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD998B9D47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055191F2250D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F315AADA;
	Thu,  2 May 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgNYcedM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2C15ADBB;
	Thu,  2 May 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663214; cv=none; b=hKNsLMWgHD3Yr65DGOTjCU8cq5HAGJ1eTSlPw7taO8BbZwj4Od0J3bJM8n8QRLJyunLz2izObG9I7XWFTa6DEk1PD0S8cujSb/CSi2CYgQ79+wdEEwlIcv3jo0BVB91B27gkiDRqrcqJJmky0taW1yKJY+FiQdPwllsL51yR8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663214; c=relaxed/simple;
	bh=v43W+Id+SXUtihys+FO7PLR0yrpaTn3IG+fuSXsqDIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/F8RTg6lBG8VZol1BsMfz2EZ6p63aDZXigHO2RNcIqFCIb8xlruaPx1N4s7/eAEJHOvQZOCBDGCk/9KsxqvXUQ9dDdmu3jYdZHIKZ/DSQxNfyzoDUAmrso88A2VtACiLhOmshXCdrNGoI244k9KtE0bIfgR8AzCwV5Q9CcPbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgNYcedM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA06C4AF18;
	Thu,  2 May 2024 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663214;
	bh=v43W+Id+SXUtihys+FO7PLR0yrpaTn3IG+fuSXsqDIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TgNYcedMxaD4k6VPuq7dn8PKamcNNPczEUHy+GJo5drCXRZuKq2klRzGjeCJVEagH
	 Cx7gh+5a7r76340F7e3Ix1Eg3orvrOI6JnfRzXRSMWEPhz6uY4hUn2D8pljYBMF73P
	 9ZHE9UviIlA8uRuYveUbFTpKcEzFWin1eLIRyhMPkmTT9w0PpRhNVr3JmWbGPZ5hhe
	 LGb7ePRKjYo4I4YGUY9s0lFFNlVxqvrIx9YKWzoekI8MDrn90NGhe+n8k9Sgkhm8Gk
	 Ja8FOlTdWFXuxeX53Xui0Q7KKAClZsiUZRULCIAB5zuuq3fIkXfNQCcfYQjCnBW8Aw
	 J3/jwR/ktRg/A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db13ca0363so130830541fa.3;
        Thu, 02 May 2024 08:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU4RVc1H1cq06c0oKoZnZwchUsNTJwi5cdCw8Htvk34EQMM/jmPp+PDWkeYMmjBJApMm6Lkrn4lJ6XirgsYCpgq1KA/ZzWTXTdxw6TbeIZrBBtmED7YSbPYGzpNMuyTQOnwLzOTVKyiA==
X-Gm-Message-State: AOJu0YxoWaURn4dqJQYI/VcCAxH2z0lh5WC9LvQsUdGwv4W7ElUhN0Vu
	8B7HeiOu9ReGXKf4HD82JRmikXf0rjR5Ac3xt+K2TxY0QVlPlMnmz6L8mLh3xRppNjgTR+RiTls
	TvPjEVIGUQ40eCEVw6aKtMmBvjg==
X-Google-Smtp-Source: AGHT+IFYPLBrsPHkwfF2ym7/pTS0ke11sSjNYp2kGQEbKDVGn/xOHGJXiBE4zQef1aSD2qe+gbHxLu5hbl6ifTcF8cc=
X-Received: by 2002:a2e:9652:0:b0:2e1:a504:f9ec with SMTP id
 z18-20020a2e9652000000b002e1a504f9ecmr48825ljh.23.1714663212706; Thu, 02 May
 2024 08:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com> <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
In-Reply-To: <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 2 May 2024 10:20:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGO9W5ysX_OWhP--8TGXiY19d5TeDL7Ne8rmj+GgWCcQ@mail.gmail.com>
Message-ID: <CAL_JsqJGO9W5ysX_OWhP--8TGXiY19d5TeDL7Ne8rmj+GgWCcQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 7:32=E2=80=AFAM Josua Mayer <josua@solid-run.com> wr=
ote:
>
> Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
> with an extra communication  processor on the carrier board.
>
> This board differentiates itself from CN9130 Clearfog by providing
> additional SoC native network interfaces and pci buses:
> 2x 10Gbps SFP+
> 4x 1Gbps RJ45
> 1x miniPCI-E
> 1x m.2 b-key with sata, usb-2.0 and usb-3.0
> 1x m.2 m-key with pcie and usb-2.0
> 1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
> 1x mpcie with pcie only
> 2x type-a usb-2.0/3.0
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  arch/arm64/boot/dts/marvell/Makefile               |   1 +
>  arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 643 +++++++++++++++=
++++++
>  2 files changed, 644 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/m=
arvell/Makefile
> index 019f2251d696..16f9d7156d9f 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D ac5x-rd-carrier-cn9131.dt=
b
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D ac5-98dx35xx-rd.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-base.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-cf-pro.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9131-cf-solidwan.dtb
> diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/ar=
m64/boot/dts/marvell/cn9131-cf-solidwan.dts
> new file mode 100644
> index 000000000000..a63a8961bad0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun CN9130 Clearfog Base.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +#include "cn9130.dtsi"
> +#include "cn9130-sr-som.dtsi"
> +
> +/*
> + * Instantiate the external CP115
> + */
> +
> +#define CP11X_NAME             cp1
> +#define CP11X_BASE             f4000000
> +#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
> +#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
> +#define CP11X_PCIE0_BASE       f4600000
> +#define CP11X_PCIE1_BASE       f4620000
> +#define CP11X_PCIE2_BASE       f4640000
> +
> +#include "armada-cp115.dtsi"
> +
> +#undef CP11X_NAME
> +#undef CP11X_BASE
> +#undef CP11X_PCIEx_MEM_BASE
> +#undef CP11X_PCIEx_MEM_SIZE
> +#undef CP11X_PCIE0_BASE
> +#undef CP11X_PCIE1_BASE
> +#undef CP11X_PCIE2_BASE
> +
> +/ {
> +       model =3D "SolidRun CN9131 SolidWAN";
> +       compatible =3D "solidrun,cn9131-solidwan",
> +                    "solidrun,cn9130-sr-som", "marvell,cn9130";
> +
> +       aliases {
> +               ethernet0 =3D &cp1_eth1;
> +               ethernet1 =3D &cp1_eth2;
> +               ethernet2 =3D &cp0_eth1;
> +               ethernet3 =3D &cp0_eth2;
> +               ethernet4 =3D &cp0_eth0;
> +               ethernet5 =3D &cp1_eth0;
> +               gpio0 =3D &ap_gpio;
> +               gpio1 =3D &cp0_gpio1;
> +               gpio2 =3D &cp0_gpio2;
> +               gpio3 =3D &cp1_gpio1;
> +               gpio4 =3D &cp1_gpio2;
> +               gpio5 =3D &expander0;
> +               i2c0 =3D &cp0_i2c0;
> +               i2c1 =3D &cp0_i2c1;
> +               i2c2 =3D &cp1_i2c1;
> +               mmc0 =3D &ap_sdhci0;
> +               mmc1 =3D &cp0_sdhci0;
> +               rtc0 =3D &cp0_rtc;
> +               rtc1 =3D &carrier_rtc;
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&cp0_led_pins &cp1_led_pins>;
> +
> +               /* for sfp-1 (J42) */
> +               led-sfp1-activity {
> +                       label =3D "sfp1:green";
> +                       gpios =3D <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               /* for sfp-1 (J42) */
> +               led-sfp1-link {
> +                       label =3D "sfp1:yellow";
> +                       gpios =3D <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               /* (J28) */
> +               led-sfp0-activity {
> +                       label =3D "sfp0:green";
> +                       gpios =3D <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               /* (J28) */
> +               led-sfp0-link {
> +                       label =3D "sfp0:yellow";
> +                       gpios =3D <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +
> +       /* Type-A port on J53 */
> +       reg_usb_a_vbus0: regulator-usb-a-vbus0 {
> +               compatible =3D "regulator-fixed";
> +               pinctrl-0 =3D <&cp0_reg_usb_a_vbus0_pins>;
> +               pinctrl-names =3D "default";
> +               regulator-name =3D "vbus0";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               regulator-oc-protection-microamp =3D <1000000>;
> +               gpio =3D <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;

"gpio" is deprecated.

> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       reg_usb_a_vbus1: regulator-usb-a-vbus1 {
> +               compatible =3D "regulator-fixed";
> +               pinctrl-0 =3D <&cp0_reg_usb_a_vbus1_pins>;
> +               pinctrl-names =3D "default";
> +               regulator-name =3D "vbus1";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               regulator-oc-protection-microamp =3D <1000000>;
> +               gpio =3D <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       sfp0: sfp-0 {
> +               compatible =3D "sff,sfp";
> +               pinctrl-0 =3D <&cp0_sfp0_pins>;
> +               pinctrl-names =3D "default";
> +               i2c-bus =3D <&cp0_i2c1>;
> +               los-gpio =3D <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
> +               mod-def0-gpio =3D <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
> +               tx-disable-gpio =3D <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
> +               tx-fault-gpio =3D <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;

As is "-gpio" suffix.  These are all pointed out with 'dtbs_check'
which I sent a report on v3. I haven't checked what else from that you
ignored... I don't expect warnings inherited from the SoC .dtsi to be
fixed in this series, but certainly the board level ones. Yes, it's
hard to pick out those, but that's the Marvell folks fault for not
fixing SoC level warnings.

Rob

