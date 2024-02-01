Return-Path: <linux-kernel+bounces-48935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31F84635B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62761C255CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1C3FE27;
	Thu,  1 Feb 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZiA4NeOX"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8463FE3D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826097; cv=none; b=etXR4lVVSQjyjl4Q/aHAXh13rqJS/7+gGHWrT1FMX9kzg/lr+qUZueS8BLyM64FFRhgb3OU/twV/wwhDXy0II8V+VZSlBlf5Kz6GV3x05xIp/28JtGd1iR2+v51GnmSamhV9Ve8nKq/km22X06vJHgAxinWTkbMnP1tF1rHoWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826097; c=relaxed/simple;
	bh=KxqNT2Gn6TchweCdNiZe0GjJMI08a2D7wc4KzdvIKNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/hS3L0PNPHUg1bxi6dhtxt6tABk7mUzW1GATk/9DjjB5gUc1YRDtpUa4iDeg2aePMkV0Vq12kSTeaoe+eozDOYmdgttkZl5twtBxj53jiPnf50dIFqQXNY90xxzh00xS08m5b+LTLTcrScW22Zk/rAcPZatnDd/Xp/f/N1Cm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZiA4NeOX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so12256075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706826091; x=1707430891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQPlEAivQZ06E0zkntV5Vmz3rSop9oniNwVi95cruE=;
        b=ZiA4NeOX4KsDorcrQKzAa1t1dNrscpM1man63TDAhD5Hy0aYuvgicb7nw5bHU2FXfX
         Df4GBx4bRXJwSqdNFFbMSMYibBJEOaYUFcABPYF0Jf7A3N2szerWveE5nC/ZAS48OqyT
         48K5jbQrs3gf26mh/+xa78aYyKcyfxefRBRw/2jDlgv2udOzVDXE979gTDXUVhHQvm2W
         Z1bdaIiF4gwp9NL4SsCRf/nx/y8IHE76JMTNMY1TelWzazF4goLrdXzM8wggAbsJXcEi
         US/Z485xxljyn7h71Yw2i9Smyrddf190yK0+72irY3vT6g9+ufeR7lDxS26hn/5bpiOK
         741w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826091; x=1707430891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIQPlEAivQZ06E0zkntV5Vmz3rSop9oniNwVi95cruE=;
        b=blTdYHjRWVFBCVMv9sgvCXeFld0QUj0lVOREwuCkR/8x4Xh2G8kGmHSfU+KC+DvHxq
         qxvtIPKOUHL9UWdBMErr+nRtwevaGMENGvR8acnEc9c5gniECg5OAxvlx1qheMamqW/n
         IsC1Zyv469fKvmEkNYHogdpqFuUo58cCll9UX7ALhyN2ZgCoeiOIrXg78WlBOD0S9Nqv
         X5OWKnHKm7h8/KdqBgZOmPkFaixFyUXWPtsPpaivZtwZc/Vf8EgqgLaQ2fbSaUt4E+ID
         7lh/pZHT1lxpUNcvBHvHh0P5aWzQINmv3wAwpmitzb+tgPXLECSTFR79Gr5sImta+aG6
         eA5Q==
X-Gm-Message-State: AOJu0YzgUJKSHfqO3gifaNec2Ck3O8+EgOnHiNs9c4ZFhiZbt2zkNEob
	XQyfZBdlhypj6dw71Xa9drC6108OEs9a0FGipfl/pqOK5PmYpqKtQWJi0NVzWvuFFkGcjRNnNVC
	c
X-Google-Smtp-Source: AGHT+IEJgKxE+80b1io2moWM9T3PQDEm6j1Z+JyJeavaiU2H3OogeU0NUL+IJ0F/R+YLcIrm4UDqYw==
X-Received: by 2002:a05:600c:524e:b0:40e:f222:9e52 with SMTP id fc14-20020a05600c524e00b0040ef2229e52mr199306wmb.40.1706826091453;
        Thu, 01 Feb 2024 14:21:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXly/jb5VP0ONr+GFXyk0WKgAnWzzcfKbh5vnymYP7rsARltzTjhTzWePdO2IJjHb45a0YkHnZJhe3qqVynsZrgZVT91QBsSLt+aeTUy3ZEGFUB8/a1Doj3D4oaVsnluVEg5jaDYlucnavYq95UvZr6u8zOyPeGJtDzgkwp9CtLbBklN/MpHRfNrUUwxKtIi8+CWDbc
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fbdf77ca3sm2558771wmb.42.2024.02.01.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:21:30 -0800 (PST)
Date: Thu, 1 Feb 2024 22:21:29 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240201222129.myunpz3vb425i3dj@airbuntu>
References: <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
 <20240128235005.txztdbdq2obyi4n6@airbuntu>
 <CAKfTPtC0=MH7bCypeY1QFxt=pFbPxY9YLuuS8_dhkF31nR6ZWQ@mail.gmail.com>
 <20240130235727.wj3texzo4lpbba6b@airbuntu>
 <CAKfTPtCAETf3F-dkMimqt6VC9TWHseiQyywyuq6BQqxVMWxXRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCAETf3F-dkMimqt6VC9TWHseiQyywyuq6BQqxVMWxXRw@mail.gmail.com>

On 01/31/24 14:55, Vincent Guittot wrote:
> On Wed, 31 Jan 2024 at 00:57, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/30/24 10:41, Vincent Guittot wrote:
> > > On Mon, 29 Jan 2024 at 00:50, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 01/26/24 15:08, Vincent Guittot wrote:
> > > >
> > > > > > TBH I had a bit of confirmation bias that this is a problem based on the fix
> > > > > > (0ae78eec8aa6) that we had in the past. So on verification I looked at
> > > > > > balance_interval and this reproducer which is a not the same as the original
> > > > > > one and it might be exposing another problem and I didn't think twice about it.
> > > > >
> > > > > I checked the behavior more deeply and I confirm that I don't see
> > > > > improvement for the use case described above. I would say that it's
> > > > > even worse as I can see some runs where the task stays on little
> > > > > whereas a big core has been added in the affinity. Having in mind that
> > > > > my system is pretty idle which means that there is almost no other
> > > > > reason to trigger an ilb than the misfit task, the change in
> > > > > check_misfit_status() is probably the reason for never kicking an ilb
> > > > > for such case
> > > >
> > > > It seems I reproduced another problem while trying to reproduce the original
> > > > issue, eh.
> > > >
> > > > I did dig more and from what I see the issue is that the rd->overload is not
> > > > being set correctly. Which I believe what causes the delays (see attached
> > > > picture how rd.overloaded is 0 with some spikes). Only when CPU7
> > > > newidle_balance() coincided with rd->overload being 1 that the migration
> > > > happens. With the below hack I can see that rd->overload is 1 all the time
> > >
> > > But here you rely on another activity happening in CPU7 whereas the
> >
> > I don't want to rely on that. I think this is a problem too. And this is what
> > ends up happening from what I see, sometimes at least.
> >
> > When is it expected for newidle_balance to pull anyway? I agree we shouldn't
> > rely on it to randomly happen, but if it happens sooner, it should pull, no?
> >
> > > misfit should trigger by itself the load balance and not expect
> > > another task waking up then sleeping on cpu7 to trigger a newidle
> > > balance. We want a normal idle load balance not a newidle_balance
> >
> > I think there's a terminology problems. I thought you mean newidle_balnce() by
> > ilb. It seems you're referring to load_balance() called from
> > rebalance_domains() when tick happens at idle?
> 
> newidle_balance is different from idle load balance. newidle_balance
> happens when the cpu becomes idle whereas busy and idle load balance
> happen at tick.

Yes. newidle_balance() is not supposed to pull a misfit task then?

> 
> >
> > I thought this is not kicking. But I just double checked in my traces and I was
> > getting confused because I was looking at where run_rebalance_domains() would
> > happen, for example, on CPU2 but the balance would actually be for CPU7.
> 
> An idle load balance happens either on the target CPU if its tick is
> not stopped or we kick one idle CPU to run the idle load balance on
> behalf of all idle CPUs. This is the latter case that doesn't happen
> anymore with your patch and the change in check_misfit_status.

Yes. I just got confused while looking at the log. I'm testing without my patch
FWIW. It should be 6.6 from Asahi folks which should contain nothing but the
necessary stuff to make the machine run that wasn't fully upstreamed yet.

> 
> >
> > No clue why it fails to pull.. I can see actually we call load_balance() twice
> > for some (not all) entries to rebalance_domains(). So we don't always operate
> > on the two domains. But that's not necessarily a problem.
> 
> We have 3 different reasons for kicking an idle load balance :
> - to do an actual balance of tasks
> - to update stats ie blocked load
> - to update nohz.next_balance
> 
> You are interested by the 1st one but it's most probably for the 2
> last reasons that this happen

Okay. Thanks for the info. I need to figure out why 1 fails although there's
a misfit task to pull.

> 
> >
> > I think it's a good opportunity to add some tracepoints to help break this path
> > down. If you have suggestions of things to record that'd be helpful.

