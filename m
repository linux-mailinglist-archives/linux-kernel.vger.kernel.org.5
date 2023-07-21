Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB575D71C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGUWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUWEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:04:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B158268F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:04:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so20662465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689977073; x=1690581873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydB8+LAJh4x1+fd2BjNCel+egumar3Lm09tICNpFdUQ=;
        b=tQPKhBBlelqrvZ4KberuHpvh+SAgoQS4Ta/enSPJLS5CurexI2qoY1oxwtPJlEG2pH
         3re76eQ+gg+9truUcG9Tg834X3nRHmtIrKsVtPUs38+C5mtDSTXLiwDlRyQ0fU8zgHWX
         We5ISaRXcMxrNJ1rKB+KSx+e6TucBQiVnaeKXqTDQ3Kvc/h3OgT7JS3vk1VQirDScGbS
         WfvWYqKCiXkpKO5T/v76i0+wB4lAjMMyr+TzQv8TBTqPxT2tdsZVkl/OrWeWQmKc6kOD
         lud1nz56nQCL12Rov1kU51VCRiz23UXJ0vj017TUMGgSTIzgagUhLWcVhjEVh4Y3ilis
         sLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977073; x=1690581873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydB8+LAJh4x1+fd2BjNCel+egumar3Lm09tICNpFdUQ=;
        b=hcJ7l6rnEUpwBeFP3FnbpulZe1dC0ZofgOo6dlTLr79OGdNudrxMnuMu2yYq5y1cRh
         GhXEsr9263JkQd+IxzM9i1fVa2zKc93Wcgn4Sp3bAAdUjj9lp9jJQ/ZferzEJnKfiwYX
         bbEP02UhcydLFGSvfFbsL2Vyokl2X08bFcsRuOQ+rc1pBSQfPikzQBvodaKdZKyuFyUJ
         Wv6n3B1zZs2PGUfSusl3QMvJ6P5EbxIYGRyFlj7jIdWXNwELT+uzSMgBQ7Hz3HyOes2M
         0//DcducT4OlPHTtG43w9uo/kcLGUDXMLaedObmBLLfT38SkKnxKel3pRtW7jYu+AMsQ
         /RzQ==
X-Gm-Message-State: ABy/qLZGDr8jcfe7kiVut42bnlhrclfnN7SjzDGxCScH6Ye1GJM1o1Wm
        znl4wInthPgerQehalCbiooR8g==
X-Google-Smtp-Source: APBJJlHQ9aLaG3IXsCkDsy8TX2SrZqOVgRn8K29ARIJKnTkirnW5+ECbv3nHgZP50wfQfUO8+UzIpQ==
X-Received: by 2002:a05:600c:22c3:b0:3f9:b430:199b with SMTP id 3-20020a05600c22c300b003f9b430199bmr2474810wmg.15.1689977072516;
        Fri, 21 Jul 2023 15:04:32 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm6840730wmq.0.2023.07.21.15.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:04:31 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:04:30 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230721220430.qv6eqo4dosfrsilo@airbuntu>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu>
 <ZLqNmpQdiTC2fio5@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLqNmpQdiTC2fio5@vingu-book>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/23 15:52, Vincent Guittot wrote:
> Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
> > On 07/20/23 14:31, Vincent Guittot wrote:
> > 
> > > I was trying to reproduce the behavior but I was failing until I
> > > realized that this code path is used when the 2 groups are not sharing
> > > their cache. Which topology do you use ? I thought that dynamiQ and
> > > shares cache between all 8 cpus was the norm for arm64 embedded device
> > > now
> > 
> > Hmm good question. phantom domains didn't die which I think is what causing
> > this. I can look if this is for a good reason or just historical artifact.
> > 
> > > 
> > > Also when you say "the little cluster capacity is very small nowadays
> > > (around 200 or less)", it is the capacity of 1 core or the cluster ?
> > 
> > I meant one core. So in my case all the littles were busy except for one that
> > was mostly idle and never pulled a task from mid where two tasks were stuck on
> > a CPU there. And the logs I have added were showing me that the env->imbalance
> > was on 150+ range but the task we pull was in the 350+ range.
> 
> I'm not able to reproduce your problem with v6.5-rc2 and without phantom domain,
> which is expected because we share cache and weight is 1 so we use the path
> 
> 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> 			/*
> 			 * When prefer sibling, evenly spread running tasks on
> 			 * groups.
> 			 */
> 			env->migration_type = migrate_task;
> 			env->imbalance = sibling_imbalance(env, sds, busiest, local);
> 		} else {
> 

I missed the deps on topology. So yes you're right, this needs to be addressed
first. I seem to remember Sudeep merged some stuff that will flatten these
topologies.

Let me chase this topology thing out first.


Thanks!

--
Qais Yousef

> > 
> > I should have mentioned that I'm on 5.15 - sorry with Android it's hard to run
> > mainline on products :( But this code as far as I can tell hasn't changed much.
> > 
> > I can try to find something that runs mainline and reproduce there if you think
> > my description of the problem is not clear or applicable.
> > 
> > 
> > Thanks
> > 
> > --
> > Qais Yousef
