Return-Path: <linux-kernel+bounces-96967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA18763EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF5DB21810
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34BB56742;
	Fri,  8 Mar 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKTGvXMD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E68535CA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899298; cv=none; b=fV38pj4EshbByj5RX1If2O3knwrvOu4JGTG4ZjQ7kbAsm5eZvpXnLWhTiKt2iX+IcWDCO2C1+iW2H7leYmPt2rVegAN5IXzXAx9d5prP/JDdU89BBpyaUSk2DkJhJNjGVPplTnR39oK/4YLRWvCV6GqAS7w6nPnrSx0mcgmuYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899298; c=relaxed/simple;
	bh=E2BfiNAmlsZGGuvd7lI2jySYoXgxjBZUKPnsjl3OhTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJGYawG4p5oZBmn9X4pb8R1CWTeOsvn/o64qFX9n+XJTqAUjWJtN/Up9Vzxx7LL/8C4T8dKVI3GyeZD8f5D1SXVFW7rMZKGzBoij/DgZK6DrAScM9m4B28/I+kcI5q6ME+G0imC0HXqEfp0ySHvZ7Bp5nxjASZWXs7L6BtkfmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oKTGvXMD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29b73427790so1345448a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709899296; x=1710504096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f7ow/DeoKMTO6ktCAJ7aL23q+8AsyGEzRnwZ1LopCd0=;
        b=oKTGvXMDeRy2GPqGicz5UPKkE3HnzvWlaNHJBtAIOWTpUoTli6ys7zd3NPR78x0Psg
         eDzFTP2QPXawZJcPIR0i1Eizl0WWz96kf/lLxswyIeVDj79aLhgaWuQG32/3NavLRHbl
         wGklhwYXUdZwpCJjvadep7VZhFPc/HX3BHvaQXTCAB/r25lph9LXvq28xv3jBNIKHiJd
         MKrkUvUL/hs4VTL+diGHU6JEi+AptJSUJJlKuqg21zSY/Euo8xpfgo+BHiAR4z1hbyV7
         Q8quA6ePRHVySXe7GLAVHonzmoPiO2dhJZzjpUAfv/b4Ma1lq6qRJa8EDF357I4k1uvG
         OMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899296; x=1710504096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7ow/DeoKMTO6ktCAJ7aL23q+8AsyGEzRnwZ1LopCd0=;
        b=HjdqFLZFC7kwLeKgyg4GzznGfdks5f+WjTed6zKOaeFwjw0pkditJ2pGWRZ8Jpv60V
         HhGaQIuC+S472ZBoyvbDE7cEnKhEbsYILhw0Og/YSWUG2Z4c/21RcnnBNMLc1Ftdbw4Q
         DI5L3Miu98fft9BISgBLdWjBtlgAnWllG1LpBRsJBpHQ+vawuQyve/AjyysKXjQonnWw
         He1D7flxRaqKTjGwgSEcrq9lC6q8I5kUl8FBKmu7cYB55BBIyZb2WSJCSClreSLD64V0
         yAYYRl9CZoZtbp8CivO+vfzLAtQtYK7jA27Kf4q0Shmls/fx5xamkEsaOww89GJBrvDA
         jpfQ==
X-Gm-Message-State: AOJu0YwZswC0YrFIEsz/ubG3m+Ju2l3y1oiiKvkoz39xrjtM5tE/J+d7
	kblTvbRGdv8Qp9FTnaKA3Yy8Lxx81WGQzyLO9HWoZP7o+j3zXq6p+iGxOLlWujn73zKKdm1l3T9
	ANu94pNNJKCw6bfS6AJbqfsMNrhHRzJYSXlksEg==
X-Google-Smtp-Source: AGHT+IHbzrtZPZf0ZOCe7ji/5bI6NbZ+b4k/jzfw/ehMhleHJi+xkto/C7Ol/MTH0pTay4z0FZgKXstpTPzsRYlkEHk=
X-Received: by 2002:a17:90a:578e:b0:299:3035:aede with SMTP id
 g14-20020a17090a578e00b002993035aedemr16742758pji.44.1709899295877; Fri, 08
 Mar 2024 04:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308105901.1096078-1-mingo@kernel.org> <20240308105901.1096078-11-mingo@kernel.org>
In-Reply-To: <20240308105901.1096078-11-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 13:01:24 +0100
Message-ID: <CAKfTPtA+Y4MEkovYvkfnUQ09kyreD3mAD-LKiSsoBe=FsqSMrw@mail.gmail.com>
Subject: Re: [PATCH 10/10] sched/balancing: Update comments in 'struct
 sg_lb_stats' and 'struct sd_lb_stats'
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:59, Ingo Molnar <mingo@kernel.org> wrote:
>
> - Align for readability
> - Capitalize consistently
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 40b98e43d794..116a640534b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9433,17 +9433,17 @@ static void update_blocked_averages(int cpu)
>  /********** Helpers for find_busiest_group ************************/
>
>  /*
> - * sg_lb_stats - stats of a sched_group required for load_balancing
> + * sg_lb_stats - stats of a sched_group required for load-balancing:
>   */
>  struct sg_lb_stats {
> -       unsigned long avg_load;                 /* Avg load across the CPUs of the group */
> -       unsigned long group_load;               /* Total load over the CPUs of the group */
> -       unsigned long group_capacity;
> -       unsigned long group_util;               /* Total utilization over the CPUs of the group */
> +       unsigned long avg_load;                 /* Avg load            over the CPUs of the group */
> +       unsigned long group_load;               /* Total load          over the CPUs of the group */
> +       unsigned long group_capacity;           /* Capacity            over the CPUs of the group */
> +       unsigned long group_util;               /* Total utilization   over the CPUs of the group */
>         unsigned long group_runnable;           /* Total runnable time over the CPUs of the group */
> -       unsigned int sum_nr_running;            /* Nr of tasks running in the group */
> +       unsigned int sum_nr_running;            /* Nr of all tasks running in the group */
>         unsigned int sum_h_nr_running;          /* Nr of CFS tasks running in the group */
> -       unsigned int idle_cpus;
> +       unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
>         unsigned int group_weight;
>         enum group_type group_type;
>         unsigned int group_asym_packing;        /* Tasks should be moved to preferred CPU */
> @@ -9456,8 +9456,7 @@ struct sg_lb_stats {
>  };
>
>  /*
> - * sd_lb_stats - Structure to store the statistics of a sched_domain
> - *              during load balancing.
> + * sd_lb_stats - stats of a sched_domain required for load-balancing:
>   */
>  struct sd_lb_stats {
>         struct sched_group *busiest;            /* Busiest group in this sd */
> @@ -9465,7 +9464,7 @@ struct sd_lb_stats {
>         unsigned long total_load;               /* Total load of all groups in sd */
>         unsigned long total_capacity;           /* Total capacity of all groups in sd */
>         unsigned long avg_load;                 /* Average load across all groups in sd */
> -       unsigned int prefer_sibling;            /* tasks should go to sibling first */
> +       unsigned int prefer_sibling;            /* Tasks should go to sibling first */
>
>         struct sg_lb_stats busiest_stat;        /* Statistics of the busiest group */
>         struct sg_lb_stats local_stat;          /* Statistics of the local group */
> --
> 2.40.1
>

