Return-Path: <linux-kernel+bounces-12876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549A81FBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB24328356D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0C10A18;
	Thu, 28 Dec 2023 23:25:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DD1097C;
	Thu, 28 Dec 2023 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id EECC2100D9410;
	Fri, 29 Dec 2023 00:25:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B66B4232130; Fri, 29 Dec 2023 00:25:11 +0100 (CET)
Date: Fri, 29 Dec 2023 00:25:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"brenda.streiff@ni.com" <brenda.streiff@ni.com>,
	Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <20231228232511.GA19291@wunner.de>
References: <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
 <20231221155305.GA13673@wunner.de>
 <f41f5ddcb52140b6a579043a5abce751@dh-electronics.com>
 <0ec4c423-3d18-4a29-b78e-938366ece117@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec4c423-3d18-4a29-b78e-938366ece117@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Dec 23, 2023 at 02:40:58PM +0100, Lino Sanfilippo wrote:
> On 23.12.23 13:49, Christoph Niedermaier wrote:
> > From: Lukas Wunner [mailto:lukas@wunner.de]
> > Sent: Thursday, December 21, 2023 4:53 PM
> > > Well why don't we just allow enabling or disabling RS-485 termination
> > > independently from the SER_RS485_ENABLED bit in struct serial_rs485?
> > >
> > > Just let the user issue a TIOCSRS485 ioctl to toggle termination even
> > > if in RS-232 mode and use that mode for RS-422.
> >
> > Sounds not bad. The termination should only depend on whether the GPIO is
> > given or not.
> >
> > Irrespective of this, I think the Linos idea of an RS-422 mode is not bad.
> > This allows you to take care of special features that were previously
> > overlooked. For example, hardware flow control can be switched off so that
> > this does not cause any problems.
> 
> Also note, that RS232 and RS422 may NOT always be the same from driver
> perspective.
> Take a look at 8250_excar.c for example. That driver has to configure
> the hardware accordingly when switching from RS232 to RS422
> (see iot2040_rs485_config()).

Actually it seems there are a bunch of GPIOs on the IOT2040 board
(called MPIO instead of GPIO by the driver).  See the documentation
of the wiring at line 87 in drivers/tty/serial/8250/8250_exar.c.

So "configure the hardware" seems to just boil down to toggling the
right GPIO (aka MPIO) pins to mux the UART signals to the right
(RS232/RS485/RS422) transceiver.

IOT2040 is an ACPI-based platform, so no devicetree to describe
the RS232/RS485/RS422 mux GPIOs, but the underlying concept is the same.

Thanks,

Lukas

