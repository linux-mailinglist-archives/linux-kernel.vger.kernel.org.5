Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D565765150
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjG0Ke7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjG0Ke6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:34:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D8D19A7;
        Thu, 27 Jul 2023 03:34:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBAA01BF207;
        Thu, 27 Jul 2023 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690454095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49SapdFsUUzXkb0zmYsMHZkg7CHiz7VOLc7j0san1b4=;
        b=D7sErss6g6hwoemn0ONI4uqJb+K/IsweOTLB1naVOQSB0jnxItj4HIIYOc01Bt1PCbQWls
        x2lcEAR9Bd9VjcK6MIkZw2GgBXiwTdL0BWCBkLp6FGIk8zL9HeoByCjQcU71EgLZvHIX9c
        ENATbxHfRlfF0SU97Zp8/habefY7ZArdGsISAkXbKwdQKnHTa46Poh7Izti1MQgJHfgtY+
        +trXOG76m0g/9BUX139rvy1EaJBvWlTKa0L2vTIHxz+5+JsANW+49ziW/vf766xYPBj86D
        /xe6CDk60hgIFLNs0LFEukyLTaCTJBZRtsZB+11cVUQUOpWASao2sGMwjhfrJQ==
Date:   Thu, 27 Jul 2023 12:34:49 +0200
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230727123449.0ab1c58e@bootlin.com>
In-Reply-To: <20230727-decidable-sterile-06ef617c144b@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-6-herve.codina@bootlin.com>
        <20230727-talcum-backside-5bdbe2171fb6@spud>
        <20230727110948.7926a532@bootlin.com>
        <20230727-decidable-sterile-06ef617c144b@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, 27 Jul 2023 10:53:15 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jul 27, 2023 at 11:09:48AM +0200, Herve Codina wrote:
> > On Thu, 27 Jul 2023 09:19:59 +0100
> > Conor Dooley <conor@kernel.org> wrote:  
> > > On Wed, Jul 26, 2023 at 05:02:01PM +0200, Herve Codina wrote:  
> 
> > If needed, I can change to:
> >   title: QMC (QUICC Multichannel Controller) HDLC
> > Let me known if it is better to you.  
> 
> If it were me writing the binding, I'd probably use something like
> "Freescale/NXP QUICC Multichannel Controller (QMC) HDLC", but it is not
> a big deal, I just had a "wtf is this" moment :)

I will change to "Freescale/NXP QUICC Multichannel Controller (QMC) HDLC" in
the next iteration.

> 
> 
> 
> > > > +  fsl,qmc-chan:  
> > > 
> > > Perhaps I am just showing my lack of knowledge in this area, but what is
> > > fsl specific about wanting a reference to the channel of a "QMC"?
> > > Is this something that hardware from other manufacturers would not also
> > > want to do?  
> > 
> > The QMC and the QMC channel are something specific to the SoC. This IP is only
> > available on some Freescale/NXP SoCs.
> > 
> > When I upstreamed the 'fsl,qmc-audio.yaml', I first used a generic name for this
> > property and Kristoff asked to change to a vendor prefixed name.
> >   https://lore.kernel.org/linux-kernel/1dfade07-f8c4-2e16-00dc-c7d183708259@linaro.org/
> > 
> > Based on this, as the property 'fsl,qmc-chan' has the exact same meaning in
> > fsl,qmc-audio.yaml and fsl,qmc-hdlc.yaml, I use the same name.  
> 
> Okay, thanks for explaining!

You're welcome.

Regards,
Hervé

