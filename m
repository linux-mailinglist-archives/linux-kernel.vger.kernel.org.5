Return-Path: <linux-kernel+bounces-42571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95D84033A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301091C22762
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20F5A792;
	Mon, 29 Jan 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SmC7qxAO"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF359166;
	Mon, 29 Jan 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525563; cv=none; b=e0WvGphje0bnkhX+Ut/icpSDPlhiVLUDfTTeNQ2wuGltKLmGC97Dh5AMCU8zCpiCe/QBbnf4C5IAF8W6qrtaBa+47qmH5ZHfkDmC56VbJZAtQ9tNaRlLgmzzRciLA4i0kU0NTYa7c6Bn2r+/CyhOIDREgR4zm4r7GaZ67Qd9/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525563; c=relaxed/simple;
	bh=UYAyZ91fb6AS92l2LL/GD79fck5Q5BXJcU0K8ZP7G7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbfZay2HoVBQp5lvY86E+z0Ir78C0z2ZTsmQlMj+YIt4MsCEuJn7/z8aNbjrWAkvUTLroZ6JmXqlUro/+f7Ip7guCwKFRU6b2eKwKNg4NENXHLJKsW5U8X4wTNoiqdE34MfBqPW9ehfnaS/G5wg+seLidtUih/fcvKs8YgNqBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SmC7qxAO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BEC5FF80E;
	Mon, 29 Jan 2024 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706525552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcUfvlOtpKiNCvjO4iOwB2dkcftJ97AES2z0e0scJ5E=;
	b=SmC7qxAOwt2XyvIWfGHgHiy8Zal6fObDL6o3CJOloIjXc+WFcTjobse8iS6p0pqdb0Qkdi
	n627jGKbyy6lOvVWKit34x8AwBW/DDVxIzHjaR1DRptmUA2C6MFsgWls/PWu0xOFRhwUJt
	XppK0UKNBZXPcajtSA/JQf225G4a5r7SAFHXGqI3naZ+68K8kHS4jNLCsk7Fbu141pdWoy
	U6OfGZIk8ddkVrkvZ611sMYtd88t0CW44TXdXZTU345eWCohAihjKlaQxlC8Um0L1kTjT2
	p/ktSi7HM0goZs+zY5M7MBacWN0O0olnk430R953ky1EFKvOkvHBFCsLylcbMA==
Date: Mon, 29 Jan 2024 11:52:28 +0100
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
Message-ID: <20240129115228.06dc2292@xps-13>
In-Reply-To: <CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-11-dregan@broadcom.com>
	<20240124184027.712b1e47@xps-13>
	<CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
	<20240126071913.699c3795@xps-13>
	<CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
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

dregan@broadcom.com wrote on Fri, 26 Jan 2024 11:57:39 -0800:

> Hi Miqu=C3=A8l,
>=20
> On Thu, Jan 25, 2024 at 10:19=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hi David,
> >
> > dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800:
> > =20
> > > Hi Miqu=C3=A8l,
> > >
> > > On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.raynal@=
bootlin.com> wrote: =20
> > > >
> > > > Hi David,
> > > >
> > > > dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
> > > > =20
> > > > > Allow settings for on-die ecc such that if on-die ECC is selected
> > > > > don't error out but require ECC strap setting of zero
> > > > >
> > > > > Signed-off-by: David Regan <dregan@broadcom.com>
> > > > > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > > > > ---
> > > > > Changes in v3: None
> > > > > ---
> > > > > Changes in v2:
> > > > > - Added to patch series
> > > > > ---
> > > > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> > > > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/m=
td/nand/raw/brcmnand/brcmnand.c
> > > > > index a4e311b6798c..42526f3250c9 100644
> > > > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > > @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmn=
and_host *host)
> > > > >       cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->wr=
itesize);
> > > > >
> > > > >       if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST=
) {
> > > > > -             dev_err(ctrl->dev, "only HW ECC supported; selected=
: %d\n",
> > > > > -                     chip->ecc.engine_type);
> > > > > -             return -EINVAL;
> > > > > +             if (chip->ecc.strength) {
> > > > > +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must be=
 set to zero for non-hardware ECC; selected: %d\n",
> > > > > +                             chip->ecc.strength); =20
> > > >
> > > > Can you use a more formal string? Also clarify it because I don't
> > > > really understand what it leads to. =20
> > >
> > > How about:
> > >
> > > dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\n",=
 =20
> >
> > Actually I am wondering how legitimate this is. Just don't enable the
> > on host ECC engine if it's not in use. No need to check the core's
> > choice. =20
>=20
> Our chip ECC engine will either be on if it's needed or off if it's not.
> Either I can do that in one place or put checks in before each
> read/write to turn on/off the ECC engine, which seems a lot more
> work and changes and possible issues/problems.
> Turning it on/off as needed has not been explicitly tested and
> could cause unforeseen consequences. This
> is a minimal change which should have minimal impact.
>=20
> > =20
> > > =20
> > > > =20
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > > > > @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmn=
and_host *host)
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > -     brcmnand_set_ecc_enabled(host, 1);
> > > > > +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_DI=
E) {
> > > > > +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n=
"); =20
> > > >
> > > > Not needed. =20
> > >
> > > Will remove.
> > > =20
> > > > =20
> > > > > +             brcmnand_set_ecc_enabled(host, 0);
> > > > > +     } else
> > > > > +             brcmnand_set_ecc_enabled(host, 1); =20
> > > >
> > > > Style is wrong, but otherwise I think ECC should be kept disabled w=
hile
> > > > not in active use, so I am a bit surprised by this line. =20
> > >
> > > This is a double check to turn on/off our hardware ECC. =20
> >
> > I expect the engine to be always disabled. Enable it only when you
> > need (may require an additional patch before this one). =20
>=20
> We are already turning on the ECC enable at this point,
> this is just adding the option to turn it off if the NAND chip
> itself will be doing the ECC instead of our controller.

Sorry if I have not been clear.

This sequence:
- init
- enable hw ECC engine
Is broken.

It *cannot* work as any operation going through exec_op now may
perform page reads which should be unmodified by the ECC engine. You
driver *must* follow the following sequence:

- init and disable (or keep disabled) the hw ECC engine
- when you perform a page operation with correction you need to
	- enable the engine
	- perform the operation
	- disable the engine

Thanks,
Miqu=C3=A8l

