Return-Path: <linux-kernel+bounces-104932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF487D60D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FD11C21310
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4954901;
	Fri, 15 Mar 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b3Y4ofKL"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFE1DA5E;
	Fri, 15 Mar 2024 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537586; cv=none; b=m8r3x2zX4qTHrkLUKegUIt8f8eG4q3edByHmGNpkHu+LunlJwOgINzI48IMTMcr6xfpwFhbx177hAwc0qPm3bejXPv2msArLjdOsUlK9IlJVBmb+nxc5HGBS3R4o3VwxxNokRucXvSXVmw7ynt1payXseb6jVDISJYvpyYGvaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537586; c=relaxed/simple;
	bh=hHtgEr/5VMXCz8vuPkp/Mit3mZ//jYLgkBhhrYiMYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkMHrRPcMYFCz1pNZ7BIf3ZEbll0C0pwNq0gkbiwidIR7201LodUhHQ/1rXlblGDJ8KhQRgF07QMMrVoZcr9QPqZD/R6UTGHW30iwkYKS5XlndYIJwwmB8YNofm/WdMtgC1tmiE2svphXNjwceKS0rCir9fyJ3iMiMQMDMrTWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b3Y4ofKL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o1YIiWKWxJNDdSzsWJzaL07fe51Di6mSo9Y2mM7H6Io=; b=b3Y4ofKLZ9KN4+FKDyOeexkEK7
	ozRPcoV4wiTdmBXClQmxRHZ0NGGlWJPcAyCC2YHX1uMGzq8qGZt4vXBd1WNaCF3WCQFDd3z88gktJ
	848Xkq/rVoOXc3VOISf9mQtyo3axW/LQAB36CI5cs/Aajp0UG71emubX+s2vPGLyMvnQllPyd5EB/
	LrFiCPXGk5GdlT1xvKfqwDmi50pzKrFvG4zCenPj6t9AlNLD4Z3ymd4oXyNpjmVpnEKNCMNTM9TRA
	0mFcmkxPmex71LMYqFbAJdvjWc76IcKuXVMZvAZ/fySLgaOZWkzUVqZhLR4o4D4f6C82hAj9S9Cuh
	mlNUKnSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rlExj-00022E-2D;
	Fri, 15 Mar 2024 21:19:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rlExh-0006iE-Gw; Fri, 15 Mar 2024 21:19:33 +0000
Date: Fri, 15 Mar 2024 21:19:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Message-ID: <ZfS7Za/KITnQiYjh@shell.armlinux.org.uk>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
 <ZfSiaT9WltBDY9yD@shell.armlinux.org.uk>
 <46ba778a-5966-4b99-b820-f0d047a56227@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46ba778a-5966-4b99-b820-f0d047a56227@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 16, 2024 at 02:17:24AM +0530, Ayush Singh wrote:
> On 3/16/24 01:02, Russell King (Oracle) wrote:
> 
> > On Sat, Mar 16, 2024 at 12:19:05AM +0530, Ayush Singh wrote:
> > > diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
> > > new file mode 100644
> > > index 000000000000..f0770006b4fe
> > > --- /dev/null
> > > +++ b/drivers/misc/mikrobus/Kconfig
> > > @@ -0,0 +1,19 @@
> > > +menuconfig MIKROBUS
> > > +	tristate "Module for instantiating devices on mikroBUS ports"
> > > +	depends on GPIOLIB
> > > +	depends on W1
> > > +	depends on W1_MASTER_GPIO
> > > +	help
> > > +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> > > +	  board socket standard that offers maximum expandability with
> > > +	  the smallest number of pins. The mikroBUS driver instantiates
> > > +	  devices on a mikroBUS port described by identifying data present
> > > +	  in an add-on board resident EEPROM, more details on the mikroBUS
> > > +	  driver support and discussion can be found in this eLinux wiki :
> > > +	  elinux.org/Mikrobus
> > I think this is a fallacy. I have boards that support Mikrobus - some of
> > the SolidRun products do. I have several Mikrobus "click" boards.
> > 
> > This help text seems to imply that Mikrobus click boards include an
> > EEPROM that identify them, hence you make the support for mikroBUS
> > depend on it. No, this is not the case - the click boards do not
> > contain a 1-wire EEPROM.
> > 
> > Please fetch a copy of the official Mikrobus specification which is
> > available here:
> > 
> > https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
> > 
> > and rather than creating something that is implementation specific but
> > appears to be generic, create something that is generic with
> > implementation specific extensions.
> 
> I think you mean mikroBUS addon boards? mikroBUS is an open socket and click
> boards™ are MikroElektronika’s brand of mikroBUS™ add-on boards.

MikroElektronika _owns_ the standard for mikroBUS, they're the ones
who publish it and it has their logo plastered all over it.

> So I think
> all click boards™ do have clickID support, but yes, mikroBUS spec is not the
> same as clickID and thus are not mutually dependent.

None of the MikroElektronika "click" boards that I have (and thus
officially produced boards) have any ID EEPROM on them, so your
statement is false. For example, if you look at the "relay click"
board schematic:

https://download.mikroe.com/documents/add-on-boards/click/relay/relay-click-schematic-v100-a.pdf

you will find no EEPROM.

The "relay 3" click board also doesn't:

https://download.mikroe.com/documents/add-on-boards/click/relay-3/relay-3-schematic-v100.pdf

However, the "relay 4" click board does:

https://download.mikroe.com/documents/add-on-boards/click/relay_4_click/Relay_4_Click_v100_Schematic.PDF

Now, ClickID is relatively new. Note that the mikroBUS standard dates
from 2011, with v2 coming out in 2015. A blog post introducing ClickID
was posted in November 2023, just some 5 months ago, so that leaves an
awful lot of click boards out there at the moment which have no EEPROM
on them.

If what you have written assumes that all click boards have this EEPROM
then you are - in my opinion - intolerably constraining the usefulness
of your idea for those of us who have click boards bought over the past
few years, and this will confuse users who have these older boards.
"I've enabled mikroBUS support in the kernel, but my board isn't
recognised" will probably end up being a regular cry from people with
this.

So, I think you need to consider how to support the already vast number
of click boards that do not support ClickID.

At the moment, my own personal solution is currently to hack the
platform's DT file for the board I wish to use, creating a new variant
of the platform which configures the SoC so the mikroBUS connector pins
are appropriately configured. It would be good to get away from the need
to do that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

