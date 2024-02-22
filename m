Return-Path: <linux-kernel+bounces-76468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A285F795
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368F91C23DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3E45C08;
	Thu, 22 Feb 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wUR2NHZn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AD3F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602963; cv=none; b=e+ZlMeYnExcdfEaP4AOhM7U5KA5+Zd6k6VC6kfc125PNxF9HBVXuF7mtFgjyGkDJO/Gn5xW/diU9v0+HcLBB+PEhr1zieQQ0xBRxpoeVpWdjheOI4AdXkOMi8YeH3OKuh3o52rJol0R12gh+UN3JKME/33aNGu2tG/GjjoO4C+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602963; c=relaxed/simple;
	bh=MTZib+sgUdCfxTYPSm0rjTzkXr3P5gse+DQK51tCwZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdniW8r01TkmYy/0kSt3owVXnZ9359ZFvj4O1r4N2qzszxSW1AaSPlToSSOjtNpvMzj90fTKIGo/n+FejrpV7t8Zryz3ILtWLSucQqq7rcwFUQVPyLlQfR/mIJGpFl2D/agr28CmDkt5xfO3e+R/+9xuQkFsXbm5JkKLS9d64/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wUR2NHZn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4128d15ae56so1724515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708602960; x=1709207760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pH9lFW9jwuISEJE0s5Q/XzAjg92dbYZszfc5ss0kQCs=;
        b=wUR2NHZnkMub0lt2borWpnMa8DHZNWLQ8aq7MG+28u+iIRnN7+XA5qpvnY144NDDoD
         99jNJKCxquTvaDpHXsG1Y95P3xlOv63apAPT7uDCs7y3pCU69uDv5xUX1bVwdQyCalI5
         HRVcR0A8IZ0kpHaVLjE9Jn4uM5gRgdVzECAl/Y5cSGAoB8K2UOmxg9BU7GTk+ZejAa0m
         n3VzTH+1n7CpMGwJMw/zI4AswURaAvP2poi+nlIiz5p2+fPgU3XfvEeQckJ5PMTHC/fa
         jd9dAnFI0WkX8nKpux3feZ6hGmzflH3wDEg/4zCrrh0oxovs7tzKFCHlVpvYfTueNFST
         opxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602960; x=1709207760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH9lFW9jwuISEJE0s5Q/XzAjg92dbYZszfc5ss0kQCs=;
        b=RLYDZ9kF+MvSCi/9dVmteklU1sS4xb6oqW1nZrF17Q4K8nRBxMjYjwlJ8bLFpbuLFk
         y1cQuwREmCQYcPFk3sZYaaaTl4TJ3NUr0pVTf685wkqLyUpNXwyTdnJUQcx3YYLheI4V
         Llw1NHr6XTfy7PiJpuZsAdzbvKlrCQhFjP8LxSgnN64RgLtwZ+WnPt87bR2snNdOEjSC
         +UP+HEBhBRUprcbRwhuvqyqWiKSceAhzgeqT+LK7e61acdFnY/MlBz+fKh5lj+TpImCR
         FLIrVbXD5aB1XJb2I6YG8rxdNOndL0g4wBBfXQM0ZaUh1oQG2Gzt1YT+kGsBBS7G5BXy
         ygoA==
X-Forwarded-Encrypted: i=1; AJvYcCX2WP9iSVO+q85rX8Amc6+J/K/FT1yeoUzFcEk5iDMB++u2HeT+MWIOsFeMrCOGG57/ChBkOkMs54zoVp316x3+XS5xEMBuk6+tGXzo
X-Gm-Message-State: AOJu0YxbGGAAOBfsHM10THj9gnj8/Z6lxYl2jy6ttcDiMvtfEyp7KVAB
	3xa10wvCYm4hHe/+PfG/EB53D/lvS041t2l9ocXefNuwIYhgVqcBoUrJnbCgG/k=
X-Google-Smtp-Source: AGHT+IFgKJndOp77uaoINQOnBlVIC/bKv5sQ5fttkGBD2lASIeWzNh+11TuyThxhaKVUQ+eAMq2MXg==
X-Received: by 2002:a05:600c:45c9:b0:412:7b4d:b22a with SMTP id s9-20020a05600c45c900b004127b4db22amr1558164wmo.19.1708602959926;
        Thu, 22 Feb 2024 03:55:59 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id x4-20020adff644000000b0033b792ed609sm20233903wrp.91.2024.02.22.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:55:59 -0800 (PST)
Date: Thu, 22 Feb 2024 11:55:57 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian.Loehle@arm.com
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240222115557.blnm4uulkxnorrl4@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
 <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>

On 02/20/24 18:38, Pierre Gondois wrote:
> Hello Qais,
> 
> I added some other remarks,
> 
> On 2/20/24 14:50, Qais Yousef wrote:
> > On 02/14/24 10:19, Pierre Gondois wrote:
> > > Hello,
> > > 
> > > On 2/12/24 16:53, Rafael J. Wysocki wrote:
> > > > On Mon, Feb 5, 2024 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > 
> > > > > On 05-02-24, 02:25, Qais Yousef wrote:
> > > > > > 10ms is too high for today's hardware, even low end ones. This default
> > > > > > end up being used a lot on Arm machines at least. Pine64, mac mini and
> > > > > > pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> > > > > > it's too high for all of them.
> > > > > > 
> > > > > > Change the default to 2ms which should be 'pessimistic' enough for worst
> > > > > > case scenario, but not too high for platforms with fast DVFS hardware.
> > > > > > 
> > > > > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > > > > ---
> > > > > >    drivers/cpufreq/cpufreq.c | 4 ++--
> > > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > > index 44db4f59c4cc..8207f7294cb6 100644
> > > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > > @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> > > > > >                  * for platforms where transition_latency is in milliseconds, it
> > > > > >                  * ends up giving unrealistic values.
> > > > > >                  *
> > > > > > -              * Cap the default transition delay to 10 ms, which seems to be
> > > > > > +              * Cap the default transition delay to 2 ms, which seems to be
> > > > > >                  * a reasonable amount of time after which we should reevaluate
> > > > > >                  * the frequency.
> > > > > >                  */
> > > > > > -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> > > > > > +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
> > > > > 
> > > > > Please add spaces around '*'.
> > > > > 
> > > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > 
> > > > I've adjusted the whitespace as suggested above and applied the patch
> > > > as 5.9 material.
> > > > 
> > > > Thanks!
> > > > 
> > > 
> > > To add some numbers, on a Juno-r2, with latency measured between the frequency
> > > request on the kernel side and the SCP actually making the frequency update.
> > > 
> > > The SCP is the firmware responsible of making the frequency updates. It receives
> > > the kernel requests and coordinate them/make the actual changes. The SCP also has
> > > a mechanism called 'fast channel' (FC) where the kernel writes the requested
> > > frequency to a memory area shared with the SCP. Every 4ms, the SCP polls/reads
> > > these memory area and make the required modifications.
> > > 
> > > Latency values (in ms)
> > > Workload:
> > > Idle system, during ~30s
> > > +---------------------------------------+
> > > |       |   Without FC  |      With FC  |
> > > +-------+---------------+---------------+
> > > | count |       1663    |        1102   |
> > > | mean  |          2.92 |          2.10 |
> > > | std   |          1.90 |          1.58 |
> > > | min   |          0.21 |          0.00 |
> > > | 25%   |          1.64 |          0.91 |
> > > | 50%   |          2.57 |          1.68 |
> > > | 75%   |          3.66 |          2.97 |
> > > | max   |         14.37 |         13.50 |
> > > +-------+---------------+---------------+
> > > 
> > > Latency values (in ms)
> > > Workload:
> > > One 1% task per CPU, period = 32ms. This allows to wake up the CPU
> > > every 32ms and send more requests/give more work to the SCP. Indeed
> > > the SCP is also responsible of idle state transitions.
> > > Test duration ~=30s.
> > > +---------------------------------------+
> > > |       |   Without FC  |      With FC  |
> > > +-------+---------------+---------------+
> > > | count |       1629    |       1446    |
> > > | mean  |          3.23 |          2.31 |
> > > | std   |          2.40 |          1.73 |
> > > | min   |          0.05 |          0.02 |
> > > | 25%   |          1.91 |          0.98 |
> > > | 50%   |          2.65 |          2.00 |
> > > | 75%   |          3.65 |          3.23 |
> > > | max   |         20.56 |         16.73 |
> > > +-------+---------------+---------------+
> > > 
> > > ---
> 
> 1.
> With this patch, platforms like the Juno which:
> - don't set a `transition_delay_us`
> - have a high `transition_latency` (> 1ms)
> can request freq. changes every 2ms.
> 
> If a platform has a `transition_latency` > 2ms, this means:
>   `transition_latency` > `transition_delay_us`
> I.e. a second freq. requests might be emitted before the first one
> will be completed. On the Juno, this doesn't cause any 'real' issue
> as the SCMI/mailbox mechanism works well, but this doesn't seem
> correct.
> If the util of CPUs is in between OPPs (i.e. freq. changes are often
> required), the Juno:
> - sends a freq. request
> - waits for completion and schedules another task in the meantime
> - upon completion, immediately sends a new freq.
> 
> I think that the following should be respected/checked:
> - `transition_latency` < `transition_delay_us`
> (it might also make sense to have, with K being any factor:)
> - `transition_latency` * K < `transition_delay_us`

Makes sense. How about this? I am not sure it is better to multiply with
a factor if the platform is already slow. Even the current 1000 multiply factor
is high but this is a territory I am not ready to step into yet.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..68a5ba24a5e0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,6 +576,15 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)

        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency) {
+               unsigned int max_delay_us = 2 * MSEC_PER_SEC;;
+
+               /*
+                * If the platform already has high transition_latency, use it
+                * as-is.
+                */
+               if (latency > max_delay_us)
+                       return latency;
+
                /*
                 * For platforms that can change the frequency very fast (< 10
                 * us), the above formula gives a decent transition delay. But
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
                 * a reasonable amount of time after which we should reevaluate
                 * the frequency.
                 */
-               return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
        }

        return LATENCY_MULTIPLIER;

> 
> 
> 2.
> There are references to the 10ms values at other places in the code:
> 
> include/linux/cpufreq.h
>  * ondemand governor will work on any processor with transition latency <= 10ms,

Not sure this one needs updating. Especially with the change above which means
10ms could theoretically happen. But if there are suggestions happy to take
them.

> 
> drivers/cpufreq/cpufreq.c
>  * For platforms that can change the frequency very fast (< 10
>  * us), the above formula gives a decent transition delay. But
> -> the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER

I can't find this one.

> 
> Documentation/admin-guide/pm/cpufreq.rst
>  Typically, it is set to values of the order of 10000 (10 ms).  Its
>  default value is equal to the value of ``cpuinfo_transition_latency``

I am not sure about this one. It refers to cpuinfo_transition_latency not the
delay and uses a formula to calculate it based on that.

Seems the paragraph needs updating in general to reflect other changes?

> 
> 
> 3.
> There seems to be a dependency of the conservative/ondemand governors
> over the the value returned by `cpufreq_policy_transition_delay_us()`:
> 
> drivers/cpufreq/cpufreq_governor.c
>   dbs_data->sampling_rate = max_t(unsigned int,
>     CPUFREQ_DBS_MIN_SAMPLING_INTERVAL,            // = 2 * tick period = 8ms
>     cpufreq_policy_transition_delay_us(policy));  // [1]: val <= 2ms
> 
> [1]
> if `transition_latency` is not set and `transition_delay_us` is,
> which is the case for the Juno.
> 
> The `sampling_rate` is, FYIU, the period used to evaluate the ratio
> of the idle/busy time, and if necessary increase/decrease the freq.
> 
> This patch will likely reduce this sampling rate from 10ms -> 8ms
> (if `cpufreq_policy_transition_delay_us()`` now returns 2ms for some
> platforms). This is not much, but just wanted to note it.

I don't think this is a problem as tick being 1ms is common and
transition_delay_us is not 10ms on all platforms. On my amd system it is 1ms
and on another intel i5 it is 5ms. So it should have already been coping with
various combination.


Thanks!

--
Qais Yousef

