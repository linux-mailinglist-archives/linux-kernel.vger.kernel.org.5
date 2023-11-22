Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E37F42C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKVJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjKVJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:49:53 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268B2135
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:34 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5c8c26cf056so51369557b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700646513; x=1701251313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PK84ms7FIdVTsWWVQYLYZx3PA5nxXbNykyMrmNGcMno=;
        b=KNQRS8NL8IsmuTVzFZwfYdbMjbi3vDIsR2prWjyS9ZlkFqPbXaAzwTzmD6R7Wa0GSz
         EFAJLT8iy+E47G4w/adtkViXdXQzScJmiK/Qn8wp8cJKdiZAt64r/xYjqT3QcCyKUL2Y
         CtbPsW4Xs8vN2g2tzVLsQY9dlnzmciwdsf4v8baxluBe0db4tvRjHEug0ZlrD4J0x0kO
         O6VLCTV4cSjN0uWbyRXRu2TmuZKaZHsre6XiDduFtPIS37w3uz1EP+dLAfH3qTpuzM+F
         engiaK/xea8F1cmVVXu0PPZ3B14TRDJHjh6EEncxUDUyEmtLLSR499/GJuXgr15I6JQW
         jC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646513; x=1701251313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK84ms7FIdVTsWWVQYLYZx3PA5nxXbNykyMrmNGcMno=;
        b=qDyhO86qDCaBIxkFFAwMWF5MWm/p68updAIjm34Po674LXFa+QhpKMaKFugtsL1Bnu
         sSepzC+cgP/1izHHSzsfRfyEpgT2tMBi0S+qSQ0YJ+owxuoYSy+FvoKZw01MUdBKxDqq
         l3b12es8373NwTC8ifXLBSPWh73DrTO3fX3UbodnHcdaZ5I8OluBysvqt3qfKTW5yiYd
         JjCB2KQz7SgkQK/fQVjEUQwu5te0aqGvoNjJqOdhKaJVfZ33/t8s77VsZPWPyfA+2z7w
         i/VuJuLqz/WuKH2N6CnzJA+QBAcVWun4jCFkL2clNjYvNLwMcASR/zF1FVc8Zfo0cq3w
         sAeg==
X-Gm-Message-State: AOJu0YzTUcrh32lyUil8IGFOWI3L3ONK71pcjOlTTIyY+/LmEVgHqYQh
        wrKBawx+TFgBMbxvo3Nikpv8XOKV+1KEzjXsB6wBiw==
X-Google-Smtp-Source: AGHT+IHdTV/0/uZlSh9c9qAIbY49um8FRdZxhgynjgw4EjeHTUqDJf8dzPOKOyax7hcrRcwOpVSAULDyg7MeFztEyxc=
X-Received: by 2002:a25:c547:0:b0:db3:8b55:1951 with SMTP id
 v68-20020a25c547000000b00db38b551951mr1542151ybe.63.1700646513271; Wed, 22
 Nov 2023 01:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231114-msm8909-cpufreq-v3-1-926097a6e5c1@kernkonzept.com>
In-Reply-To: <20231114-msm8909-cpufreq-v3-1-926097a6e5c1@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Nov 2023 10:47:56 +0100
Message-ID: <CAPDyKFqa2U3g-7xVjxmsiYHsxujvJc0QCXWXHxPZAQR0ZJJo8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 11:08, Stephan Gerhold
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
> Fix this by enabling the devices after attaching them.
>
> Without this fix performance states votes are silently ignored, and the
> CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> for some reason no one noticed this on QCS404 so far.
>
> Cc: stable@vger.kernel.org
> Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 46 +++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 6355a39418c5..d239a45ed497 100644
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
> @@ -55,6 +56,7 @@ struct qcom_cpufreq_match_data {
>
>  struct qcom_cpufreq_drv_cpu {
>         int opp_token;
> +       struct device **virt_devs;
>  };
>
>  struct qcom_cpufreq_drv {
> @@ -424,6 +426,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>         .get_version = qcom_cpufreq_ipq8074_name_version,
>  };
>
> +static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
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
> @@ -478,6 +492,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         of_node_put(np);
>
>         for_each_possible_cpu(cpu) {
> +               struct device **virt_devs = NULL;
>                 struct dev_pm_opp_config config = {
>                         .supported_hw = NULL,
>                 };
> @@ -498,7 +513,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>
>                 if (drv->data->genpd_names) {
>                         config.genpd_names = drv->data->genpd_names;
> -                       config.virt_devs = NULL;
> +                       config.virt_devs = &virt_devs;
>                 }
>
>                 if (config.supported_hw || config.genpd_names) {
> @@ -509,6 +524,27 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
> +                       }
> +                       drv->cpus[cpu].virt_devs = virt_devs;
> +               }
>         }
>
>         cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> @@ -522,8 +558,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
> @@ -534,8 +572,10 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
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
