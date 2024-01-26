Return-Path: <linux-kernel+bounces-39654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C706783D465
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8598A2872F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB984111A2;
	Fri, 26 Jan 2024 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pv3WnWWR"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96550C128;
	Fri, 26 Jan 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249963; cv=none; b=URn/z1ZLAkau4pN6L/9KULRpnYkUY3JqQCsw4rdMPH0wlvSmxKN8bZcR5hhxYxX91h6yyhd89+3ZjRHNw9nLFsU2i3kPpWpUVAMq1wMzKztwq0hBtVUkXCy+f4yJwV6FH/kyM4EvmnWPh7wekzzfSKHsLILBrvf7X1/JyA0KDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249963; c=relaxed/simple;
	bh=1SnGJqeW4AFinDsAd0NkQgQaXbzZn06pnRvQJYxt5dU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZT2hWVL8JkGFkJ1jPT1GQrvtBKElUB7yg60bVd+t2oXcDKwy8+1t/X+NFpb67pM9D3DbDh0vrCoLGtuY/Id28QCBrAoHGX4YuRnh5zWNtXXlNpQspQC0hywpaqn0vhORYGaat2F2ZRRZviuP722aQDbPbacbG8dq8S2Y7qGYbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pv3WnWWR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D16D640003;
	Fri, 26 Jan 2024 06:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706249957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzlhwUVFx4zm9tXJ7XTM/+LMgA8bFcm+1XMzEx3pfK8=;
	b=pv3WnWWRevCdcz+4tJnzojyH43cxQwuwHltR1pkR5YfxXJLK+s8UaDRxRYg9Mib8Ik0lna
	H3zikgpegGs8JHYOzUlyEKYmfzghrt+N4PbLuHnmj1CCzGhaAzdvp1FD6PEk7yfiKjJ5kM
	vxfowimCa4XC+rV22Bz42T6TEZSuY5+Mp2xfl2Um0zba9uNSKs/WyictHKXICFBA6v8XTz
	gc366KELLfnOLB5Us9BWj19qFVBcIgImsmueHcEzq9wA7KFMHL1z3n3oL5BRxU99jLJHwR
	vHKTsvary9tD5gYSzrx144o2pnJ3ysQq47yLED+ZPei1Osr6Y+ul80jOJWs90g==
Date: Fri, 26 Jan 2024 07:19:13 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Joel Peshkin
 <joel.peshkin@broadcom.com>, Tomer Yacoby <tomer.yacoby@broadcom.com>, Dan
 Beygelman <dan.beygelman@broadcom.com>, William Zhang
 <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, Kursad
 Oney <kursad.oney@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Message-ID: <20240126071913.699c3795@xps-13>
In-Reply-To: <CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-11-dregan@broadcom.com>
	<20240124184027.712b1e47@xps-13>
	<CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi David,

dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800:

> Hi Miqu=C3=A8l,
>=20
> On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hi David,
> >
> > dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
> > =20
> > > Allow settings for on-die ecc such that if on-die ECC is selected
> > > don't error out but require ECC strap setting of zero
> > >
> > > Signed-off-by: David Regan <dregan@broadcom.com>
> > > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > > ---
> > > Changes in v3: None
> > > ---
> > > Changes in v2:
> > > - Added to patch series
> > > ---
> > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/n=
and/raw/brcmnand/brcmnand.c
> > > index a4e311b6798c..42526f3250c9 100644
> > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnand_=
host *host)
> > >       cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->writes=
ize);
> > >
> > >       if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> > > -             dev_err(ctrl->dev, "only HW ECC supported; selected: %d=
\n",
> > > -                     chip->ecc.engine_type);
> > > -             return -EINVAL;
> > > +             if (chip->ecc.strength) {
> > > +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must be set=
 to zero for non-hardware ECC; selected: %d\n",
> > > +                             chip->ecc.strength); =20
> >
> > Can you use a more formal string? Also clarify it because I don't
> > really understand what it leads to. =20
>=20
> How about:
>=20
> dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\n",

Actually I am wondering how legitimate this is. Just don't enable the
on host ECC engine if it's not in use. No need to check the core's
choice.

>=20
> > =20
> > > +                     return -EINVAL;
> > > +             }
> > >       }
> > >
> > >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > > @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnand_=
host *host)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     brcmnand_set_ecc_enabled(host, 1);
> > > +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_DIE) {
> > > +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n"); =
=20
> >
> > Not needed. =20
>=20
> Will remove.
>=20
> > =20
> > > +             brcmnand_set_ecc_enabled(host, 0);
> > > +     } else
> > > +             brcmnand_set_ecc_enabled(host, 1); =20
> >
> > Style is wrong, but otherwise I think ECC should be kept disabled while
> > not in active use, so I am a bit surprised by this line. =20
>=20
> This is a double check to turn on/off our hardware ECC.

I expect the engine to be always disabled. Enable it only when you
need (may require an additional patch before this one).

Thanks,
Miqu=C3=A8l

