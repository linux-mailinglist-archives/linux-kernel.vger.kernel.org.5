Return-Path: <linux-kernel+bounces-164040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3358B7795
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF73B21F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177817278D;
	Tue, 30 Apr 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmdVDwkB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE517167F;
	Tue, 30 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484951; cv=none; b=mvXmj6y85ZL60cq1Pq4EC7vZigMwVqhqM1VZKQLKGVpTSQKx3RdEt5d1hlSX0iG2wNDAcvq8p1JT0ZZ+0GQq1SD12xplWiikF9ef/aprBj6gCATGpQc50uTiM7VFPep/Mn+wUuU6G9J+71ILsIANUqwbVBJdOyRRPpVFk3X7Yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484951; c=relaxed/simple;
	bh=meGcxxXXiP0PlH9WpeNhgSVE5M8UyQkFn5po/beRdsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSBryCaFnAOsF/LdynsbSC0IZHzlYoO565SIYOW3O5QdfC8Qac0j3ezNinEhzhssW+zQIMtOtMRltfhB1qgG6tYwOEn6nBvwFP2v7MK0FjoIbbzqZUHtDSDw1QK3X2ZUOc8GarfjV1pqTW5GYCttLmORDOo+lvD2qmJV7tkzTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmdVDwkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110BCC4AF19;
	Tue, 30 Apr 2024 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484951;
	bh=meGcxxXXiP0PlH9WpeNhgSVE5M8UyQkFn5po/beRdsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmdVDwkBKQAFLyPh+EL9vC6PEkNA3xTeczhVs2h3oB0oAPHyfOZckvM+EQRi9LvWK
	 Vgrc53QbeklE0l0gNX4IMq3Iuok2d7vxXVz7EMI2O86aNWrAhN/jSZpzT5lYKpQbKZ
	 g9M3eaVSWLD25WWqc91ZHtZQuh+uXxKvhexlJNJKdv3EFiJrNJ4Qt16/Pounmtoc0B
	 MmqeaomsI+TZmSdXxfo7CNgQzBo7m0K/+EkBUrrXL4aea0UDUBuY6Sl+7GZIYjVC4b
	 DzjzewK0I12CXhaI4eamG5Ke8AvESe0AzN+bkohIv0m0b+Lsn9Q160zjCKcp431/lB
	 fgszHGK2jYf9A==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1342402eaf.1;
        Tue, 30 Apr 2024 06:49:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrsWN5CCCzl1FUd2SA6eD7eUUHEULnCxCjCsZ8DtubKkwKZMdX56M0RXkf5wq4uRZJitDkRSFYe1ECO9vGFXJeFvgPMJ7sCVdw5lKbzGuga9lODovo+KcsjkVg+IbspkXpEXudEdE=
X-Gm-Message-State: AOJu0YxqQvTfEZyjNN2cVXNGm4o1BC75UR2/RztpqGzCA8loPb2GeETP
	ndSRx9TMczGRMMlnV8CVF1WL8XyDun+yRQKPmnxEeWaMga60y2dGhslteJhLUx6b8go2RTRUWJg
	HZWMlC3qc+Ki649NnbUVrXCvffuk=
X-Google-Smtp-Source: AGHT+IFf5bnp4mDF8jP5gJBNYsuoNpIzgyJ7jHRXp0loXpO2IvpM4hchnN5ORul1kFGPtGQcEZKPce54eeoWsGFge78=
X-Received: by 2002:a05:6820:e09:b0:5a7:db56:915c with SMTP id
 el9-20020a0568200e0900b005a7db56915cmr14075194oob.1.1714484950252; Tue, 30
 Apr 2024 06:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5938055.MhkbZ0Pkbq@kreacher> <c29247b8-89d4-404a-b294-81f19720e236@arm.com>
In-Reply-To: <c29247b8-89d4-404a-b294-81f19720e236@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 15:48:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iv_HQ3ej1C3u3iHuwW=Ae5EEAZY4vxMoHDZpKxYMvXkw@mail.gmail.com>
Message-ID: <CAJZ5v0iv_HQ3ej1C3u3iHuwW=Ae5EEAZY4vxMoHDZpKxYMvXkw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Move passive polling management to the core
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Apr 29, 2024 at 11:21=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 4/25/24 15:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Passive polling is enabled by setting the 'passive' field in
> > struct thermal_zone_device to a positive value so long as the
> > 'passive_delay_jiffies' field is greater than zero.  It causes
> > the thermal core to actively check the thermal zone temperature
> > periodically which in theory should be done after crossing a
> > passive trip point on the way up in order to allow governors to
> > react more rapidly to temperature changes and adjust mitigation
> > more precisely.
> >
> > However, the 'passive' field in struct thermal_zone_device is currently
> > managed by governors which is quite problematic.  First of all, only
> > two governors, Step-Wise and Power Allocator, update that field at
> > all, so the other governors do not benefit from passive polling,
> > although in principle they should.  Moreover, if the zone governor is
> > changed from, say, Step-Wise to Fair-Share after 'passive' has been
> > incremented by the former, it is not going to be reset back to zero by
> > the latter even if the zone temperature falls down below all passive
> > trip points.
> >
> > For this reason, make handle_thermal_trip() increment 'passive'
> > to enable passive polling for the given thermal zone whenever a
> > passive trip point is crossed on the way up and decrement it
> > whenever a passive trip point is crossed on the way down.  Also
> > remove the 'passive' field updates from governors and additionally
> > clear it in thermal_zone_device_init() to prevent passive polling
> > from being enabled after a system resume just beacuse it was enabled
> > before suspending the system.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This has been mentioned here:
> >
> > https://lore.kernel.org/linux-pm/61560bc6-d453-4b0c-a4ea-b375d547b143@l=
inaro.org/
> >
> > and I need someone to double check if the Power Allocator governor does=
 not
> > need to be adjusted more for this change.
> >
> > ---
> >   drivers/thermal/gov_power_allocator.c |   12 +++++++-----
> >   drivers/thermal/gov_step_wise.c       |   10 ----------
> >   drivers/thermal/thermal_core.c        |   10 ++++++++--
> >   3 files changed, 15 insertions(+), 17 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -389,6 +389,9 @@ static void handle_thermal_trip(struct t
> >               if (tz->temperature < trip->temperature - trip->hysteresi=
s) {
> >                       list_add(&td->notify_list_node, way_down_list);
> >                       td->notify_temp =3D trip->temperature - trip->hys=
teresis;
> > +
> > +                     if (trip->type =3D=3D THERMAL_TRIP_PASSIVE)
> > +                             tz->passive--;
>
> This gets negative values and than the core switches to fast 'polling'
> mode. The values is decremented from 0 each time the
> thermal_zone_device_enable() is called.

Interesting.

This shouldn't happen because it means that the passive trip has been
crossed on the way down, but it wasn't crossed on the way up.

It looks like an initialization issue to me.

> Then IPA is actually called every 100ms after boot w/ low temp,
> while it should 1s.
>
> Please see the logs below:
> 'short log' after boot
> ----------------------------------------------
>
> [    1.632670] thermal_sys: TZ: tz_id=3D0 passive-- =3D -1
> [    1.637984] thermal_sys: TZ: tz_id=3D0 passive-- =3D -2
> [    1.643641] thermal_sys: TZ: tz_id=3D1 passive-- =3D -1
> ----------------------------------------------
>
> long log with call stack dumped
> ----------------------------------------------
>
> [    1.632973] thermal_sys: TZ: tz_id=3D0 passive-- =3D -1
> [    1.638295] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5+ #28
> [    1.645409] Hardware name: Radxa ROCK 4SE (DT)
> [    1.650376] Call trace:
> [    1.653109]  dump_backtrace+0x9c/0x100
> [    1.657309]  show_stack+0x20/0x38
> [    1.661017]  dump_stack_lvl+0xc0/0xd0
> [    1.665119]  dump_stack+0x18/0x28
> [    1.668828]  __thermal_zone_device_update+0x1fc/0x550
> [    1.674484]  thermal_zone_device_set_mode+0x64/0xc0
> [    1.679943]  thermal_zone_device_enable+0x1c/0x30
> [    1.685206]  thermal_of_zone_register+0x34c/0x590

So let's see.

thermal_of_zone_register() calls
thermal_zone_device_register_with_trips() which calls
thermal_zone_device_update() for the first time, but
__thermal_zone_device_update() sees that
thermal_zone_device_is_enabled() returns false, so it does nothing.

This is right after thermal_zone_device_init() has been called, so
tz->temperature =3D=3D THERMAL_TEMP_INVALID and tz->passive =3D=3D 0.

Next, thermal_zone_device_enable() is called by
thermal_of_zone_register() and it calls __thermal_zone_device_update()
via thermal_zone_device_set_mode().

This time thermal_zone_device_is_enabled() returns true, so
update_temperature() is called and, unless __thermal_zone_get_temp()
returns an error, it sets tz->last_temperature to THERMAL_TEMP_INVALID
and tz->temperature to the current zone temperature.

Next, handle_thermal_trip() is called for all trips and it sees that
tz->last_temperature =3D=3D THERMAL_TEMP_INVALID, so it skips the branch
in which tz->passive is decremented.

The only case I can see in which something else can happen in when
__thermal_zone_get_temp() called by update_temperature() returns an
error code (and if it is -EAGAIN, it won't even trigger a warning
message) in which case the error is silently discarded and
__thermal_zone_device_update() happily proceeds with tz->temperature
=3D=3D THERMAL_TEMP_INVALID and tz->last_temperature =3D=3D 0.

This can lead to many surprises down the road, so IMV
__thermal_zone_device_update() should abort if it sees tz->temperature
=3D=3D THERMAL_TEMP_INVALID past calling update_temperature().

So I'm wondering if the patch below (modulo white-space damage from
GMail) helps.

> [    1.690473]  devm_thermal_of_zone_register+0x6c/0xc0
> [    1.696031]  rockchip_thermal_probe+0x238/0x5e8
> [    1.701106]  platform_probe+0x70/0xe8
> [    1.705208]  really_probe+0xc4/0x278
> [    1.709205]  __driver_probe_device+0x80/0x140
> [    1.714078]  driver_probe_device+0x48/0x130
> [    1.718756]  __driver_attach+0x7c/0x138
> [    1.723045]  bus_for_each_dev+0x80/0xf0
> [    1.727342]  driver_attach+0x2c/0x40
> [    1.731340]  bus_add_driver+0xec/0x1f8
> [    1.735539]  driver_register+0x68/0x138
> [    1.739828]  __platform_driver_register+0x30/0x48
> [    1.745093]  rockchip_thermal_driver_init+0x24/0x38
> [    1.750551]  do_one_initcall+0x50/0x2d8
> [    1.754844]  kernel_init_freeable+0x204/0x440
> [    1.759722]  kernel_init+0x28/0x140
> [    1.763631]  ret_from_fork+0x10/0x20
> [    1.767802] thermal_sys: TZ: tz_id=3D0 passive-- =3D -2

---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -496,6 +496,9 @@ void __thermal_zone_device_update(struct

     update_temperature(tz);

+    if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
+        return;
+
     tz->notify_event =3D event;

     for_each_trip_desc(tz, td)

