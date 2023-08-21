Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79EC783128
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHUT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjHUT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA45C2;
        Mon, 21 Aug 2023 12:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B5961CCB;
        Mon, 21 Aug 2023 19:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05DCC433C8;
        Mon, 21 Aug 2023 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692646038;
        bh=50DowOaWgtq3+xbaFIEFeIKo8jjSf+PPRMLLIeZpItQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2Zjxx8/sIHw9/PbdwrzIswW+vWoq49l/RVK21Bpn6xNv2DCyvyyuGzE5Wmq+y78e
         lR4Z3lf8ezwcgEFqqT8XnzIrAq/Pr1cElisIXj6lKtcTXJx6tOeRkdBHBmmW0wrBek
         LYcVex+O+WuownN/WP/Zi2SgzqIIGbpYZOsE0CJ+Pn9kgeJdGdxKOgwYa1Rl3eUWFp
         Bx4FeEsqLR9lllzhIf3lzfkvAObs0mWxSemZ1cQ71HciTYfeAY4ERM2XV9c0fq4mJ6
         eM29tPgYn3isOkTNg4xv8O0/B3sVDdCDNxtQn35k7CkuJlm5iiZCFWkPECy3Uw+Tag
         EABzSLAgR5TJA==
Received: (nullmailer pid 2156172 invoked by uid 1000);
        Mon, 21 Aug 2023 19:27:16 -0000
Date:   Mon, 21 Aug 2023 14:27:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Message-ID: <20230821192716.GA2128469-robh@kernel.org>
References: <20230815095452.4146-1-stanley_chang@realtek.com>
 <20230815095452.4146-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815095452.4146-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:54:38PM +0800, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v3 to v4 change:
>     Add reg for register set for pm control.
>     Remove maximum-speed in example.
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
> index 000000000000..345d0132d4a5
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
> +    items:
> +      - description: Address and length of register set for wrapper of dwc3 core.
> +      - description: Address and length of register set for pm control.
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
> +        reg = <0x98013e00 0x140>, <0x98013f60 0x4>;

These look like registers in some other block rather than a standalone 
wrapper block. Are these part of some syscon block? If so, I don't think 
a wrapper node is the right approach here, but a phandle to the syscon 
would be instead.

From the register definitions, much of it looks phy related, but this is 
not part of the phys?

> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
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
