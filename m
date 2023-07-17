Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1A756E21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGQUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGQUW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:22:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1AC188
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4699399f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689625375; x=1692217375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVm6xqTAMovgZP1MWiXzIK7jmnveUFt2SptueGxYvZo=;
        b=fVemw9zS0Ld/+8IajV1FrjWYOfEqR1lQKULYEsfxuv7gn7c0Qd6rJgttJT4uMvEtOH
         9drArBe9VGxi+yAUDA/dx3jPXjMB5SHeWdF7DdYpS7kldsdM8didOoQ6X+z24ibkUA48
         bZOIU/dN9PDYuBTOBkGnBdbpqNY4SBeTy/oAM6tVZMB/2uYiWwrb31iu1VUqKU8Ylx5c
         6oyVOD2UPUoZGG2WiXfBz4Fpql5/hxxuS92ulFL+EeLAZSqCosxUGtcBsb1TPwjtm+pA
         AsYNSgN0/V+d5bywsatk6OYcy7xygMKT9buH6rjxzo+L99dFLp1Z6T+FVz07XxLFyqKX
         53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625375; x=1692217375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVm6xqTAMovgZP1MWiXzIK7jmnveUFt2SptueGxYvZo=;
        b=BNmg5t1T2OEQdAKmBhTYH+kr62V9qcJZApwqTYvjLnVbhLk1CAX1W6LL5BTi/EsuHQ
         aP2Q4wqONgwNVF+octxF2+LVUU7ee0aeNz1/WWKDmURyEIUeQ7CfL2S8wDwfnoX0QfkB
         6VwnvBklarfa2OTQEG+a9JKln4peGrvgN8sG2CHfcWtIldN04Bp5byeZYDdLZiA82mA/
         OtqCnc6Gd8HWHVN8oIYPZI/hIC6PpE5BmuHfam5N6yj8EeQ5ZOnJE9uE2Nn6NVt7OEzt
         HMhLdTvy1GYvY8i4Vm4XaCaI+BUFV33CV5xyjM6qoLHNSoVg0S5acaiWEEhM+oZhoPkI
         PSMw==
X-Gm-Message-State: ABy/qLb5Dr/2Bd0Kqv4AeenGSdp9d91aeze+mkGaDB8fG7JRj3y2FEk2
        OJtcKujo9LgK+n10iXEPI7x4dUbLajylYdE0OdUdAA==
X-Google-Smtp-Source: APBJJlHZdKoPwU0S0zQns0o1mpUJ283hHTO02vOYk1GumNjjIiH48bS17QDUzgdq0FuvYNxCn63QHHwLSm+T0NYuaxY=
X-Received: by 2002:adf:ed50:0:b0:313:fff0:ff40 with SMTP id
 u16-20020adfed50000000b00313fff0ff40mr10168012wro.31.1689625375528; Mon, 17
 Jul 2023 13:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org> <ZLUbyocjNT2bGvVt@gerhold.net>
 <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com>
 <ZLWHwnjjMkJx_ACH@gerhold.net> <CAH=2NtxHekJVvzaD5SNhZZmAHXhc=7v4Pr7RMEFNTXXH6x_AgQ@mail.gmail.com>
 <81491f7e-bd2c-7e3c-14c4-a7547d76c307@linaro.org>
In-Reply-To: <81491f7e-bd2c-7e3c-14c4-a7547d76c307@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 18 Jul 2023 01:52:44 +0530
Message-ID: <CAH=2NtxX9jC6-7=bWEWTtgO=5VqX5U_ngnC6vWFZxDJUdsdg+g@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, quic_schowdhu@quicinc.com,
        gregkh@linuxfoundation.org
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

On Tue, 18 Jul 2023 at 01:49, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 17.07.2023 22:09, Bhupesh Sharma wrote:
> > On Mon, 17 Jul 2023 at 23:58, Stephan Gerhold <stephan@gerhold.net> wrote:
> >>
> >> On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
> >>> On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
> >>>>
> >>>> On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
> >>>>> Add the Embedded USB Debugger(EUD) device tree node for
> >>>>> SM6115 / SM4250 SoC.
> >>>>>
> >>>>> The node contains EUD base register region, EUD mode manager
> >>>>> register region and TCSR Base register region along with the
> >>>>> interrupt entry.
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
> >>>>>  1 file changed, 50 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>> index 839c603512403..db45337c1082c 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>> [...]
> >>>>> @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
> >>>>>                       #power-domain-cells = <1>;
> >>>>>               };
> >>>>>
> >>>>> +             eud: eud@1610000 {
> >>>>> +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> >>>>> +                     reg = <0x0 0x01610000 0x0 0x2000>,
> >>>>> +                           <0x0 0x01612000 0x0 0x1000>,
> >>>>> +                           <0x0 0x003c0000 0x0 0x40000>;
> >>>>> +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
> >>>>
> >>>> TCSR is a separate hardware block unrelated to the EUD. IMHO it
> >>>> shouldn't be listed as "reg" here.
> >>>>
> >>>> Typically we describe it as syscon and then reference it from other
> >>>> nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
> >>>> "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
> >>>> same use case as you have. It also uses this to write something with
> >>>> qcom_scm_io_writel() at the end.
> >>>
> >>> That was discussed a bit during v1 patchset review. Basically, if we
> >>> use a tcsr syscon approach here, we will need to define a 'qcom,xx'
> >>> vendor specific dt-property and use something like this in the eud
> >>> node:
> >>>
> >>> qcom,eud-sec-reg = <&tcsr_reg yyyy>
> >>>
> >>> which would be then used by the eud driver (via
> >>> syscon_regmap_lookup_by_phandle()).
> >>>
> >>> But for sm6115 / qcm2290 this would be an over complicated solution as
> >>> normally the eud driver (say sc7280) doesn't need tcsr based secure
> >>> mode manager access. So defining a new soc / vendor specific
> >>> dt-property might be an overkill.
> >>>
> >>
> >> IMO a vendor-specific DT property is still better than messing up the
> >> device separation in the device tree. The same "tcsr-base" reg would
> >> also appear on the actual tcsr syscon device tree node. Having two
> >> device tree nodes with the same reg region is generally not valid.
> >>
> >> Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
> >> clear that this points into a region that is shared between multiple
> >> different devices, while adding it as reg suggests that TCSR belongs
> >> exclusively to EUD.
> >
> > I understand your point but since for sm6115 / qcm2290 devices TCSR is
> > not used for any other purpose than EUD, I still think introducing a
> > new soc / vendor specific dt-property might be an overkill for this
> > changeset.
> Untrue, there's some mumblings around the PHY properties and PSHOLD.
> I think Stephan may be correct here.

Can you share the links to those discussions?

Thanks,
Bhupesh
