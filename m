Return-Path: <linux-kernel+bounces-25148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26082C88C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5A91F23B33
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8588107A6;
	Sat, 13 Jan 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dKoZjmAp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FCF4FE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33694bf8835so5322084f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705107875; x=1705712675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJOReSqRlJsqq5oM3aFUSklh3oObrtSaOzQi/ffGKiE=;
        b=dKoZjmApSytGZBGYbZ/K8b8fIGlyZGmnwgROscGoowQn5Unvj8fZvODAjy8DgWocHA
         jiegw7EQoacNm7iPmkQwjJLWCecojWKrzgfYb8KVFwfFntEd3k321RjBFI4pOYWE2VWv
         uo4gUlJVSs71ycMyOVcQwwvEkzJFg81S1edyP2onWHwI3mece3kQBmQZhKA5mJAQJSuR
         HA4d59qQynof1HgM+N2ms2MnBaQEBzF4oYFUcyCgjwoxswhubS2Jycmmfh0Tx7OcgkkX
         WmRWPSU5R3Flc7sNcVRCplTbbxlKwY52Gbc+VRHRsHjgbi8ftH4QuGqfi630StbzCxcY
         7yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705107875; x=1705712675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJOReSqRlJsqq5oM3aFUSklh3oObrtSaOzQi/ffGKiE=;
        b=gT1Gf8AzuctyyJ8wvEHtLmdkGxXvcUIJC8mxY8K9ZQcNyegN2fTq59A06Y21sEdqdt
         9eky6vgIEi4C2ktM13juY1OfCzzsyfRO//2l96kZ46gndsR9OzPqs8owoNO06srFcGlE
         FACW8f0qKpr8h+h82puqwOSJbLJbmCNQ6fwlLFyTxU/wNcX7RYj/8lMSZMZPOiZr1ALm
         JBzNwr1pgXrIJxELVZE8Wd64t+KWIViE9+Axwzide+5YyP78mxuWyRHN4q9Vs0pffMKl
         B3235UqJC8IMUtRnTlr6i8DWuZTozmBWP69+L/KeidGlIvkhAU6+Df7N3rOiwFefe0TS
         6OQw==
X-Gm-Message-State: AOJu0YxxmcEJagy+VtzFxuaKHch1+gGvAEqJAElsLr8kbatBUFFMuIzM
	o0KG06c8iqsbVa0KkNm6nDIstWJcWJTMfw==
X-Google-Smtp-Source: AGHT+IEppc31cBLncw0UydDK2Uu5FoAaqhHxBktdzc6rkiI+BaYfWOxnMbx9DZl6gde7vcYpJB9s5A==
X-Received: by 2002:a5d:5273:0:b0:336:67fa:971a with SMTP id l19-20020a5d5273000000b0033667fa971amr1216213wrc.101.1705107874528;
        Fri, 12 Jan 2024 17:04:34 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d4752000000b00336ee9edbb3sm5202374wrs.94.2024.01.12.17.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 17:04:34 -0800 (PST)
Date: Sat, 13 Jan 2024 01:04:32 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240113010432.xe25lxqogxuvl72t@airbuntu>
References: <ZZ+ixagkxRPYyTCE@vingu-book>
 <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com>
 <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com>

On 01/12/24 13:04, Linus Torvalds wrote:
> On Fri, 12 Jan 2024 at 12:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > All cores stay at 2.2GHz (ok, so there's noise, but we're
> > talking "within a couple of MHz of 2.2GHz").
> 
> Note: that is true also when every CPU is fully loaded and I do a real
> full build.

That is odd. I can't see how the patch can cause this yet, could you try with
a different compiler if possible? It seems like some operation goes wrong and
we end up with util or one of the transformations becoming 0 or nearby.

I tried your steps and I see frequencies changing. I have gcc
11.4.0 by default on my system.

I usually use perfetto but it should be easy to see frequency updates from
power/cpu_frequency trace event.

	echo 1 | sudo tee /sys/kernel/tracing/tracing_on
	echo 1 | sudo tee /sys/kernel/tracing/events/power/cpu_frequency/enable
	sudo cat /sys/kernel/tracing/trace

or

	sudo cat /sys/kernel/tracing/trace_pipe

to clear the buffer and block on read

Or easier with trace-cmd

	sudo trace-cmd record -e power/cpu_frequency $COMPILE_CMD
	sudo trace-cmd report

If there's no idle time the frequency updates will stop once we reach highest
frequency.

When I run it I see 2.2GHz and 3.8GHz values only, with and without the patches
reverted.

          <idle>-0     [017]5089547182905: cpu_frequency:        state=2200000 cpu_id=17
           <...>-77147 [015]5089548006123: cpu_frequency:        state=3800000 cpu_id=15
          <idle>-0     [004]5089553342808: cpu_frequency:        state=3800000 cpu_id=4
          <idle>-0     [003]5089566989667: cpu_frequency:        state=2200000 cpu_id=3
              rm-77149 [005]5089569246195: cpu_frequency:        state=3800000 cpu_id=5
          <idle>-0     [004]5089570419322: cpu_frequency:        state=2200000 cpu_id=4
          <idle>-0     [017]5089570826267: cpu_frequency:        state=3800000 cpu_id=17
          <idle>-0     [003]5089575702589: cpu_frequency:        state=3800000 cpu_id=3
          <idle>-0     [017]5089576045916: cpu_frequency:        state=2200000 cpu_id=17
          <idle>-0     [003]5089584007141: cpu_frequency:        state=2200000 cpu_id=3
          <idle>-0     [015]5089593025639: cpu_frequency:        state=2200000 cpu_id=15
          <idle>-0     [010]5089593661028: cpu_frequency:        state=2800000 cpu_id=10
          <idle>-0     [023]5089595181029: cpu_frequency:        state=2200000 cpu_id=23
           <...>-77153 [015]5089595202328: cpu_frequency:        state=3800000 cpu_id=15
          <idle>-0     [017]5089596112508: cpu_frequency:        state=3800000 cpu_id=17
          <idle>-0     [003]5089601227012: cpu_frequency:        state=3800000 cpu_id=3
          <idle>-0     [017]5089601303574: cpu_frequency:        state=2200000 cpu_id=17
          <idle>-0     [005]5089611995487: cpu_frequency:        state=2200000 cpu_id=5
          <idle>-0     [017]5089612446143: cpu_frequency:        state=3800000 cpu_id=17
          <idle>-0     [003]5089612461191: cpu_frequency:        state=2200000 cpu_id=3
             cc1-77159 [009]5089616006631: cpu_frequency:        state=3800000 cpu_id=9
          <idle>-0     [003]5089618213587: cpu_frequency:        state=3800000 cpu_id=3
          <idle>-0     [017]5089618245105: cpu_frequency:        state=2200000 cpu_id=17
          <idle>-0     [003]5089624066151: cpu_frequency:        state=2200000 cpu_id=3
          <idle>-0     [017]5089627031955: cpu_frequency:        state=3800000 cpu_id=17
          <idle>-0     [003]5089632148220: cpu_frequency:        state=3800000 cpu_id=3
          <idle>-0     [017]5089633114584: cpu_frequency:        state=2200000 cpu_id=17
         objcopy-77166 [023]5089635324796: cpu_frequency:        state=3800000 cpu_id=23
          <idle>-0     [003]5089636043349: cpu_frequency:        state=2200000 cpu_id=3
          <idle>-0     [018]5089636071762: cpu_frequency:        state=2200000 cpu_id=18
          <idle>-0     [017]5089636511027: cpu_frequency:        state=3800000 cpu_id=17
          <idle>-0     [003]5089638171879: cpu_frequency:        state=3800000 cpu_id=3
           build-77168 [019]5089640011393: cpu_frequency:        state=3800000 cpu_id=19
          <idle>-0     [017]5089652020092: cpu_frequency:        state=2200000 cpu_id=17
          <idle>-0     [004]5089653340503: cpu_frequency:        state=3800000 cpu_id=4
          <idle>-0     [004]5089654532595: cpu_frequency:        state=2200000 cpu_id=4
          <idle>-0     [003]5089656013393: cpu_frequency:        state=2200000 cpu_id=3
          <idle>-0     [004]5089666815072: cpu_frequency:        state=3800000 cpu_id=4
          <idle>-0     [011]5089697117342: cpu_frequency:        state=3800000 cpu_id=11
             cat-77170 [010]5089697219972: cpu_frequency:        state=3800000 cpu_id=10
          <idle>-0     [004]5089697313957: cpu_frequency:        state=2200000 cpu_id=4
          <idle>-0     [017]5089699129526: cpu_frequency:        state=3800000 cpu_id=17
              ln-77172 [016]5089699710505: cpu_frequency:        state=3800000 cpu_id=16
          <idle>-0     [022]5089700249275: cpu_frequency:        state=2200000 cpu_id=22
          <idle>-0     [023]5089700316449: cpu_frequency:        state=2200000 cpu_id=23
          <idle>-0     [009]5089700372223: cpu_frequency:        state=2200000 cpu_id=9


This is what cpupower frequency-info returns on my system

	analyzing CPU 0:
	  driver: acpi-cpufreq
	  CPUs which run at the same hardware frequency: 0
	  CPUs which need to have their frequency coordinated by software: 0
	  maximum transition latency:  Cannot determine or is not supported.
	  hardware limits: 2.20 GHz - 4.67 GHz
	  available frequency steps:  3.80 GHz, 2.80 GHz, 2.20 GHz
	  available cpufreq governors: conservative ondemand userspace powersave performance schedutil
	  current policy: frequency should be within 2.20 GHz and 3.80 GHz.
			  The governor "schedutil" may decide which speed to use
			  within this range.
	  current CPU frequency: Unable to call hardware
	  current CPU frequency: 2.20 GHz (asserted by call to kernel)
	  boost state support:
	    Supported: yes
	    Active: no


To my understanding schedutil doesn't know about turbo frequencies but we can
read current freq via counters which I think /proc/cpuinfo uses them. The trace
events will only show 3.8GHz as that's what we know about, but /proc/cpuinfo
shows above 4GHz if I run a single threaded workload, similar to what you've
seen. Again with and without the patches reverted.

I have to say, I am on tip/sched/core still. I probably should switch to your
tree to make sure there are no unexpected differences that can affect
reproducibility.


Cheers

--
Qais Yousef

> 
> So the "empty make" is just my quick test that happens to be
> single-threaded and should take just 20s. All my real builds slow down
> too, because all CPUs stay at the minimum frequency.
> 
> And I just verified that Ingo's revert that only reverts two commits
> (commit 60ee1706bd11 in the tip tree), makes things work correctly for
> me.
> 
> Not surprising, since the bisection clearly pointed at just commit
> 9c0b4bb7f6303c being the one that caused the issue, but I decided to
> just double-check anyway.
> 
> So with that revert, for the single-threaded case I see 4GHz+ numbers
> (they spread from a single CPU to multiple CPUs once you run the
> benchmark a few times).
> 
> And then when I run a full parallel build (rather than the
> single-threaded empty one), the frequencies drop to ~3.85GHz for the
> all-cpu case.
> 
>                 Linus

