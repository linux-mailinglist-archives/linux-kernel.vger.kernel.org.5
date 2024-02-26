Return-Path: <linux-kernel+bounces-81296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06986739F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC91F2CED3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD211DA5F;
	Mon, 26 Feb 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tnwZ/sP4"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975541CD1B;
	Mon, 26 Feb 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947685; cv=none; b=gbHtKBhgP+WFnVjVlfXfAceB87gREti7nZfmMY/SCjQ72VfclL0aW0vZwsaPNE+HA6ZMz+I8+JmJYVkbo56Empj1ircz6/P1m0yceX5/Nt/u3uDwjk4Qv5wZO/6e8/rfgk/bIpnBbFzSuCq2nwHveazhKGueam+obG/mQgkvjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947685; c=relaxed/simple;
	bh=i0sZPE2siA+KbeFuOAnfEtNMdZnct79f6csjj2KTG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDEqOYaEY6SFyc30FzhmAf/Vl0OCdPocsyUSnpWOzR9J29qOHqcZz/nAFMr0UopZU6HB8wWhQygxYs9m9zxHOG6J3z4T6gQwvTgXbwxmE1+dTa899izot/wqB8vNdkkD4nis7rWQFvPLW40iEv3KEZkOf0O4PqHOD/a1lBXFBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tnwZ/sP4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yfZTLN5C2RkxA/kaPf/m9p9YAtmZBNtR82Q6hYJPxLM=; b=tnwZ/sP4RiscbQRTfiGAaEXsqn
	8IH5bQ2CUgY95aH0jdx/aX5gu/6OnrDygICiOEbqe0V3JeDnOG0d5erGNQPdiK97Lgg/xmJuJeRJe
	Ae1QPU6MxN1W9mErx7LQd6aS1ytcx6OZiA9hv214YJSmM6DAKnWZr0/jOxkcoNakYdfK9o3DszvW7
	KJI8hIIMv7KtN5DwMi5QJ1gTwEuakIM3CtJFVkaZ+7s39rqkQRThWvQIvjMKBI90ORlgVAe9abwzK
	fRlfk8xoJdqTN1xlCs2KF2F78CVUoh0MbTeNCdUGNqQkT13ObfJLzdUCAttW8bq4oGi/u/gg3EDxX
	3ELKMmAw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reZM7-00038r-2I;
	Mon, 26 Feb 2024 11:41:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reZM3-0006Op-Jk; Mon, 26 Feb 2024 11:41:07 +0000
Date: Mon, 26 Feb 2024 11:41:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next 1/2] doc: sfp-phylink: drop the mention to
 phylink_config->pcs_poll
Message-ID: <Zdx40zi1Qz61sCX7@shell.armlinux.org.uk>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
 <20240220160406.3363002-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160406.3363002-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 20, 2024 at 05:04:03PM +0100, Maxime Chevallier wrote:
> commit 64b4a0f8b51b ("net: phylink: remove phylink_config's pcs_poll")
> dropped the phylink_config->pcs_poll field, which is no longer required
> to be set by MAC drivers. Remove that mention in the phylink porting
> guide.

The porting guide needs to be updated with the PCS, and the details for
that moved over rather than being deleted. While it's true that this
member is gone from phylink_config, it was only removed after the
introduction of the similarly named member in phylink_pcs.

In other words, point 10 should probably read:

10. Arrange for PCS link state interrupts to be forwarded into
    phylink, via:

    .. code-block:: c

        phylink_pcs_change(pcs, link_is_up);

    where ``link_is_up`` is true if the link is currently up or false
    otherwise. If a PCS is unable to provide these interrupts, then
    it should set ``pcs->pcs_poll = true;`` when creating the PCS.

However, for that to make sense, we then need the guide to provide
details about creating the PCS, and also the mac_select_pcs() method.
Thus my comment about a much bigger update being required.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

