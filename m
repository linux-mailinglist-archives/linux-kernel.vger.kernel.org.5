Return-Path: <linux-kernel+bounces-71017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CC859F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63893B22723
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB622F0F;
	Mon, 19 Feb 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pv/vW1og"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152022F00
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334256; cv=none; b=F6vRDLf/RF/Z6xTmEzMrDmK1B6shAcSrfFqVWW1HEDs7QZj4RRS/+kVUb0Msw2BX/GK1ROcENRb+0Ca+E+quqPQcM5zyvKtaUSR2talFMhhlHuvNcg5be7n6rp4MXvgdBc5lTCoaJoALlfkB8asJIYhmQ6ieitdfAiw8pYMmYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334256; c=relaxed/simple;
	bh=epTUfFQwno2wI377j99GIgS7b9HraRzpQgLwFeKbg0Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NGD15ryL6b22VWJP+qTCtDfage56275K7bG0FSSwMIr7k/2PK3DEiJqT8XEgFI3g4Z5n/8WiZggLCYWCF5Q/tir8OFoWO/z5LjGZD6khG37Kv+qp0S9eKTtorzryVY7PQT5VMPLO6iytzC7R+zqG0ALt4mTCz7Qsz4wcw1YKgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pv/vW1og; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708334246; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=BH1GYWZS6Ec7OAeBGtxUqhu8PwfORuAdAisOvqa5C+A=;
	b=Pv/vW1ogpCroWsxU68jIz3U2R1ATy4NUW/nUd5wI9juMVbcGaNV6/xz0i0IYIryEHpEtLlW45YddyDaW6TQOFjmKztxp/dHmSUM5M3NEjIx3o7KB/rMU1v+KCdJumt92trqYb6Bd9ej3Knxw82sCJ8K2Thnc6C5yzQJaRaJ2jTA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W0sMvls_1708333927;
Received: from 192.168.0.101(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0sMvls_1708333927)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 17:12:08 +0800
Message-ID: <a7dd72c5-ed0a-4270-b3a7-5775037703e4@linux.alibaba.com>
Date: Mon, 19 Feb 2024 17:12:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv7 2/2] watchdog/softlockup: report the most frequent
 interrupts
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 akpm@linux-foundation.org, Petr Mladek <pmladek@suse.com>,
 kernelfans@gmail.com, Liu Song <liusong@linux.alibaba.com>,
 yaoma@linux.alibaba.com
References: <87mss2dkxo.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87mss2dkxo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/2/15 19:30, Thomas Gleixner wrote:
> On Wed, Feb 14 2024 at 10:14, Bitao Hu wrote:
>> +static void start_counting_irqs(void)
>> +{
>> +	int i;
>> +	int local_nr_irqs;
>> +	struct irq_desc *desc;
>> +	u32 *counts = __this_cpu_read(hardirq_counts);
>> +
>> +	if (!counts) {
>> +		/*
>> +		 * nr_irqs has the potential to grow at runtime. We should read
>> +		 * it and store locally to avoid array out-of-bounds access.
>> +		 */
>> +		local_nr_irqs = nr_irqs;
>> +		counts = kcalloc(local_nr_irqs, sizeof(u32), GFP_ATOMIC);
> 
> Seriously? The system has a problem and you allocate memory from the
> detection code in hard interrupt context?
I want all the changes for this feature to be concentrated within the
watchdog module, and I am also unsure whether modifying the irq code
for this feature would be justified. Hence, I opted for this approach.
However, your reply on V1 demonstrated the proper way to do it, so I
will refactor accordingly.

>> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
>> +			if (irq_counts_sorted[i].irq == -1)
>> +				break;
>> +
>> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
>> +			if (desc && desc->action)
>> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
>> +				       i + 1, irq_counts_sorted[i].counts,
>> +				       irq_counts_sorted[i].irq, desc->action->name);
> 
> You cannot dereference desc->action here:
> 
>      1) It can be NULL'ed between check and dereference.
> 
>      2) Both 'action' and 'action->name' can be freed in parallel
> 
> And no, you cannot take desc->lock here to prevent this. Stop fiddling
> in the internals of interrupt descriptors.
Thanks for your analysis. However, I have a question. 'action->name'
cannot be accessed here, and it seems that merely outputting the
irq number provides insufficient information?

> 
> 
> and the analysis boils down to:
> 
>          u64 cnt, sorted[3] = {};
>          unsigned int irq, i;
> 
>      	for_each_active_irq(irq) {
>          	cnt = kstat_get_irq_since_snapshot(irq);
> 
> 		if (cnt) {
>                       	for (cnt = (cnt << 32) + irq, i = 0; i < 3; i++) {
>                  		if (cnt > sorted[i])
>                          		swap(cnt, sorted[i]);
Hmm, I think the approach here isn't optimal. If some interrupts
have the same count, then it effectively results in sorting by the
irq number. Is my understanding correct?

Best Regards,
	Bitao


