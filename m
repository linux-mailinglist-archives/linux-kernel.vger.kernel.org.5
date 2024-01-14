Return-Path: <linux-kernel+bounces-25491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E682D115
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C571C20ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623A23D6;
	Sun, 14 Jan 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="J2tDmK9J"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB37E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso8907025e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705245173; x=1705849973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0Y1oPUhjmsPE1otXNhij+1G6WxoVPIPuAuOHIhDqlY=;
        b=J2tDmK9J34Cb7t6290xoH4W0VbObhcMfrLYQ4XvjhtVdN1zskH9SqISfuzVx0p9oCO
         l9pr6OSIRqeU8FX+68odlLNsvKJAGez/MI28WGKhThnK7wGUqpBI5KfC6f73smgrNscB
         QdxwstN7Ml7HuKzCe1vonLNS1YEKinjTuEYiXOKz7vQQ8OGXUPTFWRrcdcR0oMEV0AWJ
         nWlWu6/K/m62SJXK+G0vvZURG+uFgw3PCUKgNBPG/rZ87Rk8SP56MArXyxnIxPxJdccI
         uPxjQaI8To4TztJ8ScBYCvv/nqo5jpK+ahRYEpeVTVIFB6PII4LFl+Q6Ijdgq6TkvosR
         HxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705245173; x=1705849973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Y1oPUhjmsPE1otXNhij+1G6WxoVPIPuAuOHIhDqlY=;
        b=Mfsgun5JIj2m9aCcoWU94bc6CL92dK0vzcDJJbIo7BTx4j2MfBcx3yBb4XrQsmacpz
         yKbTXUeJLw/BFm0BRGuO8WuFwaU+bQW2ccp89kPXKy9gCzL/evyG4DnlkE6oDMbTB+Ba
         fwe4h3tYhDTANBG1rJHmE+WAspE8swFQKLgt13ZGwA2TU9S6Ycb1YiZQVJwlbOC/IQsQ
         qsxsEP4xfn+kkgqyNZBEESJ54KzYgSA12xytFXq9YFzGgzv+u6y8pF1hd5AMRL7BPKVb
         vcjYpYm9Q+1WpFy+zsO6ZbzT4yTgNigUuZsOWWStpiQiJSsvmjGo/wzMTFeM+RgbbP3b
         y2dw==
X-Gm-Message-State: AOJu0Yw5bs4VhR8i2MdzUDVXpIJfBOPNEDPbd/AjvBm9elJHnorVd0jM
	uBFPMq6Mcx9vc77MAQTScz2LUKgiXEuCHQ==
X-Google-Smtp-Source: AGHT+IFrH9xs8JqHfk2jnkgsOkDXwUuds9ELv51kQvFG34maBaE7Qkdf8u36dAVHOO3BYuaymT/adQ==
X-Received: by 2002:a7b:ce89:0:b0:40e:467f:47c9 with SMTP id q9-20020a7bce89000000b0040e467f47c9mr1675733wmj.70.1705245172908;
        Sun, 14 Jan 2024 07:12:52 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b0040e4c1dade4sm16867130wms.36.2024.01.14.07.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 07:12:52 -0800 (PST)
Date: Sun, 14 Jan 2024 15:12:50 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Wyes Karny <wkarny@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240114151250.5wfexq44o3mdm3nh@airbuntu>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
 <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
 <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>

On 01/14/24 14:03, Vincent Guittot wrote:

> Thanks for the trace. It was really helpful and I think that I got the
> root cause.
> 
> The problem comes from get_capacity_ref_freq() which returns current
> freq when arch_scale_freq_invariant() is not enable, and the fact that
> we apply map_util_perf() earlier in the path now which is then capped
> by max capacity.
> 
> Could you try the below ?
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e420e2ee1a10..611c621543f4 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
> cpufreq_policy *policy)
>         if (arch_scale_freq_invariant())
>                 return policy->cpuinfo.max_freq;
> 
> -       return policy->cur;
> +       return policy->cur + policy->cur >> 2;
>  }
> 
>  /**

Is this a test patch or a proper fix? I can't see it being the latter. It seems
the current logic fails when util is already 1024, and I think we're trying to
fix the invariance issue too late.

Is the problem that we can't read policy->cur in the scheduler to fix the util
while it's being updated that's why it's done here in this case?

If this is the problem, shouldn't the logic be if util is max then always go to
max frequency? I don't think we have enough info to correct the invariance here
IIUC. All we can see the system is saturated at this frequency and whether
a small jump or a big jump is required is hard to tell.

Something like this

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..473d0352030b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -164,8 +164,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
        struct cpufreq_policy *policy = sg_policy->policy;
        unsigned int freq;

-       freq = get_capacity_ref_freq(policy);
-       freq = map_util_freq(util, freq, max);
+       if (util != max) {
+               freq = get_capacity_ref_freq(policy);
+               freq = map_util_freq(util, freq, max);
+       } else {
+               freq = policy->cpuinfo.max_freq;
+       }

        if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
                return sg_policy->next_freq;

