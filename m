Return-Path: <linux-kernel+bounces-107514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FD587FD85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467BE1F213CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EA7F7D7;
	Tue, 19 Mar 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ol0N8V5O"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1E7F469;
	Tue, 19 Mar 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851156; cv=none; b=nLX8Q5bzU7ot8+zHqEvWCBvBSTDDWRigdiNgb+hldkxdmqqkJUzITboJ86THvS4IkFlIn+HbXKPl6L8NUMKQDE2ykyldoNO/IZ0CEgBwtQqTQlk14zPwKi+IbXR60LTjsAyYAiKVt6qEYGYQ9Ez+vBCwBkLn3jEMnjdA0U4FXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851156; c=relaxed/simple;
	bh=BP3B84ARNrn7lXfL6vg/q+uz5CqMrzfZiAc+JtFzzGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMZGu/njMsd9toWPXFjia3ZY/Mw/RIsSSrAkQ8Wj91ZSU8AmohEqYxIE5cmLMVIuQu/CqpHdKGPB1kYYJStuXCqT2XZoCGjnIUeNvQ9hpMQToM4oIUsfvkvydTuMEMHsKrPCZnOs3HDMv3Winbr8pmnRSldXD9y3AkZMoSlokNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ol0N8V5O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oLvla2oyvXXJnH6StnpXdN8ZvKvla8sutF0A+RVM3SI=; b=ol0N8V5OvA2RhRy82GsC+gtUiA
	iWxQT13z+0a4GNIjKIrRvLJGv3xjGoqFCwB30c1fchr32JMByCSjbmtdVkshtAA4jAOwtMJzr6EL1
	9l7ZvozHYaJjy0C1a0CEWClJkSRY3LGvPKmB3dn3mZnmN3Km9wqf2SMMdK8ZPLmuuzas=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmYXF-00AhIs-Tv; Tue, 19 Mar 2024 13:25:41 +0100
Date: Tue, 19 Mar 2024 13:25:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,
	open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>

> The device tree defines the SPI controller associated with mikroBUS SPI
> pins. The driver on match queries and takes a reference to the SPI
> controller but does nothing with it. Once a mikroBUS add-on board is
> detected (by passing manifest using sysfs or reading from 1-wire EEPROM),
> the driver parses the manifest, and if it detects an SPI device in manifest,
> it registers SPI device along with setting properties such as `chip_select`,
> `max_speed_hz`, `mode`, etc.,

How complex can the description of the hardware be in the manifest?

Could i describe an SPI to I2C converter? And then a few temperature
sensors, a fan controller, and a GPIO controller on that I2C bus? And
the GPIO controller is then used for LEDs and a push button? DT
overlays could describe that. Can the manifest?

	Andrew

