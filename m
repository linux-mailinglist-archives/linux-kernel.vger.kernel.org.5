Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C27A325C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjIPT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbjIPT4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:56:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A41AD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:56:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso36478815e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694894174; x=1695498974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSRNOnwEQsZZMI8EIIn71RrWo2EfMJ2ZTlOi8DC8epM=;
        b=sWzvC+xkAN09tmwdn6sxPM0OVO0vljZhyxtomJn1osWFSKmzTJuqgxBT2TBHcpQRw9
         hW2RvbnCSD1YM1B8k7trfhP/FbB2aZrD2jn8b28VgIVaSrgiM2IkUNny5OxZ6adq2F/y
         Cj3Om6daiJmYS2k3MepSPdr6ZzTAO6mBeSP/qQ5JOF9fZRsFaYsVwvCWd1mXh9lOI/GX
         18tklEl9/cp5rmDh6YdxMK7l5SR1Bx1M8ZA53q9qETC2YilPOfLdME1fQBk35hEV8HbZ
         uR2YKwSpoVfB1v2Yv45bcXCU2jYB31mrBBs/EbEyXglPkSnIioNJkJXyeP1yE/uNdX+l
         SBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694894174; x=1695498974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSRNOnwEQsZZMI8EIIn71RrWo2EfMJ2ZTlOi8DC8epM=;
        b=MZs1KoPGJ6eqUvc/HigmlhljAa+POLd3cAQU7w7HgNOQd+Xuo7yQoZ7CpvcUt6gO/e
         aDpu1B0TGwqWmmkWgZ/Up3SrPohPJyd6EFTiUDsduDMInqLGh1j7osrQSqk5sYVaLZhp
         x98vmsnk692j9qMhcrjSjl3C1NuW1qcun4I3SJTFLtdIzibPbLU7tmNthFcGeaNYcFGZ
         A2KJjRRCiN2KY3WXxcXdH7UlHGYfALHKfyfENv4Tg63nVv7fjToRsIqsl6OY6AMmWFEJ
         0zape5EsxONsd9ZNBTbLUlT91TwqXQJzBAqtJNb+TCJ9sQYmTfuSnUfmcPwhXJVy9TXB
         sfiQ==
X-Gm-Message-State: AOJu0YyFWvCS+I3v5puTdtcYv2zWIzwwxcQG65559Q/Ckti9hM+QZBWX
        7p7r8Us/i7lQTGoMMEh0owM3TA==
X-Google-Smtp-Source: AGHT+IHgp1hQiDf9gp1gYjKMJGj/hOQySUq6hZIOAS8Yr9MgEmNAohUdVy/Yuq7EBhnq10tLrd8GMw==
X-Received: by 2002:a7b:c4cb:0:b0:401:b53e:6c56 with SMTP id g11-20020a7bc4cb000000b00401b53e6c56mr5131086wmk.3.1694894174399;
        Sat, 16 Sep 2023 12:56:14 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d6804000000b003197efd1e7bsm7990039wru.114.2023.09.16.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:56:13 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:56:12 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 2/7] sched/pelt: Add a new function to approximate
 runtime to reach given util
Message-ID: <20230916195612.n7iukjkdjl3dzyxt@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-3-qyousef@layalina.io>
 <3fc888d4-fc18-7947-0541-9dc42892c071@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fc888d4-fc18-7947-0541-9dc42892c071@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/23 10:15, Hongyan Xia wrote:
> On 28/08/2023 00:31, Qais Yousef wrote:
> > It is basically the ramp-up time from 0 to a given value. Will be used
> > later to implement new tunable to control response time  for schedutil.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >   kernel/sched/pelt.c  | 21 +++++++++++++++++++++
> >   kernel/sched/sched.h |  1 +
> >   2 files changed, 22 insertions(+)
> > 
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 50322005a0ae..f673b9ab92dc 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
> >   	return sa.util_avg;
> >   }
> > +
> > +/*
> > + * Approximate the required amount of runtime in ms required to reach @util.
> > + */
> > +u64 approximate_runtime(unsigned long util)
> > +{
> > +	struct sched_avg sa = {};
> > +	u64 delta = 1024; // period = 1024 = ~1ms
> > +	u64 runtime = 0;
> > +
> > +	if (unlikely(!util))
> > +		return runtime;
> > +
> > +	while (sa.util_avg < util) {
> > +		accumulate_sum(delta, &sa, 0, 0, 1);
> 
> This looks a bit uncomfortable as the existing comment says that we assume:
> 
> 	if (!load)
> 		runnable = running = 0;
> 
> I haven't looked at the math in detail, but if this is okay, maybe a comment
> saying why this is okay despite the existing comment says otherwise?

Yeah as Dietmar highlighted I should pass 1 for load and it was my bad
misreading the code.

So it should be

	accumulate_sum(delta, &sa, 1, 0, 1);

If that's what you meant, yes.


Thanks!

--
Qais Yousef
