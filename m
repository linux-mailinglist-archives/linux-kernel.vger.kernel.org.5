Return-Path: <linux-kernel+bounces-97115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2E8765B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519A7B20519
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27E3FB80;
	Fri,  8 Mar 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UodPQ+YM"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45936132;
	Fri,  8 Mar 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906074; cv=none; b=fZi61mHXFjCY883suy4HpHmlTnukK03C9hGwSXcxGk77WGFGif42ITtqFKZ3k7eK34IlefYgabJn5M6n9JlNsFvR+T18tNrm7Wk+zQvOJooS+kl4luhAXkdF5yrtz6pv0UUHxfWUXYAmx4nwvHgupg/BMbRbSY8IUNT+PhJ50EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906074; c=relaxed/simple;
	bh=aG3+CKOKqnEHD8zClL8ksocZPjrpA9A3lAGAuXz771A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nijpqiRRhEYbdZv22TCT2JvkTrC3KMNVEI/EUgeBkka+SUlZe6dajFn/VHwGY1nBb/uTEJgpPZcEmUS5Ren3tXI9/D0ojBSI/G6OS92Sb3rckI9I+VwiDLN6X8EaQJP3CaZHwnzlZmZFSWY680CrZ8fQK6+8o86+k1uUkLHbHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UodPQ+YM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B17DE0002;
	Fri,  8 Mar 2024 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709906069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aG3+CKOKqnEHD8zClL8ksocZPjrpA9A3lAGAuXz771A=;
	b=UodPQ+YMKvaHGMrbgD52PyzC/shaIII3K4mzJfXghCFjJAz3b/IFhvAThZwQXjyACBXHha
	7PeNTGCYtLn/YiWLh8dUBvMAOTBmMgQSQtD1E2FONBy5M6OymFCrz/SUkLhqzMZP9pq+Su
	iPZJ+iFlIc3JJrBRWbg/vYxR1s2Fa+iAUnTVBrdvKoT8YPstN8VwW9jTiQ2wnY0x66q1fq
	0LMRLL2NA/p6hauDHdeu+hN1Egxg9GEmAL/fMW+dt2cwZWYN7kQVAhmxX9G36O3RwoApaN
	adFQ1GcSTefB34p5Z2EXZNsvNV7jkVylsGWvZymQGshKMoj/k3rFfsceBxxJdw==
Date: Fri, 8 Mar 2024 14:54:26 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 00/17] net: Add support for Power over
 Ethernet (PoE)
Message-ID: <20240308145426.7eb4b043@kmaincent-XPS-13-7390>
In-Reply-To: <CAM0EoM=Q3hdXSHNADKX=erJQJWT4Jz0XeAD8kMYHv_VGagvPQA@mail.gmail.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<CAM0EoM=Q3hdXSHNADKX=erJQJWT4Jz0XeAD8kMYHv_VGagvPQA@mail.gmail.com>
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

On Tue, 27 Feb 2024 10:31:05 -0500
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Tue, Feb 27, 2024 at 9:43=E2=80=AFAM Kory Maincent <kory.maincent@boot=
lin.com>
> wrote:
> >
> > This patch series aims at adding support for PoE (Power over Ethernet),
> > based on the already existing support for PoDL (Power over Data Line)
> > implementation. In addition, it adds support for two specific PoE
> > controller, the Microchip PD692x0 and the TI TPS23881.
> >
> > This patch series is sponsored by Dent Project
> > <dentproject@linuxfoundation.org>. =20
>=20
> Sorry, couldnt resist because it sounded like a commercial;-> And
> likely i am out of touch. I am all for giving credit but does it have
> to be explicitly called out as "this patch is sponsored by X"?

Hello Jamal,

I will remove the line and add it in the From field as suggested by Jakub.
It seems to be the usual way to do it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

