Return-Path: <linux-kernel+bounces-154726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFD8AE036
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC8283364
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CB56446;
	Tue, 23 Apr 2024 08:48:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7D31E526
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862123; cv=none; b=OYemXV4PoCNlCku33lbRrjM6wfsDEZDPVPC7Cf2ZF7AES03/2v9mJuK044+aLToITOhQKlTCiZijAvYbfJ19zMKFuaHfoIUPs2YVq3MCsbA2W5S8hEFzo9A00ztDAzUyC6YR3UlTC45FkhW1htY1iMIgJ8mf/jLnxwUxYsM+yc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862123; c=relaxed/simple;
	bh=g8zd7G7ZNAHafF2FAzyu3q4vLjerp9wEdhoccM4gm0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl62Y2FntZq+64k0qAAD8Xkq8P0HAQJFH5Kk7NkAQPeX81hlujTHMxK5b7l9kgdMx2daVe//nwBFvlXwVafg9boRIKHCw//mvtSzcyRHL1xzF1Vf+CYLMuJRwgz1rMgJhQuTRJU+9/GtQ8s2x2v4D2oEMDR5e79fGRVqMreMt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpD-0007F0-V4; Tue, 23 Apr 2024 10:48:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpB-00DrZr-S1; Tue, 23 Apr 2024 10:48:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpB-009nsc-2V;
	Tue, 23 Apr 2024 10:48:25 +0200
Date: Tue, 23 Apr 2024 10:48:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Message-ID: <Zid12Z4hVQ7sThhT@pengutronix.de>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
 <ZiZ7-n5q3COmPRx6@nanopsycho>
 <20240422182030.34524046@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422182030.34524046@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2024 at 06:20:30PM +0200, Kory Maincent wrote:
> On Mon, 22 Apr 2024 17:02:18 +0200
> Jiri Pirko <jiri@resnulli.us> wrote:
> 
> > Mon, Apr 22, 2024 at 03:35:47PM CEST, kory.maincent@bootlin.com wrote:
> > >From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >
> > >Clarify PSE regulator as voltage regulator, not current.
> > >The PSE (Power Sourcing Equipment) regulator is defined as a voltage
> > >regulator, maintaining fixed voltage while accommodating varying current.
> > >
> > >Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > >Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > This looks like a fix. Can you provide "Fixes" tag please and perhaps
> > send this to -net tree?
> 
> Indeed I should have used the Fixes tag.
> The PoE patch series that introduce this issue is currently in net-next.

With Fixes tag:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

