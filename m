Return-Path: <linux-kernel+bounces-72041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2285AE28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9282C1C223E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB1B54FA2;
	Mon, 19 Feb 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VFPptt+c"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4A5475D;
	Mon, 19 Feb 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380344; cv=none; b=Me7tKDi19dNtWconIrI+1F48jxCE9mihl4wLmXXqKcXpXNG/fwxJ4ZklUlJApAO8H3CkN1vUGD+DTxpuUX44o9y2fibb3IMT1eI5ULg2QUjOdvyYedUvGGYiIIcA6lfg4+yOji8bLyFBPY53KChyzVlBMN/beYlfk97VFh/jYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380344; c=relaxed/simple;
	bh=CfdV8lh0vB5U6rIXeDqDUnBfZgpMWKXBhIyl8zGtYOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok3viBGU9zlypavZ1VSfXPx94qfkHUn1vGg6Y3dammZr+FEYe+/t9+Pfb+f0dlN01UHp6KHdobdiqrsSAk7pRVfzowaCBDWTGan1jtBj7d6w3Fa722+MccWtRsf6v/3R1N766XuL+R0MI603k+UwWdCZHqr8cs5ZbASdkzMokX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VFPptt+c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ttqw/VOatjQjjBR0zQPHDaRkA8aGduPx/uYnTvuNi/k=; b=VFPptt+crIZYg4GR716kVOk9ZJ
	5Yk84Z1B1m/9oOSnXYMa73+/m9lMTIMqeuBvs2IGvT+F8LJ90aRhFssLoOj3mYGXODv5TbreaZFHQ
	8cpOF/H7ZOl6QX5ur2X5t0Jl38Zz6XyJbbIS1eG51XPJQwmQww0iYPFoQl+WGSXQiC90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcBlc-008EcA-Kb; Mon, 19 Feb 2024 23:05:40 +0100
Date: Mon, 19 Feb 2024 23:05:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Message-ID: <0beab72d-2919-447f-88ff-fb7c92b28b61@lunn.ch>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
 <SEZPR06MB695901E7D4BEABE1B6F319D096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <5572f4dd-dcf2-42ec-99c8-51bf4d1f28ba@lunn.ch>
 <SEZPR06MB6959E5BDA57AF61BFAB19FC096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB6959E5BDA57AF61BFAB19FC096512@SEZPR06MB6959.apcprd06.prod.outlook.com>

> It's not MAC which behaves wrongly, it's the MDIO bus. If we don't follow
> the reset procedure properly. The MDIO bus fails to respond to any
> write/read commands. But i believe MAC controller and PHY are still working.
> I recalled that it can still transfer network packets, though it fails to
> read PHY registers from MDIO bus so only 10Mbps is available (And the phy id
> read out is always 0x0, normally it's 0x20669853).
> 
> Maybe during initialization, PHY sent some garbage to MDIO bus and killed
> it.

MDIO bus masters are really simple things, not much more than a shift
register. I find it hard to believe the MDIO bus master breaks because
of reset order. If the MDIO pins went to SoC pins, it would be simple
to prove, a bus-pirate or similar can capture the signals and sigrok
can decode MDIO.

To me, its more likely the PHY side of the MDIO bus is broken somehow.

   Andrew

