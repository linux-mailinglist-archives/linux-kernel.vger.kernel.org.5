Return-Path: <linux-kernel+bounces-153527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB568ACF32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB732283923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F651514C5;
	Mon, 22 Apr 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf1+8e6f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98222625;
	Mon, 22 Apr 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795628; cv=none; b=DZ6tPfDAq4Z2rRjCupEScev77kyjoXSUVM2jnS16KE32RbUs9JMnIwmnSR92/4x0xyro2G0024Xy0pAUHxrmYl/lEYOgoLWMy2VOktU1pPO8vhefgQHunHt2W1L4P7WImG76u5/JRw1I7X2zBjealSzRUSXAKUcw9Loziud/Iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795628; c=relaxed/simple;
	bh=leZjNYMHomXNgJ6IQ0Dc0ye6Ylmg0NHf7hGp59RENII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1s945cd3DmMuFltU0W5OUVdpG3jkbwhm9cGoikMjgAnGnC5p1dqaRJ/y/egQEVugfL5atauEqqzIukh6dL+b+620l1YGuGb/w7ozPrJN694AQfUdgkrH2t6ktiFbEugOyM8Y32dYoxGvf6J2RN6Avy20xIDWENk0kqCOWQ7tTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf1+8e6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BC2C116B1;
	Mon, 22 Apr 2024 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713795628;
	bh=leZjNYMHomXNgJ6IQ0Dc0ye6Ylmg0NHf7hGp59RENII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mf1+8e6fsO0Mbvrl42mWZZHGWGcGHv6i2uj/rgIq1yeQKVs7HTrT6p2udZmJjDMfo
	 YBByql65Xt583HXFp9aoquP/akWvdilLcxFBhqHwbjErfinl5uW/LWEdbwnktyBKRy
	 DSESi0dWx9LQc7MJKlu/0JifD/I+ujVEro5HvCHrozzzHr3WfQvkxcQwsi+PzoRDla
	 rB0NsaiSPWi9vihd5AWK2sW0cyvxj9RK63U8/WVocNyDzSdEh7HSdJdbfcBxjU0vT8
	 iWVRNhl+RaqgvqGwWJ0s6jm3vBkj0pWxit4CeYrJIEekneDAT8tDxUdNRLfMcmuYpA
	 0hA2gAKslGnvQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5acdbfa6e94so1183629eaf.2;
        Mon, 22 Apr 2024 07:20:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjrG2haZGvi0mNcr8+ZucXT1OYyIHXiCFlovXkAGv8sDgVgL9Pb7+xv282iK8bFgb3ed5t8sz1dFoNBeq++rZ4AiuILJwFwq+UK5YKFnRPGlC9goWa6M9bDb7efd4/hLWCPpf4u78=
X-Gm-Message-State: AOJu0Yzp/1Sic6JeZ2w2urgEoTEc6FCRg5DEJNPP36zjfifEfo1KiK/r
	vK2ZLMey52SI6maPEl+ynS7k8ck9CSgVdNce4wqrzLqg5yIQP/XjDufHqM26zxJw0czV/rYmX/9
	Hb7bZml/P6V+3nouRASQgZ56htpY=
X-Google-Smtp-Source: AGHT+IHopBr72tHT19E2iulxiSba+I5q8d7EuDgmQd+r93MaPX8iYWJkwIjSCCpEH7vwHrMWpqwofOaulq7xTouwOWA=
X-Received: by 2002:a05:6820:ecb:b0:5ac:6fc1:c2cb with SMTP id
 en11-20020a0568200ecb00b005ac6fc1c2cbmr10303162oob.0.1713795627344; Mon, 22
 Apr 2024 07:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4918025.31r3eYUQgx@kreacher> <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
In-Reply-To: <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 16:20:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3ih_st6_cBG5H29w546634FJLSVve_WjduxF_26FzHA@mail.gmail.com>
Message-ID: <CAJZ5v0g3ih_st6_cBG5H29w546634FJLSVve_WjduxF_26FzHA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Apr 22, 2024 at 1:37=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 4/17/24 14:07, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > The first patch in this series addresses the problem of updating trip
> > point statistics prematurely for trip points that have just been
> > crossed on the way down (please see the patch changelog for details).
> >
> > The way it does that renders the following cleanup patch inapplicable:
> >
> > https://lore.kernel.org/linux-pm/2321994.ElGaqSPkdT@kreacher/
> >
> > The remaining two patches in the series are cleanups on top of the
> > first one.
> >
> > This series is based on an older patch series posted last week:
> >
> > https://lore.kernel.org/linux-pm/13515747.uLZWGnKmhe@kreacher/
> >
> > but it can be trivially rebased on top of the current linux-next.
> >
> > Thanks!
> >
> >
> >
>
> I've checked this patch patch set on top of your bleeding-edge
> which has thermal re-work as well. The patch set looks good
> and works properly.
>
> Although, I have found some issue in this debug info files and
> I'm not sure if this is expected or not. If not I can address this
> and send some small fix for it.
>
> When I read the cooling device residency statistics, I don't
> get updates for the first time the state is used. It can only
> be counted when that state was known and finished it's usage.
>
> IMO it is not the right behavior, isn't it?

I agree, it is not.

> Experiment:
> My trip points are 70degC and 75degC and I'm setting emulated
> temperature to cross them and get cooling states 1 then 0.
> As you can see the statistics counter only starts showing value after
> after trip crossing down.
> ------------------------------------8<-----------------------------------
>
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> root@arm:~#
> root@arm:~#
> root@arm:~# echo 71000 > /sys/class/thermal/thermal_zone0/emul_temp
>
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> root@arm:~# echo 76000 > /sys/class/thermal/thermal_zone0/emul_temp
>
> root@arm:~#
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       518197
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       518197
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       518197
> root@arm:~# echo 71000 > /sys/class/thermal/thermal_zone0/emul_temp
>
> root@arm:~#
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       520066
> 1       17567
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       522653
> 1       17567
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       526151
> 1       17567
> root@arm:~# echo 66000 > /sys/class/thermal/thermal_zone0/emul_temp
>
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       537366
> 1       17567
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       544936
> 1       17567
> root@arm:~# cat
> /sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
> State   Residency
> 0       556694
> 1       17567
> root@arm:~#
>
> ------------------------------->8----------------------------------------
>
> Please let me know what do you think about that behavior.

If you have thought about fixing it already, please do so.

Thanks!

