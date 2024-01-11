Return-Path: <linux-kernel+bounces-23611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE982AF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85114284D82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125B15E98;
	Thu, 11 Jan 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6JEhf0D"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144715E88
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ef33e68dso37125185ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704978255; x=1705583055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJye1HwRZXqiDXVZCClxaEgybA810vZVpEjfXbsfFJs=;
        b=e6JEhf0DE1R6mJWacHwY1y5ZyhbIVbMeHL3r4HLo/FmxsLISWxZ+y1/u1pj6Ih/O0W
         ati7Yjy3q8NTDd7cpXRq8Ul3nKhf0EaTxKm/p4gLUKWETOC1b0fGlIxllFBmL6eRKRnI
         /CSA/sH9eRbl9x3ZBI5P8Mqox0jyXHJEqR3lt7ZzKbeXxxalsAWNS7Xbo1nYAcJDXjDQ
         xyZJJ64pBsul1ppK6sOP6G+6WgC7plspBET6y3cOHRZcXu7TPyCEi1P3S9PAv/Hb7URM
         fNdDx3wGRTbAQUSYSjTed77kzuFwXlQHQ588oMqmSTwVVmodOmxHai/LX/G6KfiKg2K7
         x9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704978255; x=1705583055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJye1HwRZXqiDXVZCClxaEgybA810vZVpEjfXbsfFJs=;
        b=OgbCF98q4EYtm+Zd2WkE88Rl1MFgg7EPhGx2vqQ1IbjM4glMXAOLEHfOBTCrScDuzs
         HC/EfGUMC8pD5Fpoug1niS02ZttR4YobBEQGqN+CDTg1BsLbzrKIF0m35l8EfNVj/QV0
         MmGu7NVJ+36uqDcc2nRMC/xnEqTgapMMAAjBy7ZkEdAGk+csvn7jX3xwvZlVQSv0CMWT
         yd3TqtQcGWUoE1bTBkdOHDeOiEKgRtgKBnTQdE7IA8Z8cQyPwEkCeC4sjwDnFm4Y39aO
         2uaSfi72qxGDNQoUQwH8PLOFBIt5ty+nqqNMx1nQ4gdJVoBCQ7MTSkdzf70iwW5euUj+
         uGjA==
X-Gm-Message-State: AOJu0Yx+foPjy963ki6LMs2JKRISZcTKDY+3n28cbs2GyIec97bl/PqH
	NnoykrIChKe9JIZLvKovHXx53he6zttbFMx0iwXP0YP1YL/6wg==
X-Google-Smtp-Source: AGHT+IEIWU162vz5BVssaLQ0v5ixlNOrYXMwBNBuJPvkNECOBriOK+cjfvlgUUjSWppOSEVExQD4wxH6SdVKIFrJy18=
X-Received: by 2002:a17:902:c3d1:b0:1d5:6b6c:1add with SMTP id
 j17-20020a170902c3d100b001d56b6c1addmr1014391plj.28.1704978255603; Thu, 11
 Jan 2024 05:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com> <ZZ/MY0KEGXotqGHY@gmail.com>
In-Reply-To: <ZZ/MY0KEGXotqGHY@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Jan 2024 14:04:04 +0100
Message-ID: <CAKfTPtCR5U++CF93aUq8i+j9G5nLRvUUbCESX=CwemYu9LKOqQ@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 12:09, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
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
> Thanks a lot for bisecting this, and ack on the revert in any case, these
> are relatively fresh changes that clearly didn't get enough testing - sorry!

b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency") is
linked with other patches.
I can provide a clean revert of only :
f12560779f9d ("sched/cpufreq: Rework iowait boost")
9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

if the fix that i proposed doesn't work:
https://lore.kernel.org/all/ZZ+ixagkxRPYyTCE@vingu-book/

>
> I also made the revert in sched/urgent & added a changelog, which you can
> pull from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-01-11
>
>    # HEAD: 250ce3c1169743f3575cc5937fccd72380052795 Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commits
>
> Revert recent changes to the sched_util logic, to address a bad
> performance regression that increased kernel build time on Linus's
> 64-CPU desktop system substantially.
>
> Lightly build and boot tested.
>
>  Thanks,
>
>         Ingo
>
> ------------------>
> Ingo Molnar (1):
>       Revert "sched/cpufreq: Rework schedutil governor performance estimation" and dependent commits
>
>
>  include/linux/energy_model.h     |  1 +
>  kernel/sched/core.c              | 90 +++++++++++++++++++++++-----------------
>  kernel/sched/cpufreq_schedutil.c | 90 ++++++++++++----------------------------
>  kernel/sched/fair.c              | 22 ++--------
>  kernel/sched/sched.h             | 84 +++++++++++++++++++++++++++++++++----
>  5 files changed, 160 insertions(+), 127 deletions(-)

