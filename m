Return-Path: <linux-kernel+bounces-12782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A281FA03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6842853DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE59F519;
	Thu, 28 Dec 2023 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="o2c7CSvx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF4F508
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so66781445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703781907; x=1704386707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vaQ04VZBIWMRErTRZHjHaCsni243QnJhodvuqHbEBT0=;
        b=o2c7CSvxOnTJ9mKGbG7HulqiyMYsNUlab8wq5hDrGp/e6eB4WFuKCzC/tZi3ZfPHl2
         QOx8SwXUYjO0MJDbbyKRD4Id9d+uFQO0CwqiKRv7y6euqvjEiE3lyrYVLyRUd2Pdlx4+
         VmCAiNo6YiaVEiB0+e1HpMBEzH8SKd1iXUC/RYkpigcfoOmfZgTlXqRWm30g/cbrG4OI
         r4PFUC3wLTHGa6KtwYLD2yZyHYMsck1Agc9aerHmFHNO8gPZxSOSxZZYaNAlnRFzhMm3
         RwkTw6pd3hXoycg9UYjBK6O5eN3b4jx5TQM68CBf4SoOcszyTLScVjmwPeeCxKcuPQJI
         WMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703781907; x=1704386707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaQ04VZBIWMRErTRZHjHaCsni243QnJhodvuqHbEBT0=;
        b=I5ywN0M0rXYbMXAlGa1xnoexi/hFckBG6P/IM9yk1viet9BzcX7+iXMKmJ/1t4yfQh
         vWaqqouxnnH+20c4lp8rPMwgQNt7vx5dH4yqDmwToT2luTSb7C3ZTl4OKA3oBf9JwowV
         C0573Qc5zBRpjCfScwnGwan6XhIDj4slCoyOBNgq3Wkw4PrpaY5CkueuuFnIUWVSSdpB
         TyyZDRYbLRaWDR4EuCPhQhAot6QD74u9UFzvdQdMVI814bZO+wwdjsa0oAp9Rx5Kzi2d
         /LQydtro5/6uVoj9XTg5t9RuL01WRsU4XoTMzlkMsCMUwTm03OnwaJ4dgAtblBQWVFAI
         QIfg==
X-Gm-Message-State: AOJu0YySBH8pJS7GR4OVgyxZOCR/sZgs7puNotVCZ93yyedmm75Evg67
	R2HVDhKHoqGrmLLq5iTw3JCY8oeFmyQRqw==
X-Google-Smtp-Source: AGHT+IHI4SCMJkUvvY1A7j8fWbnJYKSC7qDGu5cNYmsciMap06lpdXnUD2vyuQ/93rm0zcHI7ttpgg==
X-Received: by 2002:a05:600c:22d2:b0:40d:6045:e847 with SMTP id 18-20020a05600c22d200b0040d6045e847mr647936wmg.88.1703781907318;
        Thu, 28 Dec 2023 08:45:07 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040d5daa9092sm6504014wmq.44.2023.12.28.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 08:45:06 -0800 (PST)
Date: Thu, 28 Dec 2023 16:45:05 +0000
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
Message-ID: <20231228164505.vpzymufqhm2ty3zh@airbuntu>
References: <20231106193524.866104-1-jstultz@google.com>
 <20231217030734.ty7isyjyzgcix7er@airbuntu>
 <CANDhNCoC1fo8RoKsQHJUcJiJVAYjD8W+8jHZJ7XS-WpdikkvSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoC1fo8RoKsQHJUcJiJVAYjD8W+8jHZJ7XS-WpdikkvSQ@mail.gmail.com>

On 12/18/23 15:38, John Stultz wrote:
> On Sat, Dec 16, 2023 at 7:07 PM Qais Yousef <qyousef@layalina.io> wrote:
> > I am trying to find more time to help with review and hopefully debugging too,
> > but as it stands, I think to make progress we need to think about breaking this
> > patchset into smaller problems and get them merged into phases so at least the
> > review and actual work done would be broken down into smaller more manageable
> > chunks.
> >
> > From my very birds eye view it seems we have 3 elements:
> >
> >         1. Extend locking infrastructure.
> >         2. Split task context into scheduling and execution.
> >         3. Actual proxy_execution implementation.
> >
> > It seems to me (and as ever I could be wrong of course) the first 7 patches are
> > more or less stable? Could you send patch 1 individually and the next 6 patches
> > to get the ground work to extend locking reviewed and merged first?
> 
> So I'm working hard to get v7 out the door here, but your general
> suggestion here sounds fair.
> 
> Part of why I've not pushed as hard to get the first initial patches
> in, is that the earlier changes to rework things are mostly done in
> service of the later proxy exec logic, so it may be a little hard to
> justify the churn on their own.  Also, I've been hoping to get more

If by churn you mean they'd be changing a lot later, then yes.

But by churn you mean merging patches to serve a purpose that is yet to follow
up, then I think that is fine. I think other complex patches were staged in
pieces to help with both review and test process. And to speed things up.

> discussion & feedback around the big picture - but I suspect the size
> & number of the changes makes this daunting.

I don't know how the maintainers manage in general tbh. But finding the time
for a smaller set of patches would be easier IMHO for everyone interested.

Assuming my understanding is correct that the first set of patches upto
splitting the scheduler context are more or less stable.

> That said, if Peter is up for it, I'd be happy if the initial chunks
> of the series were to be considered to be pulled in.
> 
> > After that we can focus on splitting the task context into scheduling and
> > execution (and maybe introduce the PROXY_EXEC config along with it) but without
> > actually implementing the inheritance, etc parts? Just generally teaching the
> > scheduler these now are 2 separate parts.
> 
> The majority of that is done in a single patch:
> https://github.com/johnstultz-work/linux-dev/commit/9e3b364f3724ed840137d681876268b0ad67a469

Yep!

> 
> There we start to have separate names, but at least until we are doing
> the proxying, the rq->curr and rq_selected() will be the same task.
> 
> > Are 1 and 2 dependent on each other or can be sent as two series in parallel
> > actually?
> 
> Technically, I think they can be done in parallel. Though I'm not sure
> if managing and submitting multiple patch series is easier or harder
> for folks to review.

I didn't mean you should do that :-) Meant they're actually completely
independent.

> 
> > Hopefully this should reduce the work a lot from continuously rebasing these
> > patches and focus on the last part which is the meaty and most difficult bit
> > IIUC. Which I hope we can break down too; but I have no idea at the moment how
> > to do that.
> 
> Rebasing hasn't been the major problem, but wrangling the large patch
> set has. For v7 I got a lot of offlist feedback, and propagating those
> changes through the full fine-grained stack makes even trivial changes
> to early patches quite laborious.
> 
> As for breaking down the rest, I thought the v6 series had later
> patches broken down fairly well:

Hmm okay. I thought they're dependent; and I meant to potentially independent
parts that can be piecewise merged. But perhaps I'm overthinking the splitting
here :-)

> 1) Just local rq proxying (where the owner happens to be on the current rq)
> 2) Add proxy migration & return migration, so we can boost tasks on remote rqs
> 3) Sleeping owner enqueueing (so we get woken and added to the rq the
> owner gets woken on)
> ...
> 
> And I have the fine-grained version that is even more split up so I
> could test each small change at a time:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6-fine-grained
> 
> But I'm open to other suggestions.
> 
> > Merging in parts will help with giving each part a chance to soak individually
> > in mainline while the rest is being discussed. Which would make handling
> > potential fall overs easier too.
> 
> Again, I think this would be great.
> 
> I'll try to get v7 out the door so folks can once more consider the
> big picture, but then maybe I'll send out the earlier changes more
> frequently.


Thanks!

--
Qais Yousef

