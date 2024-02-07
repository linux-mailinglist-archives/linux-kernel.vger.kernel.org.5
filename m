Return-Path: <linux-kernel+bounces-56009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BA84C4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4A91C25252
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9C1CF92;
	Wed,  7 Feb 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k/ztEph/"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408E1CF8F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286748; cv=none; b=CGVEUJiv6qfmK4po4shFl838egusbELlX5z+yafZpgRJt0DeeFY3FWd2N2U+z9S1yXbdOukhh86p7REHxvbK7ETpFAjU4XUTebZjI5rJJ4DcQVC9pit82/PF+48N7YaEGqebj17ycPuFuSg5VU2zFQcMC0RZnNRE8li7N5FAt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286748; c=relaxed/simple;
	bh=1/AQclZkTBwnWskj4hpXdDUUVrD3fqJx9B8yDD0azTo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p3MwY/0yJw9cBQPv0+nz7L9XL4+aseJIubAS/LCaYeRCRB8ad0WoY2wo4kIx4Vjg73kqxQyOjnDGNXkLdY3SL0R68ZW+P3N/y5iLuFcFmCkeDevyFD3lpaO1M873ygjFcSpoC6psMEOxS30Cfqyz3jcVpIDtpXzdqBakgYDGHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k/ztEph/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707286737; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=fC/H3lqLg8hEunhJyS9PBEKEexaf3jBnyj8OrzaHWaU=;
	b=k/ztEph/8SZlQnkS1s1kOmjLLB7jupqj8Q0PkpnFaGSRwUSetI0Hykk3A+eRnTiTHxxqaCd5UWqSaLoXcvxjZCUrl8THq1o23GaOktzI5clEEUNZ9aoa2kuhWuY7y2CArLjq0nfi0+eVEusk1c4GpBHe5kLKtNNpBPy9g+n6Umw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0FmdVg_1707286720;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0FmdVg_1707286720)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 14:18:57 +0800
Message-ID: <8cf08d4a-fa4b-41cb-8bfa-75387122b194@linux.alibaba.com>
Date: Wed, 7 Feb 2024 14:18:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv5 2/3] watchdog/softlockup: report the most frequent
 interrupts
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
 <20240206095902.56406-3-yaoma@linux.alibaba.com>
 <CAD=FV=V8VcmEDDpaWZi40j5dkP+HyBPFr=D_mKFG-YmXTpa_AA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=V8VcmEDDpaWZi40j5dkP+HyBPFr=D_mKFG-YmXTpa_AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2024/2/7 05:42, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 6, 2024 at 1:59 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 71d5b6dfa358..26dc1ad86276 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -18,6 +18,9 @@
>>   #include <linux/init.h>
>>   #include <linux/kernel_stat.h>
>>   #include <linux/math64.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdesc.h>
>> +#include <linux/bitops.h>
> 
> These are still not sorted alphabetically. "irq.h" and "irqdesc.h"
> should go between "init.h" and "kernel_stat.h". "bitops.h" is trickier
> because the existing headers are not quite sorted. Probably the best
> would be to fully sort them. They should end up like this:
> 
> #include <linux/bitops.h>
> #include <linux/cpu.h>
> #include <linux/init.h>
> #include <linux/irq.h>
> #include <linux/irqdesc.h>
> #include <linux/kernel_stat.h>
> #include <linux/kvm_para.h>
> #include <linux/math64.h>
> #include <linux/mm.h>
> #include <linux/module.h>
> #include <linux/nmi.h>
> #include <linux/stop_machine.h>
> #include <linux/sysctl.h>
> #include <linux/tick.h>
> 
> #include <linux/sched/clock.h>
> #include <linux/sched/debug.h>
> #include <linux/sched/isolation.h>
> 
> #include <asm/irq_regs.h>
>
Sorry, I misunderstood your point, thinking that they should only be
added between "init.h" and "module.h". I will arrange them in the
alphabetical order as you suggested.

> 
>> +static void start_counting_irqs(void)
>> +{
>> +       int i;
>> +       struct irq_desc *desc;
>> +       u32 *counts = __this_cpu_read(hardirq_counts);
>> +       int cpu = smp_processor_id();
>> +
>> +       if (!test_bit(cpu, softlockup_hardirq_cpus)) {
> 
> I don't think you need "softlockup_hardirq_cpus", do you? Just read
> "actual_nr_irqs" and see if it's non-zero? ...or read "hardirq_counts"
> and see if it's non-NULL?
Sure, the existing variables are sufficient for making a determination.
And may be I should swap it to make the decision logic here clearer,
like this (untested)?

bool is_counting_started(void)
{
     return !!__this_cpu_read(hardirq_counts);
}

if (!is_counting_started()) {
> 
> 
>> +               /*
>> +                * nr_irqs has the potential to grow at runtime. We should read
>> +                * it and store locally to avoid array out-of-bounds access.
>> +                */
>> +               __this_cpu_write(actual_nr_irqs, nr_irqs);
> 
> nit: IMO store nr_irqs in a local variable to avoid all of the
> "__this_cpu_read" calls everywhere. Then just write it once from your
> local variable.
OK.
> 
> 
>> +               counts = kmalloc_array(__this_cpu_read(actual_nr_irqs),
>> +                                      sizeof(u32),
>> +                                      GFP_ATOMIC);
> 
> should use "kcalloc()" so the array is zeroed. That way if the set of
> non-NULL "desc"s changes between calls you don't end up reading
> uninitialized memory.
OK, I will use "kcalloc()" here.
> 
> 
>> +static void stop_counting_irqs(void)
>> +{
>> +       u32 *counts = __this_cpu_read(hardirq_counts);
>> +       int cpu = smp_processor_id();
>> +
>> +       if (test_bit(cpu, softlockup_hardirq_cpus)) {
>> +               kfree(counts);
>> +               counts = NULL;
>> +               __this_cpu_write(hardirq_counts, counts);
> 
> nit: don't really need to set the local "counts" to NULL. Just:
> 
> __this_cpu_write(hardirq_counts, NULL);
> 
> ...and actually if you take my advice above and get rid of
> "softlockup_hardirq_cpus" then this function just becomes:
> 
>    kfree(__this_cpu_read(hardirq_counts));
>    __this_cpu_write(hardirq_counts, NULL);
> 
> Since kfree() handles when you pass it NULL...
OK.
> 
> 
>> +static void print_irq_counts(void)
>> +{
>> +       int i;
>> +       struct irq_desc *desc;
>> +       u32 counts_diff;
>> +       u32 *counts = __this_cpu_read(hardirq_counts);
>> +       int cpu = smp_processor_id();
>> +       struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
>> +               {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
>> +       };
>> +
>> +       if (test_bit(cpu, softlockup_hardirq_cpus)) {
>> +               for_each_irq_desc(i, desc) {
>> +                       if (!desc)
>> +                               continue;
> 
> The "if" test above isn't needed. The "for_each_irq_desc()" macro
> already checks for NULL.
Thanks for your reminder.
> 
> 
> 
>> +                       /*
>> +                        * We need to bounds-check in case someone on a different CPU
>> +                        * expanded nr_irqs.
>> +                        */
>> +                       if (i < __this_cpu_read(actual_nr_irqs))
>> +                               counts_diff = desc->kstat_irqs ?
>> +                                       *this_cpu_ptr(desc->kstat_irqs) - counts[i] : 0;
>> +                       else
>> +                               counts_diff = desc->kstat_irqs ?
>> +                                       *this_cpu_ptr(desc->kstat_irqs) : 0;
> 
> Why do you need to test "kstat_irqs" for 0?
Although "alloc_desc" wil allocate both "desc" and "kstat_irqs" at the
same time, I refer to the usage of "kstat_irqs" in "show_interrupts"
from kernel/irq/proc.c, where it does perform a check.

kernel/irq/proc.c: show_interrupts
for_each_online_cpu(j)
	seq_printf(p, "%10u ", desc->kstat_irqs ?
				*per_cpu_ptr(desc->kstat_irqs, j) : 0);

I'm not sure why this is necessary, so I copied it as it is. Can we skip
the check in "print_irq_counts"?

> duplicate the math. In other words, I'd expect this (untested):
> 
> if (i < __this_cpu_read(actual_nr_irqs))
>    count = counts[i];
> else
>    count = 0;
> counts_diff = *this_cpu_ptr(desc->kstat_irqs) - count;
Agree.
> 
> I guess I'd also put "__this_cpu_read(actual_nr_irqs)" in a local
> variable like you do with counts...

