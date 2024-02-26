Return-Path: <linux-kernel+bounces-81299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A6A8673F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE23B281F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB241EB27;
	Mon, 26 Feb 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PezFmYNF"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488F1F604;
	Mon, 26 Feb 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947911; cv=none; b=fkdjfNdWnqpDCgvvmuueeFmm/N5/VmVeVwUoOkcR3TUipws/CkZ41KoG+b0Cm34pKWB08ffksBB+Xg70liUWUcM8LNhVl1NbCL6IJiPxfAeHQKRf/cSs3ednI00u1JsitynSY3KI8/GX6WJZX7ZmLp80RaXtVwFvuZ5sbP3uAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947911; c=relaxed/simple;
	bh=oSvoN8H+rqwZXxcM1Lw/Xnu0f94O0PIpJpGfNO1tV0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhaxxlqD8K5o1HKmNiklNGyx8JWyNDujxycE/f+itHrgEePu93+F88iUqtgBKbAipvMRdfDI1gl1OtfATz/iJ5cEFOssm2cKU3Vel51C/f7G1+8yhrmQgJ3lRyXcJv3GpM7YL7+D5EKIMFFOpzeDQ9cRldA23VwxfpcDfwnYhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PezFmYNF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9fx1xFWIaqHRlfNeLJHhLh9M9CR7/OWd/dFYXNoL+Ak=; b=PezFmYNF0aWQlCCcwDR5gvmKyS
	EUGqdd/VbgmjtliFb/DOVw18XVzEurQjFJ8eTAIpob2O+OMbK2MvTRoVWUu75Ymgjo5A/KmKun7aL
	udU/0WM2b+bRkRRoAMoDH+u/GUelcWWgNGwdJa8Bm1+pzzDKe4IFILa3CMo4yl1eTxw2yWbiqgrf9
	94LyHaEEuLtu6AC63EnjjEoCNUKTUCFmFzG5ZAN5HaJtU/ozRnyEzo004MjlBNe6xBrI20EiLKLP4
	5h0AYbhVPahi0cHkIBfgFpdmCtuMPZZMWbrihIBeU0w1VIP/vtX/GqQolqyMHTwfZXLfOpc6+Obco
	an3Fbp3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41710)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reZPt-00039s-0F;
	Mon, 26 Feb 2024 11:45:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reZPs-0006Oy-3J; Mon, 26 Feb 2024 11:45:04 +0000
Date: Mon, 26 Feb 2024 11:45:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next 2/2] doc: sfp-phylink: mention the
 mac_capabilities and supported_interfaces
Message-ID: <Zdx5v1UXDqsKsjW8@shell.armlinux.org.uk>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
 <20240220160406.3363002-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160406.3363002-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 20, 2024 at 05:04:04PM +0100, Maxime Chevallier wrote:
> +   Fill-in all the :c:type:`phy_interface_t <phy_interface_t>` (i.e. all MAC to
> +   PHY link modes) that your MAC can output. The following example shows a

Technically, this should be "MAC and all PCS associated with this MAC".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

