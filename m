Return-Path: <linux-kernel+bounces-66008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845985552D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168671F28597
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEF13F016;
	Wed, 14 Feb 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdemAk1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87B13B7BB;
	Wed, 14 Feb 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947525; cv=none; b=Gimzn/0TFgCgH4tdVWHRs6K3dCELxkEqVVFViht7/jWLmLc237NlRm6Etn03c3k5C1pQd+JjEH0PZyRFKWyTnEIvxBOrZ21vmy95OiRy6yrSw3yQE+cfk52YL2q/sLM+qafAvzO14OxSGxuT3qZU513GFVUJM7/V/TUEMewdWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947525; c=relaxed/simple;
	bh=3fcyP26P9Q4MkihquxI1ETrfwR4hb3GP58XHH3gA2UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUnYrmaKYchhn25PC48Ptpiwd1UuQcbrOgQINXWFLdJ8kMtMYRNhXJ7zPyFOVyR5oLAIfNRJC4ymKEBVsMsqTfwjbMOiwwRYP20xt7lJ4sjp8F+vbZq6ZIgl9Xd+lb6hSSUqIwrraJUiV+lHZUWY6clQKs0PdfPnhl8/rJ1bphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdemAk1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB71FC433F1;
	Wed, 14 Feb 2024 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707947524;
	bh=3fcyP26P9Q4MkihquxI1ETrfwR4hb3GP58XHH3gA2UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OdemAk1bBTu+tjHJi+vEfI6H0sX5B5HwELrUdqXHQ6p6IgJuI1WD+FfB7wE4mETsY
	 TsdbXF6nedGHF4ZVLRCLsSbILLAEdciuc9h53u1QRz8ijLOWB9q21HHr9gPWbmvI2O
	 szlpojOyytTNV82WvqSaDuUL9UIFSdiVy2YWaSyZ8RtQjFv2P7reVSxsT4auQqxkIu
	 IohRpH4A0/06wWgiNSolgodwTgwd1ABuDF1UHGPACKHYPD5xj9I08lnyQLVA0bRW/2
	 XYcSDW6xBIYyRMui2zu5rcSKcLIHpJGHVYF+XpqasJrKSteVErcie8pNdl1cE3AQmX
	 cZgatqe0qKSDg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5119cfaeb9bso213305e87.1;
        Wed, 14 Feb 2024 13:52:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhWH/+5tX6GJAMxP+4wUqy8a/R3QC8lxyho7vZoKPbNXpxgBzLe+9auQFRvY73TGIhxfK5UFNOgae2c5CANqbdIeWlx+NQf9NEtyZFMzrWNEZNBJENrT48Dy5jKYIHWZJWcqY/scvR0OtFYWYk5425tti4qIeqWykXzsAMFCy5BY/dtgG0
X-Gm-Message-State: AOJu0Yw8dIQuhvdFB/fuhtlhkj15fI+xOY+LAoK9UBX+kP08tQkvVOVY
	JP2h92hlXUT9H07LRDkhEvQ6VX11k3Y/5zODaLpXFs2ATMMLP7oAyeypOcric7Bpps+dXpNt2Z4
	T1ynO/QVeOy9P9b2JlMibOh7RYZU=
X-Google-Smtp-Source: AGHT+IEMCscpfwJ8E8LsKpSQpJJldUAZo5XBmyHVQfEiYM05zVLpMZaD80Rd88Gv8JN4bfudWo9P9dqPWBB7C0aV9LU=
X-Received: by 2002:a05:6512:6d4:b0:511:8c6c:631b with SMTP id
 u20-20020a05651206d400b005118c6c631bmr35219lff.50.1707947523410; Wed, 14 Feb
 2024 13:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210152003.861-1-thorsten.blum@toblux.com>
In-Reply-To: <20240210152003.861-1-thorsten.blum@toblux.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 06:51:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-3MKPAdBk4L4TboLkktNo486YDiV898VQcUEhPdZ95A@mail.gmail.com>
Message-ID: <CAK7LNAR-3MKPAdBk4L4TboLkktNo486YDiV898VQcUEhPdZ95A@mail.gmail.com>
Subject: Re: [PATCH] docs: kbuild: Kconfig: Fix grammar and formatting
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 12:26=E2=80=AFAM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> - Remove unnecessary spaces
> - Fix grammar s/to solution/solution/
> - Remove newline to be consistent with other headings
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/kbuild/Kconfig.recursion-issue-01 | 6 +++---
>  Documentation/kbuild/kconfig.rst                | 1 -



I dropped the change for Documentation/kbuild/kconfig.rst
because it was already reformatted by a previous patch.

https://lore.kernel.org/linux-kbuild/20240112125830.3753464-1-vegard.nossum=
@oracle.com/


Applied.
Thanks.








>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/kbuild/Kconfig.recursion-issue-01 b/Documentat=
ion/kbuild/Kconfig.recursion-issue-01
> index e8877db0461f..ac49836d8ecf 100644
> --- a/Documentation/kbuild/Kconfig.recursion-issue-01
> +++ b/Documentation/kbuild/Kconfig.recursion-issue-01
> @@ -16,13 +16,13 @@
>  # that are possible for CORE. So for example if CORE_BELL_A_ADVANCED is =
'y',
>  # CORE must be 'y' too.
>  #
> -#  * What influences CORE_BELL_A_ADVANCED ?
> +#  * What influences CORE_BELL_A_ADVANCED?
>  #
>  # As the name implies CORE_BELL_A_ADVANCED is an advanced feature of
>  # CORE_BELL_A so naturally it depends on CORE_BELL_A. So if CORE_BELL_A =
is 'y'
>  # we know CORE_BELL_A_ADVANCED can be 'y' too.
>  #
> -#   * What influences CORE_BELL_A ?
> +#   * What influences CORE_BELL_A?
>  #
>  # CORE_BELL_A depends on CORE, so CORE influences CORE_BELL_A.
>  #
> @@ -34,7 +34,7 @@
>  # the "recursive dependency detected" error.
>  #
>  # Reading the Documentation/kbuild/Kconfig.recursion-issue-01 file it ma=
y be
> -# obvious that an easy to solution to this problem should just be the re=
moval
> +# obvious that an easy solution to this problem should just be the remov=
al
>  # of the "select CORE" from CORE_BELL_A_ADVANCED as that is implicit alr=
eady
>  # since CORE_BELL_A depends on CORE. Recursive dependency issues are not=
 always
>  # so trivial to resolve, we provide another example below of practical
> diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kcon=
fig.rst
> index c946eb44bd13..766f9cb518df 100644
> --- a/Documentation/kbuild/kconfig.rst
> +++ b/Documentation/kbuild/kconfig.rst
> @@ -45,7 +45,6 @@ file name to override the default name of ".config".
>
>  KCONFIG_DEFCONFIG_LIST
>  ----------------------
> -
>  This environment variable specifies a list of config files which can be =
used
>  as a base configuration in case the .config does not exist yet. Entries =
in
>  the list are separated with whitespaces to each other, and the first one
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

