Return-Path: <linux-kernel+bounces-121397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73F88E76D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71ED1F30F57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EA1420D5;
	Wed, 27 Mar 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwrJOIvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57985F86B;
	Wed, 27 Mar 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547955; cv=none; b=QkaQrteERu+kdwKjoaWesqAI0JzYLuIqym2/vp15CLoTgCpGaJGqSmw/E0eGhMFzMlZYDj81EFLHjT8fQKtUfmKDWhjU5+FbEz2wUv72gwKD38YBuGCdSiY/jyvz7bmKPaA0CDFydxxi987X0llwBDgz4rQn1AFw4L7p4airOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547955; c=relaxed/simple;
	bh=y7yN0TthxO4uWT3oRU9hlOqPj8ktWodvttgpdiryghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWiZKSrLVOPtzlbkEk0O3LTcWJN7Gs4y/yGuY0podTxNyVgwspMs4OGiN77e0PqX/y66T+MeUlLpaLPAQo2iIQUCDduy0K7JPpWp/6vqD6fE5GMjYSvL3DaA2EDXNguGy1IJaUfoj6f2A6GIvHnFKlIGRMa4MkieLh2ab59QJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwrJOIvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8CC433F1;
	Wed, 27 Mar 2024 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547954;
	bh=y7yN0TthxO4uWT3oRU9hlOqPj8ktWodvttgpdiryghw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cwrJOIvV5CojMqp/G6F7olo4S1tgohbPYJNr8D18I6Xe8/gCy3YU7162zMWt4QK+f
	 EoW5+SfY+ruoZWnfN5vPydVFr9X7+lGmKw9dVOGGH/jVAzFWMOXzSSVrDSPa9pd4Pi
	 OrRra25o7GrOYEoafJ3m/NcGQoJkGjr3hTbKlS37omZUNaXXC9AvcN8BhWr4Ytchec
	 Ux/3PtYyAg3EhBjwUqGzlK0ct1HO4L/Hgst2+86qz8amhKlFlJUKuA3t8GdqwYFtyz
	 senzZEKL1gsLqPtXdUlxs9ZJBD2bMkWIVqvM7TqM+3lOrbfDg1fEDvyENlciOw+hd0
	 nOP+Uygii8/pA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a46b30857bso1692118eaf.1;
        Wed, 27 Mar 2024 06:59:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6TjLfFmP6aINZnc0Wy9gPmzUayE6Q9p1V+R7fVlBTBaswr4xQ8zk4A5ZP2LNVMHiVHqJCHg3dIatDxtni+MWVxoNgu5Hm4ZAdygvipYwsiURqEqudpmuSP6xOf8kUy0eJLMQ2e+T1OKF4Wd+glBaWBCbtXxrLPRLOkcwWQH6S3V5f12vAbnQ=
X-Gm-Message-State: AOJu0YwSHRFwIFgE9cbJxa0oDXa6cNTDlTM9v+TYWrA8lwb6o4ICUe6l
	H1IzHiZ/Yc0AoQ1Pys4rIpAoDfG7Kres94dVy2nb8sgxooKAzTDA+eQS+omnP/CBu5raGHFNQeL
	pntlbUrc7damscNnDWogLyyBDKJU=
X-Google-Smtp-Source: AGHT+IEFGimHh+uanqAvyhjUMV3UHiSF4NKYvqHcu5RJLKSgHp+VbnfnsEWUrc8xWu2YTOL0FYhRRvCUMztVdIJAKJw=
X-Received: by 2002:a05:6870:d252:b0:229:e747:6f56 with SMTP id
 h18-20020a056870d25200b00229e7476f56mr12486707oac.3.1711547953856; Wed, 27
 Mar 2024 06:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-v1-1-08839fbf737a@google.com>
 <CAJZ5v0j=cYbqyfi6y45hnu+Y_tvMGYb9p6d=kpsOA0AsxBoy3g@mail.gmail.com> <a2bdac6a8914a76ed122438547f3697611299c0f.camel@linux.intel.com>
In-Reply-To: <a2bdac6a8914a76ed122438547f3697611299c0f.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 14:59:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5qkunO=kWcmoQKwguaRGTq8ETevvpbsYCUeCbfy9-0Q@mail.gmail.com>
Message-ID: <CAJZ5v0j5qkunO=kWcmoQKwguaRGTq8ETevvpbsYCUeCbfy9-0Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x_thermal: replace deprecated
 strncpy with strscpy
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 5:20=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2024-03-19 at 12:39 +0100, Rafael J. Wysocki wrote:
> > On Mon, Mar 18, 2024 at 11:36=E2=80=AFPM Justin Stitt
> > <justinstitt@google.com> wrote:
> > >
> > > strncpy() is deprecated for use on NUL-terminated destination
> > > strings
> > > [1] and as such we should prefer more robust and less ambiguous
> > > string
> > > interfaces.
> > >
> > > psvt->limit.string can only be 8 bytes so let's use the appropriate
> > > size
> > > macro ACPI_LIMIT_STR_MAX_LEN.
> > >
> > > Neither psvt->limit.string or psvt_user[i].limit.string requires
> > > the
> > > NUL-padding behavior that strncpy() provides as they have both been
> > > filled with NUL-bytes prior to the string operation.
> > > >       memset(&psvt->limit, 0, sizeof(u64));
> > > and
> > > >       psvt_user =3D kzalloc(psvt_len, GFP_KERNEL);
> > >
> > > Let's use `strscpy` [2] due to the fact that it guarantees
> > > NUL-termination on the destination buffer without unnecessarily
> > > NUL-padding.
> > >
> > > Link:
> > > https://www.kernel.org/doc/html/latest/process/deprecated.html#strncp=
y-on-nul-terminated-strings
> > >  [1]
> > > Link:
> > > https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.htm=
l
> > >  [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > Srinivas, any objections?
> No
>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 6.10 material, thanks!

