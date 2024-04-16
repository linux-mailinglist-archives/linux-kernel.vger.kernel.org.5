Return-Path: <linux-kernel+bounces-146956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F028A6D84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE3B1F21B32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00211304B0;
	Tue, 16 Apr 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n3PM0L7f"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15712FF64;
	Tue, 16 Apr 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276614; cv=none; b=k1e8dxVt9l1LlmmIWFy04uA+OuTCCVWEXEV8s5ddgwLdHh5mM4wpOg3UtfcQw2PBImid1vyl5suOGX5lkDhdFDYUQ9nQwQdsun6QcY4G9OcPAQV1+mDba+Km4bvHYwqda7iq105K/lUXL+YCTBOqSwSAk5NOZ6q6TOTsKuq0H2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276614; c=relaxed/simple;
	bh=7JZc8UnPkyq1RzEo8SIHO6WK5tK7l6pzq2Uiq95LxoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/45AOoRFEyHmrYMHTbPZ0LBdLUO1pWpbH96yd6NFHkj9jy7dEfQIxrD1019jvZVOzfMHt/3OqQWzsar/FeGjdFx6D+ye8ihSZIkicnZvpm87JVpxkHoGDiJgSbKu0CuLHZoe4mRw7XHVEUxonaHMnKafg2Brj1v+eVwCCPBPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n3PM0L7f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w6da/WRbFvg8QeAUygR52mX3V4b4pJ5TAZXxzhpIMts=; b=n3PM0L7fraZGETa4yFlMW03vnC
	17VhNj5wsjiv8VOy0KA2V9q48v7L2Kvhfkvv4o7jxzbflPqHpiznjQZfZh6BWVV/Z15ebdjX+J+aX
	L1VZ9tlqHqsmp4l16VGfYxSJdzANxp0nqQYDL2shJl2djDcE0ENFc/+x8bc6jGNDSk0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwjVf-00D8th-8s; Tue, 16 Apr 2024 16:10:07 +0200
Date: Tue, 16 Apr 2024 16:10:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm54811: add support for BroadR-Reach mode
Message-ID: <3aaf1b82-247e-447d-a39c-c209105c2d7c@lunn.ch>
References: <20240416123811.1880177-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416123811.1880177-1-kamilh@axis.com>

> @@ -258,6 +257,9 @@ static const struct phy_setting settings[] = {
>  	PHY_SETTING(    100, HALF,    100baseT_Half		),
>  	PHY_SETTING(    100, HALF,    100baseFX_Half		),
>  	PHY_SETTING(    100, FULL,    100baseFX_Full		),
> +	PHY_SETTING(    100, FULL,    4BR100			),
> +	PHY_SETTING(    100, FULL,    2BR100			),
> +	PHY_SETTING(    100, FULL,    1BR100			),

Please could you explain the name convention. IEEE puts the speed
first, then some letters to indicate the media type, and then a number
for the number of pairs. Why is this not followed here? 100BaseBR4?
100BaseBR2? 100BaseBR1? Are these names part of the BroadR-Reach
standard?

Also, is there any compatibility? Are 100BaseT1 and 1BR100 compatible?

      Andrew

