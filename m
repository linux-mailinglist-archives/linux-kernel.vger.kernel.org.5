Return-Path: <linux-kernel+bounces-59094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9F84F11E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCE286BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31C65BBD;
	Fri,  9 Feb 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+nn2e+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59E65BA7;
	Fri,  9 Feb 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465390; cv=none; b=Jd+cmOOpJPxvRe7mCvM/njukKwMIAWS+Vk9YTJuVPhNf0Y6L8vJ2nTW7Djlg5rhuMM2q2WfL3wzwjUI/8rYrbI+VSfx1iV5I1zfAMJen1kcduxir/TxU2rVgcoiEQe6/ts02aSBJfF07VMPWbJzciypfWBnQxuhPTcIlBWp1Qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465390; c=relaxed/simple;
	bh=QyNBUI2PTkBsPOChRqOLzX23Q1aSTNw9DxhnsZLHF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgmMtSNwrfry/LVSpcJLKKkgsfiAZFKYh0i9J2oK178dLiZssRmvIXvRl6LBgeNokcPnPUJn7PKlsqb0V7rIka1Khel5KWTsWfH0pKg9MBMYfInXLwafbyDoKMF04k0PVwF0Y50kBTKdl5n6BNb6gNXtuHMMecV4C9N6GkWLvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+nn2e+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC5FC433F1;
	Fri,  9 Feb 2024 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465390;
	bh=QyNBUI2PTkBsPOChRqOLzX23Q1aSTNw9DxhnsZLHF2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+nn2e+pSRR0hTPPOBw9SmQGYgmhyzh4LDAmKybjPIbN1Rm1uMB1d3MAjdGzx8CGk
	 vnYwlp4oEJKdLy04QLBp365bmEzn8v5AZ0GhFsXrdKIsx/rCoFEF3KrFruwUu1o5lX
	 mtP8h2iYuVsh+sh53deppsE0e0BxPclRZ5hHd5TSPTGmT8O5+G03Eas0F5avYKWXyx
	 mnGe+YrTS6re/TWyaFUPMskFhakILNuZb2hF1IyVEHGgR7/pHbUIxjtecygWtk+pyQ
	 lIt9LgjRWTuLBdmhSJYih8xTcz6XYcz+L7cyOHJiniqUBoeW5Gw4eYzt21kQczISst
	 1S/wy6v1o59VA==
Date: Fri, 9 Feb 2024 07:56:24 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] mfd: tmio: move header to platform_data
Message-ID: <20240209075624.GG689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209015817.14627-14-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-14-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> All the MFD components are gone from the header meanwhile. Only the MMC
> relevant data is left which makes it a platform_data for the MMC
> controller. Move the header to the now fitting directory.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  MAINTAINERS                                   | 2 +-
>  arch/sh/boards/board-sh7757lcr.c              | 2 +-
>  arch/sh/boards/mach-ap325rxa/setup.c          | 2 +-
>  arch/sh/boards/mach-ecovec24/setup.c          | 2 +-
>  arch/sh/boards/mach-kfr2r09/setup.c           | 2 +-
>  arch/sh/boards/mach-migor/setup.c             | 2 +-
>  arch/sh/boards/mach-se/7724/setup.c           | 2 +-
>  drivers/mmc/host/renesas_sdhi_core.c          | 2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
>  drivers/mmc/host/tmio_mmc_core.c              | 2 +-
>  drivers/mmc/host/uniphier-sd.c                | 2 +-
>  include/linux/{mfd => platform_data}/tmio.h   | 0
>  13 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/{mfd => platform_data}/tmio.h (100%)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..c4e20abd177b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22154,7 +22154,7 @@ L:	linux-renesas-soc@vger.kernel.org
>  S:	Supported
>  F:	drivers/mmc/host/renesas_sdhi*
>  F:	drivers/mmc/host/tmio_mmc*
> -F:	include/linux/mfd/tmio.h
> +F:	include/linux/platform_data/tmio.h
>  
>  TMP401 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
> diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
> index f39c8196efdf..4014c042d2a5 100644
> --- a/arch/sh/boards/board-sh7757lcr.c
> +++ b/arch/sh/boards/board-sh7757lcr.c
> @@ -14,9 +14,9 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
>  #include <linux/io.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/platform_data/sh_mmcif.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/sh_eth.h>
>  #include <linux/sh_intc.h>
>  #include <linux/usb/renesas_usbhs.h>
> diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
> index 645cccf3da88..bb5004a8ac02 100644
> --- a/arch/sh/boards/mach-ap325rxa/setup.c
> +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> @@ -24,10 +24,10 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/mtd/sh_flctl.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 30d117f9ad7e..6f13557eecd6 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -17,13 +17,13 @@
>  #include <linux/input/sh_keysc.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/platform_data/sh_mmcif.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/platform_data/gpio_backlight.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_data/tsc2007.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/fixed.h>
> diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
> index 6b775eae85c0..70236859919d 100644
> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -22,10 +22,10 @@
>  #include <linux/input/sh_keysc.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/platform_data/lv5207lp.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 773ee767d0c4..1853e6319a66 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -7,6 +7,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/init.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/input.h>
> @@ -14,7 +15,6 @@
>  #include <linux/memblock.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mtd/physmap.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mtd/platnand.h>
>  #include <linux/i2c.h>
>  #include <linux/regulator/fixed.h>
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
> index 787ddd3c627a..e500feb91053 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -21,9 +21,9 @@
>  #include <linux/input/sh_keysc.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mtd/physmap.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index c675dec587ef..f84f60139bcf 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -22,13 +22,13 @@
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl-state.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 24e1c17908d7..97cd55fec0bf 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -11,12 +11,12 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io-64-nonatomic-hi-lo.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index c18581897f8a..68e31c37cce6 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -11,12 +11,12 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index c39141a5bd23..0c4397b3cffd 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -31,7 +31,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -39,6 +38,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 1404989e6151..bd231dbe90ba 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -9,11 +9,11 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> diff --git a/include/linux/mfd/tmio.h b/include/linux/platform_data/tmio.h
> similarity index 100%
> rename from include/linux/mfd/tmio.h
> rename to include/linux/platform_data/tmio.h
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

