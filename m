Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547627BD8DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjJIKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbjJIKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:39:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DEA9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:39:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32003aae100so3267789f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696847941; x=1697452741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTfXZoJBuYaZz2FmjAcl98ZIg8+Pzh2qLxbKGCpgOh4=;
        b=Mnm60Ll32ZMx8cRZvCzj5f8mfkRPr1q2TlsqFltWTnTae/cNbToy7sS/qeJ6Yn9XPT
         DGABuWlFvctjSm7Cj5ffpbCV4gH+o3WeaOpdMLRmUfYjiASeyztcniYUrh8YTgqJPEUd
         9gnfnas3ZtiZ+I9M1JuG0tRdUXSaxjnyGfQgxuaQGGvy2zCSiYHFQCbx73l2AWN/O9od
         yQV6VeZ7nnl+2/XbwBYOcIqgQLDSqjdeFuUAXdjIVhZUPOGrU1/mUCF5bIsRN6DPKtGT
         lL89Mx7qBqe5OzIg7j6/Q2+ozsyqrivxyjGIUYWDG9EfzA+9ike8gw5VC6wdogNo/NvO
         Ee5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847941; x=1697452741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTfXZoJBuYaZz2FmjAcl98ZIg8+Pzh2qLxbKGCpgOh4=;
        b=jNbAUKIxXILezfEX2Tjqx08OQ5ZHovO3Ip2L61nosjFKTOvSat9av9F9s2ZYwzy3q+
         9jHGm2teIf8iMd+zP1Ou+KTKIwdZ+tCGDQ0/3Wy6OXI/k2JiUxyHUDOH/Oa0qiazQdeF
         SWwl5YXV3GkTLA8xSsIKfwHyxrZ9z+iJs1nXdkm3h9m20uZWC3/oN71axUsFv0c5J+qa
         iNtKcYib1j4TRz7ith9HCCnpCMFtkpv9HmGrrBz2tM3t1mUa0tKG6RfbmH86Wl14xpsr
         UL4/W4FILJ7z+8SgooeQPnLa9h//YnYlMOS48BeF+ndyNwomxRbxY22oXXzEmmx8NayS
         HxIg==
X-Gm-Message-State: AOJu0Yxp0KUah0yNwVlruEwKTOd7/y02tNtIdudnJ6YpNaPgqpJ89IMe
        9sj3h9FAvsT6TthGFLf4kXU=
X-Google-Smtp-Source: AGHT+IHrGbuNfIjqnKsZW8WjS6n51627f/TF1FaS3+wR4tx5UbP7gq5QmTK8EKJzHwNczPs9weQPdg==
X-Received: by 2002:a5d:5442:0:b0:324:84bc:d5ab with SMTP id w2-20020a5d5442000000b0032484bcd5abmr9672428wrv.1.1696847941025;
        Mon, 09 Oct 2023 03:39:01 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm9239461wrm.64.2023.10.09.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:39:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 12:38:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: case sysctl_sched_rt_period to integer
Message-ID: <ZSPYQqmTLwWYLoai@gmail.com>
References: <20231008021538.3063250-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008021538.3063250-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yajun Deng <yajun.deng@linux.dev> wrote:

> proc_dointvec_minmax is for integer, but sysctl_sched_rt_period is an
> unsigned integer. And sysctl_sched_rt_period takes values from 1 to
> INT_MAX, so sysctl_sched_rt_period doesn't have to be an unsigned integer.
> 
> Case sysctl_sched_rt_period to integer. Also, change the maximum value
> of sysctl_sched_rt_runtime to sysctl_sched_rt_period.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/sched/rt.c    | 6 +++---
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 88fc98601413..76d82a096e03 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_bandwidth;
>   * period over which we measure -rt task CPU usage in us.
>   * default: 1s
>   */
> -unsigned int sysctl_sched_rt_period = 1000000;
> +int sysctl_sched_rt_period = 1000000;
>  
>  /*
>   * part of the period that we allow rt tasks to run in us.
> @@ -34,7 +34,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>  	{
>  		.procname       = "sched_rt_period_us",
>  		.data           = &sysctl_sched_rt_period,
> -		.maxlen         = sizeof(unsigned int),
> +		.maxlen         = sizeof(int),
>  		.mode           = 0644,
>  		.proc_handler   = sched_rt_handler,
>  		.extra1         = SYSCTL_ONE,
> @@ -47,7 +47,7 @@ static struct ctl_table sched_rt_sysctls[] = {

>               .data           = &sysctl_sched_rt_runtime,          # added for clarity

>  		.mode           = 0644,
>  		.proc_handler   = sched_rt_handler,
>  		.extra1         = SYSCTL_NEG_ONE,
> -		.extra2         = SYSCTL_INT_MAX,
> +		.extra2         = (void *)&sysctl_sched_rt_period,

Yeah, so I suppose this is a good change and desirable, also because 
sysctl_sched_rt_period is already an int, and all the calculus around these 
figures is 'int' based. So having an 'unsigned int' is indeed confusing and 
doesn't encode the true sysctl limit correctly.

But I don't think the checking is full with this patch applied either: if 
sysctl_sched_rt_period is shrunk below the current value of 
sysctl_sched_rt_runtime, then sysctl_sched_rt_runtime will stay out of 
bounds indefinitely, right?

I guess this comes with the territory of internal sysctls though.

Thanks,

	Ingo
