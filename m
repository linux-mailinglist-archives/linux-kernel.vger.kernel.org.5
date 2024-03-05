Return-Path: <linux-kernel+bounces-91509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072887126F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA8286CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B717C76;
	Tue,  5 Mar 2024 01:43:49 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAD18021;
	Tue,  5 Mar 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603029; cv=none; b=rwiusvKDo1fuZgnJciigao0EpeiJ3XxnQXffUrR15MKkmmIgmNXduVcL/H2PoHQrk+oQ6YSCEw89OYY9fybM88yWVjhYD6XrcyVCgh2uTcdw8tEloyvS3OPYqNdFg7Cin6JHcyyaDU6Rtb4EqVSCl4BMY9Y2ZmXMEJfWIrKCuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603029; c=relaxed/simple;
	bh=e+mnsYGFfLAnnUaiJlPfjD4Z9/DJFsSSixlEa444lcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTzre5cEa60BKIFYa20pQPE16I5vZhKbMKL+keVrPNp5LaMvhdDdqkfNbWDx1BpVJkHE/JUmyUl0eWdgW/6klvtSp/rR0FvB90qX+yxyM9sTtotJ1OJ0Nw3EDVwTa5OwjRHFvS9TdQjy9GmV8HuwJ5b9jl6ShczRrCKY2kRzG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1709602999t8s0cfq1
X-QQ-Originating-IP: 2Y1/CnORgBvRWChQmi6gP2CF5l0JJc3fT3u24IZjV8g=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Mar 2024 09:43:17 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: zT6n3Y95oi04/+7BUv1jrvQqdYkuS7cNzRUeWRYQsNZJ+32WHrm68NzsFrBOc
	A8rDBiqUUhPHH3qV/rkc3S83g+Dj5viVWdjiCMeLnV4/QFKS07a8RBZxilOvwXlU2Je1vXw
	QPTrmp8xNNOqr+qCXRfnFD2FuokA6RyIleP4xyeXwdx7GbAna+uqaDIS7HDbDqnyW9o9/jY
	exMmpfZmBPkFT/LkMlUdn1dZt9W5sIjefHT4iZkbFtVWnf8KlDYXlbL6vPrsDqNp3x36T1g
	7tGRMDME+bpA0nt2qO8qv9r0F+I9zGuyAB3UcFuvQsF90BQ2/C/94uptKoqCdpMGsoFaNZy
	7y3BWQFurnJi1UOvL+zueFwMTwZZkN2sVX5SW7rSOzMUrhMESm7b5bYfWNJVPBeCgud0DdD
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 50421180907047513
Message-ID: <ACE696AA8DB8D91B+458ebdd8-6951-4f72-a188-b21dc9863b90@shingroup.cn>
Date: Tue, 5 Mar 2024 09:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/s390/perf: Register cpumf_pmu with type =
 PERF_TYPE_RAW
To: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304022701.7362-1-jialong.yang@shingroup.cn>
 <ZeWVi6pua5QVqz_y@FVFF77S0Q05N>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <ZeWVi6pua5QVqz_y@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

在 2024/3/4 17:34, Mark Rutland 写道:
> On Mon, Mar 04, 2024 at 10:27:01AM +0800, JiaLong.Yang wrote:
>> The struct pmu cpumf_pmu has handled generic events. So it need some
>> flags to tell core this thing.
> 
> It's not necessary to register as PERF_TYPE_RAW in order to handle raw events,
> and PERF_TYPE_RAW is not a flag.
> 
> Have you encountered a functional problem, or was this found by inspection?
> 

As you expected, I'm trying to confirm which one pmu has the capability 
to handle generic events in registering pmus instead of test generic 
events in each pmus when opening.
We can confirm that before using. We have pay more in handling them when 
opening.
So most driver developers use PERF_TYPE_RAW. x86 and arm use 
PERF_PMU_CAP_EXTENDED_HW_TYPE. Others use struct pmu::task_ctx_nr = 
perf_hw_context.
I think PERF_TYPE_RAW will be a easily accepted way. So ...

How do you think about this?

> Mark.
> 
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>>   arch/s390/kernel/perf_cpum_cf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
>> index 41ed6e0f0a2a..6ba36cf50091 100644
>> --- a/arch/s390/kernel/perf_cpum_cf.c
>> +++ b/arch/s390/kernel/perf_cpum_cf.c
>> @@ -1213,7 +1213,7 @@ static int __init cpumf_pmu_init(void)
>>   	debug_register_view(cf_dbg, &debug_sprintf_view);
>>   
>>   	cpumf_pmu.attr_groups = cpumf_cf_event_group();
>> -	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", -1);
>> +	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", PERF_TYPE_RAW);
>>   	if (rc) {
>>   		pr_err("Registering the cpum_cf PMU failed with rc=%i\n", rc);
>>   		goto out2;
>> -- 
>> 2.25.1
>>
>>
> 


