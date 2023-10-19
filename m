Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6D7CF51F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbjJSKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjJSKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:25:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99712D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:24:58 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7eef0b931so95966687b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697711097; x=1698315897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gUZeb0jKJJtlyWUIyBlImNnt+JsfVfhEYz3giXl9GK4=;
        b=rREWxOlM9g3ay2zIZ3oLts2zMVCD3kO7bBZ9nMPrTAvDojb5XYZMHKZbbFekI5nUwI
         6c7Ok3nnuAfXgC2xIK8pDwADsjQYhI0OWlD8LA+IVYdOFIF5dLZwh5/+9AXRHVjsbDrt
         IockE7zLQhxYTZ939YteA4NamOdOOBRrKLWKfxVSoAZqEjTNgagIERBajAbhLLuElFZC
         No05RNG02PKwKO3xoOho3C/Ih3ffHL9TxtExz49MwXFabcP9DHjrpp95XpSOX7Rh7cP8
         Xf68LKlCXE/cfb8kFEri+DOATQ7p2Uf7ZRWdfGIdX7NGv3ZjTtuMPEfv3u0q2SubN0p3
         paaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711097; x=1698315897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUZeb0jKJJtlyWUIyBlImNnt+JsfVfhEYz3giXl9GK4=;
        b=n4LGOmldiB5t5Y/8QEpjfI06egkoxHvdfi6QEjJ80XmL144ENWBU6zH9ojWRakI8el
         vVbBnwKTmOo2roW5Unis8UBrNc4pgHThMnJrYiU5BkN7XaaU7Om80ifDL95Tm2STo6cr
         pzAXaORIV1M7ipuAxojlYteDxuJLIh8yt1zwdsZ0tuHAqsTFhL1mCZemHj7O4obco/ro
         g9NNWOQE7bBK4k+PlyheV85z25dH3NRlYhlwKcoj/PxQuth8tQDdRiUOrPttqWSRP/kf
         OaFNGOhvNCNdNkiGAr/I9ooLX58U3pcGH3021cqG4dmDslDvByWDOhtBr4yzKWe7Dnoz
         RIjQ==
X-Gm-Message-State: AOJu0YwqrGDy/sTULdOvLJduGb4lGVgg3vCO/gq3uWXJJs83HJsFdsXJ
        hK6E27fimGwym7bhf0945OUQBx0cf/xecyD3MtYRXQ==
X-Google-Smtp-Source: AGHT+IG3U91pn35gIMk/Vq4gvaPipHWqVQVRkkFkCZcPQu2WHiqMSphaji7MC775+JS3hurbXo66wbnl/P6oFsyG/oU=
X-Received: by 2002:a25:ac1c:0:b0:d9a:c4cf:a066 with SMTP id
 w28-20020a25ac1c000000b00d9ac4cfa066mr2011553ybi.34.1697711097377; Thu, 19
 Oct 2023 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com> <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
In-Reply-To: <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 12:24:21 +0200
Message-ID: <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
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
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> The genpd core caches performance state votes from devices that are
> runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> runtime PM performance state handling"). They get applied once the
> device becomes active again.
>
> To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> devices that use runtime PM only to control the enable and performance
> state for the attached power domain.
>
> However, at the moment nothing ever resumes the virtual devices created
> for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> means that performance state votes made during cpufreq scaling get
> always cached and never applied to the hardware.
>
> Fix this by enabling the devices after attaching them and use
> dev_pm_syscore_device() to ensure the power domains also stay on when
> going to suspend. Since it supplies the CPU we can never turn it off
> from Linux. There are other mechanisms to turn it off when needed,
> usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).

I believe we discussed using dev_pm_syscore_device() for the previous
version. It's not intended to be used for things like the above.

Moreover, I was under the impression that it wasn't really needed. In
fact, I would think that this actually breaks things for system
suspend/resume, as in this case the cpr driver's genpd
->power_on|off() callbacks are no longer getting called due this,
which means that the cpr state machine isn't going to be restored
properly. Or did I get this wrong?

Kind regards
Uffe

>
> Without this fix performance states votes are silently ignored, and the
> CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> for some reason no one noticed this on QCS404 so far.
>
> Cc: stable@vger.kernel.org
> Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 +++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 82a244f3fa52..3794390089b0 100644
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
> @@ -47,6 +48,7 @@ struct qcom_cpufreq_match_data {
>
>  struct qcom_cpufreq_drv_cpu {
>         int opp_token;
> +       struct device **virt_devs;
>  };
>
>  struct qcom_cpufreq_drv {
> @@ -268,6 +270,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>         .get_version = qcom_cpufreq_ipq8074_name_version,
>  };
>
> +static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned cpu)
> +{
> +       const char * const *name = drv->data->genpd_names;
> +       int i;
> +
> +       if (!drv->cpus[cpu].virt_devs)
> +               return;
> +
> +       for (i = 0; *name; i++, name++)
> +               pm_runtime_put(drv->cpus[cpu].virt_devs[i]);
> +}
> +
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
>         struct qcom_cpufreq_drv *drv;
> @@ -321,6 +335,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         of_node_put(np);
>
>         for_each_possible_cpu(cpu) {
> +               struct device **virt_devs = NULL;
>                 struct dev_pm_opp_config config = {
>                         .supported_hw = NULL,
>                 };
> @@ -341,7 +356,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>
>                 if (drv->data->genpd_names) {
>                         config.genpd_names = drv->data->genpd_names;
> -                       config.virt_devs = NULL;
> +                       config.virt_devs = &virt_devs;
>                 }
>
>                 if (config.supported_hw || config.genpd_names) {
> @@ -352,6 +367,30 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>                                 goto free_opp;
>                         }
>                 }
> +
> +               if (virt_devs) {
> +                       const char * const *name = config.genpd_names;
> +                       int i, j;
> +
> +                       for (i = 0; *name; i++, name++) {
> +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> +                               if (ret) {
> +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> +                                               *name, ret);
> +
> +                                       /* Rollback previous PM runtime calls */
> +                                       name = config.genpd_names;
> +                                       for (j = 0; *name && j < i; j++, name++)
> +                                               pm_runtime_put(virt_devs[j]);
> +
> +                                       goto free_opp;
> +                               }
> +
> +                               /* Keep CPU power domain always-on */
> +                               dev_pm_syscore_device(virt_devs[i], true);
> +                       }
> +                       drv->cpus[cpu].virt_devs = virt_devs;
> +               }
>         }
>
>         cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> @@ -365,8 +404,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         dev_err(cpu_dev, "Failed to register platform device\n");
>
>  free_opp:
> -       for_each_possible_cpu(cpu)
> +       for_each_possible_cpu(cpu) {
> +               qcom_cpufreq_put_virt_devs(drv, cpu);
>                 dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
> +       }
>         return ret;
>  }
>
> @@ -377,8 +418,10 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
>
>         platform_device_unregister(cpufreq_dt_pdev);
>
> -       for_each_possible_cpu(cpu)
> +       for_each_possible_cpu(cpu) {
> +               qcom_cpufreq_put_virt_devs(drv, cpu);
>                 dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
> +       }
>  }
>
>  static struct platform_driver qcom_cpufreq_driver = {
>
> --
> 2.39.2
>
