Return-Path: <linux-kernel+bounces-50222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09F8475F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC95B2E0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A314A4E1;
	Fri,  2 Feb 2024 17:13:55 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BF7E0E5;
	Fri,  2 Feb 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894035; cv=none; b=s8+0izKH3SfPnkaTnI7AREI94M9dV4F9IAosaS2xuRk8QthBJ6iEB/qHHQW+YuZVjh/LBys+L/+0iTN8FxoJYHV9KbXTfeho8GdxE2CqvsAtTLlIjiYaKNYVwtxkJMCEzqcZY9PBXyV5IIiUtdPDPKclSNk5t5IzzRLsvFET9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894035; c=relaxed/simple;
	bh=lElrpzwWJ9AuDSU49aGfPnpNn4ZjuzEqbifxayOHxU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb9B1zMOB/wan6nHnoai2paWh7+KlYx3eESlvjUG81amC/Zq1dSJ9uHUU5Xcw2AJ90SCvYxyaa/n18fZBEc9IzjLgrpP4sCyjHeM5brVvgxSBBqsr13RhXN3VKCfo/OjcWS9uPTNWEqdFkK5Jt0sLHgFhMt/bQnRGS05721JSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bfc3c3edf9so137282b6e.0;
        Fri, 02 Feb 2024 09:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894033; x=1707498833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tui4ONM6FO3m81h+gr+b8rlOuprFlUgn1iNa4A24rug=;
        b=htndbv4dW5aqztWhiCgq7zLlgT4wlqqYSxsNdzLuQYmldbAQqU8T9tK4gbSYCcbTFT
         4IPXvG+O7rAqbXR/kxJg8lXu/5pCohv0ZUhIfO6SWUIQGFf/8buEfLkXYRw9X8DOhnVb
         Dza7Dr+A76BJhwCUWkdPfYTsRgoC796kng/Mwink6XjpIuPF+tPfgKzJPitRYvDI7x30
         iUOp/agJybGeKZAV51zbnp7oYg1DMxF7piTYL+nm2+H/DCQio7PbC2eY9lhO21eJNUwT
         agTKhALb1/bRGaUMlfijuEDgQK3O39edq871bxaWR2ToLktZDOgyXXzhXFw73/K9kCxW
         kfVQ==
X-Forwarded-Encrypted: i=0; AJvYcCXEAFgLIg2ackZti+ZZ2gJqpHEJ+DuIyMCSLuJLwb4y2XNHYeSnbJTLY5ldnpImOU9mt/FClTK5W5st55nZatAffxrXxpSsVP0lpZzLjfeoMLXutx0hOHrCWy8psJJWaw//WIoYHTZFZXrrXUhcu56Iffqa93+HY9tV6N6S6UIDnxhlkspcBIaPhfRBJrNUbM0WCNvd/7azNauurv9lOr1rMV1Ytn/VP3A=
X-Gm-Message-State: AOJu0Yygin2NlM5As1pZtYZpGBL36Bt1hwNI5ruhGvhBiZ8TeiFG/seF
	ywmTlkPndQCjmPilZ+xlSc4/k6MrcUmBuCyyvpz4MS/3i5Q/kNY+nihhBpTqFfS/v0c8miWawHo
	vyxrgOQ4b1UEQ3oer/e5eiMUwYxI=
X-Google-Smtp-Source: AGHT+IHReUBWsbjaof+2NHOSlscw9WGDiPwNeGPaYtmtsmeEBJ9/doqIvqDTOL45dhxxuUb70/N262o7qJoS9Spb41U=
X-Received: by 2002:a05:6870:c79b:b0:219:2a72:1c6d with SMTP id
 dy27-20020a056870c79b00b002192a721c6dmr1276418oab.0.1706894032878; Fri, 02
 Feb 2024 09:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0jzaGpK8LnsFDtjuPoURrwrUgM1Z2QfZhK_FUzDeK3wcw@mail.gmail.com> <e4359d2c-e686-4a97-9d21-d10908e9df61@moroto.mountain>
In-Reply-To: <e4359d2c-e686-4a97-9d21-d10908e9df61@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 18:13:41 +0100
Message-ID: <CAJZ5v0iYNPB2v7ZCynEOvWy+gz4DQUhuoJ8e7F1MXz13m_d7rw@mail.gmail.com>
Subject: Re: [PATCH v1 02/18] thermal: Add new structures and thermal_zone_device_register()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, daniel.lezcano@linaro.org, 
	miquel.raynal@bootlin.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	support.opensource@diasemi.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
	andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, niklas.soderlund@ragnatech.se, 
	srinivas.pandruvada@linux.intel.com, baolin.wang@linux.alibaba.com, 
	u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com, d-gole@ti.com, 
	linus.walleij@linaro.org, DLG-Adam.Ward.opensource@dm.renesas.com, 
	error27@gmail.com, heiko@sntech.de, hdegoede@redhat.com, 
	jernej.skrabec@gmail.com, f.fainelli@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:47=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Thu, Feb 01, 2024 at 08:24:15PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 65d8f92a9a0d..7a540b746703 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -149,7 +149,8 @@ struct thermal_cooling_device {
> > >                         passive trip point.
> > >   * @need_update:       if equals 1, thermal_zone_device_update needs=
 to be invoked.
> > >   * @ops:       operations this &thermal_zone_device supports
> > > - * @tzp:       thermal zone parameters
> > > + * @tzp:               Thermal zone parameters
> > > + * @tgp:               Thermal zone governor parameters
> > >   * @governor:  pointer to the governor for this thermal zone
> > >   * @governor_data:     private pointer for governor data
> > >   * @thermal_instances: list of &struct thermal_instance of this ther=
mal zone
> > > @@ -184,7 +185,8 @@ struct thermal_zone_device {
> > >         int prev_high_trip;
> > >         atomic_t need_update;
> > >         struct thermal_zone_device_ops *ops;
> > > -       struct thermal_zone_params *tzp;
> > > +       struct thermal_zone_platform_params *tzp;
> > > +       struct thermal_governor_params *tgp;
> >
> > I agree with doing a split here, but I'm not sure about moving items
> > from the arg list to struct thermal_zone_platform_params (as mentioned
> > above).
> >
> > Also the naming is quite inconsistent.  IMO it would be better to call
> > the first pointer "tzpp", rename struct thermal_governor_params to
> > struct thermal_zone_governor_params and call the second pointer
> > "tzgp".
> >
>
> The names "tzgp" and "tzpp" look almost identical at first glance.
> Could we increase the hamming distance somehow?

Good point.

They may as well be gov_params and platform_params AFAIAC.

