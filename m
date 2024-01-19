Return-Path: <linux-kernel+bounces-30983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFB832714
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DD01F21C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25D3C473;
	Fri, 19 Jan 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sBiUeN1O"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CEDF71;
	Fri, 19 Jan 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658126; cv=none; b=sNgeoETVe37ELjpm9RWWCiAU8fzdUXnIv8Kb5spxv8KJlztu8UmHhLX6sT298d58v/KCtanMF+Li5axqU7/EGZJ1nn/Oacp1hb9UB6t9kuVIYFLvPNOsVCW4B+AkhzDkT2SXCoi1MQPVe5+stGaYdA7EKeuUA1JJL21ML3Cutvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658126; c=relaxed/simple;
	bh=mk3h3Ak1D/MSdlFcoWM1mR5XrVrcvGJpPegM1H6ZH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1sdHzbpA+Ds4psMlrhAJJKQ8STxJYkPYDIhO+snvAX5SK4ZZOUDf3fGSIelwaMQd6PKhMCekAl9PZ6+Tb0dFibdl1IVFPvAlamZVU8GswGifVHKcXIcgaRlcfJS65QL6bKyIk2FfQE2ro0LTcgpvyO6pyWOeGb0jrpJQf+qAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sBiUeN1O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/xy13IJm0hCibXlfElU7bPt7rRmVaRxryytJUFk5bwE=; b=sBiUeN1O2EETLwuez10JLmY6m+
	vNt2faKE41mtcqQ4gdSPAL2r59ta5WxvRI8e4m6G3BPzLiNy6DK8tElK0tudpUAJz5/BI8x5LyiMM
	kPoMII3fia6buNdICGPKdUhfeDbY5ZYMmDOLx8PvQCXGwO1dtWcKjmL/zLpHs7E3dkKyHdTLWWkRa
	ggwFOfblYoit77Kzh2RVawI/CVzxgBhk4MHFwfoN5OsjbWJh67b9d9euWefnh8HRTpkJqvWLPv6BU
	A+WUkQy4xEbIJX9iYyOdHud5av2OxHaAS2xIlzYTyCYseYA+olESX+JRjvZvDFtZTs+WiJV71S0SL
	YIQVAphA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54556)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQlac-0006Xw-0G;
	Fri, 19 Jan 2024 09:55:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQlaZ-0006Zs-OT; Fri, 19 Jan 2024 09:55:03 +0000
Date: Fri, 19 Jan 2024 09:55:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 2/2] net: phy: adin1100: Add interrupt support
 for link change
Message-ID: <ZapG9x5g0LxgnUO9@shell.armlinux.org.uk>
References: <20240119093503.6370-1-andre.werner@systec-electronic.com>
 <20240119093503.6370-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119093503.6370-2-andre.werner@systec-electronic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 19, 2024 at 10:32:26AM +0100, Andre Werner wrote:
> An interrupt handler was added to the driver as well as functions
> to enable interrupts at the phy.
> 
> There are several interrupts maskable at the phy, but only link change
> interrupts are handled by the driver yet.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

NAK. Previous feedback not actioned.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

