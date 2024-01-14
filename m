Return-Path: <linux-kernel+bounces-25525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3482D1D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E8C1C208D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D610958;
	Sun, 14 Jan 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7mr7pg/"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF391078B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dde173384aso3809913a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705255870; x=1705860670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZ1LMv/V8F731Aa0Wog+VsjYAtCsiVQiJWnq/qLkV70=;
        b=d7mr7pg/CjQdZjaJvEpWP7RfrlbZwLtxeTKuMpun1eihJbi1r3Shqs48Sw0ZKGLJyT
         NxARB6Id5poOARF1HmwHysE29xd4mI/3ABEWVSzW+fKLAedd6jJUaivHKjk7cn9bypp0
         fH7ETs73pLgJBteGHVzGwMRm1ynGcuW7C7yB9L8y+Gr14h7xPVK/nrM45EGcoMEIGVDi
         02Oz1dqniscHgfyelRrjKgcJ3UCiRVhJBuFMOJZUNNsFatHClK4EFTPNW9vjpR2OM84P
         jcyijXL7sxFZYKjtaPcg4Gnr0QIxsxAlnBc6pjeF7Cqc7kF2DqrohpyoI/oV2pKO0Xjp
         N9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705255870; x=1705860670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ1LMv/V8F731Aa0Wog+VsjYAtCsiVQiJWnq/qLkV70=;
        b=HcqreAr8Mg33PLMPrVEjJJNvIlWL30BHqe6fWz6fqZL0q34909rTKY9vTZzk/f+MW8
         P/IG92QZbr8Rw1TTZVpjn2YmkJzxv5nena8iF3fYaIDI0KQHJvO/Stgjd5qb8Sj0g5Bg
         37rtD5J9IKnNE77dGieygydk1VKbtbB5Zwy1POrPVkCPXAclt5RaAM6vewzgLzYvN1iJ
         ZVXsCmALjOKwugVLKKeEBAd99rzueVtZNwrB2+xfKEi8ByDf615DokIqpDhpBbzCoU2t
         2CVtReIpuxd4VFML+WzaAmwXKCeVz9rXd47ELB0q6kiMC0YbimYZL/PYV/6KdIR4zTfR
         hDNw==
X-Gm-Message-State: AOJu0Ywxjfrpan0Mokf6oKQZ6ludixYfJ2l7j1QWc2nJ1lWLQQsR0/pT
	HcBppQk0a1cFYkNjuqkPZwA=
X-Google-Smtp-Source: AGHT+IFagQPEANMgGe9/Qn4DBHkhHr7qPf1BcTDVNd3i4ROBc+O0QL0eg4iwI2Jvw+ct0diqm6sW3A==
X-Received: by 2002:a05:6830:18e6:b0:6dd:e242:28fd with SMTP id d6-20020a05683018e600b006dde24228fdmr4841175otf.53.1705255870330;
        Sun, 14 Jan 2024 10:11:10 -0800 (PST)
Received: from wyes-pc ([2401:4900:1cc5:6bb8:c7e3:ac96:f3b2:a36a])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7924f000000b006d9a48882f7sm6210866pfp.118.2024.01.14.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 10:11:09 -0800 (PST)
Date: Sun, 14 Jan 2024 23:41:03 +0530
From: Wyes Karny <wkarny@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240114181103.osrjpvtibmy7cmcq@wyes-pc>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>

On Sun, Jan 14, 2024 at 02:03:14PM +0100, Vincent Guittot wrote:
> On Sun, 14 Jan 2024 at 13:38, Wyes Karny <wkarny@gmail.com> wrote:
> >
> > On Sun, Jan 14, 2024 at 12:18:06PM +0100, Vincent Guittot wrote:
> > > Hi Wyes,
> > >
> > > Le dimanche 14 janv. 2024 à 14:42:40 (+0530), Wyes Karny a écrit :
> > > > On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
> > > > > On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> > > > > <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > It's one of these two:
> > > > > >
> > > > > >   f12560779f9d sched/cpufreq: Rework iowait boost
> > > > > >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation
> > > > > >
> > > > > > one more boot to go, then I'll try to revert whichever causes my
> > > > > > machine to perform horribly much worse.
> > > > >
> > > > > I guess it should come as no surprise that the result is
> > > > >
> > > > >    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit
> > > > >
> > > > > but to revert cleanly I will have to revert all of
> > > > >
> > > > >       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
> > > > >       f12560779f9d ("sched/cpufreq: Rework iowait boost")
> > > > >       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> > > > > performance estimation")
> > > > >
> > > > > This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.
> > > > >
> > > > > I'll keep that revert in my private test-tree for now (so that I have
> > > > > a working machine again), but I'll move it to my main branch soon
> > > > > unless somebody has a quick fix for this problem.
> > > >
> > > > Hi Linus,
> > > >
> > > > I'm able to reproduce this issue with my AMD Ryzen 5600G system.  But
> > > > only if I disable CPPC in BIOS and boot with acpi-cpufreq + schedutil.
> > > > (I believe for your case also CPPC is diabled as log "_CPC object is not
> > > > present" came). Enabling CPPC in BIOS issue not seen in my system.  For
> > > > AMD acpi-cpufreq also uses _CPC object to determine the boost ratio.
> > > > When CPPC is disabled in BIOS something is going wrong and max
> > > > capacity is becoming zero.
> > > >
> > > > Hi Vincent, Qais,
> > > >
> 
> ...
> 
> > >
> > > There is something strange that I don't understand
> > >
> > > Could you trace on the return of sugov_get_util()
> > > the value of sg_cpu->util ?
> >
> > Yeah, correct something was wrong in the bpftrace readings, max_cap is
> > not zero in traces.
> >
> >              git-5511    [001] d.h1.   427.159763: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.163733: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.163735: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.167706: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.167708: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.171678: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.171679: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.175653: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.175655: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.s1.   427.175665: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.s1.   427.175665: get_next_freq.constprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >
> > Debug patch applied:
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..5c9b3e1de7a0 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -166,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >
> >         freq = get_capacity_ref_freq(policy);
> >         freq = map_util_freq(util, freq, max);
> > +       trace_printk("[DEBUG] : freq %llu, util %llu, max %llu\n", freq, util, max);
> >
> >         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >                 return sg_policy->next_freq;
> > @@ -199,6 +200,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> >         util = max(util, boost);
> >         sg_cpu->bw_min = min;
> >         sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
> > +       trace_printk("[DEBUG] : util %llu, sg_cpu->util %llu\n", util, sg_cpu->util);
> >  }
> >
> >  /**
> >
> >
> > So, I guess map_util_freq going wrong somewhere.
> 
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

Issue seems to be fixed with this (but bit modified by me for arithmetic precedence):

patch:

@@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
        if (arch_scale_freq_invariant())
                return policy->cpuinfo.max_freq;
 
-       return policy->cur;
+       return policy->cur + (policy->cur >> 2);
 }
 
 /**

trace:
            make-7912    [001] d..2.   182.070005: sugov_get_util: [DEBUG] : util 595, sg_cpu->util 743
            make-7912    [001] d..2.   182.070006: get_next_freq.constprop.0: [DEBUG] : freq 3537231, util 743, max 1024
              sh-7956    [001] d..2.   182.070494: sugov_get_util: [DEBUG] : util 835, sg_cpu->util 1024
              sh-7956    [001] d..2.   182.070495: get_next_freq.constprop.0: [DEBUG] : freq 4875000, util 1024, max 1024
              sh-7956    [001] d..2.   182.070576: sugov_get_util: [DEBUG] : util 955, sg_cpu->util 1024
              sh-7956    [001] d..2.   182.070576: get_next_freq.constprop.0: [DEBUG] : freq 4875000, util 1024, max 1024
              sh-7957    [001] d.h1.   182.072120: sugov_get_util: [DEBUG] : util 990, sg_cpu->util 1024
              sh-7957    [001] d.h1.   182.072121: get_next_freq.constprop.0: [DEBUG] : freq 4875000, util 1024, max 1024
              nm-7957    [001] dNh1.   182.076088: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024
              nm-7957    [001] dNh1.   182.076089: get_next_freq.constprop.0: [DEBUG] : freq 4875000, util 1024, max 1024
            grep-7958    [001] d..2.   182.076833: sugov_get_util: [DEBUG] : util 1024, sg_cpu->util 1024


Thanks,
Wyes

