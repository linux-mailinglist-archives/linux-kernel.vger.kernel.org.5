Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE1756917
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGQQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:28:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DAB191;
        Mon, 17 Jul 2023 09:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689611320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TxN3ptB8TJ6yQXOez25FmsPlGHDfaoOtLRQzozLZr26Qfm9ByRqv4ZMgRtYqQoU+aa
    IkAylqfV7dYeTu0R0g07RdiV38P7TKcCt2kqUZ4Wk/F8FZLcluPtHmTuVrgx2HQQ5eHz
    6uf1UrKejPY+HpPrJY1XC1TgJZvDYZMe6hzZDuQAhwoIjTdpDDOltbH0e8DrL7/JD1t5
    1E5c8ISwfUJXTDyj7ZrVMauvW+Q5cJPZa1NBvx8MLupiBVit7dhe+ma/G23VvPO8JRJZ
    u8HQyCSsESaIm7Ea4HJtzbf11eATGdb6irR+E/oJw4ZmMnveLbPdAUqi+WimecL3DvJW
    rlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689611320;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dZFLrSk66UYp7OAUD98hNzXLHwBxgqQLoMU4bLna6aU=;
    b=ZQIbpA7wMe6TSSlHQaM+EvaL8EmWmEWI99FR1TqucNvwSAxJ1ThJyeO4wTDlcNakwT
    aIZwB1C23uEOGUXibmy53nva9L35NirmueO6Q1cYX8lJ28JYK9+xRIYIgWax3MA27Fqb
    y/AztOnGBRMLSOpCDL6efyTUf+NamFq25ueAQzMPvRnRqa9MMI3sY1EBitM+q1FxNrwL
    O6+dEfNkTt8jLeAEVY3gHPwahBLAsk1TZ4N/oOd/pac8HrM89j0YvHaxhprcB7xI1hsP
    G83/ys9GzckDe7fwNVUzXHTuhyIHpt99DYGs4dvguSu4GxPeMw3Viq2ehlWfMgIEnrog
    XHbw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689611320;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dZFLrSk66UYp7OAUD98hNzXLHwBxgqQLoMU4bLna6aU=;
    b=aeaAIHja89VAPmM40foHQP3GOU4n6ksSMUcYmWqX27Jl83H34SIn21o1IpR+alDfqc
    xJqKnZFtBaQsyNDPttkB1yfsJVVxm88QQEmh3QtP5XPdBZwi2+Q7RoCTZMKRpbI/y6M+
    cG2wYP1pveYFmwMKU3fIXy9MOiDYcjED64zrGAdhzh2TZ5IMatBlWmr8r2jy8kRAvGxi
    kOBARUWxcXY+RYMEpEq1WxvXueqjlW7rmPq/xOu4hrhlcqbriy3x2rsSF5Y1hi9n0zma
    V9Y0+sNDZhs2ndX5apuXOphLFuZu1SDSbv+jLi8zIsg5oFEu60lp1umeh8GTxbmpr1iJ
    zL4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689611320;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dZFLrSk66UYp7OAUD98hNzXLHwBxgqQLoMU4bLna6aU=;
    b=MvqkobRSWCLCbTT85QaoRyNXN47vawJ6h4tOX+UY8PIdoHjPjQTXa8toQK1OxtCtDh
    ohkpM7xYH8THMqIMKtCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HGSeZCQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 18:28:40 +0200 (CEST)
Date:   Mon, 17 Jul 2023 18:28:39 +0200
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
Message-ID: <ZLVsN40kYsvQm1z6@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:22PM +0200, Konrad Dybcio wrote:
> The GPU_CC block is powered by VDD_CX. Describe that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 29b5b388cd94..bfaaa1801a4d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>  				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>  				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> +			power-domains = <&rpmpd SM6115_VDDCX>;
> +			required-opps = <&rpmpd_opp_low_svs>;

Where is this required-opp coming from? The clocks in gpucc seem to have
different voltage requirements depending on the rates, but we usually
handle that in the OPP tables of the consumer.

Thanks,
Stephan
