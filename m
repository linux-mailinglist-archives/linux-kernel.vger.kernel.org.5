Return-Path: <linux-kernel+bounces-79643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40586252C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA06B218E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD73446DE;
	Sat, 24 Feb 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bJahFEi+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06B43AB7;
	Sat, 24 Feb 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782244; cv=none; b=W+o1ADnSrGmHu4ZbHIDml3TleTtqOrPCjrm59bNu6eSWhGl5c+U274RWB27tQiRFrIq498fK9RS1qs4uuhPoFZErO+iV/k+Onc2/G57vhiM6OeuxRVLXbbhkao6SIqjZJoXlDXMuwgEI2KtgUr3pUY0EJjUS5loOQDCcF3pR0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782244; c=relaxed/simple;
	bh=TaMAjuxK0M1/m1+E5BavhTKhJuPyR1t8GMHXzHJ3M6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjqOPYieCMmdkkThAxPnaeArnXdiIZ8CkzCKGVoZQ8zn+H4JSegiFZ4WMh3T9aSq6n3+eaE3wRRl2ni1dKHCh8DSgjWB2lJT+9q7vK+BSrdTCAJ6M6PPRE0Azsz9rW0AuydYH38sT0eFqqn5whHZMhqoQg6DSjnkr8Ej7UFxRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bJahFEi+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=6wjvGHv5rABfYh1OC9kfAOfTV9TqIB8vdA16HuVPu/k=;
	t=1708782241; x=1709214241; b=bJahFEi+DIFrvS5pc88TVZlTRNVycCgNw/aAN9JxP1KBnNZ
	lKFisCqiX0RTkNSWu627RfMFvI5OditP1CXi1tD2jh8fv0VfxA901o781Fh0B4nL5nUQpj/uRQ82p
	/t6njDZn9VSvJWdyQkQWCD0C84bT4GlYUYuHS2mCrme/wxXAEsJ3ewxfiMgsRp50GFFeLvrRU4uQn
	ptj/7ugYC9at0vWwU6mFfxdpOHLWZJ/JxhvU3/daJRFAMBXhqHTP33WPRJg7WNa4eP7C2oEdC55/M
	FolgGzztVF5S+FCP0wFAap3p8Qhn/w3CYQo5JzjnnpvR5g2JrKPOGXt6TOcNbFxw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rdsJm-0002R8-Eb; Sat, 24 Feb 2024 14:43:54 +0100
Message-ID: <c03533dc-73fc-4d97-8248-0affbddbed32@leemhuis.info>
Date: Sat, 24 Feb 2024 14:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
Content-Language: en-US, de-DE
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
 <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
 <003801da5bae$02d6f550$0884dff0$@telus.net>
 <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
 <000b01da5d09$8219f900$864deb00$@telus.net>
 <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com>
 <001b01da5ea7$86c7a070$9456e150$@telus.net>
 <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
 <003001da6061$bbad1e30$33075a90$@telus.net>
 <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CAKfTPtC82YXOw5yYPNkHHyF+DYSG+Ts9OjnwsVjbd_HcUsZQMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708782241;a9f43a03;
X-HE-SMSGID: 1rdsJm-0002R8-Eb

On 16.02.24 14:17, Vincent Guittot wrote:
> On Thu, 15 Feb 2024 at 23:53, Doug Smythies <dsmythies@telus.net> wrote:
>>
>> This email thread appears as if it might be moving away from a regression
>> caused by your commit towards a conclusion that your commit exposed
>> a pre-existing bug in the intel_psate.c code.
> Ok

Well, even in that case it's a regression that must be fixed -- ideally
before 6.8. Did anything happen towards that?

I noticed that Doug send the fix "cpufreq: intel_pstate: fix pstate
limits enforcement for adjust_perf call back":
https://lore.kernel.org/all/20240217213010.2466-1-dsmythies@telus.net/

Is that supposed to fix the problem? Looks a bit like it, but I'm not
totally sure. In that case I'd say it likely should be applied to 6.8,
but Rafael apparently applied it to 6.9.

I'd also say that a Fixes: would be good as well (to ensure that fix is
also backported in case anyone backports 9c0b4bb7f630), but I know that
subsystems handle this differently.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> Therefore, I have moved Rafael from the C.C. line to the "to" line and
>> added Srinivas.
>>
>> On 2024.02.14 07:38 Vincent wrote:
>>> On Tue, 13 Feb 2024 at 19:07, Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2024.02.13 03:27 Vincent wrote:
>>>>> On Sun, 11 Feb 2024 at 17:43, Doug Smythies <dsmythies@telus.net> wrote:
>>>>>> On 2024.02.11 05:36 Vincent wrote:
>>>>>>> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
>>>>>>>> On 2024.02.09.14:11 Vincent wrote:
>>>>>>>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
>>>>>>>>>>
>>>>>>>>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
>>>>>>>>>>
>>>>>>>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
>>>>>>>>>> sched/cpufreq: Rework schedutil governor performance estimation
>>>>>>>>>>
>>>>>>>>>> There was previous bisection and suggestion of reversion,
>>>>>>>>>> but I guess it wasn't done in the end. [1]
>>>>>>>>>
>>>>>>>>> This has been fixed with
>>>>>>>>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
>>>>>>>>
>>>>>>>> Okay, thanks. I didn't find that one.
>>>>>>>>
>>>>>>>>>> The regression: reduced maximum CPU frequency is ignored.
>>>>>>
>>>>>> Perhaps I should have said "sometimes ignored".
>>>>>> With a maximum CPU frequency for all CPUs set to 2.4 GHz and
>>>>>> a 100% load on CPU 5, its frequency was sampled 1000 times:
>>>>>> 28.6% of samples were 2.4 GHz.
>>>>>> 71.4% of samples were 4.8 GHz (the max turbo frequency)
>>>>>> The results are highly non-repeatable, for example another sample:
>>>>>> 32.8% of samples were 2.4 GHz.
>>>>>> 76.2% of samples were 4.8 GHz
>>>>>>
>>>>>> Another interesting side note: If load is added to the other CPUs,
>>>>>> the set maximum CPU frequency is enforced.
>>>>>
>>>>> Could you trace cpufreq and pstate ? I'd like to understand how
>>>>> policy->cur can be changed
>>>>> whereas there is this comment in intel_pstate_set_policy():
>>>>>        /*
>>>>>         * policy->cur is never updated with the intel_pstate driver, but it
>>>>>         * is used as a stale frequency value. So, keep it within limits.
>>>>>         */
>>>>>
>>>>> but cpufreq_driver_fast_switch() updates it with the freq returned by
>>>>> intel_cpufreq_fast_switch()
>>>>
>>>> Perhaps I should submit a patch clarifying that comment.
>>>> It is true for the "intel_pstate" CPU frequency scaling driver but not for the
>>>> "intel_cpufreq" CPU frequency scaling driver, also known as the intel_pstate
>>>> driver in passive mode. Sorry for any confusion.
>>>>
>>>> I ran the intel_pstate_tracer.py during the test and do observe many, but
>>>> not all, CPUs requesting pstate 48 when the max is set to 24.
>>>> The calling request seems to always be via "fast_switch" path.
>>>> The root issue here appears to be a limit clamping problem for that path.
>>>
>>> Yes, I came to a similar conclusion as well. Whatever does schedutil
>>> ask for, it should be clamped by  cpu->max|min_perf_ratio.
>>
>> Agreed. And it is not clamping properly under specific conditions.
>>
>>> Do you know if you use fast_switch or adjust_perf call back ?
>>
>> I am not certain, but I think it uses "adjust_perf" call back.
>> I do know for certain that it never takes the
>> "intel_cpufreq_update_pstate" path
>> and always takes the
>> "intel_cpu_freq_adjust_perf" path.
> 
> intel_cpu_freq_adjust_perf is registered as the callback for
> cpufreq->adjust_perf
> 
>>
>> The problem seems to occur when that function is called with:
>> min_perf = 1024
>> target_perf = 1024
>> capacity = 1024
>>
>> Even though cpu->max_perf_ratio is 24, the related HWP MSR,
>> 0x774: IA32_HWP_REQUEST, ends up as 48, 48, 48 for min, max, des.
>>
>> This patch appears to fix the issue (still has my debug code and
>> includes a question):
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index ca94e60e705a..8f88a04a494b 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -2987,12 +2987,22 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
>>         if (min_pstate < cpu->min_perf_ratio)
>>                 min_pstate = cpu->min_perf_ratio;
>>
>> +//     if (min_pstate > cpu->pstate.max_pstate)   /* needed? I don't know */
>> +//             min_pstate = cpu->pstate.max_pstate;
>> +
>> +       if (min_pstate > cpu->max_perf_ratio)
>> +               min_pstate = cpu->max_perf_ratio;
>> +
>>         max_pstate = min(cap_pstate, cpu->max_perf_ratio);
>>         if (max_pstate < min_pstate)
>>                 max_pstate = min_pstate;
>>
>>         target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
>>
>> +       if((max_pstate > 40) || (max_pstate < 7) || (min_pstate < 7) || min_pstate > 40 || target_pstate > 40){
>> +               pr_debug("Doug: t: %d : min %d : max %d : minp %d : maxp %d : mnperf %lu : tgperf %lu : capacity %lu\n", target_pstate, min_pstate, max_pstate, cpu->min_perf_ratio, cpu->max_perf_ratio, min_perf, target_perf, capacity);
>> +       }
>> +
>>         intel_cpufreq_hwp_update(cpu, min_pstate, max_pstate, target_pstate, true);
>>
>>         cpu->pstate.current_pstate = target_pstate;
>>
>> With the patch, I never hit the debug statement if the max CPU frequency is limited to 2.4 GHz,
>> whereas it used to get triggered often.
>> More importantly, the system seems to now behave properly and obey set CPU frequency limits.
>>
>>

