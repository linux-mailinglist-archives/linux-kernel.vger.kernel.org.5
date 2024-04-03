Return-Path: <linux-kernel+bounces-130006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70083897316
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A192F1C22634
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A501C14901F;
	Wed,  3 Apr 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/tdlNpT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB65B66E;
	Wed,  3 Apr 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156047; cv=none; b=BMubEThR2YiJM8Vcoq5yheNfyntVbBhwojyayXMmJL39DQ7CcWsbPuONKbNk9fe91y6HsWmefwZjOJy/r7Ched01sR7fbvAvvu9UZMQn7qz4Yp03E0XyLyR5mWvh/fEheT9yAhsEJ6s4i3J69cMUX/QiXB9CZrb1j98H5CmGizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156047; c=relaxed/simple;
	bh=ZdTDkDvhWvcbpl14yhv4Zh3E+B9iU9jq8RS0OPet/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY0mGNp5b8bVypgRXDGQ/4i+rALUs9d5hwCg1E0YcJg1aAvwKw3GMGfWC8obFPTwxD+Mrkbs+TpWKE4LH0P8JAELfZaqxelqDvAFxnnEdWvcSKRmDl/Rl9w/ABp+nJUcmclAL85p63uAF+9ubnzrMUVoHsXinVhTKqSDHYwXHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/tdlNpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC8C43330;
	Wed,  3 Apr 2024 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712156046;
	bh=ZdTDkDvhWvcbpl14yhv4Zh3E+B9iU9jq8RS0OPet/qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U/tdlNpTBq1FIZNucUpHv1Shfrzlz6A6JDsb3C/dFBS/BPQ/goXG8Wxl37GTR2XZB
	 DUdQ2DgcVSubHnJSVCKkxowp1zaVQ7BVsQfgBciBAlD0XPmGKsbFFoS4/m+0nY99Ep
	 g+9pi59J2ZRwRtop3PW6dX7z3gDaYHfN+Z0mgojq0cXg+lGUP7K8aw2RDxt7gWwPYX
	 Z1/qts9tU9XO5Sp8aKYeDqIQNXXt/DxCSkBFhA7dyEjHDs2AJQsVWTFyEysnPtEB0f
	 4m4KeT44xmuN2v8xXRKEpj29dhU+pK/BpKI01I7tYNZXDRDjDjHqkBW3HYHvfn/Efm
	 pm0ICA78yxaiQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4930d9c48so1260257eaf.1;
        Wed, 03 Apr 2024 07:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmgSdhCIO7AbhnREeWMbsVF+10KQGTCQQ4D6DnVqcf5d2PWNO+5PZbRgPePk2o4L80/W2CHlssbMpLJcIS84eiaZCgMEJvTbEFhZniOBGZySyh3Rktws30tURRLfwRrG/F0G6RiEMXW4XV0gRyB/c7i7bMU2lqfBc0zwj0Vgggh/0=
X-Gm-Message-State: AOJu0YwCWneVtsdQNqaUZqqbaikhVZy3l7wbxPybyelPfNX9pf7e0Adu
	BQCiuJy8ziNCq9BCaKPUVTA3fuuIQX+RW82uSvjt7o6LrYy/O2CTaEiZNAd5eKwEZGJORokXLLL
	KRNGJr3s/BlG7P43QZZn030V59Eg=
X-Google-Smtp-Source: AGHT+IFmeAIEBKNUUeBrXb8QHVZbYefZ5snm1WkS62JAtwDxMTixZzYn3yPdg2hhGm/NjUu67k5wzWnJytCmygYN01k=
X-Received: by 2002:a05:6820:2289:b0:5a4:6e23:e335 with SMTP id
 ck9-20020a056820228900b005a46e23e335mr18125057oob.0.1712156045715; Wed, 03
 Apr 2024 07:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318151631.1621881-1-d-gole@ti.com>
In-Reply-To: <20240318151631.1621881-1-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Apr 2024 16:53:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOEkmE741_hAmprYYxmi5p9WZPrxOu59Y3FqzLM9oJwg@mail.gmail.com>
Message-ID: <CAJZ5v0iOEkmE741_hAmprYYxmi5p9WZPrxOu59Y3FqzLM9oJwg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] PM: wakeup: make device_wakeup_disable return void
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, theo.lebrun@bootlin.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:17=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> This is a follow up patch based on discussions with Rafael[0] on a previo=
us
> patch I sent to propagate return value from device_wakeup_disable
> further upward inside device_init_wakeup
>
> However, it doesn't seem like today any return values from
> device_wakeup_disable are very useful to the caller.
>
> I could only spot one caller of this function that was actually
> propagating the return value upward other than the PM core calls. I have
> tried to update sdhci-pci-core to work with the new changes
>
> [0] https://lore.kernel.org/all/CAJZ5v0jbHwiZemtNAoM-jmgB_58VqmKUkqv4P7qr=
PkxWzBzMyQ@mail.gmail.com/
>
> Changelog:
>
> v1 --> v2:
> * Squashed the mmc fix into first patch [Rafael]
>
> Dhruva Gole (2):
>   PM: wakeup: make device_wakeup_disable return void
>   PM: wakeup: Remove unnecessary else from device_init_wakeup
>
>  drivers/base/power/wakeup.c       | 11 +++++++----
>  drivers/mmc/host/sdhci-pci-core.c |  2 +-
>  include/linux/pm_wakeup.h         | 12 +++++-------
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> --

Both patches applied as 6.10 material, thanks!

