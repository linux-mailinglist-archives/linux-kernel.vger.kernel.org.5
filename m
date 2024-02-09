Return-Path: <linux-kernel+bounces-59267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACC84F448
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504871F23CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCB28DA5;
	Fri,  9 Feb 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE1tT5r2"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5723761
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476940; cv=none; b=uMPIXr+TXeTv180xLbuGN1J+C9TQzbLQ1nrkM+GyiycwoaK5wWhLpY8muNqkz9n9tQqUM/fCpTG3nXR7yIZocruVcX7X7HTLhbQgMZTUxez2S7SGA4Pe2oxrOBqsq8ggcMDehOQp0vIBp3UUQf2putbjjLFUNDCcjIfYJRdiBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476940; c=relaxed/simple;
	bh=Zh6PlzYFbTU+L+6RTE9OLt1oOCfxpmgjWd/764eaHUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZ4pNcL40yj/bdiuW+kbUBBV6DvGRs+CNLZAazGs8qxIKOw00jBD5H/p/MSxXKXqSAr3PxuN63pPkKe48Jj7OEXONs5TJthgzrxsIIikyh3mohiIK/G0f0byzVbnGoSrr5Y0RVd/628AIE9rb9rsp2LisKQea9d3wI0R9QdNvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE1tT5r2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so635391a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707476938; x=1708081738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJDO/sC3jZ+Til09Hjp5FmXr82VkdFYrB4Z3Tb7O9dc=;
        b=fE1tT5r2MeCFMEyHw982xNdAZ+SBhlmydaym9RKAs/gn4oCSxnOZ6TeXErKG6UxBt6
         LlaR1AgcaOm1Ut8Xy9ndOTSTHXVh37+joC+BV33mrk46R7wy25f0CrL/X44qou7RNAMO
         u1PYxfij3ql7TPF9+BS7QY6JL/OnE57/hTZfH8rQv2cTM8CTF4tflWafNNRttV72mAjt
         Be8IchJXZNUlH9vsAvFrXeXaE0c1JzI+P92/qCLUwbnM8wX/4UBot9d1EOTQJjUxNsvy
         bGGjGOXMfqubUimafxnQhi1I+sjNAWAwgPksMR3OCc8jIRimeEG4tfalnR+50h4m7MVC
         Q7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476938; x=1708081738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJDO/sC3jZ+Til09Hjp5FmXr82VkdFYrB4Z3Tb7O9dc=;
        b=b2797EnnxVL216JSs2MX6E+Cv5kXV/LLcAQVfRiIc/JbTMMrOcwpcgKPloHpebPxi9
         dDRIc+VUsVZkdcUbpekEshi6fhsZBB1jaJK1k6auLG7AoaB6trai1oCuOrpGUIMcn11x
         +BAPOMa5aIb64ve6nIciHNCsAC8IjH+WGRLsQS1H8afRzZnsyszkYjSkxTOdUzfLcUKq
         D1HZ9ZFY+SYR58F25sKrQzj/4eJxIYqR0EMjeKIZ7DzvuYpQ387SeU1LFuIbZAcbvo5d
         haO5bvw2zuC3CpOGWroLmiNR+0+SEBgoJ8+yQ+w8hboBsmM/Ilmec0ilOfMUSOSJCNrH
         Xffw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUPnX1Ue4+cKWTls1aWqqH43PF+y3dap1fSS91+c199EaxCvnIbn02BpWr9v8KVEEuZbnYD7aJS7DVdKsvcJSt1aeIVgbOsg9ZMie
X-Gm-Message-State: AOJu0YzLxV7wSUmu65KE1bO/gLZ4Esc2fKFG/PcwawpvtDWEp7KHn+Up
	KmbToqLYUjpUcljJdpBxwO7xwvoBKP3GpUe946wmxSXtmBLCkYnC
X-Google-Smtp-Source: AGHT+IHQLfdUjWAmn8Cdi1i08+LQTA3n/s6Vc4b93n7ot8XMSHqVd70OOpYbM8NkpnmJT20j5e235w==
X-Received: by 2002:a05:6a20:6215:b0:19e:982e:c402 with SMTP id p21-20020a056a20621500b0019e982ec402mr1044787pze.59.1707476938414;
        Fri, 09 Feb 2024 03:08:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW00jYFO5af4+QPdF7XP+Pl+XXtRnEiFuuIPakfYs1dFVrvc57eTx/qTj7jlNgox3kjGmfAQkwg0gekHbD4CHisQM2gSDTGkilepvZj/dzKEWfPOdnx4OPcHHf71EAm6ad+7RgcqpMTVMj4wyoL7WnayxIJZOXOtZK4t5BCtCg45Sr5NM1cCfoz2t6wXsj5+HAQ7TPAKX3dNDuL/9RuRvGfpibIX56C4VHKs0l0CSFACtkPVlRsCb9KgHC0VzKdcBjow6cOVxqUdmNUD8CQ9oNPnSkImq/T1Rq3gJETtaWxPj+nB1FpU/sn7f33boWVdPsUNLo2FtPXehYIuNmN3HLuDlCq87/ympF4dWNuNAIbSj0SNn6bu8QwfI3shNWGnuhZE1b6IQV6QPeUcUmW
Received: from [192.168.255.10] ([58.32.33.209])
        by smtp.gmail.com with ESMTPSA id o13-20020a62cd0d000000b006e04e9c1d50sm220735pfg.31.2024.02.09.03.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 03:08:57 -0800 (PST)
Message-ID: <44411da9-4cda-47ff-a73d-a66c63757930@gmail.com>
Date: Fri, 9 Feb 2024 19:08:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] sched/fair: Rework sched_use_asym_prio() and
 sched_asym_prefer()
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 yangyicong@hisilicon.com
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-3-alexs@kernel.org>
 <20240209024737.GA10494@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240209024737.GA10494@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 10:47 AM, Ricardo Neri wrote:
> On Wed, Feb 07, 2024 at 11:47:03AM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> sched_use_asym_prio() sched_asym_prefer() are used together in various
> 
> s/prio() sched/prio() and sched/

Will take it, Thanks!

> 
>> places. Consolidate them into a single function sched_asym().
>>
>> The existing sched_group_asym() is only used when collecting statistics
>> of a scheduling group. Rename it as sched_group_asym().
>> This makes the code easier to read. No functional changes.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 37 ++++++++++++++++++++-----------------
>>  1 file changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 607dc310b355..942b6358f683 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>>  }
>>  
>> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
>> +{
>> +	/*
>> +	 * First check if @dst_cpu can do asym_packing load balance. Only do it
>> +	 * if it has higher priority than @src_cpu.
>> +	 */
>> +	return sched_use_asym_prio(sd, dst_cpu) &&
>> +		sched_asym_prefer(dst_cpu, src_cpu);
>> +}
>> +
>>  /**
>> - * sched_asym - Check if the destination CPU can do asym_packing load balance
>> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>>   * @env:	The load balancing environment
>>   * @sgs:	Load-balancing statistics of the candidate busiest group
>>   * @group:	The candidate busiest group
> 
> After renaming and changing this function now its documentation has become
> obsolete. Can you update it?

Since the function sched_use_asym_prio() and sched_asym_prefer() both give detailed comments for their actions, as long as this function does, could we just remove the bit obsolete comments here?


@@ -9765,14 +9765,6 @@ static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
  * @env::dst_cpu can do asym_packing if it has higher priority than the
  * preferred CPU of @group.
  *
- * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
- * can do asym_packing balance only if all its SMT siblings are idle. Also, it
- * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
- * imbalances in the number of CPUS are dealt with in find_busiest_group().
- *
- * If we are balancing load within an SMT core, or at PKG domain level, always
- * proceed.
- *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
  * otherwise.
>  

