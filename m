Return-Path: <linux-kernel+bounces-57683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822ED84DC29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF22848A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460956778;
	Thu,  8 Feb 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spif8OpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECB6A8B3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382773; cv=none; b=K905/UGc08SkeToZwFqbqgEjij3O20DnmV3cpK5sjgh3vyC6ARKmuhV3vJ4f9LoD14v8HkoIWlYgSBkXAoR2y9jfRICmEu84hpte9uYvUfYEnkYcPgXg1lsjoI91VX4IYuGO9NmYIgtJQZOeFpDGB1o8aPwYyOUW6Y5K1UdsBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382773; c=relaxed/simple;
	bh=oc9xEgs3vVsmKdWfJfVc5TvczoQamN7QDY7Z0CoyV6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJFt8ifzjO3dXqKckWLZQK5boJIl3EbDfdvJ4TWd6ad5htNMMomlIVm0FAMwAqP54pji2uf7K/G2pBrrCWtQkE/34T4b5/uAvgU62jLPhdtNOlXMStz2aSxCexxnGFDfN4nQr1k63GxyIHqPhiW/guNAu1YFCU2DhdsqtSfS0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spif8OpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66032C433F1;
	Thu,  8 Feb 2024 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707382772;
	bh=oc9xEgs3vVsmKdWfJfVc5TvczoQamN7QDY7Z0CoyV6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spif8OpMb6t8co47RAxJjj7J/2Z5Eqpi9OUsTqMyKXHRxd1wnvfkRTFGO6pqt48YE
	 tHsQWe3vEH1bZEh57nXswPxvUJVaBVJtRrO4mwM0GMuggRl0Ir5UzG2IGi+AcPAVmk
	 MaN/7UyYRV3cQdn4saHIRyA2nyFbp7kMrF3q6SD/xeOZYHDBpnsTa32ff8sAT8C6Rj
	 OCGCBZ5jEfsccRgP7YVJ0nkToO4h8JFjDhSaROoIyJO3OJ5nn3f+oIf2E4OkiFgJYZ
	 K3+aEGdnC1kTROE/EXQA/jg+Ab3cjxpPrl0Mv1k29gJ9VGRHqXRnOY6++pAWxuh6Yh
	 3VUu/oW1+nOug==
Date: Thu, 8 Feb 2024 08:59:28 +0000
From: Lee Jones <lee@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: `intel_lpss_pci_driver_init` takes 23.8 ms
Message-ID: <20240208085928.GB689448@google.com>
References: <ebd4dd9d-3710-4cbb-92d1-c3f73b66bc97@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd4dd9d-3710-4cbb-92d1-c3f73b66bc97@molgen.mpg.de>

Adding Andy.

On Tue, 06 Feb 2024, Paul Menzel wrote:

> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360 and Linux 6.8-rc3+, `intel_lpss_pci_driver_init()`
> takes 23.8 ms, making it one of Linux’ longer init functions on this device:
> 
> ```
> [    0.000000] Linux version 6.8.0-rc3
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, GNU
> ld (GNU Binutils for Debian) 2.42) #13 SMP PREEMPT_DYNAMIC Tue Feb 6
> 08:07:48 CET 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0-rc3
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> mem_sleep_default=deep log_buf_len=8M cryptomgr.notests initcall_debug
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> […]
> [    0.785696] calling  intel_lpss_pci_driver_init+0x0/0xff0
> [intel_lpss_pci] @ 153
> [    0.785704] calling  crct10dif_intel_mod_init+0x0/0xff0
> [crct10dif_pclmul] @ 163
> [    0.785796] calling  drm_core_init+0x0/0xff0 [drm] @ 161
> [    0.785880] ACPI: bus type drm_connector registered
> [    0.785887] initcall drm_core_init+0x0/0xff0 [drm] returned 0 after 25
> usecs
> [    0.785936] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    0.786210] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    0.786221] probe of idma64.0 returned 0 after 81 usecs
> […]
> [    0.801676] probe of i2c_designware.0 returned 0 after 15424 usecs
> [    0.801691] probe of 0000:00:15.0 returned 0 after 15973 usecs
> [    0.801870] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    0.802116] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    0.802123] probe of idma64.1 returned 0 after 55 usecs
> [    0.819818] probe of i2c_designware.1 returned 0 after 17646 usecs
> [    0.819832] probe of 0000:00:15.1 returned 0 after 18137 usecs
> [    0.819852] initcall intel_lpss_pci_driver_init+0x0/0xff0
> [intel_lpss_pci] returned 0 after 23842 usecs
> ```
> 
> Is this expected, that probing
> 
>     00:15.1 Signal processing controller [1180]: Intel Corporation Sunrise
> Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
> 
> takes 18 ms?
> 
> 
> Kind regards,
> 
> Paul

> [    0.000000] Linux version 6.8.0-rc3 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #13 SMP PREEMPT_DYNAMIC Tue Feb  6 08:07:48 CET 2024
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0-rc3 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests initcall_debug
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000556aafff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000556ab000-0x00000000556abfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000556ac000-0x00000000556acfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000556ad000-0x0000000064df3fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000064df4000-0x000000006517ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000065180000-0x00000000651c3fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000651c4000-0x000000006f871fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000006f872000-0x000000006fffefff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x0000000077ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000078000000-0x00000000785fffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000078600000-0x000000007c7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004817fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] e820: update [mem 0x5152e018-0x5153e057] usable ==> usable
> [    0.000000] e820: update [mem 0x5152e018-0x5153e057] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000005152e017] usable
> [    0.000000] reserve setup_data: [mem 0x000000005152e018-0x000000005153e057] usable
> [    0.000000] reserve setup_data: [mem 0x000000005153e058-0x00000000556aafff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000556ab000-0x00000000556abfff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000556ac000-0x00000000556acfff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000556ad000-0x0000000064df3fff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000064df4000-0x000000006517ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000065180000-0x00000000651c3fff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x00000000651c4000-0x000000006f871fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000006f872000-0x000000006fffefff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000006ffff000-0x000000006fffffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000070000000-0x0000000077ffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000078000000-0x00000000785fffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000078600000-0x000000007c7fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000004817fffff] usable
> [    0.000000] efi: EFI v2.4 by American Megatrends
> [    0.000000] efi: ACPI=0x6518d000 ACPI 2.0=0x6518d000 SMBIOS=0xf0000 SMBIOS 3.0=0xf0020 TPMFinalLog=0x6f812000 ESRT=0x6fc86698 MEMATTR=0x62676018 INITRD=0x5577da98 TPMEventLog=0x5577e018 
> [    0.000000] efi: Remove mem34: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
> [    0.000000] efi: Not removing mem35: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
> [    0.000000] efi: Not removing mem36: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
> [    0.000000] efi: Not removing mem37: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
> [    0.000000] efi: Remove mem38: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [    0.000000] tsc: Detected 2900.000 MHz processor
> [    0.000000] tsc: Detected 2899.886 MHz TSC
> [    0.000849] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000851] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000859] last_pfn = 0x481800 max_arch_pfn = 0x400000000
> [    0.000863] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
> [    0.000865] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001192] last_pfn = 0x78600 max_arch_pfn = 0x400000000
> [    0.007728] esrt: Reserving ESRT space from 0x000000006fc86698 to 0x000000006fc866d0.
> [    0.007733] Using GB pages for direct mapping
> [    0.014086] printk: log_buf_len: 8388608 bytes
> [    0.014087] printk: early log buf free: 125328(95%)
> [    0.014088] Secure boot disabled
> [    0.014088] RAMDISK: [mem 0x5153f000-0x52767fff]
> [    0.014092] ACPI: Early table checksum verification disabled
> [    0.014095] ACPI: RSDP 0x000000006518D000 000024 (v02 DELL  )
> [    0.014099] ACPI: XSDT 0x000000006518D0C8 00010C (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.014104] ACPI: FACP 0x00000000651B2A48 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
> [    0.014109] ACPI: DSDT 0x000000006518D260 0257E7 (v02 DELL   CBX3     01072009 INTL 20160422)
> [    0.014112] ACPI: FACS 0x000000006F86F180 000040
> [    0.014114] ACPI: APIC 0x00000000651B2B58 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
> [    0.014116] ACPI: FPDT 0x00000000651B2BE0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.014119] ACPI: FIDT 0x00000000651B2C28 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.014121] ACPI: MCFG 0x00000000651B2CD8 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
> [    0.014124] ACPI: HPET 0x00000000651B2D18 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
> [    0.014127] ACPI: SSDT 0x00000000651B2D50 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
> [    0.014129] ACPI: BOOT 0x00000000651B30B0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.014132] ACPI: SSDT 0x00000000651B30D8 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
> [    0.014135] ACPI: HPET 0x00000000651B43A8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
> [    0.014137] ACPI: SSDT 0x00000000651B43E0 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
> [    0.014140] ACPI: UEFI 0x00000000651B5168 000042 (v01                 00000000      00000000)
> [    0.014143] ACPI: SSDT 0x00000000651B51B0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
> [    0.014145] ACPI: LPIT 0x00000000651B6090 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
> [    0.014148] ACPI: WSMT 0x00000000651B6128 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
> [    0.014150] ACPI: SSDT 0x00000000651B6150 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
> [    0.014153] ACPI: SSDT 0x00000000651B62B8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
> [    0.014156] ACPI: SSDT 0x00000000651B6558 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
> [    0.014158] ACPI: SSDT 0x00000000651B9560 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
> [    0.014161] ACPI: DBGP 0x00000000651B9640 000034 (v01 INTEL           00000002 MSFT 0000005F)
> [    0.014163] ACPI: DBG2 0x00000000651B9678 000054 (v00 INTEL           00000002 MSFT 0000005F)
> [    0.014166] ACPI: SSDT 0x00000000651B96D0 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
> [    0.014169] ACPI: SSDT 0x00000000651B9EB0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
> [    0.014171] ACPI: SLIC 0x00000000651C23A8 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
> [    0.014174] ACPI: NHLT 0x00000000651C2520 00002D (v00 INTEL  EDK2     00000002      01000013)
> [    0.014177] ACPI: BGRT 0x00000000651C2550 000038 (v00                 01072009 AMI  00010013)
> [    0.014179] ACPI: TPM2 0x00000000651C2588 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
> [    0.014182] ACPI: ASF! 0x00000000651C25C0 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
> [    0.014185] ACPI: DMAR 0x00000000651C2660 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
> [    0.014187] ACPI: Reserving FACP table memory at [mem 0x651b2a48-0x651b2b53]
> [    0.014188] ACPI: Reserving DSDT table memory at [mem 0x6518d260-0x651b2a46]
> [    0.014189] ACPI: Reserving FACS table memory at [mem 0x6f86f180-0x6f86f1bf]
> [    0.014189] ACPI: Reserving APIC table memory at [mem 0x651b2b58-0x651b2bdb]
> [    0.014190] ACPI: Reserving FPDT table memory at [mem 0x651b2be0-0x651b2c23]
> [    0.014190] ACPI: Reserving FIDT table memory at [mem 0x651b2c28-0x651b2cd3]
> [    0.014191] ACPI: Reserving MCFG table memory at [mem 0x651b2cd8-0x651b2d13]
> [    0.014192] ACPI: Reserving HPET table memory at [mem 0x651b2d18-0x651b2d4f]
> [    0.014192] ACPI: Reserving SSDT table memory at [mem 0x651b2d50-0x651b30a8]
> [    0.014193] ACPI: Reserving BOOT table memory at [mem 0x651b30b0-0x651b30d7]
> [    0.014194] ACPI: Reserving SSDT table memory at [mem 0x651b30d8-0x651b43a6]
> [    0.014194] ACPI: Reserving HPET table memory at [mem 0x651b43a8-0x651b43df]
> [    0.014195] ACPI: Reserving SSDT table memory at [mem 0x651b43e0-0x651b5163]
> [    0.014196] ACPI: Reserving UEFI table memory at [mem 0x651b5168-0x651b51a9]
> [    0.014196] ACPI: Reserving SSDT table memory at [mem 0x651b51b0-0x651b608d]
> [    0.014197] ACPI: Reserving LPIT table memory at [mem 0x651b6090-0x651b6123]
> [    0.014197] ACPI: Reserving WSMT table memory at [mem 0x651b6128-0x651b614f]
> [    0.014198] ACPI: Reserving SSDT table memory at [mem 0x651b6150-0x651b62b0]
> [    0.014199] ACPI: Reserving SSDT table memory at [mem 0x651b62b8-0x651b6556]
> [    0.014199] ACPI: Reserving SSDT table memory at [mem 0x651b6558-0x651b9559]
> [    0.014200] ACPI: Reserving SSDT table memory at [mem 0x651b9560-0x651b963a]
> [    0.014201] ACPI: Reserving DBGP table memory at [mem 0x651b9640-0x651b9673]
> [    0.014201] ACPI: Reserving DBG2 table memory at [mem 0x651b9678-0x651b96cb]
> [    0.014202] ACPI: Reserving SSDT table memory at [mem 0x651b96d0-0x651b9eac]
> [    0.014203] ACPI: Reserving SSDT table memory at [mem 0x651b9eb0-0x651c23a0]
> [    0.014203] ACPI: Reserving SLIC table memory at [mem 0x651c23a8-0x651c251d]
> [    0.014204] ACPI: Reserving NHLT table memory at [mem 0x651c2520-0x651c254c]
> [    0.014205] ACPI: Reserving BGRT table memory at [mem 0x651c2550-0x651c2587]
> [    0.014205] ACPI: Reserving TPM2 table memory at [mem 0x651c2588-0x651c25bb]
> [    0.014206] ACPI: Reserving ASF! table memory at [mem 0x651c25c0-0x651c265f]
> [    0.014206] ACPI: Reserving DMAR table memory at [mem 0x651c2660-0x651c274f]
> [    0.014333] No NUMA configuration found
> [    0.014334] Faking a node at [mem 0x0000000000000000-0x00000004817fffff]
> [    0.014341] NODE_DATA(0) allocated [mem 0x47f3d5000-0x47f3fffff]
> [    0.014523] Zone ranges:
> [    0.014524]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.014526]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.014527]   Normal   [mem 0x0000000100000000-0x00000004817fffff]
> [    0.014528]   Device   empty
> [    0.014529] Movable zone start for each node
> [    0.014531] Early memory node ranges
> [    0.014531]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.014535]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
> [    0.014536]   node   0: [mem 0x0000000000100000-0x00000000556aafff]
> [    0.014537]   node   0: [mem 0x00000000556ad000-0x0000000064df3fff]
> [    0.014538]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
> [    0.014539]   node   0: [mem 0x0000000078000000-0x00000000785fffff]
> [    0.014539]   node   0: [mem 0x0000000100000000-0x00000004817fffff]
> [    0.014541] Initmem setup node 0 [mem 0x0000000000001000-0x00000004817fffff]
> [    0.014545] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.014547] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.014569] On node 0, zone DMA: 98 pages in unavailable ranges
> [    0.016919] On node 0, zone DMA32: 2 pages in unavailable ranges
> [    0.017330] On node 0, zone DMA32: 45579 pages in unavailable ranges
> [    0.017842] On node 0, zone Normal: 31232 pages in unavailable ranges
> [    0.018267] On node 0, zone Normal: 26624 pages in unavailable ranges
> [    0.018275] Reserving Intel graphics memory at [mem 0x7a800000-0x7c7fffff]
> [    0.018457] ACPI: PM-Timer IO Port: 0x1808
> [    0.018463] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.018465] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.018465] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.018466] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.018492] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.018494] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.018496] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.018500] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.018501] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.018506] e820: update [mem 0x62262000-0x623eefff] usable ==> reserved
> [    0.018516] TSC deadline timer available
> [    0.018517] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.018532] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.018534] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
> [    0.018535] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]
> [    0.018536] PM: hibernation: Registered nosave memory: [mem 0x5152e000-0x5152efff]
> [    0.018538] PM: hibernation: Registered nosave memory: [mem 0x5153e000-0x5153efff]
> [    0.018539] PM: hibernation: Registered nosave memory: [mem 0x556ab000-0x556abfff]
> [    0.018540] PM: hibernation: Registered nosave memory: [mem 0x556ac000-0x556acfff]
> [    0.018541] PM: hibernation: Registered nosave memory: [mem 0x62262000-0x623eefff]
> [    0.018542] PM: hibernation: Registered nosave memory: [mem 0x64df4000-0x6517ffff]
> [    0.018543] PM: hibernation: Registered nosave memory: [mem 0x65180000-0x651c3fff]
> [    0.018544] PM: hibernation: Registered nosave memory: [mem 0x651c4000-0x6f871fff]
> [    0.018544] PM: hibernation: Registered nosave memory: [mem 0x6f872000-0x6fffefff]
> [    0.018546] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x77ffffff]
> [    0.018547] PM: hibernation: Registered nosave memory: [mem 0x78600000-0x7c7fffff]
> [    0.018547] PM: hibernation: Registered nosave memory: [mem 0x7c800000-0xfdffffff]
> [    0.018548] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.018549] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> [    0.018549] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.018550] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> [    0.018550] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.018551] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
> [    0.018552] [mem 0x7c800000-0xfdffffff] available for PCI devices
> [    0.018553] Booting paravirtualized kernel on bare hardware
> [    0.018555] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.023088] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.023378] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u524288
> [    0.023384] pcpu-alloc: s221184 r8192 d28672 u524288 alloc=1*2097152
> [    0.023386] pcpu-alloc: [0] 0 1 2 3 
> [    0.023402] Kernel command line: BOOT_IMAGE=/vmlinuz-6.8.0-rc3 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests initcall_debug
> [    0.023472] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.8.0-rc3", will be passed to user space.
> [    0.023505] random: crng init done
> [    0.024959] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.025717] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.025779] Fallback order for Node 0: 0 
> [    0.025782] Built 1 zonelists, mobility grouping on.  Total pages: 4026691
> [    0.025783] Policy zone: Normal
> [    0.025787] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.025794] software IO TLB: area num 4.
> [    0.043822] Memory: 1658144K/16363068K available (16384K kernel code, 2333K rwdata, 5900K rodata, 3984K init, 3660K bss, 493668K reserved, 0K cma-reserved)
> [    0.044007] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.044016] Kernel/User page tables isolation: enabled
> [    0.044047] ftrace: allocating 42666 entries in 167 pages
> [    0.051067] ftrace: allocated 167 pages with 5 groups
> [    0.051851] Dynamic Preempt: voluntary
> [    0.051877] rcu: Preemptible hierarchical RCU implementation.
> [    0.051878] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.051879] 	Trampoline variant of Tasks RCU enabled.
> [    0.051880] 	Rude variant of Tasks RCU enabled.
> [    0.051880] 	Tracing variant of Tasks RCU enabled.
> [    0.051880] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.051881] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.054225] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> [    0.054428] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.054599] spurious 8259A interrupt: IRQ7.
> [    0.054615] calling  con_init+0x0/0x250 @ 0
> [    0.054627] Console: colour dummy device 80x25
> [    0.054629] printk: legacy console [tty0] enabled
> [    0.054648] initcall con_init+0x0/0x250 returned 0 after 0 usecs
> [    0.054651] calling  hvc_console_init+0x0/0x20 @ 0
> [    0.054654] initcall hvc_console_init+0x0/0x20 returned 0 after 0 usecs
> [    0.054656] calling  xen_cons_init+0x0/0x60 @ 0
> [    0.054658] initcall xen_cons_init+0x0/0x60 returned 0 after 0 usecs
> [    0.054660] calling  univ8250_console_init+0x0/0x40 @ 0
> [    0.054663] initcall univ8250_console_init+0x0/0x40 returned 0 after 0 usecs
> [    0.054679] ACPI: Core revision 20230628
> [    0.054822] hpet: HPET dysfunctional in PC10. Force disabled.
> [    0.054823] APIC: Switch to symmetric I/O mode setup
> [    0.054825] DMAR: Host address width 39
> [    0.054826] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.054831] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.054833] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.054836] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.054838] DMAR: RMRR base: 0x00000064ec2000 end: 0x00000064ee1fff
> [    0.054839] DMAR: RMRR base: 0x0000007a000000 end: 0x0000007c7fffff
> [    0.054840] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
> [    0.054841] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
> [    0.054843] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.054844] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.054845] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.056461] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.056463] x2apic enabled
> [    0.056522] APIC: Switched APIC routing to: cluster x2apic
> [    0.060382] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
> [    0.060396] Calibrating delay loop (skipped), value calculated using timer frequency.. 5799.77 BogoMIPS (lpj=11599544)
> [    0.060425] CPU0: Thermal monitoring enabled (TM1)
> [    0.060458] process: using mwait in idle threads
> [    0.060461] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.060462] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.060466] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.060468] Spectre V2 : Mitigation: IBRS
> [    0.060468] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.060469] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> [    0.060470] RETBleed: Mitigation: IBRS
> [    0.060471] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.060472] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.060474] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.060481] MDS: Mitigation: Clear CPU buffers
> [    0.060482] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    0.060486] SRBDS: Mitigation: Microcode
> [    0.060492] GDS: Mitigation: Microcode
> [    0.060497] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.060499] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.060500] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.060501] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.060502] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.060503] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.060505] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.060506] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.060507] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.064391] Freeing SMP alternatives memory: 36K
> [    0.064391] pid_max: default: 32768 minimum: 301
> [    0.064391] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,integrity
> [    0.064391] landlock: Up and running.
> [    0.064391] Yama: becoming mindful.
> [    0.064391] AppArmor: AppArmor initialized
> [    0.064391] TOMOYO Linux initialized
> [    0.064391] LSM support for eBPF active
> [    0.064391] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.064391] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.064391] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
> [    0.064391] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064391] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064391] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064391] calling  init_hw_perf_events+0x0/0x6e0 @ 1
> [    0.064391] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.064391] ... version:                4
> [    0.064391] ... bit width:              48
> [    0.064391] ... generic registers:      4
> [    0.064391] ... value mask:             0000ffffffffffff
> [    0.064391] ... max period:             00007fffffffffff
> [    0.064391] ... fixed-purpose events:   3
> [    0.064391] ... event mask:             000000070000000f
> [    0.064391] initcall init_hw_perf_events+0x0/0x6e0 returned 0 after 0 usecs
> [    0.064391] calling  do_init_real_mode+0x0/0x20 @ 1
> [    0.064391] initcall do_init_real_mode+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  init_sigframe_size+0x0/0x40 @ 1
> [    0.064391] signal: max sigframe size: 2032
> [    0.064391] initcall init_sigframe_size+0x0/0x40 returned 0 after 0 usecs
> [    0.064391] calling  trace_init_perf_perm_irq_work_exit+0x0/0x20 @ 1
> [    0.064391] initcall trace_init_perf_perm_irq_work_exit+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  cache_ap_register+0x0/0x60 @ 1
> [    0.064391] initcall cache_ap_register+0x0/0x60 returned 0 after 0 usecs
> [    0.064391] calling  bp_init_aperfmperf+0x0/0x320 @ 1
> [    0.064391] Estimated ratio of average max frequency by base frequency (times 1024): 1235
> [    0.064391] initcall bp_init_aperfmperf+0x0/0x320 returned 0 after 0 usecs
> [    0.064391] calling  save_builtin_microcode+0x0/0xf0 @ 1
> [    0.064391] initcall save_builtin_microcode+0x0/0xf0 returned 0 after 0 usecs
> [    0.064391] calling  save_microcode_in_initrd+0x0/0x110 @ 1
> [    0.064391] initcall save_microcode_in_initrd+0x0/0x110 returned 0 after 0 usecs
> [    0.064391] calling  smp_init_primary_thread_mask+0x0/0xc0 @ 1
> [    0.064391] initcall smp_init_primary_thread_mask+0x0/0xc0 returned 0 after 0 usecs
> [    0.064391] calling  register_nmi_cpu_backtrace_handler+0x0/0x20 @ 1
> [    0.064391] initcall register_nmi_cpu_backtrace_handler+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  kvm_setup_vsyscall_timeinfo+0x0/0x160 @ 1
> [    0.064391] initcall kvm_setup_vsyscall_timeinfo+0x0/0x160 returned 0 after 0 usecs
> [    0.064391] calling  spawn_ksoftirqd+0x0/0x50 @ 1
> [    0.064391] initcall spawn_ksoftirqd+0x0/0x50 returned 0 after 0 usecs
> [    0.064391] calling  init_signal_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_signal_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  init_umh_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_umh_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  migration_init+0x0/0x50 @ 1
> [    0.064391] initcall migration_init+0x0/0x50 returned 0 after 0 usecs
> [    0.064391] calling  srcu_bootup_announce+0x0/0x80 @ 1
> [    0.064391] rcu: Hierarchical SRCU implementation.
> [    0.064391] rcu: 	Max phase no-delay instances is 1000.
> [    0.064391] initcall srcu_bootup_announce+0x0/0x80 returned 0 after 0 usecs
> [    0.064391] calling  rcu_spawn_gp_kthread+0x0/0x1c0 @ 1
> [    0.064391] initcall rcu_spawn_gp_kthread+0x0/0x1c0 returned 0 after 0 usecs
> [    0.064391] calling  check_cpu_stall_init+0x0/0x30 @ 1
> [    0.064391] initcall check_cpu_stall_init+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  rcu_sysrq_init+0x0/0x30 @ 1
> [    0.064391] initcall rcu_sysrq_init+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  trace_init_flags_sys_enter+0x0/0x20 @ 1
> [    0.064391] initcall trace_init_flags_sys_enter+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  trace_init_flags_sys_exit+0x0/0x20 @ 1
> [    0.064391] initcall trace_init_flags_sys_exit+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  insert_crashkernel_resources+0x0/0x70 @ 1
> [    0.064391] initcall insert_crashkernel_resources+0x0/0x70 returned 0 after 0 usecs
> [    0.064391] calling  cpu_stop_init+0x0/0xa0 @ 1
> [    0.064391] initcall cpu_stop_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.064391] calling  init_kprobes+0x0/0x1c0 @ 1
> [    0.064391] initcall init_kprobes+0x0/0x1c0 returned 0 after 0 usecs
> [    0.064391] calling  init_trace_printk+0x0/0x10 @ 1
> [    0.064391] initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
> [    0.064391] calling  event_trace_enable_again+0x0/0x50 @ 1
> [    0.064391] initcall event_trace_enable_again+0x0/0x50 returned 0 after 0 usecs
> [    0.064391] calling  irq_work_init_threads+0x0/0x10 @ 1
> [    0.064391] initcall irq_work_init_threads+0x0/0x10 returned 0 after 0 usecs
> [    0.064391] calling  static_call_init+0x0/0xa0 @ 1
> [    0.064391] initcall static_call_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.064391] calling  jump_label_init_module+0x0/0x20 @ 1
> [    0.064391] initcall jump_label_init_module+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] calling  init_zero_pfn+0x0/0x50 @ 1
> [    0.064391] initcall init_zero_pfn+0x0/0x50 returned 0 after 0 usecs
> [    0.064391] calling  init_fs_inode_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_fs_inode_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  init_fs_locks_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_fs_locks_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  init_fs_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_fs_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  init_security_keys_sysctls+0x0/0x30 @ 1
> [    0.064391] initcall init_security_keys_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.064391] calling  dynamic_debug_init+0x0/0x2f0 @ 1
> [    0.064391] initcall dynamic_debug_init+0x0/0x2f0 returned 0 after 0 usecs
> [    0.064391] calling  unpopulated_init+0x0/0x60 @ 1
> [    0.064391] initcall unpopulated_init+0x0/0x60 returned -19 after 0 usecs
> [    0.064391] calling  efi_memreserve_root_init+0x0/0x60 @ 1
> [    0.064391] initcall efi_memreserve_root_init+0x0/0x60 returned 0 after 0 usecs
> [    0.064391] calling  efi_earlycon_remap_fb+0x0/0x70 @ 1
> [    0.064391] initcall efi_earlycon_remap_fb+0x0/0x70 returned 0 after 0 usecs
> [    0.064391] calling  idle_inject_init+0x0/0x20 @ 1
> [    0.064391] initcall idle_inject_init+0x0/0x20 returned 0 after 0 usecs
> [    0.064391] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.064391] smp: Bringing up secondary CPUs ...
> [    0.064391] smpboot: x86: Booting SMP configuration:
> [    0.064391] .... node  #0, CPUs:      #1 #2 #3
> [    0.064391] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.064391] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
> [    0.064391] smp: Brought up 1 node, 4 CPUs
> [    0.064391] smpboot: Max logical packages: 1
> [    0.064391] smpboot: Total of 4 processors activated (23199.08 BogoMIPS)
> [    0.085208] node 0 deferred pages initialised in 20ms
> [    0.086270] devtmpfs: initialized
> [    0.086270] x86/mm: Memory block size: 128MB
> [    0.086270] calling  bpf_jit_charge_init+0x0/0x50 @ 1
> [    0.086270] initcall bpf_jit_charge_init+0x0/0x50 returned 0 after 0 usecs
> [    0.086270] calling  ipc_ns_init+0x0/0x50 @ 1
> [    0.086270] initcall ipc_ns_init+0x0/0x50 returned 0 after 0 usecs
> [    0.086270] calling  init_mmap_min_addr+0x0/0x30 @ 1
> [    0.086270] initcall init_mmap_min_addr+0x0/0x30 returned 0 after 0 usecs
> [    0.086270] calling  pci_realloc_setup_params+0x0/0x70 @ 1
> [    0.086270] initcall pci_realloc_setup_params+0x0/0x70 returned 0 after 0 usecs
> [    0.086270] calling  inet_frag_wq_init+0x0/0x50 @ 1
> [    0.088402] initcall inet_frag_wq_init+0x0/0x50 returned 0 after 4000 usecs
> [    0.088425] calling  xen_pvh_gnttab_setup+0x0/0x40 @ 1
> [    0.088428] initcall xen_pvh_gnttab_setup+0x0/0x40 returned -19 after 0 usecs
> [    0.088430] calling  e820__register_nvs_regions+0x0/0x60 @ 1
> [    0.088433] ACPI: PM: Registering ACPI NVS region [mem 0x556ab000-0x556abfff] (4096 bytes)
> [    0.088435] ACPI: PM: Registering ACPI NVS region [mem 0x651c4000-0x6f871fff] (174776320 bytes)
> [    0.090476] initcall e820__register_nvs_regions+0x0/0x60 returned 0 after 0 usecs
> [    0.090480] calling  cpufreq_register_tsc_scaling+0x0/0x40 @ 1
> [    0.090482] initcall cpufreq_register_tsc_scaling+0x0/0x40 returned 0 after 0 usecs
> [    0.090484] calling  reboot_init+0x0/0x50 @ 1
> [    0.090490] initcall reboot_init+0x0/0x50 returned 0 after 0 usecs
> [    0.090492] calling  init_lapic_sysfs+0x0/0x30 @ 1
> [    0.090495] initcall init_lapic_sysfs+0x0/0x30 returned 0 after 0 usecs
> [    0.090496] calling  alloc_frozen_cpus+0x0/0x30 @ 1
> [    0.090498] initcall alloc_frozen_cpus+0x0/0x30 returned 0 after 0 usecs
> [    0.090500] calling  cpu_hotplug_pm_sync_init+0x0/0x20 @ 1
> [    0.090502] initcall cpu_hotplug_pm_sync_init+0x0/0x20 returned 0 after 0 usecs
> [    0.090504] calling  wq_sysfs_init+0x0/0x90 @ 1
> [    0.090519] initcall wq_sysfs_init+0x0/0x90 returned 0 after 0 usecs
> [    0.090521] calling  ksysfs_init+0x0/0xb0 @ 1
> [    0.090528] initcall ksysfs_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.090530] calling  schedutil_gov_init+0x0/0x20 @ 1
> [    0.090533] initcall schedutil_gov_init+0x0/0x20 returned 0 after 0 usecs
> [    0.090535] calling  pm_init+0x0/0x80 @ 1
> [    0.090552] initcall pm_init+0x0/0x80 returned 0 after 0 usecs
> [    0.090555] calling  pm_disk_init+0x0/0x20 @ 1
> [    0.090559] initcall pm_disk_init+0x0/0x20 returned 0 after 0 usecs
> [    0.090561] calling  swsusp_header_init+0x0/0x40 @ 1
> [    0.090565] initcall swsusp_header_init+0x0/0x40 returned 0 after 0 usecs
> [    0.090567] calling  rcu_set_runtime_mode+0x0/0x20 @ 1
> [    0.090569] initcall rcu_set_runtime_mode+0x0/0x20 returned 0 after 0 usecs
> [    0.090570] calling  init_jiffies_clocksource+0x0/0x20 @ 1
> [    0.090573] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.090575] initcall init_jiffies_clocksource+0x0/0x20 returned 0 after 0 usecs
> [    0.090578] calling  futex_init+0x0/0xf0 @ 1
> [    0.090584] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.090588] initcall futex_init+0x0/0xf0 returned 0 after 0 usecs
> [    0.090590] calling  cgroup_wq_init+0x0/0x40 @ 1
> [    0.090594] initcall cgroup_wq_init+0x0/0x40 returned 0 after 0 usecs
> [    0.090596] calling  cgroup1_wq_init+0x0/0x40 @ 1
> [    0.090600] initcall cgroup1_wq_init+0x0/0x40 returned 0 after 0 usecs
> [    0.090602] calling  ftrace_mod_cmd_init+0x0/0x10 @ 1
> [    0.090605] initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs
> [    0.090606] calling  init_graph_trace+0x0/0x70 @ 1
> [    0.090611] initcall init_graph_trace+0x0/0x70 returned 0 after 0 usecs
> [    0.090613] calling  trace_events_eprobe_init_early+0x0/0x40 @ 1
> [    0.090616] initcall trace_events_eprobe_init_early+0x0/0x40 returned 0 after 0 usecs
> [    0.090618] calling  trace_events_synth_init_early+0x0/0x40 @ 1
> [    0.090621] initcall trace_events_synth_init_early+0x0/0x40 returned 0 after 0 usecs
> [    0.090623] calling  init_kprobe_trace_early+0x0/0x40 @ 1
> [    0.090625] initcall init_kprobe_trace_early+0x0/0x40 returned 0 after 0 usecs
> [    0.090628] calling  init_fprobe_trace_early+0x0/0x30 @ 1
> [    0.090631] initcall init_fprobe_trace_early+0x0/0x30 returned 0 after 0 usecs
> [    0.090633] calling  bpf_offload_init+0x0/0x20 @ 1
> [    0.090636] initcall bpf_offload_init+0x0/0x20 returned 0 after 0 usecs
> [    0.090638] calling  memory_failure_init+0x0/0xd0 @ 1
> [    0.090643] initcall memory_failure_init+0x0/0xd0 returned 0 after 0 usecs
> [    0.090645] calling  fsnotify_init+0x0/0x60 @ 1
> [    0.090658] initcall fsnotify_init+0x0/0x60 returned 0 after 0 usecs
> [    0.090661] calling  filelock_init+0x0/0xb0 @ 1
> [    0.090667] initcall filelock_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.090669] calling  init_script_binfmt+0x0/0x20 @ 1
> [    0.090672] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs
> [    0.090675] calling  init_elf_binfmt+0x0/0x20 @ 1
> [    0.090676] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
> [    0.090677] calling  init_compat_elf_binfmt+0x0/0x20 @ 1
> [    0.090679] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
> [    0.090680] calling  debugfs_init+0x0/0x90 @ 1
> [    0.090683] initcall debugfs_init+0x0/0x90 returned 0 after 0 usecs
> [    0.090685] calling  tracefs_init+0x0/0x80 @ 1
> [    0.090689] initcall tracefs_init+0x0/0x80 returned 0 after 0 usecs
> [    0.090691] calling  securityfs_init+0x0/0x80 @ 1
> [    0.090707] initcall securityfs_init+0x0/0x80 returned 0 after 0 usecs
> [    0.090710] calling  lockdown_secfs_init+0x0/0x40 @ 1
> [    0.090714] initcall lockdown_secfs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.090716] calling  pinctrl_init+0x0/0xc0 @ 1
> [    0.090720] pinctrl core: initialized pinctrl subsystem
> [    0.090734] initcall pinctrl_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.090737] calling  gpiolib_dev_init+0x0/0x110 @ 1
> [    0.090749] initcall gpiolib_dev_init+0x0/0x110 returned 0 after 0 usecs
> [    0.090751] calling  virtio_init+0x0/0x30 @ 1
> [    0.090757] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
> [    0.090759] calling  regulator_init+0x0/0x110 @ 1
> [    0.090780] initcall regulator_init+0x0/0x110 returned 0 after 0 usecs
> [    0.090783] calling  iommu_init+0x0/0x40 @ 1
> [    0.090786] initcall iommu_init+0x0/0x40 returned 0 after 0 usecs
> [    0.090788] calling  component_debug_init+0x0/0x30 @ 1
> [    0.090792] initcall component_debug_init+0x0/0x30 returned 0 after 0 usecs
> [    0.090794] calling  opp_debug_init+0x0/0x30 @ 1
> [    0.090797] initcall opp_debug_init+0x0/0x30 returned 0 after 0 usecs
> [    0.090798] calling  cpufreq_core_init+0x0/0xe0 @ 1
> [    0.090801] initcall cpufreq_core_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.090803] calling  cpufreq_gov_performance_init+0x0/0x20 @ 1
> [    0.090805] initcall cpufreq_gov_performance_init+0x0/0x20 returned 0 after 0 usecs
> [    0.090806] calling  cpuidle_init+0x0/0x30 @ 1
> [    0.090812] initcall cpuidle_init+0x0/0x30 returned 0 after 0 usecs
> [    0.090813] calling  unaccepted_memory_init_kdump+0x0/0x20 @ 1
> [    0.090816] initcall unaccepted_memory_init_kdump+0x0/0x20 returned 0 after 0 usecs
> [    0.090819] calling  sock_init+0x0/0xb0 @ 1
> [    0.090778] probe of reg-dummy returned 0 after 0 usecs
> [    0.091234] initcall sock_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.091238] calling  net_inuse_init+0x0/0x30 @ 1
> [    0.091240] initcall net_inuse_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091242] calling  net_defaults_init+0x0/0x50 @ 1
> [    0.091243] initcall net_defaults_init+0x0/0x50 returned 0 after 0 usecs
> [    0.091245] calling  init_default_flow_dissectors+0x0/0x60 @ 1
> [    0.091246] initcall init_default_flow_dissectors+0x0/0x60 returned 0 after 0 usecs
> [    0.091248] calling  netlink_proto_init+0x0/0x200 @ 1
> [    0.091258] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.091268] initcall netlink_proto_init+0x0/0x200 returned 0 after 0 usecs
> [    0.091270] calling  genl_init+0x0/0x50 @ 1
> [    0.091274] initcall genl_init+0x0/0x50 returned 0 after 0 usecs
> [    0.091275] calling  bsp_pm_check_init+0x0/0x20 @ 1
> [    0.091279] initcall bsp_pm_check_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091281] calling  __gnttab_init+0x0/0x40 @ 1
> [    0.091283] initcall __gnttab_init+0x0/0x40 returned -19 after 0 usecs
> [    0.091316] calling  irq_sysfs_init+0x0/0xe0 @ 1
> [    0.091391] initcall irq_sysfs_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.091393] calling  dma_atomic_pool_init+0x0/0x160 @ 1
> [    0.091493] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.091614] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.091740] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.091751] initcall dma_atomic_pool_init+0x0/0x160 returned 0 after 0 usecs
> [    0.091756] calling  audit_init+0x0/0x180 @ 1
> [    0.091763] audit: initializing netlink subsys (disabled)
> [    0.091779] initcall audit_init+0x0/0x180 returned 0 after 0 usecs
> [    0.091779] audit: type=2000 audit(1707252202.028:1): state=initialized audit_enabled=0 res=1
> [    0.091779] calling  release_early_probes+0x0/0x50 @ 1
> [    0.091779] initcall release_early_probes+0x0/0x50 returned 0 after 0 usecs
> [    0.091779] calling  bdi_class_init+0x0/0x40 @ 1
> [    0.091779] initcall bdi_class_init+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  mm_sysfs_init+0x0/0x40 @ 1
> [    0.091779] initcall mm_sysfs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  init_per_zone_wmark_min+0x0/0x30 @ 1
> [    0.091779] initcall init_per_zone_wmark_min+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  mpi_init+0x0/0x80 @ 1
> [    0.091779] initcall mpi_init+0x0/0x80 returned 0 after 0 usecs
> [    0.091779] calling  gpiolib_sysfs_init+0x0/0xb0 @ 1
> [    0.091779] initcall gpiolib_sysfs_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.091779] calling  acpi_gpio_setup_params+0x0/0xf0 @ 1
> [    0.091779] initcall acpi_gpio_setup_params+0x0/0xf0 returned 0 after 0 usecs
> [    0.091779] calling  pcibus_class_init+0x0/0x20 @ 1
> [    0.091779] initcall pcibus_class_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  pci_driver_init+0x0/0x30 @ 1
> [    0.091779] initcall pci_driver_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  backlight_class_init+0x0/0xb0 @ 1
> [    0.091779] initcall backlight_class_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.091779] calling  xenbus_init+0x0/0x470 @ 1
> [    0.091779] initcall xenbus_init+0x0/0x470 returned -19 after 0 usecs
> [    0.091779] calling  tty_class_init+0x0/0x20 @ 1
> [    0.091779] initcall tty_class_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  vtconsole_class_init+0x0/0xc0 @ 1
> [    0.091779] initcall vtconsole_class_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.091779] calling  serdev_init+0x0/0x30 @ 1
> [    0.091779] initcall serdev_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  iommu_dev_init+0x0/0x20 @ 1
> [    0.091779] initcall iommu_dev_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  mipi_dsi_bus_init+0x0/0x20 @ 1
> [    0.091779] initcall mipi_dsi_bus_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  devlink_class_init+0x0/0x60 @ 1
> [    0.091779] initcall devlink_class_init+0x0/0x60 returned 0 after 0 usecs
> [    0.091779] calling  software_node_init+0x0/0x40 @ 1
> [    0.091779] initcall software_node_init+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  wakeup_sources_debugfs_init+0x0/0x30 @ 1
> [    0.091779] initcall wakeup_sources_debugfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  wakeup_sources_sysfs_init+0x0/0x30 @ 1
> [    0.091779] initcall wakeup_sources_sysfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  regmap_initcall+0x0/0x20 @ 1
> [    0.091779] initcall regmap_initcall+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  syscon_init+0x0/0x20 @ 1
> [    0.091779] initcall syscon_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  spi_init+0x0/0xa0 @ 1
> [    0.091779] initcall spi_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.091779] calling  i2c_init+0x0/0xf0 @ 1
> [    0.091779] initcall i2c_init+0x0/0xf0 returned 0 after 0 usecs
> [    0.091779] calling  thermal_init+0x0/0x170 @ 1
> [    0.091779] thermal_sys: Registered thermal governor 'fair_share'
> [    0.091779] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.091779] thermal_sys: Registered thermal governor 'step_wise'
> [    0.091779] thermal_sys: Registered thermal governor 'user_space'
> [    0.091779] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.091779] initcall thermal_init+0x0/0x170 returned 0 after 0 usecs
> [    0.091779] calling  init_ladder+0x0/0x30 @ 1
> [    0.091779] cpuidle: using governor ladder
> [    0.091779] initcall init_ladder+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  init_menu+0x0/0x20 @ 1
> [    0.091779] cpuidle: using governor menu
> [    0.091779] initcall init_menu+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  init_haltpoll+0x0/0x30 @ 1
> [    0.091779] initcall init_haltpoll+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  pcc_init+0x0/0xb0 @ 1
> [    0.091779] initcall pcc_init+0x0/0xb0 returned -19 after 0 usecs
> [    0.091779] calling  amd_postcore_init+0x0/0x130 @ 1
> [    0.091779] initcall amd_postcore_init+0x0/0x130 returned 0 after 0 usecs
> [    0.091779] calling  kobject_uevent_init+0x0/0x10 @ 1
> [    0.091779] initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
> [    0.091779] calling  bts_init+0x0/0xd0 @ 1
> [    0.091779] initcall bts_init+0x0/0xd0 returned -19 after 0 usecs
> [    0.091779] calling  pt_init+0x0/0x3b0 @ 1
> [    0.091779] initcall pt_init+0x0/0x3b0 returned 0 after 0 usecs
> [    0.091779] calling  boot_params_ksysfs_init+0x0/0x300 @ 1
> [    0.091779] initcall boot_params_ksysfs_init+0x0/0x300 returned 0 after 0 usecs
> [    0.091779] calling  sbf_init+0x0/0x110 @ 1
> [    0.091779] Simple Boot Flag at 0x47 set to 0x80
> [    0.091779] initcall sbf_init+0x0/0x110 returned 0 after 0 usecs
> [    0.091779] calling  arch_kdebugfs_init+0x0/0x30 @ 1
> [    0.091779] initcall arch_kdebugfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  xfd_update_static_branch+0x0/0x30 @ 1
> [    0.091779] initcall xfd_update_static_branch+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  intel_pconfig_init+0x0/0x110 @ 1
> [    0.091779] initcall intel_pconfig_init+0x0/0x110 returned 0 after 0 usecs
> [    0.091779] calling  mtrr_if_init+0x0/0x70 @ 1
> [    0.091779] initcall mtrr_if_init+0x0/0x70 returned 0 after 0 usecs
> [    0.091779] calling  activate_jump_labels+0x0/0x50 @ 1
> [    0.091779] initcall activate_jump_labels+0x0/0x50 returned 0 after 0 usecs
> [    0.091779] calling  init_s4_sigcheck+0x0/0x40 @ 1
> [    0.091779] initcall init_s4_sigcheck+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  ffh_cstate_init+0x0/0x40 @ 1
> [    0.091779] initcall ffh_cstate_init+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  kvm_alloc_cpumask+0x0/0xd0 @ 1
> [    0.091779] initcall kvm_alloc_cpumask+0x0/0xd0 returned 0 after 0 usecs
> [    0.091779] calling  activate_jump_labels+0x0/0x50 @ 1
> [    0.091779] initcall activate_jump_labels+0x0/0x50 returned 0 after 0 usecs
> [    0.091779] calling  report_cpuid_table+0x0/0xa0 @ 1
> [    0.091779] initcall report_cpuid_table+0x0/0xa0 returned 0 after 0 usecs
> [    0.091779] calling  gigantic_pages_init+0x0/0x30 @ 1
> [    0.091779] initcall gigantic_pages_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  kcmp_cookies_init+0x0/0x50 @ 1
> [    0.091779] initcall kcmp_cookies_init+0x0/0x50 returned 0 after 0 usecs
> [    0.091779] calling  cryptomgr_init+0x0/0x20 @ 1
> [    0.091779] initcall cryptomgr_init+0x0/0x20 returned 0 after 0 usecs
> [    0.091779] calling  acpi_pci_init+0x0/0x60 @ 1
> [    0.091779] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.091779] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.091779] initcall acpi_pci_init+0x0/0x60 returned 0 after 0 usecs
> [    0.091779] calling  dma_channel_table_init+0x0/0x120 @ 1
> [    0.091779] initcall dma_channel_table_init+0x0/0x120 returned 0 after 0 usecs
> [    0.091779] calling  dma_bus_init+0x0/0xf0 @ 1
> [    0.091779] initcall dma_bus_init+0x0/0xf0 returned 0 after 0 usecs
> [    0.091779] calling  register_xen_pci_notifier+0x0/0x40 @ 1
> [    0.091779] initcall register_xen_pci_notifier+0x0/0x40 returned 0 after 0 usecs
> [    0.091779] calling  xen_pcpu_init+0x0/0xd0 @ 1
> [    0.091779] initcall xen_pcpu_init+0x0/0xd0 returned -19 after 0 usecs
> [    0.091779] calling  serial_base_init+0x0/0x80 @ 1
> [    0.091779] initcall serial_base_init+0x0/0x80 returned 0 after 0 usecs
> [    0.091779] calling  iommu_dma_init+0x0/0x30 @ 1
> [    0.091779] initcall iommu_dma_init+0x0/0x30 returned 0 after 0 usecs
> [    0.091779] calling  dmi_id_init+0x0/0x3e0 @ 1
> [    0.091779] initcall dmi_id_init+0x0/0x3e0 returned 0 after 0 usecs
> [    0.091779] calling  pci_arch_init+0x0/0x90 @ 1
> [    0.091779] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.091779] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
> [    0.091779] PCI: Using configuration type 1 for base access
> [    0.091779] initcall pci_arch_init+0x0/0x90 returned 0 after 0 usecs
> [    0.092416] calling  init_vdso_image_64+0x0/0x20 @ 1
> [    0.092429] initcall init_vdso_image_64+0x0/0x20 returned 0 after 0 usecs
> [    0.092431] calling  init_vdso_image_x32+0x0/0x20 @ 1
> [    0.092438] initcall init_vdso_image_x32+0x0/0x20 returned 0 after 0 usecs
> [    0.092440] calling  init_vdso_image_32+0x0/0x20 @ 1
> [    0.092449] initcall init_vdso_image_32+0x0/0x20 returned 0 after 0 usecs
> [    0.092451] calling  fixup_ht_bug+0x0/0x120 @ 1
> [    0.092453] initcall fixup_ht_bug+0x0/0x120 returned 0 after 0 usecs
> [    0.092455] calling  mtrr_init_finalize+0x0/0x40 @ 1
> [    0.092458] initcall mtrr_init_finalize+0x0/0x40 returned 0 after 0 usecs
> [    0.092460] calling  blake2s_mod_init+0x0/0x80 @ 1
> [    0.092474] initcall blake2s_mod_init+0x0/0x80 returned 0 after 0 usecs
> [    0.092477] calling  uid_cache_init+0x0/0xc0 @ 1
> [    0.092483] initcall uid_cache_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.092484] calling  param_sysfs_init+0x0/0x60 @ 1
> [    0.092487] initcall param_sysfs_init+0x0/0x60 returned 0 after 0 usecs
> [    0.092489] calling  user_namespace_sysctl_init+0x0/0xd0 @ 1
> [    0.092499] initcall user_namespace_sysctl_init+0x0/0xd0 returned 0 after 0 usecs
> [    0.092501] calling  proc_schedstat_init+0x0/0x30 @ 1
> [    0.092505] initcall proc_schedstat_init+0x0/0x30 returned 0 after 0 usecs
> [    0.092507] calling  pm_sysrq_init+0x0/0x30 @ 1
> [    0.092514] initcall pm_sysrq_init+0x0/0x30 returned 0 after 0 usecs
> [    0.092517] calling  create_proc_profile+0x0/0xe0 @ 1
> [    0.092519] initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
> [    0.092522] calling  crash_save_vmcoreinfo_init+0x0/0x710 @ 1
> [    0.092551] initcall crash_save_vmcoreinfo_init+0x0/0x710 returned 0 after 0 usecs
> [    0.092553] calling  crash_notes_memory_init+0x0/0x50 @ 1
> [    0.092556] initcall crash_notes_memory_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092559] calling  crash_hotplug_init+0x0/0x40 @ 1
> [    0.092561] initcall crash_hotplug_init+0x0/0x40 returned 66 after 0 usecs
> [    0.092564] calling  cgroup_sysfs_init+0x0/0x20 @ 1
> [    0.092567] initcall cgroup_sysfs_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092570] calling  user_namespaces_init+0x0/0x40 @ 1
> [    0.092575] initcall user_namespaces_init+0x0/0x40 returned 0 after 0 usecs
> [    0.092577] calling  init_optprobes+0x0/0x40 @ 1
> [    0.092582] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.092585] initcall init_optprobes+0x0/0x40 returned 0 after 0 usecs
> [    0.092587] calling  hung_task_init+0x0/0x90 @ 1
> [    0.092593] initcall hung_task_init+0x0/0x90 returned 0 after 0 usecs
> [    0.092593] calling  ftrace_check_for_weak_functions+0x0/0x70 @ 1
> [    0.092593] initcall ftrace_check_for_weak_functions+0x0/0x70 returned 0 after 0 usecs
> [    0.092593] calling  trace_eval_init+0x0/0xb0 @ 1
> [    0.092593] initcall trace_eval_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.092593] calling  send_signal_irq_work_init+0x0/0x70 @ 1
> [    0.092593] initcall send_signal_irq_work_init+0x0/0x70 returned 0 after 0 usecs
> [    0.092593] calling  dev_map_init+0x0/0x60 @ 1
> [    0.092593] initcall dev_map_init+0x0/0x60 returned 0 after 0 usecs
> [    0.092593] calling  cpu_map_init+0x0/0x60 @ 1
> [    0.092593] initcall cpu_map_init+0x0/0x60 returned 0 after 0 usecs
> [    0.092593] calling  netns_bpf_init+0x0/0x20 @ 1
> [    0.092593] initcall netns_bpf_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092593] calling  oom_init+0x0/0x60 @ 1
> [    0.092593] initcall oom_init+0x0/0x60 returned 0 after 0 usecs
> [    0.092593] calling  default_bdi_init+0x0/0x40 @ 1
> [    0.092593] initcall default_bdi_init+0x0/0x40 returned 0 after 0 usecs
> [    0.092593] calling  cgwb_init+0x0/0x40 @ 1
> [    0.092593] initcall cgwb_init+0x0/0x40 returned 0 after 0 usecs
> [    0.092593] calling  percpu_enable_async+0x0/0x20 @ 1
> [    0.092593] initcall percpu_enable_async+0x0/0x20 returned 0 after 0 usecs
> [    0.092593] calling  kcompactd_init+0x0/0xb0 @ 1
> [    0.092593] initcall kcompactd_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.092593] calling  init_user_reserve+0x0/0x40 @ 1
> [    0.092593] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
> [    0.092593] calling  init_admin_reserve+0x0/0x40 @ 1
> [    0.092593] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
> [    0.092593] calling  init_reserve_notifier+0x0/0x30 @ 1
> [    0.092593] initcall init_reserve_notifier+0x0/0x30 returned 0 after 0 usecs
> [    0.092593] calling  swap_init_sysfs+0x0/0x80 @ 1
> [    0.092593] initcall swap_init_sysfs+0x0/0x80 returned 0 after 0 usecs
> [    0.092593] calling  swapfile_init+0x0/0xd0 @ 1
> [    0.092593] initcall swapfile_init+0x0/0xd0 returned 0 after 0 usecs
> [    0.092593] calling  hugetlb_init+0x0/0x760 @ 1
> [    0.092593] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.092593] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.092593] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.092593] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.092593] initcall hugetlb_init+0x0/0x760 returned 0 after 0 usecs
> [    0.092593] calling  ksm_init+0x0/0x1c0 @ 1
> [    0.092593] initcall ksm_init+0x0/0x1c0 returned 0 after 0 usecs
> [    0.092593] calling  memory_tier_init+0x0/0x160 @ 1
> [    0.092690] initcall memory_tier_init+0x0/0x160 returned 0 after 0 usecs
> [    0.092690] calling  numa_init_sysfs+0x0/0x80 @ 1
> [    0.092690] initcall numa_init_sysfs+0x0/0x80 returned 0 after 0 usecs
> [    0.092690] calling  hugepage_init+0x0/0x310 @ 1
> [    0.092690] initcall hugepage_init+0x0/0x310 returned 0 after 0 usecs
> [    0.092690] calling  mem_cgroup_init+0x0/0x120 @ 1
> [    0.092690] initcall mem_cgroup_init+0x0/0x120 returned 0 after 0 usecs
> [    0.092690] calling  mem_cgroup_swap_init+0x0/0x70 @ 1
> [    0.092690] initcall mem_cgroup_swap_init+0x0/0x70 returned 0 after 0 usecs
> [    0.092690] calling  fips_init+0x0/0x30 @ 1
> [    0.092690] initcall fips_init+0x0/0x30 returned 0 after 0 usecs
> [    0.092690] calling  dh_init+0x0/0x50 @ 1
> [    0.092690] initcall dh_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  rsa_init+0x0/0x50 @ 1
> [    0.092690] initcall rsa_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  hmac_module_init+0x0/0x20 @ 1
> [    0.092690] initcall hmac_module_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  md5_mod_init+0x0/0x20 @ 1
> [    0.092690] initcall md5_mod_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  sha1_generic_mod_init+0x0/0x20 @ 1
> [    0.092690] initcall sha1_generic_mod_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  sha256_generic_mod_init+0x0/0x20 @ 1
> [    0.092690] initcall sha256_generic_mod_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  crypto_ecb_module_init+0x0/0x20 @ 1
> [    0.092690] initcall crypto_ecb_module_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  crypto_cbc_module_init+0x0/0x20 @ 1
> [    0.092690] initcall crypto_cbc_module_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  aes_init+0x0/0x20 @ 1
> [    0.092690] initcall aes_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  lzo_mod_init+0x0/0x50 @ 1
> [    0.092690] initcall lzo_mod_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  lzorle_mod_init+0x0/0x50 @ 1
> [    0.092690] initcall lzorle_mod_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  init_bio+0x0/0xc0 @ 1
> [    0.092690] initcall init_bio+0x0/0xc0 returned 0 after 0 usecs
> [    0.092690] calling  blk_ioc_init+0x0/0x40 @ 1
> [    0.092690] initcall blk_ioc_init+0x0/0x40 returned 0 after 0 usecs
> [    0.092690] calling  blk_mq_init+0x0/0x120 @ 1
> [    0.092690] initcall blk_mq_init+0x0/0x120 returned 0 after 0 usecs
> [    0.092690] calling  genhd_device_init+0x0/0x60 @ 1
> [    0.092690] initcall genhd_device_init+0x0/0x60 returned 0 after 0 usecs
> [    0.092690] calling  io_wq_init+0x0/0x50 @ 1
> [    0.092690] initcall io_wq_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  irq_poll_setup+0x0/0x80 @ 1
> [    0.092690] initcall irq_poll_setup+0x0/0x80 returned 0 after 0 usecs
> [    0.092690] calling  byt_gpio_init+0x0/0x20 @ 1
> [    0.092690] initcall byt_gpio_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  chv_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall chv_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  bxt_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall bxt_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  cdf_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall cdf_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  dnv_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall dnv_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  glk_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall glk_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  spt_pinctrl_init+0x0/0x20 @ 1
> [    0.092690] initcall spt_pinctrl_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  gpiolib_debugfs_init+0x0/0x30 @ 1
> [    0.092690] initcall gpiolib_debugfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.092690] calling  pwm_debugfs_init+0x0/0x30 @ 1
> [    0.092690] initcall pwm_debugfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.092690] calling  pwm_sysfs_init+0x0/0x20 @ 1
> [    0.092690] initcall pwm_sysfs_init+0x0/0x20 returned 0 after 0 usecs
> [    0.092690] calling  pci_slot_init+0x0/0x50 @ 1
> [    0.092690] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
> [    0.092690] calling  fbmem_init+0x0/0x80 @ 1
> [    0.092690] initcall fbmem_init+0x0/0x80 returned 0 after 0 usecs
> [    0.092690] calling  acpi_init+0x0/0x590 @ 1
> [    0.092690] ACPI: Added _OSI(Module Device)
> [    0.092690] ACPI: Added _OSI(Processor Device)
> [    0.092690] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.092690] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.133040] ACPI: 11 ACPI AML tables successfully acquired and loaded
> [    0.137671] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.145263] ACPI: Dynamic OEM Table Load:
> [    0.145270] ACPI: SSDT 0xFFFF9DC0810D6000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
> [    0.146623] ACPI: Dynamic OEM Table Load:
> [    0.146628] ACPI: SSDT 0xFFFF9DC080D91800 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
> [    0.149244] ACPI: Dynamic OEM Table Load:
> [    0.149249] ACPI: SSDT 0xFFFF9DC081616000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
> [    0.150894] ACPI: Dynamic OEM Table Load:
> [    0.150899] ACPI: SSDT 0xFFFF9DC081114800 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
> [    0.155043] ACPI: _OSC evaluated successfully for all CPUs
> [    0.155225] ACPI: EC: EC started
> [    0.155226] ACPI: EC: interrupt blocked
> [    0.160542] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    0.160545] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
> [    0.160546] ACPI: Interpreter enabled
> [    0.160582] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.160583] ACPI: Using IOAPIC for interrupt routing
> [    0.160625] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.161543] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
> [    0.161553] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.161554] PCI: Using E820 reservations for host bridge windows
> [    0.162197] ACPI: Enabled 8 GPEs in block 00 to 7F
> [    0.167314] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
> [    0.167636] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
> [    0.167956] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
> [    0.168275] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
> [    0.168603] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
> [    0.168922] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
> [    0.169743] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
> [    0.170066] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
> [    0.170388] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
> [    0.170707] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
> [    0.171028] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
> [    0.171347] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
> [    0.171670] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
> [    0.171993] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
> [    0.172310] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
> [    0.172646] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
> [    0.172965] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
> [    0.174307] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
> [    0.174631] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
> [    0.174948] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
> [    0.198330] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    0.198337] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.198538] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
> [    0.198911] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability LTR]
> [    0.198912] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.199871] PCI host bridge to bus 0000:00
> [    0.199872] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.199875] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.199877] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
> [    0.199878] pci_bus 0000:00: root bus resource [mem 0x7c800000-0xdfffffff window]
> [    0.199879] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    0.199881] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    0.199897] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x20 @ 1
> [    0.199902] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x20 took 0 usecs
> [    0.199905] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000 conventional PCI endpoint
> [    0.199925] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.199928] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.199984] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
> [    0.199991] pci 0000:00:02.0: BAR 0 [mem 0xdb000000-0xdbffffff 64bit]
> [    0.199996] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9fffffff 64bit pref]
> [    0.199999] pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
> [    0.200012] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x140 @ 1
> [    0.200015] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    0.200016] pci 0000:00:02.0: efifb_fixup_resources+0x0/0x140 took 0 usecs
> [    0.200018] pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.200020] pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.200023] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x120 @ 1
> [    0.200027] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.200028] pci 0000:00:02.0: pci_fixup_video+0x0/0x120 took 0 usecs
> [    0.200188] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
> [    0.200196] pci 0000:00:04.0: BAR 0 [mem 0xdc320000-0xdc327fff 64bit]
> [    0.200211] pci 0000:00:04.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.200214] pci 0000:00:04.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.200478] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
> [    0.200494] pci 0000:00:14.0: BAR 0 [mem 0xdc310000-0xdc31ffff 64bit]
> [    0.200531] pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.200534] pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.200559] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.201108] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
> [    0.201123] pci 0000:00:14.2: BAR 0 [mem 0xdc334000-0xdc334fff 64bit]
> [    0.201156] pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.201158] pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.201268] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
> [    0.201299] pci 0000:00:15.0: BAR 0 [mem 0xdc333000-0xdc333fff 64bit]
> [    0.201347] pci 0000:00:15.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.201350] pci 0000:00:15.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.201670] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
> [    0.201699] pci 0000:00:15.1: BAR 0 [mem 0xdc332000-0xdc332fff 64bit]
> [    0.201748] pci 0000:00:15.1: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.201750] pci 0000:00:15.1: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.202034] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000 conventional PCI endpoint
> [    0.202047] pci 0000:00:16.0: BAR 0 [mem 0xdc331000-0xdc331fff 64bit]
> [    0.202072] pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.202075] pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.202096] pci 0000:00:16.0: PME# supported from D3hot
> [    0.202429] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x80 @ 1
> [    0.202434] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x80 took 0 usecs
> [    0.202436] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x10 @ 1
> [    0.202438] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x10 took 0 usecs
> [    0.202440] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
> [    0.202458] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.202463] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    0.202470] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.202486] pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.202488] pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.202490] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0x30 @ 1
> [    0.202493] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0x30 took 0 usecs
> [    0.202520] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.203018] pci 0000:00:1c.4: calling  quirk_cmd_compl+0x0/0x80 @ 1
> [    0.203022] pci 0000:00:1c.4: quirk_cmd_compl+0x0/0x80 took 0 usecs
> [    0.203025] pci 0000:00:1c.4: calling  quirk_no_aersid+0x0/0x10 @ 1
> [    0.203027] pci 0000:00:1c.4: quirk_no_aersid+0x0/0x10 took 0 usecs
> [    0.203029] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400 PCIe Root Port
> [    0.203049] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.203053] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    0.203079] pci 0000:00:1c.4: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.203081] pci 0000:00:1c.4: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.203084] pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/0x30 @ 1
> [    0.203086] pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0x30 took 0 usecs
> [    0.203118] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.203624] pci 0000:00:1d.0: calling  quirk_cmd_compl+0x0/0x80 @ 1
> [    0.203628] pci 0000:00:1d.0: quirk_cmd_compl+0x0/0x80 took 0 usecs
> [    0.203630] pci 0000:00:1d.0: calling  quirk_no_aersid+0x0/0x10 @ 1
> [    0.203632] pci 0000:00:1d.0: quirk_no_aersid+0x0/0x10 took 0 usecs
> [    0.203634] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400 PCIe Root Port
> [    0.203652] pci 0000:00:1d.0: PCI bridge to [bus 3b]
> [    0.203656] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    0.203678] pci 0000:00:1d.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.203680] pci 0000:00:1d.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.203682] pci 0000:00:1d.0: calling  pci_fixup_transparent_bridge+0x0/0x30 @ 1
> [    0.203685] pci 0000:00:1d.0: pci_fixup_transparent_bridge+0x0/0x30 took 0 usecs
> [    0.203713] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.204233] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100 conventional PCI endpoint
> [    0.204328] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.204331] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.204578] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
> [    0.204590] pci 0000:00:1f.2: BAR 0 [mem 0xdc32c000-0xdc32ffff]
> [    0.204627] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.204630] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.204831] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380 conventional PCI endpoint
> [    0.204851] pci 0000:00:1f.3: BAR 0 [mem 0xdc328000-0xdc32bfff 64bit]
> [    0.204874] pci 0000:00:1f.3: BAR 4 [mem 0xdc300000-0xdc30ffff 64bit]
> [    0.204887] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.204890] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.204922] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.205534] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.205592] pci 0000:00:1f.4: BAR 0 [mem 0xdc330000-0xdc3300ff 64bit]
> [    0.205664] pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
> [    0.205722] pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.205724] pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.205998] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.206332] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000 PCIe Endpoint
> [    0.206549] pci 0000:3a:00.0: BAR 0 [mem 0xdc000000-0xdc1fffff 64bit]
> [    0.207094] pci 0000:3a:00.0: calling  quirk_no_bus_reset+0x0/0x20 @ 1
> [    0.207097] pci 0000:3a:00.0: quirk_no_bus_reset+0x0/0x20 took 0 usecs
> [    0.207799] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
> [    0.209401] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.209488] pci 0000:3b:00.0: [1c5c:1284] type 00 class 0x010802 PCIe Endpoint
> [    0.209508] pci 0000:3b:00.0: BAR 0 [mem 0xdc200000-0xdc203fff 64bit]
> [    0.209614] pci 0000:3b:00.0: PME# supported from D0 D1 D3hot
> [    0.209990] pci 0000:00:1d.0: PCI bridge to [bus 3b]
> [    0.212951] probe of INT344B:00 returned 0 after 4000 usecs
> [    0.213114] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    0.213173] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    0.213230] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    0.213287] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    0.213348] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
> [    0.213404] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
> [    0.213460] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> [    0.213517] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> [    0.226436] ACPI: EC: interrupt unblocked
> [    0.226437] ACPI: EC: event unblocked
> [    0.226442] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    0.226444] ACPI: EC: GPE=0x14
> [    0.226445] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
> [    0.226447] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
> [    0.226451] probe of PNP0C09:00 returned 0 after 0 usecs
> [    0.226493] initcall acpi_init+0x0/0x590 returned 0 after 132000 usecs
> [    0.226501] calling  hmat_init+0x0/0x430 @ 1
> [    0.226503] initcall hmat_init+0x0/0x430 returned 0 after 0 usecs
> [    0.226505] calling  pnp_init+0x0/0x20 @ 1
> [    0.226511] initcall pnp_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226513] calling  balloon_init+0x0/0x230 @ 1
> [    0.226516] initcall balloon_init+0x0/0x230 returned -19 after 0 usecs
> [    0.226518] calling  xen_setup_shutdown_event+0x0/0x40 @ 1
> [    0.226521] initcall xen_setup_shutdown_event+0x0/0x40 returned -19 after 0 usecs
> [    0.226523] calling  xenbus_probe_backend_init+0x0/0x90 @ 1
> [    0.226529] initcall xenbus_probe_backend_init+0x0/0x90 returned 0 after 0 usecs
> [    0.226531] calling  xenbus_probe_frontend_init+0x0/0x60 @ 1
> [    0.226537] initcall xenbus_probe_frontend_init+0x0/0x60 returned 0 after 0 usecs
> [    0.226540] calling  xen_acpi_pad_init+0x0/0x50 @ 1
> [    0.226542] initcall xen_acpi_pad_init+0x0/0x50 returned -19 after 0 usecs
> [    0.226544] calling  misc_init+0x0/0xb0 @ 1
> [    0.226549] initcall misc_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.226551] calling  tpm_init+0x0/0xd0 @ 1
> [    0.226561] initcall tpm_init+0x0/0xd0 returned 0 after 0 usecs
> [    0.226561] calling  iommu_subsys_init+0x0/0x180 @ 1
> [    0.226561] iommu: Default domain type: Translated
> [    0.226561] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.226561] initcall iommu_subsys_init+0x0/0x180 returned 0 after 0 usecs
> [    0.226561] calling  cn_init+0x0/0x100 @ 1
> [    0.226561] initcall cn_init+0x0/0x100 returned 0 after 0 usecs
> [    0.226561] calling  dax_core_init+0x0/0xe0 @ 1
> [    0.226561] initcall dax_core_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.226561] calling  dma_buf_init+0x0/0xe0 @ 1
> [    0.226561] initcall dma_buf_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.226561] calling  cxl_core_init+0x0/0xb0 @ 1
> [    0.226561] initcall cxl_core_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.226561] calling  serio_init+0x0/0x40 @ 1
> [    0.226561] initcall serio_init+0x0/0x40 returned 0 after 0 usecs
> [    0.226561] calling  input_init+0x0/0x140 @ 1
> [    0.226561] initcall input_init+0x0/0x140 returned 0 after 0 usecs
> [    0.226561] calling  rtc_init+0x0/0x50 @ 1
> [    0.226561] initcall rtc_init+0x0/0x50 returned 0 after 0 usecs
> [    0.226561] calling  dw_i2c_init_driver+0x0/0x20 @ 1
> [    0.226561] initcall dw_i2c_init_driver+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  pps_init+0x0/0xc0 @ 1
> [    0.226561] pps_core: LinuxPPS API ver. 1 registered
> [    0.226561] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.226561] initcall pps_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.226561] calling  ptp_init+0x0/0xb0 @ 1
> [    0.226561] PTP clock support registered
> [    0.226561] initcall ptp_init+0x0/0xb0 returned 0 after 0 usecs
> [    0.226561] calling  power_supply_class_init+0x0/0x40 @ 1
> [    0.226561] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
> [    0.226561] calling  hwmon_init+0x0/0x110 @ 1
> [    0.226561] initcall hwmon_init+0x0/0x110 returned 0 after 0 usecs
> [    0.226561] calling  edac_init+0x0/0x80 @ 1
> [    0.226561] EDAC MC: Ver: 3.0.0
> [    0.226561] initcall edac_init+0x0/0x80 returned 0 after 0 usecs
> [    0.226561] calling  leds_init+0x0/0x20 @ 1
> [    0.226561] initcall leds_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  dmi_init+0x0/0x130 @ 1
> [    0.226561] initcall dmi_init+0x0/0x130 returned 0 after 0 usecs
> [    0.226561] calling  efisubsys_init+0x0/0x660 @ 1
> [    0.226561] efivars: Registered efivars operations
> [    0.226561] initcall efisubsys_init+0x0/0x660 returned 0 after 0 usecs
> [    0.226561] calling  intel_scu_ipc_init+0x0/0x20 @ 1
> [    0.226561] initcall intel_scu_ipc_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  devfreq_init+0x0/0xe0 @ 1
> [    0.226561] initcall devfreq_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.226561] calling  ras_init+0x0/0x20 @ 1
> [    0.226561] initcall ras_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  nvmem_init+0x0/0x20 @ 1
> [    0.226561] initcall nvmem_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  proto_init+0x0/0x20 @ 1
> [    0.226561] initcall proto_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  net_dev_init+0x0/0x260 @ 1
> [    0.226561] initcall net_dev_init+0x0/0x260 returned 0 after 0 usecs
> [    0.226561] calling  neigh_init+0x0/0x90 @ 1
> [    0.226561] initcall neigh_init+0x0/0x90 returned 0 after 0 usecs
> [    0.226561] calling  fib_notifier_init+0x0/0x20 @ 1
> [    0.226561] initcall fib_notifier_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  netdev_genl_init+0x0/0x50 @ 1
> [    0.226561] initcall netdev_genl_init+0x0/0x50 returned 0 after 0 usecs
> [    0.226561] calling  page_pool_user_init+0x0/0x20 @ 1
> [    0.226561] initcall page_pool_user_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  fib_rules_init+0x0/0xc0 @ 1
> [    0.226561] initcall fib_rules_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.226561] calling  init_cgroup_netprio+0x0/0x20 @ 1
> [    0.226561] initcall init_cgroup_netprio+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  bpf_lwt_init+0x0/0x20 @ 1
> [    0.226561] initcall bpf_lwt_init+0x0/0x20 returned 0 after 0 usecs
> [    0.226561] calling  pktsched_init+0x0/0x140 @ 1
> [    0.226561] initcall pktsched_init+0x0/0x140 returned 0 after 0 usecs
> [    0.226561] calling  tc_filter_init+0x0/0x110 @ 1
> [    0.226561] initcall tc_filter_init+0x0/0x110 returned 0 after 0 usecs
> [    0.226561] calling  tc_action_init+0x0/0x60 @ 1
> [    0.226561] initcall tc_action_init+0x0/0x60 returned 0 after 0 usecs
> [    0.226561] calling  ethnl_init+0x0/0x80 @ 1
> [    0.226561] initcall ethnl_init+0x0/0x80 returned 0 after 0 usecs
> [    0.226561] calling  nexthop_init+0x0/0x100 @ 1
> [    0.226561] initcall nexthop_init+0x0/0x100 returned 0 after 0 usecs
> [    0.226561] calling  cipso_v4_init+0x0/0x70 @ 1
> [    0.226561] initcall cipso_v4_init+0x0/0x70 returned 0 after 0 usecs
> [    0.226561] calling  wireless_nlevent_init+0x0/0x60 @ 1
> [    0.226561] initcall wireless_nlevent_init+0x0/0x60 returned 0 after 0 usecs
> [    0.226561] calling  netlbl_init+0x0/0x90 @ 1
> [    0.226561] NetLabel: Initializing
> [    0.226561] NetLabel:  domain hash size = 128
> [    0.226561] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.226561] NetLabel:  unlabeled traffic allowed by default
> [    0.226561] initcall netlbl_init+0x0/0x90 returned 0 after 0 usecs
> [    0.226561] calling  pci_subsys_init+0x0/0x90 @ 1
> [    0.226561] PCI: Using ACPI for IRQ routing
> [    0.249184] PCI: pci_cache_line_size set to 64 bytes
> [    0.249562] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    0.249564] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [    0.249565] e820: reserve RAM buffer [mem 0x5152e018-0x53ffffff]
> [    0.249566] e820: reserve RAM buffer [mem 0x556ab000-0x57ffffff]
> [    0.249567] e820: reserve RAM buffer [mem 0x62262000-0x63ffffff]
> [    0.249568] e820: reserve RAM buffer [mem 0x64df4000-0x67ffffff]
> [    0.249569] e820: reserve RAM buffer [mem 0x78600000-0x7bffffff]
> [    0.249570] e820: reserve RAM buffer [mem 0x481800000-0x483ffffff]
> [    0.249571] initcall pci_subsys_init+0x0/0x90 returned 0 after 28000 usecs
> [    0.249575] calling  vsprintf_init_hashval+0x0/0x20 @ 1
> [    0.249578] initcall vsprintf_init_hashval+0x0/0x20 returned 0 after 0 usecs
> [    0.249581] calling  efi_runtime_map_init+0x0/0x230 @ 1
> [    0.249605] initcall efi_runtime_map_init+0x0/0x230 returned 0 after 0 usecs
> [    0.249608] calling  vga_arb_device_init+0x0/0xa0 @ 1
> [    0.252400] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.252400] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.252400] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.252403] vgaarb: loaded
> [    0.252404] initcall vga_arb_device_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.252437] calling  nmi_warning_debugfs+0x0/0x30 @ 1
> [    0.252442] initcall nmi_warning_debugfs+0x0/0x30 returned 0 after 0 usecs
> [    0.252444] calling  hpet_late_init+0x0/0x430 @ 1
> [    0.252447] initcall hpet_late_init+0x0/0x430 returned -19 after 0 usecs
> [    0.252449] calling  init_amd_nbs+0x0/0x4f0 @ 1
> [    0.252454] initcall init_amd_nbs+0x0/0x4f0 returned 0 after 0 usecs
> [    0.252456] calling  iomem_init_inode+0x0/0x90 @ 1
> [    0.252464] initcall iomem_init_inode+0x0/0x90 returned 0 after 0 usecs
> [    0.252466] calling  em_debug_init+0x0/0x30 @ 1
> [    0.252470] initcall em_debug_init+0x0/0x30 returned 0 after 0 usecs
> [    0.252472] calling  clocksource_done_booting+0x0/0x50 @ 1
> [    0.252483] clocksource: Switched to clocksource tsc-early
> [    0.252484] initcall clocksource_done_booting+0x0/0x50 returned 0 after 3 usecs
> [    0.252487] calling  tracer_init_tracefs+0x0/0xd0 @ 1
> [    0.252492] initcall tracer_init_tracefs+0x0/0xd0 returned 0 after 2 usecs
> [    0.252494] calling  init_trace_printk_function_export+0x0/0x30 @ 1
> [    0.252513] initcall init_trace_printk_function_export+0x0/0x30 returned 0 after 16 usecs
> [    0.252517] calling  init_graph_tracefs+0x0/0x30 @ 1
> [    0.252520] initcall init_graph_tracefs+0x0/0x30 returned 0 after 1 usecs
> [    0.252523] calling  trace_events_synth_init+0x0/0x50 @ 1
> [    0.252527] initcall trace_events_synth_init+0x0/0x50 returned 0 after 1 usecs
> [    0.252530] calling  bpf_event_init+0x0/0x20 @ 1
> [    0.252537] initcall bpf_event_init+0x0/0x20 returned 0 after 4 usecs
> [    0.252540] calling  init_kprobe_trace+0x0/0x1d0 @ 1
> [    0.252975] initcall init_kprobe_trace+0x0/0x1d0 returned 0 after 432 usecs
> [    0.252979] calling  init_dynamic_event+0x0/0x30 @ 1
> [    0.252983] initcall init_dynamic_event+0x0/0x30 returned 0 after 1 usecs
> [    0.252987] calling  init_uprobe_trace+0x0/0x70 @ 1
> [    0.252992] initcall init_uprobe_trace+0x0/0x70 returned 0 after 2 usecs
> [    0.252995] calling  bpf_init+0x0/0x70 @ 1
> [    0.253000] initcall bpf_init+0x0/0x70 returned 0 after 2 usecs
> [    0.253004] calling  secretmem_init+0x0/0x40 @ 1
> [    0.253012] initcall secretmem_init+0x0/0x40 returned 0 after 5 usecs
> [    0.253015] calling  init_fs_stat_sysctls+0x0/0x40 @ 1
> [    0.253023] initcall init_fs_stat_sysctls+0x0/0x40 returned 0 after 5 usecs
> [    0.253025] calling  init_fs_exec_sysctls+0x0/0x30 @ 1
> [    0.253029] initcall init_fs_exec_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.253031] calling  init_pipe_fs+0x0/0x70 @ 1
> [    0.253045] initcall init_pipe_fs+0x0/0x70 returned 0 after 9 usecs
> [    0.253048] calling  init_fs_namei_sysctls+0x0/0x30 @ 1
> [    0.253053] initcall init_fs_namei_sysctls+0x0/0x30 returned 0 after 2 usecs
> [    0.253056] calling  init_fs_dcache_sysctls+0x0/0x30 @ 1
> [    0.253059] initcall init_fs_dcache_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.253062] calling  init_fs_namespace_sysctls+0x0/0x30 @ 1
> [    0.253066] initcall init_fs_namespace_sysctls+0x0/0x30 returned 0 after 0 usecs
> [    0.253069] calling  cgroup_writeback_init+0x0/0x30 @ 1
> [    0.253075] initcall cgroup_writeback_init+0x0/0x30 returned 0 after 3 usecs
> [    0.253078] calling  inotify_user_setup+0x0/0x100 @ 1
> [    0.253086] initcall inotify_user_setup+0x0/0x100 returned 0 after 4 usecs
> [    0.253089] calling  eventpoll_init+0x0/0x120 @ 1
> [    0.253108] initcall eventpoll_init+0x0/0x120 returned 0 after 16 usecs
> [    0.253112] calling  anon_inode_init+0x0/0x70 @ 1
> [    0.253119] initcall anon_inode_init+0x0/0x70 returned 0 after 4 usecs
> [    0.253121] calling  init_dax_wait_table+0x0/0x40 @ 1
> [    0.253141] initcall init_dax_wait_table+0x0/0x40 returned 0 after 16 usecs
> [    0.253143] calling  proc_locks_init+0x0/0x30 @ 1
> [    0.253147] initcall proc_locks_init+0x0/0x30 returned 0 after 1 usecs
> [    0.253149] calling  init_fs_coredump_sysctls+0x0/0x30 @ 1
> [    0.253153] initcall init_fs_coredump_sysctls+0x0/0x30 returned 0 after 2 usecs
> [    0.253155] calling  iomap_init+0x0/0x30 @ 1
> [    0.253175] initcall iomap_init+0x0/0x30 returned 0 after 19 usecs
> [    0.253177] calling  dquot_init+0x0/0x170 @ 1
> [    0.253178] VFS: Disk quotas dquot_6.6.0
> [    0.253188] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.253189] initcall dquot_init+0x0/0x170 returned 0 after 11 usecs
> [    0.253191] calling  quota_init+0x0/0x40 @ 1
> [    0.253196] initcall quota_init+0x0/0x40 returned 0 after 3 usecs
> [    0.253197] calling  proc_cmdline_init+0x0/0x40 @ 1
> [    0.253203] initcall proc_cmdline_init+0x0/0x40 returned 0 after 4 usecs
> [    0.253205] calling  proc_consoles_init+0x0/0x30 @ 1
> [    0.253206] initcall proc_consoles_init+0x0/0x30 returned 0 after 0 usecs
> [    0.253208] calling  proc_cpuinfo_init+0x0/0x30 @ 1
> [    0.253210] initcall proc_cpuinfo_init+0x0/0x30 returned 0 after 0 usecs
> [    0.253211] calling  proc_devices_init+0x0/0x40 @ 1
> [    0.253213] initcall proc_devices_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253214] calling  proc_interrupts_init+0x0/0x30 @ 1
> [    0.253216] initcall proc_interrupts_init+0x0/0x30 returned 0 after 0 usecs
> [    0.253218] calling  proc_loadavg_init+0x0/0x40 @ 1
> [    0.253219] initcall proc_loadavg_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253221] calling  proc_meminfo_init+0x0/0x40 @ 1
> [    0.253223] initcall proc_meminfo_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253224] calling  proc_stat_init+0x0/0x30 @ 1
> [    0.253226] initcall proc_stat_init+0x0/0x30 returned 0 after 0 usecs
> [    0.253227] calling  proc_uptime_init+0x0/0x40 @ 1
> [    0.253229] initcall proc_uptime_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253231] calling  proc_version_init+0x0/0x40 @ 1
> [    0.253233] initcall proc_version_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253234] calling  proc_softirqs_init+0x0/0x40 @ 1
> [    0.253236] initcall proc_softirqs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.253238] calling  proc_kcore_init+0x0/0x1f0 @ 1
> [    0.253244] initcall proc_kcore_init+0x0/0x1f0 returned 0 after 4 usecs
> [    0.253246] calling  vmcore_init+0x0/0x6a0 @ 1
> [    0.253248] initcall vmcore_init+0x0/0x6a0 returned 0 after 0 usecs
> [    0.253249] calling  proc_kmsg_init+0x0/0x30 @ 1
> [    0.253251] initcall proc_kmsg_init+0x0/0x30 returned 0 after 0 usecs
> [    0.253253] calling  proc_page_init+0x0/0x60 @ 1
> [    0.253256] initcall proc_page_init+0x0/0x60 returned 0 after 0 usecs
> [    0.253257] calling  init_ramfs_fs+0x0/0x20 @ 1
> [    0.253259] initcall init_ramfs_fs+0x0/0x20 returned 0 after 0 usecs
> [    0.253261] calling  init_hugetlbfs_fs+0x0/0x170 @ 1
> [    0.253275] initcall init_hugetlbfs_fs+0x0/0x170 returned 0 after 12 usecs
> [    0.253277] calling  tomoyo_initerface_init+0x0/0x190 @ 1
> [    0.253293] initcall tomoyo_initerface_init+0x0/0x190 returned 0 after 14 usecs
> [    0.253296] calling  aa_create_aafs+0x0/0x3f0 @ 1
> [    0.253359] AppArmor: AppArmor Filesystem Enabled
> [    0.253360] initcall aa_create_aafs+0x0/0x3f0 returned 0 after 61 usecs
> [    0.253362] calling  dynamic_debug_init_control+0x0/0x90 @ 1
> [    0.253368] initcall dynamic_debug_init_control+0x0/0x90 returned 0 after 2 usecs
> [    0.253370] calling  acpi_event_init+0x0/0x40 @ 1
> [    0.253380] initcall acpi_event_init+0x0/0x40 returned 0 after 3 usecs
> [    0.253383] calling  pnp_system_init+0x0/0x20 @ 1
> [    0.253389] initcall pnp_system_init+0x0/0x20 returned 0 after 4 usecs
> [    0.253391] calling  pnpacpi_init+0x0/0x80 @ 1
> [    0.253393] pnp: PnP ACPI init
> [    0.253623] system 00:00: [io  0x0680-0x069f] has been reserved
> [    0.253625] system 00:00: [io  0xffff] has been reserved
> [    0.253627] system 00:00: [io  0xffff] has been reserved
> [    0.253628] system 00:00: [io  0xffff] has been reserved
> [    0.253630] system 00:00: [io  0x1800-0x18fe] has been reserved
> [    0.253631] system 00:00: [io  0x164e-0x164f] has been reserved
> [    0.253635] probe of 00:00 returned 0 after 15 usecs
> [    0.253765] system 00:02: [io  0x1854-0x1857] has been reserved
> [    0.253769] probe of 00:02 returned 0 after 5 usecs
> [    0.254202] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.254205] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.254206] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.254208] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.254210] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.254211] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    0.254213] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.254214] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> [    0.254216] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.254217] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
> [    0.254221] probe of 00:05 returned 0 after 21 usecs
> [    0.254261] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
> [    0.254263] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    0.254265] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    0.254266] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.254268] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    0.254269] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    0.254271] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    0.254273] probe of 00:06 returned 0 after 15 usecs
> [    0.254561] system 00:07: [io  0xff00-0xfffe] has been reserved
> [    0.254564] probe of 00:07 returned 0 after 5 usecs
> [    0.255631] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
> [    0.255634] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
> [    0.255637] probe of 00:08 returned 0 after 9 usecs
> [    0.260897] pnp: PnP ACPI: found 9 devices
> [    0.260898] initcall pnpacpi_init+0x0/0x80 returned 0 after 7594 usecs
> [    0.260902] calling  chr_dev_init+0x0/0xa0 @ 1
> [    0.262121] initcall chr_dev_init+0x0/0xa0 returned 0 after 1217 usecs
> [    0.262124] calling  hwrng_modinit+0x0/0xb0 @ 1
> [    0.262145] initcall hwrng_modinit+0x0/0xb0 returned 0 after 19 usecs
> [    0.262147] calling  firmware_class_init+0x0/0x110 @ 1
> [    0.262157] initcall firmware_class_init+0x0/0x110 returned 0 after 6 usecs
> [    0.262159] calling  map_properties+0x0/0x690 @ 1
> [    0.262162] initcall map_properties+0x0/0x690 returned 0 after 0 usecs
> [    0.262164] calling  efi_mokvar_sysfs_init+0x0/0x1c0 @ 1
> [    0.262166] initcall efi_mokvar_sysfs_init+0x0/0x1c0 returned -2 after 0 usecs
> [    0.262169] calling  init_acpi_pm_clocksource+0x0/0x100 @ 1
> [    0.266654] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.266656] initcall init_acpi_pm_clocksource+0x0/0x100 returned 0 after 4484 usecs
> [    0.266659] calling  p2sb_fs_init+0x0/0x170 @ 1
> [    0.266701] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
> [    0.266760] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> [    0.266899] pci 0000:00:1f.1: calling  quirk_igfx_skip_te_disable+0x0/0xb0 @ 1
> [    0.266903] pci 0000:00:1f.1: quirk_igfx_skip_te_disable+0x0/0xb0 took 0 usecs
> [    0.266994] initcall p2sb_fs_init+0x0/0x170 returned 0 after 333 usecs
> [    0.266997] calling  powercap_init+0x0/0x290 @ 1
> [    0.267019] initcall powercap_init+0x0/0x290 returned 0 after 19 usecs
> [    0.267022] calling  sysctl_core_init+0x0/0x40 @ 1
> [    0.267038] initcall sysctl_core_init+0x0/0x40 returned 0 after 15 usecs
> [    0.267040] calling  eth_offload_init+0x0/0x20 @ 1
> [    0.267042] initcall eth_offload_init+0x0/0x20 returned 0 after 0 usecs
> [    0.267043] calling  ipv4_offload_init+0x0/0xa0 @ 1
> [    0.267046] initcall ipv4_offload_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.267048] calling  inet_init+0x0/0x2f0 @ 1
> [    0.267062] NET: Registered PF_INET protocol family
> [    0.267180] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.269463] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.269488] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.269537] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.269718] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    0.269918] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.269996] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.270035] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.270068] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.270115] initcall inet_init+0x0/0x2f0 returned 0 after 3064 usecs
> [    0.270122] calling  af_unix_init+0x0/0x100 @ 1
> [    0.270126] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.270131] initcall af_unix_init+0x0/0x100 returned 0 after 6 usecs
> [    0.270133] calling  ipv6_offload_init+0x0/0xa0 @ 1
> [    0.270135] initcall ipv6_offload_init+0x0/0xa0 returned 0 after 0 usecs
> [    0.270137] calling  xsk_init+0x0/0xe0 @ 1
> [    0.270139] NET: Registered PF_XDP protocol family
> [    0.270140] initcall xsk_init+0x0/0xe0 returned 0 after 1 usecs
> [    0.270141] calling  pcibios_assign_resources+0x0/0xf0 @ 1
> [    0.270157] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
> [    0.270166] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
> [    0.270169] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    0.270171] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.270175] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    0.270177] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.270181] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    0.270185] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    0.270190] pci 0000:00:1d.0: PCI bridge to [bus 3b]
> [    0.270193] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    0.270198] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.270200] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.270201] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
> [    0.270202] pci_bus 0000:00: resource 7 [mem 0x7c800000-0xdfffffff window]
> [    0.270204] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> [    0.270205] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    0.270206] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
> [    0.270207] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    0.270209] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
> [    0.270210] pci_bus 0000:3b: resource 1 [mem 0xdc200000-0xdc2fffff]
> [    0.270388] initcall pcibios_assign_resources+0x0/0xf0 returned 0 after 243 usecs
> [    0.270391] calling  pci_apply_final_quirks+0x0/0x170 @ 1
> [    0.270402] pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x750 @ 1
> [    0.270665] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x750 took 253 usecs
> [    0.270862] PCI: CLS 0 bytes, default 64
> [    0.270863] initcall pci_apply_final_quirks+0x0/0x170 returned 0 after 470 usecs
> [    0.270865] calling  acpi_reserve_resources+0x0/0x110 @ 1
> [    0.270870] initcall acpi_reserve_resources+0x0/0x110 returned 0 after 1 usecs
> [    0.270872] calling  populate_rootfs+0x0/0x90 @ 1
> [    0.270877] initcall populate_rootfs+0x0/0x90 returned 0 after 2 usecs
> [    0.270879] calling  pci_iommu_init+0x0/0x40 @ 1
> [    0.270887] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
> [    0.270891] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
> [    0.270901] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.270902] software IO TLB: mapped [mem 0x000000005e262000-0x0000000062262000] (64MB)
> [    0.270904] initcall pci_iommu_init+0x0/0x40 returned 0 after 22 usecs
> [    0.270906] calling  ir_dev_scope_init+0x0/0x40 @ 1
> [    0.270909] initcall ir_dev_scope_init+0x0/0x40 returned 0 after 0 usecs
> [    0.270935] Unpacking initramfs...
> [    0.270953] calling  ia32_binfmt_init+0x0/0x30 @ 1
> [    0.270958] initcall ia32_binfmt_init+0x0/0x30 returned 0 after 1 usecs
> [    0.270960] calling  amd_ibs_init+0x0/0x420 @ 1
> [    0.270963] initcall amd_ibs_init+0x0/0x420 returned -19 after 0 usecs
> [    0.270965] calling  amd_uncore_init+0x0/0x1a0 @ 1
> [    0.270968] initcall amd_uncore_init+0x0/0x1a0 returned -19 after 0 usecs
> [    0.270970] calling  amd_iommu_pc_init+0x0/0x270 @ 1
> [    0.270973] initcall amd_iommu_pc_init+0x0/0x270 returned -19 after 0 usecs
> [    0.270976] calling  msr_init+0x0/0x70 @ 1
> [    0.270983] initcall msr_init+0x0/0x70 returned 0 after 5 usecs
> [    0.270986] calling  register_kernel_offset_dumper+0x0/0x30 @ 1
> [    0.270994] initcall register_kernel_offset_dumper+0x0/0x30 returned 0 after 0 usecs
> [    0.270996] calling  i8259A_init_ops+0x0/0x30 @ 1
> [    0.270999] initcall i8259A_init_ops+0x0/0x30 returned 0 after 0 usecs
> [    0.271002] calling  init_tsc_clocksource+0x0/0xd0 @ 1
> [    0.271007] initcall init_tsc_clocksource+0x0/0xd0 returned 0 after 3 usecs
> [    0.271010] calling  add_rtc_cmos+0x0/0xa0 @ 1
> [    0.271013] initcall add_rtc_cmos+0x0/0xa0 returned 0 after 0 usecs
> [    0.271014] calling  i8237A_init_ops+0x0/0x50 @ 1
> [    0.271019] initcall i8237A_init_ops+0x0/0x50 returned -19 after 2 usecs
> [    0.271022] calling  umwait_init+0x0/0xb0 @ 1
> [    0.271024] initcall umwait_init+0x0/0xb0 returned -19 after 0 usecs
> [    0.271027] calling  sgx_init+0x0/0x480 @ 1
> [    0.271033] sgx: EPC section 0x70200000-0x75f7ffff
> [    0.271578] initcall sgx_init+0x0/0x480 returned 0 after 549 usecs
> [    0.271582] calling  ioapic_init_ops+0x0/0x20 @ 1
> [    0.271585] initcall ioapic_init_ops+0x0/0x20 returned 0 after 0 usecs
> [    0.271587] calling  add_pcspkr+0x0/0x80 @ 1
> [    0.271611] initcall add_pcspkr+0x0/0x80 returned 0 after 20 usecs
> [    0.271614] calling  snp_init_platform_device+0x0/0xa0 @ 1
> [    0.271617] initcall snp_init_platform_device+0x0/0xa0 returned -19 after 0 usecs
> [    0.271620] calling  audit_classes_init+0x0/0xc0 @ 1
> [    0.271626] initcall audit_classes_init+0x0/0xc0 returned 0 after 2 usecs
> [    0.271629] calling  pt_dump_init+0x0/0x60 @ 1
> [    0.271632] initcall pt_dump_init+0x0/0x60 returned 0 after 0 usecs
> [    0.271634] calling  iosf_mbi_init+0x0/0x30 @ 1
> [    0.271649] initcall iosf_mbi_init+0x0/0x30 returned 0 after 12 usecs
> [    0.271652] calling  proc_execdomains_init+0x0/0x30 @ 1
> [    0.271665] initcall proc_execdomains_init+0x0/0x30 returned 0 after 10 usecs
> [    0.271667] calling  register_warn_debugfs+0x0/0x30 @ 1
> [    0.271672] initcall register_warn_debugfs+0x0/0x30 returned 0 after 3 usecs
> [    0.271674] calling  cpuhp_sysfs_init+0x0/0xf0 @ 1
> [    0.271686] initcall cpuhp_sysfs_init+0x0/0xf0 returned 0 after 10 usecs
> [    0.271689] calling  ioresources_init+0x0/0x60 @ 1
> [    0.271693] initcall ioresources_init+0x0/0x60 returned 0 after 1 usecs
> [    0.271695] calling  psi_proc_init+0x0/0x80 @ 1
> [    0.271700] initcall psi_proc_init+0x0/0x80 returned 0 after 2 usecs
> [    0.271703] calling  snapshot_device_init+0x0/0x20 @ 1
> [    0.271732] initcall snapshot_device_init+0x0/0x20 returned 0 after 26 usecs
> [    0.271735] calling  irq_pm_init_ops+0x0/0x20 @ 1
> [    0.271738] initcall irq_pm_init_ops+0x0/0x20 returned 0 after 0 usecs
> [    0.271739] calling  klp_init+0x0/0x40 @ 1
> [    0.271743] initcall klp_init+0x0/0x40 returned 0 after 1 usecs
> [    0.271745] calling  proc_modules_init+0x0/0x30 @ 1
> [    0.271748] initcall proc_modules_init+0x0/0x30 returned 0 after 1 usecs
> [    0.271751] calling  timer_sysctl_init+0x0/0x30 @ 1
> [    0.271756] initcall timer_sysctl_init+0x0/0x30 returned 0 after 3 usecs
> [    0.271759] calling  timekeeping_init_ops+0x0/0x20 @ 1
> [    0.271761] initcall timekeeping_init_ops+0x0/0x20 returned 0 after 0 usecs
> [    0.271763] calling  init_clocksource_sysfs+0x0/0x30 @ 1
> [    0.271791] initcall init_clocksource_sysfs+0x0/0x30 returned 0 after 24 usecs
> [    0.271794] calling  init_timer_list_procfs+0x0/0x40 @ 1
> [    0.271797] initcall init_timer_list_procfs+0x0/0x40 returned 0 after 1 usecs
> [    0.271800] calling  alarmtimer_init+0x0/0xf0 @ 1
> [    0.271819] initcall alarmtimer_init+0x0/0xf0 returned 0 after 17 usecs
> [    0.271822] calling  init_posix_timers+0x0/0x40 @ 1
> [    0.271839] initcall init_posix_timers+0x0/0x40 returned 0 after 13 usecs
> [    0.271841] calling  clockevents_init_sysfs+0x0/0xd0 @ 1
> [    0.271899] initcall clockevents_init_sysfs+0x0/0xd0 returned 0 after 55 usecs
> [    0.271903] calling  proc_dma_init+0x0/0x30 @ 1
> [    0.271906] initcall proc_dma_init+0x0/0x30 returned 0 after 1 usecs
> [    0.271909] calling  kallsyms_init+0x0/0x30 @ 1
> [    0.271912] initcall kallsyms_init+0x0/0x30 returned 0 after 0 usecs
> [    0.271915] calling  pid_namespaces_init+0x0/0x70 @ 1
> [    0.271924] initcall pid_namespaces_init+0x0/0x70 returned 0 after 6 usecs
> [    0.271928] calling  audit_watch_init+0x0/0x50 @ 1
> [    0.271931] initcall audit_watch_init+0x0/0x50 returned 0 after 0 usecs
> [    0.271934] calling  audit_fsnotify_init+0x0/0x50 @ 1
> [    0.271937] initcall audit_fsnotify_init+0x0/0x50 returned 0 after 0 usecs
> [    0.271940] calling  audit_tree_init+0x0/0x80 @ 1
> [    0.271944] initcall audit_tree_init+0x0/0x80 returned 0 after 0 usecs
> [    0.271947] calling  seccomp_sysctl_init+0x0/0x30 @ 1
> [    0.271951] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 2 usecs
> [    0.271953] calling  utsname_sysctl_init+0x0/0x30 @ 1
> [    0.271959] initcall utsname_sysctl_init+0x0/0x30 returned 0 after 4 usecs
> [    0.271961] calling  init_tracepoints+0x0/0x40 @ 1
> [    0.271965] initcall init_tracepoints+0x0/0x40 returned 0 after 1 usecs
> [    0.271967] calling  stack_trace_init+0x0/0xc0 @ 1
> [    0.271976] initcall stack_trace_init+0x0/0xc0 returned 0 after 6 usecs
> [    0.271978] calling  init_mmio_trace+0x0/0x10 @ 1
> [    0.271982] initcall init_mmio_trace+0x0/0x10 returned 0 after 1 usecs
> [    0.271985] calling  init_blk_tracer+0x0/0x60 @ 1
> [    0.272002] initcall init_blk_tracer+0x0/0x60 returned 0 after 14 usecs
> [    0.272005] calling  perf_event_sysfs_init+0x0/0xa0 @ 1
> [    0.272134] initcall perf_event_sysfs_init+0x0/0xa0 returned 0 after 126 usecs
> [    0.272136] calling  system_trusted_keyring_init+0x0/0x100 @ 1
> [    0.272139] Initialise system trusted keyrings
> [    0.272146] initcall system_trusted_keyring_init+0x0/0x100 returned 0 after 7 usecs
> [    0.272148] calling  blacklist_init+0x0/0x100 @ 1
> [    0.272151] Key type blacklist registered
> [    0.272154] initcall blacklist_init+0x0/0x100 returned 0 after 3 usecs
> [    0.272156] calling  kswapd_init+0x0/0x60 @ 1
> [    0.272217] initcall kswapd_init+0x0/0x60 returned 0 after 59 usecs
> [    0.272230] calling  extfrag_debug_init+0x0/0x60 @ 1
> [    0.272255] initcall extfrag_debug_init+0x0/0x60 returned 0 after 18 usecs
> [    0.272261] calling  mm_compute_batch_init+0x0/0x80 @ 1
> [    0.272269] initcall mm_compute_batch_init+0x0/0x80 returned 0 after 1 usecs
> [    0.272275] calling  slab_proc_init+0x0/0x30 @ 1
> [    0.272288] initcall slab_proc_init+0x0/0x30 returned 0 after 6 usecs
> [    0.272295] calling  workingset_init+0x0/0xd0 @ 1
> [    0.272303] workingset: timestamp_bits=36 max_order=22 bucket_order=0
> [    0.272309] initcall workingset_init+0x0/0xd0 returned 0 after 6 usecs
> [    0.272316] calling  proc_vmalloc_init+0x0/0x40 @ 1
> [    0.272330] initcall proc_vmalloc_init+0x0/0x40 returned 0 after 6 usecs
> [    0.272338] calling  slab_debugfs_init+0x0/0x70 @ 1
> [    0.272355] initcall slab_debugfs_init+0x0/0x70 returned 0 after 10 usecs
> [    0.272363] calling  procswaps_init+0x0/0x30 @ 1
> [    0.272371] initcall procswaps_init+0x0/0x30 returned 0 after 2 usecs
> [    0.272375] calling  init_zbud+0x0/0x30 @ 1
> [    0.272381] zbud: loaded
> [    0.272383] initcall init_zbud+0x0/0x30 returned 0 after 2 usecs
> [    0.272389] calling  zs_init+0x0/0x50 @ 1
> [    0.272408] initcall zs_init+0x0/0x50 returned 0 after 13 usecs
> [    0.272413] calling  fcntl_init+0x0/0x40 @ 1
> [    0.272424] initcall fcntl_init+0x0/0x40 returned 0 after 4 usecs
> [    0.272430] calling  proc_filesystems_init+0x0/0x30 @ 1
> [    0.272438] initcall proc_filesystems_init+0x0/0x30 returned 0 after 1 usecs
> [    0.272446] calling  start_dirtytime_writeback+0x0/0x40 @ 1
> [    0.272455] initcall start_dirtytime_writeback+0x0/0x40 returned 0 after 1 usecs
> [    0.272462] calling  dio_init+0x0/0x40 @ 1
> [    0.272471] initcall dio_init+0x0/0x40 returned 0 after 1 usecs
> [    0.272479] calling  dnotify_init+0x0/0xb0 @ 1
> [    0.272537] initcall dnotify_init+0x0/0xb0 returned 0 after 50 usecs
> [    0.272544] calling  fanotify_user_setup+0x0/0x170 @ 1
> [    0.272565] initcall fanotify_user_setup+0x0/0x170 returned 0 after 13 usecs
> [    0.272574] calling  userfaultfd_init+0x0/0x70 @ 1
> [    0.272679] initcall userfaultfd_init+0x0/0x70 returned 0 after 98 usecs
> [    0.272687] calling  aio_setup+0x0/0xa0 @ 1
> [    0.272754] initcall aio_setup+0x0/0xa0 returned 0 after 59 usecs
> [    0.272762] calling  init_devpts_fs+0x0/0x50 @ 1
> [    0.272779] initcall init_devpts_fs+0x0/0x50 returned 0 after 10 usecs
> [    0.272785] calling  fuse_init+0x0/0x200 @ 1
> [    0.272791] fuse: init (API version 7.39)
> [    0.272867] initcall fuse_init+0x0/0x200 returned 0 after 76 usecs
> [    0.272875] calling  virtio_fs_init+0x0/0x50 @ 1
> [    0.272893] initcall virtio_fs_init+0x0/0x50 returned 0 after 12 usecs
> [    0.272900] calling  ipc_init+0x0/0x30 @ 1
> [    0.272916] initcall ipc_init+0x0/0x30 returned 0 after 11 usecs
> [    0.272923] calling  ipc_sysctl_init+0x0/0x40 @ 1
> [    0.272957] initcall ipc_sysctl_init+0x0/0x40 returned 0 after 28 usecs
> [    0.272964] calling  init_mqueue_fs+0x0/0xc0 @ 1
> [    0.273014] initcall init_mqueue_fs+0x0/0xc0 returned 0 after 43 usecs
> [    0.273021] calling  key_proc_init+0x0/0x70 @ 1
> [    0.273030] initcall key_proc_init+0x0/0x70 returned 0 after 2 usecs
> [    0.273037] calling  selinux_nf_ip_init+0x0/0x50 @ 1
> [    0.273045] initcall selinux_nf_ip_init+0x0/0x50 returned 0 after 0 usecs
> [    0.273052] calling  init_sel_fs+0x0/0x130 @ 1
> [    0.273059] initcall init_sel_fs+0x0/0x130 returned 0 after 0 usecs
> [    0.273065] calling  selnl_init+0x0/0xb0 @ 1
> [    0.273094] initcall selnl_init+0x0/0xb0 returned 0 after 21 usecs
> [    0.273102] calling  sel_netif_init+0x0/0x40 @ 1
> [    0.273109] initcall sel_netif_init+0x0/0x40 returned 0 after 0 usecs
> [    0.273116] calling  sel_netnode_init+0x0/0x40 @ 1
> [    0.273123] initcall sel_netnode_init+0x0/0x40 returned 0 after 0 usecs
> [    0.273130] calling  sel_netport_init+0x0/0x40 @ 1
> [    0.273136] initcall sel_netport_init+0x0/0x40 returned 0 after 0 usecs
> [    0.273144] calling  aurule_init+0x0/0x40 @ 1
> [    0.273151] initcall aurule_init+0x0/0x40 returned 0 after 0 usecs
> [    0.273158] calling  apparmor_nf_ip_init+0x0/0x40 @ 1
> [    0.273255] initcall apparmor_nf_ip_init+0x0/0x40 returned 0 after 89 usecs
> [    0.273264] calling  platform_keyring_init+0x0/0x30 @ 1
> [    0.273281] integrity: Platform Keyring initialized
> [    0.273284] initcall platform_keyring_init+0x0/0x30 returned 0 after 11 usecs
> [    0.273292] calling  machine_keyring_init+0x0/0x30 @ 1
> [    0.273301] integrity: Machine keyring initialized
> [    0.273303] initcall machine_keyring_init+0x0/0x30 returned 0 after 6 usecs
> [    0.273308] calling  asymmetric_key_init+0x0/0x20 @ 1
> [    0.273317] Key type asymmetric registered
> [    0.273319] initcall asymmetric_key_init+0x0/0x20 returned 0 after 4 usecs
> [    0.273326] calling  x509_key_init+0x0/0x20 @ 1
> [    0.273332] Asymmetric key parser 'x509' registered
> [    0.273335] initcall x509_key_init+0x0/0x20 returned 0 after 2 usecs
> [    0.273340] calling  crypto_kdf108_init+0x0/0x190 @ 1
> [    0.299260] Freeing initrd memory: 18596K
> [    0.302782] alg: self-tests disabled
> [    0.302818] initcall crypto_kdf108_init+0x0/0x190 returned 0 after 29470 usecs
> [    0.302825] calling  blkdev_init+0x0/0x30 @ 1
> [    0.302833] initcall blkdev_init+0x0/0x30 returned 0 after 5 usecs
> [    0.302835] calling  proc_genhd_init+0x0/0x50 @ 1
> [    0.302840] initcall proc_genhd_init+0x0/0x50 returned 0 after 2 usecs
> [    0.302842] calling  bsg_init+0x0/0xa0 @ 1
> [    0.302852] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [    0.302853] initcall bsg_init+0x0/0xa0 returned 0 after 8 usecs
> [    0.302855] calling  throtl_init+0x0/0x40 @ 1
> [    0.302884] initcall throtl_init+0x0/0x40 returned 0 after 27 usecs
> [    0.302887] calling  ioc_init+0x0/0x20 @ 1
> [    0.302892] initcall ioc_init+0x0/0x20 returned 0 after 3 usecs
> [    0.302894] calling  deadline_init+0x0/0x20 @ 1
> [    0.302896] io scheduler mq-deadline registered
> [    0.302897] initcall deadline_init+0x0/0x20 returned 0 after 1 usecs
> [    0.302900] calling  io_uring_init+0x0/0x90 @ 1
> [    0.302913] initcall io_uring_init+0x0/0x90 returned 0 after 11 usecs
> [    0.302915] calling  blake2s_mod_init+0x0/0x30 @ 1
> [    0.303254] initcall blake2s_mod_init+0x0/0x30 returned 0 after 336 usecs
> [    0.303257] calling  percpu_counter_startup+0x0/0x70 @ 1
> [    0.303279] initcall percpu_counter_startup+0x0/0x70 returned 0 after 20 usecs
> [    0.303282] calling  digsig_init+0x0/0x50 @ 1
> [    0.303304] initcall digsig_init+0x0/0x50 returned 0 after 19 usecs
> [    0.303307] calling  phy_core_init+0x0/0x70 @ 1
> [    0.303315] initcall phy_core_init+0x0/0x70 returned 0 after 6 usecs
> [    0.303317] calling  amd_gpio_driver_init+0x0/0x20 @ 1
> [    0.303339] initcall amd_gpio_driver_init+0x0/0x20 returned 0 after 19 usecs
> [    0.303342] calling  cnl_pinctrl_driver_init+0x0/0x20 @ 1
> [    0.303351] initcall cnl_pinctrl_driver_init+0x0/0x20 returned 0 after 7 usecs
> [    0.303354] calling  icl_pinctrl_driver_init+0x0/0x20 @ 1
> [    0.303362] initcall icl_pinctrl_driver_init+0x0/0x20 returned 0 after 5 usecs
> [    0.303365] calling  lbg_pinctrl_driver_init+0x0/0x20 @ 1
> [    0.303374] initcall lbg_pinctrl_driver_init+0x0/0x20 returned 0 after 6 usecs
> [    0.303376] calling  tgl_pinctrl_driver_init+0x0/0x20 @ 1
> [    0.303385] initcall tgl_pinctrl_driver_init+0x0/0x20 returned 0 after 5 usecs
> [    0.303387] calling  crystalcove_pwm_driver_init+0x0/0x20 @ 1
> [    0.303395] initcall crystalcove_pwm_driver_init+0x0/0x20 returned 0 after 5 usecs
> [    0.303398] calling  pcie_portdrv_init+0x0/0x60 @ 1
> [    0.303645] probe of 0000:00:1c.0 returned 0 after 231 usecs
> [    0.303807] probe of 0000:00:1c.4 returned 0 after 159 usecs
> [    0.303952] probe of 0000:00:1d.0 returned 0 after 142 usecs
> [    0.303958] initcall pcie_portdrv_init+0x0/0x60 returned 0 after 559 usecs
> [    0.303960] calling  pci_proc_init+0x0/0x80 @ 1
> [    0.303976] initcall pci_proc_init+0x0/0x80 returned 0 after 13 usecs
> [    0.303977] calling  pci_hotplug_init+0x0/0x50 @ 1
> [    0.303979] initcall pci_hotplug_init+0x0/0x50 returned 0 after 0 usecs
> [    0.303980] calling  shpcd_init+0x0/0x70 @ 1
> [    0.303987] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.303987] initcall shpcd_init+0x0/0x70 returned 0 after 5 usecs
> [    0.303989] calling  xenfb_init+0x0/0x50 @ 1
> [    0.303991] initcall xenfb_init+0x0/0x50 returned -19 after 0 usecs
> [    0.303993] calling  vesafb_driver_init+0x0/0x20 @ 1
> [    0.304001] initcall vesafb_driver_init+0x0/0x20 returned 0 after 6 usecs
> [    0.304003] calling  efifb_driver_init+0x0/0x20 @ 1
> [    0.304008] initcall efifb_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.304010] calling  simplefb_driver_init+0x0/0x20 @ 1
> [    0.304016] initcall simplefb_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.304018] calling  intel_idle_init+0x0/0xd00 @ 1
> [    0.304225] initcall intel_idle_init+0x0/0xd00 returned 0 after 205 usecs
> [    0.304228] calling  ged_driver_init+0x0/0x20 @ 1
> [    0.304238] initcall ged_driver_init+0x0/0x20 returned 0 after 7 usecs
> [    0.304241] calling  acpi_processor_driver_init+0x0/0xc0 @ 1
> [    0.304285] probe of cpu0 returned 0 after 40 usecs
> [    0.304316] probe of cpu1 returned 0 after 28 usecs
> [    0.304344] probe of cpu2 returned 0 after 26 usecs
> [    0.304372] probe of cpu3 returned 0 after 26 usecs
> [    0.304379] initcall acpi_processor_driver_init+0x0/0xc0 returned 0 after 136 usecs
> [    0.304380] calling  acpi_thermal_init+0x0/0x80 @ 1
> [    0.306167] thermal LNXTHERM:00: registered as thermal_zone0
> [    0.306169] ACPI: thermal: Thermal Zone [THM] (25 C)
> [    0.306174] probe of LNXTHERM:00 returned 0 after 1708 usecs
> [    0.306179] initcall acpi_thermal_init+0x0/0x80 returned 0 after 1797 usecs
> [    0.306181] calling  acpi_hed_driver_init+0x0/0x20 @ 1
> [    0.306205] initcall acpi_hed_driver_init+0x0/0x20 returned 0 after 21 usecs
> [    0.306207] calling  bgrt_init+0x0/0xd0 @ 1
> [    0.306218] initcall bgrt_init+0x0/0xd0 returned 0 after 9 usecs
> [    0.306220] calling  erst_init+0x0/0x370 @ 1
> [    0.306226] initcall erst_init+0x0/0x370 returned 0 after 4 usecs
> [    0.306228] calling  extlog_init+0x0/0x390 @ 1
> [    0.306230] initcall extlog_init+0x0/0x390 returned -19 after 0 usecs
> [    0.306232] calling  intel_crc_pmic_opregion_driver_init+0x0/0x20 @ 1
> [    0.306240] initcall intel_crc_pmic_opregion_driver_init+0x0/0x20 returned 0 after 6 usecs
> [    0.306242] calling  intel_chtcrc_pmic_opregion_driver_init+0x0/0x20 @ 1
> [    0.306248] initcall intel_chtcrc_pmic_opregion_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306250] calling  intel_cht_wc_pmic_opregion_driver_init+0x0/0x20 @ 1
> [    0.306256] initcall intel_cht_wc_pmic_opregion_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306258] calling  gpio_clk_driver_init+0x0/0x20 @ 1
> [    0.306265] initcall gpio_clk_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306267] calling  fch_clk_driver_init+0x0/0x20 @ 1
> [    0.306272] initcall fch_clk_driver_init+0x0/0x20 returned 0 after 3 usecs
> [    0.306274] calling  plt_clk_driver_init+0x0/0x20 @ 1
> [    0.306281] initcall plt_clk_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306283] calling  virtio_pci_driver_init+0x0/0x20 @ 1
> [    0.306289] initcall virtio_pci_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306291] calling  xenbus_probe_initcall+0x0/0xb0 @ 1
> [    0.306294] initcall xenbus_probe_initcall+0x0/0xb0 returned -19 after 0 usecs
> [    0.306296] calling  xenbus_init+0x0/0x50 @ 1
> [    0.306298] initcall xenbus_init+0x0/0x50 returned -19 after 0 usecs
> [    0.306300] calling  xenbus_backend_init+0x0/0x60 @ 1
> [    0.306302] initcall xenbus_backend_init+0x0/0x60 returned -19 after 0 usecs
> [    0.306305] calling  hyper_sysfs_init+0x0/0x240 @ 1
> [    0.306307] initcall hyper_sysfs_init+0x0/0x240 returned -19 after 0 usecs
> [    0.306309] calling  hypervisor_subsys_init+0x0/0x40 @ 1
> [    0.306311] initcall hypervisor_subsys_init+0x0/0x40 returned -19 after 0 usecs
> [    0.306314] calling  platform_driver_init+0x0/0x20 @ 1
> [    0.306320] initcall platform_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306322] calling  xen_late_init_mcelog+0x0/0x80 @ 1
> [    0.306324] initcall xen_late_init_mcelog+0x0/0x80 returned -19 after 0 usecs
> [    0.306327] calling  n_null_init+0x0/0x30 @ 1
> [    0.306329] initcall n_null_init+0x0/0x30 returned 0 after 0 usecs
> [    0.306332] calling  pty_init+0x0/0x230 @ 1
> [    0.306406] initcall pty_init+0x0/0x230 returned 0 after 72 usecs
> [    0.306409] calling  sysrq_init+0x0/0x80 @ 1
> [    0.306412] initcall sysrq_init+0x0/0x80 returned 0 after 1 usecs
> [    0.306415] calling  xen_hvc_init+0x0/0x210 @ 1
> [    0.306417] initcall xen_hvc_init+0x0/0x210 returned -19 after 0 usecs
> [    0.306420] calling  serial8250_init+0x0/0x1d0 @ 1
> [    0.306421] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.306477] probe of serial8250:0 returned 0 after 3 usecs
> [    0.306489] probe of serial8250:0.0 returned 0 after 2 usecs
> [    0.306597] probe of serial8250:0.1 returned 0 after 2 usecs
> [    0.306693] probe of serial8250:0.2 returned 0 after 2 usecs
> [    0.306789] probe of serial8250:0.3 returned 0 after 2 usecs
> [    0.306882] probe of serial8250 returned 0 after 3 usecs
> [    0.306885] initcall serial8250_init+0x0/0x1d0 returned 0 after 463 usecs
> [    0.306887] calling  dw8250_platform_driver_init+0x0/0x20 @ 1
> [    0.306904] initcall dw8250_platform_driver_init+0x0/0x20 returned 0 after 15 usecs
> [    0.306905] calling  mid8250_pci_driver_init+0x0/0x20 @ 1
> [    0.306912] initcall mid8250_pci_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306913] calling  serial_pci_driver_init+0x0/0x20 @ 1
> [    0.306926] initcall serial_pci_driver_init+0x0/0x20 returned 0 after 11 usecs
> [    0.306928] calling  pericom8250_pci_driver_init+0x0/0x20 @ 1
> [    0.306934] initcall pericom8250_pci_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.306935] calling  random_sysctls_init+0x0/0x30 @ 1
> [    0.306941] initcall random_sysctls_init+0x0/0x30 returned 0 after 3 usecs
> [    0.306942] calling  hpet_init+0x0/0xa0 @ 1
> [    0.307075] hpet_acpi_add: no address or irqs in _CRS
> [    0.307078] probe of PNP0103:00 returned 19 after 73 usecs
> [    0.307094] initcall hpet_init+0x0/0xa0 returned 0 after 150 usecs
> [    0.307096] calling  agp_init+0x0/0x40 @ 1
> [    0.307098] Linux agpgart interface v0.103
> [    0.307098] initcall agp_init+0x0/0x40 returned 0 after 0 usecs
> [    0.307100] calling  agp_amd64_mod_init+0x0/0x30 @ 1
> [    0.307110] initcall agp_amd64_mod_init+0x0/0x30 returned -19 after 8 usecs
> [    0.307112] calling  agp_intel_init+0x0/0x40 @ 1
> [    0.307119] initcall agp_intel_init+0x0/0x40 returned 0 after 5 usecs
> [    0.307120] calling  agp_sis_init+0x0/0x40 @ 1
> [    0.307126] initcall agp_sis_init+0x0/0x40 returned 0 after 4 usecs
> [    0.307128] calling  agp_via_init+0x0/0x40 @ 1
> [    0.307134] initcall agp_via_init+0x0/0x40 returned 0 after 4 usecs
> [    0.307136] calling  init_tis+0x0/0x100 @ 1
> [    0.319359] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> [    0.359044] probe of MSFT0101:00 returned 0 after 51903 usecs
> [    0.359066] initcall init_tis+0x0/0x100 returned 0 after 51928 usecs
> [    0.359072] calling  crb_acpi_driver_init+0x0/0x20 @ 1
> [    0.359129] probe of MSFT0101:00 returned 19 after 8 usecs
> [    0.359136] initcall crb_acpi_driver_init+0x0/0x20 returned 0 after 61 usecs
> [    0.359139] calling  cn_proc_init+0x0/0x50 @ 1
> [    0.359142] initcall cn_proc_init+0x0/0x50 returned 0 after 0 usecs
> [    0.359144] calling  topology_sysfs_init+0x0/0x30 @ 1
> [    0.359172] initcall topology_sysfs_init+0x0/0x30 returned 0 after 25 usecs
> [    0.359175] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
> [    0.359452] initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 275 usecs
> [    0.359459] calling  devcoredump_init+0x0/0x20 @ 1
> [    0.359468] initcall devcoredump_init+0x0/0x20 returned 0 after 5 usecs
> [    0.359472] calling  crystal_cove_i2c_driver_init+0x0/0x20 @ 1
> [    0.359480] initcall crystal_cove_i2c_driver_init+0x0/0x20 returned 0 after 5 usecs
> [    0.359483] calling  cht_wc_driver_init+0x0/0x20 @ 1
> [    0.359488] initcall cht_wc_driver_init+0x0/0x20 returned 0 after 2 usecs
> [    0.359490] calling  cxl_port_driver_init+0x0/0x20 @ 1
> [    0.359497] initcall cxl_port_driver_init+0x0/0x20 returned 0 after 4 usecs
> [    0.359500] calling  mac_hid_init+0x0/0x40 @ 1
> [    0.359505] initcall mac_hid_init+0x0/0x40 returned 0 after 2 usecs
> [    0.359507] calling  spidev_init+0x0/0xa0 @ 1
> [    0.359518] initcall spidev_init+0x0/0xa0 returned 0 after 7 usecs
> [    0.359520] calling  blackhole_netdev_init+0x0/0x90 @ 1
> [    0.359532] initcall blackhole_netdev_init+0x0/0x90 returned 0 after 9 usecs
> [    0.359536] calling  i8042_init+0x0/0x7f0 @ 1
> [    0.359569] probe of 00:03 returned 0 after 9 usecs
> [    0.359582] probe of 00:04 returned 0 after 3 usecs
> [    0.359586] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    0.363968] i8042: Warning: Keylock active
> [    0.366205] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.366210] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    0.366241] probe of i8042 returned 0 after 6606 usecs
> [    0.366243] initcall i8042_init+0x0/0x7f0 returned 0 after 6704 usecs
> [    0.366247] calling  input_leds_init+0x0/0x20 @ 1
> [    0.366249] initcall input_leds_init+0x0/0x20 returned 0 after 0 usecs
> [    0.366251] calling  mousedev_init+0x0/0xe0 @ 1
> [    0.366376] mousedev: PS/2 mouse device common for all mice
> [    0.366378] initcall mousedev_init+0x0/0xe0 returned 0 after 125 usecs
> [    0.366381] calling  atkbd_init+0x0/0x30 @ 1
> [    0.366392] initcall atkbd_init+0x0/0x30 returned 0 after 9 usecs
> [    0.366393] calling  xenkbd_init+0x0/0x50 @ 1
> [    0.366395] initcall xenkbd_init+0x0/0x50 returned -19 after 0 usecs
> [    0.366396] calling  cmos_init+0x0/0x90 @ 1
> [    0.366405] rtc_cmos 00:01: RTC can wake from S4
> [    0.367093] probe of alarmtimer.0.auto returned 0 after 3 usecs
> [    0.367108] rtc_cmos 00:01: registered as rtc0
> [    0.367252] rtc_cmos 00:01: setting system clock to 2024-02-06T20:43:23 UTC (1707252203)
> [    0.367276] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
> [    0.367280] probe of 00:01 returned 0 after 879 usecs
> [    0.367284] initcall cmos_init+0x0/0x90 returned 0 after 885 usecs
> [    0.367286] calling  thermal_throttle_init_device+0x0/0x50 @ 1
> [    0.367370] initcall thermal_throttle_init_device+0x0/0x50 returned 0 after 82 usecs
> [    0.367373] calling  amd_pstate_init+0x0/0x260 @ 1
> [    0.367374] initcall amd_pstate_init+0x0/0x260 returned -19 after 0 usecs
> [    0.367376] calling  intel_pstate_init+0x0/0x880 @ 1
> [    0.367379] intel_pstate: Intel P-state driver initializing
> [    0.367587] intel_pstate: HWP enabled
> [    0.367588] initcall intel_pstate_init+0x0/0x880 returned 0 after 210 usecs
> [    0.367590] calling  haltpoll_init+0x0/0x140 @ 1
> [    0.367592] initcall haltpoll_init+0x0/0x140 returned -19 after 0 usecs
> [    0.367594] calling  ledtrig_cpu_init+0x0/0xf0 @ 1
> [    0.367721] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.367721] initcall ledtrig_cpu_init+0x0/0xf0 returned 0 after 111 usecs
> [    0.367723] calling  ledtrig_panic_init+0x0/0x60 @ 1
> [    0.367726] initcall ledtrig_panic_init+0x0/0x60 returned 0 after 0 usecs
> [    0.367727] calling  dmi_sysfs_init+0x0/0x140 @ 1
> [    0.368028] initcall dmi_sysfs_init+0x0/0x140 returned 0 after 298 usecs
> [    0.368031] calling  sysfb_init+0x0/0x110 @ 1
> [    0.368065] efifb: probing for efifb
> [    0.368077] efifb: framebuffer at 0x90000000, using 22500k, total 22500k
> [    0.368078] efifb: mode is 3200x1800x32, linelength=12800, pages=1
> [    0.368080] efifb: scrolling: redraw
> [    0.368080] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.368121] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    0.368172] probe of serio0 returned 0 after 1136 usecs
> [    0.368199] Console: switching to colour frame buffer device 200x56
> [    0.371771] fb0: EFI VGA frame buffer device
> [    0.371776] probe of efi-framebuffer.0 returned 0 after 3713 usecs
> [    0.371778] initcall sysfb_init+0x0/0x110 returned 0 after 3745 usecs
> [    0.371782] calling  coreboot_table_driver_init+0x0/0x50 @ 1
> [    0.371802] initcall coreboot_table_driver_init+0x0/0x50 returned 0 after 18 usecs
> [    0.371805] calling  framebuffer_driver_init+0x0/0x20 @ 1
> [    0.371810] initcall framebuffer_driver_init+0x0/0x20 returned 0 after 2 usecs
> [    0.371812] calling  esrt_sysfs_init+0x0/0x350 @ 1
> [    0.371824] initcall esrt_sysfs_init+0x0/0x350 returned 0 after 10 usecs
> [    0.371827] calling  pmc_atom_init+0x0/0x2a0 @ 1
> [    0.371844] initcall pmc_atom_init+0x0/0x2a0 returned -19 after 14 usecs
> [    0.371846] calling  vmgenid_driver_init+0x0/0x20 @ 1
> [    0.371880] initcall vmgenid_driver_init+0x0/0x20 returned 0 after 31 usecs
> [    0.371883] calling  cxl_pmu_init+0x0/0x80 @ 1
> [    0.371888] initcall cxl_pmu_init+0x0/0x80 returned 0 after 3 usecs
> [    0.371891] calling  sock_diag_init+0x0/0x40 @ 1
> [    0.371904] initcall sock_diag_init+0x0/0x40 returned 0 after 11 usecs
> [    0.371906] calling  blackhole_init+0x0/0x20 @ 1
> [    0.371908] initcall blackhole_init+0x0/0x20 returned 0 after 1 usecs
> [    0.371910] calling  fq_codel_module_init+0x0/0x20 @ 1
> [    0.371912] initcall fq_codel_module_init+0x0/0x20 returned 0 after 0 usecs
> [    0.371913] calling  gre_offload_init+0x0/0x60 @ 1
> [    0.371917] initcall gre_offload_init+0x0/0x60 returned 0 after 0 usecs
> [    0.371919] calling  sysctl_ipv4_init+0x0/0x60 @ 1
> [    0.371970] initcall sysctl_ipv4_init+0x0/0x60 returned 0 after 49 usecs
> [    0.371972] calling  cubictcp_register+0x0/0x90 @ 1
> [    0.371975] initcall cubictcp_register+0x0/0x90 returned 0 after 0 usecs
> [    0.371977] calling  inet6_init+0x0/0x3c0 @ 1
> [    0.372008] NET: Registered PF_INET6 protocol family
> [    0.374532] probe of serio1 returned 19 after 6358 usecs
> [    0.376079] Segment Routing with IPv6
> [    0.376090] In-situ OAM (IOAM) with IPv6
> [    0.376113] initcall inet6_init+0x0/0x3c0 returned 0 after 4133 usecs
> [    0.376121] calling  mip6_init+0x0/0xc0 @ 1
> [    0.376123] mip6: Mobile IPv6
> [    0.376123] initcall mip6_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.376125] calling  packet_init+0x0/0x90 @ 1
> [    0.376129] NET: Registered PF_PACKET protocol family
> [    0.376130] initcall packet_init+0x0/0x90 returned 0 after 3 usecs
> [    0.376132] calling  strp_dev_init+0x0/0x40 @ 1
> [    0.376231] initcall strp_dev_init+0x0/0x40 returned 0 after 97 usecs
> [    0.376235] calling  dcbnl_init+0x0/0x60 @ 1
> [    0.376239] initcall dcbnl_init+0x0/0x60 returned 0 after 1 usecs
> [    0.376241] calling  mpls_gso_init+0x0/0x40 @ 1
> [    0.376243] mpls_gso: MPLS GSO support
> [    0.376244] initcall mpls_gso_init+0x0/0x40 returned 0 after 1 usecs
> [    0.376245] calling  pm_check_save_msr+0x0/0xd0 @ 1
> [    0.376253] initcall pm_check_save_msr+0x0/0xd0 returned 0 after 4 usecs
> [    0.376254] calling  mcheck_init_device+0x0/0x160 @ 1
> [    0.376471] initcall mcheck_init_device+0x0/0x160 returned 0 after 213 usecs
> [    0.376506] calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x30 @ 1
> [    0.376511] initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x30 returned 0 after 2 usecs
> [    0.376513] calling  tboot_late_init+0x0/0x390 @ 1
> [    0.376515] initcall tboot_late_init+0x0/0x390 returned 0 after 0 usecs
> [    0.376516] calling  sld_mitigate_sysctl_init+0x0/0x30 @ 1
> [    0.376521] initcall sld_mitigate_sysctl_init+0x0/0x30 returned 0 after 2 usecs
> [    0.376523] calling  intel_epb_init+0x0/0xa0 @ 1
> [    0.376527] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.376630] initcall intel_epb_init+0x0/0xa0 returned 0 after 104 usecs
> [    0.376632] calling  mcheck_late_init+0x0/0xa0 @ 1
> [    0.376639] initcall mcheck_late_init+0x0/0xa0 returned 0 after 4 usecs
> [    0.376641] calling  severities_debugfs_init+0x0/0x40 @ 1
> [    0.376644] initcall severities_debugfs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.376647] calling  microcode_init+0x0/0x1f0 @ 1
> [    0.376649] microcode: Current revision: 0x000000f4
> [    0.376651] microcode: Updated early from: 0x000000f0
> [    0.376758] initcall microcode_init+0x0/0x1f0 returned 0 after 108 usecs
> [    0.376761] calling  resctrl_late_init+0x0/0x7b0 @ 1
> [    0.376762] initcall resctrl_late_init+0x0/0x7b0 returned -19 after 0 usecs
> [    0.376764] calling  cpu_init_debugfs+0x0/0xe0 @ 1
> [    0.376773] initcall cpu_init_debugfs+0x0/0xe0 returned 0 after 7 usecs
> [    0.376775] calling  hpet_insert_resource+0x0/0x30 @ 1
> [    0.376778] initcall hpet_insert_resource+0x0/0x30 returned 0 after 1 usecs
> [    0.376779] calling  start_sync_check_timer+0x0/0x60 @ 1
> [    0.376782] initcall start_sync_check_timer+0x0/0x60 returned 0 after 0 usecs
> [    0.376785] calling  update_mp_table+0x0/0x660 @ 1
> [    0.376787] initcall update_mp_table+0x0/0x660 returned 0 after 0 usecs
> [    0.376790] calling  lapic_insert_resource+0x0/0x50 @ 1
> [    0.376792] initcall lapic_insert_resource+0x0/0x50 returned 0 after 0 usecs
> [    0.376793] calling  print_ipi_mode+0x0/0x40 @ 1
> [    0.376795] IPI shorthand broadcast: enabled
> [    0.376796] initcall print_ipi_mode+0x0/0x40 returned 0 after 1 usecs
> [    0.376797] calling  print_ICs+0x0/0x1d0 @ 1
> [    0.376799] initcall print_ICs+0x0/0x1d0 returned 0 after 0 usecs
> [    0.376800] calling  setup_efi_kvm_sev_migration+0x0/0x1c0 @ 1
> [    0.376803] initcall setup_efi_kvm_sev_migration+0x0/0x1c0 returned 0 after 0 usecs
> [    0.376805] calling  create_tlb_single_page_flush_ceiling+0x0/0x40 @ 1
> [    0.376808] initcall create_tlb_single_page_flush_ceiling+0x0/0x40 returned 0 after 0 usecs
> [    0.376810] calling  pat_memtype_list_init+0x0/0x50 @ 1
> [    0.376813] initcall pat_memtype_list_init+0x0/0x50 returned 0 after 1 usecs
> [    0.376815] calling  create_init_pkru_value+0x0/0x40 @ 1
> [    0.376817] initcall create_init_pkru_value+0x0/0x40 returned 0 after 0 usecs
> [    0.376819] calling  kernel_panic_sysctls_init+0x0/0x30 @ 1
> [    0.376823] initcall kernel_panic_sysctls_init+0x0/0x30 returned 0 after 2 usecs
> [    0.376825] calling  kernel_panic_sysfs_init+0x0/0x30 @ 1
> [    0.376827] initcall kernel_panic_sysfs_init+0x0/0x30 returned 0 after 1 usecs
> [    0.376828] calling  kernel_exit_sysctls_init+0x0/0x30 @ 1
> [    0.376831] initcall kernel_exit_sysctls_init+0x0/0x30 returned 0 after 0 usecs
> [    0.376833] calling  kernel_exit_sysfs_init+0x0/0x30 @ 1
> [    0.376835] initcall kernel_exit_sysfs_init+0x0/0x30 returned 0 after 0 usecs
> [    0.376836] calling  param_sysfs_builtin_init+0x0/0x200 @ 1
> [    0.377835] initcall param_sysfs_builtin_init+0x0/0x200 returned 0 after 996 usecs
> [    0.377845] calling  reboot_ksysfs_init+0x0/0x80 @ 1
> [    0.377852] initcall reboot_ksysfs_init+0x0/0x80 returned 0 after 4 usecs
> [    0.377854] calling  sched_core_sysctl_init+0x0/0x30 @ 1
> [    0.377858] initcall sched_core_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.377860] calling  sched_fair_sysctl_init+0x0/0x30 @ 1
> [    0.377864] initcall sched_fair_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.377866] calling  sched_rt_sysctl_init+0x0/0x30 @ 1
> [    0.377869] initcall sched_rt_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.377871] calling  sched_dl_sysctl_init+0x0/0x30 @ 1
> [    0.377874] initcall sched_dl_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.377876] calling  sched_clock_init_late+0x0/0xb0 @ 1
> [    0.377883] sched_clock: Marking stable (372004225, 5837177)->(408041193, -30199791)
> [    0.377947] initcall sched_clock_init_late+0x0/0xb0 returned 0 after 64 usecs
> [    0.377949] calling  sched_init_debug+0x0/0x230 @ 1
> [    0.377964] initcall sched_init_debug+0x0/0x230 returned 0 after 12 usecs
> [    0.377966] calling  sched_energy_aware_sysctl_init+0x0/0x30 @ 1
> [    0.377969] initcall sched_energy_aware_sysctl_init+0x0/0x30 returned 0 after 0 usecs
> [    0.377972] calling  cpu_latency_qos_init+0x0/0x50 @ 1
> [    0.378035] initcall cpu_latency_qos_init+0x0/0x50 returned 0 after 60 usecs
> [    0.378038] calling  pm_debugfs_init+0x0/0x30 @ 1
> [    0.378041] initcall pm_debugfs_init+0x0/0x30 returned 0 after 1 usecs
> [    0.378043] calling  printk_late_init+0x0/0x180 @ 1
> [    0.378049] initcall printk_late_init+0x0/0x180 returned 0 after 3 usecs
> [    0.378050] calling  init_srcu_module_notifier+0x0/0x40 @ 1
> [    0.378053] initcall init_srcu_module_notifier+0x0/0x40 returned 0 after 1 usecs
> [    0.378055] calling  swiotlb_create_default_debugfs+0x0/0xc0 @ 1
> [    0.378059] initcall swiotlb_create_default_debugfs+0x0/0xc0 returned 0 after 2 usecs
> [    0.378061] calling  module_decompress_sysfs_init+0x0/0x40 @ 1
> [    0.378064] initcall module_decompress_sysfs_init+0x0/0x40 returned 0 after 0 usecs
> [    0.378066] calling  tk_debug_sleep_time_init+0x0/0x30 @ 1
> [    0.378071] initcall tk_debug_sleep_time_init+0x0/0x30 returned 0 after 3 usecs
> [    0.378073] calling  bpf_ksym_iter_register+0x0/0x20 @ 1
> [    0.378076] initcall bpf_ksym_iter_register+0x0/0x20 returned 0 after 0 usecs
> [    0.378078] calling  kernel_acct_sysctls_init+0x0/0x30 @ 1
> [    0.378082] initcall kernel_acct_sysctls_init+0x0/0x30 returned 0 after 1 usecs
> [    0.378084] calling  kexec_core_sysctl_init+0x0/0x30 @ 1
> [    0.378088] initcall kexec_core_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.378090] calling  bpf_rstat_kfunc_init+0x0/0x20 @ 1
> [    0.378093] initcall bpf_rstat_kfunc_init+0x0/0x20 returned 0 after 0 usecs
> [    0.378095] calling  debugfs_kprobe_init+0x0/0x80 @ 1
> [    0.378101] initcall debugfs_kprobe_init+0x0/0x80 returned 0 after 3 usecs
> [    0.378103] calling  kernel_delayacct_sysctls_init+0x0/0x30 @ 1
> [    0.378106] initcall kernel_delayacct_sysctls_init+0x0/0x30 returned 0 after 0 usecs
> [    0.378107] calling  taskstats_init+0x0/0x40 @ 1
> [    0.378113] registered taskstats version 1
> [    0.378113] initcall taskstats_init+0x0/0x40 returned 0 after 4 usecs
> [    0.378115] calling  ftrace_sysctl_init+0x0/0x30 @ 1
> [    0.378117] initcall ftrace_sysctl_init+0x0/0x30 returned 0 after 0 usecs
> [    0.378119] calling  bpf_key_sig_kfuncs_init+0x0/0x20 @ 1
> [    0.378121] initcall bpf_key_sig_kfuncs_init+0x0/0x20 returned 0 after 0 usecs
> [    0.378124] calling  bpf_fs_kfuncs_init+0x0/0x20 @ 1
> [    0.378126] initcall bpf_fs_kfuncs_init+0x0/0x20 returned 0 after 0 usecs
> [    0.378128] calling  bpf_global_ma_init+0x0/0x30 @ 1
> [    0.378146] initcall bpf_global_ma_init+0x0/0x30 returned 0 after 15 usecs
> [    0.378149] calling  bpf_syscall_sysctl_init+0x0/0x30 @ 1
> [    0.378153] initcall bpf_syscall_sysctl_init+0x0/0x30 returned 0 after 1 usecs
> [    0.378155] calling  kfunc_init+0x0/0xd0 @ 1
> [    0.378157] initcall kfunc_init+0x0/0xd0 returned 0 after 0 usecs
> [    0.378160] calling  bpf_map_iter_init+0x0/0x40 @ 1
> [    0.378162] initcall bpf_map_iter_init+0x0/0x40 returned 0 after 0 usecs
> [    0.378165] calling  init_subsystem+0x0/0x20 @ 1
> [    0.378168] initcall init_subsystem+0x0/0x20 returned 0 after 0 usecs
> [    0.378169] calling  task_iter_init+0x0/0xe0 @ 1
> [    0.378172] initcall task_iter_init+0x0/0xe0 returned 0 after 0 usecs
> [    0.378174] calling  bpf_prog_iter_init+0x0/0x20 @ 1
> [    0.378177] initcall bpf_prog_iter_init+0x0/0x20 returned 0 after 0 usecs
> [    0.378179] calling  bpf_link_iter_init+0x0/0x20 @ 1
> [    0.378182] initcall bpf_link_iter_init+0x0/0x20 returned 0 after 0 usecs
> [    0.378184] calling  init_trampolines+0x0/0x30 @ 1
> [    0.378187] initcall init_trampolines+0x0/0x30 returned 0 after 0 usecs
> [    0.378189] calling  bpf_cgroup_iter_init+0x0/0x30 @ 1
> [    0.378191] initcall bpf_cgroup_iter_init+0x0/0x30 returned 0 after 0 usecs
> [    0.378192] calling  cpumask_kfunc_init+0x0/0xa0 @ 1
> [    0.378195] initcall cpumask_kfunc_init+0x0/0xa0 returned 0 after 1 usecs
> [    0.378197] calling  load_system_certificate_list+0x0/0x30 @ 1
> [    0.378198] Loading compiled-in X.509 certificates
> [    0.378764] Loaded X.509 cert 'Build time autogenerated kernel key: d47c33c70b7d8c925a93309ef39ed6f8acab6016'
> [    0.378766] initcall load_system_certificate_list+0x0/0x30 returned 0 after 567 usecs
> [    0.378770] calling  init_lru_gen+0x0/0x70 @ 1
> [    0.378781] initcall init_lru_gen+0x0/0x70 returned 0 after 9 usecs
> [    0.378783] calling  fault_around_debugfs+0x0/0x30 @ 1
> [    0.378788] initcall fault_around_debugfs+0x0/0x30 returned 0 after 1 usecs
> [    0.378791] calling  slab_sysfs_init+0x0/0x100 @ 1
> [    0.380174] initcall slab_sysfs_init+0x0/0x100 returned 0 after 1381 usecs
> [    0.380178] calling  max_swapfiles_check+0x0/0x10 @ 1
> [    0.380180] initcall max_swapfiles_check+0x0/0x10 returned 0 after 0 usecs
> [    0.380181] calling  zswap_init+0x0/0x20 @ 1
> [    0.380182] initcall zswap_init+0x0/0x20 returned 0 after 0 usecs
> [    0.380184] calling  hugetlb_vmemmap_init+0x0/0x80 @ 1
> [    0.380188] initcall hugetlb_vmemmap_init+0x0/0x80 returned 0 after 2 usecs
> [    0.380190] calling  kfence_debugfs_init+0x0/0x20 @ 1
> [    0.380193] initcall kfence_debugfs_init+0x0/0x20 returned 0 after 0 usecs
> [    0.380195] calling  split_huge_pages_debugfs+0x0/0x30 @ 1
> [    0.380198] initcall split_huge_pages_debugfs+0x0/0x30 returned 0 after 1 usecs
> [    0.380200] calling  check_early_ioremap_leak+0x0/0x50 @ 1
> [    0.380202] initcall check_early_ioremap_leak+0x0/0x50 returned 0 after 0 usecs
> [    0.380204] calling  set_hardened_usercopy+0x0/0x40 @ 1
> [    0.380206] initcall set_hardened_usercopy+0x0/0x40 returned 1 after 0 usecs
> [    0.380208] calling  fscrypt_init+0x0/0xa0 @ 1
> [    0.380251] Key type .fscrypt registered
> [    0.380252] Key type fscrypt-provisioning registered
> [    0.380252] initcall fscrypt_init+0x0/0xa0 returned 0 after 41 usecs
> [    0.380255] calling  fsverity_init+0x0/0x60 @ 1
> [    0.380274] initcall fsverity_init+0x0/0x60 returned 0 after 16 usecs
> [    0.380277] calling  pstore_init+0x0/0x70 @ 1
> [    0.380282] initcall pstore_init+0x0/0x70 returned 0 after 2 usecs
> [    0.380284] calling  init_root_keyring+0x0/0x20 @ 1
> [    0.380295] initcall init_root_keyring+0x0/0x20 returned 0 after 9 usecs
> [    0.380297] calling  init_encrypted+0x0/0xe0 @ 1
> [    0.384952] cryptd: module verification failed: signature and/or required key missing - tainting kernel
> [    0.385433] calling  cryptd_init+0x0/0xff0 [cryptd] @ 90
> [    0.385468] cryptd: max_cpu_qlen set to 1000
> [    0.385470] initcall cryptd_init+0x0/0xff0 [cryptd] returned 0 after 30 usecs
> [    0.386500] calling  aesni_init+0x0/0xff0 [aesni_intel] @ 90
> [    0.386507] AVX2 version of gcm_enc/dec engaged.
> [    0.386538] AES CTR mode by8 optimization enabled
> [    0.386562] initcall aesni_init+0x0/0xff0 [aesni_intel] returned 0 after 55 usecs
> [    0.398365] Key type encrypted registered
> [    0.398368] initcall init_encrypted+0x0/0xe0 returned 0 after 11861 usecs
> [    0.398375] calling  init_profile_hash+0x0/0x90 @ 1
> [    0.398379] AppArmor: AppArmor sha256 policy hashing enabled
> [    0.398380] initcall init_profile_hash+0x0/0x90 returned 0 after 1 usecs
> [    0.398382] calling  integrity_fs_init+0x0/0x60 @ 1
> [    0.398388] initcall integrity_fs_init+0x0/0x60 returned 0 after 3 usecs
> [    0.398391] calling  load_uefi_certs+0x0/0x460 @ 1
> [    0.398668] integrity: Loading X.509 certificate: UEFI:db
> [    0.398693] integrity: Loaded X.509 cert 'Dell Inc. UEFI DB: 5ddb772dc880660055ba0bc131886bb630a639e7'
> [    0.398694] integrity: Loading X.509 certificate: UEFI:db
> [    0.398711] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [    0.398712] integrity: Loading X.509 certificate: UEFI:db
> [    0.398725] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [    0.399066] initcall load_uefi_certs+0x0/0x460 returned 0 after 673 usecs
> [    0.399069] calling  init_ima+0x0/0xd0 @ 1
> [    0.399073] ima: Allocated hash algorithm: sha256
> [    0.440741] ima: No architecture policies found
> [    0.440775] initcall init_ima+0x0/0xd0 returned 0 after 41704 usecs
> [    0.440793] calling  init_evm+0x0/0x180 @ 1
> [    0.440800] evm: Initialising EVM extended attributes:
> [    0.440801] evm: security.selinux
> [    0.440804] evm: security.SMACK64 (disabled)
> [    0.440806] evm: security.SMACK64EXEC (disabled)
> [    0.440808] evm: security.SMACK64TRANSMUTE (disabled)
> [    0.440810] evm: security.SMACK64MMAP (disabled)
> [    0.440812] evm: security.apparmor
> [    0.440814] evm: security.ima
> [    0.440816] evm: security.capability
> [    0.440817] evm: HMAC attrs: 0x1
> [    0.440826] initcall init_evm+0x0/0x180 returned 0 after 26 usecs
> [    0.440832] calling  crypto_algapi_init+0x0/0xa0 @ 1
> [    0.442219] initcall crypto_algapi_init+0x0/0xa0 returned 0 after 1380 usecs
> [    0.442234] calling  blk_timeout_init+0x0/0x20 @ 1
> [    0.442242] initcall blk_timeout_init+0x0/0x20 returned 0 after 0 usecs
> [    0.442248] calling  sed_opal_init+0x0/0x110 @ 1
> [    0.442269] initcall sed_opal_init+0x0/0x110 returned 0 after 14 usecs
> [    0.442275] calling  depot_debugfs_init+0x0/0x40 @ 1
> [    0.442302] initcall depot_debugfs_init+0x0/0x40 returned 0 after 18 usecs
> [    0.442308] calling  pci_resource_alignment_sysfs_init+0x0/0x20 @ 1
> [    0.442325] initcall pci_resource_alignment_sysfs_init+0x0/0x20 returned 0 after 9 usecs
> [    0.442334] calling  pci_sysfs_init+0x0/0x90 @ 1
> [    0.442393] initcall pci_sysfs_init+0x0/0x90 returned 0 after 52 usecs
> [    0.442401] calling  bert_init+0x0/0x2e0 @ 1
> [    0.442409] initcall bert_init+0x0/0x2e0 returned 0 after 1 usecs
> [    0.442414] calling  clk_debug_init+0x0/0x120 @ 1
> [    0.442430] initcall clk_debug_init+0x0/0x120 returned 0 after 10 usecs
> [    0.442436] calling  setup_vcpu_hotplug_event+0x0/0x40 @ 1
> [    0.442443] initcall setup_vcpu_hotplug_event+0x0/0x40 returned -19 after 0 usecs
> [    0.442449] calling  boot_wait_for_devices+0x0/0x40 @ 1
> [    0.442456] initcall boot_wait_for_devices+0x0/0x40 returned -19 after 0 usecs
> [    0.442462] calling  dmar_free_unused_resources+0x0/0xe0 @ 1
> [    0.442474] initcall dmar_free_unused_resources+0x0/0xe0 returned 0 after 0 usecs
> [    0.442479] calling  sync_state_resume_initcall+0x0/0x20 @ 1
> [    0.442487] initcall sync_state_resume_initcall+0x0/0x20 returned 0 after 0 usecs
> [    0.442492] calling  deferred_probe_initcall+0x0/0x90 @ 1
> [    0.442531] initcall deferred_probe_initcall+0x0/0x90 returned 0 after 33 usecs
> [    0.442537] calling  firmware_memmap_init+0x0/0x50 @ 1
> [    0.442635] initcall firmware_memmap_init+0x0/0x50 returned 0 after 92 usecs
> [    0.442641] calling  register_update_efi_random_seed+0x0/0x30 @ 1
> [    0.442648] initcall register_update_efi_random_seed+0x0/0x30 returned 0 after 0 usecs
> [    0.442654] calling  efi_shutdown_init+0x0/0x60 @ 1
> [    0.442661] initcall efi_shutdown_init+0x0/0x60 returned 0 after 0 usecs
> [    0.442667] calling  efi_earlycon_unmap_fb+0x0/0x50 @ 1
> [    0.442674] initcall efi_earlycon_unmap_fb+0x0/0x50 returned 0 after 0 usecs
> [    0.442680] calling  itmt_legacy_init+0x0/0x60 @ 1
> [    0.442688] initcall itmt_legacy_init+0x0/0x60 returned -19 after 0 usecs
> [    0.442694] calling  cec_init+0x0/0x1b0 @ 1
> [    0.442716] RAS: Correctable Errors collector initialized.
> [    0.442718] initcall cec_init+0x0/0x1b0 returned 0 after 16 usecs
> [    0.442725] calling  bpf_kfunc_init+0x0/0x120 @ 1
> [    0.442731] initcall bpf_kfunc_init+0x0/0x120 returned 0 after 1 usecs
> [    0.442735] calling  init_subsystem+0x0/0x20 @ 1
> [    0.442743] initcall init_subsystem+0x0/0x20 returned 0 after 0 usecs
> [    0.442749] calling  xdp_metadata_init+0x0/0x20 @ 1
> [    0.442754] initcall xdp_metadata_init+0x0/0x20 returned 0 after 0 usecs
> [    0.442758] calling  bpf_sockmap_iter_init+0x0/0x30 @ 1
> [    0.442763] initcall bpf_sockmap_iter_init+0x0/0x30 returned 0 after 0 usecs
> [    0.442768] calling  bpf_sk_storage_map_iter_init+0x0/0x30 @ 1
> [    0.442773] initcall bpf_sk_storage_map_iter_init+0x0/0x30 returned 0 after 0 usecs
> [    0.442777] calling  sch_default_qdisc+0x0/0x20 @ 1
> [    0.442785] initcall sch_default_qdisc+0x0/0x20 returned 0 after 2 usecs
> [    0.442789] calling  bpf_prog_test_run_init+0x0/0xb0 @ 1
> [    0.442797] initcall bpf_prog_test_run_init+0x0/0xb0 returned 0 after 2 usecs
> [    0.442801] calling  tcp_congestion_default+0x0/0x20 @ 1
> [    0.442808] initcall tcp_congestion_default+0x0/0x20 returned 0 after 1 usecs
> [    0.442813] calling  tcp_bpf_v4_build_proto+0x0/0xa0 @ 1
> [    0.442821] initcall tcp_bpf_v4_build_proto+0x0/0xa0 returned 0 after 0 usecs
> [    0.442827] calling  udp_bpf_v4_build_proto+0x0/0x50 @ 1
> [    0.442834] initcall udp_bpf_v4_build_proto+0x0/0x50 returned 0 after 0 usecs
> [    0.442840] calling  bpf_tcp_ca_kfunc_init+0x0/0x20 @ 1
> [    0.442847] initcall bpf_tcp_ca_kfunc_init+0x0/0x20 returned 0 after 0 usecs
> [    0.442853] calling  bpf_mptcp_kfunc_init+0x0/0x20 @ 1
> [    0.442858] initcall bpf_mptcp_kfunc_init+0x0/0x20 returned 0 after 0 usecs
> [    0.442863] calling  pci_mmcfg_late_insert_resources+0x0/0xc0 @ 1
> [    0.442870] initcall pci_mmcfg_late_insert_resources+0x0/0xc0 returned 0 after 1 usecs
> [    0.442876] calling  software_resume_initcall+0x0/0x180 @ 1
> [    0.442886] initcall software_resume_initcall+0x0/0x180 returned -2 after 1 usecs
> [    0.442893] calling  lockup_detector_check+0x0/0x80 @ 1
> [    0.442918] initcall lockup_detector_check+0x0/0x80 returned 0 after 20 usecs
> [    0.442922] calling  ftrace_check_sync+0x0/0x20 @ 1
> [    0.442933] initcall ftrace_check_sync+0x0/0x20 returned 0 after 6 usecs
> [    0.442938] calling  latency_fsnotify_init+0x0/0x40 @ 1
> [    0.442960] initcall latency_fsnotify_init+0x0/0x40 returned 0 after 15 usecs
> [    0.442966] calling  trace_eval_sync+0x0/0x20 @ 1
> [    0.442977] initcall trace_eval_sync+0x0/0x20 returned 0 after 5 usecs
> [    0.442983] calling  late_trace_init+0x0/0xc0 @ 1
> [    0.442989] initcall late_trace_init+0x0/0xc0 returned 0 after 0 usecs
> [    0.442994] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa0 @ 1
> [    0.443003] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa0 returned 0 after 0 usecs
> [    0.443010] calling  clk_disable_unused+0x0/0x140 @ 1
> [    0.443016] clk: Disabling unused clocks
> [    0.443018] initcall clk_disable_unused+0x0/0x140 returned 0 after 2 usecs
> [    0.443024] calling  balloon_wait_finish+0x0/0x110 @ 1
> [    0.443030] initcall balloon_wait_finish+0x0/0x110 returned -19 after 0 usecs
> [    0.443036] calling  regulator_init_complete+0x0/0x30 @ 1
> [    0.443044] initcall regulator_init_complete+0x0/0x30 returned 0 after 0 usecs
> [    0.445065] Freeing unused decrypted memory: 2036K
> [    0.446102] Freeing unused kernel image (initmem) memory: 3984K
> [    0.457959] Write protecting the kernel read-only data: 22528k
> [    0.458688] Freeing unused kernel image (rodata/data gap) memory: 244K
> [    0.526388] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.526389] x86/mm: Checking user space page tables
> [    0.568530] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.568535] Run /init as init process
> [    0.568536]   with arguments:
> [    0.568537]     /init
> [    0.568538]   with environment:
> [    0.568538]     HOME=/
> [    0.568539]     TERM=linux
> [    0.568540]     BOOT_IMAGE=/vmlinuz-6.8.0-rc3
> [    0.751629] calling  hid_init+0x0/0x60 [hid] @ 161
> [    0.751668] hid: raw HID events driver (C) Jiri Kosina
> [    0.751675] initcall hid_init+0x0/0x60 [hid] returned 0 after 28 usecs
> [    0.756038] calling  idma64_platform_driver_init+0x0/0xff0 [idma64] @ 153
> [    0.756088] initcall idma64_platform_driver_init+0x0/0xff0 [idma64] returned 0 after 37 usecs
> [    0.762273] calling  usb_common_init+0x0/0x30 [usb_common] @ 150
> [    0.762290] initcall usb_common_init+0x0/0x30 [usb_common] returned 0 after 5 usecs
> [    0.763599] calling  sha1_ssse3_mod_init+0x0/0xff0 [sha1_ssse3] @ 162
> [    0.765449] initcall sha1_ssse3_mod_init+0x0/0xff0 [sha1_ssse3] returned 0 after 1829 usecs
> [    0.770841] calling  intel_lpss_init+0x0/0xff0 [intel_lpss] @ 153
> [    0.770851] initcall intel_lpss_init+0x0/0xff0 [intel_lpss] returned 0 after 2 usecs
> [    0.785414] calling  smbalert_driver_init+0x0/0xff0 [i2c_smbus] @ 172
> [    0.785437] initcall smbalert_driver_init+0x0/0xff0 [i2c_smbus] returned 0 after 15 usecs
> [    0.785696] calling  intel_lpss_pci_driver_init+0x0/0xff0 [intel_lpss_pci] @ 153
> [    0.785704] calling  crct10dif_intel_mod_init+0x0/0xff0 [crct10dif_pclmul] @ 163
> [    0.785796] calling  drm_core_init+0x0/0xff0 [drm] @ 161
> [    0.785880] ACPI: bus type drm_connector registered
> [    0.785887] initcall drm_core_init+0x0/0xff0 [drm] returned 0 after 25 usecs
> [    0.785936] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    0.786210] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    0.786221] probe of idma64.0 returned 0 after 81 usecs
> [    0.789856] initcall crct10dif_intel_mod_init+0x0/0xff0 [crct10dif_pclmul] returned 0 after 3994 usecs
> [    0.792496] calling  crct10dif_mod_init+0x0/0xff0 [crct10dif_generic] @ 163
> [    0.792562] initcall crct10dif_mod_init+0x0/0xff0 [crct10dif_generic] returned 0 after 59 usecs
> [    0.792618] calling  sha256_ssse3_mod_init+0x0/0xff0 [sha256_ssse3] @ 151
> [    0.792756] calling  usb_init+0x0/0x180 [usbcore] @ 150
> [    0.792815] initcall sha256_ssse3_mod_init+0x0/0xff0 [sha256_ssse3] returned 0 after 21 usecs
> [    0.792912] ACPI: bus type USB registered
> [    0.793016] calling  i801_driver_init+0x0/0xff0 [i2c_i801] @ 172
> [    0.793360] calling  crc_t10dif_mod_init+0x0/0xff0 [crc_t10dif] @ 163
> [    0.793387] initcall crc_t10dif_mod_init+0x0/0xff0 [crc_t10dif] returned 0 after 20 usecs
> [    0.793598] calling  crc64_rocksoft_mod_init+0x0/0xff0 [crc64_rocksoft] @ 163
> [    0.793641] calling  i2c_hid_acpi_driver_init+0x0/0xff0 [i2c_hid_acpi] @ 161
> [    0.793643] initcall i801_driver_init+0x0/0xff0 [i2c_i801] returned 0 after 39 usecs
> [    0.793659] initcall i2c_hid_acpi_driver_init+0x0/0xff0 [i2c_hid_acpi] returned 0 after 11 usecs
> [    0.793700] calling  sha512_generic_mod_init+0x0/0xff0 [sha512_generic] @ 151
> [    0.793785] initcall sha512_generic_mod_init+0x0/0xff0 [sha512_generic] returned 0 after 78 usecs
> [    0.794017] usbcore: registered new interface driver usbfs
> [    0.794028] usbcore: registered new interface driver hub
> [    0.794040] usbcore: registered new device driver usb
> [    0.794042] initcall usb_init+0x0/0x180 [usbcore] returned 0 after 336 usecs
> [    0.794317] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    0.794344] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    0.796002] calling  crc64_rocksoft_init+0x0/0xff0 [crc64_rocksoft_generic] @ 187
> [    0.796045] initcall crc64_rocksoft_init+0x0/0xff0 [crc64_rocksoft_generic] returned 0 after 35 usecs
> [    0.801676] probe of i2c_designware.0 returned 0 after 15424 usecs
> [    0.801691] probe of 0000:00:15.0 returned 0 after 15973 usecs
> [    0.801870] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    0.802116] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    0.802123] probe of idma64.1 returned 0 after 55 usecs
> [    0.819818] probe of i2c_designware.1 returned 0 after 17646 usecs
> [    0.819832] probe of 0000:00:15.1 returned 0 after 18137 usecs
> [    0.819852] initcall intel_lpss_pci_driver_init+0x0/0xff0 [intel_lpss_pci] returned 0 after 23842 usecs
> [    0.823228] i2c i2c-0: 2/2 memory slots populated (from DMI)
> [    0.823693] probe of 0000:00:1f.4 returned 0 after 30023 usecs
> [    0.975509] probe of i2c-DLL075B:01 returned 0 after 158397 usecs
> [    0.976882] calling  sha512_ssse3_mod_init+0x0/0xff0 [sha512_ssse3] @ 151
> [    0.977632] initcall sha512_ssse3_mod_init+0x0/0xff0 [sha512_ssse3] returned 0 after 710 usecs
> [    0.979428] calling  ghash_pclmulqdqni_mod_init+0x0/0xff0 [ghash_clmulni_intel] @ 151
> [    0.980358] initcall ghash_pclmulqdqni_mod_init+0x0/0xff0 [ghash_clmulni_intel] returned 0 after 889 usecs
> [    0.981368] calling  crc32c_intel_mod_init+0x0/0xff0 [crc32c_intel] @ 162
> [    0.981531] initcall crc32c_intel_mod_init+0x0/0xff0 [crc32c_intel] returned 0 after 130 usecs
> [    0.982356] calling  crc32_pclmul_mod_init+0x0/0xff0 [crc32_pclmul] @ 162
> [    0.982498] initcall crc32_pclmul_mod_init+0x0/0xff0 [crc32_pclmul] returned 0 after 116 usecs
> [    0.991135] initcall crc64_rocksoft_mod_init+0x0/0xff0 [crc64_rocksoft] returned 0 after 8752 usecs
> [    1.000807] calling  hid_generic_init+0x0/0xff0 [hid_generic] @ 161
> [    1.001026] calling  xhci_hcd_init+0x0/0x30 [xhci_hcd] @ 150
> [    1.001162] initcall xhci_hcd_init+0x0/0x30 [xhci_hcd] returned 0 after 11 usecs
> [    1.002996] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input2
> [    1.003280] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input3
> [    1.003528] hid-generic 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [    1.003576] probe of 0018:06CB:76AF.0001 returned 0 after 2717 usecs
> [    1.003626] initcall hid_generic_init+0x0/0xff0 [hid_generic] returned 0 after 2475 usecs
> [    1.003673] calling  xhci_pci_init+0x0/0xff0 [xhci_pci] @ 150
> [    1.004339] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.004365] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    1.005542] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
> [    1.007471] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.007493] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    1.007508] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    1.007647] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> [    1.007661] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.007669] usb usb1: Product: xHCI Host Controller
> [    1.007676] usb usb1: Manufacturer: Linux 6.8.0-rc3 xhci-hcd
> [    1.007684] usb usb1: SerialNumber: 0000:00:14.0
> [    1.008213] hub 1-0:1.0: USB hub found
> [    1.008243] hub 1-0:1.0: 12 ports detected
> [    1.015315] probe of 1-0:1.0 returned 0 after 7114 usecs
> [    1.015440] probe of usb1 returned 0 after 7337 usecs
> [    1.015567] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.08
> [    1.015576] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.015582] usb usb2: Product: xHCI Host Controller
> [    1.015587] usb usb2: Manufacturer: Linux 6.8.0-rc3 xhci-hcd
> [    1.015591] usb usb2: SerialNumber: 0000:00:14.0
> [    1.015982] hub 2-0:1.0: USB hub found
> [    1.016008] hub 2-0:1.0: 6 ports detected
> [    1.016686] calling  nvme_core_init+0x0/0xff0 [nvme_core] @ 163
> [    1.017283] initcall nvme_core_init+0x0/0xff0 [nvme_core] returned 0 after 536 usecs
> [    1.019555] usb: port power management may be unreliable
> [    1.020852] probe of 2-0:1.0 returned 0 after 4880 usecs
> [    1.020849] calling  nvme_init+0x0/0xff0 [nvme] @ 163
> [    1.020968] probe of usb2 returned 0 after 5108 usecs
> [    1.020958] initcall nvme_init+0x0/0xff0 [nvme] returned 0 after 80 usecs
> [    1.021169] probe of 0000:00:14.0 returned 0 after 17428 usecs
> [    1.021186] nvme nvme0: pci function 0000:3b:00.0
> [    1.021238] initcall xhci_pci_init+0x0/0xff0 [xhci_pci] returned 0 after 360 usecs
> [    1.039103] nvme nvme0: 4/0/0 default/read/poll queues
> [    1.045682]  nvme0n1: p1 p2 p3 p4
> [    1.046351] probe of 0000:3b:00.0 returned 0 after 25429 usecs
> [    1.140110] calling  dm_init+0x0/0x80 [dm_mod] @ 215
> [    1.140142] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [    1.140191] device-mapper: uevent: version 1.0.3
> [    1.140399] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
> [    1.140404] initcall dm_init+0x0/0x80 [dm_mod] returned 0 after 262 usecs
> [    1.142119] calling  dm_crypt_init+0x0/0xff0 [dm_crypt] @ 215
> [    1.142133] initcall dm_crypt_init+0x0/0xff0 [dm_crypt] returned 0 after 0 usecs
> [    1.270085] usb 1-3: new full-speed USB device number 2 using xhci_hcd
> [    1.274042] tsc: Refined TSC clocksource calibration: 2904.007 MHz
> [    1.274063] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc0c50045, max_idle_ns: 440795208304 ns
> [    1.274239] clocksource: Switched to clocksource tsc
> [    1.420223] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [    1.420239] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.423324] probe of 1-3 returned 0 after 2461 usecs
> [    1.550070] usb 1-4: new full-speed USB device number 3 using xhci_hcd
> [    1.700736] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [    1.700754] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [    1.700761] usb 1-4: Product: Touchscreen
> [    1.700766] usb 1-4: Manufacturer: ELAN
> [    1.702960] probe of 1-4 returned 0 after 1527 usecs
> [    1.710944] calling  hid_init+0x0/0xff0 [usbhid] @ 161
> [    1.717531] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input5
> [    1.717646] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input6
> [    1.717668] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input7
> [    1.717753] hid-generic 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [    1.717768] probe of 0003:04F3:2234.0002 returned 0 after 980 usecs
> [    1.717781] probe of 1-4:1.0 returned 0 after 6820 usecs
> [    1.717791] usbcore: registered new interface driver usbhid
> [    1.717793] usbhid: USB HID core driver
> [    1.717794] initcall hid_init+0x0/0xff0 [usbhid] returned 0 after 6840 usecs
> [    1.830097] usb 1-5: new high-speed USB device number 4 using xhci_hcd
> [    2.038815] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [    2.038831] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [    2.038838] usb 1-5: Product: Integrated_Webcam_HD
> [    2.038844] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [    2.048126] probe of 1-5 returned 0 after 8597 usecs
> [   13.313409] PM: Image not found (code -22)
> [   13.378810] calling  journal_init+0x0/0xea0 [jbd2] @ 432
> [   13.379162] initcall journal_init+0x0/0xea0 [jbd2] returned 0 after 292 usecs
> [   13.380492] calling  mbcache_init+0x0/0xff0 [mbcache] @ 432
> [   13.380528] initcall mbcache_init+0x0/0xff0 [mbcache] returned 0 after 14 usecs
> [   13.381520] calling  crc32c_mod_init+0x0/0xff0 [crc32c_generic] @ 432
> [   13.381681] initcall crc32c_mod_init+0x0/0xff0 [crc32c_generic] returned 0 after 134 usecs
> [   13.439586] calling  ext4_init_fs+0x0/0x1f0 [ext4] @ 432
> [   13.439761] initcall ext4_init_fs+0x0/0x1f0 [ext4] returned 0 after 129 usecs
> [   13.444782] EXT4-fs (dm-0): mounted filesystem 32e29882-d94d-4a92-9ee4-4d03002bfa29 ro with ordered data mode. Quota mode: none.
> [   13.468500] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> [   13.574040] calling  init_autofs_fs+0x0/0x50 [autofs4] @ 1
> [   13.574203] initcall init_autofs_fs+0x0/0x50 [autofs4] returned 0 after 132 usecs
> [   13.574354] systemd[1]: Inserted module 'autofs4'
> [   13.583973] calling  xt_init+0x0/0xff0 [x_tables] @ 1
> [   13.584013] initcall xt_init+0x0/0xff0 [x_tables] returned 0 after 4 usecs
> [   13.588410] calling  ip_tables_init+0x0/0xff0 [ip_tables] @ 1
> [   13.588433] initcall ip_tables_init+0x0/0xff0 [ip_tables] returned 0 after 7 usecs
> [   13.598712] calling  efivarfs_init+0x0/0xff0 [efivarfs] @ 453
> [   13.598732] initcall efivarfs_init+0x0/0xff0 [efivarfs] returned 0 after 2 usecs
> [   13.618584] systemd[1]: systemd 255.3-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [   13.618599] systemd[1]: Detected architecture x86-64.
> [   13.619649] systemd[1]: Hostname set to <abreu>.
> [   13.836045] systemd[1]: Queued start job for default target graphical.target.
> [   13.839205] calling  nfnetlink_init+0x0/0xff0 [nfnetlink] @ 469
> [   13.839219] initcall nfnetlink_init+0x0/0xff0 [nfnetlink] returned 0 after 5 usecs
> [   13.858879] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
> [   13.859202] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> [   13.859466] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
> [   13.859725] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
> [   13.859927] systemd[1]: Created slice user.slice - User and Session Slice.
> [   13.859993] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
> [   13.860043] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> [   13.860205] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> [   13.860224] systemd[1]: Expecting device dev-disk-by\x2ddiskseq-1\x2dpart4.device - /dev/disk/by-diskseq/1-part4...
> [   13.860231] systemd[1]: Expecting device dev-disk-by\x2duuid-2d23fd4c\x2d5d03\x2d4e1a\x2d8a42\x2d0e859d1f00d8.device - /dev/disk/by-uuid/2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8...
> [   13.860236] systemd[1]: Expecting device dev-disk-by\x2duuid-61be8f50\x2d69c5\x2d49a5\x2dbcad\x2d3f4521e9c7b5.device - /dev/disk/by-uuid/61be8f50-69c5-49a5-bcad-3f4521e9c7b5...
> [   13.860241] systemd[1]: Expecting device dev-disk-by\x2duuid-96BD\x2d5653.device - /dev/disk/by-uuid/96BD-5653...
> [   13.860260] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
> [   13.860279] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
> [   13.860290] systemd[1]: Reached target remote-fs.target - Remote File Systems.
> [   13.860302] systemd[1]: Reached target slices.target - Slice Units.
> [   13.860321] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
> [   13.861462] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
> [   13.861556] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
> [   13.861610] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
> [   13.861724] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> [   13.861858] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
> [   13.861900] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.862170] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> [   13.862264] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> [   13.863399] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> [   13.864256] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> [   13.865320] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> [   13.869752] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> [   13.872795] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
> [   13.875381] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> [   13.876980] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> [   13.880679] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
> [   13.883834] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
> [   13.887944] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> [   13.892033] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
> [   13.894165] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
> [   13.894279] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
> [   13.896233] calling  configfs_init+0x0/0xff0 [configfs] @ 477
> [   13.896289] initcall configfs_init+0x0/0xff0 [configfs] returned 0 after 42 usecs
> [   13.897618] calling  efivars_pstore_init+0x0/0xff0 [efi_pstore] @ 482
> [   13.897644] pstore: Using crash dump compression: deflate
> [   13.899305] systemd[1]: Starting systemd-journald.service - Journal Service...
> [   13.903590] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> [   13.903701] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.905038] pstore: Registered efi_pstore as persistent store backend
> [   13.905041] initcall efivars_pstore_init+0x0/0xff0 [efi_pstore] returned 0 after 7413 usecs
> [   13.908926] calling  loop_init+0x0/0xff0 [loop] @ 484
> [   13.909096] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> [   13.909167] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.911626] loop: module loaded
> [   13.911629] initcall loop_init+0x0/0xff0 [loop] returned 0 after 2691 usecs
> [   13.913259] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> [   13.919764] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> [   13.919924] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> [   13.920064] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> [   13.920208] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> [   13.920537] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
> [   13.921408] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> [   13.921729] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [   13.922015] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> [   13.922415] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
> [   13.922604] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
> [   13.922988] systemd[1]: modprobe@drm.service: Deactivated successfully.
> [   13.923148] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
> [   13.923466] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> [   13.923622] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> [   13.923926] systemd[1]: modprobe@fuse.service: Deactivated successfully.
> [   13.924081] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
> [   13.924400] systemd[1]: modprobe@loop.service: Deactivated successfully.
> [   13.924555] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
> [   13.926764] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> [   13.926858] calling  parport_default_proc_register+0x0/0xff0 [parport] @ 487
> [   13.926895] initcall parport_default_proc_register+0x0/0xff0 [parport] returned 0 after 27 usecs
> [   13.928360] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> [   13.928442] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
> [   13.928776] calling  lp_init_module+0x0/0xff0 [lp] @ 487
> [   13.929069] systemd-journald[486]: Collecting audit messages is disabled.
> [   13.932498] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> [   13.932619] lp: driver loaded but no devices found
> [   13.932621] initcall lp_init_module+0x0/0xff0 [lp] returned 0 after 3837 usecs
> [   13.936607] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> [   13.938112] calling  ppdev_init+0x0/0xff0 [ppdev] @ 487
> [   13.938405] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> [   13.939918] ppdev: user-space parallel port driver
> [   13.939921] initcall ppdev_init+0x0/0xff0 [ppdev] returned 0 after 1799 usecs
> [   13.943400] calling  parport_pc_init+0x0/0xef0 [parport_pc] @ 487
> [   13.943531] probe of parport_pc.956 returned 0 after 14 usecs
> [   13.943562] probe of parport0 returned 19 after 5 usecs
> [   13.943568] probe of parport0 returned 19 after 3 usecs
> [   13.943701] probe of parport_pc.888 returned 0 after 8 usecs
> [   13.943724] probe of parport0 returned 19 after 7 usecs
> [   13.943729] probe of parport0 returned 19 after 3 usecs
> [   13.943879] probe of parport_pc.632 returned 0 after 10 usecs
> [   13.943902] probe of parport0 returned 19 after 3 usecs
> [   13.943907] probe of parport0 returned 19 after 3 usecs
> [   13.944014] initcall parport_pc_init+0x0/0xef0 [parport_pc] returned 0 after 600 usecs
> [   13.947250] calling  msr_init+0x0/0xff0 [msr] @ 487
> [   13.951321] EXT4-fs (dm-0): re-mounted 32e29882-d94d-4a92-9ee4-4d03002bfa29 r/w. Quota mode: none.
> [   13.952644] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> [   13.953519] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> [   13.953582] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> [   13.954502] initcall msr_init+0x0/0xff0 [msr] returned 0 after 7241 usecs
> [   13.955907] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> [   13.955942] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.956822] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> [   13.962751] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> [   13.968329] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> [   13.968549] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
> [   13.969769] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> [   13.992235] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
> [   13.992361] systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
> [   13.994617] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
> [   13.996285] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> [   14.000607] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> [   14.011860] systemd[1]: Started systemd-journald.service - Journal Service.
> [   14.028348] systemd-journald[486]: Received client request to flush runtime journal.
> [   14.045249] systemd-journald[486]: /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/system.journal: Journal file uses a different sequence number ID, rotating.
> [   14.045255] systemd-journald[486]: Rotating system journal.
> [   14.193547] calling  serio_raw_drv_init+0x0/0xff0 [serio_raw] @ 531
> [   14.193576] initcall serio_raw_drv_init+0x0/0xff0 [serio_raw] returned 0 after 19 usecs
> [   14.219269] calling  evdev_init+0x0/0xff0 [evdev] @ 531
> [   14.229896] calling  mt_driver_init+0x0/0xff0 [hid_multitouch] @ 548
> [   14.235597] initcall evdev_init+0x0/0xff0 [evdev] returned 0 after 5685 usecs
> [   14.247749] calling  acpi_button_driver_init+0x0/0xff0 [button] @ 530
> [   14.247896] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
> [   14.248668] calling  acpi_ac_init+0x0/0xf90 [ac] @ 551
> [   14.249847] calling  intel_hid_init+0x0/0x50 [intel_hid] @ 542
> [   14.250824] ACPI: AC: AC Adapter [AC] (on-line)
> [   14.250842] probe of ACPI0003:00 returned 0 after 2074 usecs
> [   14.250863] initcall acpi_ac_init+0x0/0xf90 [ac] returned 0 after 997 usecs
> [   14.250955] calling  usb_roles_init+0x0/0xff0 [roles] @ 536
> [   14.250971] initcall usb_roles_init+0x0/0xff0 [roles] returned 0 after 6 usecs
> [   14.251225] input: Intel HID events as /devices/platform/INT33D5:00/input/input10
> [   14.254995] calling  rc_core_init+0x0/0x140 [rc_core] @ 535
> [   14.255030] initcall rc_core_init+0x0/0x140 [rc_core] returned 0 after 20 usecs
> [   14.255425] calling  int3400_thermal_driver_init+0x0/0xff0 [int3400_thermal] @ 552
> [   14.256533] calling  acpi_pad_init+0x0/0xff0 [acpi_pad] @ 544
> [   14.256610] calling  pmt_class_init+0x0/0xff0 [pmt_class] @ 532
> [   14.256622] probe of ACPI000C:00 returned 0 after 62 usecs
> [   14.256633] initcall pmt_class_init+0x0/0xff0 [pmt_class] returned 0 after 15 usecs
> [   14.256652] initcall acpi_pad_init+0x0/0xff0 [acpi_pad] returned 0 after 33 usecs
> [   14.257982] calling  pmt_telem_init+0x0/0xff0 [pmt_telemetry] @ 532
> [   14.258005] initcall pmt_telem_init+0x0/0xff0 [pmt_telemetry] returned 0 after 14 usecs
> [   14.260374] calling  intel_xhci_usb_driver_init+0x0/0xff0 [intel_xhci_usb_role_switch] @ 536
> [   14.260491] probe of intel_xhci_usb_sw returned 0 after 86 usecs
> [   14.260501] calling  cec_devnode_init+0x0/0xff0 [cec] @ 535
> [   14.261592] initcall cec_devnode_init+0x0/0xff0 [cec] returned 0 after 1082 usecs
> [   14.261703] initcall intel_xhci_usb_driver_init+0x0/0xff0 [intel_xhci_usb_role_switch] returned 0 after 1192 usecs
> [   14.264976] Consider using thermal netlink events interface
> [   14.266128] calling  intel_vsec_pci_driver_init+0x0/0xff0 [intel_vsec] @ 532
> [   14.266177] initcall intel_vsec_pci_driver_init+0x0/0xff0 [intel_vsec] returned 0 after 34 usecs
> [   14.275286] calling  rapl_init+0x0/0xff0 [intel_rapl_common] @ 534
> [   14.275355] initcall rapl_init+0x0/0xff0 [intel_rapl_common] returned 0 after 54 usecs
> [   14.276775] calling  acpi_wmi_init+0x0/0xff0 [wmi] @ 538
> [   14.276952] probe of PNP0C14:00 returned 0 after 124 usecs
> [   14.277131] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query control method not found
> [   14.277175] probe of PNP0C14:01 returned 0 after 218 usecs
> [   14.277193] initcall acpi_wmi_init+0x0/0xff0 [wmi] returned 0 after 409 usecs
> [   14.281974] calling  pmc_core_driver_init+0x0/0xff0 [intel_pmc_core] @ 532
> [   14.282139] intel_pmc_core INT33A1:00:  initialized
> [   14.282160] probe of INT33A1:00 returned 0 after 100 usecs
> [   14.282730] initcall pmc_core_driver_init+0x0/0xff0 [intel_pmc_core] returned 0 after 738 usecs
> [   14.284742] calling  rfkill_init+0x0/0x150 [rfkill] @ 536
> [   14.290613] calling  acpi_battery_init+0x0/0xf10 [battery] @ 531
> [   14.290627] initcall acpi_battery_init+0x0/0xf10 [battery] returned 0 after 3 usecs
> [   14.296625] probe of INT3400:00 returned 0 after 41156 usecs
> [   14.296650] initcall int3400_thermal_driver_init+0x0/0xff0 [int3400_thermal] returned 0 after 6025 usecs
> [   14.301711] calling  int3403_driver_init+0x0/0xff0 [int3403_thermal] @ 537
> [   14.304926] calling  typec_init+0x0/0xa0 [typec] @ 533
> [   14.305831] calling  drm_display_helper_module_init+0x0/0xff0 [drm_display_helper] @ 535
> [   14.305990] initcall drm_display_helper_module_init+0x0/0xff0 [drm_display_helper] returned 0 after 97 usecs
> [   14.307404] initcall typec_init+0x0/0xa0 [typec] returned 0 after 1510 usecs
> [   14.307562] calling  acpi_video_init+0x0/0xff0 [video] @ 546
> [   14.307583] initcall acpi_video_init+0x0/0xff0 [video] returned 0 after 9 usecs
> [   14.322949] probe of INT3403:00 returned 0 after 21211 usecs
> [   14.330148] calling  soc_button_driver_init+0x0/0xff0 [soc_button_array] @ 538
> [   14.330165] calling  intel_vbtn_init+0x0/0x50 [intel_vbtn] @ 551
> [   14.341493] probe of INT3403:01 returned 0 after 18536 usecs
> [   14.345899] probe of INT33D2:00 returned 19 after 15726 usecs
> [   14.346832] input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D6:00/input/input11
> [   14.347390] probe of INT33D3:00 returned 19 after 1486 usecs
> [   14.347411] initcall soc_button_driver_init+0x0/0xff0 [soc_button_array] returned 0 after 17239 usecs
> [   14.356156] probe of INT3403:02 returned 0 after 14649 usecs
> [   14.362590] Adding 8387904k swap on /dev/nvme0n1p4.  Priority:-2 extents:1 across:8387904k SS
> [   14.363115] ACPI: battery: Slot [BAT0] (battery present)
> [   14.363161] probe of PNP0C0A:00 returned 0 after 72420 usecs
> [   14.372366] probe of INT3403:03 returned 0 after 16201 usecs
> [   14.372400] initcall int3403_driver_init+0x0/0xff0 [int3403_thermal] returned 0 after 42228 usecs
> [   14.374420] ACPI: button: Lid Switch [LID0]
> [   14.374437] probe of PNP0C0D:00 returned 0 after 126609 usecs
> [   14.374493] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input12
> [   14.374784] intel-hid INT33D5:00: platform supports 5 button array
> [   14.374830] ACPI: button: Power Button [PBTN]
> [   14.374833] input: Intel HID 5 button array as /devices/platform/INT33D5:00/input/input13
> [   14.374849] probe of PNP0C0C:00 returned 0 after 406 usecs
> [   14.374946] initcall rfkill_init+0x0/0x150 [rfkill] returned 0 after 44775 usecs
> [   14.376129] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input14
> [   14.376221] probe of INT33D5:00 returned 0 after 126096 usecs
> [   14.376242] initcall intel_hid_init+0x0/0x50 [intel_hid] returned 0 after 46070 usecs
> [   14.376896] calling  proc_thermal_pci_driver_init+0x0/0xff0 [processor_thermal_device_pci_legacy] @ 534
> [   14.376938] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
> [   14.377700] calling  ucsi_module_init+0x0/0xff0 [typec_ucsi] @ 533
> [   14.377717] initcall ucsi_module_init+0x0/0xff0 [typec_ucsi] returned 0 after 4 usecs
> [   14.379814] probe of 0018:06CB:76AF.0001 returned 19 after 10 usecs
> [   14.382001] calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 533
> [   14.382111] probe of INT33D6:00 returned 0 after 50802 usecs
> [   14.382135] initcall intel_vbtn_init+0x0/0x50 [intel_vbtn] returned 0 after 122 usecs
> [   14.388142] calling  ecdh_init+0x0/0xff0 [ecdh_generic] @ 544
> [   14.388286] initcall ecdh_init+0x0/0xff0 [ecdh_generic] returned 0 after 125 usecs
> [   14.388528] calling  drm_buddy_module_init+0x0/0xff0 [drm_buddy] @ 535
> [   14.388542] initcall drm_buddy_module_init+0x0/0xff0 [drm_buddy] returned 0 after 5 usecs
> [   14.391888] intel_rapl_common: Found RAPL domain package
> [   14.391893] intel_rapl_common: Found RAPL domain dram
> [   14.393186] probe of 0000:00:04.0 returned 0 after 16275 usecs
> [   14.393499] ACPI: button: Sleep Button [SBTN]
> [   14.393511] probe of PNP0C0E:00 returned 0 after 18658 usecs
> [   14.393576] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input16
> [   14.406988] initcall proc_thermal_pci_driver_init+0x0/0xff0 [processor_thermal_device_pci_legacy] returned 0 after 18451 usecs
> [   14.427628] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input17
> [   14.429597] ACPI: button: Power Button [PWRF]
> [   14.429612] probe of LNXPWRBN:00 returned 0 after 36091 usecs
> [   14.429624] initcall acpi_button_driver_init+0x0/0xff0 [button] returned 0 after 41087 usecs
> [   14.452783] probe of USBC000:00 returned 0 after 70746 usecs
> [   14.465101] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input18
> [   14.465203] hid-multitouch 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [   14.469868] probe of 0018:06CB:76AF.0001 returned 0 after 90048 usecs
> [   14.470929] EXT4-fs (nvme0n1p2): mounted filesystem 2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8 r/w with ordered data mode. Quota mode: none.
> [   14.474486] initcall ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] returned 0 after 85949 usecs
> [   14.519975] calling  media_devnode_init+0x0/0xff0 [mc] @ 543
> [   14.519992] mc: Linux media interface: v0.10
> [   14.520023] initcall media_devnode_init+0x0/0xff0 [mc] returned 0 after 30 usecs
> [   14.520277] calling  watchdog_init+0x0/0xc0 [watchdog] @ 541
> [   14.520284] calling  init_soundcore+0x0/0xff0 [soundcore] @ 547
> [   14.520304] initcall init_soundcore+0x0/0xff0 [soundcore] returned 0 after 12 usecs
> [   14.524738] initcall watchdog_init+0x0/0xc0 [watchdog] returned 0 after 4446 usecs
> [   14.525814] calling  mei_init+0x0/0xa0 [mei] @ 552
> [   14.525981] calling  bt_init+0x0/0xd0 [bluetooth] @ 544
> [   14.526064] Bluetooth: Core ver 2.22
> [   14.526779] initcall mei_init+0x0/0xa0 [mei] returned 0 after 715 usecs
> [   14.528673] NET: Registered PF_BLUETOOTH protocol family
> [   14.528677] Bluetooth: HCI device and connection manager initialized
> [   14.528681] Bluetooth: HCI socket layer initialized
> [   14.528683] Bluetooth: L2CAP socket layer initialized
> [   14.528689] Bluetooth: SCO socket layer initialized
> [   14.528692] initcall bt_init+0x0/0xd0 [bluetooth] returned 0 after 2628 usecs
> [   14.533805] calling  intel_pch_thermal_driver_init+0x0/0xff0 [intel_pch_thermal] @ 538
> [   14.537917] probe of 0000:00:14.2 returned 0 after 4090 usecs
> [   14.537937] initcall intel_pch_thermal_driver_init+0x0/0xff0 [intel_pch_thermal] returned 0 after 4120 usecs
> [   14.541425] calling  iTCO_vendor_init_module+0x0/0xff0 [iTCO_vendor_support] @ 541
> [   14.541435] iTCO_vendor_support: vendor-support=0
> [   14.541436] initcall iTCO_vendor_init_module+0x0/0xff0 [iTCO_vendor_support] returned 0 after 1 usecs
> [   14.541646] calling  alsa_sound_init+0x0/0x90 [snd] @ 547
> [   14.541679] initcall alsa_sound_init+0x0/0x90 [snd] returned 0 after 10 usecs
> [   14.548073] calling  pcspkr_platform_driver_init+0x0/0xff0 [pcspkr] @ 537
> [   14.548173] input: PC Speaker as /devices/platform/pcspkr/input/input20
> [   14.550474] probe of pcspkr returned 0 after 2364 usecs
> [   14.550544] initcall pcspkr_platform_driver_init+0x0/0xff0 [pcspkr] returned 0 after 2456 usecs
> [   14.552281] calling  alsa_timer_init+0x0/0xff0 [snd_timer] @ 547
> [   14.559638] calling  mei_me_driver_init+0x0/0xff0 [mei_me] @ 552
> [   14.559684] initcall mei_me_driver_init+0x0/0xff0 [mei_me] returned 0 after 31 usecs
> [   14.559742] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [   14.559998] initcall alsa_timer_init+0x0/0xff0 [snd_timer] returned 0 after 346 usecs
> [   14.581566] calling  intel_pmc_driver_init+0x0/0xff0 [intel_pmc_bxt] @ 541
> [   14.581625] initcall intel_pmc_driver_init+0x0/0xff0 [intel_pmc_bxt] returned 0 after 47 usecs
> [   14.614781] probe of 0000:00:16.0 returned 0 after 55098 usecs
> [   14.629670] calling  videodev_init+0x0/0xff0 [videodev] @ 543
> [   14.629709] videodev: Linux video capture interface: v2.00
> [   14.629720] initcall videodev_init+0x0/0xff0 [videodev] returned 0 after 11 usecs
> [   14.634116] calling  intel_uncore_init+0x0/0xdc0 [intel_uncore] @ 533
> [   14.635106] calling  cfg80211_init+0x0/0xe0 [cfg80211] @ 553
> [   14.637623] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   14.637922] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   14.638117] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   14.638302] initcall cfg80211_init+0x0/0xe0 [cfg80211] returned 0 after 3115 usecs
> [   14.638737] probe of 0000:00:00.0 returned 0 after 4567 usecs
> [   14.640068] initcall intel_uncore_init+0x0/0xdc0 [intel_uncore] returned 0 after 4881 usecs
> [   14.640917] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
> [   14.644656] calling  iTCO_wdt_driver_init+0x0/0xff0 [iTCO_wdt] @ 541
> [   14.650710] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [   14.654791] calling  cstate_pmu_init+0x0/0xff0 [intel_cstate] @ 545
> [   14.658060] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   14.658072] probe of iTCO_wdt returned 0 after 8048 usecs
> [   14.658106] initcall iTCO_wdt_driver_init+0x0/0xff0 [iTCO_wdt] returned 0 after 3302 usecs
> [   14.658836] initcall cstate_pmu_init+0x0/0xff0 [intel_cstate] returned 0 after 4031 usecs
> [   14.658974] calling  alsa_pcm_init+0x0/0xff0 [snd_pcm] @ 547
> [   14.658998] initcall alsa_pcm_init+0x0/0xff0 [snd_pcm] returned 0 after 5 usecs
> [   14.672005] calling  uvc_init+0x0/0xff0 [uvcvideo] @ 543
> [   14.678318] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [   14.678495] probe of 0003:04F3:2234.0002 returned 19 after 8 usecs
> [   14.679378] calling  i8k_init+0x0/0x360 [dell_smm_hwmon] @ 532
> [   14.698053] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input21
> [   14.698584] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input22
> [   14.698721] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input23
> [   14.699018] hid-multitouch 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [   14.699037] probe of 0003:04F3:2234.0002 returned 0 after 20539 usecs
> [   14.699043] initcall mt_driver_init+0x0/0xff0 [hid_multitouch] returned 0 after 19653 usecs
> [   14.701487] calling  btusb_driver_init+0x0/0xff0 [btusb] @ 536
> [   14.706837] calling  rapl_pmu_init+0x0/0xff0 [rapl] @ 533
> [   14.714634] probe of dell_smm_hwmon returned 0 after 34573 usecs
> [   14.714658] initcall i8k_init+0x0/0x360 [dell_smm_hwmon] returned 0 after 7808 usecs
> [   14.736199] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   14.736203] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   14.736204] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   14.736206] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   14.736207] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   14.736208] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   14.736209] initcall rapl_pmu_init+0x0/0xff0 [rapl] returned 0 after 29360 usecs
> [   14.739450] calling  hda_bus_init+0x0/0xff0 [snd_hda_core] @ 547
> [   14.739486] initcall hda_bus_init+0x0/0xff0 [snd_hda_core] returned 0 after 16 usecs
> [   14.739512] calling  dcdbas_init+0x0/0xff0 [dcdbas] @ 532
> [   14.739642] probe of dcdbas returned 19 after 47 usecs
> [   14.739646] initcall dcdbas_init+0x0/0xff0 [dcdbas] returned 0 after 125 usecs
> [   14.741039] calling  alsa_hwdep_init+0x0/0xff0 [snd_hwdep] @ 547
> [   14.741052] initcall alsa_hwdep_init+0x0/0xff0 [snd_hwdep] returned 0 after 4 usecs
> [   14.767549] probe of 1-5:1.0 returned 0 after 95506 usecs
> [   14.767607] usbcore: registered new interface driver uvcvideo
> [   14.767609] initcall uvc_init+0x0/0xff0 [uvcvideo] returned 0 after 26561 usecs
> [   14.854098] probe of 1-3:1.0 returned 0 after 138 usecs
> [   14.854127] usbcore: registered new interface driver btusb
> [   14.854129] initcall btusb_driver_init+0x0/0xff0 [btusb] returned 0 after 113082 usecs
> [   14.856985] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [   14.856990] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [   15.147787] calling  i915_init+0x0/0xc0 [i915] @ 535
> [   15.150457] calling  joydev_init+0x0/0xff0 [joydev] @ 552
> [   15.150472] initcall joydev_init+0x0/0xff0 [joydev] returned 0 after 5 usecs
> [   15.155664] Console: switching to colour dummy device 80x25
> [   15.155805] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   15.159674] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   15.161617] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [   15.192040] calling  wmi_bmof_driver_init+0x0/0xff0 [wmi_bmof] @ 534
> [   15.194850] probe of 05901221-D566-11D1-B2F0-00A0C9062910 returned 0 after 2790 usecs
> [   15.194869] initcall wmi_bmof_driver_init+0x0/0xff0 [wmi_bmof] returned 0 after 2821 usecs
> [   15.196765] calling  intel_wmi_thunderbolt_driver_init+0x0/0xff0 [intel_wmi_thunderbolt] @ 530
> [   15.196818] probe of 86CCFD48-205E-4A77-9C48-2021CBEDE341 returned 0 after 25 usecs
> [   15.196834] initcall intel_wmi_thunderbolt_driver_init+0x0/0xff0 [intel_wmi_thunderbolt] returned 0 after 59 usecs
> [   15.197585] calling  intel_rapl_msr_driver_init+0x0/0xff0 [intel_rapl_msr] @ 548
> [   15.197669] intel_rapl_common: Found RAPL domain package
> [   15.197672] intel_rapl_common: Found RAPL domain core
> [   15.197673] intel_rapl_common: Found RAPL domain uncore
> [   15.197674] intel_rapl_common: Found RAPL domain dram
> [   15.197676] intel_rapl_common: Found RAPL domain psys
> [   15.197805] calling  ieee80211_init+0x0/0x70 [mac80211] @ 553
> [   15.198082] initcall ieee80211_init+0x0/0x70 [mac80211] returned 0 after 163 usecs
> [   15.198346] probe of intel_rapl_msr.0 returned 0 after 717 usecs
> [   15.201150] initcall intel_rapl_msr_driver_init+0x0/0xff0 [intel_rapl_msr] returned 0 after 3231 usecs
> [   15.202438] calling  dell_wmi_descriptor_driver_init+0x0/0xff0 [dell_wmi_descriptor] @ 532
> [   15.206818] probe of 8D9DDCBC-A997-11DA-B012-B622A1EF5492 returned 0 after 4359 usecs
> [   15.206824] calling  azx_driver_init+0x0/0xff0 [snd_hda_intel] @ 547
> [   15.206836] initcall dell_wmi_descriptor_driver_init+0x0/0xff0 [dell_wmi_descriptor] returned 0 after 4388 usecs
> [   15.206876] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.206902] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   15.207170] probe of 0000:00:1f.3 returned 517 after 311 usecs
> [   15.207189] initcall azx_driver_init+0x0/0xff0 [snd_hda_intel] returned 0 after 346 usecs
> [   15.209525] calling  dell_smbios_init+0x0/0xf00 [dell_smbios] @ 540
> [   15.209649] probe of dell-smbios.0 returned 0 after 11 usecs
> [   15.209680] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.212740] probe of A80593CE-A997-11DA-B012-B622A1EF5492 returned 0 after 3065 usecs
> [   15.214433] initcall dell_smbios_init+0x0/0xf00 [dell_smbios] returned 0 after 4896 usecs
> [   15.215283] calling  ledtrig_audio_init+0x0/0xff0 [ledtrig_audio] @ 532
> [   15.215305] initcall ledtrig_audio_init+0x0/0xff0 [ledtrig_audio] returned 0 after 12 usecs
> [   15.216011] probe of 0000:00:1f.3 returned 517 after 6338 usecs
> [   15.216223] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.216624] probe of 0000:00:1f.3 returned 517 after 584 usecs
> [   15.216681] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [   15.224983] calling  dell_wmi_init+0x0/0xfc0 [dell_wmi] @ 546
> [   15.227135] calling  dell_init+0x0/0xfb0 [dell_laptop] @ 532
> [   15.227242] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input25
> [   15.227358] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.227617] probe of 0000:00:1f.3 returned 517 after 268 usecs
> [   15.227632] probe of 9DBB5994-A997-11DA-B012-B622A1EF5492 returned 0 after 2627 usecs
> [   15.227644] initcall dell_wmi_init+0x0/0xfc0 [dell_wmi] returned 0 after 498 usecs
> [   15.227888] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.227988] probe of dell-laptop returned 0 after 125 usecs
> [   15.229959] probe of 0000:00:1f.3 returned 517 after 2074 usecs
> [   15.239713] calling  init_fat_fs+0x0/0xfa0 [fat] @ 626
> [   15.243581] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [   15.246026] initcall init_fat_fs+0x0/0xfa0 [fat] returned 0 after 6296 usecs
> [   15.248041] calling  init_vfat_fs+0x0/0xff0 [vfat] @ 626
> [   15.248056] initcall init_vfat_fs+0x0/0xff0 [vfat] returned 0 after 3 usecs
> [   15.339594] calling  init_nls_cp437+0x0/0xff0 [nls_cp437] @ 628
> [   15.339604] initcall init_nls_cp437+0x0/0xff0 [nls_cp437] returned 0 after 0 usecs
> [   15.339817] calling  kvm_x86_init+0x0/0x50 [kvm] @ 542
> [   15.339920] initcall kvm_x86_init+0x0/0x50 [kvm] returned 0 after 0 usecs
> [   15.348619] calling  mei_wdt_driver_init+0x0/0xff0 [mei_wdt] @ 538
> [   15.357749] calling  mei_pxp_driver_init+0x0/0xff0 [mei_pxp] @ 534
> [   15.359401] calling  snd_soc_init+0x0/0xa0 [snd_soc_core] @ 547
> [   15.359541] probe of snd-soc-dummy returned 0 after 15 usecs
> [   15.359572] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.359568] initcall snd_soc_init+0x0/0xa0 [snd_soc_core] returned 0 after 124 usecs
> [   15.359624] probe of 0000:00:16.0-05b79a6f-4628-4d7f-899d-a91514cb32ab returned 0 after 8936 usecs
> [   15.359651] initcall mei_wdt_driver_init+0x0/0xff0 [mei_wdt] returned 0 after 206 usecs
> [   15.361153] calling  init_nls_ascii+0x0/0xff0 [nls_ascii] @ 635
> [   15.361165] initcall init_nls_ascii+0x0/0xff0 [nls_ascii] returned 0 after 0 usecs
> [   15.361579] probe of 0000:00:1f.3 returned 517 after 2016 usecs
> [   15.361617] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.365457] probe of 0000:00:1f.3 returned 517 after 3850 usecs
> [   15.366142] calling  ath10k_pci_init+0x0/0xff0 [ath10k_pci] @ 553
> [   15.366461] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
> [   15.368123] probe of 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1 returned 0 after 10351 usecs
> [   15.368583] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> [   15.368601] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.368658] initcall mei_pxp_driver_init+0x0/0xff0 [mei_pxp] returned 0 after 2502 usecs
> [   15.369059] probe of 0000:00:1f.3 returned 517 after 475 usecs
> [   15.374165] calling  mei_hdcp_driver_init+0x0/0xff0 [mei_hdcp] @ 546
> [   15.374983] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [   15.375249] probe of 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04 returned 0 after 1056 usecs
> [   15.375271] initcall mei_hdcp_driver_init+0x0/0xff0 [mei_hdcp] returned 0 after 1093 usecs
> [   15.375486] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.381017] probe of 0000:00:1f.3 returned 517 after 5539 usecs
> [   15.384216] initcall dell_init+0x0/0xfb0 [dell_laptop] returned 0 after 10038 usecs
> [   15.387406] calling  vmx_init+0x0/0x150 [kvm_intel] @ 542
> [   15.395822] initcall vmx_init+0x0/0x150 [kvm_intel] returned 0 after 8371 usecs
> [   15.429221] calling  coretemp_init+0x0/0xff0 [coretemp] @ 537
> [   15.432279] initcall coretemp_init+0x0/0xff0 [coretemp] returned 0 after 3042 usecs
> [   15.437132] calling  powerclamp_init+0x0/0xff0 [intel_powerclamp] @ 542
> [   15.437193] initcall powerclamp_init+0x0/0xff0 [intel_powerclamp] returned 0 after 49 usecs
> [   15.440206] calling  pkg_temp_thermal_init+0x0/0xff0 [x86_pkg_temp_thermal] @ 542
> [   15.440890] initcall pkg_temp_thermal_init+0x0/0xff0 [x86_pkg_temp_thermal] returned 0 after 672 usecs
> [   15.446027] calling  pmc_core_platform_init+0x0/0xff0 [intel_pmc_core_pltdrv] @ 533
> [   15.446084] initcall pmc_core_platform_init+0x0/0xff0 [intel_pmc_core_pltdrv] returned -19 after 46 usecs
> [   15.450617] audit: type=1400 audit(1707252218.578:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=662 comm="apparmor_parser"
> [   15.452384] audit: type=1400 audit(1707252218.578:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=663 comm="apparmor_parser"
> [   15.452389] audit: type=1400 audit(1707252218.578:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=663 comm="apparmor_parser"
> [   15.460333] audit: type=1400 audit(1707252218.586:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=668 comm="apparmor_parser"
> [   15.460338] audit: type=1400 audit(1707252218.586:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=668 comm="apparmor_parser"
> [   15.460340] audit: type=1400 audit(1707252218.586:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=668 comm="apparmor_parser"
> [   15.464967] audit: type=1400 audit(1707252218.590:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/ipsec/charon" pid=670 comm="apparmor_parser"
> [   15.465379] calling  skl_driver_init+0x0/0xff0 [snd_soc_skl] @ 547
> [   15.465430] snd_soc_skl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.465438] probe of 0000:00:1f.3 returned 19 after 17 usecs
> [   15.465459] initcall skl_driver_init+0x0/0xff0 [snd_soc_skl] returned 0 after 53 usecs
> [   15.468653] audit: type=1400 audit(1707252218.594:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=664 comm="apparmor_parser"
> [   15.468659] audit: type=1400 audit(1707252218.594:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=664 comm="apparmor_parser"
> [   15.468661] audit: type=1400 audit(1707252218.594:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=664 comm="apparmor_parser"
> [   15.506253] calling  init_misc_binfmt+0x0/0xff0 [binfmt_misc] @ 674
> [   15.506266] initcall init_misc_binfmt+0x0/0xff0 [binfmt_misc] returned 0 after 2 usecs
> [   15.509762] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.512412] probe of 0000:00:1f.3 returned 517 after 2663 usecs
> [   15.512427] snd_soc_skl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.512432] probe of 0000:00:1f.3 returned 19 after 12 usecs
> [   15.515385] probe of 0000:3a:00.0 returned 0 after 149216 usecs
> [   15.515408] initcall ath10k_pci_init+0x0/0xff0 [ath10k_pci] returned 0 after 9144 usecs
> [   15.517120] calling  avs_pci_driver_init+0x0/0xff0 [snd_soc_avs] @ 547
> [   15.517166] snd_soc_avs 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.517174] probe of 0000:00:1f.3 returned 19 after 16 usecs
> [   15.517194] initcall avs_pci_driver_init+0x0/0xff0 [snd_soc_avs] returned 0 after 48 usecs
> [   15.565995] calling  snd_sof_pci_intel_skl_driver_init+0x0/0xff0 [snd_sof_pci_intel_skl] @ 547
> [   15.566037] sof-audio-pci-intel-skl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   15.566044] probe of 0000:00:1f.3 returned 19 after 18 usecs
> [   15.566059] initcall snd_sof_pci_intel_skl_driver_init+0x0/0xff0 [snd_sof_pci_intel_skl] returned 0 after 54 usecs
> [   15.655649] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> [   15.655656] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> [   15.656092] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
> [   15.730211] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> [   15.842499] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> [   15.924627] ath: EEPROM regdomain: 0x6c
> [   15.924640] ath: EEPROM indicates we should expect a direct regpair map
> [   15.924642] ath: Country alpha2 being used: 00
> [   15.924643] ath: Regpair used: 0x6c
> [   15.926222] ath10k_pci 0000:3a:00.0: WBRF is not supported
> [   15.931441] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
> [   15.986352] calling  qrtr_proto_init+0x0/0xff0 [qrtr] @ 788
> [   15.986397] NET: Registered PF_QIPCRTR protocol family
> [   15.986415] initcall qrtr_proto_init+0x0/0xff0 [qrtr] returned 0 after 50 usecs
> [   16.915267] i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   16.921868] i915 0000:00:02.0: [drm] [ENCODER:113:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
> [   16.951952] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 0
> [   16.955831] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   16.956678] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input26
> [   16.956754] probe of LNXVIDEO:00 returned 0 after 2882 usecs
> [   16.956778] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   16.956917] i915 display info: display version: 9
> [   16.956920] i915 display info: cursor_needs_physical: no
> [   16.956921] i915 display info: has_cdclk_crawl: no
> [   16.956923] i915 display info: has_cdclk_squash: no
> [   16.956924] i915 display info: has_ddi: yes
> [   16.956925] i915 display info: has_dp_mst: yes
> [   16.956926] i915 display info: has_dsb: no
> [   16.956928] i915 display info: has_fpga_dbg: yes
> [   16.956929] i915 display info: has_gmch: no
> [   16.956930] i915 display info: has_hotplug: yes
> [   16.956931] i915 display info: has_hti: no
> [   16.956932] i915 display info: has_ipc: yes
> [   16.956933] i915 display info: has_overlay: no
> [   16.956934] i915 display info: has_psr: yes
> [   16.956935] i915 display info: has_psr_hw_tracking: yes
> [   16.956936] i915 display info: overlay_needs_physical: no
> [   16.956938] i915 display info: supports_tv: no
> [   16.956939] i915 display info: has_hdcp: yes
> [   16.956940] i915 display info: has_dmc: yes
> [   16.956941] i915 display info: has_dsc: no
> [   16.957007] probe of 0000:00:02.0 returned 0 after 1808670 usecs
> [   16.956931] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   16.957106] probe of 0000:00:1f.3 returned 0 after 338 usecs
> [   16.957040] initcall i915_init+0x0/0xc0 [i915] returned 0 after 970675 usecs
> [   16.966729] fbcon: i915drmfb (fb0) is primary device
> [   16.968284] Console: switching to colour frame buffer device 200x56
> [   16.987823] calling  generic_driver_init+0x0/0xff0 [snd_hda_codec_generic] @ 531
> [   16.987873] initcall generic_driver_init+0x0/0xff0 [snd_hda_codec_generic] returned 0 after 34 usecs
> [   16.990075] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [   17.026964] calling  realtek_driver_init+0x0/0xff0 [snd_hda_codec_realtek] @ 826
> [   17.070199] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   17.070205] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   17.070207] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   17.070210] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   17.070211] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   17.070213] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
> [   17.070215] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
> [   17.070217] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [   17.074330] calling  snd_ctl_led_init+0x0/0xff0 [snd_ctl_led] @ 879
> [   17.074392] initcall snd_ctl_led_init+0x0/0xff0 [snd_ctl_led] returned 0 after 50 usecs
> [   17.122371] probe of hdaudioC0D0 returned 0 after 95375 usecs
> [   17.122388] initcall realtek_driver_init+0x0/0xff0 [snd_hda_codec_realtek] returned 0 after 48046 usecs
> [   17.130557] calling  hdmi_driver_init+0x0/0xff0 [snd_hda_codec_hdmi] @ 531
> [   17.134271] probe of hdaudioC0D2 returned 0 after 3687 usecs
> [   17.134290] initcall hdmi_driver_init+0x0/0xff0 [snd_hda_codec_hdmi] returned 0 after 3717 usecs
> [   17.135456] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input27
> [   17.135517] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input28
> [   17.135568] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input29
> [   17.135618] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input30
> [   17.135668] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input31
> [   17.581109] calling  alsa_seq_device_init+0x0/0xff0 [snd_seq_device] @ 970
> [   17.581146] initcall alsa_seq_device_init+0x0/0xff0 [snd_seq_device] returned 0 after 27 usecs
> [   17.587422] calling  alsa_seq_init+0x0/0x70 [snd_seq] @ 970
> [   17.587502] initcall alsa_seq_init+0x0/0x70 [snd_seq] returned 0 after 69 usecs
> [   17.592070] calling  snd_hrtimer_init+0x0/0xff0 [snd_hrtimer] @ 971
> [   17.592081] initcall snd_hrtimer_init+0x0/0xff0 [snd_hrtimer] returned 0 after 1 usecs
> [   17.594962] calling  alsa_seq_dummy_init+0x0/0xe30 [snd_seq_dummy] @ 973
> [   17.594976] initcall alsa_seq_dummy_init+0x0/0xe30 [snd_seq_dummy] returned 0 after 6 usecs
> [   19.385241] rfkill: input handler disabled
> [   21.791590] wlp58s0: 80 MHz not supported, disabling VHT
> [   21.845415] wlp58s0: authenticate with 1c:18:4a:02:50:10 (local address=9c:b6:d0:d1:6a:b1)
> [   21.845420] wlp58s0: send auth to 1c:18:4a:02:50:10 (try 1/3)
> [   21.847853] wlp58s0: authenticated
> [   21.847983] ath10k_pci 0000:3a:00.0 wlp58s0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
> [   21.849882] wlp58s0: associate with 1c:18:4a:02:50:10 (try 1/3)
> [   21.854510] wlp58s0: RX AssocResp from 1c:18:4a:02:50:10 (capab=0x401 status=0 aid=7)
> [   21.857237] wlp58s0: associated
> [   22.050468] calling  ppp_init+0x0/0xff0 [ppp_generic] @ 1427
> [   22.050482] PPP generic driver version 2.4.2
> [   22.051264] initcall ppp_init+0x0/0xff0 [ppp_generic] returned 0 after 782 usecs
> [   22.052970] calling  pppox_init+0x0/0xff0 [pppox] @ 1427
> [   22.052979] NET: Registered PF_PPPOX protocol family
> [   22.052980] initcall pppox_init+0x0/0xff0 [pppox] returned 0 after 1 usecs
> [   22.057497] calling  udp_tunnel_nic_init_module+0x0/0xff0 [udp_tunnel] @ 1429
> [   22.057518] initcall udp_tunnel_nic_init_module+0x0/0xff0 [udp_tunnel] returned 0 after 11 usecs
> [   22.063078] calling  l2tp_init+0x0/0xff0 [l2tp_core] @ 1429
> [   22.063105] l2tp_core: L2TP core driver, V2.0
> [   22.063106] initcall l2tp_init+0x0/0xff0 [l2tp_core] returned 0 after 14 usecs
> [   22.064733] calling  l2tp_nl_init+0x0/0xff0 [l2tp_netlink] @ 1429
> [   22.064742] l2tp_netlink: L2TP netlink interface
> [   22.064767] initcall l2tp_nl_init+0x0/0xff0 [l2tp_netlink] returned 0 after 25 usecs
> [   22.067249] calling  xfrm_user_init+0x0/0xff0 [xfrm_user] @ 1431
> [   22.067258] Initializing XFRM netlink socket
> [   22.067274] initcall xfrm_user_init+0x0/0xff0 [xfrm_user] returned 0 after 15 usecs
> [   22.067288] calling  pppol2tp_init+0x0/0xff0 [l2tp_ppp] @ 1429
> [   22.067306] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> [   22.067307] initcall pppol2tp_init+0x0/0xff0 [l2tp_ppp] returned 0 after 12 usecs
> [   22.071039] calling  tunnel6_init+0x0/0xff0 [tunnel6] @ 1434
> [   22.071047] initcall tunnel6_init+0x0/0xff0 [tunnel6] returned 0 after 0 usecs
> [   22.071956] calling  xfrm6_tunnel_init+0x0/0xff0 [xfrm6_tunnel] @ 1433
> [   22.071977] initcall xfrm6_tunnel_init+0x0/0xff0 [xfrm6_tunnel] returned 0 after 14 usecs
> [   22.073580] calling  xfrmi_init+0x0/0xff0 [xfrm_interface] @ 1434
> [   22.073587] IPsec XFRM device driver
> [   22.073594] initcall xfrmi_init+0x0/0xff0 [xfrm_interface] returned 0 after 6 usecs
> [   22.622863] systemd-journald[486]: /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/user-5272.journal: Journal file uses a different sequence number ID, rotating.
> [   23.038494] rfkill: input handler enabled
> [   26.504239] rfkill: input handler disabled
> [   26.737862] usb 1-1: new full-speed USB device number 5 using xhci_hcd
> [   26.890772] usb 1-1: New USB device found, idVendor=1395, idProduct=0025, bcdDevice= 1.00
> [   26.890779] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   26.890782] usb 1-1: Product: Sennheiser USB headset
> [   26.890784] usb 1-1: Manufacturer: Sennheiser Communications 
> [   26.893058] input: Sennheiser Communications  Sennheiser USB headset as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.3/0003:1395:0025.0003/input/input32
> [   26.949997] hid-generic 0003:1395:0025.0003: input,hidraw2: USB HID v1.00 Device [Sennheiser Communications  Sennheiser USB headset] on usb-0000:00:14.0-1/input3
> [   26.950021] probe of 0003:1395:0025.0003 returned 0 after 57084 usecs
> [   26.950041] probe of 1-1:1.3 returned 0 after 57540 usecs
> [   26.950067] probe of 1-1 returned 0 after 59007 usecs
> [   68.686190] usb 1-1: USB disconnect, device number 5
> [   70.722290] usb 1-1: new full-speed USB device number 6 using xhci_hcd
> [   70.876580] usb 1-1: New USB device found, idVendor=1395, idProduct=0025, bcdDevice= 1.00
> [   70.876598] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   70.876605] usb 1-1: Product: Sennheiser USB headset
> [   70.876611] usb 1-1: Manufacturer: Sennheiser Communications 
> [   70.881464] input: Sennheiser Communications  Sennheiser USB headset as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.3/0003:1395:0025.0004/input/input33
> [   70.938733] hid-generic 0003:1395:0025.0004: input,hidraw2: USB HID v1.00 Device [Sennheiser Communications  Sennheiser USB headset] on usb-0000:00:14.0-1/input3
> [   70.938757] probe of 0003:1395:0025.0004 returned 0 after 57574 usecs
> [   70.938780] probe of 1-1:1.3 returned 0 after 58273 usecs
> [   70.938817] probe of 1-1 returned 0 after 61404 usecs
> [   88.552779] usb 1-1: USB disconnect, device number 6


-- 
Lee Jones [李琼斯]

