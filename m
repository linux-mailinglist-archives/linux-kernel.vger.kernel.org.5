Return-Path: <linux-kernel+bounces-48544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A4845D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F01F2CC20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2715C80;
	Thu,  1 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SAl3WAKb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F94A2A;
	Thu,  1 Feb 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805681; cv=none; b=buXzPv/VOGzflfizBRd/5WuDmuPZsvPfurwRq7vPRDJYblol1dY3cp8OefZYwjW82dulpvq7cBGPtTWIF7UXVZ+XwYTZlnc3L/DJHLeLBWmCPAmLE8DA6eF+JoQnMJ/YJQEZVdgzvCPzWOAOp7tUO0ucqbMXlEw9By0kLePqdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805681; c=relaxed/simple;
	bh=8jHu6yHt8uCA3Dy1yFe+TlZEoJuvBfuOFfiYAURRHCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYX/rRVPCye3zkRCmC6o7RumioViTjEe3+skk7frHn2YtxNCn9nSEY+D7oJttt7HBpWkrxvVvXqRxZgkRK3DpHtW4ydO9TWFdToYbbUYprCMgmEiF0fqup4GTNklm1mu4awRwrJhowmRSqZSlnM7Z1XGOy0vfa5Y0IdlBkEw9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SAl3WAKb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706805671; x=1707410471; i=deller@gmx.de;
	bh=8jHu6yHt8uCA3Dy1yFe+TlZEoJuvBfuOFfiYAURRHCs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SAl3WAKbdxre9ty8GQzr5DFP6GnJxkvhM1Y02PyPuM1JKXNoFrgKxhkcvJG5mz+I
	 SSzogr/NtTUOkoEMkcKHcxQDY+1n9HmH0jPFwwI7j3bcO+tiVuCgWZaTOAsgW/+qA
	 +3RTsGyv783p7DmJ6eINYIVOvPL7IBWHPf68ZJvtMYYOfAAUsPXUOLeXTI49fvmXo
	 ZRxDR1qR7bsGHXlGB+tIIK8cS4x6kE6Fsoc66SvaIBoXc+DFpblz9ehhJ8Dxx0L72
	 nESEx12jWq+p91kk/NuHtrMgUti373sUdv803MGiL3WxJpA5O2nkG2hV7NK/9OTsH
	 UjEyyWFSebPVBznyPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1qjNWy2XHb-00oUnh; Thu, 01
 Feb 2024 17:41:11 +0100
Message-ID: <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
Date: Thu, 1 Feb 2024 17:41:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Helge Deller <deller@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org
References: <ZbqfMR_mVLaSCj4Q@carbonx1> <ZbrJq3X63hIMkbl2@slm.duckdns.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZbrJq3X63hIMkbl2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w57UWtdmFRiBnq3mv+oAtnI+elf1uGycDr/a5vvBaJMTS5EJxWv
 VFTxYtvVmZSEuMR14iL3OhDbozIc6twHyRc4V75fbfSmvf7WptcmHexISs0t4Y0ooW9Uxcc
 XhdcNRsaF+EfJDfRS/qzsAl1sKEmVqyYj4wFXLOVuitYh1KdpG50VGc3dvpb6S7VLkvY553
 kbHU3UdfajzWlNP70sXyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yrl6l4XB8O8=;OrePRDiSVj9iLyFebIj8eIkuU7o
 5BMDumthG0S+bLzwzwC6Kh3YSAN2cssz8UR1tfrMJoW/yelx+/MldarMr9ZW8YBixsYKjzU1k
 6mb1li51AdjC+w1ZA5bi8NvbYvyJ7+76UduOSt5ZgdTH5x9AgqCJFtfTqzWII3joLxTzQhKgq
 ugzTf0u97mG4+MDhauGEJuZSNaDfPcdscPcAATHn58QMUnxOOEB9HiZMVPMLufri/xNhqb6hK
 uvqCrGJNORzrgJyOjd/JSsU92335z3q6uaaA5GeFu6C6ww/LGRRWP/QnJNXpEswdVha+yzB6J
 +AJF+EYK5ExLu0K4/cby/9g7yBug7vlZwVGjDySVYSAEQdpV1ja9YqtWAujihCLBYO1UK+pHO
 KIxBCyomD/1P1lprP76o6Bi96LtSTC8PgAlagDwR/ItMhgvV+CRtOTR7fKk0rdt14Xjyrr/S9
 DcVkosdUwh7MlM6Wu8VBY7nJGDeGVrxirwgapdnPxM7BioReVtwLdKMM7qz70FW4u8IIIULv8
 Sd30UIH5f7CxBrHqyBJFvPYzy1H3f0/e0O7dMatD2GxCWYeSa1bPHFus/flVzzNmwS4Fg3Vfm
 XSYD2k+kl3R6uvzjeMVzmywysL2FP8SJEW27qfY0Uo/VUg0TPG0AoIFQh/8T/0dF+k/+ki7NS
 l53P1DZSYPU5q8V+CVG3G82oOLBkP8VPLxYlm0BwC8TOdmH8BU9rlSUSVeyugByLi0abcrT60
 OBNf3B2pd5LUNY8HIn49BOH7zTkBSOZ2z75E5DJUs45xY3TccWLrqjlOd0kpxFpV7N6IAMswe
 VEH5NbJc14kIVvgjszGgySmEPzSXOiH2OXsck2MfqnhxQ=

On 1/31/24 23:28, Tejun Heo wrote:
> On Wed, Jan 31, 2024 at 08:27:45PM +0100, Helge Deller wrote:
>> When hot-unplugging a 32-bit CPU on the parisc platform with
>> "chcpu -d 1", I get the following kernel panic. Adding a check
>> for !pwq prevents the panic.
>>
>>   Kernel Fault: Code=3D26 (Data memory access rights trap) at addr 0000=
0000
>>   CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.8.0-rc1-32bit+ #1291
>>   Hardware name: 9000/778/B160L
>>
>>   IASQ: 00000000 00000000 IAOQ: 10446db4 10446db8
>>    IIR: 0f80109c    ISR: 00000000  IOR: 00000000
>>    CPU:        1   CR30: 11dd1710 CR31: 00000000
>>    IAOQ[0]: wq_update_pod+0x98/0x14c
>>    IAOQ[1]: wq_update_pod+0x9c/0x14c
>>    RP(r2): wq_update_pod+0x80/0x14c
>>   Backtrace:
>>    [<10448744>] workqueue_offline_cpu+0x1d4/0x1dc
>>    [<10429db4>] cpuhp_invoke_callback+0xf8/0x200
>>    [<1042a1d0>] cpuhp_thread_fun+0xb8/0x164
>>    [<10452970>] smpboot_thread_fn+0x284/0x288
>>    [<1044d8f4>] kthread+0x12c/0x13c
>>    [<1040201c>] ret_from_kernel_thread+0x1c/0x24
>>   Kernel panic - not syncing: Kernel Fault
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> ---
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 76e60faed892..dfeee7b7322c 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -4521,6 +4521,8 @@ static void wq_update_pod(struct workqueue_struct=
 *wq, int cpu,
>>   	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
>>   	pwq =3D rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
>>   					lockdep_is_held(&wq_pool_mutex));
>> +	if (!pwq)
>> +		return;
>
> Hmm... I have a hard time imagining a scenario where some CPUs don't hav=
e
> pwq installed on wq->cpu_pwq. Can you please run `drgn
> tools/workqueue/wq_dump.py` before triggering the hotplug event and past=
e
> the output along with full dmesg?

I'm not sure if parisc is already fully supported with that tool, or
if I'm doing something wrong:

root@debian:~# uname -a
Linux debian 6.8.0-rc1-32bit+ #1292 SMP PREEMPT Thu Feb  1 11:31:38 CET 20=
24 parisc GNU/Linux

root@debian:~# drgn --main-symbols -s ./vmlinux ./wq_dump.py
Traceback (most recent call last):
   File "/usr/bin/drgn", line 33, in <module>
     sys.exit(load_entry_point('drgn=3D=3D0.0.25', 'console_scripts', 'drg=
n')())
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
   File "/usr/lib/python3/dist-packages/drgn/cli.py", line 301, in _main
     runpy.run_path(script, init_globals=3D{"prog": prog}, run_name=3D"__m=
ain__")
   File "<frozen runpy>", line 291, in run_path
   File "<frozen runpy>", line 98, in _run_module_code
   File "<frozen runpy>", line 88, in _run_code
   File "./wq_dump.py", line 78, in <module>
     worker_pool_idr         =3D prog['worker_pool_idr']
                               ~~~~^^^^^^^^^^^^^^^^^^^
KeyError: 'worker_pool_idr'

Maybe you have an idea? I'll check further, but otherwise it's probably
easier for me to add some printk() to the kernel function wq_update_pod()
and send that info?

Helge

