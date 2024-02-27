Return-Path: <linux-kernel+bounces-83565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACD869B82
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7162C287111
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07B14830A;
	Tue, 27 Feb 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWKWZeel"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED2146E8A;
	Tue, 27 Feb 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049789; cv=none; b=FMo5ecoUCPKF8H7A3qZKNCd7kVcg5ELoY/5nDb8orjFOvRDfkzDxL7J/EhlWoPkG62Y17JlDb6pJqsk5CCJmjAsY9mmPFpUM4wjSvYtaH+5AThTkRc1RcUES1vebp3fM+OerOAIzrkHDYA66x3dU8X6p4w2WipXM38PRMFeoFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049789; c=relaxed/simple;
	bh=D8fuIEf8rJNQDmLdQLIRRJcmZttD10RcRN0fcSH1sLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcBo1KwjhCJlRe+yiZiTp2PCt9flFqpr0PSMvEGbiyl3Kj+lgTBrMcAanLGZjttRs0KsAVhldFAfXRDFs+HxHoDJat+CMlq/DxywwNsWHtzNk4hIbiJ6dcLt5XWakvjXDyzwCNOvsASI7JFkIX/A8NymfLpNtYV6sZ3h8EXH/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AWKWZeel; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IY2/g60Mhri+J9MAbXvnzzlU9k4+0F6po+5bYJBis5k=; b=AWKWZeelA7RQNAtpeq50GWuqhH
	DndOuu8VHbgWp+B/i079vkiufoHy0dbHP1X+nqUIoz+fUWJr/qDw0yWUsahEdbLkfWCLsIuo6s5Db
	vkgCtxwoBUuiwFZztZd6rzFaDIC5PSvRzxyYUTzJiw/Yaq4ioKNtZhEP16eKCKTqrbTM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rezvG-008rpE-4l; Tue, 27 Feb 2024 17:03:14 +0100
Date: Tue, 27 Feb 2024 17:03:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 2/6] leds: trigger: Create a new LED netdev trigger
 for collision
Message-ID: <e6351d0c-15e2-47a9-be6c-6f21aee9ae90@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-3-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093945.21525-3-bastien.curutchet@bootlin.com>

On Tue, Feb 27, 2024 at 10:39:41AM +0100, Bastien Curutchet wrote:
> Collisions on link does not fit into one of the existing netdev triggers.
> 
> Add TRIGGER_NETDEV_COLLISION in the enum led_trigger_netdev_modes.
> Add its definition in Documentation.
> Add its handling in ledtrig-netdev, it can only be supported by hardware
> so no software fallback is implemented.

How useful is collision? How did you test this? How did you cause
collisions to see if the LED actually worked?

As far as i can see, this is just a normal 100Base-T PHY. Everybody
uses that point-to-point nowadays. If it was an 100Base-T1, with a
shared medium, good old CSMA/CD then collision might actually be
useful.

I also disagree with not having software fallback:

ip -s link show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 80:ee:73:83:60:27 brd ff:ff:ff:ff:ff:ff
    RX:     bytes    packets errors dropped  missed   mcast           
    4382213540983 2947876747      0       0       0  154890 
    TX:     bytes    packets errors dropped carrier collsns           
      18742773651  197507119      0       0       0       0

collsns = 0. The information is there in a standard format. However,
when did you last see it not 0?

	Andrew

