Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5779875C85F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGUNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGUNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:52:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8503595
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:52:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea147034so16434505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947548; x=1690552348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ssTX1dgKRkyhcVD+Me8qksEtUg0EWGtfVzkcxqqnjko=;
        b=IKJ23G9In1fc8tE2mC2zxBfvmMkqWT/w/hqNO3cguCgvVbOdliJ/+o2ejReG+JvapN
         D4y89BRuR14ExI+7wepiNa6iN76uTPP6gZvqrGPL+Dh8V9zrs1HSJkPLwHLcWlv82pRO
         F7sI0PiIjSquK7vb2p5lL5i/imQTv4liA3GCpxY7K4ptnrB9z3sn0q+z2zuhindontVu
         AwutZs3riQd8a3K/+p4rKvxq+WesJROUyDmLRAbI0ENVlgBXtxHqYhEoERQyvzfxZLvk
         PHSQESz3TkVRUEAtSjBxQR26TS1JEpe0EUwGGd6sQ2KnLsSYyp+xxwakDmlE1JAVe15X
         wqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947548; x=1690552348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssTX1dgKRkyhcVD+Me8qksEtUg0EWGtfVzkcxqqnjko=;
        b=AT1u3SQGGFQxqUTT7FFCgyvBHlBxv6tI8j9cj9/grUlmy7piV66lFVEz1jKlKXXwb7
         T8KXOv2+MREfHrtpmcI77pCRgcKTMHdYymE7hTtgJ308eq2z4ZZt2SXAnbjipe1Vqjrj
         IHVuq4B8dLNJ9v6n5qz5768KZODvpI+D08etl34pbQX2v9AWEMWBVogPdSotyN9boFeu
         ByvY/QRfV8pDy94q7F/qQqDnaToWSPKPngFJR0YznlxNK5eMVqm50Gkb3P9ISUY1ik+b
         nY43yPEa0iv7rqycvJwrztgaHsHkumeQH1D9vVjGSaiudGmnbmNo9FePkHn18eQeLtFe
         I95Q==
X-Gm-Message-State: ABy/qLbOCIQasU4xjWWsaFVBAy39jNbOpDNLvq9xYqXkyXYHL2lcyhUp
        EC7vxhuNHUV6KaK470psIaSMvg==
X-Google-Smtp-Source: APBJJlH2B7nVt4ws264dmiaffqMpt4vUElilrhO4UAm+nys0XZG+ZUfliBqua6l9UWrbAI75pAEP8g==
X-Received: by 2002:a05:600c:11c9:b0:3fc:4e0:be97 with SMTP id b9-20020a05600c11c900b003fc04e0be97mr1377905wmi.6.1689947547751;
        Fri, 21 Jul 2023 06:52:27 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:bce2:d9d6:9bb0:28be])
        by smtp.gmail.com with ESMTPSA id d11-20020a1c730b000000b003fc00892c13sm3356713wmb.35.2023.07.21.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:52:27 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:52:26 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <ZLqNmpQdiTC2fio5@vingu-book>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721105711.nzunqdtdaevmrgyg@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
> On 07/20/23 14:31, Vincent Guittot wrote:
> 
> > I was trying to reproduce the behavior but I was failing until I
> > realized that this code path is used when the 2 groups are not sharing
> > their cache. Which topology do you use ? I thought that dynamiQ and
> > shares cache between all 8 cpus was the norm for arm64 embedded device
> > now
> 
> Hmm good question. phantom domains didn't die which I think is what causing
> this. I can look if this is for a good reason or just historical artifact.
> 
> > 
> > Also when you say "the little cluster capacity is very small nowadays
> > (around 200 or less)", it is the capacity of 1 core or the cluster ?
> 
> I meant one core. So in my case all the littles were busy except for one that
> was mostly idle and never pulled a task from mid where two tasks were stuck on
> a CPU there. And the logs I have added were showing me that the env->imbalance
> was on 150+ range but the task we pull was in the 350+ range.

I'm not able to reproduce your problem with v6.5-rc2 and without phantom domain,
which is expected because we share cache and weight is 1 so we use the path

		if (busiest->group_weight == 1 || sds->prefer_sibling) {
			/*
			 * When prefer sibling, evenly spread running tasks on
			 * groups.
			 */
			env->migration_type = migrate_task;
			env->imbalance = sibling_imbalance(env, sds, busiest, local);
		} else {

> 
> I should have mentioned that I'm on 5.15 - sorry with Android it's hard to run
> mainline on products :( But this code as far as I can tell hasn't changed much.
> 
> I can try to find something that runs mainline and reproduce there if you think
> my description of the problem is not clear or applicable.
> 
> 
> Thanks
> 
> --
> Qais Yousef
