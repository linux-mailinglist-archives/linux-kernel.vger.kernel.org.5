Return-Path: <linux-kernel+bounces-128078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93668955C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E471C22105
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661EC84FD5;
	Tue,  2 Apr 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WiBOleVC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D15D47A;
	Tue,  2 Apr 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065813; cv=none; b=Ot+BlLdtbmlCBtbEHhlmU07sz5pYSvo/QMUzjoILJwT0lUY94Bab8xb9T6BFcWusLDsNZqJJLLqBQUz0vsB89PDEuOG8rL/lmLQMnnbUvT3Vui7ce4JSLsMWKfm1OwIEdttvWGoTZedpqhuaKpRSjdFPjqNZeaVyr84JbZDPWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065813; c=relaxed/simple;
	bh=GSsExJ2Cweiqv3U9XKAHuGsEXUUvZAgvUg0YJmbTYl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4UklczkKTqPvBH5EOoerj1+2aVOSri7IPMZ9H0Q9f7i0Zs3vHp/1QeWb8o9jbMsPuKbpuih8v5caiGL8SDC+O+jmLMDztwsxpyffYMkc230Var9T9HrfMi+UveHMWDk+Rv/tPYHX7x7bt9WfP87/VKUF66XUNPqipRYv0rxsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WiBOleVC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GbhkBxn+Q4MglL3Lf04y1O0cOhqs2SZS9H0XUJs9VK0=; b=WiBOleVCJwBRPqHpBXE8Ef/U+G
	OXNriYeqoB6MRc7eicL0W9EYhGR5ajRr5dPJ3uNYPlNNIbBC0HxhOjk7DX+2wrYxTMNRua2n+Ouyd
	DcF7rtkkHvFur+rvqAyiGx3S/0gqFEQDFnWt/53GQX4zgJY1vfLs/j7thO2twHL23gXVKutcSLr+t
	NeyTrxfYKNeV1LKFgJ6lvMdTakw5Id9g+QsR+G9BFveVUS00EP3jajyAUvlglUWEbHpm7lDgYooWA
	4eTco3FzRs32jC95CiPlQWcfUG6OgLsQ8riL7aDKCl/kqEz3RxVb1iYaSkQowHA0A5pYpDU9hP4uD
	ELWzNoKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37898)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rreWN-0006no-2a;
	Tue, 02 Apr 2024 14:49:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rreWK-00070E-DE; Tue, 02 Apr 2024 14:49:48 +0100
Date: Tue, 2 Apr 2024 14:49:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: add support for RZ/N1 GMAC
Message-ID: <ZgwM/FIKTuN4vkQA@shell.armlinux.org.uk>
References: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com>
 <20240402-rzn1-gmac1-v1-2-5be2b2894d8c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-rzn1-gmac1-v1-2-5be2b2894d8c@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 02:37:01PM +0200, Romain Gantois wrote:
> +	ret = stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	ndev = platform_get_drvdata(pdev);
> +	priv = netdev_priv(ndev);
> +
> +	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
> +	if (pcs_node) {
> +		pcs = miic_create(dev, pcs_node);
> +		of_node_put(pcs_node);
> +		if (IS_ERR(pcs))
> +			return PTR_ERR(pcs);
> +
> +		priv->hw->phylink_pcs = pcs;
> +	}

I'm afraid that this fails at one of the most basic principles of kernel
multi-threaded programming. stmmac_dvr_probe() as part of its work calls
register_netdev() which publishes to userspace the network device.

Everything that is required must be setup _prior_ to publication to
userspace to avoid races, because as soon as the network device is
published, userspace can decide to bring that interface up. If one
hasn't finished the initialisation, the interface can be brought up
before that initialisation is complete.

I don't see anything obvious in the stmmac data structures that would
allow you to hook in at an appropriate point before the
register_netdev() but after the netdev has been created. The
priv->hw data structure is created by stmmac_hwif_init()

I see that drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c is also
guilty of this as well, and should be fixed. It's even worse because it
does a truck load of stuff after stmmac_dvr_probe() which it most
definitely should not be doing.

I definitely get the feeling that the structure of the stmmac driver
is really getting out of hand, and is making stuff harder for people,
and it's not improving over time - in fact, it's getting worse. It
needs a *lot* of work to bring it back to a sane model.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

