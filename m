Return-Path: <linux-kernel+bounces-159037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C7B8B2881
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6394B23C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32912C7FF;
	Thu, 25 Apr 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiFoMhwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515B1534E1;
	Thu, 25 Apr 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071229; cv=none; b=ZmzTs0gHN20xqIbGsI7CY0QQBGzoDUmW7LoiE5tgT0aBVgMwqEBvtdfgjrfhvmezEcaVTxXFANvY/J2NbvcdduvOKHCLhGfv92rSwVRWlDHDPlyp/fKlAYAArmZ21LDFF/SOjMs9LqO2i1os0MFUrYS/B/fY6ljMYYYWmjnArqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071229; c=relaxed/simple;
	bh=BFWuGLTssRXIr5xt21+W1at5pIODCpOmFVmXcVu4PYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA10K6Qm7rC39NEMeRfAZD6ew93yhTv33Wb/Ui9/d7jtjNLK131paNFRslqXXSuLnEBDBE25M+If2ZIAjvUhJ5zC4qF1CuSxC5LkuNyemvpuZ1Kqteza9EQyZu8VLIwX4v0PqabTz2BOpoeSD+9HtEwOxNzIXWCVlYJY4dUu+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiFoMhwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA71C2BD11;
	Thu, 25 Apr 2024 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071229;
	bh=BFWuGLTssRXIr5xt21+W1at5pIODCpOmFVmXcVu4PYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DiFoMhwFdLuBuW2yX/yQ68HpbxTcB+auOPn1xMAW+1IcTpXsKvPn1hWpNsG8WhG1U
	 XiH9OzRVc44s2OJcSdQRIfJwTT83z9T7i2J4haZiKNKJ240fZ9DeKBw++J8R4qcUwC
	 jnffVSalaZBlSwcCuMdaCY5pTzXjU72pjj54Lg1gm5wZu/Gn7fuFoBhMqf2BQLOwWc
	 iBSW3aQplLxoW2zbo7cUSWvSrIKvk1x5w7Cm0QWjZJlP9ccWbYe3nFr/oNLM/CURP7
	 YcDg+z6krLx4k2kK/BTO75NfUNsQCxzLIaFhLBJ5c/sylpRnzhomZVAae2AsRruSC7
	 DVzX2UrSUSCNQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eba841d83cso290168a34.2;
        Thu, 25 Apr 2024 11:53:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViW5URg629onHrGUMghRExIeU5FR3Efk0oMo4ZNuNVZXgpidXDj1f5mCP8AUB0FttrcCevYddGXf70SWEGULfCmCSVOEomZqeELColyW0nLZz2GPsqsTfIL6MIL8mfPESNpuar9NI=
X-Gm-Message-State: AOJu0Yzz2uouoj1wcghvjJ7OkB6XCxyAn+UX3YvNnyX73+NbfRQvYte2
	xBC0ur/mzLzLzjGxGXjm3wjHsc2PepZKQWwBnw/J+qaZayDxsJm7gBUp6DPKQpcPDMZQPvJyGIy
	ZxRXJgAtLayGjIfjp28OIsPB28KA=
X-Google-Smtp-Source: AGHT+IGU9GK2XXxiQn37pFzu6OOI6Wbl+GUgzzpeh4ocyTt8wiiqNlOS/jQtCciywfrjW+pCSFi+2dR8Y21dhkxKLmE=
X-Received: by 2002:a4a:eb18:0:b0:5af:6d3b:d952 with SMTP id
 f24-20020a4aeb18000000b005af6d3bd952mr820517ooj.0.1714071228759; Thu, 25 Apr
 2024 11:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher>
 <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com> <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
 <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com> <4f21ee21-0178-4d50-a535-4d530baf82d1@arm.com>
In-Reply-To: <4f21ee21-0178-4d50-a535-4d530baf82d1@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 20:53:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0je44QB=dBObgDd-1pJweXdj5ZC-7sEyrOjyJ+c=n9xPQ@mail.gmail.com>
Message-ID: <CAJZ5v0je44QB=dBObgDd-1pJweXdj5ZC-7sEyrOjyJ+c=n9xPQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:42=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 4/25/24 14:00, Rafael J. Wysocki wrote:
> > On Thu, Apr 25, 2024 at 2:36=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> Hi Lukasz,
> >>
> >> On Thu, Apr 25, 2024 at 12:02=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> >>>
> >>> Hi Rafael,
> >>>
> >>> On 4/23/24 19:00, Rafael J. Wysocki wrote:
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> If cdev_dt_seq_show() runs before the first state transition of a co=
oling
> >>>> device, it will not print any state residency information for it, ev=
en
> >>>> though it might be reasonably expected to print residency informatio=
n for
> >>>> the initial state of the cooling device.
> >>>>
> >>>> For this reason, rearrange the code to get the initial state of a co=
oling
> >>>> device at the registration time and pass it to thermal_debug_cdev_ad=
d(),
> >>>> so that the latter can create a duration record for that state which=
 will
> >>>> allow cdev_dt_seq_show() to print its residency information.
> >>>>
> >>>> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device de=
bugfs information")
> >>>> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> ---
> >>>>    drivers/thermal/thermal_core.c    |    9 +++++++--
> >>>>    drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
> >>>>    drivers/thermal/thermal_debugfs.h |    4 ++--
> >>>>    3 files changed, 19 insertions(+), 6 deletions(-)
> >>>>
> >>>
> >>> I'm trying to test it on my board and do the review, but faced issue.
> >>> For some reason I couldn't apply that patch on the latest bleeding-ed=
ge
> >>> branch.
> >>> Could you help me in this please? Is there something missing in the
> >>> patch set (like one more fist patch)?
> >>
> >> I messed up the ordering of patches (patch [2/3] should be the last
> >> one in the series) and on top of that, you'll need a small rebase on
> >> that patch.
> >>
> >> Sorry about this, I'll send a v2.
> >
> > Actually, the ordering was OK, but the rebase of the second patch is
> > still needed.  I'll send a v2.
>
> Thanks, I've seen it. That v2 applies smoothly and runs on the board.
> I'll test it and review.

Thank you!

Please also see

https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/

which is actually more urgent because the fixes there address more
serious issues (I would even consider them as 6.9-rc material).

Thanks!

