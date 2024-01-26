Return-Path: <linux-kernel+bounces-39683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26D83D4F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2182D1F29A79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9518C38;
	Fri, 26 Jan 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0M/+0Dl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C491427A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252537; cv=none; b=mEcucGRDQOCwOJ4/n3KyajnRiQ8Zmygs8tAzRdQ/MqdVhK+TsEamQ51RBeMNChzbA5MoK00QmtS5yPf7Dr+n1XQ8F9qjD8A3OA3LV1EgNSYxW5K7WWmuToeYX41sC/gLAJlacFLsjldcIyrRvYVl9Lmus7T9fNZrby1tZnPCeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252537; c=relaxed/simple;
	bh=6A1Ec0hcAcDSXfpWqEsvksMUBmqx5jHm+qFzmWrsDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Sm75VdPby1L4gInJ9mgT+zYWQCkskv5xnKK3B2qxvGz0hZjW38dn+KlzE4V4Gui0EhRxFsSdtajFSIVqu9/zEvgxSPcHz8Mz2yrQPeE3wRKQ0+Ytz9OFkV79tgVuenMzpcb/n99Anj51j5eiVV0wz80/WbQRpsKGCKPp7emTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s0M/+0Dl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7Dw4ZucWoH6p0xVnUgKiMRWXXupBNncYxdOpylDCZI=; b=s0M/+0DlriPPYBQpc38JXKm9wr
	rMgc6NpuZlUrG0dKXVdJVzaEQYGrPhhkeqgmMD/AwzXz16ztX3Rb6lfdLa1WT5kMwKQ6YniAI6M4n
	zcAEIQqgixXKQ5b1N8XcSdtheJLBmkKtA0xB22fZOmdpgFrWfvf+gbXEHvkyYG6SpELLGhbLQQYL9
	7mePUqodlvRAC5gl6nvqE7NoMFknmo1TPvhjkbM99by3MdDJ8cUw0C1c+0+9B6nYdVKsqz1fVib2i
	H8pAGti4wQpHc+x9Mtm3JxRbTqS2xU8jfOGZmecnEFsRGkCWbjlTzcCMual/Twq/5I5phF12BOnYW
	/ZnxKp4g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTGE1-0000000Cpxb-0eiX;
	Fri, 26 Jan 2024 07:02:05 +0000
Date: Fri, 26 Jan 2024 07:02:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/2] mtd: Remove support for Carillo Ranch driver
Message-ID: <ZbNY7Vd2l8wjIhcp@casper.infradead.org>
References: <20231208224703.1603264-1-willy@infradead.org>
 <20231208224703.1603264-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208224703.1603264-2-willy@infradead.org>

Ping

On Fri, Dec 08, 2023 at 10:47:03PM +0000, Matthew Wilcox (Oracle) wrote:
> As far as anybody can tell, this product never shipped.  If it did,
> it shipped in 2007 and nobody has access to one any more.  Remove the
> mtd NOR driver.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  drivers/mtd/maps/Kconfig        |   7 -
>  drivers/mtd/maps/Makefile       |   1 -
>  drivers/mtd/maps/intel_vr_nor.c | 265 --------------------------------
>  3 files changed, 273 deletions(-)
>  delete mode 100644 drivers/mtd/maps/intel_vr_nor.c
> 
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index e098ae937ce8..8a8b19874e23 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -341,13 +341,6 @@ config MTD_UCLINUX
>  	help
>  	  Map driver to support image based filesystems for uClinux.
>  
> -config MTD_INTEL_VR_NOR
> -	tristate "NOR flash on Intel Vermilion Range Expansion Bus CS0"
> -	depends on PCI
> -	help
> -	  Map driver for a NOR flash bank located on the Expansion Bus of the
> -	  Intel Vermilion Range chipset.
> -
>  config MTD_PLATRAM
>  	tristate "Map driver for platform device RAM (mtd-ram)"
>  	select MTD_RAM
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 094cfb244086..a9083c888e3b 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -40,6 +40,5 @@ obj-$(CONFIG_MTD_UCLINUX)	+= uclinux.o
>  obj-$(CONFIG_MTD_NETtel)	+= nettel.o
>  obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
>  obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
> -obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
>  obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
>  obj-$(CONFIG_MTD_LANTIQ)	+= lantiq-flash.o
> diff --git a/drivers/mtd/maps/intel_vr_nor.c b/drivers/mtd/maps/intel_vr_nor.c
> deleted file mode 100644
> index d67b845b0e89..000000000000
> --- a/drivers/mtd/maps/intel_vr_nor.c
> +++ /dev/null
> @@ -1,265 +0,0 @@
> -/*
> - * drivers/mtd/maps/intel_vr_nor.c
> - *
> - * An MTD map driver for a NOR flash bank on the Expansion Bus of the Intel
> - * Vermilion Range chipset.
> - *
> - * The Vermilion Range Expansion Bus supports four chip selects, each of which
> - * has 64MiB of address space.  The 2nd BAR of the Expansion Bus PCI Device
> - * is a 256MiB memory region containing the address spaces for all four of the
> - * chip selects, with start addresses hardcoded on 64MiB boundaries.
> - *
> - * This map driver only supports NOR flash on chip select 0.  The buswidth
> - * (either 8 bits or 16 bits) is determined by reading the Expansion Bus Timing
> - * and Control Register for Chip Select 0 (EXP_TIMING_CS0).  This driver does
> - * not modify the value in the EXP_TIMING_CS0 register except to enable writing
> - * and disable boot acceleration.  The timing parameters in the register are
> - * assumed to have been properly initialized by the BIOS.  The reset default
> - * timing parameters are maximally conservative (slow), so access to the flash
> - * will be slower than it should be if the BIOS has not initialized the timing
> - * parameters.
> - *
> - * Author: Andy Lowe <alowe@mvista.com>
> - *
> - * 2006 (c) MontaVista Software, Inc. This file is licensed under
> - * the terms of the GNU General Public License version 2. This program
> - * is licensed "as is" without any warranty of any kind, whether express
> - * or implied.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/pci.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/map.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/mtd/cfi.h>
> -#include <linux/mtd/flashchip.h>
> -
> -#define DRV_NAME "vr_nor"
> -
> -struct vr_nor_mtd {
> -	void __iomem *csr_base;
> -	struct map_info map;
> -	struct mtd_info *info;
> -	struct pci_dev *dev;
> -};
> -
> -/* Expansion Bus Configuration and Status Registers are in BAR 0 */
> -#define EXP_CSR_MBAR 0
> -/* Expansion Bus Memory Window is BAR 1 */
> -#define EXP_WIN_MBAR 1
> -/* Maximum address space for Chip Select 0 is 64MiB */
> -#define CS0_SIZE 0x04000000
> -/* Chip Select 0 is at offset 0 in the Memory Window */
> -#define CS0_START 0x0
> -/* Chip Select 0 Timing Register is at offset 0 in CSR */
> -#define EXP_TIMING_CS0 0x00
> -#define TIMING_CS_EN		(1 << 31)	/* Chip Select Enable */
> -#define TIMING_BOOT_ACCEL_DIS	(1 <<  8)	/* Boot Acceleration Disable */
> -#define TIMING_WR_EN		(1 <<  1)	/* Write Enable */
> -#define TIMING_BYTE_EN		(1 <<  0)	/* 8-bit vs 16-bit bus */
> -#define TIMING_MASK		0x3FFF0000
> -
> -static void vr_nor_destroy_partitions(struct vr_nor_mtd *p)
> -{
> -	mtd_device_unregister(p->info);
> -}
> -
> -static int vr_nor_init_partitions(struct vr_nor_mtd *p)
> -{
> -	/* register the flash bank */
> -	/* partition the flash bank */
> -	return mtd_device_register(p->info, NULL, 0);
> -}
> -
> -static void vr_nor_destroy_mtd_setup(struct vr_nor_mtd *p)
> -{
> -	map_destroy(p->info);
> -}
> -
> -static int vr_nor_mtd_setup(struct vr_nor_mtd *p)
> -{
> -	static const char * const probe_types[] =
> -	    { "cfi_probe", "jedec_probe", NULL };
> -	const char * const *type;
> -
> -	for (type = probe_types; !p->info && *type; type++)
> -		p->info = do_map_probe(*type, &p->map);
> -	if (!p->info)
> -		return -ENODEV;
> -
> -	p->info->dev.parent = &p->dev->dev;
> -
> -	return 0;
> -}
> -
> -static void vr_nor_destroy_maps(struct vr_nor_mtd *p)
> -{
> -	unsigned int exp_timing_cs0;
> -
> -	/* write-protect the flash bank */
> -	exp_timing_cs0 = readl(p->csr_base + EXP_TIMING_CS0);
> -	exp_timing_cs0 &= ~TIMING_WR_EN;
> -	writel(exp_timing_cs0, p->csr_base + EXP_TIMING_CS0);
> -
> -	/* unmap the flash window */
> -	iounmap(p->map.virt);
> -
> -	/* unmap the csr window */
> -	iounmap(p->csr_base);
> -}
> -
> -/*
> - * Initialize the map_info structure and map the flash.
> - * Returns 0 on success, nonzero otherwise.
> - */
> -static int vr_nor_init_maps(struct vr_nor_mtd *p)
> -{
> -	unsigned long csr_phys, csr_len;
> -	unsigned long win_phys, win_len;
> -	unsigned int exp_timing_cs0;
> -	int err;
> -
> -	csr_phys = pci_resource_start(p->dev, EXP_CSR_MBAR);
> -	csr_len = pci_resource_len(p->dev, EXP_CSR_MBAR);
> -	win_phys = pci_resource_start(p->dev, EXP_WIN_MBAR);
> -	win_len = pci_resource_len(p->dev, EXP_WIN_MBAR);
> -
> -	if (!csr_phys || !csr_len || !win_phys || !win_len)
> -		return -ENODEV;
> -
> -	if (win_len < (CS0_START + CS0_SIZE))
> -		return -ENXIO;
> -
> -	p->csr_base = ioremap(csr_phys, csr_len);
> -	if (!p->csr_base)
> -		return -ENOMEM;
> -
> -	exp_timing_cs0 = readl(p->csr_base + EXP_TIMING_CS0);
> -	if (!(exp_timing_cs0 & TIMING_CS_EN)) {
> -		dev_warn(&p->dev->dev, "Expansion Bus Chip Select 0 "
> -		       "is disabled.\n");
> -		err = -ENODEV;
> -		goto release;
> -	}
> -	if ((exp_timing_cs0 & TIMING_MASK) == TIMING_MASK) {
> -		dev_warn(&p->dev->dev, "Expansion Bus Chip Select 0 "
> -		       "is configured for maximally slow access times.\n");
> -	}
> -	p->map.name = DRV_NAME;
> -	p->map.bankwidth = (exp_timing_cs0 & TIMING_BYTE_EN) ? 1 : 2;
> -	p->map.phys = win_phys + CS0_START;
> -	p->map.size = CS0_SIZE;
> -	p->map.virt = ioremap(p->map.phys, p->map.size);
> -	if (!p->map.virt) {
> -		err = -ENOMEM;
> -		goto release;
> -	}
> -	simple_map_init(&p->map);
> -
> -	/* Enable writes to flash bank */
> -	exp_timing_cs0 |= TIMING_BOOT_ACCEL_DIS | TIMING_WR_EN;
> -	writel(exp_timing_cs0, p->csr_base + EXP_TIMING_CS0);
> -
> -	return 0;
> -
> -      release:
> -	iounmap(p->csr_base);
> -	return err;
> -}
> -
> -static const struct pci_device_id vr_nor_pci_ids[] = {
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x500D)},
> -	{0,}
> -};
> -
> -static void vr_nor_pci_remove(struct pci_dev *dev)
> -{
> -	struct vr_nor_mtd *p = pci_get_drvdata(dev);
> -
> -	vr_nor_destroy_partitions(p);
> -	vr_nor_destroy_mtd_setup(p);
> -	vr_nor_destroy_maps(p);
> -	kfree(p);
> -	pci_release_regions(dev);
> -	pci_disable_device(dev);
> -}
> -
> -static int vr_nor_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> -{
> -	struct vr_nor_mtd *p = NULL;
> -	unsigned int exp_timing_cs0;
> -	int err;
> -
> -	err = pci_enable_device(dev);
> -	if (err)
> -		goto out;
> -
> -	err = pci_request_regions(dev, DRV_NAME);
> -	if (err)
> -		goto disable_dev;
> -
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> -	err = -ENOMEM;
> -	if (!p)
> -		goto release;
> -
> -	p->dev = dev;
> -
> -	err = vr_nor_init_maps(p);
> -	if (err)
> -		goto release;
> -
> -	err = vr_nor_mtd_setup(p);
> -	if (err)
> -		goto destroy_maps;
> -
> -	err = vr_nor_init_partitions(p);
> -	if (err)
> -		goto destroy_mtd_setup;
> -
> -	pci_set_drvdata(dev, p);
> -
> -	return 0;
> -
> -      destroy_mtd_setup:
> -	map_destroy(p->info);
> -
> -      destroy_maps:
> -	/* write-protect the flash bank */
> -	exp_timing_cs0 = readl(p->csr_base + EXP_TIMING_CS0);
> -	exp_timing_cs0 &= ~TIMING_WR_EN;
> -	writel(exp_timing_cs0, p->csr_base + EXP_TIMING_CS0);
> -
> -	/* unmap the flash window */
> -	iounmap(p->map.virt);
> -
> -	/* unmap the csr window */
> -	iounmap(p->csr_base);
> -
> -      release:
> -	kfree(p);
> -	pci_release_regions(dev);
> -
> -      disable_dev:
> -	pci_disable_device(dev);
> -
> -      out:
> -	return err;
> -}
> -
> -static struct pci_driver vr_nor_pci_driver = {
> -	.name = DRV_NAME,
> -	.probe = vr_nor_pci_probe,
> -	.remove = vr_nor_pci_remove,
> -	.id_table = vr_nor_pci_ids,
> -};
> -
> -module_pci_driver(vr_nor_pci_driver);
> -
> -MODULE_AUTHOR("Andy Lowe");
> -MODULE_DESCRIPTION("MTD map driver for NOR flash on Intel Vermilion Range");
> -MODULE_LICENSE("GPL");
> -MODULE_DEVICE_TABLE(pci, vr_nor_pci_ids);
> -- 
> 2.42.0
> 

