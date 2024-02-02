Return-Path: <linux-kernel+bounces-49470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B9846ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835BB1F2344D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4E18AF6;
	Fri,  2 Feb 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="UsVlMLNc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594A182BE;
	Fri,  2 Feb 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862537; cv=none; b=qrYUlrDyzKMwPyZxPRyvs+XazGund2hvJb89vDFPPWCCaAN2CohF6eKKxRdeqSNRl1B150MBTJpovzYRBlTKHwjh/AyktypHy/WX0RZUbqzFIv+j9G3wp14ue6Jp+FeuPzAahDjIcN3ToF+sLZoUZm19HKjyi40o8Sri8LOqEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862537; c=relaxed/simple;
	bh=q13ukHh5bV1pPUvh85t4w4azsK08ajP2NWJq+aARMrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2IvSEzK5pmT7hHbIbYiGRvKqqXgl0pqcb8I2UiqPknsZKTGb9d5JfQpzGsWYAsUnM4B257S0lJl5/evJnUscyURsorlcB2/MOYUrNVAeGBcTmQe3pN6+515wsGCCaFL/3Nsx+J8vupGQLvXX9z3uK2z2hcffxiM1aFgY+cE19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=UsVlMLNc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706862526; x=1707467326; i=deller@gmx.de;
	bh=q13ukHh5bV1pPUvh85t4w4azsK08ajP2NWJq+aARMrQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UsVlMLNc4ggrTFalyQKEWsIhf4UL23iVFZ0JkkbNSuBolcLXgl+T3BCs40TAqZvF
	 3osa6XSzObVfVyqMdHrlBQuZYklhN2c8QVuPv53KmqMcCe/LfEKE+rv0PLSTa3yoq
	 b5G1R9aHbzs7gmMvrtlbDYUmWvxHY1zMwKKV/AJ8diEnha5nEXgfQWaaV+yfd9XU/
	 59Xz7Zx9hnGRAJaIX62iOHkV61Q+A838VMfbirDmEHF+lEru7R6LECguIAlA/kYWS
	 b4bGqghyCq3pkKNDapv+znSP3bFQCrQLeC9xsl6qoML0BdUb5V9xfGKF5rJ4y/3x+
	 unmBgKAzTv+0jdjJ2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.153.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1rE9VO2BuK-00qzNY; Fri, 02
 Feb 2024 09:28:46 +0100
Message-ID: <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
Date: Fri, 2 Feb 2024 09:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Helge Deller <deller@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <ZbqfMR_mVLaSCj4Q@carbonx1> <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
 <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ipmvDoZLlJVuhpJP5isqbbXaf1SBQxqxh2mG9K9192nUiG8FJpi
 3axPNOpBCcX+HDcKlYy2YTp2vKGp7poDvr+H7CcyqPxP3O9z+sVc0HClgiI3PMZEc1AQKy+
 kE9dbYocG1VBbCrGxgOCdPCPm8a89WTuVRsvO5iPmHa+ercDDvlnUy0uto6hj0fU9bEEUtr
 MKX8Q3pxt3R7DA5qm8YEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:neSYiQ+dFqY=;chhKuJ2hVdC1eqVUAGJTx6iZRX/
 1DV4MGigwqD1U0+rXDQx2LFdXQBWiGCp0KIdGHnQtMNcn3MhCefV2W8hezdGpsEb0MaJyne9I
 TF/SfD+TybNcm49rofnYmF9Li9o8SMpbea5lFx8YH9mDfiaLEUsrsW8OSKqPyqw+/7gDw43AS
 6L9LAh0u2gMLMu3qJ642jxX9KQ9F9HCLn4ok0JCBMk70FDTn0glwOLtPohILnhtJhFrGClvJj
 pydrR4yOtaQcMZtpk+IY/NvLPuJuwjqqPofcKOttCbKvrjZ0jCb7dbYY9bOBn4M8hn/yYAN9Z
 UrfllTJOZZWuJYgsvIXDGQL8NLHiDtMqqn9WsgBJmSoYC+gL5itqv5U9YhRjpbXTwMJ+1iYb0
 AlVjwf+on42mGpP2gonM+hgv3KurGCveE/qdtyJ37MNtBTBAPJDyqQtOke0IXL2mKe8fNfGYw
 vO1Fz3JRMIXpDwu47nLyks2i/NZ8vJKSWpDTF5X9X+u51+hmew3v9tmNJQwxoF4NwTquyA7mL
 KIvnW7gnqoJdesXd6+/n983Dq8pPPuYGn194vsa/u7+qB+BeGwpXSMCzJdkAJJPnIGo3V+O1G
 AG1ru/bswPeZ0pmXIubSa51l7AqY3XgE+QFj5efIVz7LXyoVhqDRrIIsd32XWtbs5dq5c9gXu
 nP1atNnFF8zwEbGHUrNg8JMacSKQoReZ0t4asHN+8q/PawXh6ArkYxoyM3Te43lrjs6j1uBy8
 GFwhEIqh/84gFPOD0ufPtxTzTf7N74MnT8JMATV+WhfUywoJqSyULk7hbsbWsETfDD8g58vpO
 UENQubIMZ04xZ9m4yu+ED1oO9YL6p9UfgfVYZPGoCLrl8=

On 2/2/24 02:39, Tejun Heo wrote:
> Hello,
>
> On Thu, Feb 01, 2024 at 06:56:20PM +0100, Helge Deller wrote:
>> root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py 2>&1 | tee=
 L
>> Affinity Scopes
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> wq_unbound_cpumask=3D0000ffff
>>
>> CPU
>>    nr_pods  16
>>    pod_cpus [0]=3D00000001 [1]=3D00000002 [2]=3D00000004 [3]=3D00000008=
 [4]=3D00000010 [5]=3D00000020 [6]=3D00000040 [7]=3D00000080 [8]=3D0000010=
0 [9]=3D00000200 [10]=3D00000400 [11]=3D00000800 [12]=3D00001000 [13]=3D00=
002000 [14]=3D00004000 [15]=3D00008000
>>    pod_node [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=
=3D0 [8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0
>>    cpu_pod  [0]=3D0 [1]=3D1
>
> wq_unbound_cpumask is saying there are 16 possible cpus but
> for_each_possible_cpu() iteration is only giving two. Can you please app=
ly
> the following patch and post the boot dmesg? Thanks.
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index ffb625db9771..d3fa2bea4d75 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7146,6 +7146,9 @@ void __init workqueue_init_early(void)
>   	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL))=
;
>   	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
>
> +	printk("XXX workqueue_init_early: possible_cpus=3D%*pb\n",
> +	       cpumask_pr_args(cpu_possible_mask));
> +
>   	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
>   	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_W=
Q));
>   	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TY=
PE_DOMAIN));
> @@ -7290,6 +7293,9 @@ void __init workqueue_init(void)
>   	struct worker_pool *pool;
>   	int cpu, bkt;
>
> +	printk("XXX workqueue_init: possible_cpus=3D%*pb\n",
> +	       cpumask_pr_args(cpu_possible_mask));
> +
>   	wq_cpu_intensive_thresh_init();
>
>   	mutex_lock(&wq_pool_mutex);
> @@ -7401,6 +7407,9 @@ void __init workqueue_init_topology(void)
>   	struct workqueue_struct *wq;
>   	int cpu;
>
> +	printk("XXX workqueue_init_topology: possible_cpus=3D%*pb\n",
> +	       cpumask_pr_args(cpu_possible_mask));
> +
>   	init_pod_type(&wq_pod_types[WQ_AFFN_CPU], cpus_dont_share);
>   	init_pod_type(&wq_pod_types[WQ_AFFN_SMT], cpus_share_smt);
>   	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);

Here it is:

[    0.000000] Linux version 6.8.0-rc2-32bit+ (deller@carbonx1) (hppa-linu=
x-gnu-gcc (GCC) 13.2.1 20230728 (Red Hat Cross 13.2.1-1), GNU ld version 2=
40-3.fc39) #1294 SMP PREEMPT Fri Feb  2 09:24:28 CET 2024
[    0.000000] FP[0] enabled: Rev 1 Model 15
[    0.000000] The 32-bit Kernel has started...
[    0.000000] Kernel default page size is 4 KB. Huge pages disabled.
[    0.000000] Determining PDC firmware type: System Map.
[    0.000000] model 00005020 00000481 00000000 02020202 77729da0 100000f0=
 00000004 000000ba 000000ba 00000000
[    0.000000] vers  00000008
[    0.000000] CPUID vers 15 rev 8 (0x000001e8)
[    0.000000] capabilities 0x2
[    0.000000] HP-UX model name: 9000/778/B160L
[    0.000000] MPE/iX model name: 9000/778/B160L
[    0.000000] Memory Ranges:
[    0.000000]  0) Start 0x0000000000000000 End 0x000000001fffffff Size   =
 512 MB
[    0.000000] Total Memory: 512 MB
[    0.000000] PDT: Firmware does not provide any page deallocation inform=
ation.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000001ffffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000001fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001fff=
ffff]
[    0.000000] percpu: Embedded 16 pages/cpu s34912 r8192 d22432 u65536
[    0.000000] SMP: bootstrap CPU ID is 0
[    0.000000] Kernel command line: root=3D/dev/sda5  panic=3D-1 console=
=3DttyS0  earlycon=3Dpdc
[    0.000000] earlycon: pdc0 at MMIO32be 0x00000000 (options '')
[    0.000000] printk: legacy bootconsole [pdc0] enabled
[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 b=
ytes
[    0.000000] printk: log_buf_len total cpu_extra contributions: 61440 by=
tes
[    0.000000] printk: log_buf_len min size: 65536 bytes
[    0.000000] printk: log_buf_len: 131072 bytes
[    0.000000] printk: early log buf free: 63792(97%)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byt=
es, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1299=
20
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 497732K/524288K available (7216K kernel code, 3452K=
 rwdata, 2176K rodata, 3072K init, 388K bss, 26556K reserved, 0K cma-reser=
ved)
[    0.000000] SLUB: HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D16,=
 Nodes=3D1
[    0.000000] XXX workqueue_init_early: possible_cpus=3Dffff
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is =
10 jiffies.
[    0.000000] NR_IRQS: 96
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contenti=
on.
[    0.000149] sched_clock: 32 bits at 250MHz, resolution 4ns, wraps every=
 8589934590ns
[    0.005146] Console: colour dummy device 160x64
[    0.006640] Calibrating delay loop... 1771.11 BogoMIPS (lpj=3D8855552)
[    0.123925] pid_max: default: 32768 minimum: 301
[    0.128202] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes,=
 linear)
[    0.128461] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 b=
ytes, linear)
[    0.159241] XXX workqueue_init: possible_cpus=3Dffff
[    0.175221] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adju=
st=3D1.
[    0.176798] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_c=
b_adjust=3D1.
[    0.177562] TOC handler registered
[    0.178992] rcu: Hierarchical SRCU implementation.
[    0.179222] rcu:     Max phase no-delay instances is 1000.
[    0.193315] smp: Bringing up secondary CPUs ...
[    0.194144] smp: Brought up 1 node, 1 CPU
[    0.199106] XXX workqueue_init_topology: possible_cpus=3Dffff
[    0.208842] devtmpfs: initialized
[    0.217239] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 19112604462750000 ns
[    0.218067] futex hash table entries: 4096 (order: 5, 131072 bytes, lin=
ear)
[    0.224055] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.231058] EISA bus registered
[    0.231481] Searching for devices...
[    0.237416] Found devices:
[    0.237623] 1. Phantom PseudoBC GSC+ Port [8] at 0xffc00000 { type:7, h=
v:0x504, sv:0x0, rev:0x0 }
[    0.237874] 2. Dino PCI Bridge [8:0] at 0xfff80000 { type:13, hv:0x680,=
 sv:0xa, rev:0x3 }
[    0.238234] 3. Merlin+ 132 Dino RS-232 [8:0:63] at 0xfff83000 { type:10=
, hv:0x22, sv:0x8c, rev:0x0 }
[    0.238490] 4. Merlin 160 Core BA [8:16] at 0xffd00000 { type:11, hv:0x=
3d, sv:0x81, rev:0x0 }, additional addresses: 0xffd0c000 0xffc00000
[    0.238923] 5. Merlin 160 Core RS-232 [8:16:4] at 0xffd05000 { type:10,=
 hv:0x3d, sv:0x8c, rev:0x0 }
[    0.239193] 6. Merlin 160 Core Centronics [8:16:0] at 0xffd02000 { type=
:10, hv:0x3d, sv:0x74, rev:0x0 }, additional addresses: 0xffd01000 0xffd03=
000
[    0.239595] 7. Memory [63] at 0xfffff000 { type:1, hv:0x67, sv:0x9, rev=
:0x0 }
[    0.239839] 8. Merlin L2 160 (9000/778/B160L) [48] at 0xfffb0000 { type=
:0, hv:0x502, sv:0x4, rev:0x0 }
[    0.240145] 9. Merlin L2 160 (9000/778/B160L) [49] at 0xfffb1000 { type=
:0, hv:0x502, sv:0x4, rev:0x0 }
[    0.240509] Found qemu fw_cfg interface at 0xfffa0000
[    0.243313] CPU0: cpu core 0 of socket 0
[    0.244475] CPU1: cpu core 0 of socket 1
[    0.248134] Releasing cpu 1 now, hpa=3Dfffb1000
[    0.255231] CPU(s): 2 out of 2 PA7300LC (PCX-L2) at 250.000000 MHz onli=
ne
[    0.257077] alternatives: applied 17 out of 1505 patches
[    0.258013] Calculated flush threshold is 5909 KiB
[    0.258162] Cache flush threshold set to 2 KiB
[    0.258304] TLB flush threshold set to 480 KiB
[    0.259216] Lasi version 0 at 0xffd00000 found.
[    0.261123] Dino version 3.1 found at 0xfff80000
[    0.263459] dino 8:0: PCI host bridge to bus 0000:00
[    0.263841] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.264196] pci_bus 0000:00: root bus resource [mem 0xf0800000-0xff7fff=
ff]
[    0.264476] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.265734] pci 0000:00:00.0: [1000:0012] type 00 class 0x010000 conven=
tional PCI endpoint
[    0.267232] pci 0000:00:00.0: BAR 0 [io  0x1000-0x10ff]
[    0.268292] pci 0000:00:00.0: BAR 1 [mem 0xff7fe000-0xff7fe3ff]
[    0.269408] pci 0000:00:00.0: BAR 2 [mem 0xff7fc000-0xff7fdfff]
[    0.277602] pci 0000:00:01.0: [1011:0019] type 00 class 0x020000 conven=
tional PCI endpoint
[    0.278298] pci 0000:00:01.0: BAR 0 [io  0x1100-0x117f]
[    0.278820] pci 0000:00:01.0: BAR 1 [mem 0xff7ff000-0xff7ff07f]
[    0.281323] pci 0000:00:02.0: [103c:1048] type 00 class 0x070000 conven=
tional PCI endpoint
[    0.281867] pci 0000:00:02.0: BAR 0 [io  0x1180-0x1187]
[    0.284921] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.287179] pci 0000:00:00.0: BAR 2 [mem 0xf0800000-0xf0801fff]: assign=
ed
[    0.287830] pci 0000:00:00.0: BAR 1 [mem 0xf0802000-0xf08023ff]: assign=
ed
[    0.288225] pci 0000:00:00.0: BAR 0 [io  0x0100-0x01ff]: assigned
[    0.288628] pci 0000:00:01.0: BAR 0 [io  0x0080-0x00ff]: assigned
[    0.289002] pci 0000:00:01.0: BAR 1 [mem 0xf0803000-0xf080307f]: assign=
ed
[    0.289359] pci 0000:00:02.0: BAR 0 [io  0x0010-0x0017]: assigned
[    0.290999] powersw: Soft power switch at 0xf07ffff0 enabled.
[    0.314551] SCSI subsystem initialized
[    0.317664] usbcore: registered new interface driver usbfs
[    0.318202] usbcore: registered new interface driver hub
[    0.318580] usbcore: registered new device driver usb
[    0.334210] vgaarb: loaded
[    0.337059] VFS: Disk quotas dquot_6.6.0
[    0.337473] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
[    0.369580] NET: Registered PF_INET protocol family
[    0.371471] IP idents hash table entries: 8192 (order: 4, 65536 bytes, =
linear)
[    0.380082] tcp_listen_portaddr_hash hash table entries: 256 (order: 0,=
 5120 bytes, linear)
[    0.381103] Table-perturb hash table entries: 65536 (order: 6, 262144 b=
ytes, linear)
[    0.381397] TCP established hash table entries: 4096 (order: 2, 16384 b=
ytes, linear)
[    0.382605] TCP bind hash table entries: 4096 (order: 5, 163840 bytes, =
linear)
[    0.383338] TCP: Hash tables configured (established 4096 bind 4096)
[    0.385144] UDP hash table entries: 256 (order: 1, 12288 bytes, linear)
[    0.385743] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes, li=
near)
[    0.387545] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.388172] PCI: CLS 16 bytes
[    0.390311] clocksource: cr16: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 7645041786 ns
[    0.391141] clocksource: Switched to clocksource cr16
[    0.391756] Enabling PDC chassis warnings support v0.05
[    0.396076] workingset: timestamp_bits=3D14 max_order=3D17 bucket_order=
=3D3
[    0.404012] io scheduler mq-deadline registered
[    0.404324] io scheduler kyber registered
[    0.407216] PDC Stable Storage facility v0.30
[    0.408521] sticore: STI GSC/PCI core graphics driver Version 0.9c
[    0.496987] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.511533] printk: legacy console [ttyS0] disabled
[    0.515146] 8:16:4: ttyS0 at MMIO 0xffd05800 (irq =3D 16, base_baud =3D=
 454545) is a 16550A
[    0.518634] printk: legacy console [ttyS0] enabled
[    0.518634] printk: legacy console [ttyS0] enabled
[    0.519267] printk: legacy bootconsole [pdc0] disabled
[    0.519267] printk: legacy bootconsole [pdc0] disabled
[    0.528540] 8:0:63: ttyS1 at MMIO 0xfff83800 (irq =3D 18, base_baud =3D=
 454545) is a 16550A
[    0.531850] serial 0000:00:02.0: enabling SERR and PARITY (0103 -> 0143=
)
[    0.535316] 0000:00:02.0: ttyS2 at I/O 0x10 (irq =3D 21, base_baud =3D =
115200) is a 16550A
[    0.539332] parport_init_chip: initialize bidirectional-mode
[    0.540300] parport0: PC-style at 0xffd02800, irq 17 [PCSPP,TRISTATE]
[    0.667976] loop: module loaded
[    0.669638] sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 -> 0=
147)
[    0.672643] sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 19
[    0.678720] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity checking
[    0.684386] sym0: SCSI BUS has been reset.
[    0.687904] scsi host0: sym-2.2.3
[    3.783993] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2=
5+ PQ: 0 ANSI: 5
[    3.784726] scsi target0:0:0: tagged command queuing enabled, command q=
ueue depth 16.
[    3.785900] scsi target0:0:0: Beginning Domain Validation
[    3.788722] scsi target0:0:0: Domain Validation skipping write tests
[    3.788895] scsi target0:0:0: Ending Domain Validation
[    3.801756] scsi 0:0:2:0: CD-ROM            QEMU     QEMU CD-ROM      2=
5+ PQ: 0 ANSI: 5
[    3.802043] scsi target0:0:2: tagged command queuing enabled, command q=
ueue depth 16.
[    3.802392] scsi target0:0:2: Beginning Domain Validation
[    3.803995] scsi target0:0:2: Domain Validation skipping write tests
[    3.804138] scsi target0:0:2: Ending Domain Validation
[    3.816982] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    3.820181] sr 0:0:2:0: Power-on or device reset occurred
[    3.822714] sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x cd/rw xa/form2 c=
dda tray
[    3.823139] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.824901] sd 0:0:0:0: Power-on or device reset occurred
[    3.828055] sd 0:0:0:0: [sda] 62914560 512-byte logical blocks: (32.2 G=
B/30.0 GiB)
[    3.829255] sd 0:0:0:0: [sda] Write Protect is off
[    3.832789] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.833235] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[    3.833534] sr 0:0:2:0: Attached scsi generic sg1 type 5
[    3.835756] tulip 0000:00:01.0: enabling SERR and PARITY (0103 -> 0143)
[    3.849999] tulip0: EEPROM default media type Autosense
[    3.850253] tulip0: Index #0 - Media MII (#11) described by a 21142 MII=
 PHY (3) block
[    3.853899] tulip0:  MII transceiver #1 config 3100 status 702c adverti=
sing 0501
[    3.856302]  sda: sda1 sda2 sda3 < sda5 sda6 >
[    3.870391] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.871194] net eth0: Digital DS21142/43 Tulip rev 0 at Port 0x80, 52:5=
4:00:12:34:56, IRQ 20
[    3.872279] e100: Intel(R) PRO/100 Network Driver
[    3.872486] e100: Copyright(c) 1999-2006 Intel Corporation
[    3.873836] e1000: Intel(R) PRO/1000 Network Driver
[    3.874067] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.874406] e1000e: Intel(R) PRO/1000 Network Driver
[    3.874536] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.875010] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.875212] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.875563] LASI 82596 driver - Revision: 1.30
[    3.878798] HP SDC: No SDC found.
[    3.879000] HP SDC MLC: Registering the System Domain Controller's HIL =
MLC.
[    3.884554] HP SDC MLC: Request for raw HIL ISR hook denied
[    3.906699] mousedev: PS/2 mouse device common for all mice
[    3.912379] rtc-generic rtc-generic: registered as rtc0
[    3.913033] rtc-generic rtc-generic: setting system clock to 2024-02-02=
T08:24:45 UTC (1706862285)
[    3.919114] hid: raw HID events driver (C) Jiri Kosina
[    3.919926] usbcore: registered new interface driver usbhid
[    3.920146] usbhid: USB HID core driver
[    3.921737] NET: Registered PF_PACKET protocol family
[    3.924787] Key type dns_resolver registered
[    4.092592] EXT4-fs (sda5): INFO: recovery required on readonly filesys=
tem
[    4.092910] EXT4-fs (sda5): write access will be enabled during recover=
y
[    4.200680] EXT4-fs (sda5): recovery complete
[    4.207887] EXT4-fs (sda5): mounted filesystem 0e24f05b-efd0-4f75-b1de-=
3309bd27dbd8 ro with ordered data mode. Quota mode: none.
[    4.209030] VFS: Mounted root (ext4 filesystem) readonly on device 8:5.
[    4.214953] devtmpfs: mounted
[    4.267329] Freeing unused kernel image (initmem) memory: 3072K
[    4.267826] Write protected read-only-after-init data: 2k
[    4.268225] Run /sbin/init as init process
[    4.305438] process 'usr/lib/systemd/systemd' started with executable s=
tack
[    4.932357] systemd[1]: systemd 255.3-2 running in system mode (+PAM +A=
UDIT +SELINUX +APPARMOR +IMA +SMACK -SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL=
 +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBF=
DISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD=
 -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[    4.933521] systemd[1]: Detected architecture parisc.

Welcome to Debian GNU/Linux trixie/sid!

[...]
root@debian:~# lscpu
Architecture:          parisc
   Byte Order:          Big Endian
CPU(s):                2
   On-line CPU(s) list: 0,1
Model name:            PA7300LC (PCX-L2)
   CPU family:          PA-RISC 1.1e
   Model:               9000/778/B160L - Merlin L2 160 (9000/778/B160L)
   Thread(s) per core:  1
   Core(s) per socket:  1
   Socket(s):           2
   BogoMIPS:            1771.11
root@debian:~# chcpu -d 1
[   84.800279] Backtrace:
[   84.802648]  [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
[   84.802648]  [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
[   84.802648]  [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
[   84.802648]  [<10452970>] smpboot_thread_fn+0x284/0x288
[   84.802648]  [<1044d8f4>] kthread+0x12c/0x13c
[   84.802648]  [<1040201c>] ret_from_kernel_thread+0x1c/0x24
[   84.802648]
[   84.802648]
[   84.802648] Kernel Fault: Code=3D26 (Data memory access rights trap) at=
 addr 00000000
[   84.802648] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-rc2-32bit+ #=
1294
[   84.802648] Hardware name: 9000/778/B160L
[   84.802648]
[   84.802648]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[   84.802648] PSW: 00000000000001001111111100001111 Not tainted
[   84.802648] r00-03  0004ff0f 11011540 10446d9c 11e00500
[   84.802648] r04-07  11c0b800 00000002 11c0d000 00000001
[   84.802648] r08-11  110194e4 11019168 00000000 00000004
[   84.802648] r12-15  10c78800 00000612 f0028050 f0027fd8
[   84.802648] r16-19  fffffffc fee01180 f0027ed8 01735000
[   84.802648] r20-23  0000ffff 13ae1a00 13ae1a00 00000000
[   84.802648] r24-27  11c0c580 11c0d004 11c0d000 10ceb968
[   84.802648] r28-31  00000000 0000000e 11e00580 00000018
[   84.802648] sr00-03  00000000 00000000 00000000 000004af
[   84.802648] sr04-07  00000000 00000000 00000000 00000000
[   84.802648]
[   84.802648] IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
[   84.802648]  IIR: 0f80109c    ISR: 00000000  IOR: 00000000
[   84.802648]  CPU:        1   CR30: 11dd1710 CR31: 00000000
[   84.802648]  ORIG_R28: 00000612
[   84.802648]  IAOQ[0]: wq_update_pod+0x98/0x14c
[   84.802648]  IAOQ[1]: wq_update_pod+0x9c/0x14c
[   84.802648]  RP(r2): wq_update_pod+0x80/0x14c
[   84.802648] Backtrace:
[   84.802648]  [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
[   84.802648]  [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
[   84.802648]  [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
[   84.802648]  [<10452970>] smpboot_thread_fn+0x284/0x288
[   84.802648]  [<1044d8f4>] kthread+0x12c/0x13c
[   84.802648]  [<1040201c>] ret_from_kernel_thread+0x1c/0x24
[   84.802648]
[   84.802648] Kernel panic - not syncing: Kernel Fault


