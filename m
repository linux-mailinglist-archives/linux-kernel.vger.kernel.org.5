Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903387A43CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbjIRIDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbjIRIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:02:57 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB07CC1;
        Mon, 18 Sep 2023 01:02:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CE67240003;
        Mon, 18 Sep 2023 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695024135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swps3A5n7FEUQFidSq00HP9HJSFws8n5Srz8c0lIaak=;
        b=mTtoy6QkMgiN1fFQIcZ/I6T7HLsDUUmwQoWtrmWRlgrRvSas5Y7ZueYbwoJcUN5yMH2yE2
        rj4dWdQ6co74kek9BKb9F/H6NwOQRX4Jex9aAufBH2aMxpqfbXgnKTgSouDPKghgm3ZIbN
        0VKiQ8YK/f5peyquPIPxk8etPNK4sD54n5G2AQQ80Rx2zng9rBXyVd6nnujIr6FHdWS3ip
        lu2JQGyBg2Xug/JUmjSiIku/CdJGdk7gFmSxLSKKbxxqutDwplBgwnF91+lH+N1nRl0Raz
        oFEGjruxqwEzZCtgwWJYoWD0cq3f49JsenqqV9fSu+rmaOvAaMEcs4CM3BlnmA==
Date:   Mon, 18 Sep 2023 10:02:10 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Conor Dooley <conor@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 25/31] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230918100210.2946f1e0@bootlin.com>
In-Reply-To: <20230918094919.03835d40@bootlin.com>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
        <20230912101444.225809-1-herve.codina@bootlin.com>
        <20230912-overplay-donated-080eb97803d6@spud>
        <992a2b31-e21f-eee3-8bfc-a65b69fe5bd7@csgroup.eu>
        <20230918094919.03835d40@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 09:49:19 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Christophe,
> 
> On Tue, 12 Sep 2023 18:49:26 +0000
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> > Le 12/09/2023 à 20:13, Conor Dooley a écrit :  
> > > Yo,
> > > 
> > > I'm not au fait enough with this to leave particularly meaningful
> > > comments, so just some minor ones for you.
> > > 
> > > On Tue, Sep 12, 2023 at 12:14:44PM +0200, Herve Codina wrote:    
> > >> The Lantiq PEF2256 is a framer and line interface component designed to
> > >> fulfill all required interfacing between an analog E1/T1/J1 line and the
> > >> digital PCM system highway/H.100 bus.
> > >>
> > >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>    
> > > 
> > > Missing a co-developed-by?    
> > 
> > No, I guess it's a left-over of version v4 that I sent-out while Hervé 
> > was AFK.
> > 
> > If a v6 is sent I think this line can be removed.  
> 
> May I move to reviewed-by ?

Your signed-of tag is present on all patches (left-over of version v4)
May I remove your signed-of (or move to reviewed-by if relevant) in all patches
present in this series ?

Best regards,
Hervé

> 
> > 
> > Christophe  
> 
> 
> 



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
