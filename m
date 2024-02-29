Return-Path: <linux-kernel+bounces-87133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378386CFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964701F255D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CD7A153;
	Thu, 29 Feb 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N9ZbocCb"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23597A13B;
	Thu, 29 Feb 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225922; cv=none; b=jHH1bW+c9NIhd1yt/U8fa8dPlcMslK53ItJVmtixz0Vgs6lelChg2QfqAlhlfaA7LTziBCvsN/5yGueaWL6y9xou9eqF73BkziTSP/SOJL/w/Vg4ofIxUzMIQVqmrYGlGQ3h2cCSuNuxMMUl43brQPekhplGDGBpSLPf0TmHEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225922; c=relaxed/simple;
	bh=p6FqwOUMGbV2c5HR1BYCJhqK5gkHnO/jnmliZOTV0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6XcgzXqKw/Wcla3R3u5twDZ4Nc3PpVXTmABTZUHFRKzJTrQIpBYAdhEPgklejlDc3v61KpWXVZI4LxPSwQ5khF9KwkTzkvJm2WmjPg/ixTOh7SLGW4XFs5sAKhIfb4rokioMuRODjrqgvYOhMvUR2yaZTx8WAwhFcXbeejITBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N9ZbocCb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/cAast4b1moTClApH8MesOygPfzXLs7wuYy5qzSoQzM=; b=N9ZbocCbjrkXC3f/TVFZZiow7r
	KBN807SMyg2iL4AZBkaetkYRUEGJogEhjby9l/ukSKUFudq4PgFkeQYr3CiS+OpEvk9TK3NbGGQRb
	MyWKR4JMuMnwOguJHzsmJlyHvMfSainzvzZLOZM3YXJapOTONhS4y7ekVU+u3LRrAQ9H5qivH5xxm
	e1DZRNdOjn7JJEAdK/paIzo+/vbWMq33Un4Z0Rquv1lzBBbg/2+MeuZwromNoUpc8G71XUWMCL9Om
	opZfnSh+EvjifPbOYilY4QXwLFLyvYeu1r7zGNFu8yArqegaw35l6IupkKMr69+eAAQvujfzGT5h5
	dA0w84bQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45990)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rfjjl-0000WT-0y;
	Thu, 29 Feb 2024 16:58:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rfjjh-0000yS-TA; Thu, 29 Feb 2024 16:58:21 +0000
Date: Thu, 29 Feb 2024 16:58:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 2/6] leds: trigger: Create a new LED netdev trigger
 for collision
Message-ID: <ZeC3raIM/wxGXsuz@shell.armlinux.org.uk>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-3-bastien.curutchet@bootlin.com>
 <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
 <e1936774-14bf-4ae5-9754-e21f5a0c59b3@bootlin.com>
 <9dd1b2d0-4ba5-4d34-a892-a6cc8c01df28@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd1b2d0-4ba5-4d34-a892-a6cc8c01df28@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 29, 2024 at 04:17:47PM +0100, Andrew Lunn wrote:
> 2) LEDs are the wild west, because it is not part of 802.3. Every
> vendor does it differently, and has their own special blinking
> patterns. My preference is to keep it simple to what people actually
> use. You cannot actually generate a collision, the developer who wants
> to add support for collision. I have to ask, is collision actually
> useful?

I'm not sure when you say "You cannot actually generate a collision"
whether you're referring to the link or the LEDs here? Obviously, we
can't detect a collision unless the hardware tells us that it happened.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

