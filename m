Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B27B8503
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbjJDQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbjJDQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:25:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD580C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:25:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so1380946a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696436718; x=1697041518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li9kzlzo8vRAvuzuvS3ITqrHRZzrch1IRiCSn9WmS7w=;
        b=gnN8GDH8cLyZrqtynuZvaIgjaUVLpju0d6AaZPHhV/eYP3NxZ7PkzvmqpaHBlVxmnL
         EhUxqDrXR0SyPbHYvv3sYv5xWegsWpvTlGWV8SAVHl/+aME7NwGttq3EtwJ2HwGc0MPC
         ZP7ZYFfR9SlTP32XlphpIyUPc3MAuW36/rCN1KFBAVcX3vIABbjeuKsUmW2wItz6BveP
         vsPWx2kKsZB488wCQ033NqD/fJ/7UfWCxRoAE/+AgXcJND8JWAPmA5jLX6Scy5pB/nQF
         jsLBQvc879fJymkBX5jeeMAuelZQ9ME9EE3qxqwkhI0cti35UhOUw/rvxZEwE83KwmZq
         h/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436718; x=1697041518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li9kzlzo8vRAvuzuvS3ITqrHRZzrch1IRiCSn9WmS7w=;
        b=DLNPytXqZXoBtHcDnwfkn7RtBIr9BgmKm0RyB2Ns7frV+DfQei6XYo5vQfrNBtjvCk
         IfAuXgvgWFzokQ/WsL7hemcpl2nzbMT3S75Y5S2clArgpkQADogI7kfJq7SiSdsEVn6D
         G6ZIVXbbncvIr/KMNb+y+myg6gOkuTMUqzJCLRieaqQ2/8j6NgAtBWGlZkkW2DDvX3Gq
         UVo4WHbIiyx1ge/vDh6eO9utk90vXwNVlAlyBOInLyMS/NN2Ddh2RxSPKKvGSfBg3iBG
         m+TQL5XkMcTSSLTKl5zOK/OHnYSC3gMVOaj1PS/ozO0puSHio8gywdgrO6DthRJv9pXm
         Ajrg==
X-Gm-Message-State: AOJu0YwACdvMoQZ7o20Tb0jy3kc2oonOTm703afdhTYT3OdCSi4SeH9W
        AM5OONZX9CSJ5NMvSGKhDXQ=
X-Google-Smtp-Source: AGHT+IHo6cyDQtKk/DrCPAVmLcDE/3jv4Je14YIa3VItFr3K0nOfyJQgI9HBCDJkXfRUhgpHD1LX8A==
X-Received: by 2002:a05:6402:1bc1:b0:532:cae2:8dfc with SMTP id ch1-20020a0564021bc100b00532cae28dfcmr2553727edb.5.1696436717874;
        Wed, 04 Oct 2023 09:25:17 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7db47000000b005311e934765sm96513edt.27.2023.10.04.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:25:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 18:25:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de
Subject: Re: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Message-ID: <ZR2R6wMhOpx6PVGT@gmail.com>
References: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Shrikanth Hegde <sshegde@linux.vnet.ibm.com> wrote:

> When the system is fully busy, there will not be any idle CPU's.
> In that case, load_balance will be called mainly with CPU_NOT_IDLE
> type. In should_we_balance its currently checking for an idle CPU if
> one exist. When system is 100% busy, there will not be an idle CPU and
> these idle_cpu checks can be skipped. This would avoid fetching those rq
> structures.
> 
> This is a minor optimization for a specific case of 100% utilization.
> 
> .....
> Coming to the current implementation. It is a very basic approach to the
> issue. It may not be the best/perfect way to this.  It works only in
> case of CONFIG_NO_HZ_COMMON. nohz.nr_cpus is a global info available which
> tracks idle CPU's. AFAIU there isn't any other. If there is such info, we
> can use that instead. nohz.nr_cpus is atomic, which might be costly too.
> 
> Alternative way would be to add a new attribute to sched_domain and update
> it in cpu idle entry/exit path per CPU. Advantage is, check can be per
> env->sd instead of global. Slightly complicated, but maybe better. there
> could other advantage at wake up to limit the scan etc.
> 
> Your feedback would really help. Does this optimization makes sense?
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..903d59b5290c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10713,6 +10713,12 @@ static int should_we_balance(struct lb_env *env)
>  		return 1;
>  	}
> 
> +#ifdef CONFIG_NO_HZ_COMMON
> +	/* If the system is fully busy, its better to skip the idle checks */
> +	if (env->idle == CPU_NOT_IDLE && atomic_read(&nohz.nr_cpus) == 0)
> +		return group_balance_cpu(sg) == env->dst_cpu;
> +#endif

Not a big fan of coupling NOHZ to a scheduler optimization in this fashion, 
and not a big fan of the nohz.nr_cpus global cacheline either.

I think it should be done unconditionally, via the scheduler topology tree:

 - We should probably slow-propagate "permanently busy" status of a CPU
   down the topology tree, ie.:

     - mark a domain fully-busy with a delay & batching, probably driven
       by the busy-tick only,

     - while marking a domain idle instantly & propagating this up the
       domain tree only if necessary. The propagation can stop if it
       finds a non-busy domain, so usually it won't reach the root domain.

 - This approach ensures there's no real overhead problem in the domain 
   tree: think of hundreds of CPUs all accessing the nohz.nr_cpus global 
   variable... I bet it's a measurable problem already on large systems.

 - The "atomic_read(&nohz.nr_cpus) == 0" condition in your patch is simply
   the busy-flag checked at the root domain: a readonly global cacheline
   that never gets modified on a permanently busy system.

Thanks,

	Ingo
