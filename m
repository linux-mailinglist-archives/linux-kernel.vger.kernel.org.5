Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340C7F1E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjKTUm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:42:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590EC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:42:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5B68-0002hD-K6; Mon, 20 Nov 2023 21:42:24 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5B65-00AQeu-Id; Mon, 20 Nov 2023 21:42:21 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5B65-0031TS-Fa; Mon, 20 Nov 2023 21:42:21 +0100
Date:   Mon, 20 Nov 2023 21:42:21 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <20231120204221.GD590719@pengutronix.de>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
 <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
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

On Mon, Nov 20, 2023 at 07:00:03PM +0100, Andrew Lunn wrote:
> > > > >  struct pse_control_config {
> > > > >  	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > > > +	enum ethtool_pse_admin_state admin_control;  
> > > > 
> > > > When i look at this, it seems to me admin_control should be generic
> > > > across all schemes which put power down the cable, and
> > > > podl_admin_control is specific to how PoDL puts power down the cable.
> > > >
> > > > Since you appear to be adding support for a second way to put power
> > > > down the cable, i would expect something like poe_admin_control being
> > > > added here. But maybe that is in a later patch?
> > > 
> > > No as said above admin_control is for PoE and podl_admin_control is for PoDL.
> > > Maybe you prefer to use poe_admin_control, and add poe prefix in the poe
> > > variables. It will differ a bit from the IEEE standard naming but I agreed that
> > > it would be more understandable in the development part.
> > 
> > Official name for "PoE" is "Power via Media Dependent Interface". PoE is
> > not used in the IEEE 802.3-2018. Using names not used in the specification,
> > make development even harder :)
> > Especially since there are even more marketing names (names not used in the
> > specification) for different PoE variants:
> > - 802.3af (802.3at Type 1), PoE
> > - 802.3at Type 2, PoE+
> > - 802.3bt Type 3, 4PPoE or PoE++
> > - 802.3bt Type 4, 4PPoE or PoE++
> 
> From the 2018 standard:
> 
>   1.4.407 Power Sourcing Equipment (PSE): A DTE or midspan device that
>   provides the power to a single link section. PSEs are defined for
>   use with two different types of balanced twisted-pair PHYs. When
>   used with 2 or 4 pair balanced twisted-pair (BASE-T) PHYs, (see IEEE
>   Std 802.3, Clause 33), DTE powering is intended to provide a single
>   10BASE-T, 100BASE-TX, or 1000BASE-T device with a unified interface
>   for both the data it requires and the power to process these
>   data. When used with single balanced twisted-pair (BASE-T1) PHYs
>   (see IEEE Std 802.3, Clause 104), DTE powering is intended to
>   provide a single 100BASE-T1 or 1000BASE-T1 device with a unified
>   interface for both the data it requires and the power to process
>   these data. A PSE used with balanced single twisted-pair PHYs is
>   also referred to as a PoDL PSE.
> 
> So it seems like, anything not PoDL PSE does not have a name :-(
> 
> However, everything not PoDL PSE seems to be clause 33. So how about:
> 
> 	enum ethtool_podl_pse_admin_state podl_admin_control;
> 	enum ethtool_c33_pse_admin_state c33_admin_control;  
> 
> At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> are visible to userspace, but if we don't have a better name, maybe we
> have to use c33 in userspace as well.
> 
> I do think naming like this makes it clear we are talking about two
> parallel technologies, not a generic layer and then extensions for
> podl.
> 
> What do you think?

I'm OK with it.

Köry, can you please include some kernel documentation in your patches?
Something like this. I hope it will help to clarify things :) :

Power Sourcing Equipment (PSE) in IEEE 802.3 Standard
=====================================================

Overview
--------

Power Sourcing Equipment (PSE) is essential in networks for delivering power
along with data over Ethernet cables. It usually refers to devices like
switches and hubs that supply power to Powered Devices (PDs) such as IP
cameras, VoIP phones, and wireless access points.

PSE vs. PoDL PSE
----------------

PSE in the IEEE 802.3 standard generally refers to equipment that provides
power alongside data over Ethernet cables, typically associated with Power over
Ethernet (PoE). 

PoDL PSE, or Power over Data Lines PSE, specifically denotes PSEs operating
with single balanced twisted-pair PHYs, as per Clause 104 of IEEE 802.3. PoDL
is significant in contexts like automotive and industrial controls where power
and data delivery over a single pair is advantageous.

IEEE 802.3-2018 Addendums and Related Clauses
----------------------------------------------

Key addenda to the IEEE 802.3-2018 standard relevant to power delivery over
Ethernet are as follows:

- **802.3af (Approved in 2003-06-12)**: Known as PoE in the market, detailed in
  Clause 33, delivering up to 15.4W of power.
- **802.3at (Approved in 2009-09-11)**: Marketed as PoE+, enhancing PoE as
  covered in Clause 33, increasing power delivery to up to 30W.
- **802.3bt (Approved in 2018-09-27)**: Known as 4PPoE in the market, outlined
  in Clause 33. Type 3 delivers up to 60W, and Type 4 up to 100W.
- **802.3bu (Approved in 2016-12-07)**: Formerly referred to as PoDL, detailed
  in Clause 104. Introduces Classes 0 - 9. Class 9 PoDL PSE delivers up to ~65W

Kernel Naming Convention Recommendations
----------------------------------------

For clarity and consistency within the Linux kernel's networking subsystem, the
following naming conventions are recommended:

- For general PSE (PoE) code, use "c33_pse" key words. For example:
  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
  This aligns with Clause 33, encompassing various PoE forms.

- For PoDL PSE - specific code, use "podl_pse". For example:
  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to differentiate
  PoDL PSE settings according to Clause 104.

Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Dependent Interface (MDI)
-------------------------------------------------------------------------------------------

Clause 33 of the IEEE 802.3 standard defines the functional and electrical
characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE).
These entities enable power delivery using the same generic cabling as for data
transmission, integrating power with data communication for devices such as
10BASE-T, 100BASE-TX, or 1000BASE-T.

Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twisted-Pair Ethernet
-------------------------------------------------------------------------------------------

Clause 104 of the IEEE 802.3 standard delineates the functional and electrical
characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Equipment
(PSEs). These are designed for use with single balanced twisted-pair Ethernet
Physical Layers. In this clause, 'PSE' refers specifically to PoDL PSE, and
'PD' to PoDL PD. The key intent is to provide devices with a unified interface
for both data and the power required to process this data over a single
balanced twisted-pair Ethernet connection.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
