Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB37569B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGQQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGQQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:56:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062FDE9;
        Mon, 17 Jul 2023 09:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689612995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NihYKa8b35sBjXFgjiTWayBpJFu/UIUP4gKrbVhGRAKFa8EMrhSTEypcss8nCPKXh4
    fewnNPMnkT+SdYLxAcfbQmwIxnXs2+KclDuin3rrSTJxcrDEdcGbV9c8rkoIofNAwsF1
    Ud6ohfP1rRsbpIqcMJH2GvQjGQJQZ3d0ymk8vgOeYWcaR/Z3UbdZlCAtwCXQHDwJgaMN
    55djRGbWrC6F0LQ1W1mDa6VE36aFRHqto4pLce2R6PEsqLaEbjn590Rqq/g0lkRPvxgk
    TdNRtG1hlAqWA1CHZHUcrQTWCMcEReKt2CUyb8GhQwdPPn3Wbar2ooeplcE7NJB0+8Hw
    gp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689612995;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2NGVNJk9WYrSe/K1zOjn61fuTdMMU3BdhSf06SpeD3A=;
    b=QSF+yzdPeMDsOUTlN3jpTYGLL3j5DErZufjySU+0fcamWSRDSx66NgRlnVXMMb+8Ns
    S5vcX+moVp7pPZt0TKFuPGYW1/x2KnrPJwM9It1YIwjyEhZ3R42SeGmEw8IrXBXKeGSY
    DI/0pbH2x5NpYstoAfFY5D0RmfpFD88+EVV+mkew1fv1LB5c1GbzCdkDsfUQKMWePJCS
    NxERtSuX/5gavk+r2nzytLbhaRepQoDmQY1UPdA8IKOVRYvv0E2JYDPNgec0yDGgLdLB
    CfXetdE7IbbrgRDo/Q5iXckQT1Dak/5Uwoc4K7t1IK4IgkccoBp/Y0nkLhp/M0c1wBlL
    WvVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689612995;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2NGVNJk9WYrSe/K1zOjn61fuTdMMU3BdhSf06SpeD3A=;
    b=WZSXa/GbfsAM+H85eIiJPOnNj5v2CnkiZNdKE8i3y7yQqXiWwCguEMoiuoZ8c3s1Gi
    U0U8fcigIxpOTgmBp2s6OvNZw3WzRBSmkHNekE3Bx++rjnkdTuW8mJz7QrnpwJ7MmQrb
    0Usz/hPNT4TnBiBC2Wg3lw9VGUWYcDadS9pzr2zQRN8djcgw53BCxcxb/tbFHUouOq9P
    slszsJZuVWR0gHzZr+HKyvedpptz1JS+05WbujyXJ051cUg9R6ZcQqNmW9DZ2ve4leRv
    Nbl+ui3zjupbbdhRwUGhKAINhFWaEUAeV2tL5BWFVA9o/luyG8mEnXgj//L+YYmfax99
    AH7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689612995;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2NGVNJk9WYrSe/K1zOjn61fuTdMMU3BdhSf06SpeD3A=;
    b=ynQLNcM37QkX8hcOgESam8ciabA0T3kpst83IYHkK5sRMeV1cmqwkv0joiwEWj3KDN
    rIlH3HMFPAf1uEJEwsDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HGuYZEo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 18:56:34 +0200 (CEST)
Date:   Mon, 17 Jul 2023 18:56:28 +0200
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
Message-ID: <ZLVyvHnKPdOfqAck@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
 <ZLVsN40kYsvQm1z6@gerhold.net>
 <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a193a4dd-0a0a-0d36-6d83-0424cd1dce80@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:50:18PM +0200, Konrad Dybcio wrote:
> On 17.07.2023 18:28, Stephan Gerhold wrote:
> > On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
> >> The GPU_CC block is powered by VDD_CX. Describe that.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> index 29b5b388cd94..bfaaa1801a4d 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
> >>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> >>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> >> +			power-domains = <&rpmpd SM6115_VDDCX>;
> >> +			required-opps = <&rpmpd_opp_low_svs>;
> > 
> > Where is this required-opp coming from? The clocks in gpucc seem to have
> > different voltage requirements depending on the rates, but we usually
> > handle that in the OPP tables of the consumer.
> The only lower levels defined for this SoC are VDD_MIN and VDD_RET,
> but quite obviously the GPU won't work then
> 

The levels needed for the GPU clocks to run should be in the GPU OPP
table though, just like e.g. sdhc2_opp_table for the SDCC clocks.

I still don't really understand why this is specified here. :)

Stephan
