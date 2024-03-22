Return-Path: <linux-kernel+bounces-111455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F404886C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B011C213BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAC4596E;
	Fri, 22 Mar 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U9z6T2wk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF244C97;
	Fri, 22 Mar 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113081; cv=none; b=Qlf0jGgS7vDyeuDNYfyaaizY8JuVPQZ4eH1tEuJ4T4/jtThbdHdKX4J5gTxyv8Eyi2NLSYXsJKWxbFI8sFxM/FqBReGzGnBx6dX4K7+jLmxGR+63dcaoVIiJXf/t6CenbYoZwiOvjEv5YY+M5C6gqodufXmCWbPHH+TOyx/puYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113081; c=relaxed/simple;
	bh=FTN5M/4n2j9wR7OBq/TUq/tbFZDX7NYrEDnkQCjXB1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhSo+d19D8rToHHFYctKQMBH7oyVYc84bHt0lCd5TSX67QZvmp0iYqaoQzfj8FJo5YQ1Xc4vmFEEajezyfJQtXTHDj8cLPxdfydS0f361/HrNhrZCJ7mPTfZMvbk1FmpExlKmQxSUXnJWbHfkZVeZ5FIYyBEWbBqGXz5XYxsBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U9z6T2wk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x5ozSz+s2mlcaFcznwcIfR3LT7eM0wy0PldnwgSngfQ=; b=U9z6T2wkbnu9XPCta7wwuPJNLO
	Q98P7B7QLYjQjJAZFgfY0Rue5B/ufsCzZ7xZb1pQ1PQX2wXuV6QKS1oNeEFt3o3R4FmPI0n1vzdUN
	aVVXtZ3kJNuS8MjRaWzWma3vL7hGpn4nUhjujYl9B0PcwwVguTxnSo53UfOk0fvK3cgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnefq-00AxcY-VU; Fri, 22 Mar 2024 14:11:06 +0100
Date: Fri, 22 Mar 2024 14:11:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Message-ID: <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>

> > Sorry, but no. List the LEDs in the PHY node, and they can then be
> > controlled via /sys/class/leds.
> May I ask more precisely the motivation?
> Does this replace the phy's builtin automatic led control?
> > arch/arm/boot/dts/marvell/armada-370-rd.dts is an example.
> 
> I will investigate it.
> 
> My main motivation for tweaking the led controls was to make them all consistent across the two boards:
> - LEDs under control of PHYs on cpu mdio bus
> - LEDs under control of ethernet switch on mdio bus
> - LEDs under control of ethernet phy on external mdio bus behind ethernet switch
> 
> It looks as if the marvell phy driver supports led subnodes,
> The switch driver does not.

https://lwn.net/Articles/965775/

There has been quite a bit of interest in mv88e6xxx driver support, so
i expect support for other families outside of 6352 will be added
after it has been merged, and it is not difficult code to write.

> Finally one phy can only be written to but not read,
> the cpu can never know its link state.

O.K. That one cannot use the LED infrastructure in a meaningful way.

> So I prefer (for the Clearfog Pro) board to explicitly use the phys
> autonomous management of LEDs.
> Is that still possible if I added led subnodes?

You can combine both. The horrible marvell,reg-init will be applied
first. The generic LED code will then take over controlling the LEDs.

For the discrete PHYs, the generic LED code can make use of the
hardware offload support to read back the hardware configuration and
configure itself to match. The switch code is missing hardware offload
at the moment. So it cannot read back the current
configuration. However, it is simple code to add, and the discrete
code is a good example to follow.

marvell,reg-init is not going to go away, because of backwards
compatibility with old DT blobs. But in general, i expect all vendor
proprietary methods of configuring LEDs to be deprecated and replaced
with the vendor neutral /sys/class/leds.

     Andrew


