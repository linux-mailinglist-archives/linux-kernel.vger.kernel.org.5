Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E1756A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGQRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGQRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:23:36 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81917132;
        Mon, 17 Jul 2023 10:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689614610; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lxSdN8cZdv75dHwPIwsc9WJ3RtB/RYH/eh9NW9nNJcn0kZtuFHvAYXDhkhaP2mr231
    l/ke1FVGOFaFyeiqfqm7YhqAvKyBT3dMyTq+OR7LP+PT8qmkh0mWGNWHy3HVkGxd4iSv
    2K76q+qsvJMi1rp4yFJzPcTA0ErrPNZHvXiJfMfwmKWdy3KyMGmGFjCZ8O6w1CHWwZLY
    4ovG5nnSe5sjTHqEt0HDR29IoKhIVaFs5cQYS9lNlYTvvB2v/TEhdc9qA4LpcMINVNVr
    H66zN+c9KdTOerZlklfJURRVXFCRaJs3P7ux2att6pDfswIdkLMelB/e6wdiGtQ05SKl
    lPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689614610;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6YvT8KyFmk2blzole/o44X9tAPFi2f8x7nEQPBe055U=;
    b=iPM4ahBfm0rRT1zkckGkmSqjhNKDU2+nrUGg82BuKLzlAMqRoEb5j1i/EjgXWFBwU0
    5CGnenYzRhqVlw3zDPkxUNLKLBImhXi5dhmzw7JOzgHCNtePyQSoq5EtveTLEAQ4cCzd
    kKM9Ja4nRV4ixBqM8VtBKNMQBtAbnxFaxxLwyPPE2GSbWBPuFEmnWncTi/F0UOS5xNDw
    cT42/T7Z/ftQ7LevtIMjTRjC1iBCSONvBdJFz7KGPuKK5iwIgWeR840lDuh1IWQhKsxi
    0mZGBz7jogLwjjXJKb43OS7A/la+LeLe2+L90lT3xJccpGD7ieZlBJuOOMoYgnW0wAyu
    oFLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689614610;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6YvT8KyFmk2blzole/o44X9tAPFi2f8x7nEQPBe055U=;
    b=CtVpT3fUBk2QRNtTvvUIfT7qVpvQymTDKDjUIIrDeJ3thZRK7MPp8jV9TPU/vTeXSQ
    OJfYKOvpKkM885G1gJ9TClFF28BitGRYFB8nih6EEWGYquUKheAL8pzTmjBoJXPhlq9c
    jiw61w1j7TpCrL38XnyMlGhP6A0oufYWl3ZKHlXiSUQ6lafHFfI9G0wVHPhLbLEZFay9
    YEaX8K71oyTjwpeZV/Yafat+k12UoNxcM4/o+S5L8XjuCl6MNxLq3gbgt+MhR14vEP5V
    +4lTC7w5oMake8rKjCyk1TITziRkHdVb53vQsRaCVnAHYfqAcm/I9LeD5cDXrVb+C+F1
    +REg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689614610;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6YvT8KyFmk2blzole/o44X9tAPFi2f8x7nEQPBe055U=;
    b=chN/WRxqZZAL1nKWT1fAdt+14nG/D71KEpm/G5wxEw8747CbPPmBwMDU/h3K+0Qqkr
    ZgDmGWVuhsHM1hv0yRDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HHNTZHI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 19:23:29 +0200 (CEST)
Date:   Mon, 17 Jul 2023 19:23:22 +0200
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
Message-ID: <ZLV5CirE8CZfCjkX@gerhold.net>
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Can you show where this is defined downstream? On a quick look I didn't
see something like that anywhere. Or is this from some secret
documentation?

Thanks,
Stephan
