Return-Path: <linux-kernel+bounces-121561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD188E9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE75C1C313E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0913247D;
	Wed, 27 Mar 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCmDhIHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498613A3FF;
	Wed, 27 Mar 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554290; cv=none; b=GBLuvUwEd48uxxrjkrKI7nB16e/oNJPiskyj2ZbzmRan8mi6r1d1mPW9ofa2HthMk+cIzsFIo2KzKK9weKtH8Ds9Tew6GcEGk6zu6EY+Z+XPRjoXWytAZXUksJ1semZbQslcXNx4Roo4THpo0EJkxKzl8djuXvRgVGyUDfn7IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554290; c=relaxed/simple;
	bh=+NIa5J5TSJ7cA8Syi4CHzkOpCVlLP9HE63EdCDK+cRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXd35Wa/wIzIdDNGDDPwOOojGExnCPyyyCBqiU+MUyQWkpNN+cYIYk1t/l5fSSdS2d8YB3gLNJI2ua/EstleOJn+ameJCjhZChnABVn+MMGszUfcdapm2NgUi7zzFntsZJ/xYLtfLLqNQnoUYe6A99pNSixtj0Adxi3pZtTObq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCmDhIHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEACEC433C7;
	Wed, 27 Mar 2024 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554289;
	bh=+NIa5J5TSJ7cA8Syi4CHzkOpCVlLP9HE63EdCDK+cRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TCmDhIHf6MYt6jA/m2FOwtQnSjGrPsCib8wKZ3lf/Uzvhg7+mJ2LHSLQuFCnOJc5Q
	 HFLB/wEwnK8UYU9ryDiRE7a+KtcX5mlYuaXi7DaZq8Mlq5J14HaFGP4sToa+MdDD0Q
	 m6O/wWAs8Mg/l05twHo7LpO8FfSawuSoL0xDPVma7jIdrHdnTHKezIRL29+EyO3dUB
	 KSoakbsf/HbC78vkt1/jQj2Ulx6Uz2PnPlJIwhZ4HA2ajwuwVD5YeDTsZOd2oA7ReM
	 SksO4if+GZMc5eYfOlU7BIYvazUP0JEPsAU+CxC6ISt97+9HJH7+ZNzWbzWyYzAx2a
	 4LquRaY27FEiQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6a40a15c5so1996690a34.0;
        Wed, 27 Mar 2024 08:44:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrLX7XD9+ThVNU9sABWzC4OF1D2Bf0XVk4sX3NysVeD51fJ/krVmlCkqOxc1fg6/D7bKid4QV0mr9t2alfPQk0x4Y94KvfFS+oC+3PZfv2zvrvEx1gSb+HCNYHvSnNFKJAVSkEe/4=
X-Gm-Message-State: AOJu0Yz+cr8i/OagRyQlz6wTUm05BywbbojJBAV0yPsKrdMbUFOMGbZl
	hkNI2n/xyIhF/lpvtKu1yqTHOgOUywnA1KHNvXr8TO0VzPLAlzpovxawtDstCCzFjIAj/RpOaML
	RIU4BoPzDc2Wi1dErzmKonwvqSxU=
X-Google-Smtp-Source: AGHT+IFRjXu6XODER8iIXFwVOxGCKZ5u/SbJ86GhZp/aswG6CVO2u1aJZXwbY2lxvrkypGOkEjpRW2pIDL5E4cKCV4M=
X-Received: by 2002:a05:6870:6715:b0:229:e46d:763a with SMTP id
 gb21-20020a056870671500b00229e46d763amr63216oab.0.1711554289017; Wed, 27 Mar
 2024 08:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2331888.ElGaqSPkdT@kreacher> <42ffcfb8-33fd-4ea5-bfac-fa8c78cd1cd4@linaro.org>
 <2273843.iZASKD2KPV@kreacher> <1f028df8-435a-43cb-b776-0c2141f1c374@linaro.org>
In-Reply-To: <1f028df8-435a-43cb-b776-0c2141f1c374@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:44:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iz5+suB8jiHvxxCtibXo0mN5Grke1zzax4tQvV1kY-2w@mail.gmail.com>
Message-ID: <CAJZ5v0iz5+suB8jiHvxxCtibXo0mN5Grke1zzax4tQvV1kY-2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] thermal: More separation between the core and drivers
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:05=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/03/2024 14:39, Rafael J. Wysocki wrote:
> > Hi Daniel,
> >
> > On Monday, March 25, 2024 2:33:27 PM CET Daniel Lezcano wrote:
> >>
> >> Hi Rafael,
> >>
> >> thank you for this series.
> >>
> >> It has been reported a regression with commit cf3986f8c01d3. I'm
> >> investigating and confirming it. If it is the case a revert may impact
> >> this series.
> >
> > Sure.
> >
> > Can you please give me a pointer to a BZ or e-mail thread where this is
> > being handled?
>
> That has been reported to me directly. In a moment, I'll start a thread

There is only a tiny conflict in one hunk of patch [1/3] with this revert:

https://lore.kernel.org/linux-pm/20240325222424.4179635-1-daniel.lezcano@li=
naro.org/

and it is straightforward to resolve, so no worries.

I'll send an update of patch [1/3] nevertheless.

Cheers!

