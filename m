Return-Path: <linux-kernel+bounces-23453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D658982ACF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D533B25D32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BA156D6;
	Thu, 11 Jan 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVVquXoa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB60156D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28bf46ea11so908418366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704971367; x=1705576167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nwu2CRbyzm3Fyxs9Pc4nqD1ofHR8eiLe9G1Hv2MTRh0=;
        b=JVVquXoae7wFgKSsrcHT5e1cLAaN8HyTWomZBSnOKoRthIw985DwvYF4k7yTl35Qgu
         pke742vaW1GTo4CMoKXLXju980aACLt+GR4k46YzNX/3WPy+9m9hOYmnhaPQ8ISiAJvL
         Fp850pdQ0Pb/l5e/MGO/UwqbR2KIErRCAUVxUm1dy8RqYgSh3wWup95kFECwsCYl+4an
         89bVH2SkFLinL7brB4fBQOSsmlRFi48jSZ18Kd15WfgDuB4aPcTJm1nJtbsNsqHuesHL
         BuW9EXDex8hISEPSbmNr+Pc2LJsIHKkuraY8BzgODSypy9d/RjvSv+PIBZjowe26FR2K
         R8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971367; x=1705576167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwu2CRbyzm3Fyxs9Pc4nqD1ofHR8eiLe9G1Hv2MTRh0=;
        b=CLTp2LeJT+8W6anb9E+Qfhls68uQXROitINyaQTtGsqtPnDS8bdNCY7zknaB3SYYwd
         O6qJ3fEFawLToT/AK7c570kZPcL993WSI8kqCjClwl+38/e1/wwicwPs29eLcFaiOVpr
         c9XiJ8b/SEHc/Q8v26GT2y4NObTFvy1r2PYiqLG2WE2/hPfrj0kgc31pVc7Bhy/YZEac
         tkG79JVsKbPF5zKSjV0KMnS5+c2oFzN5bUp17fd8yWImNhLZlQLhuieSautT5WgSCJST
         TlWpsu8Sh/Myyq2ZcCQfJxRJtuewJ0koyd7UQC8SaWTh6pi7WR7uzU77myESZbWHEAOw
         NGpA==
X-Gm-Message-State: AOJu0Yw1NNNL+1QW5h6+Xm9a412ttVZ+GCZASTm9V52LDspFbecmLbJk
	+eUIaeyN9AnF+M+wY3s++30=
X-Google-Smtp-Source: AGHT+IHvowrKCg8LiOqlfdUzZTJIvNUbJM0TP0tBor1fjWBKiSo1lNB7ViPPvplGQEt06syQ9mgwFA==
X-Received: by 2002:a17:906:7fc4:b0:a26:96e8:c027 with SMTP id r4-20020a1709067fc400b00a2696e8c027mr660110ejs.28.1704971366840;
        Thu, 11 Jan 2024 03:09:26 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id ov18-20020a170906fc1200b00a2a184687dasm443865ejb.31.2024.01.11.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:09:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Jan 2024 12:09:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZZ/MY0KEGXotqGHY@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

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
> 
> I'll keep that revert in my private test-tree for now (so that I have
> a working machine again), but I'll move it to my main branch soon
> unless somebody has a quick fix for this problem.

Thanks a lot for bisecting this, and ack on the revert in any case, these 
are relatively fresh changes that clearly didn't get enough testing - sorry!

I also made the revert in sched/urgent & added a changelog, which you can 
pull from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-01-11

   # HEAD: 250ce3c1169743f3575cc5937fccd72380052795 Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commits

Revert recent changes to the sched_util logic, to address a bad
performance regression that increased kernel build time on Linus's
64-CPU desktop system substantially.

Lightly build and boot tested.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commits


 include/linux/energy_model.h     |  1 +
 kernel/sched/core.c              | 90 +++++++++++++++++++++++-----------------
 kernel/sched/cpufreq_schedutil.c | 90 ++++++++++++----------------------------
 kernel/sched/fair.c              | 22 ++--------
 kernel/sched/sched.h             | 84 +++++++++++++++++++++++++++++++++----
 5 files changed, 160 insertions(+), 127 deletions(-)

