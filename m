Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF6A799F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjIJT6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIJT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:58:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C9132
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:58:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so3757647f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694375915; x=1694980715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/mpJ4QxANMd1OUi0izes/wPE27BO8URpmrDEAd/e+A=;
        b=Kjp1i//bLXWlW2wDeGwlX3Ybt46ejYSxUzDq7cLGvuOWev+4nHQytKW+rLCEUrG51t
         XHwdOlc+5otnNX/6GyzgRSaoC+cb/ppPjxyIuEw8o1tcq7W/kRXdbahgeI+G364xj6uU
         h2G/sDT8L7EKgzWUrSfh48AK+Ga2wHhlxlDgnmurmEulqbutH/aG0UPSymyVx2IVDYJZ
         pAGsHh+9jAHraCZ8U5asjK7G+lgC5Aetl7nhIhParjz8qYSy3LO7pkaAduCJrfJfbYuJ
         299JwZG35VZPfex7l1e8uyGcCliLeVMYSsbcfDbksivLlImEaXyes/XlMw+9QtcpBrP2
         vuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694375915; x=1694980715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/mpJ4QxANMd1OUi0izes/wPE27BO8URpmrDEAd/e+A=;
        b=if7DmOVfDn7N9Q4kgTR7WVmr5A6L1QHcvy1oj72vz0DJa1DJ0AXJnCFU538ylcOtoT
         h6LbDWjH2Ec1gwrQJQ+tijoDcKslWLp+5SRCJ4GoY6COmBe+E6ikk5PunfBGNLynC8fs
         Vx2qd2uJ4i/S/Qiby8b6R+eIE9MEvx2h31HMPVNqGVGm5K0TeSl76/EF+1KkBDIpOdJz
         kGiROSLgA/AXe7raWchR2Ijk6g49sLtlpQA7dtEvXdTz1p/Fe7LNKiFvqH/m671iID8U
         HrQ+HQrfJKdmOIHCu/KfuZyzb5w2xrp+bYHiah0aVcMqYvN0zwBE/zTgio23B7rv0IqK
         4JMw==
X-Gm-Message-State: AOJu0YyO1qUzGDPLTRaW0oqBdksSZGO0RP9XyLPhLy9T++VO5lmj/KLS
        lPj4x+LO1/poTGNu1QjNnRsYrQ==
X-Google-Smtp-Source: AGHT+IEQDVbVhC1bXE9o/if6YM58KB28ZTDBO/FwCzX9X/u10FKNVul2ruxbQ3NG8SyOkN1iEvNlgA==
X-Received: by 2002:a5d:5541:0:b0:317:6310:a616 with SMTP id g1-20020a5d5541000000b003176310a616mr6087460wrw.36.1694375914818;
        Sun, 10 Sep 2023 12:58:34 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d5706000000b0031ad5a54bedsm8032679wrv.9.2023.09.10.12.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:58:34 -0700 (PDT)
Date:   Sun, 10 Sep 2023 20:58:32 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate
 the future util_avg value
Message-ID: <20230910195832.pncjsqmkepichly6@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
 <20230906211936.yqejc25czc6tddm6@airbuntu>
 <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 13:12, Dietmar Eggemann wrote:
> On 06/09/2023 23:19, Qais Yousef wrote:
> > On 09/06/23 14:56, Dietmar Eggemann wrote:
> >> On 28/08/2023 01:31, Qais Yousef wrote:
> 
> [...]
> 
> >>> +/*
> >>> + * Approximate the new util_avg value assuming an entity has continued to run
> >>> + * for @delta us.
> >>> + */
> >>> +unsigned long approximate_util_avg(unsigned long util, u64 delta)
> >>> +{
> >>> +	struct sched_avg sa = {
> >>> +		.util_sum = util * PELT_MIN_DIVIDER,
> >>> +		.util_avg = util,
> >>> +	};
> >>> +
> >>> +	if (unlikely(!delta))
> >>> +		return util;
> >>> +
> >>> +	accumulate_sum(delta, &sa, 0, 0, 1);
> >>
> >> IMHO, you miss the handling of `periods != 0`. load = 0 eclipses this
> >> code in accumulate_sum().
> 
> You could call accumulate_sum(delta, &sa, 1, 0, 1);

Yes. I initially thought the load is not necessary, but good catch. I didn't
get a chance to rerun to see the numbers, but hopefully this should fix the
wrong numbers I was seeing. Thanks!

> 
> > 
> > Yes. For some reason I got blank registered when I saw if this codepath can
> > impact util_avg..
> 
> Another thing ... I guess if you call accumulate_sum with delta the PELT
> machinery assumes `delta = now - sa->last_update_time` which means you
> would have to use `clock_pelt + TICK_USEC` as delta.

Right.

The way I understood it is that at TICK we should do update_load_avg() which
would call __update_load_sum() which uses

	delta = now - sa->last_update_time

which passes this delta to accumulate_sum()

I can see we are not very accurate since there will be a small additional time
besides TICK_USEC that we are not accounting for. But I can't see how this can
cause a big error.

	predicted (assumed) tick time/delta

		sa->last_update_time = now
		tick_time = TICK_USEC + now

		delta = tick_time - sa->last_update_time
		delta = TICK_USEC + now - now
		delta = TICK_USEC

	but actual tick time/delta

		sa->last_update_time = now - x
		tick_time = TICK_USEC + now

		delta = tick_time - sa->last_update_time
		delta = TICK_USEC + now - (now - x)
		delta = TICK_USEC + x

So the delta I am using might be slightly shorter than it should be.

IIUC, what you're saying that the `x` in my equation above is clock_pelt,
right?


Thanks!

--
Qais Yousef
