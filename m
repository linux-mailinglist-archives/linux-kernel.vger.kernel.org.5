Return-Path: <linux-kernel+bounces-126593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37E893A28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A56B2192F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210AA1754B;
	Mon,  1 Apr 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMDDXGOM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1596171C1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967037; cv=none; b=tU/XebRgCFiZPzQfN9OxtX5lCZLggWZ+iwUu4pk16vbC+Yq7nsS23ezDL60dkFUsJuF+jUOs7s2INJNM0LW71bFkO+UwI52yoyOHijVFoa/1/Avo4IZxvx7euotPIscuqpAB88ZQTFSxwRYlltevWwE2Fbljw7+a6gxXTPRIT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967037; c=relaxed/simple;
	bh=EeWKaS/LZJtZiEm6l6kYUAh03ghALVCWXrf2Zb7Zl7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2iGPiShxOTOExtSrK8LCcy5PHexnj1AUS2q42x+Bf/PaCX9oTe6WNsQfO3tyHWv8LCQrkoEiU663eaaKeISJQ/4rE0PVGEoWu2wkf94SI7Cdo6nQ5PF1ODr0sFeIGcbQ9MtLIby5n3j3IFkCqmY5FYUf+Tti5SYB3lxz6ejciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMDDXGOM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0ae065d24so31653235ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711967035; x=1712571835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EBVVELRlloFUQoXXd2/6rE6F2ZhQRz7Jocir1jRoIE=;
        b=rMDDXGOMe1mREj3VVGOUDb0RZILV4LULPo0+S1ZuzqZvnMYBswpOb+W96O7vHSilu9
         ek6IMY9FtfbovyXeDzS0IlPyZsF6s4M5WRxly++PSZXMS/OW5NBtDep4RDSwjR2EFkMh
         m6LjQ0paMuT5qGfcJOouwa67P5yghxUIuBKztGWi1MEKrorUk+xatblwHwXQKSw4o6cA
         Gto7/TS8Azx6gJsiPMQKepFEBnXlXQy42jT5PXKW4oVMS+u2qTJoe1j92nB79japK4Kb
         uGtp66LhbbP4WdsuTgc9887Cb5ByMPKb4A14QUOw7mo2EODGf3MP8TAkm1hNYKMQhwn6
         CvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711967035; x=1712571835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EBVVELRlloFUQoXXd2/6rE6F2ZhQRz7Jocir1jRoIE=;
        b=Q8DzURhhSCacD6GhY1b+0Ug0HSPxtNO6TYBpvfrXsoG7GQQvSsx/5QIxNxymfTZB1W
         9na0ZuNIA+8RRQJ657alGKzHAsTLrdvINkV4+jdbfsAYiPPO+9Yv3KwAj+0UzHuI1WnS
         tpf5YUqe+IJCn4HqAzckRhVyKiI2KsfWj+8GA5ceInEAJT0wQZeByzIC4MvVtyIkqwLu
         KwKGrdF9G6LH3KVGOdyK2UdQzshGmubQHU5kCD9HHGU2dcX/CYsvBNRa3Ok2OaDaU5x/
         LO9A6yR3DUqelgL25c0+klEUImIDmHip1ubRV98YiSfR3wIYJOfbJeu0DPEn8i0cq4Ew
         e15A==
X-Forwarded-Encrypted: i=1; AJvYcCUDRjiSIcIQsz8GLdLfo8MTC0cfGteZLUhGW1J9LrlQNoDgyWfUANmpncAdiT2X5cOd0b+TcJ31ylp64kKCSbUfu98/2dlY4rlKa9uG
X-Gm-Message-State: AOJu0Yz+SSBh42JbYGmd93Bk1F+Qif3A01YHbn0Ki/6LYiOB7bIawB09
	+5gE9Ww5LRZYbdmOF818SOkXOUz4IrRTJP2EQBFNwh2Hn7S3RpIOqKhTLWyitH33AMCcAxAngLJ
	OcLrcjcvB9Sha+jp9e9URMOULEhbmiE4XR6bvUA==
X-Google-Smtp-Source: AGHT+IGkmBvxKTprn0wZbQmMrnbY1tKBSzMXKE7QFWRF62ViQ9qczM999UYpDcFHuVlH1TltM9QSBE02TWt0rKkWpo8=
X-Received: by 2002:a17:902:e549:b0:1e0:a7b1:ee92 with SMTP id
 n9-20020a170902e54900b001e0a7b1ee92mr9362674plf.62.1711967035254; Mon, 01 Apr
 2024 03:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711900396.git.vitaly@bursov.com> <cf9955e3ea02f224a6e4bea490ba2b42bee278bb.1711900396.git.vitaly@bursov.com>
In-Reply-To: <cf9955e3ea02f224a6e4bea490ba2b42bee278bb.1711900396.git.vitaly@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 1 Apr 2024 12:23:43 +0200
Message-ID: <CAKfTPtCfT+EGq1pVvWUdT+CMX1j2RpfC88tMTe5mxgtOviZS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: allow disabling sched_balance_newidle
 with sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Mar 2024 at 18:02, Vitalii Bursov <vitaly@bursov.com> wrote:
>
> Change relax_domain_level checks so that it would be possible
> to include or exclude all domains from newidle balancing.
>
> This matches the behavior described in the documentation:
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>
> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> level, and level_max+1 includes all levels.
>
> Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax")
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/cgroup/cpuset.c  | 2 +-
>  kernel/sched/topology.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4237c8748..da24187c4 100644
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
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 63aecd2a7..67a777b31 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1475,7 +1475,7 @@ static void set_domain_attribute(struct sched_domain *sd,
>         } else
>                 request = attr->relax_domain_level;
>
> -       if (sd->level > request) {
> +       if (sd->level >= request) {
>                 /* Turn off idle balance on this domain: */
>                 sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>         }
> --
> 2.20.1
>

