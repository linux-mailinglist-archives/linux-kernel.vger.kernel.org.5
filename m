Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A970800351
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbjLAFvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbjLAFvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:51:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEAF2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:51:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4416C433C7;
        Fri,  1 Dec 2023 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701409882;
        bh=+VnGs6Seo0e7jvF3XvNq79ffhry+pZ72obFBhYKEFHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hiur9O1H+pALNUUYUIxgg42umh9EA0kMeqOXgI22vNjkNhwE0LRnzxIbwiIMtlkyM
         DmK3zm2nq99QGQ6iDu9c5Gw5Oxdpx0Z9oMf/NFku18SKqTGAJWUt6fU3qRqImnnMCv
         p0yYyLwWzRpbfHn/ZXPJnrHW6DoNKYITR/gXQ01m3fBb5Pj+yisdH5VPRKnNzC76Ff
         i8T6oFZSr/jBnJwdz6GFjhCY9ONCD0Q85EuV3Cy7soLFCT0WwunhwLPcZO+q8NqPSX
         pXCA0+x71uQalT3G/fvcO08AnJGDzSYTbDZFxfcCXvh8Hyl0vk1L1vSka9cySo29CZ
         gv7FgqlCZYdOA==
Date:   Fri, 1 Dec 2023 11:21:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v8 1/5] dt-bindings: PCI: qcom-ep: Add support for
 SA8775P SoC
Message-ID: <20231201055103.GG4009@thinkpad>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
 <1699669982-7691-2-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699669982-7691-2-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 08:02:57AM +0530, Mrinmay Sarkar wrote:
> Add devicetree bindings support for SA8775P SoC. It has DMA register
> space and dma interrupt to support HDMA.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index a223ce0..46802f7 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,sa8775p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
>        - items:
> @@ -20,6 +21,7 @@ properties:
>            - const: qcom,sdx55-pcie-ep
>  
>    reg:
> +    minItems: 6
>      items:
>        - description: Qualcomm-specific PARF configuration registers
>        - description: DesignWare PCIe registers
> @@ -27,8 +29,10 @@ properties:
>        - description: Address Translation Unit (ATU) registers
>        - description: Memory region used to map remote RC address space
>        - description: BAR memory region
> +      - description: DMA register space
>  
>    reg-names:
> +    minItems: 6
>      items:
>        - const: parf
>        - const: dbi
> @@ -36,13 +40,14 @@ properties:
>        - const: atu
>        - const: addr_space
>        - const: mmio
> +      - const: dma
>  
>    clocks:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    clock-names:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    qcom,perst-regs:
> @@ -57,14 +62,18 @@ properties:
>            - description: Perst separation enable offset
>  
>    interrupts:
> +    minItems: 2
>      items:
>        - description: PCIe Global interrupt
>        - description: PCIe Doorbell interrupt
> +      - description: DMA interrupt
>  
>    interrupt-names:
> +    minItems: 2
>      items:
>        - const: global
>        - const: doorbell
> +      - const: dma
>  
>    reset-gpios:
>      description: GPIO used as PERST# input signal
> @@ -125,6 +134,10 @@ allOf:
>                - qcom,sdx55-pcie-ep
>      then:
>        properties:
> +        reg:
> +          maxItems: 6
> +        reg-names:
> +          maxItems: 6
>          clocks:
>            items:
>              - description: PCIe Auxiliary clock
> @@ -143,6 +156,10 @@ allOf:
>              - const: slave_q2a
>              - const: sleep
>              - const: ref
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          maxItems: 2
>  
>    - if:
>        properties:
> @@ -152,6 +169,10 @@ allOf:
>                - qcom,sm8450-pcie-ep
>      then:
>        properties:
> +        reg:
> +          maxItems: 6
> +        reg-names:
> +          maxItems: 6
>          clocks:
>            items:
>              - description: PCIe Auxiliary clock
> @@ -172,6 +193,45 @@ allOf:
>              - const: ref
>              - const: ddrss_sf_tbu
>              - const: aggre_noc_axi
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 7
> +          maxItems: 7
> +        reg-names:
> +          minItems: 7
> +          maxItems: 7
> +        clocks:
> +          items:
> +            - description: PCIe Auxiliary clock
> +            - description: PCIe CFG AHB clock
> +            - description: PCIe Master AXI clock
> +            - description: PCIe Slave AXI clock
> +            - description: PCIe Slave Q2A AXI clock
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg
> +            - const: bus_master
> +            - const: bus_slave
> +            - const: slave_q2a
> +        interrupts:
> +          minItems: 3
> +          maxItems: 3
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
