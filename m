Return-Path: <linux-kernel+bounces-51174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CB848753
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31198B2352A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C25F575;
	Sat,  3 Feb 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ESirXQHx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD558206;
	Sat,  3 Feb 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976457; cv=none; b=ruiMkhkO04y2DQ3HYfo02b8ZwC7uzB6GODEGcnpHfhVswhJVRAoceHXAqNs9WO+3mF81SzATcL56/H75dLGZxI5CY5qfJFpYD2aBr0nHZ/KmIvSD6ZWC+xFQd77gdMvDsyhaIzHbgeXbHWroQ0QRfDou3ZQBjTUefoDxV90lPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976457; c=relaxed/simple;
	bh=eJLAoxZIMwAhbbadFPpd7UdNFT7FUaJh9BhaW8pDTyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npv0m0xKKEuLSL3go6sFXK2mfdf/J9t2LKP9CV1PAaUBuzMLmOi7+KspaJam58ThQm+DwEU+x0yifjb9aodSqOUWsG2AvqXS2BBtNi+cXHM6ll8IHdQxfduNNM6xhObYGv1g5seoadqLRykTLuvUi+i35nzLtbKvhKxErgy/PLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ESirXQHx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kXEPxKS8B+/MPJTRY2elcZxs9yw2hd/tVMqdZ7alUA4=; b=ESirXQHxI4R7uuX7KeBC5DKfDW
	SFfLzzjF67Y2fpIb4yqCmVw7Lopmt2+yP9W7BOqgXSU9VTNqCPVcgGW0YGMxqFhiM/UGzGHXc8Pxq
	TgLgJalEYsyeVYLJ9/drE3dlW/z4xj/xekGvMQR1zz+Kx09pqWYZHwUtC0ADlFwCjHM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIXx-006uYI-PQ; Sat, 03 Feb 2024 17:07:13 +0100
Date: Sat, 3 Feb 2024 17:07:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 00/13] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <ff0a1ea7-fdc3-4653-a52e-52869abb7dc8@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240129180959.582dbc88@kernel.org>
 <20240202183029.GA16692@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202183029.GA16692@debian>

On Fri, Feb 02, 2024 at 07:30:29PM +0100, Dimitri Fedrau wrote:
> [...]
> 
> Probably late, but there are parts of the code which are based on the
> sample code provided by Marvell. The sample code is licensed under BSD
> 2 Clause. Should I change the license in the driver to dual license ?

IANAL

You can take BSD code and release it with a GPL license. But it would
be better to indicate it is derived from BSD code. Either make it dual
license, or add a comment about the origin of the code.

	 Andrew

