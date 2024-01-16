Return-Path: <linux-kernel+bounces-27757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12A82F56B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C017C1C23A26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889D1D534;
	Tue, 16 Jan 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uEtrcBcX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77991D521
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433641; cv=none; b=DdpqRTEz0tlRbsLrXGIZebAZjQ5Gqm4SIx0thh1gSIqpyCXo0uRnc+80thNaVSr1IvHZNsaQsOf8smdoGE8FY8A5bkzghOujgIHxclRgYMIP1+HZkv8BhRoWZ+56zXRMccyosF5205YWtNWDsdLCh4262I+fQGZf3BI8duZb0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433641; c=relaxed/simple;
	bh=sZuC+lqlMRtSthfLhl2Beei5Sfxpx1sGtt6zGRlEi74=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s5xa0ri4RqzYhMhbrJgI0rSpiLH1oYapXTGpswlbvZmReXgAAWNJONPOQN1GsuD99rT8FMDDyJwZJoNKut2sCzFTN8GhXVHDGid43lzgzmE80oHE874x6WY15/Lg+PkwZohUEw7/tceCLTqPOO3soH1P7FCVnLyOX9i1s52a1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=uEtrcBcX; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e69b3149fso46285725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705433638; x=1706038438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab3ZIwu3XJ3IhNLR4wVJpIpbVXemMTSD7gJ4/J4o6F0=;
        b=uEtrcBcXeQnKlUgNmhi+LoSjwHY0LJ6lNRZXWUbATF0fvvhK3EaNbGLIsheqi6fhdd
         8ggwmP/fRPWdr28LKRcQia5GOSbT4IOizdOAlx3Q+YFHSE4AthZKQwd64A+SgFHL4oSz
         xW/tkap5R7QimdW5vVry9sx6jLeLcMEv0ilsCfo5qljl0v5ISTwm8lEgJIKd6F5HfxIM
         Se9h3b+G34wAlHAuP1aZoEtZrKWoycrMhf8i0h1dLLmX+SjuH/lcxh2+0735Ah0n2I4p
         AKjKK3oJSlcS2yKIU4Z+xiogPxumeB4S4xlLdW/khGSki+A+0Bys5YGFfkrf80+Ds11R
         JNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433638; x=1706038438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab3ZIwu3XJ3IhNLR4wVJpIpbVXemMTSD7gJ4/J4o6F0=;
        b=NLgLE9IxVrVrHRlLN6FpLsqPK3JGc+vzB/3ZmDIR+medSuGi8NB1zpImZSPjl73jxh
         MsGNF3UBCPqK01OE5yASyAOn3zuYvUaHbw6V0Nozj65+aEeOKFQuvMjDdbzjqDixclM5
         WfDa1AZ8ZdxQ99HcHrSUcDzcy9GKZnN3DGtvT6ZlvONps1dmRobIRvX+QtdnbE2XynCi
         uyFdeeWWR/KN6Hy3R77WMMYLixnhtAt4XqitSY/4A6o+W0+z/0oEb9qwNayOwCWK05D+
         DCVA7rALrr0J67lg08lsduEBJlx7tjTIKWorLuOPlW+EA8f0tUK2zu83ae9tdbJ5+VCp
         i4Uw==
X-Gm-Message-State: AOJu0YyfIjLvSZ6cb7ho5em+40en2w9rOiYCfwz9Fw5TerbtiMhVuFYA
	E2IdCNiS+4ITgYWE0decB8rwB/RQxyES7w==
X-Google-Smtp-Source: AGHT+IH/gTXr61TnbTI0B5aEX2OvMWDx1HRWkiT4lTmIOBRxw+YnzAPUCO/kqoR8cWktG4EAbLy8TQ==
X-Received: by 2002:a05:600c:294:b0:40e:63c5:9de6 with SMTP id 20-20020a05600c029400b0040e63c59de6mr4512424wmk.25.1705433637810;
        Tue, 16 Jan 2024 11:33:57 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm20244234wmb.7.2024.01.16.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:33:57 -0800 (PST)
Date: Tue, 16 Jan 2024 19:33:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Message-ID: <20240116193355.44fp2lbfqwpytoft@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
 <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
 <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>
 <20240115122156.5743y4trhm4tkgs3@airbuntu>
 <661068a2-7c46-4703-ba4d-5ce1cdf44b3d@arm.com>
 <20240116131033.45berjhpwzc4hwr7@airbuntu>
 <e74edb50-5dba-4c81-a383-eb97e6bc5f29@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e74edb50-5dba-4c81-a383-eb97e6bc5f29@arm.com>

On 01/16/24 15:34, Lukasz Luba wrote:
> 
> 
> On 1/16/24 13:10, Qais Yousef wrote:
> > On 01/15/24 12:36, Lukasz Luba wrote:
> > > 
> > > 
> > > On 1/15/24 12:21, Qais Yousef wrote:
> > > > On 01/10/24 13:53, Lukasz Luba wrote:
> > > > > 
> > > > > 
> > > > > On 1/4/24 19:23, Qais Yousef wrote:
> > > > > > On 01/02/24 11:47, Lukasz Luba wrote:
> > > > > > > > Did you see a problem or just being extra cautious here?
> > > > > > > 
> > > > > > > There is no problem, 'cost' is a private coefficient for EAS only.
> > > > > > 
> > > > > > Let me  ask differently, what goes wrong if you don't increase the resolution
> > > > > > here? Why is it necessary?
> > > > > > 
> > > > > 
> > > > > 
> > > > > When you have 800mW at CPU capacity 1024, then the value is small (below
> > > > > 1 thousand).
> > > > > Example:
> > > > > power = 800000 uW
> > > > > cost = 800000 / 1024 = 781
> > > > > 
> > > > > While I know from past that sometimes OPPs might have close voltage
> > > > > values and a rounding could occur and make some OPPs inefficient
> > > > > while they aren't.
> > > > > 
> > > > > This is what would happen when we have the 1x resolution:
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:551
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:644
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:744
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:851
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:493
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:493
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:493
> > > > > The bottom 3 OPPs have the same 'cost' thus 2 OPPs are in-efficient,
> > > > > which is not true (see below).
> > > > > 
> > > > > This is what would happen when we have the 10x resolution:
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:5513
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:6443
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:7447
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:8514
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:4934
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:4933
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:4934
> > > > > Here the OPP with 600MHz is more efficient than 408MHz,
> > > > > which is true. So only 408MHz will be marked as in-efficient OPP.
> > > > > 
> > > > > 
> > > > > This is what would happen when we have the 100x resolution:
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:55137
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:64433
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:74473
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:85140
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:49346
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:49331
> > > > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:49346
> > > > > The higher (100x) resolution does not bring that much in
> > > > > practice.
> > > > 
> > > > So it seems a uW is not sufficient enough. We moved from mW because of
> > > > resolution already. Shall we make it nW then and multiply by 1000 always? The
> > > > choice of 10 looks arbitrary IMHO
> > > > 
> > > 
> > > No, there is no need of nW in the 'power' field for this.
> > > You've missed the point.
> > 
> > I think you're missing what I am saying. The multiplication by 10 looks like
> > magic value to increase resolution based on a single observation you noticed.
> > 
> > The feedback I am giving is that this needs to be better explained, in
> > a comment. And instead of multiplying by 10 multiply by 1000. Saying this is
> > enough based on a single observation is not adequate IMO.
> 
> I think you are trying to review something which you don't have full
> details and previous history. I have been fighting with those rounding

I don't think so..

> issues in past and there are commits with description of issues.
> You haven't analyze all edge cases, one more is below (about your
> proposal with 1000x the nW).
> 
> > 
> > Also the difference is tiny. Could you actually measure a difference in overall
> > power with and without this extra decimal point resolution? It might be better
> 
> Yes, I had such power measurements, but for older rounding issues. Take

so not against this series..

> into account that the EM model is reflecting one CPU, but in reality we
> often have 4 CPUs linked together in one frequency domain. Thus, a small
> energy difference is actually multiplied.
> 
> > to run at 816MHz and go back to idle faster. So the trade-off is not clear cut
> > to me.
> 
> It's not the $subject to discuss other possible design which set such
> trade-offs differently. Please don't mix many topics. A "race to idle"

I am not mixing topics. I am questioning the claim about this addition of
resolution which looked random to me.

> from OPPs which have a bit higher voltage is totally different topic,
> currently not in EAS design at all. Otherwise we end up in a heuristic
> issue like: how much more 'inefficient' it has to be to skip it.
> Currently we are strict in 'inefficient' OPP tagging.

Then this part of this patch about the resolution better be split into its own
patch submission?

> 
> > 
> > So generally I am not keen on magic values based on single observations.
> > I think removing this or use 1000 is better.
> 
> That is your opinion. I've tried to explain to you:
> 1) why we cannot remove it and why we need the 10x
> 2) why we don't need more that 10x
> 
> > 
> > AFAICT you decided that 0.1uW is worth caring about. But 0.19uW difference
> > isn't.
> 
> It's not strictly related to power value, but the earlier division
> operation that we perform in setup time and not in runtime (in different
> order on the arguments in the math involved). That operation cuts some
> important information from the integer value (as listed above in those
> different configurations' dumps of 'cost' values).

-ENOPARSE. From what I see the cost has different resolution.

> 
> > 
> > I can't see how much difference this makes in practice tbh. But using more
> > uniform conversion so that the cost is in nW (keep the power field in uW) makes
> > more sense at least.
> 
> This is the edge case which I've mentioned at the begging that you're
> missing some background. Your proposal is to have 1000x resolution so in
> nano-Watts power for the 'cost'. Let's consider example power of 1.4Watt
> on single CPU at mid-high-freq OPP (700 capacity), running on 32bit
> kernel, so unsigned long has 32bit.
> 
> power = 1.4W = 1400000000nW
> 
> cost = 1400000000 / 700 = 2000000 (2mln)
> 
> Then in EAS we can have this simulation:
> 4 CPUs with util 550 voting for this OPP (700 capacity),
> so the em_cpu_energy() would perform:
> 
> return cost * sum_util
> 
> 2000000 * (4 * 550) = 4400000000 <--- overflow on 32bit ulong
> 
> That's why I said you haven't considered your proposal fully.

overflow was in mind, I didn't feel it was necessary to elaborate more..
overflows issues can be handled

> 
> > 
> > It still raises the question whether this minuscule cost difference is actually
> > better taken into account. I think the perf/watt for 816MHz is much better so
> > skipping 600MHz as inefficient looks better to me.
> > 
> 
> This is exactly the place where we disagree. You "think the perf/watt
> for 816MHz is much better so skipping 600MHz as inefficient looks
> better". For me, the numbers from 3 different configuration dumps are
> telling me exactly opposite. I will base the algorithms on the numbers
> and not on a heuristic that I think looks better.
> 
> I'm going to send v7. Please end this discussion on v5.

This thread is the context of the discussion..

It seems you don't want the feedback. I don't think there's mixing of topics.
But decisions made and I don't see proper explanation to them. Hence the
questions and probing proposals in attempt to understand more. We do have to
cover a wide areas of cases in general and enforcing such random numbers has
been a problem in practice as there's no sensible defaults. And I am not seeing
that this is a good generalization from what I am reading. Similar to
util_threshold which has caused power regressions, and migration margin and
dvfs headroom that are causing problems too. I see this is another random
number added. The numbers you're referring to are very limited in scope, it's
not number vs heuristics looks better the issue here. It seems you don't want
to consider the perf/watt impact rather than the pure cost of a single OPP
- which was the true intent behind the question. I might have misunderstood
something, but If you explained this in this reply, I certainly would have lost
it with this constant stop discussing and move to v6 or v7.

Anyway. I'll leave this at here.

