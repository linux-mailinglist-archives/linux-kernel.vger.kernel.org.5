Return-Path: <linux-kernel+bounces-111312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625C886A89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94DB1F23A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC13D38F;
	Fri, 22 Mar 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Abs65TWj"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B73DB9A;
	Fri, 22 Mar 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104000; cv=none; b=OHAZRQxnYbzDjTX9PT8q20rnLMIYfxCT//iBNNOr/QIAP4ZIIJ6yBPfeWsbZ+cu76deS0pc/7I7kHJcOtcni5S48TeHSLmmv9+Tt3LebWAxHIXAxG6eaqB5p2oAdS885YFGoNZxqb7acnW9FARnGczHRUVF+lWJaKUia0/vs3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104000; c=relaxed/simple;
	bh=mbCfCKEKkGI+oF9DOo3BjBASMhgsvFpxmE1dYl1oeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eElb8GaMfu/RYLfQegyjhO0wbM8yjwXjSNZURHOxfWAZg6E5RVRw+DOisxNBAxe/WLp95n06htke/CXF1YDvvnLiy93F/XcocercOxm80YI6jmRGlw+mB/Zt3N5xCRyMKIe0pewKzlGx3jvJWOGf7tuOivFZLcoagUp3ge5wr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Abs65TWj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BA7040009;
	Fri, 22 Mar 2024 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711103993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbCfCKEKkGI+oF9DOo3BjBASMhgsvFpxmE1dYl1oeYo=;
	b=Abs65TWjIPymsT85gW9nGnQpgIGr9KiT9Gv2MVsg/9VrWqqW8BgIoe5JtB+BFcqEm2mik+
	9LxLqoBDweMoBwKelRyPlawVI+DJyg2CkGUOt8mS6QeAa/EX8yQEL49hWTTipnwQaSh1CH
	+DyQnuXdKUbP4sprV3J+U3wOf0rPVkeN3I+gl2Lt/4bpz6R1gRfJOZBKM5+ALsELMvhZSg
	V7umSn7hZY/d9mtHhC4rqI4Js8rwcydFkG86LbGaTEJAOBJu5eJjgByGWZB8yD/nj2Ggzc
	dxKOQ9VU/Bauu1rL0pg3AHLvTE8ZYypx6layXd6CGjdo2x5ZCJRWOfUmuTXNtg==
Date: Fri, 22 Mar 2024 11:39:50 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240322113950.27d35376@kmaincent-XPS-13-7390>
In-Reply-To: <ZfxjosqPMo0ECBmx@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<ZeObuKHkPN3tiWz_@pengutronix.de>
	<20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
	<ZeWi90H-B4XeSkFs@pengutronix.de>
	<20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
	<ZfxjosqPMo0ECBmx@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleksij,

On Thu, 21 Mar 2024 17:43:14 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Mar 21, 2024 at 05:15:24PM +0100, Kory Maincent wrote:
> > Hello Oleksij,
> > Sorry, I forgot to reply about this.
> > This is specific to pse_regulator driver. Could we tackle this change in
> > another patch series when the current patch series got applied?
> > Also I don't have the hardware to test it. =20
>=20
> ACK, no problem.

I have a question unrelated to this.
Why do you add refcount on the pse_control struct?
The pse control is related to the RJ45 port. Each port is exclusively relat=
ed
to one pse control.
Shouldn't we return an error in case of two get of the same pse control ind=
ex?
Do you see use cases where a pse control could be get two times?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

