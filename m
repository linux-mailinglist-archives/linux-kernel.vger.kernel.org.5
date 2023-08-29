Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672778C2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjH2LBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjH2LA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:00:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE001AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:00:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bdcbde9676so3400286a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693306847; x=1693911647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nUHOxNEJD6JLKxuML1GAJwSutNvA6Hh3RXeO5xIv2E=;
        b=oEr9nUwYPovvAoulUEO4+4qCM3pkIUIzadQuuGIgx610hmMQqXXoVbJFB7hCwu16gM
         0wcEN12/Bc+kLQPhpF90NY5KFrBR0BGuN9K+OIiZ2Wltjn0s8yvekAAPUleJuCsgJBm+
         pXBJubGfA9CpqTlUBYoyrwvRajS1LFvdKZ/1DCgxxQjk7a0kbOnP+XYkf1GeFJlIKmdy
         xy6Fe3nJADUYgJgGx7UMnKO487yD+jU5qt9By1obATLPrYWTDww4SyBZ5SdesJ9sFZ4l
         YY5w9YVinRXJhE/zR4fLayszK8gwY00cEHJAe020zhhrJumb1dygyYuduBe6ucIu1Gni
         9XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693306847; x=1693911647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nUHOxNEJD6JLKxuML1GAJwSutNvA6Hh3RXeO5xIv2E=;
        b=AnPHbrEn7sLisG6pzANnD0F1TYl9bf1XFaJXNmdAlxiKmuGRLKfYyeX6OyAlrz3TtY
         hEggx2NOHyjxzEhfQuN4+4eCMv2aKhlxyIq4p81va0NMs2F/QEp9T9oUdCQwOY5/ohsX
         qPog+zxYCdSAYv84Y8LSXz48rqmTxjJHastU3tKw8faFbvxO97xh24BV51P39KZ5bMUO
         +4zoo8GObCD2XRYnr5ZmID3kn/gwhmVFPhHiUQh/FWfJqOxQ5gEkvxylqlyb06OeBOjB
         HwBe4qdV8Q7HHVPwEX85uL5GYz+xfKH1N3Z2ZdVRhtbMfeti9TgrRdW6YyHy2sXqvRug
         hEPQ==
X-Gm-Message-State: AOJu0YyqPd+Qru3S4FMwOFBDdVgHqj8ratGEbH1mBXYBajYy6dYSgtJi
        oGhBAv2Guh7yrBoG53sxwj4GyQxh/pt4+lIXiTIZPA==
X-Google-Smtp-Source: AGHT+IGPUiLzVgjgWh9fiiioLPrHwr1z4UoqxY3GTH10qfFEKGCE59NnkBnaX9HjmzDykHYIZXfE+quDW+mNQwitcY8=
X-Received: by 2002:a05:6358:429d:b0:134:c984:ab74 with SMTP id
 s29-20020a056358429d00b00134c984ab74mr27793268rwc.9.1693306846639; Tue, 29
 Aug 2023 04:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-4-quic_gokulsri@quicinc.com> <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
 <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
In-Reply-To: <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 14:00:35 +0300
Message-ID: <CAA8EJpojzVPVcL=7DHfd5Gvo84xdFwgZQFiE6pQy1gqd72Vy6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
To:     Robert Marko <robimarko@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 13:59, Robert Marko <robimarko@gmail.com> wrote:
>
>
> On 29. 08. 2023. 12:12, Krzysztof Kozlowski wrote:
> > On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
> >> Add the APCS, A53 PLL, cpu-opp-table nodes to set
> >> the CPU frequency at optimal range.
> >>
> >> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 34 +++++++++++++++++++++++++++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> index 9f13d2dcdfd5..05843517312c 100644
> >> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> >> @@ -8,6 +8,7 @@
> >>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>   #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> >>   #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> >> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> > c is before r.
> >
> >>
> >>   / {
> >>      interrupt-parent = <&intc>;
> >> @@ -36,6 +37,8 @@ CPU0: cpu@0 {
> >>                      reg = <0x0>;
> >>                      enable-method = "psci";
> >>                      next-level-cache = <&L2_0>;
> >> +                    clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> >> +                    operating-points-v2 = <&cpu_opp_table>;
> >>              };
> >>
> >>              CPU1: cpu@1 {
> >> @@ -44,6 +47,8 @@ CPU1: cpu@1 {
> >>                      reg = <0x1>;
> >>                      enable-method = "psci";
> >>                      next-level-cache = <&L2_0>;
> >> +                    clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> >> +                    operating-points-v2 = <&cpu_opp_table>;
> >>              };
> >>
> >>              L2_0: l2-cache {
> >> @@ -54,6 +59,17 @@ L2_0: l2-cache {
> >>              };
> >>      };
> >>
> >> +    cpu_opp_table: opp-table-cpu {
> >> +            compatible = "operating-points-v2";
> >> +            opp-shared;
> >> +
> >> +            opp-1008000000 {
> >> +                    opp-hz = /bits/ 64 <1008000000>;
> >> +                    opp-microvolt = <1100000>;
> >> +                    clock-latency-ns = <200000>;
> > And the rest of OPPs?
> Hi Krzysztof,
> IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
> by default from the bootloader so there is only one OPP.

If the bootloader sets it to 800 MHz, then this frequency is also
somehow 'supported', isn't it?

> I am glad to see more SoC-s gaining CPUFreq support.

Definitely.

>
> Regards,
> Robert
> >
> >> +            };
> >> +    };
> >> +
> >>      firmware {
> >>              scm {
> >>                      compatible = "qcom,scm-ipq5018", "qcom,scm";
> >> @@ -181,6 +197,24 @@ v2m1: v2m@1000 {
> >>                      };
> >>              };
> >>
> >> +            a53pll: clock@b116000 {
> >> +                    compatible = "qcom,ipq5018-a53pll";
> >> +                    reg = <0x0b116000 0x40>;
> >> +                    #clock-cells = <0>;
> >> +                    clocks = <&xo_board_clk>;
> >> +                    clock-names = "xo";
> >> +            };
> >> +
> >> +            apcs_glb: mailbox@b111000 {
> > 0xb111000 looks lower than 0x116000.
> >
> >> +                    compatible = "qcom,ipq5018-apcs-apps-global",
> >> +                                 "qcom,ipq6018-apcs-apps-global";
> >> +                    reg = <0x0b111000 0x1000>;
> > Best regards,
> > Krzysztof
> >
> >
> >



-- 
With best wishes
Dmitry
