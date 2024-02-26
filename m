Return-Path: <linux-kernel+bounces-81826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A467D867A85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ACB1C28452
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96612BEBF;
	Mon, 26 Feb 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gt1lY/Ce"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E82249F9;
	Mon, 26 Feb 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962157; cv=none; b=ozvTnuZCK1r9JcnSmpu3qkLon/oG+L7fS++w4jk4VhdizpwCdYb/tNCuVLwJTS2KzYl/XXPcZmQt8swTeDcVH7hcaiy3KK/0mVQtJkndkiyXPnRU0L7osDE/v1aEP3bUiJBhHiMoK1j1gpDR0PFfvxbXbJfhE9LyPeru3fEsljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962157; c=relaxed/simple;
	bh=owHJzHKtb9DA5C41QidfsCkm1UnouWrrnWfBZ9MSARM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmL04mnF9H2c1f7wH1jVM2jTu1Sa14XwsBFLJN7qJwHMQ7LxetFgLR94rjlAec+z3MYY7ywVPjattAlKncseitr023tuRt8Qhfml3Vt+zVaueq1YCsP9i4sKTDV4huge+NCJu2mnw/qzTN9nwV5HUuiOEVNmV5aQJM5eh3v2LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gt1lY/Ce; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EHijuvuV8E7YKNM4XdgGmLvPqRAeS9ueLF2rF2XSPaU=; b=Gt1lY/CehqeiCSFuq8QZV2wYJT
	DscO35EA7VMFtgwYNXyD9nOpwpNH3gotKPxK0RGqgMEDYqI6Ch9YS2ejpgp8OC/dxHObyhZuwYiIO
	xNMj9DGZ9PFFkN73BWAPqkmGzXVzWfVegL2GkXJsS4/U7GPjCWpCTijU9oXnHErFpatoS/L8iCUch
	h2mxOnxEqe4FLvRxVhSJurF+uJxQDd4Ab2oKGluj6bQRHieZ1ndEHSSBtGFT9Ppct9UH1SFx4Q1eq
	zBfvA+2odehQbByPQqHslkOHaOgJMLxdOIBeeonUL9P/wWhSK5HUptSetS8T/Rn/wzPuArg/1cIrg
	3L2X0kdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57664)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1red7Z-00043V-29;
	Mon, 26 Feb 2024 15:42:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1red7X-0006Y2-8B; Mon, 26 Feb 2024 15:42:23 +0000
Date: Mon, 26 Feb 2024 15:42:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 10:51:36PM +0800, Shengyu Qu wrote:
> Hi Russell,
> 
> 在 2024/2/26 22:39, Russell King (Oracle) 写道:
> > On Mon, Feb 26, 2024 at 10:16:46PM +0800, Shengyu Qu wrote:
> > > Hi Russell,
> > > 
> > > > On Mon, Feb 26, 2024 at 09:23:46PM +0800, Shengyu Qu wrote:
> > > > > ODI DFP-34X-2C2 is capable of 2500base-X, but incorrectly report its
> > > > > capabilities in the EEPROM.
> > > > > So use sfp_quirk_2500basex for this module to allow 2500Base-X mode.
> > > > This was previously submitted by Sergio Palumbo, and comes in two
> > > > different forms - an OEM version and non-OEM. There was extensive
> > > > discussion about this, and the result is that I'm not accepting this
> > > > quirk for this module.
> > > > 
> > > > The reason is that the module _defaults_ to 1000base-X and requires
> > > > manual reconfiguration by the user to operate at 2500base-X.
> > > > Unfortunately, there is no way for the kernel to know whether that
> > > > reconfiguration has occurred.
> > > No, In the firmware of this stick, the speed rate is configured to auto
> > > negotiation rather than fixed 1000base-X.
> > 
> > How does this "auto negotiation" work?
> > 
> > I mean *exactly* how does it work? How does it know whether the host is
> > operating at 1000base-X or 2500base-X?
> > 
> > There is *no* inband protocol to allow this to be negotiated.
> > 
> Well, that seems some kind weird trick implemented in that chip's SDK (maybe
> hardware?). It would automatically detect the speed rate that host uses and
> switch to that rate. The system log of the stick shows that.

This sounds racy - between the SFP detecting the speed of the host and
the kernel code reconfiguring the interface. More details please...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

