Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCD7CFA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjJSNMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJSNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:12:38 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B098
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:12:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a87ac9d245so55009817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697721156; x=1698325956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihyEfw6d/6Ye9dRz+5lKF9uUOsex/9mwcXLcDYm3qJ8=;
        b=uZx+XKR4SwV03LW4nZMWDzMLO6y4Ppe3CWxFgc79j+XtZ3gdsozWBNUYw2Cm06O1jl
         L2sBcz0Mdr/P/9lq4c7GEkqMoNvyqccshGWIJ+QqQvF0AMzov+wG1XdNsfh7HMePokXj
         k3R/mTtGgGf+YH9Ji8fW9XtYz+EXOxQnHIroQOqbzdpHAUOfuSAT3pH5LS22pmM0qrKd
         F+7370s5J7mmxhgok25mdbKd4gf7/1932ydQyLvTroz4GjO1yRRSBxFdtU0xMPGlHvAv
         I8APdq1sMYo66SDl4bZCgmRqzfLSMBVT5/qsVfwmjCQWBCnFrZICO5PWjSmI8CNOhbwN
         ccYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721156; x=1698325956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihyEfw6d/6Ye9dRz+5lKF9uUOsex/9mwcXLcDYm3qJ8=;
        b=L+0AVrJOedeS5l+i0tzObFehNkVWqfCfC3Ui/Nq5mC1/cmGdBJ7nu42OAPvyfpu1Am
         tnYYk7c/Xn97E9Xhh2lA8R/Z3NJhjh47A2YhDDKXucnYV6KM2bmN8hVdB3ZoVQ8KRdDA
         zfHDOsCmC02/trrVPDGF0KHa5sLEiyjNM/LnaO3ycG2vT2CJl9zrjLZkB0I0X+lPGY6F
         FwfjvyXjh18kLwmUgTamMFidrwsBRia6vx0uL2ZA37my5yZyl6XdoxEJkgvjuZOr+JhY
         +zWwnJ+G3Rwk6cZ692DBLEW4/RK3zfV8yQKw2asIZW0Qvn7QClDRgb8TNJC/DgVNsRMl
         aQoQ==
X-Gm-Message-State: AOJu0YyLv+t2e6XbP/nJvmiyWrfahLwwsWahuCV7CoUZjvjyMakuM+vn
        3i94J8sSVC1Cg9T/VoExSWfwQ7126148mnm91QYmEA==
X-Google-Smtp-Source: AGHT+IFlSkOYgC7bYQ65kZNyfSVr6WVa+b6gqEq58/U4wY+1heInRHuynGjWtLgpzZLHn7tzOvDltfRKStG3dFI+yvI=
X-Received: by 2002:a81:5247:0:b0:5a7:af89:c4a0 with SMTP id
 g68-20020a815247000000b005a7af89c4a0mr2416296ywb.23.1697721155836; Thu, 19
 Oct 2023 06:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697694811.git.quic_varada@quicinc.com> <9796f8e752c4de94b0939e4512bc646a5e72fc32.1697694811.git.quic_varada@quicinc.com>
In-Reply-To: <9796f8e752c4de94b0939e4512bc646a5e72fc32.1697694811.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 16:12:25 +0300
Message-ID: <CAA8EJprLvQ6Mzo-JLetNDESftRaJGDe46UtWChWx+BQRu1aJQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:42, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The config IPQ_APSS_6018 should depend on QCOM_SMEM, to
> avoid the following error.

Which error?

>
> Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202310181650.g8THtfsm-lkp@intel.com/
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3194c8b..ad1acd9 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -131,6 +131,7 @@ config IPQ_APSS_6018
>         tristate "IPQ APSS Clock Controller"
>         select IPQ_APSS_PLL
>         depends on QCOM_APCS_IPC || COMPILE_TEST
> +       depends on QCOM_SMEM
>         help
>           Support for APSS clock controller on IPQ platforms. The
>           APSS clock controller manages the Mux and enable block that feeds the
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
