Return-Path: <linux-kernel+bounces-160203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4D8B3A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BB51F237F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEF14885A;
	Fri, 26 Apr 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVmBP/U9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDA1E504;
	Fri, 26 Apr 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143923; cv=none; b=rqyYjqk1nJ7A/dsSxseSs74OhwsNTNySKJmb5/e5MyO21RbY2Mh19whaqhaZq9VTkydmnlHu4WtKgTdBWm+R/gcFaBxVefOKr5+XPf6NnCv2b6+hY8O0meoyh0poW2fJXY9CGHVrVoQudnyBS8Fel6aI92x3tb2VDlDtn7t423s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143923; c=relaxed/simple;
	bh=VejedOxxTo7QSOwkYVcTq4fFLRSVBP4jvU07o8BqGVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkRRpYCuNKxtW0jPPoImLwOLIxu3pMuWWnB6jW/6Vej/mmtmO2GW3eTaU8uRjKDKN32x0aEXXn3OKKvfuWu9mnKv6Q/+bvHnWkYIJQlHNLfN862eM658viXUFz4ZwikP0gqR5TA6VQB/kQvSjH4jiea6WtcSu45/gspivjfDqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVmBP/U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0255C116B1;
	Fri, 26 Apr 2024 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714143922;
	bh=VejedOxxTo7QSOwkYVcTq4fFLRSVBP4jvU07o8BqGVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kVmBP/U9zTjk7ZGAWwchly/CbJLojEbhBmLwnVS5su6PkDG7P3c8fgPg6x/GV7wve
	 U1+ezjbNthqGm1NRtnXKcZ5V3Xpz1HYmF9lSqa1a201TI2HD3WUaKy4hE0bL6vB7lD
	 1lJsYgyrlzV0Cq3g0USYrFpEa2aHdnIGroZ9t+MGok2Xf0P9J1O1wYONnsCT7NVY53
	 SBHb6zsc2WgojN+6OCDrbjPJsS4EvWEDUJ4eODu/doitvnUW822tpaQxAf8wRx8Uec
	 UhfqZkzggFwAZhFOI7laTnu3FjK5JlUmIPfIRZfE2A8NC9BuVNUfyozqoi8MMNL/nb
	 SRfhYTrb1q33w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5171a529224so2774958e87.0;
        Fri, 26 Apr 2024 08:05:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpe4YsK5hOzpF6AU1Pu2PGkSjHwtUzXVBPlopDsxOPrzCZHi8Bt5sOhf1K2lgPaX5RJKM7ulppWzrVXvt+gnHUUxvskzWy0jRfDwH7fibr3gNR3UIP9fNvdURMvhrnKEROEeJ39pgesZGHPIeW6QyRkDZK7dnW1FTFbyqNmWwfBRE=
X-Gm-Message-State: AOJu0Ywi/Xs+A2xnRDdpOISY7RQAW/O4SjK3G+v/HaVpDAm5TVBPumBt
	jVIh62IoGaWvwdT26b/tfPh38OPj+zPUHGnPg/brGXIpTZ0bgCcBkvHpt/BGVoLNWIPYlj0CPEY
	6LSYvrT9zasNEEvAed/A3H2qtg8c=
X-Google-Smtp-Source: AGHT+IFT2RH/u9ez1/6bCXS94e7Xb58D933UfyUU+LEAgMi5lH3GmSTetYaWtcovYQ/W/SS8GABunIDa0MW05zxFrus=
X-Received: by 2002:ac2:5f07:0:b0:51a:9f4b:1fd7 with SMTP id
 7-20020ac25f07000000b0051a9f4b1fd7mr1746848lfq.58.1714143921496; Fri, 26 Apr
 2024 08:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164104.2869507-1-masahiroy@kernel.org>
 <20240422164104.2869507-3-masahiroy@kernel.org> <Zij545f6JVmmbcoj@buildd.core.avm.de>
In-Reply-To: <Zij545f6JVmmbcoj@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Apr 2024 00:04:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJi8UsWfURN0=T2-Uj8kha+-SQWiWBZRhB23dr9havSg@mail.gmail.com>
Message-ID: <CAK7LNAQJi8UsWfURN0=T2-Uj8kha+-SQWiWBZRhB23dr9havSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kconfig: remove 'optional' property support
To: Nicolas Schier <n.schier@avm.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:24=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Tue, Apr 23, 2024 at 01:41:04AM +0900, Masahiro Yamada wrote:
> > The 'choice' statement is primarily used to exclusively select one
> > option, but the 'optional' property allows all entries to be disabled.
> >
> > In the following example, both A and B can be disabled simultaneously:
> >
> >     choice
> >             prompt "choose A, B, or nothing"
> >             optional
> >
> >     config A
> >             bool "A"
> >
> >     config B
> >             bool "B"
> >
> >     endchoice
> >
> > You can achieve the equivalent outcome by other means.
> >
> > A common solution is to add another option to guard the choice block.
> > In the following example, you can set ENABLE_A_B_CHOICE=3Dn to disable
> > the entire choice block:
> >
> >     choice
> >             prompt "choose A or B"
> >             depends on ENABLE_A_B_CHOICE
> >
> >     config A
> >             bool "A"
> >
> >     config B
> >             bool "B"
> >
> >     endchoice
> >
> > Another approach is to insert one more entry as a place-holder:
> >
> >     choice
> >             prompt "choose A, B, or disable both"
> >
> >     config A
> >             bool "A"
> >
> >     config B
> >             bool "B"
> >
> >     config DISABLE_A_AND_B
> >             bool "choose this to disable both A and B"
> >
> >     endchoice
> >
> > Some real examples are DEBUG_INFO_NONE, INITRAMFS_COMPRESSION_NONE,
> > LTO_NONE, etc.
> >
> > The 'optional' property is even more unnecessary for a tristate choice.
> >
> > Without the 'optional' property, you can disable A and B; you can set
> > 'm' in the choice prompt, and disable A and B individually:
> >
> >     choice
> >             prompt "choose one built-in or make them modular"
> >
> >     config A
> >             tristate "A"
> >
> >     config B
> >             tristate "B"
> >
> >     endchoice
> >
> > In conclusion, the 'optional' property was unneeded.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > (no changes since v1)
>
> thanks for the patch!
>
> I found just one small remnant that probably should be removed as well:
>
> diff --git a/scripts/kconfig/tests/choice/__init__.py b/scripts/kconfig/t=
ests/choice/__init__.py
> index 4318fce05912f..05e162220085c 100644
> --- a/scripts/kconfig/tests/choice/__init__.py
> +++ b/scripts/kconfig/tests/choice/__init__.py
> @@ -8,4 +8,2 @@ The behavior of 'y' choice is intuitive.  If choice value=
s are tristate,
>  the choice can be 'm' where each value can be enabled independently.
> -Also, if a choice is marked as 'optional', the whole choice can be
> -invisible.
>  """


Thanks. I will fold this.




>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
> Kind regards,
> Nicolas
>
>
> PS: For other reviewers, this patch (set) depends on
> https://lore.kernel.org/linux-kbuild/20240422161054.2867285-1-masahiroy@k=
ernel.org/



--=20
Best Regards
Masahiro Yamada

