Return-Path: <linux-kernel+bounces-19845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E5827531
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF26B22B51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6946B96;
	Mon,  8 Jan 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWSH4W95"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86420537ED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e461c1f44so12895225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704731520; x=1705336320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlZtp8Mc/IdEItW9zdWJoKOLhQnUFxnWRKbUrflBtl8=;
        b=rWSH4W959MkgSlZChVouh6sM94+uQXRccWerZ2JDB1b3cDkSWYhx0A2Lm0QkW64fYu
         o7z50w1QPb+AyrcqwoIat5VNN6+xRhaokzpezansR6PhhD5tJEzkS2cEUJ9QrWPoE4FH
         EcqdKsP/OJWEwpsk3BgIFf4B/MGh3uC0b3mgf/yUROO4KxmuevHw+lfoozuNM9U8CeBS
         1xqBaxe35sH+Cb4dbwHCi0HlwaW5kK9NJ/UZq3ugsV5B7IaHWj+RRSSIouKGulck0jre
         AGgl3L+LhRRgESfFgvardSBW23WauNOqPzpWuF078l5n6ab6i55G342aXOdkRMYG+gsF
         R9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731520; x=1705336320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlZtp8Mc/IdEItW9zdWJoKOLhQnUFxnWRKbUrflBtl8=;
        b=Uz2aYLXq/iCLVyheWdi1ZZ2qdSzprp7bG1vPY+0ceh1P4xHBXMKK4C10pUY1EMMMFU
         wNpBzEwqkKGmwZPKYsBnDRDgAxgznM6CO96Gj3RKbLmOc6VjWeQiB/lq70J+feM/E0vI
         E+ppOzR4DWOZK/6eHLMVmFnLUW1Wf2fabjMI5sSHDDACGf0f82vQEV6UPy6ZU8UDCtJU
         NQf9xo5zcu9Znru9i5ahTcfAQjteY+VpyiAWREln06RrmxWNujkVlLteKYOHvSMSJX8r
         hmbnIK/3QXBfrJUxwzeTunnKxtyJS70POGz/D02dE5fOeuP8ov7RmL+pze0tY7Cr5dYp
         FKyg==
X-Gm-Message-State: AOJu0YyATCyD7QFfgYJt+QZm9YWlVFWNal3hZe7V+k5kLmVuwAkQD9QP
	IWidw2uzaQ8JubP0igryHf5Rh1KGPH4yAugQq6goKQqnpIYKHmZlwcIjt4vO3b2J
X-Google-Smtp-Source: AGHT+IE+HJ6kcZvKnHQNGaVcsMN6yrWNgiZ5/HRkVlFCiWKs0+nk83b2SJCK0fThLzy/qbHzwkldT58c/xYbwY6tIYI=
X-Received: by 2002:a5d:5706:0:b0:336:ca4b:b5ff with SMTP id
 a6-20020a5d5706000000b00336ca4bb5ffmr1831234wrv.75.1704731519617; Mon, 08 Jan
 2024 08:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108033138.217032-1-wangrui@loongson.cn>
In-Reply-To: <20240108033138.217032-1-wangrui@loongson.cn>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 8 Jan 2024 08:31:45 -0800
Message-ID: <CAKwvOd=ygyfAzmk=1TTf+U62U8wkvpFYCJo-Ci--6rs5nSoT0A@mail.gmail.com>
Subject: Re: [PATCH] scripts/min-tool-version.sh: Raise min clang version to
 18.0.0 for loongarch
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	loongson-kernel@lists.loongnix.cn, Nathan Chancellor <nathan@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 7:32=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> The existing mainline clang development version encounters diffculties

s/diffculties/difficulties/

> compiling the LoongArch kernel module. It is anticipated that this issue
> will be resolved in the upcoming 18.0.0 release. To prevent user
> confusion arising from broken builds, it is advisable to raise the
> minimum required clang version for LoongArch to 18.0.0.
>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Thanks for all of the work here; it's nice to observe the progress.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1941

> ---
>  scripts/min-tool-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index c62066825f53..9faa4d3d91e3 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -26,6 +26,8 @@ gcc)
>  llvm)
>         if [ "$SRCARCH" =3D s390 ]; then
>                 echo 15.0.0
> +       elif [ "$SRCARCH" =3D loongarch ]; then
> +               echo 18.0.0
>         else
>                 echo 11.0.0
>         fi
> --
> 2.43.0
>
>


--=20
Thanks,
~Nick Desaulniers

