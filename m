Return-Path: <linux-kernel+bounces-103821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082387C4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6771C21538
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8E768F8;
	Thu, 14 Mar 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TifNrbvj"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881174BE8;
	Thu, 14 Mar 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453860; cv=none; b=OwkYRx86uRt97F5wCoYEiWx8iJl45KTR2S5e5GYTQvSEWdHoonz6FRIgy9r1r2uAOTDSRsSyQ2D6Y+5OGFcnPFzkcvBCK+LDi4AJvYOn5gpe+7jASbjES4YrhTjpUnkizWN3iIllCAzAUUkKjO+8xdod2sRV1JYeOvRmxqQbFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453860; c=relaxed/simple;
	bh=+dsvZmXTf1mHrJK+vfIVxrTv+JRORQUMEKmoTDRev/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS3/Q8dB8/YZZhSTb/qQHuCMFLgtj10mR5W2Tg4iBkO5LZVpjoGXltWHF2pMeOwnUbgyBB+c03w0nk2gvGi54slJP2IuYGn77XnAFJ+iyqTzv6mZR5j4+jUACrbqFNs4TUM1D9wgu9w87+c4YdQvkRilH2CJPgMB4jmPCX9nUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TifNrbvj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CA8940004;
	Thu, 14 Mar 2024 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710453849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfCPNoNzVXxzZ2eRtShMfBPSV4HwMjR3iQ1VFpAZEzc=;
	b=TifNrbvjRYYFBiKhOoRSDb2I5S5yVI2rgeqWlGh7Ycjewc8yCWZpzpnWA6DOfqcyY8PkCY
	SnVCJSQiLuRqQxR10aRYC3naw7offG/D2NKgeUsfNg3SJlRr3txDdf9P4mcMI1ZN5Er9xD
	/GRnquIazxL0BQR0cyG/9qTqcOxB6Moif9mRUk6KWO04ixeEl/NhZCy6orSoT+fL2dXUwf
	sYVP1JSS/Owfkmat8Z9SnODB/K+B4P7QaSb3X1c2obRQlefjWazhc9ZL5orMiCUXLN4kmU
	ot7/oc+riO4BDSINtdHRdCQ8ecIgCxCmlrtEvOyZ7Ny9QUGe6D31xvjlE3KiQA==
Date: Thu, 14 Mar 2024 23:04:02 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>, Linux MTD List
 <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, Andre Przywara
 <andre.przywara@arm.com>, Rob Herring <robh+dt@kernel.org>, Kamal Dasu
 <kdasu.kdev@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJl?=
 =?UTF-8?B?Y2tp?= <rafal@milecki.pl>, David Regan <dregan@broadcom.com>,
 devicetree@vger.kernel.org, Alexandre TORGUE <alexandre.torgue@st.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Brian Norris
 <computersforpeace@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 00/13] mtd: rawnand: brcmnand: driver and doc updates
Message-ID: <20240314230402.5fc7bbf3@xps-13>
In-Reply-To: <20240229101101.5208195c@xps-13>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<90ecf4d2-0eee-48e6-8222-7d3b5fd52b2f@broadcom.com>
	<20240229101101.5208195c@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Florian,

miquel.raynal@bootlin.com wrote on Thu, 29 Feb 2024 10:11:01 +0100:

> Hi Florian,
>=20
> florian.fainelli@broadcom.com wrote on Mon, 26 Feb 2024 09:36:02 -0800:
>=20
> > On 2/22/24 19:47, William Zhang wrote: =20
> > > This patch series is an update from the previous version [1] after
> > > exex_op support and fixes (patch 1 to 4 from the previous version.)
> > >=20
> > > It updates all the BCMBCA SoC to support the nand controller and add
> > > functions to handle BCMBCA specific needs on ECC and Write Protection
> > > usage. The device tree document is also updated accordingly with the =
new
> > > properties needed by the driver.
> > >=20
> > > In addition there is a bug fix for exec_op helper functions, log level
> > > adjustment on uncorrectable ECC error and some coding style fixes.
> > >=20
> > > [1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang=
@broadcom.com/   =20
> >=20
> > Miquel, thanks for having applied the patches, we should have discussed=
 ahead of time whether you should take the SoC/board-level DTS changes thro=
ugh your tree or mine, but it's fine either way and should not lead to conf=
licts in Linus' tree. =20
>=20
> I'm sorry for not thinking about this ahead of time, I was also not
> Cced on the other patches, I noticed it (told Willliam) and just forgot
> about this when I applied the series.
>=20
> It is currently living in -next so if there is any problem I can still
> act.
>=20
> However for this kind of change I usually apply the bindings and .c
> changes independently from the DT patches. I believe there is no
> problem having one or the other being merged first, or do I overlook
> something?

What the heck /o\ I just understand now my mistake, I am very truly
sorry for that...

You were telling me I should sync with you before taking DT changes,
and I was so convinced I _did_not_ take the DT, when I looked at the
branch I did not understand your point. But I am totally sorry I
actually did take the DTs by mistake and I truly did not notice it.
Confirmation bias I suppose. My very sincere apologies.

As mentioned previously, I was not CC'ed on the DT patches, but I
believe the linux-mtd list was, so the patches didn't appear in my
inbox, and once I was happy with the binding/driver changes I applied
it all without noticing the DT changes had sneaked in.

I'm finally preparing the PR for Linus and I see it now...

I believe the SoC tree is closed now so it's up to you what I should do
with them. Let me know if you want me to keep them in my tree and
forward them to Linus or if I should drop them and you'll take them for
the next cycle. Also, if I keep them, shall I add some tag of yours on
these 3 patches? For the record I did not review them.

Thanks and again, I'm confused. I never apply DT patches like that,
your initial remark was more than legitimate.

Cheers,
Miqu=C3=A8l

