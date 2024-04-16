Return-Path: <linux-kernel+bounces-147229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC318A714C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98219285641
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F571327E0;
	Tue, 16 Apr 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wHhoQ0VX"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856A43AA5;
	Tue, 16 Apr 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284659; cv=none; b=Fusj6dVU8cGlvkg97Tkv5iqH60xSkiWoadcxUwKxYaUO1q0FjhGEQxumjwK87zX7ost+j7llSw39Py8FpFrhdfkFagBvLc3rd7FgA28+u4i243UksU8U6x/oP2IuQunYOmJ0axhmLyjm7pFoDU6eY2jkT/h+5eLoHjZ/5b5W6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284659; c=relaxed/simple;
	bh=LXD6sGC7ShZwC4XuH56juxpwduozJ54f6l/hd3qy1JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCxpBZLfPn1BGN7rpFQM6LE6G2yqZV0g6ZD0afmFqJk1kevR5rdpSaV45e+ii1/68e09ywKeblhfmcsAanzSV8KrJXIInUV2OnIzq83vspApfKDTJ6aZ58WRzZpUAjBHPbfQ0Y38WC7/YqLmtkfUAsMACy/mf9bqZwF+OdDIGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wHhoQ0VX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EafU4aiUFWAg4n1i3C5qywi8YkpDQMqeSo4IU9drGL8=; b=wHhoQ0VXF2dXp8ma/AE6evD/s6
	QEVXU9/p8kWTKdBV3Shx+k2MG3D/KjQLhaz2LvhgEt8nPMFI0CLdeLosUcYNmc7IiNOabqTNbSMP5
	JsTufL2pU2bfBEkEKipN1P5a+w6uGLMe4dooqp/B377ob3gs/hKJq+Y3ZYzYQn+nT60OG1r2DHHTl
	EiaOVAmiKtqKlXDrXTZhRIBMrNbXJk/4nnQv6MIASp7KC9NYA++N+VEKaRIE6/MJpBNI7bQb9fRaK
	DLkrHcHqUENqA8kb3W1e19U44okMRMi4omlnbWejLmCb1fb+9ThQlksB6uh1qwPYtpgGwBRYA69Tr
	pmyRv28Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwlbH-0000et-1X;
	Tue, 16 Apr 2024 17:24:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwlbG-0004yv-9z; Tue, 16 Apr 2024 17:24:02 +0100
Date: Tue, 16 Apr 2024 17:24:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 06:02:08PM +0200, Andrew Lunn wrote:
> On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> > Hi Andrew,
> > 
> > Thanks a lot for the feedback.
> > 
> > On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > > Add a new device tree property to disable SGMII autonegotiation and
> > > > instead use the option to match the SGMII speed to what was negotiated
> > > > on the twisted pair interface (tpi).
> > > 
> > > Could you explain this is more detail.
> > > 
> > > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > > the symbols 100 times when running at 10Mbs, and 10 times when running
> > > at 100Mbps.
> > 
> > Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> > 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> > Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> > the controller. This will work for all three speed settings. However, if
> > we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> > disable SGMII autonegotiation in gpy_update_interface. This is not
> > supported by this Ethernet controller because in-band-status is still
> > enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> > the SGMII link will not go into a working state.
> 
> This is where i expect Russel to point out that SGMII does not support
> 2.5G. What you actually mean is that the PHY swaps to 2500BaseX. And
> 2500BaseX does not perform speed negotiation, since it only supports
> 2500. So you also need the MAC to swap to 2500BaseX.

Yes, absolutely true that SGMII does not support 2.5G... and when
operating faster, than 2500base-X is normally used.

How, 2500base-X was slow to be standardised, and consequently different
manufacturers came up with different ideas. The common theme is that
it's 1000base-X up-clocked by 2.5x. Where the ideas differ is whether
in-band negotiation is supported or not. This has been a pain point for
a while now.

As I mentioned in my previous two messages, I have an experimental
patch series that helps to address this.

The issue is that implementations mix manufacturers, so we need to
know the capabilities of the PHY and the capabilities of the PCS, and
then hope that we can find some common ground between their
requirements.

There is then the issue that if you're not using phylink, then...
guess what... you either need to convert to use phylink or implement
the logic in your own MAC driver to detect what the PHY is doing
and what its capabilities are - but I think from what you've said,
you are using phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

