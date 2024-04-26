Return-Path: <linux-kernel+bounces-159770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0638B33BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E031F22720
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B41282EA;
	Fri, 26 Apr 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaHFHHfW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB113DDC7;
	Fri, 26 Apr 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123126; cv=none; b=a1G0PMMy9njr18wtZ4IquNTS6vC1hh1c+p4fHfnD6pg8vZRaNr0WVWHboxXJou7AIoVVEHOP0FEY695K3eQztMoSHqhajSQcNJNqxSVPryFdok3jPsjkRfuU427G7RZCTercKg7czFR3s3xHcU5Rf4MwAYN5IFYa8CptDRDSXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123126; c=relaxed/simple;
	bh=ObriMzg6+L/x9BJ1E3PFmuN8pqe21fkjPDIG4bbt3wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBjEMxJvfkrJJxz92+VJCzvaeysi8d8hA4TIChe01jKovcwf5Ypn9bOOdV6vmXfhCJCHC/m2DKHsSPXjJDgu6Jm4WVQMtTX73smedZMGqh33eyE/r+BwXwdKfpybEQW1DyX8LBLl0y2+1FmusEvIJk9hlrbzjZa6tN4dL3p8oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaHFHHfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02858C32783;
	Fri, 26 Apr 2024 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714123126;
	bh=ObriMzg6+L/x9BJ1E3PFmuN8pqe21fkjPDIG4bbt3wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FaHFHHfWwKwzcEmF1pwKNCXfScoG4HqOBfOprvzLNT8czdXB6igccNGPEtyqlwurf
	 npEIcaGUdHcOgBP4CkaApDoxm6mnuub7US1pyNb4D1TfdBHwqM269E/UfilpxNvdl3
	 8D4UQTLIghMvr924l+FTl7Wjq2iTlCv5QqdPVBFsxLaNLiKDI54XmGxluPNJeWSF0e
	 ziWI+MpWDT4cY6+9BvQSqmB6Esp9G9ge849kuZ7MPA8dG2786Rc5QU4q7tEtJA7/Md
	 sVVpAzOdMtRUkcNhjl1kW84t9Ewby9y+aeZ9+TMYGcNU13g3+Jm3F4cv5e2wpQccL1
	 0k99iVY2gsf0Q==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so200074eaf.1;
        Fri, 26 Apr 2024 02:18:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZEHXgpcmgZpnuNLfLT5I9t+n6Crep0AiUAb3vceOPEGOwwL+igakqZs0bF+ZBkUffXAoiOd+aLu+wVIwAY5Z7weHHzI2h/u48cSwsn++l0RPdd6lN/2+ubRPwJl/pfnfmcSKsQno=
X-Gm-Message-State: AOJu0YxpQeE+8cb0fB2riVEgoGU/0ezGIo170Fg2FFHpKKpL9VsZ53Jb
	3VuIltbMkLoVAa2LNI1UUSIxFN4WHIbyGOmk4a7uWnHJnFogfEI5evso1Q8qAUHnCvFEgKBGvTb
	2ErWmdxC+lHMhSvmGyDxOl0bVhpA=
X-Google-Smtp-Source: AGHT+IFlkPfJOteB2Uzj37KEIlqpbbRbozFPpoPh/x74HdzP3prmWK6O9qnxftecgfyOr3TpmFJBPwPF1BIBXSmw8D8=
X-Received: by 2002:a05:6870:7b52:b0:239:6927:6826 with SMTP id
 ji18-20020a0568707b5200b0023969276826mr2279073oab.0.1714123125211; Fri, 26
 Apr 2024 02:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12427744.O9o76ZdvQC@kreacher> <13503555.uLZWGnKmhe@kreacher> <cf03d58a-93ad-46ce-bd59-8fbae3c311b2@arm.com>
In-Reply-To: <cf03d58a-93ad-46ce-bd59-8fbae3c311b2@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 11:18:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNpZEiaV-wuKfZuwZkFr_5k_oaw2RNHYYa3iQCsu2cMA@mail.gmail.com>
Message-ID: <CAJZ5v0hNpZEiaV-wuKfZuwZkFr_5k_oaw2RNHYYa3iQCsu2cMA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] thermal/debugfs: Prevent use-after-free from
 occurring after cdev removal
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:05=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 4/25/24 14:57, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since thermal_debug_cdev_remove() does not run under cdev->lock, it can
> > run in parallel with thermal_debug_cdev_state_update() and it may free
> > the struct thermal_debugfs object used by the latter after it has been
> > checked against NULL.
> >
> > If that happens, thermal_debug_cdev_state_update() will access memory
> > that has been freed already causing the kernel to crash.
> >
> > Address this by using cdev->lock in thermal_debug_cdev_remove() around
> > the cdev->debugfs value check (in case the same cdev is removed at the
> > same time in two differet threads) and its reset to NULL.
>
> s/differet/different/
>
> >
> > Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debug=
fs information")
> > Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_debugfs.c |   10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_debugfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> > +++ linux-pm/drivers/thermal/thermal_debugfs.c
> > @@ -503,15 +503,21 @@ void thermal_debug_cdev_add(struct therm
> >    */
> >   void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
> >   {
> > -     struct thermal_debugfs *thermal_dbg =3D cdev->debugfs;
> > +     struct thermal_debugfs *thermal_dbg;
> >
> > +     mutex_lock(&cdev->lock);
> > +
> > +     thermal_dbg =3D cdev->debugfs;
> >       if (!thermal_dbg)
>
> mutex_unlock(&cdev->lock) missing here

Good catch, thanks!

Ho-hum, I'm not sure why I haven't added it here ...

I'll send a v2 of this patch shortly.

> >               return;
> >
> > +     cdev->debugfs =3D NULL;
> > +
> > +     mutex_unlock(&cdev->lock);
> > +
> >       mutex_lock(&thermal_dbg->lock);
> >
> >       thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
> > -     cdev->debugfs =3D NULL;
> >
> >       mutex_unlock(&thermal_dbg->lock);
> >
> >
> >
> >
> >
>

