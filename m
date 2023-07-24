Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0975FB84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGXQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:10:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95490FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:10:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-316feb137a7so4073452f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1690215040; x=1690819840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0ePfpLHsLvA3LfGul9O3USPQ92wmh4hBVoBqYkITbA=;
        b=baPcpJ+erRuKdzS8TuDymaNBSQviHDjHyttsODiBtxowlIjsFdwQfRyvn/PLBKAz4s
         YOnTf69aisYobx/r8ylUDbWusu+RU5VvMPrMOwtQMWFXvtpCc5h5ZJMWkoJA1320TV+x
         UwXQa+Hw57bUPYTFtvul+gr6nzg+40uQI1/SBlEECdO/1cY6Zi4DRWEXaVDFGh9EVYzp
         5447RaWcJcCfiKj9LbVwpUE6drENT7L7TXCa0d0akiDfVpTnf/2AkPPmL8S1tR10cYLr
         wJEklr1G01dmQsSkLuv0PZgvK+ZWxUOCs4wZd+IBG7+dL2NK65muL/kjTRtwEubPNMlD
         jdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690215040; x=1690819840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ePfpLHsLvA3LfGul9O3USPQ92wmh4hBVoBqYkITbA=;
        b=Ax6qhz04vssVks3TLz0mIMpJ7SA+rWFDvne0nIS+/pWSxjmuyU48huxyDCPgUpyQ22
         jDgRf4b7D6iS/sGneRs4PX5U0nHDJ0onPcFgxQQ66zW46zd+KY6fPOiEw4XqiDPJaoA0
         D+nn1jAgG8cJHFq4u+Q47u18Ohu51qJyQjCnL1U1VjrMLr31TqJWunTxQiqJjrHUacYg
         hbjyMiIqPg/EU27Lmki/fBBKfHI3jxPovtTpHJhTvJRTxwVDTfmIawI/ghhIso8o6RWx
         V1SHYMLgB7h2oilwQOMpc1cf5UkpRfsK55Bv0yf4qkKmGAqyVctNzhKqud7vD3cFUjKB
         oJCg==
X-Gm-Message-State: ABy/qLaZPf5/eBJrrmP3sEr6TooeTfTa04EzJyDz8q32YSYWbuH08Cj+
        M8nPWp8Q2oDMX/7LRAFO5M9noA==
X-Google-Smtp-Source: APBJJlEfToB3aDAY2GwihmCwh7VhKIztFZHKmksHbQxCDx02HMMgOd5UMZmg2DtfF6KFjHwnrx3p0g==
X-Received: by 2002:adf:f092:0:b0:317:5ece:e16a with SMTP id n18-20020adff092000000b003175ecee16amr2532746wro.50.1690215040041;
        Mon, 24 Jul 2023 09:10:40 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id f3-20020a0560001b0300b0030e52d4c1bcsm13442769wrz.71.2023.07.24.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:10:39 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:10:38 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230724161038.nreywdwayiq2ypty@airbuntu>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu>
 <ZLqNmpQdiTC2fio5@vingu-book>
 <20230721220430.qv6eqo4dosfrsilo@airbuntu>
 <c31e5667-19b1-33a4-d1f1-a88907e239d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c31e5667-19b1-33a4-d1f1-a88907e239d3@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/23 14:58, Dietmar Eggemann wrote:
> On 22/07/2023 00:04, Qais Yousef wrote:
> > On 07/21/23 15:52, Vincent Guittot wrote:
> >> Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
> >>> On 07/20/23 14:31, Vincent Guittot wrote:
> >>>
> >>>> I was trying to reproduce the behavior but I was failing until I
> >>>> realized that this code path is used when the 2 groups are not sharing
> >>>> their cache. Which topology do you use ? I thought that dynamiQ and
> >>>> shares cache between all 8 cpus was the norm for arm64 embedded device
> >>>> now
> >>>
> >>> Hmm good question. phantom domains didn't die which I think is what causing
> >>> this. I can look if this is for a good reason or just historical artifact.
> >>>
> >>>>
> >>>> Also when you say "the little cluster capacity is very small nowadays
> >>>> (around 200 or less)", it is the capacity of 1 core or the cluster ?
> >>>
> >>> I meant one core. So in my case all the littles were busy except for one that
> >>> was mostly idle and never pulled a task from mid where two tasks were stuck on
> >>> a CPU there. And the logs I have added were showing me that the env->imbalance
> >>> was on 150+ range but the task we pull was in the 350+ range.
> >>
> >> I'm not able to reproduce your problem with v6.5-rc2 and without phantom domain,
> >> which is expected because we share cache and weight is 1 so we use the path
> >>
> >> 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> >> 			/*
> >> 			 * When prefer sibling, evenly spread running tasks on
> >> 			 * groups.
> >> 			 */
> >> 			env->migration_type = migrate_task;
> >> 			env->imbalance = sibling_imbalance(env, sds, busiest, local);
> >> 		} else {
> >>
> > 
> > I missed the deps on topology. So yes you're right, this needs to be addressed
> > first. I seem to remember Sudeep merged some stuff that will flatten these
> > topologies.
> > 
> > Let me chase this topology thing out first.
> 
> Sudeeps patches align topology cpumasks with cache cpumasks.
> 
> tip/sched/core:
> 
> root@juno:~# cat /sys/devices/system/cpu/cpu*/topology/package_cpus
> 3f
> 3f
> 3f
> 3f
> 3f
> 3f
> 
> v5.9:
> 
> root@juno:~# cat /sys/devices/system/cpu/cpu*/topology/package_cpus
> 39
> 06
> 06
> 39
> 39
> 39
> 
> So Android userspace won't be able to detect uArch boundaries via
> `package_cpus` any longer.
> 
> The phantom domain (DIE) in Android is a legacy decision from within
> Android. Pre-mainline Energy Model was attached to the sched domain
> topology hierarchy. And then IMHO other Android functionality start to
> rely on this. It could be removed regardless of Sudeeps patches in case
> Android would be OK with it.
> 
> The phantom domain is probably set up via DT cpu_map entry:
> 
> cpu-map {
>   cluster0 { <-- enforce phantom domain
>     core0 {
>       cpu = <&CPU0>;
>     };
> ...
>     core3 {
>       cpu = <&CPU1>;
>     };
>   cluster1 {
> ...
> 
> Juno (arch/arm64/boot/dts/arm/juno.dts) also uses cpu-map to enforce
> uarch boundaries on DIE group boundary congruence.
> 
> tip/sched/core:
> 
> # cat /proc/schedstat | awk '{ print $1 " " $2}' | head -5
> ...
> cpu0 0
> domain0 39
> domain1 3f
> 
> v5.9:
> 
> # cat /proc/schedstat | awk '{ print $1 " " $2}' | head -5
> ...
> cpu0 0
> domain0 39
> domain1 3f
> 
> We had a talk at LPC '22 about the influence of the patch-set and the
> phantom domain legacy issue:
> 
> https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf
> 
> [...]

Thanks Dietmar!

So I actually moved everything to a single cluster and this indeed solves the
lb() issue. But then when I tried to look at DT mainline I saw that the DTs
still define separate cluster for each uArch, and this got me confused whether
I did the right thing or not. And made me wonder whether the fix is to change
DT or port Sudeep's/Ionela's patch?

I did some digging and I think the DT, like the ones in mainline by the look of
it, stayed the way it was historically defined.

So IIUC the impacts are on system pre-simplified EM (should have been phased
out AFAIK). And on different presentation on sysfs topology which can
potentially break userspace deps, right? I think this is not a problem too, but
can be famous last words as usual :-)


Thanks

--
Qais Yousef

