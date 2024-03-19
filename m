Return-Path: <linux-kernel+bounces-107267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9570C87FA29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73D41C21B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7F7C092;
	Tue, 19 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L+cA3WDI"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A957885;
	Tue, 19 Mar 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838316; cv=none; b=qVz83FrR84sJc5tOiKdHJpyPwD7qrE82+BZqmrjV7zq/n7fm9HvVzUu9BcGXutt5dM4hFGvDEbqNn63LsDhISLQGdzDBSKlpzbj+COMkrAMkITXtzhKzPZ72YMeEmakL1ADlLiunW1E0VBhkkEThk/pnuNVcAI3j3LMcFW5ZloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838316; c=relaxed/simple;
	bh=wuxCjLjSB2jlZEFQiE2k3zJd7M5XOeVOZ5qvT43RcPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRfa13NsFWGl51DNxwtttNDXRouIedLatxbfoeAsMtLz/lIfNxCOFT3kBMyMdGfQ6mSkdr36ZcMNeEhYUSzavujzikfNWFkfzrPyxs1c4EF0gUhzswF8uRncngyermF+U8aKh/iKkaniMhljLwLfvGVv0jbw6krE5jucVel99sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L+cA3WDI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pzxTTNJ7RGBG1EwIfr7Uv2mWk/VNxpAAre6JLd+MBYA=; b=L+cA3WDIuvNv3pd07MyuAFUHdE
	bUnMujB1dWr3VDxyopxRNunmzdxex/DngYmYCw26JIN6VVZys5ZENoLXSp06OoAepJHywuVjSRtQR
	q4mPtLmUjwr+OFf0EOWJGEi4dlblWmWhzpE+p4PnnOPlkIDypghXQqYJfKck8AXvU70QQwcH1NMC5
	ZD/PqijIpLD8Ab4FASCcbININHlboZ+oJThmBHGjGmPDdAx8CLnRH5n095WV1RFu6vHAVJlsxGqAU
	wHxotJENlMfR+6wmMWTFsanUG37K+nMzSZr1NFXkWsCFxnj2T8sVL7b9YGENVN0H79dR8UvLPuqOa
	BWSO75zA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmVC2-0005AX-0Y;
	Tue, 19 Mar 2024 08:51:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmVBz-0001ac-FP; Tue, 19 Mar 2024 08:51:31 +0000
Date: Tue, 19 Mar 2024 08:51:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: John Ernberg <john.ernberg@actia.se>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Message-ID: <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 19, 2024 at 08:37:44AM +0000, John Ernberg wrote:
> There is also a case where the phy driver module is not automatically 
> loaded, in cases where request_module() fails, either due to the 
> userspace helper feature being compiled out or other reasons, and the 
> module is loaded manually later. I suspect for reasons like these the 
> genphy probe happens so late. My solution here doesn't cover non-loaded 
> modules either, but this could maybe be covered by moving phy_suspend() 
> to phy_probe(). Unless there is an even more clever way to go about it 
> which I can't see from inexperience.

Note that in the case where the PHY driver module is loaded late,
phy_probe() won't be called for the PHY until that happens.

I would say if one wants a platform to behave with minimal power
consumption, that is something that has to be done across the
software stack, and that includes the boot firmware. So, if one
wants the PHY to be in a low power state at boot time, then
firmware needs to ensure that happens.

Trying to shoe-horn that into the kernel isn't going to work
because we get to decide what to do with the PHY way too late
(due to PHY drivers being modular and on the rootfs.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

