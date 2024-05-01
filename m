Return-Path: <linux-kernel+bounces-165417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3EF8B8C76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85861C21865
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C77412F38C;
	Wed,  1 May 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gXpYvfIU"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4A38DDC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576205; cv=none; b=ZZDBUSiljEpOdZUbSN4Z/ft/Pb1iFX4qFZjxK3Akh/96y9ubTXfl4LOfkVnfnkP1K+hZERu+N4jeY3/Rt1PY7LTXsOpWlW5/tNEhELD36M0/p+mmLE4+w3Q2dAr9L3Z/7NegzU5e4i/8yf/3m46t/pNpWkNbRwi8oq0cPm489pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576205; c=relaxed/simple;
	bh=O0uJqRaXBRd9ZBmmGXmC8diK6l4BeSpUI9fWV6EndUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWdGfscn/egHw11HA+eYbyhSvzShytcCJdHNWfI7mpjYMARTqAzsh222lQOSHP/rvdSsPnHpgg8tsQ4bPd48f4IhcPX+kDVXfny3tyTzdKNT5VfCv/J1RycfPwptidLZfsCUTk2PvkCtih+yabJyqkXhW3Mvw3viZ75qBMF+bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gXpYvfIU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ODudOxrddT3A4z1QE7+55p3tSTQPhao8h4ys35QEMtk=; b=gXpYvfIUiqLTyxWVdb1HMKk5rH
	jeOZNCGpWy5wj0/UwBu9EXoHyAP+MwIqlLfqOKx+j3ZXQ2YC2Cx0fYvMu0KUN5BpS7McAm1+FAg8V
	wSiGr8hSX4tKNRFJGq6bMnqfjlTvdGLI+FMdF28GIv4EC/dUxABegSpEpwLenhHS7YFInJsEWGGIG
	gpmd/lFZIRCbOsAP9+OBhKWRSq5wue4b7lrY8ULaSCrlYNBt2m1K20xg1LbYMGzXuyGHWGFBMx2kc
	B6LnWk2FgWwyQyiTUfX1MaxkmzoUP574c/JJjb8MSIWyh9Bsc9mnwSXPozIrlOIGa6nyGj5y5RzNX
	ESgyrNyA==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s2Bah-002d6o-IM; Wed, 01 May 2024 17:09:51 +0200
Message-ID: <91c82905-4319-470c-8797-3c6effa7e32c@igalia.com>
Date: Wed, 1 May 2024 16:09:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/psi: Optimise psi_group_change a bit
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Suren Baghdasaryan <surenb@google.com>, Peter Ziljstra
 <peterz@infradead.org>, kernel-dev@igalia.com,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>
References: <20240329160648.86999-1-tursulin@igalia.com>
 <20240329185147.GA877460@cmpxchg.org> <20240409223847.GE1057805@cmpxchg.org>
 <99b39d9e-1fae-41a5-96f9-d1298c7cc29c@igalia.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <99b39d9e-1fae-41a5-96f9-d1298c7cc29c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

Adding more scheduler maintainers to Cc - hopefully someone can merge to 
the relevant tree?

Thanks,

Tvrtko

On 18/04/2024 09:54, Tvrtko Ursulin wrote:
> 
> Hi Ingo,
> 
> On 09/04/2024 23:38, Johannes Weiner wrote:
>> [ Oops, I still had an old mutt alias for Ingo's address. ]
>>
>> Ingo, would you mind taking this through the scheduler tree?
> 
> Gentle reminder so this one does not fall through the cracks.
> 
> Regards,
> 
> Tvrtko
> 
>> On Fri, Mar 29, 2024 at 02:51:53PM -0400, Johannes Weiner wrote:
>>> On Fri, Mar 29, 2024 at 04:06:48PM +0000, Tvrtko Ursulin wrote:
>>>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>>>>
>>>> The current code loops over the psi_states only to call a helper which
>>>> then resolves back to the action needed for each state using a switch
>>>> statement. That is effectively creating a double indirection of a kind
>>>> which, given how all the states need to be explicitly listed and 
>>>> handled
>>>> anyway, we can simply remove. Both the for loop and the switch 
>>>> statement
>>>> that is.
>>>>
>>>> The benefit is both in the code size and CPU time spent in this 
>>>> function.
>>>> YMMV but on my Steam Deck, while in a game, the patch makes the CPU 
>>>> usage
>>>> go from ~2.4% down to ~1.2%. Text size at the same time went from 
>>>> 0x323 to
>>>> 0x2c1.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>>> Cc: Peter Ziljstra <peterz@infradead.org>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: kernel-dev@igalia.com
>>>
>>> This is great.
>>>
>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> Ingo, would you mind please taking this through the scheduler tree? I
>>> think Peter is still out.
>>>
>>> Remaining quote below.
>>>
>>> Thanks
>>>
>>>> ---
>>>>   kernel/sched/psi.c | 54 
>>>> +++++++++++++++++++++++-----------------------
>>>>   1 file changed, 27 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>> index 7b4aa5809c0f..55720ecf420e 100644
>>>> --- a/kernel/sched/psi.c
>>>> +++ b/kernel/sched/psi.c
>>>> @@ -218,28 +218,32 @@ void __init psi_init(void)
>>>>       group_init(&psi_system);
>>>>   }
>>>> -static bool test_state(unsigned int *tasks, enum psi_states state, 
>>>> bool oncpu)
>>>> +static u32 test_states(unsigned int *tasks, u32 state_mask)
>>>>   {
>>>> -    switch (state) {
>>>> -    case PSI_IO_SOME:
>>>> -        return unlikely(tasks[NR_IOWAIT]);
>>>> -    case PSI_IO_FULL:
>>>> -        return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
>>>> -    case PSI_MEM_SOME:
>>>> -        return unlikely(tasks[NR_MEMSTALL]);
>>>> -    case PSI_MEM_FULL:
>>>> -        return unlikely(tasks[NR_MEMSTALL] &&
>>>> -            tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
>>>> -    case PSI_CPU_SOME:
>>>> -        return unlikely(tasks[NR_RUNNING] > oncpu);
>>>> -    case PSI_CPU_FULL:
>>>> -        return unlikely(tasks[NR_RUNNING] && !oncpu);
>>>> -    case PSI_NONIDLE:
>>>> -        return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
>>>> -            tasks[NR_RUNNING];
>>>> -    default:
>>>> -        return false;
>>>> +    const bool oncpu = state_mask & PSI_ONCPU;
>>>> +
>>>> +    if (tasks[NR_IOWAIT]) {
>>>> +        state_mask |= BIT(PSI_IO_SOME);
>>>> +        if (!tasks[NR_RUNNING])
>>>> +            state_mask |= BIT(PSI_IO_FULL);
>>>>       }
>>>> +
>>>> +    if (tasks[NR_MEMSTALL]) {
>>>> +        state_mask |= BIT(PSI_MEM_SOME);
>>>> +        if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
>>>> +            state_mask |= BIT(PSI_MEM_FULL);
>>>> +    }
>>>> +
>>>> +    if (tasks[NR_RUNNING] > oncpu)
>>>> +        state_mask |= BIT(PSI_CPU_SOME);
>>>> +
>>>> +    if (tasks[NR_RUNNING] && !oncpu)
>>>> +        state_mask |= BIT(PSI_CPU_FULL);
>>>> +
>>>> +    if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
>>>> +        state_mask |= BIT(PSI_NONIDLE);
>>>> +
>>>> +    return state_mask;
>>>>   }
>>>>   static void get_recent_times(struct psi_group *group, int cpu,
>>>> @@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group 
>>>> *group, int cpu,
>>>>   {
>>>>       struct psi_group_cpu *groupc;
>>>>       unsigned int t, m;
>>>> -    enum psi_states s;
>>>>       u32 state_mask;
>>>>       groupc = per_cpu_ptr(group->pcpu, cpu);
>>>> @@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group 
>>>> *group, int cpu,
>>>>           return;
>>>>       }
>>>> -    for (s = 0; s < NR_PSI_STATES; s++) {
>>>> -        if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
>>>> -            state_mask |= (1 << s);
>>>> -    }
>>>> +    state_mask = test_states(groupc->tasks, state_mask);
>>>>       /*
>>>>        * Since we care about lost potential, a memstall is FULL
>>>> @@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
>>>>       /*
>>>>        * After we disable psi_group->enabled, we don't actually
>>>>        * stop percpu tasks accounting in each psi_group_cpu,
>>>> -     * instead only stop test_state() loop, record_times()
>>>> +     * instead only stop test_states() loop, record_times()
>>>>        * and averaging worker, see psi_group_change() for details.
>>>>        *
>>>>        * When disable cgroup PSI, this function has nothing to sync
>>>> @@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
>>>>        * would see !psi_group->enabled and only do task accounting.
>>>>        *
>>>>        * When re-enable cgroup PSI, this function use 
>>>> psi_group_change()
>>>> -     * to get correct state mask from test_state() loop on tasks[],
>>>> +     * to get correct state mask from test_states() loop on tasks[],
>>>>        * and restart groupc->state_start from now, use .clear = .set 
>>>> = 0
>>>>        * here since no task status really changed.
>>>>        */
>>>> -- 
>>>> 2.44.0
>>>>

