Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB67727AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjHGO1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHGO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:27:35 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764AE79;
        Mon,  7 Aug 2023 07:27:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A286EFF808;
        Mon,  7 Aug 2023 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691418448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSKlAqEgzEsFnBW7d8u/9h1ZprRRwuRKRLFQ+P/wUY8=;
        b=LywQYvYZoJqcYSSsOLGqNNJCC9NtdSGpEXpSP7h89QnexEqHiRwsI7y1Fopm8khwM4Jado
        UYh+3ucNoG1TlHOxwycpd6wl86Ww1bH1aU60cma+N9WOR0OpLat30VEL6CeBvM4lykiuLw
        YTsewxWRSsSjNtpcSTDCC/w5lLkMGaNv7Xw1yRiyjXwkVqDQrnGE9qAK5QvgIhhrsRkXmb
        mp7wMTZO2Ss/rYbZR46XbfqZndue72KIO/PVTyaSLyZCXcr1LoUkH4LYGHzC6pgv3/FZsS
        y1yxUPZoU8Fr9gDi5km21Xjd+hZnD+9mY+D/84flAYhqMYAgZ0XHWK6gTENonw==
Date:   Mon, 7 Aug 2023 16:27:21 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256
 pinmux
Message-ID: <20230807162721.56318743@bootlin.com>
In-Reply-To: <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-25-herve.codina@bootlin.com>
        <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 7 Aug 2023 15:05:15 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Herve,
> 
> thanks for your patch!
> 
> First: is this patch something we could merge separately? I don't see
> any dependency on the other patches.

It depends on pef2256:
in drivers/pinctrl/Kconfig:
--- 8< ---
+config PINCTRL_PEF2256
+	tristate "Lantiq PEF2256 (FALC56) pin controller driver"
+	depends on OF && FRAMER_PEF2256
--- 8< ---
in drivers/pinctrl/pinctrl-pef2256.c
--- 8< ---
+#include <linux/framer/pef2256.h>
--- 8< ---

All the pef2256 it depends on is provided by
 path 23/28 "net: wan: framer: Add support for the Lantiq PEF2256 framer"

> 
> On Wed, Jul 26, 2023 at 5:04 PM Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> >
> > This pinmux support handles the pin muxing part (pins RP(A..D) and pins
> > XP(A..D)) of the PEF2256.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> So it is a bridge chip? Please use that terminology since Linux
> DRM often talks about bridges.
> 
> > +++ b/drivers/pinctrl/pinctrl-pef2256-regs.h  
> (...)
> > +#include "linux/bitfield.h"  
> 
> Really? I don't think there is such a file there.
> 
> Do you mean <linux/bitfield.h> and does this even compile?

Yes and it compiles (even with quoted included file).
I will be changed to <linux/bitfield.h> in the next interation.

> 
> > diff --git a/drivers/pinctrl/pinctrl-pef2256.c b/drivers/pinctrl/pinctrl-pef2256.c  
> (...)
> > +struct pef2256_pinctrl {
> > +       struct device *dev;
> > +       struct regmap *regmap;
> > +       enum pef2256_version version;
> > +       struct {
> > +               struct pinctrl_desc pctrl_desc;
> > +               const struct pef2256_function_desc *functions;
> > +               unsigned int nfunctions;
> > +       } pinctrl;  
> 
> Uh anonymous struct... can't you just define the struct separately
> with a name? Or fold it into struct pef2256_pinctrl without the
> additional struct? Thanks.

I will fold it into struct pef2256_pinctrl in the next iteration.

Thanks
Hervé

> 
> Otherwise it looks neat!
> 
> Yours,
> Linus Walleij
