Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727EF7CFC23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjJSOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345531AbjJSOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:10:16 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A17131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:10:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59e88a28b98so7343377b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697724613; x=1698329413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wSys4rsbeW6TJksuzBXo91tDTJzxZoqvYBGXuczrwg=;
        b=yPt6+hyn0q8nRh+xJGcVVTd6aBELI925YFc4Hf7saH4IKPLVQO0j8whP6+fM9MGr5Y
         cF0sKckARWxNs6zAB9lHr0MX+N9cnuirub19j7P8mfSrqAoQhrgaPQpzdGFQT4GBhSIv
         Cpx+hP11MQRChRJhNywc2ufMs4f0N9OV862GbTOMzcuKInGUIMJy3GoISH3kdJiXN8/H
         ZnIYq+efp8nqF/j0cLhcilYBZslhCQnFn/YUGMbisQ2VuKq0BVeC10U2McOZXvvF/CTg
         qPldp3+qrQczWdenq+/hz1sEdM/eFFeJe/gyFUspYGiuvXzi8baps++qJof0YLrw9oTU
         cUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724613; x=1698329413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wSys4rsbeW6TJksuzBXo91tDTJzxZoqvYBGXuczrwg=;
        b=kdFOw+HXdH0hzbpSN+pbgYa+cthz9H6Jc9hhOZJ3JeiX9r9ItbeQOq0u+xFejVacQ7
         EW1EnQQ6O64zQk5qUds16lDmJqSBrX2Q0tCmPdL/6MDrSa7L9v6N7QFtTB40B2X0Beya
         C95w6PvMf+rvezShOTxRHlfa3aUI9F7wbKxauZwkG+1OYCoIF/fFY0XDhNOelu9gneYk
         D2xwS/Yu/SlTYHVCh9Ab00bxpEA3qYixxKwhHvRPeRjs8BvIp/F+GbTWn9X1NGZtVaod
         Opq6n//uBdgM4MiZ1JUddXoKkv4JSsFjRlhr2DCunq3+zpLICkIyfRCBno5g/Zhyb8QE
         Nb9A==
X-Gm-Message-State: AOJu0Yw5U4MyWS2EKNhz3k4KOhC55/G6SQh20FLvZLp1YTRCUoYyro/K
        4vOG1hpNLmVKgTge4O7by3yBN558pa0WSLgB9R7Ptw==
X-Google-Smtp-Source: AGHT+IEwlHRy2zOcM/DBgHA9BJNVulUDdOwJQE0MV7FcIHalKrDfpv+nVUZHKKrRg9DXCMmv+RzV1EjO/cCl4dw43LI=
X-Received: by 2002:a81:5251:0:b0:5a7:ba3e:d1d1 with SMTP id
 g78-20020a815251000000b005a7ba3ed1d1mr1315335ywb.25.1697724612881; Thu, 19
 Oct 2023 07:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697694811.git.quic_varada@quicinc.com> <7369c6d5186d2b9b5f62a210878e9f864b57e11a.1697694811.git.quic_varada@quicinc.com>
In-Reply-To: <7369c6d5186d2b9b5f62a210878e9f864b57e11a.1697694811.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 17:10:01 +0300
Message-ID: <CAA8EJprFcs471e6Jd6RZxBL4+cFdrvn2oOdsm+oN09A81iYoFA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] cpufreq: qti: Introduce cpufreq for ipq95xx
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Praveenkumar I <ipkumar@codeaurora.org>
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

On Thu, 19 Oct 2023 at 11:43, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ95xx SoCs have different OPPs available for the CPU based on
> the SoC variant. This can be determined from an eFuse register
> present in the silicon.
>
> Added support for ipq95xx on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
>
> Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2:     Simplify bin selection by tweaking the order in dts
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f43e5cd..4f794ba 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -183,6 +183,7 @@ static const struct of_device_id blocklist[] __initconst = {
>         { .compatible = "qcom,ipq5332", },
>         { .compatible = "qcom,ipq8064", },
>         { .compatible = "qcom,ipq8074", },
> +       { .compatible = "qcom,ipq9574", },
>         { .compatible = "qcom,apq8064", },
>         { .compatible = "qcom,msm8974", },
>         { .compatible = "qcom,msm8960", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 0014909..d44be4e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -166,6 +166,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>         case QCOM_ID_IPQ5300:
>                 drv->versions = 1 << (unsigned int)(*speedbin);
>                 break;
> +       case QCOM_ID_IPQ9514:
> +       case QCOM_ID_IPQ9550:
> +       case QCOM_ID_IPQ9554:
> +       case QCOM_ID_IPQ9570:
> +       case QCOM_ID_IPQ9574:

Can we please merge this to the previous set of cases (and maybe to
apq8096)? I don't see a great benefit in repeating `1 << (unsigned
int)(*speedbin)` several times.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +               drv->versions = 1 << (unsigned int)(*speedbin);
> +               break;
>         default:
>                 BUG();
>                 break;
> @@ -417,6 +424,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>         { .compatible = "qcom,ipq8064", .data = &match_data_krait },
>         { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>         { .compatible = "qcom,apq8064", .data = &match_data_krait },
> +       { .compatible = "qcom,ipq9574", .data = &match_data_kryo },
>         { .compatible = "qcom,msm8974", .data = &match_data_krait },
>         { .compatible = "qcom,msm8960", .data = &match_data_krait },
>         {},
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
