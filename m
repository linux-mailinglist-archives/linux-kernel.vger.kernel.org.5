Return-Path: <linux-kernel+bounces-4162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF018178A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2D91C247F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203EA5A84B;
	Mon, 18 Dec 2023 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="CRMVcd/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AL+gvIjB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403D1E4BF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 79A975C01BF;
	Mon, 18 Dec 2023 12:27:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 18 Dec 2023 12:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1702920477; x=1703006877; bh=78eEoTRmqP
	jg8N5m2iSQ0b0Eqh+CNDALoBgwF4CtoU0=; b=CRMVcd/kAz+5ggYvBJi8CHdvT8
	5EG89YWANK/nvp2nj/mc7Iy9NpOG9o/jWRDadSJx5/m+jIwuyIqk3i1B9D+hVVRk
	RnuQh7bIAhB4D6f5oQJxrqqWj/1p404HXlE89XTyxn4XH5JxshDSNJXjG0RrORmU
	m+Jxexlp4XwTc6NmEHimfq55QantIhXEy5ynajcflhl9rGmOunDgbZA27QJIrC48
	nMSp4JIHlkT+jclLTJLoS+zXOKYpeUBWmbkTMlr+o4AhuTdj9aya3bdBqNZug0NE
	k0zjPozhFaYLwSgQuK3/qIQDVyFfFNfV7JFepHkFrimmJvEP8762/Qy0UKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702920477; x=1703006877; bh=78eEoTRmqPjg8N5m2iSQ0b0Eqh+C
	NDALoBgwF4CtoU0=; b=AL+gvIjBQb/wrIXjfvMUia0sGE0CRQJxfkHKvoKqIoy/
	nj+JSgn5BXQMCZKkx8nezylBUdzWoqg2Mgk0hEnZZvovxLNpbORYsFJGE6AL4r/Y
	t1gpcMDWvIgJcscLdTFoTGwK2MHWVuczJ7RyMf2ND+0SMZMoH0bEXvWp0OBMQsvd
	7rAd2cuA+qtY1QUfMlVwSi6U9EzsoQRyuL7doHQ4PZceV8sy2MQffKqwGQ4bgPDu
	9pz/Ig1tznfklXKv4DAcrWe/5WvuunooolCkiTMVdngoNtlXgr6us/U4wPRsiRhZ
	4d1KIPrXBs7OfT57qIcwR2k+2Rv42iI2YQaaeiEy4g==
X-ME-Sender: <xms:HYGAZQReALZ7pr3hSf8EfsqEsTTUK0bd7f_3_8gn2QCBldES2mYjEQ>
    <xme:HYGAZdy7RT67pAlAl5AxFgHB1C023oTRWUU-QKvnDrzu4XSMzIVOdW7NY1SmperL0
    KJU4-hctsHDZAsNyi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucftohgvshgthhdfuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtf
    frrghtthgvrhhnpeelgfetfffgjedtleefkefgteejffdtjefgvdduffeitdeuvedvjefg
    vedvgfelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:HYGAZd38qBjd70RDwmUlprq1aiViXmk8Q1P2SqJBx-_Zs0Tk0wy9ig>
    <xmx:HYGAZUCkwVn0PvZguDUCls5M6EL5IF9tUzBI_0JSU3FqSVdDRFu5EA>
    <xmx:HYGAZZgzSFixitvKiVSJCyOgbQkJYyD53j4qtqxCj_3Qdt9K_zy5sw>
    <xmx:HYGAZZdlJobS12gPpy8ITmaIfIRqIUO5qQlm3_8kLZ9qs4BG7LnF8g>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EEB7CB6008D; Mon, 18 Dec 2023 12:27:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <239e7a04-c0fc-40f6-b383-627603f27a99@app.fastmail.com>
In-Reply-To: <07c3d204-8285-46d2-b7fa-c63800bd7073@redhat.com>
References: <20231213182729.587081-1-shr@devkernel.io>
 <20231213182729.587081-2-shr@devkernel.io>
 <07c3d204-8285-46d2-b7fa-c63800bd7073@redhat.com>
Date: Mon, 18 Dec 2023 09:27:35 -0800
From: "Stefan Roesch" <shr@devkernel.io>
To: "David Hildenbrand" <david@redhat.com>, kernel-team@fb.com
Cc: "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.org,
 riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/4] mm/ksm: add ksm advisor
Content-Type: text/plain



On Mon, Dec 18, 2023, at 3:29 AM, David Hildenbrand wrote:
> On 13.12.23 19:27, Stefan Roesch wrote:
>> This adds the ksm advisor. The ksm advisor automatically manages the
>> pages_to_scan setting to achieve a target scan time. The target scan
>> time defines how many seconds it should take to scan all the candidate
>> KSM pages. In other words the pages_to_scan rate is changed by the
>> advisor to achieve the target scan time. The algorithm has a max and min
>> value to:
>> - guarantee responsiveness to changes
>> - limit CPU resource consumption
>> 
>> The respective parameters are:
>> - ksm_advisor_target_scan_time (how many seconds a scan should take)
>> - ksm_advisor_max_cpu (maximum value for cpu percent usage)
>> 
>> - ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
>> - ksm_advisor_max_pages (maximum value for pages_to_scan per batch)
>> 
>> The algorithm calculates the change value based on the target scan time
>> and the previous scan time. To avoid pertubations an exponentially
>> weighted moving average is applied.
>> 
>> The advisor is managed by two main parameters: target scan time,
>> cpu max time for the ksmd background thread. These parameters determine
>> how aggresive ksmd scans.
>> 
>> In addition there are min and max values for the pages_to_scan parameter
>> to make sure that its initial and max values are not set too low or too
>> high. This ensures that it is able to react to changes quickly enough.
>> 
>> The default values are:
>> - target scan time: 200 secs
>> - max cpu: 70%
>> - min pages: 500
>> - max pages: 30000
>> 
>> By default the advisor is disabled. Currently there are two advisors:
>> none and scan-time.
>> 
>> Tests with various workloads have shown considerable CPU savings. Most
>> of the workloads I have investigated have more candidate pages during
>> startup, once the workload is stable in terms of memory, the number of
>> candidate pages is reduced. Without the advisor, the pages_to_scan needs
>> to be sized for the maximum number of candidate pages. So having this
>> advisor definitely helps in reducing CPU consumption.
>> 
>> For the instagram workload, the advisor achieves a 25% CPU reduction.
>> Once the memory is stable, the pages_to_scan parameter gets reduced to
>> about 40% of its max value.
>> 
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/ksm.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 160 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 7efcc68ccc6ea..4f7b71a1f3112 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/sched/coredump.h>
>> +#include <linux/sched/cputime.h>
>>   #include <linux/rwsem.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/rmap.h>
>> @@ -248,6 +249,9 @@ static struct kmem_cache *rmap_item_cache;
>>   static struct kmem_cache *stable_node_cache;
>>   static struct kmem_cache *mm_slot_cache;
>>   
>> +/* Default number of pages to scan per batch */
>> +#define DEFAULT_PAGES_TO_SCAN 100
>> +
>>   /* The number of pages scanned */
>>   static unsigned long ksm_pages_scanned;
>>   
>> @@ -276,7 +280,7 @@ static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
>>   static int ksm_max_page_sharing = 256;
>>   
>>   /* Number of pages ksmd should scan in one batch */
>> -static unsigned int ksm_thread_pages_to_scan = 100;
>> +static unsigned int ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
>>   
>>   /* Milliseconds ksmd should sleep between batches */
>>   static unsigned int ksm_thread_sleep_millisecs = 20;
>> @@ -297,6 +301,155 @@ unsigned long ksm_zero_pages;
>>   /* The number of pages that have been skipped due to "smart scanning" */
>>   static unsigned long ksm_pages_skipped;
>>   
>> +/* Don't scan more than max pages per batch. */
>> +static unsigned long ksm_advisor_max_pages = 30000;
>> +
>> +/* At least scan this many pages per batch. */
>> +static unsigned long ksm_advisor_min_pages = 500;
>> +
>> +/* Min CPU for scanning pages per scan */
>> +static unsigned int ksm_advisor_min_cpu =  10;
>
> That will never be modified, right? Either mark it const or just turn it 
> into a define.
>


Changed it to a define.

> [...]
>
>> +/*
>> + * The scan time advisor is based on the current scan rate and the target
>> + * scan rate.
>> + *
>> + *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
>> + *
>> + * To avoid perturbations it calculates a change factor of previous changes.
>> + * A new change factor is calculated for each iteration and it uses an
>> + * exponentially weighted moving average. The new pages_to_scan value is
>> + * multiplied with that change factor:
>> + *
>> + *      new_pages_to_scan *= change facor
>> + *
>> + * The new_pages_to_scan value is limited by the cpu min and max values. It
>> + * calculates the cpu percent for the last scan and calculates the new
>> + * estimated cpu percent cost for the next scan. That value is capped by the
>> + * cpu min and max setting.
>> + *
>> + * In addition the new pages_to_scan value is capped by the max and min
>> + * limits.
>> + */
>> +static void scan_time_advisor(void)
>> +{
>> +	unsigned int cpu_percent;
>> +	unsigned long cpu_time;
>> +	unsigned long cpu_time_diff;
>> +	unsigned long cpu_time_diff_ms;
>> +	unsigned long pages;
>> +	unsigned long per_page_cost;
>> +	unsigned long factor;
>> +	unsigned long change;
>> +	unsigned long last_scan_time;
>> +	unsigned long scan_time;
>> +
>> +	/* Convert scan time to seconds */
>> +	scan_time = div_s64(ktime_ms_delta(ktime_get(), advisor_ctx.start_scan),
>> +			    MSEC_PER_SEC);
>> +	scan_time = scan_time ? scan_time : 1;
>> +
>> +	/* Calculate CPU consumption of ksmd background thread */
>> +	cpu_time = task_sched_runtime(current);
>> +	cpu_time_diff = cpu_time - advisor_ctx.cpu_time;
>> +	cpu_time_diff_ms = cpu_time_diff / 1000 / 1000;
>> +
>> +	cpu_percent = (cpu_time_diff_ms * 100) / (scan_time * 1000);
>> +	cpu_percent = cpu_percent ? cpu_percent : 1;
>> +	last_scan_time = prev_scan_time(&advisor_ctx, scan_time);
>
> I'd simply inline prev_scan_time() here and get rid of it. Whatever you 
> think is best.
>

I think prev_scan_time is a bit more expressive.

>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> -- 
> Cheers,
>
> David / dhildenb

