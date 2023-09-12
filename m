Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19A79C822
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjILHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjILHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:24:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E8E73;
        Tue, 12 Sep 2023 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1694503432; x=1695108232; i=wahrenst@gmx.net;
 bh=WLTSLoQyvn3NqUrIdq6uTSTSGFkeL838zA40j40B47c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RuIldpeYGnJ+P3gwB9sxP9V3cj8RkgPnIGZCRBceEGNH7XXvN3uEqBTSsbLn2cHx/SkdUF+
 P4mCkncwiS6PxkIQ9cjArUA8FNiaY8t0hYQ5aCvmRu+BY82MY7WqGGKQIAQXiFXGZztnnJ9ZX
 HjeyZuQem6NJKan07JBhYriuVGyca7QbmZH9dZQkztngxND16snRv69ccsIYH1/P9EjU1WdiS
 NsndX6PZAC9nGFbM/SZDg0UlaENuvtPhyski0IlpCk1DYr01MSMa4a07xmHE2BWITcNVm3Ap9
 ecma52pDWmyrahXpM4ffFC6NSsohkd1QcHfBTGoN9/bZjL+j+xTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO2E-1rUium0eXQ-00oohc; Tue, 12
 Sep 2023 09:23:52 +0200
Message-ID: <7b7d322d-5ea6-5048-0cbe-8d292853ba12@gmx.net>
Date:   Tue, 12 Sep 2023 09:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
 <20230911140712.180751-2-umang.jain@ideasonboard.com>
 <c96262e7-9bd9-c75d-7584-e6ff62f69530@gmx.net>
 <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/PYI/32a7S6FIzg/IyeBaLL++rSAEVuvCyrLTaI80A8nU7lHmW
 2SrQQVrXk87OfqMwnucdwZ6L5yp3PJPLxupY8yby3uyJsM6bPj80I/rKaAdo0JgtMi4pv80
 uuiwCMQyYetxEgZ45n52SyFdwhYHGRtSJHuJe/1wJwO6bnPV0ucYiRQDnqgkKOQPtphLOMI
 vxchE0uRKqLbdb+EHwTBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7MxLoESzg7c=;mQBy+FHlS3yE5iDeoJ5d/8MEsdj
 AzCWt9NP0lCXOX54xAYAixiXG+Dalvb2HO3gT15FxVZxfI5nTeHgcHewRI0Q4ADhrvHSGRcMt
 hNXYxlf+MX5f35nbeGf66ga/SdJHErEudCSQE+6xxHK+xNbnKIpLDu8TYEri/RChZuULWLqYF
 DYg5EijJxoJLA0BWgQeVRBo0WjWoHg8JgJ/SKaZqp8bq9PmRXQylZKbZVps82HAvspTGBSzQn
 ODlU0f0823P81UfW9Aozi7ln9g/qjAuTR7Doo08xXhE3x9ZkzPCISnQ31vK5SQCvn2ZGTNx9y
 oNcsATPH6YstTzhrprXHZSS6M2yut1jKKOo00jwwXmcWzp0jmaP6Y+PZDdhbIVJbqj+trmWxj
 YHR3bI3LIDCCv/ssrT9xAjDgp8j2Dw/b8je6TUUrqlJbkr7fz5irCV6875T1YXvkTEWQcjeo8
 dcM6zQ0zJWHVpedQZFmeMKRNIq/yPyLK1CyMpK/GrpHAO3qe5l6u5/a3BAByPR52rNnEwFcPj
 SwcgwpihNElenFzNELcEkPOBk+rmLHcghuL5D6sOPsBKjh3bjJV2CL3N6HmcbulnmuBegcmC9
 Dy7EPdtYAghe7JvRSFdcS/7uHP76rGJVlkhDr5kk1OYoYNbI1KQS8IRRpXKd1rLM45D8ttE+E
 pOAxWFJQBImkNLb7fAI/vRVIumrp5o9ucO93IwbgCoFSXexl5hjdWDZ0AjXYUrCPkWMC78ZCt
 X/kdQGM2j3Kw65xLpRsuOGuydlxA3LAUDBbzHzRdEA/dohxUbhFAG/1VdohE4mvwUiddHatui
 QDFPBfXWde4OQoIkftVSNPyhs6wxaXDME39J19DXg3T+FUwSesadm3IxMbRUo+KjBpkvt+Squ
 EBX+ZBsxw6fbIfX8EOGBaYcNlBIkd+isCd62HPOuG/SczZtk7ZgEUEnxUaH3hVp5LTBDTHHW2
 BRLFGGM3XqVdecmdPMotkEfK2M8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 12.09.23 um 07:50 schrieb Umang Jain:
> Hi Stephan
>
> On 9/12/23 1:52 AM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 11.09.23 um 16:07 schrieb Umang Jain:
>>> ...
>>
>> Unfortunately the call of of_dma_configure() generates warnings likes
>> this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):
>>
>> [=C2=A0=C2=A0=C2=A0 9.206802] vchiq-bus bcm2835-audio: DMA mask not set
>> [=C2=A0=C2=A0=C2=A0 9.206892] vchiq-bus bcm2835-camera: DMA mask not se=
t
>
> huh, really weird, as on my RPi-3-b I get these set correctly and I
> don't any such warning.
This warning comes from this line [1]. Did you test with the mainline
devicetree from [2] which must be specified in the config.txt? Be aware
the arm dts files has moved into a sub directory just like arm64. I
don't use U-Boot, just the vendor bootloader from Raspberry Pi OS.
Please look at [3] for the details.
>
> I am even checking the ret value here, so if it can't set it, it will
> log an error. I don't that getting logged on my end. Can you share you
> entire dmesg output please?

Sure, see below

>
> Also, I have tested this against arm64 kernel, I assume you are using
> 32-bit?

Correct. This is what i meant with multi_v7_defconfig. It's my prefered
configuration to test BCM2837 for 32 bit ARM.

>
>>
>> In the old platform driver code we had something like
>>
>> =C2=A0 pdevinfo.dma_mask =3D DMA_BIT_MASK(32);
>>
>> So there is still something missing for our new bus driver.
>

[1] -
https://elixir.bootlin.com/linux/v6.6-rc1/source/drivers/of/device.c#L157
[2] -
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/boot/dts/broadcom?h=3Dv6.6-rc1
[3] - https://gist.github.com/lategoodbye/c7317a42bf7f9c07f5a91baed8c68f75

[=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x0
[=C2=A0=C2=A0=C2=A0 0.000000] Linux version 6.6.0-rc1-00005-g87898f8cfe33
(stefanw@stefanw-SCHENKER) (arm-linux-gnueabihf-gcc (GCC) 11.3.1
20220604 [releases/gcc-11 revision
591c0f4b92548e3ae2e8173f4f93984b1c7f62bb], GNU ld
(Linaro_Binutils-2022.06) 2.37.20220122) #86 SMP Mon Sep 11 21:17:00
CEST 2023
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (=
ARMv7),
cr=3D10c5383d
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: div instructions available: patching di=
vision code
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIP=
T aliasing
instruction cache
[=C2=A0=C2=A0=C2=A0 0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model=
 A Plus Rev 1.0
[=C2=A0=C2=A0=C2=A0 0.000000] random: crng init done
[=C2=A0=C2=A0=C2=A0 0.000000] Memory policy: Data cache writealloc
[=C2=A0=C2=A0=C2=A0 0.000000] efi: UEFI not found.
[=C2=A0=C2=A0=C2=A0 0.000000] Reserved memory: created CMA memory pool at =
0x17800000,
size 64 MiB
[=C2=A0=C2=A0=C2=A0 0.000000] OF: reserved mem: initialized node linux,cma=
, compatible
id shared-dma-pool
[=C2=A0=C2=A0=C2=A0 0.000000] OF: reserved mem: 0x17800000..0x1b7fffff (65=
536 KiB) map
reusable linux,cma
[=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
[=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [mem 0x0000000000000000-0x000000001bffffff]
[=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 empty
[=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 HighMem=C2=A0 empty
[=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
[=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
[=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x00000=
00000000000-0x000000001bffffff]
[=C2=A0=C2=A0=C2=A0 0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x000000001bffffff]
[=C2=A0=C2=A0=C2=A0 0.000000] percpu: Embedded 16 pages/cpu s36180 r8192 d=
21164 u65536
[=C2=A0=C2=A0=C2=A0 0.000000] pcpu-alloc: s36180 r8192 d21164 u65536 alloc=
=3D16*4096
[=C2=A0=C2=A0=C2=A0 0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line: video=3DHDMI-A-1:1920x1=
200M@60
dma.dmachans=3D0x7ff5 bcm2709.boardrev=3D0x9020e0 bcm2709.serial=3D0x48390=
b9c
bcm2709.uart_clock=3D48000000 bcm2709.disk_led_gpio=3D29
bcm2709.disk_led_active_low=3D0 smsc95xx.macaddr=3DB8:27:EB:39:0B:9C
vc_mem.mem_base=3D0x1ec00000 vc_mem.mem_size=3D0x20000000=C2=A0
console=3DttyS1,115200 console=3Dtty1 root=3DPARTUUID=3Da5c5156c-02
rootfstype=3Dext4 elevator=3Ddeadline fsck.repair=3Dyes rootwait
plymouth.ignore-serial-consoles
[=C2=A0=C2=A0=C2=A0 0.000000] Kernel parameter elevator=3D does not have a=
ny effect anymore.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Please use sysfs to set IO scheduler for individual devices.
[=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 65536 (orde=
r: 6, 262144
bytes, linear)
[=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 32768 (order=
: 5, 131072
bytes, linear)
[=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=C2=
=A0 Total pages: 113792
[=C2=A0=C2=A0=C2=A0 0.000000] mem auto-init: stack:off, heap alloc:off, he=
ap free:off
[=C2=A0=C2=A0=C2=A0 0.000000] Memory: 361268K/458752K available (15360K ke=
rnel code,
2470K rwdata, 6440K rodata, 2048K init, 416K bss, 31948K reserved,
65536K cma-reserved, 0K highmem)
[=C2=A0=C2=A0=C2=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D4, Nodes=3D1
[=C2=A0=C2=A0=C2=A0 0.000000] trace event string verifier disabled
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: Hierarchical RCU implementation.
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: =C2=A0=C2=A0=C2=A0 RCU event tracing is=
 enabled.
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: =C2=A0=C2=A0=C2=A0 RCU restricting CPUs=
 from NR_CPUS=3D16 to
nr_cpu_ids=3D4.
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: RCU calculated value of scheduler-enlis=
tment delay
is 10 jiffies.
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=
=3D16, nr_cpu_ids=3D4
[=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs:=
 16
[=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct sizes ba=
sed on
contention.
[=C2=A0=C2=A0=C2=A0 0.000002] sched_clock: 32 bits at 1000kHz, resolution =
1000ns, wraps
every 2147483647500ns
[=C2=A0=C2=A0=C2=A0 0.000022] clocksource: timer: mask: 0xffffffff max_cyc=
les:
0xffffffff, max_idle_ns: 1911260446275 ns
[=C2=A0=C2=A0=C2=A0 0.000081] bcm2835: system timer (irq =3D 60)
[=C2=A0=C2=A0=C2=A0 0.002740] arch_timer: cp15 timer(s) running at 19.20MH=
z (phys).
[=C2=A0=C2=A0=C2=A0 0.002761] clocksource: arch_sys_counter: mask: 0xfffff=
fffffffff
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[=C2=A0=C2=A0=C2=A0 0.002778] sched_clock: 56 bits at 19MHz, resolution 52=
ns, wraps
every 4398046511078ns
[=C2=A0=C2=A0=C2=A0 0.002795] Switching to timer-based delay loop, resolut=
ion 52ns
[=C2=A0=C2=A0=C2=A0 0.003698] Console: colour dummy device 80x30
[=C2=A0=C2=A0=C2=A0 0.003714] printk: console [tty1] enabled
[=C2=A0=C2=A0=C2=A0 0.004615] Calibrating delay loop (skipped), value calc=
ulated using
timer frequency.. 38.40 BogoMIPS (lpj=3D192000)
[=C2=A0=C2=A0=C2=A0 0.004661] CPU: Testing write buffer coherency: ok
[=C2=A0=C2=A0=C2=A0 0.004724] pid_max: default: 32768 minimum: 301
[=C2=A0=C2=A0=C2=A0 0.004877] Mount-cache hash table entries: 1024 (order:=
 0, 4096
bytes, linear)
[=C2=A0=C2=A0=C2=A0 0.004918] Mountpoint-cache hash table entries: 1024 (o=
rder: 0, 4096
bytes, linear)
[=C2=A0=C2=A0=C2=A0 0.005864] CPU0: thread -1, cpu 0, socket 0, mpidr 8000=
0000
[=C2=A0=C2=A0=C2=A0 0.006739] Setting up static identity map for 0x300000 =
- 0x3000ac
[=C2=A0=C2=A0=C2=A0 0.007682] rcu: Hierarchical SRCU implementation.
[=C2=A0=C2=A0=C2=A0 0.007707] rcu: =C2=A0=C2=A0=C2=A0 Max phase no-delay i=
nstances is 1000.
[=C2=A0=C2=A0=C2=A0 0.010038] EFI services will not be available.
[=C2=A0=C2=A0=C2=A0 0.010319] smp: Bringing up secondary CPUs ...
[=C2=A0=C2=A0=C2=A0 0.011142] CPU1: thread -1, cpu 1, socket 0, mpidr 8000=
0001
[=C2=A0=C2=A0=C2=A0 0.012181] CPU2: thread -1, cpu 2, socket 0, mpidr 8000=
0002
[=C2=A0=C2=A0=C2=A0 0.013167] CPU3: thread -1, cpu 3, socket 0, mpidr 8000=
0003
[=C2=A0=C2=A0=C2=A0 0.013406] smp: Brought up 1 node, 4 CPUs
[=C2=A0=C2=A0=C2=A0 0.013491] SMP: Total of 4 processors activated (153.60=
 BogoMIPS).
[=C2=A0=C2=A0=C2=A0 0.013518] CPU: All CPU(s) started in HYP mode.
[=C2=A0=C2=A0=C2=A0 0.013537] CPU: Virtualization extensions available.
[=C2=A0=C2=A0=C2=A0 0.014516] devtmpfs: initialized
[=C2=A0=C2=A0=C2=A0 0.022261] VFP support v0.3: implementor 41 architectur=
e 3 part 40
variant 3 rev 4
[=C2=A0=C2=A0=C2=A0 0.022568] clocksource: jiffies: mask: 0xffffffff max_c=
ycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[=C2=A0=C2=A0=C2=A0 0.022621] futex hash table entries: 1024 (order: 4, 65=
536 bytes,
linear)
[=C2=A0=C2=A0=C2=A0 0.025174] pinctrl core: initialized pinctrl subsystem
[=C2=A0=C2=A0=C2=A0 0.027732] DMI not present or invalid.
[=C2=A0=C2=A0=C2=A0 0.028226] NET: Registered PF_NETLINK/PF_ROUTE protocol=
 family
[=C2=A0=C2=A0=C2=A0 0.030852] DMA: preallocated 256 KiB pool for atomic co=
herent
allocations
[=C2=A0=C2=A0=C2=A0 0.035838] thermal_sys: Registered thermal governor 'st=
ep_wise'
[=C2=A0=C2=A0=C2=A0 0.035910] cpuidle: using governor menu
[=C2=A0=C2=A0=C2=A0 0.036454] No ATAGs?
[=C2=A0=C2=A0=C2=A0 0.036613] hw-breakpoint: found 5 (+1 reserved) breakpo=
int and 4
watchpoint registers.
[=C2=A0=C2=A0=C2=A0 0.036651] hw-breakpoint: maximum watchpoint size is 8 =
bytes.
[=C2=A0=C2=A0=C2=A0 0.039402] Serial: AMBA PL011 UART driver
[=C2=A0=C2=A0=C2=A0 0.067841] iommu: Default domain type: Translated
[=C2=A0=C2=A0=C2=A0 0.067886] iommu: DMA domain TLB invalidation policy: s=
trict mode
[=C2=A0=C2=A0=C2=A0 0.068938] SCSI subsystem initialized
[=C2=A0=C2=A0=C2=A0 0.069165] libata version 3.00 loaded.
[=C2=A0=C2=A0=C2=A0 0.069441] usbcore: registered new interface driver usb=
fs
[=C2=A0=C2=A0=C2=A0 0.069502] usbcore: registered new interface driver hub
[=C2=A0=C2=A0=C2=A0 0.069568] usbcore: registered new device driver usb
[=C2=A0=C2=A0=C2=A0 0.069861] usb_phy_generic phy: dummy supplies not allo=
wed for
exclusive requests
[=C2=A0=C2=A0=C2=A0 0.071286] pps_core: LinuxPPS API ver. 1 registered
[=C2=A0=C2=A0=C2=A0 0.071311] pps_core: Software ver. 5.3.6 - Copyright 20=
05-2007
Rodolfo Giometti <giometti@linux.it>
[=C2=A0=C2=A0=C2=A0 0.071358] PTP clock support registered
[=C2=A0=C2=A0=C2=A0 0.071579] EDAC MC: Ver: 3.0.0
[=C2=A0=C2=A0=C2=A0 0.072267] scmi_core: SCMI protocol bus registered
[=C2=A0=C2=A0=C2=A0 0.074843] vgaarb: loaded
[=C2=A0=C2=A0=C2=A0 1.884992] clocksource: Switched to clocksource arch_sy=
s_counter
[=C2=A0=C2=A0=C2=A0 1.901738] NET: Registered PF_INET protocol family
[=C2=A0=C2=A0=C2=A0 1.901985] IP idents hash table entries: 8192 (order: 4=
, 65536
bytes, linear)
[=C2=A0=C2=A0=C2=A0 1.903408] tcp_listen_portaddr_hash hash table entries:=
 512 (order:
0, 4096 bytes, linear)
[=C2=A0=C2=A0=C2=A0 1.903467] Table-perturb hash table entries: 65536 (ord=
er: 6, 262144
bytes, linear)
[=C2=A0=C2=A0=C2=A0 1.903506] TCP established hash table entries: 4096 (or=
der: 2, 16384
bytes, linear)
[=C2=A0=C2=A0=C2=A0 1.903590] TCP bind hash table entries: 4096 (order: 4,=
 65536 bytes,
linear)
[=C2=A0=C2=A0=C2=A0 1.903780] TCP: Hash tables configured (established 409=
6 bind 4096)
[=C2=A0=C2=A0=C2=A0 1.903903] UDP hash table entries: 256 (order: 1, 8192 =
bytes, linear)
[=C2=A0=C2=A0=C2=A0 1.903953] UDP-Lite hash table entries: 256 (order: 1, =
8192 bytes,
linear)
[=C2=A0=C2=A0=C2=A0 1.904097] NET: Registered PF_UNIX/PF_LOCAL protocol fa=
mily
[=C2=A0=C2=A0=C2=A0 1.904626] RPC: Registered named UNIX socket transport =
module.
[=C2=A0=C2=A0=C2=A0 1.904658] RPC: Registered udp transport module.
[=C2=A0=C2=A0=C2=A0 1.904680] RPC: Registered tcp transport module.
[=C2=A0=C2=A0=C2=A0 1.904699] RPC: Registered tcp-with-tls transport modul=
e.
[=C2=A0=C2=A0=C2=A0 1.904720] RPC: Registered tcp NFSv4.1 backchannel tran=
sport module.
[=C2=A0=C2=A0=C2=A0 1.904752] PCI: CLS 0 bytes, default 64
[=C2=A0=C2=A0=C2=A0 1.906790] Initialise system trusted keyrings
[=C2=A0=C2=A0=C2=A0 1.907031] workingset: timestamp_bits=3D30 max_order=3D=
17 bucket_order=3D0
[=C2=A0=C2=A0=C2=A0 1.907428] squashfs: version 4.0 (2009/01/31) Phillip L=
ougher
[=C2=A0=C2=A0=C2=A0 1.907895] NFS: Registering the id_resolver key type
[=C2=A0=C2=A0=C2=A0 1.907941] Key type id_resolver registered
[=C2=A0=C2=A0=C2=A0 1.907963] Key type id_legacy registered
[=C2=A0=C2=A0=C2=A0 1.908005] nfs4filelayout_init: NFSv4 File Layout Drive=
r Registering...
[=C2=A0=C2=A0=C2=A0 1.908032] nfs4flexfilelayout_init: NFSv4 Flexfile Layo=
ut Driver
Registering...
[=C2=A0=C2=A0=C2=A0 1.908093] ntfs: driver 2.1.32 [Flags: R/O].
[=C2=A0=C2=A0=C2=A0 1.908391] Key type asymmetric registered
[=C2=A0=C2=A0=C2=A0 1.908416] Asymmetric key parser 'x509' registered
[=C2=A0=C2=A0=C2=A0 1.908511] Block layer SCSI generic (bsg) driver versio=
n 0.4 loaded
(major 246)
[=C2=A0=C2=A0=C2=A0 1.908545] io scheduler mq-deadline registered
[=C2=A0=C2=A0=C2=A0 1.908574] io scheduler kyber registered
[=C2=A0=C2=A0=C2=A0 1.908613] io scheduler bfq registered
[=C2=A0=C2=A0=C2=A0 1.929416] simple-framebuffer 1e330000.framebuffer: fra=
mebuffer at
0x1e330000, 0x8ca000 bytes
[=C2=A0=C2=A0=C2=A0 1.929483] simple-framebuffer 1e330000.framebuffer: for=
mat=3Da8r8g8b8,
mode=3D1920x1200x32, linelength=3D7680
[=C2=A0=C2=A0=C2=A0 1.960899] Console: switching to colour frame buffer de=
vice 240x75
[=C2=A0=C2=A0=C2=A0 1.991759] simple-framebuffer 1e330000.framebuffer: fb0=
: simplefb
registered!
[=C2=A0=C2=A0=C2=A0 2.068642] Serial: 8250/16550 driver, 5 ports, IRQ shar=
ing enabled
[=C2=A0=C2=A0=C2=A0 2.072833] printk: console [ttyS1] disabled
[=C2=A0=C2=A0=C2=A0 2.073399] 3f215040.serial: ttyS1 at MMIO 0x3f215040 (i=
rq =3D 86,
base_baud =3D 50000000) is a 16550
[=C2=A0=C2=A0=C2=A0 2.073651] printk: console [ttyS1] enabled
[=C2=A0=C2=A0=C2=A0 2.920538] SuperH (H)SCI(F) driver initialized
[=C2=A0=C2=A0=C2=A0 2.926208] msm_serial: driver initialized
[=C2=A0=C2=A0=C2=A0 2.930462] STMicroelectronics ASC driver initialized
[=C2=A0=C2=A0=C2=A0 2.936679] STM32 USART driver initialized
[=C2=A0=C2=A0=C2=A0 2.942745] bcm2835-rng 3f104000.rng: hwrng registered
[=C2=A0=C2=A0=C2=A0 2.963592] brd: module loaded
[=C2=A0=C2=A0=C2=A0 2.973113] loop: module loaded
[=C2=A0=C2=A0=C2=A0 2.978223] bcm2835-power bcm2835-power: Broadcom BCM283=
5 power
domains driver
[=C2=A0=C2=A0=C2=A0 2.998682] CAN device driver interface
[=C2=A0=C2=A0=C2=A0 3.003790] bgmac_bcma: Broadcom 47xx GBit MAC driver lo=
aded
[=C2=A0=C2=A0=C2=A0 3.010882] e1000e: Intel(R) PRO/1000 Network Driver
[=C2=A0=C2=A0=C2=A0 3.016055] e1000e: Copyright(c) 1999 - 2015 Intel Corpo=
ration.
[=C2=A0=C2=A0=C2=A0 3.022233] igb: Intel(R) Gigabit Ethernet Network Drive=
r
[=C2=A0=C2=A0=C2=A0 3.027849] igb: Copyright (c) 2007-2014 Intel Corporati=
on.
[=C2=A0=C2=A0=C2=A0 3.037688] pegasus: Pegasus/Pegasus II USB Ethernet dri=
ver
[=C2=A0=C2=A0=C2=A0 3.043514] usbcore: registered new interface driver peg=
asus
[=C2=A0=C2=A0=C2=A0 3.049435] usbcore: registered new interface driver asi=
x
[=C2=A0=C2=A0=C2=A0 3.055088] usbcore: registered new interface driver ax8=
8179_178a
[=C2=A0=C2=A0=C2=A0 3.061433] usbcore: registered new interface driver cdc=
_ether
[=C2=A0=C2=A0=C2=A0 3.067537] usbcore: registered new interface driver sms=
c75xx
[=C2=A0=C2=A0=C2=A0 3.073532] usbcore: registered new interface driver sms=
c95xx
[=C2=A0=C2=A0=C2=A0 3.079540] usbcore: registered new interface driver net=
1080
[=C2=A0=C2=A0=C2=A0 3.085461] usbcore: registered new interface driver cdc=
_subset
[=C2=A0=C2=A0=C2=A0 3.091635] usbcore: registered new interface driver zau=
rus
[=C2=A0=C2=A0=C2=A0 3.097493] usbcore: registered new interface driver cdc=
_ncm
[=C2=A0=C2=A0=C2=A0 3.107490] usbcore: registered new interface driver usb=
-storage
[=C2=A0=C2=A0=C2=A0 3.118756] i2c_dev: i2c /dev entries driver
[=C2=A0=C2=A0=C2=A0 3.125053] i2c-bcm2835 3f805000.i2c: Could not read clo=
ck-frequency
property
[=C2=A0=C2=A0=C2=A0 3.143909] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 wa=
tchdog timer
[=C2=A0=C2=A0=C2=A0 3.155422] sdhci: Secure Digital Host Controller Interf=
ace driver
[=C2=A0=C2=A0=C2=A0 3.161859] sdhci: Copyright(c) Pierre Ossman
[=C2=A0=C2=A0=C2=A0 3.168191] Synopsys Designware Multimedia Card Interfac=
e Driver
[=C2=A0=C2=A0=C2=A0 3.176079] sdhci-pltfm: SDHCI platform and OF driver he=
lper
[=C2=A0=C2=A0=C2=A0 3.186318] sdhci-iproc 3f300000.mmc: allocated mmc-pwrs=
eq
[=C2=A0=C2=A0=C2=A0 3.192194] ledtrig-cpu: registered to indicate activity=
 on CPUs
[=C2=A0=C2=A0=C2=A0 3.200162] usbcore: registered new interface driver usb=
hid
[=C2=A0=C2=A0=C2=A0 3.206009] usbhid: USB HID core driver
[=C2=A0=C2=A0=C2=A0 3.210952] bcm2835-mbox 3f00b880.mailbox: mailbox enabl=
ed
[=C2=A0=C2=A0=C2=A0 3.221958] NET: Registered PF_INET6 protocol family
[=C2=A0=C2=A0=C2=A0 3.228309] Segment Routing with IPv6
[=C2=A0=C2=A0=C2=A0 3.230085] mmc1: SDHCI controller on 3f300000.mmc [3f30=
0000.mmc]
using PIO
[=C2=A0=C2=A0=C2=A0 3.235506] In-situ OAM (IOAM) with IPv6
[=C2=A0=C2=A0=C2=A0 3.264571] sit: IPv6, IPv4 and MPLS over IPv4 tunneling=
 driver
[=C2=A0=C2=A0=C2=A0 3.278548] NET: Registered PF_PACKET protocol family
[=C2=A0=C2=A0=C2=A0 3.290943] can: controller area network core
[=C2=A0=C2=A0=C2=A0 3.302686] NET: Registered PF_CAN protocol family
[=C2=A0=C2=A0=C2=A0 3.310422] sdhost-bcm2835 3f202000.mmc: loaded - DMA en=
abled (>1)
[=C2=A0=C2=A0=C2=A0 3.314775] can: raw protocol
[=C2=A0=C2=A0=C2=A0 3.338588] can: broadcast manager protocol
[=C2=A0=C2=A0=C2=A0 3.340768] mmc1: new high speed SDIO card at address 00=
01
[=C2=A0=C2=A0=C2=A0 3.345840] can: netlink gateway - max_hops=3D1
[=C2=A0=C2=A0=C2=A0 3.375015] Key type dns_resolver registered
[=C2=A0=C2=A0=C2=A0 3.386990] Registering SWP/SWPB emulation handler
[=C2=A0=C2=A0=C2=A0 3.410876] Loading compiled-in X.509 certificates
[=C2=A0=C2=A0=C2=A0 3.438851] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 =
(irq =3D 114,
base_baud =3D 0) is a PL011 rev2
[=C2=A0=C2=A0=C2=A0 3.439796] mmc0: host does not support reading read-onl=
y switch,
assuming write-enable
[=C2=A0=C2=A0=C2=A0 3.446571] serial serial0: tty port ttyAMA0 registered
[=C2=A0=C2=A0=C2=A0 3.456776] mmc0: new high speed SDHC card at address 00=
07
[=C2=A0=C2=A0=C2=A0 3.465830] raspberrypi-firmware soc:firmware: Attached =
to firmware
from 2022-08-26T14:04:36
[=C2=A0=C2=A0=C2=A0 3.469479] mmcblk0: mmc0:0007 SDCIT 14.6 GiB
[=C2=A0=C2=A0=C2=A0 3.526657]=C2=A0 mmcblk0: p1 p2
[=C2=A0=C2=A0=C2=A0 4.026948] dwc2 3f980000.usb: supply vusb_d not found, =
using dummy
regulator
[=C2=A0=C2=A0=C2=A0 4.039587] dwc2 3f980000.usb: supply vusb_a not found, =
using dummy
regulator
[=C2=A0=C2=A0=C2=A0 4.104176] dwc2 3f980000.usb: DWC OTG Controller
[=C2=A0=C2=A0=C2=A0 4.116471] dwc2 3f980000.usb: new USB bus registered, a=
ssigned bus
number 1
[=C2=A0=C2=A0=C2=A0 4.131137] dwc2 3f980000.usb: irq 66, io mem 0x3f980000
[=C2=A0=C2=A0=C2=A0 4.144958] hub 1-0:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 4.152675] hub 1-0:1.0: 1 port detected
[=C2=A0=C2=A0=C2=A0 4.164850] clk: Disabling unused clocks
[=C2=A0=C2=A0=C2=A0 4.184045] EXT4-fs (mmcblk0p2): mounted filesystem
3857a514-b0f4-49ce-8430-34762068bb6f ro with ordered data mode. Quota
mode: disabled.
[=C2=A0=C2=A0=C2=A0 4.201851] VFS: Mounted root (ext4 filesystem) readonly=
 on device 179:2.
[=C2=A0=C2=A0=C2=A0 4.214447] devtmpfs: mounted
[=C2=A0=C2=A0=C2=A0 4.222679] Freeing unused kernel image (initmem) memory=
: 2048K
[=C2=A0=C2=A0=C2=A0 4.232336] Run /sbin/init as init process
[=C2=A0=C2=A0=C2=A0 4.239831]=C2=A0=C2=A0 with arguments:
[=C2=A0=C2=A0=C2=A0 4.239834]=C2=A0=C2=A0=C2=A0=C2=A0 /sbin/init
[=C2=A0=C2=A0=C2=A0 4.239838]=C2=A0=C2=A0 with environment:
[=C2=A0=C2=A0=C2=A0 4.239841]=C2=A0=C2=A0=C2=A0=C2=A0 HOME=3D/
[=C2=A0=C2=A0=C2=A0 4.239844]=C2=A0=C2=A0=C2=A0=C2=A0 TERM=3Dlinux
[=C2=A0=C2=A0=C2=A0 4.843914] systemd[1]: System time before build time, a=
dvancing clock.
[=C2=A0=C2=A0=C2=A0 4.953515] systemd[1]: systemd 241 running in system mo=
de. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN
-PCRE2 default-hierarchy=3Dhybrid)
[=C2=A0=C2=A0=C2=A0 4.989282] systemd[1]: Detected architecture arm.
[=C2=A0=C2=A0=C2=A0 5.020664] systemd[1]: Set hostname to <raspberrypi>.
[=C2=A0=C2=A0=C2=A0 5.432605] systemd[1]: File
/lib/systemd/system/systemd-journald.service:12 configures an IP
firewall (IPAddressDeny=3Dany), but the local system does not support
BPF/cgroup based firewalling.
[=C2=A0=C2=A0=C2=A0 5.456249] systemd[1]: Proceeding WITHOUT firewalling i=
n effect!
(This warning is only shown for the first loaded unit using IP firewalling=
.)
[=C2=A0=C2=A0=C2=A0 5.842271] systemd[1]: Listening on Journal Socket (/de=
v/log).
[=C2=A0=C2=A0=C2=A0 5.860471] systemd[1]: Listening on fsck to fsckd commu=
nication Socket.
[=C2=A0=C2=A0=C2=A0 5.876658] systemd[1]: Listening on udev Control Socket=
.
[=C2=A0=C2=A0=C2=A0 5.890786] systemd[1]: Listening on udev Kernel Socket.
[=C2=A0=C2=A0=C2=A0 5.905241] systemd[1]: Created slice User and Session S=
lice.
[=C2=A0=C2=A0=C2=A0 8.050246] EXT4-fs (mmcblk0p2): re-mounted
3857a514-b0f4-49ce-8430-34762068bb6f r/w. Quota mode: disabled.
[=C2=A0=C2=A0=C2=A0 8.167738] systemd-journald[105]: Received request to f=
lush runtime
journal from PID 1
[=C2=A0=C2=A0=C2=A0 9.190328] vchiq: module is from the staging directory,=
 the quality
is unknown, you have been warned.
[=C2=A0=C2=A0=C2=A0 9.206802] vchiq-bus bcm2835-audio: DMA mask not set
[=C2=A0=C2=A0=C2=A0 9.206892] vchiq-bus bcm2835-camera: DMA mask not set
[=C2=A0=C2=A0=C2=A0 9.427708] Bluetooth: Core ver 2.22
[=C2=A0=C2=A0=C2=A0 9.427791] NET: Registered PF_BLUETOOTH protocol family
[=C2=A0=C2=A0=C2=A0 9.427800] Bluetooth: HCI device and connection manager=
 initialized
[=C2=A0=C2=A0=C2=A0 9.427824] Bluetooth: HCI socket layer initialized
[=C2=A0=C2=A0=C2=A0 9.427833] Bluetooth: L2CAP socket layer initialized
[=C2=A0=C2=A0=C2=A0 9.427847] Bluetooth: SCO socket layer initialized
[=C2=A0=C2=A0=C2=A0 9.547412] Bluetooth: HCI UART driver ver 2.3
[=C2=A0=C2=A0=C2=A0 9.547448] Bluetooth: HCI UART protocol H4 registered
[=C2=A0=C2=A0=C2=A0 9.547942] Bluetooth: HCI UART protocol Broadcom regist=
ered
[=C2=A0=C2=A0=C2=A0 9.549244] hci_uart_bcm serial0-0: supply vbat not foun=
d, using
dummy regulator
[=C2=A0=C2=A0=C2=A0 9.549456] hci_uart_bcm serial0-0: supply vddio not fou=
nd, using
dummy regulator
[=C2=A0=C2=A0=C2=A0 9.549522] hci_uart_bcm serial0-0: No reset resource, u=
sing default
baud rate
[=C2=A0=C2=A0=C2=A0 9.554412] cfg80211: Loading compiled-in X.509 certific=
ates for
regulatory database
[=C2=A0=C2=A0=C2=A0 9.665377] uart-pl011 3f201000.serial: no DMA platform =
data
[=C2=A0=C2=A0=C2=A0 9.868055] Loaded X.509 cert 'sforshee: 00b28ddf47aef9c=
ea7'
[=C2=A0=C2=A0=C2=A0 9.932284] Bluetooth: hci0: BCM: chip id 107
[=C2=A0=C2=A0=C2=A0 9.934550] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0=C2=A0 9.939239] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[=C2=A0=C2=A0=C2=A0 9.957852] Bluetooth: hci0: BCM4345C0
[=C2=A0=C2=A0=C2=A0 9.957877] Bluetooth: hci0: BCM4345C0 (003.001.025) bui=
ld 0000
[=C2=A0=C2=A0=C2=A0 9.967333] brcmfmac mmc1:0001:1: Direct firmware load f=
or
brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.bin failed with error -=
2
[=C2=A0=C2=A0 10.053005] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' P=
atch
[=C2=A0=C2=A0 10.061320] Console: switching to colour dummy device 80x30
[=C2=A0=C2=A0 10.084466] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_=
ops [vc4])
[=C2=A0=C2=A0 10.122320] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdm=
i_ops [vc4])
[=C2=A0=C2=A0 10.122547] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_=
ops [vc4])
[=C2=A0=C2=A0 10.122730] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_=
ops [vc4])
[=C2=A0=C2=A0 10.122872] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0 10.123004] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0 10.123133] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0 10.123258] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_=
ops [vc4])
[=C2=A0=C2=A0 10.128918] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu =
on minor 0
[=C2=A0=C2=A0 10.218980] Console: switching to colour frame buffer device =
240x75
[=C2=A0=C2=A0 10.245316] vc4-drm soc:gpu: [drm] fb0: vc4drmfb frame buffer=
 device
[=C2=A0=C2=A0 10.274786] snd_bcm2835: module is from the staging directory=
, the
quality is unknown, you have been warned.
[=C2=A0=C2=A0 10.277567] bcm2835-audio bcm2835-audio: card created with 8 =
channels
[=C2=A0=C2=A0 10.330733] mc: Linux media interface: v0.10
[=C2=A0=C2=A0 10.341921] brcmfmac: brcmf_c_process_txcap_blob: no txcap_bl=
ob
available (err=3D-2)
[=C2=A0=C2=A0 10.342362] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM434=
5/6 wl0:
Jan=C2=A0 4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
[=C2=A0=C2=A0 10.407854] videodev: Linux video capture interface: v2.00
[=C2=A0=C2=A0 10.459897] bcm2835_mmal_vchiq: module is from the staging di=
rectory,
the quality is unknown, you have been warned.
[=C2=A0=C2=A0 10.470977] bcm2835_v4l2: module is from the staging director=
y, the
quality is unknown, you have been warned.
[=C2=A0=C2=A0 10.780230] alsactl[236]: memfd_create() called without MFD_E=
XEC or
MFD_NOEXEC_SEAL set
[=C2=A0=C2=A0 10.780230] alsactl[216]: memfd_create() called without MFD_E=
XEC or
MFD_NOEXEC_SEAL set
[=C2=A0=C2=A0 13.854105] Adding 102396k swap on /var/swap.=C2=A0 Priority:=
-2 extents:1
across:102396k SS
[=C2=A0=C2=A0 15.909255] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0 15.932508] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
[=C2=A0=C2=A0 15.932532] Bluetooth: hci0: BCM4345C0 (003.001.025) build 03=
42
[=C2=A0=C2=A0 16.593213] Bluetooth: MGMT ver 1.22
[=C2=A0=C2=A0 22.184944] usb 1-1: new low-speed USB device number 2 using =
dwc2
[=C2=A0=C2=A0 22.446694] input: PixArt Microsoft USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1:1.0/0003:045E:00CB.0001/in=
put/input0
[=C2=A0=C2=A0 22.447000] hid-generic 0003:045E:00CB.0001: input: USB HID v=
1.11
Mouse [PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1/input0
[=C2=A0=C2=A0 41.545014] usb 1-1: USB disconnect, device number 2
[=C2=A0=C2=A0 44.954930] usb 1-1: new low-speed USB device number 3 using =
dwc2
[=C2=A0=C2=A0 45.226584] input: HID 046a:0011 as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1:1.0/0003:046A:0011.0002/in=
put/input1
[=C2=A0=C2=A0 45.295525] hid-generic 0003:046A:0011.0002: input: USB HID v=
1.11
Keyboard [HID 046a:0011] on usb-3f980000.usb-1/input0
