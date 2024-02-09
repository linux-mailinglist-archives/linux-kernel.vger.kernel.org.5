Return-Path: <linux-kernel+bounces-59591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4084F96C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AF2853DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A57A731;
	Fri,  9 Feb 2024 16:15:55 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DC692FC;
	Fri,  9 Feb 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495354; cv=none; b=NRIBtdYACzuhX19zFg6BuUtefVz2xEtwoD6TBFVj1WT4k80TIjop6mQrn6gy97UABROGTeBFG5sOyZ/MeAddJpGyZKTUOa5LyLpuBlKxZdPAp3Hi5F/d3Mrz+A472l/1O+68C2G7x8Fwh3p0va4Lwm2FmyK3XD5xWU94TU3oOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495354; c=relaxed/simple;
	bh=/GY0iqMDtWLZsQ2THgMzEE7xNTqtK2F1JPFrAgYstiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXg3+8CYU57PtHna5xfed3WgWe50y6h/gV27tqxONHXIGKQckpTkmzDeTPaJv3xFkUD3CBvivWfKb6rXMgZ6rs39JmbK7AKgPUUSEh16KrthnZhtGr+FXdVAHKuk5JDVBwoOyM+h6xAZX/UtmT0TtXnes3G+EbcehK5aYK290xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2baa2a111so378871a34.1;
        Fri, 09 Feb 2024 08:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495352; x=1708100152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnOocJ+CazfmWSXyI0so8JU9qu8al/Fw5NrqJxd4Uw8=;
        b=ukofIHifeJZoSuVnVHZ8Fj0/BD5bRgjLALBNGU4CJqwypNQ9ipgamgc1SMP1rNyV7R
         YBYrQ0/opCQkozFYUfWk/phrwFPYAJgB1XntGkyeUxrMaTY6TMWmNuhBmjfeg8+b6XNe
         75/41I3BjyZ/CKHYfDcDN31PjJExXZYZ44MAV1vHVk2qz8eiITblrLHuiC64o1ZEc1Br
         L/YA2yeTL7UZwCS7ghB/IFitFZNhzy4hOl7w/EWD/HbCGkXzm7bgXBZDHvEJtCvfJU/6
         04RDh9BRnzLwv2N3rkwMlVjxAPoOKy0DCD/Cslxe22kgthoAzth0CL9WL0iucI0szXMl
         LvFw==
X-Forwarded-Encrypted: i=1; AJvYcCU17ZgL2eO8mYAKfWyMVx/nqSNkg9dMFGRUYL4xCy+E6gpG3ooO2yuKG9y2Wgtfp9lC/X5nCxVt/BKDa9xeaR08++13kkKrYfqGBjdkCYnJQ2I0qJLnjX3LLJOTpVNWjG9uoIbAVLAhfGafsVZ3ipmVeyPZjogvu8WeHzfx6qO48B/cou1sNydJlxyctRenYT9WfWyRbRsKnAp1DuXk2w==
X-Gm-Message-State: AOJu0YzYKhsk/PpXOgFSd6koPuaULILbJSVJT7NgYahECzCYmsVwSX0O
	lz2mf30RLpbxY5qWOC64y2BR25uv4Sa7wczM94kpXG+rStXOZ36J0FHFCkdFSXMEKyy02hspzxj
	Ce8F3vOyuq8ffmQoLPsVDoi2Xvsc=
X-Google-Smtp-Source: AGHT+IGZbVtBMFtcv3230J4yOp5yloggtEzukC6V5tRhbbfDgV/CSJCv4/NUQPNc9Tnt8EzR4xbWxZCugnZ3nT5p/mw=
X-Received: by 2002:a4a:e0c5:0:b0:59c:e48e:50fc with SMTP id
 e5-20020a4ae0c5000000b0059ce48e50fcmr2075168oot.1.1707495352343; Fri, 09 Feb
 2024 08:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3232442.5fSG56mABF@kreacher> <3757041.MHq7AAxBmi@kreacher> <ZcY7jyyFJq1yfOCj@linux.intel.com>
In-Reply-To: <ZcY7jyyFJq1yfOCj@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2024 17:15:41 +0100
Message-ID: <CAJZ5v0gZ1tpNmdkvRLA6-ydnhKPKgsM_FCwrW+q1=5ZiD=vbWA@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP directly
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:50=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Fri, Feb 09, 2024 at 03:10:24PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> > to allow their temperature to be set from user space via sysfs instead
> > of using a nonzero writable trips mask during thermal zone registration=
,
> > so make the iwlwifi code do that.
> >
> > No intentional functional impact.
> >
> > Note that this change is requisite for dropping the mask argument from
> > thermal_zone_device_register_with_trips() going forward.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This patch obviously depends on
> >
> > https://patchwork.kernel.org/project/linux-pm/patch/8346768.T7Z3S40VBb@=
kreacher/
> >
> > which has been queued up for 6.9 already.
> >
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > @@ -667,9 +667,6 @@ static  struct thermal_zone_device_ops t
> >       .set_trip_temp =3D iwl_mvm_tzone_set_trip_temp,
> >  };
> >
> > -/* make all trips writable */
> > -#define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
> > -
> >  static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
> >  {
> >       int i, ret;
> > @@ -692,11 +689,12 @@ static void iwl_mvm_thermal_zone_registe
> >       for (i =3D 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
> >               mvm->tz_device.trips[i].temperature =3D THERMAL_TEMP_INVA=
LID;
> >               mvm->tz_device.trips[i].type =3D THERMAL_TRIP_PASSIVE;
> > +             mvm->tz_device.trips[i].type =3D THERMAL_TRIP_WRITABLE_TE=
MP;
>
>                 mvm->tz_device.trips[i].flags =3D THERMAL_TRIP_WRITABLE_T=
EMP;
>
> Consider using diffrent prefix for constants to diffrenciate flags and ty=
pes.

Well, I can use THERMAL_TRIP_FLAG_RW_TEMP or similar, but is it really
so confusing?

I'm wondering what others think.

> >       }
> >       mvm->tz_device.tzone =3D thermal_zone_device_register_with_trips(=
name,
> >                                                       mvm->tz_device.tr=
ips,
> >                                                       IWL_MAX_DTS_TRIPS=
,
> > -                                                     IWL_WRITABLE_TRIP=
S_MSK,
> > +                                                     0,
> >                                                       mvm, &tzone_ops,
> >                                                       NULL, 0, 0);
> >       if (IS_ERR(mvm->tz_device.tzone)) {
> >
> >
> >
>

