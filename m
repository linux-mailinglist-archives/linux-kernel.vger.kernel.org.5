Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD179361B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjIFHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjIFHVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:21:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09BE41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:21:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qdmqp-0005ue-Kw; Wed, 06 Sep 2023 09:21:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qdmqo-004NIR-6Z; Wed, 06 Sep 2023 09:21:22 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qdmqn-0025Qy-Tt; Wed, 06 Sep 2023 09:21:21 +0200
Date:   Wed, 6 Sep 2023 09:21:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Message-ID: <20230906072121.GA492117@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:03:20AM +0100, Robin Murphy wrote:
> On 2023-09-04 12:58, Sascha Hauer wrote:
> > Add rockchip,io-domains property to the Rockchip pinctrl driver. This
> > list of phandles points to the IO domain device(s) the pins of the
> > pinctrl driver are supplied from.
> > 
> > Also a rockchip,io-domain-boot-on property is added to pin groups
> > which can be used for pin groups which themselves are needed to access
> > the regulators an IO domain is driven from.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >   .../bindings/pinctrl/rockchip,pinctrl.yaml          | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > index 10c335efe619e..92075419d29cf 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > @@ -62,6 +62,11 @@ properties:
> >         Required for at least rk3188 and rk3288. On the rk3368 this should
> >         point to the PMUGRF syscon.
> > +  rockchip,io-domains:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Phandles to io domains
> > +
> >     "#address-cells":
> >       enum: [1, 2]
> > @@ -137,7 +142,13 @@ additionalProperties:
> >               - description:
> >                   The phandle of a node contains the generic pinconfig options
> >                   to use as described in pinctrl-bindings.txt.
> > -
> > +      rockchip,io-domain-boot-on:
> 
> I don't think "on" is a particularly descriptive or useful property name for
> something that has no "off" state.

In fact it has an "off" state. A IO Domain can be disabled in the SoC
registers and also the corresponding regulator can be disabled.

> Furthermore it's no help at all if the DT
> consumer *is* the bootloader that's expected to configure this in the first
> place. IMO it would seem a lot more sensible to have an integer (or enum)
> property which describes the actual value for the initial I/O domain
> setting.

I agree though that a particular setting instead of a boolean is better
and could help the bootloader.

> Then Linux can choose to assume the presence of the property at all
> implies that the bootloader should have set it up already, but also has the
> option of actively enforcing it as well if we want to.

Ok.

Thanks,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
