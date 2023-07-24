Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD675FD15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGXRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGXRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:22:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EED10D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:22:11 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1qNzG0-0005pw-EB; Mon, 24 Jul 2023 19:22:04 +0200
Message-ID: <271eedd7-d191-ada8-4e08-207b29784d39@pengutronix.de>
Date:   Mon, 24 Jul 2023 19:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
Content-Language: en-US
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
From:   Bastian Krause <bst@pengutronix.de>
In-Reply-To: <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meenakshi,

On 7/19/23 09:00, Meenakshi Aggarwal wrote:
> We have tested the patch on i.mx8mm board and we did not face any issue with the patch.
> 
> Please share your imx8mm board revision and complete logs (including bootloader logs),
> It will help in investigating the issue you are facing.

SoC: i.MX8MM revision 1.0
MSC OSM-MF-IMX8MINI [1] on MSC OSM-SM2F-AD-001 on a customer baseboard.

[1] https://embedded.avnet.com/product/msc-osm-mf-imx8mini/

These are the logs booting v6.5-rc3 via barebox 2023.07.1:


NOTICE:  BL31: v2.8(release):v2.8-dirty
NOTICE:  BL31: Built : 18:12:00, Nov 21 2022

barebox 2023.07.1-20230712-1 #1 Tue Jul 18 14:38:43 UTC 2023
Buildsystem version: 00ded5f

Board: MSC OSM-MF-IMX8MINI on MSC OSM-SM2F-AD-001 on customer baseboard
deep-probe: supported due to customer-imx8mm
detected i.MX8MM revision 1.0
i.MX8MM unique ID: 272b41aac2a4060c
rn5t568-i2c rn5t5680: Found NMD RN5T568 LSI 1, OTP: 6f
imx-esdhc 30b50000.mmc@30b50000.of: registered as mmc1
imx-esdhc 30b60000.mmc@30b60000.of: registered as mmc2
mdio_bus: miibus0: probed
malloc space: 0xbfdfd1c0 -> 0xffdfd1bf (size 1 GiB)
eth0: Got preset MAC address from device tree: 00:11:22:33:44:55

Hit m for menu or any to stop autoboot:    0
mmc1: detected SD card version 2.0
mmc1: registered mmc1
ext4 ext40: EXT2 rev 1, inode_size 256, descriptor size 64
ext4 ext40: EXT2 rev 1, inode_size 256, descriptor size 64
Booting entry 'Customer Image (/mnt/mmc1.0/loader/entries/imx8mm-customer.conf)'
blspec: booting Customer Image from mmc1
Adding "root=PARTUUID=076c4a2a-01" to Kernel commandline

Loading ARM aarch64 Linux image '/mnt/mmc1.0//boot/Image'
Loading devicetree from '/mnt/mmc1.0//boot/devicetree/imx8mm-customer.dtb'
commandline: root=PARTUUID=076c4a2a-01 console=ttymxc1,115200n8  6 rootwait
Loaded kernel to 0x40000000, devicetree at 0x0000000041590000
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.5.0-rc3 (oe-user@oe-host) (aarch64-oe-linux-gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40.0.20230620) #1 SMP PREEMPT Sun Jul 23 22:24:10 UTC 2023
[    0.000000] Machine model: MSC OSM-MF-IMX8MINI on MSC OSM-SM2F-AD-001 on Customer baseboard
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] cma: Reserved 16 MiB at 0x00000000ff000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 29 pages/cpu s77992 r8192 d32600 u118784
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: root=PARTUUID=076c4a2a-01 console=ttymxc1,115200n8  6 rootwait
[    0.000000] Unknown kernel command line parameters "6", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1032192
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000fb000000-0x00000000ff000000] (64MB)
[    0.000000] Memory: 4008812K/4194304K available (11200K kernel code, 1910K rwdata, 4088K rodata, 4352K init, 326K bss, 169108K reserved, 16384K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 38151 entries in 150 pages
[    0.000000] ftrace: allocated 150 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 128 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000038880000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 8.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns
[    0.000001] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2199023255500ns
[    0.000533] Calibrating delay loop (skipped), value calculated using timer frequency.. 16.00 BogoMIPS (lpj=32000)
[    0.000543] pid_max: default: 32768 minimum: 301
[    0.003503] LSM: initializing lsm=capability
[    0.004347] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004370] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.008065] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.008139] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.008225] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.008395] rcu: Hierarchical SRCU implementation.
[    0.008399] rcu: 	Max phase no-delay instances is 1000.
[    0.009412] smp: Bringing up secondary CPUs ...
[    0.009912] Detected VIPT I-cache on CPU1
[    0.009981] GICv3: CPU1: found redistributor 1 region 0:0x00000000388a0000
[    0.010023] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.010589] Detected VIPT I-cache on CPU2
[    0.010637] GICv3: CPU2: found redistributor 2 region 0:0x00000000388c0000
[    0.010664] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.011147] Detected VIPT I-cache on CPU3
[    0.011190] GICv3: CPU3: found redistributor 3 region 0:0x00000000388e0000
[    0.011211] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.011268] smp: Brought up 1 node, 4 CPUs
[    0.011274] SMP: Total of 4 processors activated.
[    0.011279] CPU features: detected: 32-bit EL0 Support
[    0.011282] CPU features: detected: CRC32 instructions
[    0.011330] CPU: All CPU(s) started at EL2
[    0.011332] alternatives: applying system-wide alternatives
[    0.013395] devtmpfs: initialized
[    0.020093] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020119] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.021492] pinctrl core: initialized pinctrl subsystem
[    0.024561] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.025369] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.025472] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.025630] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.026034] thermal_sys: Registered thermal governor 'step_wise'
[    0.026064] cpuidle: using governor menu
[    0.026169] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.026241] ASID allocator initialised with 65536 entries
[    0.030673] platform soc@0: Fixed dependency cycle(s) with /soc@0/bus@30000000/efuse@30350000/unique-id@4
[    0.032280] platform 30330000.pinctrl: Fixed dependency cycle(s) with /soc@0/bus@30000000/pinctrl@30330000/hoggrp
[    0.032900] imx8mm-pinctrl 30330000.pinctrl: initialized IMX pinctrl driver
[    0.033610] platform 30350000.efuse: Fixed dependency cycle(s) with /soc@0/bus@30000000/clock-controller@30380000
[    0.043065] Modules: 27248 pages in range for non-PLT usage
[    0.043077] Modules: 518768 pages in range for PLT usage
[    0.043889] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.043897] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.043902] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.043906] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.043910] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.043915] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.043919] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.043922] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.044367] cryptd: max_cpu_qlen set to 1000
[    0.047344] iommu: Default domain type: Translated
[    0.047351] iommu: DMA domain TLB invalidation policy: strict mode
[    0.047695] SCSI subsystem initialized
[    0.047855] usbcore: registered new interface driver usbfs
[    0.047882] usbcore: registered new interface driver hub
[    0.047911] usbcore: registered new device driver usb
[    0.048582] pps_core: LinuxPPS API ver. 1 registered
[    0.048586] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.048600] PTP clock support registered
[    0.049014] FPGA manager framework
[    0.049909] clocksource: Switched to clocksource arch_sys_counter
[    0.059522] NET: Registered PF_INET protocol family
[    0.059758] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.063403] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.063496] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.063512] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.063726] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.064752] TCP: Hash tables configured (established 32768 bind 32768)
[    0.064930] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.065021] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.065471] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.066080] RPC: Registered named UNIX socket transport module.
[    0.066086] RPC: Registered udp transport module.
[    0.066089] RPC: Registered tcp transport module.
[    0.066091] RPC: Registered tcp-with-tls transport module.
[    0.066094] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.066108] PCI: CLS 0 bytes, default 64
[    0.067346] Initialise system trusted keyrings
[    0.067490] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.073825] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.074391] NFS: Registering the id_resolver key type
[    0.074417] Key type id_resolver registered
[    0.074421] Key type id_legacy registered
[    0.074514] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.074524] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.106201] NET: Registered PF_ALG protocol family
[    0.106212] Key type asymmetric registered
[    0.106217] Asymmetric key parser 'x509' registered
[    0.106222] Asymmetric key parser 'pkcs8' registered
[    0.106274] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.106280] io scheduler mq-deadline registered
[    0.106284] io scheduler kyber registered
[    0.114502] imx-sdma 302c0000.dma-controller: Direct firmware load for imx/sdma/sdma-imx7d.bin failed with error -2
[    0.114524] imx-sdma 302c0000.dma-controller: external firmware not found, using ROM firmware
[    0.116312] imx-sdma 302b0000.dma-controller: Direct firmware load for imx/sdma/sdma-imx7d.bin failed with error -2
[    0.116323] imx-sdma 302b0000.dma-controller: external firmware not found, using ROM firmware
[    0.118302] imx-sdma 30bd0000.dma-controller: Direct firmware load for imx/sdma/sdma-imx7d.bin failed with error -2
[    0.118313] imx-sdma 30bd0000.dma-controller: external firmware not found, using ROM firmware
[    0.122348] SoC: i.MX8MM revision 1.0
[    0.125491] 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 18, base_baud = 1500000) is a IMX
[    0.126259] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 19, base_baud = 1500000) is a IMX
[    0.126300] printk: console [ttymxc1] enabled
[    1.102185] loop: module loaded
[    1.107963] usbcore: registered new interface driver usb-storage
[    1.115875] input: 30370000.snvs:snvs-powerkey as /devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-powerkey/input/input0
[    1.129313] snvs_rtc 30370000.snvs:snvs-rtc-lp: registered as rtc1
[    1.135624] i2c_dev: i2c /dev entries driver
[    1.141791] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    1.151331] sdhci: Secure Digital Host Controller Interface driver
[    1.157540] sdhci: Copyright(c) Pierre Ossman
[    1.161905] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.169109] caam 30900000.crypto: Entropy delay = 3200
[    1.174385] caam 30900000.crypto: Entropy delay = 3600
[    1.179620] caam 30900000.crypto: Entropy delay = 4000
[    1.184849] caam 30900000.crypto: Entropy delay = 4400
[    1.190084] caam 30900000.crypto: Entropy delay = 4800
[    1.195317] caam 30900000.crypto: Entropy delay = 5200
[    1.200559] caam 30900000.crypto: Entropy delay = 5600
[    1.201193] mmc2: SDHCI controller on 30b60000.mmc [30b60000.mmc] using ADMA
[    1.205800] caam 30900000.crypto: Entropy delay = 6000
[    1.218018] caam 30900000.crypto: Entropy delay = 6400
[    1.223280] caam 30900000.crypto: Entropy delay = 6800
[    1.228530] caam 30900000.crypto: Entropy delay = 7200
[    1.233788] caam 30900000.crypto: Entropy delay = 7600
[    1.239043] caam 30900000.crypto: Entropy delay = 8000
[    1.244300] caam 30900000.crypto: Entropy delay = 8400
[    1.249562] caam 30900000.crypto: Entropy delay = 8800
[    1.254839] caam 30900000.crypto: Entropy delay = 9200
[    1.260113] caam 30900000.crypto: Entropy delay = 9600
[    1.265389] caam 30900000.crypto: Entropy delay = 10000
[    1.270749] caam 30900000.crypto: Entropy delay = 10400
[    1.276117] caam 30900000.crypto: Entropy delay = 10800
[    1.281498] caam 30900000.crypto: Entropy delay = 11200
[    1.286875] caam 30900000.crypto: Entropy delay = 11600
[    1.292254] caam 30900000.crypto: Entropy delay = 12000
[    1.297636] caam 30900000.crypto: Entropy delay = 12400
[    1.303022] caam 30900000.crypto: failed to instantiate RNG
[    1.308603] caam: probe of 30900000.crypto failed with error -11
[    1.315519] usbcore: registered new interface driver usbhid
[    1.321132] usbhid: USB HID core driver
[    1.326846] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    1.336090] mmc2: new HS400 Enhanced strobe MMC card at address 0001
[    1.338504] NET: Registered PF_INET6 protocol family
[    1.343376] mmcblk2: mmc2:0001 IB2916 14.6 GiB
[    1.348881] Segment Routing with IPv6
[    1.353939]  mmcblk2: p1
[    1.355629] In-situ OAM (IOAM) with IPv6
[    1.358931] mmcblk2boot0: mmc2:0001 IB2916 4.00 MiB
[    1.362135] NET: Registered PF_PACKET protocol family
[    1.368312] mmcblk2boot1: mmc2:0001 IB2916 4.00 MiB
[    1.372035] 8021q: 802.1Q VLAN Support v1.8
[    1.378226] mmcblk2rpmb: mmc2:0001 IB2916 4.00 MiB, chardev (245:0)
[    1.381146] Key type dns_resolver registered
[    1.397532] registered taskstats version 1
[    1.402197] Loading compiled-in X.509 certificates
[    1.429427] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    1.439918] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    1.450145] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    1.460417] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    1.470760] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    1.481645] usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests
[    1.490090] usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests
[    1.499490] i2c i2c-0: IMX I2C adapter registered
[    1.504938] i2c i2c-1: IMX I2C adapter registered
[    1.510651] at24 2-0050: supply vcc not found, using dummy regulator
[    1.545479] i2c i2c-2: IMX I2C adapter registered
[    1.551234] i2c i2c-3: IMX I2C adapter registered
[    1.560291] pps pps0: new PPS source ptp0
[    1.568244] fec 30be0000.ethernet eth0: registered PHC device 0
[    1.575795] sdhci-esdhc-imx 30b50000.mmc: Got WP GPIO
[    1.576803] clk: Disabling unused clocks
[    1.612537] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
[    1.643039] EXT4-fs (mmcblk2p1): orphan cleanup on readonly fs
[    1.649085] EXT4-fs (mmcblk2p1): mounted filesystem c6b21368-2d43-4e41-b554-1b5ee3851e5c ro with ordered data mode. Quota mode: disabled.
[    1.656832] mmc1: new high speed SDHC card at address 0001
[    1.661547] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    1.667859] mmcblk1: mmc1:0001 ASTC 29.1 GiB (ro)
[    1.674414] devtmpfs: mounted
[    1.681206]  mmcblk1: p1
[    1.684863] Freeing unused kernel memory: 4352K
[    1.689502] Run /sbin/init as init process
[    1.817750] systemd[1]: System time before build time, advancing clock.
[    1.850220] systemd[1]: systemd 253.1^ running in system mode (-PAM -AUDIT -SELINUX -APPARMOR +IMA -SMACK -SECCOMP -GCRYPT -GNUTLS -OPENSSL -ACL +BLKID -CURL -ELFUTILS -FIDO2 -IDN2 -IDN -IPTC +KMOD -LIBCRYPTSETUP +LIBFDISK -PCRE2 -PWQUALITY -P11KIT -QRENCODE -TPM2 -BZIP2 -LZ4 -XZ -ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=hybrid)
[    1.882000] systemd[1]: Detected architecture arm64.


Regards,
Bastian

> 
>> -----Original Message-----
>> From: Bastian Krause <bst@pengutronix.de>
>> Sent: Tuesday, July 18, 2023 3:13 PM
>> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Horia Geanta
>> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
>> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
>> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Victoria Milhoan <vicki.milhoan@freescale.com>; Dan Douglass
>> <dan.douglass@nxp.com>; Vipul Kumar <vipul_kumar@mentor.com>;
>> kernel@pengutronix.de
>> Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
>>
>> On 7/17/23 14:43, Bastian Krause wrote:
>>> On 6/12/23 10:26, meenakshi.aggarwal@nxp.com wrote:
>>>> From: Victoria Milhoan <vicki.milhoan@freescale.com>
>>>>
>>>> Adjust RNG timing parameters to support more i.MX6 devices.
>>>>
>>>> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
>>>> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
>>>> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
>>>> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
>>>> ---
>>>>    drivers/crypto/caam/ctrl.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> This patch seems to breaks CAAM RNG instantiation on an i.MX8MM at my end:
>>>
>>> caam 30900000.crypto: Entropy delay = 3200 caam 30900000.crypto:
>>> Entropy delay = 3600 [...] caam 30900000.crypto: Entropy delay = 12400
>>> caam 30900000.crypto: failed to instantiate RNG
>>> caam: probe of 30900000.crypto failed with error -11
>>>
>>> If I revert this patch or increase RTSDCTL_ENT_DLY_MAX to a value >
>>> 66800, it works again:
>>>
>>> caam 30900000.crypto: Entropy delay = 32800 caam 30900000.crypto:
>>> Entropy delay = 33200 [...] caam 30900000.crypto: Entropy delay =
>>> 66800 caam 30900000.crypto: Instantiated RNG4 SH0 caam
>>> 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device ID
>>> = 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings = 2, qi =
>>> 0 caam algorithms registered in /proc/crypto caam 30900000.crypto:
>>> caam pkc algorithms registered in /proc/crypto caam 30900000.crypto:
>>> registering rng-caam Executing RNG SELF-TEST with wait
>>> random: crng init done
>>> caam 30900000.crypto: rng crypto API alg registered prng-caam
>>
>> This ^ was the kernel log for..
>>
>>
>> --- a/drivers/crypto/caam/regs.h
>> +++ b/drivers/crypto/caam/regs.h
>> @@@ -522,7 -522,7 +522,7 @@@ struct rng4tst
>>     #define RTSDCTL_ENT_DLY_SHIFT 16
>>     #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
>>     #define RTSDCTL_ENT_DLY_MIN 3200
>> --#define RTSDCTL_ENT_DLY_MAX 12800
>> ++#define RTSDCTL_ENT_DLY_MAX 70000
>>     #define RTSDCTL_SAMP_SIZE_MASK 0xffff
>>     #define RTSDCTL_SAMP_SIZE_VAL 512
>>           u32 rtsdctl;            /* seed control register */
>>
>>
>> For completion's sake: Reverting this patch..
>>
>>
>> --- a/drivers/crypto/caam/ctrl.c
>> +++ b/drivers/crypto/caam/ctrl.c
>> @@ -383,7 +383,7 @@ static void kick_trng(struct device *dev, int ent_delay)
>>                   /* min. freq. count, equal to 1/4 of the entropy sample length */
>>                   wr_reg32(&r4tst->rtfrqmin, val >> 2);
>>                   /* max. freq. count, equal to 16 times the entropy sample length */
>> -               wr_reg32(&r4tst->rtfrqmax, val << 4);
>> +               wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
>>           }
>>
>>           wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
>>
>>
>> ..produces this kernel log (without RNG SELF-TEST):
>>
>> caam 30900000.crypto: Entropy delay = 3200 caam 30900000.crypto: Entropy
>> delay = 3600 caam 30900000.crypto: Instantiated RNG4 SH0 caam
>> 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device ID =
>> 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings = 2, qi = 0 caam
>> algorithms registered in /proc/crypto caam 30900000.crypto: caam pkc
>> algorithms registered in /proc/crypto caam 30900000.crypto: registering rng-
>> caam caam 30900000.crypto: rng crypto API alg registered prng-caam
>> random: crng init done
>>
>> Regards,
>> Bastian
>>
>>>>
>>>> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
>>>> index 5fed3cf354c0..62dd069942e4 100644
>>>> --- a/drivers/crypto/caam/ctrl.c
>>>> +++ b/drivers/crypto/caam/ctrl.c
>>>> @@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int
>>>> ent_delay)
>>>>        wr_reg32(&r4tst->rtsdctl, val);
>>>>        /* min. freq. count, equal to 1/4 of the entropy sample length
>>>> */
>>>>        wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
>>>> -    /* disable maximum frequency count */
>>>> -    wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
>>>> +    /* max. freq. count, equal to 16 times the entropy sample length
>>>> +*/
>>>> +    wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
>>>>        /* read the control register */
>>>>        val = rd_reg32(&r4tst->rtmctl);
>>>>    start_rng:
>>>
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       |
>> http://www.pen/
>> gutronix.de%2F&data=05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C1f556
>> d6802434c00ef4f08db87736527%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
>> 0%7C0%7C638252701909887583%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
>> %7C%7C&sdata=2vCBBdo%2FAkyz%2BaLXcDyeursw3Gle%2FKosiO%2FdPysOd3
>> Q%3D&reserved=0  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

