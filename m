Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033897B8594
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbjJDQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJDQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662A9B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:44:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC080C433C8;
        Wed,  4 Oct 2023 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696437870;
        bh=bJUdCu4n8Q616ruuLdWGE4yAQa292y0ym8neR1k201A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0goTKf7yenCuo1njZMrdo0wDTZQ5t1AC2tPHka97g2Tw8m49Gbju3yP3QFrztt7U
         PN/0QG/WY1onVRnFunFTmiV9QhcIcASYT19N+va3cryvt4q6+Z/cxMIAidJ0kNOF6w
         Wb6oOuXTJuD/I8RpVkWvMcI6ZlSMYBsAhNIz3SnnCzNfffbYTB2YrbsY0PUk90MCpe
         2XKJDz2xfxe/JJuLwx14ZYyXc7RqfTlkL3KlVH/Bsg2k18iK1dSy93uImyHWmQyRvG
         g5ANS9iQg3CvKRycbtbSuhZny1k3bnQKtZBxX2WwR2Ycjzan5KB/Tk8fCQBuv1mTh4
         cNatltJeDS8HA==
Date:   Thu, 5 Oct 2023 00:32:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add T-HEAD TH1520 USB controller
Message-ID: <ZR2Tl1rkRdIG+fQa@xhacker>
References: <20230927164222.3505-1-jszhang@kernel.org>
 <20230927164222.3505-2-jszhang@kernel.org>
 <cf68f6f1-e405-4c20-b4e1-da04189d0e2f@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf68f6f1-e405-4c20-b4e1-da04189d0e2f@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:00:59PM -0500, Samuel Holland wrote:
> On 2023-09-27 11:42 AM, Jisheng Zhang wrote:
> > T-HEAD TH1520 platform's USB has a wrapper module around
> > the DesignWare USB3 DRD controller. Add binding information doc for
> > it.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/usb/thead,th1520-usb.yaml        | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > new file mode 100644
> > index 000000000000..afb618eb5013
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/thead,th1520-usb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: T-HEAD TH1520 DWC3 USB Controller Glue
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    const: thead,th1520-usb
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ref
> > +      - const: bus_early
> > +      - const: phy
> > +      - const: suspend
> 
> Except for "phy", these clocks are already documented in snps,dwc3.yaml. Are
> they necessary for the glue/PHY, or do they belong only in the controller node?

Hi Samuel,

Enabling ref, bus_early clks are necessary for the glue layer, because
we program the glue registers before calling of_platform_populate()

> They are not used by the driver in patch 2. Also, the PHY clock probably belongs
> with the PHY node.

Except enabling the phy clk, we don't need to touch the phy, so I'm not
sure how to handle this if we have a dedicated phy driver thus a phy node.
or use the usb-nop-xceiv?

Thanks
> 
> > +
> > +  ranges: true
> > +
> > +  '#address-cells':
> > +    enum: [ 1, 2 ]
> > +
> > +  '#size-cells':
> > +    enum: [ 1, 2 ]
> > +
> > +# Required child node:
> > +
> > +patternProperties:
> > +  "^usb@[0-9a-f]+$":
> > +    $ref: snps,dwc3.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - ranges
> > +
> > +additionalProperties: false
> 
> The driver in patch 2 uses the thead,misc-sysreg and vbus-supply properties,
> neither of which is documented here. Also, depending on the other bindings, the
> VBUS supply should be referenced from the USB PHY or connector node, not here.
> 
> Regards,
> Samuel
> 
> > +examples:
> > +  - |
> > +
> > +    usb {
> > +          compatible = "thead,th1520-usb";
> > +          reg = <0xec03f000 0x1000>;
> > +          clocks = <&clk 1>,
> > +                   <&clk 2>,
> > +                   <&clk 3>,
> > +                   <&clk 4>;
> > +          clock-names = "ref", "bus_early", "phy", "suspend";
> > +          ranges;
> > +          #address-cells = <1>;
> > +          #size-cells = <1>;
> > +
> > +          usb@e7040000 {
> > +                compatible = "snps,dwc3";
> > +                reg = <0xe7040000 0x10000>;
> > +                interrupts = <68>;
> > +                dr_mode = "host";
> > +          };
> > +    };
> 
