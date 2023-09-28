Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6713D7B26F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjI1VDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1VDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:03:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB819D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:03:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b275afb6abso2049183366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935000; x=1696539800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68u9ZfEQDYxbKIVdn90enoX7Bta9ioMeZd73BugfMBs=;
        b=HFbGCvKjtiLG+udXZTd6YVJtBz0QqZ2I2R6BIEKS6ExrqQmIMKNe6P+v4oR/2YQIwZ
         zr4SYbiHp7QKQ1y44iGdffk9mWcVIqeKDhiOMTL/3pQVKfzhAiHpV07oJ/Zln/0wqzk7
         gYbn9T0rSy8kxQY7VoTfpMlWe6du3nlqEs4CDBHseDRizn8UXl0M/scBih7a0jQkKoZE
         nfndaj8C/cMPTwCXFXIgh+oNDmDKpjfFnTy8UVpbxFOgqigLGJa98xb/FvPgV+e7rxdI
         YKshPaosj/ULf3jm4eml3vrItA2Iki+mgkSx8lo/unNQ1pW3o0exPKs6JlhXKyay3Iiw
         1udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935000; x=1696539800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68u9ZfEQDYxbKIVdn90enoX7Bta9ioMeZd73BugfMBs=;
        b=DbYXqAxt0gVH6RqLKvQKcFEDrNRwx/KGVySWsfX4O/E7LfH6pmyCNT6CyPuKhFaGkq
         tXzyvG5otswDbgBhDLhroVql/neTuWuZtbfqXGxRP4GPMGbh7tScNwm+dZnVSd8Bjfhr
         TOaqH+YLdnxbRAWOUwIwdv8p1xlxZbxIgRvFWW+ubRp5NIIPTHnjbcl/NBqiqX7qfgoI
         q9hFNumCuVzDqydZLzc2v4fh+LfhZEcBMq3yBKauxvyAv7GjN8LPmBOxViVDhGvNG2uw
         14v4O9KvewUMxVN/s5FNmCKg612mTIsVxmeYpaadslncVBG8BvxhUSQZKWDHRbIN5Cd/
         2WwQ==
X-Gm-Message-State: AOJu0YwWsVxMoglaeSkyDHRMr895gLJ1eotebrrkYL09g3PFMOsdMbUQ
        BsmzStTtb4AiGrFWgsCK/ao=
X-Google-Smtp-Source: AGHT+IEPxa0tA65IrPh8kZ2UQM2M+h7INzcrrW16DhQ5wAs2PxAAXnC6VNAH4JDPcA9X/0zn90t+DA==
X-Received: by 2002:a17:907:2cd1:b0:9ae:5866:9745 with SMTP id hg17-20020a1709072cd100b009ae58669745mr2178225ejc.21.1695935000018;
        Thu, 28 Sep 2023 14:03:20 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009ad829ed144sm11372461ejd.130.2023.09.28.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:03:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 23:03:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Filter root_task_group at the beginning
Message-ID: <ZRXqFScg/vORHoqw@gmail.com>
References: <20230922094336.394865-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922094336.394865-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Haifeng Xu <haifeng.xu@shopee.com> wrote:

> We can't change the weight of the root cgroup. Let's handle
> root_task_group before doing any real work including acquiring
> the shares_mutex.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..1ac2df87e070 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12594,6 +12594,9 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  {
>  	int ret;
>  
> +	if (tg == &root_task_group)
> +		return -EINVAL;
> +
>  	mutex_lock(&shares_mutex);
>  	if (tg_is_idle(tg))
>  		ret = -EINVAL;

So what's the motivation, how common is this case? 

Normally this should be a -EINVAL error code path, which sane user-space
presumably never conscisously tries to call in that fashion, right?

It's not worth optimizing pathological cases, especially
since we check for the root CG inside __sched_group_set_shares()
already:

        /*
         * We can't change the weight of the root cgroup.
         */
        if (!tg->se[0])
                return -EINVAL;


Thanks,

	Ingo
