Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6579EBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbjIMOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIMOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:53:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C6B3;
        Wed, 13 Sep 2023 07:52:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF61860003;
        Wed, 13 Sep 2023 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694616776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aC2RwGdKDnCnTcsXt08pnHkYtsoUowN+XP5X8ItFDzc=;
        b=EWGGroVBltxzuCTMJt8gh/2G/eIS6B94Qbe3nrqz+sp5y/iQBhr+/O1HKlOYMDY3TE9PC4
        L6RELowCewGfATaEd1BYi5ynfm7M+G1PkGyfClkGeqCeZ7brzmiVhltXORoJIwqFnz62AV
        QMqNup3T4xnUR3CRAG4k1LtxYWyDKI9RySRBsblI79TYUm8eHqFqp+ilb87PZjqsuTVx6R
        OvMePhchN2VhFn45J4AmUqmTFbk4FPvtWSv6ExxPgkEdHEYYNAgC70wnjn+uPT3yEP5nI+
        IjbFoQl30h2z0mrZE0DUi/xfVs+AuF4ogRRsV4TWD7u4En8RdGI0CJTnCncG0w==
Date:   Wed, 13 Sep 2023 16:52:50 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH v5 08/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <20230913165250.02bab2ad@bootlin.com>
In-Reply-To: <20230913-unruly-recite-7dbbbd7e63e0@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
        <20230912101018.225246-1-herve.codina@bootlin.com>
        <20230912-capable-stash-c7a3e33078ac@spud>
        <20230913092640.76934b31@bootlin.com>
        <20230913-unruly-recite-7dbbbd7e63e0@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 15:42:45 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Sep 13, 2023 at 09:26:40AM +0200, Herve Codina wrote:
> > Hi Conor,
> > 
> > On Tue, 12 Sep 2023 18:21:58 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Tue, Sep 12, 2023 at 12:10:18PM +0200, Herve Codina wrote:  
> > > > The QMC (QUICC mutichannel controller) is a controller present in some
> > > > PowerQUICC SoC such as MPC885.
> > > > The QMC HDLC uses the QMC controller to transfer HDLC data.
> > > > 
> > > > Additionally, a framer can be connected to the QMC HDLC.
> > > > If present, this framer is the interface between the TDM bus used by the
> > > > QMC HDLC and the E1/T1 line.
> > > > The QMC HDLC can use this framer to get information about the E1/T1 line
> > > > and configure the E1/T1 line.
> > > > 
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml   | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> > > > index 82d9beb48e00..b5073531f3f1 100644
> > > > --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> > > > +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> > > > @@ -101,6 +101,16 @@ patternProperties:
> > > >            Channel assigned Rx time-slots within the Rx time-slots routed by the
> > > >            TSA to this cell.
> > > >  
> > > > +      compatible:
> > > > +        const: fsl,qmc-hdlc
> > > > +
> > > > +      fsl,framer:
> > > > +        $ref: /schemas/types.yaml#/definitions/phandle
> > > > +        description:
> > > > +          phandle to the framer node. The framer is in charge of an E1/T1 line
> > > > +          interface connected to the TDM bus. It can be used to get the E1/T1 line
> > > > +          status such as link up/down.    
> > > 
> > > Sounds like this fsl,framer property should depend on the compatible
> > > being present, no?  
> > 
> > Well from the implementation point of view, only the QMC HDLC driver uses this
> > property.
> > 
> > From the hardware description point of view, this property means that the time slots
> > handled by this channel are connected to the framer. So I think it makes sense for
> > any channel no matter the compatible (even if compatible is not present).
> > 
> > Should I change and constraint the fsl,framer property to the compatible presence ?
> > If so, is the following correct for this contraint ?
> >    --- 8< ---
> >    dependencies:
> >      - fsl,framer: [ compatible ];
> >    --- 8< ---  
> 
> The regular sort of
> if:
> 	compatible:
> 		contains:
> 			const: foo
> then:
> 	required:
> 		- fsl,framer
> would fit the bill, no?

Not sure.
"fsl,framer" is an optional property (depending on the hardware we can have
a framer or not).

Hervé
