Return-Path: <linux-kernel+bounces-92295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756A871E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97261C22407
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11B5813B;
	Tue,  5 Mar 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z70saEw0"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37895490D;
	Tue,  5 Mar 2024 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638624; cv=none; b=toDemnPCqlvbiUZX9M/Y24kmlGrzTxslgOux/t/9srwPy8aJoYqjbZxMU1SP7dceuBdQCAViIRrtenGsYz347Ckt82RT1Z/ffTCy1W+njMyaaB4nyF7huCb31KzDrNeNxVfN1ozO+wVEWaCAZzTAOvIQlVoONZsovPXR0YXHLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638624; c=relaxed/simple;
	bh=3ayW0IhTUeNMcpww5PHJsnIajeFZZT9ny2n8rBMH1eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azTM0TaKKQbCiYPdv0FlZhp9AQR6iiLKOs2/2DnrwblSXXQVOemYtvb0Lx/zAYltp3v5mUSD+DzdUPSNPBrnuDcMc49iDgu83FYtHrmZcUOMb1sPrCLAQbSMDQ8A4Nu7hu1UOJ7TMBNeTG/tYfcL79oEMqJxbWAN9qFHRltV0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z70saEw0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IrDqOCAVFnIywCjY1vOYOH9E3WkzoSBd6y1AwGw2QPk=; b=z70saEw0Uyr9DpMfHt0qmGvV1r
	IOgrK0UzVt4WJkKKwAMA6Z+nNottmESro61dl/j3LTnq31i1c+asqMGnwzPAvYM72RaYzTTEbC3yb
	lTUOsmvv2A3qnseBp+jV3aRZ0ZBtoU4We8+GxzKqDQtZguiRW3k53w60f8sbwQflPkz/Dj2E5bh/O
	o/gQMWYUgydc8kAI++cxof0gKS0uuMSLzTM6nhNeyQJy1J7nTLoSuBjJ+KeF7Zv8sF9hGnxj37P7H
	tct7YVX5TePcXBQ2NDbPInfBNBTBvsZiQ8DOJK287YDCFLkUml+LdV4SmIO7NyF6+oKRs5pXeoTtf
	Ux9MzmpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhT6J-00073t-1k;
	Tue, 05 Mar 2024 11:36:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhT6D-0005NL-BL; Tue, 05 Mar 2024 11:36:45 +0000
Date: Tue, 5 Mar 2024 11:36:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v3 0/9] MT7530 DSA Subdriver Improvements Act III
Message-ID: <ZecDzbAMrXgMG72Z@shell.armlinux.org.uk>
References: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
 <81a5d191894e6a7741d3c266079f3404def2bb07.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81a5d191894e6a7741d3c266079f3404def2bb07.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 12:30:20PM +0100, Paolo Abeni wrote:
> On Fri, 2024-03-01 at 12:42 +0200, Arınç ÜNAL wrote:
> > This is the third patch series with the goal of simplifying the MT7530 DSA
> > subdriver and improving support for MT7530, MT7531, and the switch on the
> > MT7988 SoC.
> > 
> > I have done a simple ping test to confirm basic communication on all switch
> > ports on MCM and standalone MT7530, and MT7531 switch with this patch
> > series applied.
> > 
> > MT7621 Unielec, MCM MT7530:
> > 
> > rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
> > gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb
> > 
> > tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000
> > 
> > MT7622 Bananapi, MT7531:
> > 
> > gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb
> > 
> > tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.uboot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000
> > 
> > MT7623 Bananapi, standalone MT7530:
> > 
> > rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
> > gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb
> > 
> > tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000
> > 
> > This patch series is the continuation of the patch series linked below.
> > 
> > https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com
> > 
> > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> @Russell, I see you went through some patches; my understanding is that
> there are no objection to this series in the current form. The series
> LGTM, so I'm going to apply it: I think it would a pity if it should
> miss this cycle.

That's fine - I did read through the entire series, but only gave my
r-b on the ones I felt I'd done a good enough job on. You may have
noticed I haven't submitted much network stuff this cycle... I have
limited bandwidth at the moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

