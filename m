Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC9798577
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbjIHKIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjIHKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:08:07 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B161BDD;
        Fri,  8 Sep 2023 03:07:50 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeYHC-000ZOB-Oi; Fri, 08 Sep 2023 11:59:46 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeYHC-001mKI-Fa; Fri, 08 Sep 2023 11:59:46 +0200
Message-ID: <e741c16ddaabf56037aff17f5f8298f084c070ee.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/4] sh: remove stale microdev board
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 08 Sep 2023 11:59:45 +0200
In-Reply-To: <20230802184849.1019466-1-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 20:48 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This board was an early prototype platform for early SH4 CPUs and related
> to the already removed SH5 cayman platform.
> 
> The microdev board itself has been kept in the tree for this long despite
> being in a bad shape even 20 years ago when it got merged, with no working
> PCI support and ugly workarounds for its I/O port implementation that
> try to emulate PC style peripheral access despite being quite different
> in reality.
> 
> As far as I can tell, the ethernet, display, USB and PCI devices on it
> already broke at some point (afbb9d8d5266b, 46bc85872040a), so I
> think we can just remove it entirely.
> 
> Link: https://lore.kernel.org/lkml/09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/Kconfig                             |   3 +-
>  arch/sh/boards/Kconfig                      |   7 -
>  arch/sh/boards/Makefile                     |   1 -
>  arch/sh/boards/mach-microdev/Makefile       |   6 -
>  arch/sh/boards/mach-microdev/fdc37c93xapm.c | 157 ----------------
>  arch/sh/boards/mach-microdev/io.c           | 123 ------------
>  arch/sh/boards/mach-microdev/irq.c          | 150 ---------------
>  arch/sh/boards/mach-microdev/setup.c        | 197 --------------------
>  arch/sh/configs/microdev_defconfig          |  42 -----
>  arch/sh/include/mach-common/mach/microdev.h |  69 -------
>  drivers/net/ethernet/smsc/smc91x.h          |  19 --
>  11 files changed, 1 insertion(+), 773 deletions(-)
>  delete mode 100644 arch/sh/boards/mach-microdev/Makefile
>  delete mode 100644 arch/sh/boards/mach-microdev/fdc37c93xapm.c
>  delete mode 100644 arch/sh/boards/mach-microdev/io.c
>  delete mode 100644 arch/sh/boards/mach-microdev/irq.c
>  delete mode 100644 arch/sh/boards/mach-microdev/setup.c
>  delete mode 100644 arch/sh/configs/microdev_defconfig
>  delete mode 100644 arch/sh/include/mach-common/mach/microdev.h
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 33530b044953c..d3df67f215ca5 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -124,8 +124,7 @@ config ARCH_HAS_ILOG2_U64
>  
>  config NO_IOPORT_MAP
>  	def_bool !PCI
> -	depends on !SH_SH4202_MICRODEV && !SH_SHMIN && !SH_HP6XX && \
> -		   !SH_SOLUTION_ENGINE
> +	depends on !SH_SHMIN && !SH_HP6XX && !SH_SOLUTION_ENGINE
>  
>  config IO_TRAPPED
>  	bool
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index fafe15d3ba1dc..109bec4dad94a 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -289,13 +289,6 @@ config SH_EDOSK7760
>  	  Select if configuring for a Renesas EDOSK7760
>  	  evaluation board.
>  
> -config SH_SH4202_MICRODEV
> -	bool "SH4-202 MicroDev"
> -	depends on CPU_SUBTYPE_SH4_202
> -	help
> -	  Select SH4-202 MicroDev if configuring for a SuperH MicroDev board
> -	  with an SH4-202 CPU.
> -
>  config SH_LANDISK
>  	bool "LANDISK"
>  	depends on CPU_SUBTYPE_SH7751R
> diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
> index b57219436ace3..fbbc350ca8542 100644
> --- a/arch/sh/boards/Makefile
> +++ b/arch/sh/boards/Makefile
> @@ -33,7 +33,6 @@ obj-$(CONFIG_SH_SDK7780)	+= mach-sdk7780/
>  obj-$(CONFIG_SH_SDK7786)	+= mach-sdk7786/
>  obj-$(CONFIG_SH_X3PROTO)	+= mach-x3proto/
>  obj-$(CONFIG_SH_SH7763RDP)	+= mach-sh7763rdp/
> -obj-$(CONFIG_SH_SH4202_MICRODEV)+= mach-microdev/
>  obj-$(CONFIG_SH_LANDISK)	+= mach-landisk/
>  obj-$(CONFIG_SH_LBOX_RE2)	+= mach-lboxre2/
>  obj-$(CONFIG_SH_RSK)		+= mach-rsk/
> diff --git a/arch/sh/boards/mach-microdev/Makefile b/arch/sh/boards/mach-microdev/Makefile
> deleted file mode 100644
> index 05c5698dcad02..0000000000000
> --- a/arch/sh/boards/mach-microdev/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for the SuperH MicroDev specific parts of the kernel
> -#
> -
> -obj-y	 := setup.o irq.o io.o fdc37c93xapm.o
> diff --git a/arch/sh/boards/mach-microdev/fdc37c93xapm.c b/arch/sh/boards/mach-microdev/fdc37c93xapm.c
> deleted file mode 100644
> index 2a04f72dd1457..0000000000000
> --- a/arch/sh/boards/mach-microdev/fdc37c93xapm.c
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Setup for the SMSC FDC37C93xAPM
> - *
> - * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
> - * Copyright (C) 2003, 2004 SuperH, Inc.
> - * Copyright (C) 2004, 2005 Paul Mundt
> - *
> - * SuperH SH4-202 MicroDev board support.
> - */
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/io.h>
> -#include <linux/err.h>
> -#include <mach/microdev.h>
> -
> -#define SMSC_CONFIG_PORT_ADDR	 (0x3F0)
> -#define SMSC_INDEX_PORT_ADDR	 SMSC_CONFIG_PORT_ADDR
> -#define SMSC_DATA_PORT_ADDR	 (SMSC_INDEX_PORT_ADDR + 1)
> -
> -#define SMSC_ENTER_CONFIG_KEY	 0x55
> -#define SMSC_EXIT_CONFIG_KEY	 0xaa
> -
> -#define SMCS_LOGICAL_DEV_INDEX	 0x07	/* Logical Device Number */
> -#define SMSC_DEVICE_ID_INDEX	 0x20	/* Device ID */
> -#define SMSC_DEVICE_REV_INDEX	 0x21	/* Device Revision */
> -#define SMSC_ACTIVATE_INDEX	 0x30	/* Activate */
> -#define SMSC_PRIMARY_BASE_INDEX	 0x60	/* Primary Base Address */
> -#define SMSC_SECONDARY_BASE_INDEX 0x62	/* Secondary Base Address */
> -#define SMSC_PRIMARY_INT_INDEX	 0x70	/* Primary Interrupt Select */
> -#define SMSC_SECONDARY_INT_INDEX 0x72	/* Secondary Interrupt Select */
> -#define SMSC_HDCS0_INDEX	 0xf0	/* HDCS0 Address Decoder */
> -#define SMSC_HDCS1_INDEX	 0xf1	/* HDCS1 Address Decoder */
> -
> -#define SMSC_IDE1_DEVICE	1	/* IDE #1 logical device */
> -#define SMSC_IDE2_DEVICE	2	/* IDE #2 logical device */
> -#define SMSC_PARALLEL_DEVICE	3	/* Parallel Port logical device */
> -#define SMSC_SERIAL1_DEVICE	4	/* Serial #1 logical device */
> -#define SMSC_SERIAL2_DEVICE	5	/* Serial #2 logical device */
> -#define SMSC_KEYBOARD_DEVICE	7	/* Keyboard logical device */
> -#define SMSC_CONFIG_REGISTERS	8	/* Configuration Registers (Aux I/O) */
> -
> -#define SMSC_READ_INDEXED(index) ({ \
> -	outb((index), SMSC_INDEX_PORT_ADDR); \
> -	inb(SMSC_DATA_PORT_ADDR); })
> -#define SMSC_WRITE_INDEXED(val, index) ({ \
> -	outb((index), SMSC_INDEX_PORT_ADDR); \
> -	outb((val),   SMSC_DATA_PORT_ADDR); })
> -
> -#define	IDE1_PRIMARY_BASE	0x01f0	/* Task File Registe base for IDE #1 */
> -#define	IDE1_SECONDARY_BASE	0x03f6	/* Miscellaneous AT registers for IDE #1 */
> -#define	IDE2_PRIMARY_BASE	0x0170	/* Task File Registe base for IDE #2 */
> -#define	IDE2_SECONDARY_BASE	0x0376	/* Miscellaneous AT registers for IDE #2 */
> -
> -#define SERIAL1_PRIMARY_BASE	0x03f8
> -#define SERIAL2_PRIMARY_BASE	0x02f8
> -
> -#define	MSB(x)		( (x) >> 8 )
> -#define	LSB(x)		( (x) & 0xff )
> -
> -	/* General-Purpose base address on CPU-board FPGA */
> -#define	MICRODEV_FPGA_GP_BASE		0xa6100000ul
> -
> -static int __init smsc_superio_setup(void)
> -{
> -
> -	unsigned char devid, devrev;
> -
> -		/* Initially the chip is in run state */
> -		/* Put it into configuration state */
> -	outb(SMSC_ENTER_CONFIG_KEY, SMSC_CONFIG_PORT_ADDR);
> -
> -		/* Read device ID info */
> -	devid  = SMSC_READ_INDEXED(SMSC_DEVICE_ID_INDEX);
> -	devrev = SMSC_READ_INDEXED(SMSC_DEVICE_REV_INDEX);
> -
> -	if ((devid == 0x30) && (devrev == 0x01))
> -		printk("SMSC FDC37C93xAPM SuperIO device detected\n");
> -	else
> -		return -ENODEV;
> -
> -		/* Select the keyboard device */
> -	SMSC_WRITE_INDEXED(SMSC_KEYBOARD_DEVICE, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable it */
> -	SMSC_WRITE_INDEXED(1, SMSC_ACTIVATE_INDEX);
> -		/* enable the interrupts */
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_KEYBOARD, SMSC_PRIMARY_INT_INDEX);
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_MOUSE, SMSC_SECONDARY_INT_INDEX);
> -
> -		/* Select the Serial #1 device */
> -	SMSC_WRITE_INDEXED(SMSC_SERIAL1_DEVICE, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable it */
> -	SMSC_WRITE_INDEXED(1, SMSC_ACTIVATE_INDEX);
> -		/* program with port addresses */
> -	SMSC_WRITE_INDEXED(MSB(SERIAL1_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(SERIAL1_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+1);
> -	SMSC_WRITE_INDEXED(0x00, SMSC_HDCS0_INDEX);
> -		/* enable the interrupts */
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_SERIAL1, SMSC_PRIMARY_INT_INDEX);
> -
> -		/* Select the Serial #2 device */
> -	SMSC_WRITE_INDEXED(SMSC_SERIAL2_DEVICE, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable it */
> -	SMSC_WRITE_INDEXED(1, SMSC_ACTIVATE_INDEX);
> -		/* program with port addresses */
> -	SMSC_WRITE_INDEXED(MSB(SERIAL2_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(SERIAL2_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+1);
> -	SMSC_WRITE_INDEXED(0x00, SMSC_HDCS0_INDEX);
> -		/* enable the interrupts */
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_SERIAL2, SMSC_PRIMARY_INT_INDEX);
> -
> -		/* Select the IDE#1 device */
> -	SMSC_WRITE_INDEXED(SMSC_IDE1_DEVICE, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable it */
> -	SMSC_WRITE_INDEXED(1, SMSC_ACTIVATE_INDEX);
> -		/* program with port addresses */
> -	SMSC_WRITE_INDEXED(MSB(IDE1_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(IDE1_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+1);
> -	SMSC_WRITE_INDEXED(MSB(IDE1_SECONDARY_BASE), SMSC_SECONDARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(IDE1_SECONDARY_BASE), SMSC_SECONDARY_BASE_INDEX+1);
> -	SMSC_WRITE_INDEXED(0x0c, SMSC_HDCS0_INDEX);
> -	SMSC_WRITE_INDEXED(0x00, SMSC_HDCS1_INDEX);
> -		/* select the interrupt */
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_IDE1, SMSC_PRIMARY_INT_INDEX);
> -
> -		/* Select the IDE#2 device */
> -	SMSC_WRITE_INDEXED(SMSC_IDE2_DEVICE, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable it */
> -	SMSC_WRITE_INDEXED(1, SMSC_ACTIVATE_INDEX);
> -		/* program with port addresses */
> -	SMSC_WRITE_INDEXED(MSB(IDE2_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(IDE2_PRIMARY_BASE), SMSC_PRIMARY_BASE_INDEX+1);
> -	SMSC_WRITE_INDEXED(MSB(IDE2_SECONDARY_BASE), SMSC_SECONDARY_BASE_INDEX+0);
> -	SMSC_WRITE_INDEXED(LSB(IDE2_SECONDARY_BASE), SMSC_SECONDARY_BASE_INDEX+1);
> -		/* select the interrupt */
> -	SMSC_WRITE_INDEXED(MICRODEV_FPGA_IRQ_IDE2, SMSC_PRIMARY_INT_INDEX);
> -
> -		/* Select the configuration registers */
> -	SMSC_WRITE_INDEXED(SMSC_CONFIG_REGISTERS, SMCS_LOGICAL_DEV_INDEX);
> -		/* enable the appropriate GPIO pins for IDE functionality:
> -		 * bit[0]   In/Out		1==input;  0==output
> -		 * bit[1]   Polarity		1==invert; 0==no invert
> -		 * bit[2]   Int Enb #1		1==Enable Combined IRQ #1; 0==disable
> -		 * bit[3:4] Function Select	00==original; 01==Alternate Function #1
> -		 */
> -	SMSC_WRITE_INDEXED(0x00, 0xc2);	/* GP42 = nIDE1_OE */
> -	SMSC_WRITE_INDEXED(0x01, 0xc5);	/* GP45 = IDE1_IRQ */
> -	SMSC_WRITE_INDEXED(0x00, 0xc6);	/* GP46 = nIOROP */
> -	SMSC_WRITE_INDEXED(0x00, 0xc7);	/* GP47 = nIOWOP */
> -	SMSC_WRITE_INDEXED(0x08, 0xe8);	/* GP20 = nIDE2_OE */
> -
> -		/* Exit the configuration state */
> -	outb(SMSC_EXIT_CONFIG_KEY, SMSC_CONFIG_PORT_ADDR);
> -
> -	return 0;
> -}
> -device_initcall(smsc_superio_setup);
> diff --git a/arch/sh/boards/mach-microdev/io.c b/arch/sh/boards/mach-microdev/io.c
> deleted file mode 100644
> index a76c12721e63d..0000000000000
> --- a/arch/sh/boards/mach-microdev/io.c
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * linux/arch/sh/boards/superh/microdev/io.c
> - *
> - * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
> - * Copyright (C) 2003, 2004 SuperH, Inc.
> - * Copyright (C) 2004 Paul Mundt
> - *
> - * SuperH SH4-202 MicroDev board support.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/wait.h>
> -#include <asm/io.h>
> -#include <mach/microdev.h>
> -
> -	/*
> -	 *	we need to have a 'safe' address to re-direct all I/O requests
> -	 *	that we do not explicitly wish to handle. This safe address
> -	 *	must have the following properies:
> -	 *
> -	 *		* writes are ignored (no exception)
> -	 *		* reads are benign (no side-effects)
> -	 *		* accesses of width 1, 2 and 4-bytes are all valid.
> -	 *
> -	 *	The Processor Version Register (PVR) has these properties.
> -	 */
> -#define	PVR	0xff000030	/* Processor Version Register */
> -
> -
> -#define	IO_IDE2_BASE		0x170ul	/* I/O base for SMSC FDC37C93xAPM IDE #2 */
> -#define	IO_IDE1_BASE		0x1f0ul	/* I/O base for SMSC FDC37C93xAPM IDE #1 */
> -#define IO_ISP1161_BASE		0x290ul /* I/O port for Philips ISP1161x USB chip */
> -#define IO_SERIAL2_BASE		0x2f8ul /* I/O base for SMSC FDC37C93xAPM Serial #2 */
> -#define	IO_LAN91C111_BASE	0x300ul	/* I/O base for SMSC LAN91C111 Ethernet chip */
> -#define	IO_IDE2_MISC		0x376ul	/* I/O misc for SMSC FDC37C93xAPM IDE #2 */
> -#define IO_SUPERIO_BASE		0x3f0ul /* I/O base for SMSC FDC37C93xAPM SuperIO chip */
> -#define	IO_IDE1_MISC		0x3f6ul	/* I/O misc for SMSC FDC37C93xAPM IDE #1 */
> -#define IO_SERIAL1_BASE		0x3f8ul /* I/O base for SMSC FDC37C93xAPM Serial #1 */
> -
> -#define	IO_ISP1161_EXTENT	0x04ul	/* I/O extent for Philips ISP1161x USB chip */
> -#define	IO_LAN91C111_EXTENT	0x10ul	/* I/O extent for SMSC LAN91C111 Ethernet chip */
> -#define	IO_SUPERIO_EXTENT	0x02ul	/* I/O extent for SMSC FDC37C93xAPM SuperIO chip */
> -#define	IO_IDE_EXTENT		0x08ul	/* I/O extent for IDE Task Register set */
> -#define IO_SERIAL_EXTENT	0x10ul
> -
> -#define	IO_LAN91C111_PHYS	0xa7500000ul	/* Physical address of SMSC LAN91C111 Ethernet chip */
> -#define	IO_ISP1161_PHYS		0xa7700000ul	/* Physical address of Philips ISP1161x USB chip */
> -#define	IO_SUPERIO_PHYS		0xa7800000ul	/* Physical address of SMSC FDC37C93xAPM SuperIO chip */
> -
> -/*
> - * map I/O ports to memory-mapped addresses
> - */
> -void __iomem *microdev_ioport_map(unsigned long offset, unsigned int len)
> -{
> -	unsigned long result;
> -
> -	if ((offset >= IO_LAN91C111_BASE) &&
> -	    (offset <  IO_LAN91C111_BASE + IO_LAN91C111_EXTENT)) {
> -			/*
> -			 *	SMSC LAN91C111 Ethernet chip
> -			 */
> -		result = IO_LAN91C111_PHYS + offset - IO_LAN91C111_BASE;
> -	} else if ((offset >= IO_SUPERIO_BASE) &&
> -		   (offset <  IO_SUPERIO_BASE + IO_SUPERIO_EXTENT)) {
> -			/*
> -			 *	SMSC FDC37C93xAPM SuperIO chip
> -			 *
> -			 *	Configuration Registers
> -			 */
> -		result = IO_SUPERIO_PHYS + (offset << 1);
> -	} else if (((offset >= IO_IDE1_BASE) &&
> -		    (offset <  IO_IDE1_BASE + IO_IDE_EXTENT)) ||
> -		    (offset == IO_IDE1_MISC)) {
> -			/*
> -			 *	SMSC FDC37C93xAPM SuperIO chip
> -			 *
> -			 *	IDE #1
> -			 */
> -	        result = IO_SUPERIO_PHYS + (offset << 1);
> -	} else if (((offset >= IO_IDE2_BASE) &&
> -		    (offset <  IO_IDE2_BASE + IO_IDE_EXTENT)) ||
> -		    (offset == IO_IDE2_MISC)) {
> -			/*
> -			 *	SMSC FDC37C93xAPM SuperIO chip
> -			 *
> -			 *	IDE #2
> -			 */
> -	        result = IO_SUPERIO_PHYS + (offset << 1);
> -	} else if ((offset >= IO_SERIAL1_BASE) &&
> -		   (offset <  IO_SERIAL1_BASE + IO_SERIAL_EXTENT)) {
> -			/*
> -			 *	SMSC FDC37C93xAPM SuperIO chip
> -			 *
> -			 *	Serial #1
> -			 */
> -		result = IO_SUPERIO_PHYS + (offset << 1);
> -	} else if ((offset >= IO_SERIAL2_BASE) &&
> -		   (offset <  IO_SERIAL2_BASE + IO_SERIAL_EXTENT)) {
> -			/*
> -			 *	SMSC FDC37C93xAPM SuperIO chip
> -			 *
> -			 *	Serial #2
> -			 */
> -		result = IO_SUPERIO_PHYS + (offset << 1);
> -	} else if ((offset >= IO_ISP1161_BASE) &&
> -		   (offset < IO_ISP1161_BASE + IO_ISP1161_EXTENT)) {
> -			/*
> -			 *	Philips USB ISP1161x chip
> -			 */
> -		result = IO_ISP1161_PHYS + offset - IO_ISP1161_BASE;
> -	} else {
> -			/*
> -			 *	safe default.
> -			 */
> -		printk("Warning: unexpected port in %s( offset = 0x%lx )\n",
> -		       __func__, offset);
> -		result = PVR;
> -	}
> -
> -	return (void __iomem *)result;
> -}
> diff --git a/arch/sh/boards/mach-microdev/irq.c b/arch/sh/boards/mach-microdev/irq.c
> deleted file mode 100644
> index dc27492c83d76..0000000000000
> --- a/arch/sh/boards/mach-microdev/irq.c
> +++ /dev/null
> @@ -1,150 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/boards/superh/microdev/irq.c
> - *
> - * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
> - *
> - * SuperH SH4-202 MicroDev board support.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/interrupt.h>
> -#include <asm/io.h>
> -#include <mach/microdev.h>
> -
> -#define NUM_EXTERNAL_IRQS 16	/* IRL0 .. IRL15 */
> -
> -static const struct {
> -	unsigned char fpgaIrq;
> -	unsigned char mapped;
> -	const char *name;
> -} fpgaIrqTable[NUM_EXTERNAL_IRQS] = {
> -	{ 0,				0,	"unused"   },		/* IRQ #0	IRL=15	0x200  */
> -	{ MICRODEV_FPGA_IRQ_KEYBOARD,	1,	"keyboard" },		/* IRQ #1	IRL=14	0x220  */
> -	{ MICRODEV_FPGA_IRQ_SERIAL1,	1,	"Serial #1"},		/* IRQ #2	IRL=13	0x240  */
> -	{ MICRODEV_FPGA_IRQ_ETHERNET,	1,	"Ethernet" },		/* IRQ #3	IRL=12	0x260  */
> -	{ MICRODEV_FPGA_IRQ_SERIAL2,	0,	"Serial #2"},		/* IRQ #4	IRL=11	0x280  */
> -	{ 0,				0,	"unused"   },		/* IRQ #5	IRL=10	0x2a0  */
> -	{ 0,				0,	"unused"   },		/* IRQ #6	IRL=9	0x2c0  */
> -	{ MICRODEV_FPGA_IRQ_USB_HC,	1,	"USB"	   },		/* IRQ #7	IRL=8	0x2e0  */
> -	{ MICRODEV_IRQ_PCI_INTA,	1,	"PCI INTA" },		/* IRQ #8	IRL=7	0x300  */
> -	{ MICRODEV_IRQ_PCI_INTB,	1,	"PCI INTB" },		/* IRQ #9	IRL=6	0x320  */
> -	{ MICRODEV_IRQ_PCI_INTC,	1,	"PCI INTC" },		/* IRQ #10	IRL=5	0x340  */
> -	{ MICRODEV_IRQ_PCI_INTD,	1,	"PCI INTD" },		/* IRQ #11	IRL=4	0x360  */
> -	{ MICRODEV_FPGA_IRQ_MOUSE,	1,	"mouse"    },		/* IRQ #12	IRL=3	0x380  */
> -	{ MICRODEV_FPGA_IRQ_IDE2,	1,	"IDE #2"   },		/* IRQ #13	IRL=2	0x3a0  */
> -	{ MICRODEV_FPGA_IRQ_IDE1,	1,	"IDE #1"   },		/* IRQ #14	IRL=1	0x3c0  */
> -	{ 0,				0,	"unused"   },		/* IRQ #15	IRL=0	0x3e0  */
> -};
> -
> -#if (MICRODEV_LINUX_IRQ_KEYBOARD != 1)
> -#  error Inconsistancy in defining the IRQ# for Keyboard!
> -#endif
> -
> -#if (MICRODEV_LINUX_IRQ_ETHERNET != 3)
> -#  error Inconsistancy in defining the IRQ# for Ethernet!
> -#endif
> -
> -#if (MICRODEV_LINUX_IRQ_USB_HC != 7)
> -#  error Inconsistancy in defining the IRQ# for USB!
> -#endif
> -
> -#if (MICRODEV_LINUX_IRQ_MOUSE != 12)
> -#  error Inconsistancy in defining the IRQ# for PS/2 Mouse!
> -#endif
> -
> -#if (MICRODEV_LINUX_IRQ_IDE2 != 13)
> -#  error Inconsistancy in defining the IRQ# for secondary IDE!
> -#endif
> -
> -#if (MICRODEV_LINUX_IRQ_IDE1 != 14)
> -#  error Inconsistancy in defining the IRQ# for primary IDE!
> -#endif
> -
> -static void disable_microdev_irq(struct irq_data *data)
> -{
> -	unsigned int irq = data->irq;
> -	unsigned int fpgaIrq;
> -
> -	if (irq >= NUM_EXTERNAL_IRQS)
> -		return;
> -	if (!fpgaIrqTable[irq].mapped)
> -		return;
> -
> -	fpgaIrq = fpgaIrqTable[irq].fpgaIrq;
> -
> -	/* disable interrupts on the FPGA INTC register */
> -	__raw_writel(MICRODEV_FPGA_INTC_MASK(fpgaIrq), MICRODEV_FPGA_INTDSB_REG);
> -}
> -
> -static void enable_microdev_irq(struct irq_data *data)
> -{
> -	unsigned int irq = data->irq;
> -	unsigned long priorityReg, priorities, pri;
> -	unsigned int fpgaIrq;
> -
> -	if (unlikely(irq >= NUM_EXTERNAL_IRQS))
> -		return;
> -	if (unlikely(!fpgaIrqTable[irq].mapped))
> -		return;
> -
> -	pri = 15 - irq;
> -
> -	fpgaIrq = fpgaIrqTable[irq].fpgaIrq;
> -	priorityReg = MICRODEV_FPGA_INTPRI_REG(fpgaIrq);
> -
> -	/* set priority for the interrupt */
> -	priorities = __raw_readl(priorityReg);
> -	priorities &= ~MICRODEV_FPGA_INTPRI_MASK(fpgaIrq);
> -	priorities |= MICRODEV_FPGA_INTPRI_LEVEL(fpgaIrq, pri);
> -	__raw_writel(priorities, priorityReg);
> -
> -	/* enable interrupts on the FPGA INTC register */
> -	__raw_writel(MICRODEV_FPGA_INTC_MASK(fpgaIrq), MICRODEV_FPGA_INTENB_REG);
> -}
> -
> -static struct irq_chip microdev_irq_type = {
> -	.name = "MicroDev-IRQ",
> -	.irq_unmask = enable_microdev_irq,
> -	.irq_mask = disable_microdev_irq,
> -};
> -
> -/* This function sets the desired irq handler to be a MicroDev type */
> -static void __init make_microdev_irq(unsigned int irq)
> -{
> -	disable_irq_nosync(irq);
> -	irq_set_chip_and_handler(irq, &microdev_irq_type, handle_level_irq);
> -	disable_microdev_irq(irq_get_irq_data(irq));
> -}
> -
> -extern void __init init_microdev_irq(void)
> -{
> -	int i;
> -
> -	/* disable interrupts on the FPGA INTC register */
> -	__raw_writel(~0ul, MICRODEV_FPGA_INTDSB_REG);
> -
> -	for (i = 0; i < NUM_EXTERNAL_IRQS; i++)
> -		make_microdev_irq(i);
> -}
> -
> -extern void microdev_print_fpga_intc_status(void)
> -{
> -	volatile unsigned int * const intenb = (unsigned int*)MICRODEV_FPGA_INTENB_REG;
> -	volatile unsigned int * const intdsb = (unsigned int*)MICRODEV_FPGA_INTDSB_REG;
> -	volatile unsigned int * const intpria = (unsigned int*)MICRODEV_FPGA_INTPRI_REG(0);
> -	volatile unsigned int * const intprib = (unsigned int*)MICRODEV_FPGA_INTPRI_REG(8);
> -	volatile unsigned int * const intpric = (unsigned int*)MICRODEV_FPGA_INTPRI_REG(16);
> -	volatile unsigned int * const intprid = (unsigned int*)MICRODEV_FPGA_INTPRI_REG(24);
> -	volatile unsigned int * const intsrc = (unsigned int*)MICRODEV_FPGA_INTSRC_REG;
> -	volatile unsigned int * const intreq = (unsigned int*)MICRODEV_FPGA_INTREQ_REG;
> -
> -	printk("-------------------------- microdev_print_fpga_intc_status() ------------------\n");
> -	printk("FPGA_INTENB = 0x%08x\n", *intenb);
> -	printk("FPGA_INTDSB = 0x%08x\n", *intdsb);
> -	printk("FPGA_INTSRC = 0x%08x\n", *intsrc);
> -	printk("FPGA_INTREQ = 0x%08x\n", *intreq);
> -	printk("FPGA_INTPRI[3..0] = %08x:%08x:%08x:%08x\n", *intprid, *intpric, *intprib, *intpria);
> -	printk("-------------------------------------------------------------------------------\n");
> -}
> diff --git a/arch/sh/boards/mach-microdev/setup.c b/arch/sh/boards/mach-microdev/setup.c
> deleted file mode 100644
> index ee55eb2b4d791..0000000000000
> --- a/arch/sh/boards/mach-microdev/setup.c
> +++ /dev/null
> @@ -1,197 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/boards/superh/microdev/setup.c
> - *
> - * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
> - * Copyright (C) 2003, 2004 SuperH, Inc.
> - * Copyright (C) 2004, 2005 Paul Mundt
> - *
> - * SuperH SH4-202 MicroDev board support.
> - */
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/ioport.h>
> -#include <video/s1d13xxxfb.h>
> -#include <mach/microdev.h>
> -#include <asm/io.h>
> -#include <asm/machvec.h>
> -#include <linux/sizes.h>
> -
> -static struct resource smc91x_resources[] = {
> -	[0] = {
> -		.start		= 0x300,
> -		.end		= 0x300 + SZ_4K - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start		= MICRODEV_LINUX_IRQ_ETHERNET,
> -		.end		= MICRODEV_LINUX_IRQ_ETHERNET,
> -		.flags		= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct platform_device smc91x_device = {
> -	.name		= "smc91x",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(smc91x_resources),
> -	.resource	= smc91x_resources,
> -};
> -
> -static struct s1d13xxxfb_regval s1d13806_initregs[] = {
> -	{ S1DREG_MISC,			0x00 },
> -	{ S1DREG_COM_DISP_MODE,		0x00 },
> -	{ S1DREG_GPIO_CNF0,		0x00 },
> -	{ S1DREG_GPIO_CNF1,		0x00 },
> -	{ S1DREG_GPIO_CTL0,		0x00 },
> -	{ S1DREG_GPIO_CTL1,		0x00 },
> -	{ S1DREG_CLK_CNF,		0x02 },
> -	{ S1DREG_LCD_CLK_CNF,		0x01 },
> -	{ S1DREG_CRT_CLK_CNF,		0x03 },
> -	{ S1DREG_MPLUG_CLK_CNF,		0x03 },
> -	{ S1DREG_CPU2MEM_WST_SEL,	0x02 },
> -	{ S1DREG_SDRAM_REF_RATE,	0x03 },
> -	{ S1DREG_SDRAM_TC0,		0x00 },
> -	{ S1DREG_SDRAM_TC1,		0x01 },
> -	{ S1DREG_MEM_CNF,		0x80 },
> -	{ S1DREG_PANEL_TYPE,		0x25 },
> -	{ S1DREG_MOD_RATE,		0x00 },
> -	{ S1DREG_LCD_DISP_HWIDTH,	0x63 },
> -	{ S1DREG_LCD_NDISP_HPER,	0x1e },
> -	{ S1DREG_TFT_FPLINE_START,	0x06 },
> -	{ S1DREG_TFT_FPLINE_PWIDTH,	0x03 },
> -	{ S1DREG_LCD_DISP_VHEIGHT0,	0x57 },
> -	{ S1DREG_LCD_DISP_VHEIGHT1,	0x02 },
> -	{ S1DREG_LCD_NDISP_VPER,	0x00 },
> -	{ S1DREG_TFT_FPFRAME_START,	0x0a },
> -	{ S1DREG_TFT_FPFRAME_PWIDTH,	0x81 },
> -	{ S1DREG_LCD_DISP_MODE,		0x03 },
> -	{ S1DREG_LCD_MISC,		0x00 },
> -	{ S1DREG_LCD_DISP_START0,	0x00 },
> -	{ S1DREG_LCD_DISP_START1,	0x00 },
> -	{ S1DREG_LCD_DISP_START2,	0x00 },
> -	{ S1DREG_LCD_MEM_OFF0,		0x90 },
> -	{ S1DREG_LCD_MEM_OFF1,		0x01 },
> -	{ S1DREG_LCD_PIX_PAN,		0x00 },
> -	{ S1DREG_LCD_DISP_FIFO_HTC,	0x00 },
> -	{ S1DREG_LCD_DISP_FIFO_LTC,	0x00 },
> -	{ S1DREG_CRT_DISP_HWIDTH,	0x63 },
> -	{ S1DREG_CRT_NDISP_HPER,	0x1f },
> -	{ S1DREG_CRT_HRTC_START,	0x04 },
> -	{ S1DREG_CRT_HRTC_PWIDTH,	0x8f },
> -	{ S1DREG_CRT_DISP_VHEIGHT0,	0x57 },
> -	{ S1DREG_CRT_DISP_VHEIGHT1,	0x02 },
> -	{ S1DREG_CRT_NDISP_VPER,	0x1b },
> -	{ S1DREG_CRT_VRTC_START,	0x00 },
> -	{ S1DREG_CRT_VRTC_PWIDTH,	0x83 },
> -	{ S1DREG_TV_OUT_CTL,		0x10 },
> -	{ S1DREG_CRT_DISP_MODE,		0x05 },
> -	{ S1DREG_CRT_DISP_START0,	0x00 },
> -	{ S1DREG_CRT_DISP_START1,	0x00 },
> -	{ S1DREG_CRT_DISP_START2,	0x00 },
> -	{ S1DREG_CRT_MEM_OFF0,		0x20 },
> -	{ S1DREG_CRT_MEM_OFF1,		0x03 },
> -	{ S1DREG_CRT_PIX_PAN,		0x00 },
> -	{ S1DREG_CRT_DISP_FIFO_HTC,	0x00 },
> -	{ S1DREG_CRT_DISP_FIFO_LTC,	0x00 },
> -	{ S1DREG_LCD_CUR_CTL,		0x00 },
> -	{ S1DREG_LCD_CUR_START,		0x01 },
> -	{ S1DREG_LCD_CUR_XPOS0,		0x00 },
> -	{ S1DREG_LCD_CUR_XPOS1,		0x00 },
> -	{ S1DREG_LCD_CUR_YPOS0,		0x00 },
> -	{ S1DREG_LCD_CUR_YPOS1,		0x00 },
> -	{ S1DREG_LCD_CUR_BCTL0,		0x00 },
> -	{ S1DREG_LCD_CUR_GCTL0,		0x00 },
> -	{ S1DREG_LCD_CUR_RCTL0,		0x00 },
> -	{ S1DREG_LCD_CUR_BCTL1,		0x1f },
> -	{ S1DREG_LCD_CUR_GCTL1,		0x3f },
> -	{ S1DREG_LCD_CUR_RCTL1,		0x1f },
> -	{ S1DREG_LCD_CUR_FIFO_HTC,	0x00 },
> -	{ S1DREG_CRT_CUR_CTL,		0x00 },
> -	{ S1DREG_CRT_CUR_START,		0x01 },
> -	{ S1DREG_CRT_CUR_XPOS0,		0x00 },
> -	{ S1DREG_CRT_CUR_XPOS1,		0x00 },
> -	{ S1DREG_CRT_CUR_YPOS0,		0x00 },
> -	{ S1DREG_CRT_CUR_YPOS1,		0x00 },
> -	{ S1DREG_CRT_CUR_BCTL0,		0x00 },
> -	{ S1DREG_CRT_CUR_GCTL0,		0x00 },
> -	{ S1DREG_CRT_CUR_RCTL0,		0x00 },
> -	{ S1DREG_CRT_CUR_BCTL1,		0x1f },
> -	{ S1DREG_CRT_CUR_GCTL1,		0x3f },
> -	{ S1DREG_CRT_CUR_RCTL1,		0x1f },
> -	{ S1DREG_CRT_CUR_FIFO_HTC,	0x00 },
> -	{ S1DREG_BBLT_CTL0,		0x00 },
> -	{ S1DREG_BBLT_CTL1,		0x00 },
> -	{ S1DREG_BBLT_CC_EXP,		0x00 },
> -	{ S1DREG_BBLT_OP,		0x00 },
> -	{ S1DREG_BBLT_SRC_START0,	0x00 },
> -	{ S1DREG_BBLT_SRC_START1,	0x00 },
> -	{ S1DREG_BBLT_SRC_START2,	0x00 },
> -	{ S1DREG_BBLT_DST_START0,	0x00 },
> -	{ S1DREG_BBLT_DST_START1,	0x00 },
> -	{ S1DREG_BBLT_DST_START2,	0x00 },
> -	{ S1DREG_BBLT_MEM_OFF0,		0x00 },
> -	{ S1DREG_BBLT_MEM_OFF1,		0x00 },
> -	{ S1DREG_BBLT_WIDTH0,		0x00 },
> -	{ S1DREG_BBLT_WIDTH1,		0x00 },
> -	{ S1DREG_BBLT_HEIGHT0,		0x00 },
> -	{ S1DREG_BBLT_HEIGHT1,		0x00 },
> -	{ S1DREG_BBLT_BGC0,		0x00 },
> -	{ S1DREG_BBLT_BGC1,		0x00 },
> -	{ S1DREG_BBLT_FGC0,		0x00 },
> -	{ S1DREG_BBLT_FGC1,		0x00 },
> -	{ S1DREG_LKUP_MODE,		0x00 },
> -	{ S1DREG_LKUP_ADDR,		0x00 },
> -	{ S1DREG_PS_CNF,		0x10 },
> -	{ S1DREG_PS_STATUS,		0x00 },
> -	{ S1DREG_CPU2MEM_WDOGT,		0x00 },
> -	{ S1DREG_COM_DISP_MODE,		0x02 },
> -};
> -
> -static struct s1d13xxxfb_platform_data s1d13806_platform_data = {
> -	.initregs	= s1d13806_initregs,
> -	.initregssize	= ARRAY_SIZE(s1d13806_initregs),
> -};
> -
> -static struct resource s1d13806_resources[] = {
> -	[0] = {
> -		.start		= 0x07200000,
> -		.end		= 0x07200000 + SZ_2M - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start		= 0x07000000,
> -		.end		= 0x07000000 + SZ_2M - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct platform_device s1d13806_device = {
> -	.name		= "s1d13806fb",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(s1d13806_resources),
> -	.resource	= s1d13806_resources,
> -
> -	.dev = {
> -		.platform_data	= &s1d13806_platform_data,
> -	},
> -};
> -
> -static struct platform_device *microdev_devices[] __initdata = {
> -	&smc91x_device,
> -	&s1d13806_device,
> -};
> -
> -static int __init microdev_devices_setup(void)
> -{
> -	return platform_add_devices(microdev_devices, ARRAY_SIZE(microdev_devices));
> -}
> -device_initcall(microdev_devices_setup);
> -
> -/*
> - * The Machine Vector
> - */
> -static struct sh_machine_vector mv_sh4202_microdev __initmv = {
> -	.mv_name		= "SH4-202 MicroDev",
> -	.mv_ioport_map		= microdev_ioport_map,
> -	.mv_init_irq		= init_microdev_irq,
> -};
> diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
> deleted file mode 100644
> index 39a83d832cac6..0000000000000
> --- a/arch/sh/configs/microdev_defconfig
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -CONFIG_BSD_PROCESS_ACCT=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_CPU_SUBTYPE_SH4_202=y
> -CONFIG_FLATMEM_MANUAL=y
> -CONFIG_SH_SH4202_MICRODEV=y
> -CONFIG_SH_DMA=y
> -CONFIG_SH_DMA_API=y
> -CONFIG_HEARTBEAT=y
> -CONFIG_PREEMPT=y
> -CONFIG_CMDLINE_OVERWRITE=y
> -CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/hda1"
> -CONFIG_SUPERHYWAY=y
> -CONFIG_NET=y
> -CONFIG_INET=y
> -CONFIG_IP_PNP=y
> -# CONFIG_IPV6 is not set
> -# CONFIG_FW_LOADER is not set
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_NETDEVICES=y
> -CONFIG_NET_ETHERNET=y
> -CONFIG_SMC91X=y
> -# CONFIG_INPUT is not set
> -# CONFIG_SERIO is not set
> -# CONFIG_VT is not set
> -CONFIG_SERIAL_SH_SCI=y
> -CONFIG_SERIAL_SH_SCI_CONSOLE=y
> -CONFIG_EXT2_FS=y
> -CONFIG_EXT3_FS=y
> -# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> -CONFIG_VFAT_FS=y
> -CONFIG_PROC_KCORE=y
> -CONFIG_TMPFS=y
> -CONFIG_HUGETLBFS=y
> -CONFIG_NFS_FS=y
> -CONFIG_NFS_V3=y
> -CONFIG_NFS_V4=y
> -CONFIG_ROOT_NFS=y
> -CONFIG_CRYPTO_ECB=y
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
> diff --git a/arch/sh/include/mach-common/mach/microdev.h b/arch/sh/include/mach-common/mach/microdev.h
> deleted file mode 100644
> index 0e2f9ab119762..0000000000000
> --- a/arch/sh/include/mach-common/mach/microdev.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0
> - *
> - * linux/include/asm-sh/microdev.h
> - *
> - * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
> - *
> - * Definitions for the SuperH SH4-202 MicroDev board.
> - */
> -#ifndef __ASM_SH_MICRODEV_H
> -#define __ASM_SH_MICRODEV_H
> -
> -extern void init_microdev_irq(void);
> -extern void microdev_print_fpga_intc_status(void);
> -
> -/*
> - * The following are useful macros for manipulating the interrupt
> - * controller (INTC) on the CPU-board FPGA.  should be noted that there
> - * is an INTC on the FPGA, and a separate INTC on the SH4-202 core -
> - * these are two different things, both of which need to be prorammed to
> - * correctly route - unfortunately, they have the same name and
> - * abbreviations!
> - */
> -#define	MICRODEV_FPGA_INTC_BASE		0xa6110000ul				/* INTC base address on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTENB_REG	(MICRODEV_FPGA_INTC_BASE+0ul)		/* Interrupt Enable Register on INTC on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTDSB_REG	(MICRODEV_FPGA_INTC_BASE+8ul)		/* Interrupt Disable Register on INTC on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTC_MASK(n)	(1ul<<(n))				/* Interrupt mask to enable/disable INTC in CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTPRI_REG(n)	(MICRODEV_FPGA_INTC_BASE+0x10+((n)/8)*8)/* Interrupt Priority Register on INTC on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTPRI_LEVEL(n,x)	((x)<<(((n)%8)*4))			/* MICRODEV_FPGA_INTPRI_LEVEL(int_number, int_level) */
> -#define	MICRODEV_FPGA_INTPRI_MASK(n)	(MICRODEV_FPGA_INTPRI_LEVEL((n),0xful))	/* Interrupt Priority Mask on INTC on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTSRC_REG	(MICRODEV_FPGA_INTC_BASE+0x30ul)	/* Interrupt Source Register on INTC on CPU-board FPGA */
> -#define	MICRODEV_FPGA_INTREQ_REG	(MICRODEV_FPGA_INTC_BASE+0x38ul)	/* Interrupt Request Register on INTC on CPU-board FPGA */
> -
> -
> -/*
> - * The following are the IRQ numbers for the Linux Kernel for external
> - * interrupts.  i.e. the numbers seen by 'cat /proc/interrupt'.
> - */
> -#define MICRODEV_LINUX_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
> -#define MICRODEV_LINUX_IRQ_SERIAL1	 2	/* SuperIO Serial #1 */
> -#define MICRODEV_LINUX_IRQ_ETHERNET	 3	/* on-board Ethnernet */
> -#define MICRODEV_LINUX_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
> -#define MICRODEV_LINUX_IRQ_USB_HC	 7	/* on-board USB HC */
> -#define MICRODEV_LINUX_IRQ_MOUSE	12	/* SuperIO PS/2 Mouse */
> -#define MICRODEV_LINUX_IRQ_IDE2		13	/* SuperIO IDE #2 */
> -#define MICRODEV_LINUX_IRQ_IDE1		14	/* SuperIO IDE #1 */
> -
> -/*
> - * The following are the IRQ numbers for the INTC on the FPGA for
> - * external interrupts.  i.e. the bits in the INTC registers in the
> - * FPGA.
> - */
> -#define MICRODEV_FPGA_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
> -#define MICRODEV_FPGA_IRQ_SERIAL1	 3	/* SuperIO Serial #1 */
> -#define MICRODEV_FPGA_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
> -#define MICRODEV_FPGA_IRQ_MOUSE		12	/* SuperIO PS/2 Mouse */
> -#define MICRODEV_FPGA_IRQ_IDE1		14	/* SuperIO IDE #1 */
> -#define MICRODEV_FPGA_IRQ_IDE2		15	/* SuperIO IDE #2 */
> -#define MICRODEV_FPGA_IRQ_USB_HC	16	/* on-board USB HC */
> -#define MICRODEV_FPGA_IRQ_ETHERNET	18	/* on-board Ethnernet */
> -
> -#define MICRODEV_IRQ_PCI_INTA		 8
> -#define MICRODEV_IRQ_PCI_INTB		 9
> -#define MICRODEV_IRQ_PCI_INTC		10
> -#define MICRODEV_IRQ_PCI_INTD		11
> -
> -#define __IO_PREFIX microdev
> -#include <asm/io_generic.h>
> -
> -#endif /* __ASM_SH_MICRODEV_H */
> diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
> index 79431ea0ce934..6c933ff974343 100644
> --- a/drivers/net/ethernet/smsc/smc91x.h
> +++ b/drivers/net/ethernet/smsc/smc91x.h
> @@ -114,25 +114,6 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
>  			 (lp)->cfg.pxa_u16_align4)
>  
>  
> -#elif	defined(CONFIG_SH_SH4202_MICRODEV)
> -
> -#define SMC_CAN_USE_8BIT	0
> -#define SMC_CAN_USE_16BIT	1
> -#define SMC_CAN_USE_32BIT	0
> -
> -#define SMC_inb(a, r)		inb((a) + (r) - 0xa0000000)
> -#define SMC_inw(a, r)		inw((a) + (r) - 0xa0000000)
> -#define SMC_inl(a, r)		inl((a) + (r) - 0xa0000000)
> -#define SMC_outb(v, a, r)	outb(v, (a) + (r) - 0xa0000000)
> -#define SMC_outw(lp, v, a, r)	outw(v, (a) + (r) - 0xa0000000)
> -#define SMC_outl(v, a, r)	outl(v, (a) + (r) - 0xa0000000)
> -#define SMC_insl(a, r, p, l)	insl((a) + (r) - 0xa0000000, p, l)
> -#define SMC_outsl(a, r, p, l)	outsl((a) + (r) - 0xa0000000, p, l)
> -#define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
> -#define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
> -
> -#define SMC_IRQ_FLAGS		(0)
> -
>  #elif defined(CONFIG_ATARI)
>  
>  #define SMC_CAN_USE_8BIT        1

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
