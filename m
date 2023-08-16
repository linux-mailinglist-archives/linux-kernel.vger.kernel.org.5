Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983A77E5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjHPPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbjHPPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:50:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C92D58;
        Wed, 16 Aug 2023 08:50:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88A01E0008;
        Wed, 16 Aug 2023 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692201004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7qqsraPhv0yClgxA/hyk25/qkMt80mxh+Qel/Qxjxk=;
        b=aTA9l5F6XqBRUIBDAk06nQK/nIEigxkLt66oO1lwGxbsCjnlCIksXy66MYVGgyPuPhY0NJ
        vcgwSZPKuyDa3dpID6QwUfiGt+IN8msV8YcunSM7kYtF1MGNuhN3WTTVxkX+EPgysd5VQG
        Y1STGp7KLgLqOUDDP+50lCSdlCa8KUV9rkbZbfyStWE5OcI3ADLgii1Ip6/MvbsBxhQlDj
        6u2BmR71zqZy9okYfyhuIL6jZaEld4kQiGU7rMUIwVCh7I2/PYqV1NMKGK610szgjiBcZk
        w7ZnmE8N4F7hjEK/ew8ZCi5q3X25mzwLmN2yTK1pO+C2UzINVFe4WGbLTiP2Kg==
Date:   Wed, 16 Aug 2023 17:49:58 +0200
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
Subject: Re: [PATCH v3 22/28] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230816174847.4709a428@bootlin.com>
In-Reply-To: <CACRpkdZWHw7sL6EKe0EP0hX5TEsdhzgkPSdVtPPYhS3LqJRHFg@mail.gmail.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
        <20230809132757.2470544-23-herve.codina@bootlin.com>
        <CACRpkdZWHw7sL6EKe0EP0hX5TEsdhzgkPSdVtPPYhS3LqJRHFg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, 10 Aug 2023 10:53:04 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Herve,
> 
> thanks for your patch!
> 
> On Wed, Aug 9, 2023 at 3:28 PM Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > The Lantiq PEF2256 is a framer and line interface component designed to
> > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > digital PCM system highway/H.100 bus.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> (...)
> > +    patternProperties:
> > +      '-pins$':
> > +        type: object
> > +        $ref: /schemas/pinctrl/pincfg-node.yaml#  
> 
> Shouldn't that be pinmux-node.yaml?
> 

Indeed, it should be pinmux-node.yaml.
This will be fixed in the next iteration.

Best regards,
Hervé
