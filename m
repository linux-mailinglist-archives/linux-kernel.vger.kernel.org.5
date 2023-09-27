Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7657AFBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjI0HYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjI0HY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:24:28 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3584BF;
        Wed, 27 Sep 2023 00:24:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1DB71C0005;
        Wed, 27 Sep 2023 07:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695799465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7lheL/fPD30+qWF6kotkKYQgHBfzDpYHPBkU7rqwKc=;
        b=CUxDSg3duEvh2iFUudjI4nwvl79l+61/0VAmFQSu2LRxhgpcqiWvVArxluGLfvz8i5H50g
        /1E6SCgjLvpCudreDT7YjSUJNoddPGTSsaP4qgW8mWZk1r2YQFIKYrFJ/YEM0vSjcRIouF
        jAG7C/ETkfGIPjGdzUf59swSIoGJQUGcVuuayMkzk8au+5Sk7KAiVV36+GbS/U8eAaBUBo
        Pb/APoI1htl9U6jlR0NLt4TNlSJhGv0qMJmsS+9RrcsdPKtRdRr7gPHjPd+Eba7D0t9cHn
        BMVN9LDMWuIFiKvBLMP4Ihx4uyZvHi66OO4LFFFAfTsgo3N8lhrCfO7XudhEyQ==
Date:   Wed, 27 Sep 2023 09:24:18 +0200
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
Message-ID: <20230927092418.6a5326ce@bootlin.com>
In-Reply-To: <e8ee6529-b194-4588-96c0-1459f214d005@linaro.org>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
        <20230922075913.422435-9-herve.codina@bootlin.com>
        <5efae150-3d92-81b8-5c25-68846d27132e@linaro.org>
        <20230925101703.1bf083f1@bootlin.com>
        <5b804a1a-6bfd-429d-ad84-696b7ecef72d@linaro.org>
        <20230925122758.43963736@bootlin.com>
        <e02ebde7-f208-40a4-bb10-aa5962ee9864@linaro.org>
        <20230925154929.2b6a9cab@bootlin.com>
        <e8ee6529-b194-4588-96c0-1459f214d005@linaro.org>
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

Hi Krzysztof,

On Tue, 26 Sep 2023 22:59:14 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/09/2023 15:50, Herve Codina wrote:
> >>>>> With these details, do you still think I need to change the child (channel)
> >>>>> compatible ?      
> >>>>
> >>>> From OS point of view, you have a driver binding to this child-level
> >>>> compatible. How do you enforce Linux driver binding based on parent
> >>>> compatible? I looked at your next patch and I did not see it.    
> >>>
> >>> We do not need to have the child driver binding based on parent.    
> >>
> >> Exactly, that's what I said.
> >>  
> >>> We have to ensure that the child handles a QMC channel and the parent provides
> >>> a QMC channel.
> >>>
> >>> A QMC controller (parent) has to implement the QMC API (include/soc/fsl/qe/qmc.h)
> >>> and a QMC channel driver (child) has to use the QMC API.    
> >>
> >> How does this solve my concerns? Sorry, I do not understand. Your driver
> >> is a platform driver and binds to the generic compatible. How do you
> >> solve regular compatibility issues (need for quirks) if parent
> >> compatible is not used?
> >>
> >> How does being QMC compliant affects driver binding and
> >> compatibility/quirks?
> >>
> >> We are back to my original question and I don't think you answered to
> >> any of the concerns.  
> > 
> > Well, to be sure that I understand correctly, do you mean that I should
> > provide a compatible for the child (HDLC) with something like this:
> > --- 8< ---
> >   compatible:
> >     items:
> >       - enum:
> >           - fsl,mpc885-qmc-hdlc
> >           - fsl,mpc866-qmc-hdlc
> >       - const: fsl,cpm1-qmc-hdlc
> >       - const: fsl,qmc-hdlc
> > --- 8< ---  
> 
> Yes, more or less, depending on actual compatibility and SoC-family.
> Maybe "fsl,cpm1-qmc-hdlc" item in the middle is not needed.

Ok,
I will keep "fsl,cpm1-qmc-hdlc". The CPM1 is the co-processor present in these
SoCs and it handles the QMC controller. So, it makes sense to have it in this
binding.

I plan to add support for other SoCs in the future and for these SoCs, the
co-processor is not the CPM1. So, it makes sense to keep "fsl,cpm1-qmc-hdlc"
to identify the co-processor.

> 
> > 
> > If so, I didn't do that because a QMC channel consumer (driver matching
> > fsl,qmc-hdlc) doesn't contains any SoC specific part.  
> 
> Just like hundreds of other drivers. :)
> 
> There is a paragraph about specific compatibles here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html
> 
> 
> > It uses the channel as a communication channel to send/receive HDLC frames
> > to/from this communication channel.
> > All the specific SoC part is handled by the QMC controller (parent) itself and
> > not by any consumer (child).  
> 
> OK, so you guarantee in 100% for this hardware and all future (including
> designs unknown currently), that they will be 100% compatible with
> existing QMC channel consumer (child, matching fsl,qmc-hdlc) driver,
> thus there will be no need for any quirk. Specifically, there will be no
> chances that it would be reasonable to re-use the same driver for child
> (currently fsl,qmc-hdlc) in different parent.

Right,
compatible strings with SoC and co-processor will be added in the next iteration.

Thanks for your feedback.

Best regards,
Hervé

> 
> P.S. If you received this email twice, apologies, I have here troubles
> with internet.
> 
> Best regards,
> Krzysztof
> 
