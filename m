Return-Path: <linux-kernel+bounces-1667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C398151E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B25B1F26752
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2E47F76;
	Fri, 15 Dec 2023 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2C9fwrQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9947F5E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-552d4483414so1120071a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702675170; x=1703279970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mxcQ8U3h2VEOqJmIa1ew38QPU2ZNWsAXvnsDdFpYNk=;
        b=z2C9fwrQBa1wtnJDsS2VfZ2PbcIs8oda73n+Uy3iZ4rOsviIusfkrkpCasr16iZ08B
         Cpl5ccUeour+h/IVL6TN3c3RaHflJaHLKYk5O6gsxNwNzyLYogKWbYys5zBh8czUp4iX
         ZQfjW6o4ZfqAHNm8tniwoL/tcXkf/OirkqItMM7D7FTMjq5GISnH/TO1EMoSrS9tWxNJ
         IvbfqTfhYnubk8a4B8o/YXrbu4mbxYCFWY16UckqEPlAna6bqSqlU+iHP0zIgJ9qJcMg
         GtVzasmeLgiwlJF/EFWfZsMaW9xuSIYK5c3AE8A617KtuP5WQJe19gFsFx5kg4vK/FTV
         IBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675170; x=1703279970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mxcQ8U3h2VEOqJmIa1ew38QPU2ZNWsAXvnsDdFpYNk=;
        b=RCQbzqkhZSoG2nfFLTOEt4VfipUPBEBdlqquOB4Lfb0duFGCIl0prHxJhmVckya61/
         0gqG85BpKwnQD0cUYQt9Y8BacRRwJTqDDK1Hz51pSo0s1sS7Vk5CEdPhjWY10VCNDe/B
         7gMjgTwJ8uvpr1HZm3ltBWcneQwl2+1qXTB+4MA5TYs4ocRW4+w7/88yrENnZJfsJAoH
         FpDCFw2iVjktCBILgx8aKU1MwG3sPZyFwLv0tq4tv1y+QNjrcHHXo5FFk7BqtOKiKXMk
         XpIHU+pE9J63bBpz1ykAeL+Tbg6E/0FExjjFP0rsa4Imm1IPL0irmVc6otDf2lP+GXXx
         ahBg==
X-Gm-Message-State: AOJu0YzZodsodFnslEiek7YygKhAVjXqGExgMTe4VRXsrqTDch0aEYl+
	lA5J/HWptInMPB1L2vSp6alsZ1nZysREkhxP9AA7rw==
X-Google-Smtp-Source: AGHT+IGWvGafUSlhGGXrv1hh40ziXnG3b+EtYKBvhRhUWYc2aqT1+gDxNub/ucJABTu5gCVtHtP+ylscuPXvzxMb7IU=
X-Received: by 2002:a50:8d50:0:b0:552:e8c3:95a7 with SMTP id
 t16-20020a508d50000000b00552e8c395a7mr409698edt.27.1702675170229; Fri, 15 Dec
 2023 13:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
In-Reply-To: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 15 Dec 2023 13:19:18 -0800
Message-ID: <CAFhGd8pweTJJU7=iSqXbvSW79fL54B_aLpzwW3nxJ62=UA0b+A@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: Use LLVM environment variable
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Manuel Traut <manut@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 15, 2023 at 10:27=E2=80=AFAM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
> When using LLVM as the compiler, decode_stacktrace should also use
> llvm-addr2line. Check if LLVM is set and add the appropriate
> suffix/prefix.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

I tried it out by dropping a random dump_stack() call into the init
phase of the kernel and redirecting the serial console output to a log
file. Using the pre-(this patch) and post-(this patch) script yields
good stack trace results. It seems llvm-addr2line is a drop-in
replacement.

Tested-by: Justin Stitt <justinstitt@google.com>

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

Thanks
Justin

