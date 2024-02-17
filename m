Return-Path: <linux-kernel+bounces-69956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9406F8590C6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC1282E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D617CF1F;
	Sat, 17 Feb 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnOKWYAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C88657BE;
	Sat, 17 Feb 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186217; cv=none; b=QhHKaVPBxf8A5SR5fE7k62dR7MnuvT1sbcyH+etIivWPOkF6zxxm0w2bev00mqpjlTf/EkPLh5+u70pH1R3tjuvSRpNr09fF3xEEwL6MQy4xVx/1Qi5uPSUVTXLvxRB6UCgsBS0yf7c7KHu7zDIMVkGaaya3WmFK7TaRw8ELUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186217; c=relaxed/simple;
	bh=jnnuiG2JA3w1jL3b+rX0XgYDDbHfBnfPxf8SR5AXRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK61wsiE08w+SIfzPg7VTZbqbVRLd8Gt43qfDWq2lQPJ4LyvZgmXwF0VP1xvu4B2j4jtxTHMjEyjIJDGiE53tz2LGZKtEab5izCoSGr74Lk5/qHLm4G2GU4dIbR3iOdhWCsq98eOQW7LtaDLCxt8rw2kLYo7Fubc4+4cqpy0HWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnOKWYAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA1C433C7;
	Sat, 17 Feb 2024 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708186217;
	bh=jnnuiG2JA3w1jL3b+rX0XgYDDbHfBnfPxf8SR5AXRDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnOKWYAvQgSl1jOt4DM2iJrH5X+Js5+PgWiKEnVlYkyFEcOmM+JKmfznrRVZwfyAK
	 Oz3vZ/1OxKpjQaq/rW8w7wN3lEo97vJ9Ct+nfw7s/n8hlesL5z+Kgt5rl5WOZJBa+7
	 7OLLZkb8L7JcqOFLv9w9YrYEAHeGHESslkwOidqQ0Kt2bX9UgaHCdfvLRucOPe58ms
	 hhVS9SS2ZtbpMdwVXAE3KqsjIGxuDsBqj1VbEUlSukdW4Yy13JwqCbER2u1cuowApX
	 AaXOwd9KR6JoD3Yi94cQSlP/4PipDzfjUm35sjSGTVR2l1AXW2lR2BEFuGvRg+foEK
	 NuotaXNE7WJDQ==
Date: Sat, 17 Feb 2024 23:57:14 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: AnnanLiu <annan.liu.xdu@outlook.com>
Cc: chao.wei@sophgo.com, unicorn_wang@outlook.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Message-ID: <ZdDXWkibFjKvXJPe@xhacker>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>

On Thu, Jan 25, 2024 at 05:46:40PM +0800, AnnanLiu wrote:
> Add the watchdog device tree node to cv1800 SoC.
> 
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

I will update reset series soon

> 
> Changes since v1:
> - Change the name of the watchdog from watchdog0 to watchdog.
> - Change the status of watchdog.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/
> 
> 
>  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..75469161bfff 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -36,3 +36,7 @@ &osc {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&watchdog {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index aec6401a467b..03ca32cd37b6 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>

No, I don't think every commit author needs to add this line.

>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
>  			status = "disabled";
>  		};
>  
> +		watchdog: watchdog@3010000{
> +			compatible = "snps,dw-wdt";
> +			reg = <0x3010000 0x100>;
> +			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pclk>;
> +			resets = <&rst RST_WDT>;
> +			status = "disabled";
> +		};
> +
> +		pclk: pclk {

what's this clk?
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <25000000>;
> +		};
> +
>  		plic: interrupt-controller@70000000 {
>  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>  			reg = <0x70000000 0x4000000>;
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

