Return-Path: <linux-kernel+bounces-55091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8384B793
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562E61C25B44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C1131E34;
	Tue,  6 Feb 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VG5X2Y3t"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A3131727;
	Tue,  6 Feb 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228923; cv=none; b=CFvwYpsyJ9MTMVG0nz8Z6WLiiEWA3bsixNcg80mu3TKfjVrfALgqpbGEQ2d9WylZ3VoLm0QfSeuWrwCbg3nhrrJ/dOtgKMFxdCx5LiyRkejkZhchR2FS1fHNd/8lGhqgEfBx0bSkfbOzgpZbBHDXBehC06B1YGjFYrgg9o6u3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228923; c=relaxed/simple;
	bh=eDbkObCHYe2dA5zx4FEUZ1qpSNTByRHIYJBIlt2dn4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDzDbbZHzQw7lTsywlYEvlPt1ssOsHnK64RJj85/EV8jNn4tV1ewfmeg7PhUDizMm9gwoKYs5NIIqtTRtyzl9JI0HjthBD3bWbFWrXahGw7X6lco54NKdx8k0fuCIFhnVJW4yJRJ5LayCfqK2CYV3NDVQ+iXLIjYPUvN2fAREaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VG5X2Y3t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vIbBwGKCBr1o0pb8V027f4JDzuee4KE6Li1uf6tax2w=; b=VG5X2Y3tvMuPu/KaXcCTQa5YTX
	3pgQuT6f17QKJXMCIUQPvI3LsUfP933NtaTzcNpOCY3KY2Y7DPwO14jR14I3OXV/qHWfNv4GbZsi/
	mvLEq+hnwRbJVur9K417OHLyzu8RZB8xX7amAGSzoJsr00e8M7mcvBvCfouquLfEMq2jqjMkHgSj6
	WCSZNlOsf8Lrgwzz160gyxwWDKcL31VJX9dpxLSgQ6bDaKfaqFEJIECb3eRN/2P9IWN1OQW33hpfG
	RgyvjD2FZdBzo2HILiFEoYHhlKlshvO5FRbaYmRyHw/b1yH8Xw7owoILeiCdJZqgj1MztnJHW6eet
	jsGhr6cQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rXMED-00025Z-38;
	Tue, 06 Feb 2024 14:15:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rXMEB-0003hM-0r; Tue, 06 Feb 2024 14:15:11 +0000
Date: Tue, 6 Feb 2024 14:15:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Sergio,

I did ask for the kernel messages from a specific scenario:

- host that supports 1000base-X and 2500base-X with your quirk
- SFP inserted with LAN_SDS_MODE=1

What I expet to see in the kernel messages is that the system will
use 2500base-X, and a failure.

You claim that the kernel will link at 1000base-X. There is no
mechanism in the kernel for this to happen, and I believe that
if you look at the kernel messages, this will prove my point.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

