Return-Path: <linux-kernel+bounces-45506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E562884319D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E4FB20F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963A7995A;
	Tue, 30 Jan 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="y/GNGdcI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86B79950
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659053; cv=none; b=vEq9JH2gb8XSvJpr+CSVmOSVFZVJr3Kh6IJxwWss6CUzzIMGhUYDphQVLqDBb32kF6jOE5N+MQFFrQ7onBvzNNaWnk5yE+R8+KynUmqH42cXR/tRsKHzM4rtYsQ7oM4r8fEF/l2UruCP7PGJkmAHkcGR7FjPy3xhuTuNiFDc2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659053; c=relaxed/simple;
	bh=QRMRw8beXinBXv6ZIIFkAWY7fv9n7Lk3/CVX+r20rQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKFE1p6jaXlL1bVZl/7BacxXXGDiqfyC5xGzNPz9CcKcTpGyEj8h0z2jyCr84loNlKYWQKkOE9q89xkWoG6xDtWAya5ImP5g1+anY+yi1rmI5yj34njRLy1WFj2SMNJQ37cpHmbCJymqhjsVFEAHIusuzeOUErbOIzLPaAgvGXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=y/GNGdcI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so49453655e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706659049; x=1707263849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mHHnGwlF/0RJCkGxu132AKvJGOVljIej2KVj0yw9Xc=;
        b=y/GNGdcIF90Ycak99ZCLxgvkwjIbH+7K8RNHWJ68UboFcD1klbIL/1v5xYGCGbHnJK
         raonjdmpyjD03H9ToHmwR8t/GI1zpmskhv4oIZOFGLTQXKUUTl/4vyMfMvygMWz301vP
         Gnpd93HRXah2VymvvPyxp1aKI/vVrZg2ZmiW0gnDlmlJcs6KwfirJLe8KmQWWbe9O06g
         IANrAhOWsJyCyra9Ng89o2aF406W9tEhx+ouSpDIZJVpM+FLLkrcGJeYQTOZxhXQOoVj
         O2ozxGRKxP+ItAM1FtHUwW/KwIInVO5OrbIuHt1pCVOmYSH/NQPepFlSQXrpZAo9fO6c
         aAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706659049; x=1707263849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mHHnGwlF/0RJCkGxu132AKvJGOVljIej2KVj0yw9Xc=;
        b=gY/onNb90louTekya1ZPnZcwxaRE10Hab/KtpLdGR/tot9MugsgLRt/l8i0tZPVQhK
         oD+NBNs8gKd+ft45D79gUfrqw7dLakY3HSmfBddAcU1a/1nIIql9OBu0a1v9idJgfgxa
         oEnHEWEkGzz6JiJcFRFqUc0yBAt0/gOC1BwyFoG6UOxE+WMnPSVJcl8TaicBBtWhgrkn
         xmFsVW45IljF1ejG8TRfQPKPqzbd/yCt6ILn3do8aTUpuDO45klZ7vfXHcNqEMdQFCgW
         +PGunH6mBK2Y6KdLAjgG0wuvhVoOW48BmfyokZRuFaSwpMZBr3NeVhzyCJZKTbSRnKjx
         OoiQ==
X-Gm-Message-State: AOJu0YwWjctYpWdhrOb/lkvIgC8qEkYEeBy+qKoXxn9OGGY2CH1XtctK
	mGkOg/bgefFukEyURIX20qbxLAoIMYNqcg0pwhTbKhzGv3SbBdyXiEiCOIcf6z4=
X-Google-Smtp-Source: AGHT+IGSORmwfW3bEYlKEch+Wp5XN4H5+MjVQYp7YFGVVRyqcOHOyioHLVIgkgJ2odyR8T6M1yyjmw==
X-Received: by 2002:a05:600c:1547:b0:40e:779f:416 with SMTP id f7-20020a05600c154700b0040e779f0416mr35598wmg.2.1706659049300;
        Tue, 30 Jan 2024 15:57:29 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b0040fb30f17e8sm538412wmb.38.2024.01.30.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:57:28 -0800 (PST)
Date: Tue, 30 Jan 2024 23:57:27 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240130235727.wj3texzo4lpbba6b@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
 <20240128235005.txztdbdq2obyi4n6@airbuntu>
 <CAKfTPtC0=MH7bCypeY1QFxt=pFbPxY9YLuuS8_dhkF31nR6ZWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtC0=MH7bCypeY1QFxt=pFbPxY9YLuuS8_dhkF31nR6ZWQ@mail.gmail.com>

On 01/30/24 10:41, Vincent Guittot wrote:
> On Mon, 29 Jan 2024 at 00:50, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/26/24 15:08, Vincent Guittot wrote:
> >
> > > > TBH I had a bit of confirmation bias that this is a problem based on the fix
> > > > (0ae78eec8aa6) that we had in the past. So on verification I looked at
> > > > balance_interval and this reproducer which is a not the same as the original
> > > > one and it might be exposing another problem and I didn't think twice about it.
> > >
> > > I checked the behavior more deeply and I confirm that I don't see
> > > improvement for the use case described above. I would say that it's
> > > even worse as I can see some runs where the task stays on little
> > > whereas a big core has been added in the affinity. Having in mind that
> > > my system is pretty idle which means that there is almost no other
> > > reason to trigger an ilb than the misfit task, the change in
> > > check_misfit_status() is probably the reason for never kicking an ilb
> > > for such case
> >
> > It seems I reproduced another problem while trying to reproduce the original
> > issue, eh.
> >
> > I did dig more and from what I see the issue is that the rd->overload is not
> > being set correctly. Which I believe what causes the delays (see attached
> > picture how rd.overloaded is 0 with some spikes). Only when CPU7
> > newidle_balance() coincided with rd->overload being 1 that the migration
> > happens. With the below hack I can see that rd->overload is 1 all the time
> 
> But here you rely on another activity happening in CPU7 whereas the

I don't want to rely on that. I think this is a problem too. And this is what
ends up happening from what I see, sometimes at least.

When is it expected for newidle_balance to pull anyway? I agree we shouldn't
rely on it to randomly happen, but if it happens sooner, it should pull, no?

> misfit should trigger by itself the load balance and not expect
> another task waking up then sleeping on cpu7 to trigger a newidle
> balance. We want a normal idle load balance not a newidle_balance

I think there's a terminology problems. I thought you mean newidle_balnce() by
ilb. It seems you're referring to load_balance() called from
rebalance_domains() when tick happens at idle?

I thought this is not kicking. But I just double checked in my traces and I was
getting confused because I was looking at where run_rebalance_domains() would
happen, for example, on CPU2 but the balance would actually be for CPU7.

No clue why it fails to pull.. I can see actually we call load_balance() twice
for some (not all) entries to rebalance_domains(). So we don't always operate
on the two domains. But that's not necessarily a problem.

I think it's a good opportunity to add some tracepoints to help break this path
down. If you have suggestions of things to record that'd be helpful.

