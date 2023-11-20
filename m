Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B507F1D62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjKTThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:37:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FBA0;
        Mon, 20 Nov 2023 11:37:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so3585982f8f.1;
        Mon, 20 Nov 2023 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700509030; x=1701113830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s6qbWAmzKi2p0EuDS/NMn95lRrUARZbsnu45noLp+Qc=;
        b=erUhBv/AMdX29t5+Mv85E0bZHg4WrQ/Cwv3r7mMxi/OuTQzzFU7NemX77PzVHeoPhA
         GS9Wu+3xRO9gMkaGt2HCspKBVyD38ni6nNebJn+3o6iLFqaK2C1TUXXRx2KcmGc0e+Z1
         Ee2nLyrwSi/WfkQQDTSVdezUiArHILXvise6vkpfTx4AR5GzkEmsR3/5YTFXsqOp8xem
         2L2+ugUrK1wYYyrwdLFht8SMa3oeFNM/KFo1I/FPjFze1CzS9BPYdvDopTRoBmYx+qBe
         SbbieaH6mqyyppc7CZq/Ki3K4t+4kjIDDhOVyeK5yghUrJ4lzW+xOcKgL0sJEiGFZhf8
         0Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509030; x=1701113830;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6qbWAmzKi2p0EuDS/NMn95lRrUARZbsnu45noLp+Qc=;
        b=NZiq5IRbD9Wi84geFgzKxKqB3SUSAEJnUbph3TBqeCnIZo4IbSHBVV/vLrYZkY/LJW
         FD5uv7P8KsMOgXfzOn8uLiHkFABIb1i6LukHXF/ta/6hkVvizw4NYtbBwE1M6YqUt6QA
         uKC3b6c1I69vATu2Uh+Cyxl30q0V8fhYZTU8YFppl2v9F0bGr1a5yP0FtzhA+4bvmpGR
         u5ZZBUK5s/1jDUyZhN8haq63q/QYU3eAUOrFvxaHaRswIUMiaDPGuv0fos7bxLN3/o+W
         zw/qdfRz/zpMMr7tqr78DHgYPnT/QPhCmuqxrBeBNm1JU51ShMmiRnZGwtxDFsCyPp7Q
         ZS2g==
X-Gm-Message-State: AOJu0Yz3Rhpbta+142YkIf7MjtVM61k4+Js+DgKKp2NFBVqNY1IaX4X6
        xwfRkwUyXlsIxYaRnpb+ZJA=
X-Google-Smtp-Source: AGHT+IF4HwRNSy2o1xnmcctJJBVc95B9JljVI0ZK81TRO/JZxZDY4YWuo06d3u96DM+h1Tmg7Z2QIg==
X-Received: by 2002:adf:e503:0:b0:331:6a43:5abe with SMTP id j3-20020adfe503000000b003316a435abemr5132310wrm.62.1700509030283;
        Mon, 20 Nov 2023 11:37:10 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e8-20020adfe7c8000000b00332cc24a59bsm997960wrn.109.2023.11.20.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:37:09 -0800 (PST)
Message-ID: <655bb565.df0a0220.1848b.5d49@mx.google.com>
X-Google-Original-Message-ID: <ZVuLuHAShU88RJno@Ansuel-xps.>
Date:   Mon, 20 Nov 2023 17:39:20 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <20231120174133.GB2378814-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120174133.GB2378814-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:41:33AM -0700, Rob Herring wrote:
> On Mon, Nov 20, 2023 at 02:50:30PM +0100, Christian Marangi wrote:
> > Document ethernet PHY package nodes used to describe PHY shipped in
> > bundle of 4-5 PHY. These particular PHY require specific PHY in the
> > package for global onfiguration of the PHY package.
> > 
> > Example are PHY package that have some regs only in one PHY of the
> > package and will affect every other PHY in the package, for example
> > related to PHY interface mode calibration or global PHY mode selection.
> > 
> > The PHY package node should use the global-phys property and the
> > global-phy-names to define PHY in the package required by the PHY driver
> > for global configuration.
> > 
> > It's also possible to specify the property phy-mode to specify that the
> > PHY package sets a global PHY interface mode and every PHY of the
> > package requires to have the same PHY interface mode.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/net/ethernet-phy-package.yaml    | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > new file mode 100644
> > index 000000000000..2aa109e155d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ethernet PHY Package Common Properties
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com
> 
> Missing a '>'
> 
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^ethernet-phy-package(-[0-9]+)?$"
> > +
> > +  compatible:
> > +    const: ethernet-phy-package
> > +
> > +  '#address-cells':
> > +    description: number of address cells for the MDIO bus
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    description: number of size cells on the MDIO bus
> > +    const: 0
> > +
> > +  global-phys:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 31
> > +    description:
> > +      List of phandle to the PHY in the package required and
> > +      used to configure the PHY package.
> > +
> > +  global-phy-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    minItems: 1
> > +    maxItems: 31
> > +    description:
> > +      List of names of the PHY defined in global-phys.
> > +
> > +  phy-connection-type:
> > +    $ref: /schemas/net/ethernet-phy-mode-types.yaml#definitions/phy-connection-type
> > +    description:
> > +      Specifies global interface type for the PHY package.
> > +
> > +  phy-mode:
> > +    $ref: "#/properties/phy-connection-type"
> > +
> > +patternProperties:
> > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > +    $ref: /schemas/net/ethernet-phy.yaml#
> > +
> > +required:
> > +  - compatible
> > +
> > +dependencies:
> > +  global-phy-names: [global-phys]
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    ethernet {
> 
> You mean 'mdio' here, right?
> 
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet-phy-package {
> 
> This doesn't work. Child nodes of MDIO bus must be an MDIO device with 
> an address. What you need is a node with all the addresses of the 
> device:
> 
> mdio {
>   ...
> 
>   ethernet-phy@1 {
>     compatible = "vendor,specifc-compatible-for-device";
>     reg = <1>, <4>;
>     ...
>   };
> };
> 
> There's also some MDIO devices which define a secondary address as a 
> child device. Maybe those are similar to your situation. I don't recall 
> which ones offhand.
>

Ehh this is not really a situation. We really need a way to describe PHY
package. (In the sense of device that expose multiple PHY package, as
they can be treated as single one but they are actually in bulk of 2-4-5
PHY)

qca807x is one example, quickinc is trying to push another PHY with just
a similar implementation and Maxime Chevallier just pointed out that Marvell
Alaska 88e1543 PHY also have this kind of configuration.

I feel defining PHY in subnode is a MUST and using ethernet-phy might be
confusing to describe PHY package (so I think a brand new node name
might be a better solution)

About the reg, I wonder if it would like it more if the PHY package node
would include the reg as the first address of the package and the reg
property as a list of all the reg the PHY package use.

Something like this?

        ethernet-phy-package@1 {
            compatible = "ethernet-phy-package";
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <1>, <2>, <3>, <4>;

            global-phys = <&phy4>;
            global-phy-names = "base";

            ethernet-phy@1 {
              compatible = "ethernet-phy-ieee802.3-c22";
              reg = <1>;
            };

            phy4: ethernet-phy@4 {
              compatible = "ethernet-phy-ieee802.3-c22";
              reg = <4>;
            };
        };

Thanks a lot for the review and I hope we can find a good and correct
way to model this. Just hope we don't have to add all kind of proprerty
to describe the idea of PHY package. (I think the current example makes
it very clear that the PHY under the node are all part of a single piece
on the device)

> > +            compatible = "ethernet-phy-package";
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            global-phys = <&phy4>;
> > +            global-phy-names = "base";
> > +
> > +            ethernet-phy@1 {
> > +              compatible = "ethernet-phy-ieee802.3-c22";
> > +              reg = <1>;
> > +            };
> > +
> > +            phy4: ethernet-phy@4 {
> > +              compatible = "ethernet-phy-ieee802.3-c22";
> > +              reg = <4>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.40.1
> > 

-- 
	Ansuel
