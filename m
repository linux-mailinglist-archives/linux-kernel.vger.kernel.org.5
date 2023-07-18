Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184AF757CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGRNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjGRNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:09:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F76AF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:09:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5700b15c12fso57409027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689685744; x=1690290544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=arlaxmSPjr+t49XEWI2/MiuInUH3guP7HZZCse70XY8=;
        b=mxJQziMe1+EUYzx/QahnAIuck+FYWaKf+SVKYZuvBv8cjOo7mfwV+1aMFfaLV39nkX
         00VfhiSeaaTFXA2xFr4gji6QqOuOSycg/rRdgDmTu4J/eLp5wI1v/dKyWuW38F3W5HCO
         A6RCKr1zmyX6/5EzgsiM+HU17nQaOAGt1kSFO2GTRPhwDWZYmqpLttF4RStISKpbc3ZV
         6CxPyVQWkyua2NYR6JbuC2GfM0nWkF/TFG6sFuBfDubLJjWKgf9KFBi4/W0ZnWSe2SI7
         14lYDcPtfxjZJbWCu2Zzn2rH23x0jGuSezFNU0HvQci/hjfZQCs0ZMJbyVZUnMee/tjo
         iypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685744; x=1690290544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arlaxmSPjr+t49XEWI2/MiuInUH3guP7HZZCse70XY8=;
        b=EEcPKjrkXl0JFeqWAgfZfjwGB/iXc0+USo/JYDhkKH7qBgMgAXkZ0v+fjuAFLM74S/
         p/WXeKjfJMhbNpjPD8S3BPBLK530H1lnZOaVUU7OGxIh07w3oHrygJzBqAMW18x0QT38
         SiwrDtMMzGzdZrcuQ8OGO12nIJPzuWyv8M14r7lw9947wM5axLeeDtzLl7Ln73xlf8oj
         4CvFnv/FDBmFFZgiUpK5B+M21TVtph/Y477eTKv6kv++Y0Uk94iDvCjX+sDfzsVN90/8
         fmJVu4RuESFY1wphy31NkNtOO948Xhkacgxr+xvFnMXuyr67m8r/A/d1aRYacEohhtnD
         gVIQ==
X-Gm-Message-State: ABy/qLb2+vwYNil3a8HWqo3mkO8ABn8Tby+DpAFiOvsftSHbj283EsuD
        mNAQ05qkHHDgPfsKRNEcljmZWLK33FntqNc5lB1sYA==
X-Google-Smtp-Source: APBJJlHK6AyLaAaLUSgPySkhrZdE9+hpDzVV8P2eZl0JHEVw4D2MnsNuSQW/tb8MXm2p7mfzFFevlgeh5Hex06CshMU=
X-Received: by 2002:a25:3446:0:b0:c6d:e3e3:5592 with SMTP id
 b67-20020a253446000000b00c6de3e35592mr12933036yba.54.1689685744321; Tue, 18
 Jul 2023 06:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net> <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
 <ZLVyvHnKPdOfqAck@gerhold.net> <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
 <ZLV5CirE8CZfCjkX@gerhold.net> <9b28a17a-fe9c-3ff0-fa1d-320e75e174d0@linaro.org>
 <ZLZ94Qc6x1HyjJPQ@gerhold.net> <d087d0df-0bf6-c93a-7999-f9385ebb7a38@linaro.org>
In-Reply-To: <d087d0df-0bf6-c93a-7999-f9385ebb7a38@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Jul 2023 16:08:53 +0300
Message-ID: <CAA8EJppFaYPm33Z-_a+AgKYcWsaPE_y=B+agYVQ8z0ncfrvUAw@mail.gmail.com>
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, 18 Jul 2023 at 15:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 18.07.2023 13:56, Stephan Gerhold wrote:
> > On Mon, Jul 17, 2023 at 09:18:21PM +0200, Konrad Dybcio wrote:
> >> On 17.07.2023 19:23, Stephan Gerhold wrote:
> >>> On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
> >>>> On 17.07.2023 18:56, Stephan Gerhold wrote:
> >>>>> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
> >>>>>> On 17.07.2023 18:28, Stephan Gerhold wrote:
> >>>>>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
> >>>>>>>> The GPU_CC block is powered by VDD_CX. Describe that.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>>>>> ---
> >>>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
> >>>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>>> index 29b5b388cd94..bfaaa1801a4d 100644
> >>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
> >>>>>>>>                        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>>>>>>>                                 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> >>>>>>>>                                 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> >>>>>>>> +                      power-domains = <&rpmpd SM6115_VDDCX>;
> >>>>>>>> +                      required-opps = <&rpmpd_opp_low_svs>;
> >>>>>>>
> >>>>>>> Where is this required-opp coming from? The clocks in gpucc seem to have
> >>>>>>> different voltage requirements depending on the rates, but we usually
> >>>>>>> handle that in the OPP tables of the consumer.
> >>>>>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
> >>>>>> but quite obviously the GPU won't work then
> >>>>>>
> >>>>>
> >>>>> The levels needed for the GPU clocks to run should be in the GPU OPP
> >>>>> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
> >>>>>
> >>>>> I still don't really understand why this is specified here. :)
> >>>> The GPU_CC block needs this rail to be at a certain power level for
> >>>> register access. This describes that requirement.
> >>>>
> >>>
> >>> Can you show where this is defined downstream? On a quick look I didn't
> >>> see something like that anywhere. Or is this from some secret
> >>> documentation?
> >> As far as downstream goes, you can notice that no branch's or RCG's
> >> vdd tables ever define a level lower than the one I mentioned.
> >>
> >
> > As far as I can tell the vdd tables are only used when the clock is
> > actually enabled though, not for writing to registers while they are
> > disabled.
> Maybe, but you can also notice that even XO rates require at least
> SVS_LOW to function.

But the vdd tables are related to clock rates, which, in the upstream
design, should be voted by the consumers, not by the clock driver.


-- 
With best wishes
Dmitry
