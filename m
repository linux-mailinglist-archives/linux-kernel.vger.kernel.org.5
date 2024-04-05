Return-Path: <linux-kernel+bounces-133340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5E89A27F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19248283485
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5302417165E;
	Fri,  5 Apr 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="4GgXo8zi"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE4171642;
	Fri,  5 Apr 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334535; cv=none; b=XbWcR40Jm5ykJmC+xc2RoJrPG4Q/U89ZJAp1bUuHhTsDzwfnaQGC9BaqsOwRxGIb1ftqrEBUyeK79sy3DgbhFISzUdVzJUuPFAGDy6CqeBOY/im0hp2v3z+nQLWXIzqn85ImswOmioNsbiNXNrdBbDfcjQrQlrmygeUlWL3l/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334535; c=relaxed/simple;
	bh=ls5NM0B+/Civ0aCN8LKMTAEFENbs0rB8CONYONdVqRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0XXdOGED0DLle5E744i/X790iAvhfEJDppEeVWpuEXIcNCzofDOwepw20YSem9eI10uM68+Mxu85R0DRa0+eUgItd+nYQRbMs2+FL0VS0O/Ojl1qDlxwtj2No9mSy4cKlJ0xoQWafjSZC/RE9JP+oJx9MZSbTt4lxUmYJDwfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=4GgXo8zi; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsmQi-003t4q-0f;
	Fri, 05 Apr 2024 18:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kiyAgZZxkVQWE1whPK+woYE3v42bZFnXrof4G4OJm+g=; b=4GgXo8ziqVmQH0d4yvhAIxpdcM
	1dYC/H65GIp/ywqfLixnhGfCPxgrBdcJfAiCfz4SmZTnNUjIDGcVtEab/HpEThY4F1B9BBfbYkTGa
	/yEkyQbXsZc/LlEbqYPGZvC3+J6n4blumSqyYVnEq9EiJ3HSSUf7wScysNEStcddXVu68OzhdWFeI
	PcdrHCNfMcCukTKbJMaifGIXhBvJRvn74+/FQTA3qp+6zUsamoDNGfHcFuphQ2sJ4DdqQlKX+MHAX
	gvzy/ruyGTo+vvGQ8DaoTpAJiAZlDEKSeNFuTSiV2PoMfVqm0SVYPv5H7P/VGKnoEj/+OnjeTdfem
	xCJOTB9Q==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsmQd-000PQH-1C;
	Fri, 05 Apr 2024 18:28:36 +0200
Date: Fri, 5 Apr 2024 18:28:32 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <20240405182832.4e457695@aktux>
In-Reply-To: <CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
References: <20240404222009.670685-1-andreas@kemnade.info>
	<20240404222009.670685-3-andreas@kemnade.info>
	<CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 18:13:45 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 5, 2024 at 1:20=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> >
> > As ft5426 seems to be compatible with this driver, add it.
> > Debug output during identification: Model "generic ft5x06 (79)", Rev. "=
 =20
>=20
> ...
>=20
> > @@ -1484,6 +1484,7 @@ static const struct of_device_id edt_ft5x06_of_ma=
tch[] =3D {
> >         { .compatible =3D "edt,edt-ft5206", .data =3D &edt_ft5x06_data =
},
> >         { .compatible =3D "edt,edt-ft5306", .data =3D &edt_ft5x06_data =
},
> >         { .compatible =3D "edt,edt-ft5406", .data =3D &edt_ft5x06_data =
},
> > +       { .compatible =3D "focaltech,ft5426", .data =3D &edt_ft5506_dat=
a }, =20
>=20
> Why a different vendor prefix?
> In case you need to use this one, keep the list sorted, currently this
> splits the edt,* ones.
>=20
How do I know whether to use evervision or edt instead?=20
I sorted by the numbers. Looking at datasheets for other controllers I see
https://www.displayfuture.com/Display/datasheet/controller/FT5x06.pdf
it only mentions FocalTech Systems Co., Ltd.
So how the vendor prefixes are derived?

Regards,
Andreas

