Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59487A3252
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjIPTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjIPTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:49:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544CCDE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:49:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2812999f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694893765; x=1695498565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhEgwhsS2gNdFaESm/g7+1RLgNynh4jZ4Z0rYWK9ouc=;
        b=D8yEuTZeDd/DRi1DEHjMHIHCkP+wGslQAPm7PBJVBlqCk3xOQDFQBv4Hj5YSsen0m4
         hNoZshFABw6xUs+A+E82IfMOjbQGDXlVWY9PUh0xo07u+dZ2yDn18U1PNIXxDYQbWWiv
         cWvSjFKC1pCJtcgTEM6qL0yGnV3s4mA+I2O98ayBUn8w23WZJlLR+zu02VIXMuCg/zKB
         SWj1AqvyrB5kScuk3s+5lDLJa78Y9OVqtecyKe+5ImLRZ5SOyP4MBYhNKDgXjBOHbIwl
         +dsVx24e6JgQAhiV70wLiKSZgm7BQWJkWu33ncW2s0f2vHoTm7WdFM7t8wuosc5Zklnu
         CYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694893765; x=1695498565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhEgwhsS2gNdFaESm/g7+1RLgNynh4jZ4Z0rYWK9ouc=;
        b=dtJZCHwSMbhvNlKvAbJHaBfLarA3HmeF6jbgdHPhAiWfeXIRcDUdymg5LnlzlJrVL0
         tZdjRBgLj2E6q+Z/sS0Nn0ImMhh3cTVBIvmd5Yum6tA7wjrObgY2F0GjfjCWgmRJFkRq
         rcvPM3UjU9pvAa0wdHLkLbkUPqv3agN5u9EKLIBlZ3SyR2xejh4NQz1oV7npqGCvhQhF
         40VxfHGGQaJFnUOk/7FlEpKiAyN1uND2PmhgtHFGH+FmaHpiguTfSb+q4DNcwr/0v+HA
         Vg7OaUvtYF8TVY4Hib72Vlh9N8jOuhRLzk3VfuLUyDpNwQgkFvV5yIWwCcauVBU2MA6L
         Yvkw==
X-Gm-Message-State: AOJu0YzAcrTU4gXzpGcqGw9SYNs65BZSuqC+zrJwl/WdIGCGnpy3ppK6
        dYhoQedT+yIw0L/Huts2th7D1g==
X-Google-Smtp-Source: AGHT+IFeNHKsPSgw0ay0079kNC39zggVssFTaXBoTIdk27U/Oa7c9349jg+h0hfBrmpjkQyLbdVgfQ==
X-Received: by 2002:adf:f742:0:b0:319:7c0f:d920 with SMTP id z2-20020adff742000000b003197c0fd920mr3617679wrp.57.1694893765210;
        Sat, 16 Sep 2023 12:49:25 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b0031981c500aasm7885231wrq.25.2023.09.16.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:49:24 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:49:23 +0100
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
Message-ID: <20230916194923.4sijts6a56jxbava@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
 <20230906211936.yqejc25czc6tddm6@airbuntu>
 <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
 <20230910195832.pncjsqmkepichly6@airbuntu>
 <45548b21-280e-7f94-0b53-f2dcab6ccb5e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45548b21-280e-7f94-0b53-f2dcab6ccb5e@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/23 19:22, Dietmar Eggemann wrote:
> On 10/09/2023 21:58, Qais Yousef wrote:
> > On 09/07/23 13:12, Dietmar Eggemann wrote:
> >> On 06/09/2023 23:19, Qais Yousef wrote:
> >>> On 09/06/23 14:56, Dietmar Eggemann wrote:
> >>>> On 28/08/2023 01:31, Qais Yousef wrote:
> 
> [...]
> 
> >> Another thing ... I guess if you call accumulate_sum with delta the PELT
> >> machinery assumes `delta = now - sa->last_update_time` which means you
> >> would have to use `clock_pelt + TICK_USEC` as delta.
> > 
> > Right.
> > 
> > The way I understood it is that at TICK we should do update_load_avg() which
> > would call __update_load_sum() which uses
> > 
> > 	delta = now - sa->last_update_time
> > 
> > which passes this delta to accumulate_sum()
> > 
> > I can see we are not very accurate since there will be a small additional time
> > besides TICK_USEC that we are not accounting for. But I can't see how this can
> > cause a big error.
> > 
> > 	predicted (assumed) tick time/delta
> > 
> > 		sa->last_update_time = now
> > 		tick_time = TICK_USEC + now
> > 
> > 		delta = tick_time - sa->last_update_time
> > 		delta = TICK_USEC + now - now
> > 		delta = TICK_USEC
> > 
> > 	but actual tick time/delta
> > 
> > 		sa->last_update_time = now - x
> > 		tick_time = TICK_USEC + now
> > 
> > 		delta = tick_time - sa->last_update_time
> > 		delta = TICK_USEC + now - (now - x)
> > 		delta = TICK_USEC + x
> > 
> > So the delta I am using might be slightly shorter than it should be.
> > 
> > IIUC, what you're saying that the `x` in my equation above is clock_pelt,
> > right?
> 
> No, I was wrong here. Calling accumulate_sum with `delta = TICK_USEC` is
> fine.
> 
> accumulate_sum() will accrue `sa->util.sum` and ___update_load_avg()
> will then adjust `sa->util_avg` accordingly.
> 
> delta should be 4000 on Arm64 boards so you will cross period
> boundaries. In case `delta < 1024` you might want to not call
> ___update_load_avg() to be in pair with __update_load_avg_cfs_rq().

You mean *not* call, or actually *do* call ___update_load_avg() if delta
< 1024? I am certainly not calling it now and I think you're suggesting to
actually call it when period is less than 1024.

This area is not my strength, so I do sure appreciate any suggestion to make it
better! :-) I will look into that for next version.


Many thanks!

--
Qais Yousef
