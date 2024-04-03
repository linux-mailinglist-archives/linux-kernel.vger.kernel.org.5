Return-Path: <linux-kernel+bounces-129344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FABE8968CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B42E286D43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562B6BB33;
	Wed,  3 Apr 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C9VY1w14"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC701E515;
	Wed,  3 Apr 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133277; cv=none; b=uyBpkdxErzGGn0h/iBWTxv3YvoPLRoKwqoARI+kytSVNtjn4D0+WCqvbii0XSzIMUXejMP1fIIzGhzxZMYinnpbr2QC2i6Rh89XzSsCB6tpixEiOSNa5uGTNyaBcoIIAB/x99yFENtZ5DsT0OcyAwMMqbNjAHA9ReJ6/AE0f5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133277; c=relaxed/simple;
	bh=goTwDlhdbXVyAEvpyvcdhWut4bT0c0eATWtJg/XKHWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw/3+IVk+ddixeNjNB5tlKu2j1nm6hYn9eoDr6RL319eCKRBmQoNfK6dosSFD8ti55fqeYoI3O3AKCFUrI8euMT1QD1M8hof58iM8z1lJPGOUGddz4b5J++gML46y2Du1IIjROnkUow8Efzcmi5S7LgPhAcpmwNnPr0Gz0zS2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C9VY1w14; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5byGfi+YltTK32ZINcsDDBL0Ip9/fC/96w7JVL8ZAeY=; b=C9VY1w14a8zzVC+dEq1nF2CU1A
	rIwwPRYl/p95f094Bi7cXEOMsEItYe6cHITEKaIfyE3HpJjVQr7fNMyCE5dcdg90j15gmp4iyQJTD
	ifXJRoHXKdXNr/265/clVoMZSmy4Yk2Yk1F4BaUaRB54Guahe9E4C3QqvlHmX2I2URTNX3A8qcvgy
	DsPxq2cdla8S2+sm1jXnQtCiOJeQOtm5deMjU5ZoOFUPqeOETAZhEu31dOFNpF4MqBX2obdS6J/wa
	WT2vG+NoiJDg5J0Wpc6AesDG5+2Cbq+8WPqpBar5CAHqxEXmUvJ+EIjX6ehYoOliFfBCrusVDPWmA
	M2ef8e3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrw4Z-0007z7-0k;
	Wed, 03 Apr 2024 09:34:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrw4W-0007mg-3j; Wed, 03 Apr 2024 09:34:16 +0100
Date: Wed, 3 Apr 2024 09:34:16 +0100
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
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
Message-ID: <Zg0Uh9TvArz7tLzH@shell.armlinux.org.uk>
References: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
 <E1rrgQO-005ZOA-KT@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rrgQO-005ZOA-KT@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 04:51:48PM +0100, Russell King (Oracle) wrote:
> Use the newly introduced pcs_init() and pcs_exit() operations to
> create and destroy the PCS instance at a more appropriate moment during
> the driver lifecycle, thereby avoiding publishing a network device to
> userspace that has not yet finished its PCS initialisation.
> 
> There are other similar issues with this driver which remain
> unaddressed, but these are out of scope for this patch.

Just for the record...

Digging into the history of this driver, the init-after-publish issue
was introduced by commit 3c201b5a84ed ("net: stmmac: socfpga: Remove
re-registration of reset controller") which gives information on why
calling the PHY configuration before stmmac_dvr_probe() didn't work.

This was further modified by 56868deece92 ("stmmac: dwmac-socfpga: add
PM ops and resume function").

I haven't decided what can be done about that yet - and I'm tempted to
leave it as-is for the time being until more of stmmac gets cleaned up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

