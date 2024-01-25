Return-Path: <linux-kernel+bounces-38649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFE83C3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24C41F249EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B650A9E;
	Thu, 25 Jan 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No3vtUZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F550A8A;
	Thu, 25 Jan 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189422; cv=none; b=CM9H+sj1+pkSgsIW5wpPxEeFB6CLhtcIOok4YNTAEXS8bSCJEjZdUHiJpnBN+j7xg4isAtTYt9rFj1jf+FleKqoFAVMfjVCWyQiOKDvK1sW5Byak1yztgyRU+fNt0cRqxyEQzQrgnZsQvbdraZYGIc3bU4VYOZKq+Sk5KZa33wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189422; c=relaxed/simple;
	bh=zME/C+k8tTwbegAkJZORCyfZGb3vyvWjMdZi755TGjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvKYIsTYaAPBni3wrhcRq5/JbWy+7/ej1+MmZdaR+WYDpnmR4/2jJ/P2vPtkFkcK4lZr1mxwrhubkGZ+DZht87QBq5Rqw2NNf2Mm1gc4qzcjkWRL2ocV4oCQbN+XITsZt/RalWVh/hc3y9EWjcu9MDqAynKuWAfhqo6GEIwDEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No3vtUZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE10C433C7;
	Thu, 25 Jan 2024 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189422;
	bh=zME/C+k8tTwbegAkJZORCyfZGb3vyvWjMdZi755TGjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=No3vtUZ53jgCPM1k/Li+GVMP46a5NMKsJAP1FHtzXVz9UkN5i0RK+Y5nmysHPoRMG
	 BU9rkt9xe9XhSpoR9azmJGlzqWqCLUOpUqeEstxm+qIEtqqly95VzYYmS3z2ARmwMb
	 msDxTRBIfAbU5vUsmYGFA0VaIyGhMHFdUeuNjKtjVrfjWEIhr9Bm/iYfRM8nYtEvhz
	 1rTW4KCBMi/0nlsYALYNhrrByHCcVTUuM30zDflmOF2vHKcnDGiOGKPiUzwlRScnbw
	 H/vUou6Z27D5HdTT/cOd0jJfCcbZaoJkdrceFdJcv4pKe1wbKVl3iryMBiAuScujF3
	 KuVhb9FlZgxcQ==
Date: Thu, 25 Jan 2024 14:30:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] ahci: add 43-bit DMA address quirk for ASMedia ASM106x
 controllers
Message-ID: <ZbJiZotayVjtF8ti@x1-carbon>
References: <ZbEWsp4KT-V9YUaC@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEWsp4KT-V9YUaC@wantstofly.org>

Hello Lennert,

On Wed, Jan 24, 2024 at 03:54:58PM +0200, Lennert Buytenhek wrote:
> With one of the on-board ASM1061 AHCI controllers (1b21:0612) on an
> ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, a controller hang was
> observed that was immediately preceded by the following kernel messages:
> 
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]
> 
> The first message is produced by code in drivers/iommu/dma-iommu.c which
> is accompanied by the following comment that seems to apply:
> 
>         /*
>          * Try to use all the 32-bit PCI addresses first. The original SAC vs.
>          * DAC reasoning loses relevance with PCIe, but enough hardware and
>          * firmware bugs are still lurking out there that it's safest not to
>          * venture into the 64-bit space until necessary.
>          *
>          * If your device goes wrong after seeing the notice then likely either
>          * its driver is not setting DMA masks accurately, the hardware has
>          * some inherent bug in handling >32-bit addresses, or not all the
>          * expected address bits are wired up between the device and the IOMMU.
>          */
> 
> Asking the ASM1061 on a discrete PCIe card to DMA from I/O virtual
> address 0xffffffff00000000 produces the following I/O page faults:
> 
> [Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
> [Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]
> 
> Note that the upper 21 bits of the logged DMA address are zero.  (When
> asking a different PCIe device in the same PCIe slot to DMA to the same
> I/O virtual address, we do see all the upper 32 bits of the DMA address
> as 1, so this is not an issue with the chipset or IOMMU configuration on
> the test system.)
> 
> Finally, hacking libahci to always set the upper 21 bits of all DMA
> addresses to 1 produces no discernible effect on the behavior of the
> ASM1061, and mkfs/mount/scrub/etc work as without this hack.
> 
> This all strongly suggests that the ASM1061 has a 43 bit DMA address
> limit, and this commit therefore adds a quirk to deal with this limit.

Thank you for all the effort you spent on debugging this!


> We apply the quirk to the other known ASMedia parts as well, since they
> are similar and likely to be affected by the same issue.

I think we want to limit the quirk to ASMedia device ID 0x612 (and
probably also 0x611) for now, as that is what you have tested with.

We don't know for sure if the other devices are also broken.
(Even though it seems highely likely that some of them are.)

If the ASMedia guys eventually reply to the other email and tell us
the exactly which device IDs that are affected, then it will be trivial
to apply the quirk for other affected device IDs as well.


> 
> Link: https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
> ---
>  drivers/ata/ahci.c | 38 +++++++++++++++++++++++++++-----------
>  drivers/ata/ahci.h |  1 +
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 08745e7db820..dc86c73019ce 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -58,6 +58,7 @@ enum board_ids {
>  
>  	/* board IDs for specific chipsets in alphabetical order */
>  	board_ahci_al,
> +	board_ahci_asm106x,
>  	board_ahci_avn,
>  	board_ahci_mcp65,
>  	board_ahci_mcp77,
> @@ -185,6 +186,13 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> +	[board_ahci_asm106x] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
>  	[board_ahci_avn] = {
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
> @@ -596,14 +604,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
>  	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
>  
> -	/* Asmedia */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
> +	/* ASMedia, 43 bit DMA address limit */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_asm106x },	/* ASM1060 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_asm106x },	/* ASM1060 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_asm106x },	/* ASM1061 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_asm106x },	/* ASM1061/1062 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_asm106x },   /* ASM1061R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_asm106x },   /* ASM1062R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_asm106x },   /* ASM1062+JMB575 */
>  
>  	/*
>  	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
> @@ -943,11 +951,19 @@ static int ahci_pci_device_resume(struct device *dev)
>  
>  #endif /* CONFIG_PM */
>  
> -static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
> +static int ahci_configure_dma_masks(struct pci_dev *pdev,
> +				    struct ahci_host_priv *hpriv)
>  {
> -	const int dma_bits = using_dac ? 64 : 32;
> +	int dma_bits;
>  	int rc;
>  
> +	if (!(hpriv->cap & HOST_CAP_64))
> +		dma_bits = 32;
> +	else if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
> +		dma_bits = 43;
> +	else
> +		dma_bits = 64;
> +

I would prefer if you write this as:

if (hpriv->cap & HOST_CAP_64) {
	dma_bits = 64;
	if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
		dma_bits = 43;
} else {
	dma_bits = 32;
}

Such that we still require the device to advertize 64 bit support,
and the quirk.
If the device does not advertize 64, we don't want it to be possible
to use a mask >32, even if the quirk flag is set.

Otherwise this looks good!


Kind regards,
Niklas

