Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A0757848
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGRJll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGRJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:41:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7EE43
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:41:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so5616413276.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689673292; x=1690278092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9lM4wxxDWZZJtzcG1+1WoWSCZ7/GaeL9QjLI/qmDy4I=;
        b=MYdG3xFipiTe1E6uctwNK4KyPAYNOl4SrpEbHLe02dXrHGAtDmDPl1A4XPh0cNA1uC
         Hpt19dukY6GVCCfgu0YI8sVLzs5EJRjHPILQ8X1whFv6+RxU5DOQ50ekWL6tc4XUk9+V
         eGKqu+UV9i6RjFc1XSmr8/QeRe8e/j9xFgNGncGW71TpCjB5goEKCkGxqfkEzv0putuZ
         rOAHryrV001WQrpkf7EyDoJrUg3caPNqpXeLRgpqvnJ5VMg+gwB0xiViVC4NZa5UOPfl
         Su8ImUCaYuSvHh2t2fEjiSWlCqkjrWrEBc7qwCfSKiz6521yFsFYiPu+fz7OaErg6oLS
         5++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689673292; x=1690278092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lM4wxxDWZZJtzcG1+1WoWSCZ7/GaeL9QjLI/qmDy4I=;
        b=Yjr8Xmk+lcMmawEG/vmq/CnVi94OEyDJ/3YBRgvBzfq7hdmyDRjIKHWhzp4q9k40Sm
         KecUO/9+pTtO/vMYf4ZspEex9E8zLNPddjavdzOGcPbUH/YCZ0E1peZDOZyLHJ/zg8CS
         +wfPPh4YzoBzaKuHkaUARGcDwi8B7LPmRNUZiSGbpEzlxNXN4P2SJ+81a8EpMCnHErAI
         E3BeIg5va5ZRvDbpgn9mcY1c5R66x1rl/DRd/Cp4n/QrMXNXlDs8Kh/o6odeijJG+ZCW
         9g+3XKDxwRitQlfiQf5u9sWcEWy6XEq/gN9PnQSeD5D73dHx7Bzle+srMA8Nyy7CyRfu
         fd1w==
X-Gm-Message-State: ABy/qLbhvws4S76/mboJKaqBriaNzIyHgVLBAcRHs82p7JXiYjsBzVMY
        4L2uujOLFgC2ID/1vsDKJAkXIaAC4TBPe6qPEBP2eg==
X-Google-Smtp-Source: APBJJlGJbEeVGjIJ8uO4gp9TaXztKbYC5jfxN5nN1X3MkYnOqOn9JwsMyqJvkvqTfDxYpJtBTn7VnYDfFLfinnV+oLg=
X-Received: by 2002:a25:6046:0:b0:c1d:6508:3083 with SMTP id
 u67-20020a256046000000b00c1d65083083mr13129985ybb.55.1689673291709; Tue, 18
 Jul 2023 02:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-3-quic_fenglinw@quicinc.com> <CAA8EJpq_DGu3+kc_ex_2MUyiQFJvZhbWOc7NO6x1pO1Wx4RbNw@mail.gmail.com>
 <86631cb4-6b99-c3a7-428e-4534891da4c7@quicinc.com>
In-Reply-To: <86631cb4-6b99-c3a7-428e-4534891da4c7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Jul 2023 12:41:20 +0300
Message-ID: <CAA8EJpr--XZnFJX96etagAa0uT0yNBcgZTfFDuu8gH2C5sgoCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: pm8xxx-vib - Add support for more PMICs
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 09:58, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 7/18/2023 2:44 PM, Dmitry Baryshkov wrote:
> > On Tue, 18 Jul 2023 at 09:27, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>
> >> Add support for vibrator module inside PMI632, PM7250B, PM7325B.
> >> It is very similar to vibrator inside PM8xxx but just the drive
> >> amplitude is controlled through 2 bytes registers.
> >>
> >> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> >> ---
> >>   drivers/input/misc/pm8xxx-vibrator.c | 48 ++++++++++++++++++++++++++++
> >>   1 file changed, 48 insertions(+)
> >>
> >> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> >> index 04cb87efd799..213fdfd47c7f 100644
> >> --- a/drivers/input/misc/pm8xxx-vibrator.c
> >> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> >> @@ -25,6 +25,9 @@ struct pm8xxx_regs {
> >>          unsigned int drv_addr;
> >>          unsigned int drv_mask;
> >>          unsigned int drv_shift;
> >> +       unsigned int drv_addr2;
> >> +       unsigned int drv_mask2;
> >> +       unsigned int drv_shift2;
> >>          unsigned int drv_en_manual_mask;
> >>   };
> >>
> >> @@ -44,6 +47,42 @@ static struct pm8xxx_regs pm8916_regs = {
> >>          .drv_en_manual_mask = 0,
> >>   };
> >>
> >> +static struct pm8xxx_regs pmi632_regs = {
> >> +       .enable_addr = 0x5746,
> >> +       .enable_mask = BIT(7),
> >> +       .drv_addr = 0x5740,
> >> +       .drv_mask = 0xff,
> >> +       .drv_shift = 0,
> >> +       .drv_addr2 = 0x5741,
> >> +       .drv_mask2 = 0x0f,
> >> +       .drv_shift2 = 8,
> >
> > I see that you are just expanding what was done for SSBI PMICs and
> > later expanded to support pm8916. However it might be better to drop
> > the hardcoded .drv_addr (and drv_addr2) and read address from DT
> > instead.
> >
>
> Right, this is the simplest change without updating the code logic too
> much. If we decided to read .drv_addr and .drv_add2 from DT, we will
> have to read .enable_addr along with all other mask/shift for each
> register address from DT as well because they are not consistent from
> target to target. I don't know how would you suggest to add the DT
> properties for all of them, but if we end up to add a property for each
> of them, it won't be cleaner than hard-coding them.

No, we (correctly) have device compatibles for that. The issue with
hardcoding register addresses is that it adds extra issues here.

If I understand correctly, we have several 'generation':
- SSBI PMIC, shifted 5-bit mask, en_manual_mask, no enable_register.
- older SPMI PMIC, 5 bit drv_mask, 0 en_manual_mask, enable register at +6
- new SPMI PMIC, 12 bit drv_mask, 0 en_manual_mask, enable register at +6

For the last generation you are adding three independent entries,
while the block looks the same. If you remove drv_addr (and get it
from reg property), it would allow us to keep only the functional data
in struct pm8xxxx_regs (masks / shifts).

>
>
> >> +       .drv_en_manual_mask = 0,
> >> +};
> >> +
> >> +static struct pm8xxx_regs pm7250b_regs = {
> >> +       .enable_addr = 0x5346,
> >> +       .enable_mask = BIT(7),
> >> +       .drv_addr = 0x5340,
> >> +       .drv_mask = 0xff,
> >> +       .drv_shift = 0,
> >> +       .drv_addr2 = 0x5341,
> >> +       .drv_mask2 = 0x0f,
> >> +       .drv_shift2 = 8,
> >> +       .drv_en_manual_mask = 0,
> >> +};
> >> +
> >> +static struct pm8xxx_regs pm7325b_regs = {
> >> +       .enable_addr = 0xdf46,
> >> +       .enable_mask = BIT(7),
> >> +       .drv_addr = 0xdf40,
> >> +       .drv_mask = 0xff,
> >> +       .drv_shift = 0,
> >> +       .drv_addr2 = 0xdf41,
> >> +       .drv_mask2 = 0x0f,
> >> +       .drv_shift2 = 8,
> >> +       .drv_en_manual_mask = 0,
> >> +};
> >> +
> >>   /**
> >>    * struct pm8xxx_vib - structure to hold vibrator data
> >>    * @vib_input_dev: input device supporting force feedback
> >> @@ -87,6 +126,12 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
> >>                  return rc;
> >>
> >>          vib->reg_vib_drv = val;
> >> +       if (regs->drv_addr2 != 0 && on) {
> >> +               val = (vib->level << regs->drv_shift2) & regs->drv_mask2;
> >> +               rc = regmap_write(vib->regmap, regs->drv_addr2, val);
> >> +               if (rc < 0)
> >> +                       return rc;
> >> +       }
> >>
> >>          if (regs->enable_mask)
> >>                  rc = regmap_update_bits(vib->regmap, regs->enable_addr,
> >> @@ -242,6 +287,9 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
> >>          { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
> >>          { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
> >>          { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> >> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
> >> +       { .compatible = "qcom,pm7250b-vib", .data = &pm7250b_regs },
> >> +       { .compatible = "qcom,pm7325b-vib", .data = &pm7325b_regs },
> >>          { }
> >>   };
> >>   MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> >> --
> >> 2.25.1
> >>
> >
> >



-- 
With best wishes
Dmitry
