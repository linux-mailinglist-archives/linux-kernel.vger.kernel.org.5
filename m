Return-Path: <linux-kernel+bounces-133076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00183899E72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95214B221F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2916D9C4;
	Fri,  5 Apr 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mLVC42jH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0716D9B5;
	Fri,  5 Apr 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324163; cv=none; b=MAl5CqD7c/1GBpPrS/JKJSB1IhbCcp4lJCJDIJgORVni2liWPnjNZ2PQFN/XXHIWuEnKXtDsGYsYHa5lpy3iPoo+Ty8/PF+iVIPSKbJ27ge+IN6963n5EAi7aX6Hroe0NwaEbrfm/LOwptOJnrTqwMLM4/P0qNx4ugLuZ2ia1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324163; c=relaxed/simple;
	bh=zAWjA/Wd9iheRIHrVx6Rxm/wZBrKlcg3RAbOX0xiYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR+OQB8Ih3kXnu0a5YZqbsxwgDCM2lIKkYKLn1igjXSle0kHtb7STXWvYUgWmCJZ3uKYyAy7JAFZNdvWJHp9TsPRwo1hNVQ8ifSB9XMLglkWIT02JiEEPhLCsIwsA1OILfnsuYmBZs74i8i65zkXZwKBmAcjLgNh5Bf8RgFcNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mLVC42jH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JfzJ8dFNpc+CDghii6YSpfFNaWsdhY3VZxC7E3oluGM=; b=mLVC42jHqinbZk1IrCD0lN6bAx
	XQ5i7nPhII+j3ww2YGuJgYQ7Hpk+OOVp9LDeuABPxxEzSAka6DNz8NGGEzFVvfhlBjIMuI2AmOIVg
	+w7kZCRu+WA2fKNTfBQvuP2P+7mx8k1zqkWH7HxOTsC24E3hAFv2cS8neKbsw71pmrbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsjjU-00CJ3D-Tv; Fri, 05 Apr 2024 15:35:52 +0200
Date: Fri, 5 Apr 2024 15:35:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add Protonic MECSBC device-tree
Message-ID: <1a0de7b4-f0f7-4080-ae48-f5ffa9e76be3@lunn.ch>
References: <20240404-protonic-mecsbc-v1-0-ad5b42ade6c6@pengutronix.de>
 <20240404-protonic-mecsbc-v1-2-ad5b42ade6c6@pengutronix.de>
 <9d325b4e-031c-4f6c-9788-fa5a68470efa@lunn.ch>
 <Zg_NwfxLhzdCjN87@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg_NwfxLhzdCjN87@pengutronix.de>

> Do you have a pointer why setting the delays in the phy is preferred
> over setting them in the network driver? In the end this requires us
> to have the correct phy driver whereas setting them in the network
> driver would just work for any phy driver?

One reason is that nearly every other board does it in the PHY. This
is something i've been trying to standardize on for years.

Another point is that when doing it in the MAC, most MAC drivers get
it wrong. RGMII needs 2ns delays on the clock lines. That delay can be
provided by the board, making the clock lines longer. Or the MAC or
the PHY can add the delays. phy-mode in DT tells you about what the
board requires. Your board does not have extra long clock lines, so
you need rgmii-id. If the MAC decides to implement the delay, it
should modify the value passed to the PHY to be rgmii, to indicate it
has added the delays, and the PHY should not. This is what many MAC
drivers get wrong, they don't do the masking. By standardizing on the
PHY doing the delay, we avoid this, keeping the MAC driver simple, and
probably bug free in this respect.

There is admittedly some historical confusion here. The design is not
the best. If would of been much better if the design would have both
phy-mode and mac-mode.

As for using genphy, yes it might work, but there is no real
guarantee. It is always best you drive the hardware using the driver
specific to it. Consider genphy as a fallback which might be good
enough that you can ssh into the board and install the correct
module. You should not really be using it in production.

	Andrew

