Return-Path: <linux-kernel+bounces-15653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA1822F97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3824E1F21ECD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965491A5B1;
	Wed,  3 Jan 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="csXp6X9Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9681A596;
	Wed,  3 Jan 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CE3EFF809;
	Wed,  3 Jan 2024 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704292418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KXHV4WXGKPJuYfPZYqb3ap2EpfGHhKz5ZTFkapW0JU=;
	b=csXp6X9Qh13BBrAzaKzK3eZoW671AqBhH1+2LmtQOtxPg81bI1/Cz7LNiNeip4+jtIuT3j
	ORzBAeg8PVCksAX66XMjI2IhVVCZ4v4Wslva8OXPwAthpZPL5cdA2KjR6ENsWMHIc7ZfQQ
	z5rq2ATzP9WVqN+TIPqELG7hD8ZOExRCWGc3OTJIOb6z/0WrNpBaqFWxfR4aUqfL4DFJeF
	knFnAC1kGGf4GOwpv0zj1KuJmmdrhIspK1/ilEUIu6iXZs11+qh8C4ADToybpjXnQrjQo4
	ACxJredOUU4gC3hAYgw7S8GLezw7ieuKzMDPWXwOCH2pOrIV/ZxgKGU2jTd61A==
Date: Wed, 3 Jan 2024 15:33:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, jesse.brandeburg@intel.com, corbet@lwn.net,
 kabel@kernel.org, piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240103153336.424dcfe3@device-28.home>
In-Reply-To: <20240102105125.77751812@kernel.org>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
	<ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
	<20240102105125.77751812@kernel.org>
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

Hi Russell, Jakub,

On Tue, 2 Jan 2024 10:51:25 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 2 Jan 2024 11:57:09 +0000 Russell King (Oracle) wrote:
> > ... and I haven't reviewed this yet. I guess it's now pointless to
> > review.  
> 
> I guess the shutdown was only a partial success. Nobody cleaned out
> pending stuff on the 23rd, and old things got applied now before we
> even officially reopened :( It is what it is, please review anyway,
> we'll be reverting things which shouldn't have been applied..

I've submitted the ethtool counterpart of that work a few seconds ago :
https://lore.kernel.org/netdev/20240103142950.235888-1-maxime.chevallier@bootlin.com/T/#m334b7cec4be1c78d399d0899a30d522ab57b4622

I think this could help in reviewing the overall design and identifying
any glaring issue with this.

Thanks,

Maxime

