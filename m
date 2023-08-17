Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0B77FC37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353664AbjHQQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353234AbjHQQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:37:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BDDE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:37:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-688731c6331so2194032b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692290275; x=1692895075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i++1LU1TWStISeIModaRn7WbkYj3NYwnbl4SGSKvDDU=;
        b=Lnf+dJ/ziyvh5PLbYbsGhanzEGQPFv75HThGTGRBGoZnBzKwZR3yTKKU2uBNqucFu3
         Tixvp2d9X0d4Gg4A1i+H0g7ScvHj2Yr5MWPttJOk8g0wAYw79I0MainACqBFj4fU2WZV
         3iplR6AEueyiFWRzbJVj8j3tE1BWBIAObmRCQpkB4kbdPwnjUZse093z1ifliRzlggyu
         gzUg6V2wcd9TvRPkkfIK3l3Cga4J+7jcXnsJny/LAfvvlN3Y0wsE2+EyhVveo1bQDKK7
         6d0X52qYwMK+uQ4D2vHspvAAnlpV6haYhWRNJpXfPE/A1URTxP3FLV8qlJ+JS1D3SkvH
         stow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290275; x=1692895075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i++1LU1TWStISeIModaRn7WbkYj3NYwnbl4SGSKvDDU=;
        b=T5L7He9BpvZpa1KiR+FSmZnZq3oyLi16ZV6OmJz1+4mqVMm2+Um7XYfNG1peDaDdhM
         oG2sv2INFkF9hGmiimR23OrmunoXtleVF4KCng2uMu8GPOz9cnZPjb996XtQO6tdGPfw
         DDmd8/XS3QV47AQbHT6gRsMSzMBkVHbvoT5xf7aXC5MPdWkCdDAeyvjEvcsEMBcaq2Q8
         +U6r4ftItlY82IXiUeJK0IeGfYlQhJT8j1QtxBUoc5VEUrr5XLuiyI4hyGOKApNTYo1r
         aQoSl2zHI4g82ECsaHrkv/PhJPkALjG67stiwE6RGcOYA44HCWcWfUSDtvNtMa2WJjUq
         7rTA==
X-Gm-Message-State: AOJu0Yy1vqv5AzxTchtrSu25E8KppXs7/bZ4LO+cuC28rHaqRwgbcPDt
        PKTL7AU4cCG84K9lUqoxc0Ao/gPt/L3U+NQya6NhVQ==
X-Google-Smtp-Source: AGHT+IGPck+GHYceIOt3clqRTqyWiMyRCO9KsVK8WGVf1WdC3plqOx7MS4/0D/d9YYizhxp/eNTmKjehavI5khO3rYo=
X-Received: by 2002:a05:6a00:158c:b0:687:1be4:46e7 with SMTP id
 u12-20020a056a00158c00b006871be446e7mr68685pfk.9.1692290274689; Thu, 17 Aug
 2023 09:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
 <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
 <e52d3f53-97dc-2081-5124-5e13e29d2603@efficios.com> <81a0b993-b613-1b35-ba43-13c7306b50e6@efficios.com>
In-Reply-To: <81a0b993-b613-1b35-ba43-13c7306b50e6@efficios.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Aug 2023 18:37:43 +0200
Message-ID: <CAKfTPtDeT0-pX7_NVr-bG_cqYUCCogYbR0ioMT-zjyXsDO45fA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 18:13, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 8/17/23 12:09, Mathieu Desnoyers wrote:
> > On 8/17/23 12:01, Vincent Guittot wrote:
> >> On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >>>
> >>> Skipping queued wakeups for all logical CPUs sharing an LLC means that
> >>> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
> >>> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
> >>> runqueues within the same group for each wakeup, causing contention on
> >>> the runqueue locks.
> > [...]
> >>>
> >>> -bool cpus_share_cache(int this_cpu, int that_cpu);
> >>> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
> >>> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */
> >>
> >> I think that Yicong is doing what you want with
> >> cpus_share_lowest_cache() which points to cluster when available or
> >> LLC otherwise
> >> https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618
> >>
> >
> > AFAIU (please correct me if I'm wrong) my AMD EPYC machine has sockets
> > consisting of 12 clusters, each cluster having its own L3 cache.
> >
> > What I am trying to achieve here is really to implement "cpus_share_l2":
> > I want this to match only when the cpus have a common L2 cache. L3
> > appears to be a group which is either:
> >
> > - too large (16 hw threads) or
> > - have a too high access latency.
> >
> > I'm not certain which (or if both) of those reasons explain why
> > grouping by L2 is better here.
>
> Re-reading the patch you pointed me to, I notice:
>
> "+ * Whether CPUs are share lowest cache, which means LLC on non-cluster
>   + * machines and LLC tag or L2 on machines with clusters."
>
> So this "share lowest cache" really means lowest in terms of number,
> e.g. L2 < L3, and not "lowest in the hierarchy" as is "closest to
> memory", correct ?

Yes

>
> Thanks,
>
> Mathieu
>
> >
> > Thanks,
> >
> > Mathieu
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
