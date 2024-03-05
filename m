Return-Path: <linux-kernel+bounces-91821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FAA87171C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2167D284BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898117E59C;
	Tue,  5 Mar 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nAl2ejfa"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A367E568
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624404; cv=none; b=Udc0wmAAetZlmvn//j4uLeTb2/FEcvadFOfLyXSdsVO4cQlRmIY9iGrN1I8nOcQ5w92n74CwJDxmpSLlX4EajULjJGhpIiEgiT7o9tTL1kK0aLPF7NNAgXyoCXplxRl0PorqsDA8Q1f6eggi58XTmuv5sMUKeUD2o5t67hfRbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624404; c=relaxed/simple;
	bh=Bm6G6ySG2cnB5nk33Fc7Wlr/Y8D0oHtaNOjrhbgmVwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0uBnfyT+yG7DtwUfzhdM0CFXZ2EnSRyf4DPVDy1p1YYaKaLTGldW3S1srFanRFJobP+Wj11X1lnRemZl915dP8yaQ6Mrov5OsZssx8HK5BV7rkT5dCyflMcvwhtLEPwsqmkaJTOP+jgUh+zKU6wbPoFP9kOpTb5/25e52FYsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nAl2ejfa; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E2A9E0004;
	Tue,  5 Mar 2024 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709624400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9CgQs4ynqWUwnYDaz6v9W6gEUCksQOjUxkpVeVTbM0=;
	b=nAl2ejfawUP1SVqpiVTpDYCXKPoATeIBUGh8X9ova3xpF9O/qiglA1ZJYeBojmBX0IlGsZ
	8/4mXHzigKOkZaGzHZcpA/7JOiBkECFgDVh+qeYw/XYvavBe+f3M8s/qYSyg8F4zs8fb97
	MfRpZm8BHKdkEko9SuHvz77aqWsFSIWJnBVebb0jtsRL2iE/o6G3KNde+OXr+VEJyLjqQy
	Kz92Nlnf7j4NSl6K/BOQAVTyk9gzWpbSl942XtdZxKnAC5VbUNHUY4LBMcDIp2rZw6TwgO
	tsz1hodTdFz3651H5YFqfTmhw5WCzNJPCisg5ORD4oEglyZbB+8N9NVddp42wA==
Date: Tue, 5 Mar 2024 08:39:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Kyeongrho.Kim" <kr.kim@skyhighmemory.com>
Cc: "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
 "ddrokosov@sberdevices.ru" <ddrokosov@sberdevices.ru>,
 "gch981213@gmail.com" <gch981213@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mohamed
 Sardi <moh.sardi@skyhighmemory.com>, "Changsub.Shim"
 <changsub.shim@skyhighmemory.com>
Subject: Re: [PATCH] Skyhighmemory
Message-ID: <20240305083957.46e80312@xps-13>
In-Reply-To: <SE2P216MB2102DA0C880653E08D03747383222@SE2P216MB2102.KORP216.PROD.OUTLOOK.COM>
References: <20240223063522.641771-1-kr.kim@skyhighmemory.com>
	<20240223100132.142c7c07@xps-13>
	<SE2P216MB2102DA0C880653E08D03747383222@SE2P216MB2102.KORP216.PROD.OUTLOOK.COM>
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

Hello,

kr.kim@skyhighmemory.com wrote on Tue, 5 Mar 2024 02:28:31 +0000:

> Hello Miquel,
>=20
> Please find the reply in below.
>=20
> I tried to send an email using 'git send-email', but '5.1.3 Invalid addre=
ss' error is occurring, so I send it to Outlook first.

I'm sorry but I will now wait for your setup to be fixed.

> > spinand_device *spinand)  static int spinand_ecc_enable(struct spinand_=
device *spinand, =20
>=20
> >                       bool enable) =20
>=20
> >  { =20
>=20
> > +   /* SHM : always ECC enable */ =20
>=20
> > +   if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY) =20
>=20
> > +         return 0; =20
>=20
> > + =20
>=20
>=20
>=20
> Can you please move this logic to your vendor driver?
>=20
> SHM's SPI Nand must have =E2=80=9CECC Always on=E2=80=9D applied.

Why? Disabling the ECC is not possible? In this case extra care must be
taken in the driver.

>=20
> However, I think there is no way to be moved to the vendor driver.
>=20

..

> > +static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int sec=
tion, =20
>=20
> > +                           struct mtd_oob_region *region) =20
>=20
> > +{ =20
>=20
> > +   if (section) =20
>=20
> > +         return -ERANGE; =20
>=20
> > + =20
>=20
> > +   region->length =3D 0; =20
>=20
> > +   region->offset =3D mtd->oobsize; =20
>=20
>=20
>=20
> The ECC bytes are not stored anywhere?
>=20
> There is no problem because skyhigh's ecc parity is stored in the interna=
l hidden area and is not needed for them.

Please add a comment.

Thanks,
Miqu=C3=A8l

