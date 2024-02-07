Return-Path: <linux-kernel+bounces-57300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA884D6BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847542864F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF5535CA;
	Wed,  7 Feb 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lt/8lbIO"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B420335;
	Wed,  7 Feb 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349148; cv=none; b=AlYsfW/BSbOP3cDLcASOkTrcvO1lt4wAaeONe4+0lTqOc0SGe2In5VT+GIfm1lm01z1h9z0mgnS00kq309N/517wb3Lk+CeZWUan53oLZNboqLNPMLlmb3ORXyTBmRwQI09duVG38nC3xp1ltY8CElFzpr46xl3S3D9sjjaEPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349148; c=relaxed/simple;
	bh=X+sLRacxcVdC02Y29oh0GUtVpmiYLw6uPxnvCrZtOJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FugfT6lbZNAzO/W9FAtCh3y7SomOQ/Y7UiI+isTphzG+W2TLFI1rP0n5J3KJFMHaaMLTYOgrpPsCPP8OwLOiEoRqpEXHz/tXE+hFLfPYs/jNW5Cq5YE6PfKmMgV9NqFj3FPsURDfjcuUHyUl2rcYWlbDQjhKjpAEAAimUV0VRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lt/8lbIO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sPheFL8KjU9NGrS7HO6mvZysMZWbjZlH2FmuJGAN74Q=; b=lt/8lbIODe49JKky8tzv9RGLFc
	siR59PJPF4n/3HssN33iVFwP/qzu+2O6ERzNOS073FGVUZhpBIhItYod2h7aRoiTVzd6iu7w00W0m
	8sMCeR0JjCCRxzLxRqLg7xEPzoEef0AtotaVMyq31TPf896fWW4q3/6AZYkEwJpIbng4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXrVN-007GGb-BS; Thu, 08 Feb 2024 00:39:01 +0100
Date: Thu, 8 Feb 2024 00:39:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
Message-ID: <da0e7982-9aa7-4b02-97da-7f580085a1d6@lunn.ch>
References: <20240204123151.55005-1-masahiroy@kernel.org>
 <20240206174130.GF1104779@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206174130.GF1104779@kernel.org>

On Tue, Feb 06, 2024 at 05:41:30PM +0000, Simon Horman wrote:
> On Sun, Feb 04, 2024 at 09:31:51PM +0900, Masahiro Yamada wrote:
> > Both drivers/net/Kconfig and drivers/net/ethernet/Kconfig contain the
> > same config entry:
> > 
> >   config SUNGEM_PHY
> >           tristate
> > 
> > Commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup") moved
> > SUNGEM_PHY from drivers/net/Kconfig to drivers/net/ethernet/Kconfig.
> > 
> > Shortly after it was applied, commit 19e2f6fe9601 ("net: Fix sungem_phy
> > sharing.") added the second one to drivers/net/Kconfig.
> > 
> > I kept the one in drivers/net/Kconfig because this CONFIG option controls
> > the compilation of drivers/net/sungem_phy.c.
> > 
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Thanks Yamada-san,
> 
> This looks good to me as-is,
> but I guess a follow-up question is if sungem_phy.c
> should move to drivers/net/phy.

It is not a phylib PHY driver. So i would say no.

It would however be nice to port the MAC drivers using this to
phylib. The PHY devices this sungem_phy.c supports don't look
particularly exotic, just Marvell and Broadcom PHYs which phylib
probably already supports.

	 Andrew

