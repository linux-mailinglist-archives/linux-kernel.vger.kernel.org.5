Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B0778236
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHJUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7A2735;
        Thu, 10 Aug 2023 13:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4FAA649D8;
        Thu, 10 Aug 2023 20:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9907FC433C7;
        Thu, 10 Aug 2023 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691699795;
        bh=HLJOnK0rH2cvb7EsLtRxErU2VHJz6XAwt8dHUse6DKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyM5XDF2DqDCiwlhNnxzBAT3zndoLjRw0OPRa2DXJli2uuvt80VkabDTadz6BQ1uq
         zFLg1kCd1aj/ogBJO98YbSFnIuHKZxvibVyAHYGyci87df4K3JkfE8Qll+j36W57Cm
         u8iXCGlTEM1r1r5hQSyAhoptS5X+ubF76dMZTKNrLOquf6PH2g+nPqrkToInf+CgEH
         a4khDadQl7wGQFxqEClwliKhphgz4H4pvteGcmNggTCGt9Uznyq0TkezqM5EgYu8IR
         xEif6xlSHOlI3tbGZOGKH4Iq1b6AeTKdz9UAEeetN8CbCOZk5cPYscv7Y2mLXNIZdY
         3j8Icc9O5WVnQ==
Received: (nullmailer pid 1127760 invoked by uid 1000);
        Thu, 10 Aug 2023 20:36:33 -0000
Date:   Thu, 10 Aug 2023 14:36:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Message-ID: <20230810203633.GA1121702-robh@kernel.org>
References: <20230810055440.3534-1-stanley_chang@realtek.com>
 <20230810055440.3534-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810055440.3534-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:54:35PM +0800, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>     Add description for reg
>     Remove property for realtek,unlink-usb3-port.
>     Remove property for realtek,disable-usb3-phy.
>     Use the maximum-speed instead of the above two properties.
> v1 to v2 change:
>     Revise the subject.
>     Rename the file.
>     Fix dtschema warnings.
>     Remove the property realtek,enable-l4icg.
>     Drop status.
> ---
>  .../bindings/usb/realtek,rtd-dwc3.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
> new file mode 100644
> index 000000000000..cc66adc4b9da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/realtek,rtd-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
> +    description: Offset and length of register set for wrapper of dwc3 core.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
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
> +        maximum-speed = "high-speed";

This should be a warning (the bot was having problems) as it is not 
defined for this node. It belongs in the child node as you also have, so 
drop it.

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
