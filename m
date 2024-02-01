Return-Path: <linux-kernel+bounces-48024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE2845662
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410E287ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E215CD6C;
	Thu,  1 Feb 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNK0YPOQ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192439852
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787633; cv=none; b=dG28/IHC2SZNB2sKBWTMxSlyhpaZQUilGpr51hVtrD2fK4CXYrgyiA4ZKN6KRMokw3gbkAw8luJRqcF4svTOw4/eJ1YQMKK5NMU0ehN5yYzE0wjJ4bva1vxyBpvShH5SxH27fxMUN15u4Ka8EoxavKoY3m/RIAV4JGxJGMfw6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787633; c=relaxed/simple;
	bh=ooxgsmDwolcjOc5z3JL9PAyy2HPwV0ZKrDoMbg++r78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYm4l1txX6tfXwtsr2gcrJM2yfyQtiINX3Rqq5E2A9oe8jv3GuMx9dRyNVpoAmAKwCO2pEsweqS3WaAe6OChnv3xlv4pvPKAWBfkIlK5xV3vLknXIb9Tbo0BsbgAZxMj8SbBLRdmoOGVneyIdx34AiQWiM32RDN0pN3CtvEq+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNK0YPOQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so531433a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706787630; x=1707392430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TaNg8LNfDXnOCUMiuqt2O/eC/tk+kH5Sp1RgXLemkg=;
        b=BNK0YPOQZsUji+uHgYPcQgE9jOne+s/UvAAK43hh/O4VJyfDbA3BXHr9zyntu45gej
         p6Y12nvQT0pJMTz83xcVPD27l7AdJd+4rmhE1rrpmAMVbG9ttOHRPsRKmiD01nEKqs+R
         edDi5A6hf44P/dg5xU6EuJ3VdlFktRwOfNWdp2vnOwrPwlOYryMDrabJ4h5lIii+Dwyn
         +LIgYWFgaguYvpM9xsKIAUJ2Zcasy9hjwHDw4LSfJm7MQLDHjtIV53MyEfPCbs0OM+aJ
         Gu2BzdvsHUgxii77spgUPfZCvvro3x5IfpFjvbXFxeiuz/pks/p4Te8mLCblaqHTySoD
         hnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787630; x=1707392430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TaNg8LNfDXnOCUMiuqt2O/eC/tk+kH5Sp1RgXLemkg=;
        b=bieNtx0pwEBvogwtGuDOOtm/iYNf36T5dXjkruXZ9sgH/3KcvHloFaEwsEBYZ2WtDI
         ZyGlCmYr9qRhCp86G/+5W2Th2YuwGBs6uUz5+GBpzYyBNMFFxRTxo1Y56cHECs3JJeCc
         G11YL763I6F7FVGz/oEmiqE2oP3yXfTb8/qqgodUJARBpZsuv3uncnmckVfuFm2ui791
         ohZ17eIhaY85gDLLiEYxtio3ylxx2EJhRQFnrTxxuHA7wxdkB1l3542MxkAqVAtQwyQL
         8rD1uvi+z7+S6DR42rO/LbMXY1egOv5f/4QDdL/NqqIO13D7BODRottUZ7UVcrOhGfRo
         zCoQ==
X-Gm-Message-State: AOJu0YzMYoZniWg6P5kzcu9/pUbob6WY8eNIXMlOD/r7sh11FFBMLp3e
	zJv5QGdudv+bjEVb1YjAkZ904CbprsaJwfFuUHv1+GlrXS55T0hO
X-Google-Smtp-Source: AGHT+IGlZMeKBgeoLSrktOUtG0zh8IbMjwHwM7NK9hrB4ezuIofltKs0YIFufn16yLZHUYlby0t21Q==
X-Received: by 2002:a17:90a:d483:b0:296:435:395c with SMTP id s3-20020a17090ad48300b002960435395cmr3832307pju.3.1706787630142;
        Thu, 01 Feb 2024 03:40:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmXM3AeUzkleAd3GY2R8TsrOl5QV0QRuGvVAN+7wge1rDLLNERUondbV7l7s8+1LtJzAPFY/kwlknBAMy9Z8I+V03AdUU+AmZ1rADXa5fTI1dH3l2G8gVoWycJGLYu0uYN6nxwU8MfQ4nNwckLBVX8OK5mQsHL+NiqvtRBSpd3GGbP0MJNMVXJYVRJRusa5dAqilLwkYMob8SWKSqKekeMIRNxcRRyzudA0VFv2HBK2O+4DzcxZ/OxNaZnoTF/kCjk3IjD20c6iiG7EmfbRHwrefB8bouP+fPmQUMr17km0hl4h32VlviWo/bMWic0wJ/c/en0a1ziIFs4vGzrFJ6KctT1St6J+bNu/ArHzuyX+AnDx+HtUnlpf4rBThw8edSEpy8F+1rkEs8j
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id jx14-20020a17090b46ce00b002902076c395sm3322401pjb.34.2024.02.01.03.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:40:29 -0800 (PST)
Message-ID: <4a6d2404-46ab-41ca-856e-e4cbfebba185@gmail.com>
Date: Thu, 1 Feb 2024 19:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6 RFT] sched/fair: change sched asym checking
 condition
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
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-6-alexs@kernel.org>
 <20240201011038.GD18560@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240201011038.GD18560@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 9:10 AM, Ricardo Neri wrote:
> On Tue, Jan 30, 2024 at 09:17:08PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> Asym only used on SMT sd, or core sd with ITMT and core idled.
>> !sched_smt_active isn't necessary.
> 
> sched_smt_active() is implemented as a static key. Thus, if SMT is not
> enabled, we can quickly return without having to check the rest of the
> conditions, as we should.

Hi Ricardo,

Thanks a lot for comments! I will drop this patch in this series.

But forgive my stupidity, asym feature is possible when SMT enabled instead of SMT disable. Why no SMT is a condition for asm feature? For this asym feature, I only see the SMT and MC domain use this, correct me if I'm wrong. 

> 
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: linux-kernel@vger.kernel.org
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Daniel Bristot de Oliveira <bristot@redhat.com>
>> To: Ben Segall <bsegall@google.com>
>> To: Steven Rostedt <rostedt@goodmis.org>
>> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Juri Lelli <juri.lelli@redhat.com>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6680cb39c787..0b7530b93429 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9744,8 +9744,8 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  	if (!(sd->flags & SD_ASYM_PACKING))
>>  		return false;
>>  
>> -	return (!sched_smt_active()) ||
>> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>> +	return (sd->flags & SD_SHARE_CPUCAPACITY) ||
>> +		(is_core_idle(cpu) && test_bit(cpu_core_flags(), (void *)&sd->flags));
> 
> cpu_core_flags() can contain more than one flag, AFAICS. Which bit should
> it check? Moreover, it is implemented differently for each architecture.

It seems only x86 using the function. But there is still a error which SMT/CLUSTER domain also has this flags bit.
$ git  grep 'cpu_core_flags('
arch/x86/kernel/smpboot.c:      return cpu_core_flags() | x86_sched_itmt_flags();
include/linux/sched/topology.h:static inline int cpu_core_flags(void)

> Also, as stated, in x86 asym_packing is also used in domains other than MC.

For the feature SD_ASYM_PACKING and SD_ASYM_CPUCAPACITY, for guts of 2 features, is it possible to combine them into one, if we give a little bit more capacity to priority cpus, like 5%?

Thanks
Alex

