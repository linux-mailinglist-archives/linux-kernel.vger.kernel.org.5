Return-Path: <linux-kernel+bounces-104875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4087D4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75AE283CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8053802;
	Fri, 15 Mar 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D1Cuije/"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE0537F6;
	Fri, 15 Mar 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534020; cv=none; b=X3KF+cya28p5pNUfaOBcAEmdvzugD+9CXFsEtU33tDyfDos0x0Cuv77sJo+QozjvOKu8sMjNO/6qIMS/XqXAWFJD6/rfW8Otw/70iHmcO2JC+PnfcXIxrVJpNZL8hC0acd4r0xq2g/+Tti/eoZIS2dbEuzVdsplhTTNRzNunwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534020; c=relaxed/simple;
	bh=JgeVMSNd7sYZdVWIiKjbcxlxcMfJq7vaoVSUlUpbvZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVKG0iURdkatjUtusHreWfGqJG/z4zzeoa457KcPrQcfIEHTfMFFZCtzi0OMtNZmYLAHvRyxic+EmK4mYtJO305mH51dZkx+XuMc2kdcT5g3MSjY3S9pXDFREbbaD8zZOqhJD8N7SmR+tQNp0dRXm4K8HYBLy0TR1S11cHUCaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D1Cuije/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iYsiZ6pFhsCSAUrF7Xqg/XRmMMh817rVgpmJKV43Zsg=; b=D1Cuije/TM/Mf0nsxWkGbeKxm4
	T2xVMtIzPPugb5wy0q6SMciM5Tz9ydTFryiaolfpkiCzXuzK/KCra+/7V7ptTOEzpNAKNl3D2L5ET
	9X6T+fjghDoAbg+2Ok67pnSUeYGXtyokfYCqvsiw58UJK6wiwGlWtwMxyiNz+Cspblk14SNFqsRGk
	DjQkZLZ0NnFdYRf5wURrufBTA4jHnQlGoQb3p8dr10k0r2D0joaa0ClQdsxX2T12WHwmBAETzE0wR
	Co6Z/1ttorFeVCQy4aMjEwmeIRZ6MiusgZHfQu9vwjRNoyZ9w0HukkRMB/KZ1uvOwYwciQvh++T69
	x1C7wgwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33688)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rlE2E-0001xa-2p;
	Fri, 15 Mar 2024 20:20:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rlE2C-0006f5-4Y; Fri, 15 Mar 2024 20:20:08 +0000
Date: Fri, 15 Mar 2024 20:20:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
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
Subject: Re: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
Message-ID: <ZfSteEmeQX5IUJnU@shell.armlinux.org.uk>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-2-ayushdevel1325@gmail.com>
 <314a88e0-19cd-4b95-9cf3-aef1c7579eec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314a88e0-19cd-4b95-9cf3-aef1c7579eec@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 15, 2024 at 09:09:11PM +0100, Krzysztof Kozlowski wrote:
> > +properties:
> > +  compatible:
> > +    const: mikrobus-connector
> 
> Hm, why do you create binding for the connector, not for some sort of
> controller? Please provide some rationale for this in commit msg.

I think you have a distorted view. I refer you to the Mikroe mikroBUS
specification - it's _just_ a connector which provides a fairly
standardised purpose for each pin and the electrical specifications.
For example of the pins: power, UART, SPIs, I2C, PWM, and analogue
pins.

> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: pwm_default
> > +      - const: pwm_gpio
> > +      - const: uart_default
> > +      - const: uart_gpio
> > +      - const: i2c_default
> > +      - const: i2c_gpio
> > +      - const: spi_default
> > +      - const: spi_gpio
> 
> I fail to see why such choice is related to the connector itself.

This isn't a choice at all. Here's the list of pins:

Analog - AN
Reset - RST
SPI Chip Select - CS
SPI Clock - SCK
SPI Master Input Slave Output - MISO
SPI Master Output Slave Input - MOSI
VCC-3.3V power - +3.3V
Reference Ground - GND
PWM - PWM output
INT - Hardware Interrupt
RX - UART Receive
TX - UART Transmit
SCL - I2C Clock
SDA - I2C Data
+5V - VCC-5V power
GND - Reference Ground

Any data pin can be a GPIO if e.g. a relay board is plugged in, even
if some of the other pins are used for e.g. UART purposes. For example,
a GPS board that provides the GPS data over the UART pins, and the
PPS signal through a different pin.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

