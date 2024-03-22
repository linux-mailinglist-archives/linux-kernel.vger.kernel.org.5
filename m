Return-Path: <linux-kernel+bounces-111966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0D887360
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FEF1F2274F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAB7319D;
	Fri, 22 Mar 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KA7PtXeT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE7629E2;
	Fri, 22 Mar 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133494; cv=none; b=XjHHDNlQbkPbUy1vwCO70nEm1pZTLAjx6chdES8MRwD+l2AGdHztgMnhqESc32Tjr3QKK1hXMCaFPAD6U3B27NddaR7EJDUdcRmaK25ptgVayfErNp12LCTu0gYErLqOpE1qd2NIHVmATXSfFmcsBftZYt0UpDOun2w5zKFZyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133494; c=relaxed/simple;
	bh=knezeFITMrOeKtT2zrfqXKXzWrr8TJ45SZ5iAZ8WBFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVksI/blmKVPXe8q542gNfEoxvj2E2XHBaUvxGkq6GLjQuvEOFogOd7pvxXPJe4yqiKiiLj7Sx5MRYi1oqcnOV5QJ+KxlH+ph+guBjs/2/Ynvheu4D2XnJgsAThOck5GmRAW2KDyBigYEVD6ZdJHZBy0IIGeNxaLbEILvxhWLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KA7PtXeT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UiMuCZuCE+GDbraTFgLjnezZYv3h2ixZi1ZXPtQOspI=; b=KA7PtXeTDDxMMDvhwcNlopN79C
	axGXt6HfyXpXMRQ6iSLvZBqBPY+Wgyzv70AlZ1kuUgGWwk1WcJcMhpilere+va8+jV+srPuBPtAIa
	40v4LkmOPmrYyWcwnJvuiR9BkwJiCfRl0PI5M2K6PyaD3gsda2FUioXdxyG08MirHMI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnjz6-00Ayph-VK; Fri, 22 Mar 2024 19:51:20 +0100
Date: Fri, 22 Mar 2024 19:51:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
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
	Vaishnav M A <vaishnav@beagleboard.org>,
	Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <362aace1-2e6a-4b50-acf8-6dccafd44973@lunn.ch>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <711ff5ea-244d-4b64-a39c-3f2da63e30c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711ff5ea-244d-4b64-a39c-3f2da63e30c0@gmail.com>

> After going through all the discussions here, I have a few questions:
> 
> 1. Is the old `*_register_device(controller, board_info)` style discouraged
> in favor of using device tree, at least for drivers using multiple
> fundamental buses (i2c, spi, etc)?

Historically, they were used in board files, where you needed to write
C code for every single board. That did not scale, which is why we
swapped to DT.

board_info is still useful, e.g. for platforms which don't have DT. I
support a few amd64 boards where i need to use a platform driver to
instantiate some I2C and MDIO devices. But in general DT is much
easier to use.

> 2. Is the preferred way to handle virtual devices (like those created by
> greybus subsystem) now device tree? Is that one of the blockers for greybus
> i2c, spi etc to still be in staging?

I would not say they are virtual. They do exist. They are just not
memory mapped like most devices, but in another address space, one
which you access via RPCs.

> 
> 3. How are virtual devices created in device tree? If I register an i2c
> adapter using `i2c_add_adapter`, is the device tree entry is dynamically
> created, which can then be used by a device tree overlay?

As far as i'm aware, there are no examples today. You are doing
something different, something new. Adding these dynamic devices to DT
is just a suggestion from me, as a good way to solve your problem. You
will need to look into the DT core and figure out how to do it.

     Andrew

