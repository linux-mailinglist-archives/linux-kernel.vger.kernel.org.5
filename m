Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00AE7874FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbjHXQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbjHXQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:12:51 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0619A1;
        Thu, 24 Aug 2023 09:12:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F04C5E0005;
        Thu, 24 Aug 2023 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692893566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWHYcTT1R00OlgvYpsdbga3jUacdQWbdaLMRIeCkuOk=;
        b=o3QwsmK2FkbSQQGVgH0r4CH2l+KHT1naLRa+8O4jnppkxUjmSV9BBELqg+inpHy5Cet2rp
        qBDmniV7E0RwlKex4e4GRe5r+saUTse2nqNsGVNNzmqV+TeTp5wwbwsF6Kp9pftidD/etL
        tOVcLgqL0xCEf//PmXkfER5jBDomV3tlg352m8cwcpRieChJYez7b4IaKHFwFmTrPgHWzw
        hw3uA6S865nzlYdgJ+PrHS4sb6Ybrs7aFOmsdGwyTMlPts0FYdj5CV5fOjnoWasNCGK0y6
        mRZuRCE3D9IJ4+PvTk1tiWYomxkq7J/NS8xSq18siGc9VMHe5mGR4m5TP8YzIg==
Date:   Thu, 24 Aug 2023 18:12:40 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
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
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 06/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230824181240.13d14f69@bootlin.com>
In-Reply-To: <20230821204258.GA2253571-robh@kernel.org>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
        <817d1418fa1e9e689375177bee4bdc68ceeab7be.1692376361.git.christophe.leroy@csgroup.eu>
        <20230821204258.GA2253571-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 15:42:58 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, Aug 18, 2023 at 06:39:00PM +0200, Christophe Leroy wrote:
> > From: Herve Codina <herve.codina@bootlin.com>
> > 
> > The QMC (QUICC mutichannel controller) is a controller present in some
> > PowerQUICC SoC such as MPC885.
> > The QMC HDLC uses the QMC controller to transfer HDLC data.
> > 
> > Additionally, a framer can be connected to the QMC HDLC.
> > If present, this framer is the interface between the TDM bus used by the
> > QMC HDLC and the E1/T1 line.
> > The QMC HDLC can use this framer to get information about the E1/T1 line
> > and configure the E1/T1 line.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > new file mode 100644
> > index 000000000000..13f3572f0feb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale/NXP QUICC Multichannel Controller (QMC) HDLC
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +description: |  
> 
> Don't need '|'

Will be fixed in the next iteration.

> 
> > +  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to transfer
> > +  HDLC data.
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,qmc-hdlc
> > +
> > +  fsl,qmc-chan:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to QMC node
> > +          - description: Channel number
> > +    description:
> > +      Should be a phandle/number pair. The phandle to QMC node and the QMC
> > +      channel to use.
> > +
> > +  framer:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the framer node  
> 
> What's the framer? 

A framer is a component in charge of an E1/T1 line interface.
Is is connected to the TDM bus and it converts TDM frames to/from E1/T1
frames.
The HDLC data are sent/received to/from the TDM bus and the framer is used to
get information about the E1/T1 line such as link up/down.

I can update the description to:
--- 8< ---
phandle to the framer node. The framer is in charge of an E1/T1 line
interface connected to the TDM bus. It can be used to get the E1/T1 line
status such as link up/down.
--- 8< ---

Is that better ?

> 
> > +
> > +required:
> > +  - compatible
> > +  - fsl,qmc-chan
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    hdlc {
> > +        compatible = "fsl,qmc-hdlc";
> > +        fsl,qmc-chan = <&qmc 16>;  
> 
> Where does this node live?
> 
> QMC is this[1]? Why don't you just add the compatible to channel@10 in 
> the QMC node?

Indeed, I will move the properties (compatible and framer phandle) to the
QMC channel node.

> 
> Rob
> 
> [1] Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
