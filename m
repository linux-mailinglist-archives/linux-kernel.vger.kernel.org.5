Return-Path: <linux-kernel+bounces-31263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB42832B62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F472B217BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDC53810;
	Fri, 19 Jan 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iC3gOgtT"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C9524C8;
	Fri, 19 Jan 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674843; cv=none; b=dEMWmvj6kiBd7NJQoxG0TYJ+JvIVgyO9vyTwXbPoesezekppb6ZDi5cIj1c/2Vu7Ch7sXbswqJArXxb7w1wWkdz9WKQV5FPupz2DqupbX9UCPy1BwlA7mf6GP57coMcYXQte7s6Q+TG8XNH3q+ZWLJjuVlckOpOSUmEoBO2Sny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674843; c=relaxed/simple;
	bh=ApAURFbaKwhO/5kE7JG5AbjfTYMpGMLoDzJEXbOZb18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnVCFW59pAz3fV3Ib2IPoDAAmaSw9sQfSM9GY6zalWwx6xkqDCiAGF0/tLX+eGt1/yp6bzO2RcS/ifpAxciVgV1Ly7rEyLdy9J5+7hWAj1+xlviZVn3cdYx+kV5zUZPUQOMK9gGIm9UYbBvkoPcv3/k0p/HK2Q/37AqGfUZnolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iC3gOgtT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NRMxyhyKCnq4lJJfksQu/hh6wttVDZUbD6dXln6VFMc=; b=iC3gOgtTcOXBmFznTlxc02zoHj
	nn7DiZRggcMRGUJqDF8CATRQGXr0nQ8JQCwWkzNLVsEDTBO3CcDXHLZNledGDrofl2rgo0Anme3cu
	EwsHAlzDEXmvgx1tBh9BO//p1AS8eR+VYmTAxtCu+HzNN/8qw8nsHyC7qxu8+pXEV0JCa1eMMhiCW
	NHcwLnwFAxJ0qCRS/SqVQ97OeMt4rN7u+qiVKLl3b3qO67zlz0HpA8FxniWAHRi8FBOn5K+tC5bpH
	FparWwQYOYFO8OB8NfLFguMHoLEs/W6wYn2VDKPqdJ/3CW3gMztilcbkeTXhLhYkUdkqaQk/Ndk6v
	Be19dZ8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57676)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQpwD-0006oA-1P;
	Fri, 19 Jan 2024 14:33:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQpwB-0006jZ-L6; Fri, 19 Jan 2024 14:33:39 +0000
Date: Fri, 19 Jan 2024 14:33:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Message-ID: <ZaqIQ7X4/iI3jxtU@shell.armlinux.org.uk>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
 <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
 <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
 <24c24b0b-da49-4452-b6ad-64c4c2d20e11@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24c24b0b-da49-4452-b6ad-64c4c2d20e11@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 19, 2024 at 01:46:26PM +0000, Josua Mayer wrote:
> Am 19.01.24 um 13:07 schrieb Josua Mayer:
> > Am 18.01.24 um 17:07 schrieb Russell King (Oracle):
> >> On Thu, Jan 18, 2024 at 04:01:10PM +0100, Josua Mayer wrote:
> >>> HummingBoard has two RTCs, first integrated within SoC that can be used to
> >>> wake up from sleep - and a second on the carrier board including back-up
> >>> battery which is intended for keeping time during power-off.
> >>>
> >>> Add aliases for both, ensuring that the battery-backed clock is primary
> >>> rtc and used by default during boot for restoring system time.
> >> Given that the snvs RTC isn't battery backed, should we even be enabling
> >> that in DT?
> > In imx6qdl.dtsi it is not disabled.
> > According to Jon it is useful because it can wake up the soc from sleep,
> > whereas the external rtc can't.
> >> Also, have you seen any issues such as:
> >>
> >> [    0.933249] rtc-pcf8523 0-0068: failed to set xtal load capacitance: -11
> >> [    0.933505] rtc-pcf8523: probe of 0-0068 failed with error -11
> >>
> >> which seems to be exhibiting itself on my SolidSense board?
> > Not on my HummingBoard Gate Rev. 1.4., but indeed on my solidsense
> > unit too, which is probably same age as yours.
> > Only tested imx6dl-hummingboard2-emmc-som-v15.dtb,
> > but solidsense one should make no difference.
> 
> I was reading control registers 1-3:
> debian@sr-imx6:~$ sudo i2cget -y -a -f 0 0x68 0x00
> 0x00
> debian@sr-imx6:~$ sudo i2cget -y -a -f 0 0x68 0x01
> 0x00
> debian@sr-imx6:~$ sudo i2cget -y -a -f 0 0x68 0x02
> 0x04
> 
> ^^ This means low voltage on back up battery

Interesting - in my case, the solidsense has been powered on for months
(it's my internet router on the boat).

I've rebooted it again today, and this time it seems to have been
successful, and is using the time from it.

> After a few power-cycles that error went away.
> Why pcf8523_load_capacitance would ever return EAGAIN I don't see.
> 
> In any case now that probe succeeded, I read these values:
> 0x80
> 0x00
> 0x04

For me, after the last reboot, they contain:
0x80
0x00
0x08

> Long story short I don't think the EAGAIN during probe is related
> to adding aliases.
> HOWEVER imo pcf8523_probe should return an error when
> pcf8523_load_capacitance fails.

I think the real question is where is the EAGAIN coming from and
why.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

