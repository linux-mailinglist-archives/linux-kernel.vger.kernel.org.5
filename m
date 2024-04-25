Return-Path: <linux-kernel+bounces-159063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5788B28CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B32C1F22C45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F761514ED;
	Thu, 25 Apr 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2jW3VcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671414E2E2;
	Thu, 25 Apr 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072252; cv=none; b=egnbXKkijnQH88oVrCbP5vbCEZhp0JDVQLW1qtQFEknzlM28qNHshk9GYhdjpAm7JrxiEEN51NPPIEBmd0z59AUXA9EjY9NT1SFlNTwXTmLq/61jlrJvWrfy3sFI7WKBkItGnj9zCAe4gMDmwRMjnpINmaTbqei0alg8vz9naQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072252; c=relaxed/simple;
	bh=WXcfAjQyE0v6RqZ5J2aCr0EewC3+EFNIWMbHw3sJ5zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYCAERfSG5SmfcdZgwn6OUVSJUYVrbVDZcylW0RwsWFK5UMKanhhNm1Ua/7aAjPBOd7JueJiQ82j21Wd8/Tv76C7iOBmi9T0sRViag5h0eXXUcUYLfn3ljRdnwwtJ2JTmqdLiYkc0JagnGnBEqomQD7ry/4oIP3aFc0POpO0D9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2jW3VcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F09EC32781;
	Thu, 25 Apr 2024 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072252;
	bh=WXcfAjQyE0v6RqZ5J2aCr0EewC3+EFNIWMbHw3sJ5zM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s2jW3VcD/t9eROvgbxwv1ZGsL+PkZ751ptleXvdXoP7XQmRRqKPG4i07OSTloS7Qp
	 42iJufu/tVqU1dtb1AhRZzXc8qPYN7514rrACQkYaFN32yIMcuibFoXSgu12vBxjqu
	 69nrhrG1IN7Qr7eNFxdlpn7yvDWiFG5OKel5diILK7OyEKcnNMxURemKSNonwv2uYT
	 VwX0HOUuY+/rns/8DgqH2uICaLj2zROzWkotHa99EJ3sdBiG+cfBrRzI1x2sTeD5JO
	 pXaP3rzxOBTESrKKYOKD/arXv6W1d7LMLOdgF0kXPsIcMxqT/N7OrvqPbbYsEFBbGh
	 Su5GseETTDQ+g==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ad288442bdso244689eaf.3;
        Thu, 25 Apr 2024 12:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9DgicQ9ydRciJsRzHflP0MCNNsB2lkiJvVilJe5T44ErJgIebJbIncp+Q15THMoaaghNEY/j3EcwwmK6QgGri2Yzt3gsefcivyD89W2URTBKlJWNpBI2xEyOsL3zEVJCA7ojPM4U=
X-Gm-Message-State: AOJu0Yx1qqqJ8knEuEfHOViYCg9aynlLj6riYe95SaI0icmTX00JVXvF
	EZMTxmNx5uffTnxtEHUzh4OuOC9cIXM+IK48KLYaM0jL7hdXYBpx3z6s2OEdOpkoRDj972XxueF
	5x+1L6YHRpCGZhHa8PT7XITB9AUs=
X-Google-Smtp-Source: AGHT+IGLYJf6oVk4k2UjVhQgKZ54+8xMIutdxxajR6agvZV5YpaRuGSrmigEzNEX0HdwbIsBftxww7oeNJAQCc5KU7o=
X-Received: by 2002:a05:6808:159e:b0:3c8:4dcb:1e70 with SMTP id
 t30-20020a056808159e00b003c84dcb1e70mr721998oiw.2.1714072251550; Thu, 25 Apr
 2024 12:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher>
 <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com> <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
 <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com>
 <4f21ee21-0178-4d50-a535-4d530baf82d1@arm.com> <CAJZ5v0je44QB=dBObgDd-1pJweXdj5ZC-7sEyrOjyJ+c=n9xPQ@mail.gmail.com>
 <ce95f95d-c004-4814-bdb0-d230731084d3@arm.com>
In-Reply-To: <ce95f95d-c004-4814-bdb0-d230731084d3@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 21:10:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_T8FdGtMGDVm0oYNZYOnfuuCRcekiA5zNth-VErutKg@mail.gmail.com>
Message-ID: <CAJZ5v0j_T8FdGtMGDVm0oYNZYOnfuuCRcekiA5zNth-VErutKg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:55=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 4/25/24 19:53, Rafael J. Wysocki wrote:
> > On Thu, Apr 25, 2024 at 8:42=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >>
> >>
> >> On 4/25/24 14:00, Rafael J. Wysocki wrote:
> >>> On Thu, Apr 25, 2024 at 2:36=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> >>>>
> >>>> Hi Lukasz,
> >>>>
> >>>> On Thu, Apr 25, 2024 at 12:02=E2=80=AFPM Lukasz Luba <lukasz.luba@ar=
m.com> wrote:
> >>>>>
> >>>>> Hi Rafael,
> >>>>>
> >>>>> On 4/23/24 19:00, Rafael J. Wysocki wrote:
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>>
> >>>>>> If cdev_dt_seq_show() runs before the first state transition of a =
cooling
> >>>>>> device, it will not print any state residency information for it, =
even
> >>>>>> though it might be reasonably expected to print residency informat=
ion for
> >>>>>> the initial state of the cooling device.
> >>>>>>
> >>>>>> For this reason, rearrange the code to get the initial state of a =
cooling
> >>>>>> device at the registration time and pass it to thermal_debug_cdev_=
add(),
> >>>>>> so that the latter can create a duration record for that state whi=
ch will
> >>>>>> allow cdev_dt_seq_show() to print its residency information.
> >>>>>>
> >>>>>> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device =
debugfs information")
> >>>>>> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>> ---
> >>>>>>     drivers/thermal/thermal_core.c    |    9 +++++++--
> >>>>>>     drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
> >>>>>>     drivers/thermal/thermal_debugfs.h |    4 ++--
> >>>>>>     3 files changed, 19 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>
> >>>>> I'm trying to test it on my board and do the review, but faced issu=
e.
> >>>>> For some reason I couldn't apply that patch on the latest bleeding-=
edge
> >>>>> branch.
> >>>>> Could you help me in this please? Is there something missing in the
> >>>>> patch set (like one more fist patch)?
> >>>>
> >>>> I messed up the ordering of patches (patch [2/3] should be the last
> >>>> one in the series) and on top of that, you'll need a small rebase on
> >>>> that patch.
> >>>>
> >>>> Sorry about this, I'll send a v2.
> >>>
> >>> Actually, the ordering was OK, but the rebase of the second patch is
> >>> still needed.  I'll send a v2.
> >>
> >> Thanks, I've seen it. That v2 applies smoothly and runs on the board.
> >> I'll test it and review.
> >
> > Thank you!
> >
> > Please also see
> >
> > https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/
> >
> > which is actually more urgent because the fixes there address more
> > serious issues (I would even consider them as 6.9-rc material).
>
> Yes, I've read that patches' headers and glanced through the code.
> I'll do the review & testing on them as well today.

Thanks, much appreciated!

