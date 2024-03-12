Return-Path: <linux-kernel+bounces-100590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE9879A87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1974C1F21EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5381384A8;
	Tue, 12 Mar 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z0vu9EUV"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D980137C5A;
	Tue, 12 Mar 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263945; cv=none; b=MqegrwEHXlmJAEXZao0hCz2GSPBw+zBWlhNrelDc4cSizGrnW00+LBuoJ912WGqWYxeQh9/NYEtAaKf7UYuQhNjI/faNrdq2ijppsEBJcJfgkSNtsvR4USareQ5/blS57aDVzG4A1X7VgmsulUCksHrliPT+yS2WsePu3A8OXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263945; c=relaxed/simple;
	bh=bp3DPapmLXS9Ig/m12t4o90H2TRiUcDtfkduFK1MMjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2c+yKwkO8M0bIiNxR1Yt32sxBsisHbfJ+jL3/k287WRPBSKXff0RpoxKStMfQm4LvWFAddIIkzUk+5/10I7yEncNjX0Opz5bgz9eLhYs7r//XmICujg2DJ40a/Gbha/BqhvGe15TNe7uSRmu712yFIIJknuyWxBXfyUzaTCa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z0vu9EUV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q3wlt+VAJLwYZMvvvsupUuGC/FaDNVJETwt8qAhUif0=; b=Z0vu9EUV9RylD3PZqkvmkGc6jL
	dRHDaikwOZFuJ0VTPDAKAhUf7XFq9KEx0NijUIbcR02TiC09ZxWGR0xG+g9Tj8Tuz0rBAvwONr9/r
	N+eFNQ5fbE+pOH5srUiYscLkIaiZYmIqbom5Xb+sT3Xzlm5ZsgFPrgdUxrkc9w/csuRloepqZLo/D
	p+gbaZfy7gIctkJTm6uD45I+FZCItWiekuK6sxy1bC2PR13yuamBbaDjYzjkaFPnK3Ox4bnU4fxlk
	8Voz3DRCYpF1i7TdpXpvlR3JVU6CPZVQv6sQCN0utzq4g9RpW4j51RsYQ9Lzo3A50XNJweFxrGjpB
	j+efElHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rk5lz-0006mM-25;
	Tue, 12 Mar 2024 17:18:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rk5lv-0003ih-Ue; Tue, 12 Mar 2024 17:18:39 +0000
Date: Tue, 12 Mar 2024 17:18:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Doug Berger <opendmb@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
Message-ID: <ZfCOb4x/+41y+SW3@shell.armlinux.org.uk>
References: <20240312165358.7712-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312165358.7712-1-d.dulov@aladdin.ru>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 12, 2024 at 07:53:58PM +0300, Daniil Dulov wrote:
> The expression priv->clk_freq * 2 can lead to overflow that will cause
> a division by zero. So, let's cast it to unsigned long to avoid it.

How does casting this help? "unsigned long" can still be 32-bit.
Maybe unimac_mdio_probe() should be validating the value it read from
DT won't overflow? I suspect that a value of 2.1GHz is way too large
for this property in any case.

https://en.wikipedia.org/wiki/Management_Data_Input/Output#Electrical_specification

(note, this driver is clause-22 only.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

