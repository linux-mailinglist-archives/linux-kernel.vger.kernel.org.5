Return-Path: <linux-kernel+bounces-41656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3E83F5EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C4CB21A25
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4D219F0;
	Sun, 28 Jan 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dBoUutm0"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49028DD2;
	Sun, 28 Jan 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452989; cv=none; b=CupVWBfsIrP6LySLVmEGTmSjgMCFbfju3mxsRJAu2s1T32E7Lo2PBtOJc7HFJ2Rf3XLc+2eB+tpMVQxCBQn5fPm/46FCmD4V/DepKUT2OVwPBiJ/6BxxNKh3STwMVOlYJIrgjWZjfTul+B9/M7TWrCOqWkYUaSAI4tNZs7bXfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452989; c=relaxed/simple;
	bh=486uJUBdkiYN81ZTZxBhuS+DZZlq5NeuS0oQGvn7p8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr+ROhEd4b/k4gvmlTw5zvw1e17WutfV0rpqg0sZYGWMRgyuf5Seudai9Jk19eyvUla/sZ6BFk7IAJ079908UMLSez2Xu2TK4dg26iCisXwHLjFrYzm4TIZyuXnbfXNKTJmWugQNJcMD8BYpEDmUElsquXWtse/ngczaQy8QqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dBoUutm0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o5WtDJdChOvcGrPGkFzXopSDwlYfTQLrTcJxGSuPnJA=; b=dBoUutm0vUsI4EkZypQdipS9ww
	AmgIYq1ZKV7lIu9SDtHF6pYneo8hSCj4tXv+yWhCnX9giZeElt0kMuMbHl2K/5ClSCw/rHmrUiUzo
	cGx0/ToQnb1AlEtE5bogX1XTgKt/z4Yw0krlAog0ZZq3oRA1UiBg4iE9p/P6xYCVfqQyqQncsIMjd
	4YVmDTxsrzo4PoahQGHAvO+pbWUAPQPQrk37tCOlifEC8Nk0hdu8ufGMcNs/7VQsPegzFdQf4QtfD
	3XgNwTJR6FMkvoExTvT86n9qQgJpBSGW1PEsqUc6SkIBnaCndsBv1WA2ny6q9jbSH6l0NhzBmfsj/
	1K4fPpDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rU6NB-0007tU-1i;
	Sun, 28 Jan 2024 14:43:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rU6N8-0003i8-Vg; Sun, 28 Jan 2024 14:42:59 +0000
Date: Sun, 28 Jan 2024 14:42:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Oh, you re-posted it already...

On Sun, Jan 28, 2024 at 03:06:33PM +0100, Sergio Palumbo wrote:
>      DFP-34X-2C2 is a GPON spf module working at both 1000baseX
>      and 2500baseX.
>      Setting the module to LAN_SDS_MODE=6 the module is working
>      at 2500baseX with auto negotiation see at
>      https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/

Please don't indent commit messages unnecessarily.

Also, good to know what this module *requires* AN with 2500base-X.

However, what mode does this module normally come up in, and does
it reflect the operating mode in the module EEPROM?

If we accept this patch, and the modules normally come up at 1000base-X
we will try to use 2500base-X and the link won't come up. So it's
important to clarify this point.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

