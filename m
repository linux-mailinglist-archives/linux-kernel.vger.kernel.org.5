Return-Path: <linux-kernel+bounces-111576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD2886DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A13BB21095
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652746B8B;
	Fri, 22 Mar 2024 14:08:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDD3B2AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116512; cv=none; b=VaNHEPSwecNkD86g9rJkSKbMGtXJkw3zoNAth0URas9twSl1ggr4QmAjU2qerHcjjx68CEplKJ2J2sfK50ucgSh9BucAdwQhtTxjOn5xa/tGA42We3lC32PMupud2iuiFVbBRXmYdcbmp9eHXy6bg1w5f5noSyiiUjkY+RnpgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116512; c=relaxed/simple;
	bh=2RQBu0WWiwp083cbydMO+Nr/jPL0tveLGURqe+4Sr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHs6VMY5Qml1dTCwn8b+8foiJBchgBM1c5Od4n+xlg6pCOoFFmQfx+nMBOg62eCJQ8j1xLSit+3Xj3OOYDhaSzZe6TrYZSJx/Mv40PRT3YydsIa7Kv1wZ0eHhdpcUy5Wq9UJLy9DVY5ZqPJeIJJrqEHGl/sk+w/iILHNNkSLkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rnfYh-00015w-Sz; Fri, 22 Mar 2024 15:07:47 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rnfYf-007r98-Dz; Fri, 22 Mar 2024 15:07:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rnfYf-00BcL0-11;
	Fri, 22 Mar 2024 15:07:45 +0100
Date: Fri, 22 Mar 2024 15:07:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
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
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <Zf2QsfsxcPoCq_SC@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
 <ZeWi90H-B4XeSkFs@pengutronix.de>
 <20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
 <ZfxjosqPMo0ECBmx@pengutronix.de>
 <20240322113950.27d35376@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322113950.27d35376@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hay Kory,

On Fri, Mar 22, 2024 at 11:39:50AM +0100, Kory Maincent wrote:
> Hello Oleksij,
> 
> On Thu, 21 Mar 2024 17:43:14 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Thu, Mar 21, 2024 at 05:15:24PM +0100, Kory Maincent wrote:
> > > Hello Oleksij,
> > > Sorry, I forgot to reply about this.
> > > This is specific to pse_regulator driver. Could we tackle this change in
> > > another patch series when the current patch series got applied?
> > > Also I don't have the hardware to test it.  
> > 
> > ACK, no problem.
> 
> I have a question unrelated to this.
> Why do you add refcount on the pse_control struct?
> The pse control is related to the RJ45 port. Each port is exclusively related
> to one pse control.
> Shouldn't we return an error in case of two get of the same pse control index?
> Do you see use cases where a pse control could be get two times?

I assume, any instance which need coordinate PSE behavior with own actions. For
example - PHY will probably need to coordinate PHY state with PSE PD
classification process.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

