Return-Path: <linux-kernel+bounces-164233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2718B7B07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635E6281CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040977118;
	Tue, 30 Apr 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poYjdTap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D9152799;
	Tue, 30 Apr 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489706; cv=none; b=NQopdoRLaH9q7Ly9kHuB9vIIQp/lhbsOn4TDPC3lNamRGiOS52hirgPiVQjlDgPIx3muMbMU1GSwuIv2aXFWhgApVnhItnIL9Nin9uREnJJB4VI1RKwsw1TxgMow/2j/TToeUzBrmQ4E1g2C4c594sW7JsR763bZoi5iyU/9G1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489706; c=relaxed/simple;
	bh=ugOiBcq5y32ylI0To3FWfJLciugj1EVKnJBOcPGdrxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qer/1q+bSob/SZMeMBI2NZjHBCtHESjfEo9HWm+ygOF8XOoZaQir2WFHAG2PwYEGlQ0jBDj7XcY21WiuLCDBjc5QRPrOvch7VHK1yYgSl+nI5UIlPusubgR630w28Vztvlmdt9k72M7xzN4RxZhiRp2Od2O+HzBPKJ5PY43svmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poYjdTap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F6C4AF1A;
	Tue, 30 Apr 2024 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489706;
	bh=ugOiBcq5y32ylI0To3FWfJLciugj1EVKnJBOcPGdrxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=poYjdTapnTIvpWv8jN5QEZOY+SHQcaQ6ICF7mjxmvFkrlybsizIx1HjR98U//cXoC
	 dQ7j5wmlEKZ5+nqwNhnwpqUs/E0q4A1csD0Qknt+EacWP77YmqRIT7AIe1W6ZRYtjX
	 9Y8XeRCVzf++EpckI/gbiRASutiWH+87QFw9jSSVPnnXpVV2jd7ldvUWjyW5i0quje
	 1hTpocmgyLBwStDRI1CB/RY1ZZfIdrc3JqdMRETyVcOb/X39fO+6/vFwY4Nh6aTMnv
	 TtEH4tu653b7Itv/YCtgIONht1ywWdh0+xX0+CakLfs0jmuLjIdm8OIikwrCRuxTec
	 MolZ8TWRciM+A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1366214eaf.1;
        Tue, 30 Apr 2024 08:08:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaBGFTgZJ497hoOyxSv7FiBC1h1Ps0cxaXRXqwKYtKo7GiNzQgCoaHya7L34qWGLHblThmw7abfJwvmvB4mxwHOCFurNFdaWUhBZbMjsf3kThXhFdUrWzGhAvElj0ppu+B2VJC3FA=
X-Gm-Message-State: AOJu0Yz7zEMMHyabiAQ/F9spC04BdjLEiRoQzisxDJruCrvfbGoM267l
	tMXHFuLQZfS1tBZOPOyEKnSVXRNVBwC+A84d6k6XK2u8EH1Ox3LdnxWqEO8QpQyi96w9zsSXHdK
	fBnFhglvH2bQpjTxw5WueDk73cyA=
X-Google-Smtp-Source: AGHT+IGvhzUP/yeOSH1HO1BmHxnpj0rau7h3x2hD9iNjfHvlGpMhWATf35LG1DPdqVEU25liqikoFt07kB3zUpDMYUw=
X-Received: by 2002:a4a:be9a:0:b0:5ac:6fc1:c2cb with SMTP id
 o26-20020a4abe9a000000b005ac6fc1c2cbmr15482913oop.0.1714489705417; Tue, 30
 Apr 2024 08:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5938055.MhkbZ0Pkbq@kreacher> <c29247b8-89d4-404a-b294-81f19720e236@arm.com>
 <CAJZ5v0iv_HQ3ej1C3u3iHuwW=Ae5EEAZY4vxMoHDZpKxYMvXkw@mail.gmail.com> <5f77b5b9-5d95-4512-a9fe-e0745f478d34@arm.com>
In-Reply-To: <5f77b5b9-5d95-4512-a9fe-e0745f478d34@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 17:08:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jkiAkmFU8c+0tfD3R+wZBieOmsqezCDTE91UT_hzW48w@mail.gmail.com>
Message-ID: <CAJZ5v0jkiAkmFU8c+0tfD3R+wZBieOmsqezCDTE91UT_hzW48w@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Move passive polling management to the core
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:58=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> On 4/30/24 14:48, Rafael J. Wysocki wrote:
> > Hi Lukasz,
> >
> > On Mon, Apr 29, 2024 at 11:21=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 4/25/24 15:11, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Passive polling is enabled by setting the 'passive' field in
> >>> struct thermal_zone_device to a positive value so long as the
> >>> 'passive_delay_jiffies' field is greater than zero.  It causes
> >>> the thermal core to actively check the thermal zone temperature
> >>> periodically which in theory should be done after crossing a
> >>> passive trip point on the way up in order to allow governors to
> >>> react more rapidly to temperature changes and adjust mitigation
> >>> more precisely.
> >>>
> >>> However, the 'passive' field in struct thermal_zone_device is current=
ly
> >>> managed by governors which is quite problematic.  First of all, only
> >>> two governors, Step-Wise and Power Allocator, update that field at
> >>> all, so the other governors do not benefit from passive polling,
> >>> although in principle they should.  Moreover, if the zone governor is
> >>> changed from, say, Step-Wise to Fair-Share after 'passive' has been
> >>> incremented by the former, it is not going to be reset back to zero b=
y
> >>> the latter even if the zone temperature falls down below all passive
> >>> trip points.
> >>>
> >>> For this reason, make handle_thermal_trip() increment 'passive'
> >>> to enable passive polling for the given thermal zone whenever a
> >>> passive trip point is crossed on the way up and decrement it
> >>> whenever a passive trip point is crossed on the way down.  Also
> >>> remove the 'passive' field updates from governors and additionally
> >>> clear it in thermal_zone_device_init() to prevent passive polling
> >>> from being enabled after a system resume just beacuse it was enabled
> >>> before suspending the system.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> This has been mentioned here:
> >>>
> >>> https://lore.kernel.org/linux-pm/61560bc6-d453-4b0c-a4ea-b375d547b143=
@linaro.org/
> >>>
> >>> and I need someone to double check if the Power Allocator governor do=
es not
> >>> need to be adjusted more for this change.
> >>>
> >>> ---
> >>>    drivers/thermal/gov_power_allocator.c |   12 +++++++-----
> >>>    drivers/thermal/gov_step_wise.c       |   10 ----------
> >>>    drivers/thermal/thermal_core.c        |   10 ++++++++--
> >>>    3 files changed, 15 insertions(+), 17 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -389,6 +389,9 @@ static void handle_thermal_trip(struct t
> >>>                if (tz->temperature < trip->temperature - trip->hyster=
esis) {
> >>>                        list_add(&td->notify_list_node, way_down_list)=
;
> >>>                        td->notify_temp =3D trip->temperature - trip->=
hysteresis;
> >>> +
> >>> +                     if (trip->type =3D=3D THERMAL_TRIP_PASSIVE)
> >>> +                             tz->passive--;
> >>
> >> This gets negative values and than the core switches to fast 'polling'
> >> mode. The values is decremented from 0 each time the
> >> thermal_zone_device_enable() is called.
> >
> > Interesting.
> >
> > This shouldn't happen because it means that the passive trip has been
> > crossed on the way down, but it wasn't crossed on the way up.
> >
> > It looks like an initialization issue to me.
> >
> >> Then IPA is actually called every 100ms after boot w/ low temp,
> >> while it should 1s.
> >>
> >> Please see the logs below:
> >> 'short log' after boot
> >> ----------------------------------------------
> >>
> >> [    1.632670] thermal_sys: TZ: tz_id=3D0 passive-- =3D -1
> >> [    1.637984] thermal_sys: TZ: tz_id=3D0 passive-- =3D -2
> >> [    1.643641] thermal_sys: TZ: tz_id=3D1 passive-- =3D -1
> >> ----------------------------------------------
> >>
> >> long log with call stack dumped
> >> ----------------------------------------------
> >>
> >> [    1.632973] thermal_sys: TZ: tz_id=3D0 passive-- =3D -1
> >> [    1.638295] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5+ #2=
8
> >> [    1.645409] Hardware name: Radxa ROCK 4SE (DT)
> >> [    1.650376] Call trace:
> >> [    1.653109]  dump_backtrace+0x9c/0x100
> >> [    1.657309]  show_stack+0x20/0x38
> >> [    1.661017]  dump_stack_lvl+0xc0/0xd0
> >> [    1.665119]  dump_stack+0x18/0x28
> >> [    1.668828]  __thermal_zone_device_update+0x1fc/0x550
> >> [    1.674484]  thermal_zone_device_set_mode+0x64/0xc0
> >> [    1.679943]  thermal_zone_device_enable+0x1c/0x30
> >> [    1.685206]  thermal_of_zone_register+0x34c/0x590
> >
> > So let's see.
> >
> > thermal_of_zone_register() calls
> > thermal_zone_device_register_with_trips() which calls
> > thermal_zone_device_update() for the first time, but
> > __thermal_zone_device_update() sees that
> > thermal_zone_device_is_enabled() returns false, so it does nothing.
> >
> > This is right after thermal_zone_device_init() has been called, so
> > tz->temperature =3D=3D THERMAL_TEMP_INVALID and tz->passive =3D=3D 0.
> >
> > Next, thermal_zone_device_enable() is called by
> > thermal_of_zone_register() and it calls __thermal_zone_device_update()
> > via thermal_zone_device_set_mode().
> >
> > This time thermal_zone_device_is_enabled() returns true, so
> > update_temperature() is called and, unless __thermal_zone_get_temp()
> > returns an error, it sets tz->last_temperature to THERMAL_TEMP_INVALID
> > and tz->temperature to the current zone temperature.
> >
> > Next, handle_thermal_trip() is called for all trips and it sees that
> > tz->last_temperature =3D=3D THERMAL_TEMP_INVALID, so it skips the branc=
h
> > in which tz->passive is decremented.
> >
> > The only case I can see in which something else can happen in when
> > __thermal_zone_get_temp() called by update_temperature() returns an
> > error code (and if it is -EAGAIN, it won't even trigger a warning
> > message) in which case the error is silently discarded and
> > __thermal_zone_device_update() happily proceeds with tz->temperature
> > =3D=3D THERMAL_TEMP_INVALID and tz->last_temperature =3D=3D 0.
>
> That correct.
>
> >
> > This can lead to many surprises down the road, so IMV
> > __thermal_zone_device_update() should abort if it sees tz->temperature
> > =3D=3D THERMAL_TEMP_INVALID past calling update_temperature().
>
> agree
>
> >
> > So I'm wondering if the patch below (modulo white-space damage from
> > GMail) helps.
> >
> >> [    1.690473]  devm_thermal_of_zone_register+0x6c/0xc0
> >> [    1.696031]  rockchip_thermal_probe+0x238/0x5e8
> >> [    1.701106]  platform_probe+0x70/0xe8
> >> [    1.705208]  really_probe+0xc4/0x278
> >> [    1.709205]  __driver_probe_device+0x80/0x140
> >> [    1.714078]  driver_probe_device+0x48/0x130
> >> [    1.718756]  __driver_attach+0x7c/0x138
> >> [    1.723045]  bus_for_each_dev+0x80/0xf0
> >> [    1.727342]  driver_attach+0x2c/0x40
> >> [    1.731340]  bus_add_driver+0xec/0x1f8
> >> [    1.735539]  driver_register+0x68/0x138
> >> [    1.739828]  __platform_driver_register+0x30/0x48
> >> [    1.745093]  rockchip_thermal_driver_init+0x24/0x38
> >> [    1.750551]  do_one_initcall+0x50/0x2d8
> >> [    1.754844]  kernel_init_freeable+0x204/0x440
> >> [    1.759722]  kernel_init+0x28/0x140
> >> [    1.763631]  ret_from_fork+0x10/0x20
> >> [    1.767802] thermal_sys: TZ: tz_id=3D0 passive-- =3D -2
> >
> > ---
> >   drivers/thermal/thermal_core.c |    3 +++
> >   1 file changed, 3 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -496,6 +496,9 @@ void __thermal_zone_device_update(struct
> >
> >       update_temperature(tz);
> >
> > +    if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> > +        return;
> > +
> >       tz->notify_event =3D event;
> >
> >       for_each_trip_desc(tz, td)
>
> Yes, it prevents that previous situation. I have added a debug print
> before your return in the code above and the it's in the log:
>
> [    1.632520] thermal_sys: TZ: THERMAL_TEMP_INVALID, return
> [    1.638899] thermal_sys: TZ: THERMAL_TEMP_INVALID, return
>
> The tracing also shows that we have only 1s slow polling.
> It also works properly in IPA when crossing 2 trip points
> and coming back to low temp.
>
> So, that code above should be OK. Thanks!

Thanks for the confirmation!

Let me put the fix patch and the $subject one in a series and resend
them together.

