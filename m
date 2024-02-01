Return-Path: <linux-kernel+bounces-48626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B4845EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D93F1C2392C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535765E1D;
	Thu,  1 Feb 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="kQh1Gvku"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826F5C055;
	Thu,  1 Feb 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810190; cv=none; b=X2TiW4iv/kbX3vs1NMu7gnb+BeAueq/1CUYdEMN5rDiak8a1+cRSik2u6A2ezg0IrT9siGY079rNwohJs5GYAq+E02it11X6zl+/wJ6Bzl+w1t9OR5EYX1oomUvA7kzneeS9x5IFeXgwr9gbm5yYkYIvDZ3DgGl3vCUdgE8Mm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810190; c=relaxed/simple;
	bh=hEIL5wMHgK9aOfwQ8aq/If+S3qmXt6xPVuSqIE1DDZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4Gn0ylRf/osirCTvY8OD9vsZwQHZNKbwq6ymj8+RJV+mJivBl9Bx3p1AcERXYvel3MSPSmZGBZ49vSsRpfimsb2tqafP/V73AgVjUXv4PtQ1B86ZX8ndy6/4S1utASLuo3jbifR7CbN19b3IZ9WMuLMyXLoTPCUG7J1s3t09qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=kQh1Gvku; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706810180; x=1707414980; i=deller@gmx.de;
	bh=hEIL5wMHgK9aOfwQ8aq/If+S3qmXt6xPVuSqIE1DDZ4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kQh1GvkuAYiIp58/Zg+UOngD16OokhZxYAMnKSiRqySx4UnBvbdsobzwp+BB4s5y
	 SRbR2fLJq0jBM2BsTe7Q+dD/s60gsU/RyyoEk10bsJeYIdDajSsWRclWeXDuAWbUb
	 mS5IZVWl9IZ1JR/LqJo0n8L3n0l6A0wnhjiS2SJFWtSVgqTgs2QOY2u1/MmgL+DLU
	 9FP07ctl/YAzCdGcqYzQaUbWi8avHf9BfX1T3KXIqHY5TKACKTmtmZOu6Rc3utt6x
	 2tvcnbjrGv9jabaGyBMgf3KDHIYfBrDSC0b6SIF3Om9RQZ7RfAcGORve4qcUDotrM
	 O5jWZAv1z3mFDjR5YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.104]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1qnV7U21JI-00iDIl; Thu, 01
 Feb 2024 18:56:20 +0100
Message-ID: <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
Date: Thu, 1 Feb 2024 18:56:20 +0100
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
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZbvM1V8CYNeds14r@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Pu3Zkbok+sHM5tEcW7RzMfUPONc4Hy6/sQW2c/XGw60bfPcxO4k
 L525zhXA7foPxAI8UpXeFU3SD/uNW/K/mM2pMQtWCzZx4bDpgD6nM5yCpLRUD6vyzaTMP5I
 7Xb0FdRsEnecbl5ED+AP3hTTQp7aSan7zYuROX7MZgq1op3yw5IOiINedT95YV/DwxRcSZg
 K+t2V23U/p6UZgZNCA9cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xjybDZVsaBs=;Rv6FOpH54tuWBeMPeVS21IzKNW0
 gcTsS2nAoK6b5jx0iu+chT/Yxnb6AIKCTanWCrQumUjRkxGnYT6vlIjHHGB11X4CoRDGEqN9c
 0P9FMz4RRZQLzKZ8pRnhuHlVkifmKAepy2TP5Opl1QvDBpYOCYqU5HURyhBHbKYOnT5VUpiAL
 uR5ObOxhtvLfWKYAonOhE13hK8fzTsOZuAjiJBjONPYcqDiyfdTTEngvMf1dtwsRdfaXc8YHK
 lsWt8m7J10EY+D99TCdT/6RkE++xh+ziEZkWB6EgBipL/ERGNBVUnoq0o6FTSxMJBAWSecZpu
 785BOc1T3HDmEsOksBy25lSMtlElKe/XyI1wqxtv9Fxo7RyvYG1kMVWX6ALkWR5v+jLjYdOLB
 RH6FwNDTk3sXbdq1PUne1vUmH418lKSJDhORB3mjjeA0NgJGMXq76mHKAooeKKS23i1909uL7
 88a8DmC83QpexFU+Wpe/3o78WpoGHJwC7yS10vfhFqIMAIFvQm7urZw9POazQxEyrIl+YtETJ
 9XOIG1d1y2YBmdlEKQL9xghHkDjSmZtrOPjTD/d/E5TdimwQiLMChVqxUJPvYiAxdW8IBceSW
 dj0OsnvaFPTrxjIpOfs/G6bwNSvzY3hpW0bEhsK1x8rzwbrQdLA8zeNrR2vRBAaBXdAnkBrzD
 tdBKydnUwoDdpZLOZ/j9UMwUbzjMOIX0hs5WYbrmyq/Q1DNPxqBzJQi6Mr3jpgU0dlGKlxrxg
 A0hylJ1DAJYp4wxR5RT+JKHW/E75M1QTzIpxGKPaRr0X6SeAGmjBNq1+scRFN7gln0cGVlN9s
 7rmLkHm1hmm6sNjImTOrxXVaFCvm6Wb/STJRiKGxGwu58=

Hi Tejun,

On 2/1/24 17:54, Tejun Heo wrote:
> On Thu, Feb 01, 2024 at 05:41:10PM +0100, Helge Deller wrote:
>>> Hmm... I have a hard time imagining a scenario where some CPUs don't have
>>> pwq installed on wq->cpu_pwq. Can you please run `drgn
>>> tools/workqueue/wq_dump.py` before triggering the hotplug event and paste
>>> the output along with full dmesg?

Enabling CONFIG_DEBUG_INFO=y did the trick :-)


root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py 2>&1 | tee L
Affinity Scopes
===============
wq_unbound_cpumask=0000ffff

CPU
   nr_pods  16
   pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008 [4]=00000010 [5]=00000020 [6]=00000040 [7]=00000080 [8]=00000100 [9]=00000200 [10]=00000400 [11]=00000800 [12]=00001000 [13]=00002000 [14]=00004000 [15]=00008000
   pod_node [0]=0 [1]=0 [2]=0 [3]=0 [4]=0 [5]=0 [6]=0 [7]=0 [8]=0 [9]=0 [10]=0 [11]=0 [12]=0 [13]=0 [14]=0 [15]=0
   cpu_pod  [0]=0 [1]=1

SMT
   nr_pods  16
   pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008 [4]=00000010 [5]=00000020 [6]=00000040 [7]=00000080 [8]=00000100 [9]=00000200 [10]=00000400 [11]=00000800 [12]=00001000 [13]=00002000 [14]=00004000 [15]=00008000
   pod_node [0]=0 [1]=0 [2]=0 [3]=0 [4]=0 [5]=0 [6]=0 [7]=0 [8]=0 [9]=0 [10]=0 [11]=0 [12]=0 [13]=0 [14]=0 [15]=0
   cpu_pod  [0]=0 [1]=1

CACHE (default)
   nr_pods  1
   pod_cpus [0]=0000ffff
   pod_node [0]=0
   cpu_pod  [0]=0 [1]=0

NUMA
   nr_pods  1
   pod_cpus [0]=0000ffff
   pod_node [0]=0
   cpu_pod  [0]=0 [1]=0

SYSTEM
   nr_pods  1
   pod_cpus [0]=0000ffff
   pod_node [0]=-1
   cpu_pod  [0]=0 [1]=0

Worker Pools
============
pool[00] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  0
pool[01] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  0
pool[02] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  1
pool[03] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  1
pool[04] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  2
pool[05] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  2
pool[06] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  3
pool[07] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  3
pool[08] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  4
pool[09] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  4
pool[10] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  5
pool[11] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  5
pool[12] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  6
pool[13] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  6
pool[14] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  7
pool[15] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  7
pool[16] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  8
pool[17] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  8
pool[18] ref= 1 nice=  0 idle/workers=  0/  0 cpu=  9
pool[19] ref= 1 nice=-20 idle/workers=  0/  0 cpu=  9
pool[20] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 10
pool[21] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 10
pool[22] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 11
pool[23] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 11
pool[24] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 12
pool[25] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 12
pool[26] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 13
pool[27] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 13
pool[28] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 14
pool[29] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 14
pool[30] ref= 1 nice=  0 idle/workers=  0/  0 cpu= 15
pool[31] ref= 1 nice=-20 idle/workers=  0/  0 cpu= 15
pool[32] ref=28 nice=  0 idle/workers=  8/  8 cpus=0000ffff pod_cpus=0000ffff

Workqueue CPU -> pool
=====================
[    workqueue     \     type   CPU  0  1 dfl]
events                   percpu      0  2
events_highpri           percpu      1  3
events_long              percpu      0  2
events_unbound           unbound    32 32 32
events_freezable         percpu      0  2
events_power_efficient   percpu      0  2
events_freezable_power_  percpu      0  2
rcu_gp                   percpu      0  2
rcu_par_gp               percpu      0  2
slub_flushwq             percpu      0  2
netns                    ordered    32 32 32
mm_percpu_wq             percpu      0  2
inet_frag_wq             percpu      0  2
cgroup_destroy           percpu      0  2
cgroup_pidlist_destroy   percpu      0  2
cgwb_release             percpu      0  2
writeback                unbound    32 32 32
kintegrityd              percpu      1  3
kblockd                  percpu      1  3
blkcg_punt_bio           unbound    32 32 32
ata_sff                  percpu      0  2
usb_hub_wq               percpu      0  2
inode_switch_wbs         percpu      0  2
virtio-blk               percpu      0  2
scsi_tmf_0               ordered    32 32 32
psmouse-smbus            percpu      0  2
kpsmoused                ordered    32 32 32
sock_diag_events         percpu      0  2
kstrp                    ordered    32 32 32
ext4-rsv-conversion      ordered    32 32 32
root@debian:~#
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
   BogoMIPS:            2446.13
root@debian:~#
root@debian:~# chcpu -d 1
[  261.926353] Backtrace:
[  261.928292]  [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
[  261.928292]  [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
[  261.928292]  [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
[  261.928292]  [<10452970>] smpboot_thread_fn+0x284/0x288
[  261.928292]  [<1044d8f4>] kthread+0x12c/0x13c
[  261.928292]  [<1040201c>] ret_from_kernel_thread+0x1c/0x24
[  261.928292]
[  261.928292]
[  261.928292] Kernel Fault: Code=26 (Data memory access rights trap) at addr 00000000
[  261.928292] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-rc1-32bit+ #1293
[  261.928292] Hardware name: 9000/778/B160L
[  261.928292]
[  261.928292]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[  261.928292] PSW: 00000000000001101111111100001111 Not tainted
[  261.928292] r00-03  0006ff0f 11011540 10446d9c 11e00500
[  261.928292] r04-07  11c0b800 00000002 11c0d000 00000001
[  261.928292] r08-11  110194e4 11018f08 00000000 00000004
[  261.928292] r12-15  10c78800 00000612 f0028050 f0027fd8
[  261.928292] r16-19  fffffffc fee01180 f0027ed8 01735000
[  261.928292] r20-23  0000ffff 1249cc00 1249cc00 00000000
[  261.928292] r24-27  11c0c580 11c0d004 11c0d000 10ceb708
[  261.928292] r28-31  00000000 0000000e 11e00580 00000018
[  261.928292] sr00-03  00000000 00000000 00000000 000004be
[  261.928292] sr04-07  00000000 00000000 00000000 00000000
[  261.928292]
[  261.928292] IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
[  261.928292]  IIR: 0f80109c    ISR: 00000000  IOR: 00000000
[  261.928292]  CPU:        1   CR30: 11dd1710 CR31: 00000000
[  261.928292]  ORIG_R28: 00000612
[  261.928292]  IAOQ[0]: wq_update_pod+0x98/0x14c
[  261.928292]  IAOQ[1]: wq_update_pod+0x9c/0x14c
[  261.928292]  RP(r2): wq_update_pod+0x80/0x14c
[  261.928292] Backtrace:
[  261.928292]  [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
[  261.928292]  [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
[  261.928292]  [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
[  261.928292]  [<10452970>] smpboot_thread_fn+0x284/0x288
[  261.928292]  [<1044d8f4>] kthread+0x12c/0x13c
[  261.928292]  [<1040201c>] ret_from_kernel_thread+0x1c/0x24
[  261.928292]
[  261.928292] Kernel panic - not syncing: Kernel Fault


