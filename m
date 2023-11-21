Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690207F3842
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKUV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjKUV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:26:21 -0500
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 13:26:16 PST
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB161AA;
        Tue, 21 Nov 2023 13:26:16 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F3F631F506;
        Tue, 21 Nov 2023 22:26:14 +0100 (CET)
Date:   Tue, 21 Nov 2023 22:26:13 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 5/6] arm64: dts: qcom: sm6125: add interrupts to DWC3
 USB controller
Message-ID: <pmkna4ckmm67kf6uuetwprbl4eiv4v7wluv4c7wosbsk557cnl@afkmfljmfloa>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
 <20231111164229.63803-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111164229.63803-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this should CC the people that have most recently worked on SM6125 and
related hardware?

On 2023-11-11 17:42:28, Krzysztof Kozlowski wrote:
> Add interrupts to SM6125 DWC3 USB controller, based on downstream/vendor
> code of Trinket DTSI from Xiaomi Laurel device, to fix dtbs_check
> warnings:
> 
>   sm6125-xiaomi-laurel-sprout.dtb: usb@4ef8800: 'interrupt-names' is a required property
>   sm6125-xiaomi-laurel-sprout.dtb: usb@4ef8800: 'oneOf' conditional failed, one must be fixed:
>     'interrupts' is a required property
>     'interrupts-extended' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on HW.

I have had an identical patch [1] on my tree for over one and a half years, but
recall not submitting it because of not being sure where to pull dm_hs_phy_irq /
dp_hs_phy_irq from.  I think you are right (in the dt-bindings fixup) that it is
not available on this platform.

Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

(and obviously tested)

[1]: https://github.com/somainline/linux/commit/b57f7fa80cb3f5cd2db3db2d79548cbf063056d9

> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index eb07eca3a48d..1dd3a4056e26 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -1185,6 +1185,10 @@ usb3: usb@4ef8800 {
>  					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>  			assigned-clock-rates = <19200000>, <66666667>;
>  
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq";
> +
>  			power-domains = <&gcc USB30_PRIM_GDSC>;
>  			qcom,select-utmi-as-pipe-clk;
>  			status = "disabled";
> -- 
> 2.34.1
> 
