Return-Path: <linux-kernel+bounces-157639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3B8B13EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB711F24696
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50F13C3C7;
	Wed, 24 Apr 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9U15ByI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973013B5A4;
	Wed, 24 Apr 2024 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988870; cv=none; b=rtLBLM2AN1bffNiZ7mFBreydMPAaFdf30AecMI6TxizOHlMOZyIoABiZgMwQAXN+LzPWYwbKK/nDOrMZ8GHFu2tmvTwov8WutUOEUFvJZXyh6sjM9OziP/QwWtpxLh7MyAEqID7HjmlDBxJ44BT2xxWfoJ3s7L8jpj+HA1iYbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988870; c=relaxed/simple;
	bh=pZJnhrqBEUNU8L74CRDodYNAWKN1FAjVYMm8hIp5g1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5N3jBbTBAUmi4894kxkueZ0IWJR+ZJ7z3EXrPiRXWg+GxNb4XslSOxfQxFFyl+5R062ZQ/g1IFPjY4RHRd90Xm5pdoiJBG5M5sACTyDfXlt7zeLfSZb69e+2ZCUFdBZ6eKo6F1oZUoICTLfAfogUFsnlHxVvPYMJDAy9ng+2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9U15ByI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23667C2BD10;
	Wed, 24 Apr 2024 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713988870;
	bh=pZJnhrqBEUNU8L74CRDodYNAWKN1FAjVYMm8hIp5g1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9U15ByIAFQBGd9skRQXTyRyW8pnoJsycZmxyPQe7bt/nQeOsflcdAiEPhRpZDlXd
	 NtAydSRRHY8MVh7kbicsB+D3eDn0yNiHvRhOdw187BP3/xgCZ3p5ZjCUHHyxjWkPGk
	 zoFr2Yk1jPynaSWrG7jBXSsfwnce/TggQhRrGbyPKXhQlTSGieK2Liyi+dWaRLFTKr
	 RAWT63JHPJ0340sl5u5sGkcXHaoy7QKRMZIpWm2oGp2erKM3q15g2bkazjDMSbpp+W
	 DTBH6DsPDHLXpEs57VIKXzX/EVdk6mYn09uvrZlbW0Os3QTzRdhfTC4PX4ciybMn19
	 ENt4PklHwh9cg==
Date: Wed, 24 Apr 2024 15:01:07 -0500
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v7 5/5] clk: meson: c3: add c3 clock peripherals
 controller driver
Message-ID: <20240424200107.GA372179-robh@kernel.org>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-6-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424050928.1997820-6-xianwei.zhao@amlogic.com>

On Wed, Apr 24, 2024 at 01:09:28PM +0800, Xianwei Zhao wrote:
> Add the C3 peripherals clock controller driver in the C3 SoC family.
> 
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig          |   15 +
>  drivers/clk/meson/Makefile         |    1 +
>  drivers/clk/meson/c3-peripherals.c | 2366 ++++++++++++++++++++++++++++
>  3 files changed, 2382 insertions(+)
>  create mode 100644 drivers/clk/meson/c3-peripherals.c
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 9f975a980581..0b85d584910e 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -142,6 +142,21 @@ config COMMON_CLK_C3_PLL
>  	  AKA C3. Say Y if you want the board to work, because PLLs are the parent
>  	  of most peripherals.
>  
> +config COMMON_CLK_C3_PERIPHERALS
> +	tristate "Amlogic C3 peripherals clock controller"
> +	depends on ARM64
> +	depends on ARM_SCMI_PROTOCOL

I may have missed it, but I don't see the dependency on SCMI in this 
driver.

> +	depends on COMMON_CLK_SCMI
> +	depends on COMMON_CLK_C3_PLL
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the Peripherals clock controller on Amlogic C302X and
> +	  C308L devices, AKA C3. Say Y if you want the peripherals clock to
> +	  work.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 4420af628b31..20ad9482c892 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
> new file mode 100644
> index 000000000000..0f834ced0ee9
> --- /dev/null
> +++ b/drivers/clk/meson/c3-peripherals.c
> @@ -0,0 +1,2366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic C3 Peripherals Clock Controller Driver
> + *
> + * Copyright (c) 2023 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>

I don't think you need this header.

> +#include <linux/platform_device.h>
> +#include "clk-regmap.h"
> +#include "clk-dualdiv.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>

