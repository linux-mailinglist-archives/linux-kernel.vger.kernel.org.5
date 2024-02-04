Return-Path: <linux-kernel+bounces-51543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25997848C5A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91F12818C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B014A8F;
	Sun,  4 Feb 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1PgbuxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D16419;
	Sun,  4 Feb 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037511; cv=none; b=enC9IrA6GdT3NvQKhE4eLY1pcnB4VqiyQoeND/vedyiogTfx0M2FL4dk3x9QxHdaq0cfD01wZPTWHHCKQhNB599CQF5XPXObrAqWULV4IEyoR21oiwWUM7PwqyNEWJRU5rGuO8Y694HKnf5blf//CrgzToX6wBa9nulDhxkE/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037511; c=relaxed/simple;
	bh=PpMQUkIvbUJJcD9sjioO5DzOWwA59EhQZWArD7QiRFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgLuhzc0rPKJHHCAF1HTRh7cY70UrYCgX+KDJT9nQFrYCgw5LPeXrY7700yvnRU+2QAzoW3ePChA75tYVaKdS7yWCs7A3vn8jN7RD2ivx16hJi6MVitVKGDInZuEIJeDb+8rK4ChnZTUMdHbzNLVBaVrv8/2V/22HNzU/zFmpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1PgbuxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14EC43394;
	Sun,  4 Feb 2024 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707037510;
	bh=PpMQUkIvbUJJcD9sjioO5DzOWwA59EhQZWArD7QiRFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e1PgbuxERyiKjDKbKAAYo13KkOdHnlPRROPXQbgTP/wS/f6quvdJvwyBZ2ievdBJR
	 ppw5HPP3CozHpWNN7U3nOI6x58XcUg9LNm2Qzem2aASPMnF22SnW+zcimytYz3TQj/
	 0UdXPd3Z6B3G0kADMe96eA48w1k+UNNZUHPUdUmQ+43ZDFL/Mej+GIr+u/vAO/QDeg
	 GrblHiv86bYTvKB8vrgAFJ5h6DLf2P4vICsEqq5JEkByTpoCIwCVJqsIXvRUecrRiK
	 GHzWwXfDxHbzFThMffaCyMGuA7Oyg3XE0XNsIyZgmrjHN+mr9MzosXPPW9WNenxc4S
	 gTL7T5mjVt6PA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5114cd44fdbso337658e87.2;
        Sun, 04 Feb 2024 01:05:10 -0800 (PST)
X-Gm-Message-State: AOJu0YwVgvqP7KMaRX98GlOGklIrNGKIBwpOZPCPouebyQQN+4CUn4YG
	Y7F93tY+IzHvLCojuaXA9u1eOwIRzCgMD9jPqu9bHEcMGCpC/6ih0UUn/8RhkL567fO09ViVU/6
	ASqtWIFRG8gOyJ3H7P1r8WWTxfWg=
X-Google-Smtp-Source: AGHT+IFUbcG1fcbBl/y42lfmxlF6FQBVFmx5ngxsoX0yGzVUghsuPZs0hTJQOr93QQPT8lKlhygq79ZOF5Ptk6CIySs=
X-Received: by 2002:a05:6512:522:b0:50e:76cd:f3f with SMTP id
 o2-20020a056512052200b0050e76cd0f3fmr6722479lfc.54.1707037509338; Sun, 04 Feb
 2024 01:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204090223.37621-1-masahiroy@kernel.org>
In-Reply-To: <20240204090223.37621-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 4 Feb 2024 18:04:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQExdrSmucgzj8UHcgvXjKjdLqkiww+cuUN6EBzkJAy3w@mail.gmail.com>
Message-ID: <CAK7LNAQExdrSmucgzj8UHcgvXjKjdLqkiww+cuUN6EBzkJAy3w@mail.gmail.com>
Subject: Re: [PATCH] sound: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, 
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe, the patch subject "ASoC: pxa:" might be better than "sound:"
so it matches the change history in this directory.



On Sun, Feb 4, 2024 at 6:02=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> 'config SND_PXA2XX_AC97' is already present in sound/arm/Kconfig with
> a prompt.
>
> Commit 734c2d4bb7cf ("[ALSA] ASoC pxa2xx build support") redundantly
> added the second one to sound/soc/pxa/Kconfig.
>
> Remove it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  sound/soc/pxa/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
> index f03c74809324..e05d6ce4c8fa 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -8,9 +8,6 @@ config SND_PXA2XX_SOC
>           the PXA2xx AC97, I2S or SSP interface. You will also need
>           to select the audio interfaces to support below.
>
> -config SND_PXA2XX_AC97
> -       tristate
> -
>  config SND_PXA2XX_SOC_AC97
>         tristate "SoC AC97 support for PXA2xx"
>         depends on SND_PXA2XX_SOC
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

