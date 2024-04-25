Return-Path: <linux-kernel+bounces-158962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38DE8B2764
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A8F1C2421C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1C14E2E2;
	Thu, 25 Apr 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="BF09zJII"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8614D715;
	Thu, 25 Apr 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065226; cv=none; b=s5WGckP6PqTNN7cluaDtCmbDyZRyrwSZ9kGyH2hvS4FsXFGzeNKis7vRjNzs0X/eCAKJDJLGbijhOziyTntnPkTpGvmQu6/vGPMurnAMpagu7eE9ZNxDIirkalo3O441IS2zsfrbhCOzeuaGZClSoxOvyVYyjY7MZrB/GIjQArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065226; c=relaxed/simple;
	bh=6foYH7QWE2i5RWLOdtEMwKdsb2KccYTN2Q/k4s5TAV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csfUj3q6qKrnAA0fMe3TVWcBVY3aqY0tGIoOHtUQemZ4Uinoicn13fDqYcT77GV35Pz+7MVFRhv8eaoBf+c6f3goVSOlqCYbDkvHsdBUnrlzJwMsqZWRnqYCl+m+5+TKtx1RE075EXyUR3VcgnA31iQ35jM6VW8e+v4rewzEVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=BF09zJII; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s02MW-000ZvV-2b;
	Thu, 25 Apr 2024 18:54:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tiBrh8Wfbv/jy2lIqssR5GnzyzHFN9L4ULdDhyCPprk=; b=BF09zJIItbQMvEhpMdlWf3E8C0
	JXoGZzZXjql074j600DVKUvMXesGkXx1Hoc1orZo2Bc68sp+DNB77gDM3H4nLdC9j1W/jCw83MSdw
	zAZZ47RtPN89pHe4xcnuzg9ENcOrEs2Nqw723CCcgelqCFrGrgcnxALBOcmmtYUJt2LGlCpN2x5i5
	ByadWtvFh7/fsn1wGHy/KjSCtfSSw3XDWq4ggOPt9j7czgGa1MxxpzDc0R1om9PwZwcatdgfT2JuR
	S0nh5vN6V1XTz308JYoAWPm7pdkpD0fTKy2hIJQ6n34tIe6k3w8RchR/7kklYGVrtKEHWn7xMVLun
	PD/tzQ5A==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s02MU-0001dn-1K;
	Thu, 25 Apr 2024 18:54:19 +0200
Date: Thu, 25 Apr 2024 18:54:17 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <20240425185417.0a5f9c19@aktux>
In-Reply-To: <CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
References: <20240404222009.670685-1-andreas@kemnade.info>
	<20240404222009.670685-3-andreas@kemnade.info>
	<CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
	<20240405182832.4e457695@aktux>
	<CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 20:21:19 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 5, 2024 at 7:28=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> > On Fri, 5 Apr 2024 18:13:45 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Fri, Apr 5, 2024 at 1:20=E2=80=AFAM Andreas Kemnade <andreas@kemna=
de.info> wrote: =20
>=20
> ...
>=20
> > > > @@ -1484,6 +1484,7 @@ static const struct of_device_id edt_ft5x06_o=
f_match[] =3D {
> > > >         { .compatible =3D "edt,edt-ft5206", .data =3D &edt_ft5x06_d=
ata },
> > > >         { .compatible =3D "edt,edt-ft5306", .data =3D &edt_ft5x06_d=
ata },
> > > >         { .compatible =3D "edt,edt-ft5406", .data =3D &edt_ft5x06_d=
ata },
> > > > +       { .compatible =3D "focaltech,ft5426", .data =3D &edt_ft5506=
_data }, =20
> > >
> > > Why a different vendor prefix?
> > > In case you need to use this one, keep the list sorted, currently this
> > > splits the edt,* ones.
> > > =20
> > How do I know whether to use evervision or edt instead? =20
>=20
> Ask DT people, the vendor-prefixes lists both...
>=20
> > I sorted by the numbers. Looking at datasheets for other controllers I =
see
> > https://www.displayfuture.com/Display/datasheet/controller/FT5x06.pdf
> > it only mentions FocalTech Systems Co., Ltd. =20
>=20
> But does the driver use that? AFAICS it uses edt. Perhaps it's due to
> a business split, not to my knowledge anyway.
>=20
Well, lets cite edt-ft5x06.rst:

"The edt-ft5x06 driver is useful for the EDT "Polytouch" family of capaciti=
ve
touch screens. Note that it is *not* suitable for other devices based on the
focaltec ft5x06 devices, since they contain vendor-specific firmware. In
particular this driver is not suitable for the Nook tablet."

So chips from focaltech which can be equipped with different firmware? So
edt prefix means EDT firmware?

Looking around I found this:
            if (tsdata->version =3D=3D EV_FT)
                        swap(x, y);
..
               case 0x59:  /* Evervision Display with FT5xx6 TS */
                        tsdata->version =3D EV_FT;

I need swap(x.y), I am using touchscreen-swapped-x-y property now.
So evervision prefix?

Regards,
Andreas

