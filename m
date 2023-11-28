Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B087FB527
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjK1JCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK1JCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:02:05 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A702DE4;
        Tue, 28 Nov 2023 01:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701162126; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r6eAu2ggbZSwoSOSC2LB9/TsOtVSDFGz1Yn6exqUJQ0DHNrZcDZFk2KMB6Pf2oxC4i
    BD9rNHK1hh72OUMXPKLavH9XGEbp8ZBmEli83jQTqYUvLSva2U2lgNj9pIX3HuMVJt+2
    qUz6BBCiePvo5XSEigRXFjYsQHZ3rLlZvVPXMb8P5gsWGcddPchoOkSsj1QNmgaWew8G
    6c5Ml6V5mmIOeUMjXSAZUPm8rCOv7yZZf2k1BAnlxms0I+mBi9T87BkWQnq6AU/3Zjn5
    bCpGLFHdB0BpP9+jgJ/ZYgEWUPJQz3LSIEqXVujdRK4OG77rNrCb8vS78Cn7rkaFkelM
    VQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701162126;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=njnHQBlxJazLWcAbW1gqa8mgblbBdF2CRCqEZQfBIIw=;
    b=qzWaaTlBGfcOt2NSli9uC30OIHhTm7Et3bwWlm5HYltZczHIohrUpFsbELgy0mQfkS
    WLyMz3zcRmaMElchm3RwfdjsZjVb+DeFjRQpFLfanu2K1+Ee6n52PZX/sHVTsBBPg6DY
    P5KBI2rUPZEwXI181zMZX6FcG0zFldP3BDmfAbL6LD5gWXt6A/XYrNilOalrEWN1yRFr
    nqPOIVRn30AqUGijCfS29EyfgvhiOP/EmYVHWyrs4QT5OxcZpJv9Y6jmDOwHRCn0negL
    1TTkuctz5ZvQSFL1jWE5UVbC2TNr894f2i30jcJhcjDaLQfuF91h5IJQ0/+8Ve/FuZfH
    58RA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701162126;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=njnHQBlxJazLWcAbW1gqa8mgblbBdF2CRCqEZQfBIIw=;
    b=NGkt5BpAHMAwG5ZGf2LpEqrMuOEjWLA6KVKLpltw4TzVMPa9HVzLWEtcKSBfqWrujV
    qBOb4Dr8yy4PqS7SnkqExRYuFSIIElBJulaur0QNIREh0xy5LNNScHRpV0Ovj65xoe2R
    MZmoW4OWEBqr1uEslj3AZKcxky/jhP6NL0nhANSgY1EUHpY5zIdu5MsqZ7ghvg2N4jdy
    fYEqXZ7s2chHCM17/Dx78JTKLrSMGVOScX5rMWRHytabBb4IhYkYLHxhEzbiqRhMJSon
    MUFdLiI8i8a9xMdgl7S9Jd5vbf79Nk1Dk69X9amD5LK4afivnJjWMjz0ylAWKLMMoOYB
    UifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701162126;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=njnHQBlxJazLWcAbW1gqa8mgblbBdF2CRCqEZQfBIIw=;
    b=8/1mIY83/yDD+zTLGU3PquPNdvq5bT+5tGhBNu6pRU7uN+7Y0kocxGPDSnyY8/AxHp
    urFKBT2uGou13TLtIEBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id t3efe7zAS925ktT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Nov 2023 10:02:05 +0100 (CET)
Date:   Tue, 28 Nov 2023 10:01:47 +0100
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
Message-ID: <ZWWse_i-wjSTH8O4@gerhold.net>
References: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
 <20231124-topic-sm8650-upstream-dt-v4-2-e402e73cc5f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124-topic-sm8650-upstream-dt-v4-2-e402e73cc5f0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:20:39AM +0100, Neil Armstrong wrote:
> Add initial DTSI for the Qualcomm SM8650 platform,
> only contains nodes which doesn't depend on interconnect.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 2439 ++++++++++++++++++++++++++++++++++
>  1 file changed, 2439 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> new file mode 100644
> index 000000000000..b0a9ca53d58e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -0,0 +1,2439 @@
> +[...]
> +		timer@17420000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0 0x17420000 0 0x1000>;
> +
> +			ranges = <0 0 0 0x20000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			frame@17421000 {
> +				reg = <0x17421000 0x1000>,
> +				      <0x17422000 0x1000>;
> +
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <0>;
> +			};
> +
> +			frame@17423000 {
> +				reg = <0x17423000 0x1000>;
> +
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <1>;
> +
> +				status = "disabled";
> +			};
> +
> +			frame@17425000 {
> +				reg = <0x17425000 0x1000>;
> +
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <2>;
> +
> +				status = "disabled";
> +			};
> +
> +			frame@17427000 {
> +				reg = <0x17427000 0x1000>;
> +
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <3>;
> +
> +				status = "disabled";
> +			};
> +
> +			frame@17429000 {
> +				reg = <0x17429000 0x1000>;
> +
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <4>;
> +
> +				status = "disabled";
> +			};
> +
> +			frame@1742b000 {
> +				reg = <0x1742b000 0x1000>;
> +
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <5>;
> +
> +				status = "disabled";
> +			};
> +
> +			frame@1742d000 {
> +				reg = <0x1742d000 0x1000>;
> +
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				frame-number = <6>;
> +
> +				status = "disabled";
> +			};
> +		};

Nitpick: Personally I feel the empty lines between each property here
are a bit overly verbose. It would be better readable without them.
Might be personal preference though :-)

> +[...]
> +	timer {
> +		compatible = "arm,armv8-timer";
> +
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;

I'm pretty sure GIC_CPU_MASK_SIMPLE() is only valid & used on GICv2.
Unlike arm,gic.yaml, arm,gic-v3.yaml doesn't mention "bits[15:8] PPI
interrupt cpu mask". Also see e.g. commit 4a92b6d75bab ("arm64: dts:
msm8996: Fix wrong use of GIC_CPU_MASK_SIMPLE()").

Would be also good to check if any existing DTs have introduced this
incorrectly again since then.

Thanks,
Stephan
