Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25603758FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGSIDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGSIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:02:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D038E47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:02:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-cb4de3bd997so795763276.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689753773; x=1690358573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHVTISJWMEu1wo/+yWJaL58w94i3Fvfg/1aly0CkBLg=;
        b=A85JiFkn24VXrvOWg7h7E5HAVa/ld4QzxYaBq0b2Gp/CZDyH29MpXz95U2vTy2XXou
         qlOgwTI4Fu+CjWy7qjNUjX6IthVth1FLk9yRiZajqyScXS+VhbFYaRszrcx/yWwmxO/V
         6jaI6K55urt6V3cLqp/83VflJqMPGfBtonEgMjksQSvjbpsMf+2U0L7bp9iamyamLkzJ
         YHc9Ps7Pbo0eUB65jgc8Bs1zWAGg9OEnicEc0FQeeUmeVqbwAhqjMpU6ZzgCCJFwOMNq
         lMcRTDx5lvkdb0zzN2fc3ybekXvi9kawOxfssUYHEO0C1BlTbGhxkNB82BdVytyR42nc
         Xefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753773; x=1690358573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHVTISJWMEu1wo/+yWJaL58w94i3Fvfg/1aly0CkBLg=;
        b=l9JMXmvjoHbYs8zmuml6w2whNu/gNQQj5fghHgxG83hLSAvlrH8emyhuUupzR3Nfbv
         TY5JlDv8zWsNQopfjJSitNgcvgM6sW2Nq2Dh/eiSAaMy1QCIkAvYpVOiG3IbT7UhEGWs
         Fe+NXp0NBWs770Bi2WUnQQg1b6ot75/EUswEtWxfEmjS1JJL6/FuoUQJjbDhn1772YJl
         FTfsLNTBn2hzJDnnl6gAbXA3tee9zO34Qwo8T4FO8kDbumhu536/K4AoD9z3xwy5rnI7
         E6mEwr2bnZBwSgwyRDrQvgkJkEFdbztHKMQvAmwyuvzOyMSfFV/hgPE/oaBQPQUNPWO1
         zDAA==
X-Gm-Message-State: ABy/qLZrXAvqs4pBCOohk3KeR0M7DMaPBQQcA+bm3PHLQ9HHc7I/74Uq
        sCgY55tcLNJ5+MjBxqCDWkhORiH7o/T+3HqzVbk9gqemAibtSC0niQw=
X-Google-Smtp-Source: APBJJlHR7GKJWe7LLZqitVIQenO93+P1JBcr4NfZqwAbSIIuN2O6NYsP9a+u2/E4hV/I7/cqCFNo11Sa+OYSwmdi61M=
X-Received: by 2002:a25:b299:0:b0:cef:fe05:b138 with SMTP id
 k25-20020a25b299000000b00ceffe05b138mr1634438ybj.8.1689753773475; Wed, 19 Jul
 2023 01:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-3-quic_fenglinw@quicinc.com> <CAA8EJpq_DGu3+kc_ex_2MUyiQFJvZhbWOc7NO6x1pO1Wx4RbNw@mail.gmail.com>
 <86631cb4-6b99-c3a7-428e-4534891da4c7@quicinc.com> <CAA8EJpr--XZnFJX96etagAa0uT0yNBcgZTfFDuu8gH2C5sgoCg@mail.gmail.com>
 <501bc7d0-1f97-1c53-a7f8-701ab9dfdf8e@quicinc.com> <CAA8EJppjshTCqeYQL1QUbLd03bopZjGHuOhoFqy7P8XuzYXc9w@mail.gmail.com>
 <138fac39-8c28-2c14-0b16-ec08189179cf@quicinc.com>
In-Reply-To: <138fac39-8c28-2c14-0b16-ec08189179cf@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 19 Jul 2023 11:02:42 +0300
Message-ID: <CAA8EJpoeFwu7P7jEqhmwttAeF4VAhaCSaKP4XrUQz1YVsg9zvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: pm8xxx-vib - Add support for more PMICs
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com, quic_huliu@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 07:09, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 7/18/2023 7:04 PM, Dmitry Baryshkov wrote:
> > On Tue, 18 Jul 2023 at 13:55, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 7/18/2023 5:41 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 18 Jul 2023 at 09:58, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/18/2023 2:44 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, 18 Jul 2023 at 09:27, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>>>>>
> >>>>>> Add support for vibrator module inside PMI632, PM7250B, PM7325B.
> >>>>>> It is very similar to vibrator inside PM8xxx but just the drive
> >>>>>> amplitude is controlled through 2 bytes registers.
> >>>>>>
> >>>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>>>> ---
> >>>>>>     drivers/input/misc/pm8xxx-vibrator.c | 48 ++++++++++++++++++++++++++++
> >>>>>>     1 file changed, 48 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> >>>>>> index 04cb87efd799..213fdfd47c7f 100644
> >>>>>> --- a/drivers/input/misc/pm8xxx-vibrator.c
> >>>>>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> >>>>>> @@ -25,6 +25,9 @@ struct pm8xxx_regs {
> >>>>>>            unsigned int drv_addr;
> >>>>>>            unsigned int drv_mask;
> >>>>>>            unsigned int drv_shift;
> >>>>>> +       unsigned int drv_addr2;

Unused

> >>>>>> +       unsigned int drv_mask2;
> >>>>>> +       unsigned int drv_shift2;
> >>>>>>            unsigned int drv_en_manual_mask;
> >>>>>>     };
> >>>>>>
> >>>>>> @@ -44,6 +47,42 @@ static struct pm8xxx_regs pm8916_regs = {
> >>>>>>            .drv_en_manual_mask = 0,
> >>>>>>     };
> >>>>>>
> >>>>>> +static struct pm8xxx_regs pmi632_regs = {
> >>>>>> +       .enable_addr = 0x5746,
> >>>>>> +       .enable_mask = BIT(7),
> >>>>>> +       .drv_addr = 0x5740,
> >>>>>> +       .drv_mask = 0xff,
> >>>>>> +       .drv_shift = 0,
> >>>>>> +       .drv_addr2 = 0x5741,
> >>>>>> +       .drv_mask2 = 0x0f,
> >>>>>> +       .drv_shift2 = 8,
> >>>>>
> >>>>> I see that you are just expanding what was done for SSBI PMICs and
> >>>>> later expanded to support pm8916. However it might be better to drop
> >>>>> the hardcoded .drv_addr (and drv_addr2) and read address from DT
> >>>>> instead.
> >>>>>
> >>>>
> >>>> Right, this is the simplest change without updating the code logic too
> >>>> much. If we decided to read .drv_addr and .drv_add2 from DT, we will
> >>>> have to read .enable_addr along with all other mask/shift for each
> >>>> register address from DT as well because they are not consistent from
> >>>> target to target. I don't know how would you suggest to add the DT
> >>>> properties for all of them, but if we end up to add a property for each
> >>>> of them, it won't be cleaner than hard-coding them.
> >>>
> >>> No, we (correctly) have device compatibles for that. The issue with
> >>> hardcoding register addresses is that it adds extra issues here.
> >>>
> >>> If I understand correctly, we have several 'generation':
> >>> - SSBI PMIC, shifted 5-bit mask, en_manual_mask, no enable_register.
> >>> - older SPMI PMIC, 5 bit drv_mask, 0 en_manual_mask, enable register at +6
> >>> - new SPMI PMIC, 12 bit drv_mask, 0 en_manual_mask, enable register at +6
> >>>
> >>> For the last generation you are adding three independent entries,
> >>> while the block looks the same. If you remove drv_addr (and get it
> >>> from reg property), it would allow us to keep only the functional data
> >>> in struct pm8xxxx_regs (masks / shifts).
> >>>
> >>
> >> Okay, let me know if I understood it correctly, this is what you are
> >> suggesting:
> >>
> >>     - hard code the mask/shifts and still keep them in struct pm8xxx_regs,
> >>       combine the drv_mask2 to the upper byte of the drv_mask, so we will
> >>       have following data structure for the 3rd generation vibrator
> >>
> >>       static struct pm8xxx_regs pm7250b_regs = {
> >>           .enable_addr = 0x5346,
> >>           .enable_mask = BIT(7),
> >>           .drv_mask = 0xfff,
> >>           .drv_shift = 0,
> >>           .drv_en_manual_mask = 0,
> >>       };
> >>
> >>
> >>     - move the drv_addr/drv_addr2 into DT, read them from 'reg' property.
> >>       Because of 'mfd/qcom,spmi-pmic.yaml' has defined the 'address-cells'
> >>       as 1 and the 'size-cells' as 0 for qcom spmi devices, we couldn't
> >>       specify the address size to 2 even the drv_addr for the 3rd
> >>       generation vibrator is 2 adjacent bytes. So we will end of having
> >>       following DT scheme:
> >>
> >>         For the 2nd generation which only has drv_addr
> >>          vibrator@c041 {
> >>                compatible = "qcom,pm8916-vib";
> >>                reg = <0xc041>;  /* drv_addr */
> >
> > No. This is <0xc000>.
> >
> >>                ...
> >>          };
> >>
> >>         For the 3rd generation which has both drv_addr and drv_addr2
> >>           vibrator@5340 {
> >>                compatible = "qcom,pm7250b-vib";
> >>               reg = <0x5340>,  /* drv_addr */
> >>                     <0x5341>;  /* drv_addr2 */
> >>               ...
> >>          };
> >>
> >> Not sure how do you feel, I actually don't see too much benefit than
> >> hard-coding them in the driver.
> >> We will end up having code to check how many u32 value in the 'reg' and
> >> only assign it to drv_addr2 when the 2nd is available, also when
> >> programming drv_addr2 register, the driver will always assume the mask
> >> is in the upper byte of the drv_mask and the shift to the drive level is
> >> 8 (this seems hacky to me and it was my biggest concern while I made
> >> this change, and it led me to defining drv_shift2/drv_mask2 along with
> >> drv_addr2).
> >
> > We only need drv_addr2 if drv_mask has more than 8 bits. So you don't
> > have to specify it in the DT. It is always equal to base_reg + 0x41.
> > The same way drv_addr is always equal to base_reg + 0x40 for all
> > SPMI-based PMIC vibrator devices.
> >
>
> Thanks. I got it now, I agree this will be beneficial for the case that
> different PMICs have the same vibrator module but with different
> register base address. I am going to change it to this way, let me know
> if this is what you thought:
>
> @@ -25,6 +29,9 @@ struct pm8xxx_regs {
>          unsigned int drv_addr;
>          unsigned int drv_mask;
>          unsigned int drv_shift;
> +       unsigned int drv_addr2;
> +       unsigned int drv_mask2;
> +       unsigned int drv_shift2;
>          unsigned int drv_en_manual_mask;
>   };
>
> +static struct pm8xxx_regs spmi_vib_regs = {
> +       .enable_mask = BIT(7),
> +       .drv_mask = 0xff,
> +       .drv_shift = 0,
> +       .drv_mask2 = 0xf,
> +       .drv_shift2 = 8,
> +       .drv_en_manual_mask = 0,
> +};

Ideally the static data should be const. I'd suggest moving
drv_addr/drv_addr2 to struct pm8xxx_vib.

> +
>
> +#define SPMI_VIB_VSET_LB_REG   0x40
> +#define SPMI_VIB_VSET_UP_REG   0x41
> +#define SPMI_VIB_EN_CTL_REG    0x46
> +
>
>          regs = of_device_get_match_data(&pdev->dev);
>
> +       if (regs->drv_addr == 0) {
> +               rc = fwnode_property_read_u32(pdev->dev.fwnode,
> +                               "reg", &reg_base);
> +               if (rc < 0)
> +                       return rc;
> +
> +               regs->enable_addr = reg_base + SPMI_VIB_EN_CTL_REG;
> +               regs->drv_addr = reg_base + SPMI_VIB_VSET_LB_REG;
> +               regs->drv_addr2 = reg_base + SPMI_VIB_VSET_UP_REG;

Yes, this looks good (except s/regs->/vib->/). Moreover this also
applies to pm8916. I'd suggest splitting this into two patches: first,
refactor pm8916 support to use reg, then add support for new devices.

> +       }
> +
>
>
> @@ -242,6 +277,7 @@ static const struct of_device_id
> pm8xxx_vib_id_table[] = {
>          { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
>          { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
>          { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> +       ( .compabitle = "qcom,spmi-vib", .data = &spmi_vib_regs },
>          { }
>
>
> >>
> >>
> >>
> >>>>
> >>>>
> >>>>>> +       .drv_en_manual_mask = 0,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static struct pm8xxx_regs pm7250b_regs = {
> >>>>>> +       .enable_addr = 0x5346,
> >>>>>> +       .enable_mask = BIT(7),
> >>>>>> +       .drv_addr = 0x5340,
> >>>>>> +       .drv_mask = 0xff,
> >>>>>> +       .drv_shift = 0,
> >>>>>> +       .drv_addr2 = 0x5341,
> >>>>>> +       .drv_mask2 = 0x0f,
> >>>>>> +       .drv_shift2 = 8,
> >>>>>> +       .drv_en_manual_mask = 0,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static struct pm8xxx_regs pm7325b_regs = {
> >>>>>> +       .enable_addr = 0xdf46,
> >>>>>> +       .enable_mask = BIT(7),
> >>>>>> +       .drv_addr = 0xdf40,
> >>>>>> +       .drv_mask = 0xff,
> >>>>>> +       .drv_shift = 0,
> >>>>>> +       .drv_addr2 = 0xdf41,
> >>>>>> +       .drv_mask2 = 0x0f,
> >>>>>> +       .drv_shift2 = 8,
> >>>>>> +       .drv_en_manual_mask = 0,
> >>>>>> +};
> >>>>>> +
> >>>>>>     /**
> >>>>>>      * struct pm8xxx_vib - structure to hold vibrator data
> >>>>>>      * @vib_input_dev: input device supporting force feedback
> >>>>>> @@ -87,6 +126,12 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
> >>>>>>                    return rc;
> >>>>>>
> >>>>>>            vib->reg_vib_drv = val;
> >>>>>> +       if (regs->drv_addr2 != 0 && on) {
> >>>>>> +               val = (vib->level << regs->drv_shift2) & regs->drv_mask2;
> >>>>>> +               rc = regmap_write(vib->regmap, regs->drv_addr2, val);
> >>>>>> +               if (rc < 0)
> >>>>>> +                       return rc;
> >>>>>> +       }
> >>>>>>
> >>>>>>            if (regs->enable_mask)
> >>>>>>                    rc = regmap_update_bits(vib->regmap, regs->enable_addr,
> >>>>>> @@ -242,6 +287,9 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
> >>>>>>            { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
> >>>>>>            { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
> >>>>>>            { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> >>>>>> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
> >>>>>> +       { .compatible = "qcom,pm7250b-vib", .data = &pm7250b_regs },
> >>>>>> +       { .compatible = "qcom,pm7325b-vib", .data = &pm7325b_regs },
> >>>>>>            { }
> >>>>>>     };
> >>>>>>     MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>
> >>>>>
> >>>>>
> >>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry
