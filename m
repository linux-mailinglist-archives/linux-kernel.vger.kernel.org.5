Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2A7EBD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjKOHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF0E9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:15:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38327C433CB;
        Wed, 15 Nov 2023 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700032557;
        bh=MqgzQQOu8k3naqWebde+daNwOSL9eli/d3myBSRtR24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7UTwy6SU73judLJIIm68X2W3qJppWcb4CM6fOQeLWa1Gt5Ev0KQk9ojN9NCJtKjR
         Hw7u1aLwf0STckZ98EOd1CAnDPmo9QR1Xv4a2HnsKxOny5Kg/vwIphr17srpvZuqtF
         e9471oeN9SFLWOSE8IFejUUd2O//US+rmSWJISf+XCGKfDv6t2254rKR0TCoE02qNb
         tSpGvM0FrlP4Bi14MHQvSrOAZgvkmYprfwnWA0PGqYgQU0QmEYUd43Ls8pguP/Y8G4
         URBRg8WM/i+kl+dzhGJyMkZqY5LqzW39fq+kB0e7NlixQ5LiAvAq6dNtBqvcPYyWle
         8ZB3rR7YqE/DQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3A7t-0007rg-2A;
        Wed, 15 Nov 2023 08:15:53 +0100
Date:   Wed, 15 Nov 2023 08:15:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Document sm8450 pcie phys as having 4
 clocks
Message-ID: <ZVRwKaUTDBaYsnQS@hovoldconsulting.com>
References: <20231103230339.966792-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103230339.966792-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:03:38PM -0700, Elliot Berman wrote:
> I noticed while running make dtbs_check that
> qcom,sm8450-qmp-gen3x1-pcie-phy and qcom,sm8450-qmp-gen4x2-pcie-phy have
> 4 clocks, not 5. There was also a typo for the 8450 bindings:
> s/gen3x2/gen4x2/.
> 
> Update the bindings to reflect the correct number of required clocks.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 505fb2541678 ("dt-bindings: phy: migrate QMP PCIe PHY bindings to qcom,sc8280xp-qmp-pcie-phy.yaml")
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 2c3d6553a7ba..1768f2016a9f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -128,6 +128,20 @@ allOf:
>          reg:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8450-qmp-gen3x1-pcie-phy
> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          minItems: 4
> +

I'm not sure which tree you think you're looking at but this is clearly
not correct.

The phy nodes in arch/arm64/boot/dts/qcom/sm8450.dtsi have five clocks
defined.

Johan
