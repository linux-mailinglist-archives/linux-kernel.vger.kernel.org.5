Return-Path: <linux-kernel+bounces-104848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8387D47A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126CB1C2207F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6552F85;
	Fri, 15 Mar 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RLU+jv1w"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8515336A;
	Fri, 15 Mar 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531196; cv=none; b=KCYpNbgBLYyLfUDOdfszNL8u/jXl+ZaoibKKkVLLTdA4T+QWTn6vJDQ9nzmu+NJPB3AMOZNHjW+f9KWWGA6mwigH+57VOo1kEklhWpHIn1x2/Cjnk0tk0U7WF4qh+RyNKJ+hNqAB1kTM2631JhN7QxATv5CKxUqI94rdlpyIJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531196; c=relaxed/simple;
	bh=eRsl8Rg+OC8BZqUKmC9kI0hyVdWty+mH75K6LNFjvDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQJ0J2j9Oz5YWVBTPUEGvs3jaLMIldnoGjERqXsTYZh+onzUHDL2kxHlkABBQKA2OhPbFyaKvpNvR2BETLMyZX0nyzevDQyb7k8KsiehPdfx413FI9BNE37devulnC9mdrXdkaOuCpaBlFGx4ytB5BGE+U9IWo4x71nn5Sif0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RLU+jv1w; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f0Ij9Ng3qFlKHBcCYFWC7NUcoSVwuVabrhGU+kT7tbo=; b=RLU+jv1w7ZdSAxv++3QgRTZbWf
	4vjrKzoM0i/woxMVS/lsbrXobofT40yChxO9gTsZcRbj3GLv94jEbzhmabLFiEIhMTKotsJOLI3Se
	xus1fCT3ykkOk8OL6p3h5vchYrpDaWO4hGigLfKlc86mFK9hK1F+DlLbdu3dHg2DzKbnFOFpVBjUB
	O51jrli51xcMZVAcWUgRrmdTTN159H/KSwvXrP25gEzjL1vcwgiQOkbCdlGIJYTKA7trqp741apPO
	q0ULoeCjbRyVtJR54Bk9m52c1gYlC9PMeEsTlVx8rXRTp6gTAAJphFyrJ26G8RDGvMbzDSqLmQ2Se
	NUMKVsqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59454)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rlDId-0001uq-28;
	Fri, 15 Mar 2024 19:33:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rlDIX-0006d1-OV; Fri, 15 Mar 2024 19:32:57 +0000
Date: Fri, 15 Mar 2024 19:32:57 +0000
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
Message-ID: <ZfSiaT9WltBDY9yD@shell.armlinux.org.uk>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-8-ayushdevel1325@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 16, 2024 at 12:19:05AM +0530, Ayush Singh wrote:
> diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
> new file mode 100644
> index 000000000000..f0770006b4fe
> --- /dev/null
> +++ b/drivers/misc/mikrobus/Kconfig
> @@ -0,0 +1,19 @@
> +menuconfig MIKROBUS
> +	tristate "Module for instantiating devices on mikroBUS ports"
> +	depends on GPIOLIB
> +	depends on W1
> +	depends on W1_MASTER_GPIO
> +	help
> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> +	  board socket standard that offers maximum expandability with
> +	  the smallest number of pins. The mikroBUS driver instantiates
> +	  devices on a mikroBUS port described by identifying data present
> +	  in an add-on board resident EEPROM, more details on the mikroBUS
> +	  driver support and discussion can be found in this eLinux wiki :
> +	  elinux.org/Mikrobus

I think this is a fallacy. I have boards that support Mikrobus - some of
the SolidRun products do. I have several Mikrobus "click" boards.

This help text seems to imply that Mikrobus click boards include an
EEPROM that identify them, hence you make the support for mikroBUS
depend on it. No, this is not the case - the click boards do not
contain a 1-wire EEPROM.

Please fetch a copy of the official Mikrobus specification which is
available here:

https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf

and rather than creating something that is implementation specific but
appears to be generic, create something that is generic with
implementation specific extensions.

You'll find if you search that document, no mention is made of an
"eprom". "identification" is also not found. "one wire", "onewire",
"1-wire", "1wire" are also not found.

What I'm concerned about is if we create this "Mikrobus" subsystem
which appears to be dependent on one-wire EEPROMs somewhere in the
system, and then end up with a load of drivers for various mikroBUS
boards, what about cases where there is no one-wire EEPROM?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

