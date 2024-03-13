Return-Path: <linux-kernel+bounces-101081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10D87A1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C270FB22076
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB110958;
	Wed, 13 Mar 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5mh72Az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3D6FA7;
	Wed, 13 Mar 2024 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710301718; cv=none; b=IcP52Fli6Nn22UnrqxKSQiNvlEKJeRIAkdHN51HBN37IsZG/3RjVuWr2xwvmHmJU1tCnwcYoBheXQjZ8tnF5Gm/BjMDsZxfDfE3XuhSS/JlnIKFcClP9422a7woxPXZPrInuope0bNByuTRRZN+a8TLKI3no9gBM8snllPqtNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710301718; c=relaxed/simple;
	bh=CeQaXs0K7RFXkVnM9dXH+pmKXGUSDN4g5SZ9YhtnJgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLPGVCRNaBcvbVsIVWq51I3HQKOV5MQuE/a7XGQJNV0joLJ5u7OxKbHimMIPnWm7m4BeQAXqY9tLKXd018YkkJqMgngnACAj8wmsNKFNtFYAGs0/1r0mPJrYnqqn6m59o22UwmWC62tzs7UZHHuIYIp1dSQC7qSZ4tJYKoYAqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5mh72Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF02C433F1;
	Wed, 13 Mar 2024 03:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710301717;
	bh=CeQaXs0K7RFXkVnM9dXH+pmKXGUSDN4g5SZ9YhtnJgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S5mh72AzKBXjn8wZtPDQf18y2EAI1jof5ujqfDI8hgQNuNBvPENMdvylHy8fvQ4q0
	 RQPnrtZNJncJpGGy5sh7Aop6CALgzpDAF+12Y3kcZcsMJ4wQfH9NPqt910X7g22peI
	 K/uQkGt9hnigpO7HHsjAhAhODI0FxWRvp7xHLkLYwvN8BHcgUOIrH/ugbaGkfSxd51
	 IoAKRv2j/UBQFCnrTlrNj3dofIgRscqC/gh5/tBu/XKZm8jdfyonMOWddfpK0OAaIb
	 D0J7i6TFHSK0Qbc5ap7jRDEeSmiXP/jPrxtRn+tMRc14vSqIMu/3UfMlLdM9z7/dr/
	 ahma+L0rilO+A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5135e8262e4so6656025e87.0;
        Tue, 12 Mar 2024 20:48:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM7L8zP1HzLZZ9cl5vJDMF3S/Ic0VXUiJamNnRjZm4gOcRXObX9ml0O4gdcA0KJMJ/6NiMzrFRzJzuUgONCUjptJv2Y+fkaKhafP+9A4zJd0JMR6tmlbhMjHmhhJrWCEEm927B5ak9eRo3a3f9/VGep/N0qVP+F+hOCGTUovTcNKrDBVdeN4hY13RM
X-Gm-Message-State: AOJu0Yye4L0QZ2pmQIVbYBmKBGPRYCMNNehLSZ+tD5kPXcxF7lKLdj7K
	DQu4534Y//aFKGxwkKFag4Vr9zz9qjhNf9rNr7mE9wGPjL/tKctz+spx74FKCdLaCYa4IAhRz1S
	Rt3WH5GhbN4rJ10aBiNH7J5Ofi/U=
X-Google-Smtp-Source: AGHT+IFQGGOXeJS2cP1mqVkQyb8U93YoQbMAGZimnQg5z8RPYJ5VLLQxpIGKpD5eblVrbx+KvNJWQ8s4AgU4cOgUDlI=
X-Received: by 2002:a05:6512:1149:b0:512:ac3a:7f27 with SMTP id
 m9-20020a056512114900b00512ac3a7f27mr8291674lfg.66.1710301716348; Tue, 12 Mar
 2024 20:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
 <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de> <202403121452.701C91AF6E@keescook>
In-Reply-To: <202403121452.701C91AF6E@keescook>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 13 Mar 2024 12:47:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=aSqUUStN_M8QVqeS9R1QVM5CPq7=kzpY0z060XJFDA@mail.gmail.com>
Message-ID: <CAK7LNAQ=aSqUUStN_M8QVqeS9R1QVM5CPq7=kzpY0z060XJFDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gcc-plugins: disable plugins when gmp.h is unavailable
To: Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:53=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Mar 12, 2024 at 04:03:30PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > The header gmp.h is meant to be picked up from the host system.
> >
> > When it is unavailable the plugin build fails:
> >
> > In file included from ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/..=
/lib/gcc/i386-linux/13.2.0/plugin/include/gcc-plugin.h:28,
> >                  from ../scripts/gcc-plugins/gcc-common.h:7,
> >                  from ../scripts/gcc-plugins/stackleak_plugin.c:30:
> > ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13=
2.0/plugin/include/system.h:703:10: fatal error: gmp.h: No such file or di=
rectory
> >   703 | #include <gmp.h>
> >       |          ^~~~~~~
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  scripts/gcc-plugins/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > index e383cda05367..a664fb5cdde5 100644
> > --- a/scripts/gcc-plugins/Kconfig
> > +++ b/scripts/gcc-plugins/Kconfig
> > @@ -10,6 +10,7 @@ menuconfig GCC_PLUGINS
> >       depends on HAVE_GCC_PLUGINS
> >       depends on CC_IS_GCC
> >       depends on $(success,test -e $(shell,$(CC) -print-file-name=3Dplu=
gin)/include/plugin-version.h)
> > +     depends on $(host-cc-option,-include gmp.h)
>
> Why does the prior depends not fail? That's where plugin detection is
> happening.
>
> --
> Kees Cook
>



This patch set should be rejected.


It was already discussed in the past.
Just install a proper package, then gcc-plugin will work.

https://lore.kernel.org/all/CAHk-=3DwjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV=
4K6WYg@mail.gmail.com/






--=20
Best Regards
Masahiro Yamada

