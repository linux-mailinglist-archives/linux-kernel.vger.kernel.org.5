Return-Path: <linux-kernel+bounces-112418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A93887993
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F353E1F21A09
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD34DA0F;
	Sat, 23 Mar 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErsSGhxq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5C523C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213213; cv=none; b=IKsYGEKGhhJHOFuOUAIsxaAxr0xiDCdaCVi09AQVwo/Efe1I0ygOFjm3oXQxQCHeAy8Y1xGHN0mOJLS8zIQUIVUPsKi8u8pMMBsML7/ZBN81UAIFFTsjdyeCYbxIEnF4DqNnNKvu3zIeAtZkE0tMEkf8g+tw9FIlNQwTlkfOcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213213; c=relaxed/simple;
	bh=VeZGijel/i5XjHD44i5MMeYYCEEtBV+CqcV//izQ3Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blxtjw9GJSZ+jEy8BbRRZ3P0cDMQONboMNbWbXVhdH9rfGh2Z9CBbNm+TXbEylWASWfbTvfpAVUjG4gxW1YThGkJNLpN5Xu4YViLRntAjRY72yPfu27rC9Ig0XK42aEfVA0jKy233Ut5FiwTORpDNb8B9VJrgZwEW1cECAkrm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErsSGhxq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso37420201fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711213210; x=1711818010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bju7c6ncuMNwvdJd5aOCyXtzQBxyZwBfOJ5baDOBVOo=;
        b=ErsSGhxqubyEHepJ4tz4sHBWKxHUdzWNOQI0kV2hBIiMjs+cnhb3cIH/EyVcOIcnLb
         QlsiA86XGxQQL5H+CxtxSsAtpZHv0j9vLazp95lUkLriq4PW31hpE9QIzjGN7BX7EDM2
         qThzAM5GOfnd0SxVTNYNPlPdYsTseS6/3Djx12YzBAGgN44gbbmWCDpx4QSCHJlcf01u
         BWoeki+gfnZV7vQjWBe7EbxUuGN4VsDVSkOjhErIhKbuLB4oCNyAyiBwIuNNFQdzQekx
         89J+5rzIM8+GkWO0Bd1s0lTQ4C9sC6zm60TzcauyYkOia3Kuvlvj1mlqSuhh4wx0gvXs
         pFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711213210; x=1711818010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bju7c6ncuMNwvdJd5aOCyXtzQBxyZwBfOJ5baDOBVOo=;
        b=RaKVHBJ5xeEMgDDVpgBBE63se22DArG6vebX9W8eYESQHV6/V/5SXf40v5GS3Nk/1k
         QXau5q231O4lI1monE93m9rCB6AkAJZxzpcQoY6hPLG4Q0LUFnKvxPW7Od9A7Kbgs1Fi
         qIwGoVImRDfKGQheEbnupA1q6fQv/dfEcOIvWeyTNpwoRcK/1r4gurcjbwqoc5aWt11O
         PdAlECYw4ItLHyKsOvXCZyteZfS5mdTxFT7i8Y3D2AQCRLdiNwd8PEGahCQcNoo2/EsH
         vNbqoMHBTFRISiyYXAAxGqXBD4sTJh5DxFwtVAk+U7pFvXCT+3eFYJX40QQFf3Jzd1CO
         0/Mw==
X-Gm-Message-State: AOJu0YwMs4eEoFoE3vD0FbZ0B212TyTFAlT/pEX6tVgf3UBdVmC5ZFtB
	RZ6sZGfRX4C+b4n/WH5XY2Q/4cHsvKgR+KS4/T+39Xjp9wlbgMJndw7C3KlJFUQkaFX+sObU84f
	g9/tfkGeBv0ZuyPNBS+ImZPaTTetAA8CPkcnVwg==
X-Google-Smtp-Source: AGHT+IEcLkvzpj1+kmgFBeCihORbdkxSGhU0RoG9GcfYHY0saXZDqR58RyWHS2JLUDTp+Bx4CJ8y3rIg2vLVUVE71kY=
X-Received: by 2002:a2e:7305:0:b0:2d4:8d75:7a69 with SMTP id
 o5-20020a2e7305000000b002d48d757a69mr1506892ljc.45.1711213209513; Sat, 23 Mar
 2024 10:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-2-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-2-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:00:07 +0100
Message-ID: <CAFULd4b+Tsvd7+VuykyoeokZ6k=bnnKX7UHGjp=zgcE5Wmn96Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] x86/stackprotector/32: Remove stack protector
 test script
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Test for compiler support directly in Kconfig.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                          | 2 +-
>  scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 03483b23a009..f326903cbe67 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -412,7 +412,7 @@ config PGTABLE_LEVELS
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
>         default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
> -       default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS))
> +       default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
>         help
>           We have to make sure stack protector is unconditionally disable=
d if
>           the compiler produces broken code or if it does not let us cont=
rol
> diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_=
32-has-stack-protector.sh
> deleted file mode 100755
> index 825c75c5b715..000000000000
> --- a/scripts/gcc-x86_32-has-stack-protector.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# This requires GCC 8.1 or better.  Specifically, we require
> -# -mstack-protector-guard-reg, added by
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0=
 -fstack-protector -mstack-protector-guard-reg=3Dfs -mstack-protector-guard=
-symbol=3D__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
> --
> 2.44.0
>

