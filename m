Return-Path: <linux-kernel+bounces-118959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470888C1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DB41C3F3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E971B40;
	Tue, 26 Mar 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbjX0r/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3397174B;
	Tue, 26 Mar 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455686; cv=none; b=sTP7Z4mMxW6vTXII82CewT2aaS4iC0CovpKhybSUvvOKWlybmw1qQe84pq7r82myHvNktwsHIp7khQgasG6vS1AfFepCYf/537exmAm4ZYAWo1RzhU2pA03aoJFa+AwCnFD6D4F1onGJIDOqA5h15ISu4gUxCnIeHqmK5p2qoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455686; c=relaxed/simple;
	bh=5pFOehu23RiUY0BYXzSTBk2aotPMSZ0Omiv/vhmPVTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5yQyFhurFFKP32JgU6tacpZY1AjKsm9TJHi68tl8xhd/myYSdwltGMHcsgaWzsJu9kncTVf+8vBbmLkUPw7zOW4Q1Ww4Aj/Jp716N1UKrW8D5Ym3ymQHp1ozAS/c0MAGL+GgYfZNE51SqzpijRnMGxfpXfUtUNqORfgu66wjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbjX0r/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F70C43399;
	Tue, 26 Mar 2024 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711455686;
	bh=5pFOehu23RiUY0BYXzSTBk2aotPMSZ0Omiv/vhmPVTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CbjX0r/YOTkJvv3GDIkOKz+upCe1NGNNDaQ65PF6+1tOCzAgC24UxPSql+7rwL5Wb
	 DeANhU0XuyJmDHnZJBB9WfwMfrLknoF4JnyWhNNNsUszcT3/XJpTJlKClr1tu+dlAp
	 ObKjBKGTCSVzVRzVUpJv7tQeoxHKfOHja4v5B1ajvXfFxYqH//O6sPGJQVyrdhWr5+
	 MXhpWaWgPTyurFUeM4io8KViKwQVi5J2gs9L61ZaaFeVrPJRX+sMI/kBoQdV70LE9m
	 Yq1hvmZCz6iXLJ+TUfKtlpmutTd4nGfPRQ+w+TEPDk3zQqU5bU7wbmmGgLHg08aN+2
	 KuoodPthZT4Mw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a48320f0f3so776270eaf.1;
        Tue, 26 Mar 2024 05:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWz40F9eaboEh9Ie+JGSj8M5VcK5eRNPlZZqd3TH5L2eoq27DqC8M/46ymYci3MMyg8IxPguMCHxZQIOby8XIkJpK3op7bWOQ7kt0aHoluvw5xU9vBIqR9bZwJc4XyEc/EuSwZrdUA=
X-Gm-Message-State: AOJu0YwuTwJdDWKZUqR2+nv0qaz1DSrKn5zxZgSQ//NKrunYTv8NBemH
	Q0JKDYLQ4zrTbMnbfFs9HkCj/YpkpGNAVI5LJ/XgVb5L3bGhrjNAqwU19HyOOJdlg46bDOmHKG3
	vpMbhN3FxLITY5ZdoHtLckGwYIws=
X-Google-Smtp-Source: AGHT+IEK57tP/VjSYirhPAhG/Ufy9aEFvsV0mjUGELZEVKAiXgwO+z2LIM7XmmQJ+Yc3Jo5405DIQ+lcUn3r1t7eVrM=
X-Received: by 2002:a4a:6c19:0:b0:5a4:7790:61b4 with SMTP id
 q25-20020a4a6c19000000b005a4779061b4mr8128005ooc.0.1711455685354; Tue, 26 Mar
 2024 05:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325222424.4179635-1-daniel.lezcano@linaro.org> <fbef883e-23f8-41b9-852b-c52d18816559@notapiano>
In-Reply-To: <fbef883e-23f8-41b9-852b-c52d18816559@notapiano>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Mar 2024 13:21:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5wZvKgh7HGa0NSrVQ=E-WeC1v0Av0h08-mQC9t7HQ3Q@mail.gmail.com>
Message-ID: <CAJZ5v0g5wZvKgh7HGa0NSrVQ=E-WeC1v0Av0h08-mQC9t7HQ3Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "thermal: core: Don't update trip points inside
 the hysteresis range"
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:29=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Mon, Mar 25, 2024 at 11:24:24PM +0100, Daniel Lezcano wrote:
> > It has been reported the commit cf3986f8c01d3 introduced a regression
> > when the temperature is wavering in the hysteresis region. The
> > mitigation stops leading to an uncontrolled temperature increase until
> > reaching the critical trip point.
> >
> > Here what happens:
> >
> >  * 'throttle' is when the current temperature is greater than the trip
> >    point temperature
> >  * 'target' is the mitigation level
> >  * 'passive' is positive when there is a mitigation, zero otherwise
> >  * these values are computed in the step_wise governor
> >
> > Configuration:
> >
> >  trip point 1: temp=3D95=C2=B0C, hyst=3D5=C2=B0C (passive)
> >  trip point 2: temp=3D115=C2=B0C, hyst=3D0=C2=B0C (critical)
> >  governor: step_wise
> >
> > 1. The temperature crosses the way up the trip point 1 at 95=C2=B0C
> >
> >    - trend=3Draising
> >    - throttle=3D1, target=3D1
> >    - passive=3D1
> >    - set_trips: low=3D90=C2=B0C, high=3D115=C2=B0C
> >
> > 2. The temperature decreases but stays in the hysteresis region at
> >    93=C2=B0C
> >
> >    - trend=3Ddropping
> >    - throttle=3D0, target=3D0
> >    - passive=3D1
> >
> >    Before cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D95=C2=B0C
> >
> >    After cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D115=C2=B0C
> >
> > 3. The temperature increases a bit but stays in the hysteresis region
> >    at 94=C2=B0C (so below the trip point 1 temp 95=C2=B0C)
> >
> >    - trend=3Draising
> >    - throttle=3D0, target=3D0
> >    - passive=3D1
> >
> >    Before cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D95=C2=B0C
> >
> >    After cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D115=C2=B0C
> >
> > 4. The temperature decreases but stays in the hysteresis region at
> >    93=C2=B0C
> >
> >    - trend=3Ddropping
> >    - throttle=3D0, target=3DTHERMAL_NO_TARGET
> >    - passive=3D0
> >
> >    Before cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D95=C2=B0C
> >
> >    After cf3986f8c01d3
> >    - set_trips: low=3D90=C2=B0C, high=3D115=C2=B0C
> >
> > At this point, the 'passive' value is zero, there is no mitigation,
> > the temperature is in the hysteresis region, the next trip point is
> > 115=C2=B0C. As 'passive' is zero, the timer to monitor the thermal zone=
 is
> > disabled. Consequently if the temperature continues to increase, no
> > mitigation will happen and it will reach the 115=C2=B0C trip point and
> > reboot.
> >
> > Before the optimization, the high boundary would have been 95=C2=B0C, t=
hus
> > triggering the mitigation again and rearming the polling timer.
> >
> > The optimization make sense but given the current implementation of
> > the step_wise governor collaborating via this 'passive' flag with the
> > core framework it can not work.
> >
> > From a higher perspective it seems like there is a problem between the
> > governor which sets a variable to be used by the core framework. That
> > sounds akward and it would make much more sense if the core framework
> > controls the governor and not the opposite. But as the devil hides in
> > the details, there are some subtilities to be addressed before.
> >
> > Elaborating those would be out of the scope this changelog. So let's
> > stay simple and revert the change first to fixup all broken mobile
> > platforms.
> >
> > This reverts commit cf3986f8c01d355490d0ac6024391b989a9d1e9d.
> >
> > This revert applies on top of v6.9-rc1.
> >
> > Fixes: cf3986f8c01d3 ("thermal: core: Don't update trip points inside t=
he hysteresis range")
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> > Cc: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> As mentioned in the commit, the issue is elsewhere, but given the origina=
l
> commit was an optimization to prevent unnecessary trip point updates, and=
 that
> it seems to have caused a regression, sounds reasonable to revert at leas=
t while
> a proper fix isn't found.
>
> Acked-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Only thing is you might want to add a cc: stable tag to guarantee it is
> backported (AFAIR Fixes: doesn't guarantee backport), even more so given =
there
> are conflicts.

Applied as 6.9-rc material, thanks!

