Return-Path: <linux-kernel+bounces-90722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D38703F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6AEB25A70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797041C64;
	Mon,  4 Mar 2024 14:23:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4C3FB32
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562231; cv=none; b=qNTsMcQn/OL+irCJaD7Jsz4/nST0SfhcLq7ci0UcUMD1mth+TaVb991Up0Uctv4O+z6FM5q2It3Sr5KYoIh+0WsMdcIpX+B+Q/vxUY3oGlvH7DfkfVfqkFWQ/E3oLeZYmFsNxNgf3iAf/P91ttyuM5VkW6IvwhJYPWSUGiNzGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562231; c=relaxed/simple;
	bh=ObcxFbtc6CHI8exv2xXtNHEcKxe9mw8/hFp5f4FVeIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtbDlJJyOZQE9t5tHPe0kRfDnHk0t/SRCUUy5XGlGy1V8fTpJUhxJxh6ONwg/P/Pcm8pk1eZHde1LoCyMOsNmwiUFaBTRZSLt0bt09DEAbXxq23DBfkz5bt6Nd+8eOqKKDUsivHuBrtEpQoPHT43gMPlA17/cu0CbOn1csxr/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rh9Du-00016V-Bk; Mon, 04 Mar 2024 15:23:22 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rh9Dt-004N6X-1P; Mon, 04 Mar 2024 15:23:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rh9Ds-001ulU-30;
	Mon, 04 Mar 2024 15:23:20 +0100
Date: Mon, 4 Mar 2024 15:23:20 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <ZeXZWAq1QwqCUJAm@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
 <84b300c7-8295-424b-9117-c604fb4cd73e@lunn.ch>
 <ZeXO_NhXZQajGZPr@pengutronix.de>
 <290c516e-6cf7-4db2-9b32-c9dc7200fe73@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <290c516e-6cf7-4db2-9b32-c9dc7200fe73@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2024 at 02:53:54PM +0100, Andrew Lunn wrote:
> On Mon, Mar 04, 2024 at 02:39:08PM +0100, Oleksij Rempel wrote:
> > On Mon, Mar 04, 2024 at 02:32:50PM +0100, Andrew Lunn wrote:
> > > > > > +	psec = dev_find_pse_control(&phy->mdio.dev);
> > > > > > +	if (IS_ERR(psec)) {
> > > > > > +		rc = PTR_ERR(psec);
> > > > > > +		goto unregister_phy;
> > > > > > +	}
> > > > > > +  
> > > > > 
> > > > > I do not think it is a good idea to make PSE controller depend on
> > > > > phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
> > > > > here was the missing port abstraction.
> > > > 
> > > > I totally agree that having port abstraction would be more convenient.
> > > > Maxime Chevallier is currently working on this and will post it after his
> > > > multi-phy series get merged.
> > > > Meanwhile, we still need a device pointer for getting the regulator. The
> > > > phy->mdio.dev is the only one I can think of as a regulator consumer.
> > > > Another idea?
> > > 
> > > Sorry, i've not been keeping up...
> > > 
> > > Doesn't the device tree binding determine this? Where is the consumer
> > > in the tree?
> > 
> > The real consumer is outside of the system.
> 
> The device on the other end of the cable?

yes.

> > Withing the system, it would be the RJ45 port, but we have no
> > abstraction for ports so far.
> 
> A Linux regulator is generally used in a producer/consumer pair. If
> there is no consumer device, why have a producer? What is going to use
> the consumer API?

We already consulted Mark Brown in precious iterations of this patch
series and got his OK. I also described all advantages of using
regulator framework within the PSE subsystem. I need to search it. Short answer,
it is relatively common to have open-ended regulator with consumer outside of
the system. A PSE system can be relatively complex, representing all
supply dependencies from power supplies (one or multiple) to the ports
will help to provide needed diagnostic information and power saving
if port are disabled. Some functionality is currently not supported by
the regulator framework, but need to be extended - power budged,
priorities and reservation. All of this are not exclusive PSE
challenges. So, using regulator framework seems to be a straightforward 
decision.

> When we have a port representor, do we expect it to have active
> elements? Something which will consume this regulator?

Not in a usual sense. There are two levels of PSE control:
- autodetected by PSE controller
- fine tuned by using LLDP wich may respond to PD requests by allocating
  more or reducing/disabling power.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

