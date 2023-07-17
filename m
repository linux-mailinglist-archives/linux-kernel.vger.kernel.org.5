Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A3756578
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:51:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7A9C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:51:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so6514878a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689601896; x=1692193896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NulYZ8ud4nInsNBQFR40gOVy/EmAPlV46bxx7L81M2Y=;
        b=XQxrKqumcE5BJeMv4hSTn+OmzCSSE+ZvJaS9+fzmjERjYVI9DkoIxm7qHAwhh1FGtK
         qSjzC5UPjBecrY1rlDFPNzhzE6q35bPflZHDjSBICuCjGZliXW/JPKfrxWhiYkjXwJxk
         G96ok6hZ94+HTmSG6+n6+fGoHyiCmmowwZD/FmnA2SJls3LfQB/ntw5AmPmeEbs9O8q0
         QXU6RACOZB3y/CdqS3zm9mpNlrrVQy/1WmoWiQmKZvwVDx1kYXjIgzQfCQ8CMOoV/j9Y
         8RUv7mYOvNW7emgWj4SU/i4gO/YtbZxOjCikvlswf1TvktCfNg0ubhC5tiTYoAB14vQ0
         Qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601896; x=1692193896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NulYZ8ud4nInsNBQFR40gOVy/EmAPlV46bxx7L81M2Y=;
        b=gxjcEY7z7dEANpRFlokzf1t/TfDFBT2hlepjZNQ2Z2cUnUfMqLHLaXh4uDZ++eNc79
         NXvcPxK+xqWQNmqLQz1SdcINKAqSiv4capoBfFhfWa+Qb/HmA1UFPFvA+Undoagd9+kR
         feB3RZp5VqidlTfHxdOSpcMJYjJBlArcmDM3ubyQFY3e9FJVWFA/JtESIHopo93+YkoI
         j8yHbziRopjO8krL6xDkxUFeJ1R/GBQB1dCpS10CTBNH7663vstuBAgWS0aHggIfIxIL
         eBqlibe8N14Avf3BEzYNWcYykYqe4iqGdPjyyP85FOoL7ARAOCfyrrVKWQ14em741Ml9
         9YrA==
X-Gm-Message-State: ABy/qLb88a64sc1dXJEspzP+wyv0yqfDYEjw9AYH7Zz0tfFowMnV4LFn
        aVz80jotTcrr/j+4y9MHR06CdZxEqmF9hfoeHYuL/A==
X-Google-Smtp-Source: APBJJlHRA1Kd6KxmUkMK+sDmqVQDSQxRd9Zs6lwubeUK+Y99P8Hyjgw+sj58YmkdcatBITyjrQr3mA6+X5fviJN0q80=
X-Received: by 2002:aa7:d98c:0:b0:521:8817:cc5d with SMTP id
 u12-20020aa7d98c000000b005218817cc5dmr3807048eds.34.1689601896196; Mon, 17
 Jul 2023 06:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
In-Reply-To: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Jul 2023 15:51:25 +0200
Message-ID: <CAKfTPtBga3CMVNGt5YEJiyfWDiWWQ0c+5_EAzY0spMFiUQBMmA@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 16:11, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi
>
> Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> for the package mask :-)

May be a link to the change that triggers this patch could be useful

>
> Since these names are SCHED_DEBUG only, rename them.
> I don't think anybody *should* be relying on this, but who knows.

Apart the remaining reference to DIE already mentioned by others,
looks good to me

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/powerpc/kernel/smp.c   | 2 +-
>  arch/s390/kernel/topology.c | 2 +-
>  arch/x86/kernel/smpboot.c   | 2 +-
>  kernel/sched/topology.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index fbbb695bae3d..5ed6b9fe5094 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1050,7 +1050,7 @@ static struct sched_domain_topology_level powerpc_topology[] = {
>  #endif
>         { shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
>         { cpu_mc_mask, SD_INIT_NAME(MC) },
> -       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +       { cpu_cpu_mask, SD_INIT_NAME(PKG) },
>         { NULL, },
>  };
>
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 68adf1de8888..c803f5e6ab46 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -522,7 +522,7 @@ static struct sched_domain_topology_level s390_topology[] = {
>         { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
>         { cpu_book_mask, SD_INIT_NAME(BOOK) },
>         { cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
> -       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +       { cpu_cpu_mask, SD_INIT_NAME(PKG) },
>         { NULL, },
>  };
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index e1aa2cd7734b..09cc9d0aa358 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -653,7 +653,7 @@ static void __init build_sched_topology(void)
>          */
>         if (!x86_has_numa_in_package) {
>                 x86_topology[i++] = (struct sched_domain_topology_level){
> -                       cpu_cpu_mask, SD_INIT_NAME(DIE)
> +                       cpu_cpu_mask, SD_INIT_NAME(PKG)
>                 };
>         }
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..e9d9cf776b7a 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1670,7 +1670,7 @@ static struct sched_domain_topology_level default_topology[] = {
>  #ifdef CONFIG_SCHED_MC
>         { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
>  #endif
> -       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +       { cpu_cpu_mask, SD_INIT_NAME(PKG) },
>         { NULL, },
>  };
>
>
