Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB1764FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjG0JaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjG0J3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:29:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975C9AB5;
        Thu, 27 Jul 2023 02:20:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FF5120009;
        Thu, 27 Jul 2023 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690449599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5uC+Ma0+GEtuYByV1fh5wNUb6P+Qvr99RmBUDDugXA=;
        b=PWL77lXoaqzqWHDfFIl9jdKdv1M4MuRzjjxUGyq7w0BvAYoX3gBbaTeU5NM2l5MhMLkRlB
        8Qc/C0E21db1XjGM/LWuV5Bj7nKFIgG6tObRGld5USHJ0Pu9/09eNFltserlLCc+0QRfod
        4UB45gpmXCPKsJsQV3ekLDhlsSgr5UHkjj3htsrfjNdmwYc+SnTrWkoHiO5mF7G0E5vz+4
        mmPH7kW2lmk4+Aa6SZuxQXNnb6Zu7inndp5s2/t1YafIK5XA0Pcx5pjnqwsmpk/zP61pn8
        RIvivFsxuBkNmUPozqTqQeCifCJZ/iII6VSnwNSdw00aHZzQ5xSykuJAwf4yqQ==
Date:   Thu, 27 Jul 2023 11:19:55 +0200
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
Subject: Re: [PATCH v2 27/28] dt-bindings: net: fsl,qmc-hdlc: Add framer
 support
Message-ID: <20230727111955.43571766@bootlin.com>
In-Reply-To: <20230727-jailer-recede-a62ab2238581@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-28-herve.codina@bootlin.com>
        <20230727-jailer-recede-a62ab2238581@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, 27 Jul 2023 09:12:01 +0100
Conor Dooley <conor@kernel.org> wrote:

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
> 
> Why not fully describe the hardware in one patch in this series, rather
> than split this over two different ones?

I agree, this can be squashed with a previous commit.
My intention was to keep things separated in this first series.

The framer property makes sense only if the stuff related the generic framer
(previous patches) are accepted whereas the QMC HDLC previous binding can be
accepted without this framer property.
I though it would be easier to review the full series with separated
modifications.

That's said, I will squash this patch with the patch 5 ("dt-bindings: net:
Add support for QMC HDLC") in the next iteration.

Best regards,
Hervé

> 
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
> > +    description:
> > +      phandle to the framer node
> > +
> >  required:
> >    - compatible
> >    - fsl,qmc-chan
> > -- 
> > 2.41.0
> >   
