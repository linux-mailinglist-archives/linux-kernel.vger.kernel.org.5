Return-Path: <linux-kernel+bounces-65657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3785501B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800E7B2EC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34068594D;
	Wed, 14 Feb 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dRgj2LnB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA67FBC1;
	Wed, 14 Feb 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931303; cv=none; b=olB4bKhZJVtqvVuDqsphbKe1HjfFUGHH2qmpT9pjHLPnQCqEM9cZcEM1/cm7YC9LHoyXUDc+z2sPjYJZ4Yb28UWNTccDIByPb4TGu9IxhoO4i5TfySFAabuB+zgTwkt0OUa6TV0z2BrT0/AWHzBf/TQsY9/PeZgJfNxsDeDfVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931303; c=relaxed/simple;
	bh=RN7IJzmBHp/oF53sQKnXsqqY6WolQpSY3d3IbVeAPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVo6nZoFBCe5abd88nj+Ruk6QDobAYVsSjnel8tDaaXdxY7euPT/x+aSYfv1VEevJ27bSZA/k0sEN8iGwwvIKoe6rxt8J7i3QyK5/TwdDTD6efwSsWaFIqex7QeFxkAWhmbB63wEeWUzETHjMfBhj/OzD3IvX7jEHbdTba8umP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dRgj2LnB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qAJ9jSGTnf0lF8ajDMvOnhF9y048KJNQYMloKOvn0Rw=; b=dRgj2LnB/Jss5dFdOQrTwLVYnO
	8suXFCUsQ1bbjq7X7R2PJzDHdv5CtdjkRboEGKt4LUIakeNFBIAddM/ukhP8u+q3d8pR/a6phDfFN
	UqG8KGuZ80tIarZ62PZIErditHeK9T3erRTHfvZ8cGlUcaBlYTflJU06+nyBKsHJzgJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIwv-007oB3-6H; Wed, 14 Feb 2024 18:21:33 +0100
Date: Wed, 14 Feb 2024 18:21:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 06/17] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <55d90957-9a44-4c19-930e-5461963738ac@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-6-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-6-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:43PM +0100, Kory Maincent wrote:
> Add PSE PoE interface support in the ethtool pse command.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I'm not particularly knowledgeable with netlink, but...

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

