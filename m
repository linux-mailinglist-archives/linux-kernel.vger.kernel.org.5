Return-Path: <linux-kernel+bounces-83597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDE869C12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CCB28E585
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A71474B0;
	Tue, 27 Feb 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="INV8iT4V"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48FB1474AB;
	Tue, 27 Feb 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051193; cv=none; b=dI9MJapjZnQCDrumltTsHqwWD9uIVo/pVwqX2y7JOolsCo6dKEeWF5X2zUwKKZ2HfeNjCVwrBCC1btfkWbvPnOBc6d8c7Ks7qSBVVy9bG1BHJRio7uZq3qVZTYnpWO3oauq2ed25UG2P1/TudW4nEb7F0uE7rQXcJPoz/xfXuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051193; c=relaxed/simple;
	bh=+1N0yN1pY17xo+GMX7GuH2gXxeC61SRGI9tHtKNgS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbUOOVe4eyw3CffzkkJjES1qw38auZL0n9Za156bA3TSqBSK7DLkPxIEljtVEkSe12MijNQ7qsfMMpANU9I7ehM+ky9nUVQAQQX2Zhfq/K49N7ljWLVqkfj3gWfc7uDpwEa2CxaieYlQekukHaerlOhg4EoU6iNSU672YMAZ8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=INV8iT4V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jr5VUhDzzReZoZ1yvB/jLd5cpPEf+jCAXBlp5ZwbFw0=; b=INV8iT4Vkiv4I7z+SNUveQ2ooP
	YRwzmhr+yVvvSoJdIEm/q6+UY6iOFFUIt7L4sbZxfyYLrOlTcrMSpyFFwY3BOfAp5pqC3fwEBVI1A
	cFjfYbDLCSY/ysP5hknI3sCacGXjjrLlCP2srWEFMOJ3KUNrcZHSmiM8HRv9TYxyrQGm5SJyk3Jzt
	rC/Xsw0OxkwlAfz1N/9uqwsktYYRV9pHsZmhLXvG8F9BNYYFskP2UuTimSBIVCrnim9EFQQU/K6DA
	UpQowSncDw6Xi1MJQDAHyCUb3D1toRbRBvegpq1CvYq6sOrTnLe72cSNt4+ImTyRXqJALc2JUMlg6
	CsFFWiNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rf0HZ-0000da-0S;
	Tue, 27 Feb 2024 16:26:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rf0HW-0007WX-4F; Tue, 27 Feb 2024 16:26:14 +0000
Date: Tue, 27 Feb 2024 16:26:13 +0000
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
Message-ID: <Zd4NJUcN3p/Vi2vn@shell.armlinux.org.uk>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-3-bastien.curutchet@bootlin.com>
 <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 05:03:14PM +0100, Andrew Lunn wrote:
> On Tue, Feb 27, 2024 at 10:39:41AM +0100, Bastien Curutchet wrote:
> > Collisions on link does not fit into one of the existing netdev triggers.
> > 
> > Add TRIGGER_NETDEV_COLLISION in the enum led_trigger_netdev_modes.
> > Add its definition in Documentation.
> > Add its handling in ledtrig-netdev, it can only be supported by hardware
> > so no software fallback is implemented.
> 
> How useful is collision? How did you test this? How did you cause
> collisions to see if the LED actually worked?
> 
> As far as i can see, this is just a normal 100Base-T PHY. Everybody
> uses that point-to-point nowadays.

That's largely irrelevant when it comes to collisions. If the link has
negotiated half-duplex mode (which we still support) then even on
twisted pair, there can be collisions, even though TX and RX are using
separate pairs. It's a quirk of 802.3 that this is the case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

