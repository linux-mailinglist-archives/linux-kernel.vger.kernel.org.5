Return-Path: <linux-kernel+bounces-65079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE12285478A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117C91F2471C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BF18AEE;
	Wed, 14 Feb 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5lHOIV+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3018633
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907864; cv=none; b=qQ5aFxJqjERTUsu1wVqYxBoP8Njr+FDGu58cf9C3VW/jkWw2/yNd6P5+OYq7DMJjHUgu3sfdLAI8i4KONphOL6+rLRecR5ODCGZO79cPWTMzdwSIeAdxR9PWzHSXVRAOsXyBBpnW+WEEymRR7ddhdXilu7cJ5c27sq64nEswv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907864; c=relaxed/simple;
	bh=Oi7K5rYcGGsepVAtt/jz07oK+Saja2lj1N8ZZPhTw0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNNo3PUgiHJhjeAsWot2Xg4N/KYfQOrozvhevuSnEHe3nzrHNYlNCUcFWXs4Q2Giq0tzKwtu6epkTdGIffL6s6yPueGqR3ge53J+sFUGwcNliA9xO5oPZCDuM02RNNkqhN3irgUcxHjyvO8xQPdxouYy5srlVgUP+xsgL2jqU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5lHOIV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B94C433C7;
	Wed, 14 Feb 2024 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907863;
	bh=Oi7K5rYcGGsepVAtt/jz07oK+Saja2lj1N8ZZPhTw0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5lHOIV+kZ1/r2LPiEOZkFaiP5A1xT4G7ar8km78XA0y+Eza51AlsyXnz2wTyD4x/
	 kp+F9vFr6TB9vVudnbLDaVUfRYQlA+lL7W9lTaMYpAOWOvKIldZW3gna/9y6FroVbj
	 HaJ+8d0jLkeFQ+naihupg/z4BGqyFzES+SB4j0zU=
Date: Wed, 14 Feb 2024 11:50:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] misc: mrvl-dpi: add octeontx3 dpi driver
Message-ID: <2024021435-stray-cried-9737@gregkh>
References: <20240214035524.1245615-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214035524.1245615-1-vattunuru@marvell.com>

On Tue, Feb 13, 2024 at 07:55:24PM -0800, Vamsi Attunuru wrote:
> Adds PCIe PF driver for OcteonTx3 DPI PF device which initializes DPI

What is a "PF"?

WHat is "DPI"?

> DMA hardware's global configuration and enables PF-VF mbox channels

What is "PF-VF"?

> which can be used by it's VF devices. This DPI PF driver handles only

What is "VF"?

> the resource configuration requests from VFs and it does not have any
> data movement functionality.

What do you mean by "data movement functionality"?

Please provide a bit more dummed down description please, for those of
us who don't understand any of this.

And if this is a pci driver, why is it in misc?

> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  MAINTAINERS                    |   5 +
>  drivers/misc/Kconfig           |  10 +
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/mrvl-dpi/Makefile |   9 +
>  drivers/misc/mrvl-dpi/dpi.c    | 559 +++++++++++++++++++++++++++++++++
>  drivers/misc/mrvl-dpi/dpi.h    | 232 ++++++++++++++
>  6 files changed, 816 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..73029199716d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13104,6 +13104,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
>  
> +MARVELL OCTEONTX3 DPI DRIVER
> +M:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Maintained
> +F:	drivers/misc/mrvl-dpi
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..3142fdb1b4c0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -574,6 +574,16 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
>  
> +config MARVELL_OCTEONTX3_DPI
> +	tristate "OcteonTX3 DPI driver"
> +	depends on ARM64 && PCI
> +	default m

Don't set a default unless you can not boot the box without it.

> +	help
> +	  Enables OCTEONTX3 DPI driver which intializes DPI PF device's global configuration
> +	  and it's VFs resource configuration to enable DMA transfers. DPI PF device
> +	  does not have any data movement functionality, it only serves VF's resource
> +	  configuration requests.

module name?


> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..86229072166c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_MARVELL_OCTEONTX3_DPI)	+= mrvl-dpi/
> diff --git a/drivers/misc/mrvl-dpi/Makefile b/drivers/misc/mrvl-dpi/Makefile
> new file mode 100644
> index 000000000000..c938ea459483
> --- /dev/null
> +++ b/drivers/misc/mrvl-dpi/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Marvell's OcteonTX3 DPI driver
> +#
> +
> +obj-$(CONFIG_MARVELL_OCTEONTX3_DPI) += octeontx3_dpi.o
> +
> +octeontx3_dpi-y := dpi.o

Why the two steps?  Why not just name the file the module name?

And because of that, why do you need a subdirectory?

And if you do have a subdirectory, why not move the Kconfig entry into
it?  You can't have it both ways here, sorry.


> +
> diff --git a/drivers/misc/mrvl-dpi/dpi.c b/drivers/misc/mrvl-dpi/dpi.c
> new file mode 100644
> index 000000000000..fe0b3ee469c8
> --- /dev/null
> +++ b/drivers/misc/mrvl-dpi/dpi.c
> @@ -0,0 +1,559 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell OcteonTx3 DPI driver
> + *
> + * Copyright (C) 2024 Marvell International Ltd.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#include "dpi.h"

Why do you need a .h file for a single .c file?

> +
> +#define DPI_DRV_NAME	"OcteonTx3-dpi"
> +#define DPI_DRV_STRING  "Marvell OcteonTx3 DPI Driver"
> +#define DPI_DRV_VERSION	"1.0"

Driver versions do not make sense once they are in the kernel tree,
please remove.

> +static int mps = 128;
> +module_param(mps, int, 0644);
> +MODULE_PARM_DESC(mps, "Maximum payload size, Supported sizes are 128, 256, 512 and 1024 bytes");
> +
> +static int mrrs = 128;
> +module_param(mrrs, int, 0644);
> +MODULE_PARM_DESC(mrrs, "Maximum read request size, Supported sizes are 128, 256, 512 and 1024 bytes");
> +
> +static unsigned long eng_fifo_buf = 0x101008080808;
> +module_param(eng_fifo_buf, ulong, 0644);
> +MODULE_PARM_DESC(eng_fifo_buf, "Per engine buffer size. Each byte corresponds to engine number");

This is not the 1990's, no module parameters should be needed, and they
don't work at all when you have multiple devices.  Please make this
"just work" and if you have to tune it, make them proper dynamic options
at runtime.

> +	while (cnt) {
> +		reg = dpi_reg_read(dpi, DPI_DMAX_QRST(queue));
> +		--cnt;
> +		if (!(reg & 0x1))
> +			break;
> +	}

That's a long busy-wait loop, one that will take a variable amount of
time given different processor speeds.  Shouldn't you be using a real
timeout instead?

> +
> +	if (reg & 0x1)
> +		dev_err(&dpi->pdev->dev, "Queue reset failed\n");

What can userspace do with this message?  And why not return an error if
an error happened?  Why are you ignoring it here?

> +
> +	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), 0ULL);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), 0ULL);
> +
> +	reg = DPI_DMA_IBUFF_CSIZE_CSIZE(csize) | DPI_DMA_IBUFF_CSIZE_NPA_FREE;
> +	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(queue), reg);
> +
> +	reg = dpi_reg_read(dpi, DPI_DMAX_IDS2(queue));
> +	reg |= DPI_DMA_IDS2_INST_AURA(aura);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS2(queue), reg);
> +
> +	reg = dpi_reg_read(dpi, DPI_DMAX_IDS(queue));
> +	reg |= DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
> +	reg |= DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
> +	reg |= DPI_DMA_IDS_DMA_STRM(vf + 1);
> +	reg |= DPI_DMA_IDS_INST_STRM(vf + 1);
> +	dpi_reg_write(dpi, DPI_DMAX_IDS(queue), reg);
> +
> +	spin_unlock(&dpi->vf_lock);
> +
> +	return 0;

Shouldn't you have returned an error if one happened?

> +static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf, union dpi_mbox_message_t *msg)
> +{
> +	switch (msg->s.cmd) {
> +	case DPI_QUEUE_OPEN:
> +		dpivf->vf_config.aura = msg->s.aura;
> +		dpivf->vf_config.csize = msg->s.csize / 8;
> +		dpivf->vf_config.sso_pf_func = msg->s.sso_pf_func;
> +		dpivf->vf_config.npa_pf_func = msg->s.npa_pf_func;
> +		dpi_queue_init(dpi, dpivf, msg->s.vfid);
> +		if (msg->s.wqecs)
> +			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
> +		dpivf->setup_done = true;
> +		break;
> +	case DPI_QUEUE_OPEN_V2:
> +		dpivf->vf_config.aura = msg->s.aura;
> +		dpivf->vf_config.csize = msg->s.csize;
> +		dpivf->vf_config.sso_pf_func = msg->s.sso_pf_func;
> +		dpivf->vf_config.npa_pf_func = msg->s.npa_pf_func;
> +		dpi_queue_init(dpi, dpivf, msg->s.vfid);
> +		if (msg->s.wqecs)
> +			dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
> +		dpivf->setup_done = true;
> +		break;
> +	case DPI_QUEUE_CLOSE:
> +		dpivf->vf_config.aura = 0;
> +		dpivf->vf_config.csize = 0;
> +		dpivf->vf_config.sso_pf_func = 0;
> +		dpivf->vf_config.npa_pf_func = 0;
> +		dpi_queue_fini(dpi, dpivf, msg->s.vfid);
> +		dpivf->setup_done = false;
> +		break;
> +	default:
> +		return -1;

That is not a valid error number :(


> +static int __init dpi_init_module(void)
> +{
> +	pr_info("%s: %s\n", DPI_DRV_NAME, DPI_DRV_STRING);

When drivers work properly, they are quiet.  No need for this.


> +
> +	return pci_register_driver(&dpi_driver);
> +}
> +
> +static void __exit dpi_cleanup_module(void)
> +{
> +	pci_unregister_driver(&dpi_driver);
> +}
> +
> +module_init(dpi_init_module);
> +module_exit(dpi_cleanup_module);

module_pci_driver() instead?  That will automatically get rid of the
pr_info() spam above :)

thanks,

greg k-h

