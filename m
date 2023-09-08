Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD3798332
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjIHHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjIHHVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:21:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A631BCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:21:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeVnV-0007vb-OL; Fri, 08 Sep 2023 09:20:57 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeVnU-004pP2-DM; Fri, 08 Sep 2023 09:20:56 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeVnT-003Drf-GB; Fri, 08 Sep 2023 09:20:55 +0200
Date:   Fri, 8 Sep 2023 09:20:55 +0200
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
Message-ID: <20230908072055.GE637806@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
 <20230906072121.GA492117@pengutronix.de>
 <5165d26f-d5fe-13e9-7940-b73e27b2bea7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5165d26f-d5fe-13e9-7940-b73e27b2bea7@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:35:26PM +0100, Robin Murphy wrote:
> On 2023-09-06 08:21, Sascha Hauer wrote:
> > On Tue, Sep 05, 2023 at 10:03:20AM +0100, Robin Murphy wrote:
> > > On 2023-09-04 12:58, Sascha Hauer wrote:
> > > > Add rockchip,io-domains property to the Rockchip pinctrl driver. This
> > > > list of phandles points to the IO domain device(s) the pins of the
> > > > pinctrl driver are supplied from.
> > > > 
> > > > Also a rockchip,io-domain-boot-on property is added to pin groups
> > > > which can be used for pin groups which themselves are needed to access
> > > > the regulators an IO domain is driven from.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >    .../bindings/pinctrl/rockchip,pinctrl.yaml          | 13 ++++++++++++-
> > > >    1 file changed, 12 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > > > index 10c335efe619e..92075419d29cf 100644
> > > > --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > > > +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> > > > @@ -62,6 +62,11 @@ properties:
> > > >          Required for at least rk3188 and rk3288. On the rk3368 this should
> > > >          point to the PMUGRF syscon.
> > > > +  rockchip,io-domains:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Phandles to io domains
> > > > +
> > > >      "#address-cells":
> > > >        enum: [1, 2]
> > > > @@ -137,7 +142,13 @@ additionalProperties:
> > > >                - description:
> > > >                    The phandle of a node contains the generic pinconfig options
> > > >                    to use as described in pinctrl-bindings.txt.
> > > > -
> > > > +      rockchip,io-domain-boot-on:
> > > 
> > > I don't think "on" is a particularly descriptive or useful property name for
> > > something that has no "off" state.
> > 
> > In fact it has an "off" state. A IO Domain can be disabled in the SoC
> > registers
> 
> Oh, is that a thing on newer SoCs? At least in the RK3399 TRM the only
> I/O-domain-related control I can find is the 1.8V/3.0V logic level threshold
> in GRF_IO_VSEL (plus the one outlier in PMUGRF_SOC_CON0).

I didn't realize that it's new, the RK3568 is the first Rockchip SoC I
work on, but yes, on RK3568 we have three bits per domain. One bit is to
enable 1.8V, one to enable 2.5V and one for 3.3V. I would assume that
clearing all bits means disable, and whatever strange things may happen
when multiple bits are set...

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
