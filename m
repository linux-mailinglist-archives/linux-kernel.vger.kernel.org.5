Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F57AD5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjIYK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:28:14 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679DF8E;
        Mon, 25 Sep 2023 03:28:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A3201C0002;
        Mon, 25 Sep 2023 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695637685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtO8T+sDShN7p7U0G6qKR0fuN42cZzhkfeW3eGEM+Oc=;
        b=LVvprKIVChYwTJzlxBd2ZNYXBHm9J7hWY1K7wpTo7zgvqzqBZGISmFtj5OfIFjje66P6S6
        HlEwH3l0nVjpj8nD5vuMQ04HpzK0kR9ZM/U4jh0pWSEMRb4F5bMp+1A6JeZwWYC3nZTpNn
        /U6LnsAPSh0QZnEt3y0Lr0BoJp0UQrIcws9zjf3FD4NOdCmt44AIAujr+TSxw3+AlvXtxH
        hfW+hGSVKZ+Hawd0vhvwNMVNosgsJYz2ky2HPFjrWkgsQ6PX7giQJvvsZAQmr4u96kgbX/
        2NKS6FPh8EB5P2zy/eURoCGbCNJb1KY9NL1nF8B1faIJpM3bP2F6JtT1GYIe7w==
Date:   Mon, 25 Sep 2023 12:27:58 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
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
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 08/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <20230925122758.43963736@bootlin.com>
In-Reply-To: <5b804a1a-6bfd-429d-ad84-696b7ecef72d@linaro.org>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
        <20230922075913.422435-9-herve.codina@bootlin.com>
        <5efae150-3d92-81b8-5c25-68846d27132e@linaro.org>
        <20230925101703.1bf083f1@bootlin.com>
        <5b804a1a-6bfd-429d-ad84-696b7ecef72d@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 10:21:15 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/09/2023 10:17, Herve Codina wrote:
> > Hi Krzysztof,
> > 
> > On Sat, 23 Sep 2023 19:39:49 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 22/09/2023 09:58, Herve Codina wrote:  
> >>> The QMC (QUICC mutichannel controller) is a controller present in some
> >>> PowerQUICC SoC such as MPC885.
> >>> The QMC HDLC uses the QMC controller to transfer HDLC data.
> >>>
> >>> Additionally, a framer can be connected to the QMC HDLC.
> >>> If present, this framer is the interface between the TDM bus used by the
> >>> QMC HDLC and the E1/T1 line.
> >>> The QMC HDLC can use this framer to get information about the E1/T1 line
> >>> and configure the E1/T1 line.
> >>>
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> ---
> >>>  .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 24 +++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> >>> index 82d9beb48e00..61dfd5ef7407 100644
> >>> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> >>> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> >>> @@ -101,6 +101,27 @@ patternProperties:
> >>>            Channel assigned Rx time-slots within the Rx time-slots routed by the
> >>>            TSA to this cell.
> >>>  
> >>> +      compatible:
> >>> +        const: fsl,qmc-hdlc    
> >>
> >> Why this is not a device/SoC specific compatible?  
> > 
> > This compatible is present in a QMC channel.
> > The parent node (the QMC itself) contains a compatible with device/SoC:
> > --- 8< ---
> >   compatible:
> >     items:
> >       - enum:
> >           - fsl,mpc885-scc-qmc
> >           - fsl,mpc866-scc-qmc
> >       - const: fsl,cpm1-scc-qmc
> > --- 8< ---
> > 
> > At the child level (ie QMC channel), I am not sure that adding device/SoC
> > makes sense. This compatible indicates that the QMC channel is handled by
> > the QMC HDLC driver.
> > At this level, whatever the device/SoC, we have to be QMC compliant.
> > 
> > With these details, do you still think I need to change the child (channel)
> > compatible ?  
> 
> From OS point of view, you have a driver binding to this child-level
> compatible. How do you enforce Linux driver binding based on parent
> compatible? I looked at your next patch and I did not see it.

We do not need to have the child driver binding based on parent.
We have to ensure that the child handles a QMC channel and the parent provides
a QMC channel.

A QMC controller (parent) has to implement the QMC API (include/soc/fsl/qe/qmc.h)
and a QMC channel driver (child) has to use the QMC API.

Best regards,
Hervé

> 
> Best regards,
> Krzysztof
> 
