Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D276E2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjHCIRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjHCIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:16:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2530FF;
        Thu,  3 Aug 2023 01:11:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 190CDFF808;
        Thu,  3 Aug 2023 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691050304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpuTuRUPiNyH3n2jjGpwrnx1fmI9b2Ko2zyAHNgRosY=;
        b=MBkGmMrkIRzCcm9qcngyjAaowvqDCU3fgHUsOk25u2vBbYmlDH+Hj2GrGAWIbTha00anRa
        gu1s9i+xkIfhLxiohPHve2V1bBnrCFEQVmD8V97HwNhUmn/HcO80PjdKXdcYONjVjmTWKQ
        HROgiT4nP7clJyC5O1RTrccH6n2NMzG/cPXmJfIRUBQ0Kcvi+WtxdE7whdaphg45Zysur7
        GMAQ9yMloM7i6sflXwFqDhG7q4HD4c7tVbFfisp0P1ro0KFhjPLwyn/lYPonWAUaVX/TgD
        clvRno6hkGHP98PBQnSEZarnxmGQcy+Pq49wDtkmQLabUhVRZo9qe9muvxZdlQ==
Date:   Thu, 3 Aug 2023 10:11:34 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 21/28] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230803101134.6920805c@bootlin.com>
In-Reply-To: <20230803004054.GA1593620-robh@kernel.org>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-22-herve.codina@bootlin.com>
        <20230803004054.GA1593620-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 2 Aug 2023 18:40:54 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 26, 2023 at 05:02:17PM +0200, Herve Codina wrote:
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/net/lantiq,pef2256.yaml          | 226 ++++++++++++++++++
> >  1 file changed, 226 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> > new file mode 100644
> > index 000000000000..b369a20d61b1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
> > @@ -0,0 +1,226 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/lantiq,pef2256.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lantiq PEF2256
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description:
> > +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
> > +  line interface component designed to fulfill all required interfacing between
> > +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: lantiq,pef2256
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Master clock
> > +      - description: Receive System Clock
> > +      - description: Transmit System Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: mclk
> > +      - const: sclkr
> > +      - const: sclkx
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO used to reset the device.
> > +    maxItems: 1
> > +
> > +  '#framer-cells':  
> 
> Looks generic, but no such property is defined. You don't need something 
> like this unless there are multiple providers and you need each 
> provider to define the number of cells.

With the framer infrastructure introduced in this series, multiple providers
can be present. Some framer chips are dual or quad framers.

With this pef2256 framer provider, consumers use "framer = <&pef2256>;"
but with some others framer provider, we can have "framer = <&foo 1>;"

That's the reason why I set '#framer-cells' in this first framer provider,
even if the value is 0.

> 
> > +    const: 0
> > +
> > +  pinctrl:
> > +    $ref: /schemas/pinctrl/pinctrl.yaml#
> > +    additionalProperties: false
> > +
> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +        $ref: /schemas/pinctrl/pincfg-node.yaml#
> > +        additionalProperties: false
> > +
> > +        properties:
> > +          pins:
> > +            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
> > +
> > +          function:
> > +            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, LOS,
> > +                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XLT,
> > +                    GPI, GPOH, GPOL ]
> > +
> > +        required:
> > +          - pins
> > +          - function
> > +
> > +  lantiq,data-rate-bps:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [2048000, 4096000, 8192000, 16384000]
> > +    default: 2048000
> > +    description:
> > +      Data rate (bit per seconds) on the system highway.
> > +
> > +  lantiq,clock-falling-edge:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Data is sent on falling edge of the clock (and received on the rising
> > +      edge). If 'clock-falling-edge' is not present, data is sent on the
> > +      rising edge (and received on the falling edge).
> > +
> > +  lantiq,channel-phase:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +    default: 0
> > +    description:
> > +      The pef2256 delivers a full frame (32 8bit time-slots in E1 and 24 8bit
> > +      time-slots 8 8bit signaling in E1/J1) every 125us. This lead to a data
> > +      rate of 2048000 bit/s. When lantiq,data-rate-bps is more than 2048000
> > +      bit/s, the data (all 32 8bit) present in the frame are interleave with
> > +      unused time-slots. The lantiq,channel-phase property allows to set the
> > +      correct alignment of the interleave mechanism.
> > +      For instance, suppose lantiq,data-rate-bps = 8192000 (ie 4*2048000), and
> > +      lantiq,channel-phase = 2, the interleave schema with unused time-slots
> > +      (nu) and used time-slots (XX) for TSi is
> > +        nu nu XX nu nu nu XX nu nu nu XX nu
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +      With lantiq,data-rate-bps = 8192000, and lantiq,channel-phase = 1, the
> > +      interleave schema is
> > +        nu XX nu nu nu XX nu nu nu XX nu nu
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +      With lantiq,data-rate-bps = 4096000 (ie 2*2048000), and
> > +      lantiq,channel-phase = 1, the interleave schema is
> > +        nu    XX    nu    XX    nu    XX
> > +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> > +
> > +patternProperties:
> > +  '^codec(-([0-9]|[1-2][0-9]|3[0-1]))?$':
> > +    type: object
> > +    $ref: /schemas/sound/dai-common.yaml
> > +    unevaluatedProperties: false
> > +    description:
> > +      Codec provided by the pef2256. This codec allows to use some of the PCM
> > +      system highway time-slots as audio channels to transport audio data over
> > +      the E1/T1/J1 lines.
> > +      The time-slots used by the codec must be set and so, the properties
> > +      'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> > +      'dai-tdm-slot-rx-mask' must be present in the sound card node for
> > +      sub-nodes that involve the codec. The codec uses 8bit time-slots.
> > +      'dai-tdm-tdm-slot-with' must be set to 8.
> > +      The tx and rx masks define the pef2256 time-slots assigned to the codec.
> > +
> > +    properties:
> > +      compatible:
> > +        const: lantiq,pef2256-codec
> > +
> > +      '#sound-dai-cells':
> > +        const: 0
> > +
> > +      framer:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description:
> > +          phandle to the framer node  
> 
> That's just the parent. Why do you need this?

It is a mistake.
You're right, as it simply refers the parent it is not needed.
This 'framer' phandle will be removed in the next iteration.

Regards,
Hervé
