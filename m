Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6E7D5960
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjJXRFx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbjJXQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:33:53 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A398D118;
        Tue, 24 Oct 2023 09:33:49 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qvKLd-0042IR-Dp; Tue, 24 Oct 2023 18:33:41 +0200
Received: from p57bd9695.dip0.t-ipconnect.de ([87.189.150.149] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qvKLd-0004ol-5c; Tue, 24 Oct 2023 18:33:41 +0200
Message-ID: <12a9df88052fa5c688028644fb225448208f3402.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] [v2] sh: remove superhyway bus support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Oct 2023 18:33:40 +0200
In-Reply-To: <20230914155523.3839811-3-arnd@kernel.org>
References: <20230914155523.3839811-1-arnd@kernel.org>
         <20230914155523.3839811-3-arnd@kernel.org>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.149
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 17:55 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> superhyway was only referenced on sh4-202, which is now gone, so remove
> it all as well.
> 
> I could find no trace of anything ever calling
> superhyway_register_driver(), not in the git history but also not on the
> web, so I assume this has never served any purpose on mainline kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/arch/sh/index.rst          |   6 -
>  arch/sh/Kconfig                          |   4 -
>  arch/sh/drivers/Makefile                 |   1 -
>  arch/sh/drivers/superhyway/Makefile      |   7 -
>  arch/sh/drivers/superhyway/ops-sh4-202.c | 168 ----------------
>  drivers/sh/Makefile                      |   1 -
>  drivers/sh/superhyway/Makefile           |   8 -
>  drivers/sh/superhyway/superhyway-sysfs.c |  54 ------
>  drivers/sh/superhyway/superhyway.c       | 234 -----------------------
>  include/linux/superhyway.h               | 107 -----------
>  10 files changed, 590 deletions(-)
>  delete mode 100644 arch/sh/drivers/superhyway/Makefile
>  delete mode 100644 arch/sh/drivers/superhyway/ops-sh4-202.c
>  delete mode 100644 drivers/sh/superhyway/Makefile
>  delete mode 100644 drivers/sh/superhyway/superhyway-sysfs.c
>  delete mode 100644 drivers/sh/superhyway/superhyway.c
>  delete mode 100644 include/linux/superhyway.h
> 
> diff --git a/Documentation/arch/sh/index.rst b/Documentation/arch/sh/index.rst
> index c64776738cf6b..01fce7c131f13 100644
> --- a/Documentation/arch/sh/index.rst
> +++ b/Documentation/arch/sh/index.rst
> @@ -43,12 +43,6 @@ mach-x3proto
>  Busses
>  ======
>  
> -SuperHyway
> -----------
> -
> -.. kernel-doc:: drivers/sh/superhyway/superhyway.c
> -   :export:
> -
>  Maple
>  -----
>  
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d785329e57151..7500521b2b984 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -737,10 +737,6 @@ endmenu
>  
>  menu "Bus options"
>  
> -config SUPERHYWAY
> -	tristate "SuperHyway Bus support"
> -	depends on CPU_SUBTYPE_SH4_202
> -
>  config MAPLE
>  	bool "Maple Bus support"
>  	depends on SH_DREAMCAST
> diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
> index 56b0acace6e7c..8bd10b904bf93 100644
> --- a/arch/sh/drivers/Makefile
> +++ b/arch/sh/drivers/Makefile
> @@ -6,6 +6,5 @@
>  obj-y		+= dma/ platform_early.o
>  
>  obj-$(CONFIG_PCI)		+= pci/
> -obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
>  obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
>  obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
> diff --git a/arch/sh/drivers/superhyway/Makefile b/arch/sh/drivers/superhyway/Makefile
> deleted file mode 100644
> index aa6e3267c055d..0000000000000
> --- a/arch/sh/drivers/superhyway/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for the SuperHyway specific kernel interface routines under Linux.
> -#
> -
> -obj-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= ops-sh4-202.o
> -
> diff --git a/arch/sh/drivers/superhyway/ops-sh4-202.c b/arch/sh/drivers/superhyway/ops-sh4-202.c
> deleted file mode 100644
> index 490142274e3b0..0000000000000
> --- a/arch/sh/drivers/superhyway/ops-sh4-202.c
> +++ /dev/null
> @@ -1,168 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/drivers/superhyway/ops-sh4-202.c
> - *
> - * SuperHyway bus support for SH4-202
> - *
> - * Copyright (C) 2005  Paul Mundt
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/superhyway.h>
> -#include <linux/string.h>
> -#include <asm/addrspace.h>
> -#include <asm/io.h>
> -
> -#define PHYS_EMI_CBLOCK		P4SEGADDR(0x1ec00000)
> -#define PHYS_EMI_DBLOCK		P4SEGADDR(0x08000000)
> -#define PHYS_FEMI_CBLOCK	P4SEGADDR(0x1f800000)
> -#define PHYS_FEMI_DBLOCK	P4SEGADDR(0x00000000)
> -
> -#define PHYS_EPBR_BLOCK		P4SEGADDR(0x1de00000)
> -#define PHYS_DMAC_BLOCK		P4SEGADDR(0x1fa00000)
> -#define PHYS_PBR_BLOCK		P4SEGADDR(0x1fc00000)
> -
> -static struct resource emi_resources[] = {
> -	[0] = {
> -		.start	= PHYS_EMI_CBLOCK,
> -		.end	= PHYS_EMI_CBLOCK + 0x00300000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_EMI_DBLOCK,
> -		.end	= PHYS_EMI_DBLOCK + 0x08000000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device emi_device = {
> -	.name		= "emi",
> -	.num_resources	= ARRAY_SIZE(emi_resources),
> -	.resource	= emi_resources,
> -};
> -
> -static struct resource femi_resources[] = {
> -	[0] = {
> -		.start	= PHYS_FEMI_CBLOCK,
> -		.end	= PHYS_FEMI_CBLOCK + 0x00100000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_FEMI_DBLOCK,
> -		.end	= PHYS_FEMI_DBLOCK + 0x08000000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device femi_device = {
> -	.name		= "femi",
> -	.num_resources	= ARRAY_SIZE(femi_resources),
> -	.resource	= femi_resources,
> -};
> -
> -static struct resource epbr_resources[] = {
> -	[0] = {
> -		.start	= P4SEGADDR(0x1e7ffff8),
> -		.end	= P4SEGADDR(0x1e7ffff8 + (sizeof(u32) * 2) - 1),
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_EPBR_BLOCK,
> -		.end	= PHYS_EPBR_BLOCK + 0x00a00000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device epbr_device = {
> -	.name		= "epbr",
> -	.num_resources	= ARRAY_SIZE(epbr_resources),
> -	.resource	= epbr_resources,
> -};
> -
> -static struct resource dmac_resource = {
> -	.start	= PHYS_DMAC_BLOCK,
> -	.end	= PHYS_DMAC_BLOCK + 0x00100000 - 1,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static struct superhyway_device dmac_device = {
> -	.name		= "dmac",
> -	.num_resources	= 1,
> -	.resource	= &dmac_resource,
> -};
> -
> -static struct resource pbr_resources[] = {
> -	[0] = {
> -		.start	= P4SEGADDR(0x1ffffff8),
> -		.end	= P4SEGADDR(0x1ffffff8 + (sizeof(u32) * 2) - 1),
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_PBR_BLOCK,
> -		.end	= PHYS_PBR_BLOCK + 0x00400000 - (sizeof(u32) * 2) - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device pbr_device = {
> -	.name		= "pbr",
> -	.num_resources	= ARRAY_SIZE(pbr_resources),
> -	.resource	= pbr_resources,
> -};
> -
> -static struct superhyway_device *sh4202_devices[] __initdata = {
> -	&emi_device, &femi_device, &epbr_device, &dmac_device, &pbr_device,
> -};
> -
> -static int sh4202_read_vcr(unsigned long base, struct superhyway_vcr_info *vcr)
> -{
> -	u32 vcrh, vcrl;
> -	u64 tmp;
> -
> -	/*
> -	 * XXX: Even though the SH4-202 Evaluation Device documentation
> -	 * indicates that VCRL is mapped first with VCRH at a + 0x04
> -	 * offset, the opposite seems to be true.
> -	 *
> -	 * Some modules (PBR and ePBR for instance) also appear to have
> -	 * VCRL/VCRH flipped in the documentation, but on the SH4-202
> -	 * itself it appears that these are all consistently mapped with
> -	 * VCRH preceding VCRL.
> -	 *
> -	 * Do not trust the documentation, for it is evil.
> -	 */
> -	vcrh = __raw_readl(base);
> -	vcrl = __raw_readl(base + sizeof(u32));
> -
> -	tmp = ((u64)vcrh << 32) | vcrl;
> -	memcpy(vcr, &tmp, sizeof(u64));
> -
> -	return 0;
> -}
> -
> -static int sh4202_write_vcr(unsigned long base, struct superhyway_vcr_info vcr)
> -{
> -	u64 tmp = *(u64 *)&vcr;
> -
> -	__raw_writel((tmp >> 32) & 0xffffffff, base);
> -	__raw_writel(tmp & 0xffffffff, base + sizeof(u32));
> -
> -	return 0;
> -}
> -
> -static struct superhyway_ops sh4202_superhyway_ops = {
> -	.read_vcr	= sh4202_read_vcr,
> -	.write_vcr	= sh4202_write_vcr,
> -};
> -
> -struct superhyway_bus superhyway_channels[] = {
> -	{ &sh4202_superhyway_ops, },
> -	{ 0, },
> -};
> -
> -int __init superhyway_scan_bus(struct superhyway_bus *bus)
> -{
> -	return superhyway_add_devices(bus, sh4202_devices,
> -				      ARRAY_SIZE(sh4202_devices));
> -}
> -
> diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
> index c53262835e85e..0aa152b1587ad 100644
> --- a/drivers/sh/Makefile
> +++ b/drivers/sh/Makefile
> @@ -7,6 +7,5 @@ ifneq ($(CONFIG_COMMON_CLK),y)
>  obj-$(CONFIG_HAVE_CLK)			+= clk/
>  endif
>  obj-$(CONFIG_MAPLE)			+= maple/
> -obj-$(CONFIG_SUPERHYWAY)		+= superhyway/
>  
>  obj-y					+= pm_runtime.o
> diff --git a/drivers/sh/superhyway/Makefile b/drivers/sh/superhyway/Makefile
> deleted file mode 100644
> index 6dfa41f160af6..0000000000000
> --- a/drivers/sh/superhyway/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile for the SuperHyway bus drivers.
> -#
> -
> -obj-$(CONFIG_SUPERHYWAY)	+= superhyway.o
> -obj-$(CONFIG_SYSFS)		+= superhyway-sysfs.o
> -
> diff --git a/drivers/sh/superhyway/superhyway-sysfs.c b/drivers/sh/superhyway/superhyway-sysfs.c
> deleted file mode 100644
> index 774f31b564f8f..0000000000000
> --- a/drivers/sh/superhyway/superhyway-sysfs.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - * drivers/sh/superhyway/superhyway-sysfs.c
> - *
> - * SuperHyway Bus sysfs interface
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/types.h>
> -#include <linux/superhyway.h>
> -
> -#define superhyway_ro_attr(name, fmt, field)				\
> -static ssize_t name##_show(struct device *dev, struct device_attribute *attr, char *buf)		\
> -{									\
> -	struct superhyway_device *s = to_superhyway_device(dev);	\
> -	return sprintf(buf, fmt, s->field);				\
> -}									\
> -static DEVICE_ATTR_RO(name);
> -
> -/* VCR flags */
> -superhyway_ro_attr(perr_flags, "0x%02x\n", vcr.perr_flags);
> -superhyway_ro_attr(merr_flags, "0x%02x\n", vcr.merr_flags);
> -superhyway_ro_attr(mod_vers, "0x%04x\n", vcr.mod_vers);
> -superhyway_ro_attr(mod_id, "0x%04x\n", vcr.mod_id);
> -superhyway_ro_attr(bot_mb, "0x%02x\n", vcr.bot_mb);
> -superhyway_ro_attr(top_mb, "0x%02x\n", vcr.top_mb);
> -
> -/* Misc */
> -superhyway_ro_attr(resource, "0x%08lx\n", resource[0].start);
> -
> -static struct attribute *superhyway_dev_attrs[] = {
> -	&dev_attr_perr_flags.attr,
> -	&dev_attr_merr_flags.attr,
> -	&dev_attr_mod_vers.attr,
> -	&dev_attr_mod_id.attr,
> -	&dev_attr_bot_mb.attr,
> -	&dev_attr_top_mb.attr,
> -	&dev_attr_resource.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group superhyway_dev_group = {
> -	.attrs = superhyway_dev_attrs,
> -};
> -
> -const struct attribute_group *superhyway_dev_groups[] = {
> -	&superhyway_dev_group,
> -	NULL,
> -};
> diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
> deleted file mode 100644
> index 44324abe21dad..0000000000000
> --- a/drivers/sh/superhyway/superhyway.c
> +++ /dev/null
> @@ -1,234 +0,0 @@
> -/*
> - * drivers/sh/superhyway/superhyway.c
> - *
> - * SuperHyway Bus Driver
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/list.h>
> -#include <linux/superhyway.h>
> -#include <linux/string.h>
> -#include <linux/slab.h>
> -
> -static int superhyway_devices;
> -
> -static struct device superhyway_bus_device = {
> -	.init_name = "superhyway",
> -};
> -
> -static void superhyway_device_release(struct device *dev)
> -{
> -	struct superhyway_device *sdev = to_superhyway_device(dev);
> -
> -	kfree(sdev->resource);
> -	kfree(sdev);
> -}
> -
> -/**
> - * superhyway_add_device - Add a SuperHyway module
> - * @base: Physical address where module is mapped.
> - * @sdev: SuperHyway device to add, or NULL to allocate a new one.
> - * @bus: Bus where SuperHyway module resides.
> - *
> - * This is responsible for adding a new SuperHyway module. This sets up a new
> - * struct superhyway_device for the module being added if @sdev == NULL.
> - *
> - * Devices are initially added in the order that they are scanned (from the
> - * top-down of the memory map), and are assigned an ID based on the order that
> - * they are added. Any manual addition of a module will thus get the ID after
> - * the devices already discovered regardless of where it resides in memory.
> - *
> - * Further work can and should be done in superhyway_scan_bus(), to be sure
> - * that any new modules are properly discovered and subsequently registered.
> - */
> -int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
> -			  struct superhyway_bus *bus)
> -{
> -	struct superhyway_device *dev = sdev;
> -
> -	if (!dev) {
> -		dev = kzalloc(sizeof(struct superhyway_device), GFP_KERNEL);
> -		if (!dev)
> -			return -ENOMEM;
> -
> -	}
> -
> -	dev->bus = bus;
> -	superhyway_read_vcr(dev, base, &dev->vcr);
> -
> -	if (!dev->resource) {
> -		dev->resource = kzalloc(sizeof(struct resource), GFP_KERNEL);
> -		if (!dev->resource) {
> -			kfree(dev);
> -			return -ENOMEM;
> -		}
> -
> -		dev->resource->name	= dev->name;
> -		dev->resource->start	= base;
> -		dev->resource->end	= dev->resource->start + 0x01000000;
> -	}
> -
> -	dev->dev.parent		= &superhyway_bus_device;
> -	dev->dev.bus		= &superhyway_bus_type;
> -	dev->dev.release	= superhyway_device_release;
> -	dev->id.id		= dev->vcr.mod_id;
> -
> -	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
> -	dev_set_name(&dev->dev, "%02x", superhyway_devices);
> -
> -	superhyway_devices++;
> -
> -	return device_register(&dev->dev);
> -}
> -
> -int superhyway_add_devices(struct superhyway_bus *bus,
> -			   struct superhyway_device **devices,
> -			   int nr_devices)
> -{
> -	int i, ret = 0;
> -
> -	for (i = 0; i < nr_devices; i++) {
> -		struct superhyway_device *dev = devices[i];
> -		ret |= superhyway_add_device(dev->resource[0].start, dev, bus);
> -	}
> -
> -	return ret;
> -}
> -
> -static int __init superhyway_init(void)
> -{
> -	struct superhyway_bus *bus;
> -	int ret;
> -
> -	ret = device_register(&superhyway_bus_device);
> -	if (unlikely(ret))
> -		return ret;
> -
> -	for (bus = superhyway_channels; bus->ops; bus++)
> -		ret |= superhyway_scan_bus(bus);
> -
> -	return ret;
> -}
> -postcore_initcall(superhyway_init);
> -
> -static const struct superhyway_device_id *
> -superhyway_match_id(const struct superhyway_device_id *ids,
> -		    struct superhyway_device *dev)
> -{
> -	while (ids->id) {
> -		if (ids->id == dev->id.id)
> -			return ids;
> -
> -		ids++;
> -	}
> -
> -	return NULL;
> -}
> -
> -static int superhyway_device_probe(struct device *dev)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
> -
> -	if (shyway_drv && shyway_drv->probe) {
> -		const struct superhyway_device_id *id;
> -
> -		id = superhyway_match_id(shyway_drv->id_table, shyway_dev);
> -		if (id)
> -			return shyway_drv->probe(shyway_dev, id);
> -	}
> -
> -	return -ENODEV;
> -}
> -
> -static void superhyway_device_remove(struct device *dev)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
> -
> -	if (shyway_drv->remove)
> -		shyway_drv->remove(shyway_dev);
> -}
> -
> -/**
> - * superhyway_register_driver - Register a new SuperHyway driver
> - * @drv: SuperHyway driver to register.
> - *
> - * This registers the passed in @drv. Any devices matching the id table will
> - * automatically be populated and handed off to the driver's specified probe
> - * routine.
> - */
> -int superhyway_register_driver(struct superhyway_driver *drv)
> -{
> -	drv->drv.name	= drv->name;
> -	drv->drv.bus	= &superhyway_bus_type;
> -
> -	return driver_register(&drv->drv);
> -}
> -
> -/**
> - * superhyway_unregister_driver - Unregister a SuperHyway driver
> - * @drv: SuperHyway driver to unregister.
> - *
> - * This cleans up after superhyway_register_driver(), and should be invoked in
> - * the exit path of any module drivers.
> - */
> -void superhyway_unregister_driver(struct superhyway_driver *drv)
> -{
> -	driver_unregister(&drv->drv);
> -}
> -
> -static int superhyway_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(drv);
> -	const struct superhyway_device_id *ids = shyway_drv->id_table;
> -
> -	if (!ids)
> -		return -EINVAL;
> -	if (superhyway_match_id(ids, shyway_dev))
> -		return 1;
> -
> -	return -ENODEV;
> -}
> -
> -struct bus_type superhyway_bus_type = {
> -	.name		= "superhyway",
> -	.match		= superhyway_bus_match,
> -#ifdef CONFIG_SYSFS
> -	.dev_groups	= superhyway_dev_groups,
> -#endif
> -	.probe		= superhyway_device_probe,
> -	.remove		= superhyway_device_remove,
> -};
> -
> -static int __init superhyway_bus_init(void)
> -{
> -	return bus_register(&superhyway_bus_type);
> -}
> -
> -static void __exit superhyway_bus_exit(void)
> -{
> -	device_unregister(&superhyway_bus_device);
> -	bus_unregister(&superhyway_bus_type);
> -}
> -
> -core_initcall(superhyway_bus_init);
> -module_exit(superhyway_bus_exit);
> -
> -EXPORT_SYMBOL(superhyway_bus_type);
> -EXPORT_SYMBOL(superhyway_add_device);
> -EXPORT_SYMBOL(superhyway_add_devices);
> -EXPORT_SYMBOL(superhyway_register_driver);
> -EXPORT_SYMBOL(superhyway_unregister_driver);
> -
> -MODULE_LICENSE("GPL");
> diff --git a/include/linux/superhyway.h b/include/linux/superhyway.h
> deleted file mode 100644
> index 8d3376775813d..0000000000000
> --- a/include/linux/superhyway.h
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -/*
> - * include/linux/superhyway.h
> - *
> - * SuperHyway Bus definitions
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#ifndef __LINUX_SUPERHYWAY_H
> -#define __LINUX_SUPERHYWAY_H
> -
> -#include <linux/device.h>
> -
> -/*
> - * SuperHyway IDs
> - */
> -#define SUPERHYWAY_DEVICE_ID_SH5_DMAC	0x0183
> -
> -struct superhyway_vcr_info {
> -	u8	perr_flags;	/* P-port Error flags */
> -	u8	merr_flags;	/* Module Error flags */
> -	u16	mod_vers;	/* Module Version */
> -	u16	mod_id;		/* Module ID */
> -	u8	bot_mb;		/* Bottom Memory block */
> -	u8	top_mb;		/* Top Memory block */
> -};
> -
> -struct superhyway_ops {
> -	int (*read_vcr)(unsigned long base, struct superhyway_vcr_info *vcr);
> -	int (*write_vcr)(unsigned long base, struct superhyway_vcr_info vcr);
> -};
> -
> -struct superhyway_bus {
> -	struct superhyway_ops *ops;
> -};
> -
> -extern struct superhyway_bus superhyway_channels[];
> -
> -struct superhyway_device_id {
> -	unsigned int id;
> -	unsigned long driver_data;
> -};
> -
> -struct superhyway_device;
> -extern struct bus_type superhyway_bus_type;
> -
> -struct superhyway_driver {
> -	char *name;
> -
> -	const struct superhyway_device_id *id_table;
> -	struct device_driver drv;
> -
> -	int (*probe)(struct superhyway_device *dev, const struct superhyway_device_id *id);
> -	void (*remove)(struct superhyway_device *dev);
> -};
> -
> -#define to_superhyway_driver(d)	container_of((d), struct superhyway_driver, drv)
> -
> -struct superhyway_device {
> -	char name[32];
> -
> -	struct device dev;
> -
> -	struct superhyway_device_id id;
> -	struct superhyway_driver *drv;
> -	struct superhyway_bus *bus;
> -
> -	int num_resources;
> -	struct resource *resource;
> -	struct superhyway_vcr_info vcr;
> -};
> -
> -#define to_superhyway_device(d)	container_of((d), struct superhyway_device, dev)
> -
> -#define superhyway_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
> -#define superhyway_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
> -
> -static inline int
> -superhyway_read_vcr(struct superhyway_device *dev, unsigned long base,
> -		    struct superhyway_vcr_info *vcr)
> -{
> -	return dev->bus->ops->read_vcr(base, vcr);
> -}
> -
> -static inline int
> -superhyway_write_vcr(struct superhyway_device *dev, unsigned long base,
> -		     struct superhyway_vcr_info vcr)
> -{
> -	return dev->bus->ops->write_vcr(base, vcr);
> -}
> -
> -extern int superhyway_scan_bus(struct superhyway_bus *);
> -
> -/* drivers/sh/superhyway/superhyway.c */
> -int superhyway_register_driver(struct superhyway_driver *);
> -void superhyway_unregister_driver(struct superhyway_driver *);
> -int superhyway_add_device(unsigned long base, struct superhyway_device *, struct superhyway_bus *);
> -int superhyway_add_devices(struct superhyway_bus *bus, struct superhyway_device **devices, int nr_devices);
> -
> -/* drivers/sh/superhyway/superhyway-sysfs.c */
> -extern const struct attribute_group *superhyway_dev_groups[];
> -
> -#endif /* __LINUX_SUPERHYWAY_H */
> -

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
