Return-Path: <linux-kernel+bounces-159664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51C8B31C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ECA281ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF113C8F7;
	Fri, 26 Apr 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="wW52gZZu"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BC13A271;
	Fri, 26 Apr 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118191; cv=none; b=Q8EkFW4LSpxchrI8D6b3D7FyenxbGXL2+vtvqQ4sBE1IGI0Pv5w38q7SbEH+ZQ369VIDVEVF8AJdF9mOCicvBbKqjNR0Tzq5lxc8CsI1p6YYNy3HS+4hvQVCuhVkWnweIT6nCfv/YNCAUfAWP1XGvOmeKpB1+7BsYYn5aqjzOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118191; c=relaxed/simple;
	bh=/oA1gWLJ772cy7dGtf/b943XB9Mt5AyNlRJvMHs+7cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTatcABKHwbOQxO0d7zAt/TbjWyu38AP2JYjvhDJtA1U+Uqw+30HUHgPGkQ6lNNDK/asVVX1Okgdg8lQjgG1bwQelDMMerSam/n31M4A9coDTDmXNSOpFKCdVEbYRgvgRMGLGktz9w7GjwGNFjU0QX7Y7q7ntYtq6TUOFrm4x0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=wW52gZZu; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s0GRR-001Fow-2S;
	Fri, 26 Apr 2024 09:56:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eN3ukgRV0UMxzWE3czcAWiLOWP8d0N+EaAA0gs4p+vs=; b=wW52gZZuXVW6afGr8W9dJMtSAb
	F7Bt1AV1GQFfX5W6n9ce6T43GsIkB3/iaXRY0QYDZj/JF3CjWWA+bE3wArpTnRb8o0Ej3RCK1S2HR
	M5ogkpkh/rhwymhu3xzHMOgkWRoBkKEWyrB1vgy1Lk3bVbCaL1lhrj7bmkAVWhayx6beih6ROKPtc
	QZm60ESl+JwH0xgVGfWAm3JV9pvGO9yj+o5waDq9vMSjlI3MunlOmk5JW+1nLNN/uraGQ5c5iaNiS
	5axiVdrtu4nJhHKjmU+u5NORSZoxMJx6Bx6x+Z7RLf1u+W6sUcTD5hRSETzfCtX+SLV4dhjlBVCMi
	srZlBGQg==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s0GRO-0003kO-1l;
	Fri, 26 Apr 2024 09:56:19 +0200
Date: Fri, 26 Apr 2024 09:56:17 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Felix Kaechele <felix@kaechele.ca>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dmitry.torokhov@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <20240426095617.4e442681@aktux>
In-Reply-To: <7dd1eb70-b011-4247-aea9-173ddcd17dc7@kaechele.ca>
References: <20240404222009.670685-1-andreas@kemnade.info>
	<20240404222009.670685-3-andreas@kemnade.info>
	<CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
	<20240405182832.4e457695@aktux>
	<CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
	<20240425185417.0a5f9c19@aktux>
	<7dd1eb70-b011-4247-aea9-173ddcd17dc7@kaechele.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024 22:54:13 -0400
Felix Kaechele <felix@kaechele.ca> wrote:

> On 2024-04-25 12:54, Andreas Kemnade wrote:
> > On Fri, 5 Apr 2024 20:21:19 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > =20
> >> On Fri, Apr 5, 2024 at 7:28=E2=80=AFPM Andreas Kemnade <andreas@kemnad=
e.info> wrote: >>> On Fri, 5 Apr 2024 18:13:45 +0300 =20
> >>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
>=20
> ...
>=20
> >>>> Why a different vendor prefix? =20
>=20
> ...
>=20
> >>> I sorted by the numbers. Looking at datasheets for other controllers =
I see >>> https://www.displayfuture.com/Display/datasheet/controller/FT5x06=
pdf
> >>> it only mentions FocalTech Systems Co., Ltd. =20
> >>
> >> But does the driver use that? AFAICS it uses edt. Perhaps it's due to
> >> a business split, not to my knowledge anyway. =20
>=20
> I've been looking into this over the past few weeks as I was working on=20
> mainline support for an Android device.
> And please forgive me if any of the following is not fully accurate, I'm=
=20
> not an industry expert.
>=20
> After some research, my understanding of this is as follows:
>=20
> - There are companies that make touch ICs, LCD driver ICs and sometimes=20
> even ICs that are both. Focaltech or Himax are examples of such companies.
>=20
> - There are companies that make LCMs. These are complete assemblies of=20
> panel, backlight, touch layer and driver circuitry PCBs. This is what=20
> OEMs generally purchase when they design a consumer device. Emerging=20
> Display Technologies Corp. (EDT) is such a LCM manufacturing company.=20
> More often than not LCM manufacturers do not make their own driver ICs.
>=20
> LCM manufacturers include ICs from Focaltech in their LCMs.
> To my knowledge Focaltech is not a manufacturer of LCMs.
>=20
> As such, an interpretation of the compatible string "edt,edt-ft5406"=20
> could be: Unspecified EDT LCM with Focaltech FT5406 IC.
>=20
>  From my perspective, more correct would either be something like=20
> "edt,etm070001bdh6" (the LCM by EDT that contains this IC, especially if=
=20
> it had model specific quirks) or "focaltech,ft5406".
> But "edt,edt-ft5406" is incorrect if being specific is the goal here.
> Given that the driver predates much of the DT binding rigour it's what=20
> we have now though.
>=20
I think focaltech,ft5406 is better because it is consistent with other driv=
ers/
bindings. We do not specify the display it is used on on other touchscreen
bindings. We do not specify the actual LEDs behind a LED interface chip.
And often the chip name is more easily to find out than the name of a
display.
[...]

> I don't think that's how the compatible strings are used today, but it=20
> is what would make sense in my opinion.
>=20
> > Looking around I found this:
> >              if (tsdata->version =3D=3D EV_FT)
> >                          swap(x, y);
> > ...
> >                 case 0x59:  /* Evervision Display with FT5xx6 TS */
> >                          tsdata->version =3D EV_FT;
> >
> > I need swap(x.y), I am using touchscreen-swapped-x-y property now.
> > So evervision prefix? =20
>=20
> The compatible string doesn't have any bearing on whether x and y are=20
> swapped. The driver relies on its device detection heuristic for that=20
> determination.

Well, I think, yes, it could have a bearing, on some models, maybe x is
swapped with some pressure value in some record.

> Ideally, the driver would allow describing this property
>=20
>    1. in the devicetree using the "touchscreen-swapped-x-y" property=20
> from the common touchscreen bindings
>=20
It allows that right now.
Well, the devicetree should be driver/os independent, so it describes the
hardware. so the driver should spit out the records specified as x
in the chip manual as x and the ones specified as y as y.

If the display is then wired up to the controller in an unusual way,
it can be compensated by the devicetree specification (if we go the
focaltech,ftxxxx road instead of edt,etm070001bdh6).=20

But datasheets... where are you? So we need a heuristic. I guess
the order used most is probably the one used in the data sheet.

>    2. by extending the edt_i2c_chip_data struct to hold that property=20
> and set it based on the compatible string if it is, in fact, a property=20
> of that specific IC
>=20
yes, agreed.

Regards,
Andreas

