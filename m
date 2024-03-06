Return-Path: <linux-kernel+bounces-93975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB708737B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732C61C22217
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9547130E4D;
	Wed,  6 Mar 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kelRpGi+"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877381BDD3;
	Wed,  6 Mar 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731675; cv=none; b=D2Fpt5vvM79o/wg006KjZPdOap9FYa2Az2qFTeuQrylO6FMO+qkUMvB6JXTegQrKlSfQxN0ICBt3C0hJYcT1Oe2FyWB5A7OXtHCwDSMrBlpaa2gGU8Dk/H3AXt8gly5hyjR5EyD4z2rbuFFVP6gP26uQMuqq4Y8fwPtkexhUfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731675; c=relaxed/simple;
	bh=32FImB/6Av8MctDXbEHxecRUUlW8E8O7NRAYsdFTSho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9kOAvfpa8VAjL3ZCBIoLOM5o8gobDrl6vJrOY8EY+2sheRQwu9Kykvnlxcq4xjwCpFgZO4KrbK58E3/oYCSYjou50YW2/1h3gCAI+ozMUNxgJk2ahh8kAFqSf/BYBJQyJppIUQqLqrMYcu5Bzkt0YKR5z2RlbjooT2Mya5Zf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kelRpGi+; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso7247833276.1;
        Wed, 06 Mar 2024 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709731672; x=1710336472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0PvucL6HmTJPxI4SoEkWegaPuUqqdMQQ07XKPr7IUE=;
        b=kelRpGi+nGSj8ga58hBReEWqXm1BgtLhs52WJ1OfMhzSeV4lFrlgbwvJ77QXfBP+yx
         nR0ibL3O35tPUlTBIn2PZRy9QtOya4X5W/VwWgwCyHcAPJbfeSrghbDCwDRzyzeRn7X4
         J4qkgxIhHw4QjcM/4nMsXFlm3mxKN3MogFrRTgu1Bjh8ErmPlhM/dixXFd27nnSscVHC
         LCCHNJNM9Q9LY8sqmmxVWBGWGmagNPbskE3LxISSskUVc2E5S0FQTgWK5V+x6dUmsar6
         fpm49+QOd5aBC1i6pHsVHOISwVDeFVmo320QZZqbUVIaJFdlQ4elP+yw79y0i2Qodcfy
         Y+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731672; x=1710336472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0PvucL6HmTJPxI4SoEkWegaPuUqqdMQQ07XKPr7IUE=;
        b=bdr3rxhxlblcirUw2PX538FDiJp/T4gx5hCPWdsNnW8XL2PbzA5VYZt5X/DD3Ny9xQ
         deC1/BOVDGo1EgA2VV4UZOVn7Az/o2hlL7DO3fkIKjZwjL+YQecTofEp/58+SEkbx5KJ
         YSVMi3wfR6Z0VfA5Qg3jdqonmKkRDUljoccuCO5HjvDOOLa88Yd/3C+ekM88wagN4ukL
         Aa1E5GS5khIcn4HeehsTp9sijfgLECIGcZbq1f+z6IY0YVeYRjq/VMzpfApsjteAdwoN
         HYKe7/R3UWcFIRQxfz+Fazju8nApS3rNfJrM89fPrlXqcztame/KM44YSC3s1PG+byvh
         KttQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9eZCK/Lh6KpW5O/+nUDnD8ckS8Mf4ZcpPzlTwhgN7YC9a/JGZZaMGPYs+qLUXb56oizR6KMNRUKWxecwQGxE/x+z+222H/OYt25uwp31hml8tXZVyW/WEWVXMecL5TMYzY1MB
X-Gm-Message-State: AOJu0YxVU3nhefW9Hla5r0Pn5cMO7Rq0EOUFRPWY1vaWDz03KBas2xbu
	RXRkLg4UwvFK2QMh7FDV6t7F9eCVNvgMZwUZnyzxbV4II+5ri6AF
X-Google-Smtp-Source: AGHT+IEdFCX2aJgj0ez4SSkRsd6MT2uesocn1kIUh63onuC2wn5Lla2LBTT79+qSGTnzA1IsbvsBJA==
X-Received: by 2002:a25:ae60:0:b0:dc6:b8f5:50ae with SMTP id g32-20020a25ae60000000b00dc6b8f550aemr13653049ybe.32.1709731672289;
        Wed, 06 Mar 2024 05:27:52 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:a708:4ac5:2d2f:c5bb])
        by smtp.gmail.com with ESMTPSA id g7-20020a258a07000000b00dcdb7d232f9sm3019270ybl.4.2024.03.06.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:27:51 -0800 (PST)
Date: Wed, 6 Mar 2024 05:27:51 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Message-ID: <ZehvV6kCD3RCumAL@yury-ThinkPad>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306080726.167338-2-herve.codina@bootlin.com>

On Wed, Mar 06, 2024 at 09:07:17AM +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/wan/Kconfig        |  12 +
>  drivers/net/wan/Makefile       |   1 +
>  drivers/net/wan/fsl_qmc_hdlc.c | 413 +++++++++++++++++++++++++++++++++
>  3 files changed, 426 insertions(+)
>  create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c
> 
> diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
> index 7dda87756d3f..31ab2136cdf1 100644
> --- a/drivers/net/wan/Kconfig
> +++ b/drivers/net/wan/Kconfig
> @@ -197,6 +197,18 @@ config FARSYNC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called farsync.
>  
> +config FSL_QMC_HDLC
> +	tristate "Freescale QMC HDLC support"
> +	depends on HDLC
> +	depends on CPM_QMC
> +	help
> +	  HDLC support using the Freescale QUICC Multichannel Controller (QMC).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called fsl_qmc_hdlc.
> +
> +	  If unsure, say N.
> +
>  config FSL_UCC_HDLC
>  	tristate "Freescale QUICC Engine HDLC support"
>  	depends on HDLC
> diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
> index 8119b49d1da9..00e9b7ee1e01 100644
> --- a/drivers/net/wan/Makefile
> +++ b/drivers/net/wan/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_WANXL)		+= wanxl.o
>  obj-$(CONFIG_PCI200SYN)		+= pci200syn.o
>  obj-$(CONFIG_PC300TOO)		+= pc300too.o
>  obj-$(CONFIG_IXP4XX_HSS)	+= ixp4xx_hss.o
> +obj-$(CONFIG_FSL_QMC_HDLC)	+= fsl_qmc_hdlc.o
>  obj-$(CONFIG_FSL_UCC_HDLC)	+= fsl_ucc_hdlc.o
>  obj-$(CONFIG_SLIC_DS26522)	+= slic_ds26522.o
>  
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
> new file mode 100644
> index 000000000000..90063a92209e
> --- /dev/null
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Freescale QMC HDLC Device Driver
> + *
> + * Copyright 2023 CS GROUP France
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hdlc.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <soc/fsl/qe/qmc.h>
> +
> +struct qmc_hdlc_desc {
> +	struct net_device *netdev;
> +	struct sk_buff *skb; /* NULL if the descriptor is not in use */
> +	dma_addr_t dma_addr;
> +	size_t dma_size;
> +};
> +
> +struct qmc_hdlc {
> +	struct device *dev;
> +	struct qmc_chan *qmc_chan;
> +	struct net_device *netdev;
> +	bool is_crc32;
> +	spinlock_t tx_lock; /* Protect tx descriptors */
> +	struct qmc_hdlc_desc tx_descs[8];
> +	unsigned int tx_out;
> +	struct qmc_hdlc_desc rx_descs[4];
> +};
> +
> +static struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> +{
> +	return dev_to_hdlc(netdev)->priv;
> +}
> +
> +static int qmc_hdlc_recv_queue(struct qmc_hdlc *qmc_hdlc, struct qmc_hdlc_desc *desc, size_t size);
> +
> +#define QMC_HDLC_RX_ERROR_FLAGS				\
> +	(QMC_RX_FLAG_HDLC_OVF | QMC_RX_FLAG_HDLC_UNA |	\
> +	 QMC_RX_FLAG_HDLC_CRC | QMC_RX_FLAG_HDLC_ABORT)
> +
> +static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int flags)
> +{
> +	struct qmc_hdlc_desc *desc = context;
> +	struct net_device *netdev = desc->netdev;
> +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> +	int ret;
> +
> +	dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size, DMA_FROM_DEVICE);
> +
> +	if (flags & QMC_HDLC_RX_ERROR_FLAGS) {
> +		netdev->stats.rx_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_OVF) /* Data overflow */
> +			netdev->stats.rx_over_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_UNA) /* bits received not multiple of 8 */
> +			netdev->stats.rx_frame_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_ABORT) /* Received an abort sequence */
> +			netdev->stats.rx_frame_errors++;
> +		if (flags & QMC_RX_FLAG_HDLC_CRC) /* CRC error */
> +			netdev->stats.rx_crc_errors++;

It's minor, but you can avoid conditionals doing something like:

		netdev->stats.rx_over_errors += !!(flags & QMC_RX_FLAG_HDLC_OVF);

Thanks,
Yury

> +		kfree_skb(desc->skb);
> +	} else {
> +		netdev->stats.rx_packets++;
> +		netdev->stats.rx_bytes += length;
> +
> +		skb_put(desc->skb, length);
> +		desc->skb->protocol = hdlc_type_trans(desc->skb, netdev);
> +		netif_rx(desc->skb);
> +	}
> +
> +	/* Re-queue a transfer using the same descriptor */
> +	ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, desc->dma_size);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "queue recv desc failed (%d)\n", ret);
> +		netdev->stats.rx_errors++;
> +	}
> +}

