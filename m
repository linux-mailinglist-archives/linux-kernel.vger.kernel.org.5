Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F57CF5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjJSKvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjJSKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58559D5C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:50:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso8828719276.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697712640; x=1698317440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7s/8+3r7RFx6yWj1hujuMRvbCyWrWX9uW8mMRBRCYM=;
        b=MeFM5FbIGVnkoFTob4eJMR+iSEl5tnE7VuhJsz/BOv2m5udYpHZosn7KqFp9HkdxYJ
         4QsGduPPzcKJ3QdHDVjIgNNDqVE7h7RM3tXrZzbp0m8qZuuvokt9Tmqsj2k51HJbtfYS
         3XHw6wnKZ/0CydW1EkHDGUy1kxJG4sPSHvpiWGoPlaQnq4vky00N0UOfGrdSwAWPCdkq
         vBN1tAHGnFgdj8uWA6GkPuilA+KIZ9ih0LFVg3GGXdJIcWyH266vBAp5yl0uAGfAW6QG
         WYy47wbp3r0zsfw2Qc1reXj74gFWYbA5lB0shVZ3fK2z0smZ+2kKkItPPDZRjC3euQeU
         ZOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712640; x=1698317440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7s/8+3r7RFx6yWj1hujuMRvbCyWrWX9uW8mMRBRCYM=;
        b=J2f8FOP9nNbIso/gII0Rgfhncfshn8cQtrj78MqCc0yXjn7K0Ci6GoVASUzU4VL38B
         +4tF5oosRA6wKXoyFeuANCXZTjnBQWPsSx2F5goUSRC65SWcau2hbQg79V/GW6onGj8d
         wNXExlYqNGmPOXT0tEi1RgFXwbGdnAueQsAm83zwTEQlfIZfvCCKFSar+iyoIJd64J+v
         lTo6cjQYRRrwPnP9Fof/2LTC0CY9y27ZITJRW+6moNFhsmKAzwVqcpWYRGJS+6Nlf0+l
         vAXyZ9zypcNG6ohfiTFAhMmNu2ez8dvmbB0yBg40quCArrxnOfIYJmjhOO4TBAfioLb4
         FgkQ==
X-Gm-Message-State: AOJu0YwmVtcgtw+fp2ORw6Gm2JRon5ZD23knkNpA2cxjc3LJCq214su2
        4ALaFXAx5mz7wBAI9Mge254Yd5+uvml4bua1Cr+tAg==
X-Google-Smtp-Source: AGHT+IFPxBdsxnQPRHzd8OSMsox5Do9D+FzcetAm0MgZTfWyC44uvU469gyS3vnZSEqmbuBz23jJ3l8V1DLvv2UpspM=
X-Received: by 2002:a25:5d0b:0:b0:d9a:cc6b:70fc with SMTP id
 r11-20020a255d0b000000b00d9acc6b70fcmr1899433ybb.3.1697712639886; Thu, 19 Oct
 2023 03:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com> <20231018-msm8909-cpufreq-v2-3-0962df95f654@kernkonzept.com>
In-Reply-To: <20231018-msm8909-cpufreq-v2-3-0962df95f654@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 12:50:03 +0200
Message-ID: <CAPDyKFruPQhkRyWURkEcMbt_EKdGAqr0j+zYZS-+3-taE+y0+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: Add MSM8909
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
> When the MSM8909 SoC is used together with the PM8909 PMIC the primary
> power supply for the CPU (VDD_APC) is shared with other components to
> the SoC, namely the VDD_CX power domain typically supplied by the PM8909
> S1 regulator. This means that all votes for necessary performance states
> go via the RPM firmware which collects the requirements from all the
> processors in the SoC. The RPM firmware then chooses the actual voltage
> based on the performance states ("corners"), depending on calibration
> values in the NVMEM and other factors.
>
> The MSM8909 SoC is also sometimes used with the PM8916 or PM660 PMIC.
> In that case there is a dedicated regulator connected to VDD_APC and
> Linux is responsible to do adaptive voltage scaling using CPR (similar
> to the existing code for QCS404).
>
> This difference can be described in the device tree, by either assigning
> the CPU a power domain from RPMPD or from the CPR driver.
>
> Describe this using "perf" as generic power domain name, which is also
> used already for SCMI based platforms.
>
> Also add a simple function that reads the speedbin from a NVMEM cell
> and sets it as-is for opp-supported-hw. The actual bit position can be
> described in the device tree without additional driver changes.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 3794390089b0..e52031863350 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -59,6 +59,24 @@ struct qcom_cpufreq_drv {
>
>  static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>
> +static int qcom_cpufreq_simple_get_version(struct device *cpu_dev,
> +                                          struct nvmem_cell *speedbin_nvmem,
> +                                          char **pvs_name,
> +                                          struct qcom_cpufreq_drv *drv)
> +{
> +       u8 *speedbin;
> +
> +       *pvs_name = NULL;
> +       speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
> +       if (IS_ERR(speedbin))
> +               return PTR_ERR(speedbin);
> +
> +       dev_dbg(cpu_dev, "speedbin: %d\n", *speedbin);
> +       drv->versions = 1 << *speedbin;
> +       kfree(speedbin);
> +       return 0;
> +}
> +
>  static void get_krait_bin_format_a(struct device *cpu_dev,
>                                           int *speed, int *pvs, int *pvs_ver,
>                                           u8 *buf)
> @@ -252,6 +270,8 @@ static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>         return 0;
>  }
>
> +static const char *generic_genpd_names[] = { "perf", NULL };
> +

As discussed, using "perf" as a generic name for a performance domain
for CPUs makes perfect sense to me. However, we need to update the DT
doc bindings for this too. At least we should update
Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml as a
part of $subject series.

At a later step, we should have a look at updating the description for
the power-domain-names in the common
Documentation/devicetree/bindings/arm/cpus.yaml, I think.

>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>         .get_version = qcom_cpufreq_kryo_name_version,
>  };
> @@ -260,6 +280,11 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
>         .get_version = qcom_cpufreq_krait_name_version,
>  };
>
> +static const struct qcom_cpufreq_match_data match_data_msm8909 = {
> +       .get_version = qcom_cpufreq_simple_get_version,
> +       .genpd_names = generic_genpd_names,
> +};
> +
>  static const char *qcs404_genpd_names[] = { "cpr", NULL };
>
>  static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> @@ -434,6 +459,7 @@ static struct platform_driver qcom_cpufreq_driver = {
>
>  static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>         { .compatible = "qcom,apq8096", .data = &match_data_kryo },
> +       { .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
>         { .compatible = "qcom,msm8996", .data = &match_data_kryo },
>         { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>         { .compatible = "qcom,ipq8064", .data = &match_data_krait },
>
> --
> 2.39.2
>

Other than the above, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
