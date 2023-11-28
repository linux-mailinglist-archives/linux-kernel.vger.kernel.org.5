Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D5B7FB937
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjK1LQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1LQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:16:16 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B69D6;
        Tue, 28 Nov 2023 03:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701170177; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EZUjOS8CVjo+FKaqJuD/a9DCglOaWeb2zwpKo10hEPcPMG+OXTX5i+T3NqVLLUKYuM
    FkzlY7UFeXuEFC4+D1259tUsMsRBGe4oon2/MkdO/12VMNAYb998ZrHbL6FToXR+nIfd
    CPtahqf54N0Ih8nA83eIoWDx0m9qVQ+zL6JtxO5QpDiahhHIGfekQ3GKKa+kpgqewlCA
    eGnJRSBhEQrQWsjnSy6+0KG3i6ZuuahdRXg2sQCpjhrTELoDspGFe1PlOROPoZQNOd/c
    VxXrnF1KeJBdFtOqUab8qHVvVYwTXjzNe8D9X7lIoHS5Qzi6nD6hcIfOKdMaWS0hKE1a
    OTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701170177;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+x5mzkgJdHdY5sgqZaJ2j6SzsEzsF/GGqVmkNqn5SdE=;
    b=d1b3UU4iiqpt/OG+fJnkaXwCSNVh6o8oLCQs1n9VaaI6o7w2g/74pWPJcES5+/Ih2p
    OMDYoff7G8Gr233XJn5KtI7bJt+lC6redqj1tNrFVqX2Hf1tZzjkuevo097J4LeBnj0b
    aeKevUTrNNQvLrI4arydJpjZdbVWcNwc4/az9BoODD1CLMZBFYf8Jolhqatc7cflRs1y
    Wjc80iLreyzQ8Bhs1HPd+MSZSkQEzAgC+yWsER1dfv1sKxC1njN+J5hBsS2QTfqDSAK3
    8JRcfShR62IgPJxoAUfvHIdoVgrS0N4ZcrIqGmWwnONKoDVRjxwMrFSjTxoEexc0TUjn
    FySw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701170177;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+x5mzkgJdHdY5sgqZaJ2j6SzsEzsF/GGqVmkNqn5SdE=;
    b=l5UdB6LjVzzwHxTDciJ+4+G6b/VMi9dUGicW7QDJ0NEkzNK7Qwaak0rPsXlueJ9ILz
    0RjvjizIyoOZv88kyeh/CXV1DiOtpPMd75HDVMClZP0Nk4FQlAWtRPdWGqN2m4a3L/1K
    veSCvPJIkcGsU+l0XFOH4asIA+x3VfOtSBWneKNmJILjdqmwTNvz58S13D7bvHS34z3p
    aiDgy/wt4dRsnyCNnXFXP4zelHI1LAnPMZNKDUKQ3iAlsXFe22hh9JpuDnuAvS3uAGOH
    Xr5yS+ZFvR/cq/GQ+gZZfZBHHUWvVtUsamUgb66/SgrKoZ/5cNsD8H6sxleycNfRS7C2
    hLcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701170177;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+x5mzkgJdHdY5sgqZaJ2j6SzsEzsF/GGqVmkNqn5SdE=;
    b=cvtpWXAuny8zip5VDrpRZSJIFLVpsFXIM705/Jx9exlp7ETkYvQAtYkSTCqWjjNcEk
    RfxSrRhubqY64mJB14CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id t3efe7zASBGGlnd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Nov 2023 12:16:16 +0100 (CET)
Date:   Tue, 28 Nov 2023 12:16:11 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Message-ID: <ZWXL-5OomtzRJCIj@gerhold.net>
References: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
 <20231124-topic-sm8650-upstream-dt-v4-2-e402e73cc5f0@linaro.org>
 <ZWWse_i-wjSTH8O4@gerhold.net>
 <fbbed866-fc43-4f30-94a1-942d38103e51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbbed866-fc43-4f30-94a1-942d38103e51@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:00:36AM +0100, Neil Armstrong wrote:
> On 28/11/2023 10:01, Stephan Gerhold wrote:
> > On Fri, Nov 24, 2023 at 10:20:39AM +0100, Neil Armstrong wrote:
> > > Add initial DTSI for the Qualcomm SM8650 platform,
> > > only contains nodes which doesn't depend on interconnect.
> > > 
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2439 ++++++++++++++++++++++++++++++++++
> > >   1 file changed, 2439 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> > > new file mode 100644
> > > index 000000000000..b0a9ca53d58e
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> > > @@ -0,0 +1,2439 @@
> > > +[...]
> > > +		timer@17420000 {
> > > +			compatible = "arm,armv7-timer-mem";
> > > +			reg = <0 0x17420000 0 0x1000>;
> > > +
> > > +			ranges = <0 0 0 0x20000000>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +
> > > +			frame@17421000 {
> > > +				reg = <0x17421000 0x1000>,
> > > +				      <0x17422000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <0>;
> > > +			};
> > > +
> > > +			frame@17423000 {
> > > +				reg = <0x17423000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <1>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			frame@17425000 {
> > > +				reg = <0x17425000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <2>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			frame@17427000 {
> > > +				reg = <0x17427000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <3>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			frame@17429000 {
> > > +				reg = <0x17429000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <4>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			frame@1742b000 {
> > > +				reg = <0x1742b000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <5>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +
> > > +			frame@1742d000 {
> > > +				reg = <0x1742d000 0x1000>;
> > > +
> > > +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +				frame-number = <6>;
> > > +
> > > +				status = "disabled";
> > > +			};
> > > +		};
> > 
> > Nitpick: Personally I feel the empty lines between each property here
> > are a bit overly verbose. It would be better readable without them.
> > Might be personal preference though :-)
> 
> I tried to maintain a coherent style across the document, so it would break it...
> 

OK, no problem :-)

> > 
> > > +[...]
> > > +	timer {
> > > +		compatible = "arm,armv8-timer";
> > > +
> > > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> > 
> > I'm pretty sure GIC_CPU_MASK_SIMPLE() is only valid & used on GICv2.
> > Unlike arm,gic.yaml, arm,gic-v3.yaml doesn't mention "bits[15:8] PPI
> > interrupt cpu mask". Also see e.g. commit 4a92b6d75bab ("arm64: dts:
> > msm8996: Fix wrong use of GIC_CPU_MASK_SIMPLE()").
> > 
> > Would be also good to check if any existing DTs have introduced this
> > incorrectly again since then.
> 
> All those platforms using GICv3 still use GIC_CPU_MASK_SIMPLE():
> 
> arch/arm64/boot/dts/qcom/qcm2290.dtsi
> arch/arm64/boot/dts/qcom/qdu1000.dtsi
> arch/arm64/boot/dts/qcom/sa8775p.dtsi
> arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> arch/arm64/boot/dts/qcom/sdx75.dtsi
> arch/arm64/boot/dts/qcom/sm4450.dtsi
> arch/arm64/boot/dts/qcom/sm6115.dtsi
> arch/arm64/boot/dts/qcom/sm6350.dtsi
> arch/arm64/boot/dts/qcom/sm6375.dtsi
> arch/arm64/boot/dts/qcom/sm8250.dtsi
> arch/arm64/boot/dts/qcom/sm8350.dtsi
> arch/arm64/boot/dts/qcom/sm8450.dtsi
> arch/arm64/boot/dts/qcom/sm8550.dtsi
> 

Heh, so we managed to omit it for msm8996, msm8998, sdm845, sm8150 and
then someone reintroduced it for sm8250 and the following. :-)

> I'm sure you're right, and indeed the PPI affinity can be specified in an optional
> 4th cell, but I'll need another confirmation I can safely remove it here.
> 
> Since it's harmless, it could be cleaned up later on over all the qcom DT.
> 

Please don't introduce new device trees with known mistakes, at least if
it's trivial to fix. This will just increase the likelihood that someone
will accidentally copy from the commit and make the same mistake again.

This is effectively comparable to a dtbs_check failure (except that the
tooling can't check for this automatically at the moment). Either the
binding or the DT should be fixed. It's most definitely the DT in this
case. :-)

Thanks,
Stephan
