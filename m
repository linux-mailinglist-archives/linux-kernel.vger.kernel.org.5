Return-Path: <linux-kernel+bounces-88258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7386DF4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBD1C217C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A306A8DE;
	Fri,  1 Mar 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="glQ0TZE6"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF72339B1;
	Fri,  1 Mar 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289438; cv=none; b=MFvli8ksd4cJOOHkURPw8x6bIx+KEJIA5s2hFq4xsX78SvuWG2bAqqantm38W8dONeRHB6I0WGNn9yumkvNJ4D6UAvo+aqp447IAN7e9bHQ/AfPVntIxUFtdDXJx0F4GrFcgUARm1h1TBEROMGLlQ6eoeFUawRYRlNJL0VMvQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289438; c=relaxed/simple;
	bh=kj0GX5JufiTvFSbGnjmfOxouxBSD5J1fiq7Z+9gQtfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvY0+XcFq/eH923wiX4kn1gkRgb0Qrfgh6ce/sVrSfKGu2iI02XayaWQ3YymruzWcVQQTycPBIL4qOg/Duqxusmdazr1PeJsf86UioIIMYofkB4dknhW7IBoajE1p8H6weyXEfiYYbnSrLhTC+5hqnNYEifn6H/F/6eUv8d5Hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=glQ0TZE6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B01660003;
	Fri,  1 Mar 2024 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709289427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZXbs8FJ1qVx7PbdKrlgZ1XNtd19xUWerbxWOLhwuM0=;
	b=glQ0TZE6LDyKscIZPFD/F5LAelaLJlBUHfnT3OffYX0JJcO2E5GvADW4hECiweYiGAqQyi
	FYSrBk/Eo+deS7wUAQ14J6OWmE/tIScxkmKtJVYYh6fROC26mn+qkvf7pc2lru5N4g4+bZ
	Y3joigwZSh52q4dD7inLW2TCAPKWllF5lj9pn86gxUvpDsorhSsUr0gLHYEAJevIp64QRn
	lY5rb611L2WOTFCm5W4bkaQWvsY5S8IGJXICo5JYGFiDk/lDdBOTBt8h/UOogKkO5WXQsh
	siefTxO9I2nQiRKpv8knknePhM/GmF2HdjwRjQGf7meP2FHLmpq0e0GRSOa0WQ==
Date: Fri, 1 Mar 2024 11:37:03 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-leds@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Message-ID: <20240301113703.102bbad0@device-28.home>
In-Reply-To: <c6840f8f-7d9c-49e8-b689-2af04605b99c@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
	<20240227093945.21525-7-bastien.curutchet@bootlin.com>
	<a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
	<c1b17410-b403-4c3a-9c00-de8f2b2b2fa7@bootlin.com>
	<c6840f8f-7d9c-49e8-b689-2af04605b99c@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Bastien, Andrew,

On Thu, 29 Feb 2024 16:23:59 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Feb 29, 2024 at 08:31:55AM +0100, Bastien Curutchet wrote:
> > Hi Andrew,
> > 
> > On 2/27/24 17:18, Andrew Lunn wrote:  
> > > On Tue, Feb 27, 2024 at 10:39:45AM +0100, Bastien Curutchet wrote:  
> > > > The PHY is able to use copper or fiber. The fiber mode can be enabled or
> > > > disabled by hardware strap. If hardware strap is incorrect, PHY can't
> > > > establish link.
> > > > 
> > > > Add a DT attribute 'ti,fiber-mode' that can be use to override the
> > > > hardware strap configuration. If the property is not present, hardware
> > > > strap configuration is left as is.  
> > > How have you tested this? Do you have a RDK with it connected to an
> > > SFP cage?  
> > 
> > I did not test fiber mode as my board uses copper.
> > 
> > My use case is that I need to explicitly disable the fiber mode because the
> > strap hardware is
> > misconfigured and could possibly enable fiber mode from time to time.  
> 
> O.K. So lets refocus this is little. Rather than support fibre mode,
> just support disabling fibre mode. But leave a clear path for somebody
> to add fibre support sometime in the future.
> 
> Looking at the current code, do you think fibre mode actually works
> today? If you think it cannot actually work today in fibre mode, one
> option would be to hard code it to copper mode. Leave the
> configuration between fibre and copper mode to the future when
> somebody actually implements fibre mode.

Looking at the driver and the datasheet, it's hard to say that the
fiber mode can't work in the current state. It's configured either
through straps or an overriding register, and it's enough to get the
scrambler/descrambler automatically setup according to that single
strap. 

So it's hard to say that defaulting to copper won't break anything :(

OTOH there's no SFP support in this PHY, in terms of register config,
some aneg modes won't work in 100BaseFX, which the driver doesn't account for,
So nothing would indicate that the fiber mode was ever used.

There's the DP83822 driver that can accept the "ti,fiber-mode"
property, so adding that would at least be coherent with other DP83xxx
PHYs but it has the opposite logic we want, so doesn't prevent any
possible regression for existing fiber users.

All in all, do you think that defaulting to copper and leaving users an
option to implement "ti,fiber-mode" is an acceptable risk to take ?

Maxime


