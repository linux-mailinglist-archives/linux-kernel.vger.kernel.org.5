Return-Path: <linux-kernel+bounces-28356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676E82FD38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D94E28A50F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AD208DF;
	Tue, 16 Jan 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4QtaqR7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7601DA2C;
	Tue, 16 Jan 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444535; cv=none; b=K8pUXTsXWe+4eH5kTc+RaM8265Tb6e2+dOwFhx+8bDu3uYPWSiCymerG+MadktsnO7WXyvzHedFYU+ykW7rYSuPYaKUr9DU/sl3rdawJMfd+0ggg1LD/368QRsmWHKBsLwNduArA7NMcbkMXdgS0jTz86eWmYKX8MyOlq8YqRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444535; c=relaxed/simple;
	bh=ins1IDJZ4lyx0ENQCIEAJzl9MLbVaW2Mn2TyaG9gBUk=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=RkAuIsnsIYdmGz0T/10Wgla8HRqYWhtFGIleudFeZMHH2FuhzumNojP4tqUOJZZBRo9qgZYRR5AhfWiVIngNuvi3eDhmzE/KyFg276JySFgPgD3zNSiiMBRYNBAUx1klAtBh9Kf1Oh5Wut90vH9hyvstQVAepWJnMX1vC3xHD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W4QtaqR7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RdhTevdQVBdb8wlxJd7xNXUyeRnkCEOfn9WkZe/WJWg=; b=W4QtaqR7NHIOIWimMjGhfOWFsm
	PKzYCRa3+vm+SUCtszEcpa18+cQMWn8Ejkyd5cqqhgi1CABB5bYt/tfUAaef97tbwOiDzLu/Snc/8
	0lCmYOUU+tGPH4RRI+IvLjzC/LbYe7R7yW5ch1462y3MpeZSzi3H/L2Bf/SozwnqO3UA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPs1e-005MRS-8j; Tue, 16 Jan 2024 23:35:18 +0100
Date: Tue, 16 Jan 2024 23:35:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
Message-ID: <6e33c038-45a7-4941-b5d9-ce5704e13d48@lunn.ch>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>

On Mon, Jan 15, 2024 at 08:21:42PM +0100, Bernd Edlinger wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.
> 
> Add a wait for 10 us before continuing to be on the safe side.
> 
> > From what have you got that delay value?
> 
> Just try and error, with very old linux versions and old gcc versions
> the synopsys_id was read out correctly most of the time (but not always),
> with recent linux versions and recnet gcc versions it was read out
> wrongly most of the time, but again not always.
> I don't have access to the VHDL code in question, so I cannot
> tell why it takes so long to get the correct values, I also do not
> have more than a few hardware samples, so I cannot tell how long
> this timeout must be in worst case.
> Experimentally I can tell that the register is read several times
> as zero immediately after the reset is de-asserted

Is zero a valid synopsys_id? If its not, maybe do the wait conditional
on the first read returning 0?

   Andrew

