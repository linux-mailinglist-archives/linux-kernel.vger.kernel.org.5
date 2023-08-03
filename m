Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4B76DD12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHCBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD91B9;
        Wed,  2 Aug 2023 18:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC4661B9F;
        Thu,  3 Aug 2023 01:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B1C433C8;
        Thu,  3 Aug 2023 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691025518;
        bh=0P0S2/MgycChVw2ibGG2dMFXAv+3iwZOlw6Fgpq6W7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqN6OA/93yzinfVGHXyl12eDcC7r/sS8zKgv+lh30BnIvzSpXVa9ncvbuw4yxNGRx
         ZgNwf0Z0ztBcLqVTXr/OHzBAU8tdKw4lhP+DFs+h2sYRto9qxuRcXxAePTET9ypbZ7
         FU0XG2jUfDpBBrKAFH9j/K2ttnJsC21f1UWvy6hYcU0vj8AASxdJPFA7YhWxVWumqs
         vS4/m+zQqN0CzfUWACLbz10Oj2sNSDZ9hMelnuB16Pzld3Me6u+y70sngwar4tNDnC
         JX0QtwC1ALxc8J4rheTd94Rw3QWcF9yPQrFAlEvjhtM83tWFDqoBqhQu0aSyrE691C
         YUSpfqzJk6y1A==
Received: (nullmailer pid 1644049 invoked by uid 1000);
        Thu, 03 Aug 2023 01:18:36 -0000
Date:   Wed, 2 Aug 2023 19:18:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek
 DHC RTD SoC DWC3 USB
Message-ID: <20230803011836.GA1635549-robh@kernel.org>
References: <20230728035318.18741-1-stanley_chang@realtek.com>
 <20230728035318.18741-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728035318.18741-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:53:13AM +0800, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  .../devicetree/bindings/usb/realtek,dwc3.yaml | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml b/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml
> new file mode 100644
> index 000000000000..74d388809924
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/realtek,dwc3.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Realtek DWC3 USB SoC Controller Glue
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description:
> +  The Realtek DHC SoC embeds a DWC3 USB IP Core configured for USB 2.0
> +  and USB 3.0 in host or dual-role mode.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtd1295-dwc3
> +          - realtek,rtd1315e-dwc3
> +          - realtek,rtd1319-dwc3
> +          - realtek,rtd1319d-dwc3
> +          - realtek,rtd1395-dwc3
> +          - realtek,rtd1619-dwc3
> +          - realtek,rtd1619b-dwc3
> +      - const: realtek,rtd-dwc3
> +
> +  reg:
> +    maxItems: 1

Some details on what these registers are would be useful. Or describing 
what's in the 'glue' device?

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  realtek,unlink-usb3-port:
> +    description: Disable link between USB 3.0 PHY and USB mac.
> +      Only for RTD1619 SoC, if the board design support maximum 2.0 speed.
> +    type: boolean

We have a property for this: maximum-speed

That belongs in the USB controller node though.

> +
> +  realtek,disable-usb3-phy:
> +    description: Close USB 3.0 PHY if the board design not support USB 3.0.
> +    type: boolean

Can't this be determined by not having a USB3 phy listed?

> +
> +  realtek,enable-l4icg:
> +    description: Enable the power saving feature l4icg by hardware clock.
> +      gating.
> +    type: boolean
> +
> +patternProperties:
> +  "^usb@[0-9a-f]+$":
> +    $ref: snps,dwc3.yaml#
> +    description: Required child node
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - realtek,rtd1619-dwc3
> +    then:
> +      properties:
> +        realtek,unlink-usb3-port: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb@98013e00 {
> +        compatible = "realtek,rtd1319d-dwc3", "realtek,rtd-dwc3";
> +        reg = <0x98013e00 0x200>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        status = "okay";

Drop status from examples.

> +        realtek,disable-usb3-phy;
> +        realtek,enable-l4icg;
> +
> +        usb@98050000 {
> +            compatible = "snps,dwc3";
> +            reg = <0x98050000 0x9000>;
> +            interrupts = <0 94 4>;
> +            phys = <&usb2phy &usb3phy>;
> +            phy-names = "usb2-phy", "usb3-phy";
> +            dr_mode = "otg";
> +            usb-role-switch;
> +            role-switch-default-mode = "host";
> +            snps,dis_u2_susphy_quirk;
> +            snps,parkmode-disable-ss-quirk;
> +            snps,parkmode-disable-hs-quirk;
> +            maximum-speed = "high-speed";
> +        };
> +    };
> -- 
> 2.34.1
> 
