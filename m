Return-Path: <linux-kernel+bounces-127770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684658950AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3DD1C21C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57B60BB6;
	Tue,  2 Apr 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkVHyRKI"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C17604CE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054908; cv=none; b=dBSQAhaB1fR8eDRzU18CqxXnVdZH7+sRyBiBG40jhiuOE4cGc9s8yVzMdnW2SMof6HYfhEqPU6+OAkOtYdLMm7EAbpG8tjQwST23nW9hllWGzt0iF0VpxwHFkbk022nofc1M/0Hmg5n4u6SSHkueAkUqN6JrsbJQwwrp/JdVVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054908; c=relaxed/simple;
	bh=3EyCUbtnMkP+cwjwavYDGusXVngaEoTsr1iaAdtpXeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q30tMdwCteMEJbVjoxHXlxtCpalH0UkaPQtqOa0ePtdIKEwrcZ+Y/PkZAaAi3xwRFvUEhv2hp7zmzzbESqAYirqYdiGN+gNe1+LDfpJk/QHPw9sjIAg8F9hu2W6rAdPEK2BGSswx1Wi4LiqZjHpSZt4nj2ew1savrfmgQ7TbnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkVHyRKI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4572599276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054905; x=1712659705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrrS39kMM3qSYmTTIfDrvL7v8BkqXr1H3y+hhGF7rb8=;
        b=UkVHyRKITqATKyKjfs/CiavGPEGleKdak8ohMaHk8LcaQEZm0bB8GoFjSkDpzNw59H
         bkwbp7u6lRoWskZq6B8SP3HRKuG6CX8pNjMF+Cbrp7rUCXaasn5WLzMGGQmnKiW7kshI
         lRLfnblVRm4pQ4PCg19qVY1KY0asC+oEZSr5Oe5QIjZ7zcEvFwenhsIMToXcHBhhrfch
         13aDuu5F/bIL2ppfSqIv3YwRe4rWn8CnrYw3yIQUVeQgzhteAkeJDXKMt256h/RV0Z0W
         SlpSNbCLR4qk7rEn0jsewuPEeIpj8Gi9bPIBiVrlkPIr+cBY5W8PyLkM8h0VXvD/ax+z
         x3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054905; x=1712659705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrrS39kMM3qSYmTTIfDrvL7v8BkqXr1H3y+hhGF7rb8=;
        b=wlV/VVQq6clEvFRRBcdNQrzXDgE14SIyvMTaw3G0zAStiYC0Z3J5Rw/Ih836P/M5fO
         CRWhHhYxcFwg/ED6Bkpa8N4iqliq6dwW0+9qYe/aVd6/4uqNlPKIdMKcbEbDomA1RStn
         f/ZNWbsY86/TW4JDMeMG/c5WL7V5Hq/t9k7AUKJAKX1ciwanwCIZYaENGsr7WPTizx87
         ozMgOaY3th2v09O0+BMFtbpdCdhZZ/S1NUiJxEaKweJtKkHJ8aaqhTY78k4ssK/xJ3XD
         7XhUFLzGU3JLTohMflJ9uc6S0o6SpiNNQdhfUsZtUwsqPgw2D5YqzGxttC7YNDQLc/Wo
         20bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRtaz5p8ht9wUBCnTQyCJuK8sBRmQsGsJbBbequWbb7ZK+T/5Re9zj5qjm1K9PjwbBlxY/K6KjSfAFqpHvs292hQyEn/b2fDS/XF+x
X-Gm-Message-State: AOJu0Ywhu5B5JGIRSWYj+sZZd2ZKGaQTEDDKizUEGM0JWWBiIHHZKbfz
	xIyCnLCznngXgKWWzAaIsBj1e9GHrtFUYZClNTNmulBkAvUiA+Ad+v7ENWBPOUL5IkDCaIAEI3I
	RXDa6X/ew0tgVxeaHMi+QYu+IntftDyEbGv6hTA==
X-Google-Smtp-Source: AGHT+IGMS8R++k+DqPE5wOBv2ZX4JQLKxz537DSE/PbugTcEZ6Qe3cfzLMtzIJTZj021l7TVX9g5NKQZckcQNQwOnio=
X-Received: by 2002:a25:4903:0:b0:dcd:a9ad:7d67 with SMTP id
 w3-20020a254903000000b00dcda9ad7d67mr10780266yba.8.1712054905465; Tue, 02 Apr
 2024 03:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-5-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-5-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:14 +0300
Message-ID: <CAA8EJprP0m53B=g7jafAkfcqAQP4kE2ZvtxPXEe4s7ALjFXGSQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] clk: qcom: common: Add interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.
>
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs. Though exposing these as normal clocks would work,
> having a minimalistic interconnect driver to handle these clocks
> would make it consistent with other Qualcomm platforms resulting
> in common code paths. This is similar to msm8996-cbf's usage of
> icc-clk framework.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v6: first_id -> icc_first_node_id
>     Remove clock get so that the peripheral that uses the clock
>     can do the clock get
> v5: Split changes in common.c to separate patch
>     Fix error handling
>     Use devm_icc_clk_register instead of icc_clk_register
> v4: Use clk_hw instead of indices
>     Do icc register in qcom_cc_probe() call stream
>     Add icc clock info to qcom_cc_desc structure
> v3: Use indexed identifiers here to avoid confusion
>     Fix error messages and move to common.c
> v2: Move DTS to separate patch
>     Update commit log
>     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> ---
>  drivers/clk/qcom/common.c | 38 +++++++++++++++++++++++++++++++++++++-
>  drivers/clk/qcom/common.h |  3 +++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..d5c008048994 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -8,6 +8,7 @@
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
>  #include <linux/reset-controller.h>
>  #include <linux/of.h>
>
> @@ -234,6 +235,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>  }
>
> +static int qcom_cc_icc_register(struct device *dev,
> +                               const struct qcom_cc_desc *desc)
> +{
> +       struct icc_clk_data *icd;
> +       int i;
> +
> +       if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
> +               return 0;
> +
> +       if (!desc->icc_hws)
> +               return 0;
> +
> +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> +       if (!icd)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < desc->num_icc_hws; i++) {
> +               /*
> +                * get_clk will be done by the peripheral device using this
> +                * clock with devm_clk_hw_get_clk() so that we can associate
> +                * the clk handle with the consumer device. It would also help
> +                * us make it so that drivers defer probe until their
> +                * clk isn't an orphan.

How the clock instance returned to the peripheral driver is supposed
to correspond to the clock instance used by the icc-clk?

> +                */
> +               icd[i].clk = desc->icc_hws[i]->clk;

You again are abusing clk_hw->clk. Please don't do that.

> +               if (!icd[i].clk)
> +                       return dev_err_probe(dev, -ENOENT,
> +                                            "(%d) clock entry is null\n", i);
> +               icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
> +       }
> +
> +       return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->icc_first_node_id,
> +                                                    desc->num_icc_hws, icd));
> +}
> +
>  int qcom_cc_really_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc, struct regmap *regmap)
>  {
> @@ -303,7 +339,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>         if (ret)
>                 return ret;
>
> -       return 0;
> +       return qcom_cc_icc_register(dev, desc);
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..9058ffd46260 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -29,6 +29,9 @@ struct qcom_cc_desc {
>         size_t num_gdscs;
>         struct clk_hw **clk_hws;
>         size_t num_clk_hws;
> +       struct clk_hw **icc_hws;
> +       size_t num_icc_hws;
> +       unsigned int icc_first_node_id;
>  };
>
>  /**
> --
> 2.34.1
>


--
With best wishes

Dmitry

