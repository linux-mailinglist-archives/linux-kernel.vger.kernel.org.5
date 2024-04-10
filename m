Return-Path: <linux-kernel+bounces-139251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BCC8A0085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549A51C23002
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0C181322;
	Wed, 10 Apr 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jnBOFofu"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D857BA39;
	Wed, 10 Apr 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776814; cv=none; b=fmduH/mz10T9PFHOh+46UPZ+eOVPSIzKyXpTtwcUDYL/aLH5Tx9AjUGkxKI52isrzcHppF3Z985VqPdDrRN1y5qINDf/MZfynBuDujkcXxuYUDnn2DALmRvaX8z1buZVVoJluVfpUXdEVZuURzy6DiLqPwrsKuG6mr4qbL7tozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776814; c=relaxed/simple;
	bh=l9o/uTy+0cwr3zODJ1peUNnlmhVhrhKvdmKJKAavIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOPXaG+lFj4HCODm5gCqk9e+ta4ldlObuRxbYgx5aNt8zXgSOUknf0hJyv0EhwemBP021nejDaapM0tpsTdLk4kPa0gzxlh8g+oaNABJ93pvCwoI0V0h4V4H+zmJbQle4n+TBPoNd8cWJIar1Wi2HwtbJ0Q/pMt315JRMeE436I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jnBOFofu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dd1aVZalUKuA+B9so3sWEVj2LqaGyKO5Aioahoz1vu8=; b=jnBOFofuCRHm+O8XMCs99fUn+L
	UXp75jYAtDxJlu/wtMb4foX7uSRRD+Q+TwX+nFozurCdwnW8f4TJw0fhYisFCNbgE8TlvJrWRJRl8
	+qHegzmIZKXaqDrVHvrE4X/DZnbbdHlNKL879QPzG33DfG8e/YHsp8uqcl9kUOrIf0DeyZMlAVa5O
	pb0kM09fXSNtS7935t6ShX040phZEI0K+QxhJLXNfRgpiVuKwueeSBF+TNkbXcN4m35qjxnMErYyN
	rpP/4SIGhD8z5sdcmBfKPf3om8cujhnuVjHkociKGNJS6mN2Sld8TTFard2pldEdDHcQBpiyrDZrn
	h7PnNJkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rudU9-0008QF-1o;
	Wed, 10 Apr 2024 20:19:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rudU6-0006Cb-09; Wed, 10 Apr 2024 20:19:50 +0100
Date: Wed, 10 Apr 2024 20:19:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	linux-arm-kernel@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 3/5] net: stmmac: dwmac-socfpga: use
 pcs_init/pcs_exit
Message-ID: <ZhbmVVXgu27ZZaNf@shell.armlinux.org.uk>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
 <20240409-rzn1-gmac1-v2-3-79ca45f2fc79@bootlin.com>
 <20240409183404.7d3eb04f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409183404.7d3eb04f@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 06:34:04PM -0700, Jakub Kicinski wrote:
> On Tue, 09 Apr 2024 11:21:46 +0200 Romain Gantois wrote:
> > +	struct regmap_config pcs_regmap_cfg = {
> > +		.reg_bits = 16,
> > +		.val_bits = 16,
> > +		.reg_shift = regmap_upshift(1),
> 
> This appears to displease the compiler:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:389:16: error: call to undeclared function 'regmap_upshift'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   389 |                 .reg_shift = regmap_upshift(1),
>       |                              ^

Yes, annoyingly I accidentally it 'u' instead of 'y' in vi which
lower-cased the entire function, and didn't realise before sending the
patch as a theoretical solution to Romain. After build-testing it locally
I did notice it. I would've thought that Romain would've build-tested
before sending out his patch set and would've fixed it up... I didn't
have time to properly fix up my patch (essentially would've ment
redoing the edits from scratch to ensure that it was correct.) Still
don't have time to do that. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

