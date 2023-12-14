Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D2812ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443436AbjLNIyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:54:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF8109
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so5112057b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702544085; x=1703148885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=Lfc5doqQYTSO3iZ1t4glMeEIbfVbUgGoDBdKF3BfalCUJ0aPbMhz6RzCxzXr45+Ycq
         H2xe/iBBS60GUA/r8+xa8d23GshQlyxXvPh9ON1b8rVSVRzdnS0snp4+BowcKqZum/v9
         HF3TUphGcgwAxCoEbMIcBtoKUFUWDTtFtR517N74ZJ2DhqtlfKqYyqYYQUDeRYE1irqj
         XDypx8kr88tXxGzrbakIO9JDQlHf6swdCrVAZxzw0rze4WkuCxpC9AHGdMsEwqcaLdgr
         ENBl2ZtxulWz+6NN+Mviwh1Ig1pUBBdZT3PSgG66nJWRDh9L5SErQbaqsh0RZ4d6Zc0s
         kw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544085; x=1703148885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=B07+p9t3h4fuq666X4tghknmW4lucKmH9SAACNlyiPbw7Qy2HX0r/ohz7UUpkSh8mZ
         bmoQaJ0KKnzSQSUCkFUdvdW01PPjLR70b6eEY4vLEkVbZG1MDz87ECkZBkhWeddUSPEF
         XoSpOqi57PjAjyrmxre1p0j9Uex0cOcLo1FedDoR59D1GiPgTWs4ex7Y1fOZkaQaBScf
         mPfgbc0k2tB3I+zCXXbvIneZ1YT1uLr++fuPgpWtrt7n/Ad/2YNXVf17yrE50wcfm3zA
         d7U1xrSfvNi0iBE0+Mp2B6orQCTUjCD06HTlnxLkTXjB3oO4YDgGGup/vDG/yGqd2Vku
         wksQ==
X-Gm-Message-State: AOJu0YzxJhHaWQYVYraOm6/gcZKv38MEgEcdnn3NlNbPEqSprniQSUSp
        zOcOX/mbZBCkvJf+NEF2U0RoKYyBMRbTgoCRRNC3tQ==
X-Google-Smtp-Source: AGHT+IGdI7/50FpKOUbpLtBvbGRJ2DilAJ+uakzY6Pk1C1l4dP/sR7vPujANsmVVA5EQ4ejpPjKjBk8CHE5FPrBpAJg=
X-Received: by 2002:a05:6a00:3a1d:b0:6d0:8b0d:b8c6 with SMTP id
 fj29-20020a056a003a1d00b006d08b0db8c6mr3981164pfb.34.1702544085168; Thu, 14
 Dec 2023 00:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-5-vincent.guittot@linaro.org> <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
 <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com> <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
In-Reply-To: <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 09:54:34 +0100
Message-ID: <CAKfTPtAU2ryefu-4cJ7YSV6Ji8Xofa-6=yAZ+EmUJ+qbsFCfZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     catalin.marinas@arm.com, bristot@redhat.com,
        linux-pm@vger.kernel.org, juri.lelli@redhat.com, agross@kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-trace-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, rostedt@goodmis.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bsegall@google.com,
        vschneid@redhat.com, will@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, mhiramat@kernel.org,
        amit.kachhap@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 09:53, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/14/23 08:36, Vincent Guittot wrote:
> > On Thu, 14 Dec 2023 at 09:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >> On 12/12/23 14:27, Vincent Guittot wrote:
>
> [snip]
>
> >>>        update_rq_clock(rq);
> >>> -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> >>> -     update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> >>> +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> >>> +     update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> >>
> >> We switch to task clock here, could you tell me why?
> >> Don't we have to maintain the boot command parameter for the shift?
> >
> > This should have been part of the patch5 that I finally removed. IMO,
> > the additional time shift with rq_clock_thermal is no more needed now
> > that we have 2 separates signals
> >
>
> I didn't like the left-shift which causes the signal to converge slowly.
> I rather wanted right-shift to converge (react faster), so you have my
> vote for this change. Also, I agree that with the two-signal approach
> this shift trick can go away now. I just worry about the dropped boot
> parameter.
>
> So, are going to send that patach5 which removes the
> 'sched_thermal_decay_shift' and documentation bit?

Yes, i will add it back for the next version
