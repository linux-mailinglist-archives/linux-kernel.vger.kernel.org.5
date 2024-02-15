Return-Path: <linux-kernel+bounces-66857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8785627D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3782821AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C612BF18;
	Thu, 15 Feb 2024 12:04:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B612BE85
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998667; cv=none; b=qJE5lYVWEuji2CZbmfiXisjmx5Ol/kxK50HnpKAjN7/I6vasdl2pZfUVC2rNXlH6d2OU041cUDgBO89yI7qzOAcWRBwu5AkHaM93rlnN8tNG8698m1LDGHHAHUEZopZiBcesqV1N6VzSNzqsmW2ROO2qz73FhR8yhKlmZ6y3A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998667; c=relaxed/simple;
	bh=I+WHBDh5S+oGpcU8eKBicxfnW8AnEzmC7pw6JB4nYoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MokrTHIqgot22chxt5ep3nSrJ3hXWBpooaSlexA53PwVv3jr9RScPC+qNa04Be+SVoFCRgZzg1kx96G4V72R5JbBkXudiv0ELMHejX0wNHCPLNynSCnRo3Zy+HScUk7BP8nAZ1c0cXH5eNy2mxyg2i/vVghgoNp3dq8VwxswIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1raaTD-0000bP-Ha; Thu, 15 Feb 2024 13:04:03 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1raaTB-000sKl-Ua; Thu, 15 Feb 2024 13:04:01 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1raaTB-00A1XF-2g;
	Thu, 15 Feb 2024 13:04:01 +0100
Date: Thu, 15 Feb 2024 13:04:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <Zc39sUlxnkrkXWhR@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
 <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
 <Zc3IrO_MXIdLXnEL@pengutronix.de>
 <20240215114123.128e7907@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215114123.128e7907@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2024 at 11:41:23AM +0100, Köry Maincent wrote:
> On Thu, 15 Feb 2024 09:17:48 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Wed, Feb 14, 2024 at 06:41:54PM +0100, Andrew Lunn wrote:
> > > > Alternative A and B Overview
> > > > ----------------------------
> > > > 
> > > > - **Alternative A:** Utilizes the data-carrying pairs for power
> > > > transmission in 10/100BaseT networks. The power delivery's polarity in
> > > > this alternative can vary based on the MDI (Medium Dependent Interface)
> > > > or MDI-X (Medium Dependent Interface Crossover) configuration.
> > > > 
> > > > - **Alternative B:** Delivers power over the spare pairs not used for
> > > > data in 10/100BaseT networks. Unlike Alternative A, Alternative B's
> > > > method separates power from data lines within the cable. Though it is
> > > > less influenced by data transmission direction, Alternative B includes
> > > > two configurations with different polarities, known as variant X and
> > > > variant S, to accommodate different network requirements and device
> > > > specifications.  
> > > 
> > > Thanks for this documentation.
> > > 
> > > It might be worth pointing out that RJ-45 supports up to 4
> > > pairs. However, 10/100BaseT only makes use of two pairs for data
> > > transfer from the four. 1000BaseT and above make use of all four pairs
> > > for data transfer. If you don't know this, it is not so obvious what
> > > 'data-carrying pairs' and 'spare pairs' mean.  
> > 
> > @Kory, can you please update it.
> > 
> > > And what happens for 1000BaseT when all four pairs are in use?  
> > 
> > Hm.. good question. I didn't found the answer in the spec. By combining all
                                                               ^^^^^^^^^^^^^^^^

> > puzzle parts I assume, different Alternative configurations are designed
    ^^^^^^^^^^^^^^^^^^^^^^

> > to handle conflict between "PSE Physical Layer classification" and PHY
> > autoneg.
> 
> Oleksij how did you get the definition of Alternative A uses the "data-carrying"
> pairs for power transmission and Alternative B Delivers power over the "spare
> pairs"?
> 
> On my understanding of the 2022 standard the definition is: 
> - Alternative A is for pinout conductors 1, 2, 3 and 6
> - Alternative B is for pinout conductors 4, 5, 7, 8.
> 
> Then indeed if we are in 10/100BaseT Alternative A are "data-carrying
> pairs" and Alternative B are "spare pairs" but that's not the case on
> 1000BaseT.
> 
> You can see it in the figures in the paragraph 145.2.3.

Please, re-read my answer :)

Autoneg for 1000Mbit is not done on all 4 pairs. The only MDI/-X
dependent transfer processes only on one pair is autoneg. Every thing
else is extrapolated out of it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

