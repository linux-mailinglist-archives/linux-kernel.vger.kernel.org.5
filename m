Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90DF7B2DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjI2I3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjI2I3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:29:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EE1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:29:49 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so171657547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695976189; x=1696580989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AO/uJHLmfHTJFDVuIxPPusBgqH9ox/rasg3E2WmZG1g=;
        b=dKrxe4IOhWMdnecL3TxzRqEYGGylcXhIGBOC8IJWomqgYY/Cwq0GiDPnpBkTEQTc0Z
         iqMA9cE2+4SNthocdCCMn97Ou+Uqd9TgmLe9goQvRps8eB0XwCxKEVr5PNOIvkCehEeD
         N2J+z04wJkLVkD6M8enQ0gM87SmgfFVQs5wl5IVmM+CB6pfaQehZp89wAFDSqwYoXUaz
         fbFUiJ/kS4jRzVwoabzSUdsc+Q5UYbquwB9PlLsUdR+H27ps1sUG/g7jw3dMuGD34FMy
         pUWV28W4SQwpFsLLGGIWvAgVQ7qPst7kPtatgc31rKRumBZCm9ISWsMDHNFIIX/72zih
         J6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695976189; x=1696580989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AO/uJHLmfHTJFDVuIxPPusBgqH9ox/rasg3E2WmZG1g=;
        b=uaYB21nc3Jk/2OKn0fLWhZaRBuV+zkMEGcZ3YvLzSlMhEHR96B+LjgdFnytGPzUP7g
         EHfvWSONDHHN+qxLd412rJ0lK4VKunVGSSiZu8WztvnRfPbs+Mq3qSRQ/YomRYPCoqRI
         pAe2nOHX3Ag2IChPRMtbSjnnvOC3fRQkwXcV6igJaJiK7ZfQyPcUP3wYkmlqG5mUPhLy
         rMAHyPkRHR87KAMNLcluW/zu3Ef9E7Tg63e4PFI4WEZ9LCy40vYxj1/7HMDdNdXkOy1J
         +TgO56aaQ1AugL1m7YVF2f7ZvAnr72+PNo4Z+WAy4/9ZlhsF+ZzlWgx8L2Dkv4EINkkM
         ZFIA==
X-Gm-Message-State: AOJu0Yy2B1uAGsV6j5hKeFDc2KWon38Vc9uVjE3MIH5UUm9na6iK0C/3
        wVl527J7bsUepMvMv2QN9EDrrbvmIuItQPQCPF7bbA==
X-Google-Smtp-Source: AGHT+IEQryF/Jq6ClcrXeNFwkaLrgTZMOGtwSpYsQb1fq1tuW4ZUQrgK4aRlhvqYry4WQ+Zv62sfUNQpqbZP7hNpur0=
X-Received: by 2002:a0d:d992:0:b0:59e:7fc1:dba0 with SMTP id
 b140-20020a0dd992000000b0059e7fc1dba0mr3269915ywe.44.1695976188816; Fri, 29
 Sep 2023 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
 <b0508a69-130d-4b05-9dfc-399e482dc2ae@linaro.org> <20230929073216.GB15001@varda-linux.qualcomm.com>
In-Reply-To: <20230929073216.GB15001@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 29 Sep 2023 11:29:36 +0300
Message-ID: <CAA8EJprD=zuvCrjOdeinPq=NaFLuATYWad4GDHzBH_PJZnOKHw@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe
 source switch for a53pll
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sept 2023 at 10:33, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Thu, Sep 07, 2023 at 10:31:55AM +0200, Konrad Dybcio wrote:
> > On 7.09.2023 07:21, Varadarajan Narayanan wrote:
> > > Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> > > frequency scaling. To achieve the same, we need to park the APPS
> > > PLL source to GPLL0, re configure the PLL and then switch the
> > > source to APSS_PLL_EARLY.
> > >
> > > To support this, register a clock notifier to get the PRE_RATE
> > > and POST_RATE notification. Change the APSS PLL source to GPLL0
> > > when PRE_RATE notification is received, then configure the PLL
> > > and then change back the source to APSS_PLL_EARLY.
> > >
> > > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 53 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > > index 4e13a08..ffb6ab5 100644
> > > --- a/drivers/clk/qcom/apss-ipq6018.c
> > > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > > @@ -9,8 +9,11 @@
> > >  #include <linux/clk-provider.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/module.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/soc/qcom/smem.h>
> > >
> > >  #include <dt-bindings/clock/qcom,apss-ipq.h>
> > > +#include <dt-bindings/arm/qcom,ids.h>
> > >
> > >  #include "common.h"
> > >  #include "clk-regmap.h"
> > > @@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
> > >     .num_clks = ARRAY_SIZE(apss_ipq6018_clks),
> > >  };
> > >
> > > +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> > > +                           void *data)
> > > +{
> > > +   u8 index;
> > > +   int err;
> > > +
> > > +   if (action == PRE_RATE_CHANGE)
> > > +           index = P_GPLL0;
> > > +   else if (action == POST_RATE_CHANGE)
> > > +           index = P_APSS_PLL_EARLY;
> > > +   else
> > > +           return 0;
> > > +
> > > +   err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
> > > +                                             index);
> > Adding a variable for clk_hw within the apcs_alias0 clock would
> > make this easier to digest, I think.
> >
> > And if we wanna be even less error-prone, you can reference the
> > ops of this clock in an indirect way.
>
> Will change it as
>
>         struct clk_hw *hw;
>
>         hw = &apcs_alias0_clk_src.clkr.hw;
>         err = hw->init->ops->set_parent(hw, index);

You can not do this, hw->init is cleared during registration.

>
> > > +   return notifier_from_errno(err);
> > > +}
> > > +
> > > +static struct notifier_block cpu_clk_notifier = {
> > > +   .notifier_call = cpu_clk_notifier_fn,
> > > +};
> > > +
> > >  static int apss_ipq6018_probe(struct platform_device *pdev)
> > >  {
> > >     struct regmap *regmap;
> > > +   u32 soc_id;
> > > +   int ret;
> > > +
> > > +   ret = qcom_smem_get_soc_id(&soc_id);
> > > +   if (ret)
> > > +           return ret;
> > >
> > >     regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > >     if (!regmap)
> > >             return -ENODEV;
> > >
> > > -   return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > > +   ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   switch (soc_id) {
> > > +   /*
> > > +    * Only below variants of IPQ53xx support scaling
> > > +    */
> > 1. /* Keep this in a 1-line comment */
>
> Ok
>
> > 2. why? explain the reasoning in the commit message
>
> Ok
>
> Thanks
> Varada
>
> > > +   case QCOM_ID_IPQ5332:
> > > +   case QCOM_ID_IPQ5322:
> > > +   case QCOM_ID_IPQ5300:
> > > +           ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> > > +                                           &cpu_clk_notifier);
> > > +           if (ret)
> > > +                   return ret;
> > > +           break;
> > > +   default:
> > > +           break;
> > > +   }
> > > +
> > > +   return 0;
> > >  }
> > >
> > >  static struct platform_driver apss_ipq6018_driver = {



-- 
With best wishes
Dmitry
