Return-Path: <linux-kernel+bounces-123100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB3890229
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EE1F277C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828112AAC8;
	Thu, 28 Mar 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUsxoU5y"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86759127B66
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636995; cv=none; b=GzskooMN+4GCTPw1CST8nPyMEKq03bIAHeThWR4ma5eYRlsBHVS85nJ59/MbWijJ/Y/h9CyTHsPm/acsrphI8wmCFDg4utllmU6HE2iMU0HK6SMM3uiyOuMJVRQKlLaMvSIAG6X8/lXbMG9wyigtJNkWDGsIXIgq4X86u6outGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636995; c=relaxed/simple;
	bh=FP+PjcJtBihvI3lmTTnq4UygK8snjjZb87vYNUD/7Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I59iW1mmce3m8X9FHOe36vnoYLG2eSYfgvTNhBrzkD153TZhNmr2L0mdWnkW9BvWWG1B7XZ56+RlLrzzqn1DsU2IBfOkwLgri+wOydCnXDJFCCLGIXwYBA52O9KoGmc6K0HPI5nime8sg/k4jvFUYMQtOoSW8avFhaD9JGKFKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VUsxoU5y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so938504b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711636993; x=1712241793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IYKdlLOF58lOHPLCX4kHglsTCyj/A/Ku3dDSw21YHw=;
        b=VUsxoU5yUXtSMgNXcbZIEebWpO/9PLxMQkVQfW4G660/BBorwPZD3wcl5fETKpJBWO
         DaEDVUZjvw27ciJnWwh6Whg7ox1ui/09aHwtjrMB34Bn1O+DvXU0xlJAu+JWORkOx/GA
         eEFKWSKzw6KhfAWIhCzfkIwgwAL2vEfLViBJtBSgI2pdbHEp1d40zACD00h4rv2t0MXT
         2g/HfuaWuNwLwhuQQwNztnVmBA9S7qL1OjhG7GEB8FjAURbZ9DkaECUXfrRq4Y5FwAlC
         u+FA45gwdOKr/wydIErH1FAKS1GL8oXrzrG+GDY5EdZjq7RJyVNvox7do9Q8+A+V6vIb
         Qc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636993; x=1712241793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IYKdlLOF58lOHPLCX4kHglsTCyj/A/Ku3dDSw21YHw=;
        b=RCoHWYed1yJHr2wqBchqIBwBaoc5j7rt0JAKGz02lL1m+DW4oQ1v97GRnKRe9H6Kop
         KDRnFqb5GC2NcF65xFv2J+Q6ljMS5oe992FsWdu7bCOu71St8g9y/fELgdNwt3GvEpbz
         04pUGkTeDkN+mnI00h3UZQC3jzHNQZKGVFF6TVLZdEhRGJR7yfEe8Q/Xi/NRlHACr/o4
         b1QsyxENVG1tzWdQ8ogPbjclgWjuQfKDqfDpbSD4jiJEngzFYA+0dysDMAzQFi37SLa3
         8Uu0Csb80PUXcxe4qLPUGnVmviGYqZ1arfdCVzIet1gM7EeTbplC9xcnqYXijXQsHdMq
         c1ng==
X-Forwarded-Encrypted: i=1; AJvYcCUSVsZLfr8TUR3avi+LDKCbhQpWD1ia1JGTgMUa9T7ALZgLdKO2hbsERxBf9G0crTLNPVCY+IMaQq2zbV2wzyZzzVxUwKzSgJ4d+bP/
X-Gm-Message-State: AOJu0Ywy4wB/0Pt5n8VGLFrPrmLbm91Fb+tiDduHRughmot5+7ZotvTL
	n8yPMGCOqsz7aBO7U4eqt8w5+jo9OwZdXlX/KMitz1tTLsXdE0JyZvnNfIjHTEZlVyteYgdtxzn
	EWp5ZLij+kWHxsK4GOUG0IJBneiRK0XZauPgR2Q==
X-Google-Smtp-Source: AGHT+IFX882eA2liCkZM38bQdVn3B8jcLzFramIwF0Y4tsnsNbpi0sMAydCF+/IjL2H0suLJvrkmXuMRB8j0EGK5+FI=
X-Received: by 2002:a05:6a00:391c:b0:6ea:ba7a:d180 with SMTP id
 fh28-20020a056a00391c00b006eaba7ad180mr3582489pfb.15.1711636992828; Thu, 28
 Mar 2024 07:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711584739.git.vitaly@bursov.com> <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
In-Reply-To: <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Mar 2024 15:43:01 +0100
Message-ID: <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 01:31, Vitalii Bursov <vitaly@bursov.com> wrote:
>
> Change relax_domain_level checks so that it would be possible
> to exclude all domains from newidle balancing.
>
> This matches the behavior described in the documentation:
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>
> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> level, and level_max+1 includes all levels.

I was about to say that max+1 is useless because it's the same as -1
but it's not exactly the same because it can supersede the system wide
default_relax_domain_level. I wonder if one should be able to enable
more levels than what the system has set by default.

>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> ---
>  kernel/cgroup/cpuset.c  | 2 +-
>  kernel/sched/debug.c    | 1 +
>  kernel/sched/topology.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4237c874871..da24187c4e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
>  {
>  #ifdef CONFIG_SMP
> -       if (val < -1 || val >= sched_domain_level_max)
> +       if (val < -1 || val > sched_domain_level_max + 1)
>                 return -EINVAL;
>  #endif
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 8d5d98a5834..8454cd4e5e1 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -423,6 +423,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>
>  #undef SDM
>
> +       debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);

IMO, this should be a separate patch as it's not part of the fix

>         debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>         debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
>  }
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99ea5986038..3127c9b30af 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
>         } else
>                 request = attr->relax_domain_level;
>
> -       if (sd->level > request) {
> +       if (sd->level >= request) {

good catch and worth :
Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on
cpuset domain relax")


>                 /* Turn off idle balance on this domain: */
>                 sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>         }
> --
> 2.20.1
>

