Return-Path: <linux-kernel+bounces-32115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C88356AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744B9B21229
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DB376EC;
	Sun, 21 Jan 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CiRXlYfV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4F1D682;
	Sun, 21 Jan 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854950; cv=none; b=R1M8CUeesO4xrIC2PA6PnWC1U39YD4/fjy/4UtyaYuQNkjBdasjHaHb3bVZhxA6FXu3hAWyAWlmxtU/J9FH3r47JffvUhlNnfKtnzF5Ez/FJyQ/CAycrqsSOqcPtwSpfB0r1yyrqqeBxOGYtYVjJWdXu3w34mXSlqqGhTWYEGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854950; c=relaxed/simple;
	bh=oXIDoCwWJnqHJqKehe0/596Q6ObG3BynFtSoQloYtpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IycD3xxgOqMep4GZQGvYvKCbqQkOEJxwV0pczxTgZcQNdiR7mAK41ihwkW6HNE3Phe0XYwJ0JzUEFqSvoxBptxo+yJDdMlNOjEmGaYOEKwXCSpmnLzuP2TLHR2xtrvdi893oobJ1gOf4M+z+e1jRgP9R5cwGHsKIx59wfu+bR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CiRXlYfV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+ee0LVJaO5xx5GZobgreq3QpintDB0kzQxoNG6Nuq/Q=; b=CiRXlYfVKNnCf62BxY//FksKhE
	ATDCOxtIR1lSIREWhqcUtHK3cRqyog9XQ4GH772UTukXmojvgCobskeCeXZ5ZcY9fXK9MYVU8G7xW
	8V5HvUAVz2B6iAb9lDZXB8BkOdb4nxFLuGXjeTy9xUMCOjfQ7EoPwCi4LpAxqYcLX6kM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRanN-005f4P-HR; Sun, 21 Jan 2024 17:35:41 +0100
Date: Sun, 21 Jan 2024 17:35:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/8] net: mdio: ipq4019: support reset control
Message-ID: <9ac4b153-2318-4d69-9771-1b3365104904@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB55568177805D79143E8CF4E2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB55568177805D79143E8CF4E2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:42:35PM +0800, Ziyang Huang wrote:

In this case, you need to document why the MDIO core reset controller
code does not work for you.

You are also missing the device tree binding again.

> @@ -248,6 +254,10 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->membase))
>  		return PTR_ERR(priv->membase);
>  
> +	priv->rst = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);

How many resets does this MDIO controller have? Would
devm_reset_control_get_optional_exclusive() be sufficient.


    Andrew

---
pw-bot: cr

