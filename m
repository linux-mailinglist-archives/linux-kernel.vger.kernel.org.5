Return-Path: <linux-kernel+bounces-133545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88089A562
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86002833D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5E17335D;
	Fri,  5 Apr 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sfTdrQvs"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA662173327;
	Fri,  5 Apr 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347540; cv=none; b=curyD7qYk8CQCu4SUHzGu7mNgnMV+7t0CvLxKbnWpoej/scWRQu+5b/Bc9tG/OcKJD3ipLBd+cPGzkMMJZxfxQv6HcZK119iNrz14zO7tYkq9GXpQkm6gp3mIO/zwcAXi1i8MoUzjCuFPSba056MN+j7brVD/jy7g1a+p0vMJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347540; c=relaxed/simple;
	bh=xmC+LFdcm+XbuEyCKOL6T3bLhwKTI1BC7Eyovvl0bY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSsWMSC/P7WTvdYxZz0cheTpn3UWWPcsx9f4F5R78VaI76ZOtmZ8XGrKFsCPb/FQqdmiHWHZG1h3IDUmXmI5h1pXAYNBrer0bk/f9CHbr2OXBhvqGxM7xP8b2zQd/Jq79xzF18xvFnmOTUdN9UmrexpYP/86tvUgT82Aq4Pqp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sfTdrQvs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fzWPtz+payU1xrhrC/vqSs/lVzZZifr9fvxjOXlFSgU=; b=sfTdrQvse6nVgXscLcnZXmd1A9
	ZsNWEs8w2HZsWtNeqRyZBh+MEMjn0EvzDniSe8c59vRWfCuBUs8Lq4sh27gJD4wwsXFS1TZR8IW09
	2GnmFHinxvn7bsJREhrOwMCmzvI1t9NPzhdu7Eeja9H7ZZpXXTXt+k+/JiEIe11PQKerolnR28/9Z
	xO5ByZ0d3qAzmG7k8Z0w5ijjITxoTyYW+MfNPdl/tduNx1FDBg45HVM07i9RGpgP8kf4qjK/JYTIX
	oKIG6k0W5pBu2R0qUo6pBAuDLhKsDCsCqSL/R3nnhJJz452YphpQcV3LF81nAViFhHZ8a3WljhKiQ
	ws1lEWtw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54122)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rspoS-0002ou-1c;
	Fri, 05 Apr 2024 21:05:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rspoR-0001dv-EF; Fri, 05 Apr 2024 21:05:23 +0100
Date: Fri, 5 Apr 2024 21:05:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sparx5: fix reconfiguration of PCS on link mode
 change
Message-ID: <ZhBZg7x9U+fzPYTP@shell.armlinux.org.uk>
References: <20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com>
 <Zg/Qf4P5gAzRUYuK@shell.armlinux.org.uk>
 <20240405194556.ngto6ddgf5r2br33@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405194556.ngto6ddgf5r2br33@DEN-DL-M70577>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 05, 2024 at 07:45:56PM +0000, Daniel Machon wrote:
> Hi Russel,
> 
> > It does change conf.autoneg slightly in that this will always be true
> > for SGMII, but will only be true for Autoneg + 802.3z modes.
> > 
> > As far as your code change goes, it looks correct to me, but I think
> > it's fixing a bug that goes back long before the commit you have
> > identified.
> 
> Just to be clear - by commit do you mean the phylink change or the commit
> referenced in the fixes tag?

I think the bug technically exists prior to the phylink change if
there is any possibility that the link may switch between inband
and a non-inband mode. (e.g. as a result of inserting a SFP module.)

> > However, I think there's another issue here which is more relevant to
> > the problem you describe in your commit message. If you look at
> > port_conf_has_changed(), you will notice that it fails to compare
> > conf.inband, and thus fails to notice any change in the setting of
> > that configuration item. This will result in sparx5_port_pcs_set()
> > not even being called if only conf.inband changes state.
> > 
> > Thus, changing from in-band to out-of-band or vice versa won't have
> > any effect if this is the only change that occurs, and this also
> > exists prior to my change.
> 
> Yes. I agree this is an issue that deserves a fix - separate from this
> one I would think.

Agreed, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

