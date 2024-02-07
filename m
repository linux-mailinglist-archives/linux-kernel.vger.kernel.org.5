Return-Path: <linux-kernel+bounces-56162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8B84C6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26331C23667
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B620B0F;
	Wed,  7 Feb 2024 09:06:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86924208D9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296769; cv=none; b=p4jxhRdCUSGrs6MboTpH/31T6zmQzeXvh8LZX9iX8Z371F6UrFE7bJQkR1MIJGHSoGthoPrdWeHcJ+PNuE1moble839YVinc8p8RxUGtwRCuJ+u+lcxgbFJUrIlAQVzEeKh7H1AXmuKqeuAn0igLNd0QgQE295T2QtFcti/tTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296769; c=relaxed/simple;
	bh=XzbFnQpdmhf+mKnd1HI5n/EqRj6P7rnCdlIOlpz7ASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoU3BmU/8rdWw1omwXdUTlfc8+teOa6i/Li1imiFstI/7dX/zZXKyJGYc3g0iudq16yCHLrNd5jXXaEJ797VPHKmrVUmy04CsFWLX0A3IXVhb6ARS8ShCU6ErBc/+wByV1yNF9YG2QWRfO306CQJvDHOZg25xLrMNYIRDdtCnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXdsH-0003kB-V4; Wed, 07 Feb 2024 10:05:45 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXdsG-004zTa-IC; Wed, 07 Feb 2024 10:05:44 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rXdsG-00Fbzx-1L;
	Wed, 07 Feb 2024 10:05:44 +0100
Date: Wed, 7 Feb 2024 10:05:44 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec-tcpci: add tcpci compatible
 binding
Message-ID: <20240207090544.g7dy7grssah3o6n3@pengutronix.de>
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-2-m.felsch@pengutronix.de>
 <004dbeb3-f863-416c-a4e4-18739302ae58@linaro.org>
 <20240206145253.u555h3rvtetv3qaf@pengutronix.de>
 <8d4cf7f7-0ee0-49ab-994a-892b200347e8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d4cf7f7-0ee0-49ab-994a-892b200347e8@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-02-06, Krzysztof Kozlowski wrote:
> On 06/02/2024 15:52, Marco Felsch wrote:
> > On 24-02-06, Krzysztof Kozlowski wrote:
> >> On 05/02/2024 17:43, Marco Felsch wrote:
> >>> This binding descripes the generic TCPCI specification [1]. So add the
> >>
> >> Typo: describes.
> > 
> > Argh.
> > 
> >> No, this binding describes PTN5110, not generic TCPCI. This is not
> >> accurate commit description.
> > 
> > This binding is currently missued if another TCPCI conform chip is used
> 
> Why would people misuse binding instead of doing things properly? :)

You know people... ;)

..

> >>>  properties:
> >>>    compatible:
> >>> -    const: nxp,ptn5110
> >>> +    enum:
> >>> +      - nxp,ptn5110
> >>> +      - tcpci
> >>
> >> I don't think this is correct. First, this is binding for NXP chip, so
> >> why generic implementation should be here? I would expect it in its own
> >> dedicated binding.
> > 
> > The nxp,ptn5110 device was the first driver which implements an TCPCI
> > conform driver. The driver already support the tcpci binding for i2c-id
> > devices as I mentioned above. IMHO this whole binding (file) should be
> > converted and the nxp,ptn5110 compatible should be marked as deprecated.
> 
> You speak about driver, but I was speaking about binding.

I know and I was afraid of mention the driver within this conversation
since this is all about bindings and devices :)

Nevertheless this particular NXP device does support the generic "tcpci"
compatible already. The support is pulled indirectly via the
i2c_device_id.name which is in the end used for of/acpi/legacy devices.

> >> Second, we rarely want generic compatibles. Care to share more details?
> > 
> > As said above this particular NXP chip is an TCPCI conform chip. There
> > is nothing special about it. There are other vendors like OnSemi (in my
> > case) which implement also an TCPCI conform chip. The (Linux) driver
> > already binds to the generic tcpci compatible if the i2c-core falls back
> > to the i2c-device id. It's even more confusing that the i2c-id supports
> > only the generic binding the of-compatible support only the specifc one.
> 
> I don't know much about TCPCI, so maybe questions are obvious: you are
> claiming that there will be no differentiating hardware element, like
> reset-gpios or power supply for none of TCPCI-conforming chips? All of
> them will never need any different hardware configuration?

Of course TCPCI doesn't mention reset gpios or power supplies but if you
use this argumentation the already supported NXP device shouldn't be
available too since the binding is missing the VDD supply ;) Since we
never break compatibility, the vdd-supply have to be optional and the
same can be done for reset-gpios.

> Is this what you claim?

Please see above.

> Just to remind: there was such claim for USB and PCI till we figured out
> it was simply wrong and we are living now with on-board hubs and PCI
> power-sequencing stuff.

Don't get me wrong, I get your point. In the end I don't care and can
copy'n'paste the whole file and change the compatible to the OnSemi
device or I can add the dedicated OnSemi compatible to this file. But I
don't wanted to add an 2nd specific compatible while the device already
supports the generic one but via i2c_device_id.name. Therefore I aligned
the i2c_device_id with the of_device_id.

> >> Are all details expected to follow spec, without need of quirks?
> > 
> > Please see above, I hope this helps.
> 
> Sorry, doesn't. You still speak about driver and how it can bind to
> something. I did not ask about this at all.
> 
> To be clear:
> WE ARE NOT TALKING ABOUT LINUX DRIVER.

I KNOW

> We talk about hardware and how it is represented in Devicetree,
> including its supplies, pins, GPIOs and any ideas hardware engineers
> like to bring.

I Know that too.

Regards,
  Marco

