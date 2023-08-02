Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520276C603
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjHBHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHBHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:00:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE240FB;
        Wed,  2 Aug 2023 00:00:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so98662341fa.3;
        Wed, 02 Aug 2023 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959648; x=1691564448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZvn2u/Wq+BAh8L0qREVpMtwpDgDCAPytw/3tNmEL/I=;
        b=gmzAUj4ucBosENniSQWADNTHLMTHYosiz7cwrOLPPXwlrE0hIX8m8abG6wPqCrLs2h
         7NjTdyPWrJ2IH22LnsLQEpLPgVP4o0XTKOTTqSY+WWjNfxbamWvs7sLxBk0LndQmljzy
         DogiAZVnHVfTaffTzXAVMG5urb1jJ8W1ePMvyicYidooigWTBn6N1LHezouxopDaOOPT
         VYOV2OEoTOAR0OWoeaojaLmuL2brEY3sGvwz7041KWFOHvouIJIzjSb2kwjvuQD7s2Mi
         BMiXLAukpjaSTYMkzhNeJOZQhwyRwpsTWEPxF8AYbYtMIEBkoeJvnRG6kkWTNH11cJX+
         FqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959648; x=1691564448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZvn2u/Wq+BAh8L0qREVpMtwpDgDCAPytw/3tNmEL/I=;
        b=WMMdQ5znmUoQ94n0kf9glXSJoDCml0TMhYOs6JKk+oK0+QOXWIhfWc0g1wh/pbeKGT
         6oI2tCPkmGJE89q1Yn66YbzgiZZ4gyu9a0jCCtmReTZ3dVX8c8FpPV1kpEmauikAXJ3+
         TNkTSz/OU7vSA9dGt9nsSgwjaDqqlMbKGCilasmeltDlLVPV0DCAg4D4PxdslAagUdrj
         k1Uc/P2IraFLxZBuYdUFtYR9os3jPT6TMPtqoI2UfWcZhZK1rx7cAL1U9nKul1AWjH1l
         3ZBiWygSFP6bh8+aV/osnvdLyRtYVqntVWILZpIGW5BQ7PER0RugJ2j/uoD0I3DS/cMD
         EszQ==
X-Gm-Message-State: ABy/qLYtIowPQHH68qblyMY+WBVOzohLAW1LnGTNeSrKM+7Ut0Ya6B4L
        ytmhFfJnRx8dkGKNn4/n/UA=
X-Google-Smtp-Source: APBJJlFCSf64qV4bqs1xnWjojELReHRuE+ukDoWzVW8X0KMuzZNQtFrMJBLtVXCJIMItj/gQTfp/eA==
X-Received: by 2002:a2e:7308:0:b0:2b9:b3e9:a027 with SMTP id o8-20020a2e7308000000b002b9b3e9a027mr4273614ljc.34.1690959647756;
        Wed, 02 Aug 2023 00:00:47 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id f22-20020a2e9516000000b002b6ec6cb24bsm3422470ljh.57.2023.08.02.00.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 00:00:47 -0700 (PDT)
Message-ID: <60a553a2-85f3-d8c6-b070-ecd3089c3c5e@gmail.com>
Date:   Wed, 2 Aug 2023 09:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <ZMmFeCBxhJOxZ575@shell.armlinux.org.uk>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <ZMmFeCBxhJOxZ575@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.08.2023 00:21, Russell King (Oracle) wrote:
> On Wed, Aug 02, 2023 at 12:10:24AM +0200, Rafał Miłecki wrote:
>> Years ago I added support for Broadcom's BCM53573 SoCs. We released
>> firmwares based on Linux 4.4 (and later on 4.14) that worked almost
>> fine. There was one little issue we couldn't debug or fix: random hangs
>> and reboots. They were too rare to deal with (most devices worked fine
>> for weeks or months).
>>
>> Recently I updated my stable kernel 5.4 and I started experiencing
>> stability issues on my own! After some uptime (usually from 0 to 20
>> minutes of close to zero activity) serial console hangs. I can't type
>> anything and I stop getting any messages. I've to wait about a minute
>> for watchdog to kick in and reboot device.
>>
>> (...)
>>
>> I'm clueless at this point. Is that possible kernel has some locking bug
>> I can hit only using this specific SoC? BCM53573s have a single ARM
>> Cortex-A7 CPU running at 900 MHz. The only unusual thing about this hw I
>> can think of is a slow arch timer running at 36,8 kHz.
>>
>> I tried compiling kernel with:
>> CONFIG_SOFTLOCKUP_DETECTOR=y
>> CONFIG_DETECT_HUNG_TASK=y
>> CONFIG_WQ_WATCHDOG=y
>> but it didn't change or report anything.
>>
>> Unfortunately enabling *any* of following options:
>> CONFIG_DEBUG_RT_MUTEXES=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_MUTEXES=y
>> seems to make locksup/hangs go away. I tried for few hours.
>>
>> Sadly I don't have access to JTAG or any low level debugging interface.
>>
>> Does looking at commits I reported above give anyone a hint on what may
>> be going on maybe?
> 
> If you suspect locking issues, make sure you have lockdep enabled which
> will detect locking errors. You will want CONFIG_PROVE_LOCKING enabled.
> 
> I will say that I use IPv6, and I run 32-bit kernels here both on real
> ARMv7 hardware (Armada 388 and iMX6 based stuff) and also in KVM based
> VMs, and these have run virtually every release of the kernel (not
> stable kernels though) and I haven't ever seen the behaviour that you
> describe.
> 
> If it is specific to stable kernels, then that would be rather
> disappointing.

I wrote above that with any of: CONFIG_DEBUG_RT_MUTEXES,
CONFIG_DEBUG_SPINLOCK or CONFIG_DEBUG_MUTEXES enabled I can't reproduce
the issue anymore. Right? Well I swear it was true for some random 5.4
release I tested before.

With your comment I decided to try CONFIG_PROVE_LOCKING anyway / again
and this time on 1 of my BCM53573 devices I got something very
interesting on the first boot.

FWIW following error:
Broadcom B53 (2) bcma_mdio-0-0:1e: failed to register switch: -517
is caused by invalid DT I sent fixes for just recently.

Please scroll through the first booting lines for the WARNING:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.4.238 (ubuntu@nat) (gcc version 8.4.0 (OpenWrt GCC 8.4.0 r15234+1-d89a7f0120)) #0 SMP Fri Jul 14 12:56:51 2023
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Tenda AC9
[    0.000000] earlycon: ns16550a0 at MMIO 0x18000300 (options '115200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Hit pending asynchronous external abort (FSR=0x00000c06) during first unmask, this is most likely caused by a firmware/bootloader bug.
[    0.000000] percpu: Embedded 14 pages/cpu s27944 r8192 d21208 u57344
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32480
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 118164K/131072K available (5531K kernel code, 201K rwdata, 1960K rodata, 1024K init, 2106K bss, 12908K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] arch_timer: cp15 timer(s) running at 0.03MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x10eb00226, max_idle_ns: 56421785894076 ns
[    0.000027] sched_clock: 56 bits at 35kHz, resolution 27918ns, wraps every 70368744165810ns
[    0.008654] Ignoring delay timer arch_delay_timer, which has insufficient resolution of 27918ns
[    0.017951] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.025936] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.030180] ... MAX_LOCK_DEPTH:          48
[    0.034479] ... MAX_LOCKDEP_KEYS:        8192
[    0.039002] ... CLASSHASH_SIZE:          4096
[    0.043525] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.048104] ... MAX_LOCKDEP_CHAINS:      65536
[    0.052683] ... CHAINHASH_SIZE:          32768
[    0.057289]  memory used by lock dependency info: 1797 kB
[    0.062873]  per task-struct memory footprint: 1536 bytes
[    0.068485] Calibrating delay loop... 1790.77 BogoMIPS (lpj=8953856)
[    0.134987] pid_max: default: 32768 minimum: 301
[    0.140097] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.147663] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.157937] CPU: Testing write buffer coherency: ok
[    0.164079] /cpus/cpu@0 missing clock-frequency property
[    0.169691] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.177787] Setting up static identity map for 0x100000 - 0x10003c
[    0.184767] rcu: Hierarchical SRCU implementation.
[    0.191077] smp: Bringing up secondary CPUs ...
[    0.195879] smp: Brought up 1 node, 1 CPU
[    0.200039] SMP: Total of 1 processors activated (1790.77 BogoMIPS).
[    0.206655] CPU: All CPU(s) started in SVC mode.
[    0.217572] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.227846] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.235244] pinctrl core: initialized pinctrl subsystem
[    0.242699] NET: Registered protocol family 16
[    0.249958] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.333156] clocksource: Switched to clocksource arch_sys_counter
[    0.342062] thermal_sys: Registered thermal governor 'step_wise'
[    0.342732] NET: Registered protocol family 2
[    0.353984] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.362694] tcp_listen_portaddr_hash hash table entries: 128 (order: 0, 5120 bytes, linear)
[    0.371433] TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.379446] TCP bind hash table entries: 1024 (order: 3, 36864 bytes, linear)
[    0.386984] TCP: Hash tables configured (established 1024 bind 1024)
[    0.393908] UDP hash table entries: 256 (order: 2, 20480 bytes, linear)
[    0.400831] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes, linear)
[    0.408733] NET: Registered protocol family 1
[    0.413423] PCI: CLS 0 bytes, default 64
[    0.427857] workingset: timestamp_bits=14 max_order=15 bucket_order=1
[    0.449187] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.455301] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.501005] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.522195] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
[    0.529063] bcma-host-soc 18000000.axi: bus0: Found chip with id 53573, rev 0x02 and package 0x01
[    0.538583] bcma-host-soc 18000000.axi: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x36, class 0x0)
[    0.549835] bcma-host-soc 18000000.axi: bus0: Core 1 found: IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x38, class 0x0)
[    0.561030] bcma-host-soc 18000000.axi: bus0: Core 2 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x05, class 0x0)
[    0.572142] bcma-host-soc 18000000.axi: bus0: Core 3 found: ARM CA7 (manuf 0x4BF, id 0x847, rev 0x00, class 0x0)
[    0.583030] bcma-host-soc 18000000.axi: bus0: Core 4 found: USB 2.0 Host (manuf 0x4BF, id 0x819, rev 0x05, class 0x0)
[    0.594421] bcma-host-soc 18000000.axi: bus0: Core 5 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x08, class 0x0)
[    0.605338] bcma-host-soc 18000000.axi: bus0: Core 6 found: I2S (manuf 0x4BF, id 0x834, rev 0x06, class 0x0)
[    0.615807] bcma-host-soc 18000000.axi: bus0: Core 7 found: CNDS DDR2/3 memory controller (manuf 0x4BF, id 0x846, rev 0x00, class 0x0)
[    0.628594] bcma-host-soc 18000000.axi: bus0: Core 8 found: NAND flash controller (manuf 0x4BF, id 0x509, rev 0x01, class 0x0)
[    0.640767] bcma-host-soc 18000000.axi: bus0: Core 9 found: IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x38, class 0x0)
[    0.652046] bcma-host-soc 18000000.axi: bus0: Core 10 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x08, class 0x0)
[    0.663074] bcma-host-soc 18000000.axi: bus0: Core 11 found: I2S (manuf 0x4BF, id 0x834, rev 0x06, class 0x0)
[    0.673599] bcma-host-soc 18000000.axi: bus0: Core 12 found: GCI (manuf 0x4BF, id 0x840, rev 0x08, class 0x0)
[    0.684153] bcma-host-soc 18000000.axi: bus0: Core 13 found: PMU (manuf 0x4BF, id 0x827, rev 0x1C, class 0x0)
[    0.709559] bcma-host-soc 18000000.axi: bus0: Found M25P64 serial flash (size: 8192KiB, blocksize: 0x10000, blocks: 128)
[    0.723602] printk: console [ttyS0] disabled
[    0.728293] 18000300.serial: ttyS0 at MMIO 0x18000300 (irq = 20, base_baud = 2500000) is a 16550A
[    0.737645] printk: console [ttyS0] enabled
[    0.737645] printk: console [ttyS0] enabled
[    0.746272] printk: bootconsole [ns16550a0] disabled
[    0.746272] printk: bootconsole [ns16550a0] disabled
[    0.776648] 4 bcm47xxpart partitions found on MTD device bcm47xxsflash
[    0.783321] Creating 4 MTD partitions on "bcm47xxsflash":
[    0.788905] 0x000000000000-0x000000040000 : "boot"
[    0.797085] 0x000000040000-0x0000007b0000 : "firmware"
[    0.804400] 2 trx partitions found on MTD device firmware
[    0.809900] Creating 2 MTD partitions on "firmware":
[    0.815065] 0x00000000001c-0x000000285400 : "linux"
[    0.822100] 0x000000285400-0x000000770000 : "rootfs"
[    0.829219] mtd: device 3 (rootfs) set to be root filesystem
[    0.835082] 1 squashfs-split partitions found on MTD device rootfs
[    0.841392] 0x000000540000-0x000000770000 : "rootfs_data"
[    0.848958] 0x0000007b0000-0x0000007f0000 : "boot"
[    0.855966] 0x0000007f0000-0x000000800000 : "nvram"
[    1.022586] pcie_iproc_bcma bcma0:2: link: UP
[    1.027555] pcie_iproc_bcma bcma0:2: PCI host bridge to bus 0000:00
[    1.034033] pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
[    1.041012] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.049304] pci 0000:00:00.0: [14e4:d145] type 01 class 0x060400
[    1.055502] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.065553] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.072924] PCI: bus0: Fast back to back transfers disabled
[    1.078619] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.087134] pci 0000:01:00.0: [14e4:a8db] type 00 class 0x028000
[    1.093360] pci_bus 0000:01: 2-byte config write to 0000:01:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    1.103244] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    1.110195] pci 0000:01:00.0: enabling Extended Tags
[    1.115444] pci 0000:01:00.0: supports D1 D2
[    1.120637] PCI: bus1: Fast back to back transfers disabled
[    1.126416] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.133201] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.139957] pci 0000:00:00.0: BAR 8: assigned [mem 0x10000000-0x100fffff]
[    1.146909] pci 0000:01:00.0: BAR 0: assigned [mem 0x10000000-0x10007fff 64bit]
[    1.154391] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.159444] pci 0000:00:00.0:   bridge window [mem 0x10000000-0x100fffff]
[    1.167234] bgmac_bcma bcma0:5: Found PHY addr: 30 (NOREGS)
[    1.173655] ------------[ cut here ]------------
[    1.178374] WARNING: CPU: 0 PID: 1 at kernel/locking/mutex.c:950 __mutex_lock+0x6b4/0x8a0
[    1.186721] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[    1.186721] Modules linked in:
[    1.194902] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.238 #0
[    1.200988] Hardware name: Generic DT based system
[    1.205874] [<c010a240>] (unwind_backtrace) from [<c01064d0>] (show_stack+0x10/0x20)
[    1.213747] [<c01064d0>] (show_stack) from [<c0648e3c>] (dump_stack+0x94/0xb8)
[    1.221062] [<c0648e3c>] (dump_stack) from [<c011ad4c>] (__warn+0xa0/0xbc)
[    1.228041] [<c011ad4c>] (__warn) from [<c011adec>] (warn_slowpath_fmt+0x84/0x98)
[    1.235635] [<c011adec>] (warn_slowpath_fmt) from [<c0662fd4>] (__mutex_lock+0x6b4/0x8a0)
[    1.243955] [<c0662fd4>] (__mutex_lock) from [<c06631dc>] (mutex_lock_nested+0x1c/0x40)
[    1.252079] [<c06631dc>] (mutex_lock_nested) from [<c04a31cc>] (phy_probe+0x4c/0x1c0)
[    1.260008] [<c04a31cc>] (phy_probe) from [<c0442d30>] (really_probe+0x1f0/0x360)
[    1.267602] [<c0442d30>] (really_probe) from [<c0440fb0>] (bus_for_each_drv+0x70/0xa0)
[    1.275643] [<c0440fb0>] (bus_for_each_drv) from [<c0442ab0>] (__device_attach+0xd0/0x140)
[    1.284019] [<c0442ab0>] (__device_attach) from [<c0441d48>] (bus_probe_device+0x88/0xa0)
[    1.292311] [<c0441d48>] (bus_probe_device) from [<c043f064>] (device_add+0x3c4/0x5e0)
[    1.300351] [<c043f064>] (device_add) from [<c04a4344>] (mdio_device_register+0x24/0x60)
[    1.308559] [<c04a4344>] (mdio_device_register) from [<c04c9c44>] (of_mdiobus_register+0x1e4/0x2e0)
[    1.317745] [<c04c9c44>] (of_mdiobus_register) from [<c04aed54>] (bcma_mdio_mii_register+0xb4/0x100)
[    1.327014] [<c04aed54>] (bcma_mdio_mii_register) from [<c04ae6f4>] (bgmac_probe+0x154/0x5a0)
[    1.335669] [<c04ae6f4>] (bgmac_probe) from [<c04ca308>] (bcma_device_probe+0x28/0x60)
[    1.343681] [<c04ca308>] (bcma_device_probe) from [<c0442d30>] (really_probe+0x1f0/0x360)
[    1.352001] [<c0442d30>] (really_probe) from [<c0440fb0>] (bus_for_each_drv+0x70/0xa0)
[    1.360014] [<c0440fb0>] (bus_for_each_drv) from [<c0442ab0>] (__device_attach+0xd0/0x140)
[    1.368390] [<c0442ab0>] (__device_attach) from [<c0441d48>] (bus_probe_device+0x88/0xa0)
[    1.376682] [<c0441d48>] (bus_probe_device) from [<c043f064>] (device_add+0x3c4/0x5e0)
[    1.384722] [<c043f064>] (device_add) from [<c04cae60>] (bcma_bus_register+0x480/0x640)
[    1.392847] [<c04cae60>] (bcma_bus_register) from [<c04d09a8>] (bcma_host_soc_probe+0x68/0xa0)
[    1.401585] [<c04d09a8>] (bcma_host_soc_probe) from [<c0444b74>] (platform_drv_probe+0x34/0x80)
[    1.410408] [<c0444b74>] (platform_drv_probe) from [<c0442d30>] (really_probe+0x1f0/0x360)
[    1.418783] [<c0442d30>] (really_probe) from [<c0443358>] (device_driver_attach+0x58/0x60)
[    1.427187] [<c0443358>] (device_driver_attach) from [<c04433c0>] (__driver_attach+0x60/0xe0)
[    1.435814] [<c04433c0>] (__driver_attach) from [<c0440ee8>] (bus_for_each_dev+0x68/0xa0)
[    1.444134] [<c0440ee8>] (bus_for_each_dev) from [<c0442004>] (bus_add_driver+0x1a4/0x200)
[    1.452509] [<c0442004>] (bus_add_driver) from [<c04439f4>] (driver_register+0x74/0x120)
[    1.460718] [<c04439f4>] (driver_register) from [<c091d8f8>] (bcma_modinit+0x14/0x4c)
[    1.468674] [<c091d8f8>] (bcma_modinit) from [<c01027e4>] (do_one_initcall+0x84/0x200)
[    1.476715] [<c01027e4>] (do_one_initcall) from [<c0901178>] (kernel_init_freeable+0x210/0x2b8)
[    1.485537] [<c0901178>] (kernel_init_freeable) from [<c065f4d0>] (kernel_init+0x8/0x118)
[    1.493829] [<c065f4d0>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    1.501507] Exception stack(0xc7823fb0 to 0xc7823ff8)
[    1.506616] 3fa0:                                     00000000 00000000 00000000 00000000
[    1.514908] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.523200] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.530180] ---[ end trace 335ee604b627e32a ]---
[    1.535792] Broadcom B53 (2) bcma_mdio-0-0:1e: failed to register switch: -517
[    1.543190] 8<--- cut here ---
[    1.546289] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    1.554497] pgd = (ptrval)
[    1.557233] [00000000] *pgd=00000000
[    1.560863] Internal error: Oops: 805 [#1] SMP ARM
[    1.565721] Modules linked in:
[    1.568820] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.4.238 #0
[    1.576330] Hardware name: Generic DT based system
[    1.581188] PC is at release_nodes+0x5c/0x1e0
[    1.585599] LR is at 0x0
[    1.588167] pc : [<c0446fdc>]    lr : [<00000000>]    psr: 80000093
[    1.594533] sp : c7823c10  ip : c7b7c700  fp : c07f7460
[    1.599838] r10: 00000000  r9 : 00000000  r8 : c0447240
[    1.605142] r7 : c04461c0  r6 : c7b73800  r5 : c7823c10  r4 : 00000001
[    1.611759] r3 : a0000013  r2 : c7b73940  r1 : c7b7c700  r0 : c7b73a00
[    1.618376] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.625690] Control: 10c5387d  Table: 0000406a  DAC: 00000051
[    1.631526] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    1.637612] Stack: (0xc7823c10 to 0xc7824000)
[    1.642023] 3c00:                                     c7823c10 c7823c10 c0c2b504 c7b73800
[    1.650315] 3c20: c0c2b4fc 00000000 fffffdfb c0a26f64 00000000 c0442c54 00000000 c7823c70
[    1.658607] 3c40: c0443220 00000000 00000001 00000000 c7b73800 c0440fb0 c7a214d4 c7918c54
[    1.666899] 3c60: c7b73800 c7b73844 c0a26970 c0442ab0 c7b73800 00000001 c7b73800 c7b73800
[    1.675191] 3c80: c0a26970 c7b790a8 00000000 c0441d48 c7b73800 c0a08648 00000000 c043f064
[    1.683483] 3ca0: c7b738a8 c7b738a8 c07e5f54 c0c2b3b0 0000001e 98eaeeb8 c7b73800 00000000
[    1.691775] 3cc0: c7b73800 c7ed660c 0000001e c07f5e88 c0a283e8 c04a4344 c7b79000 c7ed6500
[    1.700067] 3ce0: c7ed660c c04c9c44 00000000 80000013 c07d8a38 00000001 c7b790a8 00000000
[    1.708358] 3d00: 00000000 c07ff530 c7ed6500 0000001e c07d8a38 c7b79000 c7964800 c7b98580
[    1.716650] 3d20: c7964810 00000000 c0a283e8 00000000 c08001f8 c04aed54 00000000 c7823d50
[    1.724942] 3d40: c07f9e98 c7b98580 c7964800 c7b9d580 c79f0840 c04ae6f4 c0a283e8 c7964810
[    1.733234] 3d60: c0c2b4fc 00000000 00000000 c04ca308 c0c2b504 c7964810 c0c2b4fc c0442d30
[    1.741526] 3d80: 00000000 c7823db8 c0443220 00000000 00000001 00000000 00000001 c0440fb0
[    1.749818] 3da0: c796c0d4 c78ad654 c7964810 c7964854 c0a2995c c0442ab0 c7964810 00000001
[    1.758110] 3dc0: c7964810 c7964810 c0a2995c c789d610 00000000 c0441d48 c7964810 c0a08648
[    1.766402] 3de0: 00000000 c043f064 c08011c0 00000000 0000d145 c7823dec 000a005a 98eaeeb8
[    1.774694] 3e00: c79f0870 c79f0864 c79f0840 c79f0870 00000000 c7964800 0000052d c04cae60
[    1.782986] 3e20: 98eaeeb8 c79f0840 c789d600 c789d610 c7ed4d2c 00000000 c0a29d8c 00000000
[    1.791278] 3e40: c7ffeec0 c04d09a8 c789d610 c0a29d8c c0c2b4fc 00000000 00000000 c0444b74
[    1.799570] 3e60: c0c2b504 c789d610 c0c2b4fc c0442d30 c789d610 00000000 c0a29d8c 00000000
[    1.807861] 3e80: c797b1d4 c0928850 00000007 c0443358 c0a29d8c c789d610 c0443360 c04433c0
[    1.816153] 3ea0: c789d610 c0a29d8c c0443360 c0440ee8 c781c6a4 c7877590 c0a29d8c c797b180
[    1.824445] 3ec0: c0a23308 c0442004 c0801be0 c0a33014 c0a29d8c c0a33014 ffffe000 c091d8e4
[    1.832737] 3ee0: 00000000 c04439f4 00000000 c0a33014 ffffe000 c091d8f8 c0a08648 c01027e4
[    1.841029] 3f00: c7ffeed5 00000000 c0850948 00000000 c7ffeed5 c0139de8 c0a0f7f8 c0819c24
[    1.849321] 3f20: 00000006 00000006 c079a9f8 00000000 c07a7304 c079aa6c c7ffeed5 00000000
[    1.857613] 3f40: 00000000 00000006 c09005e8 98eaeeb8 c0930370 c09005e8 c0a33028 c0a33010
[    1.865905] 3f60: c0928870 c0901178 00000006 00000006 00000000 c09005e8 c7824000 00000056
[    1.874197] 3f80: 00000001 00000000 c065f4c8 00000000 00000000 00000000 00000000 00000000
[    1.882489] 3fa0: 00000000 c065f4d0 00000000 c01010e8 00000000 00000000 00000000 00000000
[    1.890781] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.899073] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.907365] [<c0446fdc>] (release_nodes) from [<c0442c54>] (really_probe+0x114/0x360)
[    1.915321] [<c0442c54>] (really_probe) from [<c0440fb0>] (bus_for_each_drv+0x70/0xa0)
[    1.923362] [<c0440fb0>] (bus_for_each_drv) from [<c0442ab0>] (__device_attach+0xd0/0x140)
[    1.931738] [<c0442ab0>] (__device_attach) from [<c0441d48>] (bus_probe_device+0x88/0xa0)
[    1.940030] [<c0441d48>] (bus_probe_device) from [<c043f064>] (device_add+0x3c4/0x5e0)
[    1.948070] [<c043f064>] (device_add) from [<c04a4344>] (mdio_device_register+0x24/0x60)
[    1.956278] [<c04a4344>] (mdio_device_register) from [<c04c9c44>] (of_mdiobus_register+0x1e4/0x2e0)
[    1.965464] [<c04c9c44>] (of_mdiobus_register) from [<c04aed54>] (bcma_mdio_mii_register+0xb4/0x100)
[    1.974733] [<c04aed54>] (bcma_mdio_mii_register) from [<c04ae6f4>] (bgmac_probe+0x154/0x5a0)
[    1.983360] [<c04ae6f4>] (bgmac_probe) from [<c04ca308>] (bcma_device_probe+0x28/0x60)
[    1.991400] [<c04ca308>] (bcma_device_probe) from [<c0442d30>] (really_probe+0x1f0/0x360)
[    1.999720] [<c0442d30>] (really_probe) from [<c0440fb0>] (bus_for_each_drv+0x70/0xa0)
[    2.007733] [<c0440fb0>] (bus_for_each_drv) from [<c0442ab0>] (__device_attach+0xd0/0x140)
[    2.016137] [<c0442ab0>] (__device_attach) from [<c0441d48>] (bus_probe_device+0x88/0xa0)
[    2.024429] [<c0441d48>] (bus_probe_device) from [<c043f064>] (device_add+0x3c4/0x5e0)
[    2.032441] [<c043f064>] (device_add) from [<c04cae60>] (bcma_bus_register+0x480/0x640)
[    2.040566] [<c04cae60>] (bcma_bus_register) from [<c04d09a8>] (bcma_host_soc_probe+0x68/0xa0)
[    2.049304] [<c04d09a8>] (bcma_host_soc_probe) from [<c0444b74>] (platform_drv_probe+0x34/0x80)
[    2.058155] [<c0444b74>] (platform_drv_probe) from [<c0442d30>] (really_probe+0x1f0/0x360)
[    2.066530] [<c0442d30>] (really_probe) from [<c0443358>] (device_driver_attach+0x58/0x60)
[    2.074906] [<c0443358>] (device_driver_attach) from [<c04433c0>] (__driver_attach+0x60/0xe0)
[    2.083561] [<c04433c0>] (__driver_attach) from [<c0440ee8>] (bus_for_each_dev+0x68/0xa0)
[    2.091853] [<c0440ee8>] (bus_for_each_dev) from [<c0442004>] (bus_add_driver+0x1a4/0x200)
[    2.100256] [<c0442004>] (bus_add_driver) from [<c04439f4>] (driver_register+0x74/0x120)
[    2.108465] [<c04439f4>] (driver_register) from [<c091d8f8>] (bcma_modinit+0x14/0x4c)
[    2.116393] [<c091d8f8>] (bcma_modinit) from [<c01027e4>] (do_one_initcall+0x84/0x200)
[    2.124434] [<c01027e4>] (do_one_initcall) from [<c0901178>] (kernel_init_freeable+0x210/0x2b8)
[    2.133257] [<c0901178>] (kernel_init_freeable) from [<c065f4d0>] (kernel_init+0x8/0x118)
[    2.141576] [<c065f4d0>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    2.149254] Exception stack(0xc7823fb0 to 0xc7823ff8)
[    2.154363] 3fa0:                                     00000000 00000000 00000000 00000000
[    2.162655] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.170947] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.177648] Code: e2844001 05901000 e152000c e58ce004 (e58ec000)
[    2.183846] ---[ end trace 335ee604b627e32b ]---
[    2.188508] Kernel panic - not syncing: Fatal exception
[    2.193841] Rebooting in 1 seconds..
[    4.187419] Reboot failed -- System halted
