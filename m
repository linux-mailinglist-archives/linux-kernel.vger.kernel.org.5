Return-Path: <linux-kernel+bounces-138835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEC89FAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B5A1C20CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668F16C848;
	Wed, 10 Apr 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d1DEagI4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DC16D9CD;
	Wed, 10 Apr 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761249; cv=none; b=DdMAEjrdVIKD4UgryHt5x0vOKgWsQXTPmy341FKyKxCqVXW2O/tk387BI/wvM/VQMqrBF2zCcGD5NmMweqP/hAJBm+/r23d+bXS+0TriU+zGLyJJEayoPMvBmklrRC5BY3L8ti84+6pu010Ig5P8gPgV/4cBPnIQ2phX33KPe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761249; c=relaxed/simple;
	bh=TS++rJeV2yp4ppxLNZ4aJCxbh0/MWI8RIQHG9a9vms8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZp6eYyML7Tnj099WTwPU4y6G6x0BxFoe2DDgbBVifrCn+OpPoq8bRcxahPxZ0vJCuIf5tcMZ4rnLXnv+d6x13P5OBOSKNgLixlt0/f/Yqzc0w8ElWezbJnW3ZoO8BSorudJexH1A/80Vy8aV/aoqa/IEJK/1PndcX7cgyTKA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d1DEagI4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F6841C0005;
	Wed, 10 Apr 2024 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712761244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzMYDMLGBpPQNMah2gckIeh3UT0WgV6HR8G+ppovp+Y=;
	b=d1DEagI4nb/ol0AaR0vfyiD500UagvM8aAw43x9dEhNl7sPQT3uoUpQgrcfWJl9sYEOjFs
	KfqwYvvH8RQ/BYupRm3yMeB8xxy6oYtewm5pEmdBjwClHnZOJUAY8xwLmHZcDkpRPM5806
	xSWAkfYYlhtIWeDgSqYZp1iGAEtxVgd3p5ayB55jQTChqmU08f1qJhrJ7Fsgc1YAokCcmn
	3edZuXvPg6HZNGNk/oXjDNbiNsmQxGQRLM+sBUIub2sCJmW77hqcsz0jylJuBSYwZyiJCO
	LkymfrG2MQ5I1FrT8yih+eDtbj1LDRoSl37311ZVUoa/AVRDk/bWRvdRn5Y99g==
Date: Wed, 10 Apr 2024 17:00:40 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240410170040.37a59ff6@xps-13>
In-Reply-To: <588551c9-3426-e623-e2aa-70b040c9324a@salutedevices.com>
References: <20240409181025.55504-1-avkrasnov@salutedevices.com>
	<20240409181025.55504-2-avkrasnov@salutedevices.com>
	<20240410122356.30852b3c@xps-13>
	<588551c9-3426-e623-e2aa-70b040c9324a@salutedevices.com>
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

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Wed, 10 Apr 2024 17:48:02 +0300:

> Hi,
>=20
> On 10.04.2024 13:23, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@salutedevices.com wrote on Tue, 9 Apr 2024 21:10:24 +0300:
> >  =20
> >> Boot ROM code on Meson requires that some pages on NAND must be written
> >> in special mode: "short" ECC mode where each block is 384 bytes and
> >> scrambling mode is on. Such pages located with the specified interval
> >> within specified offset. Both interval and offset are located in the
> >> device tree and used by driver if 'nand-is-boot-medium' is set for
> >> NAND chip.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.=
yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> index 57b6957c8415..b86a1953056b 100644
> >> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> >> @@ -64,11 +64,25 @@ patternProperties:
> >>          items:
> >>            maximum: 0
> >> =20
> >> +      amlogic,boot-page-last:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description:
> >> +          The NFC driver needs this information to select ECC
> >> +          algorithms supported by the boot ROM. =20
> >=20
> > Shall we have a length rather than the last page? =20
>=20
> You mean rename it to "amlogic,boot-pages-length" or something like that =
? But I think
> length in bytes is useless here:
> 1) boot rom needs that only some single pages are written in special mode=
 (and as I see in
>    vendor's driver it also works in pages).
> 2) NAND driver operates in pages during write/read such pages.
>=20
> So length in bytes will be converted to pages anyway.
>=20
> What do You think ?

I didn't talk about units :-)

Maybe: amlogic,boot-pages would make sense? But pointing at the last
page seems weird.

Miqu=C3=A8l

