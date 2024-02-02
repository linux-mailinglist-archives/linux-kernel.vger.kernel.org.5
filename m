Return-Path: <linux-kernel+bounces-50262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA5847686
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490D41F21770
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067131509A5;
	Fri,  2 Feb 2024 17:44:47 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E814C5A5;
	Fri,  2 Feb 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895886; cv=none; b=TY98Ob27pFwq9kxecN51XgFORR4lkbxM0dWmth0SOc4/afe7ag7IFiDgi9tuIqylhI3K+a1FzdQT4qs5ME048Rj6HjGBlmFWdGob/FejtsxqkZReipwyjAJsNtkNzSpRIpFbtqYNrqhh9V5SxmU9kHQiRBINaAIputj92gJyvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895886; c=relaxed/simple;
	bh=nUvW4QgvgMzrNCuM4aoF4fhRaCDzxOnbBr4i29R593s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQgWGC40BYCgrX/eKaT1ngJqN1OSG/UIuSjKgyMVlTyZp58A5b6d7e0p43NX7tmSwzBeGYfymqjpkzA2h4Or7PbL/9Dyk/sJYHLwb84DtJyJ5WOGwHpgXK1CXzEQ11nvOrbWPY4ih1fp4X5EKpFLLnLiD2gjbGStp7s01P/RHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a134e29d2so482975eaf.0;
        Fri, 02 Feb 2024 09:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895884; x=1707500684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhrDnO/nyG788E/DYMuZU0L8OwH2O1WxX9d2hEHfIBU=;
        b=FDf5xGD2Lz6WybmZHFdsvPSGnpDJspPJ5z6GNIeDGpr0Y7H39kH7GUxStOAEEkZWCX
         H4cMlDmy0gk0Es1h5x/cLQ5YtOQj+pMVPa4qACZEecza1SobednsnOrMUiHf6kwUHcKZ
         7dpp2YIhcbOofGqZArn8uO8QjhzA3ODkEZ9SOGqGlnt2+b5WhNjw3WkI4QCAQm3uNfjA
         DD09oIRvnA7r2GRmkT8icd/XWgaCBbY6XmEdRPzWEbyB3i/kwtP8DFkTb4ddVBhtvwwA
         eIi8Qhvu2r1x+8tCZZnwhYdyTcpDTCCo4f/uGOJBGv7uatUVSFIWuYOh8J+Ryen1CcZt
         ZObQ==
X-Gm-Message-State: AOJu0YzUWmnFR5nlVxHodB6YTcwis39zVLQCXnqpH+o9VKmi/VrwWDym
	kxQBtbEfhVa38jOiwhpn5H2Q9s9NxDmSOstRUw3yWYkd+zc9Z2XRndDa6k5kwPGDbxmg/5MIfQm
	O4iCHXSHUU5Wp8+2Z119D3LM+Nxk=
X-Google-Smtp-Source: AGHT+IFnvz5E4iMruD6Mh8TJFvkZYNiSVrw1HRRvU//vl6ihBzs7LRqsePvtO8/EjY4nqso14Y/Tcr+aZ+CU6XV+fvk=
X-Received: by 2002:a4a:ee92:0:b0:599:a348:c582 with SMTP id
 dk18-20020a4aee92000000b00599a348c582mr6515087oob.1.1706895883854; Fri, 02
 Feb 2024 09:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-9-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0ifn7eg9WrpNF2_PB62gE_BzV2Vx5_k7ebOoZWdQNVWaQ@mail.gmail.com> <eec1d1f7-6d8f-46e9-8ce5-4d7319da7d9e@collabora.com>
In-Reply-To: <eec1d1f7-6d8f-46e9-8ce5-4d7319da7d9e@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 18:44:32 +0100
Message-ID: <CAJZ5v0iEWSbbouzRgzEg3sYJ63bRYCBSrCNfT-PrHbOwH0LYOg@mail.gmail.com>
Subject: Re: [PATCH v1 08/18] thermal: intel: pch_thermal: Migrate to thermal_zone_device_register()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:10=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/02/24 20:51, Rafael J. Wysocki ha scritto:
> > On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> The thermal API has a new thermal_zone_device_register() function whic=
h
> >> is deprecating the older thermal_zone_device_register_with_trips() and
> >> thermal_tripless_zone_device_register().
> >>
> >> Migrate to the new thermal zone device registration function.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   drivers/thermal/intel/intel_pch_thermal.c | 12 ++++++++----
> >>   1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/therm=
al/intel/intel_pch_thermal.c
> >> index b3905e34c507..73d7c2ac7dbc 100644
> >> --- a/drivers/thermal/intel/intel_pch_thermal.c
> >> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> >> @@ -160,6 +160,7 @@ static int intel_pch_thermal_probe(struct pci_dev =
*pdev,
> >>                                     const struct pci_device_id *id)
> >>   {
> >>          enum pch_board_ids board_id =3D id->driver_data;
> >> +       struct thermal_zone_device_params tzdp;
> >>          struct pch_thermal_device *ptd;
> >>          int nr_trips =3D 0;
> >>          u16 trip_temp;
> >> @@ -233,10 +234,13 @@ static int intel_pch_thermal_probe(struct pci_de=
v *pdev,
> >>
> >>          nr_trips +=3D pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
> >>
> >> -       ptd->tzd =3D thermal_zone_device_register_with_trips(board_nam=
es[board_id],
> >> -                                                          ptd->trips,=
 nr_trips,
> >> -                                                          0, ptd, &tz=
d_ops,
> >> -                                                          NULL, 0, 0)=
;
> >> +       tzdp.tzp.type =3D board_names[board_id];
> >> +       tzdp.tzp.devdata =3D ptd;
> >> +       tzdp.tzp.trips =3D ptd->trips;
> >> +       tzdp.tzp.num_trips =3D nr_trips;
> >> +       tzdp.tzp.ops =3D &tzd_ops;
> >> +
> >> +       ptd->tzd =3D thermal_zone_device_register(&tzdp);
> >
> > IMV, this should be
> >
> > ptd->tzd =3D thermal_zone_device_register(board_names[board_id],
> > ptd->trips, nr_trips, &tzd_ops, ptd, NULL);
> >
> > and the tzdp variable is not necessary even.
> >
>
> The whole point of thermal_zone_device_register() taking just one paramet=
er was
> that those older functions were taking a bit too many params, and with th=
e
> introduction of Thermal Zone name we'd be adding even more.

That's fair.

However, as indicated elsewhere, there are at least a few arguments of
the registration function that fit into the argument list: trips[],
num_trips, ops, devdata.

I'd add the name to that list and put the rest (including type) into
the params struct.

> For intel_pch_thermal, things are more or less the same, assignments are =
done there
> line by line... but for most of the others, IMO it's easier and schematiz=
ed as a
> single stack-initialized structure that could even be constified in the f=
uture.

Well, it's copied into the struct thermal_zone_device, so it's better
to put it one the stack, so the memory occupied by it gets freed when
not needed any more.

