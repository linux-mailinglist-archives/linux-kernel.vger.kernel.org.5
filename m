Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB977F1168
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKTLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjKTLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:11:27 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167D1995
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:10:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r52AM-000764-P7; Mon, 20 Nov 2023 12:10:10 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r52AK-00AKxL-MV; Mon, 20 Nov 2023 12:10:08 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r52AK-002x1I-Iw; Mon, 20 Nov 2023 12:10:08 +0100
Date:   Mon, 20 Nov 2023 12:10:08 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <20231120111008.GC590719@pengutronix.de>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120110944.66938859@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Köry,

On Mon, Nov 20, 2023 at 11:09:44AM +0100, Köry Maincent wrote:
> +Oleksij
> 
> Sorry forgot to CC you the series.
> Maybe you should add yourself to the MAINTAINERS of pse-pd drivers subsystem?

ack, i'll take a look at this.

> On Sat, 18 Nov 2023 18:38:43 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Thu, Nov 16, 2023 at 03:01:34PM +0100, Kory Maincent wrote:
> > > In the current PSE interface for Ethernet Power Equipment, support is
> > > limited to PoDL. This patch extends the interface to accommodate the
> > > objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> > > Equipment (PSE).  
> > 
> > Sorry for taking a while getting to these patches. Plumbers and other
> > patches have been keeping me busy.
> 
> Don't worry you are doing a great job as a net maintainer and I won't raise any
> remarks on delay considering how you are doing your job.
> Thanks again for your review!!
> 
> > I'm trying to get my head around naming... Is there some sort of
> > hierarchy? Is PSE the generic concept for putting power down the
> > cable? Then you have the sub-type PoDL, and the sub-type PoE?
> 
> In fact as we discussed with Oleksij I decided to keep the naming as close as
> possible to the IEEE 802.3 standard.
> On the standard the PODL is naming like this aPoDLPSE* (ex: aPoDLPSEAdminState)
> and the PSE is naming like this aPSE* (ex: aPSEAdminState) without any PoE
> prefix. Maybe it is due to PoE being supported before PoDL and they didn't
> expect the PoDL part.

"PoE" (initially Power via MDI?) and PoDL have kind of different technologies.
They use different negotiation and need different physical implementation.
IEEE 802.3 standard is trying to be backwards and kind of forwards compatible
for PoE. But not compatible between PoE and PoDL.

In general, it is not just about enabling or disabling power.
"admin_state" == enable is other way to say - "do the right thing".
And the "right thing" may include some kind of communication between PSE
(Power Source Equipment) and PD (Powered Device).

Since, some variants of  Single Pair Ethernet (SPE) are using same
auto negotiation protocol as not SPE variants. I can imagine, that some
day we will see a hybrid (SPE+nonSPE) devices. Wich will need to
support both: PoE and PoDL. I assume, in that case, we wont to be able
to control both variants separately.

This is why I prefer to have mapping of IEEE 802.3 specification to the
user space as close as possible.

> > >  struct pse_control_config {
> > >  	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > +	enum ethtool_pse_admin_state admin_control;  
> > 
> > When i look at this, it seems to me admin_control should be generic
> > across all schemes which put power down the cable, and
> > podl_admin_control is specific to how PoDL puts power down the cable.
> >
> > Since you appear to be adding support for a second way to put power
> > down the cable, i would expect something like poe_admin_control being
> > added here. But maybe that is in a later patch?
> 
> No as said above admin_control is for PoE and podl_admin_control is for PoDL.
> Maybe you prefer to use poe_admin_control, and add poe prefix in the poe
> variables. It will differ a bit from the IEEE standard naming but I agreed that
> it would be more understandable in the development part.

Official name for "PoE" is "Power via Media Dependent Interface". PoE is
not used in the IEEE 802.3-2018. Using names not used in the specification,
make development even harder :)
Especially since there are even more marketing names (names not used in the
specification) for different PoE variants:
- 802.3af (802.3at Type 1), PoE
- 802.3at Type 2, PoE+
- 802.3bt Type 3, 4PPoE or PoE++
- 802.3bt Type 4, 4PPoE or PoE++

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
