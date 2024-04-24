Return-Path: <linux-kernel+bounces-156899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CB8B0A14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1F2820E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A315B0ED;
	Wed, 24 Apr 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zxnjUag+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85410134A5;
	Wed, 24 Apr 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963146; cv=none; b=mJvZyfqfOrjIRfY8UIpqohYf7JGc6ED7fu6d5NTnwCagSqvvbJfOKmsBykSyWI8tZOqoo4GR3m7I7RAIccYMg7GNdiCX72T3cmlwS8SaDT3UVr2xKc+yBk2hch0QktI2KoYbSSpoz7jRs5OmSx5nc01HINsBtjE59UBcYiO7NCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963146; c=relaxed/simple;
	bh=vanSXdv4Y6JZfy9ZTweKXIH65775yaAoxSbG12Wme1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgz4p0cdBBQH9+Y4BJ27EHcu+xV4ys24JWQT2RS+Ldjxd3T6+AFKwUcw5/O/JERxLfIM94FYSUK+uTEwvHdVEAbPJ3Dm7LOiF97i9gEJaUYy6mCK1C+76etviQa1fjIU8IN7pvjew+owYcSoYwsOniKSeKKMr7Ixxle05w4xTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zxnjUag+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8/pJWBK7NCR8cJ86fTwUM8CwNOEjC8NWwcVYq5e+ko0=; b=zxnjUag+JE3XLLairBeEV7ILY7
	Iae8+V/6QtRA2b3lzUJ49mVXMNqMEDYByamF8gmOkZzKmXu98xegf4oFjgL4CvsSl3yXss6XD7F+K
	Db/PdPuyN2qfC0vN8oy0DL4+/GmOAPoD9Jhgr22/9+y3jrpZ6gs901hD0zZPoPX6OXM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzc6g-00DoYj-HQ; Wed, 24 Apr 2024 14:52:14 +0200
Date: Wed, 24 Apr 2024 14:52:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
Message-ID: <c66d04d4-8ae2-45f7-bedc-b6b09c417b25@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>

On Wed, Apr 24, 2024 at 02:10:22PM +0200, Matthias Schiffer wrote:
> The embedded PHYs of the MV88E6020 (88E6250 family) switch are very
> basic - they do not even have an Extended Address / Page register.
> +static struct marvell_hw_stat marvell_hw_stats_88e6020[] = {

> +	{ "phy_receive_errors", 0, 21, 16},

So the 0 here is bogus? 

This patch is quite invasive, and it is hard to say it is worth it. I
would probably not try to reuses as much code, add functions which are
specific to the 6250. Keep it KISS.

	 Andrew

