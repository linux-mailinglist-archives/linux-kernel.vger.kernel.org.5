Return-Path: <linux-kernel+bounces-49937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF0B8471C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0541FB27B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27E14532F;
	Fri,  2 Feb 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NKR46xS+"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524F47A4D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883741; cv=none; b=OLMn3hkdiVG4vG9B8ndiTGbMOU4RV/QZaL/oLh9zOSA7hmyRzzAVy6pOR1/J380u9RYAqFoowx/jmE0B1X9IzaI+OQk3GLhNq1ovgtdHWvWJyfVOlA0HkTIlZjEyBdz/P12c6gzmhnjjlwG3XDMN+/CC8UN9WmOc0immrLE6EEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883741; c=relaxed/simple;
	bh=Rn9OKHYXdOkJ8S1y8BqT2KIPFZk/xuthtVZ8C2oB+uI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XwykBigr8eRyPaWzSjhTSGzS9shiUjyHLfKhCe1FW7o8I3KSzbz1AG7SoMJ3G1io3rKbacMSB10Gmbc3BFYZeJdYIUIMm44LKLrG+j/QJI9STxsmAZzvddayY0RV0lOlNzadm2FZ265DZ/PTuBqjbbM/Sq4Fp4HirONzXHChAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NKR46xS+; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706883735; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ImJKYxbYrZPinNViYS8d/TYXoRcgnCItpuy4rGR7XGg=;
	b=NKR46xS+rWNigZSTuFSL7ec0gfXJtIbSz57rCs/7mYci0+XzrIkb9zr/JwS2aoPXYuT5TjKVK77XKeBjQyXdZWR/0cHToe1a066bB0QSb6pOVCtxyVtAaQPRo+mcFXDXTjLEDjkkwTE3gU7tJqkCrny0hhQBXwOaBULkWL4Cl3k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.xEuEV_1706883733;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.xEuEV_1706883733)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 22:22:14 +0800
Message-ID: <8d350eb8-09e6-42cf-b664-442db2ac7801@linux.alibaba.com>
Date: Fri, 2 Feb 2024 22:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv3 2/2] watchdog/softlockup: report the most frequent
 interrupts
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240131171738.35496-1-yaoma@linux.alibaba.com>
 <20240131171738.35496-3-yaoma@linux.alibaba.com>
 <CAD=FV=XFWjkvuJmeJjb_OLCPJOtshmr=1A66R_WukHv4FEXr8Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=XFWjkvuJmeJjb_OLCPJOtshmr=1A66R_WukHv4FEXr8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/1 10:23, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jan 31, 2024 at 9:17 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> When the watchdog determines that the current soft lockup is due
>> to an interrupt storm based on CPU utilization, reporting the
>> most frequent interrupts could be good enough for further
>> troubleshooting.
>>
>> Below is an example of interrupt storm. The call tree does not
>> provide useful information, but we can analyze which interrupt
>> caused the soft lockup by comparing the counts of interrupts.
>>
>> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
>> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
>> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
>> [ 2987.491493]  #1: 330985      irq#7(IPI)
>> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
>> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
>> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
>> ...
>> [ 2987.492728] Call trace:
>> [ 2987.492729]  __do_softirq+0xa8/0x364
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 046507be4eb5..c4c25f25eae7 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -25,6 +25,9 @@
>>   #include <linux/stop_machine.h>
>>   #include <linux/kernel_stat.h>
>>   #include <linux/math64.h>
>> +#include <linux/irq.h>
>> +#include <linux/bitops.h>
>> +#include <linux/irqdesc.h>
> 
> Like in patch #1, don't just jam headers at the end. Put them in a
> sensible order.
Sure, I will standardize the code.
> 
> 
> 
>>   #include <asm/irq_regs.h>
>>   #include <linux/kvm_para.h>
>> @@ -431,11 +434,15 @@ void touch_softlockup_watchdog_sync(void)
>>          __this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
>>   }
>>
>> +static void set_potential_softlockup(unsigned long now, unsigned long touch_ts);
>> +
>>   static int is_softlockup(unsigned long touch_ts,
>>                           unsigned long period_ts,
>>                           unsigned long now)
>>   {
>>          if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
>> +               /* Softlockup may occur in the current period */
>> +               set_potential_softlockup(now, period_ts);
> 
> Something is really confusing to me about the
> set_potential_softlockup() and set_potential_softlockup_hardirq()
> functions and the comment above this line doesn't help me. From the
> comment and the name of the function it sounds like at this point in
> the code you've already determined that a softlockup is likely. ...but
> I don't think that's the case. At this point in the code all we know
> is that the softlockup detector is running, right?
> 
> I guess the first thing that would help would be to just get rid of
> the set_potential_softlockup() wrapper and just inline here:
> 
> if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
>    set_potential_softlockup_hardirq();
> 
> ...but then I'd want a comment explaining what that "if" test means.
> Maybe something like this (assuming it's correct):
> 
> The "sample_period" is set so that we should get called ~5 times
> between the start of the softlockup and when it is detected /
> reported. If we've already been called twice and it looks like a
> softlockup might be occurring, start counting interrupts.
> 
> Also: assuming I understand correctly, won't your "time_after_eq()"
> always be true as you've written it? Shouldn't it be something like:
> 
> if (time_after_eq(now, period_ts + 2 * get_softlockup_thresh() / 5))
> 
> ...or maybe you don't need this "if" test at all since you're using
> "need_record_irq_counts(STATS_HARDIRQ)" here. IMO that should be
> pulled out here as well since it makes it more obvious...
I agree with your this suggestion here. It is easier to understand:

if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
   set_potential_softlockup_hardirq();

Please let me explain the criteria for the judgment here. Under normal
circumstances, "softlockup_fn" will be woken up every "sample_period" to
update "period_ts", and the "time_after_eq" I written will be false. If
"period_ts" has not been updated after a "sample_period" has passed,
then the "time_after_eq" will be true. And I suspect that in the 
subsequent few "sample_period", "period_ts" might also not be updated,
which could indicate a potential softlockup. At this point, I use
"need_record_irq_counts" to determine if this phenomenon is caused by an
interrupt storm.

To summarize, my condition to start counting interrupts is that
"period_ts" has not been updated during "sample_period" AND the 
proportion of hardirq time during "sample_period" exceeds 50%.

What do you think?

By the way, The reason for having both set_potential_softlockup() and
set_potential_softlockup_hardirq() is that I once wrote a
set_potential_softlockup_softirq() for starting counting softirqs.
However, I found it might not very meaningful and removed it. I will
follow your suggestion and make improvements to make this area more
understandable.
> 
> 
> 
>>                  /* Warn about unreasonable delays. */
>>                  if (time_after(now, period_ts + get_softlockup_thresh()))
>>                          return now - touch_ts;
>> @@ -462,6 +469,8 @@ static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
>>   static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
>>   static DEFINE_PER_CPU(u8, cpustat_tail);
>>
>> +static void print_hardirq_counts(void);
>> +
> 
> Rather than predeclaring, can't you just put the functions here?
> 
> 
>>   /*
>>    * We don't need nanosecond resolution. A granularity of 16ms is
>>    * sufficient for our precision, allowing us to use u16 to store
>> @@ -516,10 +525,156 @@ static void print_cpustat(void)
>>                          __this_cpu_read(cpustat_utilization[i][STATS_HARDIRQ]),
>>                          __this_cpu_read(cpustat_utilization[i][STATS_IDLE]));
>>          }
>> +       print_hardirq_counts();
>> +}
>> +
>> +#define HARDIRQ_PERCENT_THRESH         50
>> +#define NUM_HARDIRQ_REPORT             5
>> +static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
>> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
>> +
>> +struct irq_counts {
>> +       int irq;
>> +       u32 counts;
>> +};
>> +
>> +static void find_counts_top(struct irq_counts *irq_counts, int irq, u32 counts, int range)
> 
> nit: it's not really "finding" anything. Maybe "tabulate_irq_count" or
> something?
Agree, I will rename it.
> 
> 
>> +{
>> +       unsigned int i, j;
>> +
>> +       for (i = 0; i < range; i++) {
>> +               if (counts > irq_counts[i].counts) {
>> +                       for (j = range - 1; j > i; j--) {
>> +                               irq_counts[j].counts = irq_counts[j - 1].counts;
>> +                               irq_counts[j].irq = irq_counts[j - 1].irq;
>> +                       }
>> +                       irq_counts[j].counts = counts;
>> +                       irq_counts[j].irq = irq;
>> +                       break;
>> +               }
>> +       }
> 
> Rather than a double loop, can't you just swap? Untested:
> 
>    unsigned int i;
>    struct irq_counts new_count = { irq, counts };
> 
>    for (i = 0; i < range; i++) {
>      if (count > irq_counts[i].counts)
>        swap(new_count, irq_counts[i])
>    }
I will try it.
> 
> 
>> +}
>> +
>> +/*
>> + * If the proportion of time spent handling irq exceeds HARDIRQ_PERCENT_THRESH%
>> + * during sample_period, then it is necessary to record the counts of each irq.
>> + */
>> +static inline bool need_record_irq_counts(int type)
> 
> Let the compiler decide if this should be inline. No need for the
> forced "inline" keyword.
OK.
> 
> Also: why do you need to pass in the "type". This function only makes
> sense for "STATS_HARDIRQ
As previously mentioned, I had considered counting softirqs. I will 
refactor 'need_record_irq_counts'.

> 
> 
>> +{
>> +       int tail = __this_cpu_read(cpustat_tail);
>> +       u8 utilization;
>> +
>> +       if (--tail == -1)
>> +               tail = 4;
> 
> Instead of the above:
> 
> tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
Agree, I will follow your suggestion.
> 
> 
>> +       utilization = __this_cpu_read(cpustat_utilization[tail][type]);
>> +       return utilization > HARDIRQ_PERCENT_THRESH;
>> +}
>> +
>> +/*
>> + * Mark softlockup as potentially caused by hardirq
>> + */
>> +static void set_potential_softlockup_hardirq(void)
>> +{
>> +       u32 i;
>> +       u32 *counts = __this_cpu_read(hardirq_counts);
>> +       int cpu = smp_processor_id();
>> +       struct irq_desc *desc;
>> +
>> +       if (!need_record_irq_counts(STATS_HARDIRQ))
>> +               return;
>> +
>> +       if (!test_bit(cpu, softlockup_hardirq_cpus)) {
>> +               counts = kmalloc_array(nr_irqs, sizeof(u32), GFP_ATOMIC);
> 
> I think "nr_irqs" has the potential to grow at runtime, right? That
> means you should read it and store locally how big your array actually
> is. Otherwise you could allocate enough space for 64 IRQs, someone
> could grow nr_irqs, and you could try looping over 128. Presumably
> when you loop over with "for_each_irq_desc" you'd also need to
> bounds-check in case someone on a different CPU expanded the number
> after you read it...
Oh, I assumed that "nr_irqs" would remain constant at runtime, but I 
will consider scenarios where it might grow.

> 
> 
> -Doug

