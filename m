Return-Path: <linux-kernel+bounces-38281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA683BD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59CD1F2F271
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB811CAAE;
	Thu, 25 Jan 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuaFTqc0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBD1CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175338; cv=none; b=P9r7i+R0g9DddSGcUXG111mSt1+yojwZETHWyIKbdXGJEzIB2O9FCsBdeYOMtbael/DNkMuPCRSLOOAq0/wH7/b+NTvKDIT4vnbxwcwuUvM63WvVSA3jga9mJjdfmjBBi2eTV+bp3yN6fubLoxEzbCxllJRBYfj8KiCYCYxQ8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175338; c=relaxed/simple;
	bh=y+fBajSv2Ycf+hcVnRxBudKhjS2PD9EMVpwQuvpP6SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duL7HALQHQXxnGYU1eFeM6bIayDpn+zNSWs3M970R6QwAdaGiQ8AgfkAd5llKfm1HZao6G321CNe1CAGxJvotaVJ2zS7wqP/Y3/QBLDGtYxzy60AtS2Dh/lmVYcupoBPCz5+3dZ94KeHHknbdxdJtbgkGPHIhpURFcnvvXcD9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuaFTqc0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd72c4eb4aso2512602b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706175336; x=1706780136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJGDUz4LhWJKK7q0Vv2qvt5/jXmabq414Hes2lyLBRE=;
        b=VuaFTqc0lmjQMTT0JK/6XquYszPc9QONGm4H9jJrt+Vip5fzVkUPOn8OMjw+BdGjae
         cQuGBkEWdgPXvlf662iSZVAYuujhp0RzjJgWrIVPIXGvixKHzSgcoJFNKratYXo5n2x9
         iEXaM2PN/Se9lejWQyC+33Q6IqiC9ON40iwz8+rgTsKriMrJDdkENN8HME4AmgqAcc69
         IS3YKVLmiQelDhJ5oxqc0K2KspnVlUo0rPOaSxOW7gmoVstagr3SGSEV8ryuPYs4hkSU
         3isJLoeqZ4zxpT9u86EcTYsqHzld9s5qGNctOWT8D30uIFsJseyiM5BCgbgqIJCs9i/q
         j3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175336; x=1706780136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJGDUz4LhWJKK7q0Vv2qvt5/jXmabq414Hes2lyLBRE=;
        b=aN50L1MPCkNuXETSV7szRkzrTUkr0x+xHkMIszoJie2KfcYGW7oJLF7DbcRT4/hwpB
         zLOtiyDnG9Rh/y9gIMR903Tq+7Zn5DoF++eSvKLUeepxibHvyKJcquE4hipskYTSe66w
         QRC64X97yxHcr5GcEF6QZYfBeQH6y6gj4evK2bUSoDuOH5Uq9vpD1x+B0oj1/g203m4p
         /6C/BuD4zX1yO5BWgJ3wT0+hFyunptYc6B2oyd9DU0lAmGjgGyPls35UtRfkq5Y+D970
         Siy4IaOkSfeGI3lDatVnGM2YU3MUy7raRGIVE5wMPV8/gjo7vvO+lnEC/RTcUFl8gLho
         WicA==
X-Gm-Message-State: AOJu0YwAwroY8Oc5OQXkXdg+WQUjklG2FXEc5m6r0nrAw52yThYkQ78f
	1zQAabqk9LH8H9ZgLlcBjPQjrsxuzxPka8l71K/Cl8EFYOK/mQMBW32zwSn4nq416g==
X-Google-Smtp-Source: AGHT+IHlZ4f/2NN9T5E5RVf5pdFWzyCS6ZkrIcyHI+LxEcKr++ZoWA3OQBOlkKQXNmlTcMqyoLxJpg==
X-Received: by 2002:a05:6a20:734f:b0:199:d9c9:2b65 with SMTP id v15-20020a056a20734f00b00199d9c92b65mr735057pzc.55.1706175336350;
        Thu, 25 Jan 2024 01:35:36 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001d6f33c6541sm11665817plb.285.2024.01.25.01.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:35:35 -0800 (PST)
Message-ID: <e5b4eb14-c8e4-4888-b555-4b959cda8efe@gmail.com>
Date: Thu, 25 Jan 2024 17:35:32 +0800
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 4:47 PM, Shrikanth Hegde wrote:
> 
> 
> On 1/17/24 2:27 PM, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> Current function doesn't match it's comments, in fact, core_idle
>> checking is only meaningful with non-SMT.
>> So make the function right.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 96163ab69ae0..0a321f639c79 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
>>   */
>>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  {
>> -	return (!sched_smt_active()) ||
>> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>> +	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
>> +		(!sched_smt_active() && is_core_idle(cpu));
>>  }
> 
> This seems wrong. This would always return false for higher than SMT domains 
> if smt is active. 
> 

yes, thanks for point out.

> Was this meant to be sched_smt_active() && is_core_idle(cpu)? 

In theory, yes, it should like this. But I have no ASYM device to test. :(

Thanks!
Alex

> 
>>  
>>  static inline bool _sched_asym(struct sched_domain *sd,

