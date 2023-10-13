Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C57C8C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjJMRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:25:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08EB7;
        Fri, 13 Oct 2023 10:25:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so949582b3a.2;
        Fri, 13 Oct 2023 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697217918; x=1697822718; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgaM3QtGGFd/TcGVn8yUwV6WpXNANxvFM+VK5g14yqE=;
        b=hygcx8nwNwHhY6kN56kkAQ+V9uDLIMGD40KSd3eLKsn35Juqoi3yNjD2SppvZtrKnZ
         ZkzscSZY1po5QLwXywomt0yFxOnCuWJiZ+Ns4i0hoieFTwJcBkz/DKWRZvtVeeAxdqCI
         a8knWDzUDk5b4k2PA5tGh+KavXjriFyhGRWEeDsMQ/9TAej5k0MMJAWM3Fbi9ueP/piR
         ubriSFt+bCaN/ZDYYYAp3bJdYgarCMEdoVQ4O41fRhDjYdXNHXqOtP5NOLl8Iu4MKgvM
         Pg98iNRyQh0lQhk4hJ5dFpES/K4oEJUkkL9K9yO7Z6isx9GAstVAVPyWQYxe7YDLfJqI
         dDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697217918; x=1697822718;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgaM3QtGGFd/TcGVn8yUwV6WpXNANxvFM+VK5g14yqE=;
        b=Qr3NDSWbK3pqinokcfACPJ9uM6KcJtKNj0Wzk7Hp0IncGFFflOSM9Mx4j9bkMqMbjx
         uqldD4Mm75ig2w9ui6ihGLlawthrGs4zhCwjsK3TPTjGBZed32KL5dygx8XKC5wwv5zC
         v4YQo0Dpm/3PIDRBT8EQG8q67qBJ/Ajv6gCNq/Ip1ML7PtgAnE8tZLU95KN+vQmCMr/A
         n/hWP0slw1FgA/QBjz5EU1icgMO/3XsoJ9FWrJH8b12GW+Dgs+dSsPs1dafIUaNsY5cX
         l5PO8hFgZ/t4ErdBgDR7cmYi+KLbqL2hHw5uOyWoHnjnRnedm7TowcAAcJNwU6EZhjOd
         ePRQ==
X-Gm-Message-State: AOJu0YxjAEtuRVTbMd466nVLeRQVRinjiUdm1btIL+LpX4mH8NpxFCZ+
        z+bZGwO4UDaVD5MFmjzM4rumqhW/0j0G5gR7nWB5489+7qs=
X-Google-Smtp-Source: AGHT+IGUbf4jIWHSqeZ+KWNrCqCUoKTe662vch9t3yq9Tjy5dFVO05voGC6DkpvefGpr6PnLfR1Z/w5qLKrE2E3ogLc=
X-Received: by 2002:a05:6a20:7485:b0:15e:e0fd:98e7 with SMTP id
 p5-20020a056a20748500b0015ee0fd98e7mr32333011pzd.20.1697217917776; Fri, 13
 Oct 2023 10:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231013172033.3549476-1-robimarko@gmail.com>
In-Reply-To: <20231013172033.3549476-1-robimarko@gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 13 Oct 2023 19:25:06 +0200
Message-ID: <CAOX2RU5Zg_QUkKmEWzO-OkX68-sJxbfmpa21yYjkETW27Mf8KA@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
To:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 19:20, Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ8074 comes in 3 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
>
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
>
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v6:
> * Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.

I discussed this with Christian and we decided to split out IPQ8074 as
it is much simpler
than IPQ8064 and has no additional dependencies so it makes sense split it out.

Regards,
Robert
>
> Changes in v4:
> * Add support for IPQ8174 (Oak) family
>
> Changes in v3:
> * Use enum for SoC versions
>
> Changes in v2:
> * Print an error if SMEM ID is not part of the IPQ8074 family
> and restrict the speed to Acorn variant (1.4GHz)
>
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 48 ++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 0b3776f558db..675da7f36846 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -181,6 +181,7 @@ static const struct of_device_id blocklist[] __initconst = {
>         { .compatible = "ti,am62p5", },
>
>         { .compatible = "qcom,ipq8064", },
> +       { .compatible = "qcom,ipq8074", },
>         { .compatible = "qcom,apq8064", },
>         { .compatible = "qcom,msm8974", },
>         { .compatible = "qcom,msm8960", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 84d7033e5efe..3fa12648ceb6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -30,6 +30,11 @@
>
>  #include <dt-bindings/arm/qcom,ids.h>
>
> +enum ipq8074_versions {
> +       IPQ8074_HAWKEYE_VERSION = 0,
> +       IPQ8074_ACORN_VERSION,
> +};
> +
>  struct qcom_cpufreq_drv;
>
>  struct qcom_cpufreq_match_data {
> @@ -203,6 +208,44 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>         return ret;
>  }
>
> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> +                                            struct nvmem_cell *speedbin_nvmem,
> +                                            char **pvs_name,
> +                                            struct qcom_cpufreq_drv *drv)
> +{
> +       u32 msm_id;
> +       int ret;
> +       *pvs_name = NULL;
> +
> +       ret = qcom_smem_get_soc_id(&msm_id);
> +       if (ret)
> +               return ret;
> +
> +       switch (msm_id) {
> +       case QCOM_ID_IPQ8070A:
> +       case QCOM_ID_IPQ8071A:
> +       case QCOM_ID_IPQ8172:
> +       case QCOM_ID_IPQ8173:
> +       case QCOM_ID_IPQ8174:
> +               drv->versions = BIT(IPQ8074_ACORN_VERSION);
> +               break;
> +       case QCOM_ID_IPQ8072A:
> +       case QCOM_ID_IPQ8074A:
> +       case QCOM_ID_IPQ8076A:
> +       case QCOM_ID_IPQ8078A:
> +               drv->versions = BIT(IPQ8074_HAWKEYE_VERSION);
> +               break;
> +       default:
> +               dev_err(cpu_dev,
> +                       "SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
> +                       msm_id);
> +               drv->versions = BIT(IPQ8074_ACORN_VERSION);
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>         .get_version = qcom_cpufreq_kryo_name_version,
>  };
> @@ -217,6 +260,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>         .genpd_names = qcs404_genpd_names,
>  };
>
> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> +       .get_version = qcom_cpufreq_ipq8074_name_version,
> +};
> +
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
>         struct qcom_cpufreq_drv *drv;
> @@ -360,6 +407,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>         { .compatible = "qcom,msm8996", .data = &match_data_kryo },
>         { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>         { .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +       { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>         { .compatible = "qcom,apq8064", .data = &match_data_krait },
>         { .compatible = "qcom,msm8974", .data = &match_data_krait },
>         { .compatible = "qcom,msm8960", .data = &match_data_krait },
> --
> 2.41.0
>
