Return-Path: <linux-kernel+bounces-129184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70B8966AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2861F28391
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538C5C8ED;
	Wed,  3 Apr 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UiP5IpRh"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605A4EB2E;
	Wed,  3 Apr 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129719; cv=none; b=EIBhtclExLNhdCGMeXBKll3AeOkJcncvf0KNgiXvMONKQC5+81DJIJnRgB6powxcn0jQIwVxjr2HZhYpqJpRXa6pl4APZKKgi/l554R+okHmY2QWfx30UsLLdmlsG4t2Wv9btXlXP3wwV4lG/eRSySOxnD2oJLK12y9wpmtLusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129719; c=relaxed/simple;
	bh=AwIH/TDnxGsGCKkzY4uf+J32Ol/N5m/BsfMmc9RElzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F45mJHKhynK1nQOEI8iHxyQnZqHg6og24/dVcVJ6q02ygHOhjOA/JLaB8UhbhNeL+Q8PK5Qcaa75yCm/NzpMvEFyrgGCVHBtzqty7nvUf7Q9hBfCWQd+Vy03kcj0lTyAgRdhdz2sGwf/IYTK+MpaWi/uhbPx1N6ShjlajaVI8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UiP5IpRh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0nd6s/vajPp1wjA2UISKvW/UOHyR3him7Zhv4m1hHt0=; b=UiP5IpRhi3Yd3AWY4IoG1wCQot
	gSWwSvt6+63EavAOI1y8FEzuoIOOgYyVL6SoHO/35i9pzzjZfUeF6yzEvghWiw0+KhkcylkdBQR+h
	i3Kp4j8d0MPVL8sJc1zARq5VHMWTKbKekwDWptsiB3HkIeyqUv/I70hj4D2BRIWP8LLsFugTejUcK
	MQh+SV55NJJzggS2CICuP/uDtei9N7iwFPZpkRM9aDnFDjf0Eu9dgT6ekkiMA4mKNqUQ6x7MxySF6
	bDcJ1anBPlw9BSzkrddgTmwlYsyWZKGoNf6FTDmQCj2/utCKAPDPZip7GcJUPtwLWy/Er6bjOiVuX
	OHuGjaaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrv9J-0007sx-0V;
	Wed, 03 Apr 2024 08:35:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrv9G-0007kd-T7; Wed, 03 Apr 2024 08:35:06 +0100
Date: Wed, 3 Apr 2024 08:35:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: marvell: add basic support of
 88E308X/88E609X family
Message-ID: <Zg0Gqpo9xqpw69Cc@shell.armlinux.org.uk>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402201123.2961909-1-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 10:11:18PM +0200, Pawel Dembicki wrote:
> This patch implements only basic support.
> 
> It covers PHY used in multiple IC:
> PHY: 88E3082, 88E3083
> Switch: 88E6096, 88E6097
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

