Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8957572C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGREWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGREWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D81B5;
        Mon, 17 Jul 2023 21:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7159F61375;
        Tue, 18 Jul 2023 04:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEDDC433C7;
        Tue, 18 Jul 2023 04:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689654127;
        bh=DH3pvRF8EX3slaZ3uZwiwp2DM3ieEzqPgVab6Ze81ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2CBYhXj3IVTEKGJ6q4hMRkvcKdg9DabM29jVtDeUkhbDUXHHkQE9R4Kx86/FqgVK
         uvMycjb/4BYM+mAX2t9doAFtfV+IJFl/fKK/VZi04cMWLODrQt5ZVWNJqaKpZLqSQf
         4Z0kxr3IKyykQFxbismwByYDYTvod+KDrMk9qJCz7sy4IZ5jy6WdTyIUlSKV+SDajr
         MlYI7fhenuI11CjYMSOrVJHKviKvGtSlSf1xeawpSKAEujA5D0zy2zlMOzrmGrldPZ
         ieaj6G2mpgxQBsPvUhv0/Occ6jrKd2g0oDjp4nf6jKTRAQ857NMgiqMzkirlJjsHyp
         N2GdHL4wwKjPg==
Date:   Mon, 17 Jul 2023 21:25:31 -0700
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
Message-ID: <zha5rmva3zhvvknnmeso6errwhkdjomk6r5d72an7moimdvymq@skow5jqtps5g>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net>
 <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
 <ZLVyvHnKPdOfqAck@gerhold.net>
 <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5dc146-c305-bef9-0d97-76a91345ed1a@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:11:33PM +0200, Konrad Dybcio wrote:
> On 17.07.2023 18:56, Stephan Gerhold wrote:
> > On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
> >> On 17.07.2023 18:28, Stephan Gerhold wrote:
> >>> On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
> >>>> The GPU_CC block is powered by VDD_CX. Describe that.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>> index 29b5b388cd94..bfaaa1801a4d 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
> >>>>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>>>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> >>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> >>>> +			power-domains = <&rpmpd SM6115_VDDCX>;
> >>>> +			required-opps = <&rpmpd_opp_low_svs>;
> >>>
> >>> Where is this required-opp coming from? The clocks in gpucc seem to have
> >>> different voltage requirements depending on the rates, but we usually
> >>> handle that in the OPP tables of the consumer.
> >> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
> >> but quite obviously the GPU won't work then
> >>
> > 
> > The levels needed for the GPU clocks to run should be in the GPU OPP
> > table though, just like e.g. sdhc2_opp_table for the SDCC clocks.
> > 
> > I still don't really understand why this is specified here. :)
> The GPU_CC block needs this rail to be at a certain power level for
> register access. This describes that requirement.
> 

And that is not the lowest level reported by command db?
Please describe this part in the commit message as well.

Thanks,
Bjorn
