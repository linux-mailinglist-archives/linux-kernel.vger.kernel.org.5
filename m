Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E47898EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHZUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHZUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:08:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF556CD5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:08:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so17916085e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693080511; x=1693685311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCdjXlz/JQCmuvXQ01789c2iXr7t5YUpKTlGIJ/Oy+w=;
        b=bLMJeQgewk5hN8+4i7chr1Q/9Kos1wL5EEDYVJjNCzrL0e1qBpKCWOC+AwqrfBL1Fd
         JmqS7jwzLEYX6pxE99NuLvFhSyZH/ngQmzihexmESlqHCIGUJA1X5Sslt72jGKcZU+uw
         yPKSAr+0Ws3JLiZAMfMnJsUh+kumfM33rS0cZVpyxEQ9YVB0dbO3nNWJTW1z/58GWtEI
         +y1yBlPKt+stmw44aqLE9HR4wnUXtN1mfNb7kZcfDpNFN+AqNi/Ldf5v8CHSaIwCO92O
         64/AaURzwa449zo5YsIr4/3lvbScj9rd5kz8In3UZcBlk6CBJAQrcxaxWlPbp7SUKSAI
         CSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080511; x=1693685311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCdjXlz/JQCmuvXQ01789c2iXr7t5YUpKTlGIJ/Oy+w=;
        b=cdtjZPY6Y7oO5BDAGRmIf+aRgtMxE20sLLDlQWV6twJlvv7xz7LjHgv0+bQqXMLm27
         nB2rI8Gle9TzFzHargw4Q+D1gNlAWbKzH4awvF3yOCaeO2p0Xky6vz4oJPpt8R4qDRlO
         NLjqq95xLaQS+YyppsSlhG1tKGqQfMH0tBFLJyDtL3HVWQLCnWx2nUkBBiDwq1Ue/YGm
         Le2KAhj5aLN3s2rQ1BimEOhfBA3HU/O7DskzD3D1tFSmlv+qhJBlUCuNRE9Mgr5g6qb8
         6ZABvz563J5E/8mzFA69h8OA6DpSbI70SQBB7OqMNEeTVs8XFopjMzRKLKpL6r7XVOTo
         6Hdw==
X-Gm-Message-State: AOJu0YyzBUeHMM8Tw/E+3n1vsjX/UBZGVkuM6lSd/2IMQwjImq1wHopu
        GtieIQnHmLDOQ9RQePJf+x2J8w==
X-Google-Smtp-Source: AGHT+IEg0DL/HLR+9CwukqRsdBqw2gEW+oW5++odzrU3GExLkQ1YgGtZxur/wK0bv532q7cnNFf46A==
X-Received: by 2002:a1c:7718:0:b0:401:b504:b695 with SMTP id t24-20020a1c7718000000b00401b504b695mr4377586wmi.37.1693080511066;
        Sat, 26 Aug 2023 13:08:31 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm5665214wrx.58.2023.08.26.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:08:30 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:08:29 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230826200829.gnha7xcrjbyipjr2@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <7839dd5f-e7fd-7065-934d-436d012ac9d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7839dd5f-e7fd-7065-934d-436d012ac9d6@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/23 18:39, Dietmar Eggemann wrote:
> On 20/08/2023 23:06, Qais Yousef wrote:
> > DVFS headroom is applied after we calculate the effective_cpu_util()
> > which is where we honour uclamp constraints. It makes more sense to
> > apply the headroom there once and let all users naturally get the right
> > thing without having to sprinkle the call around in various places.
> 
> uclamp is applied in effective_cpu_util(..., FREQUENCY_UTIL, ...) which
> IMHO currently has 2 power callers: (1) schedutil: sugov_get_util() and
> (2) EAS: eenv_pd_max_util()
> 
> > Before this fix running
> > 
> > 	uclampset -M 800 cat /dev/zero > /dev/null
> > 
> > Will cause the test system to run at max freq of 2.8GHz. After the fix
> > it runs at 2.2GHz instead which is the correct value that matches the
> > capacity of 800.
> 
> IMHO, a system at util = 800 (w/o uclamp) would also run at 2.8Ghz since
> we would call map_util_to_perf() on 800, no matter from where we call it.

Sorry, I would very strongly disagree here. What you're saying the effective
range of uclamp_max is 800 and anything above that will always go to max. How
can this be acceptable?

> 
> > Note that similar problem exist for uclamp_min. If util was 50, and
> > uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> > constraints, we'll end up with util of 125 instead of 100. IOW, we get
> > boosted twice, first time by uclamp_min, and second time by dvfs
> > headroom.
> 
> I see what you want to change here but:
> 
> So far we have `util -> uclamp -> map_util_to_perf()`

:-O

So when I set the system uclamp_max to 800 it will still run at max; and this
is normal?!!

> 
> which is fine when we see uclamp as an entity which constrains util, not
> the util after being mapped to a capacity constraint.

-ENOPARSE.


Cheers

--
Qais Yousef
