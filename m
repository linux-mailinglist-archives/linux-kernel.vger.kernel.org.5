Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFD79E576
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjIMK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbjIMK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:56:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F4C19BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:56:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso6269851276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694602612; x=1695207412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwE1tmf8tdsVndAPixE3ADwa0SejCshFVF56S6gRoMI=;
        b=WCQXmB1hdPdLx5jg0szCrHGf6etQvVp/GH6OiQhVKWDk2f9gOXz59D4+IX4d0uNBIq
         JJcWt6f/NKBJViDo66x2f6P8Sank123ToXsHQqw6uztKyDy67lfpHqqnMp2DZLs3VVUc
         iCZoUR2N/NS7dOvWZfpOreZFTqPuodaZoyG2YbZF34CrXAseZE670N1hvjca/Wu0GhZO
         hU2xKL1Z5JgW0PqVxJyIh6n0h2xDyi5jzuZaRf5M0b4l/hqJU860bLmmNmHIKbqp2QbE
         fdUNEL0bR9xTX5+O9f9mdlyWGjPEVa38O+y9nAG9pmZQa81LaIzxaYdzAP0lrRJf8+LK
         hlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602612; x=1695207412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwE1tmf8tdsVndAPixE3ADwa0SejCshFVF56S6gRoMI=;
        b=dwphX5mJzLgxfU11N52VTLy6zSINXVptfNw9E3s+CcJJsZIiSr5vBpzO5A0I5y0oeS
         tJxnmTVNFF/GdswEBZ/FUQ8KgVoNRz8wMAxW4HBiau+wv5FfJRwPtB7gIixGbxYuHWU2
         4PjYUnxKBi9FPny9NKFsb7WR69o5f3CbRU2THxbGQB4il5ed3IEby+mw9u9fugLgpP98
         k8atAI8Rzzl46xF38UWfOADLDgAODm69gKk/XKuzPNQB8rRVQffyi/n1PWsWrJTsHMXk
         PKmCqdRUW9kpjF1ZE2c799yh6e6r9LiNHNcvLHJnTsqfRK7MY/O4g/O0/htcWF4RM9dw
         KuUQ==
X-Gm-Message-State: AOJu0YzP5p6R2nidgx0uVrUd1dw3Go4y1wrnbjUboPhs5oxl3KOXNVOd
        BmJ4gC2+l+jJzbMMsdYNE38fHscOxHgoA5qzuqfCmA==
X-Google-Smtp-Source: AGHT+IHMAuFyyQ4cRNYR0B8xdSCeM68K8IjuOrh8tk9MNlECb4FiuI3ryuFikGYu8jUtCFCGET9Y3RPflWwbyZQSia0=
X-Received: by 2002:a5b:308:0:b0:d7f:f5e:a2bd with SMTP id j8-20020a5b0308000000b00d7f0f5ea2bdmr1911637ybp.10.1694602612496;
 Wed, 13 Sep 2023 03:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com> <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
In-Reply-To: <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Sep 2023 12:56:16 +0200
Message-ID: <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 11:40, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> The genpd core ignores performance state votes from devices that are
> runtime suspended as of commit 5937c3ce2122 ("PM: domains: Drop/restore
> performance state votes for devices at runtime PM").

I think you are referring to the wrong commit above. Please have a
look at commit 3c5a272202c2 ("PM: domains: Improve runtime PM
performance state handling"), instead.

I also suggest rephrasing the above into saying that the performance
state vote for a device is cached rather than carried out, if
pm_runtime_suspended() returns true for it.

Another relevant information in the commit message would be to add
that during device-attach (genpd_dev_pm_attach_by_id()), calls
pm_runtime_enable() the device.

> However, at the
> moment nothing ever enables the virtual devices created in
> qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
> permanently runtime-suspended.
>
> Fix this by enabling the devices after attaching them and use
> dev_pm_syscore_device() to ensure the power domain also stays on when
> going to suspend. Since it supplies the CPU we can never turn it off
> from Linux. There are other mechanisms to turn it off when needed,
> usually in the RPM firmware or the cpuidle path.
>
> Without this fix performance states votes are silently ignored, and the
> CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> for some reason no one noticed this on QCS404 so far.
>
> Cc: stable@vger.kernel.org
> Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 84d7033e5efe..17d6ab14c909 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>
> @@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         }
>
>         for_each_possible_cpu(cpu) {
> +               struct device **virt_devs = NULL;
>                 struct dev_pm_opp_config config = {
>                         .supported_hw = NULL,
>                 };
> @@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>
>                 if (drv->data->genpd_names) {
>                         config.genpd_names = drv->data->genpd_names;
> -                       config.virt_devs = NULL;
> +                       config.virt_devs = &virt_devs;
>                 }
>
>                 if (config.supported_hw || config.genpd_names) {
> @@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>                                 goto free_opp;
>                         }
>                 }
> +
> +               if (virt_devs) {
> +                       const char * const *name = config.genpd_names;
> +                       int i;
> +
> +                       for (i = 0; *name; i++, name++) {
> +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> +                               if (ret) {
> +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> +                                               *name, ret);
> +                                       goto free_opp;
> +                               }

Shouldn't we restore the usage count at ->remove() too?

> +
> +                               /* Keep CPU power domain always-on */
> +                               dev_pm_syscore_device(virt_devs[i], true);

Is this really correct? cpufreq is suspended/resumed by the PM core
during system wide suspend/resume. See dpm_suspend|resume(). Isn't
that sufficient?

Moreover, it looks like the cpr genpd provider supports genpd's
->power_on|off() callbacks. Is there something wrong with this, that I
am missing?


> +                       }
> +               }
>         }
>
>         cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>

Kind regards
Uffe
