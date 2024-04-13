Return-Path: <linux-kernel+bounces-143647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B90578A3BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CE0B216F2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678724A0D;
	Sat, 13 Apr 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTAoom3T"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75B1CABD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712999976; cv=none; b=WwebU/0DGv5aP0uD1qntvr48aCGgBFj9cl5T4h3/LnxQLKP5yODA89EQG/KOkkcR/2F5TsYbK0RLqFCstfqPbs4FOFingKsn9rKW1NOXq9p5pmbA1BA416QOpO8piK5xXlXjmnIrN3+r1wdD26KJb4stcgL06lcf7M9K9Ma8V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712999976; c=relaxed/simple;
	bh=LTMcrDIJTbqAkvmDHxX6QQA95s2VjtqES7sMFmjIehI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgITbJIsmklK4Y+WGKddpG+DsMTkGkme0VR5DLln/qXfxZvRlgo0zV6iRtEq7P/Bh4O01wqzTuw3eOYzfoJUsCqkhSt0h39OlTxuGv8fBx4V2ivuVzELKpSo4K91084ByTygWvEcOtTux6SV52aWwyfHT/UD845I/nrjvcAnv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTAoom3T; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa22ebd048so1170440eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712999973; x=1713604773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEvnMY8W9PXXXbrbbWw+Pj8L+I5c86poum1l+dsHa4E=;
        b=dTAoom3TlL8+UE4DOP4ePZT7oZEmF1iUec4hPGMB3nkATxR/5+jQ5uAlmuPg9C6h2F
         9RXckfdAp25ZGn3ZHKc9NLulWPEABdih47U6e58VOHK64d90xZ8Kk3jwF0irwEwh0Yu2
         6OFAzp+xf35P0nogT1Kj9f8hiXztu7N+eblBLaBZusD2/H5jwRLo3LQOX4ZNuZsx4o/7
         xvutKmUrgNU/3hMkoKZeCWVgLFpLnVRJLx7xVG57oHpWr4lwJfXqTaqzNaq7yxJXYe2N
         /XZGqXsku8+6SJLvF3BdrFDCooLHKgKpgKVafJy/hVst9YgtPLFWknp06FN+dSbCB/vM
         uoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712999973; x=1713604773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEvnMY8W9PXXXbrbbWw+Pj8L+I5c86poum1l+dsHa4E=;
        b=pOrC3KlFr4g4oVv3xjw1ucGsik6JLJVflwBK8ZZZxyxacegiTu9FLN1SU1q0PzYy7+
         Lzey39rs/Ren5t1APuIhHhpCVZrNE0qsWhjiBsAZ2b73A0pUjJbjhKy9i5fq+oax6mZB
         t11z634JqPiFQOQm2Cp6Ydl7BbTS4LYFvDpNxd6KACg8beJw3klXXoiBfZWkACsQlGu4
         QRNHpnANGFAoXugT7TMrGahQEewCyh/9UJsL/7QXul2GRQD0wAMMykNMDPIzrf6kPRep
         k7/N07Q4AdOI+8qfrMeK22EA83P1OWa83V7aq4aQPgcMZ0opss3dw6eiXt74m1yVnBDh
         l/CQ==
X-Gm-Message-State: AOJu0YzgBoT+qW9J477/Con6gJzOD6YhgErvNIUpZDxTq+Zb8pwUtaT0
	/Nkdw/KAWL5dzKTCpD4yb50ZYHAR402mRbOhULCzHBltEGeI5mrc
X-Google-Smtp-Source: AGHT+IGTdhFaivxiNZAFiPHAeOZOZlE20VKtn572j9zZ/E8DY4RYWUUzDiXkQ1o0iOPb2VZRMJ207Q==
X-Received: by 2002:a05:6358:6a91:b0:183:a0ac:b5c2 with SMTP id n17-20020a0563586a9100b00183a0acb5c2mr4260148rwh.11.1712999973023;
        Sat, 13 Apr 2024 02:19:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090ab88500b0029ffcf1df72sm5513540pjr.38.2024.04.13.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 02:19:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8D9F01808BB5E; Sat, 13 Apr 2024 16:19:29 +0700 (WIB)
Date: Sat, 13 Apr 2024 16:19:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Erhard Furtner <erhard_f@mailbox.org>, x86@kernel.org,
	Linux Regressions <regressions@lists.linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
Message-ID: <ZhpOIeVq1KQXzjBp@archie.me>
References: <20240413024956.488d474e@yea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/iJPQZ35WTB9jlFo"
Content-Disposition: inline
In-Reply-To: <20240413024956.488d474e@yea>


--/iJPQZ35WTB9jlFo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 02:49:56AM +0200, Erhard Furtner wrote:
> Greetings!
>=20
> With MITIGATION_RETHUNK=3Dy selected in kernel .config v6.9-rc3 fails to =
boot on my Thinkpad T60. The resulting kernel stalls booting at "x86/fpu: x=
87 FPU will use FXSAVE":
>=20
> Linux version 6.9.0-rc3-P3 (root@supah) (gcc (Gentoo 13.2.1_p20240210 p14=
) 13.2.1 20240210, GNU ld (Gentoo 2.41 p5) 2.41.0) #3 SMP Fri Apr 12 20:09:=
09 -00 2024
> KERNEL supported cpus:
>   Intel GenuineIntel
> Disabled fast string operations
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
> BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000dc000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000bfecffff] usable
> BIOS-e820: [mem 0x00000000bfed0000-0x00000000bfedefff] ACPI data
> BIOS-e820: [mem 0x00000000bfedf000-0x00000000bfefffff] ACPI NVS
> BIOS-e820: [mem 0x00000000bff00000-0x00000000bfffffff] reserved
> BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
> BIOS-e820: [mem 0x00000000fed00000-0x00000000fed003ff] reserved
> BIOS-e820: [mem 0x00000000fed14000-0x00000000fed19fff] reserved
> BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> NX (Execute Disable) protection: active
> APIC: Static calls initialized
> SMBIOS 2.4 present.
> DMI: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
> tsc: Fast TSC calibration using PIT
> tsc: Detected 1828.722 MHz processor
> last_pfn =3D 0xbfed0 max_arch_pfn =3D 0x1000000
> total RAM covered: 3071M
> Found optimal setting for mtrr clean up
>  gran_size: 64K 	chunk_size: 2M 	num_reg: 3  	lose cover RAM: 0G
> MTRR map: 8 entries (6 fixed + 2 variable; max 22), built from 8 variable=
 MTRRs
> x86/PAT: PAT not supported by the CPU.
> x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC =20
> found SMP MP-table at [mem 0x000f6810-0x000f681f]
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000000000F67E0 000024 (v02 LENOVO)
> ACPI: XSDT 0x00000000BFED14A0 000084 (v01 LENOVO TP-79    00002270  LTP 0=
0000000)
> ACPI: FACP 0x00000000BFED1600 0000F4 (v03 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 64/32 =
(20230628/tbfadt-564)
> ACPI BIOS Warning (bug): Optional FADT field Gpe1Block has valid Address =
but zero Length: 0x000000000000102C/0x0 (20230628/tbfadt-615)
> ACPI: DSDT 0x00000000BFED195E 00D467 (v01 LENOVO TP-79    00002270 MSFT 0=
100000E)
> ACPI: FACS 0x00000000BFEF4000 000040
> ACPI: FACS 0x00000000BFEF4000 000040
> ACPI: SSDT 0x00000000BFED17B4 0001AA (v01 LENOVO TP-79    00002270 MSFT 0=
100000E)
> ACPI: ECDT 0x00000000BFEDEDC5 000052 (v01 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI: TCPA 0x00000000BFEDEE17 000032 (v02 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI: APIC 0x00000000BFEDEE49 000068 (v01 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI: MCFG 0x00000000BFEDEEB1 00003C (v01 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI: HPET 0x00000000BFEDEEED 000038 (v01 LENOVO TP-79    00002270 LNVO 0=
0000001)
> ACPI: BOOT 0x00000000BFEDEFD8 000028 (v01 LENOVO TP-79    00002270  LTP 0=
0000001)
> ACPI: SSDT 0x00000000BFEF2655 00025F (v01 LENOVO TP-79    00002270 INTL 2=
0050513)
> ACPI: SSDT 0x00000000BFEF28B4 0000A6 (v01 LENOVO TP-79    00002270 INTL 2=
0050513)
> ACPI: SSDT 0x00000000BFEF295A 0004F7 (v01 LENOVO TP-79    00002270 INTL 2=
0050513)
> ACPI: SSDT 0x00000000BFEF2E51 0001D8 (v01 LENOVO TP-79    00002270 INTL 2=
0050513)
> ACPI: Reserving FACP table memory at [mem 0xbfed1600-0xbfed16f3]
> ACPI: Reserving DSDT table memory at [mem 0xbfed195e-0xbfededc4]
> ACPI: Reserving FACS table memory at [mem 0xbfef4000-0xbfef403f]
> ACPI: Reserving FACS table memory at [mem 0xbfef4000-0xbfef403f]
> ACPI: Reserving SSDT table memory at [mem 0xbfed17b4-0xbfed195d]
> ACPI: Reserving ECDT table memory at [mem 0xbfededc5-0xbfedee16]
> ACPI: Reserving TCPA table memory at [mem 0xbfedee17-0xbfedee48]
> ACPI: Reserving APIC table memory at [mem 0xbfedee49-0xbfedeeb0]
> ACPI: Reserving MCFG table memory at [mem 0xbfedeeb1-0xbfedeeec]
> ACPI: Reserving HPET table memory at [mem 0xbfedeeed-0xbfedef24]
> ACPI: Reserving BOOT table memory at [mem 0xbfedefd8-0xbfedefff]
> ACPI: Reserving SSDT table memory at [mem 0xbfef2655-0xbfef28b3]
> ACPI: Reserving SSDT table memory at [mem 0xbfef28b4-0xbfef2959]
> ACPI: Reserving SSDT table memory at [mem 0xbfef295a-0xbfef2e50]
> ACPI: Reserving SSDT table memory at [mem 0xbfef2e51-0xbfef3028]
> 2184MB HIGHMEM available.
> 885MB LOWMEM available.
>   mapped low ram: 0 - 375fe000
>   low ram: 0 - 375fe000
> Zone ranges:
>   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>   Normal   [mem 0x0000000001000000-0x00000000375fdfff]
>   HighMem  [mem 0x00000000375fe000-0x00000000bfecffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000001000-0x000000000009efff]
>   node   0: [mem 0x0000000000100000-0x00000000bfecffff]
> Initmem setup node 0 [mem 0x0000000000001000-0x00000000bfecffff]
> On node 0, zone DMA: 1 pages in unavailable ranges
> On node 0, zone DMA: 97 pages in unavailable ranges
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: Using ACPI (MADT) for SMP configuration information
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> CPU topo: Max. logical packages:   1
> CPU topo: Max. logical dies:       1
> CPU topo: Max. dies per package:   1
> CPU topo: Max. threads per core:   1
> CPU topo: Num. cores per package:     2
> CPU topo: Num. threads per package:   2
> CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
> [mem 0xc0000000-0xefffffff] available for PCI devices
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, ma=
x_idle_ns: 6370452778343963 ns
> setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
> percpu: Embedded 44 pages/cpu s89216 r0 d91008 u180224
> Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-rc3-P3 root=3DPARTU=
UID=3Df6cdabc7-801d-4572-9de8-9b696dc216cc ro systemd.gpt_auto=3Dno mce=3D0=
 slub_debug=3DFZP page_poison=3D1 netconsole=3D6666@192.168.2.10/eth0,6666@=
192.168.2.3/A8:A1:59:16:4F:EA
> Unknown kernel command line parameters "BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-=
rc3-P3", will be passed to user space.
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> Built 1 zonelists, mobility grouping on.  Total pages: 783815
> allocated 3148604 bytes of page_ext
> mem auto-init: stack:all(pattern), heap alloc:off, heap free:off
> Initializing HighMem for node 0 (000375fe:000bfed0)
> Initializing Movable for node 0 (00000000:00000000)
> Checking if this processor honours the WP bit even in supervisor mode...O=
k.
> Memory: 3091260K/3144120K available (9854K kernel code, 555K rwdata, 2532=
K rodata, 764K init, 320K bss, 52860K reserved, 0K cma-reserved, 2237256K h=
ighmem)
> **********************************************************
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **                                                      **
> ** This system shows unhashed kernel memory addresses   **
> ** via the console, logs, and other interfaces. This    **
> ** might reduce the security of your system.            **
> **                                                      **
> ** If you see this message and you are not debugging    **
> ** the kernel, report this immediately to your system   **
> ** administrator!                                       **
> **                                                      **
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **********************************************************
> SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
> Kernel/User page tables isolation: enabled
> rcu: Hierarchical RCU implementation.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
> RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=3D1.
> NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> kfence: initialized - using 2097152 bytes for 255 objects at 0xf51e0000-0=
xf53e0000
> Console: colour VGA+ 80x25
> printk: legacy console [tty0] enabled
> ACPI: Core revision 20230628
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: =
133484882848 ns
> APIC: Switch to symmetric I/O mode setup
> ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1a5c261a01=
f, max_idle_ns: 440795236171 ns
> Calibrating delay loop (skipped), value calculated using timer frequency.=
=2E 3658.83 BogoMIPS (lpj=3D6095740)
> Disabled fast string operations
> CPU0: Thermal monitoring enabled (TM2)
> Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
> Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
> process: using mwait in idle threads
> Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sani=
tization
> Spectre V2 : Mitigation: Retpolines
> Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context s=
witch
> Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> L1TF: System has more than MAX_PA/2 memory. L1TF mitigation not effective.
> L1TF: You may make it effective by booting the kernel with mem=3D21474836=
48 parameter.
> L1TF: However, doing so will make a part of your RAM unusable.
> L1TF: Reading https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/=
l1tf.html might help you decide.
> MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> MMIO Stale Data: Unknown: No mitigations
> x86/fpu: x87 FPU will use FXSAVE
>=20
> Without MITIGATION_RETHUNK selected v6.9-rc3 boots fine. Also v6.8.5 with=
 MITIGATION_RETHUNK=3Dy selected boots fine. So I bisected the issue and go=
t this result:
>=20
>  # git bisect good
> 4461438a8405e800f90e0e40409e5f3d07eed381 is the first bad commit
> commit 4461438a8405e800f90e0e40409e5f3d07eed381
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> Date:   Wed Jan 3 19:36:26 2024 +0100
>=20
>     x86/retpoline: Ensure default return thunk isn't used at runtime
>    =20
>     Make sure the default return thunk is not used after all return
>     instructions have been patched by the alternatives because the default
>     return thunk is insufficient when it comes to mitigating Retbleed or
>     SRSO.
>    =20
>     Fix based on an earlier version by David Kaplan <david.kaplan@amd.com=
>.
>    =20
>       [ bp: Fix the compilation error of warn_thunk_thunk being an invisi=
ble
>             symbol, hoist thunk macro into calling.h ]
>    =20
>     Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>     Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@=
amd.com
>     Link: https://lore.kernel.org/r/20240104132446.GEZZaxnrIgIyat0pqf@fat=
_crate.local
>=20
>  arch/x86/entry/calling.h             | 60 ++++++++++++++++++++++++++++++=
++++++
>  arch/x86/entry/entry.S               |  4 +++
>  arch/x86/entry/thunk_32.S            | 34 +++++---------------
>  arch/x86/entry/thunk_64.S            | 33 --------------------
>  arch/x86/include/asm/nospec-branch.h |  2 ++
>  arch/x86/kernel/cpu/bugs.c           |  5 +++
>  arch/x86/lib/retpoline.S             | 15 ++++-----
>  7 files changed, 85 insertions(+), 68 deletions(-)
>=20
>=20
> Indeed when reverting 4461438a8405e800f90e0e40409e5f3d07eed381 v6.9-rc3 b=
oots
> fine again. Reverting the commit was not straight forward however, I had =
to
> remove "THUNK warn_thunk_thunk, __warn_thunk" from v6-9-rc3s
> arch/x86/entry/entry.S to make the kernel build. Otherwise it would compl=
ain
> about "Error: no such instruction: `thunk warn_thunk_thunk,__warn_thunk'"
>=20
> Some data about the machine:
>=20
>  # inxi -bz
> System:
>   Kernel: 6.9.0-rc3-P3 arch: i686 bits: 32 Console: pty pts/0 Distro: Gen=
too
>     Base System release 2.14
> Machine:
>   Type: Laptop System: LENOVO product: 2007F2G v: ThinkPad T60
>     serial: <filter>
>   Mobo: LENOVO model: 2007F2G serial: <filter> BIOS: LENOVO
>     v: 79ETE7WW (2.27 ) date: 03/21/2011
> Battery:
>   ID-1: BAT0 charge: 0 Wh (0.0%) condition: 35.7/56.2 Wh (63.6%) volts: 7=
=2E4
>     min: 10.8
> CPU:
>   Info: dual core Intel T2400 [MCP] speed (MHz): avg: 1000 min/max: 1000/=
1833
> Graphics:
>   Device-1: AMD RV515/M52 [Mobility Radeon X1300] driver: radeon v: kernel
>   Display: x11 server: X.org v: 1.21.1.11 driver: X: loaded: radeon
>     unloaded: fbdev,modesetting dri: r300 gpu: radeon
>     resolution: <missing: xdpyinfo/xrandr> resolution: 1024x768
>   API: OpenGL v: 4.5 vendor: mesa v: 24.0.4 renderer: llvmpipe (LLVM 17.0=
=2E6
>     128 bits)
> Network:
>   Device-1: Intel 82573L Gigabit Ethernet driver: e1000e
>   Device-2: Intel PRO/Wireless 3945ABG [Golan] Network driver: iwl3945
> Drives:
>   Local Storage: total: 465.76 GiB used: 10.26 GiB (2.2%)
> Info:
>   Processes: 159 Uptime: 1m Memory: total: 3 GiB available: 2.95 GiB
>   used: 477.2 MiB (15.8%) igpu: 128 KiB Shell: Bash inxi: 3.3.30
>=20
>  # lscpu=20
> Architecture:             i686
>   CPU op-mode(s):         32-bit
>   Address sizes:          32 bits physical, 32 bits virtual
>   Byte Order:             Little Endian
> CPU(s):                   2
>   On-line CPU(s) list:    0,1
> Vendor ID:                GenuineIntel
>   BIOS Vendor ID:         GenuineIntel
>   Model name:             Genuine Intel(R) CPU           T2400  @ 1.83GHz
>     BIOS Model name:      Genuine Intel(R) CPU             CPU @ 1.8GHz
>     BIOS CPU family:      1
>     CPU family:           6
>     Model:                14
>     Thread(s) per core:   1
>     Core(s) per socket:   2
>     Socket(s):            1
>     Stepping:             8
>     CPU(s) scaling MHz:   54%
>     CPU max MHz:          1833,0000
>     CPU min MHz:          1000,0000
>     BogoMIPS:             3658,83
>     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtr=
r pge mca cmov clflush=20
>                           dts acpi mmx fxsr sse sse2 ht tm pbe nx constan=
t_tsc arch_perfmon bts=20
>                           cpuid aperfmperf pni monitor vmx est tm2 xtpr p=
dcm pti dtherm
> Virtualization features: =20
>   Virtualization:         VT-x
> Caches (sum of all):     =20
>   L1d:                    64 KiB (2 instances)
>   L1i:                    64 KiB (2 instances)
>   L2:                     2 MiB (1 instance)
>=20
>=20
> Attached please find the kernel .config and the bisect.log.
>=20
> Regards,
> Erhard


> git bisect start
> # Status: warte auf guten und schlechten Commit
> # good: [b95f2066a910ace64787dc4f3e1dfcb2e7e71718] Linux 6.8.5
> git bisect good b95f2066a910ace64787dc4f3e1dfcb2e7e71718
> # Status: warte auf schlechten Commit, 1 guter Commit bekannt
> # bad: [fec50db7033ea478773b159e0e2efb135270e3b7] Linux 6.9-rc3
> git bisect bad fec50db7033ea478773b159e0e2efb135270e3b7
> # good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
> git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
> # bad: [e5e038b7ae9da96b93974bf072ca1876899a01a3] Merge tag 'fs_for_v6.9-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> git bisect bad e5e038b7ae9da96b93974bf072ca1876899a01a3
> # bad: [1f440397665f4241346e4cc6d93f8b73880815d1] Merge tag 'docs-6.9' of=
 git://git.lwn.net/linux
> git bisect bad 1f440397665f4241346e4cc6d93f8b73880815d1
> # bad: [508f34f2381eb84b2335abb970b940aefef50a19] Merge tag 'm68k-for-v6.=
9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
> git bisect bad 508f34f2381eb84b2335abb970b940aefef50a19
> # good: [8ede842f669b6f78812349bbef4d1efd0fbdafce] Merge tag 'rust-6.9' o=
f https://github.com/Rust-for-Linux/linux
> git bisect good 8ede842f669b6f78812349bbef4d1efd0fbdafce
> # good: [bfdb395a7cde12d83a623949ed029b0ab38d765b] Merge tag 'x86_mtrr_fo=
r_v6.9_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good bfdb395a7cde12d83a623949ed029b0ab38d765b
> # bad: [685d98211273f60e38a6d361b62d7016c545297e] Merge tag 'x86-core-202=
4-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 685d98211273f60e38a6d361b62d7016c545297e
> # good: [b0402403e54ae9eb94ce1cbb53c7def776e97426] Merge tag 'edac_update=
s_for_v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras
> git bisect good b0402403e54ae9eb94ce1cbb53c7def776e97426
> # bad: [cb81deefb59de01325ab822f900c13941bfaf67f] x86/idle: Sanitize X86_=
BUG_AMD_E400 handling
> git bisect bad cb81deefb59de01325ab822f900c13941bfaf67f
> # good: [3a1d3829e193c091475ceab481c5f8deab385023] x86/percpu: Avoid spar=
se warning with cast to named address space
> git bisect good 3a1d3829e193c091475ceab481c5f8deab385023
> # bad: [4461438a8405e800f90e0e40409e5f3d07eed381] x86/retpoline: Ensure d=
efault return thunk isn't used at runtime
> git bisect bad 4461438a8405e800f90e0e40409e5f3d07eed381
> # good: [aefb2f2e619b6c334bcb31de830aa00ba0b11129] x86/bugs: Rename CONFI=
G_RETPOLINE            =3D> CONFIG_MITIGATION_RETPOLINE
> git bisect good aefb2f2e619b6c334bcb31de830aa00ba0b11129
> # good: [1da8d2172ce5175118929363fe568e41f24ad3d6] x86/bugs: Rename CONFI=
G_CPU_IBRS_ENTRY       =3D> CONFIG_MITIGATION_IBRS_ENTRY
> git bisect good 1da8d2172ce5175118929363fe568e41f24ad3d6
> # good: [0911b8c52c4d68c57d02f172daa55a42bce703f0] x86/bugs: Rename CONFI=
G_RETHUNK              =3D> CONFIG_MITIGATION_RETHUNK
> git bisect good 0911b8c52c4d68c57d02f172daa55a42bce703f0
> # first bad commit: [4461438a8405e800f90e0e40409e5f3d07eed381] x86/retpol=
ine: Ensure default return thunk isn't used at runtime

Also Cc: regressions mailing lists and related maintainers.

--=20
An old man doll... just what I always wanted! - Clara

--/iJPQZ35WTB9jlFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhpOHQAKCRD2uYlJVVFO
o3DsAQDur6IgBaynejIZtQWN1lYcCDcDddXLP3TPQfY2KVRgtwD+M3e/x4KDjkv9
VZYJSwJZ2SSuDYANdWb2U+AjoJP3TAE=
=cIno
-----END PGP SIGNATURE-----

--/iJPQZ35WTB9jlFo--

