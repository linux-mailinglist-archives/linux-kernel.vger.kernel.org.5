Return-Path: <linux-kernel+bounces-149044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE38A8AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD761F23CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C217334B;
	Wed, 17 Apr 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXYKgqBj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F812F398
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378185; cv=none; b=GKbWLxlzr26jcMJPENUtyrvPwgMmjLc5+jCSmn5Zb2X5jJo2YV+eKZS3Jm0USf4edRA1snfy3N38a/xwnGDTdPwsfiZqsCudcDwFQnLZAuLOnvsXmf5Xggot1Q5619uhrKstihsadpI5aPotsi8MBy4/XDn1ErZFghknNnmdMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378185; c=relaxed/simple;
	bh=GSFpQZTxw+luFY2DAenAWU3T/0O8noUL2peBuPCgorE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHXIwWbyWV8ilMiFfgQbQDaB+HGPAVG87DAs3gzjPntV1yx4TsJcWgIGMRI6l3fzHRhIYCHwx2WdIwzWy0yTZhg/33usuxzmruR++LynhhAKcx7eDrFaknHSbM9of5dKoSLAlpsMcQnIfvBmmkVykGpXQ+hshmEV+KcX5dwhroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXYKgqBj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a5215314a4so72668a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713378183; x=1713982983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmIi4x8/b8NXa0HjoEg+8UR6LXGCQpB6Ce6yJm8+fjQ=;
        b=oXYKgqBj+Xg8i7EuE+egxh8DfUpqrTJ9J4iIQ7jcrnm9K7hz1HP9D9ljld4lt0MjHG
         WnGTULpQuKaUpWl4V9aufimzs0MvTEU6UVwxzscfQ056FcTYzyaThklwTn7vpGsIqGA5
         81/xIVOr/IUl8fDlIhLYJ43gqIO+dL2+uY2W7ZRK2J+GrS+q60fNUQ+KWKZ9ewjSh/RS
         +k2pEiT4+HdYRu6ZShN9hJEtVAfUEplKo4AS/pIr3yoMUxhk++y9zB6lzGoiOfi2QHIb
         ysxJ2oeCeLuYIHG+SdX/BvBHeO1iIjro1M7aLGcb5iNMK1rGYYgTIdGj5tcZgZxQtPHq
         1NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378183; x=1713982983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmIi4x8/b8NXa0HjoEg+8UR6LXGCQpB6Ce6yJm8+fjQ=;
        b=uCDGEalFfzDk+o13J283L8q625RuSpy+lYkxBOsC4S0mUBwglaWZWlVb+kOF70KsGX
         HJfBrg1kHRN6bG6ZiNGg66o5qzD3cRwSJ5AJgGjhQkZwjwX0XNzmV8I8mccuobe2/eUR
         0a2P28Z4kXDfwA+l58FTTsAJx3lzhTcIzxXhWLlm2ceU+O29NXxhRIcaaBRX9vTsO6SM
         goqPsKIaYBvDIhjBZkQrrHIEr/ZpLDD7YoBUxk/Kp2MG08UXY8UmlCIOgIs6Nb7q+xZq
         lTxcOcsVLRQ573GIYmh1+eySTzPCBAShtW43KL5wq8EaXAW0GN89v3N3fTxXu8HwGb5e
         qIUw==
X-Forwarded-Encrypted: i=1; AJvYcCVvhV9z1uMPkuoE3t6kEG1rbwPcZNPFBYPHv9Rn+nf8M8CClfWmeII89gtDEuiBZBzx/GcsvUy2ys5IrHlG+BasKh7cThiKDH/2kzae
X-Gm-Message-State: AOJu0YyCp/8SXP/WrSM23CtKg9oEqk2/fg9utYse0201nhWYY1YZMe+M
	8oEuQZT1MpHLxh/tz+96mX8EHAlERHVgT/QoUsjY6M2LotX4+1kycHf90hdFJuit04sMrry+zrX
	Hi6PpFCEmohwtbw6oGhJQQrAAAfW/QKh/Y3A+pw==
X-Google-Smtp-Source: AGHT+IHBBJDz4Q/S3LVn4jpMpXk3OhnglB4/wAvzcxFXxkiBE6PstlHzJfD6mh8JVmunU1BfJ9mzL3gZxp6im+rnQwg=
X-Received: by 2002:a17:90a:430f:b0:2a4:f53d:e6bc with SMTP id
 q15-20020a17090a430f00b002a4f53de6bcmr211574pjg.15.1713378183432; Wed, 17 Apr
 2024 11:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-6-quic_varada@quicinc.com> <CAA8EJpq75LhY3BD4JEqAOVAt1SxTvSOsdJTTb2bZD9rj15FmGA@mail.gmail.com>
 <Zh/6BXYuKrVjq7MG@hu-varada-blr.qualcomm.com>
In-Reply-To: <Zh/6BXYuKrVjq7MG@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 21:22:50 +0300
Message-ID: <CAA8EJpoutY0t92qQFtJYmN-2+3bzDdHu+rL84R9pu4Zz-cVoVQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] clk: qcom: common: Add interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 19:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Wed, Apr 17, 2024 at 02:29:03PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 17 Apr 2024 at 13:57, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > Unlike MSM platforms that manage NoC related clocks and scaling
> > > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > > clocks and there is no NoC scaling.
> > >
> > > However, there is a requirement to enable some NoC interface
> > > clocks for accessing the peripheral controllers present on
> > > these NoCs. Though exposing these as normal clocks would work,
> > > having a minimalistic interconnect driver to handle these clocks
> > > would make it consistent with other Qualcomm platforms resulting
> > > in common code paths. This is similar to msm8996-cbf's usage of
> > > icc-clk framework.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > > v8: Explicitly set master and slave ids
> > > v7: Restore clk_get
> > > v6: first_id -> icc_first_node_id
> > >     Remove clock get so that the peripheral that uses the clock
> > >     can do the clock get
> > > v5: Split changes in common.c to separate patch
> > >     Fix error handling
> > >     Use devm_icc_clk_register instead of icc_clk_register
> > > v4: Use clk_hw instead of indices
> > >     Do icc register in qcom_cc_probe() call stream
> > >     Add icc clock info to qcom_cc_desc structure
> > > v3: Use indexed identifiers here to avoid confusion
> > >     Fix error messages and move to common.c
> > > v2: Move DTS to separate patch
> > >     Update commit log
> > >     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> > > ---
> > >  drivers/clk/qcom/common.c | 35 ++++++++++++++++++++++++++++++++++-
> > >  drivers/clk/qcom/common.h | 16 ++++++++++++++++
> > >  2 files changed, 50 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> > > index 75f09e6e057e..a6410b1828ca 100644
> > > --- a/drivers/clk/qcom/common.c
> > > +++ b/drivers/clk/qcom/common.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/clk-provider.h>
> > > +#include <linux/interconnect-clk.h>
> > >  #include <linux/reset-controller.h>
> > >  #include <linux/of.h>
> > >
> > > @@ -234,6 +235,38 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
> > >         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> > >  }
> > >
> > > +static int qcom_cc_icc_register(struct device *dev,
> > > +                               const struct qcom_cc_desc *desc)
> > > +{
> > > +       struct icc_clk_data *icd;
> > > +       struct clk_hw *hws;
> > > +       int i;
> > > +
> > > +       if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
> > > +               return 0;
> > > +
> > > +       if (!desc->icc_hws)
> > > +               return 0;
> > > +
> > > +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> > > +       if (!icd)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i = 0; i < desc->num_icc_hws; i++) {
> > > +               icd[i].master_id = desc->icc_hws[i].master_id;
> > > +               icd[i].slave_id = desc->icc_hws[i].slave_id;
> > > +               hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
> >
> > I think I keep on repeating this again and again. Instead of passing
> > indices please pass clk_hw pointers.
>
> I'm sorry. Based on the following feedback for v7 from you I changed it to
> use indices instead of clk_hw pointers. Am I missing something?
>
> https://lore.kernel.org/linux-arm-msm/CAA8EJpohAe-aW1QqVkE9NBRU0DpZR7UiwdUKk6rS_YFAhenZZA@mail.gmail.com/
> <quote>
>         > +       struct clk_hw **icc_hws;
>
>         Still we are passing hws here. We already have all the hws in a
>         different array. Can we just pass the indices?
> </quote>
>
> Please confirm.

Ok, it's fine then.

>
> > > +               icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
> > > +               if (!icd[i].clk)
> > > +                       return dev_err_probe(dev, -ENOENT,
> > > +                                            "(%d) clock entry is null\n", i);
> > > +               icd[i].name = clk_hw_get_name(hws);
> > > +       }
> > > +
> > > +       return devm_icc_clk_register(dev, desc->icc_first_node_id,
> > > +                                                    desc->num_icc_hws, icd);
> > > +}
> > > +
> > >  int qcom_cc_really_probe(struct platform_device *pdev,
> > >                          const struct qcom_cc_desc *desc, struct regmap *regmap)
> > >  {
> > > @@ -303,7 +336,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       return 0;
> > > +       return qcom_cc_icc_register(dev, desc);
> > >  }
> > >  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
> > >
> > > diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> > > index 9c8f7b798d9f..f6b25df1ca17 100644
> > > --- a/drivers/clk/qcom/common.h
> > > +++ b/drivers/clk/qcom/common.h
> > > @@ -19,6 +19,19 @@ struct clk_hw;
> > >  #define PLL_VOTE_FSM_ENA       BIT(20)
> > >  #define PLL_VOTE_FSM_RESET     BIT(21)
> > >
> > > +struct qcom_icc_hws_data {
> > > +       int master_id;
> > > +       int slave_id;
> > > +       int clk_id;
> > > +};
> > > +
> > > +#define HWS_DATA(_b, _c)               \
> > > +{                                      \
> > > +       .master_id = MASTER_##_b,       \
> > > +       .slave_id = SLAVE_##_b,         \
> > > +       .clk_id = _c,                   \
> > > +}
> >
> > This shouldn't be a part of this commit. It is not used in it.
>
> Ok.
>
> Thanks
> Varada
>
> > > +
> > >  struct qcom_cc_desc {
> > >         const struct regmap_config *config;
> > >         struct clk_regmap **clks;
> > > @@ -29,6 +42,9 @@ struct qcom_cc_desc {
> > >         size_t num_gdscs;
> > >         struct clk_hw **clk_hws;
> > >         size_t num_clk_hws;
> > > +       struct qcom_icc_hws_data *icc_hws;
> > > +       size_t num_icc_hws;
> > > +       unsigned int icc_first_node_id;
> > >  };
> > >
> > >  /**
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

