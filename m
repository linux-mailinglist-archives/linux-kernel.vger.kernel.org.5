Return-Path: <linux-kernel+bounces-19394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B653826C50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC64B21AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E114266;
	Mon,  8 Jan 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Oeb0M4LI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77921426E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4678c4e51a5so340796137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704712438; x=1705317238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMmNHA5ZM5uagnRv+Z2EBfHRX06UJnwNICsOfprVTxU=;
        b=Oeb0M4LIgaUfMrkV4Z7TvDOMxhdzBRIEM7UUakXwVi3HEOHfNgNFDA4ey67VG9+xaK
         IadFcarAyiroLG7YOMXfp+JkLXWk1ypBa9O62fNwSJBV/2VdFv1EnkSZOainYwNMfKKO
         KzNw12FE9k+7xCZcY2mxtX68DcXoufooAdbtkRuGWiPZq3lY9H/5iMroxeHbLlp/2pG2
         G4cNwutLvrXuFzeA3aXLaeSL34uUeC4GYFrZF3I01R81MaOjIUzEr5Z+CWV81bxBdwZ6
         NVZCcO49JLIUIX6ov8a3u9h1b35R1+xjIT8oRCReBr0hPVSQMClKgdRTo4qbYy20Ivyx
         apUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712438; x=1705317238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMmNHA5ZM5uagnRv+Z2EBfHRX06UJnwNICsOfprVTxU=;
        b=Bw/4DH1R9kElEV4Pdx5JGSHnE8pDKiiysV+b0xkgVNUmhKXMle38CRsFVys1hZHzFh
         dSY5EMuTC/EjCenhqdtFc2tHw60bVw9+p2yx4oLu2CiNurcKxYlbCfnhQFxtlU7ZnvPW
         nrXEi94J8WKX2B+OpAIoGDMFeBlg8yTRP6tLxTMgDughGRKh17sgvLMX7B0cegciNxuk
         ZRE7B67JR8VA/BRHw8ZOpkriCfgbKPZ2lxm2k1/xfXgud7bvshx0Ue62WbMTEHuYwDiZ
         YrrFSWZJqmRyZ2dAvm/aKc8Q1yxrm10hocOnPMHkyaycetx7GRncUgTbnHiHpmTk3ZVM
         byCA==
X-Gm-Message-State: AOJu0YwqP6ajzQ2qHmwWtfISecZiTukzy6PovN0zKeGoQm+Cj/ppN9Rb
	vZMtw5v6y8+ii6gc/6E5nOADt2riZRheSMduSvKTAKtExnkWew==
X-Google-Smtp-Source: AGHT+IFUCaD2C2j/tqCkMONWfs1OnD+E7URpzHw4UpbkW5y8hSqJvmsQCrqyEoFMZlctyYNJ2KWUjnAks/4t+55vjJA=
X-Received: by 2002:a05:6102:3d84:b0:467:c94e:3790 with SMTP id
 h4-20020a0561023d8400b00467c94e3790mr1154552vsv.20.1704712438691; Mon, 08 Jan
 2024 03:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108110055.1531153-1-arnd@kernel.org>
In-Reply-To: <20240108110055.1531153-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jan 2024 12:13:47 +0100
Message-ID: <CAMRc=McFNz5fJqScS_q1JzX-U=VC+FXQ1p6=j7ANHxL0RV88dQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: always select CONFIG_CPU_ARM926T
To: Arnd Bergmann <arnd@kernel.org>
Cc: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The select was lost by accident during the multiplatform conversion.
> Any davinci-only
>
> arm-linux-gnueabi-ld: arch/arm/mach-davinci/sleep.o: in function `CACHE_F=
LUSH':
> (.text+0x168): undefined reference to `arm926_flush_kern_cache_all'
>
> Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v=
5")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I ran into this today for the first time after five years of randconfig t=
esting
> with the bug in place, so it is clearly very hard to hit.
>
> It's an obvious fix, so I'm applying it to the soc/arm branch directly
> for this week's pull requests.
>
>
>  arch/arm/mach-davinci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfi=
g
> index 1c8bf56982e5..2a8a9fe46586 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -4,6 +4,7 @@ menuconfig ARCH_DAVINCI
>         bool "TI DaVinci"
>         depends on ARCH_MULTI_V5
>         depends on CPU_LITTLE_ENDIAN
> +       select CPU_ARM926T
>         select DAVINCI_TIMER
>         select ZONE_DMA
>         select PM_GENERIC_DOMAINS if PM
> --
> 2.39.2
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

