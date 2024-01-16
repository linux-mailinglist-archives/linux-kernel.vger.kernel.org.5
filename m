Return-Path: <linux-kernel+bounces-27407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278982EF84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D758B21895
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD01BC56;
	Tue, 16 Jan 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pBhbcoIS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7741BDC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e80046246so8488505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705410635; x=1706015435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpQQ6zM11+ltm4n0lLXCP3FxFwkBIpd9Of4Vw5bi6aw=;
        b=pBhbcoISgFyZsCb9smXkKqDIdZuEdnJyKZrm+sLjMMJYqSY2uZaVdrStq+f43cnnSs
         r/xoc0V94jG/vtBXp2j1zEtq2a0++bPYWed6tg4AgTp2YQ5M9iiEpKSuwH+BBK1by5Di
         k8Gh/T9FMWd+/MqXKWPfwWqNzMHhxThq5dTJhtxwBdTINhTTciDhxBO7+v9nXdE1U4GW
         Fv/GY2XKnNt2FREzLzb4gakadLhthUjEc9V4+U4KTEm83LyX7SCNAE19M9r4ZvZjCVD0
         EX9CLHbEgiA7xsEN7r3bfrDy7AF4SAnjRNvbwK5cil0HFFFJtSvLKIkXPv6j4UjxXne2
         D+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410635; x=1706015435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpQQ6zM11+ltm4n0lLXCP3FxFwkBIpd9Of4Vw5bi6aw=;
        b=bUoS2dDK7RqNkVSkAtX9XCJaeHJALV193jV9wEbP9LQtraOBYq4JmMi0Da4ktghtgO
         RGB5h3oPKHuncNwP9ASJuOHaZOm8hJeWuL5s24huKSAEy12FmzzUMfOUadI/tL2I8lkM
         zS5cHXafNVJHSL20HRMI+AOmmX7o3VRNDlIEVBZ9tKmq0mgQX1j6jtr9EchWNddUI23u
         ex3FAYEkzCOkin876OJNoy8T4KRmMhBaCcfuSHb8oLD2Xwkxu2BjqlnPKxOuLJJOZD/J
         aIWeppYdWeuP61w3GnzxYsmLGPFQ2gXqzSGYHQDOzhU9p6VvJv8jBU9G1f0lasaj2/3q
         m/Hw==
X-Gm-Message-State: AOJu0YyjY8nXEw5prl29hqU0pXso38fRW6nQq7GdK6N9MIklHjETezlj
	LuAamNCida05nq/55xh1O7H9oMAIq6HxAw==
X-Google-Smtp-Source: AGHT+IELsyAZ7Icn9jnJH9VW3SNMomtvGax5Mz1vFC5N+G/Mzm8tRYlxO92yZwfqcwVqh2Z2dhpR1A==
X-Received: by 2002:a05:600c:20d3:b0:40e:5977:3937 with SMTP id y19-20020a05600c20d300b0040e59773937mr3328913wmm.69.1705410634797;
        Tue, 16 Jan 2024 05:10:34 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b00337bdf4cfc6sm995109wrj.52.2024.01.16.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:10:34 -0800 (PST)
Date: Tue, 16 Jan 2024 13:10:33 +0000
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
Message-ID: <20240116131033.45berjhpwzc4hwr7@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
 <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
 <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>
 <20240115122156.5743y4trhm4tkgs3@airbuntu>
 <661068a2-7c46-4703-ba4d-5ce1cdf44b3d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <661068a2-7c46-4703-ba4d-5ce1cdf44b3d@arm.com>

On 01/15/24 12:36, Lukasz Luba wrote:
> 
> 
> On 1/15/24 12:21, Qais Yousef wrote:
> > On 01/10/24 13:53, Lukasz Luba wrote:
> > > 
> > > 
> > > On 1/4/24 19:23, Qais Yousef wrote:
> > > > On 01/02/24 11:47, Lukasz Luba wrote:
> > > > > > Did you see a problem or just being extra cautious here?
> > > > > 
> > > > > There is no problem, 'cost' is a private coefficient for EAS only.
> > > > 
> > > > Let me  ask differently, what goes wrong if you don't increase the resolution
> > > > here? Why is it necessary?
> > > > 
> > > 
> > > 
> > > When you have 800mW at CPU capacity 1024, then the value is small (below
> > > 1 thousand).
> > > Example:
> > > power = 800000 uW
> > > cost = 800000 / 1024 = 781
> > > 
> > > While I know from past that sometimes OPPs might have close voltage
> > > values and a rounding could occur and make some OPPs inefficient
> > > while they aren't.
> > > 
> > > This is what would happen when we have the 1x resolution:
> > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:551
> > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:644
> > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:744
> > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:851
> > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:493
> > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:493
> > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:493
> > > The bottom 3 OPPs have the same 'cost' thus 2 OPPs are in-efficient,
> > > which is not true (see below).
> > > 
> > > This is what would happen when we have the 10x resolution:
> > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:5513
> > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:6443
> > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:7447
> > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:8514
> > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:4934
> > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:4933
> > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:4934
> > > Here the OPP with 600MHz is more efficient than 408MHz,
> > > which is true. So only 408MHz will be marked as in-efficient OPP.
> > > 
> > > 
> > > This is what would happen when we have the 100x resolution:
> > > /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:55137
> > > /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:64433
> > > /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:74473
> > > /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:85140
> > > /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:49346
> > > /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:49331
> > > /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:49346
> > > The higher (100x) resolution does not bring that much in
> > > practice.
> > 
> > So it seems a uW is not sufficient enough. We moved from mW because of
> > resolution already. Shall we make it nW then and multiply by 1000 always? The
> > choice of 10 looks arbitrary IMHO
> > 
> 
> No, there is no need of nW in the 'power' field for this.
> You've missed the point.

I think you're missing what I am saying. The multiplication by 10 looks like
magic value to increase resolution based on a single observation you noticed.

The feedback I am giving is that this needs to be better explained, in
a comment. And instead of multiplying by 10 multiply by 1000. Saying this is
enough based on a single observation is not adequate IMO.

Also the difference is tiny. Could you actually measure a difference in overall
power with and without this extra decimal point resolution? It might be better
to run at 816MHz and go back to idle faster. So the trade-off is not clear cut
to me.

So generally I am not keen on magic values based on single observations.
I think removing this or use 1000 is better.

AFAICT you decided that 0.1uW is worth caring about. But 0.19uW difference
isn't.

I can't see how much difference this makes in practice tbh. But using more
uniform conversion so that the cost is in nW (keep the power field in uW) makes
more sense at least.

It still raises the question whether this minuscule cost difference is actually
better taken into account. I think the perf/watt for 816MHz is much better so
skipping 600MHz as inefficient looks better to me.

