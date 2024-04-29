Return-Path: <linux-kernel+bounces-162635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165898B5E59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485261C21265
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731B84D07;
	Mon, 29 Apr 2024 15:58:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1A84A28
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406299; cv=none; b=YvhCAE8yDpKMr0YrNZrskSAIX+aQKqt8z0LbZqBYnZbcfVaBtvNZgaxkTZwXyZGKSoMfnKyzDFUvTydu/ANcHXRI4rTns2GlyQ/hzuim8blo2nwvM9sB1UkYnX9IfDuywkQPTID8nFYNutOB782SwZRNtuhJD80M6JmQKP6YPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406299; c=relaxed/simple;
	bh=bnm8R3BjU4r3oFI+LvM7c1yc3O+bDzJFXe68tYSrX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T55f4aCfuSRHH7MwOQ+GDIDrm0Ma0ITNYuM23x08nziRrr76POKoLLXwVTxAGrQn5lDSbwrMQEaiSBexi1R7RdFz1qxFY+jEq8pUPnOeFKGIFHHZLBys6+9ysn8kMVDOg2K3nbkJZv4qKVPZ0GQRl+ob3ZW1NyqS5OeOefVLrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s1TOM-0003NO-2W; Mon, 29 Apr 2024 17:58:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s1TOL-00F0TU-Ds; Mon, 29 Apr 2024 17:58:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s1TOL-002VfP-16;
	Mon, 29 Apr 2024 17:58:09 +0200
Date: Mon, 29 Apr 2024 17:58:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <Zi_DkX-m0F3TyAwH@pengutronix.de>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
 <20240429145203.219bee06@kmaincent-XPS-13-7390>
 <Zi-vhKx-WlYPQe3c@pengutronix.de>
 <5063429d-5dca-4538-b240-50c35cbf5e93@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5063429d-5dca-4538-b240-50c35cbf5e93@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2024 at 04:57:35PM +0200, Andrew Lunn wrote:
> > Since there is already support to work with current (I) values, there
> > are is also overcurrent protection. If a device is beyond the power
> > budget limit, it is practically an over current event. Regulator
> > framework already capable on handling some of this events, what we need
> > for PoE is prioritization. If we detect overcurrent on supply root/node
> > we need to shutdown enough low prio consumers to provide enough power
> > for the high prio consumers.
> 
> So the assumption is we allow over provisioning?

I assume yes. But I didn't spend enough time to understand and analyze
this part. May be I just misunderstand over provisioning.

> > > So there is a potential second user, that's great to hear it! Could the
> > > priority stuff be also interesting? Like to allow only high priority SFP to use
> > > higher power class in case of a limiting power budget.
> 
> I was not expecting over-provisioning to happen. So prioritisation
> does not make much sense. You either have the power budget, or you
> don't.
> The SFP gets to use a higher power class if there is budget, or
> it is kept at a lower power class if there is no budget. I _guess_ you
> could give it a high power class, let it establish link, monitor its
> actual power consumption, and then decide to drop it to a lower class
> if the actual consumption indicates it could work at a lower
> class. But the danger is, you are going to loose link.
> 
> I've no real experience with this, and all systems today hide this
> away in firmware, rather than have Linux control it.
> 
>      Andrew

It may not be a over-provisioning by design. I can imagine some scenarios where
available power budge may dynamically change:

- Changes in Available Power Budget: If a PoE switch is modular or supports
hot-swappable power supplies, inserting a power supply with a lower power
budget while the system is under load can lead to insufficient power
availability. This might cause the system to redistribute power, potentially
leading to instability or overcurrent situations if the power management isn't
handled smoothly.

- Power Loss and Switching to Backup Sources: In cases where a switch relies on
a backup power source (like a UPS or a secondary power supply), the transition
from the primary power source to the backup can create fluctuations. These
fluctuations may temporarily affect how power is supplied to the PoE ports,
potentially causing overcurrent if the backup power does not match the original
specifications.

- System Internal Consumers: Components within the switch itself, such as
processing units or internal lighting/cooling systems, might draw power
differently under various operating conditions. Changes in internal consumption
due to increased processing needs or thermal dynamics could affect the overall
power budget.

- Environmental Conditions: High ambient temperatures can reduce the efficiency
of power delivery and increase the electrical resistance in circuits,
potentially leading to higher current draws. Additionally, cooling failures
within the switch can exacerbate this issue.

- Faulty Power Management Logic: Firmware bugs or errors in the power
management algorithm might incorrectly allocate power or fail to properly
respond to changes in power demands, leading to potential overcurrent
scenarios.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

