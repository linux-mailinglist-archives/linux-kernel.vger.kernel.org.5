Return-Path: <linux-kernel+bounces-15450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559B822C21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D6E28279B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5042218E21;
	Wed,  3 Jan 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="2xXAP8zu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783018EB4;
	Wed,  3 Jan 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutanota.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutanota.com
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id DFE451060122;
	Wed,  3 Jan 2024 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704281003;
	s=s1; d=tutanota.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=6Gi+VWIjw/flkzyAjQrYw9YQz740aTDXvQ4K7a7UqdM=;
	b=2xXAP8zusaK5CsTNLgeK1a9NIzk4hCSnyMdrgYqvZF886Ez84aEzGarNFcOzkl15
	VBBFebcL5tpRcXYrwYuMUCbaOvgWJWE8soY891JfZ04W+bNI2MuqFukA7ok4HNddNXZ
	4DhikQfSQzMvC3oArTMP514eqEUuXXQJflz/GqSZZK187EoCP9k7ghZ6Lywm4c3plXY
	wb1fKtiK9np0LnvKXybVlZkNfbaW09myqTiwN5iC1SIIk/luJ3YwkykvwDiRYPGtMQK
	borVcEvHju6A4f3Af8/tDUt0omjvfS1iUcpdLoet0IT5uF8bao8G2hw5JDWfAIhv0oL
	wrA+MQfPEw==
Date: Wed, 3 Jan 2024 12:23:23 +0100 (CET)
From: voreck-lukas@tutanota.com
To: Bagasdotme <bagasdotme@gmail.com>
Cc: Alsa Devel <alsa-devel@alsa-project.org>,
	Andy Chi <andy.chi@canonical.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Faenkhauser <faenkhauser@gmail.com>,
	James Schulman <james.schulman@cirrus.com>,
	Kailang <kailang@realtek.com>, L Guzenko <l.guzenko@web.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>, Luke <luke@ljones.dev>,
	Overloader <overloader@tutanota.com>,
	Patches <patches@opensource.cirrus.com>, Perex <perex@perex.cz>,
	Rf <rf@opensource.cirrus.com>,
	Ruinairas1992 <ruinairas1992@gmail.com>,
	Sbinding <sbinding@opensource.cirrus.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Tanure <tanure@linux.com>,
	Tiwai <tiwai@suse.com>, Tsengalb99 <tsengalb99@gmail.com>,
	Vitalyr <vitalyr@opensource.cirrus.com>,
	Yangyuchi66 <yangyuchi66@gmail.com>
Message-ID: <NnE33wh--3-9@tutanota.com>
Subject: Re: Fwd: No sound drivers on HP Envy x360 ey0xxx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_73476_1350743247.1704281003907"

------=_Part_73476_1350743247.1704281003907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I hope I'm responding correctly

On bugzilla I was asked to attach dmesg and lspci output. I'm sending both as attachments (cause of their length) and hope it works, it's my first time working with these mailing lists.

------=_Part_73476_1350743247.1704281003907
Content-Type: text/plain; charset=us-ascii; name=lspci.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 7
01:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wireless Network Adapter
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5228 (rev 01)
03:00.0 Non-Volatile memory controller: Micron Technology Inc 2450 NVMe SSD [HendrixV] (DRAM-less) (rev 01)
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Barcelo (rev c1)
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
04:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub
05:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)
05:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81)

------=_Part_73476_1350743247.1704281003907
Content-Type: text/plain; charset=UTF-8; name=dmesg.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000] Linux version 6.6.8 (nixbld@localhost) (gcc (GCC) 12.3.0, GN=
U ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Wed Dec 20 16:02:07 =
UTC 2023
[    0.000000] Command line: BOOT_IMAGE=3D(hd0,gpt3)//kernels/z287b4560l2gx=
5zfn2p1zqdra5nzaga8-linux-6.6.8-bzImage init=3D/nix/store/jclp5jk45vc2cv304=
zxmzrkn815cbpqx-nixos-system-lnix-24.05.20231230.b0d36bd/init loglevel=3D4
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009beffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000009bf0000-0x0000000009dfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0f000-0x00000000c5f7efff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000c5f7f000-0x00000000caf7efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000caf7f000-0x00000000cdf7efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000cdf7f000-0x00000000cdffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000cdfff000-0x00000000cdffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe0fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec01fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed81fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000040e2fffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000040e300000-0x000000042fffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0xb24dc018-0xb24e9857] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0xb24dc018-0xb24e9857] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000bff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009beff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009bf0000-0x0000000009dfff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000009e00000-0x0000000009efff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000009f0f000-0x00000000b24dc0=
17] usable
[    0.000000] reserve setup_data: [mem 0x00000000b24dc018-0x00000000b24e98=
57] usable
[    0.000000] reserve setup_data: [mem 0x00000000b24e9858-0x00000000c5f7ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c5f7f000-0x00000000caf7ef=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000caf7f000-0x00000000cdf7ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cdf7f000-0x00000000cdffef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cdfff000-0x00000000cdffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ce000000-0x00000000cfffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fde00000-0x00000000fdefff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe0fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec01f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec20000-0x00000000fec20f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed81f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000040e2fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000040e300000-0x000000042fffff=
ff] reserved
[    0.000000] efi: EFI v2.7 by INSYDE Corp.
[    0.000000] efi: ACPI=3D0xcdffe000 ACPI 2.0=3D0xcdffe014 ESRT=3D0xc98617=
98 TPMFinalLog=3D0xcdf40000 SMBIOS=3D0xc961a000 SMBIOS 3.0=3D0xc9618000 INI=
TRD=3D0xb24eab18 RNG=3D0xcdfdc018 TPMEventLog=3D0xb24ee018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem57: MMIO range=3D[0xf8000000-0xfbffffff] (64M=
B) from e820 map
[    0.000000] e820: remove [mem 0xf8000000-0xfbffffff] reserved
[    0.000000] efi: Remove mem58: MMIO range=3D[0xfde00000-0xfdefffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfde00000-0xfdefffff] reserved
[    0.000000] efi: Remove mem59: MMIO range=3D[0xfe000000-0xfe0fffff] (1MB=
) from e820 map
[    0.000000] e820: remove [mem 0xfe000000-0xfe0fffff] reserved
[    0.000000] efi: Not removing mem60: MMIO range=3D[0xfec00000-0xfec01fff=
] (8KB) from e820 map
[    0.000000] efi: Not removing mem61: MMIO range=3D[0xfec10000-0xfec10fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem62: MMIO range=3D[0xfec20000-0xfec20fff=
] (4KB) from e820 map
[    0.000000] efi: Not removing mem63: MMIO range=3D[0xfed80000-0xfed81fff=
] (8KB) from e820 map
[    0.000000] efi: Not removing mem64: MMIO range=3D[0xfee00000-0xfee00fff=
] (4KB) from e820 map
[    0.000000] efi: Remove mem65: MMIO range=3D[0xff000000-0xffffffff] (16M=
B) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: HP /8A31, BIOS F.09 09/05/2022
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1996.134 MHz processor
[    0.000349] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000351] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000358] last_pfn =3D 0x40e300 max_arch_pfn =3D 0x400000000
[    0.000363] MTRR map: 8 entries (4 fixed + 4 variable; max 21), built fr=
om 9 variable MTRRs
[    0.000365] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000618] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000
[    0.004876] esrt: Reserving ESRT space from 0x00000000c9861798 to 0x0000=
0000c98617d0.
[    0.004886] Using GB pages for direct mapping
[    0.005663] Secure boot disabled
[    0.005664] RAMDISK: [mem 0xb0d2f000-0xb1b1dfff]
[    0.005668] ACPI: Early table checksum verification disabled
[    0.005671] ACPI: RSDP 0x00000000CDFFE014 000024 (v02 HPQOEM)
[    0.005675] ACPI: XSDT 0x00000000CDFA2228 00016C (v01 HPQOEM SLIC-MPC 00=
000002 HP   01000013)
[    0.005680] ACPI: FACP 0x00000000CDFE0000 00010C (v05 HPQOEM SLIC-MPC 00=
000002 HP   00040000)
[    0.005684] ACPI: DSDT 0x00000000CDFD1000 00A7F3 (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005686] ACPI: FACS 0x00000000CDEB3000 000040
[    0.005688] ACPI: UEFI 0x00000000CDF7E000 000236 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005690] ACPI: SSDT 0x00000000CDFFC000 00020D (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005692] ACPI: SSDT 0x00000000CDFF4000 0072B0 (v02 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005694] ACPI: IVRS 0x00000000CDFF3000 0001A4 (v02 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005697] ACPI: SSDT 0x00000000CDFEF000 003A21 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005699] ACPI: SSDT 0x00000000CDFEE000 000472 (v02 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005701] ACPI: TPM2 0x00000000CDFED000 00004C (v04 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005703] ACPI: SSDT 0x00000000CDFEC000 00017D (v01 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005705] ACPI: SSDT 0x00000000CDFE4000 007D81 (v01 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005707] ACPI: ASF! 0x00000000CDFE2000 0000A5 (v32 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005709] ACPI: BOOT 0x00000000CDFE1000 000028 (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005711] ACPI: HPET 0x00000000CDFDF000 000038 (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005713] ACPI: APIC 0x00000000CDFDE000 000138 (v03 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005715] ACPI: MCFG 0x00000000CDFDD000 00003C (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005717] ACPI: SSDT 0x00000000CDFD0000 000145 (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005719] ACPI: SSDT 0x00000000CDFCF000 000080 (v01 HPQOEM 8A31     00=
000002 HP   00040000)
[    0.005721] ACPI: VFCT 0x00000000CDFC1000 00D884 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005723] ACPI: SSDT 0x00000000CDFC0000 0000F8 (v01 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005725] ACPI: SSDT 0x00000000CDFFD000 00005C (v02 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005727] ACPI: SSDT 0x00000000CDFBE000 00005C (v02 HPQOEM 8A31     00=
001000 HP   00040000)
[    0.005729] ACPI: SSDT 0x00000000CDFB8000 005354 (v02 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005731] ACPI: CRAT 0x00000000CDFB7000 000EE8 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005733] ACPI: CDIT 0x00000000CDFB6000 000029 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005735] ACPI: SSDT 0x00000000CDFB5000 000139 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005737] ACPI: SSDT 0x00000000CDFB4000 00028D (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005739] ACPI: SSDT 0x00000000CDFB3000 000372 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005741] ACPI: SSDT 0x00000000CDFB2000 00021F (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005743] ACPI: SSDT 0x00000000CDFB1000 000D53 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005745] ACPI: SSDT 0x00000000CDFAF000 0010C5 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005747] ACPI: SSDT 0x00000000CDFAB000 00362F (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005749] ACPI: FPDT 0x00000000CDFAA000 000044 (v01 HPQOEM SLIC-MPC 00=
000002 HP   00040000)
[    0.005751] ACPI: BGRT 0x00000000CDFA9000 000038 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005753] ACPI: WSMT 0x00000000CDFA8000 000028 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005755] ACPI: SSDT 0x00000000CDFA7000 000042 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005757] ACPI: SSDT 0x00000000CDFA6000 00020A (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005759] ACPI: SSDT 0x00000000CDFA5000 000614 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005761] ACPI: SSDT 0x00000000CDFA4000 00036A (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005763] ACPI: SSDT 0x00000000CDFA3000 00007D (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005766] ACPI: SSDT 0x00000000CDFBF000 0000C7 (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005768] ACPI: SSDT 0x00000000CDFA1000 0004DB (v01 HPQOEM 8A31     00=
000001 HP   00040000)
[    0.005769] ACPI: Reserving FACP table memory at [mem 0xcdfe0000-0xcdfe0=
10b]
[    0.005770] ACPI: Reserving DSDT table memory at [mem 0xcdfd1000-0xcdfdb=
7f2]
[    0.005771] ACPI: Reserving FACS table memory at [mem 0xcdeb3000-0xcdeb3=
03f]
[    0.005772] ACPI: Reserving UEFI table memory at [mem 0xcdf7e000-0xcdf7e=
235]
[    0.005772] ACPI: Reserving SSDT table memory at [mem 0xcdffc000-0xcdffc=
20c]
[    0.005773] ACPI: Reserving SSDT table memory at [mem 0xcdff4000-0xcdffb=
2af]
[    0.005774] ACPI: Reserving IVRS table memory at [mem 0xcdff3000-0xcdff3=
1a3]
[    0.005774] ACPI: Reserving SSDT table memory at [mem 0xcdfef000-0xcdff2=
a20]
[    0.005775] ACPI: Reserving SSDT table memory at [mem 0xcdfee000-0xcdfee=
471]
[    0.005776] ACPI: Reserving TPM2 table memory at [mem 0xcdfed000-0xcdfed=
04b]
[    0.005776] ACPI: Reserving SSDT table memory at [mem 0xcdfec000-0xcdfec=
17c]
[    0.005777] ACPI: Reserving SSDT table memory at [mem 0xcdfe4000-0xcdfeb=
d80]
[    0.005778] ACPI: Reserving ASF! table memory at [mem 0xcdfe2000-0xcdfe2=
0a4]
[    0.005778] ACPI: Reserving BOOT table memory at [mem 0xcdfe1000-0xcdfe1=
027]
[    0.005779] ACPI: Reserving HPET table memory at [mem 0xcdfdf000-0xcdfdf=
037]
[    0.005780] ACPI: Reserving APIC table memory at [mem 0xcdfde000-0xcdfde=
137]
[    0.005780] ACPI: Reserving MCFG table memory at [mem 0xcdfdd000-0xcdfdd=
03b]
[    0.005781] ACPI: Reserving SSDT table memory at [mem 0xcdfd0000-0xcdfd0=
144]
[    0.005782] ACPI: Reserving SSDT table memory at [mem 0xcdfcf000-0xcdfcf=
07f]
[    0.005782] ACPI: Reserving VFCT table memory at [mem 0xcdfc1000-0xcdfce=
883]
[    0.005783] ACPI: Reserving SSDT table memory at [mem 0xcdfc0000-0xcdfc0=
0f7]
[    0.005784] ACPI: Reserving SSDT table memory at [mem 0xcdffd000-0xcdffd=
05b]
[    0.005784] ACPI: Reserving SSDT table memory at [mem 0xcdfbe000-0xcdfbe=
05b]
[    0.005785] ACPI: Reserving SSDT table memory at [mem 0xcdfb8000-0xcdfbd=
353]
[    0.005786] ACPI: Reserving CRAT table memory at [mem 0xcdfb7000-0xcdfb7=
ee7]
[    0.005786] ACPI: Reserving CDIT table memory at [mem 0xcdfb6000-0xcdfb6=
028]
[    0.005787] ACPI: Reserving SSDT table memory at [mem 0xcdfb5000-0xcdfb5=
138]
[    0.005788] ACPI: Reserving SSDT table memory at [mem 0xcdfb4000-0xcdfb4=
28c]
[    0.005788] ACPI: Reserving SSDT table memory at [mem 0xcdfb3000-0xcdfb3=
371]
[    0.005789] ACPI: Reserving SSDT table memory at [mem 0xcdfb2000-0xcdfb2=
21e]
[    0.005790] ACPI: Reserving SSDT table memory at [mem 0xcdfb1000-0xcdfb1=
d52]
[    0.005790] ACPI: Reserving SSDT table memory at [mem 0xcdfaf000-0xcdfb0=
0c4]
[    0.005791] ACPI: Reserving SSDT table memory at [mem 0xcdfab000-0xcdfae=
62e]
[    0.005792] ACPI: Reserving FPDT table memory at [mem 0xcdfaa000-0xcdfaa=
043]
[    0.005792] ACPI: Reserving BGRT table memory at [mem 0xcdfa9000-0xcdfa9=
037]
[    0.005793] ACPI: Reserving WSMT table memory at [mem 0xcdfa8000-0xcdfa8=
027]
[    0.005794] ACPI: Reserving SSDT table memory at [mem 0xcdfa7000-0xcdfa7=
041]
[    0.005795] ACPI: Reserving SSDT table memory at [mem 0xcdfa6000-0xcdfa6=
209]
[    0.005795] ACPI: Reserving SSDT table memory at [mem 0xcdfa5000-0xcdfa5=
613]
[    0.005796] ACPI: Reserving SSDT table memory at [mem 0xcdfa4000-0xcdfa4=
369]
[    0.005797] ACPI: Reserving SSDT table memory at [mem 0xcdfa3000-0xcdfa3=
07c]
[    0.005797] ACPI: Reserving SSDT table memory at [mem 0xcdfbf000-0xcdfbf=
0c6]
[    0.005798] ACPI: Reserving SSDT table memory at [mem 0xcdfa1000-0xcdfa1=
4da]
[    0.005854] No NUMA configuration found
[    0.005855] Faking a node at [mem 0x0000000000000000-0x000000040e2fffff]
[    0.005858] NODE_DATA(0) allocated [mem 0x40e2fa000-0x40e2fffff]
[    0.005884] Zone ranges:
[    0.005884]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005886]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005887]   Normal   [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005888]   Device   empty
[    0.005889] Movable zone start for each node
[    0.005890] Early memory node ranges
[    0.005890]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005891]   node   0: [mem 0x0000000000100000-0x0000000009beffff]
[    0.005892]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]
[    0.005893]   node   0: [mem 0x0000000009f0f000-0x00000000c5f7efff]
[    0.005894]   node   0: [mem 0x00000000cdfff000-0x00000000cdffffff]
[    0.005895]   node   0: [mem 0x0000000100000000-0x000000040e2fffff]
[    0.005897] Initmem setup node 0 [mem 0x0000000000001000-0x000000040e2ff=
fff]
[    0.005900] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005913] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.006018] On node 0, zone DMA32: 528 pages in unavailable ranges
[    0.009508] On node 0, zone DMA32: 15 pages in unavailable ranges
[    0.009771] On node 0, zone DMA32: 32896 pages in unavailable ranges
[    0.026511] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.026582] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.026786] ACPI: PM-Timer IO Port: 0x408
[    0.026794] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.026796] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.026796] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.026797] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.026798] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.026799] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.026799] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.026800] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.026801] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.026802] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.026802] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.026803] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.026804] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.026805] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.026805] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.026806] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.026819] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0=
-23
[    0.026825] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 2=
4-55
[    0.026827] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026829] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.026833] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.026834] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.026842] e820: update [mem 0xb2548000-0xb2560fff] usable =3D=3D> rese=
rved
[    0.026856] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.026881] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.026883] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000bffff]
[    0.026884] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0=
x000fffff]
[    0.026886] PM: hibernation: Registered nosave memory: [mem 0x09bf0000-0=
x09dfffff]
[    0.026888] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0efff]
[    0.026889] PM: hibernation: Registered nosave memory: [mem 0xb24dc000-0=
xb24dcfff]
[    0.026891] PM: hibernation: Registered nosave memory: [mem 0xb24e9000-0=
xb24e9fff]
[    0.026893] PM: hibernation: Registered nosave memory: [mem 0xb2548000-0=
xb2560fff]
[    0.026895] PM: hibernation: Registered nosave memory: [mem 0xc5f7f000-0=
xcaf7efff]
[    0.026895] PM: hibernation: Registered nosave memory: [mem 0xcaf7f000-0=
xcdf7efff]
[    0.026896] PM: hibernation: Registered nosave memory: [mem 0xcdf7f000-0=
xcdffefff]
[    0.026898] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xcfffffff]
[    0.026899] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xfebfffff]
[    0.026899] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec01fff]
[    0.026900] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0=
xfec0ffff]
[    0.026901] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0=
xfec10fff]
[    0.026901] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0=
xfec1ffff]
[    0.026902] PM: hibernation: Registered nosave memory: [mem 0xfec20000-0=
xfec20fff]
[    0.026903] PM: hibernation: Registered nosave memory: [mem 0xfec21000-0=
xfed7ffff]
[    0.026903] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfed81fff]
[    0.026904] PM: hibernation: Registered nosave memory: [mem 0xfed82000-0=
xfedfffff]
[    0.026905] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.026906] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.026907] [mem 0xd0000000-0xfebfffff] available for PCI devices
[    0.026909] Booting paravirtualized kernel on bare hardware
[    0.026911] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.031848] setup_percpu: NR_CPUS:384 nr_cpumask_bits:16 nr_cpu_ids:16 n=
r_node_ids:1
[    0.032726] percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u524288
[    0.032735] pcpu-alloc: s221184 r8192 d114688 u524288 alloc=3D1*2097152
[    0.032737] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.032743] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.032769] Kernel command line: BOOT_IMAGE=3D(hd0,gpt3)//kernels/z287b4=
560l2gx5zfn2p1zqdra5nzaga8-linux-6.6.8-bzImage init=3D/nix/store/jclp5jk45v=
c2cv304zxmzrkn815cbpqx-nixos-system-lnix-24.05.20231230.b0d36bd/init loglev=
el=3D4
[    0.032816] Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,gp=
t3)//kernels/z287b4560l2gx5zfn2p1zqdra5nzaga8-linux-6.6.8-bzImage", will be=
 passed to user space.
[    0.034128] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.034794] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.034855] Fallback order for Node 0: 0
[    0.034860] Built 1 zonelists, mobility grouping on.  Total pages: 39511=
99
[    0.034861] Policy zone: Normal
[    0.034863] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.034907] software IO TLB: area num 16.
[    0.071545] Memory: 15552652K/16056316K available (14336K kernel code, 2=
310K rwdata, 9252K rodata, 2956K init, 2996K bss, 503408K reserved, 0K cma-=
reserved)
[    0.072930] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.072964] ftrace: allocating 39696 entries in 156 pages
[    0.085351] ftrace: allocated 156 pages with 4 groups
[    0.086324] Dynamic Preempt: voluntary
[    0.086423] rcu: Preemptible hierarchical RCU implementation.
[    0.086424] rcu: =09RCU event tracing is enabled.
[    0.086425] rcu: =09RCU restricting CPUs from NR_CPUS=3D384 to nr_cpu_id=
s=3D16.
[    0.086427] =09Trampoline variant of Tasks RCU enabled.
[    0.086427] =09Rude variant of Tasks RCU enabled.
[    0.086428] =09Tracing variant of Tasks RCU enabled.
[    0.086429] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.086430] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.090776] NR_IRQS: 24832, nr_irqs: 1096, preallocated irqs: 16
[    0.091022] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.091121] Console: colour dummy device 80x25
[    0.091124] printk: console [tty0] enabled
[    0.091207] ACPI: Core revision 20230628
[    0.091758] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.091779] APIC: Switch to symmetric I/O mode setup
[    0.093527] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[    0.093530] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[    0.093532] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[    0.093534] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[    0.093536] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
[    0.093946] APIC: Switched APIC routing to: physical flat
[    0.094765] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.099787] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x398bd529e78, max_idle_ns: 881590816213 ns
[    0.099796] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3992.26 BogoMIPS (lpj=3D1996134)
[    0.099825] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.099876] LVT offset 1 assigned for vector 0xf9
[    0.100029] LVT offset 2 assigned for vector 0xf4
[    0.100068] process: using mwait in idle threads
[    0.100071] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.100073] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.100078] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.100082] Spectre V2 : Mitigation: Retpolines
[    0.100084] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.100085] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.100086] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.100089] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.100090] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.100093] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.100095] Speculative Return Stack Overflow: IBPB-extending microcode =
not applied!
[    0.100096] Speculative Return Stack Overflow: WARNING: See https://kern=
el.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options=
.
[    0.100097] Speculative Return Stack Overflow: Vulnerable: Safe RET, no =
microcode
[    0.100105] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.100107] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.100109] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.100110] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.100112] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.100114] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.100116] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.100118] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.100120] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.137593] Freeing SMP alternatives memory: 36K
[    0.137599] pid_max: default: 32768 minimum: 301
[    0.144913] LSM: initializing lsm=3Dcapability,landlock,yama,selinux,bpf=
,integrity
[    0.144969] landlock: Up and running.
[    0.144971] Yama: becoming mindful.
[    0.144978] SELinux:  Initializing.
[    0.145034] LSM support for eBPF active
[    0.145845] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.145873] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.249569] smpboot: CPU0: AMD Ryzen 7 5825U with Radeon Graphics (famil=
y: 0x19, model: 0x50, stepping: 0x0)
[    0.250150] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.250264] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.250388] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.250513] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.250554] ... version:                0
[    0.250563] ... bit width:              48
[    0.250571] ... generic registers:      6
[    0.250579] ... value mask:             0000ffffffffffff
[    0.250589] ... max period:             00007fffffffffff
[    0.250598] ... fixed-purpose events:   0
[    0.250605] ... event mask:             000000000000003f
[    0.251339] signal: max sigframe size: 3376
[    0.251577] rcu: Hierarchical SRCU implementation.
[    0.251586] rcu: =09Max phase no-delay instances is 400.
[    0.272986] smp: Bringing up secondary CPUs ...
[    0.273870] smpboot: x86: Booting SMP configuration:
[    0.273882] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1  =
#3  #5  #7  #9 #11 #13 #15
[    0.302809] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.313946] smp: Brought up 1 node, 16 CPUs
[    0.313946] smpboot: Max logical packages: 1
[    0.313946] smpboot: Total of 16 processors activated (63876.28 BogoMIPS=
)
[    0.320017] devtmpfs: initialized
[    0.321018] x86/mm: Memory block size: 128MB
[    0.339426] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
efff] (61440 bytes)
[    0.339426] ACPI: PM: Registering ACPI NVS region [mem 0xcaf7f000-0xcdf7=
efff] (50331648 bytes)
[    0.350861] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.350892] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.351394] pinctrl core: initialized pinctrl subsystem
[    0.354506] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.355810] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.355846] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.355870] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.355968] audit: initializing netlink subsys (disabled)
[    0.356025] audit: type=3D2000 audit(1704279394.263:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.357189] thermal_sys: Registered thermal governor 'bang_bang'
[    0.357203] thermal_sys: Registered thermal governor 'step_wise'
[    0.357214] thermal_sys: Registered thermal governor 'user_space'
[    0.357302] cpuidle: using governor menu
[    0.358036] Simple Boot Flag at 0x44 set to 0x1
[    0.358254] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.358264] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.359243] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.359283] PCI: not using MMCONFIG
[    0.359292] PCI: Using configuration type 1 for base access
[    0.359301] PCI: Using configuration type 1 for extended access
[    0.365698] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.366872] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s
[    0.366888] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.366901] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.366909] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.370015] ACPI: Added _OSI(Module Device)
[    0.370031] ACPI: Added _OSI(Processor Device)
[    0.370042] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.370053] ACPI: Added _OSI(Processor Aggregator Device)
[    0.570521] ACPI: 26 ACPI AML tables successfully acquired and loaded
[    0.595636] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.616203] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.620602] ACPI: EC: EC started
[    0.620613] ACPI: EC: interrupt blocked
[    0.623690] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.623710] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions
[    0.623726] ACPI: Interpreter enabled
[    0.623898] ACPI: PM: (supports S0 S4 S5)
[    0.623910] ACPI: Using IOAPIC for interrupt routing
[    0.625297] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.644691] [Firmware Info]: PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff=
] not reserved in ACPI motherboard resources
[    0.644714] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved as Efi=
MemoryMappedIO
[    0.644798] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.644810] PCI: Using E820 reservations for host bridge windows
[    0.648091] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.663643] ACPI: \_SB_.PCI0.GPP3.PCRD.P0U1: New power resource
[    0.664201] ACPI: \_SB_.PCI0.GPP3.PCRD.P3U1: New power resource
[    0.672195] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.673144] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resource
[    0.680114] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.681067] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resource
[    0.747435] ACPI: \_SB_.PRWL: New power resource
[    0.747479] ACPI: \_SB_.PRWB: New power resource
[    0.749115] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.749122] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.749238] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.749442] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    0.749444] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.749459] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-3f] only partially covers this bridge
[    0.749964] PCI host bridge to bus 0000:00
[    0.749967] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.749970] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.749972] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.749975] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cfff=
f window]
[    0.749978] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000efff=
f window]
[    0.749980] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]
[    0.749982] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeaffff=
f window]
[    0.749984] pci_bus 0000:00: root bus resource [mem 0xfed45000-0xfed811f=
f window]
[    0.749986] pci_bus 0000:00: root bus resource [mem 0xfed81900-0xfed81ff=
f window]
[    0.749988] pci_bus 0000:00: root bus resource [mem 0xfedc0000-0xfedc0ff=
f window]
[    0.749990] pci_bus 0000:00: root bus resource [mem 0xfedc6000-0xfedc6ff=
f window]
[    0.749992] pci_bus 0000:00: root bus resource [mem 0x450200000-0xfcffff=
ffff window]
[    0.749994] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.750014] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[    0.750116] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[    0.750227] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[    0.750351] pci 0000:00:01.3: [1022:1634] type 01 class 0x060400
[    0.750414] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.750543] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[    0.750653] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[    0.750718] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.750849] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400
[    0.750911] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.751041] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[    0.751149] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[    0.751174] pci 0000:00:08.1: enabling Extended Tags
[    0.751211] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.751388] pci 0000:00:08.2: [1022:1635] type 01 class 0x060400
[    0.751413] pci 0000:00:08.2: enabling Extended Tags
[    0.751449] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.751598] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.751758] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.751942] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000
[    0.752034] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000
[    0.752122] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000
[    0.752208] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000
[    0.752297] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000
[    0.752384] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000
[    0.752475] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000
[    0.752562] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000
[    0.752717] pci 0000:01:00.0: [14c3:7961] type 00 class 0x028000
[    0.752739] pci 0000:01:00.0: reg 0x10: [mem 0xfcf0200000-0xfcf02fffff 6=
4bit pref]
[    0.752754] pci 0000:01:00.0: reg 0x18: [mem 0xfcf0300000-0xfcf0303fff 6=
4bit pref]
[    0.752767] pci 0000:01:00.0: reg 0x20: [mem 0xfcf0304000-0xfcf0304fff 6=
4bit pref]
[    0.752856] pci 0000:01:00.0: supports D1 D2
[    0.752858] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.753172] pci 0000:00:01.3: PCI bridge to [bus 01]
[    0.753181] pci 0000:00:01.3:   bridge window [mem 0xfcf0200000-0xfcf03f=
ffff 64bit pref]
[    0.753255] pci 0000:02:00.0: [10ec:5228] type 00 class 0xff0000
[    0.753271] pci 0000:02:00.0: reg 0x10: [mem 0xd0700000-0xd0700fff]
[    0.753383] pci 0000:02:00.0: supports D1 D2
[    0.753385] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.753574] pci 0000:00:02.1: PCI bridge to [bus 02]
[    0.753580] pci 0000:00:02.1:   bridge window [mem 0xd0700000-0xd07fffff=
]
[    0.753657] pci 0000:03:00.0: [1344:5411] type 00 class 0x010802
[    0.753688] pci 0000:03:00.0: reg 0x10: [mem 0xd0600000-0xd0603fff 64bit=
]
[    0.753973] pci 0000:03:00.0: 31.504 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.012 Gb/s with 1=
6.0 GT/s PCIe x4 link)
[    0.754180] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.754186] pci 0000:00:02.3:   bridge window [mem 0xd0600000-0xd06fffff=
]
[    0.754270] pci 0000:04:00.0: [1002:15e7] type 00 class 0x030000
[    0.754283] pci 0000:04:00.0: reg 0x10: [mem 0xfce0000000-0xfcefffffff 6=
4bit pref]
[    0.754293] pci 0000:04:00.0: reg 0x18: [mem 0xfcf0000000-0xfcf01fffff 6=
4bit pref]
[    0.754299] pci 0000:04:00.0: reg 0x20: [io  0x1000-0x10ff]
[    0.754306] pci 0000:04:00.0: reg 0x24: [mem 0xd0500000-0xd057ffff]
[    0.754316] pci 0000:04:00.0: enabling Extended Tags
[    0.754331] pci 0000:04:00.0: BAR 0: assigned to efifb
[    0.754375] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.754404] pci 0000:04:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.754527] pci 0000:04:00.1: [1002:1637] type 00 class 0x040300
[    0.754536] pci 0000:04:00.1: reg 0x10: [mem 0xd05c8000-0xd05cbfff]
[    0.754561] pci 0000:04:00.1: enabling Extended Tags
[    0.754597] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.754705] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000
[    0.754721] pci 0000:04:00.2: reg 0x18: [mem 0xd0400000-0xd04fffff]
[    0.754732] pci 0000:04:00.2: reg 0x24: [mem 0xd05ce000-0xd05cffff]
[    0.754742] pci 0000:04:00.2: enabling Extended Tags
[    0.754882] pci 0000:04:00.3: [1022:1639] type 00 class 0x0c0330
[    0.754895] pci 0000:04:00.3: reg 0x10: [mem 0xd0100000-0xd01fffff 64bit=
]
[    0.754922] pci 0000:04:00.3: enabling Extended Tags
[    0.754960] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
[    0.755078] pci 0000:04:00.4: [1022:1639] type 00 class 0x0c0330
[    0.755091] pci 0000:04:00.4: reg 0x10: [mem 0xd0200000-0xd02fffff 64bit=
]
[    0.755118] pci 0000:04:00.4: enabling Extended Tags
[    0.755156] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
[    0.755274] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000
[    0.755283] pci 0000:04:00.5: reg 0x10: [mem 0xd0580000-0xd05bffff]
[    0.755307] pci 0000:04:00.5: enabling Extended Tags
[    0.755342] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
[    0.755449] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300
[    0.755458] pci 0000:04:00.6: reg 0x10: [mem 0xd05c0000-0xd05c7fff]
[    0.755482] pci 0000:04:00.6: enabling Extended Tags
[    0.755517] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
[    0.755622] pci 0000:04:00.7: [1022:15e4] type 00 class 0x118000
[    0.755638] pci 0000:04:00.7: reg 0x18: [mem 0xd0300000-0xd03fffff]
[    0.755649] pci 0000:04:00.7: reg 0x24: [mem 0xd05cc000-0xd05cdfff]
[    0.755658] pci 0000:04:00.7: enabling Extended Tags
[    0.755829] pci 0000:00:08.1: PCI bridge to [bus 04]
[    0.755833] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.755836] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd05fffff=
]
[    0.755840] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    0.755899] pci 0000:05:00.0: [1022:7901] type 00 class 0x010601
[    0.755931] pci 0000:05:00.0: reg 0x24: [mem 0xd0001000-0xd00017ff]
[    0.755941] pci 0000:05:00.0: enabling Extended Tags
[    0.756011] pci 0000:05:00.0: 126.016 Gb/s available PCIe bandwidth, lim=
ited by 8.0 GT/s PCIe x16 link at 0000:00:08.2 (capable of 252.048 Gb/s wit=
h 16.0 GT/s PCIe x16 link)
[    0.756115] pci 0000:05:00.1: [1022:7901] type 00 class 0x010601
[    0.756147] pci 0000:05:00.1: reg 0x24: [mem 0xd0000000-0xd00007ff]
[    0.756158] pci 0000:05:00.1: enabling Extended Tags
[    0.756302] pci 0000:00:08.2: PCI bridge to [bus 05]
[    0.756308] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff=
]
[    0.803241] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.803244] ACPI: PCI: Interrupt link LNKA disabled
[    0.803348] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.803350] ACPI: PCI: Interrupt link LNKB disabled
[    0.803431] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.803432] ACPI: PCI: Interrupt link LNKC disabled
[    0.803535] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.803536] ACPI: PCI: Interrupt link LNKD disabled
[    0.803631] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.803633] ACPI: PCI: Interrupt link LNKE disabled
[    0.803708] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.803710] ACPI: PCI: Interrupt link LNKF disabled
[    0.803787] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.803793] ACPI: PCI: Interrupt link LNKG disabled
[    0.803868] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.803870] ACPI: PCI: Interrupt link LNKH disabled
[    0.805302] Low-power S0 idle used by default for system suspend
[    0.806420] ACPI: EC: interrupt unblocked
[    0.806422] ACPI: EC: event unblocked
[    0.806428] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.806430] ACPI: EC: GPE=3D0x3
[    0.806432] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete
[    0.806434] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events
[    0.806493] iommu: Default domain type: Translated
[    0.806495] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.951911] efivars: Registered efivars operations
[    0.952057] NetLabel: Initializing
[    0.952058] NetLabel:  domain hash size =3D 128
[    0.952059] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.952080] NetLabel:  unlabeled traffic allowed by default
[    0.952082] PCI: Using ACPI for IRQ routing
[    0.954410] PCI: pci_cache_line_size set to 64 bytes
[    0.954458] resource: Expanded resource Reserved due to conflict with PC=
I Bus 0000:00
[    0.954460] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.954462] e820: reserve RAM buffer [mem 0x09bf0000-0x0bffffff]
[    0.954464] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.954465] e820: reserve RAM buffer [mem 0xb24dc018-0xb3ffffff]
[    0.954466] e820: reserve RAM buffer [mem 0xb2548000-0xb3ffffff]
[    0.954467] e820: reserve RAM buffer [mem 0xc5f7f000-0xc7ffffff]
[    0.954469] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.954470] e820: reserve RAM buffer [mem 0x40e300000-0x40fffffff]
[    0.954535] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.954535] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.954535] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.954535] vgaarb: loaded
[    0.954535] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.954535] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.955839] clocksource: Switched to clocksource tsc-early
[    0.955920] VFS: Disk quotas dquot_6.6.0
[    0.955936] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.956017] pnp: PnP ACPI init
[    0.956179] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved
[    0.956183] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.956185] system 00:00: [mem 0xfde00000-0xfdefffff] has been reserved
[    0.956432] system 00:02: [io  0x0400-0x04cf] has been reserved
[    0.956434] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.956436] system 00:02: [io  0x04d6] has been reserved
[    0.956438] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.956440] system 00:02: [io  0x0c14] has been reserved
[    0.956441] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.956443] system 00:02: [io  0x0c6c] has been reserved
[    0.956445] system 00:02: [io  0x0c6f] has been reserved
[    0.956447] system 00:02: [io  0x0cd0-0x0cdb] has been reserved
[    0.956519] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    1.003170] pnp: PnP ACPI: found 4 devices
[    1.009508] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.009647] NET: Registered PF_INET protocol family
[    1.009822] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    1.012123] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    1.012134] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    1.012139] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    1.012229] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    1.012364] TCP: Hash tables configured (established 131072 bind 65536)
[    1.012468] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    1.012487] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear=
)
[    1.012524] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    1.012603] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.012613] NET: Registered PF_XDP protocol family
[    1.012617] pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [bus =
02] add_size 1000
[    1.012621] pci 0000:00:02.1: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 02] add_size 200000 add_align 100000
[    1.012624] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus =
03] add_size 1000
[    1.012626] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 03] add_size 200000 add_align 100000
[    1.012635] pci 0000:00:02.1: BAR 15: assigned [mem 0x450200000-0x4503ff=
fff 64bit pref]
[    1.012638] pci 0000:00:02.3: BAR 15: assigned [mem 0x450400000-0x4505ff=
fff 64bit pref]
[    1.012641] pci 0000:00:02.1: BAR 13: assigned [io  0x2000-0x2fff]
[    1.012643] pci 0000:00:02.3: BAR 13: assigned [io  0x3000-0x3fff]
[    1.012646] pci 0000:00:01.3: PCI bridge to [bus 01]
[    1.012650] pci 0000:00:01.3:   bridge window [mem 0xfcf0200000-0xfcf03f=
ffff 64bit pref]
[    1.012654] pci 0000:00:02.1: PCI bridge to [bus 02]
[    1.012656] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    1.012659] pci 0000:00:02.1:   bridge window [mem 0xd0700000-0xd07fffff=
]
[    1.012662] pci 0000:00:02.1:   bridge window [mem 0x450200000-0x4503fff=
ff 64bit pref]
[    1.012665] pci 0000:00:02.3: PCI bridge to [bus 03]
[    1.012667] pci 0000:00:02.3:   bridge window [io  0x3000-0x3fff]
[    1.012670] pci 0000:00:02.3:   bridge window [mem 0xd0600000-0xd06fffff=
]
[    1.012673] pci 0000:00:02.3:   bridge window [mem 0x450400000-0x4505fff=
ff 64bit pref]
[    1.012677] pci 0000:00:08.1: PCI bridge to [bus 04]
[    1.012679] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    1.012682] pci 0000:00:08.1:   bridge window [mem 0xd0100000-0xd05fffff=
]
[    1.012684] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]
[    1.012688] pci 0000:00:08.2: PCI bridge to [bus 05]
[    1.012690] pci 0000:00:08.2:   bridge window [mem 0xd0000000-0xd00fffff=
]
[    1.012695] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.012697] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.012699] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    1.012701] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000cffff windo=
w]
[    1.012702] pci_bus 0000:00: resource 8 [mem 0x000d0000-0x000effff windo=
w]
[    1.012703] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xf7ffffff windo=
w]
[    1.012705] pci_bus 0000:00: resource 10 [mem 0xfc000000-0xfeafffff wind=
ow]
[    1.012707] pci_bus 0000:00: resource 11 [mem 0xfed45000-0xfed811ff wind=
ow]
[    1.012708] pci_bus 0000:00: resource 12 [mem 0xfed81900-0xfed81fff wind=
ow]
[    1.012710] pci_bus 0000:00: resource 13 [mem 0xfedc0000-0xfedc0fff wind=
ow]
[    1.012711] pci_bus 0000:00: resource 14 [mem 0xfedc6000-0xfedc6fff wind=
ow]
[    1.012713] pci_bus 0000:00: resource 15 [mem 0x450200000-0xfcffffffff w=
indow]
[    1.012714] pci_bus 0000:01: resource 2 [mem 0xfcf0200000-0xfcf03fffff 6=
4bit pref]
[    1.012716] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.012717] pci_bus 0000:02: resource 1 [mem 0xd0700000-0xd07fffff]
[    1.012719] pci_bus 0000:02: resource 2 [mem 0x450200000-0x4503fffff 64b=
it pref]
[    1.012721] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    1.012722] pci_bus 0000:03: resource 1 [mem 0xd0600000-0xd06fffff]
[    1.012723] pci_bus 0000:03: resource 2 [mem 0x450400000-0x4505fffff 64b=
it pref]
[    1.012725] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    1.012726] pci_bus 0000:04: resource 1 [mem 0xd0100000-0xd05fffff]
[    1.012728] pci_bus 0000:04: resource 2 [mem 0xfce0000000-0xfcf01fffff 6=
4bit pref]
[    1.012730] pci_bus 0000:05: resource 1 [mem 0xd0000000-0xd00fffff]
[    1.012842] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    1.012849] pci 0000:04:00.3: extending delay after power-on from D3hot =
to 20 msec
[    1.014178] pci 0000:04:00.4: extending delay after power-on from D3hot =
to 20 msec
[    1.025382] pci 0000:04:00.4: quirk_usb_early_handoff+0x0/0x7d0 took 109=
38 usecs
[    1.025395] PCI: CLS 64 bytes, default 64
[    1.025408] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    1.025453] Trying to unpack rootfs image as initramfs...
[    1.025473] pci 0000:00:01.0: Adding to iommu group 0
[    1.025491] pci 0000:00:01.3: Adding to iommu group 1
[    1.025517] pci 0000:00:02.0: Adding to iommu group 2
[    1.025533] pci 0000:00:02.1: Adding to iommu group 3
[    1.025549] pci 0000:00:02.3: Adding to iommu group 4
[    1.025574] pci 0000:00:08.0: Adding to iommu group 5
[    1.025590] pci 0000:00:08.1: Adding to iommu group 6
[    1.025606] pci 0000:00:08.2: Adding to iommu group 7
[    1.025634] pci 0000:00:14.0: Adding to iommu group 8
[    1.025648] pci 0000:00:14.3: Adding to iommu group 8
[    1.025718] pci 0000:00:18.0: Adding to iommu group 9
[    1.025733] pci 0000:00:18.1: Adding to iommu group 9
[    1.025748] pci 0000:00:18.2: Adding to iommu group 9
[    1.025763] pci 0000:00:18.3: Adding to iommu group 9
[    1.025778] pci 0000:00:18.4: Adding to iommu group 9
[    1.025793] pci 0000:00:18.5: Adding to iommu group 9
[    1.025808] pci 0000:00:18.6: Adding to iommu group 9
[    1.025824] pci 0000:00:18.7: Adding to iommu group 9
[    1.025841] pci 0000:01:00.0: Adding to iommu group 10
[    1.025858] pci 0000:02:00.0: Adding to iommu group 11
[    1.025874] pci 0000:03:00.0: Adding to iommu group 12
[    1.025903] pci 0000:04:00.0: Adding to iommu group 13
[    1.025920] pci 0000:04:00.1: Adding to iommu group 14
[    1.025937] pci 0000:04:00.2: Adding to iommu group 15
[    1.025955] pci 0000:04:00.3: Adding to iommu group 16
[    1.025973] pci 0000:04:00.4: Adding to iommu group 17
[    1.025991] pci 0000:04:00.5: Adding to iommu group 18
[    1.026008] pci 0000:04:00.6: Adding to iommu group 19
[    1.026025] pci 0000:04:00.7: Adding to iommu group 20
[    1.026043] pci 0000:05:00.0: Adding to iommu group 21
[    1.026061] pci 0000:05:00.1: Adding to iommu group 22
[    1.028078] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.028080] pci 0000:00:00.2: PCI INT A: not connected
[    1.028279] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    1.028281] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2A=
PIC NX GT IA GA PC GA_vAPIC
[    1.028289] AMD-Vi: Interrupt remapping enabled
[    1.028290] AMD-Vi: X2APIC enabled
[    1.039375] AMD-Vi: Virtual APIC enabled
[    1.039385] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.039387] software IO TLB: mapped [mem 0x00000000c1558000-0x00000000c5=
558000] (64MB)
[    1.039414] LVT offset 0 assigned for vector 0x400
[    1.041355] perf: AMD IBS detected (0x000003ff)
[    1.041363] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    1.041413] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    1.042137] Initialise system trusted keyrings
[    1.042177] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    1.042189] zbud: loaded
[    1.042532] Key type asymmetric registered
[    1.042534] Asymmetric key parser 'x509' registered
[    1.042548] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    1.042590] io scheduler mq-deadline registered
[    1.042592] io scheduler kyber registered
[    1.045973] pcieport 0000:00:01.3: PME: Signaling with IRQ 37
[    1.046096] pcieport 0000:00:02.1: PME: Signaling with IRQ 38
[    1.046119] pcieport 0000:00:02.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.046282] pcieport 0000:00:02.3: PME: Signaling with IRQ 39
[    1.046314] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.046469] pcieport 0000:00:08.1: PME: Signaling with IRQ 40
[    1.046666] pcieport 0000:00:08.2: PME: Signaling with IRQ 41
[    1.046781] efifb: probing for efifb
[    1.046797] efifb: showing boot graphics
[    1.048259] efifb: framebuffer at 0xfce0000000, using 8100k, total 8100k
[    1.048261] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D1
[    1.048263] efifb: scrolling: redraw
[    1.048263] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.048310] fbcon: Deferring console take-over
[    1.048311] fb0: EFI VGA frame buffer device
[    1.048392] Estimated ratio of average max frequency by base frequency (=
times 1024): 1676
[    1.048408] Monitor-Mwait will be used to enter C-1 state
[    1.048414] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    1.048546] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    1.048663] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    1.048812] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    1.048925] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    1.049117] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    1.049259] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    1.049406] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    1.049557] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    1.049695] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    1.049837] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    1.049980] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    1.050120] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[    1.050260] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[    1.050390] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[    1.050524] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[    1.050761] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.053669] drop_monitor: Initializing network drop monitor service
[    1.062084] NET: Registered PF_INET6 protocol family
[    1.082909] Freeing initrd memory: 14268K
[    1.083307] Segment Routing with IPv6
[    1.083317] In-situ OAM (IOAM) with IPv6
[    1.084866] microcode: CPU0: patch_level=3D0x0a50000d
[    1.084865] microcode: CPU1: patch_level=3D0x0a50000d
[    1.084868] microcode: CPU3: patch_level=3D0x0a50000d
[    1.084869] microcode: CPU5: patch_level=3D0x0a50000d
[    1.084869] microcode: CPU4: patch_level=3D0x0a50000d
[    1.084872] microcode: CPU6: patch_level=3D0x0a50000d
[    1.084872] microcode: CPU7: patch_level=3D0x0a50000d
[    1.084873] microcode: CPU8: patch_level=3D0x0a50000d
[    1.084874] microcode: CPU9: patch_level=3D0x0a50000d
[    1.084876] microcode: CPU11: patch_level=3D0x0a50000d
[    1.084876] microcode: CPU10: patch_level=3D0x0a50000d
[    1.084877] microcode: CPU2: patch_level=3D0x0a50000d
[    1.084878] microcode: CPU13: patch_level=3D0x0a50000d
[    1.084878] microcode: CPU12: patch_level=3D0x0a50000d
[    1.084879] microcode: CPU14: patch_level=3D0x0a50000d
[    1.084880] microcode: CPU15: patch_level=3D0x0a50000d
[    1.084899] microcode: Microcode Update Driver: v2.2.
[    1.084904] IPI shorthand broadcast: enabled
[    1.086763] sched_clock: Marking stable (1084152728, 1741277)->(11335424=
97, -47648492)
[    1.086905] registered taskstats version 1
[    1.087034] Loading compiled-in X.509 certificates
[    1.091846] Key type .fscrypt registered
[    1.091847] Key type fscrypt-provisioning registered
[    1.092807] clk: Disabling unused clocks
[    1.093729] Freeing unused decrypted memory: 2028K
[    1.094258] Freeing unused kernel image (initmem) memory: 2956K
[    1.100956] Write protecting the kernel read-only data: 24576k
[    1.101447] Freeing unused kernel image (rodata/data gap) memory: 988K
[    1.145546] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.145553] Run /init as init process
[    1.145555]   with arguments:
[    1.145556]     /init
[    1.145557]   with environment:
[    1.145558]     HOME=3D/
[    1.145559]     TERM=3Dlinux
[    1.145560]     BOOT_IMAGE=3D(hd0,gpt3)//kernels/z287b4560l2gx5zfn2p1zqd=
ra5nzaga8-linux-6.6.8-bzImage
[    1.148021] fbcon: Taking over console
[    1.148165] Console: switching to colour frame buffer device 240x67
[    1.172682] stage-1-init: [Wed Jan  3 10:56:35 UTC 2024] loading module =
btrfs...
[    1.193742] raid6: avx2x4   gen() 43258 MB/s
[    1.210743] raid6: avx2x2   gen() 35821 MB/s
[    1.227742] raid6: avx2x1   gen() 33716 MB/s
[    1.227743] raid6: using algorithm avx2x4 gen() 43258 MB/s
[    1.244743] raid6: .... xor() 6071 MB/s, rmw enabled
[    1.244744] raid6: using avx2x2 recovery algorithm
[    1.245334] xor: automatically using best checksumming function   avx
[    1.348453] Btrfs loaded, zoned=3Dno, fsverity=3Dno
[    1.350539] stage-1-init: [Wed Jan  3 10:56:35 UTC 2024] loading module =
dm_mod...
[    1.359666] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@redhat.com
[    1.360529] stage-1-init: [Wed Jan  3 10:56:35 UTC 2024] running udev...
[    1.368533] stage-1-init: [Wed Jan  3 10:56:35 UTC 2024] Starting system=
d-udevd version 254.6
[    1.440702] i8042: PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq =
1
[    1.440707] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    1.441190] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.441820] rtc_cmos rtc_cmos: RTC can wake from S4
[    1.442198] rtc_cmos rtc_cmos: registered as rtc0
[    1.442247] rtc_cmos rtc_cmos: alarms up to one month, 114 bytes nvram, =
hpet irqs
[    1.442738] cryptd: max_cpu_qlen set to 1000
[    1.445694] rtsx_pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.450991] AVX2 version of gcm_enc/dec engaged.
[    1.451051] AES CTR mode by8 optimization enabled
[    1.457775] SCSI subsystem initialized
[    1.463369] ACPI: bus type USB registered
[    1.463416] usbcore: registered new interface driver usbfs
[    1.463430] usbcore: registered new interface driver hub
[    1.463449] usbcore: registered new device driver usb
[    1.466450] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    1.466567] nvme nvme0: pci function 0000:03:00.0
[    1.476623] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0
[    1.478279] libata version 3.00 loaded.
[    1.485437] nvme nvme0: missing or invalid SUBNQN field.
[    1.533909] nvme nvme0: allocated 64 MiB host memory buffer.
[    1.567521] nvme nvme0: 8/0/0 default/read/poll queues
[    1.570912]  nvme0n1: p1 p2 p3
[    1.575025] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.575033] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 1
[    1.575153] xhci_hcd 0000:04:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410
[    1.575220] ahci 0000:05:00.0: version 3.0
[    1.575386] ahci 0000:05:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode
[    1.575390] ahci 0000:05:00.0: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part
[    1.575638] scsi host0: ahci
[    1.575734] xhci_hcd 0000:04:00.3: xHCI Host Controller
[    1.575738] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus =
number 2
[    1.575740] ata1: SATA max UDMA/133 abar m2048@0xd0001000 port 0xd000110=
0 irq 62
[    1.575747] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.575803] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.06
[    1.575805] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.575807] usb usb1: Product: xHCI Host Controller
[    1.575809] usb usb1: Manufacturer: Linux 6.6.8 xhci-hcd
[    1.575810] usb usb1: SerialNumber: 0000:04:00.3
[    1.575941] ahci 0000:05:00.1: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode
[    1.575943] ahci 0000:05:00.1: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part
[    1.576021] hub 1-0:1.0: USB hub found
[    1.576029] hub 1-0:1.0: 4 ports detected
[    1.576153] scsi host1: ahci
[    1.576211] ata2: SATA max UDMA/133 abar m2048@0xd0000000 port 0xd000010=
0 irq 66
[    1.576329] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.576349] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.06
[    1.576351] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.576352] usb usb2: Product: xHCI Host Controller
[    1.576354] usb usb2: Manufacturer: Linux 6.6.8 xhci-hcd
[    1.576355] usb usb2: SerialNumber: 0000:04:00.3
[    1.576447] hub 2-0:1.0: USB hub found
[    1.576453] hub 2-0:1.0: 2 ports detected
[    1.576776] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.576781] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 3
[    1.576877] xhci_hcd 0000:04:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410
[    1.577301] xhci_hcd 0000:04:00.4: xHCI Host Controller
[    1.577304] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus =
number 4
[    1.577306] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.577335] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.06
[    1.577337] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.577338] usb usb3: Product: xHCI Host Controller
[    1.577340] usb usb3: Manufacturer: Linux 6.6.8 xhci-hcd
[    1.577341] usb usb3: SerialNumber: 0000:04:00.4
[    1.577443] hub 3-0:1.0: USB hub found
[    1.577450] hub 3-0:1.0: 4 ports detected
[    1.577711] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.577730] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.06
[    1.577731] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.577733] usb usb4: Product: xHCI Host Controller
[    1.577734] usb usb4: Manufacturer: Linux 6.6.8 xhci-hcd
[    1.577735] usb usb4: SerialNumber: 0000:04:00.4
[    1.577835] hub 4-0:1.0: USB hub found
[    1.577841] hub 4-0:1.0: 2 ports detected
[    1.815033] usb 1-3: new high-speed USB device number 2 using xhci_hcd
[    1.886676] ata2: SATA link down (SStatus 0 SControl 300)
[    1.886678] ata1: SATA link down (SStatus 0 SControl 300)
[    1.946628] usb 1-3: New USB device found, idVendor=3D13d3, idProduct=3D=
3567, bcdDevice=3D 1.00
[    1.946639] usb 1-3: New USB device strings: Mfr=3D5, Product=3D6, Seria=
lNumber=3D7
[    1.946642] usb 1-3: Product: Wireless_Device
[    1.946645] usb 1-3: Manufacturer: MediaTek Inc.
[    1.946648] usb 1-3: SerialNumber: 000000000
[    2.044966] tsc: Refined TSC clocksource calibration: 1996.237 MHz
[    2.044983] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x398=
c9735f96, max_idle_ns: 881590446725 ns
[    2.045044] clocksource: Switched to clocksource tsc
[    2.067051] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[    2.201230] usb 1-4: New USB device found, idVendor=3D0408, idProduct=3D=
545e, bcdDevice=3D 0.07
[    2.201238] usb 1-4: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2
[    2.201240] usb 1-4: Product: HP True Vision 5MP Camera
[    2.201242] usb 1-4: Manufacturer: Quanta
[    2.201243] usb 1-4: SerialNumber: 0001
[    7.544243] stage-1-init: [Wed Jan  3 10:56:41 UTC 2024] Passphrase for =
/dev/disk/by-uuid/1c39ec7c-f922-4b2c-a3c1-6b5055efdeff:
[    9.709616] Key type encrypted registered
[    9.735470] stage-1-init: [Wed Jan  3 10:56:43 UTC 2024] Verifying passp=
hrase for /dev/disk/by-uuid/1c39ec7c-f922-4b2c-a3c1-6b5055efdeff... - succe=
ss
[   13.952222] stage-1-init: [Wed Jan  3 10:56:47 UTC 2024] starting device=
 mapper and LVM...
[   14.014546] BTRFS: device fsid 03eb3af7-3033-4dd9-9ab4-d9590dd5a776 devi=
d 1 transid 141531 /dev/mapper/luks-1c39ec7c-f922-4b2c-a3c1-6b5055efdeff sc=
anned by btrfs (344)
[   14.015314] stage-1-init: [Wed Jan  3 10:56:47 UTC 2024] Scanning for Bt=
rfs filesystems
[   14.016117] stage-1-init: [Wed Jan  3 10:56:47 UTC 2024] registered: /de=
v/mapper/luks-1c39ec7c-f922-4b2c-a3c1-6b5055efdeff
[   14.035066] stage-1-init: [Wed Jan  3 10:56:47 UTC 2024] mounting /dev/d=
isk/by-uuid/03eb3af7-3033-4dd9-9ab4-d9590dd5a776 on /...
[   14.036076] BTRFS info (device dm-0): first mount of filesystem 03eb3af7=
-3033-4dd9-9ab4-d9590dd5a776
[   14.036091] BTRFS info (device dm-0): using crc32c (crc32c-intel) checks=
um algorithm
[   14.036096] BTRFS info (device dm-0): using free space tree
[   14.086868] BTRFS info (device dm-0): enabling ssd optimizations
[   14.276220] booting system configuration /nix/store/jclp5jk45vc2cv304zxm=
zrkn815cbpqx-nixos-system-lnix-24.05.20231230.b0d36bd
[   14.299812] stage-2-init: running activation script...
[   14.480346] stage-2-init: setting up /etc...
[   14.709346] systemd[1]: Inserted module 'autofs4'
[   14.736030] systemd[1]: systemd 254.6 running in system mode (+PAM +AUDI=
T -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BL=
KID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK =
+PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_=
FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[   14.736037] systemd[1]: Detected architecture x86-64.
[   14.736407] systemd[1]: Hostname set to <lnix>.
[   15.288851] systemd[1]: bpf-lsm: LSM BPF program attached
[   15.296918] systemd-gpt-auto-generator[692]: EFI loader partition unknow=
n, exiting.
[   15.296923] systemd-gpt-auto-generator[692]: (The boot loader did not se=
t EFI variable LoaderDevicePartUUID.)
[   15.376108] systemd[1]: /etc/systemd/system/cups.socket:5: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/c=
ups/cups.sock =E2=86=92 /run/cups/cups.sock; please update the unit file ac=
cordingly.
[   15.382867] systemd[1]: Queued start job for default target Graphical In=
terface.
[   15.396856] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[   15.397706] systemd[1]: Created slice Slice /system/getty.
[   15.398155] systemd[1]: Created slice Slice /system/modprobe.
[   15.398601] systemd[1]: Created slice Slice /system/systemd-fsck.
[   15.399027] systemd[1]: Created slice User and Session Slice.
[   15.399116] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[   15.399194] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[   15.399251] systemd[1]: Reached target Local Encrypted Volumes.
[   15.399292] systemd[1]: Reached target Containers.
[   15.399331] systemd[1]: Reached target Path Units.
[   15.399364] systemd[1]: Reached target Remote File Systems.
[   15.399396] systemd[1]: Reached target Slice Units.
[   15.399433] systemd[1]: Reached target libvirt guests shutdown target.
[   15.400109] systemd[1]: Listening on Process Core Dump Socket.
[   15.400445] systemd[1]: Listening on Journal Socket (/dev/log).
[   15.400582] systemd[1]: Listening on Journal Socket.
[   15.400751] systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Kille=
r Socket.
[   15.401082] systemd[1]: Listening on udev Control Socket.
[   15.401198] systemd[1]: Listening on udev Kernel Socket.
[   15.402173] systemd[1]: Mounting Huge Pages File System...
[   15.403107] systemd[1]: Mounting POSIX Message Queue File System...
[   15.404030] systemd[1]: Mounting Kernel Debug File System...
[   15.404975] systemd[1]: Starting Create List of Static Device Nodes...
[   15.405866] systemd[1]: Starting Load Kernel Module configfs...
[   15.406841] systemd[1]: Starting Load Kernel Module drm...
[   15.407948] systemd[1]: Starting Load Kernel Module efi_pstore...
[   15.408942] systemd[1]: Starting Load Kernel Module fuse...
[   15.410018] systemd[1]: Starting mount-pstore.service...
[   15.410205] pstore: Using crash dump compression: deflate
[   15.411130] systemd[1]: Starting Create SUID/SGID Wrappers...
[   15.412562] systemd[1]: Starting Journal Service...
[   15.413750] systemd[1]: Starting Load Kernel Modules...
[   15.414933] systemd[1]: Starting Remount Root and Kernel File Systems...
[   15.415989] pstore: Registered efi_pstore as persistent store backend
[   15.416191] systemd[1]: Starting Coldplug All udev Devices...
[   15.418178] systemd[1]: Mounted Huge Pages File System.
[   15.418333] systemd[1]: Mounted POSIX Message Queue File System.
[   15.418481] systemd[1]: Mounted Kernel Debug File System.
[   15.420228] fuse: init (API version 7.39)
[   15.422152] systemd-journald[710]: Collecting audit messages is disabled=
.
[   15.433134] systemd[1]: Finished Create List of Static Device Nodes.
[   15.434226] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[   15.446966] ACPI: bus type drm_connector registered
[   15.450027] systemd[1]: Finished Load Kernel Module configfs.
[   15.450554] systemd[1]: modprobe@drm.service: Deactivated successfully.
[   15.493948] systemd[1]: Finished Load Kernel Module drm.
[   15.494213] systemd[1]: Started Journal Service.
[   15.498737] ccp 0000:04:00.2: enabling device (0000 -> 0002)
[   15.498931] ccp 0000:04:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.
[   15.509068] ccp 0000:04:00.2: tee enabled
[   15.509149] ccp 0000:04:00.2: psp enabled
[   15.518589] kvm_amd: TSC scaling supported
[   15.518591] kvm_amd: Nested Virtualization enabled
[   15.518592] kvm_amd: Nested Paging enabled
[   15.518596] kvm_amd: Virtual VMLOAD VMSAVE supported
[   15.518597] kvm_amd: Virtual GIF supported
[   15.518598] kvm_amd: LBR virtualization supported
[   15.530780] mc: Linux media interface: v0.10
[   15.543505] videodev: Linux video capture interface: v2.00
[   15.552727] v4l2loopback: loading out-of-tree module taints kernel.
[   15.553317] v4l2loopback driver version 0.12.7 loaded
[   15.568927] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   15.575322] tun: Universal TUN/TAP device driver, 1.6
[   15.578583] Bridge firewalling registered
[   15.595336] loop: module loaded
[   15.641051] systemd-journald[710]: Received client request to flush runt=
ime journal.
[   15.662827] systemd-journald[710]: /var/log/journal/2d33e803ddb446baada1=
dc832d7bc174/system.journal: Journal file uses a different sequence number =
ID, rotating.
[   15.662832] systemd-journald[710]: Rotating system journal.
[   15.825911] BTRFS info: devid 1 device path /dev/disk/by-uuid/03eb3af7-3=
033-4dd9-9ab4-d9590dd5a776 changed to /dev/dm-0 scanned by (udev-worker) (9=
43)
[   15.831637] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   15.831714] ACPI: button: Power Button [PWRB]
[   15.831808] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input2
[   15.831842] ACPI: button: Lid Switch [LID]
[   15.831906] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[   15.832431] acpi-tad ACPI000E:00: Missing _PRW
[   15.837556] ACPI: button: Power Button [PWRF]
[   15.850890] Serial bus multi instantiate pseudo device driver CSC3551:00=
: Instantiated 2 I2C devices.
[   15.851464] hid: raw HID events driver (C) Jiri Kosina
[   15.854021] Adding 18429948k swap on /dev/mapper/luks-8f65572b-06a6-49dc=
-a618-e637d1343e04.  Priority:-2 extents:1 across:18429948k SS
[   15.861755] tpm_crb MSFT0101:00: Disabling hwrng
[   15.861765] tpm tpm0: tpm_read_log_acpi: Failed to map ACPI memory
[   15.872247] thermal LNXTHERM:00: registered as thermal_zone0
[   15.872252] ACPI: thermal: Thermal Zone [TSZ0] (79 C)
[   15.875026] thermal LNXTHERM:01: registered as thermal_zone1
[   15.875030] ACPI: thermal: Thermal Zone [TSZ2] (20 C)
[   15.877426] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8232DE3D-663D-4=
327-A8F4-E293ADB9BF05 has zero instances
[   15.877430] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6436-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[   15.877433] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: 8F1F6435-9F42-4=
2C8-BADC-0E9424F20C9A has zero instances
[   15.877436] wmi_bus wmi_bus-PNP0C14:02: [Firmware Info]: DF4E63B6-3BBC-4=
858-9737-C74F82F821F3 has zero instances
[   15.879967] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[   15.879972] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[   15.880675] pcie_mp2_amd 0000:04:00.7: enabling device (0000 -> 0002)
[   15.880772] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[   15.886227] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer
[   15.886229] RAPL PMU: hw unit of domain package 2^-16 Joules
[   15.915245] BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/ma=
pper/luks-1c39ec7c-f922-4b2c-a3c1-6b5055efdeff scanned by mount (999)
[   15.923850] ACPI: battery: Slot [BAT1] (battery present)
[   15.937705] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[   15.938445] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:0d/LNXVIDEO:00/input/input4
[   15.999587] input: ELAN2513:00 04F3:402C Touchscreen as /devices/platfor=
m/AMDI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input5
[   15.999655] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input6
[   15.999705] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input7
[   15.999762] input: ELAN2513:00 04F3:402C Stylus as /devices/platform/AMD=
I0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input8
[   15.999819] input: ELAN2513:00 04F3:402C Keyboard as /devices/platform/A=
MDI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input9
[   15.999869] input: ELAN2513:00 04F3:402C Mouse as /devices/platform/AMDI=
0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input10
[   15.999916] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input12
[   15.999960] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input13
[   16.000004] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input14
[   16.026595] input: SYNA32CB:00 06CB:CE7D Mouse as /devices/platform/AMDI=
0010:03/i2c-2/i2c-SYNA32CB:00/0018:06CB:CE7D.0002/input/input16
[   16.026667] input: SYNA32CB:00 06CB:CE7D Touchpad as /devices/platform/A=
MDI0010:03/i2c-2/i2c-SYNA32CB:00/0018:06CB:CE7D.0002/input/input17
[   16.026742] hid-generic 0018:06CB:CE7D.0002: input,hidraw1: I2C HID v1.0=
0 Mouse [SYNA32CB:00 06CB:CE7D] on i2c-SYNA32CB:00
[   16.050292] Linux agpgart interface v0.103
[   16.051179] hid-generic 0018:04F3:402C.0001: input,hidraw0: I2C HID v1.0=
0 Keyboard [ELAN2513:00 04F3:402C] on i2c-ELAN2513:00
[   16.051271] snd_rn_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002=
)
[   16.054419] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   16.054552] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[   16.055940] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[   16.078580] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed property ci=
rrus,dev-index: -22
[   16.079219] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: error -EINVAL: Pla=
tform not supported
[   16.079761] cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.0 failed wi=
th error -22
[   16.079877] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Failed property ci=
rrus,dev-index: -22
[   16.080302] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: error -EINVAL: Pla=
tform not supported
[   16.080770] cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.1 failed wi=
th error -22
[   16.080949] EDAC MC: Ver: 3.0.0
[   16.091465] MCE: In-kernel MCE decoding enabled.
[   16.091754] intel_rapl_common: Found RAPL domain package
[   16.091758] intel_rapl_common: Found RAPL domain core
[   16.117413] Bluetooth: Core ver 2.22
[   16.117433] NET: Registered PF_BLUETOOTH protocol family
[   16.117435] Bluetooth: HCI device and connection manager initialized
[   16.117440] Bluetooth: HCI socket layer initialized
[   16.117443] Bluetooth: L2CAP socket layer initialized
[   16.117449] Bluetooth: SCO socket layer initialized
[   16.118156] usb 1-4: Found UVC 1.10 device HP True Vision 5MP Camera (04=
08:545e)
[   16.126030] usb 1-4: Found UVC 1.50 device HP True Vision 5MP Camera (04=
08:545e)
[   16.127914] usbcore: registered new interface driver uvcvideo
[   16.141207] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   16.144153] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.148470] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[   16.148560] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio clie=
nt
[   16.148602] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
[   16.152863] usbcore: registered new interface driver btusb
[   16.176601] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 2023=
1109191416
[   16.192157] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input19
[   16.262324] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC245: li=
ne_outs=3D1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   16.262330] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   16.262333] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[   16.262334] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[   16.262336] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   16.262337] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x19
[   16.276926] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:04:00.1/sound/card0/input20
[   16.281302] mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
[   16.301360] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:04:00.6/sound/card1/input22
[   16.308890] input: HD-Audio Generic Headphone as /devices/pci0000:00/000=
0:00:08.1/0000:04:00.6/sound/card1/input23
[   16.309886] mt7921e 0000:01:00.0: ASIC revision: 79610010
[   16.346241] input: ELAN2513:00 04F3:402C as /devices/platform/AMDI0010:0=
2/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input24
[   16.346316] input: ELAN2513:00 04F3:402C UNKNOWN as /devices/platform/AM=
DI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input25
[   16.346376] input: ELAN2513:00 04F3:402C UNKNOWN as /devices/platform/AM=
DI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input26
[   16.346433] input: ELAN2513:00 04F3:402C Stylus as /devices/platform/AMD=
I0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input27
[   16.346490] input: ELAN2513:00 04F3:402C Keyboard as /devices/platform/A=
MDI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input28
[   16.346555] input: ELAN2513:00 04F3:402C Mouse as /devices/platform/AMDI=
0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input29
[   16.346621] input: ELAN2513:00 04F3:402C UNKNOWN as /devices/platform/AM=
DI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input31
[   16.346681] input: ELAN2513:00 04F3:402C UNKNOWN as /devices/platform/AM=
DI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input32
[   16.346737] input: ELAN2513:00 04F3:402C UNKNOWN as /devices/platform/AM=
DI0010:02/i2c-1/i2c-ELAN2513:00/0018:04F3:402C.0001/input/input33
[   16.367857] ACPI: AC: AC Adapter [ACAD] (off-line)
[   16.390375] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20231109190918a

[   16.395189] hid-multitouch 0018:04F3:402C.0001: input,hidraw0: I2C HID v=
1.00 Keyboard [ELAN2513:00 04F3:402C] on i2c-ELAN2513:00
[   16.400958] systemd-journald[710]: /var/log/journal/2d33e803ddb446baada1=
dc832d7bc174/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   16.426739] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.426754] Bluetooth: BNEP socket layer initialized
[   16.428739] input: SYNA32CB:00 06CB:CE7D Mouse as /devices/platform/AMDI=
0010:03/i2c-2/i2c-SYNA32CB:00/0018:06CB:CE7D.0002/input/input35
[   16.428833] input: SYNA32CB:00 06CB:CE7D Touchpad as /devices/platform/A=
MDI0010:03/i2c-2/i2c-SYNA32CB:00/0018:06CB:CE7D.0002/input/input36
[   16.428922] hid-multitouch 0018:06CB:CE7D.0002: input,hidraw1: I2C HID v=
1.00 Mouse [SYNA32CB:00 06CB:CE7D] on i2c-SYNA32CB:00
[   16.433316] mousedev: PS/2 mouse device common for all mice
[   16.668036] mt7921e 0000:01:00.0: WM Firmware Version: ____010000, Build=
 Time: 20231109190959
[   16.889404] input: HP WMI hotkeys as /devices/virtual/input/input21
[   17.508840] mt7921e 0000:01:00.0 wlo1: renamed from wlan0
[   17.544440] [drm] amdgpu kernel modesetting enabled.
[   17.546742] amdgpu: Virtual CRAT table created for CPU
[   17.546763] amdgpu: Topology: Add CPU node
[   17.546907] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
[   17.546961] [drm] initializing kernel modesetting (RENOIR 0x1002:0x15E7 =
0x103C:0x8A31 0xC1).
[   17.554977] [drm] register mmio base: 0xD0500000
[   17.554981] [drm] register mmio size: 524288
[   17.557926] [drm] add ip block number 0 <soc15_common>
[   17.557932] [drm] add ip block number 1 <gmc_v9_0>
[   17.557933] [drm] add ip block number 2 <vega10_ih>
[   17.557934] [drm] add ip block number 3 <psp>
[   17.557935] [drm] add ip block number 4 <smu>
[   17.557936] [drm] add ip block number 5 <dm>
[   17.557937] [drm] add ip block number 6 <gfx_v9_0>
[   17.557938] [drm] add ip block number 7 <sdma_v4_0>
[   17.557939] [drm] add ip block number 8 <vcn_v2_0>
[   17.557940] [drm] add ip block number 9 <jpeg_v2_0>
[   17.557952] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
[   17.557954] amdgpu: ATOM BIOS: 113-BARCELO-004
[   17.584590] [drm] VCN decode is enabled in VM mode
[   17.584592] [drm] VCN encode is enabled in VM mode
[   17.599192] [drm] JPEG decode is enabled in VM mode
[   17.599340] Console: switching to colour dummy device 80x25
[   17.599382] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
[   17.599385] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
[   17.599388] amdgpu 0000:04:00.0: amdgpu: MODE2 reset
[   17.599988] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[   17.599995] amdgpu 0000:04:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -=
 0x000000F41FFFFFFF (512M used)
[   17.599997] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[   17.600000] amdgpu 0000:04:00.0: amdgpu: AGP: 267419648M 0x000000F800000=
000 - 0x0000FFFFFFFFFFFF
[   17.600008] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[   17.600010] [drm] RAM width 128bits DDR4
[   17.600123] [drm] amdgpu: 512M of VRAM memory ready
[   17.600125] [drm] amdgpu: 7653M of GTT memory ready.
[   17.600143] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   17.600285] [drm] PCIE GART of 1024M enabled.
[   17.600288] [drm] PTB located at 0x000000F41FC00000
[   17.600480] [drm] Loading DMUB firmware via PSP: version=3D0x01010028
[   17.600971] [drm] Found VCN firmware Version ENC: 1.21 DEC: 6 VEP: 0 Rev=
ision: 0
[   17.600979] amdgpu 0000:04:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[   18.013928] .qemu-system-x8[1526]: memfd_create() called without MFD_EXE=
C or MFD_NOEXEC_SEAL set
[   18.237803] NET: Registered PF_PACKET protocol family
[   18.358793] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[   18.451962] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[   18.463385] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[   18.463388] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[   18.463711] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully=
!
[   18.464762] [drm] Display Core v3.2.247 initialized on DCN 2.1
[   18.464766] [drm] DP-HDMI FRL PCON supported
[   18.465410] [drm] DMUB hardware initialized: version=3D0x01010028
[   18.493195] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[   18.677059] [drm] kiq ring mec 2 pipe 1 q 0
[   18.680154] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[   18.680174] [drm] JPEG decode initialized successfully.
[   18.681305] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   18.681318] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[   18.681396] amdgpu: Virtual CRAT table created for GPU
[   18.681988] amdgpu: Topology: Add dGPU node [0x15e7:0x1002]
[   18.681990] kfd kfd: amdgpu: added device 1002:15e7
[   18.682133] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8,=
 active_cu_number 8
[   18.682262] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[   18.682264] amdgpu 0000:04:00.0: amdgpu: ring gfx_low uses VM inv eng 1 =
on hub 0
[   18.682265] amdgpu 0000:04:00.0: amdgpu: ring gfx_high uses VM inv eng 4=
 on hub 0
[   18.682267] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 5 on hub 0
[   18.682268] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 6 on hub 0
[   18.682269] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 7 on hub 0
[   18.682270] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 8 on hub 0
[   18.682271] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 9 on hub 0
[   18.682272] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 10 on hub 0
[   18.682273] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 11 on hub 0
[   18.682275] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 12 on hub 0
[   18.682276] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 13 on hub 0
[   18.682277] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[   18.682278] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[   18.682279] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[   18.682280] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[   18.682281] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[   18.684573] [drm] Initialized amdgpu 3.54.0 20150101 for 0000:04:00.0 on=
 minor 0
[   18.689739] fbcon: amdgpudrmfb (fb0) is primary device
[   18.689924] [drm] DSC precompute is not needed.
[   18.726118] Console: switching to colour frame buffer device 240x67
[   18.744637] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[   18.849836] Bluetooth: hci0: Device setup in 2633752 usecs
[   18.849841] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   18.913676] Bluetooth: MGMT ver 1.22
[   18.917069] NET: Registered PF_ALG protocol family
[   20.440355] Bluetooth: RFCOMM TTY layer initialized
[   20.440365] Bluetooth: RFCOMM socket layer initialized
[   20.440370] Bluetooth: RFCOMM ver 1.11
[   20.567202] wlo1: authenticate with b0:be:76:77:95:d3
[   20.682290] pcie_mp2_amd 0000:04:00.7: Failed to discover, sensors not e=
nabled is 0
[   20.682322] pcie_mp2_amd: probe of 0000:04:00.7 failed with error -95
[   20.762765] wlo1: send auth to b0:be:76:77:95:d3 (try 1/3)
[   20.767412] wlo1: authenticated
[   20.768753] wlo1: associate with b0:be:76:77:95:d3 (try 1/3)
[   20.783239] wlo1: RX AssocResp from b0:be:76:77:95:d3 (capab=3D0x31 stat=
us=3D0 aid=3D8)
[   20.815734] wlo1: associated
[   21.482411] Initializing XFRM netlink socket
[   26.603340] hp_wmi: Unknown event_id - 131073 - 0x0
[  146.219968] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D15518 DF PROTO=3DTCP SPT=3D45116 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  147.161767] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D15519 DF PROTO=3DTCP SPT=3D45116 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  148.126024] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D62440 DF PROTO=3DTCP SPT=3D38396 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  149.141217] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D62441 DF PROTO=3DTCP SPT=3D38396 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  151.521909] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D32376 DF PROTO=3DTCP SPT=3D45126 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  152.499266] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D32377 DF PROTO=3DTCP SPT=3D45126 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  153.489837] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D45106 DF PROTO=3DTCP SPT=3D38408 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  154.567215] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D45107 DF PROTO=3DTCP SPT=3D38408 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  156.199350] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D23470 DF PROTO=3DTCP SPT=3D38596 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  157.006858] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D23471 DF PROTO=3DTCP SPT=3D38596 DPT=
=3D80 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  158.048556] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D55065 DF PROTO=3DTCP SPT=3D41606 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  159.030888] refused connection: IN=3Dwlo1 OUT=3D MAC=3D50:5a:65:7c:60:cd=
:80:54:9c:6e:39:1f:08:00 SRC=3D192.168.158.96 DST=3D192.168.158.65 LEN=3D60=
 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D55066 DF PROTO=3DTCP SPT=3D41606 DPT=
=3D443 WINDOW=3D65535 RES=3D0x00 SYN URGP=3D0
[  241.202434] atkbd serio0: Unknown key pressed (translated set 2, code 0x=
d8 on isa0060/serio0).
[  241.202445] atkbd serio0: Use 'setkeycodes e058 <keycode>' to make it kn=
own.
[  241.209146] atkbd serio0: Unknown key released (translated set 2, code 0=
xd8 on isa0060/serio0).
[  241.209153] atkbd serio0: Use 'setkeycodes e058 <keycode>' to make it kn=
own.
[  241.606207] wlo1: deauthenticating from b0:be:76:77:95:d3 by local choic=
e (Reason: 3=3DDEAUTH_LEAVING)
[  242.082054] PM: suspend entry (s2idle)
[  242.094056] Filesystems sync: 0.011 seconds
[  242.118440] Freezing user space processes
[  242.119870] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[  242.119877] OOM killer disabled.
[  242.119880] Freezing remaining freezable tasks
[  242.120786] Freezing remaining freezable tasks completed (elapsed 0.000 =
seconds)
[  242.120791] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[  242.142291] atkbd serio0: Disabling IRQ1 wakeup source to avoid platform=
 firmware bug
[  242.508157] ACPI: EC: interrupt blocked
[ 1000.118938] ACPI: EC: interrupt unblocked
[ 1000.150265] pci 0000:00:00.2: can't derive routing for PCI INT A
[ 1000.150273] pci 0000:00:00.2: PCI INT A: no GSI
[ 1000.151548] [drm] PCIE GART of 1024M enabled.
[ 1000.151560] [drm] PTB located at 0x000000F41FC00000
[ 1000.151605] amdgpu 0000:04:00.0: amdgpu: SMU is resuming...
[ 1000.154344] amdgpu 0000:04:00.0: amdgpu: dpm has been disabled
[ 1000.155558] amdgpu 0000:04:00.0: amdgpu: SMU is resumed successfully!
[ 1000.232038] nvme nvme0: 8/0/0 default/read/poll queues
[ 1000.379100] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[ 1000.379507] [drm] JPEG decode initialized successfully.
[ 1000.379515] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[ 1000.379518] amdgpu 0000:04:00.0: amdgpu: ring gfx_low uses VM inv eng 1 =
on hub 0
[ 1000.379520] amdgpu 0000:04:00.0: amdgpu: ring gfx_high uses VM inv eng 4=
 on hub 0
[ 1000.379521] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 5 on hub 0
[ 1000.379523] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 6 on hub 0
[ 1000.379524] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 7 on hub 0
[ 1000.379525] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 8 on hub 0
[ 1000.379527] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 9 on hub 0
[ 1000.379528] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 10 on hub 0
[ 1000.379529] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 11 on hub 0
[ 1000.379531] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 12 on hub 0
[ 1000.379532] amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 13 on hub 0
[ 1000.379533] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[ 1000.379535] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[ 1000.379536] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[ 1000.379537] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[ 1000.379538] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[ 1000.434733] usb 1-4: reset high-speed USB device number 3 using xhci_hcd
[ 1000.457038] ata2: SATA link down (SStatus 0 SControl 300)
[ 1000.457040] ata1: SATA link down (SStatus 0 SControl 300)
[ 1000.807686] OOM killer enabled.
[ 1000.807688] Restarting tasks ...
[ 1000.807806] pci_bus 0000:01: Allocating resources
[ 1000.807890] pcieport 0000:00:01.3: bridge window [io  0x1000-0x0fff] to =
[bus 01] add_size 1000
[ 1000.807895] pcieport 0000:00:01.3: bridge window [mem 0x00100000-0x000ff=
fff] to [bus 01] add_size 200000 add_align 100000
[ 1000.807907] pcieport 0000:00:01.3: BAR 14: assigned [mem 0xd0800000-0xd0=
9fffff]
[ 1000.807913] pcieport 0000:00:01.3: BAR 13: assigned [io  0x4000-0x4fff]
[ 1000.810122] done.
[ 1000.810136] random: crng reseeded on system resumption
[ 1000.830777] PM: suspend exit
[ 1001.969104] pci_bus 0000:01: Allocating resources
[ 1001.972777] pci_bus 0000:01: Allocating resources
[ 1001.972913] pci_bus 0000:01: Allocating resources
[ 1001.973038] pci_bus 0000:01: Allocating resources
[ 1001.974124] pci_bus 0000:01: Allocating resources
[ 1001.974239] pci_bus 0000:01: Allocating resources
[ 1001.978407] pci_bus 0000:01: Allocating resources
[ 1001.978547] pci_bus 0000:01: Allocating resources
[ 1003.381306] wlo1: authenticate with b0:be:76:77:95:d3
[ 1003.413421] wlo1: send auth to b0:be:76:77:95:d3 (try 1/3)
[ 1003.418405] wlo1: authenticated
[ 1003.419722] wlo1: associate with b0:be:76:77:95:d3 (try 1/3)
[ 1003.434879] wlo1: RX AssocResp from b0:be:76:77:95:d3 (capab=3D0x31 stat=
us=3D0 aid=3D8)
[ 1003.460002] wlo1: associated
[ 1007.905446] pci_bus 0000:01: Allocating resources
[ 1007.912247] pci_bus 0000:01: Allocating resources
[ 1007.914355] pci_bus 0000:01: Allocating resources
[ 1007.915225] pci_bus 0000:01: Allocating resources
[ 1011.197347] hp_wmi: Unknown event_id - 131073 - 0x0
[ 1013.174623] pci_bus 0000:01: Allocating resources
[ 1013.175986] pci_bus 0000:01: Allocating resources
[ 1013.176133] pci_bus 0000:01: Allocating resources
[ 1013.176272] pci_bus 0000:01: Allocating resources
[ 1013.183823] pci_bus 0000:01: Allocating resources
[ 1017.281901] pci_bus 0000:01: Allocating resources
[ 1017.294877] pci_bus 0000:01: Allocating resources
[ 1017.295935] pci_bus 0000:01: Allocating resources
[ 1017.296052] pci_bus 0000:01: Allocating resources
[ 1017.364884] pci_bus 0000:01: Allocating resources
[ 1017.372735] pci_bus 0000:01: Allocating resources
[ 1017.375786] pci_bus 0000:01: Allocating resources
[ 1017.376031] pci_bus 0000:01: Allocating resources
[ 1017.381215] pci_bus 0000:01: Allocating resources
[ 1017.384715] pci_bus 0000:01: Allocating resources
[ 1017.385717] pci_bus 0000:01: Allocating resources
[ 1017.388692] pci_bus 0000:01: Allocating resources
[ 1017.389980] pci_bus 0000:01: Allocating resources
[ 1017.390216] pci_bus 0000:01: Allocating resources
[ 1017.392697] pci_bus 0000:01: Allocating resources
[ 1017.560932] pci_bus 0000:01: Allocating resources
[ 1017.561741] pci_bus 0000:01: Allocating resources
[ 1017.562689] pci_bus 0000:01: Allocating resources
[ 1017.576612] pci_bus 0000:01: Allocating resources
[ 1017.576876] pci_bus 0000:01: Allocating resources
[ 1017.593443] pci_bus 0000:01: Allocating resources
[ 1017.593775] pci_bus 0000:01: Allocating resources
[ 1017.594781] pci_bus 0000:01: Allocating resources
[ 1017.595921] pci_bus 0000:01: Allocating resources
[ 1017.596185] pci_bus 0000:01: Allocating resources
[ 1017.602738] pci_bus 0000:01: Allocating resources
[ 1017.603790] pci_bus 0000:01: Allocating resources
[ 1017.607727] pci_bus 0000:01: Allocating resources
[ 1017.615770] pci_bus 0000:01: Allocating resources
[ 1017.647904] pci_bus 0000:01: Allocating resources
[ 1017.653732] pci_bus 0000:01: Allocating resources
[ 1017.663819] pci_bus 0000:01: Allocating resources
[ 1017.674755] pci_bus 0000:01: Allocating resources
[ 1017.677194] pci_bus 0000:01: Allocating resources
[ 1017.677311] pci_bus 0000:01: Allocating resources
[ 1017.677431] pci_bus 0000:01: Allocating resources
[ 1017.677541] pci_bus 0000:01: Allocating resources
[ 1017.677650] pci_bus 0000:01: Allocating resources
[ 1017.677755] pci_bus 0000:01: Allocating resources
[ 1017.677865] pci_bus 0000:01: Allocating resources
[ 1017.677970] pci_bus 0000:01: Allocating resources
[ 1017.678072] pci_bus 0000:01: Allocating resources
[ 1017.681767] pci_bus 0000:01: Allocating resources
[ 1017.685991] pci_bus 0000:01: Allocating resources
[ 1017.687140] pci_bus 0000:01: Allocating resources
[ 1017.687277] pci_bus 0000:01: Allocating resources
[ 1017.692224] pci_bus 0000:01: Allocating resources
[ 1017.692542] pci_bus 0000:01: Allocating resources
[ 1017.692677] pci_bus 0000:01: Allocating resources
[ 1017.695983] pci_bus 0000:01: Allocating resources
[ 1017.696466] pci_bus 0000:01: Allocating resources
[ 1017.696698] pci_bus 0000:01: Allocating resources
[ 1017.701354] pci_bus 0000:01: Allocating resources
[ 1017.701867] pci_bus 0000:01: Allocating resources
[ 1017.703067] pci_bus 0000:01: Allocating resources
[ 1017.703208] pci_bus 0000:01: Allocating resources
[ 1017.708734] pci_bus 0000:01: Allocating resources
[ 1017.709771] pci_bus 0000:01: Allocating resources
[ 1017.711147] pci_bus 0000:01: Allocating resources
[ 1017.711286] pci_bus 0000:01: Allocating resources
[ 1017.711430] pci_bus 0000:01: Allocating resources
[ 1017.714920] pci_bus 0000:01: Allocating resources
[ 1017.715043] pci_bus 0000:01: Allocating resources
[ 1017.719719] pci_bus 0000:01: Allocating resources
[ 1017.758866] pci_bus 0000:01: Allocating resources
[ 1017.761232] pci_bus 0000:01: Allocating resources
[ 1017.761548] pci_bus 0000:01: Allocating resources
[ 1017.761845] pci_bus 0000:01: Allocating resources
[ 1017.810630] pci_bus 0000:01: Allocating resources
[ 1017.811251] pci_bus 0000:01: Allocating resources
[ 1017.811729] pci_bus 0000:01: Allocating resources
[ 1017.812808] pci_bus 0000:01: Allocating resources
[ 1017.815156] pci_bus 0000:01: Allocating resources
[ 1017.815325] pci_bus 0000:01: Allocating resources
[ 1018.613000] pci_bus 0000:01: Allocating resources
[ 1018.614169] pci_bus 0000:01: Allocating resources
[ 1018.614445] pci_bus 0000:01: Allocating resources
[ 1018.614725] pci_bus 0000:01: Allocating resources
[ 1018.617786] pci_bus 0000:01: Allocating resources
[ 1021.127520] pci_bus 0000:01: Allocating resources
[ 1021.128403] pci_bus 0000:01: Allocating resources
[ 1021.128531] pci_bus 0000:01: Allocating resources
[ 1021.128849] pci_bus 0000:01: Allocating resources
[ 1021.129519] pci_bus 0000:01: Allocating resources
[ 1021.129673] pci_bus 0000:01: Allocating resources
[ 1021.129829] pci_bus 0000:01: Allocating resources
[ 1021.129975] pci_bus 0000:01: Allocating resources
[ 1021.130101] pci_bus 0000:01: Allocating resources
[ 1021.130204] pci_bus 0000:01: Allocating resources
[ 1021.130307] pci_bus 0000:01: Allocating resources
[ 1021.130409] pci_bus 0000:01: Allocating resources
[ 1024.545152] pci_bus 0000:01: Allocating resources
[ 1024.546083] pci_bus 0000:01: Allocating resources
[ 1025.338010] pci_bus 0000:01: Allocating resources
[ 1026.168313] pci_bus 0000:01: Allocating resources
[ 1026.176197] pci_bus 0000:01: Allocating resources
[ 1026.177475] pci_bus 0000:01: Allocating resources
[ 1026.177861] pci_bus 0000:01: Allocating resources
[ 1026.178192] pci_bus 0000:01: Allocating resources
[ 1026.178527] pci_bus 0000:01: Allocating resources
[ 1026.196513] pci_bus 0000:01: Allocating resources
[ 1026.197510] pci_bus 0000:01: Allocating resources
[ 1026.197737] pci_bus 0000:01: Allocating resources
[ 1026.198171] pci_bus 0000:01: Allocating resources
[ 1026.251487] pci_bus 0000:01: Allocating resources
[ 1026.252572] pci_bus 0000:01: Allocating resources
[ 1026.252917] pci_bus 0000:01: Allocating resources
[ 1026.507523] pci_bus 0000:01: Allocating resources
[ 1027.554440] pci_bus 0000:01: Allocating resources
[ 1027.555382] pci_bus 0000:01: Allocating resources
[ 1027.557160] pci_bus 0000:01: Allocating resources
[ 1027.623279] pci_bus 0000:01: Allocating resources
[ 1028.572420] pci_bus 0000:01: Allocating resources
[ 1028.573233] pci_bus 0000:01: Allocating resources
[ 1028.759670] pci_bus 0000:01: Allocating resources
[ 1028.760201] pci_bus 0000:01: Allocating resources
[ 1028.762405] pci_bus 0000:01: Allocating resources
[ 1028.762723] pci_bus 0000:01: Allocating resources
[ 1030.468642] pci_bus 0000:01: Allocating resources
[ 1030.470416] pci_bus 0000:01: Allocating resources
[ 1030.471344] pci_bus 0000:01: Allocating resources
[ 1030.473438] pci_bus 0000:01: Allocating resources
[ 1030.474428] pci_bus 0000:01: Allocating resources
[ 1030.474643] pci_bus 0000:01: Allocating resources
[ 1030.476271] pci_bus 0000:01: Allocating resources
[ 1030.478490] pci_bus 0000:01: Allocating resources
[ 1030.478735] pci_bus 0000:01: Allocating resources
[ 1030.479345] pci_bus 0000:01: Allocating resources
[ 1030.694492] pci_bus 0000:01: Allocating resources
[ 1030.695383] pci_bus 0000:01: Allocating resources
[ 1030.926751] pci_bus 0000:01: Allocating resources
[ 1031.026566] pci_bus 0000:01: Allocating resources
[ 1031.041693] pci_bus 0000:01: Allocating resources
[ 1031.041970] pci_bus 0000:01: Allocating resources
[ 1031.267472] pci_bus 0000:01: Allocating resources
[ 1031.280368] pci_bus 0000:01: Allocating resources
[ 1031.611510] pci_bus 0000:01: Allocating resources
[ 1031.614370] pci_bus 0000:01: Allocating resources
[ 1031.617606] pci_bus 0000:01: Allocating resources
[ 1031.620568] pci_bus 0000:01: Allocating resources
[ 1031.620808] pci_bus 0000:01: Allocating resources
[ 1031.669445] pci_bus 0000:01: Allocating resources
[ 1031.670371] pci_bus 0000:01: Allocating resources
[ 1031.677355] pci_bus 0000:01: Allocating resources
[ 1031.678942] pci_bus 0000:01: Allocating resources
[ 1031.679197] pci_bus 0000:01: Allocating resources
[ 1031.679434] pci_bus 0000:01: Allocating resources
[ 1031.679661] pci_bus 0000:01: Allocating resources
[ 1031.682335] pci_bus 0000:01: Allocating resources
[ 1031.683618] pci_bus 0000:01: Allocating resources
[ 1031.687394] pci_bus 0000:01: Allocating resources
[ 1031.691373] pci_bus 0000:01: Allocating resources
[ 1031.694387] pci_bus 0000:01: Allocating resources
[ 1032.293582] pci_bus 0000:01: Allocating resources
[ 1032.692524] pci_bus 0000:01: Allocating resources
[ 1032.694427] pci_bus 0000:01: Allocating resources
[ 1032.696444] pci_bus 0000:01: Allocating resources
[ 1032.698432] pci_bus 0000:01: Allocating resources
[ 1032.881643] pci_bus 0000:01: Allocating resources
[ 1032.881892] pci_bus 0000:01: Allocating resources
[ 1033.718682] pci_bus 0000:01: Allocating resources
[ 1033.718932] pci_bus 0000:01: Allocating resources
[ 1033.719611] pci_bus 0000:01: Allocating resources
[ 1033.719824] pci_bus 0000:01: Allocating resources
[ 1033.772556] pci_bus 0000:01: Allocating resources
[ 1033.775482] pci_bus 0000:01: Allocating resources
[ 1033.776928] pci_bus 0000:01: Allocating resources
[ 1033.777565] pci_bus 0000:01: Allocating resources
[ 1033.777795] pci_bus 0000:01: Allocating resources
[ 1033.778025] pci_bus 0000:01: Allocating resources
[ 1033.778272] pci_bus 0000:01: Allocating resources
[ 1034.747854] pci_bus 0000:01: Allocating resources
[ 1034.751023] pci_bus 0000:01: Allocating resources
[ 1034.751386] pci_bus 0000:01: Allocating resources
[ 1034.753906] pci_bus 0000:01: Allocating resources
[ 1034.754117] pci_bus 0000:01: Allocating resources
[ 1034.754490] pci_bus 0000:01: Allocating resources
[ 1034.798046] pci_bus 0000:01: Allocating resources
[ 1034.798283] pci_bus 0000:01: Allocating resources
[ 1035.773868] pci_bus 0000:01: Allocating resources
[ 1035.922656] pci_bus 0000:01: Allocating resources
[ 1036.156150] pci_bus 0000:01: Allocating resources
[ 1036.276913] pci_bus 0000:01: Allocating resources
[ 1036.392201] pci_bus 0000:01: Allocating resources
[ 1036.782694] pci_bus 0000:01: Allocating resources
[ 1036.802823] pci_bus 0000:01: Allocating resources
[ 1036.803089] pci_bus 0000:01: Allocating resources
[ 1036.803624] pci_bus 0000:01: Allocating resources
[ 1036.854705] pci_bus 0000:01: Allocating resources
[ 1036.962844] pci_bus 0000:01: Allocating resources
[ 1037.376862] pci_bus 0000:01: Allocating resources
[ 1037.415013] pci_bus 0000:01: Allocating resources
[ 1037.420950] pci_bus 0000:01: Allocating resources
[ 1037.421151] pci_bus 0000:01: Allocating resources
[ 1037.515396] pci_bus 0000:01: Allocating resources
[ 1037.533897] pci_bus 0000:01: Allocating resources
[ 1037.536640] pci_bus 0000:01: Allocating resources
[ 1037.537636] pci_bus 0000:01: Allocating resources
[ 1037.543101] pci_bus 0000:01: Allocating resources
[ 1037.543597] pci_bus 0000:01: Allocating resources
[ 1037.559838] pci_bus 0000:01: Allocating resources
[ 1037.565029] pci_bus 0000:01: Allocating resources
[ 1037.565343] pci_bus 0000:01: Allocating resources
[ 1037.565689] pci_bus 0000:01: Allocating resources
[ 1037.568687] pci_bus 0000:01: Allocating resources
[ 1037.570637] pci_bus 0000:01: Allocating resources
[ 1037.571853] pci_bus 0000:01: Allocating resources
[ 1037.572115] pci_bus 0000:01: Allocating resources
[ 1037.623259] pci_bus 0000:01: Allocating resources
[ 1037.623561] pci_bus 0000:01: Allocating resources
[ 1037.623810] pci_bus 0000:01: Allocating resources
[ 1037.624056] pci_bus 0000:01: Allocating resources
[ 1037.624295] pci_bus 0000:01: Allocating resources
[ 1037.624767] pci_bus 0000:01: Allocating resources
[ 1037.625024] pci_bus 0000:01: Allocating resources
[ 1037.625283] pci_bus 0000:01: Allocating resources
[ 1037.625543] pci_bus 0000:01: Allocating resources
[ 1037.676781] pci_bus 0000:01: Allocating resources
[ 1037.755162] pci_bus 0000:01: Allocating resources
[ 1037.755817] pci_bus 0000:01: Allocating resources
[ 1037.756195] pci_bus 0000:01: Allocating resources
[ 1037.757051] pci_bus 0000:01: Allocating resources
[ 1037.757183] pci_bus 0000:01: Allocating resources
[ 1037.808571] pci_bus 0000:01: Allocating resources
[ 1037.808845] pci_bus 0000:01: Allocating resources
[ 1037.809060] pci_bus 0000:01: Allocating resources
[ 1037.809269] pci_bus 0000:01: Allocating resources
[ 1037.809503] pci_bus 0000:01: Allocating resources
[ 1037.809729] pci_bus 0000:01: Allocating resources
[ 1037.809948] pci_bus 0000:01: Allocating resources
[ 1037.810156] pci_bus 0000:01: Allocating resources
[ 1037.810373] pci_bus 0000:01: Allocating resources
[ 1037.821724] pci_bus 0000:01: Allocating resources
[ 1037.823831] pci_bus 0000:01: Allocating resources
[ 1037.824044] pci_bus 0000:01: Allocating resources
[ 1037.825618] pci_bus 0000:01: Allocating resources
[ 1037.826604] pci_bus 0000:01: Allocating resources
[ 1037.833920] pci_bus 0000:01: Allocating resources
[ 1037.836834] pci_bus 0000:01: Allocating resources
[ 1037.837061] pci_bus 0000:01: Allocating resources
[ 1037.905902] pci_bus 0000:01: Allocating resources
[ 1037.989087] pci_bus 0000:01: Allocating resources
[ 1037.989379] pci_bus 0000:01: Allocating resources
[ 1038.103791] pci_bus 0000:01: Allocating resources
[ 1038.104647] pci_bus 0000:01: Allocating resources
[ 1038.110794] pci_bus 0000:01: Allocating resources
[ 1038.216758] pci_bus 0000:01: Allocating resources
[ 1038.217662] pci_bus 0000:01: Allocating resources
[ 1038.220927] pci_bus 0000:01: Allocating resources
[ 1038.221258] pci_bus 0000:01: Allocating resources
[ 1038.331769] pci_bus 0000:01: Allocating resources
[ 1038.333693] pci_bus 0000:01: Allocating resources
[ 1038.337657] pci_bus 0000:01: Allocating resources
[ 1038.338834] pci_bus 0000:01: Allocating resources
[ 1038.338948] pci_bus 0000:01: Allocating resources
[ 1038.674230] pci_bus 0000:01: Allocating resources
[ 1038.674644] pci_bus 0000:01: Allocating resources
[ 1038.675648] pci_bus 0000:01: Allocating resources
[ 1038.676804] pci_bus 0000:01: Allocating resources
[ 1038.677019] pci_bus 0000:01: Allocating resources
[ 1038.786923] pci_bus 0000:01: Allocating resources
[ 1038.787068] pci_bus 0000:01: Allocating resources
[ 1038.788808] pci_bus 0000:01: Allocating resources
[ 1038.788923] pci_bus 0000:01: Allocating resources
[ 1038.789750] pci_bus 0000:01: Allocating resources
[ 1038.789856] pci_bus 0000:01: Allocating resources
[ 1038.840028] pci_bus 0000:01: Allocating resources
[ 1038.840321] pci_bus 0000:01: Allocating resources
[ 1038.840806] pci_bus 0000:01: Allocating resources
[ 1038.841912] pci_bus 0000:01: Allocating resources
[ 1038.842160] pci_bus 0000:01: Allocating resources
[ 1038.846099] pci_bus 0000:01: Allocating resources
[ 1038.846417] pci_bus 0000:01: Allocating resources
[ 1038.846856] pci_bus 0000:01: Allocating resources
[ 1038.847070] pci_bus 0000:01: Allocating resources
[ 1038.850856] pci_bus 0000:01: Allocating resources
[ 1038.851096] pci_bus 0000:01: Allocating resources
[ 1038.859125] pci_bus 0000:01: Allocating resources
[ 1038.859728] pci_bus 0000:01: Allocating resources
[ 1038.859971] pci_bus 0000:01: Allocating resources
[ 1038.860212] pci_bus 0000:01: Allocating resources
[ 1038.860810] pci_bus 0000:01: Allocating resources
[ 1038.861032] pci_bus 0000:01: Allocating resources
[ 1038.864132] pci_bus 0000:01: Allocating resources
[ 1038.864472] pci_bus 0000:01: Allocating resources
[ 1038.868068] pci_bus 0000:01: Allocating resources
[ 1038.868396] pci_bus 0000:01: Allocating resources
[ 1038.874704] pci_bus 0000:01: Allocating resources
[ 1038.876127] pci_bus 0000:01: Allocating resources
[ 1038.876509] pci_bus 0000:01: Allocating resources
[ 1038.903950] pci_bus 0000:01: Allocating resources
[ 1038.904194] pci_bus 0000:01: Allocating resources
[ 1038.905162] pci_bus 0000:01: Allocating resources
[ 1038.905507] pci_bus 0000:01: Allocating resources
[ 1038.907764] pci_bus 0000:01: Allocating resources
[ 1038.910716] pci_bus 0000:01: Allocating resources
[ 1038.911715] pci_bus 0000:01: Allocating resources
[ 1038.917869] pci_bus 0000:01: Allocating resources
[ 1038.918472] pci_bus 0000:01: Allocating resources
[ 1038.920974] pci_bus 0000:01: Allocating resources
[ 1038.921209] pci_bus 0000:01: Allocating resources
[ 1039.123396] pci_bus 0000:01: Allocating resources
[ 1039.227254] pci_bus 0000:01: Allocating resources
[ 1039.248795] pci_bus 0000:01: Allocating resources
[ 1039.249879] pci_bus 0000:01: Allocating resources
[ 1039.250131] pci_bus 0000:01: Allocating resources
[ 1039.250724] pci_bus 0000:01: Allocating resources
[ 1039.251671] pci_bus 0000:01: Allocating resources
[ 1039.253927] pci_bus 0000:01: Allocating resources
[ 1039.254207] pci_bus 0000:01: Allocating resources
[ 1039.254667] pci_bus 0000:01: Allocating resources
[ 1039.255837] pci_bus 0000:01: Allocating resources
[ 1039.256050] pci_bus 0000:01: Allocating resources
[ 1039.256778] pci_bus 0000:01: Allocating resources
[ 1039.256986] pci_bus 0000:01: Allocating resources
[ 1039.259735] pci_bus 0000:01: Allocating resources
[ 1039.263044] pci_bus 0000:01: Allocating resources
[ 1039.263268] pci_bus 0000:01: Allocating resources
[ 1039.263824] pci_bus 0000:01: Allocating resources
[ 1039.264035] pci_bus 0000:01: Allocating resources
[ 1039.264661] pci_bus 0000:01: Allocating resources
[ 1039.265697] pci_bus 0000:01: Allocating resources
[ 1039.267939] pci_bus 0000:01: Allocating resources
[ 1039.268203] pci_bus 0000:01: Allocating resources
[ 1039.270128] pci_bus 0000:01: Allocating resources
[ 1039.270361] pci_bus 0000:01: Allocating resources
[ 1039.270786] pci_bus 0000:01: Allocating resources
[ 1039.271653] pci_bus 0000:01: Allocating resources
[ 1039.273910] pci_bus 0000:01: Allocating resources
[ 1039.274159] pci_bus 0000:01: Allocating resources
[ 1039.274702] pci_bus 0000:01: Allocating resources
[ 1039.275662] pci_bus 0000:01: Allocating resources
[ 1039.278766] pci_bus 0000:01: Allocating resources
[ 1039.279733] pci_bus 0000:01: Allocating resources
[ 1039.280700] pci_bus 0000:01: Allocating resources
[ 1039.282741] pci_bus 0000:01: Allocating resources
[ 1039.284993] pci_bus 0000:01: Allocating resources
[ 1039.285206] pci_bus 0000:01: Allocating resources
[ 1039.285799] pci_bus 0000:01: Allocating resources
[ 1039.286005] pci_bus 0000:01: Allocating resources
[ 1039.360168] pci_bus 0000:01: Allocating resources
[ 1039.360475] pci_bus 0000:01: Allocating resources
[ 1039.361909] pci_bus 0000:01: Allocating resources
[ 1039.362028] pci_bus 0000:01: Allocating resources
[ 1039.362849] pci_bus 0000:01: Allocating resources
[ 1039.362962] pci_bus 0000:01: Allocating resources
[ 1039.363805] pci_bus 0000:01: Allocating resources
[ 1039.370693] pci_bus 0000:01: Allocating resources
[ 1039.380741] pci_bus 0000:01: Allocating resources
[ 1039.382712] pci_bus 0000:01: Allocating resources
[ 1039.384944] pci_bus 0000:01: Allocating resources
[ 1039.385082] pci_bus 0000:01: Allocating resources
[ 1039.386913] pci_bus 0000:01: Allocating resources
[ 1039.387115] pci_bus 0000:01: Allocating resources
[ 1039.387656] pci_bus 0000:01: Allocating resources
[ 1039.402713] pci_bus 0000:01: Allocating resources
[ 1039.586344] pci_bus 0000:01: Allocating resources
[ 1039.586522] pci_bus 0000:01: Allocating resources
[ 1039.586665] pci_bus 0000:01: Allocating resources
[ 1039.587892] pci_bus 0000:01: Allocating resources
[ 1039.587996] pci_bus 0000:01: Allocating resources
[ 1039.588673] pci_bus 0000:01: Allocating resources
[ 1039.634921] pci_bus 0000:01: Allocating resources
[ 1039.741394] pci_bus 0000:01: Allocating resources
[ 1039.815971] pci_bus 0000:01: Allocating resources
[ 1039.816115] pci_bus 0000:01: Allocating resources
[ 1039.816891] pci_bus 0000:01: Allocating resources
[ 1039.817005] pci_bus 0000:01: Allocating resources
[ 1039.817785] pci_bus 0000:01: Allocating resources
[ 1039.817890] pci_bus 0000:01: Allocating resources
[ 1039.821905] pci_bus 0000:01: Allocating resources
[ 1039.822027] pci_bus 0000:01: Allocating resources
[ 1039.822898] pci_bus 0000:01: Allocating resources
[ 1039.823002] pci_bus 0000:01: Allocating resources
[ 1039.823677] pci_bus 0000:01: Allocating resources
[ 1039.824729] pci_bus 0000:01: Allocating resources
[ 1039.825731] pci_bus 0000:01: Allocating resources
[ 1039.843739] pci_bus 0000:01: Allocating resources
[ 1039.867134] pci_bus 0000:01: Allocating resources
[ 1039.867382] pci_bus 0000:01: Allocating resources
[ 1039.867910] pci_bus 0000:01: Allocating resources
[ 1039.868119] pci_bus 0000:01: Allocating resources
[ 1039.879062] pci_bus 0000:01: Allocating resources
[ 1039.879899] pci_bus 0000:01: Allocating resources
[ 1039.880122] pci_bus 0000:01: Allocating resources
[ 1039.880371] pci_bus 0000:01: Allocating resources
[ 1039.886969] pci_bus 0000:01: Allocating resources
[ 1039.896777] pci_bus 0000:01: Allocating resources
[ 1039.923959] pci_bus 0000:01: Allocating resources
[ 1039.924208] pci_bus 0000:01: Allocating resources
[ 1039.924629] pci_bus 0000:01: Allocating resources
[ 1039.924863] pci_bus 0000:01: Allocating resources
[ 1039.925090] pci_bus 0000:01: Allocating resources
[ 1039.931926] pci_bus 0000:01: Allocating resources
[ 1039.932163] pci_bus 0000:01: Allocating resources
[ 1039.933079] pci_bus 0000:01: Allocating resources
[ 1039.933398] pci_bus 0000:01: Allocating resources
[ 1039.940211] pci_bus 0000:01: Allocating resources
[ 1039.940904] pci_bus 0000:01: Allocating resources
[ 1039.941156] pci_bus 0000:01: Allocating resources
[ 1039.941892] pci_bus 0000:01: Allocating resources
[ 1039.942131] pci_bus 0000:01: Allocating resources
[ 1039.954807] pci_bus 0000:01: Allocating resources
[ 1040.038018] pci_bus 0000:01: Allocating resources
[ 1040.038252] pci_bus 0000:01: Allocating resources
[ 1040.151815] pci_bus 0000:01: Allocating resources
[ 1040.152874] pci_bus 0000:01: Allocating resources
[ 1040.154778] pci_bus 0000:01: Allocating resources
[ 1040.266324] pci_bus 0000:01: Allocating resources
[ 1040.266839] pci_bus 0000:01: Allocating resources
[ 1040.267092] pci_bus 0000:01: Allocating resources
[ 1040.267341] pci_bus 0000:01: Allocating resources
[ 1040.267960] pci_bus 0000:01: Allocating resources
[ 1040.268190] pci_bus 0000:01: Allocating resources
[ 1040.268407] pci_bus 0000:01: Allocating resources
[ 1040.269098] pci_bus 0000:01: Allocating resources
[ 1040.382014] pci_bus 0000:01: Allocating resources
[ 1040.382175] pci_bus 0000:01: Allocating resources
[ 1040.382991] pci_bus 0000:01: Allocating resources
[ 1040.383125] pci_bus 0000:01: Allocating resources
[ 1040.383844] pci_bus 0000:01: Allocating resources
[ 1040.383979] pci_bus 0000:01: Allocating resources
[ 1040.394810] pci_bus 0000:01: Allocating resources
[ 1040.497094] pci_bus 0000:01: Allocating resources
[ 1040.497356] pci_bus 0000:01: Allocating resources
[ 1040.497833] pci_bus 0000:01: Allocating resources
[ 1040.498935] pci_bus 0000:01: Allocating resources
[ 1040.499151] pci_bus 0000:01: Allocating resources
[ 1040.504751] pci_bus 0000:01: Allocating resources
[ 1040.506016] pci_bus 0000:01: Allocating resources
[ 1040.506351] pci_bus 0000:01: Allocating resources
[ 1040.507875] pci_bus 0000:01: Allocating resources
[ 1040.508088] pci_bus 0000:01: Allocating resources
[ 1040.508701] pci_bus 0000:01: Allocating resources
[ 1040.510725] pci_bus 0000:01: Allocating resources
[ 1040.512994] pci_bus 0000:01: Allocating resources
[ 1040.513245] pci_bus 0000:01: Allocating resources
[ 1040.526333] pci_bus 0000:01: Allocating resources
[ 1040.609985] pci_bus 0000:01: Allocating resources
[ 1040.836433] pci_bus 0000:01: Allocating resources
[ 1040.837028] pci_bus 0000:01: Allocating resources
[ 1040.837240] pci_bus 0000:01: Allocating resources
[ 1040.837446] pci_bus 0000:01: Allocating resources
[ 1040.837677] pci_bus 0000:01: Allocating resources
[ 1040.893728] pci_bus 0000:01: Allocating resources
[ 1040.894027] pci_bus 0000:01: Allocating resources
[ 1040.894297] pci_bus 0000:01: Allocating resources
[ 1040.895076] pci_bus 0000:01: Allocating resources
[ 1040.895404] pci_bus 0000:01: Allocating resources
[ 1040.897777] pci_bus 0000:01: Allocating resources
[ 1040.898529] pci_bus 0000:01: Allocating resources
[ 1040.898812] pci_bus 0000:01: Allocating resources
[ 1040.917092] pci_bus 0000:01: Allocating resources
[ 1040.917370] pci_bus 0000:01: Allocating resources
[ 1040.920904] pci_bus 0000:01: Allocating resources
[ 1040.921121] pci_bus 0000:01: Allocating resources
[ 1040.922903] pci_bus 0000:01: Allocating resources
[ 1040.923117] pci_bus 0000:01: Allocating resources
[ 1040.928815] pci_bus 0000:01: Allocating resources
[ 1040.930196] pci_bus 0000:01: Allocating resources
[ 1040.930422] pci_bus 0000:01: Allocating resources
[ 1040.930822] pci_bus 0000:01: Allocating resources
[ 1040.932779] pci_bus 0000:01: Allocating resources
[ 1040.935613] pci_bus 0000:01: Allocating resources
[ 1040.935841] pci_bus 0000:01: Allocating resources
[ 1040.950854] pci_bus 0000:01: Allocating resources
[ 1040.952070] pci_bus 0000:01: Allocating resources
[ 1040.958943] pci_bus 0000:01: Allocating resources
[ 1040.959227] pci_bus 0000:01: Allocating resources
[ 1040.960297] pci_bus 0000:01: Allocating resources
[ 1040.960401] pci_bus 0000:01: Allocating resources
[ 1040.960513] pci_bus 0000:01: Allocating resources
[ 1040.960624] pci_bus 0000:01: Allocating resources
[ 1040.960727] pci_bus 0000:01: Allocating resources
[ 1040.960829] pci_bus 0000:01: Allocating resources
[ 1041.026317] pci_bus 0000:01: Allocating resources
[ 1041.026947] pci_bus 0000:01: Allocating resources
[ 1041.066106] pci_bus 0000:01: Allocating resources
[ 1041.066283] pci_bus 0000:01: Allocating resources
[ 1041.076928] pci_bus 0000:01: Allocating resources
[ 1041.176855] pci_bus 0000:01: Allocating resources
[ 1041.290872] pci_bus 0000:01: Allocating resources
[ 1041.520046] pci_bus 0000:01: Allocating resources
[ 1041.670548] pci_bus 0000:01: Allocating resources
[ 1041.670828] pci_bus 0000:01: Allocating resources
[ 1041.671074] pci_bus 0000:01: Allocating resources
[ 1041.684137] pci_bus 0000:01: Allocating resources
[ 1041.684417] pci_bus 0000:01: Allocating resources
[ 1041.743183] pci_bus 0000:01: Allocating resources
[ 1041.743466] pci_bus 0000:01: Allocating resources
[ 1041.743844] pci_bus 0000:01: Allocating resources
[ 1041.936932] pci_bus 0000:01: Allocating resources
[ 1041.937887] pci_bus 0000:01: Allocating resources
[ 1041.938847] pci_bus 0000:01: Allocating resources
[ 1041.944025] pci_bus 0000:01: Allocating resources
[ 1041.944279] pci_bus 0000:01: Allocating resources
[ 1041.944967] pci_bus 0000:01: Allocating resources
[ 1041.945188] pci_bus 0000:01: Allocating resources
[ 1041.975055] pci_bus 0000:01: Allocating resources
[ 1041.975308] pci_bus 0000:01: Allocating resources
[ 1041.975999] pci_bus 0000:01: Allocating resources
[ 1041.976223] pci_bus 0000:01: Allocating resources
[ 1041.981068] pci_bus 0000:01: Allocating resources
[ 1041.981306] pci_bus 0000:01: Allocating resources
[ 1041.982806] pci_bus 0000:01: Allocating resources
[ 1041.983792] pci_bus 0000:01: Allocating resources
[ 1041.986822] pci_bus 0000:01: Allocating resources
[ 1041.988215] pci_bus 0000:01: Allocating resources
[ 1041.988353] pci_bus 0000:01: Allocating resources
[ 1041.988479] pci_bus 0000:01: Allocating resources
[ 1041.991306] pci_bus 0000:01: Allocating resources
[ 1041.991583] pci_bus 0000:01: Allocating resources
[ 1041.991734] pci_bus 0000:01: Allocating resources
[ 1041.991873] pci_bus 0000:01: Allocating resources
[ 1041.991982] pci_bus 0000:01: Allocating resources
[ 1042.009808] pci_bus 0000:01: Allocating resources
[ 1042.439552] pci_bus 0000:01: Allocating resources
[ 1042.439879] pci_bus 0000:01: Allocating resources
[ 1042.440149] pci_bus 0000:01: Allocating resources
[ 1042.440276] pci_bus 0000:01: Allocating resources
[ 1042.440415] pci_bus 0000:01: Allocating resources
[ 1042.440555] pci_bus 0000:01: Allocating resources
[ 1042.440690] pci_bus 0000:01: Allocating resources
[ 1042.440812] pci_bus 0000:01: Allocating resources
[ 1042.450092] pci_bus 0000:01: Allocating resources
[ 1042.543486] pci_bus 0000:01: Allocating resources
[ 1042.543769] pci_bus 0000:01: Allocating resources
[ 1042.660098] pci_bus 0000:01: Allocating resources
[ 1042.660236] pci_bus 0000:01: Allocating resources
[ 1042.781078] pci_bus 0000:01: Allocating resources
[ 1042.781347] pci_bus 0000:01: Allocating resources
[ 1042.789055] pci_bus 0000:01: Allocating resources
[ 1042.789292] pci_bus 0000:01: Allocating resources
[ 1042.898066] pci_bus 0000:01: Allocating resources
[ 1042.964313] pci_bus 0000:01: Allocating resources
[ 1042.964575] pci_bus 0000:01: Allocating resources
[ 1042.971341] pci_bus 0000:01: Allocating resources
[ 1042.971599] pci_bus 0000:01: Allocating resources
[ 1042.971891] pci_bus 0000:01: Allocating resources
[ 1042.980170] pci_bus 0000:01: Allocating resources
[ 1042.980421] pci_bus 0000:01: Allocating resources
[ 1042.981474] pci_bus 0000:01: Allocating resources
[ 1042.981819] pci_bus 0000:01: Allocating resources
[ 1042.987312] pci_bus 0000:01: Allocating resources
[ 1042.987664] pci_bus 0000:01: Allocating resources
[ 1043.004962] pci_bus 0000:01: Allocating resources
[ 1043.005929] pci_bus 0000:01: Allocating resources
[ 1043.012952] pci_bus 0000:01: Allocating resources
[ 1043.014855] pci_bus 0000:01: Allocating resources
[ 1043.023907] pci_bus 0000:01: Allocating resources
[ 1043.817019] pci_bus 0000:01: Allocating resources
[ 1043.919028] pci_bus 0000:01: Allocating resources
[ 1043.927977] pci_bus 0000:01: Allocating resources
[ 1043.978790] pci_bus 0000:01: Allocating resources
[ 1043.979160] pci_bus 0000:01: Allocating resources
[ 1044.000425] pci_bus 0000:01: Allocating resources
[ 1044.000797] pci_bus 0000:01: Allocating resources
[ 1044.012076] pci_bus 0000:01: Allocating resources
[ 1044.018035] pci_bus 0000:01: Allocating resources
[ 1044.019092] pci_bus 0000:01: Allocating resources
[ 1044.019331] pci_bus 0000:01: Allocating resources
[ 1044.020007] pci_bus 0000:01: Allocating resources
[ 1044.020217] pci_bus 0000:01: Allocating resources
[ 1044.028006] pci_bus 0000:01: Allocating resources
[ 1044.063625] pci_bus 0000:01: Allocating resources
[ 1044.144062] pci_bus 0000:01: Allocating resources
[ 1044.145008] pci_bus 0000:01: Allocating resources
[ 1044.146926] pci_bus 0000:01: Allocating resources
[ 1044.148965] pci_bus 0000:01: Allocating resources
[ 1044.309432] pci_bus 0000:01: Allocating resources
[ 1044.329014] pci_bus 0000:01: Allocating resources
[ 1044.368263] pci_bus 0000:01: Allocating resources
[ 1044.368508] pci_bus 0000:01: Allocating resources
[ 1044.493314] pci_bus 0000:01: Allocating resources
[ 1044.594731] pci_bus 0000:01: Allocating resources
[ 1044.595088] pci_bus 0000:01: Allocating resources
[ 1044.596622] pci_bus 0000:01: Allocating resources
[ 1044.596883] pci_bus 0000:01: Allocating resources
[ 1044.597094] pci_bus 0000:01: Allocating resources
[ 1044.597304] pci_bus 0000:01: Allocating resources
[ 1044.602129] pci_bus 0000:01: Allocating resources
[ 1044.602371] pci_bus 0000:01: Allocating resources
[ 1044.609181] pci_bus 0000:01: Allocating resources
[ 1044.609424] pci_bus 0000:01: Allocating resources
[ 1044.726700] pci_bus 0000:01: Allocating resources
[ 1044.761725] pci_bus 0000:01: Allocating resources
[ 1044.762019] pci_bus 0000:01: Allocating resources
[ 1044.770999] pci_bus 0000:01: Allocating resources
[ 1044.831220] pci_bus 0000:01: Allocating resources
[ 1044.831471] pci_bus 0000:01: Allocating resources
[ 1044.832226] pci_bus 0000:01: Allocating resources
[ 1044.832464] pci_bus 0000:01: Allocating resources
[ 1044.835097] pci_bus 0000:01: Allocating resources
[ 1044.835313] pci_bus 0000:01: Allocating resources
[ 1044.862213] pci_bus 0000:01: Allocating resources
[ 1044.862337] pci_bus 0000:01: Allocating resources
[ 1044.862452] pci_bus 0000:01: Allocating resources
[ 1044.866114] pci_bus 0000:01: Allocating resources
[ 1044.866246] pci_bus 0000:01: Allocating resources
[ 1044.867410] pci_bus 0000:01: Allocating resources
[ 1044.867639] pci_bus 0000:01: Allocating resources
[ 1045.117644] pci_bus 0000:01: Allocating resources
[ 1045.117811] pci_bus 0000:01: Allocating resources
[ 1045.161175] pci_bus 0000:01: Allocating resources
[ 1045.161347] pci_bus 0000:01: Allocating resources
[ 1045.179099] pci_bus 0000:01: Allocating resources
[ 1045.181995] pci_bus 0000:01: Allocating resources
[ 1045.183959] pci_bus 0000:01: Allocating resources
[ 1045.190183] pci_bus 0000:01: Allocating resources
[ 1045.190419] pci_bus 0000:01: Allocating resources
[ 1045.196385] pci_bus 0000:01: Allocating resources
[ 1045.196534] pci_bus 0000:01: Allocating resources
[ 1045.196767] pci_bus 0000:01: Allocating resources
[ 1045.198120] pci_bus 0000:01: Allocating resources
[ 1045.198240] pci_bus 0000:01: Allocating resources
[ 1045.229954] pci_bus 0000:01: Allocating resources
[ 1045.393590] pci_bus 0000:01: Allocating resources
[ 1045.410302] pci_bus 0000:01: Allocating resources
[ 1045.410603] pci_bus 0000:01: Allocating resources
[ 1045.411062] pci_bus 0000:01: Allocating resources
[ 1045.411795] pci_bus 0000:01: Allocating resources
[ 1045.414009] pci_bus 0000:01: Allocating resources
[ 1045.416117] pci_bus 0000:01: Allocating resources
[ 1045.416590] pci_bus 0000:01: Allocating resources
[ 1045.417957] pci_bus 0000:01: Allocating resources
[ 1045.424319] pci_bus 0000:01: Allocating resources
[ 1045.424556] pci_bus 0000:01: Allocating resources
[ 1045.542105] pci_bus 0000:01: Allocating resources
[ 1045.543699] pci_bus 0000:01: Allocating resources
[ 1045.543959] pci_bus 0000:01: Allocating resources
[ 1045.561373] pci_bus 0000:01: Allocating resources
[ 1045.561552] pci_bus 0000:01: Allocating resources
[ 1045.562094] pci_bus 0000:01: Allocating resources
[ 1045.562238] pci_bus 0000:01: Allocating resources
[ 1045.622939] pci_bus 0000:01: Allocating resources
[ 1045.623212] pci_bus 0000:01: Allocating resources
[ 1045.623439] pci_bus 0000:01: Allocating resources
[ 1045.638396] pci_bus 0000:01: Allocating resources
[ 1045.638779] pci_bus 0000:01: Allocating resources
[ 1045.641150] pci_bus 0000:01: Allocating resources
[ 1045.641481] pci_bus 0000:01: Allocating resources
[ 1045.660049] pci_bus 0000:01: Allocating resources
[ 1045.660974] pci_bus 0000:01: Allocating resources
[ 1045.661112] pci_bus 0000:01: Allocating resources
[ 1045.661235] pci_bus 0000:01: Allocating resources
[ 1045.661358] pci_bus 0000:01: Allocating resources
[ 1045.661522] pci_bus 0000:01: Allocating resources
[ 1045.661672] pci_bus 0000:01: Allocating resources
[ 1045.661819] pci_bus 0000:01: Allocating resources
[ 1045.667248] pci_bus 0000:01: Allocating resources
[ 1045.667385] pci_bus 0000:01: Allocating resources
[ 1045.668118] pci_bus 0000:01: Allocating resources
[ 1045.668226] pci_bus 0000:01: Allocating resources
[ 1045.669118] pci_bus 0000:01: Allocating resources
[ 1045.669225] pci_bus 0000:01: Allocating resources
[ 1045.675020] pci_bus 0000:01: Allocating resources
[ 1045.677218] pci_bus 0000:01: Allocating resources
[ 1045.677350] pci_bus 0000:01: Allocating resources
[ 1045.677462] pci_bus 0000:01: Allocating resources
[ 1045.677986] pci_bus 0000:01: Allocating resources
[ 1045.689202] pci_bus 0000:01: Allocating resources
[ 1045.689352] pci_bus 0000:01: Allocating resources
[ 1045.690111] pci_bus 0000:01: Allocating resources
[ 1045.690252] pci_bus 0000:01: Allocating resources
[ 1045.696053] pci_bus 0000:01: Allocating resources
[ 1045.712019] pci_bus 0000:01: Allocating resources
[ 1045.712188] pci_bus 0000:01: Allocating resources
[ 1045.712317] pci_bus 0000:01: Allocating resources
[ 1045.712902] pci_bus 0000:01: Allocating resources
[ 1045.713533] pci_bus 0000:01: Allocating resources
[ 1045.713728] pci_bus 0000:01: Allocating resources
[ 1045.713939] pci_bus 0000:01: Allocating resources
[ 1045.714139] pci_bus 0000:01: Allocating resources
[ 1045.714302] pci_bus 0000:01: Allocating resources
[ 1045.763514] pci_bus 0000:01: Allocating resources
[ 1045.763820] pci_bus 0000:01: Allocating resources
[ 1045.764032] pci_bus 0000:01: Allocating resources
[ 1045.770185] pci_bus 0000:01: Allocating resources
[ 1045.770502] pci_bus 0000:01: Allocating resources
[ 1045.777613] pci_bus 0000:01: Allocating resources
[ 1045.778360] pci_bus 0000:01: Allocating resources
[ 1045.778603] pci_bus 0000:01: Allocating resources
[ 1045.778850] pci_bus 0000:01: Allocating resources
[ 1045.779086] pci_bus 0000:01: Allocating resources
[ 1045.779323] pci_bus 0000:01: Allocating resources
[ 1045.779557] pci_bus 0000:01: Allocating resources
[ 1045.844440] pci_bus 0000:01: Allocating resources
[ 1045.844590] pci_bus 0000:01: Allocating resources
[ 1045.844713] pci_bus 0000:01: Allocating resources
[ 1045.844821] pci_bus 0000:01: Allocating resources
[ 1045.844944] pci_bus 0000:01: Allocating resources
[ 1045.845091] pci_bus 0000:01: Allocating resources
[ 1045.866357] pci_bus 0000:01: Allocating resources
[ 1045.866595] pci_bus 0000:01: Allocating resources
[ 1045.873160] pci_bus 0000:01: Allocating resources
[ 1045.873276] pci_bus 0000:01: Allocating resources
[ 1045.894927] pci_bus 0000:01: Allocating resources
[ 1045.895063] pci_bus 0000:01: Allocating resources
[ 1045.895193] pci_bus 0000:01: Allocating resources
[ 1045.895345] pci_bus 0000:01: Allocating resources
[ 1045.896378] pci_bus 0000:01: Allocating resources
[ 1045.896523] pci_bus 0000:01: Allocating resources
[ 1045.896651] pci_bus 0000:01: Allocating resources
[ 1045.911186] pci_bus 0000:01: Allocating resources
[ 1045.911346] pci_bus 0000:01: Allocating resources
[ 1045.911494] pci_bus 0000:01: Allocating resources
[ 1045.911640] pci_bus 0000:01: Allocating resources
[ 1045.911801] pci_bus 0000:01: Allocating resources
[ 1045.911951] pci_bus 0000:01: Allocating resources
[ 1045.912101] pci_bus 0000:01: Allocating resources
[ 1045.912244] pci_bus 0000:01: Allocating resources
[ 1045.912346] pci_bus 0000:01: Allocating resources
[ 1046.027245] pci_bus 0000:01: Allocating resources
[ 1046.027384] pci_bus 0000:01: Allocating resources
[ 1046.027492] pci_bus 0000:01: Allocating resources
[ 1046.027595] pci_bus 0000:01: Allocating resources
[ 1046.028356] pci_bus 0000:01: Allocating resources
[ 1046.028482] pci_bus 0000:01: Allocating resources
[ 1046.071164] pci_bus 0000:01: Allocating resources
[ 1046.071281] pci_bus 0000:01: Allocating resources
[ 1046.071975] pci_bus 0000:01: Allocating resources
[ 1046.094203] pci_bus 0000:01: Allocating resources
[ 1046.094350] pci_bus 0000:01: Allocating resources
[ 1046.094474] pci_bus 0000:01: Allocating resources
[ 1046.094596] pci_bus 0000:01: Allocating resources
[ 1046.094729] pci_bus 0000:01: Allocating resources
[ 1046.094856] pci_bus 0000:01: Allocating resources

------=_Part_73476_1350743247.1704281003907--

