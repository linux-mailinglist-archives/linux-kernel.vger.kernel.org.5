Return-Path: <linux-kernel+bounces-75578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3985EB73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33D7284095
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87255127B57;
	Wed, 21 Feb 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M7N8f6yA"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC943C469
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552638; cv=none; b=XFUPMUS/5k6GGDtiNWbz0271IO0Thkyvl9oPsHz0Bew5mgEd/VjRYsqTRiMGeuPoKi8mlmxH4a0SMwrnE0NveIWawulvBECddG/jOpNDVgovRmL4sAOZbi/H3i2JpdQToyOi0ZmI/RdxsVwU0kEJXXcSyCJ1yTABBz89WFozBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552638; c=relaxed/simple;
	bh=ibxTlhN5MoDPOlT+ANu5l2nVH2J8CNPgYyG8UXQV5vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddYOWezXeyDUNOVZ11t9OcVxRaE0REGnm6AFneUe4ITnRYcbr8vLGWedHHzXoVWgrT+DcbogAXEv4/n3cpyzFrbKQDsEW4maNIRbhR41293U0xvw0QlPn3dPvPZLeAWTvt5iMyuD7P9H/kOPlDev4wtMvf09ArZER2qng3p3R4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M7N8f6yA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DxwjOJIsFQjRzr4/dwZ/wXiHdh9ufDgj/YF2uuzFhQk=; b=M7N8f6yAZG9Q4j75df8d2cXfxe
	1dnxylJgVzlZ7uRldGGjEQxP+GOJaV60Sjny9+UlxcuVcWqei83ZB6yiqxZ8AfMQtUsD0z+WgRNps
	z6k0K0Imy0Jmxz+7kLsHFqyPwoFxmDr720p5aDO4uLmVZ0+NR9vDETn1NtgVRGq0YWoOfR1y42R30
	PyEYhtIhBG0US5RL9SP7V9/UbdfBavqzC2lpexLYj0hrs1JSnkb0b+jyvRoGzZAt/J0dSdHU2JeAX
	YsIyyI0QG5f+Fa29kYXHq7Rfcj4HFwQYaBGKf1RsfgsMbVpKlsypMYavegSG0TMi+HajzopKQr31M
	HuJ6I2YQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rcuaR-0000al-2z;
	Wed, 21 Feb 2024 21:57:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rcuaQ-000266-AF; Wed, 21 Feb 2024 21:57:06 +0000
Date: Wed, 21 Feb 2024 21:57:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alfredo Cruz <alfredo.carlon@gmail.com>
Cc: arnd@arndb.de, u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: sa1111: fix put_device() before device_add() in
 error path
Message-ID: <ZdZxsrhLNCt+bCOB@shell.armlinux.org.uk>
References: <20240221213837.27605-1-alfredo.carlon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221213837.27605-1-alfredo.carlon@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 21, 2024 at 10:38:37PM +0100, Alfredo Cruz wrote:
> When request_resource() fails, a jump is made to err_resource label which
> calls put_device() on &dev->res without adding it first.
> Kept the err_resource label and moved put_device() to err_add label.

You fail to explain why this is incorrect. I think this patch is
incorrect. The reason is as follows:

"dev" is allocated.
dev->dev is then initialised. This initialises the struct device,
setting its initial refcount to '1'.

We then request the resource. If this fails, then the device needs to
be released. As refcounting has been initialised, it is *not*
appropriate to simply kfree() "dev". The correct action, as noted by
the device_initialize() documentation is to call put_device() on it.
This is what the code does.

I _do_ hope you haven't submitted other patches like this, because if
you have, they could well also be wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

