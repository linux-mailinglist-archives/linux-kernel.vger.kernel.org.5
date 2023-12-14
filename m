Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C62812E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443855AbjLNLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443917AbjLNLG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:06:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CEE12E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so7091417b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551995; x=1703156795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkFcM58ORD2DTnC5dDqDGqkLUNpEfcQ7GjcBvDad/9k=;
        b=DBL1zKoGQAAJUU8LkqPk3CmA5Izw/fZZxJEmeDoNPHE48FeSZ8KsFewNCS6sk2GPqK
         NOZ6U34jepYTaT7MY5F2VjA6DSMOA36bro2mbZZ2xylUSU9HKZy0IDV0N4uUOAEmFmZK
         P7gfsPrAi5ffogereHikFjh8JErqRGrEMkNzkNkbfEQiTI0txN8OWVThAd/L/wroszJG
         z+CwVBLXNGK9riPo5oMOgV16uTK5Hzgwmnhond+WUukuKjk8qehXXlndczDBxHYEcsWd
         ME8SnhLf4B9VCJrsL0q4xisYZzacVpoxOu0FaZVBukZZR41n0P9X8M6iC9IPTikR/HJa
         YgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551995; x=1703156795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkFcM58ORD2DTnC5dDqDGqkLUNpEfcQ7GjcBvDad/9k=;
        b=Ui4w18yO/RpjMmMkvpW6dWaV0kXW4S3O3UwAtO40HpJDLVMsIRvW0AiXT/62yoVEk1
         DSpA6+PXGIpXn5tnw0nEXxwd1ry+bPX+Je8+0moVyF3ddpYz6xOLKF5RHPCBlLowNtEC
         uKxYTtoT+wwrMOhhtlVDs1I5G624WIosPBcnzFYfU9rPHX9lA9svbf34a/ZrIbHIoLCD
         NPAO1u65KlRjZILod0ngT868wkS7TUds9kANudQ2oobgBc4ac9dBg8IoKulZEgEFsvgV
         WIyZaA60uu+pZaDmWRiaPddzMW5hcMnpWTGy4U2DozhkaPm4qpAoTaennuk4Q8fVubkt
         oE3A==
X-Gm-Message-State: AOJu0YywP+Zum392c70y2cNjfGKu+mqF/Ht5H5b5BdgUUa2mKgLfjC0f
        5PSUGQUBxNyXqx2JVC3vWuT/FxZnDEIekLMKE8XsrQ==
X-Google-Smtp-Source: AGHT+IGybyxiB7nTBs9dM8tY5oppuZjVzJ6FLWefF8o/CeO7/SBsLNR8gOeQrxQdYOWN3qivMYDL4ZJHrfh5hqtPofo=
X-Received: by 2002:a05:6a00:10c1:b0:6cb:a1fe:5217 with SMTP id
 d1-20020a056a0010c100b006cba1fe5217mr10062758pfu.16.1702551994935; Thu, 14
 Dec 2023 03:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org> <af7b67d1-c4a3-44e3-a632-5f0a4ea6eb25@arm.com>
In-Reply-To: <af7b67d1-c4a3-44e3-a632-5f0a4ea6eb25@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 12:06:23 +0100
Message-ID: <CAKfTPtApsWeEbbV03sx8vQTGc3i+oFsAWRNsLnyHjYCSrRMqhg@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the scheduler
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, mhiramat@kernel.org,
        rui.zhang@intel.com, vschneid@redhat.com, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, agross@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org,
        viresh.kumar@linaro.org, sudeep.holla@arm.com, rafael@kernel.org,
        rostedt@goodmis.org, mgorman@suse.de, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 10:20, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/12/23 14:27, Vincent Guittot wrote:
> > Provide to the scheduler a feedback about the temporary max available
> > capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> > filtered as the pressure will happen for dozens ms or more.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
> >   include/linux/cpufreq.h   | 10 ++++++++
> >   2 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..7d5f71be8d29 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
> >   }
> >   EXPORT_SYMBOL(cpufreq_get_policy);
> >
> > +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> > +EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);
>
> Why do we export this variable when we have get/update functions?
> Do we expect modules would manipulate those per-cpu variables
> independently and not like we do per-cpumask in the update func.?

No, I will remove the EXPORT_PER_CPU_SYMBOL_GPL
