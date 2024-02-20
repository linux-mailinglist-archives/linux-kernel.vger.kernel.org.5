Return-Path: <linux-kernel+bounces-73105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A476385BDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED80285F32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA96A8BE;
	Tue, 20 Feb 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="mpQapRPp"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97127612C0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437001; cv=none; b=FluHPUXqTJmxn8vd3H7GwL30onohK2/kYXTX3Q3/9DdndRzbtmyNocOxZAJNqvUx/jz+Z7i93/eIkUNsV9Sg1OVrrm2mdUcDRvLBAbV44chezbR+JYxWqDa/NFCSMYTRQGbJGGADZKGURDZwadE5Y5EplVH+ao+wNqygu5KQDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437001; c=relaxed/simple;
	bh=lozYVyMc3VfOBnHiDoSHDqEFm2dofar5tpGyH1FwJ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxCXa1kjSDMg27HwJ8UILDcJ9f7CxyJpDgLNmE7tU98P2ykqX2senWiVuFgxIuxjpkOwvrN4F/C5//zrhoUfCkFVE7oHZqYSFDJvrKd1avjsdHgpEVVmbOVenx1vM1Z1xvYABgF/d7gfwhHRFTHTMujx7vbC7VUGu/G8+95xYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=mpQapRPp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41271fb0087so866685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708436998; x=1709041798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atijrAqjDl7w1equm+2MU48dC3MbTNNsBttO38KSPYw=;
        b=mpQapRPpK07QXsW6q3yyg7PBGqn4ugZoPY1UTc3Dh+ZX1kZee8z5AQGPm+J+fBCD+O
         BVoBynxZEiT72/PhDRi6Xfo5bcbfjIvrM0sHUBv5ks+AyjkjciYNFH7Jsypl9Xl5fFCu
         c1JDDhn0YGAUP6/epU0HMH8RkU28f2aVNyQd3nYVH09jjqkOHIHZbbTngLI2RB1nklZF
         M8fMeif91oHJ15hIaln+kLVvTeAF3ObX/Gmp8bys/ITalxREXlio7YkYKVLIIQcpzChw
         DjDbkI8GSMdS4jr6D0JygOjR0HecnyhuX3MJpsWDqcE3wDtzAyPN8jqJ2HL0jYUUP2Uw
         wh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436998; x=1709041798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atijrAqjDl7w1equm+2MU48dC3MbTNNsBttO38KSPYw=;
        b=Qd/gZdxgtUFQqK+Hj/qgakzevYHGuxmbdRraE/u4TfeLshLuebYfUKOG++1KhyT/+D
         tg40DrVY3kSROR4HtwGOdNSBNF9hpRxStB7tjzwanjeWB4BcqkykfuUPoRRT8CJnfPDx
         yMg7t3otmriPm3fueW47M9RLXAz79J0F37o6Fmzl7yMpW7AWgK18Ua0yZVGWEdtg4S92
         dwEkXbbJy+n8w1K1hqCMq9XGgu3rlYGmr3m2S7b44D6Cr5CwHjhq/SzTXiPe/sN3mhHJ
         thNc0fNkWmOuKT0M9mE5IQe0JnlfLpuumZDOVZbXB07J0jIuaWGS0C4Uohw0yeXE2TSH
         WGMA==
X-Forwarded-Encrypted: i=1; AJvYcCWTsnCfqBnwDDVZLYP6GhPZDWEeSzEAPMGrWnZfuseNOfpl/9NcRuJLZHY8jCLTlAi2CzpeBMc7Fz47H3H2PbyUHroul1ZL9AkjdWou
X-Gm-Message-State: AOJu0Ywcep7M6EAomNPhqpQSAW7cbNC/612ZSR3W6AYqJ5oSMAkDkvdD
	4E7NImkf4Iu3YbjCRuaosZVZTVt4xjEzlzNDJcefy6cNL9MQlQutEawB1mY/maM=
X-Google-Smtp-Source: AGHT+IFwz1rgj01AxeALb187kQcQiPmPv9XO+Dm8PUvcdo4OlXUxE/BudbUXIdu4KCv8RvP93j4cTQ==
X-Received: by 2002:a05:600c:3108:b0:412:6885:cabf with SMTP id g8-20020a05600c310800b004126885cabfmr3195203wmo.32.1708436997787;
        Tue, 20 Feb 2024 05:49:57 -0800 (PST)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004126afe04f6sm3985233wms.32.2024.02.20.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:49:57 -0800 (PST)
Date: Tue, 20 Feb 2024 13:49:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240220134955.4nlofes2g7oz4g6g@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>

On 02/12/24 16:53, Rafael J. Wysocki wrote:
> On Mon, Feb 5, 2024 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 05-02-24, 02:25, Qais Yousef wrote:
> > > 10ms is too high for today's hardware, even low end ones. This default
> > > end up being used a lot on Arm machines at least. Pine64, mac mini and
> > > pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> > > it's too high for all of them.
> > >
> > > Change the default to 2ms which should be 'pessimistic' enough for worst
> > > case scenario, but not too high for platforms with fast DVFS hardware.
> > >
> > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 44db4f59c4cc..8207f7294cb6 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> > >                * for platforms where transition_latency is in milliseconds, it
> > >                * ends up giving unrealistic values.
> > >                *
> > > -              * Cap the default transition delay to 10 ms, which seems to be
> > > +              * Cap the default transition delay to 2 ms, which seems to be
> > >                * a reasonable amount of time after which we should reevaluate
> > >                * the frequency.
> > >                */
> > > -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> > > +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
> >
> > Please add spaces around '*'.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I've adjusted the whitespace as suggested above and applied the patch
> as 5.9 material.

Sorry I missed that remark about the white space. Thanks for the fixup!

> 
> Thanks!

