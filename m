Return-Path: <linux-kernel+bounces-54451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FD84AF6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0104287654
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D88B12A157;
	Tue,  6 Feb 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms5Or81a"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5739AD5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206257; cv=none; b=d0cIHlQRytZvs0IIbLUsS6ooRDCLC6INzfhQCD+B2DTVn0oudFEfLJB0n1Vb0X+Nxa7IKsmO7fRdYIJmNa3XE93jkAYuJ0na3nryrCbJ8b3kKSk7pOC/Henf+0bk0ZFhAXs73NK+mBZLdVuO6alqjI2YrNkzrcws0ZelNOI0eOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206257; c=relaxed/simple;
	bh=/2CPX9MHV7Aqeq+uASx+rpnPXl5+291iAjOW7FBC+uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIBmcOUYICe+G6y6Av9H+tpW4Remu4gck26ihp+MTbuNIm3YftmbTFTEk6OoFZqenxlknlvvuFXbU/JHfeZwFqmVz+3q0kxRFjWFBOdZhm8mdNWLHsRupiTCtqenMKfgaQs+FapU1YUIOvjmpnAwvrdFyGC1lcYSt7rKJ0nk/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms5Or81a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e05d958b61so94825b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707206255; x=1707811055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMH9c0uwCwrEo5X/INndbrdXCQ+5aEbq65KlNj4ZY9c=;
        b=ms5Or81amq+3BDiJBwnnlUCXfzmfHIAmKvB7t7K7hFBQPp+mhA7ngmEMSbgRrjfxcb
         ROVDYLjztwuQYF9SInQca237srdf1R+XinGRsIG+/sRRMqQdQbZJUfuFXOmu1DWiNwu6
         2mDvabWH+45iLYsmqCp9/ao/dSqxV6499rbqQ/xMdvNl63ZRLmiwjywmn8FxoC9q96F+
         IHikzL4hgu90F1EjYlQk6D6BGkhW5KinXQLJB7fseFyijrgzz+9gpfW7Mtk7QOncWDHH
         t2pECtEhlVIbQveSinqiyf1o/baNXecRvJ6sujq05HmHISdfetBGc04SjjIWysZCYZal
         ogZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707206255; x=1707811055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMH9c0uwCwrEo5X/INndbrdXCQ+5aEbq65KlNj4ZY9c=;
        b=M5umPK3IdIhb2Xh2MkFeRJsYxSyfaSpOXbLnsdj26y2awvqOvpd5OjyzYrXCh0jdcm
         Zjgaj6M5iqNL77xAFlNoELPLBdIgWZdSP0htaP8NHlQc58+bZsjlrT0/TVmKYAcg+cjf
         i8aJKXU6nI5UgDT9jChcNsJBe270XqkUOb2tiRbBq+WkLdLTZSE2/yFuQwmiR1oHH1Fz
         d/sR3DltNHaLkq7W0kAsOmqvNzDVXVBLXVB6QWz/vqLlWQ4XLmuj7rCD3qwwTdewXDmQ
         ZMzI9IWvcY9e42E9qFFhKC9onLf/XGDC7P0gRRL2Gdon4JuVZv/ROxhUbay5aEmxyDrG
         547Q==
X-Gm-Message-State: AOJu0YxAkbtbPvHV3ti4NdoxnocghBl+IITAJRWFEtwmFUz7UodTBmQl
	KoKXr3oZlfKnBsCA7YsZ3iHxhIWF1ndUofBZNZylQoZ9cAhp1d5jKhJ+09eIh0Lylg==
X-Google-Smtp-Source: AGHT+IH8mk1rT8unC6J0EHmXbIiqdTgmGmIG6DrDHffTTJ4V5ffIatzIY+EaidDkWASYz1XavIRqEg==
X-Received: by 2002:a05:6a20:9388:b0:19c:6cae:508e with SMTP id x8-20020a056a20938800b0019c6cae508emr1097369pzh.36.1707206255263;
        Mon, 05 Feb 2024 23:57:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXL8XKEkyW7II7Yug/oBOsks1U2EoKemErqPsPfSHTTycF7fUKiNBrrBtbLMiARIXJ9vAY9JIxNj2FxjMV909DZdMsgyp1sOTmSnF0SrhS3ZF/PzBogyuBGMPo8qwRLOfrnE+0sIOtrnExdO4QPb4dCouFyKsD8tkX4mVcmUCRJ3WlBq5x4mUizB6/mJfQSXfpodApaahCpbCoAzB/YKTL4KhGZGjGHLFzo0vVl0eN7yFJjCi/GaT2FNj0kJ2YsVktpYHWWoyxMmxdAqcg7WhaniG1aIrFbedjjdH3j0LBaxNARADxs9tGmHcn25ZmVCuKkciQJuGqxt43C5fsn9HjhQvk+pGQZUzor4u0VG9b+EAurdCDea1Q5gi7A4Gk8elvimJverqyn/cn1
Received: from [192.168.255.10] ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001d8f81ece98sm1200351plb.104.2024.02.05.23.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 23:57:34 -0800 (PST)
Message-ID: <65525b4a-2626-4c8c-ad05-9942a683fe43@gmail.com>
Date: Tue, 6 Feb 2024 15:57:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] sched/fair: Check the SD_ASYM_PACKING flag in
 sched_use_asym_prio()
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 sshegde@linux.ibm.com
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-4-alexs@kernel.org>
 <20240205223817.GB17602@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240205223817.GB17602@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 6:38 AM, Ricardo Neri wrote:
> On Thu, Feb 01, 2024 at 07:54:47PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> sched_use_asym_prio() checks whether CPU priorities should be used. It
>> makes sense to check for the SD_ASYM_PACKING() inside the function.
>> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
>> remove the now superfluous checks for the flag in various places"
> 
> s/places"/places./
> 
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: Ben Segall <bsegall@google.com>
>> To: Steven Rostedt <rostedt@goodmis.org>
>> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Daniel Bristot de Oliveira <bristot@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Juri Lelli <juri.lelli@redhat.com>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 44fd5e2ca642..bd32efbea688 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9741,6 +9741,9 @@ group_type group_classify(unsigned int imbalance_pct,
>>   */
>>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  {
>> +	if (!(sd->flags & SD_ASYM_PACKING))
>> +		return false;
>> +
>>  	if (!sched_smt_active())
>>  		return true;
>>  
>> @@ -9940,11 +9943,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>  	sgs->group_weight = group->group_weight;
>>  
>>  	/* Check if dst CPU is idle and preferred to this group */
>> -	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>> -	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
>> -	    sched_group_asym(env, sgs, group)) {
>> +	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
>> +			sched_group_asym(env, sgs, group))
> 
> You should align sched_group_asym() to !local_group.

Thanks for all suggestion. I will take them in next version.

> 
>>  		sgs->group_asym_packing = 1;
>> -	}
>>  
>>  	/* Check for loaded SMT group to be balanced to dst CPU */
>>  	if (!local_group && smt_balance(env, sgs, group))
>> @@ -11040,9 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>  		 * If balancing between cores, let lower priority CPUs help
>>  		 * SMT cores with more than one busy sibling.
>>  		 */
>> -		if ((env->sd->flags & SD_ASYM_PACKING) &&
>> -		    sched_asym(env->sd, i, env->dst_cpu) &&
>> -		    nr_running == 1)
>> +		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
>>  			continue;
>>  
>>  		switch (env->migration_type) {
>> @@ -11138,7 +11137,7 @@ asym_active_balance(struct lb_env *env)
>>  	 * the lower priority @env::dst_cpu help it. Do not follow
>>  	 * CPU priority.
>>  	 */
>> -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
>> +	return env->idle != CPU_NOT_IDLE &&
>>  	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
>>  	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> 
> Perhaps you can rearrange the spaghetti of conditions to make better use of
> the full 80-column line.

80-column doesn't work here, will try 100 column.

Thanks
Alex

