Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2129E76E305
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHCI13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjHCI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:26:58 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A21DA;
        Thu,  3 Aug 2023 01:23:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2FEE240009;
        Thu,  3 Aug 2023 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691051037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SELzQVaBhYhBIwDx2p1Pj2orowZttNN9xEZBvwg3M2A=;
        b=RVTarNgcL5Lqc7frx4gWP/ChoTOIAY8Fu3KgXKvID229jSKmin5+L8FZS/XNa16aJHi1KY
        wz9mh3d+mtrD5kLKgg+Zutnd8XZuvlkIUEwQ0cq8fgICHjtlWk90qU3ll40vm9fQ6sgBYt
        jWUNMx5+8UL1/5UQkRIHvpUOLwbvW975dS7ytocUjT10MoEBEQuXo1vdX9F/n3IbVI7f5J
        fJGShMAO+3iod4LDPehoOxic7SeHcJ0ugCGHqhtjY6hpHJRwEvpXfWlNWLPRj5EpTue6Sy
        CurrNWc3DoqhLfQa+toQI/c+59kPiyF9gaOcm6Gmn3Ns706aP03UhG8j19SsWw==
Date:   Thu, 3 Aug 2023 10:23:47 +0200
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
Subject: Re: [PATCH v2 27/28] dt-bindings: net: fsl,qmc-hdlc: Add framer
 support
Message-ID: <20230803102347.74706421@bootlin.com>
In-Reply-To: <20230803004259.GA1598510-robh@kernel.org>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-28-herve.codina@bootlin.com>
        <20230803004259.GA1598510-robh@kernel.org>
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

On Wed, 2 Aug 2023 18:42:59 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 26, 2023 at 05:02:23PM +0200, Herve Codina wrote:
> > A framer can be connected to the QMC HDLC.
> > If present, this framer is the interface between the TDM used by the QMC
> > HDLC and the E1/T1 line.
> > The QMC HDLC can use this framer to get information about the line and
> > configure the line.
> > 
> > Add an optional framer property to reference the framer itself.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > index 8bb6f34602d9..bf29863ab419 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
> > @@ -27,6 +27,11 @@ properties:
> >        Should be a phandle/number pair. The phandle to QMC node and the QMC
> >        channel to use.
> >  
> > +  framer:
> > +    $ref: /schemas/types.yaml#/definitions/phandle  
> 
> Now you've defined this property twice. Please avoid doing that.

I don't see what you mean.

I previously defined the framer property at the framer-codec node as it is
a framer consumer (it was a mistake because this framer-codec node is a child of
the framer node but that's an other story).

Here, at the qmc-hdlc node, I define this property in order to use the framer as a
consumer too.

What is wrong ?

Best regards,
Hervé

> 
> > +    description:
> > +      phandle to the framer node
> > +
> >  required:
> >    - compatible
> >    - fsl,qmc-chan
> > -- 
> > 2.41.0
> >   
