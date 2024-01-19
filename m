Return-Path: <linux-kernel+bounces-31301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B0832C22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFB0282861
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3553810;
	Fri, 19 Jan 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="49nKTcOg"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F03A54667
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677111; cv=none; b=GLL1T/lNHVhHHRfshaMpJMgpSpW9HgFFngtObYe6WwlmMs7vQ+SKFDpAwpKkBqX6sebjwQ8PNAZ6RMiDfoczTcDBetqvFHI/pKA74MMjdJEOIqjnyQbuHzbOy7ZBrzmkyFOXLNUcAp+f6d/9Kwaf8lWBkKVUv4b5uhy1SSJB9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677111; c=relaxed/simple;
	bh=quW70MXTdXzQmL5/o7OXWiEZ7Gj2cT0iK1H0Kcn/Hbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt/Fr+Sqpq3kO8scMc8f5ns/5tA8sNqcf6hgE91RRcCgqlfhASYALIXgffUbvtuO1ionzyHVG9pwUg6J1+6uieaSlJ++VIE0AHuNZVubE6svM9slOVXzqRo4J9m6YZOuD+a9fMKrGhnQ3s7KQIBEQH9owwKQas6hJVvJOId9JSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=49nKTcOg; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 26D331C0DAF;
	Fri, 19 Jan 2024 16:11:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1705677105;
	bh=quW70MXTdXzQmL5/o7OXWiEZ7Gj2cT0iK1H0Kcn/Hbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=49nKTcOgijc0ZtPIgtYYMIuq6Zrx0p9i6q+8hrmJdij/ADzmp0+hY+qyVH+9W+z3X
	 N7ujRUJaFtQcu3GKbok2BdOJtubYZP1+AeIOavBq2LFPc0+zaMFv/5wagvO1GHwFyF
	 EwDaJGB/za+0yOB16oay21NoWmNhLqjbJLoB9wnwwgr8z7glRzIA6PZtwuOTgcL+Yh
	 DIMk2kxyLLBTNXpKZiCAmgJMI+tImUXcUbUqDekwqHM1FHB8JcRZgqqIlAiiTPwiuW
	 HgBZ6jM+PlJM2N1GBA+UKg87y1CKz0ekHfE5eR+He1s41ISBw4UhxC6vF+5n9SCbPu
	 xQMc6W7Yv+bGw==
Date: Fri, 19 Jan 2024 16:11:44 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in
 kdump mode
Message-ID: <ZaqRMHqK6Qz0VzPX@8bytes.org>
References: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>

Adding Lu Baolu, Intel IOMMU maintainer.

Baolu, could you please have a look?

On Fri, Jan 19, 2024 at 03:45:03PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
> 
>     [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but we are
> not in kdump mode
>     [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but we are
> not in kdump mode
>     [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but we are
> not in kdump mode
>     [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but we are
> not in kdump mode
>     [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but we are
> not in kdump mode
>     [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but we are
> not in kdump mode
>     [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but we are
> not in kdump mode
>     [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but we are
> not in kdump mode
> 
> Looking through the logs, this only happens when using kexec to restart the
> system.
> 
> 
> Kind regards,
> 
> Paul

> [    0.000000] Linux version 6.7-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Debian 6.7-1~exp1 (2024-01-08)
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.7-amd64 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M
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
> [    0.000000] e820: update [mem 0x4ea13018-0x4ea23057] usable ==> usable
> [    0.000000] e820: update [mem 0x4ea13018-0x4ea23057] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000004ea13017] usable
> [    0.000000] reserve setup_data: [mem 0x000000004ea13018-0x000000004ea23057] usable
> [    0.000000] reserve setup_data: [mem 0x000000004ea23058-0x00000000556aafff] usable
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
> [    0.000000] efi: ACPI=0x6518d000 ACPI 2.0=0x6518d000 SMBIOS=0xf0000 SMBIOS 3.0=0xf0020 TPMFinalLog=0x6f812000 ESRT=0x6fc86698 MEMATTR=0x6267a298 INITRD=0x5577da98 TPMEventLog=0x5577e018 
> [    0.000000] efi: Remove mem34: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
> [    0.000000] efi: Not removing mem35: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
> [    0.000000] efi: Not removing mem36: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
> [    0.000000] efi: Not removing mem37: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
> [    0.000000] efi: Remove mem38: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
> [    0.000000] secureboot: Secure boot disabled
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [    0.000000] tsc: Detected 2900.000 MHz processor
> [    0.000000] tsc: Detected 2899.886 MHz TSC
> [    0.000678] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000681] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000688] last_pfn = 0x481800 max_arch_pfn = 0x400000000
> [    0.000692] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
> [    0.000694] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001017] last_pfn = 0x78600 max_arch_pfn = 0x400000000
> [    0.007382] esrt: Reserving ESRT space from 0x000000006fc86698 to 0x000000006fc866d0.
> [    0.007386] Using GB pages for direct mapping
> [    0.013936] printk: log_buf_len: 8388608 bytes
> [    0.013937] printk: early log buf free: 125296(95%)
> [    0.013938] RAMDISK: [mem 0x4ea24000-0x52530fff]
> [    0.013942] ACPI: Early table checksum verification disabled
> [    0.013945] ACPI: RSDP 0x000000006518D000 000024 (v02 DELL  )
> [    0.013949] ACPI: XSDT 0x000000006518D0C0 000104 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.013954] ACPI: FACP 0x00000000651B2A40 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
> [    0.013961] ACPI: DSDT 0x000000006518D258 0257E7 (v02 DELL   CBX3     01072009 INTL 20160422)
> [    0.013964] ACPI: FACS 0x000000006F86F180 000040
> [    0.013966] ACPI: APIC 0x00000000651B2B50 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
> [    0.013969] ACPI: FPDT 0x00000000651B2BD8 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.013971] ACPI: FIDT 0x00000000651B2C20 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.013974] ACPI: MCFG 0x00000000651B2CD0 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
> [    0.013976] ACPI: HPET 0x00000000651B2D10 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
> [    0.013979] ACPI: SSDT 0x00000000651B2D48 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
> [    0.013981] ACPI: BOOT 0x00000000651B30A8 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
> [    0.013984] ACPI: SSDT 0x00000000651B30D0 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
> [    0.013986] ACPI: HPET 0x00000000651B43A0 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
> [    0.013989] ACPI: SSDT 0x00000000651B43D8 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
> [    0.013991] ACPI: UEFI 0x00000000651B5160 000042 (v01                 00000000      00000000)
> [    0.013994] ACPI: SSDT 0x00000000651B51A8 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
> [    0.013996] ACPI: LPIT 0x00000000651B6088 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
> [    0.013999] ACPI: SSDT 0x00000000651B6120 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
> [    0.014001] ACPI: SSDT 0x00000000651B6288 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
> [    0.014004] ACPI: SSDT 0x00000000651B6528 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
> [    0.014006] ACPI: SSDT 0x00000000651B9530 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
> [    0.014009] ACPI: DBGP 0x00000000651B9610 000034 (v01 INTEL           00000002 MSFT 0000005F)
> [    0.014011] ACPI: DBG2 0x00000000651B9648 000054 (v00 INTEL           00000002 MSFT 0000005F)
> [    0.014014] ACPI: SSDT 0x00000000651B96A0 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
> [    0.014016] ACPI: SSDT 0x00000000651B9E80 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
> [    0.014019] ACPI: SLIC 0x00000000651C2378 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
> [    0.014021] ACPI: NHLT 0x00000000651C24F0 00002D (v00 INTEL  EDK2     00000002      01000013)
> [    0.014024] ACPI: BGRT 0x00000000651C2520 000038 (v00                 01072009 AMI  00010013)
> [    0.014026] ACPI: TPM2 0x00000000651C2558 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
> [    0.014029] ACPI: ASF! 0x00000000651C2590 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
> [    0.014031] ACPI: DMAR 0x00000000651C2630 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
> [    0.014033] ACPI: Reserving FACP table memory at [mem 0x651b2a40-0x651b2b4b]
> [    0.014035] ACPI: Reserving DSDT table memory at [mem 0x6518d258-0x651b2a3e]
> [    0.014035] ACPI: Reserving FACS table memory at [mem 0x6f86f180-0x6f86f1bf]
> [    0.014036] ACPI: Reserving APIC table memory at [mem 0x651b2b50-0x651b2bd3]
> [    0.014037] ACPI: Reserving FPDT table memory at [mem 0x651b2bd8-0x651b2c1b]
> [    0.014037] ACPI: Reserving FIDT table memory at [mem 0x651b2c20-0x651b2ccb]
> [    0.014038] ACPI: Reserving MCFG table memory at [mem 0x651b2cd0-0x651b2d0b]
> [    0.014039] ACPI: Reserving HPET table memory at [mem 0x651b2d10-0x651b2d47]
> [    0.014039] ACPI: Reserving SSDT table memory at [mem 0x651b2d48-0x651b30a0]
> [    0.014040] ACPI: Reserving BOOT table memory at [mem 0x651b30a8-0x651b30cf]
> [    0.014041] ACPI: Reserving SSDT table memory at [mem 0x651b30d0-0x651b439e]
> [    0.014041] ACPI: Reserving HPET table memory at [mem 0x651b43a0-0x651b43d7]
> [    0.014042] ACPI: Reserving SSDT table memory at [mem 0x651b43d8-0x651b515b]
> [    0.014043] ACPI: Reserving UEFI table memory at [mem 0x651b5160-0x651b51a1]
> [    0.014043] ACPI: Reserving SSDT table memory at [mem 0x651b51a8-0x651b6085]
> [    0.014044] ACPI: Reserving LPIT table memory at [mem 0x651b6088-0x651b611b]
> [    0.014045] ACPI: Reserving SSDT table memory at [mem 0x651b6120-0x651b6280]
> [    0.014045] ACPI: Reserving SSDT table memory at [mem 0x651b6288-0x651b6526]
> [    0.014046] ACPI: Reserving SSDT table memory at [mem 0x651b6528-0x651b9529]
> [    0.014046] ACPI: Reserving SSDT table memory at [mem 0x651b9530-0x651b960a]
> [    0.014047] ACPI: Reserving DBGP table memory at [mem 0x651b9610-0x651b9643]
> [    0.014048] ACPI: Reserving DBG2 table memory at [mem 0x651b9648-0x651b969b]
> [    0.014048] ACPI: Reserving SSDT table memory at [mem 0x651b96a0-0x651b9e7c]
> [    0.014049] ACPI: Reserving SSDT table memory at [mem 0x651b9e80-0x651c2370]
> [    0.014050] ACPI: Reserving SLIC table memory at [mem 0x651c2378-0x651c24ed]
> [    0.014050] ACPI: Reserving NHLT table memory at [mem 0x651c24f0-0x651c251c]
> [    0.014051] ACPI: Reserving BGRT table memory at [mem 0x651c2520-0x651c2557]
> [    0.014052] ACPI: Reserving TPM2 table memory at [mem 0x651c2558-0x651c258b]
> [    0.014052] ACPI: Reserving ASF! table memory at [mem 0x651c2590-0x651c262f]
> [    0.014053] ACPI: Reserving DMAR table memory at [mem 0x651c2630-0x651c271f]
> [    0.014179] No NUMA configuration found
> [    0.014180] Faking a node at [mem 0x0000000000000000-0x00000004817fffff]
> [    0.014188] NODE_DATA(0) allocated [mem 0x47f3d5000-0x47f3fffff]
> [    0.014336] Zone ranges:
> [    0.014337]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.014339]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.014340]   Normal   [mem 0x0000000100000000-0x00000004817fffff]
> [    0.014341]   Device   empty
> [    0.014342] Movable zone start for each node
> [    0.014344] Early memory node ranges
> [    0.014345]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.014346]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
> [    0.014347]   node   0: [mem 0x0000000000100000-0x00000000556aafff]
> [    0.014348]   node   0: [mem 0x00000000556ad000-0x0000000064df3fff]
> [    0.014348]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
> [    0.014349]   node   0: [mem 0x0000000078000000-0x00000000785fffff]
> [    0.014349]   node   0: [mem 0x0000000100000000-0x00000004817fffff]
> [    0.014351] Initmem setup node 0 [mem 0x0000000000001000-0x00000004817fffff]
> [    0.014355] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.014356] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.014380] On node 0, zone DMA: 98 pages in unavailable ranges
> [    0.016731] On node 0, zone DMA32: 2 pages in unavailable ranges
> [    0.017085] On node 0, zone DMA32: 45579 pages in unavailable ranges
> [    0.017557] On node 0, zone Normal: 31232 pages in unavailable ranges
> [    0.017763] On node 0, zone Normal: 26624 pages in unavailable ranges
> [    0.017770] Reserving Intel graphics memory at [mem 0x7a800000-0x7c7fffff]
> [    0.017956] ACPI: PM-Timer IO Port: 0x1808
> [    0.017962] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.017963] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.017964] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.017965] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.017991] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.017993] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.017995] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.017998] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.017999] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.018005] e820: update [mem 0x62264000-0x623f0fff] usable ==> reserved
> [    0.018015] TSC deadline timer available
> [    0.018015] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.018030] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.018032] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
> [    0.018033] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]
> [    0.018035] PM: hibernation: Registered nosave memory: [mem 0x4ea13000-0x4ea13fff]
> [    0.018036] PM: hibernation: Registered nosave memory: [mem 0x4ea23000-0x4ea23fff]
> [    0.018037] PM: hibernation: Registered nosave memory: [mem 0x556ab000-0x556abfff]
> [    0.018038] PM: hibernation: Registered nosave memory: [mem 0x556ac000-0x556acfff]
> [    0.018039] PM: hibernation: Registered nosave memory: [mem 0x62264000-0x623f0fff]
> [    0.018041] PM: hibernation: Registered nosave memory: [mem 0x64df4000-0x6517ffff]
> [    0.018041] PM: hibernation: Registered nosave memory: [mem 0x65180000-0x651c3fff]
> [    0.018042] PM: hibernation: Registered nosave memory: [mem 0x651c4000-0x6f871fff]
> [    0.018042] PM: hibernation: Registered nosave memory: [mem 0x6f872000-0x6fffefff]
> [    0.018044] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x77ffffff]
> [    0.018045] PM: hibernation: Registered nosave memory: [mem 0x78600000-0x7c7fffff]
> [    0.018046] PM: hibernation: Registered nosave memory: [mem 0x7c800000-0xfdffffff]
> [    0.018046] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.018047] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> [    0.018047] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.018048] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> [    0.018048] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.018049] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
> [    0.018051] [mem 0x7c800000-0xfdffffff] available for PCI devices
> [    0.018052] Booting paravirtualized kernel on bare hardware
> [    0.018053] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.022551] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> [    0.022845] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u524288
> [    0.022851] pcpu-alloc: s221184 r8192 d28672 u524288 alloc=1*2097152
> [    0.022853] pcpu-alloc: [0] 0 1 2 3 
> [    0.022869] Kernel command line: BOOT_IMAGE=/vmlinuz-6.7-amd64 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M
> [    0.022934] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.7-amd64", will be passed to user space.
> [    0.022968] random: crng init done
> [    0.024480] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.025238] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.025306] Fallback order for Node 0: 0 
> [    0.025309] Built 1 zonelists, mobility grouping on.  Total pages: 4026691
> [    0.025310] Policy zone: Normal
> [    0.025314] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.025320] software IO TLB: area num 4.
> [    0.043419] Memory: 1616272K/16363068K available (16384K kernel code, 2365K rwdata, 10652K rodata, 3992K init, 3568K bss, 541684K reserved, 0K cma-reserved)
> [    0.043600] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.043609] Kernel/User page tables isolation: enabled
> [    0.043633] ftrace: allocating 43342 entries in 170 pages
> [    0.051043] ftrace: allocated 170 pages with 4 groups
> [    0.051666] Dynamic Preempt: voluntary
> [    0.051693] rcu: Preemptible hierarchical RCU implementation.
> [    0.051694] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
> [    0.051695] 	Trampoline variant of Tasks RCU enabled.
> [    0.051695] 	Rude variant of Tasks RCU enabled.
> [    0.051695] 	Tracing variant of Tasks RCU enabled.
> [    0.051696] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.051697] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.054076] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> [    0.054293] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.054469] spurious 8259A interrupt: IRQ7.
> [    0.054493] Console: colour dummy device 80x25
> [    0.054495] printk: legacy console [tty0] enabled
> [    0.054530] ACPI: Core revision 20230628
> [    0.054670] hpet: HPET dysfunctional in PC10. Force disabled.
> [    0.054671] APIC: Switch to symmetric I/O mode setup
> [    0.054673] DMAR: Host address width 39
> [    0.054674] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> [    0.054679] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> [    0.054681] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> [    0.054684] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> [    0.054686] DMAR: RMRR base: 0x00000064ec2000 end: 0x00000064ee1fff
> [    0.054687] DMAR: RMRR base: 0x0000007a000000 end: 0x0000007c7fffff
> [    0.054688] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
> [    0.054689] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
> [    0.054691] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> [    0.054692] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> [    0.054693] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> [    0.056312] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    0.056314] x2apic enabled
> [    0.056372] APIC: Switched APIC routing to: cluster x2apic
> [    0.060236] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
> [    0.060242] Calibrating delay loop (skipped), value calculated using timer frequency.. 5799.77 BogoMIPS (lpj=11599544)
> [    0.060272] CPU0: Thermal monitoring enabled (TM1)
> [    0.060306] process: using mwait in idle threads
> [    0.060308] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.060309] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.060321] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.060323] Spectre V2 : Mitigation: IBRS
> [    0.060324] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.060325] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> [    0.060325] RETBleed: Mitigation: IBRS
> [    0.060327] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.060328] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.060329] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.060336] MDS: Mitigation: Clear CPU buffers
> [    0.060337] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    0.060341] SRBDS: Mitigation: Microcode
> [    0.060346] GDS: Mitigation: Microcode
> [    0.060352] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.060354] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.060355] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.060355] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.060356] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.060358] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.060359] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.060360] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.060362] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.064239] Freeing SMP alternatives memory: 36K
> [    0.064239] pid_max: default: 32768 minimum: 301
> [    0.064239] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,integrity
> [    0.064239] landlock: Up and running.
> [    0.064239] Yama: disabled by default; enable with sysctl kernel.yama.*
> [    0.064239] AppArmor: AppArmor initialized
> [    0.064239] TOMOYO Linux initialized
> [    0.064239] LSM support for eBPF active
> [    0.064239] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.064239] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.064239] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
> [    0.064239] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064239] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064239] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.064239] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.064239] ... version:                4
> [    0.064239] ... bit width:              48
> [    0.064239] ... generic registers:      4
> [    0.064239] ... value mask:             0000ffffffffffff
> [    0.064239] ... max period:             00007fffffffffff
> [    0.064239] ... fixed-purpose events:   3
> [    0.064239] ... event mask:             000000070000000f
> [    0.064239] signal: max sigframe size: 2032
> [    0.064239] Estimated ratio of average max frequency by base frequency (times 1024): 1235
> [    0.064239] rcu: Hierarchical SRCU implementation.
> [    0.064239] rcu: 	Max phase no-delay instances is 1000.
> [    0.064239] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.064239] smp: Bringing up secondary CPUs ...
> [    0.064239] smpboot: x86: Booting SMP configuration:
> [    0.064239] .... node  #0, CPUs:      #1 #2 #3
> [    0.064239] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.064239] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
> [    0.064239] smp: Brought up 1 node, 4 CPUs
> [    0.064239] smpboot: Max logical packages: 1
> [    0.064239] smpboot: Total of 4 processors activated (23199.08 BogoMIPS)
> [    0.084472] node 0 deferred pages initialised in 20ms
> [    0.085524] devtmpfs: initialized
> [    0.085524] x86/mm: Memory block size: 128MB
> [    0.085540] ACPI: PM: Registering ACPI NVS region [mem 0x556ab000-0x556abfff] (4096 bytes)
> [    0.085540] ACPI: PM: Registering ACPI NVS region [mem 0x651c4000-0x6f871fff] (174776320 bytes)
> [    0.090097] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.090105] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.090149] pinctrl core: initialized pinctrl subsystem
> [    0.090646] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.090881] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.090985] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.091111] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.091135] audit: initializing netlink subsys (disabled)
> [    0.091152] audit: type=2000 audit(1705666525.028:1): state=initialized audit_enabled=0 res=1
> [    0.091152] thermal_sys: Registered thermal governor 'fair_share'
> [    0.091152] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.091152] thermal_sys: Registered thermal governor 'step_wise'
> [    0.091152] thermal_sys: Registered thermal governor 'user_space'
> [    0.091152] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.091152] cpuidle: using governor ladder
> [    0.091152] cpuidle: using governor menu
> [    0.091152] Simple Boot Flag at 0x47 set to 0x80
> [    0.091152] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.091152] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.091152] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    0.091152] PCI: not using MMCONFIG
> [    0.091152] PCI: Using configuration type 1 for base access
> [    0.091152] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.091152] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.091152] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.091152] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.091152] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.091152] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.091152] ACPI: Added _OSI(Module Device)
> [    0.091152] ACPI: Added _OSI(Processor Device)
> [    0.091152] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.092245] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.124380] ACPI: 11 ACPI AML tables successfully acquired and loaded
> [    5.046680] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    5.051806] ACPI: Dynamic OEM Table Load:
> [    5.051812] ACPI: SSDT 0xFFFF9D59810D8800 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
> [    5.052757] ACPI: Dynamic OEM Table Load:
> [    5.052762] ACPI: SSDT 0xFFFF9D598113A000 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
> [    5.054323] ACPI: Dynamic OEM Table Load:
> [    5.054327] ACPI: SSDT 0xFFFF9D5981139000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
> [    5.055491] ACPI: Dynamic OEM Table Load:
> [    5.055495] ACPI: SSDT 0xFFFF9D598114E600 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
> [    5.057881] ACPI: _OSC evaluated successfully for all CPUs
> [    5.058011] ACPI: EC: EC started
> [    5.058012] ACPI: EC: interrupt blocked
> [    5.062577] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    5.062579] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
> [    5.062581] ACPI: Interpreter enabled
> [    5.062616] ACPI: PM: (supports S0 S3 S4 S5)
> [    5.062617] ACPI: Using IOAPIC for interrupt routing
> [    5.062653] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [    5.063340] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
> [    5.063349] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    5.063350] PCI: Using E820 reservations for host bridge windows
> [    5.063833] ACPI: Enabled 8 GPEs in block 00 to 7F
> [    5.075046] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
> [    5.075301] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
> [    5.075556] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
> [    5.075806] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
> [    5.076313] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
> [    5.076564] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
> [    5.077166] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
> [    5.077416] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
> [    5.077669] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
> [    5.077919] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
> [    5.078167] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
> [    5.078421] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
> [    5.078674] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
> [    5.078938] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
> [    5.079186] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
> [    5.079439] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
> [    5.079689] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
> [    5.080733] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
> [    5.080984] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
> [    5.081234] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
> [    5.099161] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    5.099167] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    5.099317] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
> [    5.099585] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability LTR]
> [    5.099587] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    5.100379] PCI host bridge to bus 0000:00
> [    5.100381] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    5.100383] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    5.100386] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
> [    5.100387] pci_bus 0000:00: root bus resource [mem 0x7c800000-0xdfffffff window]
> [    5.100388] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    5.100392] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    5.100410] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
> [    5.100482] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
> [    5.100489] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
> [    5.100494] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
> [    5.100498] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> [    5.100510] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    5.100512] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    5.100651] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
> [    5.100659] pci 0000:00:04.0: reg 0x10: [mem 0xdc320000-0xdc327fff 64bit]
> [    5.100898] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
> [    5.100912] pci 0000:00:14.0: reg 0x10: [mem 0xdc310000-0xdc31ffff 64bit]
> [    5.100971] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    5.101413] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
> [    5.101427] pci 0000:00:14.2: reg 0x10: [mem 0xdc334000-0xdc334fff 64bit]
> [    5.101567] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
> [    5.101599] pci 0000:00:15.0: reg 0x10: [mem 0xdc333000-0xdc333fff 64bit]
> [    5.101911] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
> [    5.101941] pci 0000:00:15.1: reg 0x10: [mem 0xdc332000-0xdc332fff 64bit]
> [    5.102245] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
> [    5.102258] pci 0000:00:16.0: reg 0x10: [mem 0xdc331000-0xdc331fff 64bit]
> [    5.102302] pci 0000:00:16.0: PME# supported from D3hot
> [    5.102588] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
> [    5.102647] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    5.102661] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
> [    5.103022] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
> [    5.103093] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    5.103111] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
> [    5.103478] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
> [    5.103540] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    5.103556] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
> [    5.103933] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
> [    5.104210] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
> [    5.104221] pci 0000:00:1f.2: reg 0x10: [mem 0xdc32c000-0xdc32ffff]
> [    5.104430] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380
> [    5.104448] pci 0000:00:1f.3: reg 0x10: [mem 0xdc328000-0xdc32bfff 64bit]
> [    5.104472] pci 0000:00:1f.3: reg 0x20: [mem 0xdc300000-0xdc30ffff 64bit]
> [    5.104513] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    5.105037] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
> [    5.105095] pci 0000:00:1f.4: reg 0x10: [mem 0xdc330000-0xdc3300ff 64bit]
> [    5.105166] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
> [    5.105485] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400
> [    5.105532] pci 0000:01:00.0: enabling Extended Tags
> [    5.105609] pci 0000:01:00.0: supports D1 D2
> [    5.105610] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    5.105684] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    5.105939] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    5.105944] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    5.105948] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.106024] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400
> [    5.106073] pci 0000:02:00.0: enabling Extended Tags
> [    5.106154] pci 0000:02:00.0: supports D1 D2
> [    5.106155] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    5.106320] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400
> [    5.106368] pci 0000:02:01.0: enabling Extended Tags
> [    5.106454] pci 0000:02:01.0: supports D1 D2
> [    5.106455] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    5.106615] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400
> [    5.106664] pci 0000:02:02.0: enabling Extended Tags
> [    5.106747] pci 0000:02:02.0: supports D1 D2
> [    5.106748] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    5.106919] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [    5.106926] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    5.106932] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.106968] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    5.106976] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [    5.107017] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [    5.107025] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [    5.107030] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.107102] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330
> [    5.107123] pci 0000:39:00.0: reg 0x10: [mem 0xd9f00000-0xd9f0ffff]
> [    5.107196] pci 0000:39:00.0: enabling Extended Tags
> [    5.107299] pci 0000:39:00.0: supports D1 D2
> [    5.107300] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    5.107398] pci 0000:39:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    5.107533] pci 0000:02:02.0: PCI bridge to [bus 39]
> [    5.107541] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [    5.107895] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000
> [    5.108112] pci 0000:3a:00.0: reg 0x10: [mem 0xdc000000-0xdc1fffff 64bit]
> [    5.109225] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
> [    5.110818] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    5.110822] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    5.110908] pci 0000:3b:00.0: [1c5c:1284] type 00 class 0x010802
> [    5.110929] pci 0000:3b:00.0: reg 0x10: [mem 0xdc200000-0xdc203fff 64bit]
> [    5.111034] pci 0000:3b:00.0: PME# supported from D0 D1 D3hot
> [    5.111343] pci 0000:00:1d.0: PCI bridge to [bus 3b]
> [    5.111346] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    5.114023] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    5.114023] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> [    5.114023] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> [    5.124100] ACPI: EC: interrupt unblocked
> [    5.124101] ACPI: EC: event unblocked
> [    5.124107] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
> [    5.124108] ACPI: EC: GPE=0x14
> [    5.124109] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
> [    5.124111] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
> [    5.124242] iommu: Default domain type: Translated
> [    5.124242] iommu: DMA domain TLB invalidation policy: lazy mode
> [    5.124242] pps_core: LinuxPPS API ver. 1 registered
> [    5.124242] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    5.124242] PTP clock support registered
> [    5.124242] EDAC MC: Ver: 3.0.0
> [    5.124554] efivars: Registered efivars operations
> [    5.124589] NetLabel: Initializing
> [    5.124589] NetLabel:  domain hash size = 128
> [    5.124589] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    5.124589] NetLabel:  unlabeled traffic allowed by default
> [    5.124589] PCI: Using ACPI for IRQ routing
> [    5.146975] PCI: pci_cache_line_size set to 64 bytes
> [    5.147365] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    5.147366] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [    5.147367] e820: reserve RAM buffer [mem 0x4ea13018-0x4fffffff]
> [    5.147368] e820: reserve RAM buffer [mem 0x556ab000-0x57ffffff]
> [    5.147370] e820: reserve RAM buffer [mem 0x62264000-0x63ffffff]
> [    5.147371] e820: reserve RAM buffer [mem 0x64df4000-0x67ffffff]
> [    5.147372] e820: reserve RAM buffer [mem 0x78600000-0x7bffffff]
> [    5.147373] e820: reserve RAM buffer [mem 0x481800000-0x483ffffff]
> [    5.148246] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    5.148247] pci 0000:00:02.0: vgaarb: bridge control possible
> [    5.148248] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    5.148252] vgaarb: loaded
> [    5.148322] clocksource: Switched to clocksource tsc-early
> [    5.148991] VFS: Disk quotas dquot_6.6.0
> [    5.149004] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    5.149115] AppArmor: AppArmor Filesystem Enabled
> [    5.149127] pnp: PnP ACPI init
> [    5.149332] system 00:00: [io  0x0680-0x069f] has been reserved
> [    5.149335] system 00:00: [io  0xffff] has been reserved
> [    5.149337] system 00:00: [io  0xffff] has been reserved
> [    5.149338] system 00:00: [io  0xffff] has been reserved
> [    5.149340] system 00:00: [io  0x1800-0x18fe] has been reserved
> [    5.149341] system 00:00: [io  0x164e-0x164f] has been reserved
> [    5.149463] system 00:02: [io  0x1854-0x1857] has been reserved
> [    5.149793] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
> [    5.149796] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
> [    5.149798] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
> [    5.149799] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
> [    5.149801] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    5.149802] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
> [    5.149804] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    5.149806] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> [    5.149807] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    5.149809] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
> [    5.149853] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
> [    5.149856] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    5.149857] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    5.149859] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    5.149860] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    5.149862] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    5.149863] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    5.150107] system 00:07: [io  0xff00-0xfffe] has been reserved
> [    5.150988] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
> [    5.150990] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
> [    5.154084] pnp: PnP ACPI: found 9 devices
> [    5.159616] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    5.159670] NET: Registered PF_INET protocol family
> [    5.159790] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    5.162055] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    5.162078] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    5.162133] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    5.162319] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    5.162511] TCP: Hash tables configured (established 131072 bind 65536)
> [    5.162577] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    5.162616] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    5.162657] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    5.162710] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    5.162715] NET: Registered PF_XDP protocol family
> [    5.162725] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
> [    5.162729] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
> [    5.162731] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [    5.162734] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
> [    5.162736] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 3000
> [    5.162743] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x4fff]
> [    5.162746] pci 0000:01:00.0: BAR 13: assigned [io  0x2000-0x3fff]
> [    5.162749] pci 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [    5.162751] pci 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [    5.162753] pci 0000:02:01.0: BAR 13: assigned [io  0x2000-0x2fff]
> [    5.162754] pci 0000:02:02.0: BAR 13: assigned [io  0x3000-0x3fff]
> [    5.162756] pci 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [    5.162757] pci 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [    5.162759] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    5.162764] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [    5.162772] pci 0000:02:01.0: PCI bridge to [bus 04-38]
> [    5.162775] pci 0000:02:01.0:   bridge window [io  0x2000-0x2fff]
> [    5.162779] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
> [    5.162783] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162788] pci 0000:02:02.0: PCI bridge to [bus 39]
> [    5.162791] pci 0000:02:02.0:   bridge window [io  0x3000-0x3fff]
> [    5.162795] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
> [    5.162803] pci 0000:01:00.0: PCI bridge to [bus 02-39]
> [    5.162805] pci 0000:01:00.0:   bridge window [io  0x2000-0x3fff]
> [    5.162809] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    5.162814] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162820] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
> [    5.162821] pci 0000:00:1c.0:   bridge window [io  0x2000-0x4fff]
> [    5.162824] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
> [    5.162827] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162830] pci 0000:00:1c.4: PCI bridge to [bus 3a]
> [    5.162833] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
> [    5.162839] pci 0000:00:1d.0: PCI bridge to [bus 3b]
> [    5.162842] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    5.162847] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    5.162849] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    5.162850] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
> [    5.162851] pci_bus 0000:00: resource 7 [mem 0x7c800000-0xdfffffff window]
> [    5.162853] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> [    5.162854] pci_bus 0000:01: resource 0 [io  0x2000-0x4fff]
> [    5.162855] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
> [    5.162857] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162858] pci_bus 0000:02: resource 0 [io  0x2000-0x3fff]
> [    5.162859] pci_bus 0000:02: resource 1 [mem 0xc4000000-0xda0fffff]
> [    5.162860] pci_bus 0000:02: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162862] pci_bus 0000:03: resource 1 [mem 0xda000000-0xda0fffff]
> [    5.162863] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
> [    5.162864] pci_bus 0000:04: resource 1 [mem 0xc4000000-0xd9efffff]
> [    5.162865] pci_bus 0000:04: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
> [    5.162867] pci_bus 0000:39: resource 0 [io  0x3000-0x3fff]
> [    5.162868] pci_bus 0000:39: resource 1 [mem 0xd9f00000-0xd9ffffff]
> [    5.162869] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
> [    5.162871] pci_bus 0000:3b: resource 1 [mem 0xdc200000-0xdc2fffff]
> [    5.163385] pci 0000:01:00.0: enabling device (0006 -> 0007)
> [    5.163422] pci 0000:02:02.0: enabling device (0006 -> 0007)
> [    5.163688] PCI: CLS 128 bytes, default 64
> [    5.163699] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
> [    5.163703] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
> [    5.163713] DMAR: No ATSR found
> [    5.163714] DMAR: No SATC found
> [    5.163715] DMAR: IOMMU feature fl1gp_support inconsistent
> [    5.163716] DMAR: IOMMU feature pgsel_inv inconsistent
> [    5.163717] DMAR: IOMMU feature nwfs inconsistent
> [    5.163718] DMAR: IOMMU feature pasid inconsistent
> [    5.163719] DMAR: IOMMU feature eafs inconsistent
> [    5.163720] DMAR: IOMMU feature prs inconsistent
> [    5.163720] DMAR: IOMMU feature nest inconsistent
> [    5.163721] DMAR: IOMMU feature mts inconsistent
> [    5.163722] DMAR: IOMMU feature sc_support inconsistent
> [    5.163722] DMAR: IOMMU feature dev_iotlb_support inconsistent
> [    5.163724] DMAR: dmar0: Using Queued invalidation
> [    5.163727] DMAR: dmar1: Using Queued invalidation
> [    5.163757] Trying to unpack rootfs image as initramfs...
> [    5.164027] pci 0000:00:02.0: Adding to iommu group 0
> [    5.164070] pci 0000:00:00.0: Adding to iommu group 1
> [    5.164080] pci 0000:00:04.0: Adding to iommu group 2
> [    5.164098] pci 0000:00:14.0: Adding to iommu group 3
> [    5.164107] pci 0000:00:14.2: Adding to iommu group 3
> [    5.164124] pci 0000:00:15.0: Adding to iommu group 4
> [    5.164133] pci 0000:00:15.1: Adding to iommu group 4
> [    5.164146] pci 0000:00:16.0: Adding to iommu group 5
> [    5.164164] pci 0000:00:1c.0: Adding to iommu group 6
> [    5.164176] pci 0000:00:1c.4: Adding to iommu group 7
> [    5.164187] pci 0000:00:1d.0: Adding to iommu group 8
> [    5.164210] pci 0000:00:1f.0: Adding to iommu group 9
> [    5.164221] pci 0000:00:1f.2: Adding to iommu group 9
> [    5.164231] pci 0000:00:1f.3: Adding to iommu group 9
> [    5.164241] pci 0000:00:1f.4: Adding to iommu group 9
> [    5.164253] pci 0000:01:00.0: Adding to iommu group 10
> [    5.164264] pci 0000:02:00.0: Adding to iommu group 11
> [    5.164275] pci 0000:02:01.0: Adding to iommu group 12
> [    5.164286] pci 0000:02:02.0: Adding to iommu group 13
> [    5.164292] pci 0000:39:00.0: Adding to iommu group 13
> [    5.164305] pci 0000:3a:00.0: Adding to iommu group 14
> [    5.164316] pci 0000:3b:00.0: Adding to iommu group 15
> [    5.165458] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    5.165461] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    5.165462] software IO TLB: mapped [mem 0x000000005e264000-0x0000000062264000] (64MB)
> [    5.165531] sgx: EPC section 0x70200000-0x75f7ffff
> [    5.166406] Initialise system trusted keyrings
> [    5.166417] Key type blacklist registered
> [    5.166474] workingset: timestamp_bits=36 max_order=22 bucket_order=0
> [    5.166484] zbud: loaded
> [    5.166578] fuse: init (API version 7.39)
> [    5.166710] integrity: Platform Keyring initialized
> [    5.166714] integrity: Machine keyring initialized
> [    5.166715] Key type asymmetric registered
> [    5.166717] Asymmetric key parser 'x509' registered
> [    5.297299] Freeing initrd memory: 60468K
> [    5.301405] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [    5.301434] io scheduler mq-deadline registered
> [    5.302705] pcieport 0000:02:01.0: enabling device (0006 -> 0007)
> [    5.302996] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    5.303011] efifb: probing for efifb
> [    5.303027] efifb: framebuffer at 0x90000000, using 22500k, total 22500k
> [    5.303029] efifb: mode is 3200x1800x32, linelength=12800, pages=1
> [    5.303030] efifb: scrolling: redraw
> [    5.303031] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    5.303109] Console: switching to colour frame buffer device 200x56
> [    5.306578] fb0: EFI VGA frame buffer device
> [    5.308533] thermal LNXTHERM:00: registered as thermal_zone0
> [    5.308535] ACPI: thermal: Thermal Zone [THM] (25 C)
> [    5.308673] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    5.309154] hpet_acpi_add: no address or irqs in _CRS
> [    5.309173] Linux agpgart interface v0.103
> [    5.321045] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> [    5.360121] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    5.360396] i8042: Warning: Keylock active
> [    5.362622] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    5.362628] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    5.362825] mousedev: PS/2 mouse device common for all mice
> [    5.362866] rtc_cmos 00:01: RTC can wake from S4
> [    5.363677] rtc_cmos 00:01: registered as rtc0
> [    5.363836] rtc_cmos 00:01: setting system clock to 2024-01-19T12:15:31 UTC (1705666531)
> [    5.363863] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
> [    5.364110] intel_pstate: Intel P-state driver initializing
> [    5.364367] intel_pstate: HWP enabled
> [    5.364412] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    5.365951] ledtrig-cpu: registered to indicate activity on CPUs
> [    5.382432] NET: Registered PF_INET6 protocol family
> [    5.387972] Segment Routing with IPv6
> [    5.387987] In-situ OAM (IOAM) with IPv6
> [    5.388018] mip6: Mobile IPv6
> [    5.388022] NET: Registered PF_PACKET protocol family
> [    5.388084] mpls_gso: MPLS GSO support
> [    5.388406] microcode: Current revision: 0x000000f4
> [    5.388409] microcode: Updated early from: 0x000000f0
> [    5.388491] IPI shorthand broadcast: enabled
> [    5.389943] sched_clock: Marking stable (5384002282, 5820600)->(5493284337, -103461455)
> [    5.390118] registered taskstats version 1
> [    5.390215] Loading compiled-in X.509 certificates
> [    5.410241] Loaded X.509 cert 'Build time autogenerated kernel key: 45375d97a88689d31f3746ef65fc2b509cef42c6'
> [    5.412443] Key type .fscrypt registered
> [    5.412446] Key type fscrypt-provisioning registered
> [    5.421005] cryptd: max_cpu_qlen set to 1000
> [    5.429220] AVX2 version of gcm_enc/dec engaged.
> [    5.429254] AES CTR mode by8 optimization enabled
> [    5.453274] Key type encrypted registered
> [    5.453278] AppArmor: AppArmor sha1 policy hashing enabled
> [    5.453506] integrity: Loading X.509 certificate: UEFI:db
> [    5.453526] integrity: Loaded X.509 cert 'Dell Inc. UEFI DB: 5ddb772dc880660055ba0bc131886bb630a639e7'
> [    5.453527] integrity: Loading X.509 certificate: UEFI:db
> [    5.453544] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [    5.453545] integrity: Loading X.509 certificate: UEFI:db
> [    5.453558] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [    5.453874] ima: Allocated hash algorithm: sha256
> [    5.491991] ima: No architecture policies found
> [    5.492014] evm: Initialising EVM extended attributes:
> [    5.492015] evm: security.selinux
> [    5.492017] evm: security.SMACK64 (disabled)
> [    5.492018] evm: security.SMACK64EXEC (disabled)
> [    5.492018] evm: security.SMACK64TRANSMUTE (disabled)
> [    5.492019] evm: security.SMACK64MMAP (disabled)
> [    5.492020] evm: security.apparmor
> [    5.492021] evm: security.ima
> [    5.492021] evm: security.capability
> [    5.492022] evm: HMAC attrs: 0x1
> [    5.613514] RAS: Correctable Errors collector initialized.
> [    5.613587] clk: Disabling unused clocks
> [    5.614475] Freeing unused decrypted memory: 2028K
> [    5.614877] Freeing unused kernel image (initmem) memory: 3992K
> [    5.630127] Write protecting the kernel read-only data: 28672k
> [    5.630694] Freeing unused kernel image (rodata/data gap) memory: 1636K
> [    5.674643] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    5.674645] x86/mm: Checking user space page tables
> [    5.716804] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    5.716808] Run /init as init process
> [    5.716810]   with arguments:
> [    5.716811]     /init
> [    5.716811]   with environment:
> [    5.716812]     HOME=/
> [    5.716813]     TERM=linux
> [    5.716813]     BOOT_IMAGE=/vmlinuz-6.7-amd64
> [    5.901869] wmi_bus wmi_bus-PNP0C14:01: WQBC data block query control method not found
> [    5.914076] hid: raw HID events driver (C) Jiri Kosina
> [    5.948726] ACPI: battery: Slot [BAT0] (battery present)
> [    5.950745] ACPI: bus type USB registered
> [    5.950776] usbcore: registered new interface driver usbfs
> [    5.950786] usbcore: registered new interface driver hub
> [    5.950798] usbcore: registered new device driver usb
> [    5.952989] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    5.953042] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    5.953111] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000
> [    5.953171] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
> [    5.953406] pci 0000:00:1f.1: Adding to iommu group 16
> [    5.956727] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    5.957041] platform idma64.0: Adding to iommu group 16
> [    5.957169] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    5.957445] platform i2c_designware.0: Adding to iommu group 17
> [    5.974186] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    5.974381] i2c i2c-0: 2/2 memory slots populated (from DMI)
> [    5.974404] platform idma64.1: Adding to iommu group 18
> [    5.974553] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    5.974591] platform i2c_designware.1: Adding to iommu group 19
> [    5.982071] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    5.982079] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    5.983222] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
> [    5.984172] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    5.984177] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    5.984181] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    5.984219] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.07
> [    5.984221] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.984224] usb usb1: Product: xHCI Host Controller
> [    5.984225] usb usb1: Manufacturer: Linux 6.7-amd64 xhci-hcd
> [    5.984227] usb usb1: SerialNumber: 0000:00:14.0
> [    5.984746] hub 1-0:1.0: USB hub found
> [    5.984762] hub 1-0:1.0: 12 ports detected
> [    5.988780] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.07
> [    5.988784] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.988786] usb usb2: Product: xHCI Host Controller
> [    5.988788] usb usb2: Manufacturer: Linux 6.7-amd64 xhci-hcd
> [    5.988789] usb usb2: SerialNumber: 0000:00:14.0
> [    5.988958] hub 2-0:1.0: USB hub found
> [    5.988970] hub 2-0:1.0: 6 ports detected
> [    5.990259] usb: port power management may be unreliable
> [    5.990711] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [    5.990716] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
> [    5.991897] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [    5.992149] xhci_hcd 0000:39:00.0: xHCI Host Controller
> [    5.992152] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
> [    5.992155] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [    5.992189] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.07
> [    5.992192] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.992194] usb usb3: Product: xHCI Host Controller
> [    5.992196] usb usb3: Manufacturer: Linux 6.7-amd64 xhci-hcd
> [    5.992197] usb usb3: SerialNumber: 0000:39:00.0
> [    5.992308] hub 3-0:1.0: USB hub found
> [    5.992317] hub 3-0:1.0: 2 ports detected
> [    5.992742] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.07
> [    5.992745] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.992747] usb usb4: Product: xHCI Host Controller
> [    5.992749] usb usb4: Manufacturer: Linux 6.7-amd64 xhci-hcd
> [    5.992751] usb usb4: SerialNumber: 0000:39:00.0
> [    5.992850] hub 4-0:1.0: USB hub found
> [    5.992859] hub 4-0:1.0: 2 ports detected
> [    6.001298] ACPI: bus type drm_connector registered
> [    6.163044] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input2
> [    6.163113] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input3
> [    6.163170] hid-generic 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [    6.170673] tsc: Refined TSC clocksource calibration: 2904.000 MHz
> [    6.170681] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
> [    6.170917] clocksource: Switched to clocksource tsc
> [    6.180089] nvme nvme0: pci function 0000:3b:00.0
> [    6.199297] nvme nvme0: 4/0/0 default/read/poll queues
> [    6.204698]  nvme0n1: p1 p2 p3 p4
> [    6.245910] usb 1-1: new low-speed USB device number 2 using xhci_hcd
> [    6.245926] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [    6.251851] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [    6.251889] device-mapper: uevent: version 1.0.3
> [    6.252078] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
> [    6.398220] usb 3-1: New USB device found, idVendor=2109, idProduct=2820, bcdDevice=30.03
> [    6.398243] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.398255] usb 3-1: Product: USB2.0 Hub             
> [    6.398263] usb 3-1: Manufacturer: VIA Labs, Inc.         
> [    6.401774] hub 3-1:1.0: USB hub found
> [    6.402046] hub 3-1:1.0: 5 ports detected
> [    6.402678] usb 1-1: New USB device found, idVendor=0bf8, idProduct=101e, bcdDevice= 1.09
> [    6.402700] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.402709] usb 1-1: Product: Fujitsu Keyboard
> [    6.402717] usb 1-1: Manufacturer: Fujitsu
> [    6.433062] input: Fujitsu Fujitsu Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:0BF8:101E.0002/input/input5
> [    6.490653] hid-generic 0003:0BF8:101E.0002: input,hidraw1: USB HID v1.10 Keyboard [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input0
> [    6.499143] input: Fujitsu Fujitsu Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.0003/input/input6
> [    6.529401] usb 4-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
> [    6.533897] usb 1-2: new low-speed USB device number 3 using xhci_hcd
> [    6.549884] usb 4-1: New USB device found, idVendor=2109, idProduct=0820, bcdDevice=30.03
> [    6.549903] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.549912] usb 4-1: Product: USB3.1 Hub             
> [    6.549919] usb 4-1: Manufacturer: VIA Labs, Inc.         
> [    6.552847] hub 4-1:1.0: USB hub found
> [    6.553500] hub 4-1:1.0: 4 ports detected
> [    6.558137] input: Fujitsu Fujitsu Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:0BF8:101E.0003/input/input7
> [    6.558515] hid-generic 0003:0BF8:101E.0003: input,hiddev0,hidraw2: USB HID v1.10 Device [Fujitsu Fujitsu Keyboard] on usb-0000:00:14.0-1/input1
> [    6.558667] usbcore: registered new interface driver usbhid
> [    6.558677] usbhid: USB HID core driver
> [    6.686874] usb 1-2: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
> [    6.686899] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.686910] usb 1-2: Product: USB Optical Mouse
> [    6.686919] usb 1-2: Manufacturer: Logitech
> [    6.691887] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C077.0004/input/input8
> [    6.692216] hid-generic 0003:046D:C077.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:14.0-2/input0
> [    6.818146] usb 1-3: new full-speed USB device number 4 using xhci_hcd
> [    6.968213] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
> [    6.968239] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    7.098079] usb 1-4: new full-speed USB device number 5 using xhci_hcd
> [    7.138117] usb 3-1.1: new full-speed USB device number 3 using xhci_hcd
> [    7.249134] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
> [    7.249163] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
> [    7.249175] usb 1-4: Product: Touchscreen
> [    7.249183] usb 1-4: Manufacturer: ELAN
> [    7.262726] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input9
> [    7.262787] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input10
> [    7.262809] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input11
> [    7.262870] hid-generic 0003:04F3:2234.0005: input,hiddev1,hidraw4: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [    7.294650] usb 3-1.1: New USB device found, idVendor=06c4, idProduct=c412, bcdDevice= 0.06
> [    7.294672] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    7.294682] usb 3-1.1: Product: DELL DA300
> [    7.294689] usb 3-1.1: Manufacturer: Bizlink
> [    7.294696] usb 3-1.1: SerialNumber: MCU Ver0006
> [    7.308232] hid-generic 0003:06C4:C412.0006: hiddev2,hidraw5: USB HID v1.11 Device [Bizlink DELL DA300] on usb-0000:39:00.0-1.1/input0
> [    7.389974] usb 1-5: new high-speed USB device number 6 using xhci_hcd
> [    7.599265] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
> [    7.599290] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [    7.599302] usb 1-5: Product: Integrated_Webcam_HD
> [    7.599310] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
> [    8.414385] usb 4-1.2: new SuperSpeed USB device number 3 using xhci_hcd
> [    8.434955] usb 4-1.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
> [    8.434978] usb 4-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [    8.434987] usb 4-1.2: Product: USB 10/100/1000 LAN
> [    8.434994] usb 4-1.2: Manufacturer: Realtek
> [    8.435000] usb 4-1.2: SerialNumber: 001000001
> [    8.449635] usbcore: registered new device driver r8152-cfgselector
> [    8.535005] r8152-cfgselector 4-1.2: reset SuperSpeed USB device number 3 using xhci_hcd
> [    8.560039] r8152 4-1.2:1.0: firmware: direct-loading firmware rtl_nic/rtl8153b-2.fw
> [    8.560098] r8152 4-1.2:1.0 (unnamed net_device) (uninitialized): Using pass-thru MAC addr 18:db:f2:2d:cc:f3
> [    8.562628] r8152 4-1.2:1.0: load rtl8153b-2 v2 04/27/23 successfully
> [    8.610249] r8152 4-1.2:1.0 eth0: v1.12.13
> [    8.610371] usbcore: registered new interface driver r8152
> [    8.628791] usbcore: registered new interface driver cdc_ether
> [    8.633613] usbcore: registered new interface driver r8153_ecm
> [    8.661130] r8152 4-1.2:1.0 enx18dbf22dccf3: renamed from eth0
> [   12.612396] PM: Image not found (code -22)
> [   12.785277] EXT4-fs (dm-0): mounted filesystem 32e29882-d94d-4a92-9ee4-4d03002bfa29 ro with ordered data mode. Quota mode: none.
> [   12.828218] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> [   12.902768] systemd[1]: Inserted module 'autofs4'
> [   12.941965] systemd[1]: systemd 255.2-4 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [   12.941981] systemd[1]: Detected architecture x86-64.
> [   12.943181] systemd[1]: Hostname set to <abreu>.
> [   13.119736] systemd[1]: Queued start job for default target graphical.target.
> [   13.142916] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
> [   13.143242] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> [   13.143511] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
> [   13.143777] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
> [   13.143988] systemd[1]: Created slice user.slice - User and Session Slice.
> [   13.144055] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
> [   13.144102] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> [   13.144274] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> [   13.144300] systemd[1]: Expecting device dev-disk-by\x2ddiskseq-1\x2dpart4.device - /dev/disk/by-diskseq/1-part4...
> [   13.144306] systemd[1]: Expecting device dev-disk-by\x2duuid-2d23fd4c\x2d5d03\x2d4e1a\x2d8a42\x2d0e859d1f00d8.device - /dev/disk/by-uuid/2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8...
> [   13.144313] systemd[1]: Expecting device dev-disk-by\x2duuid-61be8f50\x2d69c5\x2d49a5\x2dbcad\x2d3f4521e9c7b5.device - /dev/disk/by-uuid/61be8f50-69c5-49a5-bcad-3f4521e9c7b5...
> [   13.144319] systemd[1]: Expecting device dev-disk-by\x2duuid-96BD\x2d5653.device - /dev/disk/by-uuid/96BD-5653...
> [   13.144338] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
> [   13.144354] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
> [   13.144365] systemd[1]: Reached target remote-fs.target - Remote File Systems.
> [   13.144377] systemd[1]: Reached target slices.target - Slice Units.
> [   13.144397] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
> [   13.145558] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
> [   13.145653] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
> [   13.145711] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
> [   13.145840] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> [   13.145964] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
> [   13.145994] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.146229] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> [   13.146323] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> [   13.147326] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> [   13.148018] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> [   13.149122] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> [   13.153406] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> [   13.156564] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
> [   13.158933] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> [   13.160325] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> [   13.163938] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
> [   13.165704] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
> [   13.168962] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> [   13.178170] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
> [   13.179544] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
> [   13.179629] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
> [   13.182448] pstore: Using crash dump compression: deflate
> [   13.186067] systemd[1]: Starting systemd-journald.service - Journal Service...
> [   13.189317] pstore: Registered efi_pstore as persistent store backend
> [   13.189850] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> [   13.189876] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.191196] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> [   13.191275] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.195693] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> [   13.199452] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> [   13.199703] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> [   13.199830] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> [   13.199976] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> [   13.200303] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
> [   13.200660] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> [   13.201027] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [   13.201219] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> [   13.201666] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
> [   13.201853] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
> [   13.202202] systemd[1]: modprobe@drm.service: Deactivated successfully.
> [   13.202383] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
> [   13.202776] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> [   13.202957] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> [   13.203365] systemd[1]: modprobe@fuse.service: Deactivated successfully.
> [   13.203624] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
> [   13.206018] loop: module loaded
> [   13.206779] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> [   13.208173] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> [   13.214062] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> [   13.214549] systemd[1]: modprobe@loop.service: Deactivated successfully.
> [   13.214756] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
> [   13.215009] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
> [   13.216823] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> [   13.218308] systemd-journald[434]: Collecting audit messages is disabled.
> [   13.220025] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> [   13.226883] lp: driver loaded but no devices found
> [   13.232891] ppdev: user-space parallel port driver
> [   13.239864] EXT4-fs (dm-0): re-mounted 32e29882-d94d-4a92-9ee4-4d03002bfa29 r/w. Quota mode: none.
> [   13.241534] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> [   13.242290] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> [   13.242340] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> [   13.244133] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> [   13.244178] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [   13.251343] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> [   13.251555] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
> [   13.253335] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> [   13.260300] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> [   13.266075] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> [   13.273302] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> [   13.278405] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
> [   13.278570] systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
> [   13.280902] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
> [   13.283640] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> [   13.297820] systemd[1]: Started systemd-journald.service - Journal Service.
> [   13.314612] systemd-journald[434]: Received client request to flush runtime journal.
> [   13.326624] systemd-journald[434]: /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/system.journal: Journal file uses a different sequence number ID, rotating.
> [   13.326629] systemd-journald[434]: Rotating system journal.
> [   13.548666] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input13
> [   13.550008] ACPI: button: Lid Switch [LID0]
> [   13.550070] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input14
> [   13.551073] ACPI: AC: AC Adapter [AC] (on-line)
> [   13.558628] Consider using thermal netlink events interface
> [   13.564862] intel_pmc_core INT33A1:00:  initialized
> [   13.567272] input: Intel HID events as /devices/platform/INT33D5:00/input/input15
> [   13.604550] ACPI: button: Power Button [PBTN]
> [   13.604624] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input16
> [   13.606064] intel-hid INT33D5:00: platform supports 5 button array
> [   13.610287] input: Intel HID 5 button array as /devices/platform/INT33D5:00/input/input17
> [   13.610349] ACPI: button: Sleep Button [SBTN]
> [   13.610408] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input18
> [   13.610510] ACPI: button: Power Button [PWRF]
> [   13.614188] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input19
> [   13.615619] input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D6:00/input/input22
> [   13.623704] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
> [   13.633273] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
> [   13.640111] hid-multitouch 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
> [   13.651111] intel_rapl_common: Found RAPL domain package
> [   13.651116] intel_rapl_common: Found RAPL domain dram
> [   13.688905] Adding 8387904k swap on /dev/nvme0n1p4.  Priority:-2 extents:1 across:8387904k SS
> [   13.721809] mc: Linux media interface: v0.10
> [   13.761179] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [   13.789915] input: PC Speaker as /devices/platform/pcspkr/input/input24
> [   13.793064] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input25
> [   13.793390] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input26
> [   13.793566] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0005/input/input27
> [   13.794019] videodev: Linux video capture interface: v2.00
> [   13.812667] hid-multitouch 0003:04F3:2234.0005: input,hiddev1,hidraw4: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
> [   13.831665] iTCO_vendor_support: vendor-support=0
> [   13.881659] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
> [   13.904360] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [   13.904801] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
> [   13.904861] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   13.906575] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   13.906802] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
> [   13.907002] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
> [   13.907205] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   13.907405] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   13.913933] platform regulatory.0: firmware: direct-loading firmware regulatory.db
> [   13.915818] platform regulatory.0: firmware: direct-loading firmware regulatory.db.p7s
> [   13.974066] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> [   13.974072] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   13.974074] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   13.974075] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   13.974076] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   13.974078] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [   13.975691] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input29
> [   14.030620] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> [   14.031145] EXT4-fs (nvme0n1p2): mounted filesystem 2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8 r/w with ordered data mode. Quota mode: none.
> [   14.187691] usbcore: registered new interface driver uvcvideo
> [   14.302443] intel_rapl_common: Found RAPL domain package
> [   14.302447] intel_rapl_common: Found RAPL domain core
> [   14.302448] intel_rapl_common: Found RAPL domain uncore
> [   14.302450] intel_rapl_common: Found RAPL domain dram
> [   14.302451] intel_rapl_common: Found RAPL domain psys
> [   14.720626] i915 0000:00:02.0: [drm] VT-d active for gfx access
> [   14.721580] Console: switching to colour dummy device 80x25
> [   14.721611] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   14.721657] i915 0000:00:02.0: [drm] Using Transparent Hugepages
> [   14.730436] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   14.731079] i915 0000:00:02.0: firmware: direct-loading firmware i915/kbl_dmc_ver1_04.bin
> [   14.731594] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [   14.768719] Bluetooth: Core ver 2.22
> [   14.768744] NET: Registered PF_BLUETOOTH protocol family
> [   14.768746] Bluetooth: HCI device and connection manager initialized
> [   14.768750] Bluetooth: HCI socket layer initialized
> [   14.768752] Bluetooth: L2CAP socket layer initialized
> [   14.768756] Bluetooth: SCO socket layer initialized
> [   14.777782] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [   14.809040] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
> [   14.809494] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   14.809512] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   14.814684] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> [   14.872426] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   14.876788] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 0
> [   14.888574] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   14.890105] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input30
> [   14.890238] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   14.890807] i915 display info: display version: 9
> [   14.890810] i915 display info: cursor_needs_physical: no
> [   14.890811] i915 display info: has_cdclk_crawl: no
> [   14.890812] i915 display info: has_cdclk_squash: no
> [   14.890813] i915 display info: has_ddi: yes
> [   14.890814] i915 display info: has_dp_mst: yes
> [   14.890816] i915 display info: has_dsb: no
> [   14.890817] i915 display info: has_fpga_dbg: yes
> [   14.890818] i915 display info: has_gmch: no
> [   14.890819] i915 display info: has_hotplug: yes
> [   14.890820] i915 display info: has_hti: no
> [   14.890821] i915 display info: has_ipc: yes
> [   14.890822] i915 display info: has_overlay: no
> [   14.890823] i915 display info: has_psr: yes
> [   14.890824] i915 display info: has_psr_hw_tracking: yes
> [   14.890825] i915 display info: overlay_needs_physical: no
> [   14.890826] i915 display info: supports_tv: no
> [   14.890827] i915 display info: has_hdcp: yes
> [   14.890828] i915 display info: has_dmc: yes
> [   14.890829] i915 display info: has_dsc: no
> [   14.891714] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   14.899009] audit: type=1400 audit(1705666541.031:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=670 comm="apparmor_parser"
> [   14.899380] audit: type=1400 audit(1705666541.031:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=671 comm="apparmor_parser"
> [   14.899385] audit: type=1400 audit(1705666541.031:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=671 comm="apparmor_parser"
> [   14.903191] audit: type=1400 audit(1705666541.035:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=675 comm="apparmor_parser"
> [   14.903197] audit: type=1400 audit(1705666541.035:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=675 comm="apparmor_parser"
> [   14.903199] audit: type=1400 audit(1705666541.035:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=675 comm="apparmor_parser"
> [   14.904763] audit: type=1400 audit(1705666541.035:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=672 comm="apparmor_parser"
> [   14.904770] audit: type=1400 audit(1705666541.035:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=672 comm="apparmor_parser"
> [   14.904772] audit: type=1400 audit(1705666541.035:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=672 comm="apparmor_parser"
> [   14.904774] audit: type=1400 audit(1705666541.035:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=672 comm="apparmor_parser"
> [   14.938183] usbcore: registered new interface driver btusb
> [   14.941259] bluetooth hci0: firmware: direct-loading firmware qca/rampatch_usb_00000302.bin
> [   14.941479] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [   14.941481] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [   14.961032] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   14.965601] fbcon: i915drmfb (fb0) is primary device
> [   14.965867] i915 0000:00:02.0: [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.
> [   15.084496] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
> [   15.084499] firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
> [   15.084511] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
> [   15.084521] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/cal-pci-0000:3a:00.0.bin (-2)
> [   15.084528] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/cal-pci-0000:3a:00.0.bin (-2)
> [   15.087064] ath10k_pci 0000:3a:00.0: firmware: direct-loading firmware ath10k/QCA6174/hw3.0/firmware-6.bin
> [   15.088873] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> [   15.088876] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> [   15.089240] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
> [   15.114535] Console: switching to colour frame buffer device 200x56
> [   15.153226] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [   15.155662] ath10k_pci 0000:3a:00.0: firmware: direct-loading firmware ath10k/QCA6174/hw3.0/board-2.bin
> [   15.158562] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> [   15.254269] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   15.254274] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   15.254275] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   15.254277] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   15.254278] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   15.254282] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
> [   15.254284] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
> [   15.254285] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [   15.260023] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> [   15.300223] bluetooth hci0: firmware: direct-loading firmware qca/nvm_usb_00000302.bin
> [   15.300246] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [   15.331523] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [   15.341648] ath: EEPROM regdomain: 0x6c
> [   15.341650] ath: EEPROM indicates we should expect a direct regpair map
> [   15.341652] ath: Country alpha2 being used: 00
> [   15.341652] ath: Regpair used: 0x6c
> [   15.345818] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
> [   15.757223] NET: Registered PF_QIPCRTR protocol family
> [   15.873382] r8152 4-1.2:1.0 enx18dbf22dccf3: carrier on
> [   16.049992] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input31
> [   16.050060] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input32
> [   16.050119] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input33
> [   16.050173] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input34
> [   16.050221] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input35
> [   19.375624] rfkill: input handler disabled
> [   21.194149] wlp58s0: authenticate with 6c:f3:7f:10:ae:1a (local address=9c:b6:d0:d1:6a:b1)
> [   21.194154] wlp58s0: send auth to 6c:f3:7f:10:ae:1a (try 1/3)
> [   21.200974] wlp58s0: authenticated
> [   21.201123] wlp58s0: VHT capa missing/short, disabling VHT/HE/EHT
> [   21.201833] wlp58s0: associate with 6c:f3:7f:10:ae:1a (try 1/3)
> [   21.212666] wlp58s0: RX AssocResp from 6c:f3:7f:10:ae:1a (capab=0x401 status=0 aid=1)
> [   21.215146] wlp58s0: associated
> [   21.307789] PPP generic driver version 2.4.2
> [   21.310713] NET: Registered PF_PPPOX protocol family
> [   21.325698] l2tp_core: L2TP core driver, V2.0
> [   21.328345] l2tp_netlink: L2TP netlink interface
> [   21.331617] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> [   21.341597] Initializing XFRM netlink socket
> [   21.352219] IPsec XFRM device driver
> [   23.654362] systemd-journald[434]: /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/user-5272.journal: Journal file uses a different sequence number ID, rotating.
> [   24.049182] rfkill: input handler enabled
> [   28.677929] rfkill: input handler disabled
> [   59.095264] wlp58s0: deauthenticating from 6c:f3:7f:10:ae:1a by local choice (Reason: 3=DEAUTH_LEAVING)
> [   99.711230] PM: suspend entry (deep)
> [   99.716031] Filesystems sync: 0.004 seconds
> [   99.716150] (NULL device *): firmware: direct-loading firmware i915/kbl_dmc_ver1_04.bin
> [   99.716253] (NULL device *): firmware: direct-loading firmware regulatory.db
> [   99.716268] (NULL device *): firmware: direct-loading firmware regulatory.db.p7s
> [   99.716298] (NULL device *): firmware: direct-loading firmware qca/nvm_usb_00000302.bin
> [   99.716311] (NULL device *): firmware: direct-loading firmware qca/rampatch_usb_00000302.bin
> [   99.718635] Freezing user space processes
> [   99.720764] Freezing user space processes completed (elapsed 0.002 seconds)
> [   99.720768] OOM killer disabled.
> [   99.720769] Freezing remaining freezable tasks
> [   99.722054] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   99.722101] printk: Suspending console(s) (use no_console_suspend to debug)
> [  100.285178] ACPI: EC: interrupt blocked
> [  100.319908] ACPI: PM: Preparing to enter system sleep state S3
> [  100.331793] ACPI: EC: event blocked
> [  100.331798] ACPI: EC: EC stopped
> [  100.331800] ACPI: PM: Saving platform NVS memory
> [  100.335224] Disabling non-boot CPUs ...
> [  100.337412] smpboot: CPU 1 is now offline
> [  100.341065] smpboot: CPU 2 is now offline
> [  100.346441] smpboot: CPU 3 is now offline
> [  100.353086] ACPI: PM: Low-level resume complete
> [  100.353129] ACPI: EC: EC started
> [  100.353129] ACPI: PM: Restoring platform NVS memory
> [  100.355219] Enabling non-boot CPUs ...
> [  100.355244] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  100.355954] CPU1 is up
> [  100.355972] smpboot: Booting Node 0 Processor 2 APIC 0x1
> [  100.356698] CPU2 is up
> [  100.356716] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  100.357371] CPU3 is up
> [  100.360217] ACPI: PM: Waking up from system sleep state S3
> [  100.668380] ACPI: EC: interrupt unblocked
> [  100.668598] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
> [  100.668606] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
> [  100.668643] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
> [  100.690996] DMAR: DRHD: handling fault status reg 2
> [  100.691001] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault index 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
> [  100.756870] ACPI: EC: event unblocked
> [  100.758124] xhci_hcd 0000:39:00.0: xHC error in resume, USBSTS 0x411, Reinit
> [  100.758129] usb usb3: root hub lost power or was reset
> [  100.758131] usb usb4: root hub lost power or was reset
> [  100.768819] nvme nvme0: 4/0/0 default/read/poll queues
> [  100.788891] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] is disabled/in DSI mode with an ungated DDI clock, gate it
> [  100.791478] i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
> [  100.798652] i915 0000:00:02.0: [drm] [ENCODER:113:DDI C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
> [  101.058430] usb 3-1: reset high-speed USB device number 2 using xhci_hcd
> [  101.214521] usb 1-2: reset low-speed USB device number 3 using xhci_hcd
> [  101.338567] usb 4-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
> [  101.630655] usb 1-3: reset full-speed USB device number 4 using xhci_hcd
> [  101.906544] usb 1-4: reset full-speed USB device number 5 using xhci_hcd
> [  101.966492] usb 3-1.1: reset full-speed USB device number 3 using xhci_hcd
> [  102.182536] usb 1-5: reset high-speed USB device number 6 using xhci_hcd
> [  102.598644] usb 1-1: reset low-speed USB device number 2 using xhci_hcd
> [  102.990582] r8152-cfgselector 4-1.2: reset SuperSpeed USB device number 3 using xhci_hcd
> [  103.013516] r8152 4-1.2:1.0: skip request firmware
> [  103.013637] r8152 4-1.2:1.0 enx18dbf22dccf3: Using pass-thru MAC addr 18:db:f2:2d:cc:f3
> [  103.016440] r8152 4-1.2:1.0: load rtl8153b-2 v2 04/27/23 successfully
> [  103.056663] OOM killer enabled.
> [  103.056665] Restarting tasks ... 
> [  103.056737] pci_bus 0000:02: Allocating resources
> [  103.056759] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [  103.056769] pcieport 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [  103.056773] pcieport 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [  103.056778] pcieport 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [  103.056781] pcieport 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [  103.058855] pci_bus 0000:02: Allocating resources
> [  103.058875] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
> [  103.058888] pcieport 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [  103.058892] pcieport 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [  103.058897] pcieport 0000:02:02.0: BAR 15: no space for [mem size 0x00200000 64bit pref]
> [  103.058900] pcieport 0000:02:02.0: BAR 15: failed to assign [mem size 0x00200000 64bit pref]
> [  103.059435] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [  103.060638] done.
> [  103.060678] random: crng reseeded on system resumption
> [  103.150372] PM: suspend exit
> [  103.211747] Process accounting resumed


