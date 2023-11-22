Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92367F4E88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjKVRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:39:55 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FF83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:39:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E60AC3200A5B;
        Wed, 22 Nov 2023 12:39:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 Nov 2023 12:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700674790; x=1700761190; bh=mb
        Xk1fPQ1fXNlmJ+siwdw43FMHaaZllJuDW8mtdpSdA=; b=ZjtW5riyX0b7AO7/vn
        XNlO+X7n8lGYWWkXRsIzeCx3CPG4PZXRKZJ5kdr2CbCeCdFb8OmSqVU9paMvsG7i
        6PskCUikkHjp6P2E0Gbh6+abYd6OjXTWIMmsDOEsdmBfMGcUNy9y3W8SbfYLMiqU
        yz7bUaefNN/LwKnRZrSaUQiubrMlTe5UuqBWJhmAN7zlro28aMpBFL8OJaIHQvMq
        z1gI5kIagdnXEqBCqzF4cMio8xIfoMZbZMbbpEC/QcmD+TE4ZU1UtptDzWtBfDwi
        GeHqpMyApW1VtfTwsg7SEsgJZzda8RHNLaV78Va3J+zALYqvQx4ZAb0KX2dP3qQo
        MeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700674790; x=1700761190; bh=mbXk1fPQ1fXNl
        mJ+siwdw43FMHaaZllJuDW8mtdpSdA=; b=BSPM8oAQwOtYGvg26DINegNv0/pjM
        S/dMn7507XKoyzxet+Omn3isgr0fGk49WuNRCgkrkpfMuj64cKXUMemZM4PsLXXP
        j8JSk5+NhK5/3Q4uKjR3TS/Abslla6feFxrS+xRd8Q5hRtl6vKEb5kB1E9sxPxEe
        hTS+REZ0hzVQSvoC98GY6jFCPHhOXdwRluFybzqojEMvlJFtGFY5boOuZ2fWondN
        +48t8YEEYozotl4bKOy9ysZ1F3cCv+yKWoeHIsTW2mkcHV62rroqUvipQkeFWldO
        8vFwJdRstg/nNBAeIP1COJJd7XGkPS/3ZVocAUt7y+418AsD/RA8pPo1w==
X-ME-Sender: <xms:5TxeZZh_nN2rT5jujDtEDuSgTRdi_O24FxFHzzP9gvjVY3nRBeWCXQ>
    <xme:5TxeZeD_Wq4m6gJuh2ETxTGJ8x6VgRHOTpQGbmpu3n1aeIDnFZrWvpFmc21nsjoBJ
    JO_u37_nONBF9lmRXM>
X-ME-Received: <xmr:5TxeZZGKghguL6iMd9zY6kJVyLudSNeU0t7MBlV8IjaPHs9E41hISGZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:5TxeZeSxonj8pJxfzB5h4-DA-gf_Iyi3OnOktL-dL5OKUDVGDaNZmA>
    <xmx:5TxeZWxajHsNYPgIwZBF-yTrvEEZD81R4z-EqKy7T352WZTHwlD2WQ>
    <xmx:5TxeZU4kdjhMnoUxCrluP2HSNVjjZmo7w8VnO61oxTTGZX5-jKNaag>
    <xmx:5jxeZdq9JAuiQwQz5AgX1KujbeJirLSh0BtcIaFlvWbv1HYkirxwMg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 12:39:47 -0500 (EST)
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-2-shr@devkernel.io>
 <d41ecf6d-d276-406c-a002-f4ffc9d82ef1@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/ksm: add ksm advisor
Date:   Wed, 22 Nov 2023 09:20:25 -0800
In-reply-to: <d41ecf6d-d276-406c-a002-f4ffc9d82ef1@redhat.com>
Message-ID: <8734wxsn4u.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 28.10.23 02:09, Stefan Roesch wrote:
>> This adds the ksm advisor. The ksm advisor automatically manages the
>> pages_to_scan setting to achieve a target scan time. The target scan
>> time defines how many seconds it should take to scan all the candidate
>> KSM pages. In other words the pages_to_scan rate is changed by the
>> advisor to achieve the target scan time. The algorithm has a max and min
>> value to:
>> - guarantee responsiveness to changes
>> - to avoid to spend too much CPU
>> The respective parameters are:
>> - ksm_advisor_target_scan_time (how many seconds a scan should take)
>> - ksm_advisor_min_cpu (minimum value for cpu percent usage)
>> - ksm_advisor_max_cpu (maximum value for cpu percent usage)
>> - ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
>> - ksm_advisor_max_pages (maximum value for pages_to_scan per batch)
>> The algorithm calculates the change value based on the target scan time
>> and the previous scan time. To avoid pertubations an exponentially
>> weighted moving average is applied.
>> The advisor is managed by three main parameters: target scan time,
>> cpu min time and cpu max time for the ksmd background thread. These
>> parameters determine how aggresive ksmd scans.
>> In addition there are min and max values for the pages_to_scan parameter
>> to make sure that its initial and max values are not set too low or too
>> high. This ensures that it is able to react to changes quickly enough.
>> The default values are:
>> - target scan time: 200 secs
>> - min cpu: 15%
>> - max cpu: 70%
>> - min pages: 500
>> - max pages: 30000
>
> Do we really need the min cpu load? The target scan time combined with the max
> CPU load should be sufficient, no?
>
> Internally, we might want some sane default/min start value, but exposing that
> to the user is questionable.
>
> For example, if I have exactly two possible KSM pages in the system, why should
> my cpu dedicate 15% to scanning nothing after merging them? :)
>
> [...]
>

The min cpu case is to make sure that we scan fast enough to be able to
react fast enough to the changes in the number of pages. This helps in
determining in how quick we want to react to changes. This helps
especially with the startup phase of applications.

We can certainly only set a default value, that is not exposed in sysfs.

>> +/**
>> + * struct advisor_ctx - metadata for KSM advisor
>> + * @start_scan: start time of the current scan
>> + * @scan_time: scan time of previous scan
>> + * @change: change in percent to pages_to_scan parameter
>> + * @cpu_percent: average cpu percent usage of the ksmd thread for the last scan
>> + */
>> +struct advisor_ctx {
>> +	ktime_t start_scan;
>> +	unsigned long scan_time;
>> +	unsigned long change;
>> +	unsigned long long cpu_time;
>> +};
>> +static struct advisor_ctx advisor_ctx;
>> +
>> +/* Define different advisor's */
>> +enum ksm_advisor_type {
>> +	KSM_ADVISOR_NONE,
>> +	KSM_ADVISOR_FIRST = KSM_ADVISOR_NONE,
>
> Unused, better drop it. 0 is the implicit first one.
>
Will change it accordingly.

>> +	KSM_ADVISOR_SCAN_TIME,
>> +	KSM_ADVISOR_LAST = KSM_ADVISOR_SCAN_TIME
>
> Instead of "_LAST", maybe use "_COUNT" and use that when checking for valid
> values.
>
> But: we likely want to store "strings" instead of magic numbers from user space
> instead.
>

Any recommendation for the naming of the parameters when I switch to
strings?

>> +};
>> +static enum ksm_advisor_type ksm_advisor;
>> +
>> +static void init_advisor(void)
>> +{
>> +	advisor_ctx.start_scan = 0;
>> +	advisor_ctx.scan_time = 0;
>> +	advisor_ctx.change = 0;
>> +	advisor_ctx.cpu_time = 0;
>> +}
>
> That should likely not be required. The values are all 0.
>
> If other values are ever required, they could be initialized right with the
> variable:
>
> static struct advisor_ctx advisor_ctx = {
> 	.start_scan = 0,
> 	...
> };
>

ok

>> +
>> +/*
>> + * Use previous scan time if available, otherwise use current scan time as an
>> + * approximation for the previous scan time.
>> + */
>> +static inline unsigned long prev_scan_time(struct advisor_ctx *ctx,
>> +					   unsigned long scan_time)
>> +{
>> +	return ctx->scan_time ? ctx->scan_time : scan_time;
>> +}
>> +
>> +/* Calculate exponential weighted moving average */
>> +static unsigned long ewma(unsigned long prev, unsigned long curr)
>> +{
>> +	return ((100 - EWMA_WEIGHT) * prev + EWMA_WEIGHT * curr) / 100;
>> +}
>> +
>> +/*
>> + * The scan time advisor is based on the current scan rate and the target
>> + * scan rate.
>> + *
>> + *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
>> + *
>> + * To avoid pertubations it calculates a change factor of previous changes.
>> + * A new change factor is calculated for each iteration and it uses an
>> + * exponentially weighted moving average. The new pages_to_scan value is
>> + * multiplied with that change factor:
>> + *
>> + *      new_pages_to_scan *= change facor
>> + *
>> + * In addition the new pages_to_scan value is capped by the max and min
>> + * limits.
>> + */
>> +static void scan_time_advisor(unsigned long scan_time)
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
>> +
>> +	cpu_time = task_sched_runtime(current);
>> +	cpu_time_diff = cpu_time - advisor_ctx.cpu_time;
>> +	cpu_time_diff_ms = cpu_time_diff / 1000 / 1000;
>> +
>> +	cpu_percent = (cpu_time_diff_ms * 100) / (scan_time * 1000);
>> +	cpu_percent = cpu_percent ? cpu_percent : 1;
>> +	last_scan_time = prev_scan_time(&advisor_ctx, scan_time);
>> +
>> +	/* Calculate scan time as percentage of target scan time */
>> +	factor = ksm_advisor_target_scan_time * 100 / scan_time;
>> +	factor = factor ? factor : 1;
>> +
>> +	/*
>> +	 * Calculate scan time as percentage of last scan time and use
>> +	 * exponentially weighted average to smooth it
>> +	 */
>> +	change = scan_time * 100 / last_scan_time;
>> +	change = change ? change : 1;
>> +	change = ewma(advisor_ctx.change, change);
>> +
>> +	/* Calculate new scan rate based on target scan rate. */
>> +	pages = ksm_thread_pages_to_scan * 100 / factor;
>> +	/* Update pages_to_scan by weighted change percentage. */
>> +	pages = pages * change / 100;
>> +
>> +	/* Cap new pages_to_scan value */
>> +	per_page_cost = ksm_thread_pages_to_scan / cpu_percent;
>> +	per_page_cost = per_page_cost ? per_page_cost : 1;
>> +
>> +	pages = min(pages, per_page_cost * ksm_advisor_max_cpu);
>> +	pages = max(pages, per_page_cost * ksm_advisor_min_cpu);
>> +	pages = min(pages, ksm_advisor_max_pages);
>> +
>> +	/* Update advisor context */
>> +	advisor_ctx.change = change;
>> +	advisor_ctx.scan_time = scan_time;
>> +	advisor_ctx.cpu_time = cpu_time;
>> +
>> +	ksm_thread_pages_to_scan = pages;
>
> While that advisor is active, we should likely disallow changing
> ksm_thread_pages_to_scan using other means.
>

I'll add a check in the corresponding sysfs function

>> +}
>> +
>> +static void run_advisor(void)
>> +{
>> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME) {
>> +		s64 scan_time;
>> +
>> +		/* Convert scan time to seconds */
>> +		scan_time = ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
>> +		scan_time = div_s64(scan_time, MSEC_PER_SEC);
>> +		scan_time = scan_time ? scan_time : 1;
>> +
>> +		scan_time_advisor((unsigned long)scan_time);
>> +	}
>
> We could have rescheduled in the meantime, right? Doesn't that mean that our CPU
> load consumption might be wrong in some cases?
>
Does it matter? I'm interested how long it takes to complete the scan,
including any scheduling.

>> +}
>> +
>>   #ifdef CONFIG_NUMA
>>   /* Zeroed when merging across nodes is not allowed */
>>   static unsigned int ksm_merge_across_nodes = 1;
>> @@ -2401,6 +2554,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>     	mm_slot = ksm_scan.mm_slot;
>>   	if (mm_slot == &ksm_mm_head) {
>> +		advisor_ctx.start_scan = ktime_get();
>
> Why do that even without KSM_ADVISOR_SCAN_TIME?
>
> You should probably have two functions:
>
> ksm_advisor_start_scan() [this code, fenced by KSM_ADVISOR_SCAN_TIME]
> ksm_advisor_stop_scan() [previous run_advisor]
>
I'll add the above functions.

>>   		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
>>     		/*
>> @@ -2558,6 +2712,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>   	if (mm_slot != &ksm_mm_head)
>>   		goto next_mm;
>>   +	run_advisor();
>> +
>>   	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
>>   	ksm_scan.seqnr++;
>>   	return NULL;
>> @@ -3603,6 +3759,7 @@ static int __init ksm_init(void)
>>   	zero_checksum = calc_checksum(ZERO_PAGE(0));
>>   	/* Default to false for backwards compatibility */
>>   	ksm_use_zero_pages = false;
>> +	init_advisor();
>>     	err = ksm_slab_init();
>>   	if (err)
