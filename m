Return-Path: <linux-kernel+bounces-63829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A385350C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B6B28162A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3C5EE99;
	Tue, 13 Feb 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MFkYfYJT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16A5DF26;
	Tue, 13 Feb 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839209; cv=none; b=LJxzqztlSaPfL2FI+RE8PfVTRzR5595SR/lXcqt7GciuMLYDki1FHFJpqOj1mIV15WdtLMH8i1GF3Bj7pncUsxGmgSJy2QT9y0swtauS327HVqmlngY+XW+pVD8hkJtxhQTTijBCubJK12QxaqIKl7emfPt0xwG04aMxgGBiy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839209; c=relaxed/simple;
	bh=nDHY4NSawgocEYFVaXaHXV+0vNm1+xE93FNovNj87EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0TVq7xxt5PSHpltACTC3Qk54ulOqTi3pene6hiqj9vUt1RwuOcpB5A1p29x8zCc9dG0gSaFYBC/VmXr5Vkljy2ZVJwFRVvCQ1W+/dPEsjMlJBAYT00RKWRZ+LVSTaypag2ESRx5i7NY4agyNv7oInB16+C9ymDNVlwak3OYfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MFkYfYJT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RiCbBVOdVROX5fgEuIJF+tD5IRbN1+CQ/2UfcdpGtUA=; b=MFkYfYJTusz/farDJErKREeISO
	soAloWysLKJVABloCwlSHMekpeFn/BmsQCJAnU9/x1IGeW5Nof2lRoqyvpP0/R4OwGvkf575hXj8L
	PHr/kR3eyx2FxtxpMRDVLQRjKsF8zMys0rBbYuq+QJjUF+TftMBJv8mQpMao7DBdM7P0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZuzf-007hH1-Ca; Tue, 13 Feb 2024 16:46:47 +0100
Date: Tue, 13 Feb 2024 16:46:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
Message-ID: <12f27e82-6981-4a13-bdc0-77054bf964e9@lunn.ch>
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
 <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
 <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>
 <a10c3b55-c6c3-4982-b294-d6e5b9383e31@lunn.ch>
 <65cb87a3.5d0a0220.69795.6a1d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb87a3.5d0a0220.69795.6a1d@mx.google.com>

> With the amount of things we are noticing on these PHY it can be
> anything from Marvell itself, from OEM messing up with the Provision to
> a buf in the FW itself...

Ideally, we want to get Marvell to release one universal firmware for
each PHY. Get the OEM out of the picture. This is something i said to
then Aquantia years ago, that provisioning is going to make driver
support a real problem. Seems like i predicted it correctly :-(

	Andrew

