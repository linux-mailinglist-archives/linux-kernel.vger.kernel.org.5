Return-Path: <linux-kernel+bounces-39047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2931083CA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9665CB226C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA98133421;
	Thu, 25 Jan 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jev7GVaf"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3912A16D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204439; cv=none; b=dmNN8pZs67N8eH4uaDIV1Cn8ACqYY0CqjeSh15gQHYG9ZRTam+6Y1CKpKqYZ3f8dDVSenDozW686/VjezoeT2MgysE/ximPSNM+8s+jfVNmljM6wjIxt/h6VC2KJ1r4xWYx0VOervpSuu/LNDVukbROm2gLgtfl1tzFv6Lps0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204439; c=relaxed/simple;
	bh=mAAfa+ekF1FxwQldFSf7TSBpo1nSxuHy9JZ+wtpZGnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQEE31CLJVEomxZ8InDbKdUlky4+uP7K2R6m6SwPJMHms/pcQxtGNau7vjnCe7gDIJ3I62NTqZbQO8/MsKYb2lSuTpmoA+3DOWRLRF/zmfKBRN9InZLMvaHh2a4A5O8Ozbx3+SxtUYgW/RHCkaz6AoTP3BNQL3Ve6XVPUqtkDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jev7GVaf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2903498ae21so4073184a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706204437; x=1706809237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAAfa+ekF1FxwQldFSf7TSBpo1nSxuHy9JZ+wtpZGnA=;
        b=Jev7GVafwp04dXCCGT+BAIwFAqlYTJkG4U7O/49g6eSy296crTduu4WNJ/XQ4Moubl
         PCL2CycS8o1PdKIHmIAHMCgYQ+SMjoEgMbvvnD+Iq48NfaXw8aheAeI5HuCTNjpSuM3B
         JwA4jMoFyIUNIuTojZgeaX+uja/W0c6NJivhKr9mET7kvaFFs0rSjwxw5INV3urgQ7pl
         QNBI4eRfZKMGHa1e/Khsn/qWXdXl+ZHxisDZgqDre3vU7dDYcPqM20TcOOS9lx9rDuAy
         6UdMf/lxUw2fKCZABVx1PZvt10AvZ2zOH6EhbQchS/QA6gJiF5G35Fy+j6jdOtbHJYbc
         UwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706204437; x=1706809237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAAfa+ekF1FxwQldFSf7TSBpo1nSxuHy9JZ+wtpZGnA=;
        b=FHaUF9JVv2dpaQh9B3wur6xiw82J2jmcn2MIntnFetETATWRk+7iNaC1VQMT0S1/CO
         li0bZ/poHXOc6XS2LF4CzaPb2K7xm9gcxxbXoJc3nF3L5Gz3r3ZclpZhcyC4VId4Hljp
         /brAd5ENR5zpBCJ8lqeaDTGfeBbMkVIw8paWn77royeeQE8COhdNibHTL0Cx/EVvbiYR
         LVaf+Nu9FLgkm4LCO0cRKlVy5AcYMdgXsniwhVMSYJmAddftsuHWnlMSEcsGBW5oaxIv
         hAnZGrEWDLJB1TgSiqJEbs4VdFlF9rqXKlDCcB5JKhWtBjbr5Ch1/2bxIkh3dQ7ijwWW
         sD3g==
X-Gm-Message-State: AOJu0YxjWOFG0kIM1zxZBrReuY/QB29crYkzTrfWzwcnPC0cNXXiTAJ2
	Tq/V4x2LxI0Ln7FGdjI9F18XMSlrTnLrsZyBFA6/jzP9NtAbIjJFGa5gFR7AF9r5XBr9gIsPMj8
	0w4pkYOLo1qU+oxvGB5C1C88iq26yz+ICuSI3Xw==
X-Google-Smtp-Source: AGHT+IG9mp4jnM6MKi9OxwjiYgtX/ZGDEceAai7BWv3ny+3ROISeFdUlJM+WAzVoaIO8Y9dDgvzfC12qiD0XceqvxLU=
X-Received: by 2002:a17:90a:1c90:b0:290:85a:dba1 with SMTP id
 t16-20020a17090a1c9000b00290085adba1mr861438pjt.5.1706204436886; Thu, 25 Jan
 2024 09:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com> <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
In-Reply-To: <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 25 Jan 2024 18:40:25 +0100
Message-ID: <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/23/24 09:26, Vincent Guittot wrote:
> > On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > From: Qais Yousef <qais.yousef@arm.com>
> > >
> > > If a misfit task is affined to a subset of the possible cpus, we need to
> > > verify that one of these cpus can fit it. Otherwise the load balancer
> > > code will continuously trigger needlessly leading the balance_interval
> > > to increase in return and eventually end up with a situation where real
> > > imbalances take a long time to address because of this impossible
> > > imbalance situation.
> >
> > If your problem is about increasing balance_interval, it would be
> > better to not increase the interval is such case.
> > I mean that we are able to detect misfit_task conditions for the
> > periodic load balance so we should be able to not increase the
> > interval in such cases.
> >
> > If I'm not wrong, your problem only happens when the system is
> > overutilized and we have disable EAS
>
> Yes and no. There are two concerns here:
>
> 1.
>
> So this patch is a generalized form of 0ae78eec8aa6 ("sched/eas: Don't update
> misfit status if the task is pinned") which is when I originally noticed the
> problem and this patch was written along side it.
>
> We have unlinked misfit from overutilized since then.
>
> And to be honest I am not sure if flattening of topology matters too since
> I first noticed this, which was on Juno which doesn't have flat topology.
>
> FWIW I can still reproduce this, but I have a different setup now. On M1 mac
> mini if I spawn a busy task affined to littles then expand the mask for
> a single big core; I see big delays (>500ms) without the patch. But with the
> patch it moves in few ms. The delay without the patch is too large and I can't
> explain it. So the worry here is that generally misfit migration not happening
> fast enough due to this fake misfit cases.

I tried a similar scenario on RB5 but I don't see any difference with
your patch. And that could be me not testing it correctly...

I set the affinity of always running task to cpu[0-3] for a few
seconds then extend it to [0-3,7] and the time to migrate is almost
the same.

I'm using tip/sched/core + [0]

[0] https://lore.kernel.org/all/20240108134843.429769-1-vincent.guittot@linaro.org/


>
> I did hit issues where with this patch I saw big delays sometimes. I have no
> clue why this happens. So there are potentially more problems to chase.
>
> My expectations that newidle balance should be able to pull misfit regardless
> of balance_interval. So the system has to be really busy or really quite to
> notice delays. I think prior to flat topology this pull was not guaranteed, but
> with flat topology it should happen.
>
> On this system if I expand the mask to all cpus (instead of littles + single
> big), the issue is not as easy to reproduce, but I captured 35+ms delays
> - which is long if this task was carrying important work and needs to
> upmigrate. I thought newidle balance is more likely to pull it sooner, but I am
> not 100% sure.
>
> It's a 6.6 kernel I am testing with.
>
> 2.
>
> Here yes the concern is that when we are overutilized and load balance is
> required, this unnecessarily long delay can cause potential problems.
>
>
> Cheers
>
> --
> Qais Yousef

