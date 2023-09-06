Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9B7939A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjIFKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjIFKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:19:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFE10C6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:19:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qdpcu-0004oz-GH; Wed, 06 Sep 2023 12:19:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qdpcs-004P41-A9; Wed, 06 Sep 2023 12:19:10 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qdpcr-0029pN-QY; Wed, 06 Sep 2023 12:19:09 +0200
Date:   Wed, 6 Sep 2023 12:19:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Message-ID: <20230906101909.GB492117@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
 <5166ca75-5454-8f64-4f61-fcc0f7a4c235@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5166ca75-5454-8f64-4f61-fcc0f7a4c235@theobroma-systems.com>
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

On Wed, Sep 06, 2023 at 10:20:26AM +0200, Quentin Schulz wrote:
> Sascha, Robin,
> 
> On 9/5/23 11:03, Robin Murphy wrote:
> > [You don't often get email from robin.murphy@arm.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > > +        type: boolean
> > > +        description:
> > > +          If true assume that the io domain needed for this pin
> > > group has been
> > > +          configured correctly by the bootloader. This is needed to
> > > break cyclic
> > > +          dependencies introduced when a io domain needs a
> > > regulator that can be
> > > +          accessed through pins configured here.
> > 
> > This is describing a Linux implementation detail, not the binding
> > itself. There's no technical reason a DT consumer couldn't already
> > figure this much out from the existing topology (by observing that the
> > pinctrl consumer is a grandparent of the I/O domain's supply).
> > 
> 
> I am guessing you're suggesting to have some complex handling in the driver
> to detect those cyclic dependencies and ignore the IO domain dependency for
> the pinctrl pins where this happens?

I haven't read this as a suggestion, but only as an argument to make it
clear that I should describe the binding rather than anticipating
how it should be used.

I may have misunderstood it though.

> One of the issues we're having here too is that we lose granularity. There
> are multiple domains inside an IO domain device and here we make the whole
> pinctrl device depend on all domains from one IO domain device (there can be
> multiple ones) while it is factually (on the HW level) only dependent on one
> domain. Considering (if I remember correctly) Heiko highly suggested we
> think about adding child nodes to the IO domain devices to have a DT node
> per domain in the IO domain device, how would this work with the suggested
> DT binding?

I started implementing that. I have moved the IO domains into subnodes
of the IO domain controller and started adding phandles from the pin
groups in rk3568-pinctrl.dtsi to the corresponding IO domains. After a
couple of hours I had phandles for around a quarter of the existing
groups of only one SoC, so doing this for all SoCs would really be a
cumbersome job.

In the end I realized this doesn't solve any problem. Also adding the
properties I suggested doesn't prevent us from adding the more specific
dependencies from the pins to their actual IO domains later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
