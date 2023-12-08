Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE280AE1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjLHUmd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 15:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjLHUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:42:31 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EE171E;
        Fri,  8 Dec 2023 12:42:37 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9d6f8485eso309232a34.0;
        Fri, 08 Dec 2023 12:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702068157; x=1702672957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F//99F/9ZrwtkWvIQbflf74wFg1Bqqbh42D5kCs6IT4=;
        b=kcr2oD8bJkibDNzC3UxrJAzh3BG+k9N1T/q5cU3fbB3N6iJZmqzQtJIYrAIlTGvK8i
         CFc4XMQ/fD/kJgm0ekwjU0CUcXqF8NFj8B9l2kVqdT9DO1k45K9T4PHPGdsjVy1qPFX3
         6NWVlP7k47JfPVa5z8e9JtD+s/Pwi9ozPjhDW02t1turfle2bXJm4EoDJMrl7Z7vTYhy
         290F2aYxpdVeuypE34GhW8imk6/f3zxL7CsmlR+LyVZBJOZiptltdoLMSYjxmiNa/LgS
         gGsySfpWCVU47sZEw9eB+BuDfQRVqvhCqxFTtz+gXdj+Rc9Ya11nLos9XXy5gkNekEb1
         olrg==
X-Gm-Message-State: AOJu0YwIToIDiixVjVyftiEhfBO1fj604/83TMhdz4dyguhtmYzCvh0E
        TClNPjXsJBmLXGJ3jJ41A8SWk7o2InUUx4B8ep4iotkHDxE=
X-Google-Smtp-Source: AGHT+IE7DxLp6suofZuaoZ5h58BK60EAcW2F/cXG9PVuPcnc8EWa9am7lgFlk8Gz08xs/HBwPpxBjlHEvOSWVAU5Uq8=
X-Received: by 2002:a4a:a7c4:0:b0:590:6585:5c41 with SMTP id
 n4-20020a4aa7c4000000b0059065855c41mr1408409oom.0.1702068156758; Fri, 08 Dec
 2023 12:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20231201190757.144741-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231201190757.144741-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Dec 2023 21:42:25 +0100
Message-ID: <CAJZ5v0gNR3AC=fMeipiHNSoOiA0u==_irbQn1r-OJ6aUJ-XBrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] pm_qos: Rename freq to interval constraint
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, caleb.connolly@linaro.org, lina.iyer@linaro.org,
        linux-pm@vger.kernel.org, mani@kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 8:08 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The frequency pm_qos relies on a couple of values, the min and max
> frequencies. However more pm_qos will be added with the same logic of
> a couple of min and max. Instead of writing new set of constraints as
> well as type, etc... let's rename freq_* to a more generic name
> interval_*

I'm fine with a rename if it helps, but I would rather call it range_*
than interval_*.

>
> That way, new qos interval based can be added easily.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/power/qos.c          |  4 +--
>  drivers/powercap/dtpm_cpu.c       |  2 +-
>  drivers/thermal/cpufreq_cooling.c |  2 +-
>  include/linux/cpufreq.h           |  6 ++--
>  include/linux/pm_qos.h            | 55 ++++++++++++++++---------------
>  kernel/power/qos.c                | 53 +++++++++++++++--------------
>  6 files changed, 61 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 8e93167f1783..561d2a0e106c 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -285,14 +285,14 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>                 memset(req, 0, sizeof(*req));
>         }
>
> -       c = &qos->freq.min_freq;
> +       c = &qos->freq.min;
>         plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ,
>                                  PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
>                 memset(req, 0, sizeof(*req));
>         }
>
> -       c = &qos->freq.max_freq;
> +       c = &qos->freq.max;
>         plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ,
>                                  PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 2ff7717530bf..6587c94d0127 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -28,7 +28,7 @@
>
>  struct dtpm_cpu {
>         struct dtpm dtpm;
> -       struct freq_qos_request qos_req;
> +       struct interval_qos_request qos_req;
>         int cpu;
>  };
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index e2cc7bd30862..72e9f0cde55c 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -77,7 +77,7 @@ struct cpufreq_cooling_device {
>  #ifndef CONFIG_SMP
>         struct time_in_idle *idle_time;
>  #endif
> -       struct freq_qos_request qos_req;
> +       struct interval_qos_request qos_req;
>  };
>
>  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..7e2d66c37535 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -80,9 +80,9 @@ struct cpufreq_policy {
>         struct work_struct      update; /* if update_policy() needs to be
>                                          * called, but you're in IRQ context */
>
> -       struct freq_constraints constraints;
> -       struct freq_qos_request *min_freq_req;
> -       struct freq_qos_request *max_freq_req;
> +       struct interval_constraints     constraints;
> +       struct interval_qos_request     *min_freq_req;
> +       struct interval_qos_request     *max_freq_req;
>
>         struct cpufreq_frequency_table  *freq_table;
>         enum cpufreq_table_sorting freq_table_sorted;
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..a662ac918e3e 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -77,25 +77,26 @@ struct pm_qos_flags {
>  #define FREQ_QOS_MIN_DEFAULT_VALUE     0
>  #define FREQ_QOS_MAX_DEFAULT_VALUE     S32_MAX
>
> -enum freq_qos_req_type {
> -       FREQ_QOS_MIN = 1,
> +enum interval_qos_req_type {
> +       INTERVAL_QOS_MIN = 1,
> +       INTERVAL_QOS_MAX,
> +       FREQ_QOS_MIN,
>         FREQ_QOS_MAX,
>  };
>
> -struct freq_constraints {
> -       struct pm_qos_constraints min_freq;
> -       struct blocking_notifier_head min_freq_notifiers;
> -       struct pm_qos_constraints max_freq;
> -       struct blocking_notifier_head max_freq_notifiers;
> +struct interval_constraints {
> +       struct pm_qos_constraints min;
> +       struct blocking_notifier_head min_notifiers;
> +       struct pm_qos_constraints max;
> +       struct blocking_notifier_head max_notifiers;
>  };

Also I would rename min_freq and max_freq to lower_bound and
upper_bound, respectively, because this is less likely to get confused
with other things with the same name.

So the above would be

+struct range_constraints {
+       struct pm_qos_constraints lower_bound;
+       struct blocking_notifier_head lower_bound_notifiers;
+       struct pm_qos_constraints upper_bound;
+       struct blocking_notifier_head upper_bound_notifiers;
};
