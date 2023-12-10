Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84380BD39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjLJUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:40:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD9D7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 12:40:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so15794515e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702240835; x=1702845635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Uyd9KMY+K25kTJFgOr5S8Hm0W9vFSsTptGb/Ecd2pM=;
        b=E5ZHl+VyniGXu8tX8dC80tid+/FFfk0vt/Wno2lU7requPiTZgv6/RODbpLH/gbTKx
         /DdyFLA8vgKmE17K/nFohsUjqtxq0j26oPOpSD6KDcHu2xX1lV8EwAfOhe+Kspo110a/
         ytRPClvVzgPy0hBd70WvsHr+KRoQQ9d93MF80LVofmH9ySErnUx6EEu4slgmSOsoI187
         EWeznvh+eoPZzs0ILpi7q5KTL+Hfl/aSE4KB66AKuUkUIjRNwRm2sGS7TokKTf3bwmGU
         iHRld15OtQ5kv5U8nRumi5zSOu1yZB1qD4rq4Uw8r6rvUd7d9aViNKSGnZXD1s8G0QbN
         kSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702240835; x=1702845635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uyd9KMY+K25kTJFgOr5S8Hm0W9vFSsTptGb/Ecd2pM=;
        b=bDESVWTlY6Ee+TukeqsoSzlk189UvAj1oNoKTn34/loZows9SbCMFNcOMVdcxYVoCK
         lRBN6D99mH3mANY++Fcoqj28JWXOCPEU9yr1bA/N6V+MurH917iHDucRTT2IjWpXtI3R
         BCyHrWsWimZoyOaO6wbMSctt4LO4DLpsXQyeqTmMk9xfQTUwJGgMzRourFYRZL3PZAgw
         YSMVj22ty69Bd/vwn6RazSIkTvxoNa0BK46kkJc7SgpyNKzNCXMEfXLyuRT6W/9H/r6o
         oCWYPuTS2KPE1Q9MTdm9Uw/nBzwsCrcJYmA9GQTMA5rpS+cCkg1mf5XwIiZ5MtvdW2ar
         yv1Q==
X-Gm-Message-State: AOJu0YwGC6JHiAXUJ82mmVFbLZYiMR1zlEIUpLZYBwDzpuNGQ63L/cQG
        +15PE4F/5aigDVexs/UEImrBzA==
X-Google-Smtp-Source: AGHT+IFxMIMh5aewN00Oc8FUKcOa4n76XyVMwRfDK93DYoceLQVAxOssdc0xwwnr430pCJK3uVtfwg==
X-Received: by 2002:a05:600c:993:b0:40c:18fa:8e6b with SMTP id w19-20020a05600c099300b0040c18fa8e6bmr861474wmp.266.1702240834891;
        Sun, 10 Dec 2023 12:40:34 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b0040b4c59f133sm10574096wmo.1.2023.12.10.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 12:40:34 -0800 (PST)
Date:   Sun, 10 Dec 2023 20:40:32 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20231210204032.fficzltp2gq66pne@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-8-qyousef@layalina.io>
 <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/23 19:06, Rafael J. Wysocki wrote:
> On Fri, Dec 8, 2023 at 1:24 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > The new tunable, response_time_ms,  allow us to speed up or slow down
> > the response time of the policy to meet the perf, power and thermal
> > characteristic desired by the user/sysadmin. There's no single universal
> > trade-off that we can apply for all systems even if they use the same
> > SoC. The form factor of the system, the dominant use case, and in case
> > of battery powered systems, the size of the battery and presence or
> > absence of active cooling can play a big role on what would be best to
> > use.
> >
> > The new tunable provides sensible defaults, but yet gives the power to
> > control the response time to the user/sysadmin, if they wish to.
> >
> > This tunable is applied before we apply the DVFS headroom.
> >
> > The default behavior of applying 1.25 headroom can be re-instated easily
> > now. But we continue to keep the min required headroom to overcome
> > hardware limitation in its speed to change DVFS. And any additional
> > headroom to speed things up must be applied by userspace to match their
> > expectation for best perf/watt as it dictates a type of policy that will
> > be better for some systems, but worse for others.
> >
> > There's a whitespace clean up included in sugov_start().
> >
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> 
> I thought that there was an agreement to avoid adding any new tunables
> to schedutil.

Oh. I didn't know that.

What alternatives do we have? I couldn't see how can we universally make the
response work for every possible system (not just SoC, but different platforms
with same SoC even) and workloads. We see big power saving with no or little
perf impact on many workloads when not applying the current 125%. Others want
to push it faster under gaming scenarios etc to get more stable FPS.

Hopefully uclamp will make the need for this tuning obsolete over time. But
until userspace gains critical mass; I can't see how we can know best
trade-offs for all myriads of use cases/systems.

Some are happy to gain more perf and lose power. Others prefer to save power
over perf. DVFS response time plays a critical role in this trade-off and I'm
not sure how we can crystal ball it without delegating.


Thanks!

--
Qais Yousef
