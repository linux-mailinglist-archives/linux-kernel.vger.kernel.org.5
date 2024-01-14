Return-Path: <linux-kernel+bounces-25450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BCE82D06C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C5AB21304
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620C2582;
	Sun, 14 Jan 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS4yG+7i"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30457E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336897b6bd6so7560362f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705231089; x=1705835889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yG+7EMaMjgQ2b/xtnts46+u5PmtaH8N17UlmONtsmGc=;
        b=RS4yG+7iMinhlcH8z+AXNPgqjHmMgrvonUA9jI4nLktrBH9zw5GQAyJg6IZmg/OoR3
         rqCDwAbPgtGgdUtUO3VI7QgOAWHsorynWmZL7tfZYZq/9MKtcnTL9M59P1Wge/fbLpRx
         3pycBwqSAjsyePpNBxh8++yfiV+xMERkUhYN0ImxJSlTDcnkJ/gWBv0SSQAVOsRQMG/C
         vx07X0PUGzYgd/jg150J6KafcS98zJY59ARdINJQ78GQCY7uUFwdrCo1RMxIwT6DK5o3
         pyK5ws5ZZt0Vf8DbapveB3Thi2ZdQM6YBr3ytU7LZ/buHXZ9owOIBINJtrDW5U22yk+h
         h4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705231089; x=1705835889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yG+7EMaMjgQ2b/xtnts46+u5PmtaH8N17UlmONtsmGc=;
        b=RNB00ROVnEJ3Og8VOt2MMyi3GV3MLpyFMpbePX9hkTA0u0FmTUSINVTxJzLvc5LApT
         ME6JzYOrKgUoPle3cRZOqzQyOx9WyGdbDsCeLoU7BmNnTYr6+azfTwg0mU8ZU2PmxCW3
         8uZ2UuBq2KdEauWuDX+2tk+znmsah31l7BJaq6bvzicitctbchvtbwUkzFb2R9PgLxgi
         94mPdtYQRXlDbmukMeDAT/0s+YHdME4Ps68WXLy8MgdsBCBsrNGXwPCbGljGHPVEPW31
         uu4RFBGyo2XMpR1XfMt0P4p1ZgPhC7eoJQLwSlIFKYdhx8PtBeY4FRYnRYjQfKPc40D+
         ZfCg==
X-Gm-Message-State: AOJu0YwaBnhbvGCp3kU9lH2n/5oPqXPaQjjE9Q8HVNM9aMIRB4D8Ggyn
	Nqw/FTH64xb9QNmeLxC6hbe116+9uvWdvw==
X-Google-Smtp-Source: AGHT+IHuv+xkCXGK2LoEAjjrfDQoA4LwnjrklPU2Sn1m8xRyHRNQcvSnH6Nf++9R5dMFGe0cCrHk0A==
X-Received: by 2002:a05:600c:1913:b0:40e:4d1c:392e with SMTP id j19-20020a05600c191300b0040e4d1c392emr1987176wmq.16.1705231088839;
        Sun, 14 Jan 2024 03:18:08 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:6389:1f58:77fa:5f22])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040d1bd0e716sm12258209wmq.9.2024.01.14.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 03:18:08 -0800 (PST)
Date: Sun, 14 Jan 2024 12:18:06 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Wyes Karny <wkarny@gmail.com>
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
Message-ID: <ZaPC7o44lEswxOXp@vingu-book>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>

Hi Wyes,

Le dimanche 14 janv. 2024 à 14:42:40 (+0530), Wyes Karny a écrit :
> On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
> > On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It's one of these two:
> > >
> > >   f12560779f9d sched/cpufreq: Rework iowait boost
> > >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation
> > >
> > > one more boot to go, then I'll try to revert whichever causes my
> > > machine to perform horribly much worse.
> > 
> > I guess it should come as no surprise that the result is
> > 
> >    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit
> > 
> > but to revert cleanly I will have to revert all of
> > 
> >       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
> >       f12560779f9d ("sched/cpufreq: Rework iowait boost")
> >       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> > performance estimation")
> > 
> > This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.
> > 
> > I'll keep that revert in my private test-tree for now (so that I have
> > a working machine again), but I'll move it to my main branch soon
> > unless somebody has a quick fix for this problem.
> 
> Hi Linus,
> 
> I'm able to reproduce this issue with my AMD Ryzen 5600G system.  But
> only if I disable CPPC in BIOS and boot with acpi-cpufreq + schedutil.
> (I believe for your case also CPPC is diabled as log "_CPC object is not
> present" came). Enabling CPPC in BIOS issue not seen in my system.  For
> AMD acpi-cpufreq also uses _CPC object to determine the boost ratio.
> When CPPC is disabled in BIOS something is going wrong and max
> capacity is becoming zero.
> 
> Hi Vincent, Qais,
> 
> I have collected some data with bpftracing:

Thanks for your tests results

> 
> sudo bpftrace -e 'kretprobe:effective_cpu_util /cpu == 1/ { @eff_util = lhist(retval, 0, 1200, 50);} kprobe:get_next_freq /cpu == 1/ { @sugov_eff_util = lhist(arg1, 0, 1200, 50); @sugov_max_cap = lhist(arg2, 0, 1000, 2);} kretprobe:get_next_freq /cpu == 1/ { @sugov_freq = lhist(retval, 1000000, 5000000, 100000);}'
> 
> with running: taskset -c 1 make
> 
> issue case:
> 
> Attaching 3 probes...
> @eff_util:
> [0, 50)             1263 |@                                                   |
> [50, 100)            517 |                                                    |
> [100, 150)           233 |                                                    |
> [150, 200)           297 |                                                    |
> [200, 250)           162 |                                                    |
> [250, 300)            98 |                                                    |
> [300, 350)            75 |                                                    |
> [350, 400)           205 |                                                    |
> [400, 450)           210 |                                                    |
> [450, 500)            16 |                                                    |
> [500, 550)          1532 |@                                                   |
> [550, 600)          1026 |                                                    |
> [600, 650)           761 |                                                    |
> [650, 700)           876 |                                                    |
> [700, 750)          1085 |                                                    |
> [750, 800)           891 |                                                    |
> [800, 850)           816 |                                                    |
> [850, 900)           983 |                                                    |
> [900, 950)           661 |                                                    |
> [950, 1000)          759 |                                                    |
> [1000, 1050)       57433 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 

ok so the output of effective_cpu_util() seems correct or at least to maw utilization
value. In order to be correct, it means that arch_scale_cpu_capacity(cpu) is not zero
because of :

unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
				 unsigned long *min,
				 unsigned long *max)
{
	unsigned long util, irq, scale;
	struct rq *rq = cpu_rq(cpu);

	scale = arch_scale_cpu_capacity(cpu);

	/*
	 * Early check to see if IRQ/steal time saturates the CPU, can be
	 * because of inaccuracies in how we track these -- see
	 * update_irq_load_avg().
	 */
	irq = cpu_util_irq(rq);
	if (unlikely(irq >= scale)) {
		if (min)
			*min = scale;
		if (max)
			*max = scale;
		return scale;
	}
..
}

If arch_scale_cpu_capacity(cpu) returns 0 then effective_cpu_util() should returns
0 too.

Now see below

> @sugov_eff_util:
> [0, 50)             1074 |                                                    |
> [50, 100)            571 |                                                    |
> [100, 150)           259 |                                                    |
> [150, 200)           169 |                                                    |
> [200, 250)           237 |                                                    |
> [250, 300)           156 |                                                    |
> [300, 350)            91 |                                                    |
> [350, 400)            46 |                                                    |
> [400, 450)            52 |                                                    |
> [450, 500)           195 |                                                    |
> [500, 550)           175 |                                                    |
> [550, 600)            46 |                                                    |
> [600, 650)           493 |                                                    |
> [650, 700)          1424 |@                                                   |
> [700, 750)           646 |                                                    |
> [750, 800)           628 |                                                    |
> [800, 850)           612 |                                                    |
> [850, 900)           840 |                                                    |
> [900, 950)           893 |                                                    |
> [950, 1000)          640 |                                                    |
> [1000, 1050)       60679 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @sugov_freq:
> [1400000, 1500000)   69911 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @sugov_max_cap:
> [0, 2)             69926 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

In get_next_freq(struct sugov_policy *sg_policy, unsigned long util, unsigned long max)

max is 0 and we comes from this path:

static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
				     unsigned int flags)
{

..
	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);

	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
		return;

	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
..

so here arch_scale_cpu_capacity(sg_cpu->cpu) returns 0 ...

AFAICT, AMD platform uses the default 
static __always_inline
unsigned long arch_scale_cpu_capacity(int cpu)
{
	return SCHED_CAPACITY_SCALE;
}

I'm missing something here

> 
> 
> good case:
> 
> Attaching 3 probes...
> @eff_util:
> [0, 50)              246 |@                                                   |
> [50, 100)            150 |@                                                   |
> [100, 150)           191 |@                                                   |
> [150, 200)           239 |@                                                   |
> [200, 250)           117 |                                                    |
> [250, 300)          2101 |@@@@@@@@@@@@@@@                                     |
> [300, 350)          2284 |@@@@@@@@@@@@@@@@                                    |
> [350, 400)           713 |@@@@@                                               |
> [400, 450)           151 |@                                                   |
> [450, 500)           154 |@                                                   |
> [500, 550)          1121 |@@@@@@@@                                            |
> [550, 600)          1901 |@@@@@@@@@@@@@                                       |
> [600, 650)          1208 |@@@@@@@@                                            |
> [650, 700)           606 |@@@@                                                |
> [700, 750)           557 |@@@                                                 |
> [750, 800)           872 |@@@@@@                                              |
> [800, 850)          1092 |@@@@@@@                                             |
> [850, 900)          1416 |@@@@@@@@@@                                          |
> [900, 950)          1107 |@@@@@@@                                             |
> [950, 1000)         1051 |@@@@@@@                                             |
> [1000, 1050)        7260 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @sugov_eff_util:
> [0, 50)              241 |                                                    |
> [50, 100)            149 |                                                    |
> [100, 150)            72 |                                                    |
> [150, 200)            95 |                                                    |
> [200, 250)            43 |                                                    |
> [250, 300)            49 |                                                    |
> [300, 350)            19 |                                                    |
> [350, 400)            56 |                                                    |
> [400, 450)            22 |                                                    |
> [450, 500)            29 |                                                    |
> [500, 550)          1840 |@@@@@@                                              |
> [550, 600)          1476 |@@@@@                                               |
> [600, 650)          1027 |@@@                                                 |
> [650, 700)           473 |@                                                   |
> [700, 750)           366 |@                                                   |
> [750, 800)           627 |@@                                                  |
> [800, 850)           930 |@@@                                                 |
> [850, 900)          1285 |@@@@                                                |
> [900, 950)           971 |@@@                                                 |
> [950, 1000)          946 |@@@                                                 |
> [1000, 1050)       13839 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @sugov_freq:
> [1400000, 1500000)     648 |@                                                   |
> [1500000, 1600000)       0 |                                                    |
> [1600000, 1700000)       0 |                                                    |
> [1700000, 1800000)      25 |                                                    |
> [1800000, 1900000)       0 |                                                    |
> [1900000, 2000000)       0 |                                                    |
> [2000000, 2100000)       0 |                                                    |
> [2100000, 2200000)       0 |                                                    |
> [2200000, 2300000)       0 |                                                    |
> [2300000, 2400000)       0 |                                                    |
> [2400000, 2500000)       0 |                                                    |
> [2500000, 2600000)       0 |                                                    |
> [2600000, 2700000)       0 |                                                    |
> [2700000, 2800000)       0 |                                                    |
> [2800000, 2900000)       0 |                                                    |
> [2900000, 3000000)       0 |                                                    |
> [3000000, 3100000)       0 |                                                    |
> [3100000, 3125K)       0 |                                                    |
> [3125K, 3300000)       0 |                                                    |
> [3300000, 3400000)       0 |                                                    |
> [3400000, 3500000)       0 |                                                    |
> [3500000, 3600000)       0 |                                                    |
> [3600000, 3700000)       0 |                                                    |
> [3700000, 3800000)       0 |                                                    |
> [3800000, 3900000)       0 |                                                    |
> [3900000, 4000000)   23879 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> @sugov_max_cap:
> [0, 2)             24555 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
> In both case max_cap is zero but selected freq is incorrect in bad case.

Also we have in get_next_freq():
	freq = map_util_freq(util, freq, max);
	       --> util * freq /max

If max was 0, we should have been an error ?

There is something strange that I don't understand

Could you trace on the return of sugov_get_util()
the value of sg_cpu->util ?

Thanks for you help
Vincent

> 
> Thanks,
> Wyes
> 

