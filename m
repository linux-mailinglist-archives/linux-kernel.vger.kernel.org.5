Return-Path: <linux-kernel+bounces-67849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0D8571CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F71F245A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE15145B17;
	Thu, 15 Feb 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="IVNBI7KW"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA453362
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040811; cv=none; b=N5r3tOG/sb9sohnr9T+D1eN3YSCvhyqf9/5qqh31xOxeYnfP74eu/0RD9oS4c3+s3rX37l77ykCnzMXVEu4u/X5KVcGI3VVdao/lP+8wkBwXru9KrHbPRMRyhQYkTaJdJkY8WfUj4NJHy2fs/0h6ZwllakNhMsZqsZipQ9HxFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040811; c=relaxed/simple;
	bh=P6+lmQxvl8w7R/6o/wn366nD62c6jpHcX1VYmkT9w58=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JZRKtxH0c61gwdLKVStSlWjKVdEzzfEBd22SakfGMB+3vWR5GrygrtCAmxx8F1rUkGVCh38EJ3nQnWyfq1acV60zVD8u7AuNlqZ08WMpgYD9gzDNBpgCIR10P2kzPiTqUSmBKgAuoqByNmLoXrGY0IkkHMPu8t8iOG7tyRyEB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=IVNBI7KW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-296dc0cab6aso1107493a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1708040806; x=1708645606; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYfVWtTqTCHr5KhFhw4IyifBEW2WCQHIvrnWi5uJANg=;
        b=IVNBI7KWIgvwPcNGHAq7KsLJOfYRaQP6Xpf8CFCWXfH45XQkxWTHUy0pG6N0kMDZiZ
         aEvg+EEvX8+f41PGEfFyiWXlgPc0ApN4I3XFCLsgYDwyc9UBWuzFlbVSFgaxoeM66NwE
         tOvkqkGxS3yaYQzkE8F5p7sKnG8lBJhSgierI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040806; x=1708645606;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYfVWtTqTCHr5KhFhw4IyifBEW2WCQHIvrnWi5uJANg=;
        b=smfl/L2FoOOSlaNDqHUcEnfWFw9CadYHMczk4z1wm9ASNcy6DMzt53PtmPJYBtHV2t
         HXvg8n7jPDJ4PD+67Um3fqxqp/O6d+UWwMn6Da1JDfiQH9/3irRaOvI9o3XffOJSvrcf
         W4bwx6RYICOo4MCvaaGus/wEgPGIuXEWIkwc4UXVtf4UWN+NH9R+6hwCUqP0H99kIU8B
         HEaqefV20dRWhUQrrsgazDlxGYs/EQWRaGazpVnlixF5q+fcgXqFdZA8pZm4IAG06PvC
         RFvhRrMYXExiVw5aqxBJZ60MSL8DDayahfTAS7mw4YuQRGgmC4+MhYLTqby8yXQuKb8E
         2Nlg==
X-Gm-Message-State: AOJu0YwoPHXuA39Vv9HmAvNRxNQ9mVNZwZAZspYRVKUewPMJk9UyprXa
	c0JMcOXlB2hI+r44nv/E1IyLgJxGPEE94Ouosmm8Tt8nuMH13AMGbRtfkcu6+iteFgJANqUt/LE
	x62Iepkf+wqaFYKsq2y1U8HPzApBt36M+gSqK5LLr+8TyF3DpedM=
X-Google-Smtp-Source: AGHT+IHgKsycKWfvHDMwJGoM29/MbGcWB2owjGBG2SB1sqq8VRAY6fX5Ta0YWh6fdwnGwWvF7y4mvXUk06tr0dCaXgI=
X-Received: by 2002:a17:90b:305:b0:299:1802:4c54 with SMTP id
 ay5-20020a17090b030500b0029918024c54mr3299309pjb.16.1708040804680; Thu, 15
 Feb 2024 15:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Thu, 15 Feb 2024 18:46:33 -0500
Message-ID: <CAO9zADyveGGBNKsD-JFoOeGZ3om3wMhkqvPc2mvxp-yBzk5mrg@mail.gmail.com>
Subject: Linux FS6712X-EB92 5.13.x - page allocation failure followed by a
 controller reset and the drive drops out of the array
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I am using an Asus FlashStor FS6712X-EB92, and was curious why this
issue keeps happening?  Is this a known issue in 5.13.x?  The last
time this happened, I had removed the drive, ran a bunch of
diagnostics on it and used it in another system and it was okay, no
errors were found.  This is the second instance where there is a page
allocation failure and a drive drops out of the array.


[1698614.263935] SLUB: Unable to allocate memory on node -1,
gfp=0x800(GFP_NOWAIT)
[1698614.271680]   cache: skbuff_head_cache, object size: 224, buffer
size: 256, default order: 0, min order: 0
[1698614.281979]   node 0: slabs: 32, objs: 512, free: 64
[1933116.236646] nvme nvme9: I/O 119 QID 2 timeout, aborting
[1933116.242365] nvme nvme9: I/O 120 QID 2 timeout, aborting
[1933141.324640] nvme nvme9: I/O 1 QID 0 timeout, reset controller
[1933146.444701] nvme nvme9: I/O 119 QID 2 timeout, reset controller
[1933215.826997] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933215.839856] nvme nvme9: Abort status: 0x371
[1933215.844475] nvme nvme9: Abort status: 0x371
[1933226.357672] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933226.364390] nvme nvme9: Removing after probe failure status: -19
[1933236.879570] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933236.886392] nvme9n1: detected capacity change from 7814037168 to 0
[1933236.886392] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
[1933236.886392] md/raid1:md0: Operation continuing on 11 devices.
[1933236.886395] md/raid1:md0: nvme9n1p2: rescheduling sector 3912
[1933236.887190] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
[1933236.887193] md/raid:md1: Operation continuing on 11 devices.
[1933236.890001] md: remove_and_add_spares bdev /dev/nvme9n1p2 exist
[1933236.890377] md: remove_and_add_spares bdev /dev/nvme9n1p4 exist
[1933236.893420] asustor remove disk dev nvme9n1
[1933236.912814] md/raid1:md0: redirecting sector 3912 to other
mirror: nvme7n1p2
[1933236.936634] md: remove_and_add_spares bdev /dev/nvme9n1p4 exist
[1933236.936643] md: remove_and_add_spares rdev nvme9n1p4 remove sucess
[1933236.938640] md: remove_and_add_spares bdev /dev/nvme9n1p2 exist
[1933236.938655] md: remove_and_add_spares rdev nvme9n1p2 remove sucess

Full dmesg:

[    0.000000] Linux version 5.13.x (root@sw1-dailybuild)
(x86_64-asustor_x64_g3_2020.12.24-linux-gnu-gcc (crosstool-NG 1.24.0)
7.4.0, GNU ld (crosstool-NG 1.24.0) 2.32) #1 SMP Fri Nov 3 00:15:07
CST 2023
[    0.000000] Command line: BOOT_IMAGE=(hd12,gpt2)/bzImage
console=ttyS0,115200n8 bootpart=2
uuid=e15419aa-e366-4e44-a305-863db786e456
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   zhaoxin   Shanghai
[    0.000000] x86/split lock detection: #AC: crashing the kernel on
kernel split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is
576 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000070a17fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070a18000-0x0000000070b17fff] type 20
[    0.000000] BIOS-e820: [mem 0x0000000070b18000-0x0000000075cc6fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000075cc7000-0x000000007697efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007697f000-0x0000000076bfefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000076bff000-0x0000000076bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076c00000-0x000000007fbfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004803fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by Phoenix Technologies Ltd.
[    0.000000] efi: ACPI=0x76bfe000 ACPI 2.0=0x76bfe014
TPMFinalLog=0x76815000 SMBIOS=0x72b77000 SMBIOS 3.0=0x72b6a000
MEMATTR=0x6e187018 ESRT=0x6e508018
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: Intel Corporation Jasper Lake Client
Platform/0123456789ABCDEF0123456789ABCDEF, BIOS V1.20 11/04/2022
[    0.000000] tsc: Detected 2000.000 MHz processor
[    0.000000] tsc: Detected 1996.800 MHz TSC
[    0.000010] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000014] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000019] last_pfn = 0x480400 max_arch_pfn = 0x400000000
[    0.000059] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000390] last_pfn = 0x76c00 max_arch_pfn = 0x400000000
[    0.004098] esrt: Reserving ESRT space from 0x000000006e508018 to
0x000000006e508190.
[    0.004104] e820: update [mem 0x6e508000-0x6e508fff] usable ==> reserved
[    0.004632] Secure boot could not be determined
[    0.004634] RAMDISK: [mem 0x35ff3000-0x36ff0fff]
[    0.004637] ACPI: Early table checksum verification disabled
[    0.004640] ACPI: RSDP 0x0000000076BFE014 000024 (v02 PTEC  )
[    0.004644] ACPI: XSDT 0x0000000076BFC188 0000EC (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004650] ACPI: FACP 0x0000000072B5D000 000114 (v06 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004656] ACPI: DSDT 0x0000000072B13000 045810 (v02 PTEC   ICL
  00000002      01000013)
[    0.004660] ACPI: FACS 0x00000000767F7000 000040
[    0.004663] ACPI: SSDT 0x0000000072BDD000 0025EE (v02 PTEC
CpuSsdt  00003000 INTL 20191018)
[    0.004667] ACPI: SSDT 0x0000000072B79000 00060E (v02 PTEC
Tpm2Tabl 00001000 INTL 20191018)
[    0.004671] ACPI: TPM2 0x0000000072B78000 00004C (v04 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004675] ACPI: HPET 0x0000000072B5C000 000038 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004678] ACPI: APIC 0x0000000072B5B000 00012C (v05 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004681] ACPI: MCFG 0x0000000072B5A000 00003C (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004685] ACPI: PRAM 0x0000000072B59000 000030 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004688] ACPI: SSDT 0x0000000072B12000 000EF4 (v02 PTEC
Ther_Rvp 00001000 INTL 20191018)
[    0.004692] ACPI: NHLT 0x0000000072B11000 00002D (v00 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004695] ACPI: SSDT 0x0000000072B0E000 001D29 (v02 PTEC   SaSsdt
  00003000 INTL 20191018)
[    0.004698] ACPI: SSDT 0x0000000072B0A000 0032CD (v02 PTEC
IgfxSsdt 00003000 INTL 20191018)
[    0.004702] ACPI: SSDT 0x0000000072B09000 00014C (v02 PTEC
IpuSsdt  00001000 INTL 20191018)
[    0.004705] ACPI: LPIT 0x0000000072B07000 000094 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004708] ACPI: WSMT 0x0000000072B06000 000028 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004712] ACPI: SSDT 0x0000000072B03000 002720 (v02 PTEC
PtidDevc 00001000 INTL 20191018)
[    0.004715] ACPI: SSDT 0x0000000072B02000 000122 (v02 PTEC
TbtTypeC 00000000 INTL 20191018)
[    0.004719] ACPI: DBGP 0x0000000072B01000 000034 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004722] ACPI: DBG2 0x0000000072B00000 000054 (v00 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004725] ACPI: POAT 0x0000000072AFF000 000055 (v03 PTEC
OEMTABLE 00000000 PTEC 00000002)
[    0.004728] ACPI: BATB 0x0000000072ADB000 00004A (v02 PTEC
OEMTABLE 00000000 PTEC 00000002)
[    0.004732] ACPI: DMAR 0x00000000711D9000 0000A0 (v02 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004735] ACPI: SSDT 0x00000000711D8000 000144 (v02 PTEC
ADebTabl 00001000 INTL 20191018)
[    0.004738] ACPI: UEFI 0x0000000075F52000 000076 (v01 PTEC
OEMTABLE 00000001 PTEC 00000002)
[    0.004742] ACPI: FPDT 0x00000000711D7000 000034 (v01 PTEC
OEMTABLE 00000002 PTEC 00000002)
[    0.004744] ACPI: Reserving FACP table memory at [mem 0x72b5d000-0x72b5d113]
[    0.004747] ACPI: Reserving DSDT table memory at [mem 0x72b13000-0x72b5880f]
[    0.004749] ACPI: Reserving FACS table memory at [mem 0x767f7000-0x767f703f]
[    0.004750] ACPI: Reserving SSDT table memory at [mem 0x72bdd000-0x72bdf5ed]
[    0.004752] ACPI: Reserving SSDT table memory at [mem 0x72b79000-0x72b7960d]
[    0.004754] ACPI: Reserving TPM2 table memory at [mem 0x72b78000-0x72b7804b]
[    0.004755] ACPI: Reserving HPET table memory at [mem 0x72b5c000-0x72b5c037]
[    0.004757] ACPI: Reserving APIC table memory at [mem 0x72b5b000-0x72b5b12b]
[    0.004758] ACPI: Reserving MCFG table memory at [mem 0x72b5a000-0x72b5a03b]
[    0.004760] ACPI: Reserving PRAM table memory at [mem 0x72b59000-0x72b5902f]
[    0.004761] ACPI: Reserving SSDT table memory at [mem 0x72b12000-0x72b12ef3]
[    0.004763] ACPI: Reserving NHLT table memory at [mem 0x72b11000-0x72b1102c]
[    0.004764] ACPI: Reserving SSDT table memory at [mem 0x72b0e000-0x72b0fd28]
[    0.004766] ACPI: Reserving SSDT table memory at [mem 0x72b0a000-0x72b0d2cc]
[    0.004767] ACPI: Reserving SSDT table memory at [mem 0x72b09000-0x72b0914b]
[    0.004769] ACPI: Reserving LPIT table memory at [mem 0x72b07000-0x72b07093]
[    0.004770] ACPI: Reserving WSMT table memory at [mem 0x72b06000-0x72b06027]
[    0.004772] ACPI: Reserving SSDT table memory at [mem 0x72b03000-0x72b0571f]
[    0.004773] ACPI: Reserving SSDT table memory at [mem 0x72b02000-0x72b02121]
[    0.004775] ACPI: Reserving DBGP table memory at [mem 0x72b01000-0x72b01033]
[    0.004776] ACPI: Reserving DBG2 table memory at [mem 0x72b00000-0x72b00053]
[    0.004778] ACPI: Reserving POAT table memory at [mem 0x72aff000-0x72aff054]
[    0.004779] ACPI: Reserving BATB table memory at [mem 0x72adb000-0x72adb049]
[    0.004781] ACPI: Reserving DMAR table memory at [mem 0x711d9000-0x711d909f]
[    0.004783] ACPI: Reserving SSDT table memory at [mem 0x711d8000-0x711d8143]
[    0.004784] ACPI: Reserving UEFI table memory at [mem 0x75f52000-0x75f52075]
[    0.004786] ACPI: Reserving FPDT table memory at [mem 0x711d7000-0x711d7033]
[    0.004800] ACPI: Local APIC address 0xfee00000
[    0.004855] No NUMA configuration found
[    0.004857] Faking a node at [mem 0x0000000000000000-0x00000004803fffff]
[    0.004861] NODE_DATA(0) allocated [mem 0x4803ed000-0x4803f0fff]
[    0.004887] Zone ranges:
[    0.004888]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.004890]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.004892]   Normal   [mem 0x0000000100000000-0x00000004803fffff]
[    0.004894] Movable zone start for each node
[    0.004896] Early memory node ranges
[    0.004897]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.004899]   node   0: [mem 0x0000000000100000-0x0000000070a17fff]
[    0.004901]   node   0: [mem 0x0000000076bff000-0x0000000076bfffff]
[    0.004902]   node   0: [mem 0x0000000100000000-0x00000004803fffff]
[    0.004905] Initmem setup node 0 [mem 0x0000000000001000-0x00000004803fffff]
[    0.004907] On node 0 totalpages: 4132279
[    0.004909]   DMA zone: 64 pages used for memmap
[    0.004910]   DMA zone: 158 pages reserved
[    0.004911]   DMA zone: 3998 pages, LIFO batch:0
[    0.004912]   DMA32 zone: 7145 pages used for memmap
[    0.004913]   DMA32 zone: 457241 pages, LIFO batch:63
[    0.004915]   Normal zone: 57360 pages used for memmap
[    0.004916]   Normal zone: 3671040 pages, LIFO batch:63
[    0.004919] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.004948] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.008489] On node 0, zone DMA32: 25063 pages in unavailable ranges
[    0.035054] On node 0, zone Normal: 5120 pages in unavailable ranges
[    0.035338] On node 0, zone Normal: 31744 pages in unavailable ranges
[    0.035361] Reserving Intel graphics memory at [mem 0x7c000000-0x7fbfffff]
[    0.035579] ACPI: PM-Timer IO Port: 0x1808
[    0.035581] ACPI: Local APIC address 0xfee00000
[    0.035587] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.035589] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.035591] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.035592] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.035594] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.035595] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.035596] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.035597] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.035599] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.035600] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.035601] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.035603] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.035604] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.035605] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.035606] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.035608] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.035642] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.035645] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.035648] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.035650] ACPI: IRQ0 used by override.
[    0.035652] ACPI: IRQ9 used by override.
[    0.035654] Using ACPI (MADT) for SMP configuration information
[    0.035657] TSC deadline timer available
[    0.035658] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.035674] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.035677] PM: hibernation: Registered nosave memory: [mem
0x0009f000-0x000fffff]
[    0.035679] PM: hibernation: Registered nosave memory: [mem
0x6e508000-0x6e508fff]
[    0.035682] PM: hibernation: Registered nosave memory: [mem
0x70a18000-0x70b17fff]
[    0.035683] PM: hibernation: Registered nosave memory: [mem
0x70b18000-0x75cc6fff]
[    0.035684] PM: hibernation: Registered nosave memory: [mem
0x75cc7000-0x7697efff]
[    0.035686] PM: hibernation: Registered nosave memory: [mem
0x7697f000-0x76bfefff]
[    0.035688] PM: hibernation: Registered nosave memory: [mem
0x76c00000-0x7fbfffff]
[    0.035689] PM: hibernation: Registered nosave memory: [mem
0x7fc00000-0xbfffffff]
[    0.035691] PM: hibernation: Registered nosave memory: [mem
0xc0000000-0xcfffffff]
[    0.035692] PM: hibernation: Registered nosave memory: [mem
0xd0000000-0xfed1ffff]
[    0.035693] PM: hibernation: Registered nosave memory: [mem
0xfed20000-0xfed7ffff]
[    0.035695] PM: hibernation: Registered nosave memory: [mem
0xfed80000-0xffffffff]
[    0.035697] [mem 0x7fc00000-0xbfffffff] available for PCI devices
[    0.035700] Booting paravirtualized kernel on bare hardware
[    0.035703] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.035710] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:4 nr_node_ids:1
[    0.035973] percpu: Embedded 44 pages/cpu s141912 r8192 d30120 u524288
[    0.035981] pcpu-alloc: s141912 r8192 d30120 u524288 alloc=1*2097152
[    0.035984] pcpu-alloc: [0] 0 1 2 3
[    0.036007] Built 1 zonelists, mobility grouping on.  Total pages: 4067552
[    0.036009] Policy zone: Normal
[    0.036011] Kernel command line: BOOT_IMAGE=(hd12,gpt2)/bzImage
console=ttyS0,115200n8 bootpart=2
uuid=e15419aa-e366-4e44-a305-863db786e456
[    0.037765] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.038614] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.038653] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.093087] Memory: 16091048K/16529116K available (12289K kernel
code, 1683K rwdata, 3944K rodata, 1052K init, 1248K bss, 437812K
reserved, 0K cma-reserved)
[    0.093135] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.093193] rcu: Hierarchical RCU implementation.
[    0.093194] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.093197] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.093198] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.093225] NR_IRQS: 16640, nr_irqs: 1024, preallocated irqs: 16
[    0.093711] random: get_random_bytes called from
start_kernel+0x32b/0x4eb with crng_init=0
[    0.093740] Console: colour dummy device 80x25
[    1.270886] printk: console [ttyS0] enabled
[    1.275079] ACPI: Core revision 20210331
[    1.279325] APIC: Switch to symmetric I/O mode setup
[    1.285578] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.295982] check_system_tsc_reliable: disable clocksource watchdog
[    1.295984] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x3990bec8342, max_idle_ns: 881590769617 ns
[    1.306505] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3993.60 BogoMIPS (lpj=1996800)
[    1.307501] pid_max: default: 32768 minimum: 301
[    1.307501] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    1.307501] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    1.307501] CPU0: Thermal monitoring enabled (TM1)
[    1.307501] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    1.307501] process: using mwait in idle threads
[    1.307501] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    1.307501] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    1.307501] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    1.307501] Spectre V2 : Mitigation: Enhanced IBRS
[    1.307501] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    1.307501] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    1.307501] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    1.307501] Freeing SMP alternatives memory: 20K
[    1.307501] smpboot: Estimated ratio of average max frequency by
base frequency (times 1024): 1433
[    1.307501] smpboot: CPU0: Intel(R) Celeron(R) N5105 @ 2.00GHz
(family: 0x6, model: 0x9c, stepping: 0x0)
[    1.307604] Performance Events: PEBS fmt4+-baseline, PEBS-via-PT,
AnyThread deprecated, Tremont events, 32-deep LBR, full-width
counters, Intel PMU driver.
[    1.308503] ... version:                5
[    1.309502] ... bit width:              48
[    1.310502] ... generic registers:      4
[    1.311502] ... value mask:             0000ffffffffffff
[    1.312502] ... max period:             00007fffffffffff
[    1.313502] ... fixed-purpose events:   3
[    1.314502] ... event mask:             000000070000000f
[    1.315566] rcu: Hierarchical SRCU implementation.
[    1.316716] mc: CPU model GenuineIntel Jasper Lake
[    1.317554] smp: Bringing up secondary CPUs ...
[    1.318589] x86: Booting SMP configuration:
[    1.319503] .... node  #0, CPUs:      #1 #2 #3
[    1.320997] smp: Brought up 1 node, 4 CPUs
[    1.322502] smpboot: Max logical packages: 1
[    1.323502] smpboot: Total of 4 processors activated (15974.40 BogoMIPS)
[    1.325788] devtmpfs: initialized
[    1.326548] x86/mm: Memory block size: 128MB
[    1.328705] PM: Registering ACPI NVS region [mem
0x75cc7000-0x7697efff] (13336576 bytes)
[    1.329740] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.330505] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    1.331531] pinctrl core: initialized pinctrl subsystem
[    1.332727] PM: RTC time: 13:46:39, date: 2024-01-24
[    1.333586] NET: Registered protocol family 16
[    1.334668] thermal_sys: Registered thermal governor 'step_wise'
[    1.334669] thermal_sys: Registered thermal governor 'user_space'
[    1.335514] cpuidle: using governor ladder
[    1.345523] cpuidle: using governor menu
[    1.346544] ACPI: bus type PCI registered
[    1.347553] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xc0000000-0xcfffffff] (base 0xc0000000)
[    1.348504] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    1.349519] PCI: Using configuration type 1 for base access
[    1.350803] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.352844] Kprobes globally optimized
[    1.353521] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.354520] cryptd: max_cpu_qlen set to 1000
[    1.372502] raid6: sse2x4   gen() 10998 MB/s
[    1.390503] raid6: sse2x4   xor()  6973 MB/s
[    1.408502] raid6: sse2x2   gen() 13103 MB/s
[    1.426503] raid6: sse2x2   xor()  7614 MB/s
[    1.444503] raid6: sse2x1   gen()  9862 MB/s
[    1.462502] raid6: sse2x1   xor()  5277 MB/s
[    1.463502] raid6: using algorithm sse2x2 gen() 13103 MB/s
[    1.464502] raid6: .... xor() 7614 MB/s, rmw enabled
[    1.465502] raid6: using ssse3x2 recovery algorithm
[    1.466539] ACPI: Added _OSI(Module Device)
[    1.467502] ACPI: Added _OSI(Processor Device)
[    1.468502] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.469502] ACPI: Added _OSI(Processor Aggregator Device)
[    1.470502] ACPI: Added _OSI(Linux-Dell-Video)
[    1.471504] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.472502] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.530435] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    1.536715] ACPI: Dynamic OEM Table Load:
[    1.537509] ACPI: SSDT 0xFFFF888100921600 0001B8 (v02 PmRef
Cpu0Psd  00003000 INTL 20191018)
[    1.539239] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    1.540973] ACPI: Dynamic OEM Table Load:
[    1.541507] ACPI: SSDT 0xFFFF888100972800 000479 (v02 PmRef
Cpu0Ist  00003000 INTL 20191018)
[    1.543421] ACPI: Dynamic OEM Table Load:
[    1.543506] ACPI: SSDT 0xFFFF888100921800 00013A (v02 PmRef
Cpu0Hwp  00003000 INTL 20191018)
[    1.545523] ACPI: Dynamic OEM Table Load:
[    1.546507] ACPI: SSDT 0xFFFF888100064000 0008E7 (v02 PmRef  ApIst
  00003000 INTL 20191018)
[    1.548505] ACPI: Dynamic OEM Table Load:
[    1.549507] ACPI: SSDT 0xFFFF888100973800 00048A (v02 PmRef  ApHwp
  00003000 INTL 20191018)
[    1.551422] ACPI: Dynamic OEM Table Load:
[    1.551506] ACPI: SSDT 0xFFFF888100974800 0004D2 (v02 PmRef  ApPsd
  00003000 INTL 20191018)
[    1.556166] ACPI: Interpreter enabled
[    1.556554] ACPI: (supports S0 S3 S4 S5)
[    1.557502] ACPI: Using IOAPIC for interrupt routing
[    1.558545] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    1.573418] ACPI: PM: Power Resource [WRST] (on)
[    1.581123] acpi ABCD0000:00: ACPI dock station (docks/bays count: 1)
[    1.585972] ACPI: PM: Power Resource [FN00] (off)
[    1.586594] ACPI: PM: Power Resource [FN01] (off)
[    1.587593] ACPI: PM: Power Resource [FN02] (off)
[    1.588592] ACPI: PM: Power Resource [FN03] (off)
[    1.589589] ACPI: PM: Power Resource [FN04] (off)
[    1.591044] ACPI: PM: Power Resource [PIN] (off)
[    1.591796] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    1.592506] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    1.595760] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
PCIeCapability LTR]
[    1.596803] PCI host bridge to bus 0000:00
[    1.597503] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.598505] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.599502] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    1.600502] pci_bus 0000:00: root bus resource [mem
0x7fc00000-0xbfffffff window]
[    1.601502] pci_bus 0000:00: root bus resource [mem
0x4000000000-0x7fffffffff window]
[    1.602502] pci_bus 0000:00: root bus resource [bus 00-fe]
[    1.603526] pci 0000:00:00.0: [8086:4e24] type 00 class 0x060000
[    1.605456] pci 0000:00:02.0: [8086:4e61] type 00 class 0x030000
[    1.605512] pci 0000:00:02.0: reg 0x10: [mem 0x6001000000-0x6001ffffff 64bit]
[    1.606508] pci 0000:00:02.0: reg 0x18: [mem
0x4000000000-0x400fffffff 64bit pref]
[    1.607506] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    1.609399] pci 0000:00:04.0: [8086:4e03] type 00 class 0x118000
[    1.609518] pci 0000:00:04.0: reg 0x10: [mem 0x6002110000-0x600211ffff 64bit]
[    1.611483] pci 0000:00:05.0: [8086:4e19] type 00 class 0x048000
[    1.611510] pci 0000:00:05.0: reg 0x10: [mem 0x6000000000-0x6000ffffff 64bit]
[    1.612516] pci 0000:00:05.0: enabling Extended Tags
[    1.614366] pci 0000:00:08.0: [8086:4e11] type 00 class 0x088000
[    1.614511] pci 0000:00:08.0: reg 0x10: [mem 0x6002130000-0x6002130fff 64bit]
[    1.616368] pci 0000:00:14.0: [8086:4ded] type 00 class 0x0c0330
[    1.616524] pci 0000:00:14.0: reg 0x10: [mem 0x6002100000-0x600210ffff 64bit]
[    1.617579] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.619500] pci 0000:00:14.2: [8086:4def] type 00 class 0x050000
[    1.620521] pci 0000:00:14.2: reg 0x10: [mem 0x6002124000-0x6002125fff 64bit]
[    1.621514] pci 0000:00:14.2: reg 0x18: [mem 0x600212f000-0x600212ffff 64bit]
[    1.623354] pci 0000:00:15.0: [8086:4de8] type 00 class 0x0c8000
[    1.623523] pci 0000:00:15.0: reg 0x10: [mem 0x600212e000-0x600212efff 64bit]
[    1.625508] pci 0000:00:15.2: [8086:4dea] type 00 class 0x0c8000
[    1.626522] pci 0000:00:15.2: reg 0x10: [mem 0x600212d000-0x600212dfff 64bit]
[    1.628524] pci 0000:00:16.0: [8086:4de0] type 00 class 0x078000
[    1.629524] pci 0000:00:16.0: reg 0x10: [mem 0x600212c000-0x600212cfff 64bit]
[    1.630588] pci 0000:00:16.0: PME# supported from D3hot
[    1.632654] pci 0000:00:19.0: [8086:4dc5] type 00 class 0x0c8000
[    1.633523] pci 0000:00:19.0: reg 0x10: [mem 0x600212b000-0x600212bfff 64bit]
[    1.635504] pci 0000:00:19.1: [8086:4dc6] type 00 class 0x0c8000
[    1.636522] pci 0000:00:19.1: reg 0x10: [mem 0x600212a000-0x600212afff 64bit]
[    1.638520] pci 0000:00:1a.0: [8086:4dc4] type 00 class 0x080501
[    1.639525] pci 0000:00:1a.0: reg 0x10: [mem 0x6002129000-0x6002129fff 64bit]
[    1.641555] pci 0000:00:1c.0: [8086:4db8] type 01 class 0x060400
[    1.642608] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.644772] pci 0000:00:1c.2: [8086:4dba] type 01 class 0x060400
[    1.645608] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.647762] pci 0000:00:1c.4: [8086:4dbc] type 01 class 0x060400
[    1.648607] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.650760] pci 0000:00:1c.6: [8086:4dbe] type 01 class 0x060400
[    1.651607] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    1.653762] pci 0000:00:1e.0: [8086:4da8] type 00 class 0x078000
[    1.654523] pci 0000:00:1e.0: reg 0x10: [mem 0x6002128000-0x6002128fff 64bit]
[    1.656551] pci 0000:00:1e.3: [8086:4dab] type 00 class 0x0c8000
[    1.657522] pci 0000:00:1e.3: reg 0x10: [mem 0x6002127000-0x6002127fff 64bit]
[    1.659510] pci 0000:00:1f.0: [8086:4d87] type 00 class 0x060100
[    1.661543] pci 0000:00:1f.3: [8086:4dc8] type 00 class 0x040380
[    1.662537] pci 0000:00:1f.3: reg 0x10: [mem 0x6002120000-0x6002123fff 64bit]
[    1.663546] pci 0000:00:1f.3: reg 0x20: [mem 0x6002000000-0x60020fffff 64bit]
[    1.664592] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    1.666667] pci 0000:00:1f.4: [8086:4da3] type 00 class 0x0c0500
[    1.667530] pci 0000:00:1f.4: reg 0x10: [mem 0x6002126000-0x60021260ff 64bit]
[    1.668534] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    1.670460] pci 0000:00:1f.5: [8086:4da4] type 00 class 0x0c8000
[    1.670520] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    1.672422] pci 0000:01:00.0: [1d6a:04c0] type 00 class 0x020000
[    1.672523] pci 0000:01:00.0: reg 0x10: [mem 0x80000000-0x8007ffff 64bit]
[    1.673514] pci 0000:01:00.0: reg 0x18: [mem 0x80080000-0x80080fff 64bit]
[    1.674514] pci 0000:01:00.0: reg 0x20: [mem 0x7fc00000-0x7fffffff 64bit]
[    1.675509] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    1.676625] pci 0000:01:00.0: supports D1 D2
[    1.677502] pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.678584] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 63.012
Gb/s with 16.0 GT/s PCIe x4 link)
[    1.679559] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.680507] pci 0000:00:1c.0:   bridge window [mem 0x7fc00000-0x800fffff]
[    1.681576] pci 0000:02:00.0: [1b21:2806] type 01 class 0x060400
[    1.682563] pci 0000:02:00.0: enabling Extended Tags
[    1.683594] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.684623] pci 0000:00:1c.2: PCI bridge to [bus 02-07]
[    1.685507] pci 0000:00:1c.2:   bridge window [mem 0x80900000-0x80cfffff]
[    1.686581] pci 0000:03:00.0: [1b21:2806] type 01 class 0x060400
[    1.687565] pci 0000:03:00.0: enabling Extended Tags
[    1.688594] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.689617] pci 0000:03:02.0: [1b21:2806] type 01 class 0x060400
[    1.690565] pci 0000:03:02.0: enabling Extended Tags
[    1.691594] pci 0000:03:02.0: PME# supported from D0 D3hot D3cold
[    1.692611] pci 0000:03:06.0: [1b21:2806] type 01 class 0x060400
[    1.693565] pci 0000:03:06.0: enabling Extended Tags
[    1.694594] pci 0000:03:06.0: PME# supported from D0 D3hot D3cold
[    1.695614] pci 0000:03:0e.0: [1b21:2806] type 01 class 0x060400
[    1.696565] pci 0000:03:0e.0: enabling Extended Tags
[    1.697593] pci 0000:03:0e.0: PME# supported from D0 D3hot D3cold
[    1.698599] pci 0000:02:00.0: PCI bridge to [bus 03-07]
[    1.699511] pci 0000:02:00.0:   bridge window [mem 0x80900000-0x80cfffff]
[    1.700590] pci 0000:04:00.0: [15b7:5006] type 00 class 0x010802
[    1.701535] pci 0000:04:00.0: reg 0x10: [mem 0x80c00000-0x80c03fff 64bit]
[    1.702549] pci 0000:04:00.0: reg 0x20: [mem 0x80c04000-0x80c040ff 64bit]
[    1.703701] pci 0000:04:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:03:00.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.704536] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.705511] pci 0000:03:00.0:   bridge window [mem 0x80c00000-0x80cfffff]
[    1.706590] pci 0000:05:00.0: [15b7:5006] type 00 class 0x010802
[    1.707535] pci 0000:05:00.0: reg 0x10: [mem 0x80b00000-0x80b03fff 64bit]
[    1.708549] pci 0000:05:00.0: reg 0x20: [mem 0x80b04000-0x80b040ff 64bit]
[    1.709700] pci 0000:05:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:03:02.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.710535] pci 0000:03:02.0: PCI bridge to [bus 05]
[    1.711511] pci 0000:03:02.0:   bridge window [mem 0x80b00000-0x80bfffff]
[    1.712591] pci 0000:06:00.0: [15b7:5006] type 00 class 0x010802
[    1.713535] pci 0000:06:00.0: reg 0x10: [mem 0x80a00000-0x80a03fff 64bit]
[    1.714549] pci 0000:06:00.0: reg 0x20: [mem 0x80a04000-0x80a040ff 64bit]
[    1.715700] pci 0000:06:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:03:06.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.716536] pci 0000:03:06.0: PCI bridge to [bus 06]
[    1.717511] pci 0000:03:06.0:   bridge window [mem 0x80a00000-0x80afffff]
[    1.718591] pci 0000:07:00.0: [15b7:5006] type 00 class 0x010802
[    1.719535] pci 0000:07:00.0: reg 0x10: [mem 0x80900000-0x80903fff 64bit]
[    1.720549] pci 0000:07:00.0: reg 0x20: [mem 0x80904000-0x809040ff 64bit]
[    1.721700] pci 0000:07:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:03:0e.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.722536] pci 0000:03:0e.0: PCI bridge to [bus 07]
[    1.723511] pci 0000:03:0e.0:   bridge window [mem 0x80900000-0x809fffff]
[    1.724606] pci 0000:08:00.0: [1b21:2806] type 01 class 0x060400
[    1.725565] pci 0000:08:00.0: enabling Extended Tags
[    1.726593] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    1.727625] pci 0000:00:1c.4: PCI bridge to [bus 08-0d]
[    1.728507] pci 0000:00:1c.4:   bridge window [mem 0x80500000-0x808fffff]
[    1.729579] pci 0000:09:00.0: [1b21:2806] type 01 class 0x060400
[    1.730565] pci 0000:09:00.0: enabling Extended Tags
[    1.731594] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    1.732615] pci 0000:09:02.0: [1b21:2806] type 01 class 0x060400
[    1.733565] pci 0000:09:02.0: enabling Extended Tags
[    1.734593] pci 0000:09:02.0: PME# supported from D0 D3hot D3cold
[    1.735607] pci 0000:09:06.0: [1b21:2806] type 01 class 0x060400
[    1.736564] pci 0000:09:06.0: enabling Extended Tags
[    1.737594] pci 0000:09:06.0: PME# supported from D0 D3hot D3cold
[    1.738613] pci 0000:09:0e.0: [1b21:2806] type 01 class 0x060400
[    1.739565] pci 0000:09:0e.0: enabling Extended Tags
[    1.740594] pci 0000:09:0e.0: PME# supported from D0 D3hot D3cold
[    1.741600] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    1.742511] pci 0000:08:00.0:   bridge window [mem 0x80500000-0x808fffff]
[    1.743590] pci 0000:0a:00.0: [15b7:5006] type 00 class 0x010802
[    1.744535] pci 0000:0a:00.0: reg 0x10: [mem 0x80800000-0x80803fff 64bit]
[    1.745549] pci 0000:0a:00.0: reg 0x20: [mem 0x80804000-0x808040ff 64bit]
[    1.746701] pci 0000:0a:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:09:00.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.747536] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    1.748511] pci 0000:09:00.0:   bridge window [mem 0x80800000-0x808fffff]
[    1.749591] pci 0000:0b:00.0: [15b7:5006] type 00 class 0x010802
[    1.750535] pci 0000:0b:00.0: reg 0x10: [mem 0x80700000-0x80703fff 64bit]
[    1.751549] pci 0000:0b:00.0: reg 0x20: [mem 0x80704000-0x807040ff 64bit]
[    1.752700] pci 0000:0b:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:09:02.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.753535] pci 0000:09:02.0: PCI bridge to [bus 0b]
[    1.754511] pci 0000:09:02.0:   bridge window [mem 0x80700000-0x807fffff]
[    1.755591] pci 0000:0c:00.0: [15b7:5006] type 00 class 0x010802
[    1.756535] pci 0000:0c:00.0: reg 0x10: [mem 0x80600000-0x80603fff 64bit]
[    1.757549] pci 0000:0c:00.0: reg 0x20: [mem 0x80604000-0x806040ff 64bit]
[    1.758700] pci 0000:0c:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:09:06.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.759536] pci 0000:09:06.0: PCI bridge to [bus 0c]
[    1.760511] pci 0000:09:06.0:   bridge window [mem 0x80600000-0x806fffff]
[    1.761591] pci 0000:0d:00.0: [15b7:5006] type 00 class 0x010802
[    1.762535] pci 0000:0d:00.0: reg 0x10: [mem 0x80500000-0x80503fff 64bit]
[    1.763549] pci 0000:0d:00.0: reg 0x20: [mem 0x80504000-0x805040ff 64bit]
[    1.764700] pci 0000:0d:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:09:0e.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.765535] pci 0000:09:0e.0: PCI bridge to [bus 0d]
[    1.766511] pci 0000:09:0e.0:   bridge window [mem 0x80500000-0x805fffff]
[    1.767607] pci 0000:0e:00.0: [1b21:2806] type 01 class 0x060400
[    1.768563] pci 0000:0e:00.0: enabling Extended Tags
[    1.769593] pci 0000:0e:00.0: PME# supported from D0 D3hot D3cold
[    1.770625] pci 0000:00:1c.6: PCI bridge to [bus 0e-13]
[    1.771507] pci 0000:00:1c.6:   bridge window [mem 0x80100000-0x804fffff]
[    1.772580] pci 0000:0f:00.0: [1b21:2806] type 01 class 0x060400
[    1.773565] pci 0000:0f:00.0: enabling Extended Tags
[    1.774595] pci 0000:0f:00.0: PME# supported from D0 D3hot D3cold
[    1.775614] pci 0000:0f:02.0: [1b21:2806] type 01 class 0x060400
[    1.776565] pci 0000:0f:02.0: enabling Extended Tags
[    1.777594] pci 0000:0f:02.0: PME# supported from D0 D3hot D3cold
[    1.778606] pci 0000:0f:06.0: [1b21:2806] type 01 class 0x060400
[    1.779564] pci 0000:0f:06.0: enabling Extended Tags
[    1.780594] pci 0000:0f:06.0: PME# supported from D0 D3hot D3cold
[    1.781613] pci 0000:0f:0e.0: [1b21:2806] type 01 class 0x060400
[    1.782565] pci 0000:0f:0e.0: enabling Extended Tags
[    1.783594] pci 0000:0f:0e.0: PME# supported from D0 D3hot D3cold
[    1.784600] pci 0000:0e:00.0: PCI bridge to [bus 0f-13]
[    1.785511] pci 0000:0e:00.0:   bridge window [mem 0x80100000-0x804fffff]
[    1.786590] pci 0000:10:00.0: [15b7:5006] type 00 class 0x010802
[    1.787535] pci 0000:10:00.0: reg 0x10: [mem 0x80400000-0x80403fff 64bit]
[    1.788549] pci 0000:10:00.0: reg 0x20: [mem 0x80404000-0x804040ff 64bit]
[    1.789700] pci 0000:10:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:0f:00.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.790535] pci 0000:0f:00.0: PCI bridge to [bus 10]
[    1.791511] pci 0000:0f:00.0:   bridge window [mem 0x80400000-0x804fffff]
[    1.792592] pci 0000:11:00.0: [15b7:5006] type 00 class 0x010802
[    1.793535] pci 0000:11:00.0: reg 0x10: [mem 0x80300000-0x80303fff 64bit]
[    1.794549] pci 0000:11:00.0: reg 0x20: [mem 0x80304000-0x803040ff 64bit]
[    1.795701] pci 0000:11:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:0f:02.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.796535] pci 0000:0f:02.0: PCI bridge to [bus 11]
[    1.797511] pci 0000:0f:02.0:   bridge window [mem 0x80300000-0x803fffff]
[    1.798591] pci 0000:12:00.0: [15b7:5006] type 00 class 0x010802
[    1.799535] pci 0000:12:00.0: reg 0x10: [mem 0x80200000-0x80203fff 64bit]
[    1.800549] pci 0000:12:00.0: reg 0x20: [mem 0x80204000-0x802040ff 64bit]
[    1.801700] pci 0000:12:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:0f:06.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.802536] pci 0000:0f:06.0: PCI bridge to [bus 12]
[    1.803511] pci 0000:0f:06.0:   bridge window [mem 0x80200000-0x802fffff]
[    1.804592] pci 0000:13:00.0: [15b7:5006] type 00 class 0x010802
[    1.805535] pci 0000:13:00.0: reg 0x10: [mem 0x80100000-0x80103fff 64bit]
[    1.806549] pci 0000:13:00.0: reg 0x20: [mem 0x80104000-0x801040ff 64bit]
[    1.807700] pci 0000:13:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x1 link at 0000:0f:0e.0 (capable of 31.504
Gb/s with 8.0 GT/s PCIe x4 link)
[    1.808536] pci 0000:0f:0e.0: PCI bridge to [bus 13]
[    1.809511] pci 0000:0f:0e.0:   bridge window [mem 0x80100000-0x801fffff]
[    1.821064] acpi LNXPOWER:06: Turning OFF
[    1.821507] acpi LNXPOWER:00: Turning OFF
[    1.822571] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.823501] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    1.823511] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.824504] vgaarb: loaded
[    1.825586] SCSI subsystem initialized
[    1.826512] libata version 3.00 loaded.
[    1.826529] ACPI: bus type USB registered
[    1.827519] usbcore: registered new interface driver usbfs
[    1.828514] usbcore: registered new interface driver hub
[    1.829507] usbcore: registered new device driver usb
[    1.830527] pps_core: LinuxPPS API ver. 1 registered
[    1.831502] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.832504] PTP clock support registered
[    1.833564] Registered efivars operations
[    1.837523] mc: Asustor model(AS6700T)
[    1.840673] PCI: Using ACPI for IRQ routing
[    1.863540] PCI: pci_cache_line_size set to 64 bytes
[    1.863645] pci 0000:00:1f.5: can't claim BAR 0 [mem
0xfe010000-0xfe010fff]: no compatible bridge window
[    1.872591] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    1.872593] e820: reserve RAM buffer [mem 0x6e508000-0x6fffffff]
[    1.872595] e820: reserve RAM buffer [mem 0x70a18000-0x73ffffff]
[    1.872596] e820: reserve RAM buffer [mem 0x76c00000-0x77ffffff]
[    1.872597] e820: reserve RAM buffer [mem 0x480400000-0x483ffffff]
[    1.873508] clocksource: Switched to clocksource tsc-early
[    1.879028] VFS: Disk quotas dquot_6.6.0
[    1.882969] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.889879] pnp: PnP ACPI init
[    1.893189] system 00:00: [io  0x0680-0x069f] has been reserved
[    1.899109] system 00:00: [io  0x164e-0x164f] has been reserved
[    1.905027] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.905074] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.905174] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.911099] system 00:02: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    1.911441] ACPI: IRQ 4 override to edge, high
[    1.915917] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.916255] ACPI: IRQ 3 override to edge, high
[    1.920722] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.921463] system 00:05: [mem 0xfea80000-0xfeafffff] has been reserved
[    1.928082] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    1.934687] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    1.941296] system 00:05: [mem 0xc0000000-0xcfffffff] has been reserved
[    1.947905] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    1.954860] system 00:05: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.961468] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    1.968422] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.975034] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.975688] system 00:06: [io  0x1800-0x18fe] could not be reserved
[    1.981962] system 00:06: [mem 0xfe000000-0xfe01ffff] has been reserved
[    1.988568] system 00:06: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    1.995175] system 00:06: [mem 0xfe050000-0xfe0affff] has been reserved
[    2.001784] system 00:06: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    2.008393] system 00:06: [mem 0xfe200000-0xfe7fffff] has been reserved
[    2.014998] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.021608] system 00:06: [mem 0xfd000000-0xfd68ffff] has been reserved
[    2.028216] system 00:06: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    2.034823] system 00:06: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    2.041434] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.041726] system 00:07: [io  0xff00-0xfffe] has been reserved
[    2.047647] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.047856] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.048034] pnp: PnP ACPI: found 9 devices
[    2.057971] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    2.066862] NET: Registered protocol family 2
[    2.071472] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    2.081212] tcp_listen_portaddr_hash hash table entries: 8192
(order: 5, 131072 bytes, linear)
[    2.089841] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    2.098137] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    2.105640] TCP: Hash tables configured (established 131072 bind 65536)
[    2.112292] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    2.119110] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    2.126395] NET: Registered protocol family 1
[    2.131032] pci 0000:01:00.0: can't claim BAR 6 [mem
0xfffe0000-0xffffffff pref]: no compatible bridge window
[    2.140966] pci 0000:00:1f.5: BAR 0: assigned [mem 0x80d00000-0x80d00fff]
[    2.147756] pci 0000:01:00.0: BAR 6: assigned [mem
0x800a0000-0x800bffff pref]
[    2.154974] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    2.159939] pci 0000:00:1c.0:   bridge window [mem 0x7fc00000-0x800fffff]
[    2.166730] pci 0000:03:00.0: PCI bridge to [bus 04]
[    2.171699] pci 0000:03:00.0:   bridge window [mem 0x80c00000-0x80cfffff]
[    2.178486] pci 0000:03:02.0: PCI bridge to [bus 05]
[    2.183453] pci 0000:03:02.0:   bridge window [mem 0x80b00000-0x80bfffff]
[    2.190242] pci 0000:03:06.0: PCI bridge to [bus 06]
[    2.195207] pci 0000:03:06.0:   bridge window [mem 0x80a00000-0x80afffff]
[    2.201996] pci 0000:03:0e.0: PCI bridge to [bus 07]
[    2.206963] pci 0000:03:0e.0:   bridge window [mem 0x80900000-0x809fffff]
[    2.213755] pci 0000:02:00.0: PCI bridge to [bus 03-07]
[    2.218984] pci 0000:02:00.0:   bridge window [mem 0x80900000-0x80cfffff]
[    2.225776] pci 0000:00:1c.2: PCI bridge to [bus 02-07]
[    2.231005] pci 0000:00:1c.2:   bridge window [mem 0x80900000-0x80cfffff]
[    2.237788] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    2.242759] pci 0000:09:00.0:   bridge window [mem 0x80800000-0x808fffff]
[    2.249553] pci 0000:09:02.0: PCI bridge to [bus 0b]
[    2.254519] pci 0000:09:02.0:   bridge window [mem 0x80700000-0x807fffff]
[    2.261308] pci 0000:09:06.0: PCI bridge to [bus 0c]
[    2.266275] pci 0000:09:06.0:   bridge window [mem 0x80600000-0x806fffff]
[    2.273067] pci 0000:09:0e.0: PCI bridge to [bus 0d]
[    2.278035] pci 0000:09:0e.0:   bridge window [mem 0x80500000-0x805fffff]
[    2.284831] pci 0000:08:00.0: PCI bridge to [bus 09-0d]
[    2.290055] pci 0000:08:00.0:   bridge window [mem 0x80500000-0x808fffff]
[    2.296843] pci 0000:00:1c.4: PCI bridge to [bus 08-0d]
[    2.302067] pci 0000:00:1c.4:   bridge window [mem 0x80500000-0x808fffff]
[    2.308854] pci 0000:0f:00.0: PCI bridge to [bus 10]
[    2.313822] pci 0000:0f:00.0:   bridge window [mem 0x80400000-0x804fffff]
[    2.320614] pci 0000:0f:02.0: PCI bridge to [bus 11]
[    2.325583] pci 0000:0f:02.0:   bridge window [mem 0x80300000-0x803fffff]
[    2.332379] pci 0000:0f:06.0: PCI bridge to [bus 12]
[    2.337343] pci 0000:0f:06.0:   bridge window [mem 0x80200000-0x802fffff]
[    2.344131] pci 0000:0f:0e.0: PCI bridge to [bus 13]
[    2.349098] pci 0000:0f:0e.0:   bridge window [mem 0x80100000-0x801fffff]
[    2.355885] pci 0000:0e:00.0: PCI bridge to [bus 0f-13]
[    2.361113] pci 0000:0e:00.0:   bridge window [mem 0x80100000-0x804fffff]
[    2.367909] pci 0000:00:1c.6: PCI bridge to [bus 0e-13]
[    2.373135] pci 0000:00:1c.6:   bridge window [mem 0x80100000-0x804fffff]
[    2.379921] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.386097] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.392271] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.399141] pci_bus 0000:00: resource 7 [mem 0x7fc00000-0xbfffffff window]
[    2.406010] pci_bus 0000:00: resource 8 [mem
0x4000000000-0x7fffffffff window]
[    2.413226] pci_bus 0000:01: resource 1 [mem 0x7fc00000-0x800fffff]
[    2.419486] pci_bus 0000:02: resource 1 [mem 0x80900000-0x80cfffff]
[    2.425748] pci_bus 0000:03: resource 1 [mem 0x80900000-0x80cfffff]
[    2.432012] pci_bus 0000:04: resource 1 [mem 0x80c00000-0x80cfffff]
[    2.438271] pci_bus 0000:05: resource 1 [mem 0x80b00000-0x80bfffff]
[    2.444534] pci_bus 0000:06: resource 1 [mem 0x80a00000-0x80afffff]
[    2.450794] pci_bus 0000:07: resource 1 [mem 0x80900000-0x809fffff]
[    2.457057] pci_bus 0000:08: resource 1 [mem 0x80500000-0x808fffff]
[    2.463320] pci_bus 0000:09: resource 1 [mem 0x80500000-0x808fffff]
[    2.469581] pci_bus 0000:0a: resource 1 [mem 0x80800000-0x808fffff]
[    2.475844] pci_bus 0000:0b: resource 1 [mem 0x80700000-0x807fffff]
[    2.482106] pci_bus 0000:0c: resource 1 [mem 0x80600000-0x806fffff]
[    2.488369] pci_bus 0000:0d: resource 1 [mem 0x80500000-0x805fffff]
[    2.494629] pci_bus 0000:0e: resource 1 [mem 0x80100000-0x804fffff]
[    2.500892] pci_bus 0000:0f: resource 1 [mem 0x80100000-0x804fffff]
[    2.507154] pci_bus 0000:10: resource 1 [mem 0x80400000-0x804fffff]
[    2.513416] pci_bus 0000:11: resource 1 [mem 0x80300000-0x803fffff]
[    2.519678] pci_bus 0000:12: resource 1 [mem 0x80200000-0x802fffff]
[    2.525940] pci_bus 0000:13: resource 1 [mem 0x80100000-0x801fffff]
[    2.532319] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    2.541092] PCI: CLS 0 bytes, default 64
[    2.545018] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.545087] Trying to unpack rootfs image as initramfs...
[    2.551458] software IO TLB: mapped [mem
0x000000006a187000-0x000000006e187000] (64MB)
[    2.564797] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x3990bec8342, max_idle_ns: 881590769617 ns
[    2.574832] clocksource: Switched to clocksource tsc
[    2.580188] Initialise system trusted keyrings
[    2.584676] workingset: timestamp_bits=40 max_order=22 bucket_order=0
[    2.592402] fuse: init (API version 7.34)
[    2.606292] NET: Registered protocol family 38
[    2.610744] xor: measuring software checksum speed
[    2.616029]    prefetch64-sse  : 19874 MB/sec
[    2.620939]    generic_sse     : 17947 MB/sec
[    2.625299] xor: using function: prefetch64-sse (19874 MB/sec)
[    2.631131] Key type asymmetric registered
[    2.635226] Asymmetric key parser 'x509' registered
[    2.640114] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    2.647537] io scheduler mq-deadline registered
[    2.652072] io scheduler kyber registered
[    2.658560] gpio_it87: Found Chip IT8625 rev d. 64 GPIO lines
starting at 0a00h
[    2.666182] pcieport 0000:00:1c.0: PME: Signaling with IRQ 120
[    2.672259] pcieport 0000:00:1c.2: PME: Signaling with IRQ 121
[    2.678351] pcieport 0000:00:1c.4: PME: Signaling with IRQ 122
[    2.684466] pcieport 0000:00:1c.6: PME: Signaling with IRQ 123
[    2.693335] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    2.701705] ACPI: button: Sleep Button [SLPB]
[    2.706103] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.713535] ACPI: button: Power Button [PWRF]
[    2.718240] smpboot: Estimated ratio of average max frequency by
base frequency (times 1024): 1433
[    2.728244] thermal LNXTHERM:00: registered as thermal_zone0
[    2.733911] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    2.739066] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.766452] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
is a 16550A
[    2.794824] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200)
is a 16550A
[    2.803336] hpet_acpi_add: no address or irqs in _CRS
[    2.808460] Linux agpgart interface v0.103
[    2.822538] brd: module loaded
[    2.828063] loop: module loaded
[    2.831322] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    2.831323] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    2.836866] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
[    2.855049] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
[    2.866524] intel-lpss 0000:00:19.1: enabling device (0000 -> 0002)
[    2.877994] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    2.884617] dw-apb-uart.4: ttyS4 at MMIO 0x6002128000 (irq = 20,
base_baud = 7500000) is a 16550A
[    2.893574] intel-lpss 0000:00:1e.3: enabling device (0000 -> 0002)
[    2.900358] nvme nvme0: pci function 0000:04:00.0
[    2.905136] nvme nvme1: pci function 0000:05:00.0
[    2.909905] nvme nvme2: pci function 0000:06:00.0
[    2.911002] nvme nvme0: 4/0/0 default/read/poll queues
[    2.914674] nvme nvme3: pci function 0000:07:00.0
[    2.921159] nvme nvme2: 4/0/0 default/read/poll queues
[    2.925090] nvme nvme1: 4/0/0 default/read/poll queues
[    2.929713] nvme nvme4: pci function 0000:0a:00.0
[    2.930672]  nvme0n1: p1 p2 p3 p4
[    2.931218] nvme nvme3: 4/0/0 default/read/poll queues
[    2.933821]  nvme3n1: p1 p2 p3 p4
[    2.934046]  nvme2n1: p1 p2 p3 p4
[    2.952146]  nvme1n1: p1 p2 p3 p4
[    2.954948] nvme nvme5: pci function 0000:0b:00.0
[    2.961007] nvme nvme4: 4/0/0 default/read/poll queues
[    2.962612] nvme nvme6: pci function 0000:0c:00.0
[    2.970546]  nvme4n1: p1 p2 p3 p4
[    2.972449] nvme nvme7: pci function 0000:0d:00.0
[    2.980492] nvme nvme8: pci function 0000:10:00.0
[    2.981985] nvme nvme6: 4/0/0 default/read/poll queues
[    2.985469] nvme nvme9: pci function 0000:11:00.0
[    2.986993] nvme nvme7: 4/0/0 default/read/poll queues
[    2.992889]  nvme6n1: p1 p2 p3 p4
[    2.992922]  nvme7n1: p1 p2 p3 p4
[    2.993998] nvme nvme8: 4/0/0 default/read/poll queues
[    2.995233] nvme nvme5: 4/0/0 default/read/poll queues
[    2.995533] nvme nvme10: pci function 0000:12:00.0
[    2.995575] nvme nvme11: pci function 0000:13:00.0
[    2.995790] libphy: Fixed MDIO Bus: probed
[    2.995862] e1000: Intel(R) PRO/1000 Network Driver
[    2.995863] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.995878] e1000e: Intel(R) PRO/1000 Network Driver
[    2.995879] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.995926] usbcore: registered new interface driver catc
[    2.995958] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.995960] ehci-pci: EHCI PCI platform driver
[    2.995969] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.995971] ohci-pci: OHCI PCI platform driver
[    2.995980] uhci_hcd: USB Universal Host Controller Interface driver
[    2.996182] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.996211] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    2.997371] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci
version 0x110 quirks 0x0000000000009810
[    2.997636] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.13
[    2.997639] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.997641] usb usb1: Product: xHCI Host Controller
[    2.997642] usb usb1: Manufacturer: Linux 5.13.x xhci-hcd
[    2.997643] usb usb1: SerialNumber: 0000:00:14.0
[    2.997736] hub 1-0:1.0: USB hub found
[    2.997762] hub 1-0:1.0: 8 ports detected
[    2.998107] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.998132] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    2.998135] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.998177] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.13
[    2.998180] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.998181] usb usb2: Product: xHCI Host Controller
[    2.998183] usb usb2: Manufacturer: Linux 5.13.x xhci-hcd
[    2.998184] usb usb2: SerialNumber: 0000:00:14.0
[    2.998260] hub 2-0:1.0: USB hub found
[    2.998279] hub 2-0:1.0: 6 ports detected
[    2.998499] usbcore: registered new interface driver cdc_acm
[    2.998500] cdc_acm: USB Abstract Control Model driver for USB
modems and ISDN adapters
[    2.998511] usbcore: registered new interface driver usblp
[    2.998526] usbcore: registered new interface driver usb-storage
[    2.998540] usbcore: registered new interface driver ftdi_sio
[    2.998544] usbserial: USB Serial support registered for FTDI USB
Serial Device
[    2.998577] i8042: PNP: No PS/2 controller found.
[    2.998620] mousedev: PS/2 mouse device common for all mice
[    2.998717] input: PC Speaker as /devices/platform/pcspkr/input/input2
[    2.998794] rtc_cmos 00:01: RTC can wake from S4
[    3.000180] rtc_cmos 00:01: registered as rtc0
[    3.003542] rtc_cmos 00:01: setting system clock to
2024-01-24T13:46:42 UTC (1706104002)
[    3.008054]  nvme8n1: p1 p2 p3 p4
[    3.012038] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    3.017023] nvme nvme9: 4/0/0 default/read/poll queues
[    3.020482]  nvme9n1: p1
[    3.021996] i2c /dev entries driver
[    3.027930] nvme nvme10: 4/0/0 default/read/poll queues
[    3.030981] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
[    3.033122]  nvme5n1: p1 p2 p3 p4
[    3.048001] nvme nvme11: 4/0/0 default/read/poll queues
[    3.052565] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    3.058127] random: fast init done
[    3.325867] asustor add disk dev nvme9n1
[    3.326722]  nvme10n1: p1 p2 p3 p4
[    3.330263] it87: it87 driver version <not provided>
[    3.331087]  nvme11n1: p1 p2 p3 p4
[    3.335464] it87: Found IT8625E chip at 0xa30, revision 13
[    3.344212] it87: Beeping is supported
[    3.348233] it87 it87.2608: Detected broken BIOS defaults,
disabling PWM interface
[    3.358568] device-mapper: uevent: version 1.0.3
[    3.363246] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
initialised: dm-devel@redhat.com
[    3.371732] intel_pstate: Intel P-state driver initializing
[    3.377535] intel_pstate: HWP enabled
[    3.381240] sdhci: Secure Digital Host Controller Interface driver
[    3.387426] sdhci: Copyright(c) Pierre Ossman
[    3.391801] sdhci-pci 0000:00:1a.0: SDHCI controller found
[8086:4dc4] (rev 1)
[    3.399422] mmc0: CQHCI version 5.10
[    3.403154] mmc0: SDHCI controller on PCI [0000:00:1a.0] using ADMA 64-bit
[    3.410079] EFI Variables Facility v0.08 2004-May-17
[    3.417126] pstore: Registered efi as persistent store backend
[    3.422981] hid: raw HID events driver (C) Jiri Kosina
[    3.428406] usbcore: registered new interface driver usbhid
[    3.433990] usbhid: USB HID core driver
[    3.437892] input: Unspecified device as /devices/virtual/input/input3
[    3.439511] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    3.451009] Virtual Mouse Driver Initialized.
[    3.455693] IPVS: Registered protocols (TCP, UDP)
[    3.460413] IPVS: Connection hash table configured (size=4096,
memory=64Kbytes)
[    3.467762] IPVS: ipvs loaded.
[    3.470974] NET: Registered protocol family 10
[    3.475648] Segment Routing with IPv6
[    3.479336] NET: Registered protocol family 17
[    3.483783] 8021q: 802.1Q VLAN Support v1.8
[    3.487974] Key type dns_resolver registered
[    3.492587] microcode: sig=0x906c0, pf=0x1, revision=0x2400001f
[    3.498553] microcode: Microcode Update Driver: v2.2.
[    3.498557] IPI shorthand broadcast: enabled
[    3.507886] SSE version of gcm_enc/dec engaged.
[    3.512894] sched_clock: Marking stable (2299947382,
1212936297)->(5219562137, -1706678458)
[    3.521372] registered taskstats version 1
[    3.525471] Loading compiled-in X.509 certificates
[    3.530458] Btrfs loaded, crc32c=crc32c-intel, debug=on, zoned=no
[    3.536616] pstore: Using crash dump compression: deflate
[    3.537928] asustor add disk dev nvme2n1
[    3.537948] asustor add disk dev nvme3n1
[    3.542254] asustor add disk dev nvme0n1
[    3.542413] PM:   Magic number: 8:387:787
[    3.546464] mei 0000:00:16.0-55213584-9a29-4916-badf-0fb7ed682aeb:
hash matches
[    3.553906] printk: console [netcon0] enabled
[    3.555923] limit mmc speed to HS200 mode
[    3.558300] netconsole: network logging started
[    3.558332] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    3.563525] mmc0: Command Queue Engine enabled
[    3.579027] mmc0: new HS200 MMC card at address 0001
[    3.584143] mmcblk0: mmc0:0001 8GTF4R 7.28 GiB
[    3.588731] mmcblk0boot0: mmc0:0001 8GTF4R 4.00 MiB
[    3.593746] mmcblk0boot1: mmc0:0001 8GTF4R 4.00 MiB
[    3.598761] mmcblk0rpmb: mmc0:0001 8GTF4R 512 KiB, chardev (241:0)
[    3.606190] usb 1-5: New USB device found, idVendor=0764,
idProduct=0501, bcdDevice= 0.01
[    3.614367] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.621500] usb 1-5: Product: CRCA102.981
[    3.625517] usb 1-5: Manufacturer: CP1500PFCLCD
[    3.630049] usb 1-5: SerialNumber: CPS
[    3.634837] GPT:Primary header thinks Alt. header is not at the end
of the disk.
[    3.641737] asustor add disk dev nvme5n1
[    3.641899] asustor add disk dev nvme8n1
[    3.641914] asustor add disk dev nvme6n1
[    3.642253] GPT:1007615 != 15269887
[    3.645748] GPT:Alternate GPT header not at the end of the disk.
[    3.649693] asustor add disk dev nvme1n1
[    3.651754] GPT:1007615 != 15269887
[    3.651932] asustor add disk dev nvme7n1
[    3.655246] GPT: Use GNU Parted to correct GPT errors.
[    3.655263] asustor add disk dev nvme4n1
[    3.660393]  mmcblk0: p1 p2 p3
[    3.664224] hid-generic 0003:0764:0501.0001: hiddev0,hidraw0: USB
HID v1.10 Device [CP1500PFCLCD CRCA102.981] on
usb-0000:00:14.0-5/input0
[    3.753731] asustor add disk dev nvme10n1
[    3.761694] asustor add disk dev nvme11n1
[    4.136525] Freeing initrd memory: 16376K
[    4.141025] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.147636] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    4.156250] cfg80211: failed to load regulatory.db
[    4.161343] Freeing unused kernel image (initmem) memory: 1052K
[    4.174505] Write protecting the kernel read-only data: 18432k
[    4.181127] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    4.188076] Freeing unused kernel image (rodata/data gap) memory: 152K
[    4.194863] Run /init as init process
[    4.198705]   with arguments:
[    4.198705]     /init
[    4.198706]   with environment:
[    4.198707]     HOME=/
[    4.198707]     TERM=linux
[    4.198708]     BOOT_IMAGE=(hd12,gpt2)/bzImage
[    4.198709]     bootpart=2
[    4.198709]     uuid=e15419aa-e366-4e44-a305-863db786e456
[    4.916453] atlantic 0000:01:00.0: enabling device (0000 -> 0002)
[    5.027290] atlantic: Detect ATL2FW 103001e
[    5.160739] mmcblk: mmc_blk_ioctl_as_set_lock before set lock=0 flag 100
[    5.167864] mmcblk: mmc_blk_ioctl_as_set_lock after set lock=0 flag 100
[    5.286463] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Opts: (null). Quota mode: none.
[    5.296632] ext4 filesystem being mounted at /mnt supports
timestamps until 2038 (0x7fffffff)
[    5.547397] 8021q: adding VLAN 0 to HW filter on device eth0
[    5.614049] random: dd: uninitialized urandom read (512 bytes read)
[    5.637696] mmcblk: mmc_blk_ioctl_as_set_lock before set lock=0 flag 100
[    5.644785] mmcblk: mmc_blk_ioctl_as_set_lock after set lock=0 flag 100
[    8.033421] md: md0 stopped.
[    8.039625] md/raid1:md0: active with 11 out of 12 mirrors
[    8.045361] md0: detected capacity change from 0 to 4188160
[    8.215009] EXT4-fs (md0): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[    8.241104] EXT4-fs (md0): re-mounted. Opts: (null). Quota mode: none.
[    8.272874] loop0: detected capacity change from 0 to 2048
[   10.484839] EXT4-fs (loop0): mounted filesystem without journal.
Opts: (null). Quota mode: none.
[   10.494088] ext4 filesystem being mounted at /share supports
timestamps until 2038 (0x7fffffff)
[   10.503558] mmcblk: mmc_blk_ioctl_as_set_lock before set lock=0 flag 100
[   10.510602] mmcblk: mmc_blk_ioctl_as_set_lock after set lock=0 flag 100
[   10.654683] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Opts: (null). Quota mode: none.
[   10.664872] ext4 filesystem being mounted at /mnt/bootdev.~1257
supports timestamps until 2038 (0x7fffffff)
[   12.665517] atlantic 0000:01:00.0 eth0: atlantic: link change old 0 new 10000
[   12.673201] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   12.935993] mmcblk: mmc_blk_ioctl_as_set_lock before set lock=0 flag 101
[   12.943004] mmcblk: mmc_blk_ioctl_as_set_lock after set lock=1 flag 101
[   14.195052] random: proxy_check_int: uninitialized urandom read (4
bytes read)
[   14.220088] random: proxy_check_int: uninitialized urandom read (4
bytes read)
[   14.307653] random: proxy_check_int: uninitialized urandom read (4
bytes read)
[   14.606525] random: crng init done
[   15.246308] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   17.843685] md: md126 stopped.
[   17.855921] md/raid1:md126: active with 4 out of 4 mirrors
[   17.861706] md126: detected capacity change from 0 to 4188160
[   17.933505] Adding 2094076k swap on /dev/md126.  Priority:-2
extents:1 across:2094076k SS
[   18.010100] md: md1 stopped.
[   18.018475] md/raid:md1: device nvme7n1p4 operational as raid disk 0
[   18.025144] md/raid:md1: device nvme4n1p4 operational as raid disk 11
[   18.031856] md/raid:md1: device nvme5n1p4 operational as raid disk 10
[   18.038613] md/raid:md1: device nvme8n1p4 operational as raid disk 9
[   18.045203] md/raid:md1: device nvme0n1p4 operational as raid disk 7
[   18.051834] md/raid:md1: device nvme1n1p4 operational as raid disk 6
[   18.058446] md/raid:md1: device nvme2n1p4 operational as raid disk 5
[   18.065133] md/raid:md1: device nvme3n1p4 operational as raid disk 4
[   18.071829] md/raid:md1: device nvme10n1p4 operational as raid disk 3
[   18.078512] md/raid:md1: device nvme11n1p4 operational as raid disk 2
[   18.085209] md/raid:md1: device nvme6n1p4 operational as raid disk 1
[   18.115524] md/raid:md1: raid level 6 active with 11 out of 12
devices, algorithm 2
[   18.123498] md1: detected capacity change from 0 to 78048583680
[   18.276690] BTRFS: device fsid 09c24c40-d5b3-4c7f-8500-27e7b18dad1e
devid 1 transid 17048 /dev/md1 scanned by mount (1841)
[   18.288786] BTRFS info (device md1): flagging fs with big metadata feature
[   18.296053] BTRFS info (device md1): using free space tree
[   18.303045] BTRFS info (device md1): has skinny extents
[   30.090556]  nvme9n1: p1 p2 p3 p4
[   30.563207] md: recovery of RAID array md1
[   31.193244] md: md1: recovery interrupted.
[   31.199141] mmcblk: mmc_blk_ioctl_as_set_lock before set lock=1 flag 101
[   31.207393] mmcblk: mmc_blk_ioctl_as_set_lock after set lock=1 flag 101
[   32.292981] sys_stat: module is from the staging directory, the
quality is unknown, you have been warned.
[   32.305514] asleddrv: loading out-of-tree module taints kernel.
[   32.312036] Found Chip IT8625 rev d. GPIO lines starting at 0a00h
[   34.426992] Jasperlake Buzzer Driver Initialized.
[   36.527134] i915 0000:00:02.0: vgaarb: deactivate vga console
[   36.585792] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   36.596365] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/icl_dmc_ver1_09.bin (v1.9)
[   36.636680] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[   36.645385] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
no  post: no)
[   36.674245] acpi device:16: registered as cooling_device9
[   36.680369] acpi device:17: registered as cooling_device10
[   36.686317] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[   36.697526] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   36.704245] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   36.715828] intelfb: intelfb_init
[   36.715833] intelfb: Framebuffer driver for Intel(R)
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM
chipsets
[   36.728061] intelfb: Version 0.9.6
[   36.733844] fnotify: module license 'Proprietary' taints kernel.
[   36.740095] Disabling lock debugging due to kernel taint
[   36.779897] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040380
[   36.789593] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   36.796991] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[   36.825540] snd_hda_codec_realtek hdaudioC0D0: ALC888-VD: SKU not
ready 0x00000100
[   36.834060] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC888-VD: line_outs=4 (0x14/0x16/0x15/0x17/0x0) type:line
[   36.845487] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   36.853744] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   36.861697] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   36.868268] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[   36.876090] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   36.881690] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   36.889445] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   36.895955] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   36.903372] snd_hda_codec_realtek hdaudioC0D0:      CD=0x1c
[   36.933104] RPC: Registered named UNIX socket transport module.
[   36.940366] RPC: Registered udp transport module.
[   36.946751] RPC: Registered tcp transport module.
[   36.951725] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   36.960556] input: HDA Intel PCH Rear Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[   36.974995] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   36.983463] input: HDA Intel PCH Front Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[   37.017955] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[   37.031844] input: HDA Intel PCH Line Out Front as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[   37.042419] input: HDA Intel PCH Line Out Surround as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   37.055433] input: HDA Intel PCH Line Out CLFE as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   37.071480] input: HDA Intel PCH Line Out Side as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   37.082363] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   37.096041] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   37.107094] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   37.117436] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   37.132108] input: HDA Intel PCH HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   37.142024] input: HDA Intel PCH HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   37.152094] input: HDA Intel PCH HDMI/DP,pcm=11 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   37.162118] input: HDA Intel PCH HDMI/DP,pcm=12 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   38.122827] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[   38.131020] NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
[   38.138233] NFSD: Unable to initialize client recovery tracking! (-2)
[   38.144967] NFSD: starting 90-second grace period (net f0000098)
[   38.174022] [3067]: scst: sysfs_work_thread_fn:500:User interface
thread started
[   38.181862] [3072]: scst: scst_cmd_thread:4838:Processing thread
scstd0 started
[   38.189485] [3075]: scst: scst_cmd_thread:4838:Processing thread
scstd1 started
[   38.197155] [3083]: scst: scst_cmd_thread:4838:Processing thread
scstd2 started
[   38.204826] [3086]: scst: scst_init_thread:4509:Init thread started
[   38.212594] [3084]: scst: scst_cmd_thread:4838:Processing thread
scstd3 started
[   38.220292] [3087]: scst: scst_tm_thread:6822:Task management thread started
[   38.227626] [3088]: scst: scst_global_mgmt_thread:7638:Management
thread started
[   38.235354] [3065]: scst:
__scst_register_target_template:315:Target template copy_manager
registered successfully
[   38.246042] [3065]: scst: scst_register_target:509:Target
copy_manager_tgt for template copy_manager registered successfully
[   38.257721] [3065]: scst: scst_init_session:7273:Using security
group "copy_manager_tgt" for initiator "copy_manager_sess" (target
copy_manager_tgt)
[   38.271531] [3065]: scst: init_scst:2569:SCST version 3.6.0-pre
loaded successfully (global max mem for commands ignored, per device
1577MB)
[   38.284563] [3065]: scst: scst_print_config:2319:Enabled features:
EXTRACHECKS, TRACING, DEBUG
[   38.310897] [3096]: dev_vdisk:
vdev_check_mode_pages_path:13392:***WARNING***: Unable to find
/var/lib/scst/vdev_mode_pages (err -2), saved mode pages disabled. You
should create this directory manually or reinstall SCST
[   38.332410] [3096]: scst:
__scst_register_virtual_dev_driver:1678:Virtual device handler
vdisk_fileio for type 0 registered successfully
[   38.345236] [3096]: scst:
__scst_register_virtual_dev_driver:1678:Virtual device handler
vdisk_blockio for type 0 registered successfully
[   38.358033] [3096]: scst:
__scst_register_virtual_dev_driver:1678:Virtual device handler
vdisk_nullio for type 0 registered successfully
[   38.370796] [3096]: scst:
__scst_register_virtual_dev_driver:1678:Virtual device handler vcdrom
for type 5 registered successfully
[   38.382990] [3097]: dev_vdisk:
scst_global_acti_thread:12417:activity thread started, PID 3097
[   38.415622] [3105]: iscsi-scst: iscsi_init:4290:iSCSI SCST Target -
version 3.6.0-pre
[   38.423820] [3105]: iscsi-scst: iscsit_reg_transport:52:Registered
iSCSI transport: iSCSI-TCP
[   38.432859] [3105]: scst:
__scst_register_target_template:315:Target template iscsi registered
successfully
[   38.443099] [3106]: iscsi-scst: istrd:954:Read thread for pool
000000002a7779d7 started
[   38.451451] [3107]: iscsi-scst: istrd:954:Read thread for pool
000000002a7779d7 started
[   38.459794] [3108]: iscsi-scst: istrd:954:Read thread for pool
000000002a7779d7 started
[   38.468227] [3109]: iscsi-scst: istrd:954:Read thread for pool
000000002a7779d7 started
[   38.476619] [3110]: iscsi-scst: istwr:1605:Write thread for pool
000000002a7779d7 started
[   38.485105] [3111]: iscsi-scst: istwr:1605:Write thread for pool
000000002a7779d7 started
[   38.494889] [3112]: iscsi-scst: istwr:1605:Write thread for pool
000000002a7779d7 started
[   38.503432] [3113]: iscsi-scst: istwr:1605:Write thread for pool
000000002a7779d7 started
[   38.543093] Loading iSCSI transport class v2.0-870.
[   38.563186] iscsi: registered transport (tcp)
[   40.263292] usbcore: registered new device driver usbip-host
[   41.453162] cryptodev: driver 1.12 loaded.
[   41.849823] Bluetooth: Core ver 2.22
[   41.853618] NET: Registered protocol family 31
[   41.858309] Bluetooth: HCI device and connection manager initialized
[   41.865002] Bluetooth: HCI socket layer initialized
[   41.870171] Bluetooth: L2CAP socket layer initialized
[   41.875496] Bluetooth: SCO socket layer initialized
[   41.883196] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   41.888793] Bluetooth: BNEP socket layer initialized
[   41.896985] Bluetooth: RFCOMM TTY layer initialized
[   41.902132] Bluetooth: RFCOMM socket layer initialized
[   41.908140] Bluetooth: RFCOMM ver 1.11
[   41.915246] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   41.921504] Bluetooth: HIDP socket layer initialized
[   41.941442] Bluetooth: HCI UART driver ver 2.3
[   41.946243] Bluetooth: HCI UART protocol H4 registered
[   41.951764] Bluetooth: HCI UART protocol QCA registered
[   41.967128] usbcore: registered new interface driver btusb
[   55.550389] mc: Linux media interface: v0.10
[   55.565437] usbcore: registered new interface driver snd-usb-audio
[   55.608103] md: recovery of RAID array md0
[   55.643295] md: remove_and_add_spares rdev nvme9n1p4 remove fail
[   55.643470] md: delaying recovery of md1 until md0 has finished
(they share one or more physical units)
[   56.216284] S99zzzlastbooti (3929): drop_caches: 1
[   66.108998] md: md0: recovery done.
[   66.113944] md: recovery of RAID array md1
[ 1266.094921] TCP: eth0: Driver has suspect GRO implementation, TCP
performance may be compromised.
[46019.055859] md: md1: recovery done.
[1354404.285614] smartctl: page allocation failure: order:0,
mode:0x800(GFP_NOWAIT), nodemask=(null),cpuset=/,mems_allowed=0
[1354404.297055] CPU: 2 PID: 10165 Comm: smartctl Tainted: P         C
O      5.13.x #1
[1354404.305224] Hardware name: Intel Corporation Jasper Lake Client
Platform/0123456789ABCDEF0123456789ABCDEF, BIOS V1.20 11/04/2022
[1354404.317473] Call Trace:
[1354404.320253]  dump_stack+0x6b/0x86
[1354404.323913]  warn_alloc+0xd4/0x145
[1354404.327652]  ? wake_all_kswapds+0x4f/0x87
[1354404.332033]  __alloc_pages_slowpath.constprop.123+0x7c2/0x7eb
[1354404.338196]  ? get_page_from_freelist+0x13b/0x694
[1354404.343294]  ? cfs_rq_throttled.isra.56+0x9/0x1b
[1354404.348282]  __alloc_pages+0xfe/0x159
[1354404.352316]  alloc_pages+0x81/0x88
[1354404.356055]  allocate_slab+0xaf/0x288
[1354404.360098]  ___slab_alloc+0x3fb/0x4db
[1354404.364227]  ? skb_clone+0x5e/0x77
[1354404.367958]  ? __wake_up_common+0xa8/0x11a
[1354404.372382]  ? skb_clone+0x5e/0x77
[1354404.376129]  __slab_alloc+0xd/0x17
[1354404.379851]  ? __slab_alloc+0xd/0x17
[1354404.383773]  kmem_cache_alloc+0x88/0x122
[1354404.388109]  skb_clone+0x5e/0x77
[1354404.391684]  netlink_broadcast_filtered+0x15d/0x31f
[1354404.396955]  netlink_broadcast+0xe/0x10
[1354404.401181]  cn_netlink_send_mult+0x16a/0x18e
[1354404.405951]  cn_netlink_send+0x16/0x18
[1354404.410088]  send_msg.constprop.7+0x42/0x4d
[1354404.414685]  proc_exit_connector+0xbf/0xda
[1354404.419145]  do_exit+0x85d/0x8e5
[1354404.422737]  ? send_sig_info+0x14/0x1c
[1354404.426917]  ? send_sig+0x17/0x19
[1354404.430598]  do_group_exit+0x90/0x90
[1354404.434545]  get_signal+0x307/0x5bd
[1354404.438413]  ? new_sync_write+0x77/0xaf
[1354404.442629]  arch_do_signal_or_restart+0x41/0x63a
[1354404.447728]  ? vfs_write+0xf1/0x100
[1354404.451606]  ? fdput_pos.isra.17+0x22/0x26
[1354404.456038]  exit_to_user_mode_prepare+0x76/0x124
[1354404.461172]  syscall_exit_to_user_mode+0x16/0x25
[1354404.466201]  do_syscall_64+0x65/0x6b
[1354404.470080]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[1354404.475533] RIP: 0033:0x7f28b4bb6664
[1354404.479508] Code: Unable to access opcode bytes at RIP 0x7f28b4bb663a.
[1354404.486484] RSP: 002b:00007fffde6759f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[1354404.494589] RAX: ffffffffffffffe0 RBX: 0000000000000029 RCX:
00007f28b4bb6664
[1354404.502328] RDX: 0000000000000029 RSI: 0000000000663f30 RDI:
0000000000000001
[1354404.510006] RBP: 0000000000663f30 R08: 00007f28b4c838c0 R09:
00007f28b4acff00
[1354404.517676] R10: 00007fffde675a68 R11: 0000000000000246 R12:
00007f28b4c82760
[1354404.525328] R13: 0000000000000029 R14: 00007f28b4c7d760 R15:
0000000000000029
[1354404.533006] Mem-Info:
[1354404.535560] active_anon:2174 inactive_anon:2137 isolated_anon:0
[1354404.535560]  active_file:1117227 inactive_file:2456812 isolated_file:0
[1354404.535560]  unevictable:1930 dirty:349 writeback:0
[1354404.535560]  slab_reclaimable:117903 slab_unreclaimable:82792
[1354404.535560]  mapped:3273 shmem:3463 pagetables:1113 bounce:0
[1354404.535560]  free:126601 free_pcp:1336 free_cma:0
[1354404.571987] Node 0 active_anon:8696kB inactive_anon:8548kB
active_file:4468908kB inactive_file:9827248kB unevictable:7720kB
isolated(anon):0kB isolated(file):0kB mapped:13092kB dirty:1396kB
writeback:0kB shmem:13852kB writeback_tmp:0kB kernel_stack:3904kB
pagetables:4452kB all_unreclaimable? no
[1354404.599941] Node 0 DMA free:15360kB min:120kB low:148kB
high:176kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[1354404.627117] lowmem_reserve[]: 0 1684 15742 15742
[1354404.632206] Node 0 DMA32 free:69548kB min:13736kB low:17168kB
high:20600kB reserved_highatomic:0KB active_anon:148kB
inactive_anon:152kB active_file:330136kB inactive_file:1182676kB
unevictable:0kB writepending:0kB present:1828964kB managed:1744132kB
mlocked:0kB bounce:0kB free_pcp:1104kB local_pcp:0kB free_cma:0kB
[1354404.661934] lowmem_reserve[]: 0 0 14058 14058
[1354404.666764] Node 0 Normal free:421496kB min:114676kB low:143344kB
high:172012kB reserved_highatomic:2048KB active_anon:8548kB
inactive_anon:8592kB active_file:4138772kB inactive_file:8645648kB
unevictable:7720kB writepending:428kB present:14684160kB
managed:14395832kB mlocked:7640kB bounce:0kB free_pcp:4240kB
local_pcp:280kB free_cma:0kB
[1354404.698682] lowmem_reserve[]: 0 0 0 0
[1354404.702714] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
[1354404.715263] Node 0 DMA32: 2051*4kB (UME) 1593*8kB (UME) 1461*16kB
(UME) 558*32kB (UME) 108*64kB (UE) 5*128kB (UME) 1*256kB (M) 0*512kB
0*1024kB 0*2048kB 0*4096kB = 69988kB
[1354404.731727] Node 0 Normal: 6160*4kB (UM) 16368*8kB (UME)
4841*16kB (UMEH) 3591*32kB (UMEH) 882*64kB (MH) 90*128kB (M) 21*256kB
(M) 0*512kB 1*1024kB (H) 0*2048kB 0*4096kB = 422320kB
[1354404.748932] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[1354404.758115] 3578326 total pagecache pages
[1354404.762591] 476 pages in swap cache
[1354404.766520] Swap cache stats: add 50169, delete 49692, find
12157134/12169109
[1354404.774267] Free swap  = 2002684kB
[1354404.778075] Total swap = 2094076kB
[1354404.781873] 4132279 pages RAM
[1354404.785310] 0 pages HighMem/MovableOnly
[1354404.789604] 93448 pages reserved
[1354404.793308] 0 pages hwpoisoned
[1354404.796762] SLUB: Unable to allocate memory on node -1,
gfp=0x800(GFP_NOWAIT)
[1354404.804462]   cache: skbuff_head_cache, object size: 224, buffer
size: 256, default order: 0, min order: 0
[1354404.814972]   node 0: slabs: 44, objs: 704, free: 0
[1698613.750206] smartctl: page allocation failure: order:0,
mode:0x800(GFP_NOWAIT), nodemask=(null),cpuset=/,mems_allowed=0
[1698613.761666] CPU: 2 PID: 21408 Comm: smartctl Tainted: P         C
O      5.13.x #1
[1698613.769825] Hardware name: Intel Corporation Jasper Lake Client
Platform/0123456789ABCDEF0123456789ABCDEF, BIOS V1.20 11/04/2022
[1698613.782209] Call Trace:
[1698613.784987]  dump_stack+0x6b/0x86
[1698613.788785]  warn_alloc+0xd4/0x145
[1698613.792636]  ? wake_all_kswapds+0x4f/0x87
[1698613.797154]  __alloc_pages_slowpath.constprop.123+0x7c2/0x7eb
[1698613.803590]  ? get_page_from_freelist+0x13b/0x694
[1698613.808766]  ? smp_send_reschedule+0xa/0xc
[1698613.813309]  ? resched_curr+0x5d/0x5f
[1698613.817359]  __alloc_pages+0xfe/0x159
[1698613.821444]  alloc_pages+0x81/0x88
[1698613.825174]  allocate_slab+0xaf/0x288
[1698613.829202]  ___slab_alloc+0x3fb/0x4db
[1698613.833323]  ? skb_clone+0x5e/0x77
[1698613.837079]  ? __wake_up_common+0xa8/0x11a
[1698613.841615]  ? skb_clone+0x5e/0x77
[1698613.845309]  __slab_alloc+0xd/0x17
[1698613.849084]  ? __slab_alloc+0xd/0x17
[1698613.852955]  kmem_cache_alloc+0x88/0x122
[1698613.857284]  skb_clone+0x5e/0x77
[1698613.860823]  netlink_broadcast_filtered+0x15d/0x31f
[1698613.866070]  netlink_broadcast+0xe/0x10
[1698613.870277]  cn_netlink_send_mult+0x16a/0x18e
[1698613.875037]  cn_netlink_send+0x16/0x18
[1698613.879157]  send_msg.constprop.7+0x42/0x4d
[1698613.883702]  proc_exit_connector+0xbf/0xda
[1698613.888179]  do_exit+0x85d/0x8e5
[1698613.891736]  ? send_sig_info+0x14/0x1c
[1698613.895796]  ? send_sig+0x17/0x19
[1698613.899406]  do_group_exit+0x90/0x90
[1698613.903290]  get_signal+0x307/0x5bd
[1698613.907135]  ? new_sync_write+0x77/0xaf
[1698613.911349]  arch_do_signal_or_restart+0x41/0x63a
[1698613.916501]  ? vfs_write+0xf1/0x100
[1698613.920362]  ? fdput_pos.isra.17+0x22/0x26
[1698613.924836]  exit_to_user_mode_prepare+0x76/0x124
[1698613.930030]  syscall_exit_to_user_mode+0x16/0x25
[1698613.935069]  do_syscall_64+0x65/0x6b
[1698613.939016]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[1698613.944443] RIP: 0033:0x7fa240cca664
[1698613.948380] Code: Unable to access opcode bytes at RIP 0x7fa240cca63a.
[1698613.955400] RSP: 002b:00007ffed70b8408 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[1698613.963537] RAX: ffffffffffffffe0 RBX: 0000000000000029 RCX:
00007fa240cca664
[1698613.971232] RDX: 0000000000000029 RSI: 0000000001304f30 RDI:
0000000000000001
[1698613.978920] RBP: 0000000001304f30 R08: 00007fa240d978c0 R09:
00007fa240be3f00
[1698613.986598] R10: 00007ffed70b8478 R11: 0000000000000246 R12:
00007fa240d96760
[1698613.994319] R13: 0000000000000029 R14: 00007fa240d91760 R15:
0000000000000029
[1698614.001980] Mem-Info:
[1698614.004611] active_anon:2297 inactive_anon:2856 isolated_anon:0
[1698614.004611]  active_file:1372504 inactive_file:2004674 isolated_file:32
[1698614.004611]  unevictable:1930 dirty:1857 writeback:17
[1698614.004611]  slab_reclaimable:294486 slab_unreclaimable:113172
[1698614.004611]  mapped:3262 shmem:3520 pagetables:1178 bounce:0
[1698614.004611]  free:112852 free_pcp:1239 free_cma:0
[1698614.041088] Node 0 active_anon:9188kB inactive_anon:11424kB
active_file:5490016kB inactive_file:8018696kB unevictable:7720kB
isolated(anon):0kB isolated(file):128kB mapped:13048kB dirty:7428kB
writeback:68kB shmem:14080kB writeback_tmp:0kB kernel_stack:3968kB
pagetables:4712kB all_unreclaimable? no
[1698614.068832] Node 0 DMA free:15360kB min:120kB low:148kB
high:176kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
[1698614.095708] lowmem_reserve[]: 0 1684 15742 15742
[1698614.100795] Node 0 DMA32 free:100760kB min:19880kB low:23312kB
high:26744kB reserved_highatomic:0KB active_anon:24kB
inactive_anon:792kB active_file:283032kB inactive_file:1143244kB
unevictable:0kB writepending:2416kB present:1828964kB
managed:1744132kB mlocked:0kB bounce:0kB free_pcp:312kB
local_pcp:296kB free_cma:0kB
[1698614.130998] lowmem_reserve[]: 0 0 14058 14058
[1698614.135757] Node 0 Normal free:335288kB min:114676kB low:143344kB
high:172012kB reserved_highatomic:2048KB active_anon:9164kB
inactive_anon:10868kB active_file:5207760kB inactive_file:6874460kB
unevictable:7720kB writepending:5328kB present:14684160kB
managed:14395832kB mlocked:7640kB bounce:0kB free_pcp:4644kB
local_pcp:1412kB free_cma:0kB
[1698614.167822] lowmem_reserve[]: 0 0 0 0
[1698614.171863] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
[1698614.184472] Node 0 DMA32: 3756*4kB (UME) 3038*8kB (UME) 2788*16kB
(UME) 458*32kB (UME) 55*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 102112kB
[1698614.199987] Node 0 Normal: 15758*4kB (UME) 8927*8kB (UME)
9836*16kB (UMEH) 1302*32kB (UMEH) 5*64kB (MH) 0*128kB 0*256kB 0*512kB
1*1024kB (H) 0*2048kB 0*4096kB = 334832kB
[1698614.216163] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[1698614.225335] 3382012 total pagecache pages
[1698614.229729] 1112 pages in swap cache
[1698614.233652] Swap cache stats: add 55484, delete 54371, find
15766528/15781176
[1698614.241371] Free swap  = 2002428kB
[1698614.245170] Total swap = 2094076kB
[1698614.248979] 4132279 pages RAM
[1698614.252370] 0 pages HighMem/MovableOnly
[1698614.256758] 93448 pages reserved
[1698614.260454] 0 pages hwpoisoned
[1698614.263935] SLUB: Unable to allocate memory on node -1,
gfp=0x800(GFP_NOWAIT)
[1698614.271680]   cache: skbuff_head_cache, object size: 224, buffer
size: 256, default order: 0, min order: 0
[1698614.281979]   node 0: slabs: 32, objs: 512, free: 64
[1933116.236646] nvme nvme9: I/O 119 QID 2 timeout, aborting
[1933116.242365] nvme nvme9: I/O 120 QID 2 timeout, aborting
[1933141.324640] nvme nvme9: I/O 1 QID 0 timeout, reset controller
[1933146.444701] nvme nvme9: I/O 119 QID 2 timeout, reset controller
[1933215.826997] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933215.839856] nvme nvme9: Abort status: 0x371
[1933215.844475] nvme nvme9: Abort status: 0x371
[1933226.357672] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933226.364390] nvme nvme9: Removing after probe failure status: -19
[1933236.879570] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[1933236.886392] nvme9n1: detected capacity change from 7814037168 to 0
[1933236.886392] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
[1933236.886392] md/raid1:md0: Operation continuing on 11 devices.
[1933236.886395] md/raid1:md0: nvme9n1p2: rescheduling sector 3912
[1933236.887190] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
[1933236.887193] md/raid:md1: Operation continuing on 11 devices.
[1933236.890001] md: remove_and_add_spares bdev /dev/nvme9n1p2 exist
[1933236.890377] md: remove_and_add_spares bdev /dev/nvme9n1p4 exist
[1933236.893420] asustor remove disk dev nvme9n1
[1933236.912814] md/raid1:md0: redirecting sector 3912 to other
mirror: nvme7n1p2
[1933236.936634] md: remove_and_add_spares bdev /dev/nvme9n1p4 exist
[1933236.936643] md: remove_and_add_spares rdev nvme9n1p4 remove sucess
[1933236.938640] md: remove_and_add_spares bdev /dev/nvme9n1p2 exist
[1933236.938655] md: remove_and_add_spares rdev nvme9n1p2 remove sucess

Regards,
Justin

