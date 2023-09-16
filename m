Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309E7A322C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjIPTZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjIPTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:25:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9114139
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:25:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso3057882f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694892311; x=1695497111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YemuLAkzZ3mwS+fKbYUx0+x9FMVINu37w9byNNYEGG4=;
        b=SZmRlQSw8lHgDamtJo31qQUNjwJXNnvvu+2ZwlyXUo1fneAwRHsaxxjuxAKvnZez1P
         IEGyDIpZD6MuzAXN75Xrxthk14Y/Y7MSvVGonhWOEtQtgyL4L07WuWJh0oLcPGNIuyCV
         PdosSY5owA4lo7lL7gS+OOuyrS3fv7ZyssPcVD9Dh6RVPb3YgeF4P7CpXhXjL219BK6L
         t587mm6XKGaY+xk8VE+/HvsJo1L4QRPSZg84pbK9PSLD+jtkoV3SXZapNdFULK8CZU4e
         X1V6ycKYscQ+gYMY50OZzlXFj0gAPxh3KV2n8lM0jF1phRMmOOS6V7tnlW+oNzH22ejo
         IRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694892311; x=1695497111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YemuLAkzZ3mwS+fKbYUx0+x9FMVINu37w9byNNYEGG4=;
        b=Mtp5gRDwzrSIYfkgDXZ/h90XmZXj33OofaO/SdSsgwYbXv8efpcOCJXbQwx1vZYpgD
         P7Z7KZzt1OwFuUF7wvldYGFpp9fvOIX/uV0LHKdq5WiHqmSznCEV/sQe7fCi7Z6dwugn
         oUwI8mffVyaNEoFMT/LnMV5AkKXQnCVaO5TB/oGLBwrcsOE2Onhs3sj912ZFBbiPK3tq
         MdWkUyJIA7k0UsPZ3ReQtKbUJNGXCEH2zh/oTP94VvpNhnDjBAuYG54tdFd4ghhQkUT/
         NNHD74NAtNuZVFZ7phInuOilPhnLsGs+WhHbOyLPk/9gKApVVJtZScE/cDSPiUhaQ66k
         hgkw==
X-Gm-Message-State: AOJu0YxdxgGQthQ31u3CGLO29FnlpNzrmV1Y9CWo1UEdMivBkDjZxqp6
        IU6HRGFmZmxTehkfZDtxcJ/rHw==
X-Google-Smtp-Source: AGHT+IEADZZw7fcsDZqrMKnoBmJ/kcuGy+M7Cc95Kv1zTWEp0tRpiLumIFPEG3KXk41Wctm0QnIXoA==
X-Received: by 2002:a05:6000:1549:b0:320:a4e:acf8 with SMTP id 9-20020a056000154900b003200a4eacf8mr303880wry.48.1694892311265;
        Sat, 16 Sep 2023 12:25:11 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id n9-20020adfe789000000b003180fdf5589sm3500322wrm.6.2023.09.16.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:25:10 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:25:09 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230916192509.bportepj7dbgp6ro@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/23 18:03, Vincent Guittot wrote:

> And it seems that what is done today doesn't work correctly for you.
> Your proposal to include cpufreq headroom into the scheduler is not
> correct IMO and it only applies for some cases. Then, the cpufreq
> driver can have some really good reason to apply some headroom even
> with an uclamp value but it can't make any decision.
> 
> I think that we should use another way to fix your problem with how
> uclamp than reordering how headroom is applied by cpufreq. Mixing
> utilization and performance in one signal hide some differences that
> cpufreq can make a good use of.
> 
> As an example:
> 
> cfs util = 650
> cfs uclamp = 800
> irq = 128
> 
> cfs with headroom 650*1.25=812 is clamped to 800
> 
> Final utilization will be : 800(1024-128)/1024+128*1.25=860 which is
> above the target of 800.
> 
> When we look at the detail, we have:
> 
> cfs util once scaled to the full range is only 650(1024-128)/1024= 568
> 
> After applying irq (even with some headroom) 568+128*1.25 = 728 which
> is below the uclamp of 800 so shouldn't we stay at 800 in this case ?

Shouldn't it be (568+128)*1.25 = 870? Which is almost the 860 above. We calmped
the 812 to 800, with rounding errors that almost accounts for the 10 points
difference between 870 and 860..

I might have gotten the math wrong. But what I saw is that we have

	util = (X + Y + Z) * A

and what I did

	util = AX + AY + AZ

so maybe I missed something up, but I just did the multiplication with the
headroom to each element individually rather than after the sum.

So yeah, if I messed that part up, then that wasn't intentional and should be
done differently. But I still can't see it.

> >
> > The main change being done here actually is to apply_dvfs_headroom() *before*
> > doing uclamp_rq_util_with(). I am not sure how you see this mixing.
> 
> Because dvfs_headroom is a cpufreq hints and you want to apply it
> somewhere else.

I am still not sure if you mean we are mixing up the code and we need better
abstraction or something else.

Beside the abstraction problem, which I agree with, I can't see what I am
mixing up yet :( Sorry I think I need more helping hand to see it.

> > Current code performs apply_dvfs_headroom() *after*; which what causes the CPU
> > to run at a performance level higher than rq->uclamp[UCLAMP_MAX].
> >
> > It doesn't matter how many tasks on the rq, if rq->uclamp[UCLAMP_MAX] is set to
> > 800, then the CPU should not vote to max (assuminig all other pressures are 0).
> 
> You can't remove the irq pressure from the picture. If
> rq->uclamp[UCLAMP_MAX] is set to 800 means that cpu must not go above
> 800, it should apply also after taking into account other inputs. At
> least up to some level as described in my example above

I was trying to simplify to understand what you mean as I don't think I see the
problem you're highlighting still.


Thanks!

--
Qais Yousef
