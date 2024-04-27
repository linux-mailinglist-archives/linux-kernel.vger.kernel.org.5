Return-Path: <linux-kernel+bounces-161093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12F8B46F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBD282AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A441206;
	Sat, 27 Apr 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKEQtaDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372B1D68F;
	Sat, 27 Apr 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233309; cv=none; b=ZJYrqHwEK9+mftH4rLNXiKT/a+MUkJDWOFpaBqZhXGjUX5Fj8ZHzIDlWWyFIpmHcVd05KKzuv9g4TH2wjx/oSkdjstocq2i/vfi4A3q9uO3ualUfB8Z0eRgeYLKrpyWMDeZXII2mU0kQkDAP9KTrykxzkd/MDao7txmUwp0cRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233309; c=relaxed/simple;
	bh=ofuhFWPl4k3YMFbQdDOUk1Gke1D1lygzEswmhGN6K2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g54cE+wWRwbHoxZfVXWItLlwhA2/e285nUKyq3BLGRRXCBxw/Qz9nIAhboitCFm1hOLBEResPOFG5wN4iN1gbtdMAkQmaBMiLru6MPyt/LyKRWcKMeIIEzemw72a49MpVfy2kOngGn7jUMc9qvV+/bgf2csnoqdLBgsSDM67dQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKEQtaDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48D1C113CE;
	Sat, 27 Apr 2024 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233308;
	bh=ofuhFWPl4k3YMFbQdDOUk1Gke1D1lygzEswmhGN6K2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKEQtaDYDeMkBP7AqS4Zj4arztEQu48l/jC70lvOkcZqX6SVfDrjbFVyH5C9rFtV0
	 KMyW8gvKDnVG8jHHVr4azM3hmnLEQRVqBrro1JVumEWNJCXwPeV8T69Mk2LaIPPzPo
	 UAjmiIZvKvAHUdM5qvZo9caZNBL/WBkTgdrGykls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.88
Date: Sat, 27 Apr 2024 17:54:55 +0200
Message-ID: <2024042755-purist-lure-e839@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024042754-surrender-exclaim-79bb@gregkh>
References: <2024042754-surrender-exclaim-79bb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index aebbe2981241..e6f0570cf490 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6603,6 +6603,9 @@
 					pause after every control message);
 				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
 					delay after resetting its port);
+				p = USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT
+					(Reduce timeout of the SET_ADDRESS
+					request from 5000 ms to 500 ms);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/MAINTAINERS b/MAINTAINERS
index bbfedb0b2093..ecf4d0c8f446 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8031,7 +8031,7 @@ M:	Geoffrey D. Bennett <g@b4.vu>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
-F:	sound/usb/mixer_scarlett_gen2.c
+F:	sound/usb/mixer_scarlett2.c
 
 FORCEDETH GIGABIT ETHERNET DRIVER
 M:	Rain River <rain.1986.08.12@gmail.com>
diff --git a/Makefile b/Makefile
index e46a57006a34..c73cb678fb9a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 87
+SUBLEVEL = 88
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 5e86145db0e2..8897364e550b 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -22,7 +22,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mmc-omap.h>
 #include <linux/mfd/menelaus.h>
-#include <sound/tlv320aic3x.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -567,10 +566,6 @@ struct menelaus_platform_data n8x0_menelaus_platform_data = {
 	.late_init = n8x0_menelaus_late_init,
 };
 
-struct aic3x_pdata n810_aic33_data = {
-	.gpio_reset = 118,
-};
-
 static int __init n8x0_late_initcall(void)
 {
 	if (!board_caps)
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index b23962c38fb2..69694af71475 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -2,12 +2,10 @@
 #ifndef __OMAP_COMMON_BOARD_DEVICES__
 #define __OMAP_COMMON_BOARD_DEVICES__
 
-#include <sound/tlv320aic3x.h>
 #include <linux/mfd/menelaus.h>
 
 void *n8x0_legacy_init(void);
 
 extern struct menelaus_platform_data n8x0_menelaus_platform_data;
-extern struct aic3x_pdata n810_aic33_data;
 
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 5b99d602c87b..44da1e14a374 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -257,9 +257,19 @@ static struct platform_device pandora_backlight = {
 	.id	= -1,
 };
 
+static struct gpiod_lookup_table pandora_soc_audio_gpios = {
+	.dev_id = "soc-audio",
+	.table = {
+		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static void __init omap3_pandora_legacy_init(void)
 {
 	platform_device_register(&pandora_backlight);
+	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
@@ -440,7 +450,6 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
 	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
-	OF_DEV_AUXDATA("tlv320aic3x", 0x18, "2-0018", &n810_aic33_data),
 #endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 826cb200b204..425b398f8d45 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -220,9 +220,6 @@ bool kernel_page_present(struct page *page)
 	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
-	if (!can_set_direct_map())
-		return true;
-
 	pgdp = pgd_offset_k(addr);
 	if (pgd_none(READ_ONCE(*pgdp)))
 		return false;
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffaadb5d..3c1b3520361c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3965b2c9efee..6e61baff223f 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,7 +84,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8ae7893d712f..45435ff88363 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,7 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_text_size = VO___start_rodata - VO__text;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d07e665bb265..3c5d5c97f8f7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -118,6 +118,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #define __init
 #define __pa(x)	((unsigned long)(x))
 
+#undef __head
+#define __head
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b2375d021..bcf0e4e4c98e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,11 +42,13 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.data :	{
+	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
 		*(.data.*)
-		*(.bss.efistub)
+
+		/* Add 4 bytes of extra space for a CRC-32 checksum */
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index d31982509654..7593339b529a 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -36,65 +36,19 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 #define ROOT_RDONLY 1
 #endif
 
+	.set	salign, 0x1000
+	.set	falign, 0x200
+
 	.code16
 	.section ".bstext", "ax"
-
-	.global bootsect_start
-bootsect_start:
 #ifdef CONFIG_EFI_STUB
 	# "MZ", MS-DOS header
 	.word	MZ_MAGIC
-#endif
-
-	# Normalize the start address
-	ljmp	$BOOTSEG, $start2
-
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	xorw	%sp, %sp
-	sti
-	cld
-
-	movw	$bugger_off_msg, %si
-
-msg_loop:
-	lodsb
-	andb	%al, %al
-	jz	bs_die
-	movb	$0xe, %ah
-	movw	$7, %bx
-	int	$0x10
-	jmp	msg_loop
-
-bs_die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
-
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
-
-#ifdef CONFIG_EFI_STUB
 	.org	0x3c
 	#
 	# Offset to the PE header.
 	#
 	.long	pe_header
-#endif /* CONFIG_EFI_STUB */
-
-	.section ".bsdata", "a"
-bugger_off_msg:
-	.ascii	"Use a boot loader.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot...\r\n"
-	.byte	0
-
-#ifdef CONFIG_EFI_STUB
 pe_header:
 	.long	PE_MAGIC
 
@@ -123,30 +77,26 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	# Filled in by build.c
-	.long	0				# SizeOfCode
+	.long	ZO__data			# SizeOfCode
 
-	.long	0				# SizeOfInitializedData
+	.long	ZO__end - ZO__data		# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
-	# Filled in by build.c
-	.long	0x0000				# AddressOfEntryPoint
+	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	setup_size			# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
 
 extra_header_fields:
-	# PE specification requires ImageBase to be 64k aligned
-	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	image_base			# ImageBase
+	.long	0				# ImageBase
 #else
-	.quad	image_base			# ImageBase
+	.quad	0				# ImageBase
 #endif
-	.long	0x20				# SectionAlignment
-	.long	0x20				# FileAlignment
+	.long	salign				# SectionAlignment
+	.long	falign				# FileAlignment
 	.word	0				# MajorOperatingSystemVersion
 	.word	0				# MinorOperatingSystemVersion
 	.word	LINUX_EFISTUB_MAJOR_VERSION	# MajorImageVersion
@@ -155,12 +105,9 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	#
-	# The size of the bzImage is written in tools/build.c
-	#
-	.long	0				# SizeOfImage
+	.long	setup_size + ZO__end		# SizeOfImage
 
-	.long	0x200				# SizeOfHeaders
+	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
 #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
@@ -191,87 +138,77 @@ extra_header_fields:
 
 	# Section table
 section_table:
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0				# startup_{32,64}
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_CODE		| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+	.long	pecompat_fstart - salign 	# VirtualSize
+	.long	salign				# VirtualAddress
+	.long	pecompat_fstart - salign	# SizeOfRawData
+	.long	salign				# PointerToRawData
 
-	#
-	# The EFI application loader requires a relocation section
-	# because EFI applications must be relocatable. The .reloc
-	# offset & size fields are filled in by build.c.
-	#
-	.ascii	".reloc"
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0
-	.long	0				# SizeOfRawData
-	.long	0				# PointerToRawData
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
+	.long	0, 0, 0
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.asciz	".compat"
-	.long	0
-	.long	0x0
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
+
+	.long	pecompat_fsize			# VirtualSize
+	.long	pecompat_fstart			# VirtualAddress
+	.long	pecompat_fsize			# SizeOfRawData
+	.long	pecompat_fstart			# PointerToRawData
+
+	.long	0, 0, 0
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
+
+	/*
+	 * Put the IA-32 machine type and the associated entry point address in
+	 * the .compat section, so loaders can figure out which other execution
+	 * modes this image supports.
+	 */
+	.pushsection ".pecompat", "a", @progbits
+	.balign	salign
+	.globl	pecompat_fstart
+pecompat_fstart:
+	.byte	0x1				# Version
+	.byte	8				# Size
+	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
+	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.byte	0x0				# Sentinel
+	.popsection
+#else
+	.set	pecompat_fstart, setup_size
 #endif
-
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".text"
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
+	.long	ZO__data
+	.long	setup_size
+	.long	ZO__data			# Size of initialized data
 						# on disk
-	.long	0x0				# startup_{32,64}
+	.long	setup_size
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+
+	.ascii	".data\0\0\0"
+	.long	ZO__end - ZO__data		# VirtualSize
+	.long	setup_size + ZO__data		# VirtualAddress
+	.long	ZO__edata - ZO__data		# SizeOfRawData
+	.long	setup_size + ZO__data		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
@@ -285,12 +222,12 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
-syssize:	.long 0			/* Filled in by build.c */
+syssize:	.long ZO__edata / 16
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
-root_dev:	.word 0			/* Filled in by build.c */
+root_dev:	.word 0			/* Default to major/minor 0/0 */
 boot_flag:	.word 0xAA55
 
 	# offset 512, entry point
@@ -578,9 +515,25 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # define INIT_SIZE VO_INIT_SIZE
 #endif
 
+	.macro		__handover_offset
+#ifndef CONFIG_EFI_HANDOVER_PROTOCOL
+	.long		0
+#elif !defined(CONFIG_X86_64)
+	.long		ZO_efi32_stub_entry
+#else
+	/* Yes, this is really how we defined it :( */
+	.long		ZO_efi64_stub_entry - 0x200
+#ifdef CONFIG_EFI_MIXED
+	.if		ZO_efi32_stub_entry != ZO_efi64_stub_entry - 0x200
+	.error		"32-bit and 64-bit EFI entry points do not match"
+	.endif
+#endif
+#endif
+	.endm
+
 init_size:		.long INIT_SIZE		# kernel initialization size
-handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+handover_offset:	__handover_offset
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 49546c247ae2..3a2d1360abb0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -10,10 +10,11 @@ ENTRY(_start)
 SECTIONS
 {
 	. = 0;
-	.bstext		: { *(.bstext) }
-	.bsdata		: { *(.bsdata) }
+	.bstext	: {
+		*(.bstext)
+		. = 495;
+	} =0xffffffff
 
-	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
 	.inittext	: { *(.inittext) }
@@ -23,6 +24,9 @@ SECTIONS
 	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
 
@@ -38,8 +42,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
-	}
 
+		setup_size = ALIGN(ABSOLUTE(.), 4096);
+		setup_sects = ABSOLUTE(setup_size / 512);
+	}
 
 	. = ALIGN(16);
 	.bss		:
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bd247692b701..10311d77c67f 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -40,10 +40,6 @@ typedef unsigned char  u8;
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
-#define DEFAULT_MAJOR_ROOT 0
-#define DEFAULT_MINOR_ROOT 0
-#define DEFAULT_ROOT_DEV (DEFAULT_MAJOR_ROOT << 8 | DEFAULT_MINOR_ROOT)
-
 /* Minimal number of setup sectors */
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
@@ -51,22 +47,7 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*512];
 
-#define PECOFF_RELOC_RESERVE 0x20
-
-#ifdef CONFIG_EFI_MIXED
-#define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
-
-static unsigned long efi32_stub_entry;
-static unsigned long efi64_stub_entry;
-static unsigned long efi_pe_entry;
-static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
-static unsigned long startup_64;
-static unsigned long _ehead;
-static unsigned long _end;
+static unsigned long _edata;
 
 /*----------------------------------------------------------------------*/
 
@@ -152,180 +133,6 @@ static void usage(void)
 	die("Usage: build setup system zoffset.h image");
 }
 
-#ifdef CONFIG_EFI_STUB
-
-static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
-{
-	unsigned int pe_header;
-	unsigned short num_sections;
-	u8 *section;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-	num_sections = get_unaligned_le16(&buf[pe_header + 6]);
-
-#ifdef CONFIG_X86_32
-	section = &buf[pe_header + 0xa8];
-#else
-	section = &buf[pe_header + 0xb8];
-#endif
-
-	while (num_sections > 0) {
-		if (strncmp((char*)section, section_name, 8) == 0) {
-			/* section header size field */
-			put_unaligned_le32(size, section + 0x8);
-
-			/* section header vma field */
-			put_unaligned_le32(vma, section + 0xc);
-
-			/* section header 'size of initialised data' field */
-			put_unaligned_le32(datasz, section + 0x10);
-
-			/* section header 'file offset' field */
-			put_unaligned_le32(offset, section + 0x14);
-
-			break;
-		}
-		section += 0x28;
-		num_sections--;
-	}
-}
-
-static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
-{
-	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
-}
-
-static void update_pecoff_setup_and_reloc(unsigned int size)
-{
-	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
-#ifdef CONFIG_EFI_MIXED
-	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
-#endif
-	u32 setup_size = reloc_offset - setup_offset;
-
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
-	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
-
-	/*
-	 * Modify .reloc section contents with a single entry. The
-	 * relocation is applied to offset 10 of the relocation section.
-	 */
-	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
-	put_unaligned_le32(10, &buf[reloc_offset + 4]);
-
-#ifdef CONFIG_EFI_MIXED
-	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
-
-	/*
-	 * Put the IA-32 machine type (0x14c) and the associated entry point
-	 * address in the .compat section, so loaders can figure out which other
-	 * execution modes this image supports.
-	 */
-	buf[compat_offset] = 0x1;
-	buf[compat_offset + 1] = 0x8;
-	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
-	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
-#endif
-}
-
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
-			       unsigned int init_sz)
-{
-	unsigned int pe_header;
-	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = init_sz - file_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-
-	/*
-	 * The PE/COFF loader may load the image at an address which is
-	 * misaligned with respect to the kernel_alignment field in the setup
-	 * header.
-	 *
-	 * In order to avoid relocating the kernel to correct the misalignment,
-	 * add slack to allow the buffer to be aligned within the declared size
-	 * of the image.
-	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
-
-	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
-	 */
-	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
-
-	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
-
-	/*
-	 * Address of entry point for PE/COFF executable
-	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
-
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
-}
-
-static int reserve_pecoff_reloc_section(int c)
-{
-	/* Reserve 0x20 bytes for .reloc section */
-	memset(buf+c, 0, PECOFF_RELOC_RESERVE);
-	return PECOFF_RELOC_RESERVE;
-}
-
-static void efi_stub_defaults(void)
-{
-	/* Defaults for old kernel */
-#ifdef CONFIG_X86_32
-	efi_pe_entry = 0x10;
-#else
-	efi_pe_entry = 0x210;
-	startup_64 = 0x200;
-#endif
-}
-
-static void efi_stub_entry_update(void)
-{
-	unsigned long addr = efi32_stub_entry;
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-#ifdef CONFIG_X86_64
-	/* Yes, this is really how we defined it :( */
-	addr = efi64_stub_entry - 0x200;
-#endif
-
-#ifdef CONFIG_EFI_MIXED
-	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
-#endif
-#endif
-	put_unaligned_le32(addr, &buf[0x264]);
-}
-
-#else
-
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
-static inline void efi_stub_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
-
-static inline int reserve_pecoff_reloc_section(int c)
-{
-	return 0;
-}
-#endif /* CONFIG_EFI_STUB */
-
-static int reserve_pecoff_compat_section(int c)
-{
-	/* Reserve 0x20 bytes for .compat section */
-	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
-	return PECOFF_COMPAT_RESERVE;
-}
-
 /*
  * Parse zoffset.h and find the entry points. We could just #include zoffset.h
  * but that would mean tools/build would have to be rebuilt every time. It's
@@ -354,14 +161,7 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_stub_entry);
-		PARSE_ZOFS(p, efi64_stub_entry);
-		PARSE_ZOFS(p, efi_pe_entry);
-		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
-		PARSE_ZOFS(p, startup_64);
-		PARSE_ZOFS(p, _ehead);
-		PARSE_ZOFS(p, _end);
+		PARSE_ZOFS(p, _edata);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -371,17 +171,14 @@ static void parse_zoffset(char *fname)
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, sz, setup_sectors, init_sz;
+	unsigned int i, sz, setup_sectors;
 	int c;
-	u32 sys_size;
 	struct stat sb;
 	FILE *file, *dest;
 	int fd;
 	void *kernel;
 	u32 crc = 0xffffffffUL;
 
-	efi_stub_defaults();
-
 	if (argc != 5)
 		usage();
 	parse_zoffset(argv[3]);
@@ -403,72 +200,27 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
-	c += reserve_pecoff_compat_section(c);
-	c += reserve_pecoff_reloc_section(c);
-
 	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
+	setup_sectors = (c + 4095) / 4096;
+	setup_sectors *= 8;
 	if (setup_sectors < SETUP_SECT_MIN)
 		setup_sectors = SETUP_SECT_MIN;
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup_and_reloc(i);
-
-	/* Set the default root device */
-	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
 		die("Unable to open `%s': %m", argv[2]);
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
+	if (_edata != sb.st_size)
+		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
+		    sb.st_size);
+	sz = _edata - 4;
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
-	sys_size = (sz + 15 + 4) / 16;
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * COFF requires minimum 32-byte alignment of sections, and
-	 * adding a signature is problematic without that alignment.
-	 */
-	sys_size = (sys_size + 1) & ~1;
-#endif
-
-	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
-	put_unaligned_le32(sys_size, &buf[0x1f4]);
-
-	init_sz = get_unaligned_le32(&buf[0x260]);
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * The decompression buffer will start at ImageBase. When relocating
-	 * the compressed kernel to its end, we must ensure that the head
-	 * section does not get overwritten.  The head section occupies
-	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
-	 *
-	 * At present these should never overlap, because 'i' is at most 32k
-	 * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and the
-	 * calculation of INIT_SIZE in boot/header.S ensures that
-	 * 'init_sz - _end' is at least 64k.
-	 *
-	 * For future-proofing, increase init_sz if necessary.
-	 */
-
-	if (init_sz - _end < i + _ehead) {
-		init_sz = (i + _ehead + _end + 4095) & ~4095;
-		put_unaligned_le32(init_sz, &buf[0x260]);
-	}
-#endif
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
-
-	efi_stub_entry_update();
-
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
@@ -479,13 +231,6 @@ int main(int argc, char ** argv)
 	if (fwrite(kernel, 1, sz, dest) != sz)
 		die("Writing kernel failed");
 
-	/* Add padding leaving 4 bytes for the checksum */
-	while (sz++ < (sys_size*16) - 4) {
-		crc = partial_crc32_one('\0', crc);
-		if (fwrite("\0", 1, 1, dest) != 1)
-			die("Writing padding failed");
-	}
-
 	/* Write the CRC */
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index a38cc0afc90a..a3e0be0470a4 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -81,6 +81,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int output_len;
+extern const unsigned long kernel_text_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5f1d3c421f68..cc9ccf61b6bd 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#define __head	__section(".head.text")
+
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dfcdcafe3a2c..887a171488ea 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -773,6 +773,7 @@ struct kvm_vcpu_arch {
 	int cpuid_nent;
 	struct kvm_cpuid_entry2 *cpuid_entries;
 	u32 kvm_cpuid_base;
+	bool is_amd_compatible;
 
 	u64 reserved_gpa_bits;
 	int maxphyaddr;
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 41d06822bc8c..853f423b1d13 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -46,8 +46,8 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 void __init sme_early_init(void);
 void __init sev_setup_arch(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
-void __init sme_enable(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
+void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
@@ -80,8 +80,8 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 static inline void __init sme_early_init(void) { }
 static inline void __init sev_setup_arch(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
-static inline void __init sme_enable(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index a506a411474d..86bd4311daf8 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -11,20 +11,14 @@
 #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
-#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
-
-#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
-#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
-
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
-/* Cast *PAGE_MASK to a signed type so that it is sign-extended if
+/* Cast P*D_MASK to a signed type so that it is sign-extended if
    virtual addresses are 32-bits but physical addresses are larger
    (ie, 32-bit PAE). */
 #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_PAGE_MASK) & __PHYSICAL_MASK)
-#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_PAGE_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_MASK) & __PHYSICAL_MASK)
+#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_MASK) & __PHYSICAL_MASK)
 
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c57dd21155bd..bcac2e53d50b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -192,15 +192,15 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned long npages);
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages);
+void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+				  unsigned long npages);
+void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+				 unsigned long npages);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __init __noreturn snp_abort(void);
+void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 u64 snp_get_unsupported_features(u64 status);
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 19a0207e529f..56a917df410d 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -504,7 +504,7 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 	}
 
 	a = aper + iommu_size;
-	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
+	iommu_size -= round_up(a, PMD_SIZE) - a;
 
 	if (iommu_size < 64*1024*1024) {
 		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6d69123de366..3f38592ec771 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1629,7 +1629,8 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2783,11 +2784,13 @@ static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
 		return "; BHI: BHI_DIS_S";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
+		 rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bcafba7d..9c19f40b1b27 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -44,7 +44,10 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_F16C,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_GFNI,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VAES,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX       },
 	{ X86_FEATURE_AVX2,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512F,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512IFMA,		X86_FEATURE_AVX512F   },
@@ -56,9 +59,6 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512VL,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512VBMI,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VBMI2,		X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_GFNI,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VAES,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_VNNI,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_BITALG,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_4VNNIW,		X86_FEATURE_AVX512F   },
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 84adf12a76d3..4fae511b2e2b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -41,6 +41,7 @@
 #include <asm/trapnr.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/init.h>
 
 /*
  * Manage page tables very early on.
@@ -84,8 +85,6 @@ static struct desc_ptr startup_gdt_descr = {
 	.address = 0,
 };
 
-#define __head	__section(".head.text")
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
@@ -203,7 +202,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
-	if (load_delta & ~PMD_PAGE_MASK)
+	if (load_delta & ~PMD_MASK)
 		for (;;);
 
 	/* Include the SME encryption mask in the fixup value */
@@ -588,7 +587,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void __head startup_64_load_idt(unsigned long physbase)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index b348a672f71d..b525fe6d6657 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pnp.h>
 
 #include <asm/setup.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 271e70d5748e..3fe76bf17d95 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -86,7 +86,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -323,13 +324,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &RIP_REL_REF(cpuid_table_copy);
 }
 
 /*
@@ -388,7 +383,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __head
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -525,7 +520,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -567,7 +563,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1013,7 +1009,8 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
 	struct setup_data *hdr;
@@ -1040,7 +1037,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e35fcc8d4bae..f8a8249ae117 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -690,7 +691,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool vali
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
+static void __head early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -728,7 +729,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned long npag
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -2085,7 +2086,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2111,7 +2112,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2133,7 +2134,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __head __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 62a44455c51d..f02961cbbb75 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -340,6 +340,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	kvm_update_pv_runtime(vcpu);
 
+	vcpu->arch.is_amd_compatible = guest_cpuid_is_amd_or_hygon(vcpu);
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index b1658c0de847..18fd2e845989 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -125,6 +125,16 @@ static inline bool guest_cpuid_is_intel(struct kvm_vcpu *vcpu)
 	return best && is_guest_vendor_intel(best->ebx, best->ecx, best->edx);
 }
 
+static inline bool guest_cpuid_is_amd_compatible(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.is_amd_compatible;
+}
+
+static inline bool guest_cpuid_is_intel_compatible(struct kvm_vcpu *vcpu)
+{
+	return !guest_cpuid_is_amd_compatible(vcpu);
+}
+
 static inline int guest_cpuid_family(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index bfeafe485552..c90fef0258c5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2548,7 +2548,8 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d30325e297a0..13134954e24d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4649,7 +4649,7 @@ static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				context->cpu_role.base.level, is_efer_nx(context),
 				guest_can_use_gbpages(vcpu),
 				is_cr4_pse(context),
-				guest_cpuid_is_amd_or_hygon(vcpu));
+				guest_cpuid_is_amd_compatible(vcpu));
 }
 
 static void
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c1590855ffc..10aff2c9a4e4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7742,8 +7742,28 @@ static u64 vmx_get_perf_capabilities(void)
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
-			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
+
+		/*
+		 * Disallow adaptive PEBS as it is functionally broken, can be
+		 * used by the guest to read *host* LBRs, and can be used to
+		 * bypass userspace event filters.  To correctly and safely
+		 * support adaptive PEBS, KVM needs to:
+		 *
+		 * 1. Account for the ADAPTIVE flag when (re)programming fixed
+		 *    counters.
+		 *
+		 * 2. Gain support from perf (or take direct control of counter
+		 *    programming) to support events without adaptive PEBS
+		 *    enabled for the hardware counter.
+		 *
+		 * 3. Ensure LBR MSRs cannot hold host data on VM-Entry with
+		 *    adaptive PEBS enabled and MSR_PEBS_DATA_CFG.LBRS=1.
+		 *
+		 * 4. Document which PMU events are effectively exposed to the
+		 *    guest via adaptive PEBS, and make adaptive PEBS mutually
+		 *    exclusive with KVM_SET_PMU_EVENT_FILTER if necessary.
+		 */
+		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
 	}
 
 	return perf_cap;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f724765032bc..a2ea636a2308 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3278,7 +3278,7 @@ static bool is_mci_status_msr(u32 msr)
 static bool can_set_mci_status(struct kvm_vcpu *vcpu)
 {
 	/* McStatusWrEn enabled? */
-	if (guest_cpuid_is_amd_or_hygon(vcpu))
+	if (guest_cpuid_is_amd_compatible(vcpu))
 		return !!(vcpu->arch.msr_hwcr & BIT_ULL(18));
 
 	return false;
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 9de3d900bc92..e25288ee33c2 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 	 *   RCX - virtual address of the encryption workarea, including:
 	 *     - stack page (PAGE_SIZE)
 	 *     - encryption routine page (PAGE_SIZE)
-	 *     - intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     - intermediate copy buffer (PMD_SIZE)
 	 *    R8 - physical address of the pagetables to use for encryption
 	 */
 
@@ -123,7 +123,7 @@ SYM_FUNC_START(__enc_copy)
 	wbinvd				/* Invalidate any cache entries */
 
 	/* Copy/encrypt up to 2MB at a time */
-	movq	$PMD_PAGE_SIZE, %r12
+	movq	$PMD_SIZE, %r12
 1:
 	cmpq	%r12, %r9
 	jnb	2f
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 06ccbd36e8dc..f17609884874 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -41,6 +41,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 
+#include <asm/init.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
@@ -93,12 +94,12 @@ struct sme_populate_pgd_data {
  * section is 2MB aligned to allow for simple pagetable setup using only
  * PMD entries (see vmlinux.lds.S).
  */
-static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
+static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -113,7 +114,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -150,7 +151,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -166,7 +167,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -192,17 +193,17 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
 
-		ppd->vaddr += PMD_PAGE_SIZE;
-		ppd->paddr += PMD_PAGE_SIZE;
+		ppd->vaddr += PMD_SIZE;
+		ppd->paddr += PMD_SIZE;
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -212,7 +213,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -224,11 +225,11 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	vaddr_end = ppd->vaddr_end;
 
 	/* If start is not 2MB aligned, create PTE entries */
-	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_PAGE_SIZE);
+	ppd->vaddr_end = ALIGN(ppd->vaddr, PMD_SIZE);
 	__sme_map_range_pte(ppd);
 
 	/* Create PMD entries */
-	ppd->vaddr_end = vaddr_end & PMD_PAGE_MASK;
+	ppd->vaddr_end = vaddr_end & PMD_MASK;
 	__sme_map_range_pmd(ppd);
 
 	/* If end is not 2MB aligned, create PTE entries */
@@ -236,22 +237,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __init sme_pgtable_calc(unsigned long len)
+static unsigned long __head sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -288,7 +289,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __head sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -323,9 +324,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_PAGE_SIZE);
+	kernel_start = (unsigned long)RIP_REL_REF(_text);
+	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -342,25 +342,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
 	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
 	 *     stack page (PAGE_SIZE)
 	 *     encryption routine page (PAGE_SIZE)
-	 *     intermediate copy buffer (PMD_PAGE_SIZE)
+	 *     intermediate copy buffer (PMD_SIZE)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
-	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_PAGE_SIZE;
+	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
+	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
 	/*
@@ -383,7 +375,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * before it is mapped.
 	 */
 	workarea_len = execute_len + pgtable_area_len;
-	workarea_end = ALIGN(workarea_start + workarea_len, PMD_PAGE_SIZE);
+	workarea_end = ALIGN(workarea_start + workarea_len, PMD_SIZE);
 
 	/*
 	 * Set the address to the start of where newly created pagetable
@@ -502,7 +494,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	native_write_cr3(__native_read_cr3());
 }
 
-void __init sme_enable(struct boot_params *bp)
+void __head sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 5f0ce77a259d..68d4f328f169 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -747,11 +747,11 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
 	switch (level) {
 	case PG_LEVEL_1G:
 		phys_addr = (phys_addr_t)pud_pfn(*(pud_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PUD_PAGE_MASK;
+		offset = virt_addr & ~PUD_MASK;
 		break;
 	case PG_LEVEL_2M:
 		phys_addr = (phys_addr_t)pmd_pfn(*(pmd_t *)pte) << PAGE_SHIFT;
-		offset = virt_addr & ~PMD_PAGE_MASK;
+		offset = virt_addr & ~PMD_MASK;
 		break;
 	default:
 		phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
@@ -1041,7 +1041,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	case PG_LEVEL_1G:
 		ref_prot = pud_pgprot(*(pud_t *)kpte);
 		ref_pfn = pud_pfn(*(pud_t *)kpte);
-		pfninc = PMD_PAGE_SIZE >> PAGE_SHIFT;
+		pfninc = PMD_SIZE >> PAGE_SHIFT;
 		lpaddr = address & PUD_MASK;
 		lpinc = PMD_SIZE;
 		/*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ffe3b3a087fe..78414c6d1b5e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -592,7 +592,7 @@ static void pti_set_kernel_image_nonglobal(void)
 	 * of the image.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_SIZE);
 
 	/*
 	 * This clears _PAGE_GLOBAL from the entire kernel image.
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 73db0cb44fc7..45d906f17ea3 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -573,7 +573,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 55cd17a13e75..8c2b7c074eca 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1707,8 +1707,10 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+	    !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
+
 	if (u) {
 		if (copy_from_user(object, u + offset, read_size))
 			return 0;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d1c8e1c99b5..fd57eb372d49 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -683,7 +683,7 @@ static void extract_entropy(void *buf, size_t len)
 
 static void __cold _credit_init_bits(size_t bits)
 {
-	static struct execute_work set_ready;
+	static DECLARE_WORK(set_ready, crng_set_ready);
 	unsigned int new, orig, add;
 	unsigned long flags;
 
@@ -699,8 +699,8 @@ static void __cold _credit_init_bits(size_t bits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-		if (static_key_initialized)
-			execute_in_process_context(crng_set_ready, &set_ready);
+		if (static_key_initialized && system_unbound_wq)
+			queue_work(system_unbound_wq, &set_ready);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
@@ -870,8 +870,8 @@ void __init random_init(void)
 
 	/*
 	 * If we were initialized by the cpu or bootloader before jump labels
-	 * are initialized, then we should enable the static branch here, where
-	 * it's guaranteed that jump labels have been initialized.
+	 * or workqueues are initialized, then we should enable the static
+	 * branch here, where it's guaranteed that these have been initialized.
 	 */
 	if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
 		crng_set_ready(NULL);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9004e0718225..fe1d45eac837 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -37,6 +37,10 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
+/* List of registered clks that use runtime PM */
+static HLIST_HEAD(clk_rpm_list);
+static DEFINE_MUTEX(clk_rpm_list_lock);
+
 static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
@@ -59,6 +63,7 @@ struct clk_core {
 	struct clk_hw		*hw;
 	struct module		*owner;
 	struct device		*dev;
+	struct hlist_node	rpm_node;
 	struct device_node	*of_node;
 	struct clk_core		*parent;
 	struct clk_parent_map	*parents;
@@ -122,6 +127,89 @@ static void clk_pm_runtime_put(struct clk_core *core)
 	pm_runtime_put_sync(core->dev);
 }
 
+/**
+ * clk_pm_runtime_get_all() - Runtime "get" all clk provider devices
+ *
+ * Call clk_pm_runtime_get() on all runtime PM enabled clks in the clk tree so
+ * that disabling unused clks avoids a deadlock where a device is runtime PM
+ * resuming/suspending and the runtime PM callback is trying to grab the
+ * prepare_lock for something like clk_prepare_enable() while
+ * clk_disable_unused_subtree() holds the prepare_lock and is trying to runtime
+ * PM resume/suspend the device as well.
+ *
+ * Context: Acquires the 'clk_rpm_list_lock' and returns with the lock held on
+ * success. Otherwise the lock is released on failure.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+static int clk_pm_runtime_get_all(void)
+{
+	int ret;
+	struct clk_core *core, *failed;
+
+	/*
+	 * Grab the list lock to prevent any new clks from being registered
+	 * or unregistered until clk_pm_runtime_put_all().
+	 */
+	mutex_lock(&clk_rpm_list_lock);
+
+	/*
+	 * Runtime PM "get" all the devices that are needed for the clks
+	 * currently registered. Do this without holding the prepare_lock, to
+	 * avoid the deadlock.
+	 */
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
+		ret = clk_pm_runtime_get(core);
+		if (ret) {
+			failed = core;
+			pr_err("clk: Failed to runtime PM get '%s' for clk '%s'\n",
+			       dev_name(failed->dev), failed->name);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
+		if (core == failed)
+			break;
+
+		clk_pm_runtime_put(core);
+	}
+	mutex_unlock(&clk_rpm_list_lock);
+
+	return ret;
+}
+
+/**
+ * clk_pm_runtime_put_all() - Runtime "put" all clk provider devices
+ *
+ * Put the runtime PM references taken in clk_pm_runtime_get_all() and release
+ * the 'clk_rpm_list_lock'.
+ */
+static void clk_pm_runtime_put_all(void)
+{
+	struct clk_core *core;
+
+	hlist_for_each_entry(core, &clk_rpm_list, rpm_node)
+		clk_pm_runtime_put(core);
+	mutex_unlock(&clk_rpm_list_lock);
+}
+
+static void clk_pm_runtime_init(struct clk_core *core)
+{
+	struct device *dev = core->dev;
+
+	if (dev && pm_runtime_enabled(dev)) {
+		core->rpm_enabled = true;
+
+		mutex_lock(&clk_rpm_list_lock);
+		hlist_add_head(&core->rpm_node, &clk_rpm_list);
+		mutex_unlock(&clk_rpm_list_lock);
+	}
+}
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -1310,9 +1398,6 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_IGNORE_UNUSED)
 		return;
 
-	if (clk_pm_runtime_get(core))
-		return;
-
 	if (clk_core_is_prepared(core)) {
 		trace_clk_unprepare(core);
 		if (core->ops->unprepare_unused)
@@ -1321,8 +1406,6 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 			core->ops->unprepare(core->hw);
 		trace_clk_unprepare_complete(core);
 	}
-
-	clk_pm_runtime_put(core);
 }
 
 static void __init clk_disable_unused_subtree(struct clk_core *core)
@@ -1338,9 +1421,6 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
-	if (clk_pm_runtime_get(core))
-		goto unprepare_out;
-
 	flags = clk_enable_lock();
 
 	if (core->enable_count)
@@ -1365,8 +1445,6 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
-	clk_pm_runtime_put(core);
-unprepare_out:
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable_unprepare(core->parent);
 }
@@ -1382,12 +1460,22 @@ __setup("clk_ignore_unused", clk_ignore_unused_setup);
 static int __init clk_disable_unused(void)
 {
 	struct clk_core *core;
+	int ret;
 
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
 	}
 
+	pr_info("clk: Disabling unused clocks\n");
+
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
+	/*
+	 * Grab the prepare lock to keep the clk topology stable while iterating
+	 * over clks.
+	 */
 	clk_prepare_lock();
 
 	hlist_for_each_entry(core, &clk_root_list, child_node)
@@ -1404,6 +1492,8 @@ static int __init clk_disable_unused(void)
 
 	clk_prepare_unlock();
 
+	clk_pm_runtime_put_all();
+
 	return 0;
 }
 late_initcall_sync(clk_disable_unused);
@@ -3115,28 +3205,41 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
 	int phase;
+	struct clk *clk_user;
+	int multi_node = 0;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
+	seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
 		   level * 3 + 1, "",
-		   30 - level * 3, c->name,
+		   35 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
 		   clk_core_get_rate_recalc(c),
 		   clk_core_get_accuracy_recalc(c));
 
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
-		seq_printf(s, "%5d", phase);
+		seq_printf(s, "%-5d", phase);
 	else
 		seq_puts(s, "-----");
 
-	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
+	seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
 
 	if (c->ops->is_enabled)
-		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
+		seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N');
 	else if (!c->ops->enable)
-		seq_printf(s, " %9c\n", 'Y');
+		seq_printf(s, " %5c ", 'Y');
 	else
-		seq_printf(s, " %9c\n", '?');
+		seq_printf(s, " %5c ", '?');
+
+	hlist_for_each_entry(clk_user, &c->clks, clks_node) {
+		seq_printf(s, "%*s%-*s  %-25s\n",
+			   level * 3 + 2 + 105 * multi_node, "",
+			   30,
+			   clk_user->dev_id ? clk_user->dev_id : "deviceless",
+			   clk_user->con_id ? clk_user->con_id : "no_connection_id");
+
+		multi_node = 1;
+	}
+
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -3144,9 +3247,7 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 {
 	struct clk_core *child;
 
-	clk_pm_runtime_get(c);
 	clk_summary_show_one(s, c, level);
-	clk_pm_runtime_put(c);
 
 	hlist_for_each_entry(child, &c->children, child_node)
 		clk_summary_show_subtree(s, child, level + 1);
@@ -3155,11 +3256,16 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 static int clk_summary_show(struct seq_file *s, void *data)
 {
 	struct clk_core *c;
-	struct hlist_head **lists = (struct hlist_head **)s->private;
+	struct hlist_head **lists = s->private;
+	int ret;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
+
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
 
 	clk_prepare_lock();
 
@@ -3168,6 +3274,7 @@ static int clk_summary_show(struct seq_file *s, void *data)
 			clk_summary_show_subtree(s, c, 0);
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	return 0;
 }
@@ -3214,9 +3321,15 @@ static int clk_dump_show(struct seq_file *s, void *data)
 {
 	struct clk_core *c;
 	bool first_node = true;
-	struct hlist_head **lists = (struct hlist_head **)s->private;
+	struct hlist_head **lists = s->private;
+	int ret;
+
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
 
 	seq_putc(s, '{');
+
 	clk_prepare_lock();
 
 	for (; *lists; lists++) {
@@ -3229,6 +3342,7 @@ static int clk_dump_show(struct seq_file *s, void *data)
 	}
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	seq_puts(s, "}\n");
 	return 0;
@@ -3836,8 +3950,6 @@ static int __clk_core_init(struct clk_core *core)
 	}
 
 	clk_core_reparent_orphans_nolock();
-
-	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
 unlock:
@@ -4066,6 +4178,22 @@ static void clk_core_free_parent_map(struct clk_core *core)
 	kfree(core->parents);
 }
 
+/* Free memory allocated for a struct clk_core */
+static void __clk_release(struct kref *ref)
+{
+	struct clk_core *core = container_of(ref, struct clk_core, ref);
+
+	if (core->rpm_enabled) {
+		mutex_lock(&clk_rpm_list_lock);
+		hlist_del(&core->rpm_node);
+		mutex_unlock(&clk_rpm_list_lock);
+	}
+
+	clk_core_free_parent_map(core);
+	kfree_const(core->name);
+	kfree(core);
+}
+
 static struct clk *
 __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
@@ -4086,6 +4214,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_out;
 	}
 
+	kref_init(&core->ref);
+
 	core->name = kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret = -ENOMEM;
@@ -4098,9 +4228,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	}
 	core->ops = init->ops;
 
-	if (dev && pm_runtime_enabled(dev))
-		core->rpm_enabled = true;
 	core->dev = dev;
+	clk_pm_runtime_init(core);
 	core->of_node = np;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
@@ -4140,12 +4269,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	hw->clk = NULL;
 
 fail_create_clk:
-	clk_core_free_parent_map(core);
 fail_parents:
 fail_ops:
-	kfree_const(core->name);
 fail_name:
-	kfree(core);
+	kref_put(&core->ref, __clk_release);
 fail_out:
 	return ERR_PTR(ret);
 }
@@ -4225,18 +4352,6 @@ int of_clk_hw_register(struct device_node *node, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_register);
 
-/* Free memory allocated for a clock. */
-static void __clk_release(struct kref *ref)
-{
-	struct clk_core *core = container_of(ref, struct clk_core, ref);
-
-	lockdep_assert_held(&prepare_lock);
-
-	clk_core_free_parent_map(core);
-	kfree_const(core->name);
-	kfree(core);
-}
-
 /*
  * Empty clk_ops for unregistered clocks. These are used temporarily
  * after clk_unregister() was called on a clock and until last clock
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 0c867136e49d..67d9e741c5e7 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -152,12 +152,12 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-static struct clk_hw *mtk_clk_register_gate(const char *name,
+static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name,
 					 const char *parent_name,
 					 struct regmap *regmap, int set_ofs,
 					 int clr_ofs, int sta_ofs, u8 bit,
 					 const struct clk_ops *ops,
-					 unsigned long flags, struct device *dev)
+					 unsigned long flags)
 {
 	struct mtk_clk_gate *cg;
 	int ret;
@@ -202,10 +202,9 @@ static void mtk_clk_unregister_gate(struct clk_hw *hw)
 	kfree(cg);
 }
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev)
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk_hw *hw;
@@ -229,13 +228,13 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(gate->name, gate->parent_name,
+		hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
 					    regmap,
 					    gate->regs->set_ofs,
 					    gate->regs->clr_ofs,
 					    gate->regs->sta_ofs,
 					    gate->shift, gate->ops,
-					    gate->flags, dev);
+					    gate->flags);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
@@ -261,14 +260,6 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
-EXPORT_SYMBOL_GPL(mtk_clk_register_gates_with_dev);
-
-int mtk_clk_register_gates(struct device_node *node,
-			   const struct mtk_gate *clks, int num,
-			   struct clk_hw_onecell_data *clk_data)
-{
-	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
-}
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index d9897ef53528..1a46b4c56fc5 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -50,15 +50,10 @@ struct mtk_gate {
 #define GATE_MTK(_id, _name, _parent, _regs, _shift, _ops)		\
 	GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift, _ops, 0)
 
-int mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			   const struct mtk_gate *clks, int num,
 			   struct clk_hw_onecell_data *clk_data);
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev);
-
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 4287bd3f545e..03ab212aa7f4 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -127,8 +127,8 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 601358748750..924725d67c13 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -51,8 +51,8 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 8d1fc8e3336e..501fb99bb41a 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -45,7 +45,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
 
-	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
+	mtk_clk_register_gates(&pdev->dev, node, g3d_clks, ARRAY_SIZE(g3d_clks),
 			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index edeeb033a235..1ddefc21d6a0 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -48,8 +48,8 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
 
-	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, hif_clks,
+			       ARRAY_SIZE(hif_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index eb069f3bc9a2..f4885dffb324 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -76,8 +76,8 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 00d2e81bdd43..e80fe9c942ee 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -679,14 +679,15 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 								clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				base, &mt2701_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt2701_clk_lock, clk_data);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -789,8 +790,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
@@ -902,11 +903,12 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
-			&mt2701_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, peri_muxs,
+				    ARRAY_SIZE(peri_muxs), base,
+				    &mt2701_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index ad6daa8f28a8..e5264f1ce60d 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -117,8 +117,8 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index d6c2cc183b1a..a0f0c9ed48d1 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1320,12 +1320,13 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt2712_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
@@ -1344,8 +1345,8 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1366,8 +1367,8 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1395,8 +1396,11 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
-	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt2712_clk_lock, clk_data);
+	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					ARRAY_SIZE(mcu_muxes), base,
+					&mt2712_clk_lock, clk_data);
+	if (r)
+		dev_err(&pdev->dev, "Could not register composites: %d\n", r);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 2c6a52ff5564..c4941523f552 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -743,7 +743,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -782,10 +782,11 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 				    clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
 			       &mt6765_clk_lock, clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -820,8 +821,8 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+			       ARRAY_SIZE(ifr_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index eda8cbee3d23..2cccf62d3b36 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -93,8 +93,8 @@ static int clk_mt6779_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 39dadc954708..7fe9d12b2dfd 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1223,7 +1223,7 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -1248,14 +1248,17 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
-			       node, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
+			       &mt6779_clk_lock, clk_data);
 
-	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-				    base, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
+				    ARRAY_SIZE(top_aud_muxes), base,
+				    &mt6779_clk_lock, clk_data);
 
-	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-				    base, &mt6779_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+				    ARRAY_SIZE(top_aud_divs), base,
+				    &mt6779_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1267,8 +1270,8 @@ static int clk_mt6779_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index df7eed6e071e..8025d171d692 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -101,7 +101,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
+				     ARRAY_SIZE(infra_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index fd73f202f292..eebb6143ada2 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -87,7 +87,8 @@ static int clk_mt6795_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, mm_gates,
+				     ARRAY_SIZE(mm_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index cb28d35dad59..08aaa9b09c36 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -109,11 +109,13 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, peri_gates,
+				     ARRAY_SIZE(peri_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
+	ret = mtk_clk_register_composites(&pdev->dev, peri_clks,
+					  ARRAY_SIZE(peri_clks), base,
 					  &mt6795_peri_clk_lock, clk_data);
 	if (ret)
 		goto unregister_gates;
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 2948dd1aee8f..2ab8bf5d6d6d 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -552,12 +552,14 @@ static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_fixed_clks;
 
-	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
+				     ARRAY_SIZE(top_muxes), node,
 				     &mt6795_top_clk_lock, clk_data);
 	if (ret)
 		goto unregister_factors;
 
-	ret = mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), base,
+	ret = mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+					  ARRAY_SIZE(top_aud_divs), base,
 					  &mt6795_top_clk_lock, clk_data);
 	if (ret)
 		goto unregister_muxes;
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 99a63f46642f..d5e9fe445e30 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -89,8 +89,8 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index b362e99c8f53..0429a80f3cad 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -398,7 +398,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
 				    &mt6797_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -584,8 +585,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index b17731fa1144..e9070d0bea8d 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -114,8 +114,8 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index a60190e83418..ece0f7a7c5f6 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -69,8 +69,8 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -91,8 +91,8 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
-	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks,
+			       ARRAY_SIZE(sgmii_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 55baa6d06a20..c57ac2273c4e 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -80,8 +80,8 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -102,8 +102,8 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index eebbb8790693..67a296646722 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -615,14 +615,15 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7622_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt7622_clk_lock, clk_data);
 
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				  base, &mt7622_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -635,8 +636,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -663,7 +664,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -682,10 +683,11 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, peri_muxes,
+				    ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index e1d2635c72c1..eab838af6d41 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -82,7 +82,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       CLK_ETH_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -106,8 +107,8 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks[id++],
+			       CLK_SGMII_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 3628811a2f57..804900792e49 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -75,8 +75,8 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -97,8 +97,8 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 01ee45fcd7e3..2019e272d1cd 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -566,8 +566,9 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
 				 clk_data);
 
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
-				    base, &mt7629_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt7629_clk_lock, clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
 	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
@@ -585,8 +586,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -610,10 +611,11 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
-	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
+	mtk_clk_register_composites(&pdev->dev, peri_muxes,
+				    ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -637,7 +639,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index c21e1d672384..e04bc6845ea6 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -72,8 +72,8 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
 
-	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii0_clks,
+			       ARRAY_SIZE(sgmii0_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -90,8 +90,8 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
 
-	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii1_clks,
+			       ARRAY_SIZE(sgmii1_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -109,7 +109,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 74e68a719730..0a4bf87ee160 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -178,10 +178,11 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
-	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, infra_muxes,
+			       ARRAY_SIZE(infra_muxes), node,
 			       &mt7986_clk_lock, clk_data);
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index de5121cf2877..c9bf47e6098f 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -303,7 +303,8 @@ static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 3ea06d2ec2f1..a39ad58e2741 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -536,8 +536,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8135_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8135_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -553,8 +554,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -579,10 +580,11 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8135_clk_lock, clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
+	mtk_clk_register_composites(NULL, peri_clks,
+				    ARRAY_SIZE(peri_clks), base,
+				    &mt8135_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index b5ac196cd945..47a7d89d5777 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -50,7 +50,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 4e7c0772b4f9..e196b3b894a1 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -42,7 +42,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 192714498b2e..602d25f4cb2e 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -40,7 +40,7 @@ static void __init mtk_mfgcfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index a94961b7b8cc..abc70e1221bf 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -98,8 +98,8 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 
 	data = &mt8167_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 38f0ba357d59..92bc05d99798 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -49,7 +49,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks, ARRAY_SIZE(vdec_clks),
+			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index f900ac4bf7b8..91669ebafaf9 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -937,11 +937,12 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8167_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8167_clk_lock, clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8167_clk_lock, clk_data);
 
@@ -966,8 +967,9 @@ static void __init mtk_infracfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8167_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, ifr_muxes,
+				    ARRAY_SIZE(ifr_muxes), base,
+				    &mt8167_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 5826eabdc9c7..444a3d58c8bf 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -112,8 +112,8 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 
 	data = &mt8173_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b8529ee7199d..d05c1109b4f8 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -869,8 +869,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-			&mt8173_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8173_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -888,8 +889,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
@@ -918,10 +919,11 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
-	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-			&mt8173_clk_lock, clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
+	mtk_clk_register_composites(NULL, peri_clks,
+				    ARRAY_SIZE(peri_clks), base,
+				    &mt8173_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1062,8 +1064,8 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks,
+			       ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1080,8 +1082,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks,
+			       ARRAY_SIZE(vdec_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1097,8 +1099,8 @@ static void __init mtk_vencsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
 
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venc_clks,
+			       ARRAY_SIZE(venc_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1114,8 +1116,8 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
 
-	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venclt_clks,
+			       ARRAY_SIZE(venclt_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index b2d7746eddbe..f358a6e7a340 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -75,8 +75,8 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 11ecc6fb0065..358031530913 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -90,8 +90,8 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 1860a35a723a..78620244144e 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1172,8 +1172,8 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1238,17 +1238,20 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 
-	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
-		node, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_muxes(&pdev->dev, top_muxes,
+			       ARRAY_SIZE(top_muxes), node,
+			       &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-		base, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
+				    ARRAY_SIZE(top_aud_muxes), base,
+				    &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-		base, &mt8183_clk_lock, top_clk_data);
+	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
+				    ARRAY_SIZE(top_aud_divs), base,
+				    &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-		top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
 					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
@@ -1267,8 +1270,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
@@ -1290,8 +1293,8 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1308,8 +1311,9 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
 
-	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
-			&mt8183_clk_lock, clk_data);
+	mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+				    ARRAY_SIZE(mcu_muxes), base,
+				    &mt8183_clk_lock, clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index dfc305c1fc5d..e52a2d986c99 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -65,7 +65,8 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 		goto free_mcu_data;
 	}
 
-	r = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
+	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					ARRAY_SIZE(mcu_muxes), base,
 					NULL, clk_data);
 	if (r)
 		goto free_mcu_data;
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 1d33be407947..0b72607777fa 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -69,7 +69,8 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+				   ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		goto free_mm_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index d7f2c4663c85..70b6e008a188 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -715,17 +715,20 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_fixed_clks;
 
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
 				   &mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_factors;
 
-	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
+					ARRAY_SIZE(top_muxes), base,
 					&mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
 					&mt8186_clk_lock, clk_data);
 	if (r)
 		goto unregister_composite_muxes;
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 8c989bffd8c7..f524188fe4c2 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -87,7 +87,8 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, aud_clks,
+				   ARRAY_SIZE(aud_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 1be3ff4d407d..e9eb4cf8349a 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -91,7 +91,8 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index d0f226931070..16feb86dcb1b 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1100,27 +1100,68 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
-	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node, &mt8192_clk_lock,
-			       top_clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
-				    top_clk_data);
-	mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base, &mt8192_clk_lock,
-				    top_clk_data);
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	if (r)
 		return r;
 
+	r = mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
+	if (r)
+		goto unregister_fixed_clks;
+
+	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+	if (r)
+		goto unregister_early_factors;
+
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
+				   &mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_factors;
+
+	r = mtk_clk_register_composites(&pdev->dev, top_muxes,
+					ARRAY_SIZE(top_muxes), base,
+					&mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_muxes;
+
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
+					&mt8192_clk_lock, top_clk_data);
+	if (r)
+		goto unregister_top_composites;
+
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
+	if (r)
+		goto unregister_adj_divs_composites;
+
 	r = clk_mt8192_reg_mfg_mux_notifier(&pdev->dev,
 					    top_clk_data->hws[CLK_TOP_MFG_PLL_SEL]->clk);
 	if (r)
-		return r;
+		goto unregister_gates;
 
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
+	if (r)
+		goto unregister_gates;
+
+	return 0;
+
+unregister_gates:
+	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+unregister_adj_divs_composites:
+	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
+unregister_top_composites:
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
+unregister_muxes:
+	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+unregister_early_factors:
+	mtk_clk_unregister_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
+unregister_fixed_clks:
+	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				      top_clk_data);
+	return r;
 }
 
 static int clk_mt8192_infra_probe(struct platform_device *pdev)
@@ -1133,20 +1174,23 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+				   ARRAY_SIZE(infra_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
 	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1162,16 +1206,19 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+				   ARRAY_SIZE(peri_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
@@ -1188,16 +1235,19 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
-		goto free_clk_data;
+		goto unregister_gates;
 
 	return r;
 
+unregister_gates:
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 0dfed6ec4d15..1bc917f2667e 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -124,7 +124,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apmixed_data;
 
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto unregister_plls;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 1e016329c1d2..3485ebb17ab8 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1262,7 +1262,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_fixed_clks;
 
-	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
+	r = mtk_clk_register_muxes(&pdev->dev, top_mtk_muxes,
+				   ARRAY_SIZE(top_mtk_muxes), node,
 				   &mt8195_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_factors;
@@ -1281,12 +1282,14 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
+	r = mtk_clk_register_composites(&pdev->dev, top_adj_divs,
+					ARRAY_SIZE(top_adj_divs), base,
 					&mt8195_clk_lock, top_clk_data);
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
 		goto unregister_composite_divs;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 07b46bfd5040..839b730688ac 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -104,7 +104,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo0_clks,
+				   ARRAY_SIZE(vdo0_clks), clk_data);
 	if (r)
 		goto free_vdo0_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 835335b9d87b..7df695b28925 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -131,7 +131,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo1_clks,
+				   ARRAY_SIZE(vdo1_clks), clk_data);
 	if (r)
 		goto free_vdo1_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 5c8bf18ab1f1..22c75a03a645 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -81,9 +81,8 @@ static int clk_mt8365_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	ret = mtk_clk_register_gates_with_dev(node, mm_clks,
-					      ARRAY_SIZE(mm_clks), clk_data,
-					      dev);
+	ret = mtk_clk_register_gates(dev, node, mm_clks,
+				     ARRAY_SIZE(mm_clks), clk_data);
 	if (ret)
 		goto err_free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index adfecb618f10..c9faa07ec0a6 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -947,12 +947,13 @@ static int clk_mt8365_top_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_fixed_clks;
 
-	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+	ret = mtk_clk_register_muxes(&pdev->dev, top_muxes,
+				     ARRAY_SIZE(top_muxes), node,
 				     &mt8365_clk_lock, clk_data);
 	if (ret)
 		goto unregister_factors;
 
-	ret = mtk_clk_register_composites(top_misc_mux_gates,
+	ret = mtk_clk_register_composites(&pdev->dev, top_misc_mux_gates,
 					  ARRAY_SIZE(top_misc_mux_gates), base,
 					  &mt8365_clk_lock, clk_data);
 	if (ret)
@@ -1019,8 +1020,8 @@ static int clk_mt8365_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+				     ARRAY_SIZE(ifr_clks), clk_data);
 	if (ret)
 		goto free_clk_data;
 
@@ -1080,8 +1081,9 @@ static int clk_mt8365_mcu_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
-					  base, &mt8365_clk_lock, clk_data);
+	ret = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
+					  ARRAY_SIZE(mcu_muxes), base,
+					  &mt8365_clk_lock, clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index a3dafc719799..a6ae8003b9ff 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -48,7 +48,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 056953d594c6..6983d3a48dc9 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -655,11 +655,12 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-		&mt8516_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, top_muxes,
+				    ARRAY_SIZE(top_muxes), base,
+				    &mt8516_clk_lock, clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8516_clk_lock, clk_data);
 
@@ -684,8 +685,9 @@ static void __init mtk_infracfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
-		&mt8516_clk_lock, clk_data);
+	mtk_clk_register_composites(NULL, ifr_muxes,
+				    ARRAY_SIZE(ifr_muxes), base,
+				    &mt8516_clk_lock, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d31f01d0ba1c..fa2c1b1c7dee 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -11,12 +11,15 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mux.h"
 
 static void mtk_init_clk_data(struct clk_hw_onecell_data *clk_data,
 			      unsigned int clk_num)
@@ -197,8 +200,8 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
 
-static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
-		void __iomem *base, spinlock_t *lock)
+static struct clk_hw *mtk_clk_register_composite(struct device *dev,
+		const struct mtk_composite *mc, void __iomem *base, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 	struct clk_mux *mux = NULL;
@@ -264,7 +267,7 @@ static struct clk_hw *mtk_clk_register_composite(const struct mtk_composite *mc,
 		div_ops = &clk_divider_ops;
 	}
 
-	hw = clk_hw_register_composite(NULL, mc->name, parent_names, num_parents,
+	hw = clk_hw_register_composite(dev, mc->name, parent_names, num_parents,
 		mux_hw, mux_ops,
 		div_hw, div_ops,
 		gate_hw, gate_ops,
@@ -308,7 +311,8 @@ static void mtk_clk_unregister_composite(struct clk_hw *hw)
 	kfree(mux);
 }
 
-int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+int mtk_clk_register_composites(struct device *dev,
+				const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_hw_onecell_data *clk_data)
 {
@@ -327,7 +331,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			continue;
 		}
 
-		hw = mtk_clk_register_composite(mc, base, lock);
+		hw = mtk_clk_register_composite(dev, mc, base, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mc->name,
@@ -449,20 +453,81 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
-	int r;
+	void __iomem *base;
+	int num_clks, r;
 
 	mcd = of_device_get_match_data(&pdev->dev);
 	if (!mcd)
 		return -EINVAL;
 
-	clk_data = mtk_alloc_clk_data(mcd->num_clks);
+	/* Composite clocks needs us to pass iomem pointer */
+	if (mcd->composite_clks) {
+		if (!mcd->shared_io)
+			base = devm_platform_ioremap_resource(pdev, 0);
+		else
+			base = of_iomap(node, 0);
+
+		if (IS_ERR_OR_NULL(base))
+			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
+	}
+
+
+	devm_pm_runtime_enable(&pdev->dev);
+	/*
+	 * Do a pm_runtime_resume_and_get() to workaround a possible
+	 * deadlock between clk_register() and the genpd framework.
+	 */
+	r = pm_runtime_resume_and_get(&pdev->dev);
+	if (r)
+		return r;
+
+	/* Calculate how many clk_hw_onecell_data entries to allocate */
+	num_clks = mcd->num_clks + mcd->num_composite_clks;
+	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
+	num_clks += mcd->num_mux_clks;
+
+	clk_data = mtk_alloc_clk_data(num_clks);
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
-					    clk_data, &pdev->dev);
-	if (r)
-		goto free_data;
+	if (mcd->fixed_clks) {
+		r = mtk_clk_register_fixed_clks(mcd->fixed_clks,
+						mcd->num_fixed_clks, clk_data);
+		if (r)
+			goto free_data;
+	}
+
+	if (mcd->factor_clks) {
+		r = mtk_clk_register_factors(mcd->factor_clks,
+					     mcd->num_factor_clks, clk_data);
+		if (r)
+			goto unregister_fixed_clks;
+	}
+
+	if (mcd->mux_clks) {
+		r = mtk_clk_register_muxes(&pdev->dev, mcd->mux_clks,
+					   mcd->num_mux_clks, node,
+					   mcd->clk_lock, clk_data);
+		if (r)
+			goto unregister_factors;
+	};
+
+	if (mcd->composite_clks) {
+		/* We don't check composite_lock because it's optional */
+		r = mtk_clk_register_composites(&pdev->dev,
+						mcd->composite_clks,
+						mcd->num_composite_clks,
+						base, mcd->clk_lock, clk_data);
+		if (r)
+			goto unregister_muxes;
+	}
+
+	if (mcd->clks) {
+		r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks,
+					   mcd->num_clks, clk_data);
+		if (r)
+			goto unregister_composites;
+	}
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -477,12 +542,35 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 			goto unregister_clks;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	return r;
 
 unregister_clks:
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->clks)
+		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+unregister_composites:
+	if (mcd->composite_clks)
+		mtk_clk_unregister_composites(mcd->composite_clks,
+					      mcd->num_composite_clks, clk_data);
+unregister_muxes:
+	if (mcd->mux_clks)
+		mtk_clk_unregister_muxes(mcd->mux_clks,
+					 mcd->num_mux_clks, clk_data);
+unregister_factors:
+	if (mcd->factor_clks)
+		mtk_clk_unregister_factors(mcd->factor_clks,
+					   mcd->num_factor_clks, clk_data);
+unregister_fixed_clks:
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
+					      mcd->num_fixed_clks, clk_data);
 free_data:
 	mtk_free_clk_data(clk_data);
+	if (mcd->shared_io && base)
+		iounmap(base);
+
+	pm_runtime_put(&pdev->dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
@@ -494,7 +582,20 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->clks)
+		mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	if (mcd->composite_clks)
+		mtk_clk_unregister_composites(mcd->composite_clks,
+					      mcd->num_composite_clks, clk_data);
+	if (mcd->mux_clks)
+		mtk_clk_unregister_muxes(mcd->mux_clks,
+					 mcd->num_mux_clks, clk_data);
+	if (mcd->factor_clks)
+		mtk_clk_unregister_factors(mcd->factor_clks,
+					   mcd->num_factor_clks, clk_data);
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
+					      mcd->num_fixed_clks, clk_data);
 	mtk_free_clk_data(clk_data);
 
 	return 0;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 63ae7941aa92..880b3d6d8011 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -149,7 +149,8 @@ struct mtk_composite {
 		.flags = 0,						\
 	}
 
-int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+int mtk_clk_register_composites(struct device *dev,
+				const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
 				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
@@ -195,7 +196,17 @@ void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
+	const struct mtk_composite *composite_clks;
+	size_t num_composite_clks;
+	const struct mtk_fixed_clk *fixed_clks;
+	size_t num_fixed_clks;
+	const struct mtk_fixed_factor *factor_clks;
+	size_t num_factor_clks;
+	const struct mtk_mux *mux_clks;
+	size_t num_mux_clks;
 	const struct mtk_clk_rst_desc *rst_desc;
+	spinlock_t *clk_lock;
+	bool shared_io;
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index ba1720b9e231..c8593554239d 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -154,9 +154,10 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
-static struct clk_hw *mtk_clk_register_mux(const struct mtk_mux *mux,
-				 struct regmap *regmap,
-				 spinlock_t *lock)
+static struct clk_hw *mtk_clk_register_mux(struct device *dev,
+					   const struct mtk_mux *mux,
+					   struct regmap *regmap,
+					   spinlock_t *lock)
 {
 	struct mtk_clk_mux *clk_mux;
 	struct clk_init_data init = {};
@@ -177,7 +178,7 @@ static struct clk_hw *mtk_clk_register_mux(const struct mtk_mux *mux,
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
 
-	ret = clk_hw_register(NULL, &clk_mux->hw);
+	ret = clk_hw_register(dev, &clk_mux->hw);
 	if (ret) {
 		kfree(clk_mux);
 		return ERR_PTR(ret);
@@ -198,7 +199,8 @@ static void mtk_clk_unregister_mux(struct clk_hw *hw)
 	kfree(mux);
 }
 
-int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+int mtk_clk_register_muxes(struct device *dev,
+			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
 			   struct clk_hw_onecell_data *clk_data)
@@ -222,7 +224,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			continue;
 		}
 
-		hw = mtk_clk_register_mux(mux, regmap, lock);
+		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 83ff420f4ebe..7ecb963b0ec6 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -83,7 +83,8 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,		\
 			mtk_mux_clr_set_upd_ops)
 
-int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+int mtk_clk_register_muxes(struct device *dev,
+			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
 			   struct clk_hw_onecell_data *clk_data);
diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 4536ed43f65b..84dce5184a77 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
 	struct vmk80xx_private *devpriv = dev->private;
 	struct usb_interface *intf = comedi_to_usb_interface(dev);
 	struct usb_host_interface *iface_desc = intf->cur_altsetting;
-	struct usb_endpoint_descriptor *ep_desc;
-	int i;
-
-	if (iface_desc->desc.bNumEndpoints != 2)
-		return -ENODEV;
-
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep_desc = &iface_desc->endpoint[i].desc;
-
-		if (usb_endpoint_is_int_in(ep_desc) ||
-		    usb_endpoint_is_bulk_in(ep_desc)) {
-			if (!devpriv->ep_rx)
-				devpriv->ep_rx = ep_desc;
-			continue;
-		}
+	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
+	int ret;
 
-		if (usb_endpoint_is_int_out(ep_desc) ||
-		    usb_endpoint_is_bulk_out(ep_desc)) {
-			if (!devpriv->ep_tx)
-				devpriv->ep_tx = ep_desc;
-			continue;
-		}
-	}
+	if (devpriv->model == VMK8061_MODEL)
+		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
+						&ep_tx_desc, NULL, NULL);
+	else
+		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
+						&ep_rx_desc, &ep_tx_desc);
 
-	if (!devpriv->ep_rx || !devpriv->ep_tx)
+	if (ret)
 		return -ENODEV;
 
+	devpriv->ep_rx = ep_rx_desc;
+	devpriv->ep_tx = ep_tx_desc;
+
 	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
 		return -EINVAL;
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 473ef18421db..748781c25787 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -102,13 +102,6 @@ lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 # https://bugs.llvm.org/show_bug.cgi?id=46480
 STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
 
-#
-# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
-# .bss section, so the .bss section of the EFI stub needs to be included in the
-# .data section of the compressed kernel to ensure initialization. Rename the
-# .bss section here so it's easy to pick out in the linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
 STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index dc50dda40239..55468debd55d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -227,6 +227,15 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
 	if (memattr != NULL) {
+		status = efi_call_proto(memattr, set_memory_attributes,
+					rounded_start,
+					rounded_end - rounded_start,
+					EFI_MEMORY_RO);
+		if (status != EFI_SUCCESS) {
+			efi_warn("Failed to set EFI_MEMORY_RO attribute\n");
+			return status;
+		}
+
 		status = efi_call_proto(memattr, clear_memory_attributes,
 					rounded_start,
 					rounded_end - rounded_start,
@@ -426,9 +435,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
-	struct setup_header *hdr;
-	void *image_base;
+	static struct boot_params boot_params __page_aligned_bss;
+	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -449,57 +457,25 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	image_base = efi_table_attr(image, image_base);
-
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
+	/* Assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
 
 	hdr->type_of_loader = 0x21;
+	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
-
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &boot_params.ext_cmd_line_ptr);
 
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
-
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
@@ -811,7 +787,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_total_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c661e024e13..49a47807c42d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1400,6 +1400,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
+/* Validate operation parameters to prevent potential abuse */
+static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t saddr,
+					  uint64_t offset,
+					  uint64_t size)
+{
+	uint64_t tmp, lpfn;
+
+	if (saddr & AMDGPU_GPU_PAGE_MASK
+	    || offset & AMDGPU_GPU_PAGE_MASK
+	    || size & AMDGPU_GPU_PAGE_MASK)
+		return -EINVAL;
+
+	if (check_add_overflow(saddr, size, &tmp)
+	    || check_add_overflow(offset, size, &tmp)
+	    || size == 0 /* which also leads to end < begin */)
+		return -EINVAL;
+
+	/* make sure object fit at this offset */
+	if (bo && offset + size > amdgpu_bo_size(bo))
+		return -EINVAL;
+
+	/* Ensure last pfn not exceed max_pfn */
+	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
+	if (lpfn >= adev->vm_manager.max_pfn)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_bo_map - map bo inside a vm
  *
@@ -1426,21 +1457,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
+	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
@@ -1493,17 +1517,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	/* Allocate all the needed memory */
 	mapping = kmalloc(sizeof(*mapping), GFP_KERNEL);
@@ -1517,7 +1533,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	}
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
 	mapping->last = eaddr;
@@ -1604,10 +1620,14 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
 	LIST_HEAD(removed);
 	uint64_t eaddr;
+	int r;
+
+	r = amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
+	if (r)
+		return r;
 
-	eaddr = saddr + size - 1;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	/* Allocate all the needed memory */
 	before = kzalloc(sizeof(*before), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66a6f7a37ebc..5a5787bfbce7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1531,44 +1531,70 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);
 }
 
-static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+static u32 gfx_v11_0_get_sa_active_bitmap(struct amdgpu_device *adev)
 {
-	u32 data, mask;
+	u32 gc_disabled_sa_mask, gc_user_disabled_sa_mask, sa_mask;
+
+	gc_disabled_sa_mask = RREG32_SOC15(GC, 0, regCC_GC_SA_UNIT_DISABLE);
+	gc_disabled_sa_mask = REG_GET_FIELD(gc_disabled_sa_mask,
+					   CC_GC_SA_UNIT_DISABLE,
+					   SA_DISABLE);
+	gc_user_disabled_sa_mask = RREG32_SOC15(GC, 0, regGC_USER_SA_UNIT_DISABLE);
+	gc_user_disabled_sa_mask = REG_GET_FIELD(gc_user_disabled_sa_mask,
+						 GC_USER_SA_UNIT_DISABLE,
+						 SA_DISABLE);
+	sa_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+					    adev->gfx.config.max_shader_engines);
 
-	data = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));
+}
 
-	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
-	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
+static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+{
+	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
+	u32 rb_mask;
 
-	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se);
+	gc_disabled_rb_mask = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
+	gc_disabled_rb_mask = REG_GET_FIELD(gc_disabled_rb_mask,
+					    CC_RB_BACKEND_DISABLE,
+					    BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = REG_GET_FIELD(gc_user_disabled_rb_mask,
+						 GC_USER_RB_BACKEND_DISABLE,
+						 BACKEND_DISABLE);
+	rb_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se *
+					    adev->gfx.config.max_shader_engines);
 
-	return (~data) & mask;
+	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
 }
 
 static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 {
-	int i, j;
-	u32 data;
-	u32 active_rbs = 0;
-	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
-					adev->gfx.config.max_sh_per_se;
+	u32 rb_bitmap_width_per_sa;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 active_rb_bitmap = 0;
+	u32 i;
 
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff);
-			data = gfx_v11_0_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
-		}
+	/* query sa bitmap from SA_UNIT_DISABLE registers */
+	active_sa_bitmap = gfx_v11_0_get_sa_active_bitmap(adev);
+	/* query rb bitmap from RB_BACKEND_DISABLE registers */
+	global_active_rb_bitmap = gfx_v11_0_get_rb_active_bitmap(adev);
+
+	/* generate active rb bitmap according to active sa bitmap */
+	max_sa = adev->gfx.config.max_shader_engines *
+		 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
+				 adev->gfx.config.max_sh_per_se;
+	for (i = 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
 	}
-	gfx_v11_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-	mutex_unlock(&adev->grbm_idx_mutex);
 
-	adev->gfx.config.backend_enable_mask = active_rbs;
-	adev->gfx.config.num_rbs = hweight32(active_rbs);
+	active_rb_bitmap &= global_active_rb_bitmap;
+	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
+	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index a974f86e718a..37c645a882dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -216,9 +216,6 @@ static void optc32_setup_manual_trigger(struct timing_generator *optc)
 				OTG_V_TOTAL_MAX_SEL, 1,
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
-
-		// Setup manual flow control for EOF via TRIG_A
-		optc->funcs->setup_manual_trigger(optc);
 	}
 }
 
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3fe5e6439c40..aa93129c3397 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -348,6 +348,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Lenovo Legion Go 8APU1 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* Lenovo Yoga Book X90F / X90L */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index c8ad8f37e5cf..58a03da16a10 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -32,6 +32,7 @@
 #include "gt/intel_engine.h"
 #include "gt/intel_engine_heartbeat.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_requests.h"
 
 #include "i915_drv.h"
@@ -98,12 +99,34 @@ static inline struct i915_vma *active_to_vma(struct i915_active *ref)
 
 static int __i915_vma_active(struct i915_active *ref)
 {
-	return i915_vma_tryget(active_to_vma(ref)) ? 0 : -ENOENT;
+	struct i915_vma *vma = active_to_vma(ref);
+
+	if (!i915_vma_tryget(vma))
+		return -ENOENT;
+
+	/*
+	 * Exclude global GTT VMA from holding a GT wakeref
+	 * while active, otherwise GPU never goes idle.
+	 */
+	if (!i915_vma_is_ggtt(vma))
+		intel_gt_pm_get(vma->vm->gt);
+
+	return 0;
 }
 
 static void __i915_vma_retire(struct i915_active *ref)
 {
-	i915_vma_put(active_to_vma(ref));
+	struct i915_vma *vma = active_to_vma(ref);
+
+	if (!i915_vma_is_ggtt(vma)) {
+		/*
+		 * Since we can be called from atomic contexts,
+		 * use an async variant of intel_gt_pm_put().
+		 */
+		intel_gt_pm_put_async(vma->vm->gt);
+	}
+
+	i915_vma_put(vma);
 }
 
 static struct i915_vma *
@@ -1365,7 +1388,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	struct i915_vma_work *work = NULL;
 	struct dma_fence *moving = NULL;
 	struct i915_vma_resource *vma_res = NULL;
-	intel_wakeref_t wakeref = 0;
+	intel_wakeref_t wakeref;
 	unsigned int bound;
 	int err;
 
@@ -1385,8 +1408,14 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	if (err)
 		return err;
 
-	if (flags & PIN_GLOBAL)
-		wakeref = intel_runtime_pm_get(&vma->vm->i915->runtime_pm);
+	/*
+	 * In case of a global GTT, we must hold a runtime-pm wakeref
+	 * while global PTEs are updated.  In other cases, we hold
+	 * the rpm reference while the VMA is active.  Since runtime
+	 * resume may require allocations, which are forbidden inside
+	 * vm->mutex, get the first rpm wakeref outside of the mutex.
+	 */
+	wakeref = intel_runtime_pm_get(&vma->vm->i915->runtime_pm);
 
 	if (flags & vma->vm->bind_async_flags) {
 		/* lock VM */
@@ -1522,8 +1551,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	if (work)
 		dma_fence_work_commit_imm(&work->base);
 err_rpm:
-	if (wakeref)
-		intel_runtime_pm_put(&vma->vm->i915->runtime_pm, wakeref);
+	intel_runtime_pm_put(&vma->vm->i915->runtime_pm, wakeref);
 
 	if (moving)
 		dma_fence_put(moving);
diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 189903b65edc..48cf593383b3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -23,6 +23,7 @@
  */
 
 #include "nouveau_drv.h"
+#include "nouveau_bios.h"
 #include "nouveau_reg.h"
 #include "dispnv04/hw.h"
 #include "nouveau_encoder.h"
@@ -1675,7 +1676,7 @@ apply_dcb_encoder_quirks(struct drm_device *dev, int idx, u32 *conn, u32 *conf)
 	 */
 	if (nv_match_device(dev, 0x0201, 0x1462, 0x8851)) {
 		if (*conn == 0xf2005014 && *conf == 0xffffffff) {
-			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, 1);
+			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, DCB_OUTPUT_B);
 			return false;
 		}
 	}
@@ -1761,26 +1762,26 @@ fabricate_dcb_encoder_table(struct drm_device *dev, struct nvbios *bios)
 #ifdef __powerpc__
 	/* Apple iMac G4 NV17 */
 	if (of_machine_is_compatible("PowerMac4,5")) {
-		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);
-		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, 2);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, DCB_OUTPUT_C);
 		return;
 	}
 #endif
 
 	/* Make up some sane defaults */
 	fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG,
-			     bios->legacy.i2c_indices.crt, 1, 1);
+			     bios->legacy.i2c_indices.crt, 1, DCB_OUTPUT_B);
 
 	if (nv04_tv_identify(dev, bios->legacy.i2c_indices.tv) >= 0)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TV,
 				     bios->legacy.i2c_indices.tv,
-				     all_heads, 0);
+				     all_heads, DCB_OUTPUT_A);
 
 	else if (bios->tmds.output0_script_ptr ||
 		 bios->tmds.output1_script_ptr)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS,
 				     bios->legacy.i2c_indices.panel,
-				     all_heads, 1);
+				     all_heads, DCB_OUTPUT_B);
 }
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index c51bac76174c..9fe5b6a36ab9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -221,8 +221,11 @@ nv50_instobj_acquire(struct nvkm_memory *memory)
 	void __iomem *map = NULL;
 
 	/* Already mapped? */
-	if (refcount_inc_not_zero(&iobj->maps))
+	if (refcount_inc_not_zero(&iobj->maps)) {
+		/* read barrier match the wmb on refcount set */
+		smp_rmb();
 		return iobj->map;
+	}
 
 	/* Take the lock, and re-check that another thread hasn't
 	 * already mapped the object in the meantime.
@@ -249,6 +252,8 @@ nv50_instobj_acquire(struct nvkm_memory *memory)
 			iobj->base.memory.ptrs = &nv50_instobj_fast;
 		else
 			iobj->base.memory.ptrs = &nv50_instobj_slow;
+		/* barrier to ensure the ptrs are written before refcount is set */
+		smp_wmb();
 		refcount_set(&iobj->maps, 1);
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index ec228c269146..b380bbb0e0d0 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -261,8 +261,6 @@ static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
 	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(ctx->dsi);
-	mipi_dsi_device_unregister(ctx->dsi);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 9d7a1b710f48..53f63ad656a4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -663,11 +663,12 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_populate] = "Caching DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
-	/* TTM currently doesn't fully support SEV encryption. */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return -EINVAL;
-
-	if (vmw_force_coherent)
+	/*
+	 * When running with SEV we always want dma mappings, because
+	 * otherwise ttm tt pool pages will bounce through swiotlb running
+	 * out of available space.
+	 */
+	if (vmw_force_coherent || cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 	else if (vmw_restrict_iommu)
 		dev_priv->map_mode = vmw_dma_map_bind;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index aa571b75cd07..b1aed051b41a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -793,6 +793,7 @@ int vmw_du_cursor_plane_atomic_check(struct drm_plane *plane,
 int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 			     struct drm_atomic_state *state)
 {
+	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
 									 crtc);
 	struct vmw_display_unit *du = vmw_crtc_to_du(new_state->crtc);
@@ -800,9 +801,13 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	bool has_primary = new_state->plane_mask &
 			   drm_plane_mask(crtc->primary);
 
-	/* We always want to have an active plane with an active CRTC */
-	if (has_primary != new_state->enable)
-		return -EINVAL;
+	/*
+	 * This is fine in general, but broken userspace might expect
+	 * some actual rendering so give a clue as why it's blank.
+	 */
+	if (new_state->enable && !has_primary)
+		drm_dbg_driver(&vmw->drm,
+			       "CRTC without a primary plane will be blank.\n");
 
 
 	if (new_state->connector_mask != connector_mask &&
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index b02d2793659f..b116600b343a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -246,10 +246,10 @@ struct vmw_framebuffer_bo {
 
 
 static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 };
 
 static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1be454bafcb9..405d88b08908 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -717,10 +717,10 @@
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
-#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 #define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
 #define USB_DEVICE_ID_KYE_EASYPEN_M406XE	0x5019
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2	0x501A
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index da903138eee4..dc57e9d4a3e2 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -602,6 +602,18 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[74] = 0x08;
 		}
 		break;
+	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
+		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
+					"Genius Gila Gaming Mouse");
+		break;
+	case USB_DEVICE_ID_GENIUS_MANTICORE:
+		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
+					"Genius Manticore Keyboard");
+		break;
+	case USB_DEVICE_ID_GENIUS_GX_IMPERATOR:
+		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
+					"Genius Gx Imperator Keyboard");
+		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 		if (*rsize == EASYPEN_I405X_RDESC_ORIG_SIZE) {
 			rdesc = easypen_i405x_rdesc_fixed;
@@ -638,18 +650,6 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(pensketch_m912_rdesc_fixed);
 		}
 		break;
-	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
-		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
-					"Genius Gila Gaming Mouse");
-		break;
-	case USB_DEVICE_ID_GENIUS_GX_IMPERATOR:
-		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
-					"Genius Gx Imperator Keyboard");
-		break;
-	case USB_DEVICE_ID_GENIUS_MANTICORE:
-		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
-					"Genius Manticore Keyboard");
-		break;
 	}
 	return rdesc;
 }
@@ -717,26 +717,26 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	switch (id->product) {
+	case USB_DEVICE_ID_GENIUS_MANTICORE:
+		/*
+		 * The manticore keyboard needs to have all the interfaces
+		 * opened at least once to be fully functional.
+		 */
+		if (hid_hw_open(hdev))
+			hid_hw_close(hdev);
+		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
 			goto enabling_err;
 		}
 		break;
-	case USB_DEVICE_ID_GENIUS_MANTICORE:
-		/*
-		 * The manticore keyboard needs to have all the interfaces
-		 * opened at least once to be fully functional.
-		 */
-		if (hid_hw_open(hdev))
-			hid_hw_close(hdev);
-		break;
 	}
 
 	return 0;
@@ -749,23 +749,23 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static const struct hid_device_id kye_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
+				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+				USB_DEVICE_ID_GENIUS_MANTICORE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
+				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
+				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
+				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
+				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_GENIUS_MANTICORE) },
+				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
-				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 60884066362a..debc49272a5c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -107,12 +107,12 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 462a10d6a576..950fe205995b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1026,23 +1026,26 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
+						enum ib_cm_state old_state)
 {
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
-	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
+	enum ib_cm_state old_state;
 	struct cm_work *work;
 	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
+	old_state = cm_id->state;
 retest:
 	switch (cm_id->state) {
 	case IB_CM_LISTEN:
@@ -1151,7 +1154,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 						  msecs_to_jiffies(
 						  CM_DESTROY_ID_WAIT_TIMEOUT));
 		if (!ret) /* timeout happened */
-			cm_destroy_id_wait_timeout(cm_id);
+			cm_destroy_id_wait_timeout(cm_id, old_state);
 	} while (!ret);
 
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 9c8a7b206dcf..e61efed320f1 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -188,7 +188,8 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 		mdev = dev->mdev;
 		mdev_port_num = 1;
 	}
-	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1) {
+	if (MLX5_CAP_GEN(dev->mdev, num_ports) == 1 &&
+	    !mlx5_core_mp_enabled(mdev)) {
 		/* set local port to one for Function-Per-Port HCA. */
 		mdev = dev->mdev;
 		mdev_port_num = 1;
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 51daac5c4feb..be3ddfbf3cae 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -33,6 +33,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
+
+	mutex_destroy(&rxe->usdev_lock);
 }
 
 /* initialize rxe device parameters */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index f8219cbd2c7c..a617f64a351d 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -116,7 +116,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_P, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_N, MEI_ME_PCH15_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_SPS_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d4515c19a5f3..1aba0cf38630 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -419,6 +419,20 @@ static void mt7530_pll_setup(struct mt7530_priv *priv)
 	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
 }
 
+/* If port 6 is available as a CPU port, always prefer that as the default,
+ * otherwise don't care.
+ */
+static struct dsa_port *
+mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp = dsa_to_port(ds, 6);
+
+	if (dsa_port_is_cpu(cpu_dp))
+		return cpu_dp;
+
+	return NULL;
+}
+
 /* Setup port 6 interface mode and TRGMII TX circuit */
 static int
 mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
@@ -1236,6 +1250,13 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
+	/* Add the CPU port to the CPU port bitmap for MT7531. Trapped frames
+	 * will be forwarded to the CPU port that is affine to the inbound user
+	 * port.
+	 */
+	if (priv->id == ID_MT7531)
+		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
+
 	/* CPU port gets connected to all user ports of
 	 * the switch.
 	 */
@@ -2413,8 +2434,6 @@ mt7530_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7530_pll_setup(priv);
-
 	/* Lower Tx driving for TRGMII path */
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
 		mt7530_write(priv, MT7530_TRGMII_TD_ODT(i),
@@ -2432,6 +2451,9 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_40MHZ)
+		mt7530_pll_setup(priv);
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2461,6 +2483,9 @@ mt7530_setup(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
 	if (ret)
@@ -2531,16 +2556,8 @@ static int
 mt7531_setup_common(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
-	struct dsa_port *cpu_dp;
 	int ret, i;
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2577,6 +2594,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Flush the FDB table */
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
@@ -2655,18 +2675,25 @@ mt7531_setup(struct dsa_switch *ds)
 	priv->p5_interface = PHY_INTERFACE_MODE_NA;
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
-	/* Enable PHY core PLL, since phy_device has not yet been created
-	 * provided for phy_[read,write]_mmd_indirect is called, we provide
-	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
-	 * function.
+	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
+	 * phy_device has not yet been created provided for
+	 * phy_[read,write]_mmd_indirect is called, we provide our own
+	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
 	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
 				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
-	val |= MT7531_PHY_PLL_BYPASS_MODE;
+	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
 	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
@@ -3400,6 +3427,7 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 2d1ea390f05a..6441e8d7f05d 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -31,6 +31,10 @@ enum mt753x_id {
 #define SYSC_REG_RSTCTRL		0x34
 #define  RESET_MCM			BIT(2)
 
+/* Register for ARL global control */
+#define MT753X_AGC			0xc
+#define  LOCAL_EN			BIT(7)
+
 /* Registers to mac forward control for unknown frames */
 #define MT7530_MFC			0x10
 #define  BC_FFP(x)			(((x) & 0xff) << 24)
@@ -53,6 +57,7 @@ enum mt753x_id {
 #define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
 #define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
 #define  MT7531_CPU_PMAP_MASK		GENMASK(7, 0)
+#define  MT7531_CPU_PMAP(x)		FIELD_PREP(MT7531_CPU_PMAP_MASK, x)
 
 #define MT753X_MIRROR_REG(id)		(((id) == ID_MT7531) ? \
 					 MT7531_CFC : MT7530_MFC)
@@ -668,6 +673,7 @@ enum mt7531_clk_skew {
 #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
 #define  RG_SYSPLL_BIAS_EN		BIT(11)
 #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 652ef09eeb30..ec6628aacc13 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -663,7 +663,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	int ret;
 	int i;
 
-	if (!flags || (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT)) {
+	if (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported encap field(s)");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 58eacba6de8c..ad51edf55318 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -45,6 +45,10 @@ struct arfs_table {
 	struct hlist_head	 rules_hash[ARFS_HASH_SIZE];
 };
 
+enum {
+	MLX5E_ARFS_STATE_ENABLED,
+};
+
 enum arfs_type {
 	ARFS_IPV4_TCP,
 	ARFS_IPV6_TCP,
@@ -60,6 +64,7 @@ struct mlx5e_arfs_tables {
 	struct list_head               rules;
 	int                            last_filter_id;
 	struct workqueue_struct        *wq;
+	unsigned long                  state;
 };
 
 struct arfs_tuple {
@@ -170,6 +175,8 @@ int mlx5e_arfs_enable(struct mlx5e_flow_steering *fs)
 			return err;
 		}
 	}
+	set_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	return 0;
 }
 
@@ -454,6 +461,8 @@ static void arfs_del_rules(struct mlx5e_flow_steering *fs)
 	int i;
 	int j;
 
+	clear_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	spin_lock_bh(&arfs->arfs_lock);
 	mlx5e_for_each_arfs_rule(rule, htmp, arfs->arfs_tables, i, j) {
 		hlist_del_init(&rule->hlist);
@@ -621,17 +630,8 @@ static void arfs_handle_work(struct work_struct *work)
 	struct mlx5_flow_handle *rule;
 
 	arfs = mlx5e_fs_get_arfs(priv->fs);
-	mutex_lock(&priv->state_lock);
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
-		spin_lock_bh(&arfs->arfs_lock);
-		hlist_del(&arfs_rule->hlist);
-		spin_unlock_bh(&arfs->arfs_lock);
-
-		mutex_unlock(&priv->state_lock);
-		kfree(arfs_rule);
-		goto out;
-	}
-	mutex_unlock(&priv->state_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state))
+		return;
 
 	if (!arfs_rule->rule) {
 		rule = arfs_add_rule(priv, arfs_rule);
@@ -744,6 +744,11 @@ int mlx5e_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		return -EPROTONOSUPPORT;
 
 	spin_lock_bh(&arfs->arfs_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state)) {
+		spin_unlock_bh(&arfs->arfs_lock);
+		return -EPERM;
+	}
+
 	arfs_rule = arfs_find_rule(arfs_t, &fk);
 	if (arfs_rule) {
 		if (arfs_rule->rxq == rxq_index) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ad32b80e8501..01c0e1ee918d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -679,8 +679,10 @@ static int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 		return err;
 	}
 
-	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags))
+	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags)) {
 		mlx5_lag_port_sel_destroy(ldev);
+		ldev->buckets = 1;
+	}
 	if (mlx5_lag_has_drop_rule(ldev))
 		mlx5_lag_drop_rule_cleanup(ldev);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 76fabeae512d..33df06a2de13 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2549,6 +2549,8 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 
 static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 {
+	struct am65_cpsw_rx_chn *rx_chan = &common->rx_chns;
+	struct am65_cpsw_tx_chn *tx_chan = common->tx_chns;
 	struct device *dev = common->dev;
 	struct devlink_port *dl_port;
 	struct am65_cpsw_port *port;
@@ -2567,6 +2569,22 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		return ret;
 	}
 
+	/* The DMA Channels are not guaranteed to be in a clean state.
+	 * Reset and disable them to ensure that they are back to the
+	 * clean state and ready to be used.
+	 */
+	for (i = 0; i < common->tx_ch_num; i++) {
+		k3_udma_glue_reset_tx_chn(tx_chan[i].tx_chn, &tx_chan[i],
+					  am65_cpsw_nuss_tx_cleanup);
+		k3_udma_glue_disable_tx_chn(tx_chan[i].tx_chn);
+	}
+
+	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
+		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i, rx_chan,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
+
+	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
+
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 922d6f16d99d..4af1ba5d074c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2121,14 +2121,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 					    tun_is_little_endian(tun), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
-			pr_err("unexpected GSO type: "
-			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+
+			if (net_ratelimit()) {
+				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+					   tun16_to_cpu(tun, gso.hdr_len));
+				print_hex_dump(KERN_ERR, "tun: ",
+					       DUMP_PREFIX_NONE,
+					       16, 1, skb->head,
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index e0e9b4c53cb0..3078511f7608 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1317,6 +1317,8 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
+	ax88179_reset(dev);
+
 	return 0;
 }
 
@@ -1695,7 +1697,6 @@ static const struct driver_info ax88179_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1708,7 +1709,6 @@ static const struct driver_info ax88178a_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index feafa378bf8e..aa2fba1c0f56 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -379,21 +379,8 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
 
-/** pci_walk_bus - walk devices on/under bus, calling callback.
- *  @top      bus whose devices should be walked
- *  @cb       callback to be called for each device found
- *  @userdata arbitrary pointer to be passed to callback.
- *
- *  Walk the given bus, including any bridged devices
- *  on buses under this bus.  Call the provided callback
- *  on each device found.
- *
- *  We check the return of @cb each time. If it returns anything
- *  other than 0, we break out.
- *
- */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			   void *userdata, bool locked)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -401,7 +388,8 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 	int retval;
 
 	bus = top;
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -424,10 +412,37 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		if (retval)
 			break;
 	}
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
+}
+
+/**
+ *  pci_walk_bus - walk devices on/under bus, calling callback.
+ *  @top: bus whose devices should be walked
+ *  @cb: callback to be called for each device found
+ *  @userdata: arbitrary pointer to be passed to callback
+ *
+ *  Walk the given bus, including any bridged devices
+ *  on buses under this bus.  Call the provided callback
+ *  on each device found.
+ *
+ *  We check the return of @cb each time. If it returns anything
+ *  other than 0, we break out.
+ */
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	__pci_walk_bus(top, cb, userdata, false);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	__pci_walk_bus(top, cb, userdata, true);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
+
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
 	if (bus)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5368a37154cf..67956bfebf87 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1258,6 +1258,7 @@ int pci_power_up(struct pci_dev *dev)
 /**
  * pci_set_full_power_state - Put a PCI device into D0 and update its state
  * @dev: PCI device to power up
+ * @locked: whether pci_bus_sem is held
  *
  * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
  * to confirm the state change, restore its BARs if they might be lost and
@@ -1267,7 +1268,7 @@ int pci_power_up(struct pci_dev *dev)
  * to D0, it is more efficient to use pci_power_up() directly instead of this
  * function.
  */
-static int pci_set_full_power_state(struct pci_dev *dev)
+static int pci_set_full_power_state(struct pci_dev *dev, bool locked)
 {
 	u16 pmcsr;
 	int ret;
@@ -1303,7 +1304,7 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 	}
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
@@ -1332,10 +1333,22 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
 		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
 }
 
+static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state, bool locked)
+{
+	if (!bus)
+		return;
+
+	if (locked)
+		pci_walk_bus_locked(bus, __pci_dev_set_current_state, &state);
+	else
+		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
+}
+
 /**
  * pci_set_low_power_state - Put a PCI device into a low-power state.
  * @dev: PCI device to handle.
  * @state: PCI power state (D1, D2, D3hot) to put the device into.
+ * @locked: whether pci_bus_sem is held
  *
  * Use the device's PCI_PM_CTRL register to put it into a low-power state.
  *
@@ -1346,7 +1359,7 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
  * 0 if device already is in the requested state.
  * 0 if device's power state has been successfully changed.
  */
-static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	u16 pmcsr;
 
@@ -1400,29 +1413,12 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
 				     pci_power_name(state));
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
 
-/**
- * pci_set_power_state - Set the power state of a PCI device
- * @dev: PCI device to handle.
- * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
- *
- * Transition a device to a new power state, using the platform firmware and/or
- * the device's PCI PM registers.
- *
- * RETURN VALUE:
- * -EINVAL if the requested state is invalid.
- * -EIO if device does not support PCI PM or its PM capabilities register has a
- * wrong version, or device doesn't support the requested state.
- * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
- * 0 if device already is in the requested state.
- * 0 if the transition is to D3 but D3 is not supported.
- * 0 if device's power state has been successfully changed.
- */
-int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int __pci_set_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	int error;
 
@@ -1446,7 +1442,7 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_set_full_power_state(dev);
+		return pci_set_full_power_state(dev, locked);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
@@ -1460,16 +1456,16 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		 * To put the device in D3cold, put it into D3hot in the native
 		 * way, then put it into D3cold using platform ops.
 		 */
-		error = pci_set_low_power_state(dev, PCI_D3hot);
+		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
 
 		if (pci_platform_power_transition(dev, PCI_D3cold))
 			return error;
 
 		/* Powering off a bridge may power off the whole hierarchy */
 		if (dev->current_state == PCI_D3cold)
-			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+			__pci_bus_set_current_state(dev->subordinate, PCI_D3cold, locked);
 	} else {
-		error = pci_set_low_power_state(dev, state);
+		error = pci_set_low_power_state(dev, state, locked);
 
 		if (pci_platform_power_transition(dev, state))
 			return error;
@@ -1477,8 +1473,38 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	return 0;
 }
+
+/**
+ * pci_set_power_state - Set the power state of a PCI device
+ * @dev: PCI device to handle.
+ * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ *
+ * Transition a device to a new power state, using the platform firmware and/or
+ * the device's PCI PM registers.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
+ * 0 if device already is in the requested state.
+ * 0 if the transition is to D3 but D3 is not supported.
+ * 0 if device's power state has been successfully changed.
+ */
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	return __pci_set_power_state(dev, state, false);
+}
 EXPORT_SYMBOL(pci_set_power_state);
 
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	return __pci_set_power_state(dev, state, true);
+}
+EXPORT_SYMBOL(pci_set_power_state_locked);
+
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9950deeb047a..88576a22fecb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -556,12 +556,12 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 25736d408e88..cf4acea6610d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -743,10 +743,10 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 * in pcie_config_aspm_link().
 	 */
 	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
-		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPM_L1);
 	}
 
 	val = 0;
@@ -1055,8 +1055,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+/*
+ * @pdev: the root port or switch downstream port
+ * @locked: whether pci_bus_sem is held
+ */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
 {
 	struct pcie_link_state *link = pdev->link_state;
 
@@ -1066,12 +1069,14 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 	 * Devices changed PM state, we should recheck if latency
 	 * meets all functions' requirement
 	 */
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	pcie_update_aspm_capable(link->root);
 	pcie_config_aspm_path(link);
 	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
 }
 
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 08800282825e..acdbf9e770a8 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -9,6 +9,7 @@
 #define dev_fmt(fmt) "DPC: " fmt
 
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -203,7 +204,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
-	first_error = (dpc_status & 0x1f00) >> 8;
+	first_error = FIELD_GET(PCI_EXP_DPC_RP_PIO_FEP, dpc_status);
 
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if ((status & ~mask) & (1 << i))
@@ -339,7 +340,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
 	if (!pdev->dpc_rp_log_size) {
 		pdev->dpc_rp_log_size =
-			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
 		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 289ba6902e41..56dce858a693 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2425,9 +2425,9 @@ static void quirk_enable_clear_retrain_link(struct pci_dev *dev)
 	dev->clear_retrain_link = 1;
 	pci_info(dev, "Enable PCIe Retrain Link quirk\n");
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe110, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe111, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe130, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe110, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe111, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PERICOM, 0xe130, quirk_enable_clear_retrain_link);
 
 static void fixup_rev1_53c810(struct pci_dev *dev)
 {
@@ -4011,10 +4011,11 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 }
 
 /*
- * Intel DC P3700 NVMe controller will timeout waiting for ready status
- * to change after NVMe enable if the driver starts interacting with the
- * device too soon after FLR.  A 250ms delay after FLR has heuristically
- * proven to produce reliably working results for device assignment cases.
+ * Some NVMe controllers such as Intel DC P3700 and Solidigm P44 Pro will
+ * timeout waiting for ready status to change after NVMe enable if the driver
+ * starts interacting with the device too soon after FLR.  A 250ms delay after
+ * FLR has heuristically proven to produce reliably working results for device
+ * assignment cases.
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
@@ -4101,6 +4102,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0a54, delay_250ms_after_flr },
+	{ PCI_VENDOR_ID_SOLIDIGM, 0xf1ac, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
@@ -4474,9 +4476,9 @@ static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
 
 	pci_info(root_port, "Disabling No Snoop/Relaxed Ordering Attributes to avoid PCIe Completion erratum in %s\n",
 		 dev_name(&pdev->dev));
-	pcie_capability_clear_and_set_word(root_port, PCI_EXP_DEVCTL,
-					   PCI_EXP_DEVCTL_RELAX_EN |
-					   PCI_EXP_DEVCTL_NOSNOOP_EN, 0);
+	pcie_capability_clear_word(root_port, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN |
+				   PCI_EXP_DEVCTL_NOSNOOP_EN);
 }
 
 /*
@@ -5403,6 +5405,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 
+/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
+static void quirk_no_flr_snet(struct pci_dev *dev)
+{
+	if (dev->revision == 0x1)
+		quirk_no_flr(dev);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
+
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
@@ -5808,6 +5818,42 @@ SWITCHTEC_QUIRK(0x4428);  /* PSXA 28XG4 */
 SWITCHTEC_QUIRK(0x4552);  /* PAXA 52XG4 */
 SWITCHTEC_QUIRK(0x4536);  /* PAXA 36XG4 */
 SWITCHTEC_QUIRK(0x4528);  /* PAXA 28XG4 */
+SWITCHTEC_QUIRK(0x5000);  /* PFX 100XG5 */
+SWITCHTEC_QUIRK(0x5084);  /* PFX 84XG5 */
+SWITCHTEC_QUIRK(0x5068);  /* PFX 68XG5 */
+SWITCHTEC_QUIRK(0x5052);  /* PFX 52XG5 */
+SWITCHTEC_QUIRK(0x5036);  /* PFX 36XG5 */
+SWITCHTEC_QUIRK(0x5028);  /* PFX 28XG5 */
+SWITCHTEC_QUIRK(0x5100);  /* PSX 100XG5 */
+SWITCHTEC_QUIRK(0x5184);  /* PSX 84XG5 */
+SWITCHTEC_QUIRK(0x5168);  /* PSX 68XG5 */
+SWITCHTEC_QUIRK(0x5152);  /* PSX 52XG5 */
+SWITCHTEC_QUIRK(0x5136);  /* PSX 36XG5 */
+SWITCHTEC_QUIRK(0x5128);  /* PSX 28XG5 */
+SWITCHTEC_QUIRK(0x5200);  /* PAX 100XG5 */
+SWITCHTEC_QUIRK(0x5284);  /* PAX 84XG5 */
+SWITCHTEC_QUIRK(0x5268);  /* PAX 68XG5 */
+SWITCHTEC_QUIRK(0x5252);  /* PAX 52XG5 */
+SWITCHTEC_QUIRK(0x5236);  /* PAX 36XG5 */
+SWITCHTEC_QUIRK(0x5228);  /* PAX 28XG5 */
+SWITCHTEC_QUIRK(0x5300);  /* PFXA 100XG5 */
+SWITCHTEC_QUIRK(0x5384);  /* PFXA 84XG5 */
+SWITCHTEC_QUIRK(0x5368);  /* PFXA 68XG5 */
+SWITCHTEC_QUIRK(0x5352);  /* PFXA 52XG5 */
+SWITCHTEC_QUIRK(0x5336);  /* PFXA 36XG5 */
+SWITCHTEC_QUIRK(0x5328);  /* PFXA 28XG5 */
+SWITCHTEC_QUIRK(0x5400);  /* PSXA 100XG5 */
+SWITCHTEC_QUIRK(0x5484);  /* PSXA 84XG5 */
+SWITCHTEC_QUIRK(0x5468);  /* PSXA 68XG5 */
+SWITCHTEC_QUIRK(0x5452);  /* PSXA 52XG5 */
+SWITCHTEC_QUIRK(0x5436);  /* PSXA 36XG5 */
+SWITCHTEC_QUIRK(0x5428);  /* PSXA 28XG5 */
+SWITCHTEC_QUIRK(0x5500);  /* PAXA 100XG5 */
+SWITCHTEC_QUIRK(0x5584);  /* PAXA 84XG5 */
+SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
+SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
+SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
+SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
@@ -6057,7 +6103,7 @@ static void dpc_log_size(struct pci_dev *dev)
 	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
 
-	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
+	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
 		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
 		dev->dpc_rp_log_size = 4;
 	}
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index d05a482639e3..332af6938d7f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -372,7 +372,7 @@ static ssize_t field ## _show(struct device *dev, \
 	if (stdev->gen == SWITCHTEC_GEN3) \
 		return io_string_show(buf, &si->gen3.field, \
 				      sizeof(si->gen3.field)); \
-	else if (stdev->gen == SWITCHTEC_GEN4) \
+	else if (stdev->gen >= SWITCHTEC_GEN4) \
 		return io_string_show(buf, &si->gen4.field, \
 				      sizeof(si->gen4.field)); \
 	else \
@@ -663,7 +663,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	if (stdev->gen == SWITCHTEC_GEN3) {
 		info.flash_length = ioread32(&fi->gen3.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		info.flash_length = ioread32(&fi->gen4.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
@@ -870,7 +870,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		ret = flash_part_info_gen3(stdev, &info);
 		if (ret)
 			return ret;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		ret = flash_part_info_gen4(stdev, &info);
 		if (ret)
 			return ret;
@@ -1606,7 +1606,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 
 	if (stdev->gen == SWITCHTEC_GEN3)
 		part_id = &stdev->mmio_sys_info->gen3.partition_id;
-	else if (stdev->gen == SWITCHTEC_GEN4)
+	else if (stdev->gen >= SWITCHTEC_GEN4)
 		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
 		return -EOPNOTSUPP;
@@ -1740,63 +1740,99 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	}
 
 static const struct pci_device_id switchtec_pci_tbl[] = {
-	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  //PFX 24xG3
-	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  //PFX 32xG3
-	SWITCHTEC_PCI_DEVICE(0x8533, SWITCHTEC_GEN3),  //PFX 48xG3
-	SWITCHTEC_PCI_DEVICE(0x8534, SWITCHTEC_GEN3),  //PFX 64xG3
-	SWITCHTEC_PCI_DEVICE(0x8535, SWITCHTEC_GEN3),  //PFX 80xG3
-	SWITCHTEC_PCI_DEVICE(0x8536, SWITCHTEC_GEN3),  //PFX 96xG3
-	SWITCHTEC_PCI_DEVICE(0x8541, SWITCHTEC_GEN3),  //PSX 24xG3
-	SWITCHTEC_PCI_DEVICE(0x8542, SWITCHTEC_GEN3),  //PSX 32xG3
-	SWITCHTEC_PCI_DEVICE(0x8543, SWITCHTEC_GEN3),  //PSX 48xG3
-	SWITCHTEC_PCI_DEVICE(0x8544, SWITCHTEC_GEN3),  //PSX 64xG3
-	SWITCHTEC_PCI_DEVICE(0x8545, SWITCHTEC_GEN3),  //PSX 80xG3
-	SWITCHTEC_PCI_DEVICE(0x8546, SWITCHTEC_GEN3),  //PSX 96xG3
-	SWITCHTEC_PCI_DEVICE(0x8551, SWITCHTEC_GEN3),  //PAX 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8552, SWITCHTEC_GEN3),  //PAX 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8553, SWITCHTEC_GEN3),  //PAX 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8554, SWITCHTEC_GEN3),  //PAX 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8555, SWITCHTEC_GEN3),  //PAX 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8556, SWITCHTEC_GEN3),  //PAX 96XG3
-	SWITCHTEC_PCI_DEVICE(0x8561, SWITCHTEC_GEN3),  //PFXL 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8562, SWITCHTEC_GEN3),  //PFXL 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8563, SWITCHTEC_GEN3),  //PFXL 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8564, SWITCHTEC_GEN3),  //PFXL 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8565, SWITCHTEC_GEN3),  //PFXL 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8566, SWITCHTEC_GEN3),  //PFXL 96XG3
-	SWITCHTEC_PCI_DEVICE(0x8571, SWITCHTEC_GEN3),  //PFXI 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8572, SWITCHTEC_GEN3),  //PFXI 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8573, SWITCHTEC_GEN3),  //PFXI 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8574, SWITCHTEC_GEN3),  //PFXI 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8575, SWITCHTEC_GEN3),  //PFXI 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8576, SWITCHTEC_GEN3),  //PFXI 96XG3
-	SWITCHTEC_PCI_DEVICE(0x4000, SWITCHTEC_GEN4),  //PFX 100XG4
-	SWITCHTEC_PCI_DEVICE(0x4084, SWITCHTEC_GEN4),  //PFX 84XG4
-	SWITCHTEC_PCI_DEVICE(0x4068, SWITCHTEC_GEN4),  //PFX 68XG4
-	SWITCHTEC_PCI_DEVICE(0x4052, SWITCHTEC_GEN4),  //PFX 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4036, SWITCHTEC_GEN4),  //PFX 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4028, SWITCHTEC_GEN4),  //PFX 28XG4
-	SWITCHTEC_PCI_DEVICE(0x4100, SWITCHTEC_GEN4),  //PSX 100XG4
-	SWITCHTEC_PCI_DEVICE(0x4184, SWITCHTEC_GEN4),  //PSX 84XG4
-	SWITCHTEC_PCI_DEVICE(0x4168, SWITCHTEC_GEN4),  //PSX 68XG4
-	SWITCHTEC_PCI_DEVICE(0x4152, SWITCHTEC_GEN4),  //PSX 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4136, SWITCHTEC_GEN4),  //PSX 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4128, SWITCHTEC_GEN4),  //PSX 28XG4
-	SWITCHTEC_PCI_DEVICE(0x4200, SWITCHTEC_GEN4),  //PAX 100XG4
-	SWITCHTEC_PCI_DEVICE(0x4284, SWITCHTEC_GEN4),  //PAX 84XG4
-	SWITCHTEC_PCI_DEVICE(0x4268, SWITCHTEC_GEN4),  //PAX 68XG4
-	SWITCHTEC_PCI_DEVICE(0x4252, SWITCHTEC_GEN4),  //PAX 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4236, SWITCHTEC_GEN4),  //PAX 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4228, SWITCHTEC_GEN4),  //PAX 28XG4
-	SWITCHTEC_PCI_DEVICE(0x4352, SWITCHTEC_GEN4),  //PFXA 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4336, SWITCHTEC_GEN4),  //PFXA 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4328, SWITCHTEC_GEN4),  //PFXA 28XG4
-	SWITCHTEC_PCI_DEVICE(0x4452, SWITCHTEC_GEN4),  //PSXA 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4436, SWITCHTEC_GEN4),  //PSXA 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4428, SWITCHTEC_GEN4),  //PSXA 28XG4
-	SWITCHTEC_PCI_DEVICE(0x4552, SWITCHTEC_GEN4),  //PAXA 52XG4
-	SWITCHTEC_PCI_DEVICE(0x4536, SWITCHTEC_GEN4),  //PAXA 36XG4
-	SWITCHTEC_PCI_DEVICE(0x4528, SWITCHTEC_GEN4),  //PAXA 28XG4
+	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8533, SWITCHTEC_GEN3),  /* PFX 48xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8534, SWITCHTEC_GEN3),  /* PFX 64xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8535, SWITCHTEC_GEN3),  /* PFX 80xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8536, SWITCHTEC_GEN3),  /* PFX 96xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8541, SWITCHTEC_GEN3),  /* PSX 24xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8542, SWITCHTEC_GEN3),  /* PSX 32xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8543, SWITCHTEC_GEN3),  /* PSX 48xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8544, SWITCHTEC_GEN3),  /* PSX 64xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8545, SWITCHTEC_GEN3),  /* PSX 80xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8546, SWITCHTEC_GEN3),  /* PSX 96xG3 */
+	SWITCHTEC_PCI_DEVICE(0x8551, SWITCHTEC_GEN3),  /* PAX 24XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8552, SWITCHTEC_GEN3),  /* PAX 32XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8553, SWITCHTEC_GEN3),  /* PAX 48XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8554, SWITCHTEC_GEN3),  /* PAX 64XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8555, SWITCHTEC_GEN3),  /* PAX 80XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8556, SWITCHTEC_GEN3),  /* PAX 96XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8561, SWITCHTEC_GEN3),  /* PFXL 24XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8562, SWITCHTEC_GEN3),  /* PFXL 32XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8563, SWITCHTEC_GEN3),  /* PFXL 48XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8564, SWITCHTEC_GEN3),  /* PFXL 64XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8565, SWITCHTEC_GEN3),  /* PFXL 80XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8566, SWITCHTEC_GEN3),  /* PFXL 96XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8571, SWITCHTEC_GEN3),  /* PFXI 24XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8572, SWITCHTEC_GEN3),  /* PFXI 32XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8573, SWITCHTEC_GEN3),  /* PFXI 48XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8574, SWITCHTEC_GEN3),  /* PFXI 64XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8575, SWITCHTEC_GEN3),  /* PFXI 80XG3 */
+	SWITCHTEC_PCI_DEVICE(0x8576, SWITCHTEC_GEN3),  /* PFXI 96XG3 */
+	SWITCHTEC_PCI_DEVICE(0x4000, SWITCHTEC_GEN4),  /* PFX 100XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4084, SWITCHTEC_GEN4),  /* PFX 84XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4068, SWITCHTEC_GEN4),  /* PFX 68XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4052, SWITCHTEC_GEN4),  /* PFX 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4036, SWITCHTEC_GEN4),  /* PFX 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4028, SWITCHTEC_GEN4),  /* PFX 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4100, SWITCHTEC_GEN4),  /* PSX 100XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4184, SWITCHTEC_GEN4),  /* PSX 84XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4168, SWITCHTEC_GEN4),  /* PSX 68XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4152, SWITCHTEC_GEN4),  /* PSX 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4136, SWITCHTEC_GEN4),  /* PSX 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4128, SWITCHTEC_GEN4),  /* PSX 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4200, SWITCHTEC_GEN4),  /* PAX 100XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4284, SWITCHTEC_GEN4),  /* PAX 84XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4268, SWITCHTEC_GEN4),  /* PAX 68XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4252, SWITCHTEC_GEN4),  /* PAX 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4236, SWITCHTEC_GEN4),  /* PAX 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4228, SWITCHTEC_GEN4),  /* PAX 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4352, SWITCHTEC_GEN4),  /* PFXA 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4336, SWITCHTEC_GEN4),  /* PFXA 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4328, SWITCHTEC_GEN4),  /* PFXA 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4452, SWITCHTEC_GEN4),  /* PSXA 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4436, SWITCHTEC_GEN4),  /* PSXA 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4428, SWITCHTEC_GEN4),  /* PSXA 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4552, SWITCHTEC_GEN4),  /* PAXA 52XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4536, SWITCHTEC_GEN4),  /* PAXA 36XG4 */
+	SWITCHTEC_PCI_DEVICE(0x4528, SWITCHTEC_GEN4),  /* PAXA 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x5000, SWITCHTEC_GEN5),  /* PFX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5084, SWITCHTEC_GEN5),  /* PFX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5068, SWITCHTEC_GEN5),  /* PFX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5052, SWITCHTEC_GEN5),  /* PFX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5036, SWITCHTEC_GEN5),  /* PFX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5028, SWITCHTEC_GEN5),  /* PFX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5100, SWITCHTEC_GEN5),  /* PSX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5184, SWITCHTEC_GEN5),  /* PSX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5168, SWITCHTEC_GEN5),  /* PSX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5152, SWITCHTEC_GEN5),  /* PSX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5136, SWITCHTEC_GEN5),  /* PSX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5128, SWITCHTEC_GEN5),  /* PSX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5200, SWITCHTEC_GEN5),  /* PAX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5284, SWITCHTEC_GEN5),  /* PAX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5268, SWITCHTEC_GEN5),  /* PAX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5252, SWITCHTEC_GEN5),  /* PAX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5236, SWITCHTEC_GEN5),  /* PAX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5228, SWITCHTEC_GEN5),  /* PAX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5300, SWITCHTEC_GEN5),  /* PFXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5384, SWITCHTEC_GEN5),  /* PFXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5368, SWITCHTEC_GEN5),  /* PFXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5352, SWITCHTEC_GEN5),  /* PFXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5336, SWITCHTEC_GEN5),  /* PFXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5328, SWITCHTEC_GEN5),  /* PFXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5400, SWITCHTEC_GEN5),  /* PSXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5484, SWITCHTEC_GEN5),  /* PSXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5468, SWITCHTEC_GEN5),  /* PSXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5452, SWITCHTEC_GEN5),  /* PSXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5436, SWITCHTEC_GEN5),  /* PSXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5428, SWITCHTEC_GEN5),  /* PSXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5500, SWITCHTEC_GEN5),  /* PAXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5584, SWITCHTEC_GEN5),  /* PAXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5568, SWITCHTEC_GEN5),  /* PAXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 02813b63f90f..5666b9cc5d29 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -360,10 +360,8 @@ int ccw_device_set_online(struct ccw_device *cdev)
 
 	spin_lock_irq(cdev->ccwlock);
 	ret = ccw_device_online(cdev);
-	spin_unlock_irq(cdev->ccwlock);
-	if (ret == 0)
-		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	else {
+	if (ret) {
+		spin_unlock_irq(cdev->ccwlock);
 		CIO_MSG_EVENT(0, "ccw_device_online returned %d, "
 			      "device 0.%x.%04x\n",
 			      ret, cdev->private->dev_id.ssid,
@@ -372,7 +370,12 @@ int ccw_device_set_online(struct ccw_device *cdev)
 		put_device(&cdev->dev);
 		return ret;
 	}
-	spin_lock_irq(cdev->ccwlock);
+	/* Wait until a final state is reached */
+	while (!dev_fsm_final_state(cdev)) {
+		spin_unlock_irq(cdev->ccwlock);
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+		spin_lock_irq(cdev->ccwlock);
+	}
 	/* Check if online processing was successful */
 	if ((cdev->private->state != DEV_STATE_ONLINE) &&
 	    (cdev->private->state != DEV_STATE_W4SENSE)) {
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 9cde55730b65..ebcb53580988 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -722,8 +722,8 @@ static void qdio_handle_activate_check(struct qdio_irq *irq_ptr,
 	lgr_info_log();
 }
 
-static void qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
-				      int dstat)
+static int qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
+				     int dstat, int dcc)
 {
 	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qest irq");
 
@@ -731,15 +731,18 @@ static void qdio_establish_handle_irq(struct qdio_irq *irq_ptr, int cstat,
 		goto error;
 	if (dstat & ~(DEV_STAT_DEV_END | DEV_STAT_CHN_END))
 		goto error;
+	if (dcc == 1)
+		return -EAGAIN;
 	if (!(dstat & DEV_STAT_DEV_END))
 		goto error;
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ESTABLISHED);
-	return;
+	return 0;
 
 error:
 	DBF_ERROR("%4x EQ:error", irq_ptr->schid.sch_no);
 	DBF_ERROR("ds: %2x cs:%2x", dstat, cstat);
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+	return -EIO;
 }
 
 /* qdio interrupt handler */
@@ -748,7 +751,7 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 	struct subchannel_id schid;
-	int cstat, dstat;
+	int cstat, dstat, rc, dcc;
 
 	if (!intparm || !irq_ptr) {
 		ccw_device_get_schid(cdev, &schid);
@@ -768,10 +771,12 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	qdio_irq_check_sense(irq_ptr, irb);
 	cstat = irb->scsw.cmd.cstat;
 	dstat = irb->scsw.cmd.dstat;
+	dcc   = scsw_cmd_is_valid_cc(&irb->scsw) ? irb->scsw.cmd.cc : 0;
+	rc    = 0;
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
-		qdio_establish_handle_irq(irq_ptr, cstat, dstat);
+		rc = qdio_establish_handle_irq(irq_ptr, cstat, dstat, dcc);
 		break;
 	case QDIO_IRQ_STATE_CLEANUP:
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
@@ -785,12 +790,25 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		if (cstat || dstat)
 			qdio_handle_activate_check(irq_ptr, intparm, cstat,
 						   dstat);
+		else if (dcc == 1)
+			rc = -EAGAIN;
 		break;
 	case QDIO_IRQ_STATE_STOPPED:
 		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
+
+	if (rc == -EAGAIN) {
+		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qint retry");
+		rc = ccw_device_start(cdev, irq_ptr->ccw, intparm, 0, 0);
+		if (!rc)
+			return;
+		DBF_ERROR("%4x RETRY ERR", irq_ptr->schid.sch_no);
+		DBF_ERROR("rc:%4x", rc);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+	}
+
 	wake_up(&cdev->private->wait_q);
 }
 
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 638cb5fb22c1..e81de9c30eac 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -10,6 +10,7 @@
 static void quirk_force_power_link(struct tb_switch *sw)
 {
 	sw->quirks |= QUIRK_FORCE_POWER_LINK_CONTROLLER;
+	tb_sw_dbg(sw, "forcing power to link controller\n");
 }
 
 static void quirk_dp_credit_allocation(struct tb_switch *sw)
@@ -130,6 +131,7 @@ void tb_check_quirks(struct tb_switch *sw)
 		if (q->device && q->device != sw->device)
 			continue;
 
+		tb_sw_dbg(sw, "running %ps\n", q->hook);
 		q->hook(sw);
 	}
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 55698a0978f0..d3058ede5306 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2880,22 +2880,29 @@ void tb_switch_unconfigure_link(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
 
-	if (sw->is_unplugged)
-		return;
 	if (!tb_route(sw) || tb_switch_is_icm(sw))
 		return;
 
+	/*
+	 * Unconfigure downstream port so that wake-on-connect can be
+	 * configured after router unplug. No need to unconfigure upstream port
+	 * since its router is unplugged.
+	 */
 	up = tb_upstream_port(sw);
-	if (tb_switch_is_usb4(up->sw))
-		usb4_port_unconfigure(up);
-	else
-		tb_lc_unconfigure_port(up);
-
 	down = up->remote;
 	if (tb_switch_is_usb4(down->sw))
 		usb4_port_unconfigure(down);
 	else
 		tb_lc_unconfigure_port(down);
+
+	if (sw->is_unplugged)
+		return;
+
+	up = tb_upstream_port(sw);
+	if (tb_switch_is_usb4(up->sw))
+		usb4_port_unconfigure(up);
+	else
+		tb_lc_unconfigure_port(up);
 }
 
 static void tb_switch_credits_init(struct tb_switch *sw)
@@ -3135,7 +3142,26 @@ static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 	return tb_lc_set_wake(sw, flags);
 }
 
-int tb_switch_resume(struct tb_switch *sw)
+static void tb_switch_check_wakes(struct tb_switch *sw)
+{
+	if (device_may_wakeup(&sw->dev)) {
+		if (tb_switch_is_usb4(sw))
+			usb4_switch_check_wakes(sw);
+	}
+}
+
+/**
+ * tb_switch_resume() - Resume a switch after sleep
+ * @sw: Switch to resume
+ * @runtime: Is this resume from runtime suspend or system sleep
+ *
+ * Resumes and re-enumerates router (and all its children), if still plugged
+ * after suspend. Don't enumerate device router whose UID was changed during
+ * suspend. If this is resume from system sleep, notifies PM core about the
+ * wakes occurred during suspend. Disables all wakes, except USB4 wake of
+ * upstream port for USB4 routers that shall be always enabled.
+ */
+int tb_switch_resume(struct tb_switch *sw, bool runtime)
 {
 	struct tb_port *port;
 	int err;
@@ -3184,6 +3210,9 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (err)
 		return err;
 
+	if (!runtime)
+		tb_switch_check_wakes(sw);
+
 	/* Disable wakes */
 	tb_switch_set_wake(sw, 0);
 
@@ -3213,7 +3242,8 @@ int tb_switch_resume(struct tb_switch *sw)
 			 */
 			if (tb_port_unlock(port))
 				tb_port_warn(port, "failed to unlock port\n");
-			if (port->remote && tb_switch_resume(port->remote->sw)) {
+			if (port->remote &&
+			    tb_switch_resume(port->remote->sw, runtime)) {
 				tb_port_warn(port,
 					     "lost during suspend, disconnecting\n");
 				tb_sw_set_unplugged(port->remote->sw);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e83269dc2b06..c5e4fa478e64 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1628,7 +1628,7 @@ static int tb_resume_noirq(struct tb *tb)
 	/* remove any pci devices the firmware might have setup */
 	tb_switch_reset(tb->root_switch);
 
-	tb_switch_resume(tb->root_switch);
+	tb_switch_resume(tb->root_switch, false);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
 	tb_restore_children(tb->root_switch);
@@ -1754,7 +1754,7 @@ static int tb_runtime_resume(struct tb *tb)
 	struct tb_tunnel *tunnel, *n;
 
 	mutex_lock(&tb->lock);
-	tb_switch_resume(tb->root_switch);
+	tb_switch_resume(tb->root_switch, true);
 	tb_free_invalid_tunnels(tb);
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index b3fec5f8e20c..acf5b8620845 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -787,7 +787,7 @@ int tb_switch_configure(struct tb_switch *sw);
 int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
 void tb_switch_suspend(struct tb_switch *sw, bool runtime);
-int tb_switch_resume(struct tb_switch *sw);
+int tb_switch_resume(struct tb_switch *sw, bool runtime);
 int tb_switch_reset(struct tb_switch *sw);
 int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 			   u32 value, int timeout_msec);
@@ -1182,6 +1182,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
 	return NULL;
 }
 
+void usb4_switch_check_wakes(struct tb_switch *sw);
 int usb4_switch_setup(struct tb_switch *sw);
 int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 3c821f5e4481..b0394ba6d111 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -153,15 +153,18 @@ static inline int usb4_switch_op_data(struct tb_switch *sw, u16 opcode,
 				tx_dwords, rx_data, rx_dwords);
 }
 
-static void usb4_switch_check_wakes(struct tb_switch *sw)
+/**
+ * usb4_switch_check_wakes() - Check for wakes and notify PM core about them
+ * @sw: Router whose wakes to check
+ *
+ * Checks wakes occurred during suspend and notify the PM core about them.
+ */
+void usb4_switch_check_wakes(struct tb_switch *sw)
 {
 	struct tb_port *port;
 	bool wakeup = false;
 	u32 val;
 
-	if (!device_may_wakeup(&sw->dev))
-		return;
-
 	if (tb_route(sw)) {
 		if (tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_6, 1))
 			return;
@@ -226,8 +229,6 @@ int usb4_switch_setup(struct tb_switch *sw)
 	u32 val = 0;
 	int ret;
 
-	usb4_switch_check_wakes(sw);
-
 	if (!tb_route(sw))
 		return 0;
 
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d21a4f3ef2fe..8b31017e7e56 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1094,11 +1094,13 @@ static void mxs_auart_set_ldisc(struct uart_port *port,
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-	u32 istat;
+	u32 istat, stat;
 	struct mxs_auart_port *s = context;
 	u32 mctrl_temp = s->mctrl_prev;
-	u32 stat = mxs_read(s, REG_STAT);
 
+	uart_port_lock(&s->port);
+
+	stat = mxs_read(s, REG_STAT);
 	istat = mxs_read(s, REG_INTR);
 
 	/* ack irq */
@@ -1134,6 +1136,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		istat &= ~AUART_INTR_TXIS;
 	}
 
+	uart_port_unlock(&s->port);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index fe2e4ec423f7..daf15d23bb42 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -210,7 +210,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 {
 	struct tty_port *port;
 	unsigned char ch, r1, drop, flag;
-	int loops = 0;
 
 	/* Sanity check, make sure the old bug is no longer happening */
 	if (uap->port.state == NULL) {
@@ -291,24 +290,11 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		if (r1 & Rx_OVR)
 			tty_insert_flip_char(port, 0, TTY_OVERRUN);
 	next_char:
-		/* We can get stuck in an infinite loop getting char 0 when the
-		 * line is in a wrong HW state, we break that here.
-		 * When that happens, I disable the receive side of the driver.
-		 * Note that what I've been experiencing is a real irq loop where
-		 * I'm getting flooded regardless of the actual port speed.
-		 * Something strange is going on with the HW
-		 */
-		if ((++loops) > 1000)
-			goto flood;
 		ch = read_zsreg(uap, R0);
 		if (!(ch & Rx_CH_AV))
 			break;
 	}
 
-	return true;
- flood:
-	pmz_interrupt_control(uap, 0);
-	pmz_error("pmz: rx irq flood !\n");
 	return true;
 }
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2a9c4058824a..7d11511c8c12 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -755,6 +755,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 	unsigned int size;
+	irqreturn_t ret = IRQ_NONE;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -763,11 +764,14 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	    (sr & USART_SR_TC)) {
 		stm32_usart_tc_interrupt_disable(port);
 		stm32_usart_rs485_rts_disable(port);
+		ret = IRQ_HANDLED;
 	}
 
-	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG)
+	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG) {
 		writel_relaxed(USART_ICR_RTOCF,
 			       port->membase + ofs->icr);
+		ret = IRQ_HANDLED;
+	}
 
 	if ((sr & USART_SR_WUF) && ofs->icr != UNDEF_REG) {
 		/* Clear wake up flag and disable wake up interrupt */
@@ -776,6 +780,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
 			pm_wakeup_event(tport->tty->dev, 0);
+		ret = IRQ_HANDLED;
 	}
 
 	/*
@@ -790,6 +795,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 			uart_unlock_and_check_sysrq(port);
 			if (size)
 				tty_flip_buffer_push(tport);
+			ret = IRQ_HANDLED;
 		}
 	}
 
@@ -797,6 +803,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		spin_lock(&port->lock);
 		stm32_usart_transmit_chars(port);
 		spin_unlock(&port->lock);
+		ret = IRQ_HANDLED;
 	}
 
 	/* Receiver timeout irq for DMA RX */
@@ -806,9 +813,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		uart_unlock_and_check_sysrq(port);
 		if (size)
 			tty_flip_buffer_push(tport);
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)
@@ -1013,6 +1021,7 @@ static int stm32_usart_startup(struct uart_port *port)
 		val |= USART_CR2_SWAP;
 		writel_relaxed(val, port->membase + ofs->cr2);
 	}
+	stm32_port->throttled = false;
 
 	/* RX FIFO Flush */
 	if (ofs->rqr != UNDEF_REG)
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index fdc1a66b129a..1f0951be15ab 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -485,7 +485,6 @@ static ssize_t wdm_write
 static int service_outstanding_interrupt(struct wdm_device *desc)
 {
 	int rv = 0;
-	int used;
 
 	/* submit read urb only if the device is waiting for it */
 	if (!desc->resp_count || !--desc->resp_count)
@@ -500,10 +499,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 		goto out;
 	}
 
-	used = test_and_set_bit(WDM_RESPONDING, &desc->flags);
-	if (used)
-		goto out;
-
+	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
 	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1fb04e5247c..dea110241ee7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -60,6 +60,12 @@
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 #define USB_REDUCE_FRAME_INTR_BINTERVAL	9
 
+/*
+ * The SET_ADDRESS request timeout will be 500 ms when
+ * USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT quirk flag is set.
+ */
+#define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT	500  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -4648,7 +4654,12 @@ EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
+	unsigned int timeout_ms = USB_CTRL_SET_TIMEOUT;
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	if (hub->hdev->quirks & USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT)
+		timeout_ms = USB_SHORT_SET_ADDRESS_REQ_TIMEOUT;
 
 	/*
 	 * The host controller will choose the device address,
@@ -4661,11 +4672,11 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev);
+		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
-				NULL, 0, USB_CTRL_SET_TIMEOUT);
+				NULL, 0, timeout_ms);
 	if (retval == 0) {
 		update_devnum(udev, devnum);
 		/* Device now using proper address. */
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index e91fa567d08d..93a63b7f164d 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -409,8 +409,10 @@ static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
-	if (port_dev->child)
+	if (port_dev->child) {
 		usb_disable_usb2_hardware_lpm(port_dev->child);
+		usb_unlocked_disable_lpm(port_dev->child);
+	}
 }
 
 static const struct dev_pm_ops usb_port_pm_ops = {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..b4783574b8e6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -527,6 +530,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* APTIV AUTOMOTIVE HUB */
+	{ USB_DEVICE(0x2c48, 0x0132), .driver_info =
+			USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index 79582b102c7e..994a78ad084b 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -867,13 +867,15 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 	struct dwc2_dma_desc *dma_desc;
 	struct dwc2_hcd_iso_packet_desc *frame_desc;
 	u16 frame_desc_idx;
-	struct urb *usb_urb = qtd->urb->priv;
+	struct urb *usb_urb;
 	u16 remain = 0;
 	int rc = 0;
 
 	if (!qtd->urb)
 		return -EINVAL;
 
+	usb_urb = qtd->urb->priv;
+
 	dma_sync_single_for_cpu(hsotg->dev, qh->desc_list_dma + (idx *
 				sizeof(struct dwc2_dma_desc)),
 				sizeof(struct dwc2_dma_desc),
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 14601a2d2542..b267ed9dc6d9 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -884,7 +884,7 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (alt > 1)
 			goto fail;
 
-		if (ncm->port.in_ep->enabled) {
+		if (ncm->netdev) {
 			DBG(cdev, "reset ncm\n");
 			ncm->netdev = NULL;
 			gether_disconnect(&ncm->port);
@@ -1369,7 +1369,7 @@ static void ncm_disable(struct usb_function *f)
 
 	DBG(cdev, "ncm deactivated\n");
 
-	if (ncm->port.in_ep->enabled) {
+	if (ncm->netdev) {
 		ncm->netdev = NULL;
 		gether_disconnect(&ncm->port);
 	}
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b9714..2665832f9add 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -207,8 +207,7 @@ EXPORT_SYMBOL_GPL(sb800_prefetch);
 static void usb_amd_find_chipset_info(void)
 {
 	unsigned long flags;
-	struct amd_chipset_info info;
-	info.need_pll_quirk = false;
+	struct amd_chipset_info info = { };
 
 	spin_lock_irqsave(&amd_lock, flags);
 
@@ -218,7 +217,6 @@ static void usb_amd_find_chipset_info(void)
 		spin_unlock_irqrestore(&amd_lock, flags);
 		return;
 	}
-	memset(&info, 0, sizeof(info));
 	spin_unlock_irqrestore(&amd_lock, flags);
 
 	if (!amd_chipset_sb_type_init(&info)) {
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 019dcbe55dbd..62808c98713e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1752,6 +1752,8 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	}
 
 	command->status = 0;
+	/* set default timeout to 5000 ms */
+	command->timeout_ms = XHCI_CMD_DEFAULT_TIMEOUT;
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 239b5edee326..4a039e42694b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -332,9 +332,10 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
+static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer, delay);
+	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
 static struct xhci_command *xhci_next_queued_cmd(struct xhci_hcd *xhci)
@@ -378,7 +379,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
@@ -1762,7 +1763,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	if (!list_is_singular(&xhci->cmd_list)) {
 		xhci->current_cmd = list_first_entry(&cmd->cmd_list,
 						struct xhci_command, cmd_list);
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	} else if (xhci->current_cmd == cmd) {
 		xhci->current_cmd = NULL;
 	}
@@ -4339,7 +4340,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 565aba6b9986..27e01671d386 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4170,12 +4170,18 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 0;
 }
 
-/*
- * Issue an Address Device command and optionally send a corresponding
- * SetAddress request to the device.
+/**
+ * xhci_setup_device - issues an Address Device command to assign a unique
+ *			USB bus address.
+ * @hcd: USB host controller data structure.
+ * @udev: USB dev structure representing the connected device.
+ * @setup: Enum specifying setup mode: address only or with context.
+ * @timeout_ms: Max wait time (ms) for the command operation to complete.
+ *
+ * Return: 0 if successful; otherwise, negative error code.
  */
 static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
-			     enum xhci_setup_dev setup)
+			     enum xhci_setup_dev setup, unsigned int timeout_ms)
 {
 	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
 	unsigned long flags;
@@ -4232,6 +4238,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	command->in_ctx = virt_dev->in_ctx;
+	command->timeout_ms = timeout_ms;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
@@ -4358,14 +4365,16 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev,
+			       unsigned int timeout_ms)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout_ms);
 }
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY,
+				 XHCI_CMD_DEFAULT_TIMEOUT);
 }
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index fc25a5b09710..fa9e87141e0b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -815,6 +815,8 @@ struct xhci_command {
 	struct completion		*completion;
 	union xhci_trb			*command_trb;
 	struct list_head		cmd_list;
+	/* xHCI command response timeout in milliseconds */
+	unsigned int			timeout_ms;
 };
 
 /* drop context bitmasks */
@@ -1574,8 +1576,11 @@ struct xhci_td {
 	unsigned int		num_trbs;
 };
 
-/* xHCI command default timeout value */
-#define XHCI_CMD_DEFAULT_TIMEOUT	(5 * HZ)
+/*
+ * xHCI command default timeout value in milliseconds.
+ * USB 3.2 spec, section 9.2.6.1
+ */
+#define XHCI_CMD_DEFAULT_TIMEOUT	5000
 
 /* command descriptor */
 struct xhci_cd {
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1a3e5a9414f0..b5ee8518fcc7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -255,6 +255,10 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_EM060K_128		0x0128
+#define QUECTEL_PRODUCT_EM060K_129		0x0129
+#define QUECTEL_PRODUCT_EM060K_12a		0x012a
+#define QUECTEL_PRODUCT_EM060K_12b		0x012b
+#define QUECTEL_PRODUCT_EM060K_12c		0x012c
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -1218,6 +1222,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_129, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12a, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12b, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_12c, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1360,6 +1376,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2052,6 +2074,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9803, 0xff),
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, 0x9b05),	/* Longsung U8300 */
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, 0x9b3c),	/* Longsung U9300 */
+	  .driver_info = RSVD(0) | RSVD(4) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
 	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
@@ -2272,15 +2298,29 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff),			/* Fibocom FM135 (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a04, 0xff) },			/* Fibocom FM650-CN (ECM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE(0x33f8, 0x0104),						/* Rolling RW101-GL (laptop RMNET) */
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a2, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a3, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a4, 0xff),			/* Rolling RW101-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index decd6471300b..760405da852f 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -243,7 +243,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
 	[S_IFREG >> S_SHIFT]	= NILFS_FT_REG_FILE,
 	[S_IFDIR >> S_SHIFT]	= NILFS_FT_DIR,
 	[S_IFCHR >> S_SHIFT]	= NILFS_FT_CHRDEV,
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index a3936ff53d9d..25383b11d01b 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -699,7 +699,7 @@ struct smb2_close_rsp {
 	__le16 StructureSize; /* 60 */
 	__le16 Flags;
 	__le32 Reserved;
-	struct_group(network_open_info,
+	struct_group_attr(network_open_info, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 11b201e6ee44..63b01f7d9703 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -167,20 +167,17 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	int rc;
 	bool is_chained = false;
 
-	if (conn->ops->allocate_rsp_buf(work))
-		return;
-
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
 		rc = conn->ops->decrypt_req(work);
-		if (rc < 0) {
-			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
-			goto send;
-		}
-
+		if (rc < 0)
+			return;
 		work->encrypted = true;
 	}
 
+	if (conn->ops->allocate_rsp_buf(work))
+		return;
+
 	rc = conn->ops->init_rsp_hdr(work);
 	if (rc) {
 		/* either uid or tid is not correct */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c02b1772cb80..34d88425434a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -534,6 +534,10 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
+		if (get_rfc1002_len(work->request_buf) <
+		    offsetof(struct smb2_query_info_req, OutputBufferLength))
+			return -EINVAL;
+
 		req = smb2_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index fe2c80ea2e47..a4c99ec38fac 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -746,10 +746,15 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
+	/*
+	 * explicitly handle file overwrite case, for compatibility with
+	 * filesystems that may not support rename flags (e.g: fuse)
+	 */
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
 		err = -EEXIST;
 		goto out4;
 	}
+	flags &= ~(RENAME_NOREPLACE);
 
 	if (old_child == trap) {
 		err = -EINVAL;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..f21e73d10724 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -450,6 +450,8 @@ struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
 	kn = kernfs_find_and_get(kobj->sd, attr->name);
 	if (kn)
 		kernfs_break_active_protection(kn);
+	else
+		kobject_put(kobj);
 	return kn;
 }
 EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index ca73940e26df..4195444ec45d 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -287,7 +287,12 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init xbc_exit(void);
+void __init _xbc_exit(bool early);
+
+static inline void xbc_exit(void)
+{
+	_xbc_exit(false);
+}
 
 /* XBC embedded bootconfig data in kernel */
 #ifdef CONFIG_BOOT_CONFIG_EMBED
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f5d89a4b811f..4da7411da9ba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1383,6 +1383,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
 int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
@@ -1553,6 +1554,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			 void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
@@ -1884,6 +1887,8 @@ static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline void pci_restore_state(struct pci_dev *dev) { }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
+static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73cc1e7dd15a..9e9794d03c9f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -158,6 +158,8 @@
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
+#define PCI_VENDOR_ID_SOLIDIGM		0x025e
+
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 48fabe36509e..8d8fac1626bd 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -41,6 +41,7 @@ enum {
 enum switchtec_gen {
 	SWITCHTEC_GEN3,
 	SWITCHTEC_GEN4,
+	SWITCHTEC_GEN5,
 };
 
 struct mrpc_regs {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 5a89928ea953..cd667acf6267 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -371,8 +371,9 @@ struct hc_driver {
 		 * or bandwidth constraints.
 		 */
 	void	(*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
-		/* Returns the hardware-chosen device address */
-	int	(*address_device)(struct usb_hcd *, struct usb_device *udev);
+		/* Set the hardware-chosen device address */
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,
+				  unsigned int timeout_ms);
 		/* prepares the hardware to send commands to the device */
 	int	(*enable_device)(struct usb_hcd *, struct usb_device *udev);
 		/* Notifies the HCD after a hub descriptor is fetched.
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index eeb7c2157c72..59409c1fc3de 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -72,4 +72,7 @@
 /* device has endpoints that should be ignored */
 #define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
+/* short SET_ADDRESS request timeout */
+#define USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT	BIT(16)
+
 #endif /* __LINUX_USB_QUIRKS_H */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index ee369670e20e..f96b61d9768e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -968,6 +968,14 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+	/*
+	 * Compatibility between device trees defining multiple CPU ports and
+	 * drivers which are not OK to use by default the numerically smallest
+	 * CPU port of a switch for its local ports. This can return NULL,
+	 * meaning "don't know/don't care".
+	 */
+	struct dsa_port *(*preferred_default_local_cpu_port)(struct dsa_switch *ds);
+
 	/*
 	 * Port's MAC EEE settings
 	 */
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 4a767b3d20b9..df7775afb92b 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -335,7 +335,7 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 int nf_flow_table_offload_init(void);
 void nf_flow_table_offload_exit(void);
 
-static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
+static inline __be16 __nf_flow_pppoe_proto(const struct sk_buff *skb)
 {
 	__be16 proto;
 
@@ -351,6 +351,16 @@ static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
 	return 0;
 }
 
+static inline bool nf_flow_pppoe_proto(struct sk_buff *skb, __be16 *inner_proto)
+{
+	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+		return false;
+
+	*inner_proto = __nf_flow_pppoe_proto(skb);
+
+	return true;
+}
+
 #define NF_FLOW_TABLE_STAT_INC(net, count) __this_cpu_inc((net)->ft.stat->count)
 #define NF_FLOW_TABLE_STAT_DEC(net, count) __this_cpu_dec((net)->ft.stat->count)
 #define NF_FLOW_TABLE_STAT_INC_ATOMIC(net, count)	\
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 3f121eed369e..894d9fc8bd94 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -587,7 +587,7 @@ TRACE_EVENT(rpcgss_context,
 		__field(unsigned int, timeout)
 		__field(u32, window_size)
 		__field(int, len)
-		__string(acceptor, data)
+		__string_len(acceptor, data, len)
 	),
 
 	TP_fast_assign(
@@ -596,7 +596,7 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout = timeout;
 		__entry->window_size = window_size;
 		__entry->len = len;
-		strncpy(__get_str(acceptor), data, len);
+		__assign_str(acceptor, data);
 	),
 
 	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..3325155036c8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1043,6 +1043,7 @@
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
 #define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
 #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
+#define  PCI_EXP_DPC_RP_PIO_FEP		    0x1f00 /* RP PIO First Err Ptr */
 
 #define PCI_EXP_DPC_SOURCE_ID		 0x0A	/* DPC Source Identifier */
 
diff --git a/init/main.c b/init/main.c
index ccde19e7275f..2c339793511b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -633,6 +633,8 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
+	len = xlen + strlen(command_line) + 1;
+
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 68f1b6f8699a..958c3b619020 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2426,6 +2426,14 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return 0;
 	} while (ret > 0);
 
+	if (uts) {
+		struct timespec64 ts;
+
+		if (get_timespec64(&ts, uts))
+			return -EFAULT;
+		timeout = ktime_add_ns(timespec64_to_ktime(ts), ktime_get_ns());
+	}
+
 	if (sig) {
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
@@ -2439,14 +2447,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	if (uts) {
-		struct timespec64 ts;
-
-		if (get_timespec64(&ts, uts))
-			return -EFAULT;
-		timeout = ktime_add_ns(timespec64_to_ktime(ts), ktime_get_ns());
-	}
-
 	init_waitqueue_func_entry(&iowq.wq, io_wake_function);
 	iowq.wq.private = current;
 	INIT_LIST_HEAD(&iowq.wq.entry);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c59d26068a64..8841554432d5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -61,9 +61,12 @@ static inline void * __init xbc_alloc_mem(size_t size)
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-static inline void __init xbc_free_mem(void *addr, size_t size)
+static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 {
-	memblock_free(addr, size);
+	if (early)
+		memblock_free(addr, size);
+	else if (addr)
+		memblock_free_late(__pa(addr), size);
 }
 
 #else /* !__KERNEL__ */
@@ -73,7 +76,7 @@ static inline void *xbc_alloc_mem(size_t size)
 	return malloc(size);
 }
 
-static inline void xbc_free_mem(void *addr, size_t size)
+static inline void xbc_free_mem(void *addr, size_t size, bool early)
 {
 	free(addr);
 }
@@ -904,13 +907,13 @@ static int __init xbc_parse_tree(void)
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init xbc_exit(void)
+void __init _xbc_exit(bool early)
 {
-	xbc_free_mem(xbc_data, xbc_data_size);
+	xbc_free_mem(xbc_data, xbc_data_size, early);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -963,7 +966,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_exit();
+		_xbc_exit(true);
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -977,7 +980,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_exit();
+		_xbc_exit(true);
 	} else
 		ret = xbc_node_num;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b846ed5dcbe..be58ce999259 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -84,11 +84,23 @@ static int __page_handle_poison(struct page *page)
 {
 	int ret;
 
-	zone_pcp_disable(page_zone(page));
+	/*
+	 * zone_pcp_disable() can't be used here. It will
+	 * hold pcp_batch_high_lock and dissolve_free_huge_page() might hold
+	 * cpu_hotplug_lock via static_key_slow_dec() when hugetlb vmemmap
+	 * optimization is enabled. This will break current lock dependency
+	 * chain and leads to deadlock.
+	 * Disabling pcp before dissolving the page was a deterministic
+	 * approach because we made sure that those pages cannot end up in any
+	 * PCP list. Draining PCP lists expels those pages to the buddy system,
+	 * but nothing guarantees that those pages do not get back to a PCP
+	 * queue if we need to refill those.
+	 */
 	ret = dissolve_free_huge_page(page);
-	if (!ret)
+	if (!ret) {
+		drain_all_pages(page_zone(page));
 		ret = take_page_off_buddy(page);
-	zone_pcp_enable(page_zone(page));
+	}
 
 	return ret;
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 6bb272894c96..b94a1783902e 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -30,7 +30,7 @@ br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return netif_receive_skb(skb);
 }
 
-static int br_pass_frame_up(struct sk_buff *skb)
+static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 {
 	struct net_device *indev, *brdev = BR_INPUT_SKB_CB(skb)->brdev;
 	struct net_bridge *br = netdev_priv(brdev);
@@ -65,6 +65,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	br_multicast_count(br, NULL, skb, br_multicast_igmp_type(skb),
 			   BR_MCAST_DIR_TX);
 
+	BR_INPUT_SKB_CB(skb)->promisc = promisc;
+
 	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
 		       dev_net(indev), NULL, skb, indev, NULL,
 		       br_netif_receive_skb);
@@ -82,6 +84,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_mcast *brmctx;
 	struct net_bridge_vlan *vlan;
 	struct net_bridge *br;
+	bool promisc;
 	u16 vid = 0;
 	u8 state;
 
@@ -120,7 +123,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (p->flags & BR_LEARNING)
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
-	local_rcv = !!(br->dev->flags & IFF_PROMISC);
+	promisc = !!(br->dev->flags & IFF_PROMISC);
+	local_rcv = promisc;
+
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest)) {
 		/* by definition the broadcast is also a multicast address */
 		if (is_broadcast_ether_addr(eth_hdr(skb)->h_dest)) {
@@ -183,7 +188,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		unsigned long now = jiffies;
 
 		if (test_bit(BR_FDB_LOCAL, &dst->flags))
-			return br_pass_frame_up(skb);
+			return br_pass_frame_up(skb, false);
 
 		if (now != dst->used)
 			dst->used = now;
@@ -196,7 +201,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	}
 
 	if (local_rcv)
-		return br_pass_frame_up(skb);
+		return br_pass_frame_up(skb, promisc);
 
 out:
 	return 0;
@@ -368,6 +373,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 				goto forward;
 		}
 
+		BR_INPUT_SKB_CB(skb)->promisc = false;
+
 		/* The else clause should be hit when nf_hook():
 		 *   - returns < 0 (drop/error)
 		 *   - returns = 0 (stolen/nf_queue)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index bff48d576363..9ac70c27da83 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -600,11 +600,17 @@ static unsigned int br_nf_local_in(void *priv,
 				   struct sk_buff *skb,
 				   const struct nf_hook_state *state)
 {
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
 	struct nf_conntrack *nfct = skb_nfct(skb);
 	const struct nf_ct_hook *ct_hook;
 	struct nf_conn *ct;
 	int ret;
 
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
 	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 51d010f64e06..940de9516768 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -559,6 +559,7 @@ struct br_input_skb_cb {
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
+	u8 promisc:1;
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8 vlan_filtered:1;
 #endif
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index c7c27ada6704..e60c38670f22 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -294,18 +294,24 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
 				    const struct nf_hook_state *state)
 {
-	enum ip_conntrack_info ctinfo;
+	bool promisc = BR_INPUT_SKB_CB(skb)->promisc;
+	struct nf_conntrack *nfct = skb_nfct(skb);
 	struct nf_conn *ct;
 
-	if (skb->pkt_type == PACKET_HOST)
+	if (promisc) {
+		nf_reset_ct(skb);
+		return NF_ACCEPT;
+	}
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
 		return NF_ACCEPT;
 
 	/* nf_conntrack_confirm() cannot handle concurrent clones,
 	 * this happens for broad/multicast frames with e.g. macvlan on top
 	 * of the bridge device.
 	 */
-	ct = nf_ct_get(skb, &ctinfo);
-	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
 		return NF_ACCEPT;
 
 	/* let inet prerouting call conntrack again */
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 5417f7b1187c..98f864879175 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -425,6 +425,24 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
 	return 0;
 }
 
+static struct dsa_port *
+dsa_switch_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp;
+
+	if (!ds->ops->preferred_default_local_cpu_port)
+		return NULL;
+
+	cpu_dp = ds->ops->preferred_default_local_cpu_port(ds);
+	if (!cpu_dp)
+		return NULL;
+
+	if (WARN_ON(!dsa_port_is_cpu(cpu_dp) || cpu_dp->ds != ds))
+		return NULL;
+
+	return cpu_dp;
+}
+
 /* Perform initial assignment of CPU ports to user ports and DSA links in the
  * fabric, giving preference to CPU ports local to each switch. Default to
  * using the first CPU port in the switch tree if the port does not have a CPU
@@ -432,12 +450,16 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
  */
 static int dsa_tree_setup_cpu_ports(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp, *dp;
+	struct dsa_port *preferred_cpu_dp, *cpu_dp, *dp;
 
 	list_for_each_entry(cpu_dp, &dst->ports, list) {
 		if (!dsa_port_is_cpu(cpu_dp))
 			continue;
 
+		preferred_cpu_dp = dsa_switch_preferred_default_local_cpu_port(cpu_dp->ds);
+		if (preferred_cpu_dp && preferred_cpu_dp != cpu_dp)
+			continue;
+
 		/* Prefer a local CPU port */
 		dsa_switch_for_each_port(dp, cpu_dp->ds) {
 			/* Prefer the first local CPU port found */
diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index 9505f9d188ff..6eef15648b7b 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -21,7 +21,8 @@ nf_flow_offload_inet_hook(void *priv, struct sk_buff *skb,
 		proto = veth->h_vlan_encapsulated_proto;
 		break;
 	case htons(ETH_P_PPP_SES):
-		proto = nf_flow_pppoe_proto(skb);
+		if (!nf_flow_pppoe_proto(skb, &proto))
+			return NF_ACCEPT;
 		break;
 	default:
 		proto = skb->protocol;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 6feaac9ab05c..22bc0e3d8a0b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -156,7 +156,7 @@ static void nf_flow_tuple_encap(struct sk_buff *skb,
 		tuple->encap[i].proto = skb->protocol;
 		break;
 	case htons(ETH_P_PPP_SES):
-		phdr = (struct pppoe_hdr *)skb_mac_header(skb);
+		phdr = (struct pppoe_hdr *)skb_network_header(skb);
 		tuple->encap[i].id = ntohs(phdr->sid);
 		tuple->encap[i].proto = skb->protocol;
 		break;
@@ -267,10 +267,11 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 	return NF_STOLEN;
 }
 
-static bool nf_flow_skb_encap_protocol(const struct sk_buff *skb, __be16 proto,
+static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
 				       u32 *offset)
 {
 	struct vlan_ethhdr *veth;
+	__be16 inner_proto;
 
 	switch (skb->protocol) {
 	case htons(ETH_P_8021Q):
@@ -281,7 +282,8 @@ static bool nf_flow_skb_encap_protocol(const struct sk_buff *skb, __be16 proto,
 		}
 		break;
 	case htons(ETH_P_PPP_SES):
-		if (nf_flow_pppoe_proto(skb) == proto) {
+		if (nf_flow_pppoe_proto(skb, &inner_proto) &&
+		    inner_proto == proto) {
 			*offset += PPPOE_SES_HLEN;
 			return true;
 		}
@@ -310,7 +312,7 @@ static void nf_flow_encap_pop(struct sk_buff *skb,
 			skb_reset_network_header(skb);
 			break;
 		case htons(ETH_P_PPP_SES):
-			skb->protocol = nf_flow_pppoe_proto(skb);
+			skb->protocol = __nf_flow_pppoe_proto(skb);
 			skb_pull(skb, PPPOE_SES_HLEN);
 			skb_reset_network_header(skb);
 			break;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8152a69d8268..1c4b7a8ec2cc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2891,7 +2891,7 @@ static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 {
 	const struct nft_expr_type *type, *candidate = NULL;
 
-	list_for_each_entry(type, &nf_tables_expressions, list) {
+	list_for_each_entry_rcu(type, &nf_tables_expressions, list) {
 		if (!nla_strcmp(nla, type->name)) {
 			if (!type->family && !candidate)
 				candidate = type;
@@ -2923,9 +2923,13 @@ static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
+	rcu_read_lock();
 	type = __nft_expr_type_get(family, nla);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
@@ -7171,7 +7175,7 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	list_for_each_entry(type, &nf_tables_objects, list) {
+	list_for_each_entry_rcu(type, &nf_tables_objects, list) {
 		if (type->family != NFPROTO_UNSPEC &&
 		    type->family != family)
 			continue;
@@ -7187,9 +7191,13 @@ nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
+	rcu_read_lock();
 	type = __nft_obj_type_get(objtype, family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 58eca2616273..2299ced939c4 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1994,6 +1994,8 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		rules_fx = rules_f0;
 
 		nft_pipapo_for_each_field(f, i, m) {
+			bool last = i == m->field_count - 1;
+
 			if (!pipapo_match_field(f, start, rules_fx,
 						match_start, match_end))
 				break;
@@ -2006,16 +2008,18 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 			match_start += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 			match_end += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
-		}
 
-		if (i == m->field_count) {
-			priv->dirty = true;
-			pipapo_drop(m, rulemap);
-			return;
+			if (last && f->mt[rulemap[i].to].e == e) {
+				priv->dirty = true;
+				pipapo_drop(m, rulemap);
+				return;
+			}
 		}
 
 		first_rule += rules_f0;
 	}
+
+	WARN_ON_ONCE(1); /* elem_priv not found */
 }
 
 /**
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0a75d76535f7..f28e2956fea5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2675,7 +2675,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
 				}
-			} else if (!(flags & MSG_PEEK)) {
+			} else if (flags & MSG_PEEK) {
+				skb = NULL;
+			} else {
 				skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
 				if (!WARN_ON_ONCE(skb_unref(skb)))
@@ -2753,18 +2755,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		last = skb = skb_peek(&sk->sk_receive_queue);
 		last_len = last ? last->len : 0;
 
+again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb) {
+			if (!skb && copied) {
 				unix_state_unlock(sk);
-				if (copied)
-					break;
-				goto redo;
+				break;
 			}
 		}
 #endif
-again:
 		if (skb == NULL) {
 			if (copied >= target)
 				goto unlock;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e8cf38dc8a5e..77c40063d63a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10122,6 +10122,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index a287e9747c2a..fa92ed97dfe3 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -7,7 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
@@ -21,12 +21,11 @@
 
 #include "omap-mcbsp.h"
 
-#define OMAP3_PANDORA_DAC_POWER_GPIO	118
-#define OMAP3_PANDORA_AMP_POWER_GPIO	14
-
 #define PREFIX "ASoC omap3pandora: "
 
 static struct regulator *omap3pandora_dac_reg;
+static struct gpio_desc *dac_power_gpio;
+static struct gpio_desc *amp_power_gpio;
 
 static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
@@ -78,9 +77,9 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 			return ret;
 		}
 		mdelay(1);
-		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
+		gpiod_set_value(dac_power_gpio, 1);
 	} else {
-		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+		gpiod_set_value(dac_power_gpio, 0);
 		mdelay(1);
 		regulator_disable(omap3pandora_dac_reg);
 	}
@@ -92,9 +91,9 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
+		gpiod_set_value(amp_power_gpio, 1);
 	else
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+		gpiod_set_value(amp_power_gpio, 0);
 
 	return 0;
 }
@@ -229,35 +228,10 @@ static int __init omap3pandora_soc_init(void)
 
 	pr_info("OMAP3 Pandora SoC init\n");
 
-	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
-	if (ret) {
-		pr_err(PREFIX "Failed to get DAC power GPIO\n");
-		return ret;
-	}
-
-	ret = gpio_direction_output(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set DAC power GPIO direction\n");
-		goto fail0;
-	}
-
-	ret = gpio_request(OMAP3_PANDORA_AMP_POWER_GPIO, "amp_power");
-	if (ret) {
-		pr_err(PREFIX "Failed to get amp power GPIO\n");
-		goto fail0;
-	}
-
-	ret = gpio_direction_output(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set amp power GPIO direction\n");
-		goto fail1;
-	}
-
 	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
 	if (omap3pandora_snd_device == NULL) {
 		pr_err(PREFIX "Platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto fail1;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
@@ -268,6 +242,20 @@ static int __init omap3pandora_soc_init(void)
 		goto fail2;
 	}
 
+	dac_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
+					"dac", GPIOD_OUT_LOW);
+	if (IS_ERR(dac_power_gpio)) {
+		ret = PTR_ERR(dac_power_gpio);
+		goto fail3;
+	}
+
+	amp_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
+					"amp", GPIOD_OUT_LOW);
+	if (IS_ERR(amp_power_gpio)) {
+		ret = PTR_ERR(amp_power_gpio);
+		goto fail3;
+	}
+
 	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
 	if (IS_ERR(omap3pandora_dac_reg)) {
 		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
@@ -283,10 +271,7 @@ static int __init omap3pandora_soc_init(void)
 	platform_device_del(omap3pandora_snd_device);
 fail2:
 	platform_device_put(omap3pandora_snd_device);
-fail1:
-	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
-fail0:
-	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
+
 	return ret;
 }
 module_init(omap3pandora_soc_init);
@@ -295,8 +280,6 @@ static void __exit omap3pandora_soc_exit(void)
 {
 	regulator_put(omap3pandora_dac_reg);
 	platform_device_unregister(omap3pandora_snd_device);
-	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
-	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
 }
 module_exit(omap3pandora_soc_exit);
 
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 9ccb21a4ff8a..64a718c766a7 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -12,7 +12,7 @@ snd-usb-audio-objs := 	card.o \
 			mixer.o \
 			mixer_quirks.o \
 			mixer_scarlett.o \
-			mixer_scarlett_gen2.o \
+			mixer_scarlett2.o \
 			mixer_us16x08.o \
 			mixer_s1810c.o \
 			pcm.o \
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1f32e3ae3aa3..c8d48566e175 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -33,7 +33,7 @@
 #include "mixer.h"
 #include "mixer_quirks.h"
 #include "mixer_scarlett.h"
-#include "mixer_scarlett_gen2.h"
+#include "mixer_scarlett2.h"
 #include "mixer_us16x08.h"
 #include "mixer_s1810c.h"
 #include "helper.h"
@@ -3447,8 +3447,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x8213): /* Focusrite Scarlett 8i6 3rd Gen */
 	case USB_ID(0x1235, 0x8214): /* Focusrite Scarlett 18i8 3rd Gen */
 	case USB_ID(0x1235, 0x8215): /* Focusrite Scarlett 18i20 3rd Gen */
+	case USB_ID(0x1235, 0x8206): /* Focusrite Clarett 2Pre USB */
+	case USB_ID(0x1235, 0x8207): /* Focusrite Clarett 4Pre USB */
+	case USB_ID(0x1235, 0x8208): /* Focusrite Clarett 8Pre USB */
+	case USB_ID(0x1235, 0x820a): /* Focusrite Clarett+ 2Pre */
+	case USB_ID(0x1235, 0x820b): /* Focusrite Clarett+ 4Pre */
 	case USB_ID(0x1235, 0x820c): /* Focusrite Clarett+ 8Pre */
-		err = snd_scarlett_gen2_init(mixer);
+		err = snd_scarlett2_init(mixer);
 		break;
 
 	case USB_ID(0x041e, 0x323b): /* Creative Sound Blaster E1 */
diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
new file mode 100644
index 000000000000..bcb8b7617406
--- /dev/null
+++ b/sound/usb/mixer_scarlett2.c
@@ -0,0 +1,4391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *   Focusrite Scarlett 2 Protocol Driver for ALSA
+ *   (including Scarlett 2nd Gen, 3rd Gen, Clarett USB, and Clarett+
+ *   series products)
+ *
+ *   Supported models:
+ *   - 6i6/18i8/18i20 Gen 2
+ *   - Solo/2i2/4i4/8i6/18i8/18i20 Gen 3
+ *   - Clarett 2Pre/4Pre/8Pre USB
+ *   - Clarett+ 2Pre/4Pre/8Pre
+ *
+ *   Copyright (c) 2018-2023 by Geoffrey D. Bennett <g at b4.vu>
+ *   Copyright (c) 2020-2021 by Vladimir Sadovnikov <sadko4u@gmail.com>
+ *   Copyright (c) 2022 by Christian Colglazier <christian@cacolglazier.com>
+ *
+ *   Based on the Scarlett (Gen 1) Driver for ALSA:
+ *
+ *   Copyright (c) 2013 by Tobias Hoffmann
+ *   Copyright (c) 2013 by Robin Gareus <robin at gareus.org>
+ *   Copyright (c) 2002 by Takashi Iwai <tiwai at suse.de>
+ *   Copyright (c) 2014 by Chris J Arges <chris.j.arges at canonical.com>
+ *
+ *   Many codes borrowed from audio.c by
+ *     Alan Cox (alan at lxorguk.ukuu.org.uk)
+ *     Thomas Sailer (sailer at ife.ee.ethz.ch)
+ *
+ *   Code cleanup:
+ *   David Henningsson <david.henningsson at canonical.com>
+ */
+
+/* The protocol was reverse engineered by looking at the communication
+ * between Focusrite Control 2.3.4 and the Focusrite(R) Scarlett 18i20
+ * (firmware 1083) using usbmon in July-August 2018.
+ *
+ * Scarlett 18i8 support added in April 2019.
+ *
+ * Scarlett 6i6 support added in June 2019 (thanks to Martin Wittmann
+ * for providing usbmon output and testing).
+ *
+ * Scarlett 4i4/8i6 Gen 3 support added in May 2020 (thanks to Laurent
+ * Debricon for donating a 4i4 and to Fredrik Unger for providing 8i6
+ * usbmon output and testing).
+ *
+ * Scarlett 18i8/18i20 Gen 3 support added in June 2020 (thanks to
+ * Darren Jaeckel, Alex Sedlack, and Clovis Lunel for providing usbmon
+ * output, protocol traces and testing).
+ *
+ * Support for loading mixer volume and mux configuration from the
+ * interface during driver initialisation added in May 2021 (thanks to
+ * Vladimir Sadovnikov for figuring out how).
+ *
+ * Support for Solo/2i2 Gen 3 added in May 2021 (thanks to Alexander
+ * Vorona for 2i2 protocol traces).
+ *
+ * Support for phantom power, direct monitoring, speaker switching,
+ * and talkback added in May-June 2021.
+ *
+ * Support for Clarett+ 8Pre added in Aug 2022 by Christian
+ * Colglazier.
+ *
+ * Support for Clarett 8Pre USB added in Sep 2023 (thanks to Philippe
+ * Perrot for confirmation).
+ *
+ * Support for Clarett+ 4Pre and 2Pre added in Sep 2023 (thanks to
+ * Gregory Rozzo for donating a 4Pre, and David Sherwood and Patrice
+ * Peterson for usbmon output).
+ *
+ * Support for Clarett 2Pre and 4Pre USB added in Oct 2023.
+ *
+ * This ALSA mixer gives access to (model-dependent):
+ *  - input, output, mixer-matrix muxes
+ *  - mixer-matrix gain stages
+ *  - gain/volume/mute controls
+ *  - level meters
+ *  - line/inst level, pad, and air controls
+ *  - phantom power, direct monitor, speaker switching, and talkback
+ *    controls
+ *  - disable/enable MSD mode
+ *  - disable/enable standalone mode
+ *
+ * <ditaa>
+ *    /--------------\    18chn            20chn     /--------------\
+ *    | Hardware  in +--+------\    /-------------+--+ ALSA PCM out |
+ *    \--------------/  |      |    |             |  \--------------/
+ *                      |      |    |    /-----\  |
+ *                      |      |    |    |     |  |
+ *                      |      v    v    v     |  |
+ *                      |   +---------------+  |  |
+ *                      |    \ Matrix  Mux /   |  |
+ *                      |     +-----+-----+    |  |
+ *                      |           |          |  |
+ *                      |           |18chn     |  |
+ *                      |           |          |  |
+ *                      |           |     10chn|  |
+ *                      |           v          |  |
+ *                      |     +------------+   |  |
+ *                      |     | Mixer      |   |  |
+ *                      |     |     Matrix |   |  |
+ *                      |     |            |   |  |
+ *                      |     | 18x10 Gain |   |  |
+ *                      |     |   stages   |   |  |
+ *                      |     +-----+------+   |  |
+ *                      |           |          |  |
+ *                      |18chn      |10chn     |  |20chn
+ *                      |           |          |  |
+ *                      |           +----------/  |
+ *                      |           |             |
+ *                      v           v             v
+ *                      ===========================
+ *               +---------------+       +--—------------+
+ *                \ Output  Mux /         \ Capture Mux /
+ *                 +---+---+---+           +-----+-----+
+ *                     |   |                     |
+ *                10chn|   |                     |18chn
+ *                     |   |                     |
+ *  /--------------\   |   |                     |   /--------------\
+ *  | S/PDIF, ADAT |<--/   |10chn                \-->| ALSA PCM in  |
+ *  | Hardware out |       |                         \--------------/
+ *  \--------------/       |
+ *                         v
+ *                  +-------------+    Software gain per channel.
+ *                  | Master Gain |<-- 18i20 only: Switch per channel
+ *                  +------+------+    to select HW or SW gain control.
+ *                         |
+ *                         |10chn
+ *  /--------------\       |
+ *  | Analogue     |<------/
+ *  | Hardware out |
+ *  \--------------/
+ * </ditaa>
+ *
+ * Gen 3 devices have a Mass Storage Device (MSD) mode where a small
+ * disk with registration and driver download information is presented
+ * to the host. To access the full functionality of the device without
+ * proprietary software, MSD mode can be disabled by:
+ * - holding down the 48V button for five seconds while powering on
+ *   the device, or
+ * - using this driver and alsamixer to change the "MSD Mode" setting
+ *   to Off and power-cycling the device
+ */
+
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/moduleparam.h>
+
+#include <sound/control.h>
+#include <sound/tlv.h>
+
+#include "usbaudio.h"
+#include "mixer.h"
+#include "helper.h"
+
+#include "mixer_scarlett2.h"
+
+/* device_setup value to allow turning MSD mode back on */
+#define SCARLETT2_MSD_ENABLE 0x02
+
+/* device_setup value to disable this mixer driver */
+#define SCARLETT2_DISABLE 0x04
+
+/* some gui mixers can't handle negative ctl values */
+#define SCARLETT2_VOLUME_BIAS 127
+
+/* mixer range from -80dB to +6dB in 0.5dB steps */
+#define SCARLETT2_MIXER_MIN_DB -80
+#define SCARLETT2_MIXER_BIAS (-SCARLETT2_MIXER_MIN_DB * 2)
+#define SCARLETT2_MIXER_MAX_DB 6
+#define SCARLETT2_MIXER_MAX_VALUE \
+	((SCARLETT2_MIXER_MAX_DB - SCARLETT2_MIXER_MIN_DB) * 2)
+#define SCARLETT2_MIXER_VALUE_COUNT (SCARLETT2_MIXER_MAX_VALUE + 1)
+
+/* map from (dB + 80) * 2 to mixer value
+ * for dB in 0 .. 172: int(8192 * pow(10, ((dB - 160) / 2 / 20)))
+ */
+static const u16 scarlett2_mixer_values[SCARLETT2_MIXER_VALUE_COUNT] = {
+	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
+	2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8,
+	9, 9, 10, 10, 11, 12, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
+	23, 24, 25, 27, 29, 30, 32, 34, 36, 38, 41, 43, 46, 48, 51,
+	54, 57, 61, 65, 68, 73, 77, 81, 86, 91, 97, 103, 109, 115,
+	122, 129, 137, 145, 154, 163, 173, 183, 194, 205, 217, 230,
+	244, 259, 274, 290, 307, 326, 345, 365, 387, 410, 434, 460,
+	487, 516, 547, 579, 614, 650, 689, 730, 773, 819, 867, 919,
+	973, 1031, 1092, 1157, 1225, 1298, 1375, 1456, 1543, 1634,
+	1731, 1833, 1942, 2057, 2179, 2308, 2445, 2590, 2744, 2906,
+	3078, 3261, 3454, 3659, 3876, 4105, 4349, 4606, 4879, 5168,
+	5475, 5799, 6143, 6507, 6892, 7301, 7733, 8192, 8677, 9191,
+	9736, 10313, 10924, 11571, 12257, 12983, 13752, 14567, 15430,
+	16345
+};
+
+/* Maximum number of analogue outputs */
+#define SCARLETT2_ANALOGUE_MAX 10
+
+/* Maximum number of level and pad switches */
+#define SCARLETT2_LEVEL_SWITCH_MAX 2
+#define SCARLETT2_PAD_SWITCH_MAX 8
+#define SCARLETT2_AIR_SWITCH_MAX 8
+#define SCARLETT2_PHANTOM_SWITCH_MAX 2
+
+/* Maximum number of inputs to the mixer */
+#define SCARLETT2_INPUT_MIX_MAX 25
+
+/* Maximum number of outputs from the mixer */
+#define SCARLETT2_OUTPUT_MIX_MAX 12
+
+/* Maximum size of the data in the USB mux assignment message:
+ * 20 inputs, 20 outputs, 25 matrix inputs, 12 spare
+ */
+#define SCARLETT2_MUX_MAX 77
+
+/* Maximum number of meters (sum of output port counts) */
+#define SCARLETT2_MAX_METERS 65
+
+/* There are three different sets of configuration parameters across
+ * the devices
+ */
+enum {
+	SCARLETT2_CONFIG_SET_NO_MIXER = 0,
+	SCARLETT2_CONFIG_SET_GEN_2 = 1,
+	SCARLETT2_CONFIG_SET_GEN_3 = 2,
+	SCARLETT2_CONFIG_SET_CLARETT = 3,
+	SCARLETT2_CONFIG_SET_COUNT = 4
+};
+
+/* Hardware port types:
+ * - None (no input to mux)
+ * - Analogue I/O
+ * - S/PDIF I/O
+ * - ADAT I/O
+ * - Mixer I/O
+ * - PCM I/O
+ */
+enum {
+	SCARLETT2_PORT_TYPE_NONE     = 0,
+	SCARLETT2_PORT_TYPE_ANALOGUE = 1,
+	SCARLETT2_PORT_TYPE_SPDIF    = 2,
+	SCARLETT2_PORT_TYPE_ADAT     = 3,
+	SCARLETT2_PORT_TYPE_MIX      = 4,
+	SCARLETT2_PORT_TYPE_PCM      = 5,
+	SCARLETT2_PORT_TYPE_COUNT    = 6,
+};
+
+/* I/O count of each port type kept in struct scarlett2_ports */
+enum {
+	SCARLETT2_PORT_IN    = 0,
+	SCARLETT2_PORT_OUT   = 1,
+	SCARLETT2_PORT_DIRNS = 2,
+};
+
+/* Dim/Mute buttons on the 18i20 */
+enum {
+	SCARLETT2_BUTTON_MUTE    = 0,
+	SCARLETT2_BUTTON_DIM     = 1,
+	SCARLETT2_DIM_MUTE_COUNT = 2,
+};
+
+static const char *const scarlett2_dim_mute_names[SCARLETT2_DIM_MUTE_COUNT] = {
+	"Mute Playback Switch", "Dim Playback Switch"
+};
+
+/* Description of each hardware port type:
+ * - id: hardware ID of this port type
+ * - src_descr: printf format string for mux input selections
+ * - src_num_offset: added to channel number for the fprintf
+ * - dst_descr: printf format string for mixer controls
+ */
+struct scarlett2_port {
+	u16 id;
+	const char * const src_descr;
+	int src_num_offset;
+	const char * const dst_descr;
+};
+
+static const struct scarlett2_port scarlett2_ports[SCARLETT2_PORT_TYPE_COUNT] = {
+	[SCARLETT2_PORT_TYPE_NONE] = {
+		.id = 0x000,
+		.src_descr = "Off"
+	},
+	[SCARLETT2_PORT_TYPE_ANALOGUE] = {
+		.id = 0x080,
+		.src_descr = "Analogue %d",
+		.src_num_offset = 1,
+		.dst_descr = "Analogue Output %02d Playback"
+	},
+	[SCARLETT2_PORT_TYPE_SPDIF] = {
+		.id = 0x180,
+		.src_descr = "S/PDIF %d",
+		.src_num_offset = 1,
+		.dst_descr = "S/PDIF Output %d Playback"
+	},
+	[SCARLETT2_PORT_TYPE_ADAT] = {
+		.id = 0x200,
+		.src_descr = "ADAT %d",
+		.src_num_offset = 1,
+		.dst_descr = "ADAT Output %d Playback"
+	},
+	[SCARLETT2_PORT_TYPE_MIX] = {
+		.id = 0x300,
+		.src_descr = "Mix %c",
+		.src_num_offset = 'A',
+		.dst_descr = "Mixer Input %02d Capture"
+	},
+	[SCARLETT2_PORT_TYPE_PCM] = {
+		.id = 0x600,
+		.src_descr = "PCM %d",
+		.src_num_offset = 1,
+		.dst_descr = "PCM %02d Capture"
+	},
+};
+
+/* Number of mux tables: one for each band of sample rates
+ * (44.1/48kHz, 88.2/96kHz, and 176.4/176kHz)
+ */
+#define SCARLETT2_MUX_TABLES 3
+
+/* Maximum number of entries in a mux table */
+#define SCARLETT2_MAX_MUX_ENTRIES 10
+
+/* One entry within mux_assignment defines the port type and range of
+ * ports to add to the set_mux message. The end of the list is marked
+ * with count == 0.
+ */
+struct scarlett2_mux_entry {
+	u8 port_type;
+	u8 start;
+	u8 count;
+};
+
+struct scarlett2_device_info {
+	/* Gen 3 devices have an internal MSD mode switch that needs
+	 * to be disabled in order to access the full functionality of
+	 * the device.
+	 */
+	u8 has_msd_mode;
+
+	/* which set of configuration parameters the device uses */
+	u8 config_set;
+
+	/* line out hw volume is sw controlled */
+	u8 line_out_hw_vol;
+
+	/* support for main/alt speaker switching */
+	u8 has_speaker_switching;
+
+	/* support for talkback microphone */
+	u8 has_talkback;
+
+	/* the number of analogue inputs with a software switchable
+	 * level control that can be set to line or instrument
+	 */
+	u8 level_input_count;
+
+	/* the first input with a level control (0-based) */
+	u8 level_input_first;
+
+	/* the number of analogue inputs with a software switchable
+	 * 10dB pad control
+	 */
+	u8 pad_input_count;
+
+	/* the number of analogue inputs with a software switchable
+	 * "air" control
+	 */
+	u8 air_input_count;
+
+	/* the number of phantom (48V) software switchable controls */
+	u8 phantom_count;
+
+	/* the number of inputs each phantom switch controls */
+	u8 inputs_per_phantom;
+
+	/* the number of direct monitor options
+	 * (0 = none, 1 = mono only, 2 = mono/stereo)
+	 */
+	u8 direct_monitor;
+
+	/* remap analogue outputs; 18i8 Gen 3 has "line 3/4" connected
+	 * internally to the analogue 7/8 outputs
+	 */
+	u8 line_out_remap_enable;
+	u8 line_out_remap[SCARLETT2_ANALOGUE_MAX];
+
+	/* additional description for the line out volume controls */
+	const char * const line_out_descrs[SCARLETT2_ANALOGUE_MAX];
+
+	/* number of sources/destinations of each port type */
+	const int port_count[SCARLETT2_PORT_TYPE_COUNT][SCARLETT2_PORT_DIRNS];
+
+	/* layout/order of the entries in the set_mux message */
+	struct scarlett2_mux_entry mux_assignment[SCARLETT2_MUX_TABLES]
+						 [SCARLETT2_MAX_MUX_ENTRIES];
+};
+
+struct scarlett2_data {
+	struct usb_mixer_interface *mixer;
+	struct mutex usb_mutex; /* prevent sending concurrent USB requests */
+	struct mutex data_mutex; /* lock access to this data */
+	struct delayed_work work;
+	const struct scarlett2_device_info *info;
+	const char *series_name;
+	__u8 bInterfaceNumber;
+	__u8 bEndpointAddress;
+	__u16 wMaxPacketSize;
+	__u8 bInterval;
+	int num_mux_srcs;
+	int num_mux_dsts;
+	u16 scarlett2_seq;
+	u8 sync_updated;
+	u8 vol_updated;
+	u8 input_other_updated;
+	u8 monitor_other_updated;
+	u8 mux_updated;
+	u8 speaker_switching_switched;
+	u8 sync;
+	u8 master_vol;
+	u8 vol[SCARLETT2_ANALOGUE_MAX];
+	u8 vol_sw_hw_switch[SCARLETT2_ANALOGUE_MAX];
+	u8 mute_switch[SCARLETT2_ANALOGUE_MAX];
+	u8 level_switch[SCARLETT2_LEVEL_SWITCH_MAX];
+	u8 pad_switch[SCARLETT2_PAD_SWITCH_MAX];
+	u8 dim_mute[SCARLETT2_DIM_MUTE_COUNT];
+	u8 air_switch[SCARLETT2_AIR_SWITCH_MAX];
+	u8 phantom_switch[SCARLETT2_PHANTOM_SWITCH_MAX];
+	u8 phantom_persistence;
+	u8 direct_monitor_switch;
+	u8 speaker_switching_switch;
+	u8 talkback_switch;
+	u8 talkback_map[SCARLETT2_OUTPUT_MIX_MAX];
+	u8 msd_switch;
+	u8 standalone_switch;
+	struct snd_kcontrol *sync_ctl;
+	struct snd_kcontrol *master_vol_ctl;
+	struct snd_kcontrol *vol_ctls[SCARLETT2_ANALOGUE_MAX];
+	struct snd_kcontrol *sw_hw_ctls[SCARLETT2_ANALOGUE_MAX];
+	struct snd_kcontrol *mute_ctls[SCARLETT2_ANALOGUE_MAX];
+	struct snd_kcontrol *dim_mute_ctls[SCARLETT2_DIM_MUTE_COUNT];
+	struct snd_kcontrol *level_ctls[SCARLETT2_LEVEL_SWITCH_MAX];
+	struct snd_kcontrol *pad_ctls[SCARLETT2_PAD_SWITCH_MAX];
+	struct snd_kcontrol *air_ctls[SCARLETT2_AIR_SWITCH_MAX];
+	struct snd_kcontrol *phantom_ctls[SCARLETT2_PHANTOM_SWITCH_MAX];
+	struct snd_kcontrol *mux_ctls[SCARLETT2_MUX_MAX];
+	struct snd_kcontrol *direct_monitor_ctl;
+	struct snd_kcontrol *speaker_switching_ctl;
+	struct snd_kcontrol *talkback_ctl;
+	u8 mux[SCARLETT2_MUX_MAX];
+	u8 mix[SCARLETT2_INPUT_MIX_MAX * SCARLETT2_OUTPUT_MIX_MAX];
+};
+
+/*** Model-specific data ***/
+
+static const struct scarlett2_device_info s6i6_gen2_info = {
+	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
+	.level_input_count = 2,
+	.pad_input_count = 2,
+
+	.line_out_descrs = {
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  4,  4 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = {  6,  6 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info s18i8_gen2_info = {
+	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
+	.level_input_count = 2,
+	.pad_input_count = 4,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8,  6 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = {  8, 18 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 10 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  4 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info s18i20_gen2_info = {
+	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
+	.line_out_hw_vol = 1,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8, 10 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 18 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,     0,  8 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,     0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 10 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  6 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info solo_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
+	.level_input_count = 1,
+	.level_input_first = 1,
+	.air_input_count = 1,
+	.phantom_count = 1,
+	.inputs_per_phantom = 1,
+	.direct_monitor = 1,
+};
+
+static const struct scarlett2_device_info s2i2_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
+	.level_input_count = 2,
+	.air_input_count = 2,
+	.phantom_count = 1,
+	.inputs_per_phantom = 2,
+	.direct_monitor = 2,
+};
+
+static const struct scarlett2_device_info s4i4_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
+	.level_input_count = 2,
+	.pad_input_count = 2,
+	.air_input_count = 2,
+	.phantom_count = 1,
+	.inputs_per_phantom = 2,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		"Headphones L",
+		"Headphones R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = { 1, 0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = { 4, 4 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 6, 8 },
+		[SCARLETT2_PORT_TYPE_PCM]      = { 4, 6 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info s8i6_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
+	.level_input_count = 2,
+	.pad_input_count = 2,
+	.air_input_count = 2,
+	.phantom_count = 1,
+	.inputs_per_phantom = 2,
+
+	.line_out_descrs = {
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = { 1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = { 6,  4 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = { 2,  2 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 8,  8 },
+		[SCARLETT2_PORT_TYPE_PCM]      = { 6, 10 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info s18i8_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
+	.line_out_hw_vol = 1,
+	.has_speaker_switching = 1,
+	.level_input_count = 2,
+	.pad_input_count = 4,
+	.air_input_count = 4,
+	.phantom_count = 2,
+	.inputs_per_phantom = 2,
+
+	.line_out_remap_enable = 1,
+	.line_out_remap = { 0, 1, 6, 7, 2, 3, 4, 5 },
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		"Alt Monitor L",
+		"Alt Monitor R",
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8,  8 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 20 },
+		[SCARLETT2_PORT_TYPE_PCM]      = {  8, 20 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
+		{ SCARLETT2_PORT_TYPE_PCM,      12,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_PCM,      10,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
+		{ 0,                             0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
+		{ SCARLETT2_PORT_TYPE_PCM,      12,  4 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_PCM,      10,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
+		{ 0,                             0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
+		{ 0,                             0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info s18i20_gen3_info = {
+	.has_msd_mode = 1,
+	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
+	.line_out_hw_vol = 1,
+	.has_speaker_switching = 1,
+	.has_talkback = 1,
+	.level_input_count = 2,
+	.pad_input_count = 8,
+	.air_input_count = 8,
+	.phantom_count = 2,
+	.inputs_per_phantom = 4,
+
+	.line_out_descrs = {
+		"Monitor 1 L",
+		"Monitor 1 R",
+		"Monitor 2 L",
+		"Monitor 2 R",
+		NULL,
+		NULL,
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  9, 10 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 12, 25 },
+		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 20 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,       0,  8 },
+		{ SCARLETT2_PORT_TYPE_PCM,      10, 10 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_PCM,       8,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,       0, 25 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 12 },
+		{ 0,                             0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,       0,  8 },
+		{ SCARLETT2_PORT_TYPE_PCM,      10,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_PCM,       8,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,       0, 25 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
+		{ 0,                             0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
+		{ SCARLETT2_PORT_TYPE_NONE,      0, 24 },
+		{ 0,                             0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info clarett_2pre_info = {
+	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
+	.line_out_hw_vol = 1,
+	.level_input_count = 2,
+	.air_input_count = 2,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		"Headphones L",
+		"Headphones R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  2,  4 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  0 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = {  4, 12 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 12 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0,  2 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 26 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info clarett_4pre_info = {
+	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
+	.line_out_hw_vol = 1,
+	.level_input_count = 2,
+	.air_input_count = 4,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8,  6 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = {  8, 18 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 12 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 24 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+static const struct scarlett2_device_info clarett_8pre_info = {
+	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
+	.line_out_hw_vol = 1,
+	.level_input_count = 2,
+	.air_input_count = 8,
+
+	.line_out_descrs = {
+		"Monitor L",
+		"Monitor R",
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
+	},
+
+	.port_count = {
+		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
+		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8, 10 },
+		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
+		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
+		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
+		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 18 },
+	},
+
+	.mux_assignment = { {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,     0,  8 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_ADAT,     0,  4 },
+		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
+		{ 0,                            0,  0 },
+	}, {
+		{ SCARLETT2_PORT_TYPE_PCM,      0, 12 },
+		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
+		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
+		{ SCARLETT2_PORT_TYPE_NONE,     0, 22 },
+		{ 0,                            0,  0 },
+	} },
+};
+
+struct scarlett2_device_entry {
+	const u32 usb_id; /* USB device identifier */
+	const struct scarlett2_device_info *info;
+	const char *series_name;
+};
+
+static const struct scarlett2_device_entry scarlett2_devices[] = {
+	/* Supported Gen 2 devices */
+	{ USB_ID(0x1235, 0x8203), &s6i6_gen2_info, "Scarlett Gen 2" },
+	{ USB_ID(0x1235, 0x8204), &s18i8_gen2_info, "Scarlett Gen 2" },
+	{ USB_ID(0x1235, 0x8201), &s18i20_gen2_info, "Scarlett Gen 2" },
+
+	/* Supported Gen 3 devices */
+	{ USB_ID(0x1235, 0x8211), &solo_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8210), &s2i2_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8212), &s4i4_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8213), &s8i6_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info, "Scarlett Gen 3" },
+	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info, "Scarlett Gen 3" },
+
+	/* Supported Clarett USB/Clarett+ devices */
+	{ USB_ID(0x1235, 0x8206), &clarett_2pre_info, "Clarett USB" },
+	{ USB_ID(0x1235, 0x8207), &clarett_4pre_info, "Clarett USB" },
+	{ USB_ID(0x1235, 0x8208), &clarett_8pre_info, "Clarett USB" },
+	{ USB_ID(0x1235, 0x820a), &clarett_2pre_info, "Clarett+" },
+	{ USB_ID(0x1235, 0x820b), &clarett_4pre_info, "Clarett+" },
+	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info, "Clarett+" },
+
+	/* End of list */
+	{ 0, NULL },
+};
+
+/* get the starting port index number for a given port type/direction */
+static int scarlett2_get_port_start_num(
+	const int port_count[][SCARLETT2_PORT_DIRNS],
+	int direction, int port_type)
+{
+	int i, num = 0;
+
+	for (i = 0; i < port_type; i++)
+		num += port_count[i][direction];
+
+	return num;
+}
+
+/*** USB Interactions ***/
+
+/* Notifications from the interface */
+#define SCARLETT2_USB_NOTIFY_SYNC          0x00000008
+#define SCARLETT2_USB_NOTIFY_DIM_MUTE      0x00200000
+#define SCARLETT2_USB_NOTIFY_MONITOR       0x00400000
+#define SCARLETT2_USB_NOTIFY_INPUT_OTHER   0x00800000
+#define SCARLETT2_USB_NOTIFY_MONITOR_OTHER 0x01000000
+
+/* Commands for sending/receiving requests/responses */
+#define SCARLETT2_USB_CMD_INIT 0
+#define SCARLETT2_USB_CMD_REQ  2
+#define SCARLETT2_USB_CMD_RESP 3
+
+#define SCARLETT2_USB_INIT_1    0x00000000
+#define SCARLETT2_USB_INIT_2    0x00000002
+#define SCARLETT2_USB_GET_METER 0x00001001
+#define SCARLETT2_USB_GET_MIX   0x00002001
+#define SCARLETT2_USB_SET_MIX   0x00002002
+#define SCARLETT2_USB_GET_MUX   0x00003001
+#define SCARLETT2_USB_SET_MUX   0x00003002
+#define SCARLETT2_USB_GET_SYNC  0x00006004
+#define SCARLETT2_USB_GET_DATA  0x00800000
+#define SCARLETT2_USB_SET_DATA  0x00800001
+#define SCARLETT2_USB_DATA_CMD  0x00800002
+
+#define SCARLETT2_USB_CONFIG_SAVE 6
+
+#define SCARLETT2_USB_VOLUME_STATUS_OFFSET 0x31
+#define SCARLETT2_USB_METER_LEVELS_GET_MAGIC 1
+
+/* volume status is read together (matches scarlett2_config_items[1]) */
+struct scarlett2_usb_volume_status {
+	/* dim/mute buttons */
+	u8 dim_mute[SCARLETT2_DIM_MUTE_COUNT];
+
+	u8 pad1;
+
+	/* software volume setting */
+	s16 sw_vol[SCARLETT2_ANALOGUE_MAX];
+
+	/* actual volume of output inc. dim (-18dB) */
+	s16 hw_vol[SCARLETT2_ANALOGUE_MAX];
+
+	/* internal mute buttons */
+	u8 mute_switch[SCARLETT2_ANALOGUE_MAX];
+
+	/* sw (0) or hw (1) controlled */
+	u8 sw_hw_switch[SCARLETT2_ANALOGUE_MAX];
+
+	u8 pad3[6];
+
+	/* front panel volume knob */
+	s16 master_vol;
+} __packed;
+
+/* Configuration parameters that can be read and written */
+enum {
+	SCARLETT2_CONFIG_DIM_MUTE = 0,
+	SCARLETT2_CONFIG_LINE_OUT_VOLUME = 1,
+	SCARLETT2_CONFIG_MUTE_SWITCH = 2,
+	SCARLETT2_CONFIG_SW_HW_SWITCH = 3,
+	SCARLETT2_CONFIG_LEVEL_SWITCH = 4,
+	SCARLETT2_CONFIG_PAD_SWITCH = 5,
+	SCARLETT2_CONFIG_MSD_SWITCH = 6,
+	SCARLETT2_CONFIG_AIR_SWITCH = 7,
+	SCARLETT2_CONFIG_STANDALONE_SWITCH = 8,
+	SCARLETT2_CONFIG_PHANTOM_SWITCH = 9,
+	SCARLETT2_CONFIG_PHANTOM_PERSISTENCE = 10,
+	SCARLETT2_CONFIG_DIRECT_MONITOR = 11,
+	SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH = 12,
+	SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE = 13,
+	SCARLETT2_CONFIG_TALKBACK_MAP = 14,
+	SCARLETT2_CONFIG_COUNT = 15
+};
+
+/* Location, size, and activation command number for the configuration
+ * parameters. Size is in bits and may be 1, 8, or 16.
+ */
+struct scarlett2_config {
+	u8 offset;
+	u8 size;
+	u8 activate;
+};
+
+static const struct scarlett2_config
+	scarlett2_config_items[SCARLETT2_CONFIG_SET_COUNT]
+			      [SCARLETT2_CONFIG_COUNT] =
+
+/* Devices without a mixer (Gen 3 Solo and 2i2) */
+{ {
+	[SCARLETT2_CONFIG_MSD_SWITCH] = {
+		.offset = 0x04, .size = 8, .activate = 6 },
+
+	[SCARLETT2_CONFIG_PHANTOM_PERSISTENCE] = {
+		.offset = 0x05, .size = 8, .activate = 6 },
+
+	[SCARLETT2_CONFIG_PHANTOM_SWITCH] = {
+		.offset = 0x06, .size = 8, .activate = 3 },
+
+	[SCARLETT2_CONFIG_DIRECT_MONITOR] = {
+		.offset = 0x07, .size = 8, .activate = 4 },
+
+	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+		.offset = 0x08, .size = 1, .activate = 7 },
+
+	[SCARLETT2_CONFIG_AIR_SWITCH] = {
+		.offset = 0x09, .size = 1, .activate = 8 },
+
+/* Gen 2 devices: 6i6, 18i8, 18i20 */
+}, {
+	[SCARLETT2_CONFIG_DIM_MUTE] = {
+		.offset = 0x31, .size = 8, .activate = 2 },
+
+	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
+		.offset = 0x34, .size = 16, .activate = 1 },
+
+	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
+		.offset = 0x5c, .size = 8, .activate = 1 },
+
+	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
+		.offset = 0x66, .size = 8, .activate = 3 },
+
+	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+		.offset = 0x7c, .size = 8, .activate = 7 },
+
+	[SCARLETT2_CONFIG_PAD_SWITCH] = {
+		.offset = 0x84, .size = 8, .activate = 8 },
+
+	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
+		.offset = 0x8d, .size = 8, .activate = 6 },
+
+/* Gen 3 devices: 4i4, 8i6, 18i8, 18i20 */
+}, {
+	[SCARLETT2_CONFIG_DIM_MUTE] = {
+		.offset = 0x31, .size = 8, .activate = 2 },
+
+	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
+		.offset = 0x34, .size = 16, .activate = 1 },
+
+	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
+		.offset = 0x5c, .size = 8, .activate = 1 },
+
+	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
+		.offset = 0x66, .size = 8, .activate = 3 },
+
+	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+		.offset = 0x7c, .size = 8, .activate = 7 },
+
+	[SCARLETT2_CONFIG_PAD_SWITCH] = {
+		.offset = 0x84, .size = 8, .activate = 8 },
+
+	[SCARLETT2_CONFIG_AIR_SWITCH] = {
+		.offset = 0x8c, .size = 8, .activate = 8 },
+
+	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
+		.offset = 0x95, .size = 8, .activate = 6 },
+
+	[SCARLETT2_CONFIG_PHANTOM_SWITCH] = {
+		.offset = 0x9c, .size = 1, .activate = 8 },
+
+	[SCARLETT2_CONFIG_MSD_SWITCH] = {
+		.offset = 0x9d, .size = 8, .activate = 6 },
+
+	[SCARLETT2_CONFIG_PHANTOM_PERSISTENCE] = {
+		.offset = 0x9e, .size = 8, .activate = 6 },
+
+	[SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH] = {
+		.offset = 0x9f, .size = 1, .activate = 10 },
+
+	[SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE] = {
+		.offset = 0xa0, .size = 1, .activate = 10 },
+
+	[SCARLETT2_CONFIG_TALKBACK_MAP] = {
+		.offset = 0xb0, .size = 16, .activate = 10 },
+
+/* Clarett USB and Clarett+ devices: 2Pre, 4Pre, 8Pre */
+}, {
+	[SCARLETT2_CONFIG_DIM_MUTE] = {
+		.offset = 0x31, .size = 8, .activate = 2 },
+
+	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
+		.offset = 0x34, .size = 16, .activate = 1 },
+
+	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
+		.offset = 0x5c, .size = 8, .activate = 1 },
+
+	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
+		.offset = 0x66, .size = 8, .activate = 3 },
+
+	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+		.offset = 0x7c, .size = 8, .activate = 7 },
+
+	[SCARLETT2_CONFIG_AIR_SWITCH] = {
+		.offset = 0x95, .size = 8, .activate = 8 },
+
+	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
+		.offset = 0x8d, .size = 8, .activate = 6 },
+} };
+
+/* proprietary request/response format */
+struct scarlett2_usb_packet {
+	__le32 cmd;
+	__le16 size;
+	__le16 seq;
+	__le32 error;
+	__le32 pad;
+	u8 data[];
+};
+
+static void scarlett2_fill_request_header(struct scarlett2_data *private,
+					  struct scarlett2_usb_packet *req,
+					  u32 cmd, u16 req_size)
+{
+	/* sequence must go up by 1 for each request */
+	u16 seq = private->scarlett2_seq++;
+
+	req->cmd = cpu_to_le32(cmd);
+	req->size = cpu_to_le16(req_size);
+	req->seq = cpu_to_le16(seq);
+	req->error = 0;
+	req->pad = 0;
+}
+
+static int scarlett2_usb_tx(struct usb_device *dev, int interface,
+			    void *buf, u16 size)
+{
+	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			SCARLETT2_USB_CMD_REQ,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			0, interface, buf, size);
+}
+
+static int scarlett2_usb_rx(struct usb_device *dev, int interface,
+			    u32 usb_req, void *buf, u16 size)
+{
+	return snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			usb_req,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			0, interface, buf, size);
+}
+
+/* Send a proprietary format request to the Scarlett interface */
+static int scarlett2_usb(
+	struct usb_mixer_interface *mixer, u32 cmd,
+	void *req_data, u16 req_size, void *resp_data, u16 resp_size)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	struct usb_device *dev = mixer->chip->dev;
+	struct scarlett2_usb_packet *req, *resp = NULL;
+	size_t req_buf_size = struct_size(req, data, req_size);
+	size_t resp_buf_size = struct_size(resp, data, resp_size);
+	int err;
+
+	req = kmalloc(req_buf_size, GFP_KERNEL);
+	if (!req) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	resp = kmalloc(resp_buf_size, GFP_KERNEL);
+	if (!resp) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	mutex_lock(&private->usb_mutex);
+
+	/* build request message and send it */
+
+	scarlett2_fill_request_header(private, req, cmd, req_size);
+
+	if (req_size)
+		memcpy(req->data, req_data, req_size);
+
+	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
+			       req, req_buf_size);
+
+	if (err != req_buf_size) {
+		usb_audio_err(
+			mixer->chip,
+			"%s USB request result cmd %x was %d\n",
+			private->series_name, cmd, err);
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	/* send a second message to get the response */
+
+	err = scarlett2_usb_rx(dev, private->bInterfaceNumber,
+			       SCARLETT2_USB_CMD_RESP,
+			       resp, resp_buf_size);
+
+	/* validate the response */
+
+	if (err != resp_buf_size) {
+		usb_audio_err(
+			mixer->chip,
+			"%s USB response result cmd %x was %d expected %zu\n",
+			private->series_name, cmd, err, resp_buf_size);
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	/* cmd/seq/size should match except when initialising
+	 * seq sent = 1, response = 0
+	 */
+	if (resp->cmd != req->cmd ||
+	    (resp->seq != req->seq &&
+		(le16_to_cpu(req->seq) != 1 || resp->seq != 0)) ||
+	    resp_size != le16_to_cpu(resp->size) ||
+	    resp->error ||
+	    resp->pad) {
+		usb_audio_err(
+			mixer->chip,
+			"%s USB invalid response; "
+			   "cmd tx/rx %d/%d seq %d/%d size %d/%d "
+			   "error %d pad %d\n",
+			private->series_name,
+			le32_to_cpu(req->cmd), le32_to_cpu(resp->cmd),
+			le16_to_cpu(req->seq), le16_to_cpu(resp->seq),
+			resp_size, le16_to_cpu(resp->size),
+			le32_to_cpu(resp->error),
+			le32_to_cpu(resp->pad));
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	if (resp_data && resp_size > 0)
+		memcpy(resp_data, resp->data, resp_size);
+
+unlock:
+	mutex_unlock(&private->usb_mutex);
+error:
+	kfree(req);
+	kfree(resp);
+	return err;
+}
+
+/* Send a USB message to get data; result placed in *buf */
+static int scarlett2_usb_get(
+	struct usb_mixer_interface *mixer,
+	int offset, void *buf, int size)
+{
+	struct {
+		__le32 offset;
+		__le32 size;
+	} __packed req;
+
+	req.offset = cpu_to_le32(offset);
+	req.size = cpu_to_le32(size);
+	return scarlett2_usb(mixer, SCARLETT2_USB_GET_DATA,
+			     &req, sizeof(req), buf, size);
+}
+
+/* Send a USB message to get configuration parameters; result placed in *buf */
+static int scarlett2_usb_get_config(
+	struct usb_mixer_interface *mixer,
+	int config_item_num, int count, void *buf)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const struct scarlett2_config *config_item =
+		&scarlett2_config_items[info->config_set][config_item_num];
+	int size, err, i;
+	u8 *buf_8;
+	u8 value;
+
+	/* For byte-sized parameters, retrieve directly into buf */
+	if (config_item->size >= 8) {
+		size = config_item->size / 8 * count;
+		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
+		if (err < 0)
+			return err;
+		if (size == 2) {
+			u16 *buf_16 = buf;
+
+			for (i = 0; i < count; i++, buf_16++)
+				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
+		}
+		return 0;
+	}
+
+	/* For bit-sized parameters, retrieve into value */
+	err = scarlett2_usb_get(mixer, config_item->offset, &value, 1);
+	if (err < 0)
+		return err;
+
+	/* then unpack from value into buf[] */
+	buf_8 = buf;
+	for (i = 0; i < 8 && i < count; i++, value >>= 1)
+		*buf_8++ = value & 1;
+
+	return 0;
+}
+
+/* Send SCARLETT2_USB_DATA_CMD SCARLETT2_USB_CONFIG_SAVE */
+static void scarlett2_config_save(struct usb_mixer_interface *mixer)
+{
+	__le32 req = cpu_to_le32(SCARLETT2_USB_CONFIG_SAVE);
+
+	int err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
+				&req, sizeof(u32),
+				NULL, 0);
+	if (err < 0)
+		usb_audio_err(mixer->chip, "config save failed: %d\n", err);
+}
+
+/* Delayed work to save config */
+static void scarlett2_config_save_work(struct work_struct *work)
+{
+	struct scarlett2_data *private =
+		container_of(work, struct scarlett2_data, work.work);
+
+	scarlett2_config_save(private->mixer);
+}
+
+/* Send a USB message to set a SCARLETT2_CONFIG_* parameter */
+static int scarlett2_usb_set_config(
+	struct usb_mixer_interface *mixer,
+	int config_item_num, int index, int value)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const struct scarlett2_config *config_item =
+	       &scarlett2_config_items[info->config_set][config_item_num];
+	struct {
+		__le32 offset;
+		__le32 bytes;
+		__le32 value;
+	} __packed req;
+	__le32 req2;
+	int offset, size;
+	int err;
+
+	/* Cancel any pending NVRAM save */
+	cancel_delayed_work_sync(&private->work);
+
+	/* Convert config_item->size in bits to size in bytes and
+	 * calculate offset
+	 */
+	if (config_item->size >= 8) {
+		size = config_item->size / 8;
+		offset = config_item->offset + index * size;
+
+	/* If updating a bit, retrieve the old value, set/clear the
+	 * bit as needed, and update value
+	 */
+	} else {
+		u8 tmp;
+
+		size = 1;
+		offset = config_item->offset;
+
+		err = scarlett2_usb_get(mixer, offset, &tmp, 1);
+		if (err < 0)
+			return err;
+
+		if (value)
+			tmp |= (1 << index);
+		else
+			tmp &= ~(1 << index);
+
+		value = tmp;
+	}
+
+	/* Send the configuration parameter data */
+	req.offset = cpu_to_le32(offset);
+	req.bytes = cpu_to_le32(size);
+	req.value = cpu_to_le32(value);
+	err = scarlett2_usb(mixer, SCARLETT2_USB_SET_DATA,
+			    &req, sizeof(u32) * 2 + size,
+			    NULL, 0);
+	if (err < 0)
+		return err;
+
+	/* Activate the change */
+	req2 = cpu_to_le32(config_item->activate);
+	err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
+			    &req2, sizeof(req2), NULL, 0);
+	if (err < 0)
+		return err;
+
+	/* Schedule the change to be written to NVRAM */
+	if (config_item->activate != SCARLETT2_USB_CONFIG_SAVE)
+		schedule_delayed_work(&private->work, msecs_to_jiffies(2000));
+
+	return 0;
+}
+
+/* Send a USB message to get sync status; result placed in *sync */
+static int scarlett2_usb_get_sync_status(
+	struct usb_mixer_interface *mixer,
+	u8 *sync)
+{
+	__le32 data;
+	int err;
+
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_SYNC,
+			    NULL, 0, &data, sizeof(data));
+	if (err < 0)
+		return err;
+
+	*sync = !!data;
+	return 0;
+}
+
+/* Send a USB message to get volume status; result placed in *buf */
+static int scarlett2_usb_get_volume_status(
+	struct usb_mixer_interface *mixer,
+	struct scarlett2_usb_volume_status *buf)
+{
+	return scarlett2_usb_get(mixer, SCARLETT2_USB_VOLUME_STATUS_OFFSET,
+				 buf, sizeof(*buf));
+}
+
+/* Send a USB message to get the volumes for all inputs of one mix
+ * and put the values into private->mix[]
+ */
+static int scarlett2_usb_get_mix(struct usb_mixer_interface *mixer,
+				 int mix_num)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	int num_mixer_in =
+		info->port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
+	int err, i, j, k;
+
+	struct {
+		__le16 mix_num;
+		__le16 count;
+	} __packed req;
+
+	__le16 data[SCARLETT2_INPUT_MIX_MAX];
+
+	req.mix_num = cpu_to_le16(mix_num);
+	req.count = cpu_to_le16(num_mixer_in);
+
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_MIX,
+			    &req, sizeof(req),
+			    data, num_mixer_in * sizeof(u16));
+	if (err < 0)
+		return err;
+
+	for (i = 0, j = mix_num * num_mixer_in; i < num_mixer_in; i++, j++) {
+		u16 mixer_value = le16_to_cpu(data[i]);
+
+		for (k = 0; k < SCARLETT2_MIXER_VALUE_COUNT; k++)
+			if (scarlett2_mixer_values[k] >= mixer_value)
+				break;
+		if (k == SCARLETT2_MIXER_VALUE_COUNT)
+			k = SCARLETT2_MIXER_MAX_VALUE;
+		private->mix[j] = k;
+	}
+
+	return 0;
+}
+
+/* Send a USB message to set the volumes for all inputs of one mix
+ * (values obtained from private->mix[])
+ */
+static int scarlett2_usb_set_mix(struct usb_mixer_interface *mixer,
+				 int mix_num)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	struct {
+		__le16 mix_num;
+		__le16 data[SCARLETT2_INPUT_MIX_MAX];
+	} __packed req;
+
+	int i, j;
+	int num_mixer_in =
+		info->port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
+
+	req.mix_num = cpu_to_le16(mix_num);
+
+	for (i = 0, j = mix_num * num_mixer_in; i < num_mixer_in; i++, j++)
+		req.data[i] = cpu_to_le16(
+			scarlett2_mixer_values[private->mix[j]]
+		);
+
+	return scarlett2_usb(mixer, SCARLETT2_USB_SET_MIX,
+			     &req, (num_mixer_in + 1) * sizeof(u16),
+			     NULL, 0);
+}
+
+/* Convert a port number index (per info->port_count) to a hardware ID */
+static u32 scarlett2_mux_src_num_to_id(
+	const int port_count[][SCARLETT2_PORT_DIRNS], int num)
+{
+	int port_type;
+
+	for (port_type = 0;
+	     port_type < SCARLETT2_PORT_TYPE_COUNT;
+	     port_type++) {
+		if (num < port_count[port_type][SCARLETT2_PORT_IN])
+			return scarlett2_ports[port_type].id | num;
+		num -= port_count[port_type][SCARLETT2_PORT_IN];
+	}
+
+	/* Oops */
+	return 0;
+}
+
+/* Convert a hardware ID to a port number index */
+static u32 scarlett2_mux_id_to_num(
+	const int port_count[][SCARLETT2_PORT_DIRNS], int direction, u32 id)
+{
+	int port_type;
+	int port_num = 0;
+
+	for (port_type = 0;
+	     port_type < SCARLETT2_PORT_TYPE_COUNT;
+	     port_type++) {
+		int base = scarlett2_ports[port_type].id;
+		int count = port_count[port_type][direction];
+
+		if (id >= base && id < base + count)
+			return port_num + id - base;
+		port_num += count;
+	}
+
+	/* Oops */
+	return -1;
+}
+
+/* Convert one mux entry from the interface and load into private->mux[] */
+static void scarlett2_usb_populate_mux(struct scarlett2_data *private,
+				       u32 mux_entry)
+{
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+
+	int dst_idx, src_idx;
+
+	dst_idx = scarlett2_mux_id_to_num(port_count, SCARLETT2_PORT_OUT,
+					  mux_entry & 0xFFF);
+	if (dst_idx < 0)
+		return;
+
+	if (dst_idx >= private->num_mux_dsts) {
+		usb_audio_err(private->mixer->chip,
+			"BUG: scarlett2_mux_id_to_num(%06x, OUT): %d >= %d",
+			mux_entry, dst_idx, private->num_mux_dsts);
+		return;
+	}
+
+	src_idx = scarlett2_mux_id_to_num(port_count, SCARLETT2_PORT_IN,
+					  mux_entry >> 12);
+	if (src_idx < 0)
+		return;
+
+	if (src_idx >= private->num_mux_srcs) {
+		usb_audio_err(private->mixer->chip,
+			"BUG: scarlett2_mux_id_to_num(%06x, IN): %d >= %d",
+			mux_entry, src_idx, private->num_mux_srcs);
+		return;
+	}
+
+	private->mux[dst_idx] = src_idx;
+}
+
+/* Send USB message to get mux inputs and then populate private->mux[] */
+static int scarlett2_usb_get_mux(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	int count = private->num_mux_dsts;
+	int err, i;
+
+	struct {
+		__le16 num;
+		__le16 count;
+	} __packed req;
+
+	__le32 data[SCARLETT2_MUX_MAX];
+
+	private->mux_updated = 0;
+
+	req.num = 0;
+	req.count = cpu_to_le16(count);
+
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_MUX,
+			    &req, sizeof(req),
+			    data, count * sizeof(u32));
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < count; i++)
+		scarlett2_usb_populate_mux(private, le32_to_cpu(data[i]));
+
+	return 0;
+}
+
+/* Send USB messages to set mux inputs */
+static int scarlett2_usb_set_mux(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int table;
+
+	struct {
+		__le16 pad;
+		__le16 num;
+		__le32 data[SCARLETT2_MUX_MAX];
+	} __packed req;
+
+	req.pad = 0;
+
+	/* set mux settings for each rate */
+	for (table = 0; table < SCARLETT2_MUX_TABLES; table++) {
+		const struct scarlett2_mux_entry *entry;
+
+		/* i counts over the output array */
+		int i = 0, err;
+
+		req.num = cpu_to_le16(table);
+
+		/* loop through each entry */
+		for (entry = info->mux_assignment[table];
+		     entry->count;
+		     entry++) {
+			int j;
+			int port_type = entry->port_type;
+			int port_idx = entry->start;
+			int mux_idx = scarlett2_get_port_start_num(port_count,
+				SCARLETT2_PORT_OUT, port_type) + port_idx;
+			int dst_id = scarlett2_ports[port_type].id + port_idx;
+
+			/* Empty slots */
+			if (!dst_id) {
+				for (j = 0; j < entry->count; j++)
+					req.data[i++] = 0;
+				continue;
+			}
+
+			/* Non-empty mux slots use the lower 12 bits
+			 * for the destination and next 12 bits for
+			 * the source
+			 */
+			for (j = 0; j < entry->count; j++) {
+				int src_id = scarlett2_mux_src_num_to_id(
+					port_count, private->mux[mux_idx++]);
+				req.data[i++] = cpu_to_le32(dst_id |
+							    src_id << 12);
+				dst_id++;
+			}
+		}
+
+		err = scarlett2_usb(mixer, SCARLETT2_USB_SET_MUX,
+				    &req, (i + 1) * sizeof(u32),
+				    NULL, 0);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Send USB message to get meter levels */
+static int scarlett2_usb_get_meter_levels(struct usb_mixer_interface *mixer,
+					  u16 num_meters, u16 *levels)
+{
+	struct {
+		__le16 pad;
+		__le16 num_meters;
+		__le32 magic;
+	} __packed req;
+	u32 resp[SCARLETT2_MAX_METERS];
+	int i, err;
+
+	req.pad = 0;
+	req.num_meters = cpu_to_le16(num_meters);
+	req.magic = cpu_to_le32(SCARLETT2_USB_METER_LEVELS_GET_MAGIC);
+	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_METER,
+			    &req, sizeof(req), resp, num_meters * sizeof(u32));
+	if (err < 0)
+		return err;
+
+	/* copy, convert to u16 */
+	for (i = 0; i < num_meters; i++)
+		levels[i] = resp[i];
+
+	return 0;
+}
+
+/*** Control Functions ***/
+
+/* helper function to create a new control */
+static int scarlett2_add_new_ctl(struct usb_mixer_interface *mixer,
+				 const struct snd_kcontrol_new *ncontrol,
+				 int index, int channels, const char *name,
+				 struct snd_kcontrol **kctl_return)
+{
+	struct snd_kcontrol *kctl;
+	struct usb_mixer_elem_info *elem;
+	int err;
+
+	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
+	if (!elem)
+		return -ENOMEM;
+
+	/* We set USB_MIXER_BESPOKEN type, so that the core USB mixer code
+	 * ignores them for resume and other operations.
+	 * Also, the head.id field is set to 0, as we don't use this field.
+	 */
+	elem->head.mixer = mixer;
+	elem->control = index;
+	elem->head.id = 0;
+	elem->channels = channels;
+	elem->val_type = USB_MIXER_BESPOKEN;
+
+	kctl = snd_ctl_new1(ncontrol, elem);
+	if (!kctl) {
+		kfree(elem);
+		return -ENOMEM;
+	}
+	kctl->private_free = snd_usb_mixer_elem_free;
+
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+
+	err = snd_usb_mixer_add_control(&elem->head, kctl);
+	if (err < 0)
+		return err;
+
+	if (kctl_return)
+		*kctl_return = kctl;
+
+	return 0;
+}
+
+/*** Sync Control ***/
+
+/* Update sync control after receiving notification that the status
+ * has changed
+ */
+static int scarlett2_update_sync(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	private->sync_updated = 0;
+	return scarlett2_usb_get_sync_status(mixer, &private->sync);
+}
+
+static int scarlett2_sync_ctl_info(struct snd_kcontrol *kctl,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	static const char *texts[2] = {
+		"Unlocked", "Locked"
+	};
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
+}
+
+static int scarlett2_sync_ctl_get(struct snd_kcontrol *kctl,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->sync_updated) {
+		err = scarlett2_update_sync(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->sync;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_sync_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.name = "",
+	.info = scarlett2_sync_ctl_info,
+	.get  = scarlett2_sync_ctl_get
+};
+
+static int scarlett2_add_sync_ctl(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	/* devices without a mixer also don't support reporting sync status */
+	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
+		return 0;
+
+	return scarlett2_add_new_ctl(mixer, &scarlett2_sync_ctl,
+				     0, 1, "Sync Status", &private->sync_ctl);
+}
+
+/*** Analogue Line Out Volume Controls ***/
+
+/* Update hardware volume controls after receiving notification that
+ * they have changed
+ */
+static int scarlett2_update_volumes(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	struct scarlett2_usb_volume_status volume_status;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+	int err, i;
+	int mute;
+
+	private->vol_updated = 0;
+
+	err = scarlett2_usb_get_volume_status(mixer, &volume_status);
+	if (err < 0)
+		return err;
+
+	private->master_vol = clamp(
+		volume_status.master_vol + SCARLETT2_VOLUME_BIAS,
+		0, SCARLETT2_VOLUME_BIAS);
+
+	if (info->line_out_hw_vol)
+		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
+			private->dim_mute[i] = !!volume_status.dim_mute[i];
+
+	mute = private->dim_mute[SCARLETT2_BUTTON_MUTE];
+
+	for (i = 0; i < num_line_out; i++)
+		if (private->vol_sw_hw_switch[i]) {
+			private->vol[i] = private->master_vol;
+			private->mute_switch[i] = mute;
+		}
+
+	return 0;
+}
+
+static int scarlett2_volume_ctl_info(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = elem->channels;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SCARLETT2_VOLUME_BIAS;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int scarlett2_master_volume_ctl_get(struct snd_kcontrol *kctl,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->vol_updated) {
+		err = scarlett2_update_volumes(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] = private->master_vol;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int line_out_remap(struct scarlett2_data *private, int index)
+{
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int line_out_count =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+
+	if (!info->line_out_remap_enable)
+		return index;
+
+	if (index >= line_out_count)
+		return index;
+
+	return info->line_out_remap[index];
+}
+
+static int scarlett2_volume_ctl_get(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->vol_updated) {
+		err = scarlett2_update_volumes(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] = private->vol[index];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_volume_ctl_put(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->vol[index];
+	val = ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->vol[index] = val;
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LINE_OUT_VOLUME,
+				       index, val - SCARLETT2_VOLUME_BIAS);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const DECLARE_TLV_DB_MINMAX(
+	db_scale_scarlett2_gain, -SCARLETT2_VOLUME_BIAS * 100, 0
+);
+
+static const struct snd_kcontrol_new scarlett2_master_volume_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	.name = "",
+	.info = scarlett2_volume_ctl_info,
+	.get  = scarlett2_master_volume_ctl_get,
+	.private_value = 0, /* max value */
+	.tlv = { .p = db_scale_scarlett2_gain }
+};
+
+static const struct snd_kcontrol_new scarlett2_line_out_volume_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	.name = "",
+	.info = scarlett2_volume_ctl_info,
+	.get  = scarlett2_volume_ctl_get,
+	.put  = scarlett2_volume_ctl_put,
+	.private_value = 0, /* max value */
+	.tlv = { .p = db_scale_scarlett2_gain }
+};
+
+/*** Mute Switch Controls ***/
+
+static int scarlett2_mute_ctl_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->vol_updated) {
+		err = scarlett2_update_volumes(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] = private->mute_switch[index];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_mute_ctl_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->mute_switch[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->mute_switch[index] = val;
+
+	/* Send mute change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_MUTE_SWITCH,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_mute_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_mute_ctl_get,
+	.put  = scarlett2_mute_ctl_put,
+};
+
+/*** HW/SW Volume Switch Controls ***/
+
+static void scarlett2_sw_hw_ctl_ro(struct scarlett2_data *private, int index)
+{
+	private->sw_hw_ctls[index]->vd[0].access &=
+		~SNDRV_CTL_ELEM_ACCESS_WRITE;
+}
+
+static void scarlett2_sw_hw_ctl_rw(struct scarlett2_data *private, int index)
+{
+	private->sw_hw_ctls[index]->vd[0].access |=
+		SNDRV_CTL_ELEM_ACCESS_WRITE;
+}
+
+static int scarlett2_sw_hw_enum_ctl_info(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const values[2] = {
+		"SW", "HW"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 2, values);
+}
+
+static int scarlett2_sw_hw_enum_ctl_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+
+	ucontrol->value.enumerated.item[0] = private->vol_sw_hw_switch[index];
+	return 0;
+}
+
+static void scarlett2_vol_ctl_set_writable(struct usb_mixer_interface *mixer,
+					   int index, int value)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	struct snd_card *card = mixer->chip->card;
+
+	/* Set/Clear write bits */
+	if (value) {
+		private->vol_ctls[index]->vd[0].access |=
+			SNDRV_CTL_ELEM_ACCESS_WRITE;
+		private->mute_ctls[index]->vd[0].access |=
+			SNDRV_CTL_ELEM_ACCESS_WRITE;
+	} else {
+		private->vol_ctls[index]->vd[0].access &=
+			~SNDRV_CTL_ELEM_ACCESS_WRITE;
+		private->mute_ctls[index]->vd[0].access &=
+			~SNDRV_CTL_ELEM_ACCESS_WRITE;
+	}
+
+	/* Notify of write bit and possible value change */
+	snd_ctl_notify(card,
+		       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
+		       &private->vol_ctls[index]->id);
+	snd_ctl_notify(card,
+		       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
+		       &private->mute_ctls[index]->id);
+}
+
+static int scarlett2_sw_hw_change(struct usb_mixer_interface *mixer,
+				  int ctl_index, int val)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, ctl_index);
+	int err;
+
+	private->vol_sw_hw_switch[index] = val;
+
+	/* Change access mode to RO (hardware controlled volume)
+	 * or RW (software controlled volume)
+	 */
+	scarlett2_vol_ctl_set_writable(mixer, ctl_index, !val);
+
+	/* Reset volume/mute to master volume/mute */
+	private->vol[index] = private->master_vol;
+	private->mute_switch[index] = private->dim_mute[SCARLETT2_BUTTON_MUTE];
+
+	/* Set SW volume to current HW volume */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_LINE_OUT_VOLUME,
+		index, private->master_vol - SCARLETT2_VOLUME_BIAS);
+	if (err < 0)
+		return err;
+
+	/* Set SW mute to current HW mute */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_MUTE_SWITCH,
+		index, private->dim_mute[SCARLETT2_BUTTON_MUTE]);
+	if (err < 0)
+		return err;
+
+	/* Send SW/HW switch change to the device */
+	return scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_SW_HW_SWITCH,
+					index, val);
+}
+
+static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int ctl_index = elem->control;
+	int index = line_out_remap(private, ctl_index);
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->vol_sw_hw_switch[index];
+	val = !!ucontrol->value.enumerated.item[0];
+
+	if (oval == val)
+		goto unlock;
+
+	err = scarlett2_sw_hw_change(mixer, ctl_index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_sw_hw_enum_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = scarlett2_sw_hw_enum_ctl_info,
+	.get  = scarlett2_sw_hw_enum_ctl_get,
+	.put  = scarlett2_sw_hw_enum_ctl_put,
+};
+
+/*** Line Level/Instrument Level Switch Controls ***/
+
+static int scarlett2_update_input_other(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	private->input_other_updated = 0;
+
+	if (info->level_input_count) {
+		int err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
+			info->level_input_count + info->level_input_first,
+			private->level_switch);
+		if (err < 0)
+			return err;
+	}
+
+	if (info->pad_input_count) {
+		int err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_PAD_SWITCH,
+			info->pad_input_count, private->pad_switch);
+		if (err < 0)
+			return err;
+	}
+
+	if (info->air_input_count) {
+		int err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_AIR_SWITCH,
+			info->air_input_count, private->air_switch);
+		if (err < 0)
+			return err;
+	}
+
+	if (info->phantom_count) {
+		int err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_PHANTOM_SWITCH,
+			info->phantom_count, private->phantom_switch);
+		if (err < 0)
+			return err;
+
+		err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_PHANTOM_PERSISTENCE,
+			1, &private->phantom_persistence);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int scarlett2_level_enum_ctl_info(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const values[2] = {
+		"Line", "Inst"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 2, values);
+}
+
+static int scarlett2_level_enum_ctl_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	int index = elem->control + info->level_input_first;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->input_other_updated) {
+		err = scarlett2_update_input_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->level_switch[index];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_level_enum_ctl_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	int index = elem->control + info->level_input_first;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->level_switch[index];
+	val = !!ucontrol->value.enumerated.item[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->level_switch[index] = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_level_enum_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = scarlett2_level_enum_ctl_info,
+	.get  = scarlett2_level_enum_ctl_get,
+	.put  = scarlett2_level_enum_ctl_put,
+};
+
+/*** Pad Switch Controls ***/
+
+static int scarlett2_pad_ctl_get(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->input_other_updated) {
+		err = scarlett2_update_input_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] =
+		private->pad_switch[elem->control];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_pad_ctl_put(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int index = elem->control;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->pad_switch[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->pad_switch[index] = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PAD_SWITCH,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_pad_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_pad_ctl_get,
+	.put  = scarlett2_pad_ctl_put,
+};
+
+/*** Air Switch Controls ***/
+
+static int scarlett2_air_ctl_get(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->input_other_updated) {
+		err = scarlett2_update_input_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] = private->air_switch[elem->control];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_air_ctl_put(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int index = elem->control;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->air_switch[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->air_switch[index] = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_AIR_SWITCH,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_air_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_air_ctl_get,
+	.put  = scarlett2_air_ctl_put,
+};
+
+/*** Phantom Switch Controls ***/
+
+static int scarlett2_phantom_ctl_get(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->input_other_updated) {
+		err = scarlett2_update_input_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] =
+		private->phantom_switch[elem->control];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_phantom_ctl_put(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int index = elem->control;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->phantom_switch[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->phantom_switch[index] = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PHANTOM_SWITCH,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_phantom_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_phantom_ctl_get,
+	.put  = scarlett2_phantom_ctl_put,
+};
+
+/*** Phantom Persistence Control ***/
+
+static int scarlett2_phantom_persistence_ctl_get(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+
+	ucontrol->value.integer.value[0] = private->phantom_persistence;
+	return 0;
+}
+
+static int scarlett2_phantom_persistence_ctl_put(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int index = elem->control;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->phantom_persistence;
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->phantom_persistence = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_PHANTOM_PERSISTENCE, index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_phantom_persistence_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_phantom_persistence_ctl_get,
+	.put  = scarlett2_phantom_persistence_ctl_put,
+};
+
+/*** Direct Monitor Control ***/
+
+static int scarlett2_update_monitor_other(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	int err;
+
+	/* monitor_other_enable[0] enables speaker switching
+	 * monitor_other_enable[1] enables talkback
+	 */
+	u8 monitor_other_enable[2];
+
+	/* monitor_other_switch[0] activates the alternate speakers
+	 * monitor_other_switch[1] activates talkback
+	 */
+	u8 monitor_other_switch[2];
+
+	private->monitor_other_updated = 0;
+
+	if (info->direct_monitor)
+		return scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_DIRECT_MONITOR,
+			1, &private->direct_monitor_switch);
+
+	/* if it doesn't do speaker switching then it also doesn't do
+	 * talkback
+	 */
+	if (!info->has_speaker_switching)
+		return 0;
+
+	err = scarlett2_usb_get_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
+		2, monitor_other_enable);
+	if (err < 0)
+		return err;
+
+	err = scarlett2_usb_get_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
+		2, monitor_other_switch);
+	if (err < 0)
+		return err;
+
+	if (!monitor_other_enable[0])
+		private->speaker_switching_switch = 0;
+	else
+		private->speaker_switching_switch = monitor_other_switch[0] + 1;
+
+	if (info->has_talkback) {
+		const int (*port_count)[SCARLETT2_PORT_DIRNS] =
+			info->port_count;
+		int num_mixes =
+			port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
+		u16 bitmap;
+		int i;
+
+		if (!monitor_other_enable[1])
+			private->talkback_switch = 0;
+		else
+			private->talkback_switch = monitor_other_switch[1] + 1;
+
+		err = scarlett2_usb_get_config(mixer,
+					       SCARLETT2_CONFIG_TALKBACK_MAP,
+					       1, &bitmap);
+		if (err < 0)
+			return err;
+		for (i = 0; i < num_mixes; i++, bitmap >>= 1)
+			private->talkback_map[i] = bitmap & 1;
+	}
+
+	return 0;
+}
+
+static int scarlett2_direct_monitor_ctl_get(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->monitor_other_updated) {
+		err = scarlett2_update_monitor_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->direct_monitor_switch;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_direct_monitor_ctl_put(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int index = elem->control;
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->direct_monitor_switch;
+	val = min(ucontrol->value.enumerated.item[0], 2U);
+
+	if (oval == val)
+		goto unlock;
+
+	private->direct_monitor_switch = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_DIRECT_MONITOR, index, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_direct_monitor_stereo_enum_ctl_info(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const values[3] = {
+		"Off", "Mono", "Stereo"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 3, values);
+}
+
+/* Direct Monitor for Solo is mono-only and only needs a boolean control
+ * Direct Monitor for 2i2 is selectable between Off/Mono/Stereo
+ */
+static const struct snd_kcontrol_new scarlett2_direct_monitor_ctl[2] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "",
+		.info = snd_ctl_boolean_mono_info,
+		.get  = scarlett2_direct_monitor_ctl_get,
+		.put  = scarlett2_direct_monitor_ctl_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "",
+		.info = scarlett2_direct_monitor_stereo_enum_ctl_info,
+		.get  = scarlett2_direct_monitor_ctl_get,
+		.put  = scarlett2_direct_monitor_ctl_put,
+	}
+};
+
+static int scarlett2_add_direct_monitor_ctl(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const char *s;
+
+	if (!info->direct_monitor)
+		return 0;
+
+	s = info->direct_monitor == 1
+	      ? "Direct Monitor Playback Switch"
+	      : "Direct Monitor Playback Enum";
+
+	return scarlett2_add_new_ctl(
+		mixer, &scarlett2_direct_monitor_ctl[info->direct_monitor - 1],
+		0, 1, s, &private->direct_monitor_ctl);
+}
+
+/*** Speaker Switching Control ***/
+
+static int scarlett2_speaker_switch_enum_ctl_info(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const values[3] = {
+		"Off", "Main", "Alt"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 3, values);
+}
+
+static int scarlett2_speaker_switch_enum_ctl_get(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->monitor_other_updated) {
+		err = scarlett2_update_monitor_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->speaker_switching_switch;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+/* when speaker switching gets enabled, switch the main/alt speakers
+ * to HW volume and disable those controls
+ */
+static int scarlett2_speaker_switch_enable(struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	int i, err;
+
+	for (i = 0; i < 4; i++) {
+		int index = line_out_remap(private, i);
+
+		/* switch the main/alt speakers to HW volume */
+		if (!private->vol_sw_hw_switch[index]) {
+			err = scarlett2_sw_hw_change(private->mixer, i, 1);
+			if (err < 0)
+				return err;
+		}
+
+		/* disable the line out SW/HW switch */
+		scarlett2_sw_hw_ctl_ro(private, i);
+		snd_ctl_notify(card,
+			       SNDRV_CTL_EVENT_MASK_VALUE |
+				 SNDRV_CTL_EVENT_MASK_INFO,
+			       &private->sw_hw_ctls[i]->id);
+	}
+
+	/* when the next monitor-other notify comes in, update the mux
+	 * configuration
+	 */
+	private->speaker_switching_switched = 1;
+
+	return 0;
+}
+
+/* when speaker switching gets disabled, reenable the hw/sw controls
+ * and invalidate the routing
+ */
+static void scarlett2_speaker_switch_disable(struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	int i;
+
+	/* enable the line out SW/HW switch */
+	for (i = 0; i < 4; i++) {
+		scarlett2_sw_hw_ctl_rw(private, i);
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO,
+			       &private->sw_hw_ctls[i]->id);
+	}
+
+	/* when the next monitor-other notify comes in, update the mux
+	 * configuration
+	 */
+	private->speaker_switching_switched = 1;
+}
+
+static int scarlett2_speaker_switch_enum_ctl_put(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->speaker_switching_switch;
+	val = min(ucontrol->value.enumerated.item[0], 2U);
+
+	if (oval == val)
+		goto unlock;
+
+	private->speaker_switching_switch = val;
+
+	/* enable/disable speaker switching */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
+		0, !!val);
+	if (err < 0)
+		goto unlock;
+
+	/* if speaker switching is enabled, select main or alt */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
+		0, val == 2);
+	if (err < 0)
+		goto unlock;
+
+	/* update controls if speaker switching gets enabled or disabled */
+	if (!oval && val)
+		err = scarlett2_speaker_switch_enable(mixer);
+	else if (oval && !val)
+		scarlett2_speaker_switch_disable(mixer);
+
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_speaker_switch_enum_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = scarlett2_speaker_switch_enum_ctl_info,
+	.get  = scarlett2_speaker_switch_enum_ctl_get,
+	.put  = scarlett2_speaker_switch_enum_ctl_put,
+};
+
+static int scarlett2_add_speaker_switch_ctl(
+	struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	if (!info->has_speaker_switching)
+		return 0;
+
+	return scarlett2_add_new_ctl(
+		mixer, &scarlett2_speaker_switch_enum_ctl,
+		0, 1, "Speaker Switching Playback Enum",
+		&private->speaker_switching_ctl);
+}
+
+/*** Talkback and Talkback Map Controls ***/
+
+static int scarlett2_talkback_enum_ctl_info(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const values[3] = {
+		"Disabled", "Off", "On"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 3, values);
+}
+
+static int scarlett2_talkback_enum_ctl_get(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->monitor_other_updated) {
+		err = scarlett2_update_monitor_other(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->talkback_switch;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_talkback_enum_ctl_put(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->talkback_switch;
+	val = min(ucontrol->value.enumerated.item[0], 2U);
+
+	if (oval == val)
+		goto unlock;
+
+	private->talkback_switch = val;
+
+	/* enable/disable talkback */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
+		1, !!val);
+	if (err < 0)
+		goto unlock;
+
+	/* if talkback is enabled, select main or alt */
+	err = scarlett2_usb_set_config(
+		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
+		1, val == 2);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_talkback_enum_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = scarlett2_talkback_enum_ctl_info,
+	.get  = scarlett2_talkback_enum_ctl_get,
+	.put  = scarlett2_talkback_enum_ctl_put,
+};
+
+static int scarlett2_talkback_map_ctl_get(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = elem->control;
+
+	ucontrol->value.integer.value[0] = private->talkback_map[index];
+
+	return 0;
+}
+
+static int scarlett2_talkback_map_ctl_put(
+	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] =
+		private->info->port_count;
+	int num_mixes = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
+
+	int index = elem->control;
+	int oval, val, err = 0, i;
+	u16 bitmap = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->talkback_map[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->talkback_map[index] = val;
+
+	for (i = 0; i < num_mixes; i++)
+		bitmap |= private->talkback_map[i] << i;
+
+	/* Send updated bitmap to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_TALKBACK_MAP,
+				       0, bitmap);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_talkback_map_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_talkback_map_ctl_get,
+	.put  = scarlett2_talkback_map_ctl_put,
+};
+
+static int scarlett2_add_talkback_ctls(
+	struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_mixes = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
+	int err, i;
+	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	if (!info->has_talkback)
+		return 0;
+
+	err = scarlett2_add_new_ctl(
+		mixer, &scarlett2_talkback_enum_ctl,
+		0, 1, "Talkback Playback Enum",
+		&private->talkback_ctl);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < num_mixes; i++) {
+		snprintf(s, sizeof(s),
+			 "Talkback Mix %c Playback Switch", i + 'A');
+		err = scarlett2_add_new_ctl(mixer, &scarlett2_talkback_map_ctl,
+					    i, 1, s, NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*** Dim/Mute Controls ***/
+
+static int scarlett2_dim_mute_ctl_get(struct snd_kcontrol *kctl,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->vol_updated) {
+		err = scarlett2_update_volumes(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.integer.value[0] = private->dim_mute[elem->control];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_dim_mute_ctl_put(struct snd_kcontrol *kctl,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+
+	int index = elem->control;
+	int oval, val, err = 0, i;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->dim_mute[index];
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->dim_mute[index] = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_DIM_MUTE,
+				       index, val);
+	if (err == 0)
+		err = 1;
+
+	if (index == SCARLETT2_BUTTON_MUTE)
+		for (i = 0; i < num_line_out; i++) {
+			int line_index = line_out_remap(private, i);
+
+			if (private->vol_sw_hw_switch[line_index]) {
+				private->mute_switch[line_index] = val;
+				snd_ctl_notify(mixer->chip->card,
+					       SNDRV_CTL_EVENT_MASK_VALUE,
+					       &private->mute_ctls[i]->id);
+			}
+		}
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_dim_mute_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_dim_mute_ctl_get,
+	.put  = scarlett2_dim_mute_ctl_put
+};
+
+/*** Create the analogue output controls ***/
+
+static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+	int err, i;
+	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	/* Add R/O HW volume control */
+	if (info->line_out_hw_vol) {
+		snprintf(s, sizeof(s), "Master HW Playback Volume");
+		err = scarlett2_add_new_ctl(mixer,
+					    &scarlett2_master_volume_ctl,
+					    0, 1, s, &private->master_vol_ctl);
+		if (err < 0)
+			return err;
+	}
+
+	/* Add volume controls */
+	for (i = 0; i < num_line_out; i++) {
+		int index = line_out_remap(private, i);
+
+		/* Fader */
+		if (info->line_out_descrs[i])
+			snprintf(s, sizeof(s),
+				 "Line %02d (%s) Playback Volume",
+				 i + 1, info->line_out_descrs[i]);
+		else
+			snprintf(s, sizeof(s),
+				 "Line %02d Playback Volume",
+				 i + 1);
+		err = scarlett2_add_new_ctl(mixer,
+					    &scarlett2_line_out_volume_ctl,
+					    i, 1, s, &private->vol_ctls[i]);
+		if (err < 0)
+			return err;
+
+		/* Mute Switch */
+		snprintf(s, sizeof(s),
+			 "Line %02d Mute Playback Switch",
+			 i + 1);
+		err = scarlett2_add_new_ctl(mixer,
+					    &scarlett2_mute_ctl,
+					    i, 1, s,
+					    &private->mute_ctls[i]);
+		if (err < 0)
+			return err;
+
+		/* Make the fader and mute controls read-only if the
+		 * SW/HW switch is set to HW
+		 */
+		if (private->vol_sw_hw_switch[index])
+			scarlett2_vol_ctl_set_writable(mixer, i, 0);
+
+		/* SW/HW Switch */
+		if (info->line_out_hw_vol) {
+			snprintf(s, sizeof(s),
+				 "Line Out %02d Volume Control Playback Enum",
+				 i + 1);
+			err = scarlett2_add_new_ctl(mixer,
+						    &scarlett2_sw_hw_enum_ctl,
+						    i, 1, s,
+						    &private->sw_hw_ctls[i]);
+			if (err < 0)
+				return err;
+
+			/* Make the switch read-only if the line is
+			 * involved in speaker switching
+			 */
+			if (private->speaker_switching_switch && i < 4)
+				scarlett2_sw_hw_ctl_ro(private, i);
+		}
+	}
+
+	/* Add dim/mute controls */
+	if (info->line_out_hw_vol)
+		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++) {
+			err = scarlett2_add_new_ctl(
+				mixer, &scarlett2_dim_mute_ctl,
+				i, 1, scarlett2_dim_mute_names[i],
+				&private->dim_mute_ctls[i]);
+			if (err < 0)
+				return err;
+		}
+
+	return 0;
+}
+
+/*** Create the analogue input controls ***/
+
+static int scarlett2_add_line_in_ctls(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	int err, i;
+	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	const char *fmt = "Line In %d %s Capture %s";
+	const char *fmt2 = "Line In %d-%d %s Capture %s";
+
+	/* Add input level (line/inst) controls */
+	for (i = 0; i < info->level_input_count; i++) {
+		snprintf(s, sizeof(s), fmt, i + 1 + info->level_input_first,
+			 "Level", "Enum");
+		err = scarlett2_add_new_ctl(mixer, &scarlett2_level_enum_ctl,
+					    i, 1, s, &private->level_ctls[i]);
+		if (err < 0)
+			return err;
+	}
+
+	/* Add input pad controls */
+	for (i = 0; i < info->pad_input_count; i++) {
+		snprintf(s, sizeof(s), fmt, i + 1, "Pad", "Switch");
+		err = scarlett2_add_new_ctl(mixer, &scarlett2_pad_ctl,
+					    i, 1, s, &private->pad_ctls[i]);
+		if (err < 0)
+			return err;
+	}
+
+	/* Add input air controls */
+	for (i = 0; i < info->air_input_count; i++) {
+		snprintf(s, sizeof(s), fmt, i + 1, "Air", "Switch");
+		err = scarlett2_add_new_ctl(mixer, &scarlett2_air_ctl,
+					    i, 1, s, &private->air_ctls[i]);
+		if (err < 0)
+			return err;
+	}
+
+	/* Add input phantom controls */
+	if (info->inputs_per_phantom == 1) {
+		for (i = 0; i < info->phantom_count; i++) {
+			snprintf(s, sizeof(s), fmt, i + 1,
+				 "Phantom Power", "Switch");
+			err = scarlett2_add_new_ctl(
+				mixer, &scarlett2_phantom_ctl,
+				i, 1, s, &private->phantom_ctls[i]);
+			if (err < 0)
+				return err;
+		}
+	} else if (info->inputs_per_phantom > 1) {
+		for (i = 0; i < info->phantom_count; i++) {
+			int from = i * info->inputs_per_phantom + 1;
+			int to = (i + 1) * info->inputs_per_phantom;
+
+			snprintf(s, sizeof(s), fmt2, from, to,
+				 "Phantom Power", "Switch");
+			err = scarlett2_add_new_ctl(
+				mixer, &scarlett2_phantom_ctl,
+				i, 1, s, &private->phantom_ctls[i]);
+			if (err < 0)
+				return err;
+		}
+	}
+	if (info->phantom_count) {
+		err = scarlett2_add_new_ctl(
+			mixer, &scarlett2_phantom_persistence_ctl, 0, 1,
+			"Phantom Power Persistence Capture Switch", NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*** Mixer Volume Controls ***/
+
+static int scarlett2_mixer_ctl_info(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = elem->channels;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SCARLETT2_MIXER_MAX_VALUE;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int scarlett2_mixer_ctl_get(struct snd_kcontrol *kctl,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+
+	ucontrol->value.integer.value[0] = private->mix[elem->control];
+	return 0;
+}
+
+static int scarlett2_mixer_ctl_put(struct snd_kcontrol *kctl,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int oval, val, num_mixer_in, mix_num, err = 0;
+	int index = elem->control;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->mix[index];
+	val = clamp(ucontrol->value.integer.value[0],
+		    0L, (long)SCARLETT2_MIXER_MAX_VALUE);
+	num_mixer_in = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
+	mix_num = index / num_mixer_in;
+
+	if (oval == val)
+		goto unlock;
+
+	private->mix[index] = val;
+	err = scarlett2_usb_set_mix(mixer, mix_num);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const DECLARE_TLV_DB_MINMAX(
+	db_scale_scarlett2_mixer,
+	SCARLETT2_MIXER_MIN_DB * 100,
+	SCARLETT2_MIXER_MAX_DB * 100
+);
+
+static const struct snd_kcontrol_new scarlett2_mixer_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	.name = "",
+	.info = scarlett2_mixer_ctl_info,
+	.get  = scarlett2_mixer_ctl_get,
+	.put  = scarlett2_mixer_ctl_put,
+	.private_value = SCARLETT2_MIXER_MAX_DB, /* max value */
+	.tlv = { .p = db_scale_scarlett2_mixer }
+};
+
+static int scarlett2_add_mixer_ctls(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int err, i, j;
+	int index;
+	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	int num_inputs =
+		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
+	int num_outputs =
+		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
+
+	for (i = 0, index = 0; i < num_outputs; i++)
+		for (j = 0; j < num_inputs; j++, index++) {
+			snprintf(s, sizeof(s),
+				 "Mix %c Input %02d Playback Volume",
+				 'A' + i, j + 1);
+			err = scarlett2_add_new_ctl(mixer, &scarlett2_mixer_ctl,
+						    index, 1, s, NULL);
+			if (err < 0)
+				return err;
+		}
+
+	return 0;
+}
+
+/*** Mux Source Selection Controls ***/
+
+static int scarlett2_mux_src_enum_ctl_info(struct snd_kcontrol *kctl,
+					   struct snd_ctl_elem_info *uinfo)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	unsigned int item = uinfo->value.enumerated.item;
+	int items = private->num_mux_srcs;
+	int port_type;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = elem->channels;
+	uinfo->value.enumerated.items = items;
+
+	if (item >= items)
+		item = uinfo->value.enumerated.item = items - 1;
+
+	for (port_type = 0;
+	     port_type < SCARLETT2_PORT_TYPE_COUNT;
+	     port_type++) {
+		if (item < port_count[port_type][SCARLETT2_PORT_IN]) {
+			const struct scarlett2_port *port =
+				&scarlett2_ports[port_type];
+
+			sprintf(uinfo->value.enumerated.name,
+				port->src_descr, item + port->src_num_offset);
+			return 0;
+		}
+		item -= port_count[port_type][SCARLETT2_PORT_IN];
+	}
+
+	return -EINVAL;
+}
+
+static int scarlett2_mux_src_enum_ctl_get(struct snd_kcontrol *kctl,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	if (private->mux_updated) {
+		err = scarlett2_usb_get_mux(mixer);
+		if (err < 0)
+			goto unlock;
+	}
+	ucontrol->value.enumerated.item[0] = private->mux[index];
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static int scarlett2_mux_src_enum_ctl_put(struct snd_kcontrol *kctl,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+	int index = line_out_remap(private, elem->control);
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->mux[index];
+	val = min(ucontrol->value.enumerated.item[0],
+		  private->num_mux_srcs - 1U);
+
+	if (oval == val)
+		goto unlock;
+
+	private->mux[index] = val;
+	err = scarlett2_usb_set_mux(mixer);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_mux_src_enum_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = scarlett2_mux_src_enum_ctl_info,
+	.get  = scarlett2_mux_src_enum_ctl_get,
+	.put  = scarlett2_mux_src_enum_ctl_put,
+};
+
+static int scarlett2_add_mux_enums(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int port_type, channel, i;
+
+	for (i = 0, port_type = 0;
+	     port_type < SCARLETT2_PORT_TYPE_COUNT;
+	     port_type++) {
+		for (channel = 0;
+		     channel < port_count[port_type][SCARLETT2_PORT_OUT];
+		     channel++, i++) {
+			int err;
+			char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+			const char *const descr =
+				scarlett2_ports[port_type].dst_descr;
+
+			snprintf(s, sizeof(s) - 5, descr, channel + 1);
+			strcat(s, " Enum");
+
+			err = scarlett2_add_new_ctl(mixer,
+						    &scarlett2_mux_src_enum_ctl,
+						    i, 1, s,
+						    &private->mux_ctls[i]);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/*** Meter Controls ***/
+
+static int scarlett2_meter_ctl_info(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = elem->channels;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 4095;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int scarlett2_meter_ctl_get(struct snd_kcontrol *kctl,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	u16 meter_levels[SCARLETT2_MAX_METERS];
+	int i, err;
+
+	err = scarlett2_usb_get_meter_levels(elem->head.mixer, elem->channels,
+					     meter_levels);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < elem->channels; i++)
+		ucontrol->value.integer.value[i] = meter_levels[i];
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new scarlett2_meter_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.name = "",
+	.info = scarlett2_meter_ctl_info,
+	.get  = scarlett2_meter_ctl_get
+};
+
+static int scarlett2_add_meter_ctl(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	/* devices without a mixer also don't support reporting levels */
+	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
+		return 0;
+
+	return scarlett2_add_new_ctl(mixer, &scarlett2_meter_ctl,
+				     0, private->num_mux_dsts,
+				     "Level Meter", NULL);
+}
+
+/*** MSD Controls ***/
+
+static int scarlett2_msd_ctl_get(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+
+	ucontrol->value.integer.value[0] = private->msd_switch;
+	return 0;
+}
+
+static int scarlett2_msd_ctl_put(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->msd_switch;
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->msd_switch = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_MSD_SWITCH,
+				       0, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_msd_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_msd_ctl_get,
+	.put  = scarlett2_msd_ctl_put,
+};
+
+static int scarlett2_add_msd_ctl(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	if (!info->has_msd_mode)
+		return 0;
+
+	/* If MSD mode is off, hide the switch by default */
+	if (!private->msd_switch && !(mixer->chip->setup & SCARLETT2_MSD_ENABLE))
+		return 0;
+
+	/* Add MSD control */
+	return scarlett2_add_new_ctl(mixer, &scarlett2_msd_ctl,
+				     0, 1, "MSD Mode Switch", NULL);
+}
+
+/*** Standalone Control ***/
+
+static int scarlett2_standalone_ctl_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct scarlett2_data *private = elem->head.mixer->private_data;
+
+	ucontrol->value.integer.value[0] = private->standalone_switch;
+	return 0;
+}
+
+static int scarlett2_standalone_ctl_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *elem = kctl->private_data;
+	struct usb_mixer_interface *mixer = elem->head.mixer;
+	struct scarlett2_data *private = mixer->private_data;
+
+	int oval, val, err = 0;
+
+	mutex_lock(&private->data_mutex);
+
+	oval = private->standalone_switch;
+	val = !!ucontrol->value.integer.value[0];
+
+	if (oval == val)
+		goto unlock;
+
+	private->standalone_switch = val;
+
+	/* Send switch change to the device */
+	err = scarlett2_usb_set_config(mixer,
+				       SCARLETT2_CONFIG_STANDALONE_SWITCH,
+				       0, val);
+	if (err == 0)
+		err = 1;
+
+unlock:
+	mutex_unlock(&private->data_mutex);
+	return err;
+}
+
+static const struct snd_kcontrol_new scarlett2_standalone_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "",
+	.info = snd_ctl_boolean_mono_info,
+	.get  = scarlett2_standalone_ctl_get,
+	.put  = scarlett2_standalone_ctl_put,
+};
+
+static int scarlett2_add_standalone_ctl(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
+		return 0;
+
+	/* Add standalone control */
+	return scarlett2_add_new_ctl(mixer, &scarlett2_standalone_ctl,
+				     0, 1, "Standalone Switch", NULL);
+}
+
+/*** Cleanup/Suspend Callbacks ***/
+
+static void scarlett2_private_free(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	cancel_delayed_work_sync(&private->work);
+	kfree(private);
+	mixer->private_data = NULL;
+}
+
+static void scarlett2_private_suspend(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	if (cancel_delayed_work_sync(&private->work))
+		scarlett2_config_save(private->mixer);
+}
+
+/*** Initialisation ***/
+
+static void scarlett2_count_mux_io(struct scarlett2_data *private)
+{
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int port_type, srcs = 0, dsts = 0;
+
+	for (port_type = 0;
+	     port_type < SCARLETT2_PORT_TYPE_COUNT;
+	     port_type++) {
+		srcs += port_count[port_type][SCARLETT2_PORT_IN];
+		dsts += port_count[port_type][SCARLETT2_PORT_OUT];
+	}
+
+	private->num_mux_srcs = srcs;
+	private->num_mux_dsts = dsts;
+}
+
+/* Look through the interface descriptors for the Focusrite Control
+ * interface (bInterfaceClass = 255 Vendor Specific Class) and set
+ * bInterfaceNumber, bEndpointAddress, wMaxPacketSize, and bInterval
+ * in private
+ */
+static int scarlett2_find_fc_interface(struct usb_device *dev,
+				       struct scarlett2_data *private)
+{
+	struct usb_host_config *config = dev->actconfig;
+	int i;
+
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = config->interface[i];
+		struct usb_interface_descriptor *desc =
+			&intf->altsetting[0].desc;
+		struct usb_endpoint_descriptor *epd;
+
+		if (desc->bInterfaceClass != 255)
+			continue;
+
+		epd = get_endpoint(intf->altsetting, 0);
+		private->bInterfaceNumber = desc->bInterfaceNumber;
+		private->bEndpointAddress = epd->bEndpointAddress &
+			USB_ENDPOINT_NUMBER_MASK;
+		private->wMaxPacketSize = le16_to_cpu(epd->wMaxPacketSize);
+		private->bInterval = epd->bInterval;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/* Initialise private data */
+static int scarlett2_init_private(struct usb_mixer_interface *mixer,
+				  const struct scarlett2_device_entry *entry)
+{
+	struct scarlett2_data *private =
+		kzalloc(sizeof(struct scarlett2_data), GFP_KERNEL);
+
+	if (!private)
+		return -ENOMEM;
+
+	mutex_init(&private->usb_mutex);
+	mutex_init(&private->data_mutex);
+	INIT_DELAYED_WORK(&private->work, scarlett2_config_save_work);
+
+	mixer->private_data = private;
+	mixer->private_free = scarlett2_private_free;
+	mixer->private_suspend = scarlett2_private_suspend;
+
+	private->info = entry->info;
+	private->series_name = entry->series_name;
+	scarlett2_count_mux_io(private);
+	private->scarlett2_seq = 0;
+	private->mixer = mixer;
+
+	return scarlett2_find_fc_interface(mixer->chip->dev, private);
+}
+
+/* Cargo cult proprietary initialisation sequence */
+static int scarlett2_usb_init(struct usb_mixer_interface *mixer)
+{
+	struct usb_device *dev = mixer->chip->dev;
+	struct scarlett2_data *private = mixer->private_data;
+	u8 buf[24];
+	int err;
+
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
+		return -EINVAL;
+
+	/* step 0 */
+	err = scarlett2_usb_rx(dev, private->bInterfaceNumber,
+			       SCARLETT2_USB_CMD_INIT, buf, sizeof(buf));
+	if (err < 0)
+		return err;
+
+	/* step 1 */
+	private->scarlett2_seq = 1;
+	err = scarlett2_usb(mixer, SCARLETT2_USB_INIT_1, NULL, 0, NULL, 0);
+	if (err < 0)
+		return err;
+
+	/* step 2 */
+	private->scarlett2_seq = 1;
+	return scarlett2_usb(mixer, SCARLETT2_USB_INIT_2, NULL, 0, NULL, 84);
+}
+
+/* Read configuration from the interface on start */
+static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+	int num_mixer_out =
+		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
+	struct scarlett2_usb_volume_status volume_status;
+	int err, i;
+
+	if (info->has_msd_mode) {
+		err = scarlett2_usb_get_config(
+			mixer, SCARLETT2_CONFIG_MSD_SWITCH,
+			1, &private->msd_switch);
+		if (err < 0)
+			return err;
+
+		/* no other controls are created if MSD mode is on */
+		if (private->msd_switch)
+			return 0;
+	}
+
+	err = scarlett2_update_input_other(mixer);
+	if (err < 0)
+		return err;
+
+	err = scarlett2_update_monitor_other(mixer);
+	if (err < 0)
+		return err;
+
+	/* the rest of the configuration is for devices with a mixer */
+	if (info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
+		return 0;
+
+	err = scarlett2_usb_get_config(
+		mixer, SCARLETT2_CONFIG_STANDALONE_SWITCH,
+		1, &private->standalone_switch);
+	if (err < 0)
+		return err;
+
+	err = scarlett2_update_sync(mixer);
+	if (err < 0)
+		return err;
+
+	err = scarlett2_usb_get_volume_status(mixer, &volume_status);
+	if (err < 0)
+		return err;
+
+	if (info->line_out_hw_vol)
+		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
+			private->dim_mute[i] = !!volume_status.dim_mute[i];
+
+	private->master_vol = clamp(
+		volume_status.master_vol + SCARLETT2_VOLUME_BIAS,
+		0, SCARLETT2_VOLUME_BIAS);
+
+	for (i = 0; i < num_line_out; i++) {
+		int volume, mute;
+
+		private->vol_sw_hw_switch[i] =
+			info->line_out_hw_vol
+				&& volume_status.sw_hw_switch[i];
+
+		volume = private->vol_sw_hw_switch[i]
+			   ? volume_status.master_vol
+			   : volume_status.sw_vol[i];
+		volume = clamp(volume + SCARLETT2_VOLUME_BIAS,
+			       0, SCARLETT2_VOLUME_BIAS);
+		private->vol[i] = volume;
+
+		mute = private->vol_sw_hw_switch[i]
+			 ? private->dim_mute[SCARLETT2_BUTTON_MUTE]
+			 : volume_status.mute_switch[i];
+		private->mute_switch[i] = mute;
+	}
+
+	for (i = 0; i < num_mixer_out; i++) {
+		err = scarlett2_usb_get_mix(mixer, i);
+		if (err < 0)
+			return err;
+	}
+
+	return scarlett2_usb_get_mux(mixer);
+}
+
+/* Notify on sync change */
+static void scarlett2_notify_sync(
+	struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	private->sync_updated = 1;
+
+	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &private->sync_ctl->id);
+}
+
+/* Notify on monitor change */
+static void scarlett2_notify_monitor(
+	struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+	int i;
+
+	/* if line_out_hw_vol is 0, there are no controls to update */
+	if (!info->line_out_hw_vol)
+		return;
+
+	private->vol_updated = 1;
+
+	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &private->master_vol_ctl->id);
+
+	for (i = 0; i < num_line_out; i++)
+		if (private->vol_sw_hw_switch[line_out_remap(private, i)])
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &private->vol_ctls[i]->id);
+}
+
+/* Notify on dim/mute change */
+static void scarlett2_notify_dim_mute(
+	struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
+	int num_line_out =
+		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
+	int i;
+
+	private->vol_updated = 1;
+
+	if (!info->line_out_hw_vol)
+		return;
+
+	for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->dim_mute_ctls[i]->id);
+
+	for (i = 0; i < num_line_out; i++)
+		if (private->vol_sw_hw_switch[line_out_remap(private, i)])
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &private->mute_ctls[i]->id);
+}
+
+/* Notify on "input other" change (level/pad/air) */
+static void scarlett2_notify_input_other(
+	struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+	int i;
+
+	private->input_other_updated = 1;
+
+	for (i = 0; i < info->level_input_count; i++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->level_ctls[i]->id);
+	for (i = 0; i < info->pad_input_count; i++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->pad_ctls[i]->id);
+	for (i = 0; i < info->air_input_count; i++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->air_ctls[i]->id);
+	for (i = 0; i < info->phantom_count; i++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->phantom_ctls[i]->id);
+}
+
+/* Notify on "monitor other" change (direct monitor, speaker
+ * switching, talkback)
+ */
+static void scarlett2_notify_monitor_other(
+	struct usb_mixer_interface *mixer)
+{
+	struct snd_card *card = mixer->chip->card;
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_device_info *info = private->info;
+
+	private->monitor_other_updated = 1;
+
+	if (info->direct_monitor) {
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->direct_monitor_ctl->id);
+		return;
+	}
+
+	if (info->has_speaker_switching)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->speaker_switching_ctl->id);
+
+	if (info->has_talkback)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &private->talkback_ctl->id);
+
+	/* if speaker switching was recently enabled or disabled,
+	 * invalidate the dim/mute and mux enum controls
+	 */
+	if (private->speaker_switching_switched) {
+		int i;
+
+		scarlett2_notify_dim_mute(mixer);
+
+		private->speaker_switching_switched = 0;
+		private->mux_updated = 1;
+
+		for (i = 0; i < private->num_mux_dsts; i++)
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &private->mux_ctls[i]->id);
+	}
+}
+
+/* Interrupt callback */
+static void scarlett2_notify(struct urb *urb)
+{
+	struct usb_mixer_interface *mixer = urb->context;
+	int len = urb->actual_length;
+	int ustatus = urb->status;
+	u32 data;
+
+	if (ustatus != 0 || len != 8)
+		goto requeue;
+
+	data = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
+	if (data & SCARLETT2_USB_NOTIFY_SYNC)
+		scarlett2_notify_sync(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_MONITOR)
+		scarlett2_notify_monitor(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_DIM_MUTE)
+		scarlett2_notify_dim_mute(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_INPUT_OTHER)
+		scarlett2_notify_input_other(mixer);
+	if (data & SCARLETT2_USB_NOTIFY_MONITOR_OTHER)
+		scarlett2_notify_monitor_other(mixer);
+
+requeue:
+	if (ustatus != -ENOENT &&
+	    ustatus != -ECONNRESET &&
+	    ustatus != -ESHUTDOWN) {
+		urb->dev = mixer->chip->dev;
+		usb_submit_urb(urb, GFP_ATOMIC);
+	}
+}
+
+static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
+{
+	struct usb_device *dev = mixer->chip->dev;
+	struct scarlett2_data *private = mixer->private_data;
+	unsigned int pipe = usb_rcvintpipe(dev, private->bEndpointAddress);
+	void *transfer_buffer;
+
+	if (mixer->urb) {
+		usb_audio_err(mixer->chip,
+			      "%s: mixer urb already in use!\n", __func__);
+		return 0;
+	}
+
+	if (usb_pipe_type_check(dev, pipe))
+		return -EINVAL;
+
+	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!mixer->urb)
+		return -ENOMEM;
+
+	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
+	if (!transfer_buffer)
+		return -ENOMEM;
+
+	usb_fill_int_urb(mixer->urb, dev, pipe,
+			 transfer_buffer, private->wMaxPacketSize,
+			 scarlett2_notify, mixer, private->bInterval);
+
+	return usb_submit_urb(mixer->urb, GFP_KERNEL);
+}
+
+static const struct scarlett2_device_entry *get_scarlett2_device_entry(
+	struct usb_mixer_interface *mixer)
+{
+	const struct scarlett2_device_entry *entry = scarlett2_devices;
+
+	/* Find entry in scarlett2_devices */
+	while (entry->usb_id && entry->usb_id != mixer->chip->usb_id)
+		entry++;
+	if (!entry->usb_id)
+		return NULL;
+
+	return entry;
+}
+
+static int snd_scarlett2_controls_create(
+	struct usb_mixer_interface *mixer,
+	const struct scarlett2_device_entry *entry)
+{
+	int err;
+
+	/* Initialise private data */
+	err = scarlett2_init_private(mixer, entry);
+	if (err < 0)
+		return err;
+
+	/* Send proprietary USB initialisation sequence */
+	err = scarlett2_usb_init(mixer);
+	if (err < 0)
+		return err;
+
+	/* Read volume levels and controls from the interface */
+	err = scarlett2_read_configs(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the MSD control */
+	err = scarlett2_add_msd_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* If MSD mode is enabled, don't create any other controls */
+	if (((struct scarlett2_data *)mixer->private_data)->msd_switch)
+		return 0;
+
+	/* Create the analogue output controls */
+	err = scarlett2_add_line_out_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the analogue input controls */
+	err = scarlett2_add_line_in_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the input, output, and mixer mux input selections */
+	err = scarlett2_add_mux_enums(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the matrix mixer controls */
+	err = scarlett2_add_mixer_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the level meter controls */
+	err = scarlett2_add_meter_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the sync control */
+	err = scarlett2_add_sync_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the direct monitor control */
+	err = scarlett2_add_direct_monitor_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the speaker switching control */
+	err = scarlett2_add_speaker_switch_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the talkback controls */
+	err = scarlett2_add_talkback_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	/* Create the standalone control */
+	err = scarlett2_add_standalone_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	/* Set up the interrupt polling */
+	err = scarlett2_init_notify(mixer);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int snd_scarlett2_init(struct usb_mixer_interface *mixer)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	const struct scarlett2_device_entry *entry;
+	int err;
+
+	/* only use UAC_VERSION_2 */
+	if (!mixer->protocol)
+		return 0;
+
+	/* find entry in scarlett2_devices */
+	entry = get_scarlett2_device_entry(mixer);
+	if (!entry) {
+		usb_audio_err(mixer->chip,
+			      "%s: missing device entry for %04x:%04x\n",
+			      __func__,
+			      USB_ID_VENDOR(chip->usb_id),
+			      USB_ID_PRODUCT(chip->usb_id));
+		return 0;
+	}
+
+	if (chip->setup & SCARLETT2_DISABLE) {
+		usb_audio_info(chip,
+			"Focusrite %s Mixer Driver disabled "
+			"by modprobe options (snd_usb_audio "
+			"vid=0x%04x pid=0x%04x device_setup=%d)\n",
+			entry->series_name,
+			USB_ID_VENDOR(chip->usb_id),
+			USB_ID_PRODUCT(chip->usb_id),
+			SCARLETT2_DISABLE);
+		return 0;
+	}
+
+	usb_audio_info(chip,
+		"Focusrite %s Mixer Driver enabled (pid=0x%04x); "
+		"report any issues to g@b4.vu",
+		entry->series_name,
+		USB_ID_PRODUCT(chip->usb_id));
+
+	err = snd_scarlett2_controls_create(mixer, entry);
+	if (err < 0)
+		usb_audio_err(mixer->chip,
+			      "Error initialising %s Mixer Driver: %d",
+			      entry->series_name,
+			      err);
+
+	return err;
+}
diff --git a/sound/usb/mixer_scarlett2.h b/sound/usb/mixer_scarlett2.h
new file mode 100644
index 000000000000..d209362cf41a
--- /dev/null
+++ b/sound/usb/mixer_scarlett2.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __USB_MIXER_SCARLETT2_H
+#define __USB_MIXER_SCARLETT2_H
+
+int snd_scarlett2_init(struct usb_mixer_interface *mixer);
+
+#endif /* __USB_MIXER_SCARLETT2_H */
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
deleted file mode 100644
index 1bcb05c73e0a..000000000000
--- a/sound/usb/mixer_scarlett_gen2.c
+++ /dev/null
@@ -1,4274 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *   Focusrite Scarlett Gen 2/3 and Clarett+ Driver for ALSA
- *
- *   Supported models:
- *   - 6i6/18i8/18i20 Gen 2
- *   - Solo/2i2/4i4/8i6/18i8/18i20 Gen 3
- *   - Clarett+ 8Pre
- *
- *   Copyright (c) 2018-2022 by Geoffrey D. Bennett <g at b4.vu>
- *   Copyright (c) 2020-2021 by Vladimir Sadovnikov <sadko4u@gmail.com>
- *   Copyright (c) 2022 by Christian Colglazier <christian@cacolglazier.com>
- *
- *   Based on the Scarlett (Gen 1) Driver for ALSA:
- *
- *   Copyright (c) 2013 by Tobias Hoffmann
- *   Copyright (c) 2013 by Robin Gareus <robin at gareus.org>
- *   Copyright (c) 2002 by Takashi Iwai <tiwai at suse.de>
- *   Copyright (c) 2014 by Chris J Arges <chris.j.arges at canonical.com>
- *
- *   Many codes borrowed from audio.c by
- *     Alan Cox (alan at lxorguk.ukuu.org.uk)
- *     Thomas Sailer (sailer at ife.ee.ethz.ch)
- *
- *   Code cleanup:
- *   David Henningsson <david.henningsson at canonical.com>
- */
-
-/* The protocol was reverse engineered by looking at the communication
- * between Focusrite Control 2.3.4 and the Focusrite(R) Scarlett 18i20
- * (firmware 1083) using usbmon in July-August 2018.
- *
- * Scarlett 18i8 support added in April 2019.
- *
- * Scarlett 6i6 support added in June 2019 (thanks to Martin Wittmann
- * for providing usbmon output and testing).
- *
- * Scarlett 4i4/8i6 Gen 3 support added in May 2020 (thanks to Laurent
- * Debricon for donating a 4i4 and to Fredrik Unger for providing 8i6
- * usbmon output and testing).
- *
- * Scarlett 18i8/18i20 Gen 3 support added in June 2020 (thanks to
- * Darren Jaeckel, Alex Sedlack, and Clovis Lunel for providing usbmon
- * output, protocol traces and testing).
- *
- * Support for loading mixer volume and mux configuration from the
- * interface during driver initialisation added in May 2021 (thanks to
- * Vladimir Sadovnikov for figuring out how).
- *
- * Support for Solo/2i2 Gen 3 added in May 2021 (thanks to Alexander
- * Vorona for 2i2 protocol traces).
- *
- * Support for phantom power, direct monitoring, speaker switching,
- * and talkback added in May-June 2021.
- *
- * Support for Clarett+ 8Pre added in Aug 2022 by Christian
- * Colglazier.
- *
- * This ALSA mixer gives access to (model-dependent):
- *  - input, output, mixer-matrix muxes
- *  - mixer-matrix gain stages
- *  - gain/volume/mute controls
- *  - level meters
- *  - line/inst level, pad, and air controls
- *  - phantom power, direct monitor, speaker switching, and talkback
- *    controls
- *  - disable/enable MSD mode
- *  - disable/enable standalone mode
- *
- * <ditaa>
- *    /--------------\    18chn            20chn     /--------------\
- *    | Hardware  in +--+------\    /-------------+--+ ALSA PCM out |
- *    \--------------/  |      |    |             |  \--------------/
- *                      |      |    |    /-----\  |
- *                      |      |    |    |     |  |
- *                      |      v    v    v     |  |
- *                      |   +---------------+  |  |
- *                      |    \ Matrix  Mux /   |  |
- *                      |     +-----+-----+    |  |
- *                      |           |          |  |
- *                      |           |18chn     |  |
- *                      |           |          |  |
- *                      |           |     10chn|  |
- *                      |           v          |  |
- *                      |     +------------+   |  |
- *                      |     | Mixer      |   |  |
- *                      |     |     Matrix |   |  |
- *                      |     |            |   |  |
- *                      |     | 18x10 Gain |   |  |
- *                      |     |   stages   |   |  |
- *                      |     +-----+------+   |  |
- *                      |           |          |  |
- *                      |18chn      |10chn     |  |20chn
- *                      |           |          |  |
- *                      |           +----------/  |
- *                      |           |             |
- *                      v           v             v
- *                      ===========================
- *               +---------------+       +--—------------+
- *                \ Output  Mux /         \ Capture Mux /
- *                 +---+---+---+           +-----+-----+
- *                     |   |                     |
- *                10chn|   |                     |18chn
- *                     |   |                     |
- *  /--------------\   |   |                     |   /--------------\
- *  | S/PDIF, ADAT |<--/   |10chn                \-->| ALSA PCM in  |
- *  | Hardware out |       |                         \--------------/
- *  \--------------/       |
- *                         v
- *                  +-------------+    Software gain per channel.
- *                  | Master Gain |<-- 18i20 only: Switch per channel
- *                  +------+------+    to select HW or SW gain control.
- *                         |
- *                         |10chn
- *  /--------------\       |
- *  | Analogue     |<------/
- *  | Hardware out |
- *  \--------------/
- * </ditaa>
- *
- * Gen 3 devices have a Mass Storage Device (MSD) mode where a small
- * disk with registration and driver download information is presented
- * to the host. To access the full functionality of the device without
- * proprietary software, MSD mode can be disabled by:
- * - holding down the 48V button for five seconds while powering on
- *   the device, or
- * - using this driver and alsamixer to change the "MSD Mode" setting
- *   to Off and power-cycling the device
- */
-
-#include <linux/slab.h>
-#include <linux/usb.h>
-#include <linux/moduleparam.h>
-
-#include <sound/control.h>
-#include <sound/tlv.h>
-
-#include "usbaudio.h"
-#include "mixer.h"
-#include "helper.h"
-
-#include "mixer_scarlett_gen2.h"
-
-/* device_setup value to enable */
-#define SCARLETT2_ENABLE 0x01
-
-/* device_setup value to allow turning MSD mode back on */
-#define SCARLETT2_MSD_ENABLE 0x02
-
-/* some gui mixers can't handle negative ctl values */
-#define SCARLETT2_VOLUME_BIAS 127
-
-/* mixer range from -80dB to +6dB in 0.5dB steps */
-#define SCARLETT2_MIXER_MIN_DB -80
-#define SCARLETT2_MIXER_BIAS (-SCARLETT2_MIXER_MIN_DB * 2)
-#define SCARLETT2_MIXER_MAX_DB 6
-#define SCARLETT2_MIXER_MAX_VALUE \
-	((SCARLETT2_MIXER_MAX_DB - SCARLETT2_MIXER_MIN_DB) * 2)
-#define SCARLETT2_MIXER_VALUE_COUNT (SCARLETT2_MIXER_MAX_VALUE + 1)
-
-/* map from (dB + 80) * 2 to mixer value
- * for dB in 0 .. 172: int(8192 * pow(10, ((dB - 160) / 2 / 20)))
- */
-static const u16 scarlett2_mixer_values[SCARLETT2_MIXER_VALUE_COUNT] = {
-	0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
-	2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8,
-	9, 9, 10, 10, 11, 12, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
-	23, 24, 25, 27, 29, 30, 32, 34, 36, 38, 41, 43, 46, 48, 51,
-	54, 57, 61, 65, 68, 73, 77, 81, 86, 91, 97, 103, 109, 115,
-	122, 129, 137, 145, 154, 163, 173, 183, 194, 205, 217, 230,
-	244, 259, 274, 290, 307, 326, 345, 365, 387, 410, 434, 460,
-	487, 516, 547, 579, 614, 650, 689, 730, 773, 819, 867, 919,
-	973, 1031, 1092, 1157, 1225, 1298, 1375, 1456, 1543, 1634,
-	1731, 1833, 1942, 2057, 2179, 2308, 2445, 2590, 2744, 2906,
-	3078, 3261, 3454, 3659, 3876, 4105, 4349, 4606, 4879, 5168,
-	5475, 5799, 6143, 6507, 6892, 7301, 7733, 8192, 8677, 9191,
-	9736, 10313, 10924, 11571, 12257, 12983, 13752, 14567, 15430,
-	16345
-};
-
-/* Maximum number of analogue outputs */
-#define SCARLETT2_ANALOGUE_MAX 10
-
-/* Maximum number of level and pad switches */
-#define SCARLETT2_LEVEL_SWITCH_MAX 2
-#define SCARLETT2_PAD_SWITCH_MAX 8
-#define SCARLETT2_AIR_SWITCH_MAX 8
-#define SCARLETT2_PHANTOM_SWITCH_MAX 2
-
-/* Maximum number of inputs to the mixer */
-#define SCARLETT2_INPUT_MIX_MAX 25
-
-/* Maximum number of outputs from the mixer */
-#define SCARLETT2_OUTPUT_MIX_MAX 12
-
-/* Maximum size of the data in the USB mux assignment message:
- * 20 inputs, 20 outputs, 25 matrix inputs, 12 spare
- */
-#define SCARLETT2_MUX_MAX 77
-
-/* Maximum number of meters (sum of output port counts) */
-#define SCARLETT2_MAX_METERS 65
-
-/* There are three different sets of configuration parameters across
- * the devices
- */
-enum {
-	SCARLETT2_CONFIG_SET_NO_MIXER = 0,
-	SCARLETT2_CONFIG_SET_GEN_2 = 1,
-	SCARLETT2_CONFIG_SET_GEN_3 = 2,
-	SCARLETT2_CONFIG_SET_CLARETT = 3,
-	SCARLETT2_CONFIG_SET_COUNT = 4
-};
-
-/* Hardware port types:
- * - None (no input to mux)
- * - Analogue I/O
- * - S/PDIF I/O
- * - ADAT I/O
- * - Mixer I/O
- * - PCM I/O
- */
-enum {
-	SCARLETT2_PORT_TYPE_NONE     = 0,
-	SCARLETT2_PORT_TYPE_ANALOGUE = 1,
-	SCARLETT2_PORT_TYPE_SPDIF    = 2,
-	SCARLETT2_PORT_TYPE_ADAT     = 3,
-	SCARLETT2_PORT_TYPE_MIX      = 4,
-	SCARLETT2_PORT_TYPE_PCM      = 5,
-	SCARLETT2_PORT_TYPE_COUNT    = 6,
-};
-
-/* I/O count of each port type kept in struct scarlett2_ports */
-enum {
-	SCARLETT2_PORT_IN    = 0,
-	SCARLETT2_PORT_OUT   = 1,
-	SCARLETT2_PORT_DIRNS = 2,
-};
-
-/* Dim/Mute buttons on the 18i20 */
-enum {
-	SCARLETT2_BUTTON_MUTE    = 0,
-	SCARLETT2_BUTTON_DIM     = 1,
-	SCARLETT2_DIM_MUTE_COUNT = 2,
-};
-
-static const char *const scarlett2_dim_mute_names[SCARLETT2_DIM_MUTE_COUNT] = {
-	"Mute Playback Switch", "Dim Playback Switch"
-};
-
-/* Description of each hardware port type:
- * - id: hardware ID of this port type
- * - src_descr: printf format string for mux input selections
- * - src_num_offset: added to channel number for the fprintf
- * - dst_descr: printf format string for mixer controls
- */
-struct scarlett2_port {
-	u16 id;
-	const char * const src_descr;
-	int src_num_offset;
-	const char * const dst_descr;
-};
-
-static const struct scarlett2_port scarlett2_ports[SCARLETT2_PORT_TYPE_COUNT] = {
-	[SCARLETT2_PORT_TYPE_NONE] = {
-		.id = 0x000,
-		.src_descr = "Off"
-	},
-	[SCARLETT2_PORT_TYPE_ANALOGUE] = {
-		.id = 0x080,
-		.src_descr = "Analogue %d",
-		.src_num_offset = 1,
-		.dst_descr = "Analogue Output %02d Playback"
-	},
-	[SCARLETT2_PORT_TYPE_SPDIF] = {
-		.id = 0x180,
-		.src_descr = "S/PDIF %d",
-		.src_num_offset = 1,
-		.dst_descr = "S/PDIF Output %d Playback"
-	},
-	[SCARLETT2_PORT_TYPE_ADAT] = {
-		.id = 0x200,
-		.src_descr = "ADAT %d",
-		.src_num_offset = 1,
-		.dst_descr = "ADAT Output %d Playback"
-	},
-	[SCARLETT2_PORT_TYPE_MIX] = {
-		.id = 0x300,
-		.src_descr = "Mix %c",
-		.src_num_offset = 'A',
-		.dst_descr = "Mixer Input %02d Capture"
-	},
-	[SCARLETT2_PORT_TYPE_PCM] = {
-		.id = 0x600,
-		.src_descr = "PCM %d",
-		.src_num_offset = 1,
-		.dst_descr = "PCM %02d Capture"
-	},
-};
-
-/* Number of mux tables: one for each band of sample rates
- * (44.1/48kHz, 88.2/96kHz, and 176.4/176kHz)
- */
-#define SCARLETT2_MUX_TABLES 3
-
-/* Maximum number of entries in a mux table */
-#define SCARLETT2_MAX_MUX_ENTRIES 10
-
-/* One entry within mux_assignment defines the port type and range of
- * ports to add to the set_mux message. The end of the list is marked
- * with count == 0.
- */
-struct scarlett2_mux_entry {
-	u8 port_type;
-	u8 start;
-	u8 count;
-};
-
-struct scarlett2_device_info {
-	u32 usb_id; /* USB device identifier */
-
-	/* Gen 3 devices have an internal MSD mode switch that needs
-	 * to be disabled in order to access the full functionality of
-	 * the device.
-	 */
-	u8 has_msd_mode;
-
-	/* which set of configuration parameters the device uses */
-	u8 config_set;
-
-	/* line out hw volume is sw controlled */
-	u8 line_out_hw_vol;
-
-	/* support for main/alt speaker switching */
-	u8 has_speaker_switching;
-
-	/* support for talkback microphone */
-	u8 has_talkback;
-
-	/* the number of analogue inputs with a software switchable
-	 * level control that can be set to line or instrument
-	 */
-	u8 level_input_count;
-
-	/* the first input with a level control (0-based) */
-	u8 level_input_first;
-
-	/* the number of analogue inputs with a software switchable
-	 * 10dB pad control
-	 */
-	u8 pad_input_count;
-
-	/* the number of analogue inputs with a software switchable
-	 * "air" control
-	 */
-	u8 air_input_count;
-
-	/* the number of phantom (48V) software switchable controls */
-	u8 phantom_count;
-
-	/* the number of inputs each phantom switch controls */
-	u8 inputs_per_phantom;
-
-	/* the number of direct monitor options
-	 * (0 = none, 1 = mono only, 2 = mono/stereo)
-	 */
-	u8 direct_monitor;
-
-	/* remap analogue outputs; 18i8 Gen 3 has "line 3/4" connected
-	 * internally to the analogue 7/8 outputs
-	 */
-	u8 line_out_remap_enable;
-	u8 line_out_remap[SCARLETT2_ANALOGUE_MAX];
-
-	/* additional description for the line out volume controls */
-	const char * const line_out_descrs[SCARLETT2_ANALOGUE_MAX];
-
-	/* number of sources/destinations of each port type */
-	const int port_count[SCARLETT2_PORT_TYPE_COUNT][SCARLETT2_PORT_DIRNS];
-
-	/* layout/order of the entries in the set_mux message */
-	struct scarlett2_mux_entry mux_assignment[SCARLETT2_MUX_TABLES]
-						 [SCARLETT2_MAX_MUX_ENTRIES];
-};
-
-struct scarlett2_data {
-	struct usb_mixer_interface *mixer;
-	struct mutex usb_mutex; /* prevent sending concurrent USB requests */
-	struct mutex data_mutex; /* lock access to this data */
-	struct delayed_work work;
-	const struct scarlett2_device_info *info;
-	__u8 bInterfaceNumber;
-	__u8 bEndpointAddress;
-	__u16 wMaxPacketSize;
-	__u8 bInterval;
-	int num_mux_srcs;
-	int num_mux_dsts;
-	u16 scarlett2_seq;
-	u8 sync_updated;
-	u8 vol_updated;
-	u8 input_other_updated;
-	u8 monitor_other_updated;
-	u8 mux_updated;
-	u8 speaker_switching_switched;
-	u8 sync;
-	u8 master_vol;
-	u8 vol[SCARLETT2_ANALOGUE_MAX];
-	u8 vol_sw_hw_switch[SCARLETT2_ANALOGUE_MAX];
-	u8 mute_switch[SCARLETT2_ANALOGUE_MAX];
-	u8 level_switch[SCARLETT2_LEVEL_SWITCH_MAX];
-	u8 pad_switch[SCARLETT2_PAD_SWITCH_MAX];
-	u8 dim_mute[SCARLETT2_DIM_MUTE_COUNT];
-	u8 air_switch[SCARLETT2_AIR_SWITCH_MAX];
-	u8 phantom_switch[SCARLETT2_PHANTOM_SWITCH_MAX];
-	u8 phantom_persistence;
-	u8 direct_monitor_switch;
-	u8 speaker_switching_switch;
-	u8 talkback_switch;
-	u8 talkback_map[SCARLETT2_OUTPUT_MIX_MAX];
-	u8 msd_switch;
-	u8 standalone_switch;
-	struct snd_kcontrol *sync_ctl;
-	struct snd_kcontrol *master_vol_ctl;
-	struct snd_kcontrol *vol_ctls[SCARLETT2_ANALOGUE_MAX];
-	struct snd_kcontrol *sw_hw_ctls[SCARLETT2_ANALOGUE_MAX];
-	struct snd_kcontrol *mute_ctls[SCARLETT2_ANALOGUE_MAX];
-	struct snd_kcontrol *dim_mute_ctls[SCARLETT2_DIM_MUTE_COUNT];
-	struct snd_kcontrol *level_ctls[SCARLETT2_LEVEL_SWITCH_MAX];
-	struct snd_kcontrol *pad_ctls[SCARLETT2_PAD_SWITCH_MAX];
-	struct snd_kcontrol *air_ctls[SCARLETT2_AIR_SWITCH_MAX];
-	struct snd_kcontrol *phantom_ctls[SCARLETT2_PHANTOM_SWITCH_MAX];
-	struct snd_kcontrol *mux_ctls[SCARLETT2_MUX_MAX];
-	struct snd_kcontrol *direct_monitor_ctl;
-	struct snd_kcontrol *speaker_switching_ctl;
-	struct snd_kcontrol *talkback_ctl;
-	u8 mux[SCARLETT2_MUX_MAX];
-	u8 mix[SCARLETT2_INPUT_MIX_MAX * SCARLETT2_OUTPUT_MIX_MAX];
-};
-
-/*** Model-specific data ***/
-
-static const struct scarlett2_device_info s6i6_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8203),
-
-	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
-	.level_input_count = 2,
-	.pad_input_count = 2,
-
-	.line_out_descrs = {
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  4,  4 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
-		[SCARLETT2_PORT_TYPE_PCM]      = {  6,  6 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info s18i8_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8204),
-
-	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
-	.level_input_count = 2,
-	.pad_input_count = 4,
-
-	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8,  6 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
-		[SCARLETT2_PORT_TYPE_PCM]      = {  8, 18 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 10 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  6 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  4 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info s18i20_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8201),
-
-	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
-	.line_out_hw_vol = 1,
-
-	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8, 10 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
-		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 18 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,     0,  8 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,     0,  4 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 10 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  6 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info solo_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8211),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
-	.level_input_count = 1,
-	.level_input_first = 1,
-	.air_input_count = 1,
-	.phantom_count = 1,
-	.inputs_per_phantom = 1,
-	.direct_monitor = 1,
-};
-
-static const struct scarlett2_device_info s2i2_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8210),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
-	.level_input_count = 2,
-	.air_input_count = 2,
-	.phantom_count = 1,
-	.inputs_per_phantom = 2,
-	.direct_monitor = 2,
-};
-
-static const struct scarlett2_device_info s4i4_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8212),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
-	.level_input_count = 2,
-	.pad_input_count = 2,
-	.air_input_count = 2,
-	.phantom_count = 1,
-	.inputs_per_phantom = 2,
-
-	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		"Headphones L",
-		"Headphones R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = { 1, 0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = { 4, 4 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 6, 8 },
-		[SCARLETT2_PORT_TYPE_PCM]      = { 4, 6 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  6 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 16 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info s8i6_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8213),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
-	.level_input_count = 2,
-	.pad_input_count = 2,
-	.air_input_count = 2,
-	.phantom_count = 1,
-	.inputs_per_phantom = 2,
-
-	.line_out_descrs = {
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = { 1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = { 6,  4 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = { 2,  2 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 8,  8 },
-		[SCARLETT2_PORT_TYPE_PCM]      = { 6, 10 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_PCM,      8,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 18 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info s18i8_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8214),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
-	.line_out_hw_vol = 1,
-	.has_speaker_switching = 1,
-	.level_input_count = 2,
-	.pad_input_count = 4,
-	.air_input_count = 4,
-	.phantom_count = 2,
-	.inputs_per_phantom = 2,
-
-	.line_out_remap_enable = 1,
-	.line_out_remap = { 0, 1, 6, 7, 2, 3, 4, 5 },
-
-	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		"Alt Monitor L",
-		"Alt Monitor R",
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8,  8 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  0 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 20 },
-		[SCARLETT2_PORT_TYPE_PCM]      = {  8, 20 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
-		{ SCARLETT2_PORT_TYPE_PCM,      12,  8 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_PCM,      10,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
-		{ 0,                             0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
-		{ SCARLETT2_PORT_TYPE_PCM,      12,  4 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_PCM,      10,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
-		{ 0,                             0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  6,  2 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  2,  4 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,       0, 20 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
-		{ 0,                             0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info s18i20_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8215),
-
-	.has_msd_mode = 1,
-	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
-	.line_out_hw_vol = 1,
-	.has_speaker_switching = 1,
-	.has_talkback = 1,
-	.level_input_count = 2,
-	.pad_input_count = 8,
-	.air_input_count = 8,
-	.phantom_count = 2,
-	.inputs_per_phantom = 4,
-
-	.line_out_descrs = {
-		"Monitor 1 L",
-		"Monitor 1 R",
-		"Monitor 2 L",
-		"Monitor 2 R",
-		NULL,
-		NULL,
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  9, 10 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 12, 25 },
-		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 20 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,       0,  8 },
-		{ SCARLETT2_PORT_TYPE_PCM,      10, 10 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_PCM,       8,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,       0, 25 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 12 },
-		{ 0,                             0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,       0,  8 },
-		{ SCARLETT2_PORT_TYPE_PCM,      10,  8 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,      0,  8 },
-		{ SCARLETT2_PORT_TYPE_PCM,       8,  2 },
-		{ SCARLETT2_PORT_TYPE_MIX,       0, 25 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 10 },
-		{ 0,                             0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,       0, 10 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE,  0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,     0,  2 },
-		{ SCARLETT2_PORT_TYPE_NONE,      0, 24 },
-		{ 0,                             0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info clarett_8pre_info = {
-	.usb_id = USB_ID(0x1235, 0x820c),
-
-	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
-	.line_out_hw_vol = 1,
-	.level_input_count = 2,
-	.air_input_count = 8,
-
-	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-		"Headphones 1 L",
-		"Headphones 1 R",
-		"Headphones 2 L",
-		"Headphones 2 R",
-	},
-
-	.port_count = {
-		[SCARLETT2_PORT_TYPE_NONE]     = {  1,  0 },
-		[SCARLETT2_PORT_TYPE_ANALOGUE] = {  8, 10 },
-		[SCARLETT2_PORT_TYPE_SPDIF]    = {  2,  2 },
-		[SCARLETT2_PORT_TYPE_ADAT]     = {  8,  8 },
-		[SCARLETT2_PORT_TYPE_MIX]      = { 10, 18 },
-		[SCARLETT2_PORT_TYPE_PCM]      = { 20, 18 },
-	},
-
-	.mux_assignment = { {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,     0,  8 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 14 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_ADAT,     0,  4 },
-		{ SCARLETT2_PORT_TYPE_MIX,      0, 18 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0,  8 },
-		{ 0,                            0,  0 },
-	}, {
-		{ SCARLETT2_PORT_TYPE_PCM,      0, 12 },
-		{ SCARLETT2_PORT_TYPE_ANALOGUE, 0, 10 },
-		{ SCARLETT2_PORT_TYPE_SPDIF,    0,  2 },
-		{ SCARLETT2_PORT_TYPE_NONE,     0, 22 },
-		{ 0,                            0,  0 },
-	} },
-};
-
-static const struct scarlett2_device_info *scarlett2_devices[] = {
-	/* Supported Gen 2 devices */
-	&s6i6_gen2_info,
-	&s18i8_gen2_info,
-	&s18i20_gen2_info,
-
-	/* Supported Gen 3 devices */
-	&solo_gen3_info,
-	&s2i2_gen3_info,
-	&s4i4_gen3_info,
-	&s8i6_gen3_info,
-	&s18i8_gen3_info,
-	&s18i20_gen3_info,
-
-	/* Supported Clarett+ devices */
-	&clarett_8pre_info,
-
-	/* End of list */
-	NULL
-};
-
-/* get the starting port index number for a given port type/direction */
-static int scarlett2_get_port_start_num(
-	const int port_count[][SCARLETT2_PORT_DIRNS],
-	int direction, int port_type)
-{
-	int i, num = 0;
-
-	for (i = 0; i < port_type; i++)
-		num += port_count[i][direction];
-
-	return num;
-}
-
-/*** USB Interactions ***/
-
-/* Notifications from the interface */
-#define SCARLETT2_USB_NOTIFY_SYNC          0x00000008
-#define SCARLETT2_USB_NOTIFY_DIM_MUTE      0x00200000
-#define SCARLETT2_USB_NOTIFY_MONITOR       0x00400000
-#define SCARLETT2_USB_NOTIFY_INPUT_OTHER   0x00800000
-#define SCARLETT2_USB_NOTIFY_MONITOR_OTHER 0x01000000
-
-/* Commands for sending/receiving requests/responses */
-#define SCARLETT2_USB_CMD_INIT 0
-#define SCARLETT2_USB_CMD_REQ  2
-#define SCARLETT2_USB_CMD_RESP 3
-
-#define SCARLETT2_USB_INIT_1    0x00000000
-#define SCARLETT2_USB_INIT_2    0x00000002
-#define SCARLETT2_USB_GET_METER 0x00001001
-#define SCARLETT2_USB_GET_MIX   0x00002001
-#define SCARLETT2_USB_SET_MIX   0x00002002
-#define SCARLETT2_USB_GET_MUX   0x00003001
-#define SCARLETT2_USB_SET_MUX   0x00003002
-#define SCARLETT2_USB_GET_SYNC  0x00006004
-#define SCARLETT2_USB_GET_DATA  0x00800000
-#define SCARLETT2_USB_SET_DATA  0x00800001
-#define SCARLETT2_USB_DATA_CMD  0x00800002
-
-#define SCARLETT2_USB_CONFIG_SAVE 6
-
-#define SCARLETT2_USB_VOLUME_STATUS_OFFSET 0x31
-#define SCARLETT2_USB_METER_LEVELS_GET_MAGIC 1
-
-/* volume status is read together (matches scarlett2_config_items[1]) */
-struct scarlett2_usb_volume_status {
-	/* dim/mute buttons */
-	u8 dim_mute[SCARLETT2_DIM_MUTE_COUNT];
-
-	u8 pad1;
-
-	/* software volume setting */
-	s16 sw_vol[SCARLETT2_ANALOGUE_MAX];
-
-	/* actual volume of output inc. dim (-18dB) */
-	s16 hw_vol[SCARLETT2_ANALOGUE_MAX];
-
-	/* internal mute buttons */
-	u8 mute_switch[SCARLETT2_ANALOGUE_MAX];
-
-	/* sw (0) or hw (1) controlled */
-	u8 sw_hw_switch[SCARLETT2_ANALOGUE_MAX];
-
-	u8 pad3[6];
-
-	/* front panel volume knob */
-	s16 master_vol;
-} __packed;
-
-/* Configuration parameters that can be read and written */
-enum {
-	SCARLETT2_CONFIG_DIM_MUTE = 0,
-	SCARLETT2_CONFIG_LINE_OUT_VOLUME = 1,
-	SCARLETT2_CONFIG_MUTE_SWITCH = 2,
-	SCARLETT2_CONFIG_SW_HW_SWITCH = 3,
-	SCARLETT2_CONFIG_LEVEL_SWITCH = 4,
-	SCARLETT2_CONFIG_PAD_SWITCH = 5,
-	SCARLETT2_CONFIG_MSD_SWITCH = 6,
-	SCARLETT2_CONFIG_AIR_SWITCH = 7,
-	SCARLETT2_CONFIG_STANDALONE_SWITCH = 8,
-	SCARLETT2_CONFIG_PHANTOM_SWITCH = 9,
-	SCARLETT2_CONFIG_PHANTOM_PERSISTENCE = 10,
-	SCARLETT2_CONFIG_DIRECT_MONITOR = 11,
-	SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH = 12,
-	SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE = 13,
-	SCARLETT2_CONFIG_TALKBACK_MAP = 14,
-	SCARLETT2_CONFIG_COUNT = 15
-};
-
-/* Location, size, and activation command number for the configuration
- * parameters. Size is in bits and may be 1, 8, or 16.
- */
-struct scarlett2_config {
-	u8 offset;
-	u8 size;
-	u8 activate;
-};
-
-static const struct scarlett2_config
-	scarlett2_config_items[SCARLETT2_CONFIG_SET_COUNT]
-			      [SCARLETT2_CONFIG_COUNT] =
-
-/* Devices without a mixer (Gen 3 Solo and 2i2) */
-{ {
-	[SCARLETT2_CONFIG_MSD_SWITCH] = {
-		.offset = 0x04, .size = 8, .activate = 6 },
-
-	[SCARLETT2_CONFIG_PHANTOM_PERSISTENCE] = {
-		.offset = 0x05, .size = 8, .activate = 6 },
-
-	[SCARLETT2_CONFIG_PHANTOM_SWITCH] = {
-		.offset = 0x06, .size = 8, .activate = 3 },
-
-	[SCARLETT2_CONFIG_DIRECT_MONITOR] = {
-		.offset = 0x07, .size = 8, .activate = 4 },
-
-	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
-		.offset = 0x08, .size = 1, .activate = 7 },
-
-	[SCARLETT2_CONFIG_AIR_SWITCH] = {
-		.offset = 0x09, .size = 1, .activate = 8 },
-
-/* Gen 2 devices: 6i6, 18i8, 18i20 */
-}, {
-	[SCARLETT2_CONFIG_DIM_MUTE] = {
-		.offset = 0x31, .size = 8, .activate = 2 },
-
-	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
-		.offset = 0x34, .size = 16, .activate = 1 },
-
-	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
-		.offset = 0x5c, .size = 8, .activate = 1 },
-
-	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
-		.offset = 0x66, .size = 8, .activate = 3 },
-
-	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
-		.offset = 0x7c, .size = 8, .activate = 7 },
-
-	[SCARLETT2_CONFIG_PAD_SWITCH] = {
-		.offset = 0x84, .size = 8, .activate = 8 },
-
-	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
-		.offset = 0x8d, .size = 8, .activate = 6 },
-
-/* Gen 3 devices: 4i4, 8i6, 18i8, 18i20 */
-}, {
-	[SCARLETT2_CONFIG_DIM_MUTE] = {
-		.offset = 0x31, .size = 8, .activate = 2 },
-
-	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
-		.offset = 0x34, .size = 16, .activate = 1 },
-
-	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
-		.offset = 0x5c, .size = 8, .activate = 1 },
-
-	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
-		.offset = 0x66, .size = 8, .activate = 3 },
-
-	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
-		.offset = 0x7c, .size = 8, .activate = 7 },
-
-	[SCARLETT2_CONFIG_PAD_SWITCH] = {
-		.offset = 0x84, .size = 8, .activate = 8 },
-
-	[SCARLETT2_CONFIG_AIR_SWITCH] = {
-		.offset = 0x8c, .size = 8, .activate = 8 },
-
-	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
-		.offset = 0x95, .size = 8, .activate = 6 },
-
-	[SCARLETT2_CONFIG_PHANTOM_SWITCH] = {
-		.offset = 0x9c, .size = 1, .activate = 8 },
-
-	[SCARLETT2_CONFIG_MSD_SWITCH] = {
-		.offset = 0x9d, .size = 8, .activate = 6 },
-
-	[SCARLETT2_CONFIG_PHANTOM_PERSISTENCE] = {
-		.offset = 0x9e, .size = 8, .activate = 6 },
-
-	[SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH] = {
-		.offset = 0x9f, .size = 1, .activate = 10 },
-
-	[SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE] = {
-		.offset = 0xa0, .size = 1, .activate = 10 },
-
-	[SCARLETT2_CONFIG_TALKBACK_MAP] = {
-		.offset = 0xb0, .size = 16, .activate = 10 },
-
-/* Clarett+ 8Pre */
-}, {
-	[SCARLETT2_CONFIG_DIM_MUTE] = {
-		.offset = 0x31, .size = 8, .activate = 2 },
-
-	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
-		.offset = 0x34, .size = 16, .activate = 1 },
-
-	[SCARLETT2_CONFIG_MUTE_SWITCH] = {
-		.offset = 0x5c, .size = 8, .activate = 1 },
-
-	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
-		.offset = 0x66, .size = 8, .activate = 3 },
-
-	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
-		.offset = 0x7c, .size = 8, .activate = 7 },
-
-	[SCARLETT2_CONFIG_AIR_SWITCH] = {
-		.offset = 0x95, .size = 8, .activate = 8 },
-
-	[SCARLETT2_CONFIG_STANDALONE_SWITCH] = {
-		.offset = 0x8d, .size = 8, .activate = 6 },
-} };
-
-/* proprietary request/response format */
-struct scarlett2_usb_packet {
-	__le32 cmd;
-	__le16 size;
-	__le16 seq;
-	__le32 error;
-	__le32 pad;
-	u8 data[];
-};
-
-static void scarlett2_fill_request_header(struct scarlett2_data *private,
-					  struct scarlett2_usb_packet *req,
-					  u32 cmd, u16 req_size)
-{
-	/* sequence must go up by 1 for each request */
-	u16 seq = private->scarlett2_seq++;
-
-	req->cmd = cpu_to_le32(cmd);
-	req->size = cpu_to_le16(req_size);
-	req->seq = cpu_to_le16(seq);
-	req->error = 0;
-	req->pad = 0;
-}
-
-static int scarlett2_usb_tx(struct usb_device *dev, int interface,
-			    void *buf, u16 size)
-{
-	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			SCARLETT2_USB_CMD_REQ,
-			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-			0, interface, buf, size);
-}
-
-static int scarlett2_usb_rx(struct usb_device *dev, int interface,
-			    u32 usb_req, void *buf, u16 size)
-{
-	return snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
-			usb_req,
-			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-			0, interface, buf, size);
-}
-
-/* Send a proprietary format request to the Scarlett interface */
-static int scarlett2_usb(
-	struct usb_mixer_interface *mixer, u32 cmd,
-	void *req_data, u16 req_size, void *resp_data, u16 resp_size)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	struct usb_device *dev = mixer->chip->dev;
-	struct scarlett2_usb_packet *req, *resp = NULL;
-	size_t req_buf_size = struct_size(req, data, req_size);
-	size_t resp_buf_size = struct_size(resp, data, resp_size);
-	int err;
-
-	req = kmalloc(req_buf_size, GFP_KERNEL);
-	if (!req) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	resp = kmalloc(resp_buf_size, GFP_KERNEL);
-	if (!resp) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	mutex_lock(&private->usb_mutex);
-
-	/* build request message and send it */
-
-	scarlett2_fill_request_header(private, req, cmd, req_size);
-
-	if (req_size)
-		memcpy(req->data, req_data, req_size);
-
-	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
-			       req, req_buf_size);
-
-	if (err != req_buf_size) {
-		usb_audio_err(
-			mixer->chip,
-			"Scarlett Gen 2/3 USB request result cmd %x was %d\n",
-			cmd, err);
-		err = -EINVAL;
-		goto unlock;
-	}
-
-	/* send a second message to get the response */
-
-	err = scarlett2_usb_rx(dev, private->bInterfaceNumber,
-			       SCARLETT2_USB_CMD_RESP,
-			       resp, resp_buf_size);
-
-	/* validate the response */
-
-	if (err != resp_buf_size) {
-		usb_audio_err(
-			mixer->chip,
-			"Scarlett Gen 2/3 USB response result cmd %x was %d "
-			"expected %zu\n",
-			cmd, err, resp_buf_size);
-		err = -EINVAL;
-		goto unlock;
-	}
-
-	/* cmd/seq/size should match except when initialising
-	 * seq sent = 1, response = 0
-	 */
-	if (resp->cmd != req->cmd ||
-	    (resp->seq != req->seq &&
-		(le16_to_cpu(req->seq) != 1 || resp->seq != 0)) ||
-	    resp_size != le16_to_cpu(resp->size) ||
-	    resp->error ||
-	    resp->pad) {
-		usb_audio_err(
-			mixer->chip,
-			"Scarlett Gen 2/3 USB invalid response; "
-			   "cmd tx/rx %d/%d seq %d/%d size %d/%d "
-			   "error %d pad %d\n",
-			le32_to_cpu(req->cmd), le32_to_cpu(resp->cmd),
-			le16_to_cpu(req->seq), le16_to_cpu(resp->seq),
-			resp_size, le16_to_cpu(resp->size),
-			le32_to_cpu(resp->error),
-			le32_to_cpu(resp->pad));
-		err = -EINVAL;
-		goto unlock;
-	}
-
-	if (resp_data && resp_size > 0)
-		memcpy(resp_data, resp->data, resp_size);
-
-unlock:
-	mutex_unlock(&private->usb_mutex);
-error:
-	kfree(req);
-	kfree(resp);
-	return err;
-}
-
-/* Send a USB message to get data; result placed in *buf */
-static int scarlett2_usb_get(
-	struct usb_mixer_interface *mixer,
-	int offset, void *buf, int size)
-{
-	struct {
-		__le32 offset;
-		__le32 size;
-	} __packed req;
-
-	req.offset = cpu_to_le32(offset);
-	req.size = cpu_to_le32(size);
-	return scarlett2_usb(mixer, SCARLETT2_USB_GET_DATA,
-			     &req, sizeof(req), buf, size);
-}
-
-/* Send a USB message to get configuration parameters; result placed in *buf */
-static int scarlett2_usb_get_config(
-	struct usb_mixer_interface *mixer,
-	int config_item_num, int count, void *buf)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const struct scarlett2_config *config_item =
-		&scarlett2_config_items[info->config_set][config_item_num];
-	int size, err, i;
-	u8 *buf_8;
-	u8 value;
-
-	/* For byte-sized parameters, retrieve directly into buf */
-	if (config_item->size >= 8) {
-		size = config_item->size / 8 * count;
-		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
-		if (err < 0)
-			return err;
-		if (size == 2) {
-			u16 *buf_16 = buf;
-
-			for (i = 0; i < count; i++, buf_16++)
-				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
-		}
-		return 0;
-	}
-
-	/* For bit-sized parameters, retrieve into value */
-	err = scarlett2_usb_get(mixer, config_item->offset, &value, 1);
-	if (err < 0)
-		return err;
-
-	/* then unpack from value into buf[] */
-	buf_8 = buf;
-	for (i = 0; i < 8 && i < count; i++, value >>= 1)
-		*buf_8++ = value & 1;
-
-	return 0;
-}
-
-/* Send SCARLETT2_USB_DATA_CMD SCARLETT2_USB_CONFIG_SAVE */
-static void scarlett2_config_save(struct usb_mixer_interface *mixer)
-{
-	__le32 req = cpu_to_le32(SCARLETT2_USB_CONFIG_SAVE);
-
-	int err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
-				&req, sizeof(u32),
-				NULL, 0);
-	if (err < 0)
-		usb_audio_err(mixer->chip, "config save failed: %d\n", err);
-}
-
-/* Delayed work to save config */
-static void scarlett2_config_save_work(struct work_struct *work)
-{
-	struct scarlett2_data *private =
-		container_of(work, struct scarlett2_data, work.work);
-
-	scarlett2_config_save(private->mixer);
-}
-
-/* Send a USB message to set a SCARLETT2_CONFIG_* parameter */
-static int scarlett2_usb_set_config(
-	struct usb_mixer_interface *mixer,
-	int config_item_num, int index, int value)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const struct scarlett2_config *config_item =
-	       &scarlett2_config_items[info->config_set][config_item_num];
-	struct {
-		__le32 offset;
-		__le32 bytes;
-		__le32 value;
-	} __packed req;
-	__le32 req2;
-	int offset, size;
-	int err;
-
-	/* Cancel any pending NVRAM save */
-	cancel_delayed_work_sync(&private->work);
-
-	/* Convert config_item->size in bits to size in bytes and
-	 * calculate offset
-	 */
-	if (config_item->size >= 8) {
-		size = config_item->size / 8;
-		offset = config_item->offset + index * size;
-
-	/* If updating a bit, retrieve the old value, set/clear the
-	 * bit as needed, and update value
-	 */
-	} else {
-		u8 tmp;
-
-		size = 1;
-		offset = config_item->offset;
-
-		err = scarlett2_usb_get(mixer, offset, &tmp, 1);
-		if (err < 0)
-			return err;
-
-		if (value)
-			tmp |= (1 << index);
-		else
-			tmp &= ~(1 << index);
-
-		value = tmp;
-	}
-
-	/* Send the configuration parameter data */
-	req.offset = cpu_to_le32(offset);
-	req.bytes = cpu_to_le32(size);
-	req.value = cpu_to_le32(value);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_SET_DATA,
-			    &req, sizeof(u32) * 2 + size,
-			    NULL, 0);
-	if (err < 0)
-		return err;
-
-	/* Activate the change */
-	req2 = cpu_to_le32(config_item->activate);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
-			    &req2, sizeof(req2), NULL, 0);
-	if (err < 0)
-		return err;
-
-	/* Schedule the change to be written to NVRAM */
-	if (config_item->activate != SCARLETT2_USB_CONFIG_SAVE)
-		schedule_delayed_work(&private->work, msecs_to_jiffies(2000));
-
-	return 0;
-}
-
-/* Send a USB message to get sync status; result placed in *sync */
-static int scarlett2_usb_get_sync_status(
-	struct usb_mixer_interface *mixer,
-	u8 *sync)
-{
-	__le32 data;
-	int err;
-
-	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_SYNC,
-			    NULL, 0, &data, sizeof(data));
-	if (err < 0)
-		return err;
-
-	*sync = !!data;
-	return 0;
-}
-
-/* Send a USB message to get volume status; result placed in *buf */
-static int scarlett2_usb_get_volume_status(
-	struct usb_mixer_interface *mixer,
-	struct scarlett2_usb_volume_status *buf)
-{
-	return scarlett2_usb_get(mixer, SCARLETT2_USB_VOLUME_STATUS_OFFSET,
-				 buf, sizeof(*buf));
-}
-
-/* Send a USB message to get the volumes for all inputs of one mix
- * and put the values into private->mix[]
- */
-static int scarlett2_usb_get_mix(struct usb_mixer_interface *mixer,
-				 int mix_num)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	int num_mixer_in =
-		info->port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
-	int err, i, j, k;
-
-	struct {
-		__le16 mix_num;
-		__le16 count;
-	} __packed req;
-
-	__le16 data[SCARLETT2_INPUT_MIX_MAX];
-
-	req.mix_num = cpu_to_le16(mix_num);
-	req.count = cpu_to_le16(num_mixer_in);
-
-	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_MIX,
-			    &req, sizeof(req),
-			    data, num_mixer_in * sizeof(u16));
-	if (err < 0)
-		return err;
-
-	for (i = 0, j = mix_num * num_mixer_in; i < num_mixer_in; i++, j++) {
-		u16 mixer_value = le16_to_cpu(data[i]);
-
-		for (k = 0; k < SCARLETT2_MIXER_VALUE_COUNT; k++)
-			if (scarlett2_mixer_values[k] >= mixer_value)
-				break;
-		if (k == SCARLETT2_MIXER_VALUE_COUNT)
-			k = SCARLETT2_MIXER_MAX_VALUE;
-		private->mix[j] = k;
-	}
-
-	return 0;
-}
-
-/* Send a USB message to set the volumes for all inputs of one mix
- * (values obtained from private->mix[])
- */
-static int scarlett2_usb_set_mix(struct usb_mixer_interface *mixer,
-				 int mix_num)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	struct {
-		__le16 mix_num;
-		__le16 data[SCARLETT2_INPUT_MIX_MAX];
-	} __packed req;
-
-	int i, j;
-	int num_mixer_in =
-		info->port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
-
-	req.mix_num = cpu_to_le16(mix_num);
-
-	for (i = 0, j = mix_num * num_mixer_in; i < num_mixer_in; i++, j++)
-		req.data[i] = cpu_to_le16(
-			scarlett2_mixer_values[private->mix[j]]
-		);
-
-	return scarlett2_usb(mixer, SCARLETT2_USB_SET_MIX,
-			     &req, (num_mixer_in + 1) * sizeof(u16),
-			     NULL, 0);
-}
-
-/* Convert a port number index (per info->port_count) to a hardware ID */
-static u32 scarlett2_mux_src_num_to_id(
-	const int port_count[][SCARLETT2_PORT_DIRNS], int num)
-{
-	int port_type;
-
-	for (port_type = 0;
-	     port_type < SCARLETT2_PORT_TYPE_COUNT;
-	     port_type++) {
-		if (num < port_count[port_type][SCARLETT2_PORT_IN])
-			return scarlett2_ports[port_type].id | num;
-		num -= port_count[port_type][SCARLETT2_PORT_IN];
-	}
-
-	/* Oops */
-	return 0;
-}
-
-/* Convert a hardware ID to a port number index */
-static u32 scarlett2_mux_id_to_num(
-	const int port_count[][SCARLETT2_PORT_DIRNS], int direction, u32 id)
-{
-	int port_type;
-	int port_num = 0;
-
-	for (port_type = 0;
-	     port_type < SCARLETT2_PORT_TYPE_COUNT;
-	     port_type++) {
-		int base = scarlett2_ports[port_type].id;
-		int count = port_count[port_type][direction];
-
-		if (id >= base && id < base + count)
-			return port_num + id - base;
-		port_num += count;
-	}
-
-	/* Oops */
-	return -1;
-}
-
-/* Convert one mux entry from the interface and load into private->mux[] */
-static void scarlett2_usb_populate_mux(struct scarlett2_data *private,
-				       u32 mux_entry)
-{
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-
-	int dst_idx, src_idx;
-
-	dst_idx = scarlett2_mux_id_to_num(port_count, SCARLETT2_PORT_OUT,
-					  mux_entry & 0xFFF);
-	if (dst_idx < 0)
-		return;
-
-	if (dst_idx >= private->num_mux_dsts) {
-		usb_audio_err(private->mixer->chip,
-			"BUG: scarlett2_mux_id_to_num(%06x, OUT): %d >= %d",
-			mux_entry, dst_idx, private->num_mux_dsts);
-		return;
-	}
-
-	src_idx = scarlett2_mux_id_to_num(port_count, SCARLETT2_PORT_IN,
-					  mux_entry >> 12);
-	if (src_idx < 0)
-		return;
-
-	if (src_idx >= private->num_mux_srcs) {
-		usb_audio_err(private->mixer->chip,
-			"BUG: scarlett2_mux_id_to_num(%06x, IN): %d >= %d",
-			mux_entry, src_idx, private->num_mux_srcs);
-		return;
-	}
-
-	private->mux[dst_idx] = src_idx;
-}
-
-/* Send USB message to get mux inputs and then populate private->mux[] */
-static int scarlett2_usb_get_mux(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	int count = private->num_mux_dsts;
-	int err, i;
-
-	struct {
-		__le16 num;
-		__le16 count;
-	} __packed req;
-
-	__le32 data[SCARLETT2_MUX_MAX];
-
-	private->mux_updated = 0;
-
-	req.num = 0;
-	req.count = cpu_to_le16(count);
-
-	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_MUX,
-			    &req, sizeof(req),
-			    data, count * sizeof(u32));
-	if (err < 0)
-		return err;
-
-	for (i = 0; i < count; i++)
-		scarlett2_usb_populate_mux(private, le32_to_cpu(data[i]));
-
-	return 0;
-}
-
-/* Send USB messages to set mux inputs */
-static int scarlett2_usb_set_mux(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int table;
-
-	struct {
-		__le16 pad;
-		__le16 num;
-		__le32 data[SCARLETT2_MUX_MAX];
-	} __packed req;
-
-	req.pad = 0;
-
-	/* set mux settings for each rate */
-	for (table = 0; table < SCARLETT2_MUX_TABLES; table++) {
-		const struct scarlett2_mux_entry *entry;
-
-		/* i counts over the output array */
-		int i = 0, err;
-
-		req.num = cpu_to_le16(table);
-
-		/* loop through each entry */
-		for (entry = info->mux_assignment[table];
-		     entry->count;
-		     entry++) {
-			int j;
-			int port_type = entry->port_type;
-			int port_idx = entry->start;
-			int mux_idx = scarlett2_get_port_start_num(port_count,
-				SCARLETT2_PORT_OUT, port_type) + port_idx;
-			int dst_id = scarlett2_ports[port_type].id + port_idx;
-
-			/* Empty slots */
-			if (!dst_id) {
-				for (j = 0; j < entry->count; j++)
-					req.data[i++] = 0;
-				continue;
-			}
-
-			/* Non-empty mux slots use the lower 12 bits
-			 * for the destination and next 12 bits for
-			 * the source
-			 */
-			for (j = 0; j < entry->count; j++) {
-				int src_id = scarlett2_mux_src_num_to_id(
-					port_count, private->mux[mux_idx++]);
-				req.data[i++] = cpu_to_le32(dst_id |
-							    src_id << 12);
-				dst_id++;
-			}
-		}
-
-		err = scarlett2_usb(mixer, SCARLETT2_USB_SET_MUX,
-				    &req, (i + 1) * sizeof(u32),
-				    NULL, 0);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-/* Send USB message to get meter levels */
-static int scarlett2_usb_get_meter_levels(struct usb_mixer_interface *mixer,
-					  u16 num_meters, u16 *levels)
-{
-	struct {
-		__le16 pad;
-		__le16 num_meters;
-		__le32 magic;
-	} __packed req;
-	u32 resp[SCARLETT2_MAX_METERS];
-	int i, err;
-
-	req.pad = 0;
-	req.num_meters = cpu_to_le16(num_meters);
-	req.magic = cpu_to_le32(SCARLETT2_USB_METER_LEVELS_GET_MAGIC);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_GET_METER,
-			    &req, sizeof(req), resp, num_meters * sizeof(u32));
-	if (err < 0)
-		return err;
-
-	/* copy, convert to u16 */
-	for (i = 0; i < num_meters; i++)
-		levels[i] = resp[i];
-
-	return 0;
-}
-
-/*** Control Functions ***/
-
-/* helper function to create a new control */
-static int scarlett2_add_new_ctl(struct usb_mixer_interface *mixer,
-				 const struct snd_kcontrol_new *ncontrol,
-				 int index, int channels, const char *name,
-				 struct snd_kcontrol **kctl_return)
-{
-	struct snd_kcontrol *kctl;
-	struct usb_mixer_elem_info *elem;
-	int err;
-
-	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
-	if (!elem)
-		return -ENOMEM;
-
-	/* We set USB_MIXER_BESPOKEN type, so that the core USB mixer code
-	 * ignores them for resume and other operations.
-	 * Also, the head.id field is set to 0, as we don't use this field.
-	 */
-	elem->head.mixer = mixer;
-	elem->control = index;
-	elem->head.id = 0;
-	elem->channels = channels;
-	elem->val_type = USB_MIXER_BESPOKEN;
-
-	kctl = snd_ctl_new1(ncontrol, elem);
-	if (!kctl) {
-		kfree(elem);
-		return -ENOMEM;
-	}
-	kctl->private_free = snd_usb_mixer_elem_free;
-
-	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
-
-	err = snd_usb_mixer_add_control(&elem->head, kctl);
-	if (err < 0)
-		return err;
-
-	if (kctl_return)
-		*kctl_return = kctl;
-
-	return 0;
-}
-
-/*** Sync Control ***/
-
-/* Update sync control after receiving notification that the status
- * has changed
- */
-static int scarlett2_update_sync(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	private->sync_updated = 0;
-	return scarlett2_usb_get_sync_status(mixer, &private->sync);
-}
-
-static int scarlett2_sync_ctl_info(struct snd_kcontrol *kctl,
-				   struct snd_ctl_elem_info *uinfo)
-{
-	static const char *texts[2] = {
-		"Unlocked", "Locked"
-	};
-	return snd_ctl_enum_info(uinfo, 1, 2, texts);
-}
-
-static int scarlett2_sync_ctl_get(struct snd_kcontrol *kctl,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->sync_updated) {
-		err = scarlett2_update_sync(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->sync;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_sync_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READ,
-	.name = "",
-	.info = scarlett2_sync_ctl_info,
-	.get  = scarlett2_sync_ctl_get
-};
-
-static int scarlett2_add_sync_ctl(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	/* devices without a mixer also don't support reporting sync status */
-	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
-		return 0;
-
-	return scarlett2_add_new_ctl(mixer, &scarlett2_sync_ctl,
-				     0, 1, "Sync Status", &private->sync_ctl);
-}
-
-/*** Analogue Line Out Volume Controls ***/
-
-/* Update hardware volume controls after receiving notification that
- * they have changed
- */
-static int scarlett2_update_volumes(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	struct scarlett2_usb_volume_status volume_status;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int err, i;
-	int mute;
-
-	private->vol_updated = 0;
-
-	err = scarlett2_usb_get_volume_status(mixer, &volume_status);
-	if (err < 0)
-		return err;
-
-	private->master_vol = clamp(
-		volume_status.master_vol + SCARLETT2_VOLUME_BIAS,
-		0, SCARLETT2_VOLUME_BIAS);
-
-	if (info->line_out_hw_vol)
-		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
-			private->dim_mute[i] = !!volume_status.dim_mute[i];
-
-	mute = private->dim_mute[SCARLETT2_BUTTON_MUTE];
-
-	for (i = 0; i < num_line_out; i++)
-		if (private->vol_sw_hw_switch[i]) {
-			private->vol[i] = private->master_vol;
-			private->mute_switch[i] = mute;
-		}
-
-	return 0;
-}
-
-static int scarlett2_volume_ctl_info(struct snd_kcontrol *kctl,
-				     struct snd_ctl_elem_info *uinfo)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = elem->channels;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = SCARLETT2_VOLUME_BIAS;
-	uinfo->value.integer.step = 1;
-	return 0;
-}
-
-static int scarlett2_master_volume_ctl_get(struct snd_kcontrol *kctl,
-					   struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->vol_updated) {
-		err = scarlett2_update_volumes(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] = private->master_vol;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int line_out_remap(struct scarlett2_data *private, int index)
-{
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int line_out_count =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-
-	if (!info->line_out_remap_enable)
-		return index;
-
-	if (index >= line_out_count)
-		return index;
-
-	return info->line_out_remap[index];
-}
-
-static int scarlett2_volume_ctl_get(struct snd_kcontrol *kctl,
-				    struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->vol_updated) {
-		err = scarlett2_update_volumes(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] = private->vol[index];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_volume_ctl_put(struct snd_kcontrol *kctl,
-				    struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->vol[index];
-	val = ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->vol[index] = val;
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LINE_OUT_VOLUME,
-				       index, val - SCARLETT2_VOLUME_BIAS);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const DECLARE_TLV_DB_MINMAX(
-	db_scale_scarlett2_gain, -SCARLETT2_VOLUME_BIAS * 100, 0
-);
-
-static const struct snd_kcontrol_new scarlett2_master_volume_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READ |
-		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-	.name = "",
-	.info = scarlett2_volume_ctl_info,
-	.get  = scarlett2_master_volume_ctl_get,
-	.private_value = 0, /* max value */
-	.tlv = { .p = db_scale_scarlett2_gain }
-};
-
-static const struct snd_kcontrol_new scarlett2_line_out_volume_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-	.name = "",
-	.info = scarlett2_volume_ctl_info,
-	.get  = scarlett2_volume_ctl_get,
-	.put  = scarlett2_volume_ctl_put,
-	.private_value = 0, /* max value */
-	.tlv = { .p = db_scale_scarlett2_gain }
-};
-
-/*** Mute Switch Controls ***/
-
-static int scarlett2_mute_ctl_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->vol_updated) {
-		err = scarlett2_update_volumes(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] = private->mute_switch[index];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_mute_ctl_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->mute_switch[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->mute_switch[index] = val;
-
-	/* Send mute change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_MUTE_SWITCH,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_mute_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_mute_ctl_get,
-	.put  = scarlett2_mute_ctl_put,
-};
-
-/*** HW/SW Volume Switch Controls ***/
-
-static void scarlett2_sw_hw_ctl_ro(struct scarlett2_data *private, int index)
-{
-	private->sw_hw_ctls[index]->vd[0].access &=
-		~SNDRV_CTL_ELEM_ACCESS_WRITE;
-}
-
-static void scarlett2_sw_hw_ctl_rw(struct scarlett2_data *private, int index)
-{
-	private->sw_hw_ctls[index]->vd[0].access |=
-		SNDRV_CTL_ELEM_ACCESS_WRITE;
-}
-
-static int scarlett2_sw_hw_enum_ctl_info(struct snd_kcontrol *kctl,
-					 struct snd_ctl_elem_info *uinfo)
-{
-	static const char *const values[2] = {
-		"SW", "HW"
-	};
-
-	return snd_ctl_enum_info(uinfo, 1, 2, values);
-}
-
-static int scarlett2_sw_hw_enum_ctl_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-
-	ucontrol->value.enumerated.item[0] = private->vol_sw_hw_switch[index];
-	return 0;
-}
-
-static void scarlett2_vol_ctl_set_writable(struct usb_mixer_interface *mixer,
-					   int index, int value)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	struct snd_card *card = mixer->chip->card;
-
-	/* Set/Clear write bits */
-	if (value) {
-		private->vol_ctls[index]->vd[0].access |=
-			SNDRV_CTL_ELEM_ACCESS_WRITE;
-		private->mute_ctls[index]->vd[0].access |=
-			SNDRV_CTL_ELEM_ACCESS_WRITE;
-	} else {
-		private->vol_ctls[index]->vd[0].access &=
-			~SNDRV_CTL_ELEM_ACCESS_WRITE;
-		private->mute_ctls[index]->vd[0].access &=
-			~SNDRV_CTL_ELEM_ACCESS_WRITE;
-	}
-
-	/* Notify of write bit and possible value change */
-	snd_ctl_notify(card,
-		       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
-		       &private->vol_ctls[index]->id);
-	snd_ctl_notify(card,
-		       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
-		       &private->mute_ctls[index]->id);
-}
-
-static int scarlett2_sw_hw_change(struct usb_mixer_interface *mixer,
-				  int ctl_index, int val)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, ctl_index);
-	int err;
-
-	private->vol_sw_hw_switch[index] = val;
-
-	/* Change access mode to RO (hardware controlled volume)
-	 * or RW (software controlled volume)
-	 */
-	scarlett2_vol_ctl_set_writable(mixer, ctl_index, !val);
-
-	/* Reset volume/mute to master volume/mute */
-	private->vol[index] = private->master_vol;
-	private->mute_switch[index] = private->dim_mute[SCARLETT2_BUTTON_MUTE];
-
-	/* Set SW volume to current HW volume */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_LINE_OUT_VOLUME,
-		index, private->master_vol - SCARLETT2_VOLUME_BIAS);
-	if (err < 0)
-		return err;
-
-	/* Set SW mute to current HW mute */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_MUTE_SWITCH,
-		index, private->dim_mute[SCARLETT2_BUTTON_MUTE]);
-	if (err < 0)
-		return err;
-
-	/* Send SW/HW switch change to the device */
-	return scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_SW_HW_SWITCH,
-					index, val);
-}
-
-static int scarlett2_sw_hw_enum_ctl_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int ctl_index = elem->control;
-	int index = line_out_remap(private, ctl_index);
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->vol_sw_hw_switch[index];
-	val = !!ucontrol->value.enumerated.item[0];
-
-	if (oval == val)
-		goto unlock;
-
-	err = scarlett2_sw_hw_change(mixer, ctl_index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_sw_hw_enum_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = scarlett2_sw_hw_enum_ctl_info,
-	.get  = scarlett2_sw_hw_enum_ctl_get,
-	.put  = scarlett2_sw_hw_enum_ctl_put,
-};
-
-/*** Line Level/Instrument Level Switch Controls ***/
-
-static int scarlett2_update_input_other(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	private->input_other_updated = 0;
-
-	if (info->level_input_count) {
-		int err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
-			info->level_input_count + info->level_input_first,
-			private->level_switch);
-		if (err < 0)
-			return err;
-	}
-
-	if (info->pad_input_count) {
-		int err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_PAD_SWITCH,
-			info->pad_input_count, private->pad_switch);
-		if (err < 0)
-			return err;
-	}
-
-	if (info->air_input_count) {
-		int err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_AIR_SWITCH,
-			info->air_input_count, private->air_switch);
-		if (err < 0)
-			return err;
-	}
-
-	if (info->phantom_count) {
-		int err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_PHANTOM_SWITCH,
-			info->phantom_count, private->phantom_switch);
-		if (err < 0)
-			return err;
-
-		err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_PHANTOM_PERSISTENCE,
-			1, &private->phantom_persistence);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-static int scarlett2_level_enum_ctl_info(struct snd_kcontrol *kctl,
-					 struct snd_ctl_elem_info *uinfo)
-{
-	static const char *const values[2] = {
-		"Line", "Inst"
-	};
-
-	return snd_ctl_enum_info(uinfo, 1, 2, values);
-}
-
-static int scarlett2_level_enum_ctl_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	int index = elem->control + info->level_input_first;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->input_other_updated) {
-		err = scarlett2_update_input_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->level_switch[index];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_level_enum_ctl_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	int index = elem->control + info->level_input_first;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->level_switch[index];
-	val = !!ucontrol->value.enumerated.item[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->level_switch[index] = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_LEVEL_SWITCH,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_level_enum_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = scarlett2_level_enum_ctl_info,
-	.get  = scarlett2_level_enum_ctl_get,
-	.put  = scarlett2_level_enum_ctl_put,
-};
-
-/*** Pad Switch Controls ***/
-
-static int scarlett2_pad_ctl_get(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->input_other_updated) {
-		err = scarlett2_update_input_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] =
-		private->pad_switch[elem->control];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_pad_ctl_put(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int index = elem->control;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->pad_switch[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->pad_switch[index] = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PAD_SWITCH,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_pad_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_pad_ctl_get,
-	.put  = scarlett2_pad_ctl_put,
-};
-
-/*** Air Switch Controls ***/
-
-static int scarlett2_air_ctl_get(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->input_other_updated) {
-		err = scarlett2_update_input_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] = private->air_switch[elem->control];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_air_ctl_put(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int index = elem->control;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->air_switch[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->air_switch[index] = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_AIR_SWITCH,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_air_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_air_ctl_get,
-	.put  = scarlett2_air_ctl_put,
-};
-
-/*** Phantom Switch Controls ***/
-
-static int scarlett2_phantom_ctl_get(struct snd_kcontrol *kctl,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->input_other_updated) {
-		err = scarlett2_update_input_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] =
-		private->phantom_switch[elem->control];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_phantom_ctl_put(struct snd_kcontrol *kctl,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int index = elem->control;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->phantom_switch[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->phantom_switch[index] = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_PHANTOM_SWITCH,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_phantom_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_phantom_ctl_get,
-	.put  = scarlett2_phantom_ctl_put,
-};
-
-/*** Phantom Persistence Control ***/
-
-static int scarlett2_phantom_persistence_ctl_get(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-
-	ucontrol->value.integer.value[0] = private->phantom_persistence;
-	return 0;
-}
-
-static int scarlett2_phantom_persistence_ctl_put(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int index = elem->control;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->phantom_persistence;
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->phantom_persistence = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_PHANTOM_PERSISTENCE, index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_phantom_persistence_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_phantom_persistence_ctl_get,
-	.put  = scarlett2_phantom_persistence_ctl_put,
-};
-
-/*** Direct Monitor Control ***/
-
-static int scarlett2_update_monitor_other(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	int err;
-
-	/* monitor_other_enable[0] enables speaker switching
-	 * monitor_other_enable[1] enables talkback
-	 */
-	u8 monitor_other_enable[2];
-
-	/* monitor_other_switch[0] activates the alternate speakers
-	 * monitor_other_switch[1] activates talkback
-	 */
-	u8 monitor_other_switch[2];
-
-	private->monitor_other_updated = 0;
-
-	if (info->direct_monitor)
-		return scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_DIRECT_MONITOR,
-			1, &private->direct_monitor_switch);
-
-	/* if it doesn't do speaker switching then it also doesn't do
-	 * talkback
-	 */
-	if (!info->has_speaker_switching)
-		return 0;
-
-	err = scarlett2_usb_get_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
-		2, monitor_other_enable);
-	if (err < 0)
-		return err;
-
-	err = scarlett2_usb_get_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
-		2, monitor_other_switch);
-	if (err < 0)
-		return err;
-
-	if (!monitor_other_enable[0])
-		private->speaker_switching_switch = 0;
-	else
-		private->speaker_switching_switch = monitor_other_switch[0] + 1;
-
-	if (info->has_talkback) {
-		const int (*port_count)[SCARLETT2_PORT_DIRNS] =
-			info->port_count;
-		int num_mixes =
-			port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
-		u16 bitmap;
-		int i;
-
-		if (!monitor_other_enable[1])
-			private->talkback_switch = 0;
-		else
-			private->talkback_switch = monitor_other_switch[1] + 1;
-
-		err = scarlett2_usb_get_config(mixer,
-					       SCARLETT2_CONFIG_TALKBACK_MAP,
-					       1, &bitmap);
-		if (err < 0)
-			return err;
-		for (i = 0; i < num_mixes; i++, bitmap >>= 1)
-			private->talkback_map[i] = bitmap & 1;
-	}
-
-	return 0;
-}
-
-static int scarlett2_direct_monitor_ctl_get(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->monitor_other_updated) {
-		err = scarlett2_update_monitor_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->direct_monitor_switch;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_direct_monitor_ctl_put(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int index = elem->control;
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->direct_monitor_switch;
-	val = min(ucontrol->value.enumerated.item[0], 2U);
-
-	if (oval == val)
-		goto unlock;
-
-	private->direct_monitor_switch = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_DIRECT_MONITOR, index, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_direct_monitor_stereo_enum_ctl_info(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
-{
-	static const char *const values[3] = {
-		"Off", "Mono", "Stereo"
-	};
-
-	return snd_ctl_enum_info(uinfo, 1, 3, values);
-}
-
-/* Direct Monitor for Solo is mono-only and only needs a boolean control
- * Direct Monitor for 2i2 is selectable between Off/Mono/Stereo
- */
-static const struct snd_kcontrol_new scarlett2_direct_monitor_ctl[2] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "",
-		.info = snd_ctl_boolean_mono_info,
-		.get  = scarlett2_direct_monitor_ctl_get,
-		.put  = scarlett2_direct_monitor_ctl_put,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "",
-		.info = scarlett2_direct_monitor_stereo_enum_ctl_info,
-		.get  = scarlett2_direct_monitor_ctl_get,
-		.put  = scarlett2_direct_monitor_ctl_put,
-	}
-};
-
-static int scarlett2_add_direct_monitor_ctl(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const char *s;
-
-	if (!info->direct_monitor)
-		return 0;
-
-	s = info->direct_monitor == 1
-	      ? "Direct Monitor Playback Switch"
-	      : "Direct Monitor Playback Enum";
-
-	return scarlett2_add_new_ctl(
-		mixer, &scarlett2_direct_monitor_ctl[info->direct_monitor - 1],
-		0, 1, s, &private->direct_monitor_ctl);
-}
-
-/*** Speaker Switching Control ***/
-
-static int scarlett2_speaker_switch_enum_ctl_info(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
-{
-	static const char *const values[3] = {
-		"Off", "Main", "Alt"
-	};
-
-	return snd_ctl_enum_info(uinfo, 1, 3, values);
-}
-
-static int scarlett2_speaker_switch_enum_ctl_get(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->monitor_other_updated) {
-		err = scarlett2_update_monitor_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->speaker_switching_switch;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-/* when speaker switching gets enabled, switch the main/alt speakers
- * to HW volume and disable those controls
- */
-static int scarlett2_speaker_switch_enable(struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	int i, err;
-
-	for (i = 0; i < 4; i++) {
-		int index = line_out_remap(private, i);
-
-		/* switch the main/alt speakers to HW volume */
-		if (!private->vol_sw_hw_switch[index]) {
-			err = scarlett2_sw_hw_change(private->mixer, i, 1);
-			if (err < 0)
-				return err;
-		}
-
-		/* disable the line out SW/HW switch */
-		scarlett2_sw_hw_ctl_ro(private, i);
-		snd_ctl_notify(card,
-			       SNDRV_CTL_EVENT_MASK_VALUE |
-				 SNDRV_CTL_EVENT_MASK_INFO,
-			       &private->sw_hw_ctls[i]->id);
-	}
-
-	/* when the next monitor-other notify comes in, update the mux
-	 * configuration
-	 */
-	private->speaker_switching_switched = 1;
-
-	return 0;
-}
-
-/* when speaker switching gets disabled, reenable the hw/sw controls
- * and invalidate the routing
- */
-static void scarlett2_speaker_switch_disable(struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	int i;
-
-	/* enable the line out SW/HW switch */
-	for (i = 0; i < 4; i++) {
-		scarlett2_sw_hw_ctl_rw(private, i);
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO,
-			       &private->sw_hw_ctls[i]->id);
-	}
-
-	/* when the next monitor-other notify comes in, update the mux
-	 * configuration
-	 */
-	private->speaker_switching_switched = 1;
-}
-
-static int scarlett2_speaker_switch_enum_ctl_put(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->speaker_switching_switch;
-	val = min(ucontrol->value.enumerated.item[0], 2U);
-
-	if (oval == val)
-		goto unlock;
-
-	private->speaker_switching_switch = val;
-
-	/* enable/disable speaker switching */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
-		0, !!val);
-	if (err < 0)
-		goto unlock;
-
-	/* if speaker switching is enabled, select main or alt */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
-		0, val == 2);
-	if (err < 0)
-		goto unlock;
-
-	/* update controls if speaker switching gets enabled or disabled */
-	if (!oval && val)
-		err = scarlett2_speaker_switch_enable(mixer);
-	else if (oval && !val)
-		scarlett2_speaker_switch_disable(mixer);
-
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_speaker_switch_enum_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = scarlett2_speaker_switch_enum_ctl_info,
-	.get  = scarlett2_speaker_switch_enum_ctl_get,
-	.put  = scarlett2_speaker_switch_enum_ctl_put,
-};
-
-static int scarlett2_add_speaker_switch_ctl(
-	struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	if (!info->has_speaker_switching)
-		return 0;
-
-	return scarlett2_add_new_ctl(
-		mixer, &scarlett2_speaker_switch_enum_ctl,
-		0, 1, "Speaker Switching Playback Enum",
-		&private->speaker_switching_ctl);
-}
-
-/*** Talkback and Talkback Map Controls ***/
-
-static int scarlett2_talkback_enum_ctl_info(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
-{
-	static const char *const values[3] = {
-		"Disabled", "Off", "On"
-	};
-
-	return snd_ctl_enum_info(uinfo, 1, 3, values);
-}
-
-static int scarlett2_talkback_enum_ctl_get(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->monitor_other_updated) {
-		err = scarlett2_update_monitor_other(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->talkback_switch;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_talkback_enum_ctl_put(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->talkback_switch;
-	val = min(ucontrol->value.enumerated.item[0], 2U);
-
-	if (oval == val)
-		goto unlock;
-
-	private->talkback_switch = val;
-
-	/* enable/disable talkback */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_ENABLE,
-		1, !!val);
-	if (err < 0)
-		goto unlock;
-
-	/* if talkback is enabled, select main or alt */
-	err = scarlett2_usb_set_config(
-		mixer, SCARLETT2_CONFIG_MONITOR_OTHER_SWITCH,
-		1, val == 2);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_talkback_enum_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = scarlett2_talkback_enum_ctl_info,
-	.get  = scarlett2_talkback_enum_ctl_get,
-	.put  = scarlett2_talkback_enum_ctl_put,
-};
-
-static int scarlett2_talkback_map_ctl_get(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = elem->control;
-
-	ucontrol->value.integer.value[0] = private->talkback_map[index];
-
-	return 0;
-}
-
-static int scarlett2_talkback_map_ctl_put(
-	struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] =
-		private->info->port_count;
-	int num_mixes = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
-
-	int index = elem->control;
-	int oval, val, err = 0, i;
-	u16 bitmap = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->talkback_map[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->talkback_map[index] = val;
-
-	for (i = 0; i < num_mixes; i++)
-		bitmap |= private->talkback_map[i] << i;
-
-	/* Send updated bitmap to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_TALKBACK_MAP,
-				       0, bitmap);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_talkback_map_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_talkback_map_ctl_get,
-	.put  = scarlett2_talkback_map_ctl_put,
-};
-
-static int scarlett2_add_talkback_ctls(
-	struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_mixes = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
-	int err, i;
-	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-
-	if (!info->has_talkback)
-		return 0;
-
-	err = scarlett2_add_new_ctl(
-		mixer, &scarlett2_talkback_enum_ctl,
-		0, 1, "Talkback Playback Enum",
-		&private->talkback_ctl);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i < num_mixes; i++) {
-		snprintf(s, sizeof(s),
-			 "Talkback Mix %c Playback Switch", i + 'A');
-		err = scarlett2_add_new_ctl(mixer, &scarlett2_talkback_map_ctl,
-					    i, 1, s, NULL);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-/*** Dim/Mute Controls ***/
-
-static int scarlett2_dim_mute_ctl_get(struct snd_kcontrol *kctl,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->vol_updated) {
-		err = scarlett2_update_volumes(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.integer.value[0] = private->dim_mute[elem->control];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_dim_mute_ctl_put(struct snd_kcontrol *kctl,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-
-	int index = elem->control;
-	int oval, val, err = 0, i;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->dim_mute[index];
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->dim_mute[index] = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_DIM_MUTE,
-				       index, val);
-	if (err == 0)
-		err = 1;
-
-	if (index == SCARLETT2_BUTTON_MUTE)
-		for (i = 0; i < num_line_out; i++) {
-			int line_index = line_out_remap(private, i);
-
-			if (private->vol_sw_hw_switch[line_index]) {
-				private->mute_switch[line_index] = val;
-				snd_ctl_notify(mixer->chip->card,
-					       SNDRV_CTL_EVENT_MASK_VALUE,
-					       &private->mute_ctls[i]->id);
-			}
-		}
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_dim_mute_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_dim_mute_ctl_get,
-	.put  = scarlett2_dim_mute_ctl_put
-};
-
-/*** Create the analogue output controls ***/
-
-static int scarlett2_add_line_out_ctls(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int err, i;
-	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-
-	/* Add R/O HW volume control */
-	if (info->line_out_hw_vol) {
-		snprintf(s, sizeof(s), "Master HW Playback Volume");
-		err = scarlett2_add_new_ctl(mixer,
-					    &scarlett2_master_volume_ctl,
-					    0, 1, s, &private->master_vol_ctl);
-		if (err < 0)
-			return err;
-	}
-
-	/* Add volume controls */
-	for (i = 0; i < num_line_out; i++) {
-		int index = line_out_remap(private, i);
-
-		/* Fader */
-		if (info->line_out_descrs[i])
-			snprintf(s, sizeof(s),
-				 "Line %02d (%s) Playback Volume",
-				 i + 1, info->line_out_descrs[i]);
-		else
-			snprintf(s, sizeof(s),
-				 "Line %02d Playback Volume",
-				 i + 1);
-		err = scarlett2_add_new_ctl(mixer,
-					    &scarlett2_line_out_volume_ctl,
-					    i, 1, s, &private->vol_ctls[i]);
-		if (err < 0)
-			return err;
-
-		/* Mute Switch */
-		snprintf(s, sizeof(s),
-			 "Line %02d Mute Playback Switch",
-			 i + 1);
-		err = scarlett2_add_new_ctl(mixer,
-					    &scarlett2_mute_ctl,
-					    i, 1, s,
-					    &private->mute_ctls[i]);
-		if (err < 0)
-			return err;
-
-		/* Make the fader and mute controls read-only if the
-		 * SW/HW switch is set to HW
-		 */
-		if (private->vol_sw_hw_switch[index])
-			scarlett2_vol_ctl_set_writable(mixer, i, 0);
-
-		/* SW/HW Switch */
-		if (info->line_out_hw_vol) {
-			snprintf(s, sizeof(s),
-				 "Line Out %02d Volume Control Playback Enum",
-				 i + 1);
-			err = scarlett2_add_new_ctl(mixer,
-						    &scarlett2_sw_hw_enum_ctl,
-						    i, 1, s,
-						    &private->sw_hw_ctls[i]);
-			if (err < 0)
-				return err;
-
-			/* Make the switch read-only if the line is
-			 * involved in speaker switching
-			 */
-			if (private->speaker_switching_switch && i < 4)
-				scarlett2_sw_hw_ctl_ro(private, i);
-		}
-	}
-
-	/* Add dim/mute controls */
-	if (info->line_out_hw_vol)
-		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++) {
-			err = scarlett2_add_new_ctl(
-				mixer, &scarlett2_dim_mute_ctl,
-				i, 1, scarlett2_dim_mute_names[i],
-				&private->dim_mute_ctls[i]);
-			if (err < 0)
-				return err;
-		}
-
-	return 0;
-}
-
-/*** Create the analogue input controls ***/
-
-static int scarlett2_add_line_in_ctls(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	int err, i;
-	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	const char *fmt = "Line In %d %s Capture %s";
-	const char *fmt2 = "Line In %d-%d %s Capture %s";
-
-	/* Add input level (line/inst) controls */
-	for (i = 0; i < info->level_input_count; i++) {
-		snprintf(s, sizeof(s), fmt, i + 1 + info->level_input_first,
-			 "Level", "Enum");
-		err = scarlett2_add_new_ctl(mixer, &scarlett2_level_enum_ctl,
-					    i, 1, s, &private->level_ctls[i]);
-		if (err < 0)
-			return err;
-	}
-
-	/* Add input pad controls */
-	for (i = 0; i < info->pad_input_count; i++) {
-		snprintf(s, sizeof(s), fmt, i + 1, "Pad", "Switch");
-		err = scarlett2_add_new_ctl(mixer, &scarlett2_pad_ctl,
-					    i, 1, s, &private->pad_ctls[i]);
-		if (err < 0)
-			return err;
-	}
-
-	/* Add input air controls */
-	for (i = 0; i < info->air_input_count; i++) {
-		snprintf(s, sizeof(s), fmt, i + 1, "Air", "Switch");
-		err = scarlett2_add_new_ctl(mixer, &scarlett2_air_ctl,
-					    i, 1, s, &private->air_ctls[i]);
-		if (err < 0)
-			return err;
-	}
-
-	/* Add input phantom controls */
-	if (info->inputs_per_phantom == 1) {
-		for (i = 0; i < info->phantom_count; i++) {
-			snprintf(s, sizeof(s), fmt, i + 1,
-				 "Phantom Power", "Switch");
-			err = scarlett2_add_new_ctl(
-				mixer, &scarlett2_phantom_ctl,
-				i, 1, s, &private->phantom_ctls[i]);
-			if (err < 0)
-				return err;
-		}
-	} else if (info->inputs_per_phantom > 1) {
-		for (i = 0; i < info->phantom_count; i++) {
-			int from = i * info->inputs_per_phantom + 1;
-			int to = (i + 1) * info->inputs_per_phantom;
-
-			snprintf(s, sizeof(s), fmt2, from, to,
-				 "Phantom Power", "Switch");
-			err = scarlett2_add_new_ctl(
-				mixer, &scarlett2_phantom_ctl,
-				i, 1, s, &private->phantom_ctls[i]);
-			if (err < 0)
-				return err;
-		}
-	}
-	if (info->phantom_count) {
-		err = scarlett2_add_new_ctl(
-			mixer, &scarlett2_phantom_persistence_ctl, 0, 1,
-			"Phantom Power Persistence Capture Switch", NULL);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-/*** Mixer Volume Controls ***/
-
-static int scarlett2_mixer_ctl_info(struct snd_kcontrol *kctl,
-				    struct snd_ctl_elem_info *uinfo)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = elem->channels;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = SCARLETT2_MIXER_MAX_VALUE;
-	uinfo->value.integer.step = 1;
-	return 0;
-}
-
-static int scarlett2_mixer_ctl_get(struct snd_kcontrol *kctl,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-
-	ucontrol->value.integer.value[0] = private->mix[elem->control];
-	return 0;
-}
-
-static int scarlett2_mixer_ctl_put(struct snd_kcontrol *kctl,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int oval, val, num_mixer_in, mix_num, err = 0;
-	int index = elem->control;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->mix[index];
-	val = clamp(ucontrol->value.integer.value[0],
-		    0L, (long)SCARLETT2_MIXER_MAX_VALUE);
-	num_mixer_in = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
-	mix_num = index / num_mixer_in;
-
-	if (oval == val)
-		goto unlock;
-
-	private->mix[index] = val;
-	err = scarlett2_usb_set_mix(mixer, mix_num);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const DECLARE_TLV_DB_MINMAX(
-	db_scale_scarlett2_mixer,
-	SCARLETT2_MIXER_MIN_DB * 100,
-	SCARLETT2_MIXER_MAX_DB * 100
-);
-
-static const struct snd_kcontrol_new scarlett2_mixer_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-	.name = "",
-	.info = scarlett2_mixer_ctl_info,
-	.get  = scarlett2_mixer_ctl_get,
-	.put  = scarlett2_mixer_ctl_put,
-	.private_value = SCARLETT2_MIXER_MAX_DB, /* max value */
-	.tlv = { .p = db_scale_scarlett2_mixer }
-};
-
-static int scarlett2_add_mixer_ctls(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int err, i, j;
-	int index;
-	char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-
-	int num_inputs =
-		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
-	int num_outputs =
-		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
-
-	for (i = 0, index = 0; i < num_outputs; i++)
-		for (j = 0; j < num_inputs; j++, index++) {
-			snprintf(s, sizeof(s),
-				 "Mix %c Input %02d Playback Volume",
-				 'A' + i, j + 1);
-			err = scarlett2_add_new_ctl(mixer, &scarlett2_mixer_ctl,
-						    index, 1, s, NULL);
-			if (err < 0)
-				return err;
-		}
-
-	return 0;
-}
-
-/*** Mux Source Selection Controls ***/
-
-static int scarlett2_mux_src_enum_ctl_info(struct snd_kcontrol *kctl,
-					   struct snd_ctl_elem_info *uinfo)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	unsigned int item = uinfo->value.enumerated.item;
-	int items = private->num_mux_srcs;
-	int port_type;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = elem->channels;
-	uinfo->value.enumerated.items = items;
-
-	if (item >= items)
-		item = uinfo->value.enumerated.item = items - 1;
-
-	for (port_type = 0;
-	     port_type < SCARLETT2_PORT_TYPE_COUNT;
-	     port_type++) {
-		if (item < port_count[port_type][SCARLETT2_PORT_IN]) {
-			const struct scarlett2_port *port =
-				&scarlett2_ports[port_type];
-
-			sprintf(uinfo->value.enumerated.name,
-				port->src_descr, item + port->src_num_offset);
-			return 0;
-		}
-		item -= port_count[port_type][SCARLETT2_PORT_IN];
-	}
-
-	return -EINVAL;
-}
-
-static int scarlett2_mux_src_enum_ctl_get(struct snd_kcontrol *kctl,
-					  struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	if (private->mux_updated) {
-		err = scarlett2_usb_get_mux(mixer);
-		if (err < 0)
-			goto unlock;
-	}
-	ucontrol->value.enumerated.item[0] = private->mux[index];
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static int scarlett2_mux_src_enum_ctl_put(struct snd_kcontrol *kctl,
-					  struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-	int index = line_out_remap(private, elem->control);
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->mux[index];
-	val = min(ucontrol->value.enumerated.item[0],
-		  private->num_mux_srcs - 1U);
-
-	if (oval == val)
-		goto unlock;
-
-	private->mux[index] = val;
-	err = scarlett2_usb_set_mux(mixer);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_mux_src_enum_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = scarlett2_mux_src_enum_ctl_info,
-	.get  = scarlett2_mux_src_enum_ctl_get,
-	.put  = scarlett2_mux_src_enum_ctl_put,
-};
-
-static int scarlett2_add_mux_enums(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int port_type, channel, i;
-
-	for (i = 0, port_type = 0;
-	     port_type < SCARLETT2_PORT_TYPE_COUNT;
-	     port_type++) {
-		for (channel = 0;
-		     channel < port_count[port_type][SCARLETT2_PORT_OUT];
-		     channel++, i++) {
-			int err;
-			char s[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-			const char *const descr =
-				scarlett2_ports[port_type].dst_descr;
-
-			snprintf(s, sizeof(s) - 5, descr, channel + 1);
-			strcat(s, " Enum");
-
-			err = scarlett2_add_new_ctl(mixer,
-						    &scarlett2_mux_src_enum_ctl,
-						    i, 1, s,
-						    &private->mux_ctls[i]);
-			if (err < 0)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
-/*** Meter Controls ***/
-
-static int scarlett2_meter_ctl_info(struct snd_kcontrol *kctl,
-				    struct snd_ctl_elem_info *uinfo)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = elem->channels;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 4095;
-	uinfo->value.integer.step = 1;
-	return 0;
-}
-
-static int scarlett2_meter_ctl_get(struct snd_kcontrol *kctl,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	u16 meter_levels[SCARLETT2_MAX_METERS];
-	int i, err;
-
-	err = scarlett2_usb_get_meter_levels(elem->head.mixer, elem->channels,
-					     meter_levels);
-	if (err < 0)
-		return err;
-
-	for (i = 0; i < elem->channels; i++)
-		ucontrol->value.integer.value[i] = meter_levels[i];
-
-	return 0;
-}
-
-static const struct snd_kcontrol_new scarlett2_meter_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
-	.name = "",
-	.info = scarlett2_meter_ctl_info,
-	.get  = scarlett2_meter_ctl_get
-};
-
-static int scarlett2_add_meter_ctl(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	/* devices without a mixer also don't support reporting levels */
-	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
-		return 0;
-
-	return scarlett2_add_new_ctl(mixer, &scarlett2_meter_ctl,
-				     0, private->num_mux_dsts,
-				     "Level Meter", NULL);
-}
-
-/*** MSD Controls ***/
-
-static int scarlett2_msd_ctl_get(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-
-	ucontrol->value.integer.value[0] = private->msd_switch;
-	return 0;
-}
-
-static int scarlett2_msd_ctl_put(struct snd_kcontrol *kctl,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->msd_switch;
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->msd_switch = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer, SCARLETT2_CONFIG_MSD_SWITCH,
-				       0, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_msd_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_msd_ctl_get,
-	.put  = scarlett2_msd_ctl_put,
-};
-
-static int scarlett2_add_msd_ctl(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	if (!info->has_msd_mode)
-		return 0;
-
-	/* If MSD mode is off, hide the switch by default */
-	if (!private->msd_switch && !(mixer->chip->setup & SCARLETT2_MSD_ENABLE))
-		return 0;
-
-	/* Add MSD control */
-	return scarlett2_add_new_ctl(mixer, &scarlett2_msd_ctl,
-				     0, 1, "MSD Mode Switch", NULL);
-}
-
-/*** Standalone Control ***/
-
-static int scarlett2_standalone_ctl_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct scarlett2_data *private = elem->head.mixer->private_data;
-
-	ucontrol->value.integer.value[0] = private->standalone_switch;
-	return 0;
-}
-
-static int scarlett2_standalone_ctl_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct usb_mixer_interface *mixer = elem->head.mixer;
-	struct scarlett2_data *private = mixer->private_data;
-
-	int oval, val, err = 0;
-
-	mutex_lock(&private->data_mutex);
-
-	oval = private->standalone_switch;
-	val = !!ucontrol->value.integer.value[0];
-
-	if (oval == val)
-		goto unlock;
-
-	private->standalone_switch = val;
-
-	/* Send switch change to the device */
-	err = scarlett2_usb_set_config(mixer,
-				       SCARLETT2_CONFIG_STANDALONE_SWITCH,
-				       0, val);
-	if (err == 0)
-		err = 1;
-
-unlock:
-	mutex_unlock(&private->data_mutex);
-	return err;
-}
-
-static const struct snd_kcontrol_new scarlett2_standalone_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "",
-	.info = snd_ctl_boolean_mono_info,
-	.get  = scarlett2_standalone_ctl_get,
-	.put  = scarlett2_standalone_ctl_put,
-};
-
-static int scarlett2_add_standalone_ctl(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	if (private->info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
-		return 0;
-
-	/* Add standalone control */
-	return scarlett2_add_new_ctl(mixer, &scarlett2_standalone_ctl,
-				     0, 1, "Standalone Switch", NULL);
-}
-
-/*** Cleanup/Suspend Callbacks ***/
-
-static void scarlett2_private_free(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	cancel_delayed_work_sync(&private->work);
-	kfree(private);
-	mixer->private_data = NULL;
-}
-
-static void scarlett2_private_suspend(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	if (cancel_delayed_work_sync(&private->work))
-		scarlett2_config_save(private->mixer);
-}
-
-/*** Initialisation ***/
-
-static void scarlett2_count_mux_io(struct scarlett2_data *private)
-{
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int port_type, srcs = 0, dsts = 0;
-
-	for (port_type = 0;
-	     port_type < SCARLETT2_PORT_TYPE_COUNT;
-	     port_type++) {
-		srcs += port_count[port_type][SCARLETT2_PORT_IN];
-		dsts += port_count[port_type][SCARLETT2_PORT_OUT];
-	}
-
-	private->num_mux_srcs = srcs;
-	private->num_mux_dsts = dsts;
-}
-
-/* Look through the interface descriptors for the Focusrite Control
- * interface (bInterfaceClass = 255 Vendor Specific Class) and set
- * bInterfaceNumber, bEndpointAddress, wMaxPacketSize, and bInterval
- * in private
- */
-static int scarlett2_find_fc_interface(struct usb_device *dev,
-				       struct scarlett2_data *private)
-{
-	struct usb_host_config *config = dev->actconfig;
-	int i;
-
-	for (i = 0; i < config->desc.bNumInterfaces; i++) {
-		struct usb_interface *intf = config->interface[i];
-		struct usb_interface_descriptor *desc =
-			&intf->altsetting[0].desc;
-		struct usb_endpoint_descriptor *epd;
-
-		if (desc->bInterfaceClass != 255)
-			continue;
-
-		epd = get_endpoint(intf->altsetting, 0);
-		private->bInterfaceNumber = desc->bInterfaceNumber;
-		private->bEndpointAddress = epd->bEndpointAddress &
-			USB_ENDPOINT_NUMBER_MASK;
-		private->wMaxPacketSize = le16_to_cpu(epd->wMaxPacketSize);
-		private->bInterval = epd->bInterval;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/* Initialise private data */
-static int scarlett2_init_private(struct usb_mixer_interface *mixer,
-				  const struct scarlett2_device_info *info)
-{
-	struct scarlett2_data *private =
-		kzalloc(sizeof(struct scarlett2_data), GFP_KERNEL);
-
-	if (!private)
-		return -ENOMEM;
-
-	mutex_init(&private->usb_mutex);
-	mutex_init(&private->data_mutex);
-	INIT_DELAYED_WORK(&private->work, scarlett2_config_save_work);
-
-	mixer->private_data = private;
-	mixer->private_free = scarlett2_private_free;
-	mixer->private_suspend = scarlett2_private_suspend;
-
-	private->info = info;
-	scarlett2_count_mux_io(private);
-	private->scarlett2_seq = 0;
-	private->mixer = mixer;
-
-	return scarlett2_find_fc_interface(mixer->chip->dev, private);
-}
-
-/* Cargo cult proprietary initialisation sequence */
-static int scarlett2_usb_init(struct usb_mixer_interface *mixer)
-{
-	struct usb_device *dev = mixer->chip->dev;
-	struct scarlett2_data *private = mixer->private_data;
-	u8 buf[24];
-	int err;
-
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
-
-	/* step 0 */
-	err = scarlett2_usb_rx(dev, private->bInterfaceNumber,
-			       SCARLETT2_USB_CMD_INIT, buf, sizeof(buf));
-	if (err < 0)
-		return err;
-
-	/* step 1 */
-	private->scarlett2_seq = 1;
-	err = scarlett2_usb(mixer, SCARLETT2_USB_INIT_1, NULL, 0, NULL, 0);
-	if (err < 0)
-		return err;
-
-	/* step 2 */
-	private->scarlett2_seq = 1;
-	return scarlett2_usb(mixer, SCARLETT2_USB_INIT_2, NULL, 0, NULL, 84);
-}
-
-/* Read configuration from the interface on start */
-static int scarlett2_read_configs(struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int num_mixer_out =
-		port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_IN];
-	struct scarlett2_usb_volume_status volume_status;
-	int err, i;
-
-	if (info->has_msd_mode) {
-		err = scarlett2_usb_get_config(
-			mixer, SCARLETT2_CONFIG_MSD_SWITCH,
-			1, &private->msd_switch);
-		if (err < 0)
-			return err;
-
-		/* no other controls are created if MSD mode is on */
-		if (private->msd_switch)
-			return 0;
-	}
-
-	err = scarlett2_update_input_other(mixer);
-	if (err < 0)
-		return err;
-
-	err = scarlett2_update_monitor_other(mixer);
-	if (err < 0)
-		return err;
-
-	/* the rest of the configuration is for devices with a mixer */
-	if (info->config_set == SCARLETT2_CONFIG_SET_NO_MIXER)
-		return 0;
-
-	err = scarlett2_usb_get_config(
-		mixer, SCARLETT2_CONFIG_STANDALONE_SWITCH,
-		1, &private->standalone_switch);
-	if (err < 0)
-		return err;
-
-	err = scarlett2_update_sync(mixer);
-	if (err < 0)
-		return err;
-
-	err = scarlett2_usb_get_volume_status(mixer, &volume_status);
-	if (err < 0)
-		return err;
-
-	if (info->line_out_hw_vol)
-		for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
-			private->dim_mute[i] = !!volume_status.dim_mute[i];
-
-	private->master_vol = clamp(
-		volume_status.master_vol + SCARLETT2_VOLUME_BIAS,
-		0, SCARLETT2_VOLUME_BIAS);
-
-	for (i = 0; i < num_line_out; i++) {
-		int volume, mute;
-
-		private->vol_sw_hw_switch[i] =
-			info->line_out_hw_vol
-				&& volume_status.sw_hw_switch[i];
-
-		volume = private->vol_sw_hw_switch[i]
-			   ? volume_status.master_vol
-			   : volume_status.sw_vol[i];
-		volume = clamp(volume + SCARLETT2_VOLUME_BIAS,
-			       0, SCARLETT2_VOLUME_BIAS);
-		private->vol[i] = volume;
-
-		mute = private->vol_sw_hw_switch[i]
-			 ? private->dim_mute[SCARLETT2_BUTTON_MUTE]
-			 : volume_status.mute_switch[i];
-		private->mute_switch[i] = mute;
-	}
-
-	for (i = 0; i < num_mixer_out; i++) {
-		err = scarlett2_usb_get_mix(mixer, i);
-		if (err < 0)
-			return err;
-	}
-
-	return scarlett2_usb_get_mux(mixer);
-}
-
-/* Notify on sync change */
-static void scarlett2_notify_sync(
-	struct usb_mixer_interface *mixer)
-{
-	struct scarlett2_data *private = mixer->private_data;
-
-	private->sync_updated = 1;
-
-	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-		       &private->sync_ctl->id);
-}
-
-/* Notify on monitor change */
-static void scarlett2_notify_monitor(
-	struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int i;
-
-	/* if line_out_hw_vol is 0, there are no controls to update */
-	if (!info->line_out_hw_vol)
-		return;
-
-	private->vol_updated = 1;
-
-	snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-		       &private->master_vol_ctl->id);
-
-	for (i = 0; i < num_line_out; i++)
-		if (private->vol_sw_hw_switch[line_out_remap(private, i)])
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &private->vol_ctls[i]->id);
-}
-
-/* Notify on dim/mute change */
-static void scarlett2_notify_dim_mute(
-	struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	const int (*port_count)[SCARLETT2_PORT_DIRNS] = info->port_count;
-	int num_line_out =
-		port_count[SCARLETT2_PORT_TYPE_ANALOGUE][SCARLETT2_PORT_OUT];
-	int i;
-
-	private->vol_updated = 1;
-
-	if (!info->line_out_hw_vol)
-		return;
-
-	for (i = 0; i < SCARLETT2_DIM_MUTE_COUNT; i++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->dim_mute_ctls[i]->id);
-
-	for (i = 0; i < num_line_out; i++)
-		if (private->vol_sw_hw_switch[line_out_remap(private, i)])
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &private->mute_ctls[i]->id);
-}
-
-/* Notify on "input other" change (level/pad/air) */
-static void scarlett2_notify_input_other(
-	struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-	int i;
-
-	private->input_other_updated = 1;
-
-	for (i = 0; i < info->level_input_count; i++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->level_ctls[i]->id);
-	for (i = 0; i < info->pad_input_count; i++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->pad_ctls[i]->id);
-	for (i = 0; i < info->air_input_count; i++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->air_ctls[i]->id);
-	for (i = 0; i < info->phantom_count; i++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->phantom_ctls[i]->id);
-}
-
-/* Notify on "monitor other" change (direct monitor, speaker
- * switching, talkback)
- */
-static void scarlett2_notify_monitor_other(
-	struct usb_mixer_interface *mixer)
-{
-	struct snd_card *card = mixer->chip->card;
-	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_device_info *info = private->info;
-
-	private->monitor_other_updated = 1;
-
-	if (info->direct_monitor) {
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->direct_monitor_ctl->id);
-		return;
-	}
-
-	if (info->has_speaker_switching)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->speaker_switching_ctl->id);
-
-	if (info->has_talkback)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &private->talkback_ctl->id);
-
-	/* if speaker switching was recently enabled or disabled,
-	 * invalidate the dim/mute and mux enum controls
-	 */
-	if (private->speaker_switching_switched) {
-		int i;
-
-		scarlett2_notify_dim_mute(mixer);
-
-		private->speaker_switching_switched = 0;
-		private->mux_updated = 1;
-
-		for (i = 0; i < private->num_mux_dsts; i++)
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &private->mux_ctls[i]->id);
-	}
-}
-
-/* Interrupt callback */
-static void scarlett2_notify(struct urb *urb)
-{
-	struct usb_mixer_interface *mixer = urb->context;
-	int len = urb->actual_length;
-	int ustatus = urb->status;
-	u32 data;
-
-	if (ustatus != 0 || len != 8)
-		goto requeue;
-
-	data = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
-	if (data & SCARLETT2_USB_NOTIFY_SYNC)
-		scarlett2_notify_sync(mixer);
-	if (data & SCARLETT2_USB_NOTIFY_MONITOR)
-		scarlett2_notify_monitor(mixer);
-	if (data & SCARLETT2_USB_NOTIFY_DIM_MUTE)
-		scarlett2_notify_dim_mute(mixer);
-	if (data & SCARLETT2_USB_NOTIFY_INPUT_OTHER)
-		scarlett2_notify_input_other(mixer);
-	if (data & SCARLETT2_USB_NOTIFY_MONITOR_OTHER)
-		scarlett2_notify_monitor_other(mixer);
-
-requeue:
-	if (ustatus != -ENOENT &&
-	    ustatus != -ECONNRESET &&
-	    ustatus != -ESHUTDOWN) {
-		urb->dev = mixer->chip->dev;
-		usb_submit_urb(urb, GFP_ATOMIC);
-	}
-}
-
-static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
-{
-	struct usb_device *dev = mixer->chip->dev;
-	struct scarlett2_data *private = mixer->private_data;
-	unsigned int pipe = usb_rcvintpipe(dev, private->bEndpointAddress);
-	void *transfer_buffer;
-
-	if (mixer->urb) {
-		usb_audio_err(mixer->chip,
-			      "%s: mixer urb already in use!\n", __func__);
-		return 0;
-	}
-
-	if (usb_pipe_type_check(dev, pipe))
-		return -EINVAL;
-
-	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!mixer->urb)
-		return -ENOMEM;
-
-	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
-	if (!transfer_buffer)
-		return -ENOMEM;
-
-	usb_fill_int_urb(mixer->urb, dev, pipe,
-			 transfer_buffer, private->wMaxPacketSize,
-			 scarlett2_notify, mixer, private->bInterval);
-
-	return usb_submit_urb(mixer->urb, GFP_KERNEL);
-}
-
-static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer)
-{
-	const struct scarlett2_device_info **info = scarlett2_devices;
-	int err;
-
-	/* Find device in scarlett2_devices */
-	while (*info && (*info)->usb_id != mixer->chip->usb_id)
-		info++;
-	if (!*info)
-		return -EINVAL;
-
-	/* Initialise private data */
-	err = scarlett2_init_private(mixer, *info);
-	if (err < 0)
-		return err;
-
-	/* Send proprietary USB initialisation sequence */
-	err = scarlett2_usb_init(mixer);
-	if (err < 0)
-		return err;
-
-	/* Read volume levels and controls from the interface */
-	err = scarlett2_read_configs(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the MSD control */
-	err = scarlett2_add_msd_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* If MSD mode is enabled, don't create any other controls */
-	if (((struct scarlett2_data *)mixer->private_data)->msd_switch)
-		return 0;
-
-	/* Create the analogue output controls */
-	err = scarlett2_add_line_out_ctls(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the analogue input controls */
-	err = scarlett2_add_line_in_ctls(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the input, output, and mixer mux input selections */
-	err = scarlett2_add_mux_enums(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the matrix mixer controls */
-	err = scarlett2_add_mixer_ctls(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the level meter controls */
-	err = scarlett2_add_meter_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the sync control */
-	err = scarlett2_add_sync_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the direct monitor control */
-	err = scarlett2_add_direct_monitor_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the speaker switching control */
-	err = scarlett2_add_speaker_switch_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the talkback controls */
-	err = scarlett2_add_talkback_ctls(mixer);
-	if (err < 0)
-		return err;
-
-	/* Create the standalone control */
-	err = scarlett2_add_standalone_ctl(mixer);
-	if (err < 0)
-		return err;
-
-	/* Set up the interrupt polling */
-	err = scarlett2_init_notify(mixer);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer)
-{
-	struct snd_usb_audio *chip = mixer->chip;
-	int err;
-
-	/* only use UAC_VERSION_2 */
-	if (!mixer->protocol)
-		return 0;
-
-	if (!(chip->setup & SCARLETT2_ENABLE)) {
-		usb_audio_info(chip,
-			"Focusrite Scarlett Gen 2/3 Mixer Driver disabled; "
-			"use options snd_usb_audio vid=0x%04x pid=0x%04x "
-			"device_setup=1 to enable and report any issues "
-			"to g@b4.vu",
-			USB_ID_VENDOR(chip->usb_id),
-			USB_ID_PRODUCT(chip->usb_id));
-		return 0;
-	}
-
-	usb_audio_info(chip,
-		"Focusrite Scarlett Gen 2/3 Mixer Driver enabled pid=0x%04x",
-		USB_ID_PRODUCT(chip->usb_id));
-
-	err = snd_scarlett_gen2_controls_create(mixer);
-	if (err < 0)
-		usb_audio_err(mixer->chip,
-			      "Error initialising Scarlett Mixer Driver: %d",
-			      err);
-
-	return err;
-}
diff --git a/sound/usb/mixer_scarlett_gen2.h b/sound/usb/mixer_scarlett_gen2.h
deleted file mode 100644
index 668c6b0cb50a..000000000000
--- a/sound/usb/mixer_scarlett_gen2.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __USB_MIXER_SCARLETT_GEN2_H
-#define __USB_MIXER_SCARLETT_GEN2_H
-
-int snd_scarlett_gen2_init(struct usb_mixer_interface *mixer);
-
-#endif /* __USB_MIXER_SCARLETT_GEN2_H */
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b1ede6249866..b7c8f29c09a9 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:*' > set_event
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi

