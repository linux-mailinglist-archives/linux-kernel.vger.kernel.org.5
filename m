Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628BF7F3444
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjKUQxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKUQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:53:40 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE39113;
        Tue, 21 Nov 2023 08:53:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CE3C6000B;
        Tue, 21 Nov 2023 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700585614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n02adsIvyblEozYaL9kieTrZl/WHapBpg8ySkC5Rsmo=;
        b=iqdm9xd88QUoCRBrFpluE/q44QmcnEPu0yhe/WVswF6dVuLGela12+s0emF5H4mYpLynIy
        s0yZfQL3IKnUZh+hBRCCF9elHteEPEKsDgrGH7PvItYqYQzh5lb67lIiKJhhCyztZA64MW
        15Mt9HDl1umMGmiDi/Ad9jdiiGgnt9aq1Au4vgb/Pgb+aARJPTIWoLVlNRCWcj0+lgMdDg
        y0iuv9chCqQN7Z0sIo/++nymEIxNqLAlbDIG8oT1Rqf5XY6zTMFlEPQfbsRNWf+Xh7Eiaq
        7UK0500YQMzyNMiHQRDsEshFGKh7YF5nDTtU+6h5xalvcxCbBBKfKiqyEjnFcw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Nov 2023 17:53:32 +0100
Message-Id: <CX4NADEZZEO1.3TXPVNOONKBCF@tleb-bootlin-xps13-01>
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Cc:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-1-038c7e4a3df4@bootlin.com>
 <6f0da181-717c-4b14-ba3f-d287efe4105b@linaro.org>
In-Reply-To: <6f0da181-717c-4b14-ba3f-d287efe4105b@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon Nov 20, 2023 at 6:32 PM CET, Krzysztof Kozlowski wrote:
> On 20/11/2023 18:06, Th=C3=A9o Lebrun wrote:
> > On this platform, the controller & its wrapper are reset on resume. Thi=
s
> > makes it have a different behavior from other platforms.
> >=20
> > We allow using the new compatible with a fallback onto the original
> > ti,j721e-usb compatible. We therefore allow using an older kernel with
>
> Where is fallback ti,j721e-usb used? Please point me to the code.

No fallback is implemented in code. Using a kernel that doesn't have
this patch series but a more recent devicetree: DT has both
devicetrees & the kernel will know which driver to use.

That is opposed to having only compatible =3D "ti,j7200-usb". If using an
old kernel, it would not know what driver to match it to.

[...]

> > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > @@ -12,11 +12,15 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - const: ti,j7200-usb
> >        - const: ti,j721e-usb
> >        - const: ti,am64-usb
> >        - items:
> >            - const: ti,j721e-usb
> >            - const: ti,am64-usb
> > +      - items:
> > +          - const: ti,j721e-usb
>
> This makes little sense. It's already on the list. Twice! Don't add it
> third time.
>
> I am sorry, but this binding makes no sense. I mean, existing binding
> makes no sense, but your change is not making it anyhow better.

The goal of the DT schema pre-patch was to allow all three:

   compatible =3D "ti,j721e-usb";
   compatible =3D "ti,am64-usb";
   compatible =3D "ti,j721e-usb", "ti,am64-usb";

I've followed the same scheme & added both of those:

   compatible =3D "ti,j7200-usb";
   compatible =3D "ti,j7200-usb", "ti,j721e-usb";

I messed up the ordering in the added 'items' options, but the logic
seems right to me. And dtbs_check agrees. Am I missing something?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
