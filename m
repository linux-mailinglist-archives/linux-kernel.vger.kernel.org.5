Return-Path: <linux-kernel+bounces-27229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E155182EC75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797372844FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEE18AF0;
	Tue, 16 Jan 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyilO6D7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE21756C;
	Tue, 16 Jan 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e86c86a6fso126465e9.2;
        Tue, 16 Jan 2024 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705399193; x=1706003993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si59UtDvYnkoR5qP2N5Z67QQnuZarHWZ4VkQAHNmja8=;
        b=LyilO6D7hdEJX9CmbMYUIDFWsTl+DJerkULotIW89bVjy6Dff/PiRi9jOR8URJ/v0b
         l28TveGGOPXL5h2ycnZHLaPdMxRC4SwrLR2YM60hJconiiQ0tx0q4Fc1zBPvm0cv9xyY
         zeygR3BhPatiKt9wk5rUmhMR3Uxb7XH0B0gZ+dahtFBSjzgRR75I/sPyVY5rm5lbTULc
         hzW5U8ZQ6HpsN6YPMz5YzF7m8h0IypsCB/TYww/VY2zKotXqfuOvQ50Pu1d5wUcdaXRk
         cRADhk4iWnG+RrUG1pTs3yeDA5A9WxGsKoZgYr1E6nBg1xZO7Acbrw5iJcGXluGs07Em
         T2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399193; x=1706003993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=si59UtDvYnkoR5qP2N5Z67QQnuZarHWZ4VkQAHNmja8=;
        b=hwqjqCqgGAFYHXI3vS3ze0rO1G0KKiWGP+qtVHqkNbuWXgzd115eEELVkzYD7YErE6
         l3hdGumH8W3em7nmOFuwb0pkdA3Z/t2EZwiPjsinAMh8ESqaUhQLMfcNE1Xtw6YCjqgH
         j+D31og0obzR8bqY5G9swZd8I/WG47ZfaWelmzpVJpJ22AmWPy1/KWw4eZBUlnPBj5cb
         5tFIXO/ahd1x72jFr+O8bBiJY6ioZXFEv5n3cF0DCKEYT/yg/QbW3d8iPo01VaEFH4lW
         1zE0RKY0xe9ZvCXR1E9RqUEZawQyAkDL4EvcGOX3LpMLHpSDimktxW0mGH0X+9RQn3Bu
         peUQ==
X-Gm-Message-State: AOJu0YwRKdmPPP93b5NrsYneEeelwtfI1OFSoPv6r2QlHLrxEm5Xf0Fs
	VBDvADVrFR6qONCC8kFyEYA=
X-Google-Smtp-Source: AGHT+IHQKMMLqyYCyaKlq3XNqqVCpXok+AmTjD32SU1kv3Wfmw3VKFhmTteZAvKyyHYjZcNp9eqglw==
X-Received: by 2002:a05:600c:4850:b0:40e:3655:db8b with SMTP id j16-20020a05600c485000b0040e3655db8bmr1625550wmo.120.1705399192512;
        Tue, 16 Jan 2024 01:59:52 -0800 (PST)
Received: from gmail.com (1F2EF378.nat.pool.telekom.hu. [31.46.243.120])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c358a00b0040e559e0ba7sm22405066wmq.26.2024.01.16.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 01:59:51 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 16 Jan 2024 10:59:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	wkarny@gmail.com, torvalds@linux-foundation.org,
	qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Message-ID: <ZaZTlcFZaQefnf1v@gmail.com>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114183600.135316-1-vincent.guittot@linaro.org>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> returns the current frequency and the performance margin applied by
> map_util_perf(), enabled the utilization to go above the maximum compute
> capacity and to select a higher frequency than the current one.
> 
> The performance margin is now applied earlier in the path to take into
> account some utilization clampings and we can't get an utilization higher
> than the maximum compute capacity.
> 
> We must use a frequency above the current frequency to get a chance to
> select a higher OPP when the current one becomes fully used. Apply
> the same margin and returns a frequency 25% higher than the current one in
> order to switch to the next OPP before we fully use the cpu at the current
> one.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..d12e95d30e2e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>  	if (arch_scale_freq_invariant())
>  		return policy->cpuinfo.max_freq;
>  
> -	return policy->cur;
> +	/*
> +	 * Apply a 25% margin so that we select a higher frequency than
> +	 * the current one before the CPU is full busy
> +	 */
> +	return policy->cur + (policy->cur >> 2);
>  }

I've updated the changelog to better express what was broken and how we 
fixed it. Ack?

	Ingo

==========================>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Jan 2024 19:36:00 +0100
Subject: [PATCH] sched/fair: Fix frequency selection for non-invariant case

Linus reported a ~50% performance regression on single-threaded
workloads on his AMD Ryzen system, and bisected it to:

  9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

When frequency invariance is not enabled, get_capacity_ref_freq(policy)
is supposed to return the current frequency and the performance margin
applied by map_util_perf(), enabling the utilization to go above the
maximum compute capacity and to select a higher frequency than the current one.

After the changes in 9c0b4bb7f630, the performance margin was applied
earlier in the path to take into account utilization clampings and
we couldn't get a utilization higher than the maximum compute capacity,
and the CPU remained 'stuck' at lower frequencies.

To fix this, we must use a frequency above the current frequency to
get a chance to select a higher OPP when the current one becomes fully used.
Apply the same margin and return a frequency 25% higher than the current
one in order to switch to the next OPP before we fully use the CPU
at the current one.

[ mingo: Clarified the changelog. ]

Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Wyes Karny <wkarny@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Wyes Karny <wkarny@gmail.com>
Link: https://lore.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..eece6244f9d2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
 	if (arch_scale_freq_invariant())
 		return policy->cpuinfo.max_freq;
 
-	return policy->cur;
+	/*
+	 * Apply a 25% margin so that we select a higher frequency than
+	 * the current one before the CPU is fully busy:
+	 */
+	return policy->cur + (policy->cur >> 2);
 }
 
 /**

