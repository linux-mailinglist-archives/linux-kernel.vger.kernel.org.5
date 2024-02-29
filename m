Return-Path: <linux-kernel+bounces-86077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC686BF47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834531F24254
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E736B0E;
	Thu, 29 Feb 2024 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfvWxeR3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA435F18;
	Thu, 29 Feb 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175934; cv=none; b=f6IypB2Pnooia/tmc6sCH7GA+VnCDI8XWZ2lJdhBMkyDpCA1LSzX7zB/tODC2f0sSDji/whuV/xUY0um5sU3Tc11AWBXw1RejDBq5emhfu6aaUyhHiT59Z0ApLGL3M0fgq7RzIhLfg4nYXVFCKCZgYIOSFTBjydRn9gfEyXv53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175934; c=relaxed/simple;
	bh=tQQ7xj//LU316ukpe78B00k15tsraKruobbXoWY9rrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTRDDc3mgO8KumFvJEQsjbZpweWvEFFwc42FhB6euuJMUXxcPoahZSU+r42R+DjPWjTJJHwEQlhjefBZ5Krn6clI9sdSp9rBEvHBYQdK3V/Ycx0yWrwJluDtlbimW/Gq6UYtreZunE0Rp6cdwO61vtMjKX0m5G/U4cNVPSNrJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfvWxeR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118DC433B1;
	Thu, 29 Feb 2024 03:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709175934;
	bh=tQQ7xj//LU316ukpe78B00k15tsraKruobbXoWY9rrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gfvWxeR3pbs8ghgSbBlJCLmuK/7aVZUzt93Irm/LS4k5mTSaydV+NuqvOMspAjW1A
	 4Bbs3e6FUYLqVah3jC9FsdAUDt0FgVOUy7WVuGe+VBQI0kU91/DcH0tKF+nSr3wlJk
	 L+U4Jg4m3yH30n3/8uRSibcfYK9LL+5mGSKFfM16DSSZBQCEy/deWwknSAfIhjbJ7g
	 a2dBVOWgyeVqrsvpeivOsMsGY0L0V1uI8ni8nY4qpTFdJtrV33cQhp8Wasj5wVxmOM
	 jUZynJQXc8USJyRSrus9rpCOE2Lx2VS8GW/bNuIkJHhY1c3dKH+qACvLhDq2UHCzBx
	 KDzHel7v/SZrQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso62737066b.1;
        Wed, 28 Feb 2024 19:05:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXPUCkcNjfDkJvwoG/uJFmH1UA0RQcQQbstxzJllOed7Q7QbcXavP38hFJh31Mo6ZNZEs3dRb6dhe4yUi2hsULAG+1e41ann4/M0wKbBoUfd3w//P5JxZYYI9SrD3OLZRWiEsipGnMbcta
X-Gm-Message-State: AOJu0Yywx1SDd9XisWST2nWhy+XCIb+WOselyuZVc7ZJ1lV/5+t4gn9p
	X6cSrS6plvwvzWjWxvWkd0FCvtEJfaTEL58Omu0O7KHJ19pgm3lhdOYfPnjnWri5XDGhMEYdF8/
	VNm0Pf+ap9yT8DZhWCCrTQuVdW54=
X-Google-Smtp-Source: AGHT+IFVMoyGoA0xQbS/JsIg1Cl7TXgTjZPzrXNORPXtgXO6d+4IGnmLrfhNOxwcomGzNF2eNNE8ozfcarOb4XUphl4=
X-Received: by 2002:a17:906:ca49:b0:a44:1be1:66f0 with SMTP id
 jx9-20020a170906ca4900b00a441be166f0mr447407ejb.57.1709175932312; Wed, 28 Feb
 2024 19:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226080328.334021-1-wangyuli@uniontech.com>
In-Reply-To: <20240226080328.334021-1-wangyuli@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 29 Feb 2024 11:05:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4CXW5Lkn1=hMnMbcY3MO2eoos8bSr3Z5jY_piAbpP+5A@mail.gmail.com>
Message-ID: <CAAhV-H4CXW5Lkn1=hMnMbcY3MO2eoos8bSr3Z5jY_piAbpP+5A@mail.gmail.com>
Subject: Re: [PATCH] loongarch/crypto: Clean up useless assignment operations
To: WangYuli <wangyuli@uniontech.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, kernel@xen0n.name, 
	linux-crypto@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Guan Wentao <guanwentao@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yuli,

The code is fine to me, please change loongarch to LoongArch in the
subject, and update your commit message with Xuerui's review in V2.

Huacai

On Mon, Feb 26, 2024 at 4:04=E2=80=AFPM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> Both crc32 and crc32c hw accelerated funcs will calculate the
> remaining len. Those codes are derived from
> arch/mips/crypto/crc32-mips.c and "len -=3D sizeof(u32)" is not
> necessary for 64-bit CPUs.
>
> Removing it can make context code style more unified and improve
> code readability.
>
> Suggested-by: Guan Wentao <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/loongarch/crypto/crc32-loongarch.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/cry=
pto/crc32-loongarch.c
> index a49e507af38c..3eebea3a7b47 100644
> --- a/arch/loongarch/crypto/crc32-loongarch.c
> +++ b/arch/loongarch/crypto/crc32-loongarch.c
> @@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, un=
signed int len)
>
>                 CRC32(crc, value, w);
>                 p +=3D sizeof(u32);
> -               len -=3D sizeof(u32);
>         }
>
>         if (len & sizeof(u16)) {
> @@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, u=
nsigned int len)
>
>                 CRC32C(crc, value, w);
>                 p +=3D sizeof(u32);
> -               len -=3D sizeof(u32);
>         }
>
>         if (len & sizeof(u16)) {
> --
> 2.33.1
>

