Return-Path: <linux-kernel+bounces-4078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C68177AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D171C240CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A591498BF;
	Mon, 18 Dec 2023 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9PDDfUm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281E42392
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d190df5d0so14083815e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702917477; x=1703522277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUE9wOcs5DhS6rCyT7en0Ycls+VZryCuy04V3s7BDwY=;
        b=w9PDDfUmDmKfk+lgbu/VSU9dz4HwZKDxVgPUM2nb+WFqQcWEL8LNlQrv24l+GSx0y2
         6YSm3SeH9GkMFBfiLHkXXJNuorryYuVFHu6PFQFOLEbK6G+RtKJtwBB/XmiTAOvaAYAj
         Pv7OKru8eAt3//0AMca9mOFGIY6VEauaU3MsmMkre8O4u3TsC/suGqQ0rwa1TGn3KLuO
         s37rkm2Y7NSV5cL3wD7thYbl9tY/UJrMxUnh8yUX8fQK07sEkeZ0oni/6FVqcHMW9nJs
         4pDvT+6jVApO6URAJApCxgSLC1i/Pquq+AiY3aVbcODtbSEQn3X3ZJO+orQUgbxwGPee
         NwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917477; x=1703522277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUE9wOcs5DhS6rCyT7en0Ycls+VZryCuy04V3s7BDwY=;
        b=nLOZJ0MmnZUMzPFU7mgK4UOvRf93UjrtXPKNgVzsWfv2MAjdTIdVFD97r1NdqK/588
         JJyLXRiOP1MXEBVsA0azk0m3jgWDOGHscEdWJf5kuqn9GMb2GetezjWcVztlwDViz1JN
         yG3jlTmj1uez+Zeiu7H1wcz3DMSe17qLGMg9AghgfovloDg3Yrh9XReYCI8I9YzMCH0S
         PLrYCK997r9YrP19oOcNepbt4svVAqoq1oJzrLsnmIrkDK8L77uvGXq0m80c/BHbzHIh
         ZUFvheK/bGefJpiEx3HBx7Fr3y6toFlDAfmSv75cgqGx1lIPKStWFxlVQqZO6ObnNzy8
         ia/A==
X-Gm-Message-State: AOJu0Yy+d6VxNtP6OE1qwV+e/rzVlrhvFVwmVZmuEtub03FVntNm9DVS
	emnscah+n23L7PIk/ZYN7o3xhJrIISHrwm9FDl6TWQ==
X-Google-Smtp-Source: AGHT+IHXrsR1IvFyccMxPBaIu18/8JzznbiYFGpcdylejDvJk9lKQolYCP+MFBgLmXsqvurqf6AGybBA4PfkuxeHX/8=
X-Received: by 2002:a05:600c:1649:b0:40c:1205:c253 with SMTP id
 o9-20020a05600c164900b0040c1205c253mr8598699wmn.183.1702917474422; Mon, 18
 Dec 2023 08:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
In-Reply-To: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 18 Dec 2023 08:37:43 -0800
Message-ID: <CAKwvOdmY=Jysqai3KOYO8+c5idP9JjNGKL2xZn2sDNdj5MjTVA@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: Use LLVM environment variable
To: Elliot Berman <quic_eberman@quicinc.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Manuel Traut <manut@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:27=E2=80=AFAM Elliot Berman <quic_eberman@quicin=
c.com> wrote:

This patch looks familiar...
https://lore.kernel.org/lkml/20230929034836.403735-1-cmllamas@google.com/

Masahiro, can you please pick up that patch?

Elliot, Justin, can you help test/review that patch?

>
> When using LLVM as the compiler, decode_stacktrace should also use
> llvm-addr2line. Check if LLVM is set and add the appropriate
> suffix/prefix.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  scripts/decode_stacktrace.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 564c5632e1a2..189b00f4e120 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -16,6 +16,16 @@ elif type c++filt >/dev/null 2>&1 ; then
>         cppfilt_opts=3D-i
>  fi
>
> +if [[ "${LLVM}" =3D=3D "1" ]] ; then
> +       addr2line=3D"llvm-addr2line"
> +elif [[ "${LLVM}" =3D=3D */ ]] ; then
> +       addr2line=3D"${LLVM}llvm-addr2line"
> +elif [[ "${LLVM}" =3D=3D -* ]] ; then
> +       addr2line=3D"llvm-addr2line${LLVM}"
> +else
> +       addr2line=3D"${CROSS_COMPILE}addr2line"
> +fi
> +
>  if [[ $1 =3D=3D "-r" ]] ; then
>         vmlinux=3D""
>         basepath=3D"auto"
> @@ -169,7 +179,7 @@ parse_symbol() {
>         if [[ $aarray_support =3D=3D true && "${cache[$module,$address]+i=
sset}" =3D=3D "isset" ]]; then
>                 local code=3D${cache[$module,$address]}
>         else
> -               local code=3D$(${CROSS_COMPILE}addr2line -i -e "$objfile"=
 "$address" 2>/dev/null)
> +               local code=3D$(${addr2line} -i -e "$objfile" "$address" 2=
>/dev/null)
>                 if [[ $aarray_support =3D=3D true ]]; then
>                         cache[$module,$address]=3D$code
>                 fi
>
> ---
> base-commit: 3f7168591ebf7bbdb91797d02b1afaf00a4289b1
> change-id: 20231214-llvm-decode-stacktrace-09538979006d
>
> Best regards,
> --
> Elliot Berman <quic_eberman@quicinc.com>
>


--=20
Thanks,
~Nick Desaulniers

