Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426F757B08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjGRL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGRL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:57:46 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A541A5;
        Tue, 18 Jul 2023 04:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689681462; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q39R8bTMaXXKb81rUIVKJYBY8FV6VF4CobR7EBjfvs801tAZD34lSjDOxTPNa9+4GU
    2jEUzFY9B2rmUGipYDfFm3Iv0NxU2amM44iMA9X2m8OsYVs2MaOzbuG6TujEizeqrx4H
    CsZNCGf1kQvr0gBM/FFFySvxtXmB/F8TJiz+TBdGvbEDiDvjZOtuD4CXEYVg6R6DoCZ0
    eSY/HvWwPrUWpoLeBt1rzZufhvhAv/roVR62K13gODNi7GT43JQdxxMJE+5amL58oV4M
    0bIcgOJ/6MxfouKGRlDvOdo9XtkFRguBCOmeb5TvgrSEhv92n/gNpGk0uN6hWzY5jIHg
    f/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689681462;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Sb0pqlb1077vNwse8z8g8xfC2iPAIQzF3zf4V9j8Ktc=;
    b=iz39F9q96LypRzGabbiUfTFskYA6oaJCjDtgH8GbLMJo/1gPmV3yrfNIhIr8WkH02r
    lH6Co18PFi5hH90fiBRRDw9en2UCK6W1WK47/5fsJLmvjZNpsPw83PQAS9iLYj2jbttv
    pZDbNmFQldlRZ32OklvPuHld7m67pancgCkfbB0qZp1Spu3Ssr8ieJajZrnPkrFLGGvT
    Wp/VM9oIgLMq48zmSFM89eJh8dvcoKie3A23fyedovf37bu6mMYtSltvRYWqgKNtm5bG
    lvyad7XjlsA/tOfiw112oSTbhnuzYEb/XruD4pGyIKyl/qGEJHLpAZoNAK/peo/nuAas
    bHsg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689681462;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Sb0pqlb1077vNwse8z8g8xfC2iPAIQzF3zf4V9j8Ktc=;
    b=VynGfbgdQsUP/am6BUpvjuBX8C6FysttYQ2ECREV/hwC3VqLJeKZOSCk5JHHsguzOy
    Amn4BygG90sNBGnMz/WZe7PFq5E0qcN9EzYysQ2mcYUMABET4CFx5T4mrcinuRSyUsEt
    E6Nd8UtTHrzle5HhtgD96Nyxs0ZNv+GkycOjFpDhTc69XGu0302KJbuF6peN2zMQYKxq
    7VYvnkPe0gmCK1Fg5gWxQzoiShHZB4N2ybQstRl2r7fHDXdNlqNCxRK7ENBQvAhXusvR
    vi0nP5jTETQfUuQ1ftMsS6413uCjxdEOyignBxGIEU2xqv9EA9LqSz2r7vCH3NF1SpoO
    OnmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689681462;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Sb0pqlb1077vNwse8z8g8xfC2iPAIQzF3zf4V9j8Ktc=;
    b=1/lQ9gZSgnOq7n3U0Nhl9yk9LY03oFl3fMvQMKXsXiui9VLD/vCz19S6pWQHWIaAOO
    buWtDRqqKWH1rGoJHDBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBvgbuN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:57:42 +0200 (CEST)
Date:   Tue, 18 Jul 2023 13:56:45 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
Message-ID: <ZLZ94Qc6x1HyjJPQ@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net>
 <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
 <ZLVyvHnKPdOfqAck@gerhold.net>
 <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
 <ZLV5CirE8CZfCjkX@gerhold.net>
 <9b28a17a-fe9c-3ff0-fa1d-320e75e174d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b28a17a-fe9c-3ff0-fa1d-320e75e174d0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:18:21PM +0200, Konrad Dybcio wrote:
> On 17.07.2023 19:23, Stephan Gerhold wrote:
> > On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
> >> On 17.07.2023 18:56, Stephan Gerhold wrote:
> >>> On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
> >>>> On 17.07.2023 18:28, Stephan Gerhold wrote:
> >>>>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
> >>>>>> The GPU_CC block is powered by VDD_CX. Describe that.
> >>>>>>
> >>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>>> ---
> >>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
> >>>>>>  1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>> index 29b5b388cd94..bfaaa1801a4d 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
> >>>>>>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>>>>>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> >>>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> >>>>>> +			power-domains = <&rpmpd SM6115_VDDCX>;
> >>>>>> +			required-opps = <&rpmpd_opp_low_svs>;
> >>>>>
> >>>>> Where is this required-opp coming from? The clocks in gpucc seem to have
> >>>>> different voltage requirements depending on the rates, but we usually
> >>>>> handle that in the OPP tables of the consumer.
> >>>> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
> >>>> but quite obviously the GPU won't work then
> >>>>
> >>>
> >>> The levels needed for the GPU clocks to run should be in the GPU OPP
> >>> table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
> >>>
> >>> I still don't really understand why this is specified here. :)
> >> The GPU_CC block needs this rail to be at a certain power level for
> >> register access. This describes that requirement.
> >>
> > 
> > Can you show where this is defined downstream? On a quick look I didn't
> > see something like that anywhere. Or is this from some secret
> > documentation?
> As far as downstream goes, you can notice that no branch's or RCG's
> vdd tables ever define a level lower than the one I mentioned.
> 

As far as I can tell the vdd tables are only used when the clock is
actually enabled though, not for writing to registers while they are
disabled.

Stephan
