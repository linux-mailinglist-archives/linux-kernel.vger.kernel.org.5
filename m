Return-Path: <linux-kernel+bounces-104794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56C87D3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D27B22333
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849001EB3C;
	Fri, 15 Mar 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RT9ysCUC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2510A2A;
	Fri, 15 Mar 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527939; cv=none; b=Ax2tcTq+RQoYYZIFqdEf4ZRINFh8SK8Zs86BvF1i144eus+qfc8lxYLpQ8L7DkZPPLt2oH9A5JuCL/LYvPi1lRI/fGG5liuU9MIssIgQJvWN/Z5ZmR4mwnjT+0kUxfWpDUXn6knJC1lVdaFMeBlye5nWXznhAHKzyyv9CIKMdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527939; c=relaxed/simple;
	bh=8Aoo9eOKWnx5Pa08PI7YI1Dgaa4uYs167pxGa5q6eDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipPi0Vr8egnMFnqK+2I0pOCAHw1hZhfp6SGIPzStf0N40PyNCcrAs3yckLfgBm/myOXNVejPRxCDMrT8li0kLVV4CpHlyokW9AYFpnzH5Ws+20TJ6Sa75NaoqD8V0kvhuf0NIeAgmYuVR5In/o/hXbsmoL0793xNXuhIVXjkMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RT9ysCUC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xaGS7BGnjMck/bV5iUN/Gm9lsk2oMymyo55vI3BCLdM=; b=RT9ysCUC1zc0ThZgFdKk+qmWQp
	7y987h3hvq3yuxTdAPi3ycDLp26+qTfQPHcDV02XAYyVEbsntMpNrtaDbD+HLvl3cx9aSiUkHw6bX
	4S/9oaDZu/aZJiquzf35RoxS/66oUoGIoKiRE6dU6Z+/ypPjJJg2EtZVPLwza4CT+bp6qYE55Te8z
	KaRT3rX5GGdARVFwQTPckVK/Q9Ielsiro6iecSsOIKcTFpL2RPeXfJa+JFUMumT6JO5wRtCqaJoZe
	rY2pTjIAPj5dbG/vGnKKd+9xJ8t7OzH9htAyMJF3o8DWMWO1n6mULmXxIazKrmneSg4c/RXjL4LM2
	a3aJUxRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44850)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rlCS1-0001rx-2a;
	Fri, 15 Mar 2024 18:38:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rlCRy-0006aE-6t; Fri, 15 Mar 2024 18:38:38 +0000
Date: Fri, 15 Mar 2024 18:38:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: phy: fix phy_read_poll_timeout argument type in
 genphy_loopback
Message-ID: <ZfSVrge/REaXPF+0@shell.armlinux.org.uk>
References: <20240314164826.161bd398@kernel.org>
 <20240315175052.8049-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315175052.8049-1-kiryushin@ancud.ru>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 15, 2024 at 08:50:52PM +0300, Nikita Kiryushin wrote:
> read_poll_timeout inside phy_read_poll_timeout can set val negative
> in some cases (for example, __mdiobus_read inside phy_read can return
> -EOPNOTSUPP).
> 
> Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
> should fix problems with wrong-signed vals, but I do not see how
> as val is sent to phy_read as is and __val = phy_read (not val)
> is checked for sign.
> 
> Change val type for signed to allow better error handling as done in other
> phy_read_poll_timeout callers. This will not fix any error handling
> by itself, but allows, for example, to modify cond with appropriate
> sign check or check resulting val separately.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed configuration")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

