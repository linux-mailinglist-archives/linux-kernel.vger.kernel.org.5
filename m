Return-Path: <linux-kernel+bounces-8165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61F81B2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F89B22E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241D638DD0;
	Thu, 21 Dec 2023 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WHkXJP0Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0446448;
	Thu, 21 Dec 2023 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nNHtlAW8aT/uWc6gxkoWAdVp1fHEqtpoZtfG2iX2QXk=; b=WHkXJP0YBGJBO48/Q4+4us8COx
	j9bP8c1kWgG9CRL0fKYMmf3+t/vGfjc1yS4V/6sgu9RjNkF9ZKU5RiZcTNoLhTg9Ltl/2s/Q6MskI
	TOjLulxsKqOzanhBVSYW4WkWxkllAONBkpYRE7TjxFMgJvBbvAbtf+3xsIjZtxZuqqlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGFk7-003UwM-94; Thu, 21 Dec 2023 10:53:27 +0100
Date: Thu, 21 Dec 2023 10:53:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <c2433183-7893-43b1-8de8-9ed847f8a721@lunn.ch>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221072853.107678-5-dima.fedrau@gmail.com>

> -static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> +static int mv88q2xxx_get_sqi(struct phy_device *phydev)
>  {
>  	int ret;
>  
> @@ -208,7 +283,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
>  		/* Read the SQI from the vendor specific receiver status
>  		 * register
>  		 */
> -		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
> +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> +				   MDIO_MMD_PCS_MV_RX_STAT);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -230,11 +306,208 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
>  	return ret & 0x0F;
>  }
>  
> -static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
> +static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
>  {
>  	return 15;
>  }

This could be a patch of its own.

     Andrew

