Return-Path: <linux-kernel+bounces-16568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FDC82405B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC24B23BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE8210F6;
	Thu,  4 Jan 2024 11:13:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E97210E3;
	Thu,  4 Jan 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbd87b706aso106450a34.0;
        Thu, 04 Jan 2024 03:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366790; x=1704971590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KADDJtubP9xxZYN3kC3xy/rkpnjcsqHbF4q/GCStMls=;
        b=GikRP3/Sat1zGEvez8PIrZSyOyRg1A/K2AZ5YFSmSa8ACKaZv7Zco/vEUzUzIzg86H
         lowyKzuc4wkCcJABK4LNtUdTkleqkuiRVo968OvsiqmJDXfzXkDu2q6dfPU07DYJjawU
         WQXKxb8Qbm1LB2AnUnJJISotMSFj3I9duVaHUI48gEiahemhddoqVU9nf2eL58YZPfLk
         FfAFR7bWzNP1IXTSkcTed2sVtap6p2Olj7Qmv+x4PmK+jGdKe4H0WHJUaDvp2ZESSQy8
         AlXuit84HiBiMUHfaB8Mm/Lk/mf0Ik7t3/LEVYMvuTdYuGbzPjtLheKMFBlXRfXTGPbE
         Fnhw==
X-Gm-Message-State: AOJu0YzedUhiSuyKaysIi+pzL9X4zF9zxmLDfy0mCqLt/Q4VxwGUxXCw
	VnBTvtI1COe5xlTbxRK5GRyI9PZKXbBZaQys9u0=
X-Google-Smtp-Source: AGHT+IFSyW8wbnoZ4SCVQ2MOTqO2FYzWiFceSrHjqeUYNzwfns8DQw+OB/LtOUVoO1vKs8nyOXs+OLtiSepvVSfkhvA=
X-Received: by 2002:a4a:b3c2:0:b0:594:35b4:8a with SMTP id q2-20020a4ab3c2000000b0059435b4008amr840062ooo.0.1704366789882;
 Thu, 04 Jan 2024 03:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher> <10409811.nUPlyArG6x@kreacher> <4eb9b38f-5364-466b-99fa-b2c42c1a4997@arm.com>
In-Reply-To: <4eb9b38f-5364-466b-99fa-b2c42c1a4997@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 12:12:58 +0100
Message-ID: <CAJZ5v0h=y0=Cd3PEKK8dvwJzbSt_6rzS84hzgrSrxTrDkA_5Ug@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] thermal: netlink: Drop thermal_notify_tz_trip_add/delete()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:06=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 12/15/23 19:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because thermal_notify_tz_trip_add/delete() are never used, drop them
> > entirely along with the related code.
> >
> > The addition or removal of trip points is not supported by the thermal
> > core and is unlikely to be supported in the future, so it is also
> > unlikely that these functions will ever be needed.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_netlink.c |   33 +---------------------------=
-----
> >   drivers/thermal/thermal_netlink.h |   14 --------------
> >   2 files changed, 1 insertion(+), 46 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_netlink.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> > +++ linux-pm/drivers/thermal/thermal_netlink.c
> > @@ -135,7 +135,7 @@ static int thermal_genl_event_tz_trip_up
> >       return 0;
> >   }
> >
> > -static int thermal_genl_event_tz_trip_add(struct param *p)
> > +static int thermal_genl_event_tz_trip_change(struct param *p)
> >   {
> >       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> >           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id)=
 ||
> > @@ -147,15 +147,6 @@ static int thermal_genl_event_tz_trip_ad
> >       return 0;
> >   }
> >
> > -static int thermal_genl_event_tz_trip_delete(struct param *p)
> > -{
> > -     if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> > -         nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id)=
)
> > -             return -EMSGSIZE;
> > -
> > -     return 0;
> > -}
> > -
> >   static int thermal_genl_event_cdev_add(struct param *p)
> >   {
> >       if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
> > @@ -245,9 +236,6 @@ int thermal_genl_event_tz_disable(struct
> >   int thermal_genl_event_tz_trip_down(struct param *p)
> >       __attribute__((alias("thermal_genl_event_tz_trip_up")));
> >
> > -int thermal_genl_event_tz_trip_change(struct param *p)
> > -     __attribute__((alias("thermal_genl_event_tz_trip_add")));
> > -
> >   static cb_t event_cb[] =3D {
> >       [THERMAL_GENL_EVENT_TZ_CREATE]          =3D thermal_genl_event_tz=
_create,
> >       [THERMAL_GENL_EVENT_TZ_DELETE]          =3D thermal_genl_event_tz=
_delete,
> > @@ -256,8 +244,6 @@ static cb_t event_cb[] =3D {
> >       [THERMAL_GENL_EVENT_TZ_TRIP_UP]         =3D thermal_genl_event_tz=
_trip_up,
> >       [THERMAL_GENL_EVENT_TZ_TRIP_DOWN]       =3D thermal_genl_event_tz=
_trip_down,
> >       [THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]     =3D thermal_genl_event_tz=
_trip_change,
> > -     [THERMAL_GENL_EVENT_TZ_TRIP_ADD]        =3D thermal_genl_event_tz=
_trip_add,
> > -     [THERMAL_GENL_EVENT_TZ_TRIP_DELETE]     =3D thermal_genl_event_tz=
_trip_delete,
> >       [THERMAL_GENL_EVENT_CDEV_ADD]           =3D thermal_genl_event_cd=
ev_add,
> >       [THERMAL_GENL_EVENT_CDEV_DELETE]        =3D thermal_genl_event_cd=
ev_delete,
> >       [THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]  =3D thermal_genl_event_cd=
ev_state_update,
> > @@ -350,23 +336,6 @@ int thermal_notify_tz_trip_up(const stru
> >       return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p)=
;
> >   }
> >
> > -int thermal_notify_tz_trip_add(int tz_id, int trip_id, int trip_type,
> > -                            int trip_temp, int trip_hyst)
> > -{
> > -     struct param p =3D { .tz_id =3D tz_id, .trip_id =3D trip_id,
> > -                        .trip_type =3D trip_type, .trip_temp =3D trip_=
temp,
> > -                        .trip_hyst =3D trip_hyst };
> > -
> > -     return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_ADD, &p=
);
> > -}
> > -
> > -int thermal_notify_tz_trip_delete(int tz_id, int trip_id)
> > -{
> > -     struct param p =3D { .tz_id =3D tz_id, .trip_id =3D trip_id };
> > -
> > -     return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE,=
 &p);
> > -}
> > -
> >   int thermal_notify_tz_trip_change(const struct thermal_zone_device *t=
z,
> >                                 const struct thermal_trip *trip)
> >   {
> > Index: linux-pm/drivers/thermal/thermal_netlink.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> > +++ linux-pm/drivers/thermal/thermal_netlink.h
> > @@ -22,9 +22,6 @@ int thermal_notify_tz_trip_down(const st
> >                               const struct thermal_trip *trip);
> >   int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
> >                             const struct thermal_trip *trip);
> > -int thermal_notify_tz_trip_delete(int tz_id, int id);
> > -int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> > -                            int temp, int hyst);
> >   int thermal_notify_tz_trip_change(const struct thermal_zone_device *t=
z,
> >                                 const struct thermal_trip *trip);
> >   int thermal_notify_cdev_state_update(int cdev_id, int state);
> > @@ -71,17 +68,6 @@ static inline int thermal_notify_tz_trip
> >   {
> >       return 0;
> >   }
> > -
> > -static inline int thermal_notify_tz_trip_delete(int tz_id, int id)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline int thermal_notify_tz_trip_add(int tz_id, int id, int ty=
pe,
> > -                                          int temp, int hyst)
> > -{
> > -     return 0;
> > -}
> >
> >   static inline int thermal_notify_tz_trip_change(const struct thermal_=
zone_device *tz,
> >                                               const struct thermal_trip=
 *trip)
> >
> >
> >
>
> We could also add a comment that these two
> (THERMAL_GENL_EVENT_TZ_TRIP_ADD/DELETE) in the uapi header are obsolete.

I'd rather say they are placeholders for message types that have never
been sent by the kernel - and nothing changes in that respect after
the $subject patch.  They have been unused so far and they are still
unused (it is easier to figure that out through code inspection,
however).

And even though it is unlikely that they will be used in the future,
it is not entirely unimaginable.

> Other than that this looks good.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks a lot for all of the reviews!

