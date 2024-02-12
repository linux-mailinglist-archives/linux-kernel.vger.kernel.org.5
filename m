Return-Path: <linux-kernel+bounces-61926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F7851884
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96E41F21A48
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4803CF79;
	Mon, 12 Feb 2024 15:55:12 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF425740;
	Mon, 12 Feb 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753311; cv=none; b=hvj6NWIrcO5TtSDpF+3ydf6/mETfkU46rPpWTHxbi+CYH3oDQbYAmL5kt1K9mRjM3qkAqY8e2bzud43MoQs7JWws9X9FHfZKjhEwCP5Y+KaJRUmloA/d/1TxGBDWqzuTCg9xRJvmQw125r8w6Xx3Gs83aRUBze5NopgHsfOf1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753311; c=relaxed/simple;
	bh=cQbWgrlnIZwyNKcCKHVsWPQRlIykh63Q3/WdiiwnYYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClJriHEw3JsabnkGHSXn9vX0xxCC+ZWKGaPFNBDw5dhmga3YgzoO8db/WHuh2NIZRLC0sck7TTsfzITjcCV6cGQ+HXIEtibLHipyoe6/hTunnFagV3CxSl3oXCXi3lGRM+zAra16uCBCtlsaag0KyNijVb01HNAbmmPXmpVXzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59d249f8e57so185247eaf.1;
        Mon, 12 Feb 2024 07:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753308; x=1708358108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dujpNDTGdXCKvYGZS10rcgFgfYJ2arhZ7Y4ipEQpcXE=;
        b=hnTEkg8YaDuTbzJyTDOd/rPmhWjshF4XZevHjc486ljPGRet59Ec1dEK13csNWSGz6
         fQX+O0zv9joG7Zd64raJuLa0YsASf9Dv21XGdDis0ZVEVn/eh+UtM90WO6K7/338sf/M
         MClRYEMNAsNGmk+yIahDPOnyUWm3MmeXB6tVE1vRqliyWS3TgZUnoLFXuvt/V0C/tzZg
         /MnfTMiidHLcX6CZxdRVomEABjae1c4kToH6Z57vrWLZ0xF53pr6q5/LAIl9y18rJXP6
         rd8w/1n/mFnVeJcBHGPxDhv3d4FoEPzQwOvUpn2vS+nLdo4wDnqmT4SJ1a+xqOg0OBbH
         Y5pg==
X-Forwarded-Encrypted: i=1; AJvYcCUks/ewUZKFGmAsFspfCBZMcqiDeWVDnQLc1raD/QlQtYW2yVCI/EKRWDkDNVNRYU0Qu6A8VRkAcbsLIGaKMvBWVAjJIF+JcYZJiks5ILmlLszl61QFzs6FgEIc5TW4nlXJGh2bjd4=
X-Gm-Message-State: AOJu0YzTlfxqorC68uXETRf2UgSSxJiloRu7W3yeUGWsxnecz2t2tW1U
	LJQ54BqMxbhXmr0TOWLQY3XMwm7+Ozm+RieVSEPUTVSof5YV3Mv9Sa62ngAUXBPT5tqOn9LUbRl
	OV7wKOQz1Yhzi5mteXL/Xmipi+XQQfOiG
X-Google-Smtp-Source: AGHT+IHhTnBNcIsQMOyuDhimfKe4C01cy8jc/sgluobphgih1wk5PW+xYxcVwcsgFO/WJGVpwsPjivvFT2DIROy3/sg=
X-Received: by 2002:a4a:ee91:0:b0:59c:7c63:928f with SMTP id
 dk17-20020a4aee91000000b0059c7c63928fmr5268927oob.0.1707753308526; Mon, 12
 Feb 2024 07:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205022006.2229877-1-qyousef@layalina.io>
In-Reply-To: <20240205022006.2229877-1-qyousef@layalina.io>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 16:54:57 +0100
Message-ID: <CAJZ5v0g68atmQAbKFdm1bhp_Uvw6+C9SnJp9jZK0vEHA4mX7bw@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:20=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.
>
> Also move it to sched.h. This function relies on updating util signal
> appropriately to give a headroom to grow. This is more of a scheduler
> functionality than cpufreq. Move it to sched.h where all the other util
> handling code belongs.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched/cpufreq.h    |  5 -----
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/sched.h             | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.=
h
> index bdd31ab93bc5..d01755d3142f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned lon=
g util,
>  {
>         return freq * util / cap;
>  }
> -
> -static inline unsigned long map_util_perf(unsigned long util)
> -{
> -       return util + (util >> 2);
> -}
>  #endif /* CONFIG_CPU_FREQ */
>
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 95c3c097083e..abbd1ddb0359 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsig=
ned long actual,
>                                  unsigned long max)
>  {
>         /* Add dvfs headroom to actual utilization */
> -       actual =3D map_util_perf(actual);
> +       actual =3D apply_dvfs_headroom(actual);
>         /* Actually we don't need to target the max performance */
>         if (actual < max)
>                 max =3D actual;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..0da3425200b1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, un=
signed long actual,
>                                  unsigned long min,
>                                  unsigned long max);
>
> +/*
> + * DVFS decision are made at discrete points. If CPU stays busy, the uti=
l will
> + * continue to grow, which means it could need to run at a higher freque=
ncy
> + * before the next decision point was reached. IOW, we can't follow the =
util as
> + * it grows immediately, but there's a delay before we issue a request t=
o go to
> + * higher frequency. The headroom caters for this delay so the system co=
ntinues
> + * to run at adequate performance point.
> + *
> + * This function provides enough headroom to provide adequate performanc=
e
> + * assuming the CPU continues to be busy.
> + *
> + * At the moment it is a constant multiplication with 1.25.
> + */
> +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> +{
> +       return util + (util >> 2);
> +}
>
>  /*
>   * Verify the fitness of task @p to run on @cpu taking into account the
> --

This touches sched.h, so I'd prefer it to go in via tip and

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

