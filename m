Return-Path: <linux-kernel+bounces-67847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F18571C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DD11C21D33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E22145B1F;
	Thu, 15 Feb 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TjtLkwJU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D813B790;
	Thu, 15 Feb 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040689; cv=none; b=W3fXyhS42Yb/hDOIyPO7tiMTPjTXFJF/eOvvpmSDrPAcs2w+HJ+wtVLdKk7mfrXq7NmTt+z8XNlvC1+k67d6ahe4LzgRg+RYOM9JAFHCupB4eH/MA3ofuGpkeyXaDZNQ+XJGTTyjKDyavWV54jzy2XHeM3Xh5gX9zQsbzQ+RiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040689; c=relaxed/simple;
	bh=5ZF3pvvc4uP1svsPIM2Jx8uuzrLfcGQJgK1XNfm6LSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtQHyo/3xWtTHOl8j/34gdnd3UUNRhNYgHFeH3NczDiIIPKThEL4Y4smplqttxOyr7Ec2gfMH0Js/oap1URl3QQuEdwhyQs70zXKY5hf/vHc8WkkLEyvCb69IfZLb4cp1H9SyhDPRUFR03rrQ84pfs7yiW3M5/xNT/liMEuVLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TjtLkwJU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xL+R9eh8qyHDKqNoAgUSUqv3bM/vWiUYQEUpxF/zJwg=; b=TjtLkwJUvxPfBhszBZGQzpBQ2y
	irDZdqGUBg7/PhU1067NiHblp71pzxSZ+S+1lSML6pY78PZturkPgKnsSzAQseRWemaIXtICJVo1M
	5TZmdbXEiVUgzpkI4t0b9OjZ4/JNkHozZgUWh+O7j4C8m1TQVmpotR07FRZm2+Og4eN8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ralPQ-007vg6-Jh; Fri, 16 Feb 2024 00:44:52 +0100
Date: Fri, 16 Feb 2024 00:44:52 +0100
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
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR813 PHY ID
Message-ID: <88c9fa1e-ac19-4a0b-a7cf-d45e4a9ca78c@lunn.ch>
References: <20240215214331.18162-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215214331.18162-1-ansuelsmth@gmail.com>

On Thu, Feb 15, 2024 at 10:43:30PM +0100, Christian Marangi wrote:
> Aquantia AQR813 is the Octal Port variant of the AQR113. Add PHY ID for
> it to provide support for it.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

