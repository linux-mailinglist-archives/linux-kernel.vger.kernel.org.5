Return-Path: <linux-kernel+bounces-49480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990D1846AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CD7291906
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35E18030;
	Fri,  2 Feb 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="p6mPdov7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2885FDAA;
	Fri,  2 Feb 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863310; cv=none; b=uOjkp2hjiwpqBdeacD3MCxvwDvyj6ey8XxZzoOoJuGykd0xJQ24By1dY72LVMO9n7798HYSRv/0C51Q+CZRg5E0E7XYH/W4gvFi+mUImVcGxz1hm4lkhtm2Wk4UuBwF77NddqmeFLgwVscgt6autRthN5rRSksp2XTQHGmSdDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863310; c=relaxed/simple;
	bh=bTU6oFo1pOhZjSruYugUPCoRyErURTC0SUM2VS81vYk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MYWPFPOmQIX0w2fBQLMfE17ZiPouWOogpqWV6l//AWt5PSRJSvYNfIJUNzyCuNHRsSFWcRbg2MHhVQielOXbwjd+fAd7eHMpJpeTKz2E02qczbizeLKwtoSRnmLPLCu9bqEBXmFwemPVJaZRaTieuCS9nn4z+xIARLACqFjzOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=p6mPdov7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706863299; x=1707468099; i=deller@gmx.de;
	bh=bTU6oFo1pOhZjSruYugUPCoRyErURTC0SUM2VS81vYk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=p6mPdov7fnj2xJRHLpqnDas2D8PP2cU+HNrMrcWlCbsBc51w3URyJ9iffrv4cKpO
	 yjo7biWuod+NLgQjWkVOSHloySLzHTHwor3CFeNwzF4VTGndzQFZfZ9WeSeB2wXJN
	 BpvaFGhwc3zMDcKEVKMGRdlXySa7ciuwxC5KBipDd7lFEGEedzOkQhYgdEJSy3Mni
	 wf2WPCj/ZHC+TxZj/9Dsxtqomj5IQ834mf1HljGlXt/ViR1wFWGQqqEaEw1wSU9td
	 SehWODmnjtyOzu2dSXZgSdoAse1ZLg5UnAJ1OENhrWx5tn24fheyBwekDJ63r50CO
	 6VlCrTIUgTfFwQjMzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.153.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1rJ9g90bVS-00DmgG; Fri, 02
 Feb 2024 09:41:39 +0100
Message-ID: <f75e7606-0904-4e97-b337-e8f74843e87d@gmx.de>
Date: Fri, 2 Feb 2024 09:41:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Tejun Heo <tj@kernel.org>
Cc: Helge Deller <deller@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <ZbqfMR_mVLaSCj4Q@carbonx1> <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
 <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
 <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:898fho7GTip2IJ2D0TbCCX6+4xfSHrIb66tqIA3Afd8CM46suBk
 U52DT2eLXebOPVe3PGcaBfOELgBbyLGcncrLO5nBbPzGm6b3tr17ACOn8GNVOI0DcI7iaAc
 Nx4LHNr97+q/vt6RU4zphOEva3sjI1DVeHdn1IetTc3jdFU1r1UUuS+Qg+avT/N6ZqzOwXE
 s98+Xaqimci1Nz3lubQEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P8yAmHB3XJ8=;Vm6FAFtizwBNRDnku1H9kQZhTzI
 wVmeXsiEI05J9g4LF/Eo695ECtrN8CrOMjjg8twMMDl4c6nGNhWbrp9pX/3PXfiXu0xMURi6y
 MHDIUHJRSmE6wDfQYeU8DX7b+1fA/RTyh3sXJ+IYPlkZkJxdCGi5KeC/44YwSeEc8TlJMA/Hz
 QtUnw7JFaxMnRl6sPSpI4VTCupisiWaNvmByrT7gB6Jlu986U6FAqP/HrPmnMZh77/lIXbws7
 Nyh0N8uvP+P229KzegDSpQQyoNRUzBFQi7WpnTWPmwbTGKCqONxnNdYa8aLDx3kiOLHbukLSi
 g9zttgKKaFzqwrlqXpMhJvgm1b8Qt8gIpuWfGnCOjBAzPVnHWErMGsM1Y0XY75aC/3lVvR64/
 fkS9SsExQAkwJ/1HnxYgA8lGNKIfPI8TbAz6B5J02xbZ3YHPcRkIAapwyAMuHuWZ7dZZWwLXe
 olMvDzCG0Z9kY3kPj4GaZuqvHZUCwNuuAIZGGYVYVkg+nSHnF7pGq46DaentUOfTlu4dFKhg0
 Oqx+LohbR5dhsjthL5hAjvrLlS6lcCqJK89QJRTgiTLxQQHN51oEirI8KkZcqDDY7Bt9auOr6
 Jgkj4FKu2VmhyPFbgQh+UTn/4QVBXMWWW+LhF5D4Tm+oo0F3foGbBIHQzdvuioaavfoCuw/Ic
 1xJJ+pgrsxTUUB70+IeMWTJqs906kwW9uA75HrFs95GeCBvP9dKI9wSYn2s41Qva4r6fexaNu
 jKyI4nyQIVRFz2shbdZQm6U9nEIBSjqMbvqlhhDm+meaY7lNJGPLVudTO/1rIPkDSJYjfQs1K
 bVsrI7HgjaZedO9HS4QFVpgxcCUGLJgwAXeLSq/MzPJcg=

On 2/2/24 09:28, Helge Deller wrote:
> On 2/2/24 02:39, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Feb 01, 2024 at 06:56:20PM +0100, Helge Deller wrote:
>>> root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py 2>&1 | te=
e L
>>> Affinity Scopes
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> wq_unbound_cpumask=3D0000ffff
>>>
>>> CPU
>>> =C2=A0=C2=A0 nr_pods=C2=A0 16
>>> =C2=A0=C2=A0 pod_cpus [0]=3D00000001 [1]=3D00000002 [2]=3D00000004 [3]=
=3D00000008 [4]=3D00000010 [5]=3D00000020 [6]=3D00000040 [7]=3D00000080 [8=
]=3D00000100 [9]=3D00000200 [10]=3D00000400 [11]=3D00000800 [12]=3D0000100=
0 [13]=3D00002000 [14]=3D00004000 [15]=3D00008000
>>> =C2=A0=C2=A0 pod_node [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 =
[6]=3D0 [7]=3D0 [8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=
=3D0 [15]=3D0
>>> =C2=A0=C2=A0 cpu_pod=C2=A0 [0]=3D0 [1]=3D1
>>
>> wq_unbound_cpumask is saying there are 16 possible cpus but
>> for_each_possible_cpu() iteration is only giving two. Can you please ap=
ply
>> the following patch and post the boot dmesg? Thanks.
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index ffb625db9771..d3fa2bea4d75 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -7146,6 +7146,9 @@ void __init workqueue_init_early(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!alloc_cpumask_var(&wq_requested_=
unbound_cpumask, GFP_KERNEL));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!zalloc_cpumask_var(&wq_isolated_=
cpumask, GFP_KERNEL));
>>
>> +=C2=A0=C2=A0=C2=A0 printk("XXX workqueue_init_early: possible_cpus=3D%=
*pb\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_p=
r_args(cpu_possible_mask));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_copy(wq_unbound_cpumask, cpu_pos=
sible_mask);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restrict_unbound_cpumask("HK_TYPE_WQ", h=
ousekeeping_cpumask(HK_TYPE_WQ));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restrict_unbound_cpumask("HK_TYPE_DOMAIN=
", housekeeping_cpumask(HK_TYPE_DOMAIN));
>> @@ -7290,6 +7293,9 @@ void __init workqueue_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct worker_pool *pool;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu, bkt;
>>
>> +=C2=A0=C2=A0=C2=A0 printk("XXX workqueue_init: possible_cpus=3D%*pb\n"=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_p=
r_args(cpu_possible_mask));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wq_cpu_intensive_thresh_init();
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&wq_pool_mutex);
>> @@ -7401,6 +7407,9 @@ void __init workqueue_init_topology(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct workqueue_struct *wq;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
>>
>> +=C2=A0=C2=A0=C2=A0 printk("XXX workqueue_init_topology: possible_cpus=
=3D%*pb\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_p=
r_args(cpu_possible_mask));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_pod_type(&wq_pod_types[WQ_AFFN_CPU]=
, cpus_dont_share);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_pod_type(&wq_pod_types[WQ_AFFN_SMT]=
, cpus_share_smt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_pod_type(&wq_pod_types[WQ_AFFN_CACH=
E], cpus_share_cache);
>
> Here it is:
>
> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 6.8.0-rc2-32bit+ (deller@car=
bonx1) (hppa-linux-gnu-gcc (GCC) 13.2.1 20230728 (Red Hat Cross 13.2.1-1),=
 GNU ld version 2.40-3.fc39) #1294 SMP PREEMPT Fri Feb=C2=A0 2 09:24:28 CE=
T 2024
> [=C2=A0=C2=A0=C2=A0 0.000000] FP[0] enabled: Rev 1 Model 15
> [=C2=A0=C2=A0=C2=A0 0.000000] The 32-bit Kernel has started...
> [=C2=A0=C2=A0=C2=A0 0.000000] Kernel default page size is 4 KB. Huge pag=
es disabled.
> [=C2=A0=C2=A0=C2=A0 0.000000] Determining PDC firmware type: System Map.
> [=C2=A0=C2=A0=C2=A0 0.000000] model 00005020 00000481 00000000 02020202 =
77729da0 100000f0 00000004 000000ba 000000ba 00000000
> [=C2=A0=C2=A0=C2=A0 0.000000] vers=C2=A0 00000008
> [=C2=A0=C2=A0=C2=A0 0.000000] CPUID vers 15 rev 8 (0x000001e8)
> [=C2=A0=C2=A0=C2=A0 0.000000] capabilities 0x2
> [=C2=A0=C2=A0=C2=A0 0.000000] HP-UX model name: 9000/778/B160L
> [=C2=A0=C2=A0=C2=A0 0.000000] MPE/iX model name: 9000/778/B160L
> [=C2=A0=C2=A0=C2=A0 0.000000] Memory Ranges:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 0) Start 0x0000000000000000 End 0x00=
0000001fffffff Size=C2=A0=C2=A0=C2=A0 512 MB
> [=C2=A0=C2=A0=C2=A0 0.000000] Total Memory: 512 MB
> [=C2=A0=C2=A0=C2=A0 0.000000] PDT: Firmware does not provide any page de=
allocation information.
> [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 [mem 0x0000=
000000000000-0x000001ffffffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
> [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x000=
0000000000000-0x000000001fffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Initmem setup node 0 [mem 0x00000000000000=
00-0x000000001fffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] percpu: Embedded 16 pages/cpu s34912 r8192=
 d22432 u65536
> [=C2=A0=C2=A0=C2=A0 0.000000] SMP: bootstrap CPU ID is 0
> [=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line: root=3D/dev/sda5=C2=
=A0 panic=3D-1 console=3DttyS0=C2=A0 earlycon=3Dpdc
> [=C2=A0=C2=A0=C2=A0 0.000000] earlycon: pdc0 at MMIO32be 0x00000000 (opt=
ions '')
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: legacy bootconsole [pdc0] enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: log_buf_len individual max cpu con=
tribution: 4096 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: log_buf_len total cpu_extra contri=
butions: 61440 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: log_buf_len min size: 65536 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: log_buf_len: 131072 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] printk: early log buf free: 63792(97%)
> [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 65536 (or=
der: 6, 262144 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 32768 (ord=
er: 5, 131072 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.000000] Sorting __ex_table...
> [=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=
=C2=A0 Total pages: 129920
> [=C2=A0=C2=A0=C2=A0 0.000000] mem auto-init: stack:off, heap alloc:off, =
heap free:off
> [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 497732K/524288K available (7216K k=
ernel code, 3452K rwdata, 2176K rodata, 3072K init, 388K bss, 26556K reser=
ved, 0K cma-reserved)
> [=C2=A0=C2=A0=C2=A0 0.000000] SLUB: HWalign=3D16, Order=3D0-3, MinObject=
s=3D0, CPUs=3D16, Nodes=3D1
> [=C2=A0=C2=A0=C2=A0 0.000000] XXX workqueue_init_early: possible_cpus=3D=
ffff
> [=C2=A0=C2=A0=C2=A0 0.000000] rcu: Preemptible hierarchical RCU implemen=
tation.
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 Trampoline variant of Tasks RCU enab=
led.
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 Tracing variant of Tasks RCU enabled=
.
> [=C2=A0=C2=A0=C2=A0 0.000000] rcu: RCU calculated value of scheduler-enl=
istment delay is 10 jiffies.
> [=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 96
> [=C2=A0=C2=A0=C2=A0 0.000000] rcu: srcu_init: Setting srcu_struct sizes =
based on contention.
> [=C2=A0=C2=A0=C2=A0 0.000149] sched_clock: 32 bits at 250MHz, resolution=
 4ns, wraps every 8589934590ns
> [=C2=A0=C2=A0=C2=A0 0.005146] Console: colour dummy device 160x64
> [=C2=A0=C2=A0=C2=A0 0.006640] Calibrating delay loop... 1771.11 BogoMIPS=
 (lpj=3D8855552)
> [=C2=A0=C2=A0=C2=A0 0.123925] pid_max: default: 32768 minimum: 301
> [=C2=A0=C2=A0=C2=A0 0.128202] Mount-cache hash table entries: 1024 (orde=
r: 0, 4096 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.128461] Mountpoint-cache hash table entries: 1024 =
(order: 0, 4096 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.159241] XXX workqueue_init: possible_cpus=3Dffff
> [=C2=A0=C2=A0=C2=A0 0.175221] RCU Tasks: Setting shift to 4 and lim to 1=
 rcu_task_cb_adjust=3D1.
> [=C2=A0=C2=A0=C2=A0 0.176798] RCU Tasks Trace: Setting shift to 4 and li=
m to 1 rcu_task_cb_adjust=3D1.
> [=C2=A0=C2=A0=C2=A0 0.177562] TOC handler registered
> [=C2=A0=C2=A0=C2=A0 0.178992] rcu: Hierarchical SRCU implementation.
> [=C2=A0=C2=A0=C2=A0 0.179222] rcu:=C2=A0=C2=A0=C2=A0=C2=A0 Max phase no-=
delay instances is 1000.
> [=C2=A0=C2=A0=C2=A0 0.193315] smp: Bringing up secondary CPUs ...
> [=C2=A0=C2=A0=C2=A0 0.194144] smp: Brought up 1 node, 1 CPU
> [=C2=A0=C2=A0=C2=A0 0.199106] XXX workqueue_init_topology: possible_cpus=
=3Dffff
> [=C2=A0=C2=A0=C2=A0 0.208842] devtmpfs: initialized
> [=C2=A0=C2=A0=C2=A0 0.217239] clocksource: jiffies: mask: 0xffffffff max=
_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [=C2=A0=C2=A0=C2=A0 0.218067] futex hash table entries: 4096 (order: 5, =
131072 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.224055] NET: Registered PF_NETLINK/PF_ROUTE protoc=
ol family
> [=C2=A0=C2=A0=C2=A0 0.231058] EISA bus registered
> [=C2=A0=C2=A0=C2=A0 0.231481] Searching for devices...
> [=C2=A0=C2=A0=C2=A0 0.237416] Found devices:
> [=C2=A0=C2=A0=C2=A0 0.237623] 1. Phantom PseudoBC GSC+ Port [8] at 0xffc=
00000 { type:7, hv:0x504, sv:0x0, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.237874] 2. Dino PCI Bridge [8:0] at 0xfff80000 { t=
ype:13, hv:0x680, sv:0xa, rev:0x3 }
> [=C2=A0=C2=A0=C2=A0 0.238234] 3. Merlin+ 132 Dino RS-232 [8:0:63] at 0xf=
ff83000 { type:10, hv:0x22, sv:0x8c, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.238490] 4. Merlin 160 Core BA [8:16] at 0xffd00000=
 { type:11, hv:0x3d, sv:0x81, rev:0x0 }, additional addresses: 0xffd0c000 =
0xffc00000
> [=C2=A0=C2=A0=C2=A0 0.238923] 5. Merlin 160 Core RS-232 [8:16:4] at 0xff=
d05000 { type:10, hv:0x3d, sv:0x8c, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.239193] 6. Merlin 160 Core Centronics [8:16:0] at =
0xffd02000 { type:10, hv:0x3d, sv:0x74, rev:0x0 }, additional addresses: 0=
xffd01000 0xffd03000
> [=C2=A0=C2=A0=C2=A0 0.239595] 7. Memory [63] at 0xfffff000 { type:1, hv:=
0x67, sv:0x9, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.239839] 8. Merlin L2 160 (9000/778/B160L) [48] at =
0xfffb0000 { type:0, hv:0x502, sv:0x4, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.240145] 9. Merlin L2 160 (9000/778/B160L) [49] at =
0xfffb1000 { type:0, hv:0x502, sv:0x4, rev:0x0 }
> [=C2=A0=C2=A0=C2=A0 0.240509] Found qemu fw_cfg interface at 0xfffa0000
> [=C2=A0=C2=A0=C2=A0 0.243313] CPU0: cpu core 0 of socket 0
> [=C2=A0=C2=A0=C2=A0 0.244475] CPU1: cpu core 0 of socket 1
> [=C2=A0=C2=A0=C2=A0 0.248134] Releasing cpu 1 now, hpa=3Dfffb1000
> [=C2=A0=C2=A0=C2=A0 0.255231] CPU(s): 2 out of 2 PA7300LC (PCX-L2) at 25=
0.000000 MHz online
> [=C2=A0=C2=A0=C2=A0 0.257077] alternatives: applied 17 out of 1505 patch=
es
> [=C2=A0=C2=A0=C2=A0 0.258013] Calculated flush threshold is 5909 KiB
> [=C2=A0=C2=A0=C2=A0 0.258162] Cache flush threshold set to 2 KiB
> [=C2=A0=C2=A0=C2=A0 0.258304] TLB flush threshold set to 480 KiB
> [=C2=A0=C2=A0=C2=A0 0.259216] Lasi version 0 at 0xffd00000 found.
> [=C2=A0=C2=A0=C2=A0 0.261123] Dino version 3.1 found at 0xfff80000
> [=C2=A0=C2=A0=C2=A0 0.263459] dino 8:0: PCI host bridge to bus 0000:00
> [=C2=A0=C2=A0=C2=A0 0.263841] pci_bus 0000:00: root bus resource [io=C2=
=A0 0x0000-0xffff]
> [=C2=A0=C2=A0=C2=A0 0.264196] pci_bus 0000:00: root bus resource [mem 0x=
f0800000-0xff7fffff]
> [=C2=A0=C2=A0=C2=A0 0.264476] pci_bus 0000:00: root bus resource [bus 00=
-ff]
> [=C2=A0=C2=A0=C2=A0 0.265734] pci 0000:00:00.0: [1000:0012] type 00 clas=
s 0x010000 conventional PCI endpoint
> [=C2=A0=C2=A0=C2=A0 0.267232] pci 0000:00:00.0: BAR 0 [io=C2=A0 0x1000-0=
x10ff]
> [=C2=A0=C2=A0=C2=A0 0.268292] pci 0000:00:00.0: BAR 1 [mem 0xff7fe000-0x=
ff7fe3ff]
> [=C2=A0=C2=A0=C2=A0 0.269408] pci 0000:00:00.0: BAR 2 [mem 0xff7fc000-0x=
ff7fdfff]
> [=C2=A0=C2=A0=C2=A0 0.277602] pci 0000:00:01.0: [1011:0019] type 00 clas=
s 0x020000 conventional PCI endpoint
> [=C2=A0=C2=A0=C2=A0 0.278298] pci 0000:00:01.0: BAR 0 [io=C2=A0 0x1100-0=
x117f]
> [=C2=A0=C2=A0=C2=A0 0.278820] pci 0000:00:01.0: BAR 1 [mem 0xff7ff000-0x=
ff7ff07f]
> [=C2=A0=C2=A0=C2=A0 0.281323] pci 0000:00:02.0: [103c:1048] type 00 clas=
s 0x070000 conventional PCI endpoint
> [=C2=A0=C2=A0=C2=A0 0.281867] pci 0000:00:02.0: BAR 0 [io=C2=A0 0x1180-0=
x1187]
> [=C2=A0=C2=A0=C2=A0 0.284921] pci_bus 0000:00: busn_res: [bus 00-ff] end=
 is updated to 00
> [=C2=A0=C2=A0=C2=A0 0.287179] pci 0000:00:00.0: BAR 2 [mem 0xf0800000-0x=
f0801fff]: assigned
> [=C2=A0=C2=A0=C2=A0 0.287830] pci 0000:00:00.0: BAR 1 [mem 0xf0802000-0x=
f08023ff]: assigned
> [=C2=A0=C2=A0=C2=A0 0.288225] pci 0000:00:00.0: BAR 0 [io=C2=A0 0x0100-0=
x01ff]: assigned
> [=C2=A0=C2=A0=C2=A0 0.288628] pci 0000:00:01.0: BAR 0 [io=C2=A0 0x0080-0=
x00ff]: assigned
> [=C2=A0=C2=A0=C2=A0 0.289002] pci 0000:00:01.0: BAR 1 [mem 0xf0803000-0x=
f080307f]: assigned
> [=C2=A0=C2=A0=C2=A0 0.289359] pci 0000:00:02.0: BAR 0 [io=C2=A0 0x0010-0=
x0017]: assigned
> [=C2=A0=C2=A0=C2=A0 0.290999] powersw: Soft power switch at 0xf07ffff0 e=
nabled.
> [=C2=A0=C2=A0=C2=A0 0.314551] SCSI subsystem initialized
> [=C2=A0=C2=A0=C2=A0 0.317664] usbcore: registered new interface driver u=
sbfs
> [=C2=A0=C2=A0=C2=A0 0.318202] usbcore: registered new interface driver h=
ub
> [=C2=A0=C2=A0=C2=A0 0.318580] usbcore: registered new device driver usb
> [=C2=A0=C2=A0=C2=A0 0.334210] vgaarb: loaded
> [=C2=A0=C2=A0=C2=A0 0.337059] VFS: Disk quotas dquot_6.6.0
> [=C2=A0=C2=A0=C2=A0 0.337473] VFS: Dquot-cache hash table entries: 1024 =
(order 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.369580] NET: Registered PF_INET protocol family
> [=C2=A0=C2=A0=C2=A0 0.371471] IP idents hash table entries: 8192 (order:=
 4, 65536 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.380082] tcp_listen_portaddr_hash hash table entrie=
s: 256 (order: 0, 5120 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.381103] Table-perturb hash table entries: 65536 (o=
rder: 6, 262144 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.381397] TCP established hash table entries: 4096 (=
order: 2, 16384 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.382605] TCP bind hash table entries: 4096 (order: =
5, 163840 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.383338] TCP: Hash tables configured (established 4=
096 bind 4096)
> [=C2=A0=C2=A0=C2=A0 0.385144] UDP hash table entries: 256 (order: 1, 122=
88 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.385743] UDP-Lite hash table entries: 256 (order: 1=
, 12288 bytes, linear)
> [=C2=A0=C2=A0=C2=A0 0.387545] NET: Registered PF_UNIX/PF_LOCAL protocol =
family
> [=C2=A0=C2=A0=C2=A0 0.388172] PCI: CLS 16 bytes
> [=C2=A0=C2=A0=C2=A0 0.390311] clocksource: cr16: mask: 0xffffffff max_cy=
cles: 0xffffffff, max_idle_ns: 7645041786 ns
> [=C2=A0=C2=A0=C2=A0 0.391141] clocksource: Switched to clocksource cr16
> [=C2=A0=C2=A0=C2=A0 0.391756] Enabling PDC chassis warnings support v0.0=
5
> [=C2=A0=C2=A0=C2=A0 0.396076] workingset: timestamp_bits=3D14 max_order=
=3D17 bucket_order=3D3
> [=C2=A0=C2=A0=C2=A0 0.404012] io scheduler mq-deadline registered
> [=C2=A0=C2=A0=C2=A0 0.404324] io scheduler kyber registered
> [=C2=A0=C2=A0=C2=A0 0.407216] PDC Stable Storage facility v0.30
> [=C2=A0=C2=A0=C2=A0 0.408521] sticore: STI GSC/PCI core graphics driver =
Version 0.9c
> [=C2=A0=C2=A0=C2=A0 0.496987] Serial: 8250/16550 driver, 4 ports, IRQ sh=
aring enabled
> [=C2=A0=C2=A0=C2=A0 0.511533] printk: legacy console [ttyS0] disabled
> [=C2=A0=C2=A0=C2=A0 0.515146] 8:16:4: ttyS0 at MMIO 0xffd05800 (irq =3D =
16, base_baud =3D 454545) is a 16550A
> [=C2=A0=C2=A0=C2=A0 0.518634] printk: legacy console [ttyS0] enabled
> [=C2=A0=C2=A0=C2=A0 0.518634] printk: legacy console [ttyS0] enabled
> [=C2=A0=C2=A0=C2=A0 0.519267] printk: legacy bootconsole [pdc0] disabled
> [=C2=A0=C2=A0=C2=A0 0.519267] printk: legacy bootconsole [pdc0] disabled
> [=C2=A0=C2=A0=C2=A0 0.528540] 8:0:63: ttyS1 at MMIO 0xfff83800 (irq =3D =
18, base_baud =3D 454545) is a 16550A
> [=C2=A0=C2=A0=C2=A0 0.531850] serial 0000:00:02.0: enabling SERR and PAR=
ITY (0103 -> 0143)
> [=C2=A0=C2=A0=C2=A0 0.535316] 0000:00:02.0: ttyS2 at I/O 0x10 (irq =3D 2=
1, base_baud =3D 115200) is a 16550A
> [=C2=A0=C2=A0=C2=A0 0.539332] parport_init_chip: initialize bidirectiona=
l-mode
> [=C2=A0=C2=A0=C2=A0 0.540300] parport0: PC-style at 0xffd02800, irq 17 [=
PCSPP,TRISTATE]
> [=C2=A0=C2=A0=C2=A0 0.667976] loop: module loaded
> [=C2=A0=C2=A0=C2=A0 0.669638] sym53c8xx 0000:00:00.0: enabling SERR and =
PARITY (0107 -> 0147)
> [=C2=A0=C2=A0=C2=A0 0.672643] sym0: <895a> rev 0x0 at pci 0000:00:00.0 i=
rq 19
> [=C2=A0=C2=A0=C2=A0 0.678720] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD=
, parity checking
> [=C2=A0=C2=A0=C2=A0 0.684386] sym0: SCSI BUS has been reset.
> [=C2=A0=C2=A0=C2=A0 0.687904] scsi host0: sym-2.2.3
> [=C2=A0=C2=A0=C2=A0 3.783993] scsi 0:0:0:0: Direct-Access=C2=A0=C2=A0=C2=
=A0=C2=A0 QEMU=C2=A0=C2=A0=C2=A0=C2=A0 QEMU HARDDISK=C2=A0=C2=A0=C2=A0 2.5=
+ PQ: 0 ANSI: 5
> [=C2=A0=C2=A0=C2=A0 3.784726] scsi target0:0:0: tagged command queuing e=
nabled, command queue depth 16.
> [=C2=A0=C2=A0=C2=A0 3.785900] scsi target0:0:0: Beginning Domain Validat=
ion
> [=C2=A0=C2=A0=C2=A0 3.788722] scsi target0:0:0: Domain Validation skippi=
ng write tests
> [=C2=A0=C2=A0=C2=A0 3.788895] scsi target0:0:0: Ending Domain Validation
> [=C2=A0=C2=A0=C2=A0 3.801756] scsi 0:0:2:0: CD-ROM=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU=C2=A0=C2=A0=C2=A0=C2=A0=
 QEMU CD-ROM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5+ PQ: 0 ANSI: 5
> [=C2=A0=C2=A0=C2=A0 3.802043] scsi target0:0:2: tagged command queuing e=
nabled, command queue depth 16.
> [=C2=A0=C2=A0=C2=A0 3.802392] scsi target0:0:2: Beginning Domain Validat=
ion
> [=C2=A0=C2=A0=C2=A0 3.803995] scsi target0:0:2: Domain Validation skippi=
ng write tests
> [=C2=A0=C2=A0=C2=A0 3.804138] scsi target0:0:2: Ending Domain Validation
> [=C2=A0=C2=A0=C2=A0 3.816982] st: Version 20160209, fixed bufsize 32768,=
 s/g segs 256
> [=C2=A0=C2=A0=C2=A0 3.820181] sr 0:0:2:0: Power-on or device reset occur=
red
> [=C2=A0=C2=A0=C2=A0 3.822714] sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x=
 cd/rw xa/form2 cdda tray
> [=C2=A0=C2=A0=C2=A0 3.823139] cdrom: Uniform CD-ROM driver Revision: 3.2=
0
> [=C2=A0=C2=A0=C2=A0 3.824901] sd 0:0:0:0: Power-on or device reset occur=
red
> [=C2=A0=C2=A0=C2=A0 3.828055] sd 0:0:0:0: [sda] 62914560 512-byte logica=
l blocks: (32.2 GB/30.0 GiB)
> [=C2=A0=C2=A0=C2=A0 3.829255] sd 0:0:0:0: [sda] Write Protect is off
> [=C2=A0=C2=A0=C2=A0 3.832789] sd 0:0:0:0: Attached scsi generic sg0 type=
 0
> [=C2=A0=C2=A0=C2=A0 3.833235] sd 0:0:0:0: [sda] Write cache: enabled, re=
ad cache: enabled, doesn't support DPO or FUA
> [=C2=A0=C2=A0=C2=A0 3.833534] sr 0:0:2:0: Attached scsi generic sg1 type=
 5
> [=C2=A0=C2=A0=C2=A0 3.835756] tulip 0000:00:01.0: enabling SERR and PARI=
TY (0103 -> 0143)
> [=C2=A0=C2=A0=C2=A0 3.849999] tulip0: EEPROM default media type Autosens=
e
> [=C2=A0=C2=A0=C2=A0 3.850253] tulip0: Index #0 - Media MII (#11) describ=
ed by a 21142 MII PHY (3) block
> [=C2=A0=C2=A0=C2=A0 3.853899] tulip0:=C2=A0 MII transceiver #1 config 31=
00 status 702c advertising 0501
> [=C2=A0=C2=A0=C2=A0 3.856302]=C2=A0 sda: sda1 sda2 sda3 < sda5 sda6 >
> [=C2=A0=C2=A0=C2=A0 3.870391] sd 0:0:0:0: [sda] Attached SCSI disk
> [=C2=A0=C2=A0=C2=A0 3.871194] net eth0: Digital DS21142/43 Tulip rev 0 a=
t Port 0x80, 52:54:00:12:34:56, IRQ 20
> [=C2=A0=C2=A0=C2=A0 3.872279] e100: Intel(R) PRO/100 Network Driver
> [=C2=A0=C2=A0=C2=A0 3.872486] e100: Copyright(c) 1999-2006 Intel Corpora=
tion
> [=C2=A0=C2=A0=C2=A0 3.873836] e1000: Intel(R) PRO/1000 Network Driver
> [=C2=A0=C2=A0=C2=A0 3.874067] e1000: Copyright (c) 1999-2006 Intel Corpo=
ration.
> [=C2=A0=C2=A0=C2=A0 3.874406] e1000e: Intel(R) PRO/1000 Network Driver
> [=C2=A0=C2=A0=C2=A0 3.874536] e1000e: Copyright(c) 1999 - 2015 Intel Cor=
poration.
> [=C2=A0=C2=A0=C2=A0 3.875010] igb: Intel(R) Gigabit Ethernet Network Dri=
ver
> [=C2=A0=C2=A0=C2=A0 3.875212] igb: Copyright (c) 2007-2014 Intel Corpora=
tion.
> [=C2=A0=C2=A0=C2=A0 3.875563] LASI 82596 driver - Revision: 1.30
> [=C2=A0=C2=A0=C2=A0 3.878798] HP SDC: No SDC found.
> [=C2=A0=C2=A0=C2=A0 3.879000] HP SDC MLC: Registering the System Domain =
Controller's HIL MLC.
> [=C2=A0=C2=A0=C2=A0 3.884554] HP SDC MLC: Request for raw HIL ISR hook d=
enied
> [=C2=A0=C2=A0=C2=A0 3.906699] mousedev: PS/2 mouse device common for all=
 mice
> [=C2=A0=C2=A0=C2=A0 3.912379] rtc-generic rtc-generic: registered as rtc=
0
> [=C2=A0=C2=A0=C2=A0 3.913033] rtc-generic rtc-generic: setting system cl=
ock to 2024-02-02T08:24:45 UTC (1706862285)
> [=C2=A0=C2=A0=C2=A0 3.919114] hid: raw HID events driver (C) Jiri Kosina
> [=C2=A0=C2=A0=C2=A0 3.919926] usbcore: registered new interface driver u=
sbhid
> [=C2=A0=C2=A0=C2=A0 3.920146] usbhid: USB HID core driver
> [=C2=A0=C2=A0=C2=A0 3.921737] NET: Registered PF_PACKET protocol family
> [=C2=A0=C2=A0=C2=A0 3.924787] Key type dns_resolver registered
> [=C2=A0=C2=A0=C2=A0 4.092592] EXT4-fs (sda5): INFO: recovery required on=
 readonly filesystem
> [=C2=A0=C2=A0=C2=A0 4.092910] EXT4-fs (sda5): write access will be enabl=
ed during recovery
> [=C2=A0=C2=A0=C2=A0 4.200680] EXT4-fs (sda5): recovery complete
> [=C2=A0=C2=A0=C2=A0 4.207887] EXT4-fs (sda5): mounted filesystem 0e24f05=
b-efd0-4f75-b1de-3309bd27dbd8 ro with ordered data mode. Quota mode: none.
> [=C2=A0=C2=A0=C2=A0 4.209030] VFS: Mounted root (ext4 filesystem) readon=
ly on device 8:5.
> [=C2=A0=C2=A0=C2=A0 4.214953] devtmpfs: mounted
> [=C2=A0=C2=A0=C2=A0 4.267329] Freeing unused kernel image (initmem) memo=
ry: 3072K
> [=C2=A0=C2=A0=C2=A0 4.267826] Write protected read-only-after-init data:=
 2k
> [=C2=A0=C2=A0=C2=A0 4.268225] Run /sbin/init as init process
> [=C2=A0=C2=A0=C2=A0 4.305438] process 'usr/lib/systemd/systemd' started =
with executable stack
> [=C2=A0=C2=A0=C2=A0 4.932357] systemd[1]: systemd 255.3-2 running in sys=
tem mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK -SECCOMP +GCRYPT -GNU=
TLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LI=
BCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ=
4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierar=
chy=3Dunified)
> [=C2=A0=C2=A0=C2=A0 4.933521] systemd[1]: Detected architecture parisc.
>
> Welcome to Debian GNU/Linux trixie/sid!
>
> [...]
> root@debian:~# lscpu
> Architecture:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pari=
sc
>  =C2=A0 Byte Order:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Big Endian
> CPU(s):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>  =C2=A0 On-line CPU(s) list: 0,1
> Model name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PA7300LC (PCX-L2)
>  =C2=A0 CPU family:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PA-RISC 1.1e
>  =C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9000/778/B160L - Merlin L2 160 (9000/778/B160L=
)
>  =C2=A0 Thread(s) per core:=C2=A0 1
>  =C2=A0 Core(s) per socket:=C2=A0 1
>  =C2=A0 Socket(s):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2
>  =C2=A0 BogoMIPS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1771.11
> root@debian:~# chcpu -d 1
> [=C2=A0=C2=A0 84.800279] Backtrace:
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10448744>] workqueue_offline_cpu+0x1d4/=
0x1dc
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10429db4>] cpuhp_invoke_callback+0xf8/0=
x200
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10452970>] smpboot_thread_fn+0x284/0x28=
8
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1044d8f4>] kthread+0x12c/0x13c
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1040201c>] ret_from_kernel_thread+0x1c/=
0x24
> [=C2=A0=C2=A0 84.802648]
> [=C2=A0=C2=A0 84.802648]
> [=C2=A0=C2=A0 84.802648] Kernel Fault: Code=3D26 (Data memory access rig=
hts trap) at addr 00000000
> [=C2=A0=C2=A0 84.802648] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-=
rc2-32bit+ #1294
> [=C2=A0=C2=A0 84.802648] Hardware name: 9000/778/B160L
> [=C2=A0=C2=A0 84.802648]
> [=C2=A0=C2=A0 84.802648]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 YZrvWESTHLNXBCVMc=
bcbcbcbOGFRQPDI
> [=C2=A0=C2=A0 84.802648] PSW: 00000000000001001111111100001111 Not taint=
ed
> [=C2=A0=C2=A0 84.802648] r00-03=C2=A0 0004ff0f 11011540 10446d9c 11e0050=
0
> [=C2=A0=C2=A0 84.802648] r04-07=C2=A0 11c0b800 00000002 11c0d000 0000000=
1
> [=C2=A0=C2=A0 84.802648] r08-11=C2=A0 110194e4 11019168 00000000 0000000=
4
> [=C2=A0=C2=A0 84.802648] r12-15=C2=A0 10c78800 00000612 f0028050 f0027fd=
8
> [=C2=A0=C2=A0 84.802648] r16-19=C2=A0 fffffffc fee01180 f0027ed8 0173500=
0
> [=C2=A0=C2=A0 84.802648] r20-23=C2=A0 0000ffff 13ae1a00 13ae1a00 0000000=
0
> [=C2=A0=C2=A0 84.802648] r24-27=C2=A0 11c0c580 11c0d004 11c0d000 10ceb96=
8
> [=C2=A0=C2=A0 84.802648] r28-31=C2=A0 00000000 0000000e 11e00580 0000001=
8
> [=C2=A0=C2=A0 84.802648] sr00-03=C2=A0 00000000 00000000 00000000 000004=
af
> [=C2=A0=C2=A0 84.802648] sr04-07=C2=A0 00000000 00000000 00000000 000000=
00
> [=C2=A0=C2=A0 84.802648]
> [=C2=A0=C2=A0 84.802648] IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
> [=C2=A0=C2=A0 84.802648]=C2=A0 IIR: 0f80109c=C2=A0=C2=A0=C2=A0 ISR: 0000=
0000=C2=A0 IOR: 00000000
> [=C2=A0=C2=A0 84.802648]=C2=A0 CPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1=C2=A0=C2=A0 CR30: 11dd1710 CR31: 00000000
> [=C2=A0=C2=A0 84.802648]=C2=A0 ORIG_R28: 00000612
> [=C2=A0=C2=A0 84.802648]=C2=A0 IAOQ[0]: wq_update_pod+0x98/0x14c
> [=C2=A0=C2=A0 84.802648]=C2=A0 IAOQ[1]: wq_update_pod+0x9c/0x14c
> [=C2=A0=C2=A0 84.802648]=C2=A0 RP(r2): wq_update_pod+0x80/0x14c
> [=C2=A0=C2=A0 84.802648] Backtrace:
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10448744>] workqueue_offline_cpu+0x1d4/=
0x1dc
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10429db4>] cpuhp_invoke_callback+0xf8/0=
x200
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<10452970>] smpboot_thread_fn+0x284/0x28=
8
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1044d8f4>] kthread+0x12c/0x13c
> [=C2=A0=C2=A0 84.802648]=C2=A0 [<1040201c>] ret_from_kernel_thread+0x1c/=
0x24
> [=C2=A0=C2=A0 84.802648]
> [=C2=A0=C2=A0 84.802648] Kernel panic - not syncing: Kernel Fault

In a second step I extended your patch to print the present
and online CPUs too. Below is the relevant dmesg part.

Note, that on parisc the second CPU will be activated later in the
boot process, after the kernel has the inventory.
This I think differs vs x86, where all CPUs are available earlier
in the boot process.
..
[    0.000000] XXX workqueue_init_early: possible_cpus=3Dffff  present=3D0=
001  online=3D0001
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
[    0.005119] Console: colour dummy device 160x64
[    0.006600] Calibrating delay loop... 2465.79 BogoMIPS (lpj=3D12328960)
[    0.196545] pid_max: default: 32768 minimum: 301
[    0.200761] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes,=
 linear)
[    0.201009] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 b=
ytes, linear)
[    0.228080] XXX workqueue_init: possible_cpus=3Dffff  present=3D0001  o=
nline=3D0001
[    0.240799] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adju=
st=3D1.
[    0.242004] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_c=
b_adjust=3D1.
[    0.242735] TOC handler registered
[    0.244112] rcu: Hierarchical SRCU implementation.
[    0.244270] rcu:     Max phase no-delay instances is 1000.
[    0.259462] smp: Bringing up secondary CPUs ...
[    0.260271] smp: Brought up 1 node, 1 CPU
[    0.263466] XXX workqueue_init_topology: possible_cpus=3Dffff  present=
=3D0001  online=3D0001
[    0.273156] devtmpfs: initialized
[    0.282163] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 19112604462750000 ns
..
[    0.296480] Searching for devices...
[    0.301965] Found devices:
[    0.302119] 1. Phantom PseudoBC GSC+ Port [8] at 0xffc00000 { type:7, h=
v:0x504, sv:0x0, rev:0x0 }
[    0.302353] 2. Dino PCI Bridge [8:0] at 0xfff80000 { type:13, hv:0x680,=
 sv:0xa, rev:0x3 }
[    0.302549] 3. Merlin+ 132 Dino RS-232 [8:0:63] at 0xfff83000 { type:10=
, hv:0x22, sv:0x8c, rev:0x0 }
[    0.302755] 4. Merlin 160 Core BA [8:16] at 0xffd00000 { type:11, hv:0x=
3d, sv:0x81, rev:0x0 }, additional addresses: 0xffd0c000 0xffc00000
[    0.303084] 5. Merlin 160 Core RS-232 [8:16:4] at 0xffd05000 { type:10,=
 hv:0x3d, sv:0x8c, rev:0x0 }
[    0.303287] 6. Merlin 160 Core Centronics [8:16:0] at 0xffd02000 { type=
:10, hv:0x3d, sv:0x74, rev:0x0 }, additional addresses: 0xffd01000 0xffd03=
000
[    0.303605] 7. Memory [63] at 0xfffff000 { type:1, hv:0x67, sv:0x9, rev=
:0x0 }
[    0.303776] 8. Merlin L2 160 (9000/778/B160L) [48] at 0xfffb0000 { type=
:0, hv:0x502, sv:0x4, rev:0x0 }
[    0.303996] 9. Merlin L2 160 (9000/778/B160L) [49] at 0xfffb1000 { type=
:0, hv:0x502, sv:0x4, rev:0x0 }
[    0.304245] Found qemu fw_cfg interface at 0xfffa0000
[    0.306850] CPU0: cpu core 0 of socket 0
[    0.307868] CPU1: cpu core 0 of socket 1
[    0.311565] Releasing cpu 1 now, hpa=3Dfffb1000
[    0.322058] CPU(s): 2 out of 2 PA7300LC (PCX-L2) at 250.000000 MHz onli=
ne
^^^ here the second CPU gets activated (after workqueue_init* has run).

Helge

