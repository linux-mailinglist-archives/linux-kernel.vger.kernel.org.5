Return-Path: <linux-kernel+bounces-64116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700F853A35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835BCB28E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7821CD10;
	Tue, 13 Feb 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2MT5sfTZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9F1CA8F;
	Tue, 13 Feb 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850008; cv=none; b=TEOTl9Rurpe5gaWwSNUVcbE7bGrZ0JKcsZ8MEXl4fC8LCKmHlFvIdBHpk4GhGv1CCb00pMbwWF4s5rPFajYWhMR/vA767wmNfOsubKP1fo0o/Zq7ObA5OP4ZqJ2W+cBa4XU00viPqy8JUMXIbhV75CqvHbNGJfkXlDCLSmYAAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850008; c=relaxed/simple;
	bh=lcWJKroqnVoZeeUmZmZEfdTXGoqvGouIATK9PaCgMg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYTIJV01g/c21zemhtfy8dcx6zOTWyrXYxqjFhCMoBjljxEd6FeMEHUgtMC80yNTg1qsKldJSD/uDdQ3HDNEzOeHrXeXWzHTF29qM6asNH6i5MytBKAIaEAiQPi02KEPrV4xFi+YMDH4mim+NAqAXAa3P81F1zF3U6or+z/5wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2MT5sfTZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3XeLjS7yUXexGit1/+ZjYAFdk3R9Y2+oOfIWTeb8D+o=; b=2MT5sfTZ3I0vGDcXw9vLNINaGz
	XQWphb/FQ6NVP3K6r4/eqDb7Xja5HcYg+SbohdEZZ3CZwLF3VcPgBv1aUYJAuluT4WgvWb4M3auOx
	NkyzNPwdzK3mjCi5s+MH+KYl8avTmrNvuoT/w5e94OCbW0ZVhRs4G/YTywMxRcuWZUzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZxnp-007iIQ-Ok; Tue, 13 Feb 2024 19:46:45 +0100
Date: Tue, 13 Feb 2024 19:46:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/2] net: phy: aquantia: fix system
 interface provision
Message-ID: <ee00b11a-4679-4ba4-be42-10f15d5e9f65@lunn.ch>
References: <20240213182415.17223-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213182415.17223-1-ansuelsmth@gmail.com>

On Tue, Feb 13, 2024 at 07:24:10PM +0100, Christian Marangi wrote:
> Posting this as RFC as I think this require some discussion on the topic.
> 
> There is currently a problem. OEM multiple time provision Aquantia FW
> with random and wrong data that may apply for one board but doesn't for
> another. And at the same time OEM use the same broken FW for multiple
> board and apply fixup at runtime.
> 
> This is the common case for AQR112 where downstream (uboot, OEM sdk,
> openwrt to have the port correctly working) hack patch are used to fixup
> broken system interface provision from the FW.
> 
> The downstream patch do one simple thing, they setup the SERDES startup
> rate (that the FW may wrongly not init) and overwrite the
> global system config for each rate to default values for the rwquested PHY
> interface.
> 
> Now setting the SERDES startup value is SAFE, and this can be implemented
> right away.
> 
> Overwriting the SERDES modes for each rate tho might pose some question
> on how this is correct or wrong.
> 
> Reality is that probably every user an Aquantia PHY in one way or another
> makes use of the SDK and have this patch in use making any kind of
> provision on the FW ignored, (since the default values are always applied
> at runtime) making the introduction of this change safe and restoring
> correct functionality of AQR112 in the case of a broken FW loaded.

This is part of the discussion i had with Aquantia about
provisioning. Basically, you cannot trust any register to contain a
known value, e.g the value the data sheet indicates the reset value
should be, or that the 802.3 standard says it should be.

So in effect, the driver needs to write every single register it
depends on.

> This might be the safest change but again would not give us 100% idea that
> the thing provision by the FW are correct.

I would say, we have to assume provision is 100% wrong. Write every
single register with the needed value.

Is the provisioning information available? Can it be read from the
flash? Can it be dumped from firmware we have on disk? Dumping it for
a number of devices could give a list of register values which are
highly suspect, ones that OEMs typically mess with. We could start by
always setting those registers.

       Andrew

