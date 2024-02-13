Return-Path: <linux-kernel+bounces-63574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44585319E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DE41F2266B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290055799;
	Tue, 13 Feb 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nKfhvDUq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088B2BB14;
	Tue, 13 Feb 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830379; cv=none; b=fjKvUdcfItQZTMMHXdRDidSbxeajPPgRjHTUrxHt5FndquY2sfSsGSaoW5vzIq1st1cNDbsNZKbypSG3bxq+VhXeB67BsqHNEDbxkRzZv3KpYP01YVQn+IrA1shixjnsxTH43bCcsblkayuJvKZNwvhYqMB0C3DPTxpExYyfFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830379; c=relaxed/simple;
	bh=fByT2UUftBCR45CYsAl+T8nyHT82IpA746ur+u10NpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptX5pzI62E8SMP3z22F9Fe7kZTwLfjX75J8xpe6ljEax6olsBN7MI1167w2MAavbC+EH7mr9HRbw/A13z+CMCRzTSkGFUTLnpjJ3kr7ARhC/YVE1yiJih8bZ1BVbNsP4JQMnaaxwoKuK9xKA7LIbgEzTfokRR0E+ZCwVTtkSYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nKfhvDUq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/xBCE8NGNltY8hI4n/J/zJtrAUlwhkdXFeiaX3Edki4=; b=nKfhvDUquN80pPtU1+yVCOVAYl
	Esev4o2zHClUGE2pFfec0t4BlpzDyniz4i03sbpMmVwkMnPnWMk/0fKJbYF12dibXZ9U7pssH55EN
	mTuAx4ng7/o1yJPh/XTt6TigX4wfq90JvUfWMjFVw4g2Bc0yJVjetAqe6eLPaNm4tlW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZshH-007gB8-7l; Tue, 13 Feb 2024 14:19:39 +0100
Date: Tue, 13 Feb 2024 14:19:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net 6/7] net: fill in MODULE_DESCRIPTION()s for
 mdio_devres
Message-ID: <045f7cdb-7f99-4182-8c75-097be8a5a7d0@lunn.ch>
References: <20240213112122.404045-1-leitao@debian.org>
 <20240213112122.404045-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213112122.404045-7-leitao@debian.org>

On Tue, Feb 13, 2024 at 03:21:21AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the PHY MDIO helpers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/phy/mdio_devres.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
> index 69b829e6ab35..8921fa22bdbd 100644
> --- a/drivers/net/phy/mdio_devres.c
> +++ b/drivers/net/phy/mdio_devres.c
> @@ -131,4 +131,5 @@ int __devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
>  EXPORT_SYMBOL(__devm_of_mdiobus_register);
>  #endif /* CONFIG_OF_MDIO */
>  
> +MODULE_DESCRIPTION("Network PHY MDIO devres helpers");

"Network MDIO bus devres helpers"

There is nothing PHY related in here, its all mdio bus.

      Andrew

