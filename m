Return-Path: <linux-kernel+bounces-30634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B106983224C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA23E1C2253A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2F1EB48;
	Thu, 18 Jan 2024 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dkPCbZyR"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DA1EB36;
	Thu, 18 Jan 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705620858; cv=none; b=ruBURsideX7PunBWRY4cFr07zQoUKWIDjqzaositelQRjY07dmLpntL0Y4sUvcLh9lZ9fLwqCKbHiF1OYNkN0qkY+qnRJG7gswQIlZqjh9KKl0STKTkOnpBhEa1H3KZT8LvDaSQ6PCEyRkHfHgtVL3Q4m9bYAqr3bawO5pFhFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705620858; c=relaxed/simple;
	bh=f43g/o6DELaGlF54cw9m9YqpDM2kRtSlAdByNGiSRr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/7Ph7JDF5lWlNACyxK3jdImRPvHhCeeCPvmE2F1eFXqPQ3asJmOy94SYhIAA6uhj725IiofSRZhYYuECEvztGtdfSek5DtyYtmINbGBW5aPM7rCEv6/aFbNyKJPte41wwzleVktpPV9WPvsVPOKo60/7nzaqhgSILN6SGtzFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dkPCbZyR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K/G2shxQvXG2Qi1TfkdPAFj+pwZ7Bi7AXWM5RodtagE=; b=dkPCbZyRiSpFLHEQZ11dlL9dJn
	g3WIGkZwJ9AHvyaERjyTLy4vcXCBq1hTvYXzt7j4N0fYfTAbT6d1YSDaOQ8hpMJ9m6nBCIg0pdRNV
	3l2wL4eTRWQ+oioOZ4bjfiZjSG1it19iMw6NLluCYnW+8Yn6rujNmizuDGHdwbVkL5e9FeVYpUoPC
	CRvlZH2jzpZkmOLc9BtgGPQHDDBymt5Sh566OfJqwHwDQij31JHo7nngxTRt5dzd23hL4QwcVQUQb
	P8hPHQfG6G0yIzjqB7zNDKWD1da/vIZig0G6hoYrPkpM9QFYnR1hBgVkRyNPLxtr1fq/F4r6eZlED
	WJX9lIuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQbtf-00068Q-1d;
	Thu, 18 Jan 2024 23:34:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQbtd-00066e-NO; Thu, 18 Jan 2024 23:34:05 +0000
Date: Thu, 18 Jan 2024 23:34:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andre Werner <andre.werner@systec-electronic.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
Message-ID: <Zam1bWV+yZqq07FR@shell.armlinux.org.uk>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
 <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
 <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com>
 <4e30f871-c7b7-4dc5-ba4c-629a63dc3261@lunn.ch>
 <70a4f7de-6032-4247-a484-56d1fdcee7f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a4f7de-6032-4247-a484-56d1fdcee7f8@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 18, 2024 at 10:24:03PM +0100, Heiner Kallweit wrote:
> This would save us here, but can't prevent that phydev->irq may be set
> even later. I think, ideally nobody should ever access phydev->irq directly.
> There should be a setter which performs the needed checks.
> But it may be a longer journey to make parts of struct phy_device private
> to phylib.

Yes, I have been thinking over the last couple of days through reading
these emails that's a path that's needed to go down to stop drivers
poking around in stuff that should be private to phylib. So it's
something I would support.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

