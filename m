Return-Path: <linux-kernel+bounces-37740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F083B4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465521C224D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D9135A6F;
	Wed, 24 Jan 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZhCuH0Pt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F9135A52
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135405; cv=none; b=lBrDjdXg0N0UC2gSdqNF7I94n4Vcnxw1vZQy42q4lTszowiXK2gXZvdbrUmVJz6r+K6HPvPD+PA+dnJSOZjiC9e6d+FRYgq0wBCyb4xA68pY+BKreVIrSlWa5mX6VPX/bjqJfxEXxexhRtKv+X7bCH+VI8efNSCgYRGU3YAiSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135405; c=relaxed/simple;
	bh=SpfKE04nDfpZ5iEFdmLAh+1Qj/AYGrZl8Ls1vYyc1BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZaJqdpOTlYGsiNQY2laNVn/dGl9g+1djHJu/PCDyjOJ3CLmEzceFsUyF4cLSAvGdenIix7LOpJs+2zX/xhLpdyc3McHhtROEbfNafScL2ESzVnRY5Qy+QpSCx+0H2UUf4bk3RkZw4DaTILp8fAMFJQ/aCATNqnbZY85Z0bhwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZhCuH0Pt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso66055895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706135402; x=1706740202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM8anFygTIEicOfEcoFbhECHS8uqjDHmTQqeyTt/OLk=;
        b=ZhCuH0PtK0hvfv3OQqTvr5GFqCRDTPVkTHTU18SkUBPK0h2tUyuxgXH5bc5uO5+c3A
         ZPRlPt0qxTYvx0iCLv79hzveQMUSPsjCXkmWBetFjpUCB7tMoJqCEPeBxOVWqO1tJxs5
         R+mmW8PypVFIGR/Oh8mIpKKray2aVPYGlGt1pExI61cSn6OxoevzisKHQ/J3nH+aiPSF
         C6rxBs5a7AkRavom+Q2PKjkSAHNhZEWDZya6NDke8dHbEKWMcobtKDJhJ3FXDWDC3dtb
         aq0up7vQ/AjjIKDK+dX0/mNl+Fs1d8+ETDhmZHGryO992KrZhWqcTYDHtM0j9LJTX58t
         tjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706135402; x=1706740202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM8anFygTIEicOfEcoFbhECHS8uqjDHmTQqeyTt/OLk=;
        b=JRkEpzLreDIwuvCvLfeg8PAY2w6BAwtinBJsuGq8DXKI11xEhUtVMeUGrCB92jQB7C
         gpRb7y95mDaRF896ZlTQBq9N79Y/MwxlB6IMCKBIN+nF0G7ZWrAExH5KWQRutInGuev4
         UoUEC90Ef71kxAK2OspOQyBTZN0BUb9bYUCnuBrjPMc9YQM9T0H94n6ucVFxsSL860Mq
         +eRoCzbFXtmKPjUPOe9eGbHa0OD5qEsqkTLQG8WYSfLFLqh01gaXj9GZm7/b9UlKXHVl
         UlT2cR8kdCp3/aKUYlNvXH+XllTEXp2arPXnhpzEfsQM71uQpiVEWso/pXbKkNCsYcrS
         q6DA==
X-Gm-Message-State: AOJu0YzRSpx5RPeSpo50BbL8ojjICZ7GrJ2PcklI2rVRJAwlEETH3/j9
	nAC8zDC9j2DesdftL3WoyE9qsfjLDm9kq1h2ZSnhZ/g3k4KYRjph1j55neZuVI4rVN8fWqDj+18
	a
X-Google-Smtp-Source: AGHT+IGbsdyG9ZTnk1bTcyGUTxxC/P7Pj9cgbraFd9+7QiQkKf3eSp52LuyBZNudG9yqChp+qYwd9w==
X-Received: by 2002:a05:600c:1e8e:b0:40e:c69d:94f3 with SMTP id be14-20020a05600c1e8e00b0040ec69d94f3mr945388wmb.185.1706135401786;
        Wed, 24 Jan 2024 14:30:01 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b0040e47dc2e8fsm437999wmq.6.2024.01.24.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:30:01 -0800 (PST)
Date: Wed, 24 Jan 2024 22:29:59 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>

On 01/23/24 09:26, Vincent Guittot wrote:
> On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > From: Qais Yousef <qais.yousef@arm.com>
> >
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> 
> If your problem is about increasing balance_interval, it would be
> better to not increase the interval is such case.
> I mean that we are able to detect misfit_task conditions for the
> periodic load balance so we should be able to not increase the
> interval in such cases.
> 
> If I'm not wrong, your problem only happens when the system is
> overutilized and we have disable EAS

Yes and no. There are two concerns here:

1.

So this patch is a generalized form of 0ae78eec8aa6 ("sched/eas: Don't update
misfit status if the task is pinned") which is when I originally noticed the
problem and this patch was written along side it.

We have unlinked misfit from overutilized since then.

And to be honest I am not sure if flattening of topology matters too since
I first noticed this, which was on Juno which doesn't have flat topology.

FWIW I can still reproduce this, but I have a different setup now. On M1 mac
mini if I spawn a busy task affined to littles then expand the mask for
a single big core; I see big delays (>500ms) without the patch. But with the
patch it moves in few ms. The delay without the patch is too large and I can't
explain it. So the worry here is that generally misfit migration not happening
fast enough due to this fake misfit cases.

I did hit issues where with this patch I saw big delays sometimes. I have no
clue why this happens. So there are potentially more problems to chase.

My expectations that newidle balance should be able to pull misfit regardless
of balance_interval. So the system has to be really busy or really quite to
notice delays. I think prior to flat topology this pull was not guaranteed, but
with flat topology it should happen.

On this system if I expand the mask to all cpus (instead of littles + single
big), the issue is not as easy to reproduce, but I captured 35+ms delays
- which is long if this task was carrying important work and needs to
upmigrate. I thought newidle balance is more likely to pull it sooner, but I am
not 100% sure.

It's a 6.6 kernel I am testing with.

2.

Here yes the concern is that when we are overutilized and load balance is
required, this unnecessarily long delay can cause potential problems.


Cheers

--
Qais Yousef

