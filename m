Return-Path: <linux-kernel+bounces-126764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDF893C67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7591C21464
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9B45024;
	Mon,  1 Apr 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RYKGg0nk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC6446D5;
	Mon,  1 Apr 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983257; cv=none; b=XlTW2R+hQRyKB76IfDUYCtvCw15WWYpdnAn5BcUCphahEjat/rN7+4Wy9XfYEOquJqDm3OJNbsJ26ncCXvRKoILtCDGgrNSwcNXB3GdsAgDZrvNh91yoEUwRbuOyJHhla3ggzmPqsw/+Vfcl0inITiGSWklUVMQQrNBHhpqD70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983257; c=relaxed/simple;
	bh=CZU9iRUym/va2d6/9xkrujZBBOra9du2dj2ls/Rjeek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5FHRRPZKdIKh6hOeqK6IGyM7aZDwYJUl4IUJX8c6jgk2JTeS6CXTlDtNiLaWg5heJGP/6dC+llI0bR7BKpqki3j5tjYzECg39pmizKPt7DOE/SqdwyKdiJtHvyOdPHC/Jobq4d1a/dpYG/oCNuIJyo2DdAXK/plUDWQ7xug4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RYKGg0nk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jbM2j7z0fvG4RLqHXyIcHYAtFB/yFOWhm9X/G9CnWtU=; b=RY
	KGg0nkWaZfZ0bS/7N258fqRJ7j+5ueaHzu6N5/MgJEXi0vAJRiZPM3ht/9u7j6EdiUndM6dv9YjrR
	GEXMzohGaoKeyiaxuEF8irEJbQWREGGFZSjmAyROFsWQ4R/nRMafkSiYaP10XNkVByopsH/8WS54z
	ZPt7aeBH7FwntHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrJ31-00BrdN-R9; Mon, 01 Apr 2024 16:54:07 +0200
Date: Mon, 1 Apr 2024 16:54:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: aquantia: add support for AQR114C
 PHY ID
Message-ID: <6ac20747-8fc0-4a28-a513-a2512b58dc7d@lunn.ch>
References: <20240315080657.3460084-1-frut3k7@gmail.com>
 <20240401145114.1699451-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401145114.1699451-1-frut3k7@gmail.com>

On Mon, Apr 01, 2024 at 04:51:06PM +0200, Paweł Owoc wrote:
> Add support for AQR114C PHY ID. This PHY advertise 10G speed:
> SPEED(0x04): 0x6031
>   capabilities: -400g +5g +2.5g -200g -25g -10g-xr -100g -40g -10g/1g -10
>                 +100 +1000 -10-ts -2-tl +10g
> EXTABLE(0x0B): 0x40fc
>   capabilities: -10g-cx4 -10g-lrm +10g-t +10g-kx4 +10g-kr +1000-t +1000-kx
>                 +100-tx -10-t -p2mp -40g/100g -1000/100-t1 -25g -200g/400g
>                 +2.5g/5g -1000-h
> 
> but supports only up to 5G speed (as with AQR111/111B0).
> AQR111 init config is used to set max speed 5G.
> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

