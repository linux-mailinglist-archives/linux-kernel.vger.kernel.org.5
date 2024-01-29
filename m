Return-Path: <linux-kernel+bounces-43184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF2840D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6757287AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5618159591;
	Mon, 29 Jan 2024 17:07:35 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FE157E67;
	Mon, 29 Jan 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548055; cv=none; b=b0aai0OYFwa9qyVPbdVn2viIoEQhCh/4ZlGoq6Oq5cHxnfYnKpt6oWTKipt/iHu7M6QZ/D3O8cqjLDWl6iHuK3vkD26lzfaNipID5z+zJO6aDsYS/xv3ujKqjiojejeZJM0m2K3buz34Kn+s60sKa0QGSVUzimKpoteWT/ekRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548055; c=relaxed/simple;
	bh=Dw40eiuSwc6UvSuD5Twmobfqt27Fhk6CjmchyhrvpXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esVcx6LxwTRB7bBjZqaCxj++1gmng4KfMr7zpp2Es92CAJEBMuFPjy+bWxJPkfEW4mtE3XulvTphgsLpYVTncnGYD9NeNlKRFDkJL74cjf94+zvDgeVRf5zQym2sJwWggt2AAanxnoQRKDan2/PzBRHFZXpYyhuZx1w6Lh4s3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-214309bbbf0so63963fac.1;
        Mon, 29 Jan 2024 09:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548052; x=1707152852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgtrFrE7cKwimz6gW2LR5nb/tAR8mHNmJDdeg+RBNBU=;
        b=LuDX1OC8/iNzlnwYJMoNoE4y1mvXA7SZy2/zrPVjNikch2isS21tX9imT+jF+VNB2v
         6edfhi11LVZhhdSm8Z37/oJYbsGFJvXVB5mB6X03spwqxWCFb3KODzPeg93fhSssh+vx
         MY11H54/qJZjhR9TrhK/Yl6b3h/7h20AqCUN6XlVA+77yUWaLRGq/rWGJHCR8smaBRf/
         YIBWXCXv7DNKwoXExl6QHJaljn9AVd/3ox3nVvauaXiFb4wESd5mzcOVM1A2PYqss2uv
         GJqkccq/6KiRcfEarhcN25Jr1NQ1KcB9OfD7JCxaN6CaelqnO/qtx3RK2LSUOuXCl73S
         Xf7Q==
X-Gm-Message-State: AOJu0YxU+iSxj+kBvJPdshFtnrWIyVGZa2iHP0FpRE9YwaLP2UEM0OD3
	YC2WgB7o1itxAZbD7HzGigjpN/yT2Rmb/SuPO6zQPTsjhmh2FDE/IYs1P2gja/EupoRaNaFga1s
	lZ0OI9gccJJf6ygcPdkjzvVGeVCk=
X-Google-Smtp-Source: AGHT+IHxjx6MVIcNk7cn+/xdmKYbRxLgAF+okKcq4cj2FpaD0kDdSba5yuR+8NsQSRrhI5BYclr87y0DGlHMawJ61wQ=
X-Received: by 2002:a05:6870:7f01:b0:218:5412:5f2d with SMTP id
 xa1-20020a0568707f0100b0021854125f2dmr6178099oab.0.1706548052217; Mon, 29 Jan
 2024 09:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com> <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
 <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org> <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
 <41b284d7-e31f-48b5-8b21-0dca3e23cb1c@linaro.org> <CAJZ5v0ina=7R6x6Ff=8_rRR9Kkmz2tkojbs_WWCN=JPmzhg+HQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ina=7R6x6Ff=8_rRR9Kkmz2tkojbs_WWCN=JPmzhg+HQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 18:07:20 +0100
Message-ID: <CAJZ5v0hM9Y+cV7WrEHe6WjzQ0ATnBce4NO1wxvZh=fcLWPkqKA@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:19=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Jan 18, 2024 at 11:25=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 17/01/2024 19:49, Rafael J. Wysocki wrote:
> > > On Wed, Jan 17, 2024 at 5:57=E2=80=AFPM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 10/01/2024 13:48, Rafael J. Wysocki wrote:
> > >>> Hi Manaf,
> > >>>
> > >>> On Wed, Jan 10, 2024 at 9:17=E2=80=AFAM Manaf Meethalavalappu Palli=
kunhi
> > >>> <quic_manafm@quicinc.com> wrote:
> > >>>>
> > >>>> Hi Rafael,
> > >>>>
> > >>>> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
> > >>>>
> > >>>> On Sat, Jan 6, 2024 at 8:16=E2=80=AFPM Manaf Meethalavalappu Palli=
kunhi
> > >>>> <quic_manafm@quicinc.com> wrote:
> > >>>>
> > >>>> The commit 2e38a2a981b2("thermal/core: Add a generic
> > >>>> thermal_zone_set_trip() function") adds the support to update
> > >>>> trip hysteresis even if set_trip_hyst() operation is not defined.
> > >>>> But during hysteresis attribute creation, if this operation is
> > >>>> defined then only it enables hysteresis write access. It leads
> > >>>> to a case where hysteresis sysfs will be read only for a thermal
> > >>>> zone when its set_trip_hyst() operation is not defined.
> > >>>>
> > >>>> Which is by design.
> > >>>>
> > >>>> I think it is regression after recent re-work. If a sensor is regi=
stered with thermal framework via thermal_of,
> > >>>>
> > >>>> sensor driver doesn't need to know the trip configuration and noth=
ing to do with set_trip_hyst() in driver.
> > >>>>
> > >>>> Without this change, if a sensor needs to be monitored from usersp=
ace(trip/hysteresis),
> > >>>
> > >>> What exactly do you mean by "monitored" here?
> > >>>
> > >>>> it is enforcing sensor driver to add  dummy set_trip_hyst() operat=
ion. Correct me otherwise
> > >>>
> > >>> With the current design, whether or not trip properties can be upda=
ted
> > >>> by user space is a thermal zone property expressed by the presence =
of
> > >>> the set_trip_* operations, so yes, whoever registers the thermal zo=
ne
> > >>> needs to provide those so that user space can update the trip
> > >>> properties.
> > >>>
> > >>>> For some thermal zone types (eg. acpi), updating trip hysteresis v=
ia
> > >>>> sysfs might lead to incorrect behavior.
> > >>>>
> > >>>> To address this issue, is it okay to  guard  hysteresis write perm=
ission under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?
> > >>>
> > >>> Not really, because it would affect all of the thermal zones then.
> > >>
> > >> It seems like there is an inconsistency here with the writable trip
> > >> points and the writable hysteresis [1].
> > >>
> > >> My understanding is it does not make sense to have the hysteresis
> > >> writable even if the driver has a hysteresis dedicated ops. The code
> > >> allowing to change the hysteresis was done regardless the consistenc=
y
> > >> with the trip temperature change and writable trip points kernel opt=
ion IMO.
> > >>
> > >> It would make sense to have:
> > >>
> > >> if enabled(CONFIG_WRITABLE_TRIP_POINT)
> > >>    -> trip_temp RW
> > >>    -> trip_hyst RW
> > >> else
> > >>    -> trip temp RO
> > >>    -> trip hyst RO
> > >> fi
> > >>
> > >> But if the interface exists since a long time, we may not want to ch=
ange
> > >> it, right ?
> > >
> > > If the platform firmware implements hysteresis by changing trip
> > > temperature (as recommended by the ACPI specification, for example),
> > > modifying the trip hysteresis via sysfs is simply incorrect and user
> > > space may not know that.
> > >
> > >> However, we can take the opportunity to introduce a new 'user' trip
> > >> point type in order to let the userspace to have dedicated trip poin=
t
> > >> and receive temperature notifications [2]
> > >>
> > >>> TBH, the exact scenario in which user space needs to update trip
> > >>> hysteresis is not particularly clear to me, so can you provide some
> > >>> more details, please?
> > >>
> > >> IIUC changing the hysteresis value is useful because the temperature
> > >> speed will vary given the thermal contribution of the components
> > >> surrounding the thermal zone, that includes the ambient temperature.
> > >>
> > >> However, that may apply to slow speed temperature sensor like the sk=
in
> > >> temperature sensor where we may to do small hysteresis variation.
> > >>
> > >> The places managed by the kernel have an insane temperature transiti=
on
> > >> speed. The userspace is unable to follow this speed and manage the
> > >> hysteresis on the fly.
> > >>
> > >> So that brings us to userspace trip point handling again.
> > >
> > > Well, I've already said that whether hysteresis can be modified via
> > > sysfs is a property of a thermal zone.
> >
> > > It may as well be a trip property, for example expressed via a (new)
> > > trip flag set in the trips table used for thermal zone registration.
> >
> > Yes, a trip property makes more sense.
> >
> > I'm a bit lost about WRITABLE_TRIP_POINT, writable hysteresis, read-onl=
y
> > temperature trip.
> >
> > Can we have a hysteresis writable but not the temperature ?
> >
> > You mentioned above "modifying the trip hysteresis via sysfs is simply
> > incorrect", so shall we allow that at the end?
> >
> > Is it possible to recap the situation?
>
> Sure, which is a good idea BTW.
>
> First off, the callers of thermal_zone_device_register_with_trips()
> need to pass a mask of writeable trip points to it.  If the mask is 0,
> none of the trip attributes are writeable for any trips.
>
> However, the mask only takes effect if CONFIG_THERMAL_WRITABLE_TRIPS
> is set.  Otherwise, it is not taken into account at all.
>
> Now, if CONFIG_THERMAL_WRITABLE_TRIPS is set, it only affects the trip
> temperature, which is a bit inconsistent.
>
> Moreover, the hysteresis is allowed to be updated unconditionally if
> tz->ops->set_trip_hyst is not NULL, which is even more inconsistent.
>
> So, because it already is only enabled if the creator of the thermal
> zone asks for it explicitly, it would be fine by me to simply allow
> the hysteresis to be updated if the temperature is allowed to be
> updated.
>
> IOW, something like the patch below (unstested, white space messed-up by =
gmail).
>
> If this looks OK to everyone from the functionality perspective, I can
> submit it properly with a changelog etc.
>
> ---
>  drivers/thermal/thermal_sysfs.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
>                      tz->trip_hyst_attrs[indx].name;
>          tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
>          tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show;
> -        if (tz->ops->set_trip_hyst) {
> +        if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
> +            mask & (1 << indx)) {
>              tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
>              tz->trip_hyst_attrs[indx].attr.store =3D
>                      trip_point_hyst_store;

So it looks like I need to submit this, even though I'm not sure if
anyone cares.

In any case, I care about consistency.

