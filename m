Return-Path: <linux-kernel+bounces-46844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29301844544
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E49D1C22C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA812C54B;
	Wed, 31 Jan 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fxPEA0HQ"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53C5DF0D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720059; cv=none; b=isX+cREV/667Uf5mGr17+n1kn+iGLogcgjni/lBgk+vYfPN/+bsFn/dG1IGuFNGQWO4O1R7buZDMs3M9ymLQntZphuJ7C5s3IGUI6XGXdl4vTo6gfVZE4EKdbejkpVV8AJH6960HtT3+FolMWAAPa2/JESQjrHHgR0zKuhizKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720059; c=relaxed/simple;
	bh=rzC5us6/9zOhFEQXoGh+xjbquBdsxx9lSCK+YE2R3oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVdnAxvE6SkOnH31bXL9hs1dEvyDvfrZZUmlHT7u9jJNFyQ7zB0V5eTAeJZ6fWVhwBfdi4t2d3dIZtdau0JNiM5+F6acfEgAgN6mBT68rrV5pw1/TJ4D6rD8HPZ3xAPZlLYVEYeAZDwNze5zL5eVcwv2GbJ/2hV1txUWv6Xbhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fxPEA0HQ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706720053; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FMEHeKt+c9du1Xp83MFbzYoLO9YQlm9re4bakqdSx/A=;
	b=fxPEA0HQZpKWeIFmSKITxAgr5gXY00ewRF92hZiVzzRJkHZ+DZSUSoPvoBhQg6dG3Ze3SeZZl6vBvgE0b7hcpbrDg7wzdFvHoOrO+8IuI+LbOShXjy8/EMBEBEu2/MgcYmlDeB+MkdxCTfMpKpCdFsSD0Iul6SXI6tR5LP8OrZY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.k7P.i_1706720051;
Received: from 30.39.213.32(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.k7P.i_1706720051)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 00:54:13 +0800
Message-ID: <c3eff3df-f891-4c01-8c76-29ad92914327@linux.alibaba.com>
Date: Thu, 1 Feb 2024 00:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] watchdog/softlockup: report the most frequent
 interrupts
Content-Language: en-US
To: dianders@chromium.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org, yaoma@linux.alibaba.com
References: <20240131164516.34139-1-yaoma@linux.alibaba.com>
 <20240131164516.34139-3-yaoma@linux.alibaba.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <20240131164516.34139-3-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The version is wrong, please ignore this.

Best regards,

Bitao Hu

On 2024/2/1 00:45, Bitao Hu wrote:
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
> 
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
> 
> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
> [ 2987.491493]  #1: 330985      irq#7(IPI)
> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
> ...
> [ 2987.492728] Call trace:
> [ 2987.492729]  __do_softirq+0xa8/0x364
> 
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   kernel/watchdog.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 154 insertions(+)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 046507be4eb5..6841ecdc3053 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -25,6 +25,9 @@
>   #include <linux/stop_machine.h>
>   #include <linux/kernel_stat.h>
>   #include <linux/math64.h>
> +#include <linux/irq.h>
> +#include <linux/bitops.h>
> +#include <linux/irqdesc.h>
>   
>   #include <asm/irq_regs.h>
>   #include <linux/kvm_para.h>
> @@ -431,11 +434,15 @@ void touch_softlockup_watchdog_sync(void)
>   	__this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
>   }
>   
> +static void set_potential_softlockup(unsigned long now, unsigned long touch_ts);
> +
>   static int is_softlockup(unsigned long touch_ts,
>   			 unsigned long period_ts,
>   			 unsigned long now)
>   {
>   	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
> +		/* Softlockup may occur in the current period */
> +		set_potential_softlockup(now, period_ts);
>   		/* Warn about unreasonable delays. */
>   		if (time_after(now, period_ts + get_softlockup_thresh()))
>   			return now - touch_ts;
> @@ -462,6 +469,8 @@ static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
>   static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
>   static DEFINE_PER_CPU(u8, cpustat_tail);
>   
> +static void print_hardirq_counts(void);
> +
>   /*
>    * We don't need nanosecond resolution. A granularity of 16ms is
>    * sufficient for our precision, allowing us to use u16 to store
> @@ -516,7 +525,151 @@ static void print_cpustat(void)
>   			__this_cpu_read(cpustat_utilization[i][STATS_HARDIRQ]),
>   			__this_cpu_read(cpustat_utilization[i][STATS_IDLE]));
>   	}
> +	print_hardirq_counts();
> +}
> +
> +#define HARDIRQ_PERCENT_THRESH		50
> +#define NUM_HARDIRQ_REPORT		5
> +static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
> +
> +struct irq_counts {
> +	int irq;
> +	u32 counts;
> +};
> +
> +static void find_counts_top(struct irq_counts *irq_counts, int irq, u32 counts, int range)
> +{
> +	unsigned int i, j;
> +
> +	for (i = 0; i < range; i++) {
> +		if (counts > irq_counts[i].counts) {
> +			for (j = range - 1; j > i; j--) {
> +				irq_counts[j].counts = irq_counts[j - 1].counts;
> +				irq_counts[j].irq = irq_counts[j - 1].irq;
> +			}
> +			irq_counts[j].counts = counts;
> +			irq_counts[j].irq = irq;
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * If the proportion of time spent handling irq exceeds HARDIRQ_PERCENT_THRESH%
> + * during sample_period, then it is necessary to record the counts of each irq.
> + */
> +static inline bool need_record_irq_counts(int type)
> +{
> +	int tail = this_cpu_read(cpustat_tail);
> +	u8 utilization;
> +
> +	if (--tail == -1)
> +		tail = 4;
> +	utilization = this_cpu_read(cpustat_utilization[tail][type]);
> +	return utilization > HARDIRQ_PERCENT_THRESH;
> +}
> +
> +/*
> + * Mark softlockup as potentially caused by hardirq
> + */
> +static void set_potential_softlockup_hardirq(void)
> +{
> +	u32 i;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +	struct irq_desc *desc;
> +
> +	if (!need_record_irq_counts(STATS_HARDIRQ))
> +		return;
> +
> +	if (!test_bit(cpu, softlockup_hardirq_cpus)) {
> +		counts = kmalloc_array(nr_irqs, sizeof(u32), GFP_ATOMIC);
> +		if (!counts)
> +			return;
> +		for_each_irq_desc(i, desc) {
> +			if (!desc)
> +				continue;
> +			counts[i] = desc->kstat_irqs ?
> +				*this_cpu_ptr(desc->kstat_irqs) : 0;
> +		}
> +		__this_cpu_write(hardirq_counts, counts);
> +		set_bit(cpu, softlockup_hardirq_cpus);
> +	}
> +}
> +
> +static void clear_potential_softlockup_hardirq(void)
> +{
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +
> +	if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +		kfree(counts);
> +		counts = NULL;
> +		__this_cpu_write(hardirq_counts, counts);
> +		clear_bit(cpu, softlockup_hardirq_cpus);
> +	}
>   }
> +
> +/*
> + * Mark that softlockup may occur
> + */
> +static void set_potential_softlockup(unsigned long now, unsigned long period_ts)
> +{
> +	if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
> +		set_potential_softlockup_hardirq();
> +}
> +
> +static void clear_potential_softlockup(void)
> +{
> +	clear_potential_softlockup_hardirq();
> +}
> +
> +static void print_hardirq_counts(void)
> +{
> +	u32 i;
> +	struct irq_desc *desc;
> +	u32 counts_diff;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +	struct irq_counts hardirq_counts_top[NUM_HARDIRQ_REPORT] = {
> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
> +	};
> +
> +	if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +		/* Find the top NUM_HARDIRQ_REPORT most frequent interrupts */
> +		for_each_irq_desc(i, desc) {
> +			if (!desc)
> +				continue;
> +			counts_diff = desc->kstat_irqs ?
> +				*this_cpu_ptr(desc->kstat_irqs) - counts[i] : 0;
> +			find_counts_top(hardirq_counts_top, i, counts_diff,
> +					NUM_HARDIRQ_REPORT);
> +		}
> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */
> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
> +			smp_processor_id(), HARDIRQ_PERCENT_THRESH);
> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (hardirq_counts_top[i].irq == -1)
> +				break;
> +			desc = irq_to_desc(hardirq_counts_top[i].irq);
> +			if (desc && desc->action)
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
> +					i+1, hardirq_counts_top[i].counts,
> +					hardirq_counts_top[i].irq, desc->action->name);
> +			else
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
> +					i+1, hardirq_counts_top[i].counts,
> +					hardirq_counts_top[i].irq);
> +		}
> +		if (!need_record_irq_counts(STATS_HARDIRQ))
> +			clear_potential_softlockup_hardirq();
> +	}
> +}
> +
>   #else
>   static inline void update_cpustat(void) { }
>   static inline void print_cpustat(void) { }
> @@ -537,6 +690,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
>   static int softlockup_fn(void *data)
>   {
>   	update_touch_ts();
> +	clear_potential_softlockup();
>   	complete(this_cpu_ptr(&softlockup_completion));
>   
>   	return 0;

