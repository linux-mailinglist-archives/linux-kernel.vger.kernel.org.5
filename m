Return-Path: <linux-kernel+bounces-10467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E914A81D4B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF09B21B26
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F47DF63;
	Sat, 23 Dec 2023 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP4Fn/c7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC79DDA0;
	Sat, 23 Dec 2023 14:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E26C433C7;
	Sat, 23 Dec 2023 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703343259;
	bh=vzQQtZqISgnGwapiVVctyIZ0TfoXA6A7HlfNDJ0ph2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OP4Fn/c7Rb/7Qi/ExiCsATmxakO1VuDsLC/uR/YK0UNYEiKbP/Lt7pAEuW+8xybih
	 t2k5eiOq0F6dr39AAnHVJab/QqdBI8bMcVIa8z7Bfj01sL3Huzta0XiQf9uYcbq+CH
	 C1XQNldEa2MLg6jSsfOJVIfI3BNalGSzGf0DrLis0AryxQrCFVn4sqq6a4xmnhLfaP
	 AlKH4+XjhS8wrgrR1ioUtqi1JyOKsZLwn2T0NPhcYepTSx6vsQxmNyvnVKdYfuVLIH
	 4XL6hPU2PuMrlbqOYQV1C1LlQCQOUJrRkJsGHMp6F8VCALBk0QkxBFuFx9VmMa+4vl
	 ZrpBCpVVPU0HQ==
Date: Sat, 23 Dec 2023 14:54:15 +0000
From: Simon Horman <horms@kernel.org>
To: deepakx.nagaraju@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdavem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] net: ethernet: altera: rename functions and their
 prototypes
Message-ID: <20231223145415.GC201037@kernel.org>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
 <20231221134041.27104-5-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134041.27104-5-deepakx.nagaraju@intel.com>

On Thu, Dec 21, 2023 at 09:40:41PM +0800, deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Move standard DMA interface for sgdma and msgdma and rename them
> from tse_private to dma_private.
> 
> Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/altera/Makefile          |   5 +-
>  drivers/net/ethernet/altera/altera_eth_dma.c  |  58 ++++
>  drivers/net/ethernet/altera/altera_eth_dma.h  | 121 +++++++++
>  drivers/net/ethernet/altera/altera_msgdma.c   |  38 +--
>  drivers/net/ethernet/altera/altera_msgdma.h   |  28 +-
>  drivers/net/ethernet/altera/altera_sgdma.c    | 110 ++++----
>  drivers/net/ethernet/altera/altera_sgdma.h    |  30 +--
>  drivers/net/ethernet/altera/altera_tse.h      |  26 +-
>  .../net/ethernet/altera/altera_tse_ethtool.c  |   1 +
>  drivers/net/ethernet/altera/altera_tse_main.c | 248 +++++++-----------
>  drivers/net/ethernet/altera/altera_utils.c    |   1 +
>  11 files changed, 390 insertions(+), 276 deletions(-)
>  create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.c
>  create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.h

Hi Nagaraju,

this patch is doing a lot of things. I think that the patch description
warrants a description of why this is desirable.

And I think it would also be worth consider breaking it up: doing one
thing at a time makes things a lot easier to review (for me at least).

> 
> diff --git a/drivers/net/ethernet/altera/Makefile b/drivers/net/ethernet/altera/Makefile
> index a52db80aee9f..ce723832edc4 100644
> --- a/drivers/net/ethernet/altera/Makefile
> +++ b/drivers/net/ethernet/altera/Makefile
> @@ -3,6 +3,9 @@
>  # Makefile for the Altera device drivers.
>  #
> 
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=NET_ALTERA
> +
>  obj-$(CONFIG_ALTERA_TSE) += altera_tse.o
>  altera_tse-objs := altera_tse_main.o altera_tse_ethtool.o \
> -altera_msgdma.o altera_sgdma.o altera_utils.o
> +		   altera_msgdma.o altera_sgdma.o altera_utils.o \
> +		   altera_eth_dma.o
> diff --git a/drivers/net/ethernet/altera/altera_eth_dma.c b/drivers/net/ethernet/altera/altera_eth_dma.c
> new file mode 100644
> index 000000000000..6a47a3cb3406
> --- /dev/null
> +++ b/drivers/net/ethernet/altera/altera_eth_dma.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* DMA support for Intel FPGA Quad-Speed Ethernet MAC driver
> + * Copyright (C) 2023 Intel Corporation. All rights reserved
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include "altera_eth_dma.h"
> +#include "altera_utils.h"
> +
> +/* Probe DMA */
> +int altera_eth_dma_probe(struct platform_device *pdev, struct altera_dma_private *priv,
> +			 enum altera_dma_type type)
> +{
> +	void __iomem *descmap;
> +
> +	/* xSGDMA Rx Dispatcher address space */
> +	priv->rx_dma_csr = devm_platform_ioremap_resource_byname(pdev, "rx_csr");
> +	if (IS_ERR(priv->rx_dma_csr))
> +		return PTR_ERR(priv->rx_dma_csr);
> +
> +	/* mSGDMA Tx Dispatcher address space */
> +	priv->tx_dma_csr = devm_platform_ioremap_resource_byname(pdev, "tx_csr");
> +	if (IS_ERR(priv->rx_dma_csr))
> +		return PTR_ERR(priv->rx_dma_csr);
> +
> +	switch (type) {
> +	case ALTERA_DTYPE_SGDMA:
> +		/* Get the mapped address to the SGDMA descriptor memory */
> +		descmap = devm_platform_ioremap_resource_byname(pdev, "s1");
> +		if (IS_ERR(descmap))
> +			return PTR_ERR(descmap);
> +		break;
> +	case ALTERA_DTYPE_MSGDMA:
> +		priv->rx_dma_resp = devm_platform_ioremap_resource_byname(pdev, "rx_resp");
> +		if (IS_ERR(priv->rx_dma_resp))
> +			return PTR_ERR(priv->rx_dma_resp);
> +
> +		priv->tx_dma_desc = devm_platform_ioremap_resource_byname(pdev, "tx_desc");
> +		if (IS_ERR(priv->tx_dma_desc))
> +			return PTR_ERR(priv->tx_dma_desc);
> +
> +		priv->rx_dma_desc = devm_platform_ioremap_resource_byname(pdev, "rx_desc");
> +		if (IS_ERR(priv->rx_dma_desc))
> +			return PTR_ERR(priv->rx_dma_desc);
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +
> +};
> +EXPORT_SYMBOL_NS(altera_eth_dma_probe, NET_ALTERA);

Perhaps I am missing something obvious here, but, I'm a little confused by
this export; And the corresponding import in altera_tse_main; And the
MODULE_LICENSE below, as there is also a MODULE_LICENSE in corresponding
import in altera_tse_main.c.

The basis of my confusion is that I assume that this file and
altera_tse_main.c are both parts of the same module.

> +MODULE_LICENSE("GPL");

...

> diff --git a/drivers/net/ethernet/altera/altera_tse.h b/drivers/net/ethernet/altera/altera_tse.h
> index 4874139e7cdf..020ac5946acc 100644
> --- a/drivers/net/ethernet/altera/altera_tse.h
> +++ b/drivers/net/ethernet/altera/altera_tse.h
> @@ -368,29 +368,6 @@ struct tse_buffer {
> 
>  struct altera_tse_private;

I think the forward declaration of  struct altera_tse_private can
also be removed.

> 
> -#define ALTERA_DTYPE_SGDMA 1
> -#define ALTERA_DTYPE_MSGDMA 2
> -
> -/* standard DMA interface for SGDMA and MSGDMA */
> -struct altera_dmaops {
> -	int altera_dtype;
> -	int dmamask;
> -	void (*reset_dma)(struct altera_tse_private *);
> -	void (*enable_txirq)(struct altera_tse_private *);
> -	void (*enable_rxirq)(struct altera_tse_private *);
> -	void (*disable_txirq)(struct altera_tse_private *);
> -	void (*disable_rxirq)(struct altera_tse_private *);
> -	void (*clear_txirq)(struct altera_tse_private *);
> -	void (*clear_rxirq)(struct altera_tse_private *);
> -	int (*tx_buffer)(struct altera_tse_private *, struct tse_buffer *);
> -	u32 (*tx_completions)(struct altera_tse_private *);
> -	void (*add_rx_desc)(struct altera_tse_private *, struct tse_buffer *);
> -	u32 (*get_rx_status)(struct altera_tse_private *);
> -	int (*init_dma)(struct altera_tse_private *);
> -	void (*uninit_dma)(struct altera_tse_private *);
> -	void (*start_rxdma)(struct altera_tse_private *);
> -};
> -
>  /* This structure is private to each device.
>   */
>  struct altera_tse_private {
> @@ -401,6 +378,9 @@ struct altera_tse_private {
>  	/* MAC address space */
>  	struct altera_tse_mac __iomem *mac_dev;
> 
> +	/* Shared DMA structure */
> +	struct altera_dma_private dma_priv;

I had expected many of the fields corresponding to those
present in struct altera_dma_private to be removed from
struct altera_tse_private.

> +
>  	/* TSE Revision */
>  	u32	revision;
> 
> diff --git a/drivers/net/ethernet/altera/altera_tse_ethtool.c b/drivers/net/ethernet/altera/altera_tse_ethtool.c
> index d34373bac94a..6253bfe86e47 100644
> --- a/drivers/net/ethernet/altera/altera_tse_ethtool.c
> +++ b/drivers/net/ethernet/altera/altera_tse_ethtool.c
> @@ -21,6 +21,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/phy.h>
> 
> +#include "altera_eth_dma.h"
>  #include "altera_tse.h"
>  #include "altera_utils.h"

This seems wrong.
Headers should, in general, include everything they need to
be included by .c files.

I think that here altera_eth_dma.h should be included in altera_tse.h. 

> diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
> index 6a1a004ea693..1b66970a40e6 100644
> --- a/drivers/net/ethernet/altera/altera_tse_main.c
> +++ b/drivers/net/ethernet/altera/altera_tse_main.c
> @@ -29,21 +29,23 @@
>  #include <linux/mii.h>
>  #include <linux/mdio/mdio-regmap.h>
>  #include <linux/netdevice.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> +#include <linux/of_platform.h>
>  #include <linux/pcs-lynx.h>
>  #include <linux/phy.h>
>  #include <linux/platform_device.h>
> -#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/skbuff.h>
> +
>  #include <asm/cacheflush.h>
> 
> -#include "altera_utils.h"
> -#include "altera_tse.h"
> -#include "altera_sgdma.h"
> +#include "altera_eth_dma.h"
>  #include "altera_msgdma.h"
> +#include "altera_sgdma.h"
> +#include "altera_tse.h"
> +#include "altera_utils.h"

I'm all for cleaning up includes, but are the changes
above strictly related to the rest of this patch?
If not, perhaps they could be moved into a separate patch.

...

> @@ -1529,4 +1474,5 @@ module_platform_driver(altera_tse_driver);
> 
>  MODULE_AUTHOR("Altera Corporation");
>  MODULE_DESCRIPTION("Altera Triple Speed Ethernet MAC driver");
> +MODULE_IMPORT_NS(NET_ALTERA);
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/net/ethernet/altera/altera_utils.c b/drivers/net/ethernet/altera/altera_utils.c
> index e6a7fc9d8fb1..09a53f879b51 100644
> --- a/drivers/net/ethernet/altera/altera_utils.c
> +++ b/drivers/net/ethernet/altera/altera_utils.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2014 Altera Corporation. All rights reserved
>   */
> 
> +#include "altera_eth_dma.h"
>  #include "altera_tse.h"
>  #include "altera_utils.h"

Please see my comment on altera_tse_ethtool.c,
I believe it applies here too.

