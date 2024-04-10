Return-Path: <linux-kernel+bounces-138910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1189FBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CA1F2472A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0416F0E0;
	Wed, 10 Apr 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="l4ssNbGL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824551E86D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764052; cv=none; b=sf3+ecHVo0EryeFFsJzLm0eEkZfTHC6AYRLqNkJIm/bzI/1/v7FEV8tCR3soeQvGRNkoyoYw12TK/1ok3OLrPb3IftzkDKqy8tSx1VW/kq1nFAevIbB6cF9+fwnqM9Wp31SZ3oHWZx8JPqs3LiTfKwr/NVJMlz9srICqi/eOdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764052; c=relaxed/simple;
	bh=dhW94+L8qu0FHYG/pT4rSi65rfiKoRlcyelRniAx4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm5ziI+N1Iq7awRItO1OG89ydhDId8/+RGBjTCrip4AkWMkDr9ZZ0ilXomEf3oF5NjyK15sazWoH7HEaNoWK5eEMc6pkfaIZssFZSrhOdZ20GdXTEhzWuHQJt0JCD6hCNobxgBX3fzJ24OxaCtEQM6M5/P5lmAc6PTgiTNHxLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=l4ssNbGL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso247475b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712764050; x=1713368850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT5kihno0CtGEg+7vZ9yWZNl3u0Nc+IwRAbIkMek22A=;
        b=l4ssNbGLPTLTAMDnKlcNimlLx5KM3UybTHygSRMtr1prmPx5tsvJFSHaWa0zhBWGz4
         Fe5aUMHPn01CJ4+f6Vhd5SGBSreZgt0KhN8HItHWtkWROeUTaJrOMS2uM3hx8j/wKbw+
         OCB61ZwHbOhc+oYgyudXe5b3HvqRF5+UGzUcdU7DCMPsVfnNroTLHsuc49lMVFF3bQvj
         JmV5pkrmJaTDGmCjakkbej9989j8g33LVMb8tZreTTrqf4/9kv9CVSByghjOpIMiVU5R
         y3b36FvMXgInUOK+6r9ygeyZB7rVqBqBhLZoBJ0Rr/ryKalOzhKzoNzlmGR/cyDXok3r
         RbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764050; x=1713368850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT5kihno0CtGEg+7vZ9yWZNl3u0Nc+IwRAbIkMek22A=;
        b=c7E/c3pbQmQKssNBbZZWXiKyoaHAVpXNNshlSzxsP6kl7k2OVevGvfHu91kTOasJhl
         c6v4+PFt2kRPYnNQ5LJB44Y4MxYs0H3zBO+V0S0B5JpZynj7gg18ZwJPhGxMsZACW11A
         bPyhnnri7YgJvghKJOiy+l7mgep4J9S6+vtjCYBd8Xr2maTeDcJV+o0N7OHUPYXOJ0/G
         dTdH3Be1Q42oq7W5vighxlw22e0FHdaxAyP4N75Khmo7mU8bF0k3VIuT6bu8M2QZI2HJ
         6VHStBkVbRy+WJdDsDAWOWTaLiuJCkV/qSwpDF8blziGOpvMwt2+g9SZ8Zh5JQaw6nPD
         s/hA==
X-Forwarded-Encrypted: i=1; AJvYcCXRq+yWsLHdLTlIAAM8I0MLlX6XqhJBO07Uqn8h3vtn0oFH/q/jzC9/HcTr9Nbit12wl5bAZdvwd0dtPRtCuY+RH2ssOGF4bWTYdHFm
X-Gm-Message-State: AOJu0Ywhj2mut/yhAMnFDXIg2/Vv0ncEepP9kEYTGHRX4gzM8mHFgan4
	17Zi1iK+1RS4xY3CPNfTrgcji39evLAkYfwk+np1ldytXRSFDZezxRKTzfp3tBmWMqxOIl3DJJ0
	Q0SA=
X-Google-Smtp-Source: AGHT+IFc+FYkQTr4VvtqNsjtG7qwRMaC04Mg+jbAYApXgx86ugsgPh9J1USUvy3Lv0cRCDdRt6mqoA==
X-Received: by 2002:a05:6a20:564c:b0:1a7:9adc:86e4 with SMTP id is12-20020a056a20564c00b001a79adc86e4mr3228673pzc.23.1712764049606;
        Wed, 10 Apr 2024 08:47:29 -0700 (PDT)
Received: from airbuntu ([64.125.41.58])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b006e554afa254sm10293488pfn.38.2024.04.10.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:47:29 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:47:27 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240410154727.4yh5tcnpb6zwxuub@airbuntu>
References: <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
 <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
 <20240409061909.tb3vxc27h2eawiwg@airbuntu>
 <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
 <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
 <CAKfTPtD-J37Q1SL2HqZLvfNtW9LY34C-d-t6-0KU4DxkUmvHzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD-J37Q1SL2HqZLvfNtW9LY34C-d-t6-0KU4DxkUmvHzQ@mail.gmail.com>

On 04/10/24 11:13, Vincent Guittot wrote:

> > > Without cgroup, the solution could be straightforward but android uses
> > > extensively cgroup AFAICT and update_cfs_group() makes impossible to
> > > track the top cfs waiter and its "prio"
> >
> > :(
> >
> > IIUC the issue is that we can't easily come up with a single number of
> > 'effective prio' for N level hierarchy and compare it with another M level
> > hierarchy..
> 
> And then how do you apply it on the hierarchy ?

(I am not disagreeing with you, just trying to state the reasons more
explicitly)

I think the application is easy, attach to the leaf cfs_rq? Which IIUC
correctly what should happen with proxy execution, but by consuming the context
of the donor directly without having explicitly to move the lock owner.

Finding out which hierarchy actually has the highest effective share is not
straightforward I agree. And if we combine a potential operation of something
that could move any waiting task to a different hierarchy at anytime, this gets
even more complex.

I need to go and find more info, but seems Windows has some kind of boost
mechanism to help the lock owner to release the lock faster. I wonder if
something like that could help as interim solution. What we could do is move
the task to root group as a boost with the simple reweight operation proposed
here applied. As soon as it releases the lock we should restore it.

From what I heard in Windows this boost happens randomly (don't quote me on
this). I am not sure could be our trigger mechanism. We sure don't want to do
this unconditionally otherwise we break fairness.

Maybe there are easier ways to introduce a simple such boost mechanism..

