Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914E9758055
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGRPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjGRPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44ED171A;
        Tue, 18 Jul 2023 08:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7318261627;
        Tue, 18 Jul 2023 15:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D706BC433C7;
        Tue, 18 Jul 2023 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692567;
        bh=sy7DCojCRG8d7aqK80NuXkkijlk7Z0axQrX85V5IRrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnSKhCaobgOyjj4OaIVde77zX9hr/BJiYdfIQd3KHcHYfRZY/b4Kn//JZry0UGtaU
         o8vdAOJBpAGQ4xEhieCd+t+yfrjgSIt71X5oAM2v/wu7sEaX9myytOKHGJguXzLMwZ
         OhYkTbnj6BhHwXoicueU/T1WQgGb5L2PKGY6A7xIqLOsQ6gHEgsA6FPGW+hD8LT7lP
         cIcZ8XqIVwHDv7dJTSnm3ihjAHZMBaXMQ3fXIe3nZX7wAwzb8MeL9IPhdYCXDW9q7f
         kYkB0CHyyDajGAfR+omS7E6B3IZUafuxwy7uSmRHLeP6xRFSHvOHJGc6KjjCvvPNDy
         XBBubkYth0XUg==
Date:   Tue, 18 Jul 2023 08:06:11 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
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
Message-ID: <yk4xiydi47e7dn3zhasmnhgjc3l23napvznioshm2xx7uf5ziw@b7htk7ixes5b>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net>
 <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
 <ZLVyvHnKPdOfqAck@gerhold.net>
 <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
 <zha5rmva3zhvvknnmeso6errwhkdjomk6r5d72an7moimdvymq@skow5jqtps5g>
 <18e192cb-eafe-3aa9-6602-b1a9dbe020d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e192cb-eafe-3aa9-6602-b1a9dbe020d5@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:21:31PM +0200, Konrad Dybcio wrote:
> On 18.07.2023 06:25, Bjorn Andersson wrote:
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
> > And that is not the lowest level reported by command db?
> > Please describe this part in the commit message as well.
> command-what? ;)
> 

Apparently doesn't matter that I read that line multiple times, my brain
really wanted a 'h' in there.

> RPM exports VDD_NONE (off), VDD_MIN (the lowest state before collapse)
> and then low_svs is usually the lowest "actually on" state for all
> consumers.
> 

In rpmhpd I changed it such that the minimal enabled state would be
!disabled (so that the automatic enablement during probe would be
sufficient to access registers), but talking to Ulf this is
provider-specific.

So unless you can figure out a acceptable lowest non-disabled state this
is what has to be done...


PS. My ask for mentioning this in the commit message still stands.

Regards,
Bjorn
