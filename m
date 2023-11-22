Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006D7F42C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjKVJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjKVJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:49:55 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44C2693
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:38 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db406b5ceddso357434276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700646517; x=1701251317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygGpIikdffA3zI0CSmuuy6nPAmKVPCLvFv3JJHDPC+E=;
        b=gAfvNJSWoLkbMqMzI/YXVFmLGb5aBqNH6/wkfVxdHTvi9hcIK/F9rdqB/q6iTEFDVi
         eqgVotjwqGXVLOBCGGYNb2ICRJXFdAF4wvGY6Du8Tly4z5IGpTdt7BcBdkbwKtewpOfv
         RQo5nURaG2j7XjpR9prVU13m8dveW+14a63hVBwlmPufLx6SvrpOWogFMox+QpfGCLCN
         WD4nn9Hxy8IXzW9faZqs5cA03kazH4qsL2m0+FzraG/Lytyr1LLl+PlC6UNEj/nborJ0
         S8U3Wgr7AAbFIXr2Ifsqi4zkCS6bdNZC6p8wmg3fwHRpRhXVKYS57I7I/DDqs656Mrdg
         cN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646517; x=1701251317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygGpIikdffA3zI0CSmuuy6nPAmKVPCLvFv3JJHDPC+E=;
        b=vzsrogQ3IMlsDu3mMtXVAOQ7Iz1vhz7s598KPTr1s3pVl5Bl7NuuysHLBq4+mTw/Cd
         eFcWmGvA5mKJNGSvdw8xX3WavKAX1wqSi2sjvqelq+PZz4j6iM7EwH3oGMZoPb9BLotT
         kPH9qV6ziY4vJEq9Krr6gUFyVuzoo2I0Bq1bQX2OvFcv8yECnX3wPt5kzBgzonRgs4AT
         8xVu/bvtENei366Y8cwiOZ8yF3sfytCP68dJiLEFvfVjpJ+u+ZVzNbXr0b9+0imV8ybK
         YvkN7lkagQAZf56VBfdG1T2XF0boKwXEdE6CRVj/9p4kWcyPQ3JXlIybcyIxhFqKyXgU
         KzHg==
X-Gm-Message-State: AOJu0YwqClbEnHLQudY6f3VXhMSBz1kU3yI4zJ/FXOUL63SkkqEgBUx+
        LVIereGVvgGpOAvCr4aO5dW9hktlcS96opi2GzGSlA==
X-Google-Smtp-Source: AGHT+IHg3xtWznL7RoXEO+Wk8qVQlDpVyn+jAxEz7GbXdU/LSx4+N+Ut3/07i5p33DnA24H7agc2O3KIwSPgMDwgTH4=
X-Received: by 2002:a25:374c:0:b0:db0:6cde:3859 with SMTP id
 e73-20020a25374c000000b00db06cde3859mr1535108yba.41.1700646517145; Wed, 22
 Nov 2023 01:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231114-msm8909-cpufreq-v3-2-926097a6e5c1@kernkonzept.com>
In-Reply-To: <20231114-msm8909-cpufreq-v3-2-926097a6e5c1@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Nov 2023 10:48:01 +0100
Message-ID: <CAPDyKFrwZn1Po+aWwPusjhfoxWoy5qJn4SBK1Csr=280_JPRkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cpufreq: qcom-nvmem: Preserve PM domain votes in
 system suspend
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
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
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
> From the Linux point of view, the power domains used by the CPU must
> stay always-on. This is because we still need the CPU to keep running
> until the last instruction, which will typically be a firmware call that
> shuts down the CPU cleanly.
>
> At the moment the power domain votes (enable + performance state) are
> dropped during system suspend, which means the CPU could potentially
> malfunction while entering suspend.
>
> We need to distinguish between two different setups used with
> qcom-cpufreq-nvmem:
>
>  1. CPR power domain: The backing regulator used by CPR should stay
>     always-on in Linux; it is typically disabled automatically by
>     hardware when the CPU enters a deep idle state. However, we
>     should pause the CPR state machine during system suspend.
>
>  2. RPMPD: The power domains used by the CPU should stay always-on
>     in Linux (also across system suspend). The CPU typically only
>     uses the *_AO ("active-only") variants of the power domains in
>     RPMPD. For those, the RPM firmware will automatically drop
>     the votes internally when the CPU enters a deep idle state.
>
> Make this work correctly by calling device_set_awake_path() on the
> virtual genpd devices, so that the votes are maintained across system
> suspend. The power domain drivers need to set GENPD_FLAG_ACTIVE_WAKEUP
> to opt into staying on during system suspend.
>
> For now we only set this for the RPMPD case. For CPR, not setting it
> will ensure the state machine is still paused during system suspend,
> while the backing regulator will stay on with "regulator-always-on".
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
> This patch can be merged independently from the pmdomain one for RPMPD.
> Both are needed to actually preserve the votes during system suspend but
> there is no compile-time dependency.
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index d239a45ed497..ea05d9d67490 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -23,6 +23,7 @@
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> @@ -426,6 +427,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>         .get_version = qcom_cpufreq_ipq8074_name_version,
>  };
>
> +static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
> +{
> +       const char * const *name = drv->data->genpd_names;
> +       int i;
> +
> +       if (!drv->cpus[cpu].virt_devs)
> +               return;
> +
> +       for (i = 0; *name; i++, name++)
> +               device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
> +}
> +
>  static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
>  {
>         const char * const *name = drv->data->genpd_names;
> @@ -578,11 +591,25 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
>         }
>  }
>
> +static int qcom_cpufreq_suspend(struct device *dev)
> +{
> +       struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
> +       unsigned int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               qcom_cpufreq_suspend_virt_devs(drv, cpu);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, qcom_cpufreq_suspend, NULL);
> +
>  static struct platform_driver qcom_cpufreq_driver = {
>         .probe = qcom_cpufreq_probe,
>         .remove_new = qcom_cpufreq_remove,
>         .driver = {
>                 .name = "qcom-cpufreq-nvmem",
> +               .pm = pm_sleep_ptr(&qcom_cpufreq_pm_ops),
>         },
>  };
>
>
> --
> 2.39.2
>
