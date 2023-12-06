Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA680701A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378107AbjLFMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378087AbjLFMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:46:01 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DA181;
        Wed,  6 Dec 2023 04:46:05 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rArHf-0005kg-2z;
        Wed, 06 Dec 2023 12:45:49 +0000
Date:   Wed, 6 Dec 2023 12:45:40 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Message-ID: <ZXBs9GOOOlZrMuSW@makrotopia.org>
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <def05aac79ddff872d3e56698b736cb445f14116.1701823757.git.daniel@makrotopia.org>
 <3e72bff6-9f4d-4cd4-845e-b065f1233ec6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e72bff6-9f4d-4cd4-845e-b065f1233ec6@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:59:54AM +0100, AngeloGioacchino Del Regno wrote:
> Il 06/12/23 01:57, Daniel Golle ha scritto:
> > Add various clock controllers found in the MT7988 SoC to existing
> > bindings (if applicable) and add files for the new ethwarp, mcusys
> > and xfi-pll clock controllers not previously present in any SoC.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v3:
> >   * move clock bindings to clock folder
> >   * drop ti,syscon-reset from bindings and example
> >   * merge mcusys with topckgen bindings
> > 
> > v2:
> >   * dropped unused labels
> >   * add 'type: object' declaration for reset-controller found in new
> >     ethwarp controller and represented as ti,syscon-reset
> >   * rebase on top of
> >     "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"
> > 
> >   .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
> >   .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
> >   .../bindings/clock/mediatek,ethsys.yaml       |  1 +
> >   .../clock/mediatek,mt7988-ethwarp.yaml        | 49 +++++++++++++++++++
> >   .../clock/mediatek,mt7988-xfi-pll.yaml        | 48 ++++++++++++++++++
> >   .../bindings/clock/mediatek,topckgen.yaml     |  2 +
> >   .../bindings/net/pcs/mediatek,sgmiisys.yaml   | 13 +++--
> >   7 files changed, 112 insertions(+), 3 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
> >   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> > index ea98043c6ba3d..230b5188a88db 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> > @@ -30,6 +30,7 @@ properties:
> >                 - mediatek,mt7629-infracfg
> >                 - mediatek,mt7981-infracfg
> >                 - mediatek,mt7986-infracfg
> > +              - mediatek,mt7988-infracfg
> >                 - mediatek,mt8135-infracfg
> >                 - mediatek,mt8167-infracfg
> >                 - mediatek,mt8173-infracfg
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
> > index 372c1d744bc27..685535846cbb7 100644
> > --- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
> > @@ -22,6 +22,7 @@ properties:
> >             - mediatek,mt7622-apmixedsys
> >             - mediatek,mt7981-apmixedsys
> >             - mediatek,mt7986-apmixedsys
> > +          - mediatek,mt7988-apmixedsys
> >             - mediatek,mt8135-apmixedsys
> >             - mediatek,mt8173-apmixedsys
> >             - mediatek,mt8516-apmixedsys
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
> > index 94d42c8647777..f9cddacc2eae1 100644
> > --- a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
> > @@ -22,6 +22,7 @@ properties:
> >                 - mediatek,mt7629-ethsys
> >                 - mediatek,mt7981-ethsys
> >                 - mediatek,mt7986-ethsys
> > +              - mediatek,mt7988-ethsys
> >             - const: syscon
> >         - items:
> >             - const: mediatek,mt7623-ethsys
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
> > new file mode 100644
> > index 0000000000000..9b919a155eb13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7988-ethwarp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7988 ethwarp Controller
> > +
> > +maintainers:
> > +  - Daniel Golle <daniel@makrotopia.org>
> > +
> > +description:
> > +  The Mediatek MT7988 ethwarp controller provides clocks and resets for the
> > +  Ethernet related subsystems found the MT7988 SoC.
> > +  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mediatek,mt7988-ethwarp
> > +      - const: syscon
> > +      - const: simple-mfd
> 
> No, this is not a mfd, I say.
> 
> Prove me wrong! :-)

https://github.com/dangowrt/linux/blob/mt7988-for-next/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L564

The 'simple-mfd' compatible is required to have the Linux
kernel probe drivers for sub-nodes -- several drivers will act on
the different aspects of the circuit exposed at this memory range.
From what I understand, this is the definition of a MFD.

> 
> ..snip..
> 
> > diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
> > index 66a95191bd776..68632cda334bd 100644
> > --- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
> > +++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
> > @@ -15,15 +15,22 @@ description:
> >   properties:
> >     compatible:
> > -    items:
> > -      - enum:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> >             - mediatek,mt7622-sgmiisys
> >             - mediatek,mt7629-sgmiisys
> >             - mediatek,mt7981-sgmiisys_0
> >             - mediatek,mt7981-sgmiisys_1
> >             - mediatek,mt7986-sgmiisys_0
> >             - mediatek,mt7986-sgmiisys_1
> > -      - const: syscon
> > +        - const: syscon
> > +      - items:
> > +        - enum:
> > +          - mediatek,mt7988-sgmiisys_0
> > +          - mediatek,mt7988-sgmiisys_1
> > +        - const: syscon
> > +        - const: simple-mfd
> 
> Same.
> 
> Cheers,
> Angelo
