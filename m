Return-Path: <linux-kernel+bounces-64233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1524853C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63C01C219C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF6627F2;
	Tue, 13 Feb 2024 20:52:50 +0000 (UTC)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786B627E7;
	Tue, 13 Feb 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857569; cv=none; b=Xs9yHs7SRkXLhJyEQ4RwVHlWDQNBaS2I10opJlq+fkIFBnlKy3Yky86Pdviatj932wdHrHN4MA1ohR39PUfTCkZmcJdlx9GRkXsRs40CyNimG2dT7DuT7iTwzaajS+Gr/afizEFVRDstaqDxZzA3CxwN2vQeIbV/jfEEiAvHzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857569; c=relaxed/simple;
	bh=pNLjfATizxDfzKBpwbo33+bigWKUwEcoBZaEGdtP0VQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WO3hhjrif+PUXxKt0hfD8Al19VeTRA4fIgWynJ1UYXo/BtYE8gjgLeEzWCWASOXx+SDf8vPkQqEf5APj0I2kSdIvWZZASKKPXe+6mzV0yV10UZZr1MKu6MbvrhNwaxkKO3cxAqj6v6OnR9y9VeIcDrcK1OW7EzftT1oAF0B5ZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rZzla-00000002PLI-4Bog; Tue, 13 Feb 2024 21:52:35 +0100
Received: from dynamic-077-183-140-215.77.183.pool.telefonica.de ([77.183.140.215] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rZzla-00000001fwb-39u4; Tue, 13 Feb 2024 21:52:34 +0100
Message-ID: <51eb2eb0845ae986209ba1ecda315dd27519a087.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 6/6] mfd: tmio: move header to platform_data
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
  Rich Felker <dalias@libc.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>,  linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org,  linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Feb 2024 21:52:33 +0100
In-Reply-To: <20240209015817.14627-14-wsa+renesas@sang-engineering.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
	 <20240209015817.14627-14-wsa+renesas@sang-engineering.com>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2024-02-09 at 02:58 +0100, Wolfram Sang wrote:
> All the MFD components are gone from the header meanwhile. Only the MMC
> relevant data is left which makes it a platform_data for the MMC
> controller. Move the header to the now fitting directory.
>=20
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
>  include/linux/{mfd =3D> platform_data}/tmio.h   | 0
>  13 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/{mfd =3D> platform_data}/tmio.h (100%)
>=20
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
> =20
>  TMP401 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
> diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh77=
57lcr.c
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
> diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-a=
p325rxa/setup.c
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
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-e=
covec24/setup.c
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
> diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kf=
r2r09/setup.c
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
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migo=
r/setup.c
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
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se=
/7724/setup.c
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
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
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
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
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
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/=
renesas_sdhi_sys_dmac.c
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
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
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
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-s=
d.c
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
> diff --git a/include/linux/mfd/tmio.h b/include/linux/platform_data/tmio.=
h
> similarity index 100%
> rename from include/linux/mfd/tmio.h
> rename to include/linux/platform_data/tmio.h

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

