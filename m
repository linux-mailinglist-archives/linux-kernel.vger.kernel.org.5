Return-Path: <linux-kernel+bounces-44692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B484260A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166EE1C2466C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5CA6BB2C;
	Tue, 30 Jan 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+sAd1sG"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35A60874
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620718; cv=none; b=hxT0sK3wmspTu4mT4S+2cj3j6q/o7zDMrLJj0vGfyJuLLf8VoQym6jjKASwxiU12zB8sa80eUBwnXdpbu8j0U92VV7Ljagb/cWpmZUfbpqXzb78QbNWaxwKecK69995Iixy968v4J7SGFQ0FduyZStD2+dKNCNPVPN7/aG392/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620718; c=relaxed/simple;
	bh=vD9IsLTsDmZDtBNXBUMQvvlMs8VuldFZdEYPTu/lHNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exA/gqIZBwtQ71FGUnz8KRQ1VWlUtVMzUgGiw91B+C7wBgO1GZTpG3d0l5S31CQmWm6ET/cd/vAUz/v1QdvM7LCssb2OsjTeeFXtuSv1UfbDFFalvApC/xWfjgZK9Be+jkPj4KjWSEqbJGXRP2j1YRx5+bpAvoW5TsKSx8q9Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+sAd1sG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d746ce7d13so32792505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706620716; x=1707225516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZSzrHwZT0cUCH166tCfR7sNZHASOuItLrNgK3kvuqI=;
        b=e+sAd1sGpQRw+zijDjnyx13tusTJO4FcOGkYEuTUoE4JvZGZfxU12QaXCFxr9UIAs6
         aKxRcRIjgsWlo0GqfVOL48io0okzmUUqiJksZd4Lexs/mmHi87B14gYVeEiPPb4KxmRM
         /t8uRA/+/MBKCbz9BKfvI5AuNvPmUyIcieEEoLLjCRCyCRgy5pe57tJvnByNDmdpFVTr
         +2pKPz/Dljdw1yiL8poSl8WRhPCXS6rfCEP7gB7C1obdXmXV4Csd2vmcfxO1C107CoJH
         VoBhxOyGWgjRg6hWzEv4K7z5QNUQ84mPg3T2c+sOVh1yt7Scw16gq4VbHd12/3CW6Kr0
         hYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706620716; x=1707225516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZSzrHwZT0cUCH166tCfR7sNZHASOuItLrNgK3kvuqI=;
        b=R42o98SO7JXkft2V7BZq6Xa1dx3D2f0byqBj5LYRMqGvi+NcwPH8MXXYsY/O+VdRYo
         oFJHVl/k5yRFg5185O82o7tjE4M2s0rabLRBh88JeLaQhbGgrBajT+sOfc9FIwscOTZf
         qsQrkU6elU1BsSc4NnoYRwOaoqWjIhgVC9d8470el2n4pfIhHxOGf7cQIEPOi9t2BEDL
         rTDezW+Tt1B/B230K+PPQy1k9ELClN7xcqz0BHH1/G2Es0N1ljm1Pa+WpvhnMm7nnPSU
         Wtj1smfZz/BzUiIPUlLi7VIJAmf0evZDkQ5kQ4Hsq1OY4hzw3Ewb43Kt1eVXofmTqqks
         Tjog==
X-Gm-Message-State: AOJu0YxJPNZwiMhX9983oGANWBDzfHVfQ8kxHxRo+5nZ5fRh6dL2zW83
	BNj7nsiqgrWo4vPP6X+KU5Y4V84XJkUReKX1QUeCcrNBXSemN0dM
X-Google-Smtp-Source: AGHT+IHLq+9akx25pQgd1KUDRwbbA1HqOfwVzGCIyYXWyHRjLLcIgvDip9Psyc79vi7FYkJU/hpLyw==
X-Received: by 2002:a17:902:d488:b0:1d8:ae30:eddd with SMTP id c8-20020a170902d48800b001d8ae30edddmr9647806plg.23.1706620716009;
        Tue, 30 Jan 2024 05:18:36 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001d8cc3bfee8sm4500837plb.273.2024.01.30.05.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 05:18:35 -0800 (PST)
Message-ID: <60f6d4e7-5718-4c7a-a3a7-9bd1ac088cae@gmail.com>
Date: Tue, 30 Jan 2024 21:18:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sched/fair: narrow the sched_use_asym_prio checking
 scenario
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, alexs@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-5-alexs@kernel.org>
 <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
 <e5b4eb14-c8e4-4888-b555-4b959cda8efe@gmail.com>
 <20240126000609.GC17237@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240126000609.GC17237@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 8:06 AM, Ricardo Neri wrote:
> On Thu, Jan 25, 2024 at 05:35:32PM +0800, kuiliang Shi wrote:
>>
>>
>> On 1/23/24 4:47 PM, Shrikanth Hegde wrote:
>>>
>>>
>>> On 1/17/24 2:27 PM, alexs@kernel.org wrote:
>>>> From: Alex Shi <alexs@kernel.org>
>>>>
>>>> Current function doesn't match it's comments, in fact, core_idle
>>>> checking is only meaningful with non-SMT.
>>>> So make the function right.
>>>>
>>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>>> To: Valentin Schneider <vschneid@redhat.com>
>>>> To: Vincent Guittot <vincent.guittot@linaro.org>
>>>> To: Peter Zijlstra <peterz@infradead.org>
>>>> To: Ingo Molnar <mingo@redhat.com>
>>>> ---
>>>>  kernel/sched/fair.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 96163ab69ae0..0a321f639c79 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
>>>>   */
>>>>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>>>  {
>>>> -	return (!sched_smt_active()) ||
>>>> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>>>> +	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
>>>> +		(!sched_smt_active() && is_core_idle(cpu));
>>>>  }
>>>
>>> This seems wrong. This would always return false for higher than SMT domains 
>>> if smt is active. 
>>>
>>
>> yes, thanks for point out.
>>
>>> Was this meant to be sched_smt_active() && is_core_idle(cpu)? 
>>
>> In theory, yes, it should like this. But I have no ASYM device to test. :(
> 
> This would not work with !SMT and asym_packing.
> 
> I can test your patches on asym_packing + SMT systems if you post a new
> version.
> 

Hi Neri,

Thanks a lot for generous offer! I don't know if my understanding right, but I try my best to have a best guessing in V2 patch for you. :)

Many thanks for the help!

Best regards
Alex 

