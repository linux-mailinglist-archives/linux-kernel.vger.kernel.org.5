Return-Path: <linux-kernel+bounces-97948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F45877225
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91A31F215F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6324594D;
	Sat,  9 Mar 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="jMjPXz7O";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Bl+PEwTp"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED994085E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710000836; cv=none; b=m9AUb8XjI2ZncNAgC/ddSO47d9VapjTMLaVQsq9UbXx6WDU1tuP90R493FgTQXTo68ooFkp6XhPP1JBfhh+45d3MbQDIq4O+uJrMFw6eFQC43rexyoVHZkESeRoWsAWXogI4hWE+SlV8wAsvnDGemO53AClT2Mu2IM4edHyjy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710000836; c=relaxed/simple;
	bh=aw5/Q+b3HlUcOKz7avQB1o344XdTS8xLwx9BG7g5m1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MN8mek0y6FLzHZa0sphpvUT9ElaNnG+oTTmmIT/fHKuzW60cWqV6j3JZvOvrBveJtW6QATvDXlnW4lXeF2GaMscALHQ0N4U2rsX8p3vcX3KaRHzuNMqS7Zj1+yXen+O/IBd5R7WQx4pMTzAR5PQdfObyQzWh6mN2vb9E/kj8czU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=jMjPXz7O; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=Bl+PEwTp; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 23EE2601A1;
	Sat,  9 Mar 2024 17:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710000827; bh=aw5/Q+b3HlUcOKz7avQB1o344XdTS8xLwx9BG7g5m1o=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=jMjPXz7ONc0j/+wyxLp658+dsf34gBxfmoeke7bY76N+za1yrJ4B49BaxJ7gB1Bi8
	 tyo7TrdACJUp+PYQoQvpI82vfTLfIRXvorQkZW9enaoyIfNNq3Clk8PMg6a3R/bHY0
	 4MzlD1fpQDYlUk0cyyNotDJWAcsFBZUP4QufIo5VKMpRLxbuZSN3GhgKLqiKzMYwCM
	 jEFcAOLCtrAY6/JjawdVkrduzjo6g7n8Z7cDCHysi2FC2SkgGhd1PisbrpA5BEIt6/
	 jV/AwwCYjNQ57Oeg0PXhpiW9YKH5zN3X20Ed6J1mo82Po5HyimOHCgc+iwRhSAFlGM
	 2g49PQB3NOwBw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvc4ZIJd7mYI; Sat,  9 Mar 2024 17:13:44 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-27.xnet.hr [88.207.40.27])
	by domac.alu.hr (Postfix) with ESMTPSA id F0D7C60189;
	Sat,  9 Mar 2024 17:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710000824; bh=aw5/Q+b3HlUcOKz7avQB1o344XdTS8xLwx9BG7g5m1o=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=Bl+PEwTpC1wcKzyB51m5oINdVWx3yqKrq6+SrBYrD4tOE1fkEWu8xSoymv4CCgGHj
	 I2LHWM09Gr4g+/RnaSt46KBiHctraMcoBIbSxPLivRWIzMDGYR0ESdWIy32SDLHmjv
	 5M16dXoC8a8tLh/XaA9EpKvmMq/Qn2mLyuc3HO1OTWZbq2h5oFKrFMv6qPUNSkA8X7
	 gNW2EqLHmYvYiQtHQL4yvwZZ8z7WNRtRlJzGSizGwtdJYAl408pMbjKLurfVAl6GzF
	 4YW3eLxNLeDD00ibyo3uFWwQULnzolp1f6VBCXFduZ2Mdz62MdDv5KaCj76t2IU0G5
	 gyx6UQHGR7bjQ==
Message-ID: <d9a3eb80-abaa-4453-a1ec-cc1200c58481@alu.unizg.hr>
Date: Sat, 9 Mar 2024 17:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KCSAN: data-race in tick_nohz_idle_stop_tick /
 tick_nohz_next_event
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
 <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
 <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Sean,

I am reducing Cc: so if you could please attach the decode_stacktrace.sh output of your build.

Thanks,
Mirsad

On 3/7/24 20:43, Sean Anderson wrote:
> On 8/18/23 10:15, Mirsad Todorovac wrote:
>>
>>
>> On 8/17/23 21:32, Mirsad Todorovac wrote:
>>> Hi,
>>>
>>> This is your friendly bug reporter. :-)
>>>
>>> The environment is the vanilla torvalds kernel on Ubuntu 22.04 LTS and a Ryzen 7950X assembled box.
>>>
>>> [ 7145.500079] ==================================================================
>>> [ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event
>>>
>>> [ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:
>>> [ 7145.500155]  tick_nohz_idle_stop_tick+0x3b1/0x4a0
>>> [ 7145.500173]  do_idle+0x1e3/0x250
>>> [ 7145.500186]  cpu_startup_entry+0x20/0x30
>>> [ 7145.500199]  start_secondary+0x129/0x160
>>> [ 7145.500216]  secondary_startup_64_no_verify+0x17e/0x18b
>>>
>>> [ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:
>>> [ 7145.500261]  tick_nohz_next_event+0xe7/0x1e0
>>> [ 7145.500277]  tick_nohz_get_sleep_length+0xa7/0xe0
>>> [ 7145.500293]  menu_select+0x82/0xb90
>>> [ 7145.500309]  cpuidle_select+0x44/0x60
>>> [ 7145.500324]  do_idle+0x1c2/0x250
>>> [ 7145.500336]  cpu_startup_entry+0x20/0x30
>>> [ 7145.500350]  start_secondary+0x129/0x160
>>> [ 7145.500367]  secondary_startup_64_no_verify+0x17e/0x18b
>>>
>>> [ 7145.500392] value changed: 0x0000001a -> 0xffffffff
>>>
>>> [ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
>>> [ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
>>> [ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>> [ 7145.500449] ==================================================================
>>>
>>> Please find dmesg log (what was available in the ring buffer) and the lshw output attached.
>>>
>>> NOTE: There are no proprietary drivers loaded and Canonical livepatch isn't working for this kernel,
>>> probably previous ACPI KCSAN BUGs turn this taint on.
>>>
>>> Thank you very much for your time evaluating this report.
>>
>> P.S.
>>
>> According to Mr. Heo, I will add the decoded stacktrace to this bug report, which ought to have been done
>> in the first place :-/
>>
>> [ 7145.500079] ==================================================================
>> [ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event
>>
>> [ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:
>> [ 7145.500155] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:904 kernel/time/tick-sched.c:1130)
>> [ 7145.500173] do_idle (kernel/sched/idle.c:215 kernel/sched/idle.c:282)
>> [ 7145.500186] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>> [ 7145.500199] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>> [ 7145.500216] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)
>>
>> [ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:
>> [ 7145.500261] tick_nohz_next_event (kernel/time/tick-sched.c:868)
>> [ 7145.500277] tick_nohz_get_sleep_length (kernel/time/tick-sched.c:1250)
>> [ 7145.500293] menu_select (drivers/cpuidle/governors/menu.c:283)
>> [ 7145.500309] cpuidle_select (drivers/cpuidle/cpuidle.c:359)
>> [ 7145.500324] do_idle (kernel/sched/idle.c:208 kernel/sched/idle.c:282)
>> [ 7145.500336] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>> [ 7145.500350] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>> [ 7145.500367] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)
>>
>> [ 7145.500392] value changed: 0x0000001a -> 0xffffffff
>>
>> [ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
>> [ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
>> [ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 7145.500449] ==================================================================
>>
>> The code seems to be:
>>
>>
>>      /*
>>       * If this CPU is the one which updates jiffies, then give up
>>       * the assignment and let it be taken by the CPU which runs
>>       * the tick timer next, which might be this CPU as well. If we
>>       * don't drop this here the jiffies might be stale and
>>       * do_timer() never invoked. Keep track of the fact that it
>>       * was the one which had the do_timer() duty last.
>>       */
>>      if (cpu == tick_do_timer_cpu) {
>>          tick_do_timer_cpu = TICK_DO_TIMER_NONE;
>> →        ts->do_timer_last = 1;
>>      } else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
>>          ts->do_timer_last = 0;
>>
>>      }
>>
>> but I am not sure why this happens.
>>
>> Maybe a WRITE_ONCE(ts->do_timer_last, 1) is required?
>>
>> Or is it another KCSAN false positive ...
> 
> I have seen a few more KCSAN reports regarding this variable:
> 
> [  153.285199] ==================================================================
> [  153.292529] BUG: KCSAN: data-race in tick_nohz_next_event+0x15c/0x29c
> [  153.299118]
> [  153.300685] race at unknown origin, with read to 0xffffffc082aa1048 of 4 bytes by task 0 on cpu 2:
> [  153.309760]  tick_nohz_next_event+0x15c/0x29c
> [  153.314256]  tick_nohz_get_sleep_length+0xd8/0x118
> [  153.319186]  menu_select+0x1e0/0xc08
> [  153.322875]  cpuidle_select+0x4c/0x60
> [  153.326686]  do_idle+0x1e0/0x2b4
> [  153.330062]  cpu_startup_entry+0x34/0x3c
> [  153.334133]  secondary_start_kernel+0x1e8/0x21c
> [  153.338821]  __secondary_switched+0xb8/0xbc
> [  153.343143]
> [  153.344706] no locks held by swapper/2/0.
> [  153.348802] irq event stamp: 129586
> [  153.352370] hardirqs last  enabled at (129585): [<ffffffc081acaa2c>] el1_interrupt+0x40/0x50
> [  153.360964] hardirqs last disabled at (129586): [<ffffffc0800d8fec>] do_idle+0xc8/0x2b4
> [  153.369132] softirqs last  enabled at (129560): [<ffffffc08001071c>] __do_softirq+0x47c/0x500
> [  153.377786] softirqs last disabled at (129549): [<ffffffc080017134>] ____do_softirq+0x10/0x1c
> [  153.386457]
> [  153.388019] value changed: 0xffffffff -> 0x00000001
> [  153.392993]
> [  153.394555] Reported by Kernel Concurrency Sanitizer on:
> [  153.399947] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.6.20+ #102
> [  153.406595] Hardware name: xlnx,zynqmp (DT)
> [  153.410866] ==================================================================
> 
> and:
> 
> [   75.362055] ==================================================================
> [   75.369461] BUG: KCSAN: data-race in tick_sched_do_timer / tick_sched_do_timer
> [   75.376854]
> [   75.378426] write to 0xffffffc082aa1048 of 4 bytes by interrupt on cpu 1:
> [   75.385335]  tick_sched_do_timer+0x124/0x168
> [   75.389744]  tick_sched_timer+0x48/0xc8
> [   75.393720]  __hrtimer_run_queues+0x200/0x5f0
> [   75.398198]  hrtimer_interrupt+0x1b0/0x3f4
> [   75.402417]  arch_timer_handler_phys+0x40/0x54
> [   75.406983]  handle_percpu_devid_irq+0xf8/0x20c
> [   75.411679]  generic_handle_domain_irq+0x48/0x64
> [   75.416435]  gic_handle_irq+0xc4/0x100
> [   75.420298]  call_on_irq_stack+0x24/0x4c
> [   75.424360]  do_interrupt_handler+0xc0/0xc4
> [   75.428692]  el1_interrupt+0x34/0x50
> [   75.432415]  el1h_64_irq_handler+0x18/0x24
> [   75.436668]  el1h_64_irq+0x64/0x68
> [   75.440184]  percpu_counter_add_batch+0xd8/0x1b8
> [   75.444967]  set_pte_range+0x14c/0x2c8
> [   75.448838]  filemap_map_pages+0x2dc/0xa38
> [   75.453091]  __handle_mm_fault+0x1304/0x17dc
> [   75.457492]  handle_mm_fault+0xa0/0x374
> [   75.461450]  do_page_fault+0x1f8/0x620
> [   75.465365]  do_translation_fault+0x118/0x138
> [   75.469887]  do_mem_abort+0x5c/0xe4
> [   75.473516]  el0_da+0x5c/0xac
> [   75.476623]  el0t_64_sync_handler+0xe4/0x158
> [   75.481050]  el0t_64_sync+0x190/0x194
> [   75.484834]
> [   75.486405] 5 locks held by (d-logind)/293:
> [   75.490693]  #0: ffffff88076753c0 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x15c/0x5c0
> [   75.500441]  #1: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: __handle_mm_fault+0x1260/0x17dc
> [   75.509755]  #2: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: filemap_map_pages+0x0/0xa38
> [   75.518748]  #3: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: __pte_offset_map+0x0/0x2a0
> [   75.527662]  #4: ffffff880762b018 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: __pte_offset_map_lock+0xa4/0x264
> [   75.537488] irq event stamp: 1761
> [   75.540890] hardirqs last  enabled at (1760): [<ffffffc080bc1f78>] percpu_counter_add_batch+0x160/0x1b8
> [   75.550465] hardirqs last disabled at (1761): [<ffffffc081aca990>] el1_interrupt+0x24/0x50
> [   75.558893] softirqs last  enabled at (1534): [<ffffffc08001071c>] __do_softirq+0x47c/0x500
> [   75.567382] softirqs last disabled at (1529): [<ffffffc080017134>] ____do_softirq+0x10/0x1c
> [   75.575889]
> [   75.577460] read to 0xffffffc082aa1048 of 4 bytes by interrupt on cpu 2:
> [   75.584273]  tick_sched_do_timer+0x48/0x168
> [   75.588596]  tick_sched_timer+0x48/0xc8
> [   75.592572]  __hrtimer_run_queues+0x200/0x5f0
> [   75.597050]  hrtimer_interrupt+0x1b0/0x3f4
> [   75.601269]  arch_timer_handler_phys+0x40/0x54
> [   75.605835]  handle_percpu_devid_irq+0xf8/0x20c
> [   75.610531]  generic_handle_domain_irq+0x48/0x64
> [   75.615287]  gic_handle_irq+0xc4/0x100
> [   75.619150]  call_on_irq_stack+0x24/0x4c
> [   75.623204]  do_interrupt_handler+0xc0/0xc4
> [   75.627535]  el1_interrupt+0x34/0x50
> [   75.631258]  el1h_64_irq_handler+0x18/0x24
> [   75.635512]  el1h_64_irq+0x64/0x68
> [   75.639027]  lock_acquire+0x13c/0x2f0
> [   75.642820]  count_memcg_event_mm.part.0+0x70/0x2a8
> [   75.647829]  handle_mm_fault+0x1d8/0x374
> [   75.651874]  do_page_fault+0x1f8/0x620
> [   75.655789]  do_mem_abort+0x5c/0xe4
> [   75.659417]  el0_da+0x5c/0xac
> [   75.662524]  el0t_64_sync_handler+0xe4/0x158
> [   75.666951]  el0t_64_sync+0x190/0x194
> [   75.670736]
> [   75.672307] 2 locks held by systemd/1:
> [   75.676152]  #0: ffffff88042627b0 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x15c/0x5c0
> [   75.685900]  #1: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: count_memcg_event_mm.part.0+0x0/0x2a8
> [   75.695726] irq event stamp: 576347
> [   75.699302] hardirqs last  enabled at (576346): [<ffffffc08001af70>] local_daif_restore+0x38/0x54
> [   75.708338] hardirqs last disabled at (576347): [<ffffffc081aca990>] el1_interrupt+0x24/0x50
> [   75.716940] softirqs last  enabled at (576161): [<ffffffc08001071c>] __do_softirq+0x47c/0x500
> [   75.725602] softirqs last disabled at (576154): [<ffffffc080017134>] ____do_softirq+0x10/0x1c
> [   75.734283]
> [   75.735854] value changed: 0xffffffff -> 0x00000000
> [   75.740836]
> [   75.742407] Reported by Kernel Concurrency Sanitizer on:
> [   75.747808] CPU: 2 PID: 1 Comm: systemd Not tainted 6.6.20+ #101
> [   75.754290] Hardware name: xlnx,zynqmp (DT)
> [   75.758563] ==================================================================
> 
> The justification seems to be in tick_sched_do_timer:
> 
>          /*
>           * Check if the do_timer duty was dropped. We don't care about
>           * concurrency: This happens only when the CPU in charge went
>           * into a long sleep. If two CPUs happen to assign themselves to
>           * this duty, then the jiffies update is still serialized by
>           * jiffies_lock.
>           *
>           * If nohz_full is enabled, this should not happen because the
>           * tick_do_timer_cpu never relinquishes.
>           */
> 
> with the other assignment being in tick_nohz_stop_tick. I'm not familiar
> enough with this code to say whether we should be using READ/WRITE_ONCE
> or maybe just data_race (as would be implied by the comment above).
> 
> --Sean
> 
> [Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embeddedworld2024/Register/ew24517689>

