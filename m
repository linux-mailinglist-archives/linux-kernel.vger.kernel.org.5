Return-Path: <linux-kernel+bounces-30984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B34832719
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF65A28523C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D954F3C471;
	Fri, 19 Jan 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="IdJnNEEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qc1+2loE"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031F3C063;
	Fri, 19 Jan 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658197; cv=none; b=QGt2b63YTWsJyvsmS9Jro16BWWnEOAJkBhtUFoEH1pIivAqJRulbNRrc7RzuAXS3b7JDmeRh7vzOeauwJbGoR1PjprmhyFFM+NDWQxmA107fBr8wcuQauG3MWQDQY0MR2HXpuo1s5DZHkN56rQ0MyjECTk9WOQ0ie6SgIkXHlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658197; c=relaxed/simple;
	bh=YpgWL0g58553EApQrrSgdKF5e0FnD3RArSLD6nWClCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st38bE3wD8hFN2b67zHbGQl6T4ObLazBfUpwXDsypDnyuI8jx6zSpU2kISA6jKnzXJ8etgzPzN1H1+lC8l+F/9RrM2mwb7GQ5YOsjlFm92WpwJHRtEzOnK8S4xGYd6kZQl3PEEWqb4tw5iznZPJN2szmBZhaSSx4KVRzCVuC5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=IdJnNEEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qc1+2loE; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4FCC85C01BB;
	Fri, 19 Jan 2024 04:56:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Jan 2024 04:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1705658194;
	 x=1705744594; bh=00gLrxJ8+js/sxezIi/9rpR+lF95biOp44/Jx7OnTYw=; b=
	IdJnNEEpzH53I7lFSSW5Vy3XD8AwK6umI4wWlhMnyZEYE/5mgQO8R3pwgpIwYnZn
	I/1n9xTlB3XTILNmU9c16DcG7Z/uuCg5+4xd1f3UMXs7E0G4UEFIpJAo+rGH7/KZ
	KW4xB75wkCTp7VReUQruhdMaj9C7teuWmymsbm6RLIiyGqlr+gt+vTwUr7L/QXM8
	G7IxP1T/p2xs/INFSq7+Fg7sLoB90ylbjXrQtuFMLaGljQ0BlL7YmQ/iyztlEJ4t
	57+0qsc6jiXncjOKXyc52VMrDCWGOuvsl9VIDtpVz1P/9oD9XdSKV/2zvRRETLxF
	MXOzgJZtAFHptWVouRtAtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705658194; x=
	1705744594; bh=00gLrxJ8+js/sxezIi/9rpR+lF95biOp44/Jx7OnTYw=; b=q
	c1+2loEk1Kpj1T2hpZc2IzchsUfUn/Tv2W3nIg6EG1cDlBNnoVazC8z4xFJkCIzg
	DbGkdGEOupvBjwlZB5HztIhEETjzuoxSJXHaQtuVtZeokXV8NMpXsFu5Qo+GwQHC
	egZQDb/hFC8tJ6M5JrhwzwbvM3utCGdIbCxNHranB1VSiEPdgLgF8fHFHVYW5/Tu
	n45yS7NTRGuKxwnmPlLZPl3P/nntWr7e6cx6v7XjmdDS/8tjIs8OYvP0GZ+F4T6u
	SRYS88aKPnVzjqHEMqxOnwizpycx2rgFpKRCqJWhGLlsw8Fx9tcfJBhSMrcI8l4C
	roREnD6QCAl5cn2LCRRrw==
X-ME-Sender: <xms:UUeqZfqlV2w-QEqYc-DeX8ZVX3gQt8s-hEv3y0DaH9-Q7Jh-28P1EA>
    <xme:UUeqZZpj3vZaOaKzl_GoN_En2vBh9E7r68Omej8gkXe7C2q11gOmwR35RK_ToFVcH
    GSo6v5WiesKC5fLdqk>
X-ME-Received: <xmr:UUeqZcMchT_Ez6eXp74oL9L7NLwYZtbyvu3GaZq6JXKNktuw76CsRFSfpXB_REOOE50jabDIoXRkt5ApducDb6A42sZLZAQs11AVOUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepteetueetfeffkeefgefhleevkeeggeefveettdehveelheel
    ueelteelteevfeefnecuffhomhgrihhnpehithhsrdhssgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:UUeqZS7dK4avwanRGc96gkv-2TWwflpuPfaidIgCabeca12q7nHIbg>
    <xmx:UUeqZe5EEJBQff75-9vjjd1UaTa9kQtCBMW27BzAPXfn_CeClHAMZg>
    <xmx:UUeqZajJKWWbSu5IGRVvlmF_hfYWHQK-SsXnX24cWBMoZs-3CyFRUA>
    <xmx:UkeqZWiW5aEIaEWosJlT47SA6LkNgMPxf-dud6T9OTvaSBuPRizcgw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 04:56:32 -0500 (EST)
Message-ID: <08c15a99-b158-4a69-af63-0bbbb0961da7@flygoat.com>
Date: Fri, 19 Jan 2024 09:56:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] MIPS: Add support for Mobileye EyeQ5
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
 <20240118155252.397947-15-gregory.clement@bootlin.com>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240118155252.397947-15-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/18 15:52, Gregory CLEMENT 写道:
> Introduce support for the MIPS based Mobileye EyeQ5 SoCs.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Hi Gregory,

Thanks for your reversion!
See my comments below.
> ---
>   arch/mips/Kbuild.platforms          |   1 +
>   arch/mips/Kconfig                   |  62 ++++++++++++++++
>   arch/mips/configs/eyeq5_defconfig   | 109 ++++++++++++++++++++++++++++
>   arch/mips/mobileye/Kconfig          |  12 +++
>   arch/mips/mobileye/Platform         |  16 ++++
>   arch/mips/mobileye/board-epm5.its.S |  24 ++++++
>   arch/mips/mobileye/vmlinux.its.S    |  32 ++++++++
>   7 files changed, 256 insertions(+)
>   create mode 100644 arch/mips/configs/eyeq5_defconfig
>   create mode 100644 arch/mips/mobileye/Kconfig
>   create mode 100644 arch/mips/mobileye/Platform
>   create mode 100644 arch/mips/mobileye/board-epm5.its.S
>   create mode 100644 arch/mips/mobileye/vmlinux.its.S
>
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index a2311c4bce6a6..5c145b67d3bf4 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -17,6 +17,7 @@ platform-$(CONFIG_MACH_LOONGSON2EF)	+= loongson2ef/
>   platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
>   platform-$(CONFIG_MACH_LOONGSON64)	+= loongson64/
>   platform-$(CONFIG_MIPS_MALTA)		+= mti-malta/
> +platform-$(CONFIG_MACH_EYEQ5)		+= mobileye/
>   platform-$(CONFIG_MACH_NINTENDO64)	+= n64/
>   platform-$(CONFIG_PIC32MZDA)		+= pic32/
>   platform-$(CONFIG_RALINK)		+= ralink/
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5549d26448941..e4f624adffee8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -569,6 +569,68 @@ config MACH_PIC32
>   	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
>   	  microcontrollers.
>   
> +config MACH_EYEQ5
> +	bool "Mobileye EyeQ5 SoC"
> +	select MACH_GENERIC_CORE
> +	select ARM_AMBA
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
^ Those should be selected for MIPS_CPS, as I mentioned before.
> +	select PHYSICAL_START_BOOL
> +	select ARCH_SPARSEMEM_DEFAULT if 64BIT
> +	select BOOT_RAW
> +	select BUILTIN_DTB
> +	select CEVT_R4K
> +	select CLKSRC_MIPS_GIC
> +	select COMMON_CLK
> +	select CPU_MIPSR2_IRQ_EI
> +	select CPU_MIPSR2_IRQ_VI
> +	select CSRC_R4K
> +	select DMA_NONCOHERENT
> +	select HAVE_PCI
> +	select IRQ_MIPS_CPU
> +	select MIPS_AUTO_PFN_OFFSET
> +	select MIPS_CPU_SCACHE
> +	select MIPS_GIC
> +	select MIPS_L1_CACHE_SHIFT_7
> +	select PCI_DRIVERS_GENERIC
> +	select SMP_UP if SMP
> +	select SWAP_IO_SPACE
> +	select SYS_HAS_CPU_MIPS64_R6
> +	select SYS_SUPPORTS_32BIT_KERNEL
^ I don't think you can build 32bit kernel due to your address space 
limitation.
> +	select SYS_SUPPORTS_64BIT_KERNEL
> +	select SYS_SUPPORTS_BIG_ENDIAN
^ Does it support big endian mode?
For I6500 endian pin is driven by external circuit. You shouldn't select 
it unless you have
physical endian pin or reset and set register at SoC level.
> +	select SYS_SUPPORTS_HIGHMEM
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SYS_SUPPORTS_MICROMIPS
> +	select SYS_SUPPORTS_MIPS16
^ Both MICROMIPS and MIPS16 are not available on MIPS R6.
> +	select SYS_SUPPORTS_MIPS_CPS
> +	select SYS_SUPPORTS_MULTITHREADING
^ MT is not possible on R6, we do have VP on R6.
> +	select SYS_SUPPORTS_RELOCATABLE
> +	select SYS_SUPPORTS_SMARTMIPS
^ SMARTMIPS is deprecated on R6.
> +	select SYS_SUPPORTS_ZBOOT
> +	select UHI_BOOT
> +	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> +	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select USE_OF
> +	help
> +	  Select this to build a kernel supporting EyeQ5 SoC from Mobileye.
> +
> +	bool
> +
> +config FIT_IMAGE_FDT_EPM5
> +	bool "Include FDT for Mobileye EyeQ5 development platforms"
> +	depends on MACH_EYEQ5
> +	default n
> +	help
> +	  Enable this to include the FDT for the EyeQ5 development platforms
> +	  from Mobileye in the FIT kernel image.
> +	  This requires u-boot on the platform.
> +
> +
>   config MACH_NINTENDO64
>   	bool "Nintendo 64 console"
>   	select CEVT_R4K
> diff --git a/arch/mips/configs/eyeq5_defconfig b/arch/mips/configs/eyeq5_defconfig
> new file mode 100644
> index 0000000000000..653fb11b1580d
> --- /dev/null
> +++ b/arch/mips/configs/eyeq5_defconfig
> @@ -0,0 +1,109 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_TASKSTATS=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_MEMCG=y
> +CONFIG_BLK_CGROUP=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_NAMESPACES=y
> +CONFIG_USER_NS=y
> +CONFIG_SCHED_AUTOGROUP=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EXPERT=y
> +CONFIG_MACH_EYEQ5=y
> +CONFIG_FIT_IMAGE_FDT_EPM5=y
> +CONFIG_CPU_LITTLE_ENDIAN=y
> +CONFIG_64BIT=y
> +CONFIG_PAGE_SIZE_16KB=y
> +CONFIG_MIPS_CPS=y
> +CONFIG_CPU_HAS_MSA=y
> +CONFIG_NR_CPUS=16
> +CONFIG_JUMP_LABEL=y
> +CONFIG_COMPAT_32BIT_TIME=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_TRIM_UNUSED_KSYMS=y
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SPARSEMEM_MANUAL=y
> +CONFIG_USERFAULTFD=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_NET_KEY=y
> +CONFIG_INET=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_NETFILTER=y
> +CONFIG_CAN=y
> +CONFIG_PCI=y
> +CONFIG_PCI_MSI=y
> +CONFIG_PCI_DEBUG=y
> +CONFIG_PCI_ENDPOINT=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_CONNECTOR=y
> +CONFIG_MTD=y
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_BLOCK=y
> +CONFIG_SCSI=y
> +CONFIG_NETDEVICES=y
> +CONFIG_MACVLAN=y
> +CONFIG_IPVLAN=y
> +CONFIG_MACB=y
> +CONFIG_MARVELL_PHY=y
> +CONFIG_MICREL_PHY=y
> +CONFIG_CAN_M_CAN=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_HW_RANDOM=y
> +# CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_PINCTRL=y
> +CONFIG_MFD_SYSCON=y
> +CONFIG_HID_A4TECH=y
> +CONFIG_HID_BELKIN=y
> +CONFIG_HID_CHERRY=y
> +CONFIG_HID_CYPRESS=y
> +CONFIG_HID_EZKEY=y
> +CONFIG_HID_ITE=y
> +CONFIG_HID_KENSINGTON=y
> +CONFIG_HID_REDRAGON=y
> +CONFIG_HID_MICROSOFT=y
> +CONFIG_HID_MONTEREY=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHCI=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_RESET_CONTROLLER=y
> +# CONFIG_NVMEM is not set
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_FS_ENCRYPTION=y
> +CONFIG_FUSE_FS=y
> +CONFIG_CUSE=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_UBIFS_FS=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3_ACL=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_CRYPTO_CRC32_MIPS=y
> +CONFIG_FRAME_WARN=1024
> +CONFIG_DEBUG_FS=y
> +# CONFIG_RCU_TRACE is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_CMDLINE_BOOL=y
> +CONFIG_CMDLINE="earlycon"
^ Better not overriding cmdline here, you can leave it in chosen node.

> diff --git a/arch/mips/mobileye/Kconfig b/arch/mips/mobileye/Kconfig
> new file mode 100644
> index 0000000000000..781007542422d
> --- /dev/null
> +++ b/arch/mips/mobileye/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +if MACH_EYEQ5
> +
> +config BOARD_EYEQ5
> +	bool "Support EyeQ5 platform"
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	default n
> +	help
> +	  This enables support for EyeQ5 platform.
^ Do you need this board option, given that you can build a generic 
kernel for all
EyeQ5 systems?

Thanks
- Jiaxun
> +
> +endif
> diff --git a/arch/mips/mobileye/Platform b/arch/mips/mobileye/Platform
> new file mode 100644
> index 0000000000000..43b6f4644592f
> --- /dev/null
> +++ b/arch/mips/mobileye/Platform
> @@ -0,0 +1,16 @@
> +#
> +# Copyright (C) 2016 Imagination Technologies
> +# Author: Paul Burton <paul.burton@mips.com>
> +#
> +# This program is free software; you can redistribute it and/or modify it
> +# under the terms of the GNU General Public License as published by the
> +# Free Software Foundation;  either version 2 of the  License, or (at your
> +# option) any later version.
> +#
> +
> +load-$(CONFIG_MACH_EYEQ5)	= 0xa800000808000000
> +all-$(CONFIG_MACH_EYEQ5)	+= vmlinux.gz.itb
> +
> +its-y					:= vmlinux.its.S
> +its-$(CONFIG_FIT_IMAGE_FDT_EPM5)	+= board-epm5.its.S
> +
> diff --git a/arch/mips/mobileye/board-epm5.its.S b/arch/mips/mobileye/board-epm5.its.S
> new file mode 100644
> index 0000000000000..08e8c4f183d63
> --- /dev/null
> +++ b/arch/mips/mobileye/board-epm5.its.S
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/ {
> +	images {
> +		fdt-mobileye-epm5 {
> +			description = "Mobileeye MP5 Device Tree";
> +			data = /incbin/("boot/dts/mobileye/eyeq5-epm5.dtb");
> +			type = "flat_dt";
> +			arch = "mips";
> +			compression = "none";
> +			hash {
> +				algo = "sha1";
> +			};
> +		};
> +	};
> +
> +    configurations {
> +		default = "conf-1";
> +		conf-1 {
> +			description = "Mobileye EPM5 Linux kernel";
> +			kernel = "kernel";
> +			fdt = "fdt-mobileye-epm5";
> +		};
> +	};
> +};
> diff --git a/arch/mips/mobileye/vmlinux.its.S b/arch/mips/mobileye/vmlinux.its.S
> new file mode 100644
> index 0000000000000..3e254676540f4
> --- /dev/null
> +++ b/arch/mips/mobileye/vmlinux.its.S
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/dts-v1/;
> +
> +/ {
> +	description = KERNEL_NAME;
> +	#address-cells = <ADDR_CELLS>;
> +
> +	images {
> +		kernel {
> +			description = KERNEL_NAME;
> +			data = /incbin/(VMLINUX_BINARY);
> +			type = "kernel";
> +			arch = "mips";
> +			os = "linux";
> +			compression = VMLINUX_COMPRESSION;
> +			load = /bits/ ADDR_BITS <VMLINUX_LOAD_ADDRESS>;
> +			entry = /bits/ ADDR_BITS <VMLINUX_ENTRY_ADDRESS>;
> +			hash {
> +				algo = "sha1";
> +			};
> +		};
> +	};
> +
> +	configurations {
> +		default = "conf-default";
> +
> +		conf-default {
> +			description = "Generic Linux kernel";
> +			kernel = "kernel";
> +		};
> +	};
> +};

-- 
---
Jiaxun Yang


