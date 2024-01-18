Return-Path: <linux-kernel+bounces-29900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C828314E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57561B21DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F07125B0;
	Thu, 18 Jan 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FFAXbHkx"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF400C2E9;
	Thu, 18 Jan 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566999; cv=none; b=Ug2YtFpm0FkvjCE8DY2jXbUYuCI9EzH2hjwHbJce7IR3FbA8f3wchQi4S7MgfETn0HXw48ysaZWt7i1uN7iMZjvX9TmTm9xOMPjuJyq6WXRjzrSJOR6KA8cBsUV9bON2yYHNnxcT9oBUkFgUUe312kRYoijFZwjI1OeVnfapYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566999; c=relaxed/simple;
	bh=9nB0hvJ/9aLf6fDnzN/xsePM/QortmHnFQleCMr1hlw=;
	h=DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Sender; b=ZZFyLhzBy36yGZcTvOnVqRfMdAIiamaPTtKBdrpmnI1YgfQmCT6iQBGq55JyUJySa+TVaCFrsCWd+6HmuTros9W6ELYFl2RWBCZTRAHQM2Jyte2/tp5Gmp/aCBfRaRMgi0VU7IUJu6jUMqWfzvi44ZcBnhetY37ch3YsM2KwGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FFAXbHkx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JlgKP+FPv3esdIvjSP1xwJJg3T/aL8cA5hIPaywX15k=; b=FFAXbHkx35OhEr7iZ/8v5xXeJo
	gaQRtOKk86oVCsINzzaPANYk1qP/G04oEuyAczNG2Ip8dnMy1uENgzUWgGJP5UzJny9bxyv9rswAZ
	N4s6a5J0ddbKcZp0YrmHcInr1EczDn9JYK8+3SQOuslFjVDsrUa5P5YADa/L+YFq+WTbFlJYH8brJ
	HbvH8NWuFC+CTukctlArlV61WRcZc21igWPkUNTg8mat6q7oanmnMaKDLrzyzJuPTb5xLxGScA0Eo
	GceHDR9TEhynQVgbdO6S1wZqYb/TLileSp7N8j8vRNIklMfl+zUoCDy9sEwRYKziVp0I1w39hQNzj
	476cXXzg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQNst-0005VY-1S;
	Thu, 18 Jan 2024 08:36:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQNsp-0005a2-Et; Thu, 18 Jan 2024 08:36:19 +0000
Date: Thu, 18 Jan 2024 08:36:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: mvpp2: Add EEE get/set to mvpp2 driver
Message-ID: <ZajjA6Y4UdX5nGNn@shell.armlinux.org.uk>
References: <20240118015748.3507954-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118015748.3507954-1-elliot.ayrey@alliedtelesis.co.nz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 18, 2024 at 02:57:48PM +1300, Elliot Ayrey wrote:
> Fill in the missing .get_eee and .set_eee functions for the mvpp2
> driver.

This has no benefit without also configuring LPI in the driver.
In any case, you should be calling the phylink functions not the
phylib functions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

