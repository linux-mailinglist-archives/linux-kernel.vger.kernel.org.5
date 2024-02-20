Return-Path: <linux-kernel+bounces-73273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0C85C04C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2FC1F21AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EC762FA;
	Tue, 20 Feb 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hQSLZ/6u"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECA76059
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444057; cv=none; b=SaUuHc7ox78mRIy4Q9mgk1zq6I+1E3OxhFCJMxrJcjEF89s2w4lfLXoBTLH70iRAfMqcQKRGsVctxwHTuCto+/2O5hH7Qb3n8WfFk9r6Ft137Li81t1smGKJuOWOFPvp6WTt07ioNwm5hCXPm08wm6DFqJ+QkjCoOjNkfc1BMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444057; c=relaxed/simple;
	bh=o1q2KJLC/ep+5zlyk1aEauwIRlmL3BolEXOX/8vFivQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlTyrB1uJkLnlmQs/k0Vm3hdbUgTwIFcZbtd9aDdjtn4D2DNm/mR4nAr7w7a/8JP+aQ8dkuONYikC7gqqCtZZvmKE1TATqRUDJg3BBC7XQYnaZEpl/JS0J8l1/Wvp/BdKjF+qILvVlVD3OYcGXSz3LPfLjdH7inav8wiotB8VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=hQSLZ/6u; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so684502866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708444053; x=1709048853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmKeO3SrUAnQUQ1qjk/xcUWMJTT3mFCsw1UFgof0hBk=;
        b=hQSLZ/6udvv6kQi3vbWHNRXwkOBlYjCDojw2J7oyRDMmYwAFfrmQnlruus5+b/kqqB
         i5O5DQ/siqMPLJKK9Of8X2ok5JI3TtpARmRqcv0t7Tuvo8yAjhaR45ThcAA040U1XTLa
         9LPP95D+L4eVppavmCd1NzVuzOJRChBhqEdJgOhkx57uacUlu/IwDCkGYkhCZ6qswNp8
         frpxLWNJjpCsd3OztBPbaoBogEB6ZUClP0bP6CttKMhDliUhseUkhDvIkuPMwYxLj/nv
         cnj/sejOb0CjcN95BlmNj3iLTwh8i1FBjqq7DKpHUQHyh+lszBvwHjNk0GRBpkdM59X5
         8WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444053; x=1709048853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmKeO3SrUAnQUQ1qjk/xcUWMJTT3mFCsw1UFgof0hBk=;
        b=fvoGz9YbrnfX2oEXbwAP7U5467D66LHO61O9X1cVtMbVJmuRmRZoPhLgH7Nq2/uHSP
         wUrdo50FQFYRja4NEPDYlvePfnZ3LrQ6HiMwd0JVpcK+ZSMnSJJ9YzA9wL9CrnVGsz5h
         494csw+hWTpu6zV9jOxeDtCSepGfXiZ7l3WEZAIurOFe572y4PU7KKKcG/63DMf48CIH
         3i6RiEm3tbw4voClz2mxL3d+mNUTqaNhGa25sTBv4QfBsEOqrno6a17jWrsytcgLuLGX
         c3W+QRll4rUoM80Wxb2VndVHYBhcDnEtWfGvX3fTedL/FoOJc3MgJ5ipNNgIwpvvb66j
         9Enw==
X-Forwarded-Encrypted: i=1; AJvYcCWK7+FMRX18sOquv4iU4IVlZezUvkAJF57EL7Y9ETj2ZYlx6zJR8ChVCBEtum5aUJ0vWZAREUfAkOBIM4VoUHvNJiUDVil68SVakwpF
X-Gm-Message-State: AOJu0YyY01w/Kq/9Cy9+99PL4HDmnSi7ZAcqKOghcJqixr2rE6XypSsp
	BT/UO006QcJGDj27uSyGTKzRxpzVvg+OwLzFNdDjrnej4ttoz99+Ea64dSuxvF4=
X-Google-Smtp-Source: AGHT+IFJoZqvRJziJG7H9sCCpZIDcUZbowJ7Y/gZQF2SG2Kzgj6U4NrCRzOQs7IpjwKWe5lLfODFxw==
X-Received: by 2002:a17:906:2319:b0:a3e:ce5a:bba5 with SMTP id l25-20020a170906231900b00a3ece5abba5mr2919988eja.60.1708444053565;
        Tue, 20 Feb 2024 07:47:33 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id r16-20020a1709067fd000b00a3e88f99cf1sm2398776ejs.149.2024.02.20.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:47:33 -0800 (PST)
Date: Tue, 20 Feb 2024 15:47:31 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org, David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v2 0/7] uclamp sum aggregation
Message-ID: <20240220154731.ujnbaa65djmiroco@airbuntu>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <20240206152054.k3uskf3rhd4icmzt@airbuntu>
 <1cc2b8c4-ea0e-4e98-a1a3-2916cccb1ab1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cc2b8c4-ea0e-4e98-a1a3-2916cccb1ab1@arm.com>

On 02/06/24 17:32, Hongyan Xia wrote:
> On 06/02/2024 15:20, Qais Yousef wrote:
> > On 02/01/24 13:11, Hongyan Xia wrote:
> > 
> > > [1]: https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.com/
> > 
> > Their solution is not acceptable for the same reason yours isn't. Saravana and
> > David know this and we discussed at LPC. uclamp hints are limits and should not
> > be summed.
> 
> Uclamp is a performance hint and nothing in its definition says it can't be

That's the major problem here. The definition says it can't be summed because
they're limits. So if two tasks boosted to 1024, then their combined
performance limit is 2048? Or if 4 tasks are capped to 512, then the combined
limits is 2048? You're changing the behavior. If not, please help me understand
how not. You're treating them as 'bandwidth' hints.

> summed. Clearly whether a uclamp approach should be taken should be
> determined by how well it works as a hint, not by how we calculate it. I
> would not say I want to reject max aggregation simply because it throws away
> all other uclamp values except the max. It's because I have real evaluation
> results showing sum aggregation works as a much better hint.

It is easy to get numbers that shows improvements. That doesn't necessarily
mean it is correct.

> 
> > > [2]: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510
> > 
> > I think I clarified several times so far that this is not related to uclamp.
> > Could you please refrain from referring to it again in the future? This is
> > misleading and neither helps your cause nor its cause. The fact that you're
> > relating to it makes me very worried as both links demonstrate lack of
> > understanding/confusion of what uclamp is supposed to be.
> 
> The intention of the code is irrelevant. What I'm talking about is what

It is relevant.

1. You failed to get consent on using this an example.
2. You failed to demonstrate the purpose of the code and why it was
   actually added. I don't think you know the full details anyway.
3. You're using a hack that is problematic and needs to be deleted as a proof
   of something good that _we do not want_.
4. How do you know it works as you think it is? You're making wrong assumptions
   that are misleading and quite frankly annoying.

Generally we don't want to discuss this in this venue. So for the last time
please stop bringing it up altogether and let's focus on the problems you are
seeing and trying to fix and leave other people's code out of the discussion.

> effect the code actually has. The fact that you keep thinking I don't
> understand what the code does even after me explaining "I know what the
> intention of the code is, I'm just talking about the actual effect of the
> code" is an even more worrying sign.
> 
> > Again, this solution is not acceptable and you're moving things in the wrong
> > direction. We don't want to redesign what uclamp means, but fix some corner
> > cases. And you're doing the former not the latter.
> 
> I'm saying max aggregation is not effective and proposing a more effective
> implementation. In fact, you have sent a series that removes max
> aggregation. Clearly that does not count as fixing corner cases but is
> actually a redesign, and I don't understand why you are allowed to do such
> things and I am not. Also, when something becomes harder and harder to fix,
> a redesign that solves all the problems is clearly justified.

I don't have issues with max aggregation removal. I actually would love to see
it gone. But summing uclamp values changes the meaning of uclamp hints. Which
is my number 1 concern.

And you're lumping too many problems to max aggregations. It was brought up
several times that overutilized definition being tied to misfit is not fit for
purpose anymore. This needs to be fixed. feec() fails to distribute fairly when
capacities are equal. This is a known old problem. This needs fixing. energy
computation needs to evolve to deal with a number of new realities. This needs
fixing. Load balancer can't correct bad decision at wake up in aligned way with
feec(), this needs fixing. Adding a new signal is not the right way to fix
these problems. And the only issue with max-aggregation in practice is the fact
it is not effective in restricting power use for uclamp_max. It has also the
minor problem of boosting unnecessarily for the duration of enqueue of the
task. The correct behavior we want and other vendors has expressed to me in the
past is to apply the boost/cap only when required; ie the task is running. The
hardware can cope with this. And this is tied to how cpufreq governor works and
if there are hardware limitations that makes this hard to achieve, then it is
up to the governor to decide this, not the scheduler. We already have util_avg
and util_est. I really don't think we need another addition. We just need to
fix issues else where and improve the interface with the cpufreq governor to
honour the performance limits the tasks have so that we can get rid off
max-aggregation.

> 
> What I can summarize from sum aggregation is:
> 
> Pros:
> 1. A more effective implementation, proven by evaluation numbers
> 2. Consuming the same or even less power in benchmarks
> 3. 350 lines of code in total, less than half of max aggregation
> 4. This series shows the entirety and effectiveness of sum aggregation, at
> this very moment, today. Max aggregation needs further filtering and load
> balancing patches which we have not seen yet.
> 5. Resolves the drawbacks from max aggregation (which you might say is the
> same as 4)
> 6. Significantly reduces uclamp overhead, no bucket operations
> 
> Cons:
> 1. should not be summed (although the scheduler used to sum up utilization
> and util_est sums up a processed PELT signal today)
> 2. Under-utilization case (which is a problem GROUP_THROTTLE also has, and
> can be worked around. Please, I know the intention of GROUP_THROTTLE, I'm
> just talking about its actual effects).
> 
> I don't see why the things I listed above is in the wrong direction.

