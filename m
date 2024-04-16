Return-Path: <linux-kernel+bounces-146735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AB8A6A14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F661F216C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52312A16B;
	Tue, 16 Apr 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R6GDJn38"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E9127B57;
	Tue, 16 Apr 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268913; cv=none; b=ix8DA2qTeoHyEYvFiMvNKTF7lNaxH7MWdi7OAHNGNme0Qag8hzJn5SnJ2SzQHzyb1sts02j9LzOLseelRLHFr5yrn65ndKRfXVQZ02V1zpxtYSEbIDW2jky/h5WpVpVwkRoug4Z2ijU4Cqd4zmEM/lkG2zKhmUkDR5v7Qwgdf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268913; c=relaxed/simple;
	bh=y04OwjH/sbLKlcXwliMQHnCBgTseJ+PQ3aes3eUFGXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNbMHH9wY+jLN4IVESRdQes4EEQDWxP4jXeWTFUBgCvKYuI3G0GrWYjNnX+3e3OBJUZ5cOQzRBG9RQqWF6Ju7j2Du/ViQLCIhjyLUUB1j7SsAk57sQHiFC3ScQFM3b3yt9LSyZD2/qv4mOBjTe/W+O27QCghUnF65WfpCttnJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R6GDJn38; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IsKWmq3S1tbhsPEHkpNJ+4wTjZvXqEyH5UAdmDYEQ5Q=; b=R6GDJn38hgKmNBGIc81JtA0h1Q
	R3uScF+x+HDTqA8bIZi8vFrRKzu4vgwk6os8ntlO2z4sio2h40d5XAbu9VYldnSIq9/Uc2BFgxhWU
	gYhHN/JWQBuDrHapNFeqQUlssHeUz7jEXzIuxbYOR+Oiam/vKXNlqS5aZKZVHPLStzH5rEMJFdeqp
	xIQ6DJrAGZh1xsU74mUnzpwU4/s02XomHhPQoL9yiF7qk88W8YEcIa7iMY0o8e51JmSx2V1NTExas
	kZAUfITBlX3IP8E9E9hqhJkAqpfhfBqhepNUAQFCPz8I/PhRvoptM3wQRl+1nbrmTPPkjr9jiogV0
	sxjM8eCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33062)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwhUv-00009J-1B;
	Tue, 16 Apr 2024 13:01:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwhUo-0004pX-19; Tue, 16 Apr 2024 13:01:06 +0100
Date: Tue, 16 Apr 2024 13:01:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: stmmac: Move MAC caps init to phylink
 MAC caps getter
Message-ID: <Zh5ogZ433lrUOi9b@shell.armlinux.org.uk>
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
 <20240412180340.7965-5-fancer.lancer@gmail.com>
 <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714199e5-edf2-dcbb-216b-563431d70488@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 09:56:32AM +0200, Romain Gantois wrote:
> Hi Serge,
> 
> On Fri, 12 Apr 2024, Serge Semin wrote:
> 
> > +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> > +					 phy_interface_t interface)
> > +{
> > +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> > +
> > +	/* Get the MAC-specific capabilities */
> > +	stmmac_mac_phylink_get_caps(priv);
> 
> This is a bit of a nitpick, but the terminology is quite confusing between 
> stmmac_mac_phylink_get_caps() and stmmac_mac_get_caps(). Ideally, we could just 
> get rid of the whole stmmac_do_void_callback() complexity and just call 
> phylink_get_caps() directly. In the meantime, maybe renaming this to 
> stmmac_mac_core_get_caps() would be acceptable?

I'd prefer not to do that. If the method is called mac_get_caps() then
I'd much rather have method implementations called foo_mac_get_caps()
which makes grep easier.

So... stmmac_core_mac_get_caps() would be acceptable to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

