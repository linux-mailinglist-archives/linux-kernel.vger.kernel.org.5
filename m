Return-Path: <linux-kernel+bounces-106087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E387E8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9AA2821DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79585374D3;
	Mon, 18 Mar 2024 11:44:14 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE92EB05;
	Mon, 18 Mar 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762253; cv=none; b=ECnbnggNDXBMCMUCUei61FUa4YiTPLh+OBdLWmjQc8KSPuJQuTqEJfD9kTlaiH6dNa3PrAeP3VF72rDUTEmsdGjegwSsmxjydI1o3nADiKbd4L46TqnoZKCSwbkeB9RyxlZWdCq+XaNACteQynmsLTnf8OmsmiSiSIorEaraVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762253; c=relaxed/simple;
	bh=fm9f5sEjxwJilAjXMsib9RssHKpDR14Z/SGHXDC9leQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvWVBp4K2KYgvoqadXgdkrIbGhabfo1LmJvaxVAnr2D74Arrt5BBYirshol2QI8I3j0Zk7eqrp1QNtIsbu6EllYQmqywL1mZkiTe/cbLagYVKOD/vsqKLiWhYj6W/lurLPeuA0pGNh11ydPCdGL2ab27HxEhF6GGibJQ7tkFQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso4764667e87.3;
        Mon, 18 Mar 2024 04:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762249; x=1711367049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6IZqzz3rILslSOETOOaPrvrM3Xa9JBLiQ2zKyYSlIw=;
        b=QVd7D6xYxSvWhxS5jeQ/uucL6JCv5jf3lRJSZPJV8uNocCgynJ2hyiVhLJuMXevBB9
         WIGs2dp0fuq+HtqnPSE+hoyC9RCB+a260oCK4tfBwAGD63FIYd06+aqYCG+a22GYk/nE
         nlktiSMfA5TBfxx0MRfwK+hMHnIYJgfLiA/agrcYd0LDyfLAYPI2ux4k6bzyrU/2XEBu
         rzSq0nVn1YvEFRaNymKOZlEEZhe0etyV3NkXmoISnJLw/A9umJtE0qHQzMHfQ9+uqcLy
         Tf7phCHBaqXgl1XHbX/WCAzmyLAU1UW4XL02iFuSYwePoch94/vcj611OLPwyxTyPEtF
         IYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjnvztu7MYTV4F3dzdZRlX3l0M3frIW8DkpCYYRag30Ag7phldm4a5sAG4MYjZMFNjutpHHFmpjMVBPqKfEtd4iqXkOVgCHbSdnMk9rzb95/IuGebI4ieE6/s4mYYCUHiInhlf6cs4tTHdG23Sk4BqnyGyfa4QxiNZ5ncCTKfC16nRlg==
X-Gm-Message-State: AOJu0YwfzHMBlXxUohhfW8eULY9wVaCyCpBaOENuToJ7hi/AEgRuC5uB
	0D+yUmDzO07NhETFrqXqWAe3OyUR0OvktLXbphENzRhxhfW0/x5h
X-Google-Smtp-Source: AGHT+IFsyN3fUj/wvge2OpObg910h3fgjA0Yhq4m4uzYJTM25pWV56b9nEJpwCVhkLI7zYjrHHI/tQ==
X-Received: by 2002:ac2:5bce:0:b0:513:c988:71d4 with SMTP id u14-20020ac25bce000000b00513c98871d4mr8688003lfn.23.1710762248460;
        Mon, 18 Mar 2024 04:44:08 -0700 (PDT)
Received: from ryzen.lan (cpc147820-finc19-2-0-cust1005.4-2.cable.virginm.net. [86.16.175.238])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm17925813wmb.42.2024.03.18.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:44:07 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Yu Tu <yu.tu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lucas Tanure <tanure@linux.com>
Subject: [RFC][PATCH 0/2] Amlogic T7 (A113D2) Clock Driver
Date: Mon, 18 Mar 2024 11:43:44 +0000
Message-ID: <20240318114346.112935-1-tanure@linux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am trying to port the T7 clock driver from Khadas 5.4 kernel for Vim4
to mainline, but I am encountering some issues in the path.

The kernel panics at clk_mux_val_to_index, but I believe that all the
needed clocks are registered.

If anyone from Amlogic or the community could help me understand what
my driver is missing, that would be great.
I will continue to try to figure out, but it has been some weeks
without progress =/.

Lucas Tanure (2):
  clk: meson: T7: add support for Amlogic T7 SoC PLL clock driver
  arm64: dts: amlogic: t7: SDCard, Ethernet and Clocking

 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |   66 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |  189 +
 drivers/clk/meson/Kconfig                     |   25 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/t7-peripherals.c            | 6368 +++++++++++++++++
 drivers/clk/meson/t7-peripherals.h            |  131 +
 drivers/clk/meson/t7-pll.c                    | 1543 ++++
 drivers/clk/meson/t7-pll.h                    |   83 +
 .../clock/amlogic,t7-peripherals-clkc.h       |  410 ++
 .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |   69 +
 10 files changed, 8886 insertions(+)
 create mode 100644 drivers/clk/meson/t7-peripherals.c
 create mode 100644 drivers/clk/meson/t7-peripherals.h
 create mode 100644 drivers/clk/meson/t7-pll.c
 create mode 100644 drivers/clk/meson/t7-pll.h
 create mode 100644 include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h

Starting kernel ...

uboot time: 14277917 us
boot 64bit kernel
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
[    0.000000] Linux version 6.8.0-09793-gda876e5b54b3-dirty (tanureal@ryzen) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the A-pr4
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Khadas vim4
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable secmon@5000000
[    0.000000] OF: reserved mem: 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap non-reusable secmon@5300000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000000df7fffff]
[    0.000000] NUMA: NODE_DATA [mem 0xdf10c9c0-0xdf10efff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000df7fffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000]   node   0: [mem 0x0000000005000000-0x00000000072fffff]
[    0.000000]   node   0: [mem 0x0000000007300000-0x00000000df7fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000df7fffff]
[    0.000000] On node 0, zone DMA: 2048 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000d9800000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 24 pages/cpu s58152 r8192 d31960 u98304
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: detected: ARM erratum 858921
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: root=UUID=a91e7bfe-4263-4e53-867d-7824e7c6a992 rw rootfstype=ext4 console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000 khadas_board=VIM4 androidboot.selinux=permissive androidboot.0
[    0.000000] Unknown kernel command line parameters "khadas_board=VIM4", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 901152
[    0.000000] Policy zone: DMA
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 3MB
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 4MB
[    0.000000] software IO TLB: mapped [mem 0x00000000d8e00000-0x00000000d9200000] (4MB)
[    0.000000] Memory: 3445944K/3661824K available (16896K kernel code, 4426K rwdata, 9184K rodata, 9728K init, 611K bss, 183112K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: GICv2 detected, but range too small and irqchip.gicv2_force_probe not set
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.000000] arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000210] Console: colour dummy device 80x25
[    0.000253] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000261] pid_max: default: 32768 minimum: 301
[    0.000300] LSM: initializing lsm=capability
[    0.000358] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000371] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000920] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.001389] rcu: Hierarchical SRCU implementation.
[    0.001391] rcu:     Max phase no-delay instances is 1000.
[    0.001834] EFI services will not be available.
[    0.001999] smp: Bringing up secondary CPUs ...
[    0.002408] CPU features: detected: ARM erratum 845719
[    0.002426] Detected VIPT I-cache on CPU1
[    0.002516] CPU1: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.003007] Detected VIPT I-cache on CPU2
[    0.003054] CPU2: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.003497] Detected VIPT I-cache on CPU3
[    0.003546] CPU3: Booted secondary processor 0x0000000102 [0x410fd034]
[    0.003988] Detected VIPT I-cache on CPU4
[    0.004038] CPU4: Booted secondary processor 0x0000000103 [0x410fd034]
[    0.004472] Detected VIPT I-cache on CPU5
[    0.004509] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.004519] arch_timer: CPU5: Trapping CNTVCT access
[    0.004527] CPU5: Booted secondary processor 0x0000000001 [0x410fd092]
[    0.004915] Detected VIPT I-cache on CPU6
[    0.004940] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.004946] arch_timer: CPU6: Trapping CNTVCT access
[    0.004951] CPU6: Booted secondary processor 0x0000000002 [0x410fd092]
[    0.005333] Detected VIPT I-cache on CPU7
[    0.005358] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.005364] arch_timer: CPU7: Trapping CNTVCT access
[    0.005369] CPU7: Booted secondary processor 0x0000000003 [0x410fd092]
[    0.005414] smp: Brought up 1 node, 8 CPUs
[    0.005419] SMP: Total of 8 processors activated.
[    0.005421] CPU: All CPU(s) started at EL2
[    0.005434] CPU features: detected: 32-bit EL0 Support
[    0.005437] CPU features: detected: 32-bit EL1 Support
[    0.005440] CPU features: detected: CRC32 instructions
[    0.005485] alternatives: applying system-wide alternatives
[    0.006730] devtmpfs: initialized
[    0.008534] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.008545] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.008989] pinctrl core: initialized pinctrl subsystem
[    0.009581] DMI not present or invalid.
[    0.011290] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.011944] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.012293] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.012711] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.012832] audit: initializing netlink subsys (disabled)
[    0.013075] audit: type=2000 audit(0.012:1): state=initialized audit_enabled=0 res=1
[    0.013508] thermal_sys: Registered thermal governor 'step_wise'
[    0.013512] thermal_sys: Registered thermal governor 'power_allocator'
[    0.013557] cpuidle: using governor menu
[    0.013675] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.013784] ASID allocator initialised with 65536 entries
[    0.014630] Serial: AMBA PL011 UART driver
[    0.017553] Modules: 22496 pages in range for non-PLT usage
[    0.017556] Modules: 514016 pages in range for PLT usage
[    0.017980] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.017984] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.017988] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.017990] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.017993] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.017995] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.017997] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.018000] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.018247] Demotion targets for Node 0: null
[    0.018884] ACPI: Interpreter disabled.
[    0.019584] iommu: Default domain type: Translated
[    0.019587] iommu: DMA domain TLB invalidation policy: strict mode
[    0.019979] SCSI subsystem initialized
[    0.020174] usbcore: registered new interface driver usbfs
[    0.020187] usbcore: registered new interface driver hub
[    0.020200] usbcore: registered new device driver usb
[    0.020434] pps_core: LinuxPPS API ver. 1 registered
[    0.020437] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.020443] PTP clock support registered
[    0.020487] EDAC MC: Ver: 3.0.0
[    0.020717] scmi_core: SCMI protocol bus registered
[    0.021039] FPGA manager framework
[    0.021076] Advanced Linux Sound Architecture Driver Initialized.
[    0.021612] vgaarb: loaded
[    0.021857] clocksource: Switched to clocksource arch_sys_counter
[    0.021967] VFS: Disk quotas dquot_6.6.0
[    0.021984] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.022062] pnp: PnP ACPI: disabled
[    0.026651] NET: Registered PF_INET protocol family
[    0.026781] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.028598] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.028615] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.028622] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.028750] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.029019] TCP: Hash tables configured (established 32768 bind 32768)
[    0.029096] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.029124] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.029225] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.029506] RPC: Registered named UNIX socket transport module.
[    0.029510] RPC: Registered udp transport module.
[    0.029512] RPC: Registered tcp transport module.
[    0.029513] RPC: Registered tcp-with-tls transport module.
[    0.029515] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.029524] PCI: CLS 0 bytes, default 64
[    0.029649] Unpacking initramfs...
[    0.033933] kvm [1]: IPA Size Limit: 40 bits
[    0.034713] kvm [1]: Hyp mode initialized successfully
[    0.035476] Initialise system trusted keyrings
[    0.035582] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.035747] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.035906] NFS: Registering the id_resolver key type
[    0.035919] Key type id_resolver registered
[    0.035922] Key type id_legacy registered
[    0.035933] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.035935] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.036031] 9p: Installing v9fs 9p2000 file system support
[    0.062587] Key type asymmetric registered
[    0.062596] Asymmetric key parser 'x509' registered
[    0.062657] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.062661] io scheduler mq-deadline registered
[    0.062664] io scheduler kyber registered
[    0.062688] io scheduler bfq registered
[    0.063318] irq_meson_gpio: 157 to 12 gpio interrupt mux initialized
[    0.068061] EINJ: ACPI disabled.
[    0.072570] amlogic_t7_pll_probe
[    0.072855] amlogic_t7_pll_probe ret 0
[    0.072943] amlogic_a1_periphs_probe
[    0.078155] amlogic_a1_periphs_probe ret 0
[    0.084876] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.086691] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.086710] printk: legacy console [ttyS0] enabled
[    0.229167] sysfs: cannot create duplicate filename '/class/tty/ttyS0'
[    0.229669] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.8.0-09793-gda876e5b54b3-dirty #15
[    0.230684] Hardware name: Khadas vim4 (DT)
[    0.231205] Call trace:
[    0.231509]  dump_backtrace+0x94/0xec
[    0.231963]  show_stack+0x18/0x24
[    0.232374]  dump_stack_lvl+0x78/0x90
[    0.232829]  dump_stack+0x18/0x24
[    0.233241]  sysfs_warn_dup+0x64/0x80
[    0.233696]  sysfs_do_create_link_sd+0xf0/0xf8
[    0.234248]  sysfs_create_link+0x20/0x40
[    0.234736]  device_add+0x27c/0x77c
[    0.235169]  device_register+0x20/0x30
[    0.235635]  tty_register_device_attr+0xfc/0x240
[    0.236209]  tty_port_register_device_attr_serdev+0x8c/0xac
[    0.236902]  serial_core_register_port+0x318/0x658
[    0.237498]  serial_ctrl_register_port+0x10/0x1c
[    0.238072]  uart_add_one_port+0x10/0x1c
[    0.238560]  meson_uart_probe+0x2c0/0x3b4
[    0.239058]  platform_probe+0x68/0xd8
[    0.239513]  really_probe+0x148/0x2b4
[    0.239968]  __driver_probe_device+0x78/0x12c
[    0.240510]  driver_probe_device+0xdc/0x160
[    0.241030]  __driver_attach+0x94/0x19c
[    0.241507]  bus_for_each_dev+0x74/0xd4
[    0.241983]  driver_attach+0x24/0x30
[    0.242428]  bus_add_driver+0xe4/0x1e8
[    0.242893]  driver_register+0x60/0x128
[    0.243370]  __platform_driver_register+0x28/0x34
[    0.243955]  meson_uart_platform_driver_init+0x1c/0x28
[    0.244594]  do_one_initcall+0x6c/0x1b0
[    0.245071]  kernel_init_freeable+0x1cc/0x294
[    0.245613]  kernel_init+0x20/0x1dc
[    0.246046]  ret_from_fork+0x10/0x20
[    0.246555] meson_uart fe078000.serial: Cannot register tty device on line 0
[    0.247729] msm_serial: driver initialized
[    0.248150] SuperH (H)SCI(F) driver initialized
[    0.248544] STM32 USART driver initialized
[    0.263927] loop: module loaded
[    0.264952] megasas: 07.727.03.00-rc1
[    0.271065] tun: Universal TUN/TAP device driver, 1.6
[    0.271824] thunder_xcv, ver 1.0
[    0.271878] thunder_bgx, ver 1.0
[    0.271956] nicpf, ver 1.0
[    0.273230] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    0.273437] hns3: Copyright (c) 2017 Huawei Corporation.
[    0.274148] hclge is initializing
[    0.274541] e1000: Intel(R) PRO/1000 Network Driver
[    0.275116] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.275860] e1000e: Intel(R) PRO/1000 Network Driver
[    0.276449] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.277209] igb: Intel(R) Gigabit Ethernet Network Driver
[    0.277867] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.278576] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.279330] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.280319] sky2: driver version 1.30
[    0.281597] VFIO - User Level meta-driver version: 0.3
[    0.283859] usbcore: registered new interface driver usb-storage
[    0.286328] i2c_dev: i2c /dev entries driver
[    0.292404] sdhci: Secure Digital Host Controller Interface driver
[    0.292481] sdhci: Copyright(c) Pierre Ossman
[    0.293577] Synopsys Designware Multimedia Card Interface Driver
[    0.294572] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.296259] ledtrig-cpu: registered to indicate activity on CPUs
[    0.298966] meson-sm: secure-monitor enabled
[    0.299963] usbcore: registered new interface driver usbhid
[    0.299997] usbhid: USB HID core driver
[    0.306803] NET: Registered PF_PACKET protocol family
[    0.306919] 9pnet: Installing 9P2000 support
[    0.307331] Key type dns_resolver registered
[    0.318926] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.319462] registered taskstats version 1
[    0.319968] Loading compiled-in X.509 certificates
[    0.362771] clk: Disabling unused clocks
[    0.363100] PM: genpd: Disabling unused power domains
[    0.363383] ALSA device list:
[    0.363580]   No soundcards found.
[    0.368194] meson-gx-mmc fe08a000.sd: Got CD GPIO
[    0.368524] SError Interrupt on CPU6, code 0x00000000bf000002 -- SError
[    0.368531] CPU: 6 PID: 87 Comm: kworker/u32:3 Not tainted 6.8.0-09793-gda876e5b54b3-dirty #15
[    0.368537] Hardware name: Khadas vim4 (DT)
[    0.368540] Workqueue: async async_run_entry_fn
[    0.368552] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.368556] pc : clk_mux_val_to_index+0x0/0xc0
[    0.368565] lr : clk_mux_get_parent+0x4c/0x84
[    0.368571] sp : ffff800082efba10
[    0.368572] x29: ffff800082efba10 x28: ffff8000823279c0 x27: ffff800082327000
[    0.368578] x26: ffff000004c361c0 x25: 0000000000000000 x24: 0000000000000002
[    0.368584] x23: ffff000003f1d300 x22: ffff000003f1d2a0 x21: ffff000004c37280
[    0.368589] x20: ffff000004c36ec0 x19: ffff000004bba800 x18: 0000000000000020
[    0.368594] x17: ffff000000022000 x16: 0000000000000003 x15: ffffffffffffffff
[    0.368599] x14: ffffffffffffffff x13: 0078756d2364732e x12: 3030306138306566
[    0.368604] x11: 7f7f7f7f7f7f7f7f x10: ffff7fff83438910 x9 : 0000000000000005
[    0.368609] x8 : 0101010101010101 x7 : 0000000000000000 x6 : 05114367045e5359
[    0.368613] x5 : 0000000000000006 x4 : 0000000000000000 x3 : 0000000000000000
[    0.368618] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000004c36ec0
[    0.368624] Kernel panic - not syncing: Asynchronous SError Interrupt
[    0.368626] CPU: 6 PID: 87 Comm: kworker/u32:3 Not tainted 6.8.0-09793-gda876e5b54b3-dirty #15
[    0.368630] Hardware name: Khadas vim4 (DT)
[    0.368631] Workqueue: async async_run_entry_fn
[    0.368635] Call trace:
[    0.368637]  dump_backtrace+0x94/0xec
[    0.368644]  show_stack+0x18/0x24
[    0.368649]  dump_stack_lvl+0x38/0x90
[    0.368656]  dump_stack+0x18/0x24
[    0.368661]  panic+0x388/0x3c8
[    0.368666]  nmi_panic+0x48/0x94
[    0.368670]  arm64_serror_panic+0x6c/0x78
[    0.368674]  do_serror+0x3c/0x78
[    0.368677]  el1h_64_error_handler+0x30/0x48
[    0.368681]  el1h_64_error+0x64/0x68
[    0.368684]  clk_mux_val_to_index+0x0/0xc0
[    0.368689]  __clk_register+0x440/0x82c
[    0.368693]  devm_clk_register+0x5c/0xbc
[    0.368697]  meson_mmc_clk_init+0x11c/0x2a8
[    0.368702]  meson_mmc_probe+0x18c/0x3c0
[    0.368705]  platform_probe+0x68/0xd8
[    0.368711]  really_probe+0x148/0x2b4
[    0.368714]  __driver_probe_device+0x78/0x12c
[    0.368718]  driver_probe_device+0xdc/0x160
[    0.368721]  __device_attach_driver+0xb8/0x134
[    0.368724]  bus_for_each_drv+0x84/0xe0
[    0.368727]  __device_attach_async_helper+0xac/0xd0
[    0.368730]  async_run_entry_fn+0x34/0xe0
[    0.368734]  process_one_work+0x150/0x294
[    0.368740]  worker_thread+0x304/0x408
[    0.368744]  kthread+0x118/0x11c
[    0.368748]  ret_from_fork+0x10/0x20
[    0.368753] SMP: stopping secondary CPUs
[    0.368760] Kernel Offset: disabled
[    0.368761] CPU features: 0x0,00000060,d0080000,0200421b
[    0.368765] Memory Limit: none
[    0.400328] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---


-- 
2.44.0


