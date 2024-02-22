Return-Path: <linux-kernel+bounces-76655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84085FA96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08C28361E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE120145FF6;
	Thu, 22 Feb 2024 14:00:07 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09308135403;
	Thu, 22 Feb 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610407; cv=none; b=cECg+DKR/paMp6nBEBMemt7suyMtsGODO9lvkuw8mgs16VB32PX5OpUsqx4CIZc5+hxzFCQyVf9gZkIYntTcLR9UR9C1SCrIENK7zO0WOUZHeqdt1Q9DICnIJhR16Y0DqGx/SBx2AFlA3a4y3xQPXPdLXhuMutIURqOf/x9wkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610407; c=relaxed/simple;
	bh=faC93JEXJFCufNC5dOS6ApNeW8gKvRR+kMj0RPtYFkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF7tB6DRQ1XgTvMipaTQlB1vulN5vxcLOCYtwrJNXSdJGTUxn1tKysc17kXMpDyj4tSPRcW/DndCAgFzDqwS5j0HFrG/1FTy+xJU8vrdqqoZt9oRexi7sQXWkn9vD8p1DsjVGPEwOtAz25wSZ3+ENx0qEcBh+C11avOhM2FIEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0333a9779so134114eaf.0;
        Thu, 22 Feb 2024 06:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610405; x=1709215205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wGnYwIfq9nup3u9bw55avJLf6TS9fj3kCr0bhf4Ym8=;
        b=cnUzz2lmsOqJs3jlzy8yNVZGDcTSNHIrKHCGqoldcWIucfjqCBve+f1miGMHg+qy+h
         Kkget2JI5pw50dSUH3WS9urkcWCBbtIqFqDQSr7KG0qFhgfbmIoSWS+CDHBmRhdcRi1s
         00l9cKtRN+HebfPFQvKdZ82gJdnCopKb0y3rW4jKEEk7bvlNYUePPhbMmuu3Q6fVpeQV
         cXd7NEVjYVbiGYXgSbuUUSb5j/ur3rJCzbroiOJyUoSgzvdXCZiBuXGrajfri/KJ82hq
         3F0ecUHM6ZDaSDQDb5fN9fou/oPvbG4o74JFPWHk7+8NeGHv0Yj5+1bK7cxN4cJNaWwe
         2FCg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPAyK6h/JXcQk/dQ3VZShRs8K9Z1xlcvAHMymYDP9etpzQaKOo/IIqp+6wah1EcPgND0CFs/lgiMSjx8UFqIHjkDlKkmpVOLT5SbmUt0wGkqaPRmkFXK0WIGMJHnncRJBMirrd/DS9m2oRmKPJ/uctlhPXZcXYvIiGv3j1abB9+BbCYsIim+NTS+xgeU7oBlJW5ge+Xn81mQLA9i5qQ==
X-Gm-Message-State: AOJu0Yza3Z7YAwUB1O1YIKSlQq6BuffQc85zMGP8wdX8yugE7eJnZ15e
	sBTB+Ivvvsu6Pa3PPIURT1UWcQ+sNHcPtIr8St+6+cQkeINNUTkzveAWSpD5gL6dAuo0PxT7R7j
	etT6rUfeFvzldzzvKnDDIhwXzfuc=
X-Google-Smtp-Source: AGHT+IFk/cRrA9w3h6K7wqQ/CveV9XXnLmyjBHYg13D8CnoEJk666aXdvpwHpLKnzNNGD1cS009+cnPg4rM90X+uxuM=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr26243164oow.0.1708610404960; Thu, 22
 Feb 2024 06:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher> <9235101.CDJkKcVGEf@kreacher> <cd710cd4-c723-48e0-80d2-72d9d95f9e0c@linaro.org>
In-Reply-To: <cd710cd4-c723-48e0-80d2-72d9d95f9e0c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 14:59:53 +0100
Message-ID: <CAJZ5v0jD=AmR0w49wDhDJ2Bq1KewUmGApe_Gc=v7SNb-jtqNPA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] thermal: of: Set THERMAL_TRIP_FLAG_RW_TEMP directly
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:48=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/02/2024 19:40, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> > to allow their temperature to be set from user space via sysfs instead
> > of using a nonzero writable trips mask during thermal zone registration=
,
> > so make the OF thermal code do that.
> >
> > No intentional functional impact.
> >
> > Note that this change is requisite for dropping the mask argument from
> > thermal_zone_device_register_with_trips() going forward.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Rename trip flag (Stanislaw).
> >
> > ---
> >   drivers/thermal/thermal_of.c |    8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_of.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_of.c
> > +++ linux-pm/drivers/thermal/thermal_of.c
> > @@ -117,6 +117,8 @@ static int thermal_of_populate_trip(stru
> >               return ret;
> >       }
> >
> > +     trip->flags =3D THERMAL_TRIP_FLAG_RW_TEMP;
> > +
> >       return 0;
> >   }
>
> Even if you are not at the origin of this default behavior. I'm
> wondering if we should be more protective against changes from userspace
> when the firmware is telling us to protect the silicon at a specific
> temperature.
>
> What do you think if we set the THERMAL_TRIP_FLAG_RW_TEMP only if the
> trip point is not bound to a cooling device?
>
> So trip points without associated cooling device can be writable but
> others can be considered as managed by the kernel and no modifiable.

This sounds reasonable to me.

This is mostly relevant to thermal_of anyway, because the other
drivers asking for writable trip temperature seem to want it
regardless.

> (This comment does not put in question this patch BTW)

OK

