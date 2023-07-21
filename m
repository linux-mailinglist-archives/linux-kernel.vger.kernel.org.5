Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B112375C523
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGUK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGUK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:57:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7B19B5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:57:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so14668735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689937033; x=1690541833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W98yB9onrt+L+sHrT9wYT0pOvj+Kg/EhmG2u0g1eta0=;
        b=MsB8RTKpskKLNG1//7WGzsABffdV6qVkUUAhK6Ywm4NMbs6vjKggiHX9bAXFLwat2u
         oheAxyR9KDrbjNucdbaEdDOWuV7UZeSOR+pRTV7jl89kBWsWH8ocFl1iwWozUWUMvPD+
         yI+rihhR5ys2Q2iUsBfcad9zpGJ3w1T4/KFLxQR038OQC4a0lc8PxBpp8PWv9AYAxeJe
         Q628ecEDM2ky7sVrr11PCIArbOTXe4ucLgGcZF1LybzDqsXhrrFu6lmiq6Exszc8nVK0
         csGIBA0fyQz9G0jpUt97g0tWbOHCgl6hVtlGdTN3POvXIHypyhpdvCvE7tn1sH0FjC9u
         850A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689937033; x=1690541833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W98yB9onrt+L+sHrT9wYT0pOvj+Kg/EhmG2u0g1eta0=;
        b=dsaWMJqqiOSmjo3s28SDhNy4rI1C07NEFVB0/QZh3zkHIGVV0t098LWV1DsQBeqRY5
         0KKXYUohTvpnZcDjlv5iqqB5l778OAGUbVOTxUVq+aTCAtOZ775Vuvr9mEMQOtdhnVUe
         0sIWthMwpy3/KvBpK0RLj4ve14gz3NDmCXcEiy1EyBo0Xw1iltJP+c6IoLaBzoFppcuV
         DTUNj9+flqW9tEkxkcxSJcLOEYjlZQdUiGiArRWl+8NvDXyZ0j1CdeMgFj8jf3Et/E3k
         I7QVKFEZxfe8K9btYhHCeQ43ec2/qlTkRvsWB+pSf4XwuBxDsGlnAUftbTx2Q5zNjp3X
         n8oA==
X-Gm-Message-State: ABy/qLYmieUBct800iKg+cNuWrrlGCcwI/1KjzeJzim6zsR4WXZCWak4
        Gri8NJmCpXKLXEzfOUulxOIO127NG1EXAGwSlz8=
X-Google-Smtp-Source: APBJJlELd3pibdzXadazj+Ze9uIDI9J3Iim181nZv3Vh9OjEeCxgwyjBFuzU/S2BB/GyCoOY780jfA==
X-Received: by 2002:adf:dbce:0:b0:314:fe8:94d8 with SMTP id e14-20020adfdbce000000b003140fe894d8mr1109281wrj.31.1689937033293;
        Fri, 21 Jul 2023 03:57:13 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d5545000000b0031437ec7ec1sm3906887wrw.2.2023.07.21.03.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:57:12 -0700 (PDT)
Date:   Fri, 21 Jul 2023 11:57:11 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230721105711.nzunqdtdaevmrgyg@airbuntu>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/23 14:31, Vincent Guittot wrote:

> I was trying to reproduce the behavior but I was failing until I
> realized that this code path is used when the 2 groups are not sharing
> their cache. Which topology do you use ? I thought that dynamiQ and
> shares cache between all 8 cpus was the norm for arm64 embedded device
> now

Hmm good question. phantom domains didn't die which I think is what causing
this. I can look if this is for a good reason or just historical artifact.

> 
> Also when you say "the little cluster capacity is very small nowadays
> (around 200 or less)", it is the capacity of 1 core or the cluster ?

I meant one core. So in my case all the littles were busy except for one that
was mostly idle and never pulled a task from mid where two tasks were stuck on
a CPU there. And the logs I have added were showing me that the env->imbalance
was on 150+ range but the task we pull was in the 350+ range.

I should have mentioned that I'm on 5.15 - sorry with Android it's hard to run
mainline on products :( But this code as far as I can tell hasn't changed much.

I can try to find something that runs mainline and reproduce there if you think
my description of the problem is not clear or applicable.


Thanks

--
Qais Yousef
