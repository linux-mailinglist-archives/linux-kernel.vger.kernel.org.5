Return-Path: <linux-kernel+bounces-122852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30088FE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B4BB21A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656E7EEEA;
	Thu, 28 Mar 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="38NP34lc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36618847C;
	Thu, 28 Mar 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626974; cv=none; b=TGgFlCx9NJGL+img0OIEEk5v170sC+hE4zsVnBV5q+FTcAtPl37/tQw26gW+XMYCEx8VjMzP8dWfpb0o4FDeWLJyDghc0MkeZDHUPCbwDsfubXsob3xE3EtEVgIRNjc6fEb/iPt8jWKPiZc0KYT5gM/xsj449YJyGzPpFg3qCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626974; c=relaxed/simple;
	bh=HJeDevFss7ftGKoBs7GBo8wdqcUpCcQWRd0Z0rC7J60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6w5A28VhTorBL5FGglh1hinmWPM7bArSHsA/JGAOL+tJN2UG4QZFuppyNGwX7kIsAd6MbTc1/F4IcxP6ioX77dgqmkbe+x6XRKcfR2Sv2vJf+g6C/XjXMfN4f676kPqqdhGyuAlUGSpEJ44rGjfBc6bhBvpEyZGK82PEFx0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=38NP34lc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h07olpqTWWJnF5ca3/Hz06zgL23i68HGqWz1fSaO55k=; b=38NP34lcVYqYrxp0jp2ticTsJL
	ObXLl0cK8LOGyLO96nkCDesLhiIeENEwBsZtDv0wswHEAgPd29yL74QUkzzX1SSRjz3EOdkcgDZsO
	D3abpWAbUNeh4oCeXqjSSBBrg3oaEkWs72kDvDCAwKodFq2gC9TowM68HBB5AxdhSzqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpoME-00BUYx-Ca; Thu, 28 Mar 2024 12:55:46 +0100
Date: Thu, 28 Mar 2024 12:55:46 +0100
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
Subject: Re: [PATCH net-next v6 01/17] MAINTAINERS: net: Add Oleksij to
 pse-pd maintainers
Message-ID: <a5ebd46c-80e4-4063-82e1-bcbb1accffbe@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-1-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-1-c1011b6ea1cb@bootlin.com>

On Tue, Mar 26, 2024 at 03:04:38PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Oleksij was the first to add support for pse-pd net subsystem.
> Add himself to the maintainers seems logical.
> 
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

