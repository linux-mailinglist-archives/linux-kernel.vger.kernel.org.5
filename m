Return-Path: <linux-kernel+bounces-17606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145382500F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DE31F23CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128B21A0B;
	Fri,  5 Jan 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ypx9vUWd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E3225A1;
	Fri,  5 Jan 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3891220011;
	Fri,  5 Jan 2024 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704443639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr4AmEGv2scZUnfevs3m3o46Mdu5zJBUL4fi7MMzU58=;
	b=Ypx9vUWdqeHKGOl/JEW5WOqXxtVXfIZGVWWf3wA1vokJB0CqmgaJ3mWL12xDTVwdOLbTc/
	ClrwSqzWmM5b6Q6j3NyULA6H4YWInyc9H2zkZWrMv/jWmdGJyE1xal1/3MyNDx6KxHL/gr
	R1ESPb9Dd4p7oBNVgWQpvxenF5394jnvgIutvP6t5GGrSJUQRpBGPQrQMi0QOC7dq+kjvg
	lSY0i/Q/hi8x2UspCc3+FwwpF1kAmqHB17gkm6OZHAA0pdZ2oaS/QcRgbNRN04kk/u7ePf
	ec0dl6iUusB/HMGKCe+CBrakTU5BM5/Y4736GOJZB5aQ/6pDLRpWebVMcdoqRA==
Date: Fri, 5 Jan 2024 10:30:45 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240105103045.7b420759@device-28.home>
In-Reply-To: <20240104151516.5f424dbf@kernel.org>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-6-maxime.chevallier@bootlin.com>
	<20240104151516.5f424dbf@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Thu, 4 Jan 2024 15:15:16 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 21 Dec 2023 19:00:38 +0100 Maxime Chevallier wrote:
> > @@ -20,6 +21,7 @@ const struct nla_policy ethnl_header_policy[] = {
> >  					    .len = ALTIFNAMSIZ - 1 },
> >  	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
> >  							  ETHTOOL_FLAGS_BASIC),
> > +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
> >  };
> >  
> >  const struct nla_policy ethnl_header_policy_stats[] = {
> > @@ -28,6 +30,7 @@ const struct nla_policy ethnl_header_policy_stats[] = {
> >  					    .len = ALTIFNAMSIZ - 1 },
> >  	[ETHTOOL_A_HEADER_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
> >  							  ETHTOOL_FLAGS_STATS),
> > +	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
> >  };  
> 
> You should define (copy/paste) a new header policy and use it
> only for commands which actually make use of the PHY index.
> That's why we have separate copies already for stats.

Ah OK I didn't know that, I'll do this. Thanks !

Maxime

