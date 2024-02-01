Return-Path: <linux-kernel+bounces-48790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F9846174
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED34B267FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404085626;
	Thu,  1 Feb 2024 19:52:09 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0843AC7;
	Thu,  1 Feb 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817129; cv=none; b=iNXZbCq815JhDAzz4Wvj1CDZFmhjy370wFoz47rk8lMBQuXXKYbmkmHqJGuQTYIElqRxfnsO8WEEjy3BBUvhGDacQJtaDizTNSFDZTbQy3zDXmTs9rWyYlpJxYk0k1fG93v6j+Isfr8oLc72Y69AeafykfUJZysbNaLXM0OA1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817129; c=relaxed/simple;
	bh=Xew4gfla9jXfDUHncBpGBh9XjFEK7ZSm6CBMFGhAqEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m37LC7QVhCxkQzfCNuMPT1lkNcXeHkq4I+Nnz6k4+VnQ/nfAsCBJ5Wfij6HkSAQNUiURX/qkWStFroctgYjT9RvrisKzXPV8T1B4+oMiozrL+WPj0++scjo5iMHeok0eHtkTnw1RCL57h0hOeu702uxYxj2TXhXMB168G9zCBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5958b9cda7aso277826eaf.0;
        Thu, 01 Feb 2024 11:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817127; x=1707421927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBl5ou+TD9Mfvm1lNPShNlGf1pFR7KSH1sVazZHfCoo=;
        b=TNNH+viGuZzgzeZCrGkeHKnAVu2odmk3BtRhzeh3LmS06uvU2seKKDZLz3sQc3tbsF
         bcttPTPeYiaeeJTqLVN+vvrUcrAO6iDBH8fRzff6fMS1SmgnemkgqViG7GtjWtBizUgN
         8chO3mWbXgHlsxtcGnS1WGVfjxTimpj5X5it6dJ3iyjUaMKfNXgwS3kBt07vR10J0AqH
         Qooz/pTzSF5XwsN5sAaallTLkD38ENyxtHMvb4AqvTVYT6K5b15nZdZOAzrqIB+UomZq
         kESozfZWjfV2GDN8FxPwYMR3sgSFFxJGCvBzq57ONbwmad++Xss3d3Y21FbQDn+xWPgK
         5d4w==
X-Gm-Message-State: AOJu0YzfCVH1BzQ348nm/xSrSzysAv969o1xlbLbju7Y0aQ1SnlZmLNN
	siQ6lpJUCQsP3wA5q1NjvlKVgOArFOF5mPso00GhOARWCirOGq/Bsn+pfncJkK71YMM8VJJZ1jy
	hzmgXjSnmsGOSLTvHpuRR1GOf+eY=
X-Google-Smtp-Source: AGHT+IGIX57rgCOZHcRSzGZQRMQVAH2ftzlN0hg9CMRZtySZdlSrx6EQamzGXxueyqs1l1rdkWQ36d9/JVVygPbihns=
X-Received: by 2002:a05:6820:2c8a:b0:59a:bfb:f556 with SMTP id
 dx10-20020a0568202c8a00b0059a0bfbf556mr3738842oob.0.1706817127183; Thu, 01
 Feb 2024 11:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com> <20240130111250.185718-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-9-angelogioacchino.delregno@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 20:51:56 +0100
Message-ID: <CAJZ5v0ifn7eg9WrpNF2_PB62gE_BzV2Vx5_k7ebOoZWdQNVWaQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/18] thermal: intel: pch_thermal: Migrate to thermal_zone_device_register()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org, 
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

On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The thermal API has a new thermal_zone_device_register() function which
> is deprecating the older thermal_zone_device_register_with_trips() and
> thermal_tripless_zone_device_register().
>
> Migrate to the new thermal zone device registration function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/=
intel/intel_pch_thermal.c
> index b3905e34c507..73d7c2ac7dbc 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -160,6 +160,7 @@ static int intel_pch_thermal_probe(struct pci_dev *pd=
ev,
>                                    const struct pci_device_id *id)
>  {
>         enum pch_board_ids board_id =3D id->driver_data;
> +       struct thermal_zone_device_params tzdp;
>         struct pch_thermal_device *ptd;
>         int nr_trips =3D 0;
>         u16 trip_temp;
> @@ -233,10 +234,13 @@ static int intel_pch_thermal_probe(struct pci_dev *=
pdev,
>
>         nr_trips +=3D pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
>
> -       ptd->tzd =3D thermal_zone_device_register_with_trips(board_names[=
board_id],
> -                                                          ptd->trips, nr=
_trips,
> -                                                          0, ptd, &tzd_o=
ps,
> -                                                          NULL, 0, 0);
> +       tzdp.tzp.type =3D board_names[board_id];
> +       tzdp.tzp.devdata =3D ptd;
> +       tzdp.tzp.trips =3D ptd->trips;
> +       tzdp.tzp.num_trips =3D nr_trips;
> +       tzdp.tzp.ops =3D &tzd_ops;
> +
> +       ptd->tzd =3D thermal_zone_device_register(&tzdp);

IMV, this should be

ptd->tzd =3D thermal_zone_device_register(board_names[board_id],
ptd->trips, nr_trips, &tzd_ops, ptd, NULL);

and the tzdp variable is not necessary even.

Analogously in the rest of the series (ie. patches [4-18/18]).

>         if (IS_ERR(ptd->tzd)) {
>                 dev_err(&pdev->dev, "Failed to register thermal zone %s\n=
",
>                         board_names[board_id]);
> --

