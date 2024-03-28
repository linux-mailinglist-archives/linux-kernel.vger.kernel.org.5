Return-Path: <linux-kernel+bounces-123303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19989064C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017CD1F282CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB681DDE9;
	Thu, 28 Mar 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3sD5NNS"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1F7EF0E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644540; cv=none; b=gLSmtFx2DkwSuAxLp7o19yHiAYUrsgSmCGTAAeBHPTnUXBcNu1ci8xAXMROqPtB2Wo5SHjjOLIbd3E+6Kx3xhOo1H2ozE/wlgmXIUJzzqXVf7lnZoTXyCju/u3eixtlg8bAjQqAbhuFVz12UOZq9Oou5zY97EQJ3ttgZ47YsR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644540; c=relaxed/simple;
	bh=8vxWOlQlpcuO/cUupUEMOpwkE7CjqUoggWiMZXbc7u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzYYo3F8uab1Mk6Q4Iq6unel6mz+XGkGj85gXGM4YRkeXcT4xXMu0AL7TTby/dL4fJXmxVqnDswPp/xwNiZT0G7RW7+1LXFWvU+jjiHttCcbcozvVrCbZ6gbv4oAY9GpCStvk160/OdwZCzuoSGvl0Hu0xzhjUv2mO9NY4EZmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k3sD5NNS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a04ac98cf7so886927a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711644537; x=1712249337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VwsClxdzx+PS8FxWXqqz2bD5n56tmHHyfKLOAB78t/o=;
        b=k3sD5NNSg1ADzNFgwy3uRCDTcOCmHMpAfikcL/bgP72MvFZw/Q+SGQ7gDPozgUZmyZ
         q6X8VyWTkwNd99bqK63BTp1+idu4dPJq4iPyYL4IFBBK6NSm9L96jxX211ZtjJtBou68
         xmTu/w1zHtwDaBRpxAQylnpgqSEMckFukxS+8kn9HhIGkFzd9J+MPhjx2EkP02ZAeEtO
         Hk6EesKziEZ1lGl1bXbfUwPq61nvegAOPzzx628RNVz6Da6ch+W+UxTPDwmLKK+t5hBb
         QGIbKC3LOmrhwDtFxP6OYD1BjO7jAWVz7u0Yp3dHpViX+XiVujggXY3TFREabltGtYSw
         aXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644538; x=1712249338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwsClxdzx+PS8FxWXqqz2bD5n56tmHHyfKLOAB78t/o=;
        b=qSKw3muRFIYWqwnJyMxIabYu25SVN2E+Za/I1zsCuRdlznpOnCHANMCenHF29oVUEf
         +kRW7/Xpoq0TYQyKou0ablnr88bEprOdTWeCMKAEnWUTnPU74wL0mkLzqnRBYJzuZWRS
         nhfVjQX8xWpNkKHP8Jgalot1X13PUPzyayY/XDVQz87ChFMC2VRQRX5kgnMdPOOijXRq
         m5R3/g8dfcFnZcbM5fHsMTCEX54MK5i6jjXu5biMGGci5xTTusoAYBcxPIHygqOEpgSk
         YqP/j2IGGtc95R/jVMvo85mhSj9LcPNcPuuxsxnqo7k1w6IHb5u1GtaWfxy1EdbBkots
         I+RA==
X-Forwarded-Encrypted: i=1; AJvYcCVd9Y/dJJ8p0ypOxM8ARNtcCSaozEi2obTl/XQbmRx3itHsmbGwbpMbADgKemP2Ly+eudEpPuWNGbGIY6Z3EizGah8TWHcdiKHueFnS
X-Gm-Message-State: AOJu0YxCNFpTrEhSItkYatYRlw2pVIpXrH72IDohecss1tHMFtIRpRwP
	iFpEt+MUePCC7L8gMLbKSDMPmzJkJUESMxFybzlZvCIoIDpXRqKWWjp/piz6TzuvIx5hVwheee7
	U1xgnBzQmLmRgm2D8P5N1Qkzjt7nJ8FfuGjwxZg==
X-Google-Smtp-Source: AGHT+IHH+HpNLR3jDEY2hJLBNwUFDhCA5/ZD7dDZInhSd29y3NJAiJEbPdbY84f5rQghfyGITQNRED1ToAdW5FGtFWw=
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id
 t21-20020a17090ad51500b002a08d17948dmr1288pju.1.1711644537432; Thu, 28 Mar
 2024 09:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711584739.git.vitaly@bursov.com> <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
 <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com> <1679cb16-a4a1-4a5f-9742-3523555d33f9@bursov.com>
In-Reply-To: <1679cb16-a4a1-4a5f-9742-3523555d33f9@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Mar 2024 17:48:46 +0100
Message-ID: <CAKfTPtDbRUNEQ4g3rBxuC8daa6Dj_Eba8mHhVr+9UZ9eAFTPkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 17:27, Vitalii Bursov <vitaly@bursov.com> wrote:
>
>
> On 28.03.24 16:43, Vincent Guittot wrote:
> > On Thu, 28 Mar 2024 at 01:31, Vitalii Bursov <vitaly@bursov.com> wrote:
> >>
> >> Change relax_domain_level checks so that it would be possible
> >> to exclude all domains from newidle balancing.
> >>
> >> This matches the behavior described in the documentation:
> >>   -1   no request. use system default or follow request of others.
> >>    0   no search.
> >>    1   search siblings (hyperthreads in a core).
> >>
> >> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> >> level, and level_max+1 includes all levels.
> >
> > I was about to say that max+1 is useless because it's the same as -1
> > but it's not exactly the same because it can supersede the system wide
> > default_relax_domain_level. I wonder if one should be able to enable
> > more levels than what the system has set by default.
>
> I don't know is such systems exist, but cpusets.rst suggests that
> increasing it beyoud the default value is possible:
> > If your situation is:
> >
> >  - The migration costs between each cpu can be assumed considerably
> >    small(for you) due to your special application's behavior or
> >    special hardware support for CPU cache etc.
> >  - The searching cost doesn't have impact(for you) or you can make
> >    the searching cost enough small by managing cpuset to compact etc.
> >  - The latency is required even it sacrifices cache hit rate etc.
> >    then increasing 'sched_relax_domain_level' would benefit you.

Fair enough. The doc should be updated as we can now clear the flags
but not set them

>
>
> >>
> >> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> >> ---
> >>  kernel/cgroup/cpuset.c  | 2 +-
> >>  kernel/sched/debug.c    | 1 +
> >>  kernel/sched/topology.c | 2 +-
> >>  3 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> >> index 4237c874871..da24187c4e0 100644
> >> --- a/kernel/cgroup/cpuset.c
> >> +++ b/kernel/cgroup/cpuset.c
> >> @@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
> >>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
> >>  {
> >>  #ifdef CONFIG_SMP
> >> -       if (val < -1 || val >= sched_domain_level_max)
> >> +       if (val < -1 || val > sched_domain_level_max + 1)
> >>                 return -EINVAL;
> >>  #endif
> >>
> >> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> >> index 8d5d98a5834..8454cd4e5e1 100644
> >> --- a/kernel/sched/debug.c
> >> +++ b/kernel/sched/debug.c
> >> @@ -423,6 +423,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
> >>
> >>  #undef SDM
> >>
> >> +       debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
> >
> > IMO, this should be a separate patch as it's not part of the fix
>
> Thanks, I'll split it.
>
> >>         debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
> >>         debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
> >>  }
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index 99ea5986038..3127c9b30af 100644
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
> >>         } else
> >>                 request = attr->relax_domain_level;
> >>
> >> -       if (sd->level > request) {
> >> +       if (sd->level >= request) {
> >
> > good catch and worth :
> > Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on
> > cpuset domain relax")
> >
> Will add this.
> Thanks.
>
> >
> >>                 /* Turn off idle balance on this domain: */
> >>                 sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
> >>         }
> >> --
> >> 2.20.1
> >>

