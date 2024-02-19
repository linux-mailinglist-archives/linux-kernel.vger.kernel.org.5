Return-Path: <linux-kernel+bounces-70781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E3859C50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5B01F231A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB732030A;
	Mon, 19 Feb 2024 06:38:16 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6721E53A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324695; cv=none; b=RKVs+rfOCWOOUfE7j2xt8DouiWgjUkwh3IPrc+NiGfgmYvn/ADsol06BT4l1/TPuEJB1IkVHBj/XpdCAB6iJdLQ7iuTEWHDSS5jvjFRDc6AxZuAMtHaP3yedpfBN/qNghc6eIOH6j2ETXUfCu1cTmBAgwx5ATPF63/bTbnQJQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324695; c=relaxed/simple;
	bh=k2W4SLsFgsS9LCnpgmL1u7Cig5/CHtD4qFo/HAogbiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSu2C0/ex7gb5QjjJryvK6k7YWwe/D1R3NvpxwDvZD+8Cs9C6g6cGN67exZXYRezAluHJ/prBUQhJDyV+7NPUjIgfrsVapJ6gPGMlKoKoPaiB6YvTnlk/BVGaiz1BtgBTV1cp0Dx652x96Pnv7IXY4cAQ04LbBINbCWG2C9XRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp85t1708324630tbe0lfpq
X-QQ-Originating-IP: ePE/qLgyPfe1V/nBJfQ2j4hIEphQMTlw8PTAfJik8+I=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 Feb 2024 14:37:08 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: FwowAM4HOqDdhY0Gzn+ClKKjVX6mbdXdMVvKgJbfIirwcGIMI78wiLXHy6zx7
	wqiOHbXwq0NZktjXcy2Bs9IVbFJhOXRykM2uYMapAOwnQ32dO0INkqQCCINol8x93bAfaGx
	AEo3EDF/1mFrtsxrzta+dk7API3xIzbI9KTBD89WD4UfRElftIyN4lWiPvhF9MNPi24bd/h
	ma6VAmbiYJGRrGAGUnqr7OmhS16yco4i4wQ3lWPDKpkaW3Z8U/59V2IXExMUAtu/6Ef0DgW
	o+Kb+OqtWZmKdNob+1TXwT9nQX/ggBMAQrZXI4w0DcXYHkN2L9Zn7ccYXAYWVW36wPLam/a
	JQwgxT0yrSObSUwnsWeBoODSWI44x8JAcOtwIpyFVCvo6nDXrcWKFN5AcfZyTn62k4vnjMV
	RFO+bwwG4XA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17624953656164576299
Message-ID: <840C2556C7DDB57C+c4575f04-5d1b-44a5-8f7b-3a2ba1fd61c4@shingroup.cn>
Date: Mon, 19 Feb 2024 14:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm_smmuv3: Omit the two judgements which done in
 framework
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, shenghui.qu@shingroup.cn,
 ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231221093802.20612-1-jialong.yang@shingroup.cn>
 <20240209160905.GA24565@willie-the-truck>
 <a455e5db-676a-4cf8-8669-8a10e900361c@arm.com>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <a455e5db-676a-4cf8-8669-8a10e900361c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/2/10 0:32, Robin Murphy 写道:
> On 2024-02-09 4:09 pm, Will Deacon wrote:
>> On Thu, Dec 21, 2023 at 05:38:01PM +0800, JiaLong.Yang wrote:
>>> 'event->attr.type != event->pmu->type' has been done in
>>> core.c::perf_init_event() ,core.c::perf_event_modify_attr(), etc.
>>>
>>> This PMU is an uncore one. The core framework has disallowed
>>> uncore-task events. So the judgement to event->cpu < 0 is no mean.
>>
>> It would be great to refer to the changes which added those checks to
>> the perf core code. From reading the code myself, I can't convince myself
>> that perf_try_init_event() won't call into the driver.
>>
>>>
>>> The two judgements have been done in kernel/events/core.c
>>>
>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>> ---
>>>   drivers/perf/arm_smmuv3_pmu.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>
>> It looks like _many_ perf drivers have these checks, so if they really
>> aren't needed, we can clean this up bveyond SMMU. However, as I said
>> above, I'm not quite convinced we can drop them.
> 
> Right, I think the logic prevents events with a specific PMU type being 
> offered to other PMUs, but as far as I'm aware doesn't apply the other 
> way round to stop generic events (PERF_TYPE_HARDWARE etc.) being offered 
> to all PMUs, so it's those that system PMUs need to reject. >
> It's been on my wishlist for a long time to have a capability flag to 
> say "I don't handle generic events, please only ever give me events of 
> my exact type" so we *can* truly factor this into the core.


It's core framework's responsible to differ generic events and others, 
or uncore pmu and core pmu.
Here we have flag PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE, 
PERF_PMU_CAP_EXTENDED_HW_TYPE doing this.

again:
         rcu_read_lock();
         pmu = idr_find(&pmu_idr, type);
         rcu_read_unlock();
         if (pmu) {
                 if (event->attr.type != type && type != PERF_TYPE_RAW &&
                     !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
                         goto fail; /* generic event with no ability pmu */
This can avoid driver code (event->attr.type != event->pmu->type).

And, code:
if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
	err = -EINVAL;
	goto err_pmu;
}
can promise not uncore-task event.

We should confirm that uncore event should be cpu >= 0.

> 
> Thanks,
> Robin.
> 


