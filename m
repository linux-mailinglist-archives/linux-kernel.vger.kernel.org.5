Return-Path: <linux-kernel+bounces-63054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE11852A36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7221F228DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A821775E;
	Tue, 13 Feb 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRp4y+/g"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003F17755
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810370; cv=none; b=Cn05WP/V8VRRdx+v5b/ByZuoZplAloVMo/Nt6vuwOLkLw00+ZOfA4XTE4lqJdxvhaRh2wRnaZCd+XxHdeknXHySKtYT5qstArcFHXiNVgL39vpIew4fvDICrLb370Oig5WOxJvGZ/KKPdCq3DH5u1mO6hn3c+PGXhY3hO5rGLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810370; c=relaxed/simple;
	bh=PbF29hTerpeueYCgRClBIMeyfQqY4j9lUKkhK8ynkQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQFH/kVTgm8MoCWvAAvCABNLhY/ahAGoojVkBzfwEDuH2dEnjVwqbtLXvIq+gw6ZvU6FeD1Tk5NY5AtCtPCTR+GTPrq8UcJmEiLZSIC2l8rkZH4bsg3PjhSEh+AZgeZ4DRrvr1sMLYsmGuOXHKnorAgz7KaQCMb+sU+oCPKxsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRp4y+/g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso2349834a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707810368; x=1708415168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc/cvXAJMHLqdf3OgGzlHdpWHxevmYx69ypRgOrbw4o=;
        b=wRp4y+/gtEfFppzCMSKb2hLFGsgZTEDfWWnktQV8A10PLkaWfolNWQepNo+IOMgb/j
         9byLsclPFVXSqkyc1FPx5loPJSqQROLN1IAdToojFu3ti18np5DUyWQ6SyG4RsP2fkAX
         hULwyclSR0JCyrtexoADJi7kgS08QXbruYV8grLzSSVBoD5qDC4ekn8pN7HRFMWVO5x+
         Furne9o8JfPdFZAM3vZ55ET0dZQIIQ/CN1sxWIQWNoU0M7uLhTwSCvKjFZS3s4qovq1x
         BNoG0coWxRHjkaAuF7kCVIlLbKNCgmfLKYLkoXD+UEHUvGENlKnZlWve+9c84ElIIN3q
         /avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810368; x=1708415168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc/cvXAJMHLqdf3OgGzlHdpWHxevmYx69ypRgOrbw4o=;
        b=mZqc5IPUrPmshM30Jil4nmMC+qRPLl0Y/QoWvWEa4FMDgAkef2twu/YC9IpyE3pPdk
         v2PKRLR+YmKJVgrDEM4vS5hNsww8dRT01ZjC+di/EkQpfYwFmoBSjWMDzlJ1OEzPZVT5
         2WCreRiLnvZDEEjHV7od7ZudMkHMMZcTAjEKZQjvCP6dAXnWq3htny02PREZzs99umgv
         5THU98XusD/Q2KRkAihBkVlkcnLBA1faX9me4/2QUWbMI905hhVl4vQj6qwSm/sBzLJP
         i4utWTK+97rCuamPVXZA1BsCpvh1F9MvTp1z6RiHYDphQj5ndLmLGG34nnS1gzqQLHtU
         afsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlz6orGLT7Ozk8wa/lsBJOZXBr3Q4bW0V38uoEu9n7XclBrmNmDbLFXUErlDBOJzMx64JOeQqWkOSAMbu+75K20sm+VcEvIAyxl/76
X-Gm-Message-State: AOJu0Yy5sUwQx/Mk/kHrYQ+I/+Sg6Pah6h6i6gYb/Ki7gbCB6IMq9mVw
	d7C8Kxvtd7NhAhbTZhyTRnJEVEp4543ps16LpEG3STmogvmJEq04q6Ec6MrPvdtRPzoIfPP1Wyu
	D2eryL7TS90gFp5gTB2Fe7FmbtuSvOvlT7kCSjQ==
X-Google-Smtp-Source: AGHT+IFdvfgjVONNLkilvrus+P4w+DyEa0NYIWoHABD8QicCZK9AR0GQ1fkksQSgeaFJKKEaqvVlPMu8yR9t9mO2kGo=
X-Received: by 2002:a17:90a:a38b:b0:297:1927:71ed with SMTP id
 x11-20020a17090aa38b00b00297192771edmr4510101pjp.6.1707810367904; Mon, 12 Feb
 2024 23:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211074950.247836-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240211074950.247836-1-zhaoyang.huang@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 08:45:56 +0100
Message-ID: <CAKfTPtDobWtDjoqvw0Q=H7DAUayQ=HNU9hu1s1JHAbKRmJaJiw@mail.gmail.com>
Subject: Re: [PATCH] sched: make cpu_util_cfs visible
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, 
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Feb 2024 at 08:50, zhaoyang.huang <zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
> timing value want to know the distribution of how these spread
> approximately by using utilization account value (nivcsw is not enough
> sometimes), wheras, cpu_util_cfs is not visible out side of
> kernel/sched, This commit would like to make it be visible.

We expect a user of this to be sent as part of the patchset

>
> eg.
> Effective part of A = Total_time * cpu_util_cfs / sched_cpu_util
>
> Task's Timing value A
> Timing start
> |
> |
> preempted by RT, DL or IRQ
> |\
> | This period time is nonvoluntary CPU give up, need to know how long
> |/
> sched in again
> |
> |
> |
> Timing end

You have to use *_avg with care if you want to get such figures
because they do not only reflect the last task activation but an
average of the past dozens of ms so you can easily get wrong figures.


>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/sched.h | 1 +
>  kernel/sched/sched.h  | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..56953626526f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2318,6 +2318,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
>
>  /* Returns effective CPU energy utilization, as seen by the scheduler */
>  unsigned long sched_cpu_util(int cpu);
> +unsigned long cpu_util_cfs(int cpu);
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_RSEQ
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 04846272409c..46110409e0f3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3027,7 +3027,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>  }
>
>
> -extern unsigned long cpu_util_cfs(int cpu);
>  extern unsigned long cpu_util_cfs_boost(int cpu);
>
>  static inline unsigned long cpu_util_rt(struct rq *rq)
> --
> 2.25.1
>

