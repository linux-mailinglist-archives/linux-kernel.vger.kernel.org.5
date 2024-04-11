Return-Path: <linux-kernel+bounces-140164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B08A0C42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7863E1C227C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4484144D18;
	Thu, 11 Apr 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="heNt7qrS"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF27144303;
	Thu, 11 Apr 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827557; cv=none; b=PX3aPkgBTCVT0vDxv8fj1qvLdKcPCbZiaf4WMUSbkoOYMM5+vqTB4dlL2wowpavSVp0j5+GUNVBi2i50GcnvrJIipc02EopkYalWu3ykUWUcV8rAe5/DZj58VmtJkznUOrSxun9NhPrVSuUZJ6wuoyaDrfR91PX4JECmHHBrr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827557; c=relaxed/simple;
	bh=dygA1WPRuBqMdxGGpCaKSAr2jCspXpnEIHOS+j+BVXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoRpJmV5Y8pAuFLXSwjQHl+pm4eWjqfh3wCLamlfxGzTttR6M15rmy1z4IGWQ4w6BdTu9S5E8aUP+NcCbvBza1e1sLofJAHi98olvU3yDzfcVqSAyOHHA3pSSBzGp9l1lnhaxseuOginmsohuTwDKShGDiTcUWfNEfvstH6itLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=heNt7qrS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7ECF360003;
	Thu, 11 Apr 2024 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712827552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKjOj/t4Yd+gG7pDolrHBzRHmNw6eOFJQo600f52EaQ=;
	b=heNt7qrSXRMC4rqLyIBOIMXpVD8SFG+udbziO2RYbryEobpgcdrsdl8Zera6ZTHjQdhOqG
	5yHs1eci3vhT8x0di/FRMcpX5H9dHp0hEMxuwP9jshRIyuUlGeaTRokaFv+Ao094HNm6Bk
	wnarmorhQDzH+EU55n/bsVVk1k2h+P+0+58GmQ7Vi3rwV+jZ2wUXUBY3DLH6en//GzkqHO
	JgXjV+A2KkxuKNHW5qpBD2Mg71z9HjlA2cphOTqMcY6r0/cYzdfb0Z308Tk3igbKbpaHAt
	5Y1XNSLddxw7Bg3/4pTa0Zig5M94uVSNTFsir+GzdhGRrFN8Bisr83TtE2rRMg==
Date: Thu, 11 Apr 2024 11:25:48 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240411112548.68ae868e@device-28.home>
In-Reply-To: <20240410145358.GA2996695@dev-arch.thelio-3990X>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
	<20240404093004.2552221-2-maxime.chevallier@bootlin.com>
	<20240409201553.GA4124869@dev-arch.thelio-3990X>
	<20240410101627.53bfdebf@device-28.home>
	<20240410145358.GA2996695@dev-arch.thelio-3990X>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Wed, 10 Apr 2024 07:53:58 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Wed, Apr 10, 2024 at 10:16:27AM +0200, Maxime Chevallier wrote:
> > On Tue, 9 Apr 2024 13:15:53 -0700
> > Nathan Chancellor <nathan@kernel.org> wrote:  
> > > On Thu, Apr 04, 2024 at 11:29:51AM +0200, Maxime Chevallier wrote:  
> > 
> > [...]
> >   
> > > I bisected a crash that I see on one of my test devices to this change
> > > in -next as commit 6916e461e793 ("net: phy: Introduce ethernet link
> > > topology representation"). Here is the stack trace passed through
> > > scripts/decode_stacktrace.sh:  
> > 
> > [...]
> >   
> > > [    5.626535] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:46) libphy
> > > [    5.627954] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
> > > [    5.627963] phy_link_topo_add_phy (include/linux/xarray.h:977 drivers/net/phy/phy_link_topology.c:80) libphy
> > > [    5.629462] phy_attach_direct (drivers/net/phy/phy_device.c:1516) libphy
> > > [    5.629504] phylink_connect_phy (drivers/net/phy/phylink.c:1983) phylink
> > > [    5.631030] ax88772_bind (drivers/net/usb/asix_devices.c:710 drivers/net/usb/asix_devices.c:919) asix
> > > [    5.631049] usbnet_probe (drivers/net/usb/usbnet.c:1745) usbnet  
> > 
> > I've run some tests on an arm64 board using an USB to Ethernet adapter
> > that uses the same driver (It also goes through ax88772_bind() ) but I
> > don't reproduce the error.
> >   
> > > If there is any additional information I can provide or patches I can
> > > test, I am more than happy to do so.  
> > 
> > The next step for me would be to try on an x86_64 box to get closer to
> > the config you used, however could you give me the .config that was used
> > when the bug was triggered ? I'd like to make sure I didn't miss
> > anything related to some of the parts being build as modules for
> > example.  
> 
> Sure thing! It should be the one I have attached, it is basically just
> Arch Linux's configuration:
> 
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

Thanks a lot. Let me try with that config and see if I can reproduce :)

Maxime

> 
> Cheers,
> Nathan


