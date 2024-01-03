Return-Path: <linux-kernel+bounces-15954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ECC823632
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D243F282A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28DC1D525;
	Wed,  3 Jan 2024 20:09:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE91D692;
	Wed,  3 Jan 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-594363b4783so347704eaf.1;
        Wed, 03 Jan 2024 12:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312580; x=1704917380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZOqC+vh8nhBkqQBS+jkEHlXm5GbUXDC2IWE5XgtUcw=;
        b=W4yZCJtrMnIEAwJiRbxeRibdxJNLSbttUrq4IhtLOBnihFvFL01XHmClBUlMsoWNyW
         zqk6b0tlizWQXuccc8TRMagKEjyan8h+n8BSzBgAPi8wmYrw2i5RsAveKxo3GqRkOoL7
         ZZCkE+z/4XFGHqttPBTrESoBPzJMMlbJHgChN+avqZ8TnE9BfIT1bcNicf9iYuE3Yauz
         /z9lloxYog6RNCnPl3wMz4AMxnfmcE+FYVmLgul19/bunqrYvXFyObt9qmPlDhVYyDxb
         L9Y8SdgEz3sx3HajPJN39uHFd3Pd2iXmws13IA/q72Z2oeOkFTuyK6YiAX+Bildvr5FO
         8lLg==
X-Gm-Message-State: AOJu0YxXORmARHd3FlvIzSExmxOe27tpObmUW9gFT12aljdh57m60lK/
	NZHIeeRSQbpqAdlebrhgrzUlMRN+atofS9ulDcY=
X-Google-Smtp-Source: AGHT+IFGRBo6mDTu/6Go6p6Xvr+1jM4RYFUjBFAq+gr8WyiRnKRMQs1ciEaJ9M3mqO4WwE5lS20MjnN9DH9qyoi1XlE=
X-Received: by 2002:a05:6820:2e01:b0:594:35b4:8a with SMTP id
 ec1-20020a0568202e0100b0059435b4008amr27264639oob.0.1704312579904; Wed, 03
 Jan 2024 12:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher> <2938222.e9J7NaK4W3@kreacher> <24822e06-1e5e-41e8-9f68-8fa82b1b11d4@arm.com>
In-Reply-To: <24822e06-1e5e-41e8-9f68-8fa82b1b11d4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 21:09:28 +0100
Message-ID: <CAJZ5v0jcC=Apc8U3G6qKAXBHOJ2Q0RF4DE8dvgtE8jozRzg7cg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] thermal: netlink: Pass pointers to thermal_notify_tz_trip_change()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:57=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 12/15/23 19:56, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of requiring the caller of thermal_notify_tz_trip_change() to
> > provide specific values needed to populate struct param in it, make it
> > extract those values from objects passed to it by the caller via const
> > pointers.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_netlink.c |   12 +++++++-----
> >   drivers/thermal/thermal_netlink.h |    8 ++++----
> >   drivers/thermal/thermal_trip.c    |    8 ++------
> >   3 files changed, 13 insertions(+), 15 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_netlink.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> > +++ linux-pm/drivers/thermal/thermal_netlink.c
> > @@ -361,12 +361,14 @@ int thermal_notify_tz_trip_delete(int tz
> >       return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE,=
 &p);
> >   }
> >
> > -int thermal_notify_tz_trip_change(int tz_id, int trip_id, int trip_typ=
e,
> > -                               int trip_temp, int trip_hyst)
> > +int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz=
,
> > +                               const struct thermal_trip *trip)
> >   {
> > -     struct param p =3D { .tz_id =3D tz_id, .trip_id =3D trip_id,
> > -                        .trip_type =3D trip_type, .trip_temp =3D trip_=
temp,
> > -                        .trip_hyst =3D trip_hyst };
> > +     struct param p =3D { .tz_id =3D tz->id,
> > +                        .trip_id =3D thermal_zone_trip_id(tz, trip),
> > +                        .trip_type =3D trip->type,
> > +                        .trip_temp =3D trip->temperature,
> > +                        .trip_hyst =3D trip->hysteresis };
> >
> >       return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE,=
 &p);
> >   }
> > Index: linux-pm/drivers/thermal/thermal_netlink.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> > +++ linux-pm/drivers/thermal/thermal_netlink.h
> > @@ -23,8 +23,8 @@ int thermal_notify_tz_trip_up(int tz_id,
> >   int thermal_notify_tz_trip_delete(int tz_id, int id);
> >   int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> >                              int temp, int hyst);
> > -int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> > -                               int temp, int hyst);
> > +int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz=
,
> > +                               const struct thermal_trip *trip);
> >   int thermal_notify_cdev_state_update(int cdev_id, int state);
> >   int thermal_notify_cdev_add(int cdev_id, const char *name, int max_st=
ate);
> >   int thermal_notify_cdev_delete(int cdev_id);
> > @@ -79,8 +79,8 @@ static inline int thermal_notify_tz_trip
> >       return 0;
> >   }
> >
> > -static inline int thermal_notify_tz_trip_change(int tz_id, int id, int=
 type,
> > -                                             int temp, int hyst)
> > +static inline int thermal_notify_tz_trip_change(const struct thermal_z=
one_device *tz,
>
> I was wondering if it's not too long line, but I can see it's common
> in that header file. Shouldn't we break such lines like:
>
> static inline
> int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>                                 const struct thermal_trip *trip)
>
> ?

IMO the additional line break doesn't really make it easier to read.

And note that it is OK now to have code lines longer than 80 chars (as
long as they are not longer than 100 chars IIRC), although it is still
recommended (but not required any more) to observe the "old" 80 chars
length limit.

> Although, it would apply to all other long lines in that header, so not
> particularly to this $subject.

Well, right.

> > +                                             const struct thermal_trip=
 *trip)
> >   {
> >       return 0;
> >   }
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -155,9 +155,7 @@ int thermal_zone_trip_id(const struct th
> >   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
> >                              const struct thermal_trip *trip)
> >   {
> > -     thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, tr=
ip),
> > -                                   trip->type, trip->temperature,
> > -                                   trip->hysteresis);
> > +     thermal_notify_tz_trip_change(tz, trip);
> >       __thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> >   }
> >
> > @@ -168,8 +166,6 @@ void thermal_zone_set_trip_temp(struct t
> >               return;
> >
> >       trip->temperature =3D temp;
> > -     thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, tr=
ip),
> > -                                   trip->type, trip->temperature,
> > -                                   trip->hysteresis);
> > +     thermal_notify_tz_trip_change(tz, trip);
> >   }
> >   EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> >
> >
> >
>
> Other than the comment above, LGTM.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks!

