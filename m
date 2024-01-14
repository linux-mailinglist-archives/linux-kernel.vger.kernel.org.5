Return-Path: <linux-kernel+bounces-25428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED082D019
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F217282C90
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC461FBE;
	Sun, 14 Jan 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdezuLPT"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03D1FA3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28e4fd9e352so7959a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705223568; x=1705828368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cL6Svl4R0/RoNHEJXQKzc/PKcJNoOT6s7PeEtQwwRE=;
        b=UdezuLPTJi+M8coqkLG5mPRnJYVj7sUzu6yklqFGkDz2U76+wZNa6vkJLor6aioUNL
         a8Q1zTSR4L+ctRVMuwJG5qhgofWgAj1kZURukxzyAH1cN7SDwGnHo3DmV/EBH4vnVJiE
         itMNh9wSGYBfBAon1VLz7FYMo/0nO583pO/CxZ7dFERh3SUqfGo3W3DK48+rNOfmje2p
         Mjc/gwdzBIW6I4fRX7KOdPp3TL8UOME1cWtBhfNELEbdUDBlYzM8c0rRsjlH79ZpknCh
         L8/K+6N+SzT10OJx/Pj5ziQrIMPmknq8QBpWBcofVjEnp668naLi4B3mBbh7a9PjkaGD
         m4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705223568; x=1705828368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cL6Svl4R0/RoNHEJXQKzc/PKcJNoOT6s7PeEtQwwRE=;
        b=XFej4BPLO1AJL7eAPM6t8N+mUjS2spXyEo58YIsLez+CVxwEjrQ3xxir0kX89FC+na
         PwEjL0FXx+VA1s3K0uFtDfvbue/EYILu8tfDsa7Bf/+zYhk5ACs6voW9OeyS1MH5fIeF
         BA8QAN+eCbrbye1MHfRDv8LyXIfZfteaXa803ffY7AA8iX6F2LpOYN/pV8JLbvksIJwo
         tJ1yTnS9cCp5jwjSWD4ir5EjPxtJfogAx5fM/9dOK18xmCzxxq20NJvKzJH5Df8Xfp35
         CZgAz5Y9ILucJQoNzMICISBAFLqDJzzTGjctqz8HctGW3XcQRYy5jUXKf4xoTYlxFcuw
         I5gA==
X-Gm-Message-State: AOJu0Yyf8icEevY6/C5MTRv+JUSoFkiZT12CJHYOQndC7rEXhc9PQA7h
	L9heq8Zbwxr+P0Cy8x4KpDqNf+qrnAA0OQ==
X-Google-Smtp-Source: AGHT+IF10/iiD91n5uYAjFbfNCfxABFTc7SO4fkTCQxOwVOnRjLW0i3/u/C6+qTZ6m3BOdm1/9QYow==
X-Received: by 2002:a17:902:dacc:b0:1d4:69a5:edbb with SMTP id q12-20020a170902dacc00b001d469a5edbbmr4790132plx.48.1705223568015;
        Sun, 14 Jan 2024 01:12:48 -0800 (PST)
Received: from wyes-pc ([2401:4900:1cc5:6bb8:5c24:dc8b:c502:29d8])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001d536a910fasm5800178plb.77.2024.01.14.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 01:12:47 -0800 (PST)
Date: Sun, 14 Jan 2024 14:42:40 +0530
From: Wyes Karny <wkarny@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <20240114091240.xzdvqk75ifgfj5yx@wyes-pc>
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

On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
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

Hi Linus,

I'm able to reproduce this issue with my AMD Ryzen 5600G system.  But
only if I disable CPPC in BIOS and boot with acpi-cpufreq + schedutil.
(I believe for your case also CPPC is diabled as log "_CPC object is not
present" came). Enabling CPPC in BIOS issue not seen in my system.  For
AMD acpi-cpufreq also uses _CPC object to determine the boost ratio.
When CPPC is disabled in BIOS something is going wrong and max
capacity is becoming zero.

Hi Vincent, Qais,

I have collected some data with bpftracing:

sudo bpftrace -e 'kretprobe:effective_cpu_util /cpu == 1/ { @eff_util = lhist(retval, 0, 1200, 50);} kprobe:get_next_freq /cpu == 1/ { @sugov_eff_util = lhist(arg1, 0, 1200, 50); @sugov_max_cap = lhist(arg2, 0, 1000, 2);} kretprobe:get_next_freq /cpu == 1/ { @sugov_freq = lhist(retval, 1000000, 5000000, 100000);}'

with running: taskset -c 1 make

issue case:

Attaching 3 probes...
@eff_util:
[0, 50)             1263 |@                                                   |
[50, 100)            517 |                                                    |
[100, 150)           233 |                                                    |
[150, 200)           297 |                                                    |
[200, 250)           162 |                                                    |
[250, 300)            98 |                                                    |
[300, 350)            75 |                                                    |
[350, 400)           205 |                                                    |
[400, 450)           210 |                                                    |
[450, 500)            16 |                                                    |
[500, 550)          1532 |@                                                   |
[550, 600)          1026 |                                                    |
[600, 650)           761 |                                                    |
[650, 700)           876 |                                                    |
[700, 750)          1085 |                                                    |
[750, 800)           891 |                                                    |
[800, 850)           816 |                                                    |
[850, 900)           983 |                                                    |
[900, 950)           661 |                                                    |
[950, 1000)          759 |                                                    |
[1000, 1050)       57433 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_eff_util:
[0, 50)             1074 |                                                    |
[50, 100)            571 |                                                    |
[100, 150)           259 |                                                    |
[150, 200)           169 |                                                    |
[200, 250)           237 |                                                    |
[250, 300)           156 |                                                    |
[300, 350)            91 |                                                    |
[350, 400)            46 |                                                    |
[400, 450)            52 |                                                    |
[450, 500)           195 |                                                    |
[500, 550)           175 |                                                    |
[550, 600)            46 |                                                    |
[600, 650)           493 |                                                    |
[650, 700)          1424 |@                                                   |
[700, 750)           646 |                                                    |
[750, 800)           628 |                                                    |
[800, 850)           612 |                                                    |
[850, 900)           840 |                                                    |
[900, 950)           893 |                                                    |
[950, 1000)          640 |                                                    |
[1000, 1050)       60679 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_freq:
[1400000, 1500000)   69911 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_max_cap:
[0, 2)             69926 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


good case:

Attaching 3 probes...
@eff_util:
[0, 50)              246 |@                                                   |
[50, 100)            150 |@                                                   |
[100, 150)           191 |@                                                   |
[150, 200)           239 |@                                                   |
[200, 250)           117 |                                                    |
[250, 300)          2101 |@@@@@@@@@@@@@@@                                     |
[300, 350)          2284 |@@@@@@@@@@@@@@@@                                    |
[350, 400)           713 |@@@@@                                               |
[400, 450)           151 |@                                                   |
[450, 500)           154 |@                                                   |
[500, 550)          1121 |@@@@@@@@                                            |
[550, 600)          1901 |@@@@@@@@@@@@@                                       |
[600, 650)          1208 |@@@@@@@@                                            |
[650, 700)           606 |@@@@                                                |
[700, 750)           557 |@@@                                                 |
[750, 800)           872 |@@@@@@                                              |
[800, 850)          1092 |@@@@@@@                                             |
[850, 900)          1416 |@@@@@@@@@@                                          |
[900, 950)          1107 |@@@@@@@                                             |
[950, 1000)         1051 |@@@@@@@                                             |
[1000, 1050)        7260 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_eff_util:
[0, 50)              241 |                                                    |
[50, 100)            149 |                                                    |
[100, 150)            72 |                                                    |
[150, 200)            95 |                                                    |
[200, 250)            43 |                                                    |
[250, 300)            49 |                                                    |
[300, 350)            19 |                                                    |
[350, 400)            56 |                                                    |
[400, 450)            22 |                                                    |
[450, 500)            29 |                                                    |
[500, 550)          1840 |@@@@@@                                              |
[550, 600)          1476 |@@@@@                                               |
[600, 650)          1027 |@@@                                                 |
[650, 700)           473 |@                                                   |
[700, 750)           366 |@                                                   |
[750, 800)           627 |@@                                                  |
[800, 850)           930 |@@@                                                 |
[850, 900)          1285 |@@@@                                                |
[900, 950)           971 |@@@                                                 |
[950, 1000)          946 |@@@                                                 |
[1000, 1050)       13839 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_freq:
[1400000, 1500000)     648 |@                                                   |
[1500000, 1600000)       0 |                                                    |
[1600000, 1700000)       0 |                                                    |
[1700000, 1800000)      25 |                                                    |
[1800000, 1900000)       0 |                                                    |
[1900000, 2000000)       0 |                                                    |
[2000000, 2100000)       0 |                                                    |
[2100000, 2200000)       0 |                                                    |
[2200000, 2300000)       0 |                                                    |
[2300000, 2400000)       0 |                                                    |
[2400000, 2500000)       0 |                                                    |
[2500000, 2600000)       0 |                                                    |
[2600000, 2700000)       0 |                                                    |
[2700000, 2800000)       0 |                                                    |
[2800000, 2900000)       0 |                                                    |
[2900000, 3000000)       0 |                                                    |
[3000000, 3100000)       0 |                                                    |
[3100000, 3125K)       0 |                                                    |
[3125K, 3300000)       0 |                                                    |
[3300000, 3400000)       0 |                                                    |
[3400000, 3500000)       0 |                                                    |
[3500000, 3600000)       0 |                                                    |
[3600000, 3700000)       0 |                                                    |
[3700000, 3800000)       0 |                                                    |
[3800000, 3900000)       0 |                                                    |
[3900000, 4000000)   23879 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@sugov_max_cap:
[0, 2)             24555 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

In both case max_cap is zero but selected freq is incorrect in bad case.

Thanks,
Wyes


