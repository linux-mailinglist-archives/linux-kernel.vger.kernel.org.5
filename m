Return-Path: <linux-kernel+bounces-166737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931958B9EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C494D1C227C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1D16C875;
	Thu,  2 May 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M9WbHyzb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648077107;
	Thu,  2 May 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667854; cv=none; b=QbLYofyE+Mql50YPh+3txBnEswWTudRfhhHHOk9W9MMO8rwrL3GW2/HWu2A7+mI9TmKl7W1LlJNvvN0gJ7ejNO+3N66rRk0CwmLtCSYnSn4M/rjsUG8gXDO4xHfAEeWpvt4DS2yqn+jyoRI/hndPzSWiAXxteoyaxw6Ep22O0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667854; c=relaxed/simple;
	bh=F1YLlJn4ghUxf3VvFW+cV0y/RFheiAs4J4SwsgQNjDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZjY6kdpnQfIJ2gb4l+GDZtHGoPb7OvwlxL37dV7GItbiXwms6UcWOfj/1/Nf/vpd2HJvIY3Ha9bNUiBTjzCeT9++S9fv1Ofx4vYb/qcVeSu9raT0HGfKQw5YtS6KAzus2Zbq1/iAihrSmLn0sQ76HKqLLqU3Zda9zWPz15rAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M9WbHyzb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cR2BES9hb/9eWknORmLmkMiLggM9fLX/h5/4WiQzZw0=; b=M9WbHyzbbqjJ2MMfasdwEe3KUr
	6CsVGoHhssHKruk4KXuBHEMEMrg0fHrh62HHLxPb+0nExUPAWVNXKD6ItyXreBFdSiwGmTCBoWowz
	5M2g+QemOllH9M/9iMff6XXqbqkJgs2DZSdF0gAleptlbmqIWTVz41EAA5elZEidOLYU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2ZQh-00EW3e-Iz; Thu, 02 May 2024 18:37:07 +0200
Date: Thu, 2 May 2024 18:37:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <1ee9ee17-6582-4cb1-9a17-072be7d2b2c0@lunn.ch>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>

> It would be good to hear exactly why its necessary for phylib to track
> this state, and why the PHY isn't retaining it.

I _think_ it is a hardware reset. The call path is probably:

mdio_bus_phy_resume():
  phy_init_hw():
    phy_device_reset()
      mdio_device_reset()

But it would be good to get this confirmed.

	Andrew

