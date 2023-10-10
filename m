Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8D7C001E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjJJPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJJPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123EA7;
        Tue, 10 Oct 2023 08:14:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E98DC433C8;
        Tue, 10 Oct 2023 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696950842;
        bh=iRxiY3IuELO5fr43sz9lhcyv7foq3bHa+ZIfYse9aJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6/I8ffbLmwNnLDRYxk+qOQVp/TqP+IB+PIWJn/hvL/VfCyTHCx3+HBDHNvdUu/l7
         +kAm7yXvXMirOd4rZ3Z2iQf9lOhGY2YN+CjCM3qDpKJ560i2DT+1Rx9ypnM+WxYksn
         4HVmZf8KzVK1iLnd0trnaIDI3770hiQec3PnzC8fF0lWo+lr/qJsSdHXHyV9FZ+wd7
         B+ACst8PpS7h7fYHbWGjX2aIfirXVd0Qse6fOjEdpX3T0Lc7EmwWIe1cVFGrOx+HWs
         ILiC6Bg0SdpE6dyvqTXkmEv/K4VsTmR9jlLuU+oxuQCkoBVjEPbcxnOS99jjvY5fcH
         vK0LXfmZnizGQ==
Received: (nullmailer pid 889001 invoked by uid 1000);
        Tue, 10 Oct 2023 15:13:55 -0000
Date:   Tue, 10 Oct 2023 10:13:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Message-ID: <20231010151355.GB870095-robh@kernel.org>
References: <20231010122539.1768825-1-bryan.odonoghue@linaro.org>
 <20231010122539.1768825-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010122539.1768825-3-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:25:38PM +0100, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/media/qcom,sc8280xp-camss.yaml   | 582 ++++++++++++++++++
>  1 file changed, 582 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> new file mode 100644
> index 000000000000..5b0481d8bd07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> @@ -0,0 +1,582 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sc8280xp-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC8280XP Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> +
> +description: |
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sc8280xp-camss
> +
> +  clocks:
> +    maxItems: 63
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +      - const: camnoc_axi_src
> +      - const: cpas_ahb
> +      - const: cphy_rx_src
> +      - const: csiphy0
> +      - const: csiphy0_timer_src
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer_src
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer_src
> +      - const: csiphy2_timer
> +      - const: csiphy3
> +      - const: csiphy3_timer_src
> +      - const: csiphy3_timer
> +      - const: vfe0_axi
> +      - const: vfe0_src
> +      - const: vfe0
> +      - const: vfe0_cphy_rx
> +      - const: vfe0_csid_src
> +      - const: vfe0_csid
> +      - const: vfe1_axi
> +      - const: vfe1_src
> +      - const: vfe1
> +      - const: vfe1_cphy_rx
> +      - const: vfe1_csid_src
> +      - const: vfe1_csid
> +      - const: vfe2_axi
> +      - const: vfe2_src
> +      - const: vfe2
> +      - const: vfe2_cphy_rx
> +      - const: vfe2_csid_src
> +      - const: vfe2_csid
> +      - const: vfe3_axi
> +      - const: vfe3_src
> +      - const: vfe3
> +      - const: vfe3_cphy_rx
> +      - const: vfe3_csid_src
> +      - const: vfe3_csid
> +      - const: vfe_lite0_src
> +      - const: vfe_lite0
> +      - const: vfe_lite0_cphy_rx
> +      - const: vfe_lite0_csid_src
> +      - const: vfe_lite0_csid
> +      - const: vfe_lite1_src
> +      - const: vfe_lite1
> +      - const: vfe_lite1_cphy_rx
> +      - const: vfe_lite1_csid_src
> +      - const: vfe_lite1_csid
> +      - const: vfe_lite2_src
> +      - const: vfe_lite2
> +      - const: vfe_lite2_cphy_rx
> +      - const: vfe_lite2_csid_src
> +      - const: vfe_lite2_csid
> +      - const: vfe_lite3_src
> +      - const: vfe_lite3
> +      - const: vfe_lite3_cphy_rx
> +      - const: vfe_lite3_csid_src
> +      - const: vfe_lite3_csid
> +      - const: gcc_axi_hf
> +      - const: gcc_axi_sf
> +      - const: slow_ahb_src
> +
> +  interrupts:
> +    maxItems: 20
> +
> +  interrupt-names:
> +    items:
> +      - const: csid1_lite
> +      - const: vfe_lite1
> +      - const: csiphy3
> +      - const: csid0
> +      - const: vfe0
> +      - const: csid1
> +      - const: vfe1
> +      - const: csid0_lite
> +      - const: vfe_lite0
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csid2
> +      - const: vfe2
> +      - const: csid3_lite
> +      - const: csid2_lite
> +      - const: vfe_lite3
> +      - const: vfe_lite2
> +      - const: csid3
> +      - const: vfe3
> +
> +  iommus:
> +    maxItems: 16
> +
> +  interconnects:
> +    maxItems: 4
> +
> +  interconnect-names:
> +    items:
> +      - const: cam_ahb
> +      - const: cam_hf_mnoc
> +      - const: cam_sf_mnoc
> +      - const: cam_sf_icp_mnoc
> +
> +  power-domains:
> +    items:
> +      - description: IFE0 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE1 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE2 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE3 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: Titan Top GDSC - Titan ISP Block, Global Distributed Switch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: ife0
> +      - const: ife1
> +      - const: ife2
> +      - const: ife3
> +      - const: top
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    description:
> +      CSI input ports.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.

Every port has the same description. You need to define how they 
correlate to the h/w. 0-3 is what in the hardware?

Rob
