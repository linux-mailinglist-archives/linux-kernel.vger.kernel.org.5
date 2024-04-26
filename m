Return-Path: <linux-kernel+bounces-159822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAB8B34A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7594F1C21A54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58317140380;
	Fri, 26 Apr 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr6jYSwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3147EF;
	Fri, 26 Apr 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125298; cv=none; b=FkoedFZjW5NCC0dT9m3qG1gdoUnoQ7rNCGPDD72RyNFQXLrVgJO5GhEXOX56AORRp+D/mreYk7wGNP+Jar1B4ZmvS0TFQu32snce1w2bYfByYcED9Ca/kLz2905BSkKc42osTjudsLfSFNeFQdMLsYK5vcsJSNJD6miAzXTuOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125298; c=relaxed/simple;
	bh=WiI+XutyNd/nngQLJKLa2onjPd4tP4nDxenYt4ZyDv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGYFIMJewFmf6i6ePiMsMLs6Iicz5LJqLWabMt1G69/7mRba++LZ2eL8jQkEv/DvXcRSzXVGS9nWGNY3VkUf0mUuUYcX16W8J8bwC9eKV6V83zvxa8+OVOZO1llNl2K/E/Xi2qBRKagnzxfCg/4s5c5Pb9UGVlnoXAzZvaBfK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr6jYSwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B220C2BD10;
	Fri, 26 Apr 2024 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714125298;
	bh=WiI+XutyNd/nngQLJKLa2onjPd4tP4nDxenYt4ZyDv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fr6jYSwmuB97RzELezZDWf/0xjYFiDejLAK7+3bOviaAmHs3GN6Q0GhIKsmq0Oo7A
	 2OAbP5QPfDxCE7WF6uO3OYMx7Y6Hfxqr5ClW11Y2EA0WeuFsXhBHPdYX1Je6SpiOGr
	 b/EN7x4OUSModISNjrTmzIgMDkvrbL6qLNVC9/MTBTc9i8SpvQ2r13KrY437bU9xWT
	 tIURVUSFBrKMMQjycSWMVvkEoV4PaEyKscwy+MczvhLGOF+ufFXeKZfF1/uqGkcNcC
	 URo1aT6ffcvmSx65YYffEVMhRrG2oK6Lm2UidQFt6pE66K1sBrWWKSZTbzQEA2y8dX
	 1r+/eSOlDQuQw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea0a6856d7so304379a34.1;
        Fri, 26 Apr 2024 02:54:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfFWAlnDrRDpxEkvao/QTwMuz1aftOXAoXsho8Jwev6pRh5R+PuBEdKVlHuI21IpujTMj/bL/furZco6tz11ZYQtAHfacuvSmU7bLih9dMfIlah2NKlfzJICKduQcNXJUgDgUtP/w=
X-Gm-Message-State: AOJu0YxBC/A2iJ6UKDePFhykRPb2ssl8fEnrArqy971q1uY1/x3Dcmom
	YeORlRWqKZMp5gepYQb2ZId7AusYr10v5j0/piQWErRzS+wpZRRuKRtg8Ia1k0CWQsXL4FK4FNZ
	J08V449r5NTYrBtjNDf/NU56qLB4=
X-Google-Smtp-Source: AGHT+IHW0dqddY+m0h7lHyZU/UoSuqnrvnX6DYZicHntquPNDpIybmzPNcGXUtB/we7sN92JrY5Ltt9rRhsxkaEldko=
X-Received: by 2002:a4a:ba07:0:b0:5aa:14ff:4128 with SMTP id
 b7-20020a4aba07000000b005aa14ff4128mr2361789oop.1.1714125297342; Fri, 26 Apr
 2024 02:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12427744.O9o76ZdvQC@kreacher> <13503555.uLZWGnKmhe@kreacher>
 <2740417.mvXUDI8C0e@kreacher> <4416568e-79d4-465f-8d47-a199b3b69ca4@arm.com>
In-Reply-To: <4416568e-79d4-465f-8d47-a199b3b69ca4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 11:54:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBhwL2w7MfBj4g7hV8VqrJYS-Pwr2rgYyWD4qfkQ5F0g@mail.gmail.com>
Message-ID: <CAJZ5v0jBhwL2w7MfBj4g7hV8VqrJYS-Pwr2rgYyWD4qfkQ5F0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal/debugfs: Prevent use-after-free from
 occurring after cdev removal
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:35=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 4/26/24 10:28, Rafael J. Wysocki wrote:
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
> > same time in two different threads) and its reset to NULL.
> >
> > Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debug=
fs information")
> > Cc :6.8+ <stable@vger.kernel.org> # 6.8+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Add missing mutex_unlock() (Lukasz).
> >
> > ---
> >   drivers/thermal/thermal_debugfs.c |   14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_debugfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> > +++ linux-pm/drivers/thermal/thermal_debugfs.c
> > @@ -505,15 +505,23 @@ void thermal_debug_cdev_add(struct therm
> >    */
> >   void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
> >   {
> > -     struct thermal_debugfs *thermal_dbg =3D cdev->debugfs;
> > +     struct thermal_debugfs *thermal_dbg;
> >
> > -     if (!thermal_dbg)
> > +     mutex_lock(&cdev->lock);
> > +
> > +     thermal_dbg =3D cdev->debugfs;
> > +     if (!thermal_dbg) {
> > +             mutex_unlock(&cdev->lock);
> >               return;
> > +     }
> > +
> > +     cdev->debugfs =3D NULL;
> > +
> > +     mutex_unlock(&cdev->lock);
> >
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
> It looks good now
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks!

