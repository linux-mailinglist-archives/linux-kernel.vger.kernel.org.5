Return-Path: <linux-kernel+bounces-24965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22A82C55C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98957284FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34E1AABE;
	Fri, 12 Jan 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNMBC8z2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62A1AAA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so8051157a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705083858; x=1705688658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnu8ykiaLhvhfeKozjNh1muEVcXSR2hqekqJyEyZRj8=;
        b=ZNMBC8z2q8l1bz1V5MGF1cJ52PXvhWn7NOyjaJY38Rn9ZW5qgXgDl3sDJZ5+RlXgPn
         Roz+39KQ5pK1ep8QCghItxi1Hcy7bHmHPAjuX0KmjiosN2Adq72qI6Nv3bSXdXfxLom9
         jzWwEzR1K3eloJgcfiv5f/yyIAg2MuTIBHOfXI6rwPaDHMMd6KgEt3VzV6rTEKDw1IzP
         UHV04/ebWbS/6AKhLjAPhiO4PEWduYenNRpy0l9L50lGP85Av6M025kKfFWgjrvNOctF
         y2N/RmdCpzjDB3eGVTnWjpl+0NaOSzN7vGU1z13hN9IGORUR1lASJZw+kA0hTwvY1FTo
         fEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083858; x=1705688658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tnu8ykiaLhvhfeKozjNh1muEVcXSR2hqekqJyEyZRj8=;
        b=bUsYMR4IhOQrmgPnvtMy+xY/czJUnWsfjH+HZSPm0xpRbfYtS8d2c+oL7rhrs3/AAB
         g264QEvnMRYafKRprj2TMeSFRG7IYewYlqZ+WMo9PbUzKCHFjEqP4An/SgWCjMjnMgea
         SvytHFC0Dt33K6K8Yb93eeodR3MCRyL2kc08Z9kCjXRLrV70vdVCnUeqHrh/u4b8KLQn
         p4yvj7k/wEUn0FXU4CbtbGuXhQugEU9tjLeNC7RDUH1bNUZa2/IX+o1ULwq3U7FJfuL0
         UKqVNrPnSsYM1w6vqoiwE1DpI6NVD+LrjYyTyUcROT7QCIVBui789WDz/JQPRfIVgZrt
         pP/g==
X-Gm-Message-State: AOJu0YzP1mN/3v/arUMHhFjQMxkgIgZdamvmSfAXqv+EWEtGUOK35deU
	ZfS50Av+VOzS3yylGm3shn4=
X-Google-Smtp-Source: AGHT+IEKDaQ2qCIotP2BJERSrZBjWe+z/Mch3BGJTxeTpS6IVe0Xn9pm7TXN4WqlJ9/U7ffR14Vtxg==
X-Received: by 2002:a05:6402:3d2:b0:557:2aae:a362 with SMTP id t18-20020a05640203d200b005572aaea362mr550826edw.109.1705083858309;
        Fri, 12 Jan 2024 10:24:18 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b005582b9d551csm2070960edt.30.2024.01.12.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:24:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Jan 2024 19:24:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] Revert "sched/cpufreq: Rework schedutil governor
 performance estimation" and dependent commit
Message-ID: <ZaGDziEnKJ988zHh@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ/MY0KEGXotqGHY@gmail.com>
 <CAKfTPtCR5U++CF93aUq8i+j9G5nLRvUUbCESX=CwemYu9LKOqQ@mail.gmail.com>
 <ZaBUFETV53cRF7RB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBUFETV53cRF7RB@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > I can provide a clean revert of only :
> > f12560779f9d ("sched/cpufreq: Rework iowait boost")
> > 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> 
> I've done this too, see this new commit in sched/urgent:
> 
>   60ee1706bd11 ("Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commit")
> 
> Also attached below.
> 
> > if the fix that i proposed doesn't work:
> > https://lore.kernel.org/all/ZZ+ixagkxRPYyTCE@vingu-book/
> 
> Yeah - although of course Linus is free to just pull the revert as well. 
> I'll try to reproduce the regression locally as well.

Update & heads up: unfortunately I'm unable to reproduce the regression on 
a fairly similar system with a Threadripper 3970X CPU.

Kernel build times are very close, with or without the revert, on vanilla 
v6.7 or v6.7+sched/core.

Here's a few results where I tried to quantify kernel build times without 
having to wait a long time.

Re-building the kernel/**.o object files in a loop:

   $ perf stat --pre 'rm -f kernel/*.o kernel/*/*.o kernel/*/*/*.o' --null --sync --repeat 3 make -j64 kernel/ >/dev/null


    # v6.7.0:
    # bootup default schedutil governor:
              24.521 +- 0.077 seconds time elapsed  ( +-  0.31% )
              24.644 +- 0.071 seconds time elapsed  ( +-  0.29% )

    # cpufreq-max:
              24.452 +- 0.110 seconds time elapsed  ( +-  0.45% )
              24.482 +- 0.048 seconds time elapsed  ( +-  0.20% )

    # v6.7.0+sched/core:
    # bootup default schedutil governor:
              24.666 +- 0.063 seconds time elapsed  ( +-  0.26% )
              24.809 +- 0.118 seconds time elapsed  ( +-  0.48% )

The fully-cached build numbers are very close to each other, and during the 
hot phase of the kernel build all CPUs are saturated.

The 2x performance regression that Linus is seeing is either some 
pathological wakeup behavior, or perhaps the cores don't transition 
frequencies? The difference between the lowest and highest frequency is 
pretty substantial (at least on my box):

  cpu MHz		: 2200.000
  ...
  cpu MHz		: 4000.000


There was *one* test when the tree was cache-cold, when I saw really bad 
performance (which I didn't really expect with my nvram system), with -j32 
builds:

   Performance counter stats for 'make -j32 kernel/' (3 runs):

              64.34 +- 39.22 seconds time elapsed  ( +- 60.95% )
              25.08 +- 0.142 seconds time elapsed  ( +-  0.56% )
              24.97 +- 0.072 seconds time elapsed  ( +-  0.29% )

Unfortunately that outlier was on a vanilla v6.7 bootup.

As a next step I could try Linus's specific config, maybe there's some 
detail in it that makes the difference.

The commit itself that Linus bisected to (9c0b4bb7f6303c) doesn't *seem* 
wrong in itself, especially without uclamp [I presume Linus doesn't use 
CONFIG_UCLAMP_TASK=y and the cpu.uclamp.min/uclamp.max cgroup interface 
that goes with it?], but the commit changes how we use sched_util metrics, 
which could change scheduling patterns - which is why I was spending many 
hours yesterday and today trying to find a pathological workload to 
reproduce this. No luck so far.

Linus: I can send a pull request for the 2-commit revert, or maybe you 
could try Vincent's guess-patch that tries to restore to previous behavior 
as closely as possible.

Thanks,

	Ingo

