Return-Path: <linux-kernel+bounces-23188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D882A8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976351C2228B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FAE55F;
	Thu, 11 Jan 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQsq9xIY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847ABE544
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e5f3b390fso2991765e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704960712; x=1705565512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Azz0b+6CAUzmV8Ry8tVgD4tXkSCsJwibkLVSbCQpCng=;
        b=FQsq9xIYs171jKjnBn+/9MMeKFt/qJBSIsu9Gly5K2oeBMfgtXaCjapzAO/2vfRh/K
         Sk/Z97DURujdHSJJVWMBtgzv8+BRExKvyiyhszIGkywTU7Nh2eLGElkYkvgojANtvwNJ
         qjsQwbc4mbss+k03krdDDEjtHnKeKn1AfJrV6HfE3Kv5EPFEwwJI9Cxl1RkcITlVC6iL
         7MQ/mJlxaSElIKX6x6oh+0Rk+8fvPjx6HBASp00UgHbVrv7K9TPwoqbZet4yoB0KzJzh
         lAj/jiC61j3XErJR2z7auE+3C9L+SqPgPCMaoNqmAtWCDfkxSqjTyKsuAwOgDJmta4Bx
         9yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704960712; x=1705565512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azz0b+6CAUzmV8Ry8tVgD4tXkSCsJwibkLVSbCQpCng=;
        b=LQzt+J7L/zlaIC+lEBblLV33eEaPyEuL8Hc4AA6YxQxYjGRa1vltnVVIolPG5bzuzx
         0nwVmnXweRgdi71LpkSertMKGrqkW7IehfRP5DWNh1YMYZvNXJs3HXxN6nDXpwrUMxWZ
         Wo29ETfHjGUBX9EZ7EMB3cQIi006+yn4eiEpRcPQB07R130ay3VTLr4A1tdjqO1HAOM6
         poooy/MO5bD1QBD9nFi9CNJNczUgCnu0KTzGInn/V9ORalyxy6keFev/z+ggg6naBqQl
         Kbp0jyn4bWSfBqdfXyQT863bUh8fHokHuxb5tOXBXZI25d1sTjY29zea7yg0KFrhMx/H
         MaNA==
X-Gm-Message-State: AOJu0YyGnZ7PRKDAknRUkAFRJLjLkQOj2CNX+h2Sg/ONmbsns78WoOv8
	GaX7lH+wUNvO8TnZK/7bTI4rOIrUMAQH/w==
X-Google-Smtp-Source: AGHT+IHstm69eO/mK4NDR+MtLGdg9g9BxrswDOSA8dgVjgrAVSheAk5HwaUjMJLODYiyf0UBJlK2gA==
X-Received: by 2002:a05:600c:3eca:b0:40e:51bf:cd18 with SMTP id ek10-20020a05600c3eca00b0040e51bfcd18mr199258wmb.119.1704960711630;
        Thu, 11 Jan 2024 00:11:51 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:d51f:b77a:76cb:8b6e])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b0040d5b849f38sm4890721wmq.0.2024.01.11.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:11:51 -0800 (PST)
Date: Thu, 11 Jan 2024 09:11:49 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <ZZ+ixagkxRPYyTCE@vingu-book>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>

Le mercredi 10 janv. 2024 à 14:57:14 (-0800), Linus Torvalds a écrit :
> On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's one of these two:
> >
> >   f12560779f9d sched/cpufreq: Rework iowait boost
> >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation
> >
> > one more boot to go, then I'll try to revert whichever causes my
> > machine to perform horribly much worse.
> 
> I guess it should come as no surprise that the result is
> 
>    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit
> 
> but to revert cleanly I will have to revert all of
> 
>       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>       f12560779f9d ("sched/cpufreq: Rework iowait boost")
>       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> performance estimation")
> 
> This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.

Could you confirm that cpufreq governor is schedutil and the driver is
amd-pstate on your system ?

Also I'm interested by the output of the amd_pstate to confirm that it uses the
adjust_perf callback

I suppose that you don't use uclamp feature and amd doesn't use EAS so that let
the change of the min parameter of adjust_perf which was probably always 0
unless you use deadline scheduler and which now takes into account irq pressure. 

Could you try the patch below which restores the previous min value ?

---
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..3fe8ac6ce9cc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -194,10 +194,11 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
 	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
+	struct rq *rq = cpu_rq(sg_cpu->cpu);

 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
 	util = max(util, boost);
-	sg_cpu->bw_min = min;
+	sg_cpu->bw_min = cpu_bw_dl(rq);
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }

@@ -442,7 +443,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;

-	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_min),
 				   sg_cpu->util, max_cap);

 	sg_cpu->sg_policy->last_freq_update_time = time;
--
2.34.1


> 
> I'll keep that revert in my private test-tree for now (so that I have
> a working machine again), but I'll move it to my main branch soon
> unless somebody has a quick fix for this problem.
> 
>                 Linus

