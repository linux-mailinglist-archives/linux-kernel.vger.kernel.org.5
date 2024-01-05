Return-Path: <linux-kernel+bounces-17565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF4F824F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E781F2298F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CEF2031C;
	Fri,  5 Jan 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mWABq9FS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC820300;
	Fri,  5 Jan 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 688F160003;
	Fri,  5 Jan 2024 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704441659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pVbHSyTk3IwM74aAC786oc+bICglCxth9kXk8hzr2I=;
	b=mWABq9FSd19s42hdr1jewCcl4Q7BSmTHAMLoP7uHnczhNQFmGmE8gXMO/DLSrWfBkJoKEK
	KNj9ZC0v9o/BLRZCK+HXsheejuwFhv+HrDNJ+SiaB0m/S0J0qmlb0G2Eo8l6HWaUgWW93S
	C/QHRx9sYFsZF1awyBsMGYmyUpU3hN+R95fjzAFLDkVKVJcfx5GFgXwmiYmfErr8+azAuL
	r7IPOmV4gwzeNqC3LsNn+kn7HDhre8fL4Y6fX7SRkyPwkg0gKOf71BYzavqFeqD9kxaL/P
	jJcr+7bx3icAm+mYoNUqrmNOHim0Qt8Jr2Kw2z6QjoYyF2uFiu3sFzEwytF/kw==
Date: Fri, 5 Jan 2024 10:00:31 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, patchwork-bot+netdevbpf@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 hkallweit1@gmail.com, vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240105100031.7e75a7fc@device-28.home>
In-Reply-To: <20240104165609.5a56cac1@kernel.org>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
	<ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
	<20240102105125.77751812@kernel.org>
	<20240103153336.424dcfe3@device-28.home>
	<20240104154721.192694a8@kernel.org>
	<1447ce09-f90e-4ba2-a6f7-e5cb23bf724f@gmail.com>
	<20240104165609.5a56cac1@kernel.org>
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

Hi Jakub,

On Thu, 4 Jan 2024 16:56:09 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 4 Jan 2024 15:50:40 -0800 Florian Fainelli wrote:
> > > The netlink handling looks a bit wobbly to me.
> > > I commented best I could in the 20min I had to look at this code :(
> > > I think it'd be best to revert, if you don't mind, because reviewing
> > > incremental fixes will get even harder.    
> > 
> > +1  
> 
> Okay, let's say that the three of us - Florian, Russell
> and I are a quorum? :) Reverted.

No worries, I'd rather make sure we get this right especially regarding
the API. Thanks for taking a look,

Maxime

