Return-Path: <linux-kernel+bounces-50729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939F847D5A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4171C224D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A512D74E;
	Fri,  2 Feb 2024 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TSwS8A+P"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2B12C809;
	Fri,  2 Feb 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917558; cv=none; b=GIRJ3OLBi5KtUbQxezKnxL3hNGtF64b4HM2W4Fcuvy0RvsAOW3sR+O4n6Qsn5AA6eOvvORmXlKOMDhKWmLtk3z39Uk6MQxBHgUGwS0mYngFS+iBxdb9gmP7R1Fbd/pCcBRv+x8cYXaK6JtK93iOr/c9lWR01eaZnIhZAwhCYc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917558; c=relaxed/simple;
	bh=9buRC9ldDrXvuxhVyglMKfULnlaqWnKfqa2YfBgUcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvKDhBtqISMO7olw/okdXNaGrORlvVPIgUNqmHizvGMiAaZUlngzzj4QDYPupF+HH9aA6DYAivZiUayBThbE7Iatbj++9wMU4gukPfTLwyE4oCYkGZMh/jMHsrKe7AWu5q1wJDBg+PfAPd2s8R6NdNTRx2G5Z01EzPO/ovME3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TSwS8A+P; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g7Pb1IkcGK23Tspia9tCXFn6ISE+4JEdP8pHgIzbMhI=; b=TSwS8A+P0NONYf5Ve437zOz15B
	2x4wAoLnf+lx9yQ6BBSzVMaP1SMYKdgO7pEXYARLm1UYI+8fjWOFegAsoPtracPlNiDkhVV3DtVLv
	c+DDRMCUJb82/v7UJrirV0ykaWIWlM6Z3x6nOrd5SWiPdj5SAXVcAKBEVhyuOPlbh18HPsMqv6GPz
	BzyBXqYesvczbD9MZjhnV2V3fXiMPBEwC91IUFb/lFr9UruwOmOHlk3k6oD7/qzcmsdVr4dZWvbax
	dD4safKmHqwMQzOcv77cM1pevGflv38tYDC/fYfVR4+Kfd+g+5tL6eqk1Ri9Vqova9S52jNZLic9+
	mB1FRCxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43142)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rW3EB-0006bw-02;
	Fri, 02 Feb 2024 23:45:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rW3E8-0000GD-0Z; Fri, 02 Feb 2024 23:45:44 +0000
Date: Fri, 2 Feb 2024 23:45:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 03, 2024 at 12:18:13AM +0100, Sergio Palumbo wrote:
> Hello Russell,
> thanks for your  explanation. I have to say that:
> Module default is LAN_SDS_MODE=1
> Host banana PI R3 supporting 1000base-X + 2500base-X
> I would update the table as follows:
> 
> The current situation:
> Host supports		Module		Mode		Functional
> 1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
> 1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
> 1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes
> 1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	Yes (host forcing module at 1000base-X)
> 
> I suppose that Banana PI R3 host is forced by linux drivers
> at 1000base-X so first two cases should be same as second two cases.
> 
> 
> With the quirk:
> Host supports		Module		Mode		Functional
> 1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
> 1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
> 1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes (module forcing host at 1000base-X)
> 1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes

Your third line is just wrong. Given the capabilities of the host
_and_ the capabilities of the module adjusted by your quirk, phylink
_will_ choose 2500base-X _not_ 1000base-X for that. With your quirk,
there is no way for Linux to know what LAN_SDS_MODE has been set
in the module. Even without your quirk, _unless_ the module updates
the EEPROM contents which is unlikely, there isn't a way to know.

Add #define DEBUG in phylink.c, rebuild and run that kernel. Try
that exact configuration. Report to me the kernel messages.

Adding a quirk that makes it not work in its default state is
technically a regression. We can't know whether people are already
using this module with Linux in this state. Adding this change
potentially breaks users setups.

> I suppose Banana PI R3 forcing Linux drivers at 1000-X when
> module in LAN_SDS_MODE=1 and expect it should work alpso with
> hosts at 1000base-X only in LAN_SDS_MODE=1 and LAN_SDS_MODE=6

There is no way for Linux to know what LAN_SDS_MODE the module is
in.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

