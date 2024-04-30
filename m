Return-Path: <linux-kernel+bounces-164477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6838B7DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8EC1C236FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A9181CEA;
	Tue, 30 Apr 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FCluwWN2"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5622172BC6;
	Tue, 30 Apr 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496118; cv=none; b=HzvwWyVK1QThnujUqlu3XFnCHEw5yPkDGixHrWSlx0qFDEaEXoNXcQtif3YLN5sturdxgMeFCcoTERN+ayjCjibSoaI10ES4rsw+i+qeRSzzWRzcdj8Nd1E4oyL/oNrRHaH5z1NigBx3V6naZqI3NZh9/GB1xPYSq1y+p77m4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496118; c=relaxed/simple;
	bh=q3Mtcb6WTFm/fPnOFpVQ3lGozboE4nEg4ZQJAN/Eyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx5UYfGS+zdsnqBDKR78qIAgA1ZX4RWwCLZj2nLZG9SJPiOGIu3h9PlVh9zleNhdGmwJBdP7mty7VowFiBIUXd2e/5NCBsitoAkHR9yoQxWhAJ5uC13NDxjr4DsGpVrCm0t29d2fNOWiSALYaTpr0L/LUN5MTji8UApPIH1D6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FCluwWN2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RF9yx8dTNGWVZHPM8PUtYI0D1E5HGDUZkzK1++mcdwU=; b=FCluwWN2Ckp2/t1F/WFJTNugMa
	31IRpdp15lFyJxOmLoQ87R+QNmwE1ssWWbCDrOrZjEj/P8bwVM0lsNKkDZhvjs5EWJ8AVC9uSjkq8
	5VTYm83DHJZ/0hGxk24xFOB7/UvOq55DPg1JAewszQy+IyBdzGKvDfeMdVr7yjl/bAFoVTk6Ndg8O
	egGcaH8cXhZmHrmrl7Ma/vSSAUXJQpUekrJaxM8cSpTT+/sPMWKSBE3YsYdf0BJrLXn2apFrrgukF
	wSit8t68UcHLmYj6ySsfoC/quX277Hmya/8sieUR25WoRxI4TgLbNKeEtIhycDarXHKqUuZ1k/1mJ
	r59T76OA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36096)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1ql2-0005Hu-0y;
	Tue, 30 Apr 2024 17:55:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1ql1-0001vZ-Bf; Tue, 30 Apr 2024 17:55:07 +0100
Date: Tue, 30 Apr 2024 17:55:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/2] net: dsa: adjust_link removal
Message-ID: <ZjEia+20WfldXpMn@shell.armlinux.org.uk>
References: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 30, 2024 at 09:48:14AM -0700, Florian Fainelli wrote:
> Now that the last in-tree driver (b53) has been converted to PHYLINK, we
> can get rid of all of code that catered to working with drivers
> implementing only PHYLIB's adjust_link callback.

LGTM. For the whole series:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

