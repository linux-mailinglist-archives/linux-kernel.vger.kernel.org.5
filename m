Return-Path: <linux-kernel+bounces-72171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67D85B06E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2DD1F228CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942C17547;
	Tue, 20 Feb 2024 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSzC9IHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7B10785;
	Tue, 20 Feb 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391898; cv=none; b=uN3s0OUInygSD8gUvKpc5bJ/ldCSbwi0f+lIbIB07Feraz7uCBOOkIAJIywx9kuW8BDFEXr5CKfhpT8ajw8YPUIYvK4N6jq0uUqisA607LekFJCLiVPF9he7aHBB2a2JHwoyEzSx98oNWeS2uiLLWbUS0ZpJEFIORosp5DDkeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391898; c=relaxed/simple;
	bh=WTH8xvtj80oNQYl3D+sWeUGKtHxI3W3Jq2AUCHP7cEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRr/miVJgsyr1GWydlYhjqJvnmu+WMO5y/gxIkNANeoI9l5hy9E+xjjTovAk8Ayd1JriNzSzxgru+hvgAGM0erqBqePXKwVlK2IbMbpwCuA4kF95fThqFPcMaNwwbyc1M5gmeUiQ/OXB89rSnE4ZRXZ3AqdmLXKPo2/Za5qHSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSzC9IHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C234C433A6;
	Tue, 20 Feb 2024 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708391897;
	bh=WTH8xvtj80oNQYl3D+sWeUGKtHxI3W3Jq2AUCHP7cEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FSzC9IHvaWwdQgtgv46bhtCoFk2IR78ZsruEuyYO/MCPdSd1tVpszZiJUkGC4Qf9R
	 oMFwHu89BN5NYmQ6p3vuyYZw0RT4GK0A7D4UHy6ZJHkLC6a7XwglRlYEdgnOn1+Zu6
	 SlDFv87OzkaTNVLfp41FRcB/bjtlgI+J0MYI2Rfx91twuj3P5+FbPjl3v9DEt7mfEn
	 zPiOyoodcPVVW0l+YEbNtix84qomqQJvDT2Cp7TbgF75p92Kf9L9n/HJ2rxW6oB1wc
	 9VLB8iDFhuw4WNAg+OHifdKh2XjZ5RA+Qh75+C0gSezapxGzoi0LPz8Q1syvuPjMXs
	 ecoOqmsGcffdA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512bde3d197so1233525e87.0;
        Mon, 19 Feb 2024 17:18:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXg7rEFLm8gpgiCJ1TXKdhpEIkluvi+iwEF3SWzW2Fl6P78vJwu++m/9262HrcMoOG9y3AJR5u+7V0nncO7ZnBErZXn8Atu/tXHTjdma0F/NJeemncJWAdPTR5ZJHlhzbujHL+w4AhbrQPW3WR9o0yjmNur5Ht82NVBn29NyCE3dmutJA==
X-Gm-Message-State: AOJu0YwyMxhGYS7fyjKZeAEc5lA819Xp43RHqHqUjaUIS/ry8BmYlJZK
	1D5P7q87kiFrTAXcZjbKhDRpuVK+Wuiw4ptBxMxN4QuvjmSbcESTPU384zLV87L0XZ/CbmXFcFM
	I3MKc6psKnWCTwuIEx1gIMkK7IyQ=
X-Google-Smtp-Source: AGHT+IGMJfhDTJq1YqqIQGq98YiHO1JYn61LbwsGJ+VOUot9UnoTW+nNWZE7jsiRg+M3Bm2sv8S6XKJo1YK/Hc+mNjo=
X-Received: by 2002:a05:6512:1321:b0:512:bf09:9313 with SMTP id
 x33-20020a056512132100b00512bf099313mr1095294lfu.50.1708391895799; Mon, 19
 Feb 2024 17:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708223519.git.unicorn_wang@outlook.com> <dc899c89e5c30e2267965f185b52d6dded4eb1ac.1708223519.git.unicorn_wang@outlook.com>
In-Reply-To: <dc899c89e5c30e2267965f185b52d6dded4eb1ac.1708223519.git.unicorn_wang@outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Feb 2024 09:18:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRPU6-8Wwds=PRREjU3W0cmCpBcc=w7=J9p_y+XSd3o6w@mail.gmail.com>
Message-ID: <CAJF2gTRPU6-8Wwds=PRREjU3W0cmCpBcc=w7=J9p_y+XSd3o6w@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
To: Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, 
	robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, jszhang@kernel.org, inochiama@outlook.com, 
	samuel.holland@sifive.com, Chen Wang <unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:52=E2=80=AFAM Chen Wang <unicornxw@gmail.com> wr=
ote:
>
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add clock generator node to device tree for SG2042, and enable clock for
> uart.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 48 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/r=
iscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index 49b4b9c2c101..80cb017974d8 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -14,6 +14,18 @@ chosen {
>         };
>  };
>
> +&cgi_main {
> +       clock-frequency =3D <25000000>;
> +};
> +
> +&cgi_dpll0 {
> +       clock-frequency =3D <25000000>;
> +};
> +
> +&cgi_dpll1 {
> +       clock-frequency =3D <25000000>;
> +};
> +
If all are fixed, why do we separate them into three pieces? To show
real internal hardware?

>  &uart0 {
>         status =3D "okay";
>  };
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts=
/sophgo/sg2042.dtsi
> index ead1cc35d88b..e70c43e2ccbe 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -5,6 +5,9 @@
>
>  /dts-v1/;
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/sophgo,sg2042-pll.h>
> +#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
> +#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
>
>  #include "sg2042-cpus.dtsi"
>
> @@ -18,12 +21,54 @@ aliases {
>                 serial0 =3D &uart0;
>         };
>
> +       cgi_main: oscillator0 {
> +               compatible =3D "fixed-clock";
> +               clock-output-names =3D "cgi_main";
> +               #clock-cells =3D <0>;
> +       };
> +
> +       cgi_dpll0: oscillator1 {
> +               compatible =3D "fixed-clock";
> +               clock-output-names =3D "cgi_dpll0";
> +               #clock-cells =3D <0>;
> +       };
> +
> +       cgi_dpll1: oscillator2 {
> +               compatible =3D "fixed-clock";
> +               clock-output-names =3D "cgi_dpll1";
> +               #clock-cells =3D <0>;
> +       };
> +
>         soc: soc {
>                 compatible =3D "simple-bus";
>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
>                 ranges;
>
> +               pllclk: clock-controller@70300100c0 {
> +                       compatible =3D "sophgo,sg2042-pll";
> +                       reg =3D <0x70 0x300100c0 0x0 0x40>;
> +                       clocks =3D <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1=
>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               rpgate: clock-controller@7030010368 {
> +                       compatible =3D "sophgo,sg2042-rpgate";
> +                       reg =3D <0x70 0x30010368 0x0 0x98>;
> +                       clocks =3D <&clkgen GATE_CLK_RP_CPU_NORMAL>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               clkgen: clock-controller@7030012000 {
> +                       compatible =3D "sophgo,sg2042-clkgen";
> +                       reg =3D <0x70 0x30012000 0x0 0x1000>;
> +                       clocks =3D <&pllclk MPLL_CLK>,
> +                                <&pllclk FPLL_CLK>,
> +                                <&pllclk DPLL0_CLK>,
> +                                <&pllclk DPLL1_CLK>;
> +                       #clock-cells =3D <1>;
> +               };
> +
>                 clint_mswi: interrupt-controller@7094000000 {
>                         compatible =3D "sophgo,sg2042-aclint-mswi", "thea=
d,c900-aclint-mswi";
>                         reg =3D <0x00000070 0x94000000 0x00000000 0x00004=
000>;
> @@ -333,6 +378,9 @@ uart0: serial@7040000000 {
>                         interrupt-parent =3D <&intc>;
>                         interrupts =3D <112 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-frequency =3D <500000000>;
> +                       clocks =3D <&clkgen GATE_CLK_UART_500M>,
> +                                <&clkgen GATE_CLK_APB_UART>;
> +                       clock-names =3D "baudclk", "apb_pclk";
>                         reg-shift =3D <2>;
>                         reg-io-width =3D <4>;
>                         status =3D "disabled";
> --
> 2.25.1
>
Others LGTM.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

