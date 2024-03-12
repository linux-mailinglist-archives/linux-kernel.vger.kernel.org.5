Return-Path: <linux-kernel+bounces-100719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8C879C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50802823CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D13142651;
	Tue, 12 Mar 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kOEdfTja"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808123A6;
	Tue, 12 Mar 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272554; cv=none; b=T4hrfiQF/ToRL3i1fJV0Sdw/TanshCiOIwHJsM8wO4F2ecE/zux3UZux0NCLZEZLvIdl9WXEpKSK8WZ1MfjZx3k9wBP8zs7vwNpjfF0FmLfedYC2CKDFldg4HZLmn5EqFsbkslDS6PCWv+V+ss2Xh+NNd2fpgbOXpyu7AnnWwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272554; c=relaxed/simple;
	bh=68ALfO905AYUlS53YoIMyGx+1CjoW/ERgDY1HwnqKyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osypJZP+/FgeYKj1ELwZOBg02s2rADZiVntSjz84cNNxcVqGN187CL0lgjehal4S0YLIkJvVLmh+6M8eIYj29TeauZ6WXjWvCZdN4G1IJXwSKPD9tCwkLanSxSTFDlK6vRjurfuJ23j1Kp+LskrxkZmg7YI7OcIOWpMw7Y8cvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kOEdfTja; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jQDsOwuAAPx1Ek5GFlKu13YSBeA1J7htLKf6fXH4K/4=; b=kOEdfTja/SP3czPoQDuH0Qgb6y
	XXOoFSOI3Zrr7xGIO2sqKJXsFgSUzyS/XcDM/fJgvHhHWF1eQLtUm1B9HOJkWQPKcvl59nhYiXoSq
	XpM5qLdNVROYUvoDHkhYfaScouzQsPs0oAy2dW0VgYIs9mhiVUeNzH0zb5YpkUo4VM7TjiZObP3Rw
	I1c6CKXVS5RCVzFf7m3GCd/45VS4TYG4i7uMlrBSbhw9g6yFi4u+gsSCJ7enu+PigdMO+8/tHEIAl
	oBbvMVJnSY94YJXXsswkIsplMCqakeXbNPUBP8yVPHtLV35SVGaRBU0K2TwduWP9VW/DRmz/BBpy7
	8cnsIKmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rk80y-0006vH-1d;
	Tue, 12 Mar 2024 19:42:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rk80u-0003oA-J8; Tue, 12 Mar 2024 19:42:16 +0000
Date: Tue, 12 Mar 2024 19:42:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Doug Berger <opendmb@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Daniil Dulov <d.dulov@aladdin.ru>, Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
Message-ID: <ZfCwGF3JRiFdJ353@shell.armlinux.org.uk>
References: <20240312165358.7712-1-d.dulov@aladdin.ru>
 <ZfCOb4x/+41y+SW3@shell.armlinux.org.uk>
 <df295be9-d33e-45d2-914f-c9c1554e5ac0@gmail.com>
 <b1acf9d0-872c-487a-9938-6d667959d0d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1acf9d0-872c-487a-9938-6d667959d0d3@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 12, 2024 at 12:23:20PM -0700, Doug Berger wrote:
> On 3/12/2024 10:23 AM, Florian Fainelli wrote:
> > On 3/12/24 10:18, Russell King (Oracle) wrote:
> > > On Tue, Mar 12, 2024 at 07:53:58PM +0300, Daniil Dulov wrote:
> > > > The expression priv->clk_freq * 2 can lead to overflow that will cause
> > > > a division by zero. So, let's cast it to unsigned long to avoid it.
> > > 
> > > How does casting this help? "unsigned long" can still be 32-bit.
> > > Maybe unimac_mdio_probe() should be validating the value it read from
> > > DT won't overflow? I suspect that a value of 2.1GHz is way too large
> > > for this property in any case.
> > > 
> > > https://en.wikipedia.org/wiki/Management_Data_Input/Output#Electrical_specification
> > > 
> > > (note, this driver is clause-22 only.)
> > > 
> > 
> > Had commented on the previous version (not sure why this was not
> > prefixed with v2) that the maximum clock frequency for this clock is
> > 250MHz, the driver could check that to prevent for an overflow, most
> > certainly.
> 
> Could also use:
> -	div = (rate / (2 * priv->clk_freq)) - 1;
> +	div = ((rate / priv->clk_freq) >> 1) - 1;
> which is mathematically equivalent without the risk of overflow.

What's the point when the maximum clock frequency that the driver should
allow fits within u32, nay u28?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

