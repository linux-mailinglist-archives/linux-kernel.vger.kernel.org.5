Return-Path: <linux-kernel+bounces-161820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAA8B51A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E744E1C211D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C05111BB;
	Mon, 29 Apr 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY/lFN/s"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81733F6;
	Mon, 29 Apr 2024 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372947; cv=none; b=KW4n8Xbwmkm+xA+3/pmbDV09GSGloJ4H24uV9AEfyjXEPg2lXxiAyD7OacCYmtwBr4vTQvYhFUwYX1wfRuIFUYymmObdRoCNR3C8M/GbLuSyM+E1snqMs5hyBv5jOkh5b0dxqEyUXULsDCdNhAoAIhY8TGnnWap20S6lJimmgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372947; c=relaxed/simple;
	bh=dICQK8Q0jcjj9CaE3KImceaas7jxXUuWuZ1OLxRCE3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S39nDF6OAB7IKNNDiolGCZxR5rBYqPa43BCWbXd/VLLNXJuPDgqCni4B7ideE9Y6akHATP8OyWB8F5fZvdu5W/bIT13yR/mTpNRuPvZ/a+6PL9Cba1ThelaQulaNGv9gECtO+kktBV+7hi9c8BucyWshMy1s6Qw+6+DHR9VKvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY/lFN/s; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db13ca0363so63735251fa.3;
        Sun, 28 Apr 2024 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714372943; x=1714977743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DT5qYazuL+T47UuZ+tljcjT1BWfh1A8GOLwOSbtPJ4=;
        b=QY/lFN/sOwlqMhYEz0jPt/j2pPItlzBVHUv5mYhHyXU4A0wNtCWd9HQEhSNRvJazC8
         f3iPGZoge7/OY+mdtklprEMbunJgn2UsgKOjd5kuN3bqOllm6LGP0HxSSorLdBJSjvQW
         Mb0LH5G+sbw/s06BppUYqDQ1avRYfYzgYN6W9oWgwU4uuECl/bWhVmukQOEJXmP8a+5N
         u2djAqhg4WAYi43W1BvD+0UgY+dE372LEERo8jRMBt2jgJqVaZIOx2h8vo5tSqKQrO3p
         EQtRoBlDp28WLZjczaiAYbl23Oj7ofte/H9mEGevgVHo7KSpGMs5T5iS4D+Q4pCg2qpZ
         q+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372943; x=1714977743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DT5qYazuL+T47UuZ+tljcjT1BWfh1A8GOLwOSbtPJ4=;
        b=w/i0M28uF9Rogco25I4u1cdUi/M0WDHPr3v11gD5s+uI8bh02SS6y6IZujRJrRtWfH
         QKICo04ERNMsI8/rnTfhiWKiet+BJvHvzAHMXMGLpFvayKXInDpNju9QzKLgw//NlGlA
         /mLJQdeScdTtIGrR2wc+Zum6UZM/6sg2rRc6Pa2cEO23Clm7SgzEJahb94mV5lXQKnm7
         yyXrY5ROkR9bhio6Pw/07WSVlQwEDdgNIqKnW8z60dBizTCUXiNABcLEO1F7UhKRKVMJ
         mctRpVsGm+kJ5Y3dhTMFMsME42ut+NE0arLra9kfgpyF/u1fo9bHbS2DtZzCgu6s3K/L
         uxSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgQd5r9mV0P/FN9cpHuU9OAr/doISkwq+krkDgjcJgF5PSRwcuyIwblG0y0Kp5Y6c+JS8220wwUCHu1vh+48Tufo765xlk0kHzQY4GOJEejfQmH/NQXx/x8KGYvkQy5wZXu5kAboV8iQ==
X-Gm-Message-State: AOJu0Yzdx+fDI/+2wgik7i8WlHFjbwT8SGgVWUnJaTNuBPdHp7fiUXTF
	foQdoo52GRg63AFQ4LibKirpXzuSQXRrTsie/giVzwIlZ91lJ6C+4Q2krRnbQqXCyKclImCDer3
	vroF4VChc0GRSHHoOA5rN3Fdt0F0=
X-Google-Smtp-Source: AGHT+IH1Pfr+aNgvZLCVhYng7zWAyDawysKCunJWkhd+9smZhKb0CuaXYcaqxyOL6cmd4ZZmdyRctfEwlm81DiyZhrE=
X-Received: by 2002:a2e:9c98:0:b0:2e0:6313:fe3a with SMTP id
 x24-20020a2e9c98000000b002e06313fe3amr1444734lji.35.1714372942318; Sun, 28
 Apr 2024 23:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012162027.3411684-1-lis8215@gmail.com>
In-Reply-To: <20231012162027.3411684-1-lis8215@gmail.com>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Mon, 29 Apr 2024 09:42:11 +0300
Message-ID: <CAKNVLfZnD+Yh5_dNUwUooCi72dxX7XO1den1oZf_rwtzk2Kckw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Take in account load hazards for HI/LO restoring
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Siarhei Volkau <lis8215@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping. The patch looks abandoned.

Paul, could you recommend right persons / lists for that ?

=D1=87=D1=82, 12 =D0=BE=D0=BA=D1=82. 2023=E2=80=AF=D0=B3. =D0=B2 19:21, Sia=
rhei Volkau <lis8215@gmail.com>:
>
> MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
> and right after move to HI/LO will usually stall the pipeline for
> significant amount of time. Let's take it into account and separate
> loads and mthi/lo in instruction sequence.
>
> The patch uses t6 and t7 registers as temporaries in addition to t8.
>
> The patch tries to deal with SmartMIPS, but I know little about and
> haven't tested it.
>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  arch/mips/include/asm/stackframe.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/s=
tackframe.h
> index a8705aef47e1..3821d91b00fd 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -308,17 +308,11 @@
>                 jal     octeon_mult_restore
>  #endif
>  #ifdef CONFIG_CPU_HAS_SMARTMIPS
> -               LONG_L  $24, PT_ACX(sp)
> -               mtlhx   $24
> -               LONG_L  $24, PT_HI(sp)
> -               mtlhx   $24
> -               LONG_L  $24, PT_LO(sp)
> -               mtlhx   $24
> -#elif !defined(CONFIG_CPU_MIPSR6)
> +               LONG_L  $14, PT_ACX(sp)
> +#endif
> +#if defined(CONFIG_CPU_HAS_SMARTMIPS) || !defined(CONFIG_CPU_MIPSR6)
>                 LONG_L  $24, PT_LO(sp)
> -               mtlo    $24
> -               LONG_L  $24, PT_HI(sp)
> -               mthi    $24
> +               LONG_L  $15, PT_HI(sp)
>  #endif
>  #ifdef CONFIG_32BIT
>                 cfi_ld  $8, PT_R8, \docfi
> @@ -327,6 +321,14 @@
>                 cfi_ld  $10, PT_R10, \docfi
>                 cfi_ld  $11, PT_R11, \docfi
>                 cfi_ld  $12, PT_R12, \docfi
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               mtlhx   $14
> +               mtlhx   $15
> +               mtlhx   $24
> +#elif !defined(CONFIG_CPU_MIPSR6)
> +               mtlo    $24
> +               mthi    $15
> +#endif
>                 cfi_ld  $13, PT_R13, \docfi
>                 cfi_ld  $14, PT_R14, \docfi
>                 cfi_ld  $15, PT_R15, \docfi
> --
> 2.41.0
>

