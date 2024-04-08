Return-Path: <linux-kernel+bounces-135288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579689BE71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DEF1F218C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DE6A330;
	Mon,  8 Apr 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="rxDSbYHW"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BF69E07;
	Mon,  8 Apr 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577090; cv=none; b=GEpGfGvBRwYiBiZl0fF0xJ01GxfcJguChmP5/oAKQHAWRlBOY2uLDnc1YBga0nQ9AAY/O2gi3Wchvf7U9Dcwx1Bz9V/oENY41lrmLXtx+KFjwplake7DoT3LDvhd9TD9e45wv+XGG6Ityo8rxHNG7CAWuA0uRsDdYSjfv3GgRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577090; c=relaxed/simple;
	bh=I5yljxzZzXYcwlpP5I426+Gg1XBkRYcBytW1okcfLJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGd44+tcMp87g9Ks4wJE2N++Kpgp0JMt7c3zzP4W6NqXpXSTiZhGr8Tql8cH1FzaakSLEJdZfSx/sn9hQrmF/TuEPm4lw8CCwbj8jZVf/x1PDs9ATYV/Yt16y2w+EcLHQkvnQkihWuc6Gqz21KNUXFJPK5Niz9JjsJZz9PAy0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=rxDSbYHW; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712577078; bh=I5yljxzZzXYcwlpP5I426+Gg1XBkRYcBytW1okcfLJc=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=rxDSbYHWltTdqEXQq3e2/NVcU5m38sByYCxFziUb6aFv88v9TSrHQGWkO7ZnOJlLf
	 9pBS6jQO02xwbKyxnIK1MYOP3/5t4khGbOOWoI4P1bD3R1D9knXzZ5ve898ZcZcdD4
	 +z6mwTIo5pDtgMunTvW9yJhVtlHUCskppb9JaebI=
Date: Mon, 8 Apr 2024 13:51:18 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <35tqaktf533qtpaquvzb7p5juupjyakktstlqgr2hqretnt7lv@chubnabkyqjz>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>

Hi Krzysztof,

On Mon, Apr 08, 2024 at 01:17:32PM GMT, Krzysztof Kozlowski wrote:
> On 08/04/2024 12:51, Pavel Machek wrote:
> > Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> > but I did best I could.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ...
> 
> > +  cabledet-gpios:
> > +    maxItems: 1
> > +    description: GPIO controlling CABLE_DET (C3) pin.
> > +
> > +  avdd10-supply:
> > +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
> > +
> > +  dvdd10-supply:
> > +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
> > +
> > +  avdd18-supply:
> > +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
> > +
> > +  dvdd18-supply:
> > +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
> > +
> > +  avdd33-supply:
> > +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
> > +
> > +  i2c-supply: true
> > +  vconn-supply: true
> 
> There are no such supplies like i2c and vconn on the schematics.

Which schematics?

ANX7688 has VCONN1/2_EN GPIOs that control a switching of VCONN power supply
to resective CCx pins. That's just a switch signal. Power for VCONN needs
to come from somewhere and the driver needs to enable the regulator at
the appropriate time only.

On Pinephone it can't be an always on power supply and needs to be enabled
only when used due to HW design of the circuit. (default without ANX driver
initialized would be to shove 5V to both CC pins, which breaks Type-C spec)

I2C supply is needed for I2C bus to work, apparently. There's nothing
that says that I2C pull-ups supply has to come from supplies powering the
chip. I2C I/O is open drain and the device needs to enable a bus supply
in order to communicate.

You can say that bus master should be managing the bus supply, but you'd still
have a problem that each device may be behind a voltage translator, and
logically, bus master driver should care only about its side of the bus then.
Both side of level shifter need the pull-up power enabled.

You can also make an argument that bus supply can be always on, but that
causes several other issues on Pinephone due to shared nature of most
resources like these. There are other devices on shared power rails, that
need to be turned off during sleep, etc.

Kind regards,
	o.

> I think this represents some other part of component which was added
> here only for convenience.
> 
> 
> 
> Best regards,
> Krzysztof
> 

