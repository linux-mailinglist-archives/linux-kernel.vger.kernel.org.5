Return-Path: <linux-kernel+bounces-133487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399E89A46F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52501C21CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D7172BA4;
	Fri,  5 Apr 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AVyLVVCb"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B98172797;
	Fri,  5 Apr 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343428; cv=none; b=gzErBedUxiLO8avz5QgiZslNvqTUIFAQb0HbwJfrTuCmgRcMa0qA09/ObAI0Hpc1BbXYVJdDRN6jg85Uhl0Diu15VZUHWEwsHD31CleeZQTrWIc9s5XYeO4BiktnREjk9lYrwiNYz7ofYzbHQnCdnWaZY3Iz2FBuQTAZCC3gboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343428; c=relaxed/simple;
	bh=vnYEQ17KysvX7LO1gsXCZ7bQP+q4ViwuQl1/8sCVlOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaEVbS1dAGy0qGY2EDIT4rnFOWLUpyAOvSvQZ2IV/2UxtYLlykC7WpzzoZofKOJRzxdm0ANu51Zk6+hR7mir81pc0fjm2zBwSugn9KNssiR6aaLWMlDTU0PPpOt2NGT+1CF0T3ON8RuDDztuGLyltcRGgqeR481B2LPvCxrNpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=AVyLVVCb; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsokE-003tJv-0p;
	Fri, 05 Apr 2024 20:56:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ogE4OYrDq5iNX0qpphDnVQy5Okj2XC66c4JZZyH1L24=; b=AVyLVVCbDK7rv9n92vw1sNlfhL
	HP85XOMdLA6kVEjQKAz4eq66qdjYEJRVaexEHVTjt9k/JSzRmwxLa2vK1tvYdXiGSfeyNCMlfJBmn
	DzOIyIkJ8Q0RhBdujYKspXHhznntU3crbTg84qfAYw2kMRgPWBppeOgJkXkO4GgYcM+y65fxYgMsa
	UUEzR3U1IAcf3ca8DG/Vr01tkvz5c2NJvJoMm1SANA6jaIDcl4CdoupHje36LBYSBbzzneTl0osCi
	x5H2WN3OVt0a4mhqzvlulKQcYd+Tft8AFOwTjwtvjk3SfKpHx7NSLhQbgQr/3HYCqTp2zrJJFnf00
	OOKU3vAg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsokB-000Pe2-1H;
	Fri, 05 Apr 2024 20:56:55 +0200
Date: Fri, 5 Apr 2024 20:56:53 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
Message-ID: <20240405205653.32bdcb75@aktux>
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
well, the fact is that there were several tried to add duplicates to this
driver to the kernel using focaltech prefixes e.g.
https://lore.kernel.org/linux-input/47209259-9e57-f263-bf48-10f233c63b69@re=
dhat.com/

My guess it is somehow about owner of the firmware in the chip vs the chip =
itself.

Regards,
Andreas

