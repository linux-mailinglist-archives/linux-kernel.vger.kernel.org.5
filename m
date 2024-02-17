Return-Path: <linux-kernel+bounces-69836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0720858F54
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B26283905
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA826A02E;
	Sat, 17 Feb 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1bfYrlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72081E;
	Sat, 17 Feb 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172696; cv=none; b=g7FiDe88szi530/g7XQwKa1CC/g5t0j7sby0HTckNK06zQuOf+SvuB4YDJOJ3lIUoq+xQYlFM1lqIZT+ub5iXRWq8VuhGIbcPTj6sPCZpKyx4VODFeWmqU4SpRPbAI7SAMmCvySLVncGnPhWhcgL3enE01awNfEqLVNzP+BnzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172696; c=relaxed/simple;
	bh=AjIzCu/BylbssdXT/VzmVu/nVEA78ZhOK/Sh07hxbDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE8D7Ua1Z9RWAfHLr/Sh1IEOq+NtlQQEtRmSDM7AlOz6e3FSyu4LHGqt5lQJMQOBoZnnXnC81rTpWjyf2eIWzakTFhtdgDzqUs6zqHuGCQYHuDxeTeAwX5R/sG51P+rXVXY+DoOq3VI8azZm2WHIK2Fv16iFmBWSgPa9vkd6oL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1bfYrlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29898C433C7;
	Sat, 17 Feb 2024 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708172696;
	bh=AjIzCu/BylbssdXT/VzmVu/nVEA78ZhOK/Sh07hxbDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T1bfYrlq6lX2zw+ZEL9jo4Mj75iJqFpUID1wmGP0zJkLB3fgXOW1YzknVT3KG8QsE
	 57nYQRiqRvggJwSGxkfiqaeDXGC3M7kICC8iOuiwaTS9BiSLLbPdOG2fgApdivliLy
	 8LY0hp2miMftDad4b6R+AuLuPwdx2L6lDwmjvAsxTUhSTh7SNxCZpMIwPUduY/9mhl
	 j+5ta89SiOlYTOM/eN7kgvbT39MxAlNEOx94i3pkhZuowyVYm0+mmjjpd6CCvrK3JJ
	 43JXCzrvYa/2AhuGkGnCzoepWq8IiYTIaCuRplzJZuajMpoLBs62nrF/hOdRfOhHGJ
	 LBUPMNW8D5r1g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d208d0b282so35623761fa.0;
        Sat, 17 Feb 2024 04:24:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1I7RL8mSh/KfQTDuKHCG+28YrCMJZ1GwE+Add3IXzfIX0bFgCaJ9FqQlSZv8y7QjTS788vDJpjASQXtMrojT9HLy6bkDtb3oBCXLVQr2gYAxrC5mskUmYyLdzdUuW8qRjObkfbCRJXmXw
X-Gm-Message-State: AOJu0YzcAnqdw43qmoPjzPja/fmWOhDR45MYJRClR/edbqvjCRlatfS3
	kB8nIMekY6ddS+A813MZ33NU1ZYo2jdrBm3bgHVChWSxaT5icSVGPf8qizD3okei34BjtAJUTdq
	I9ljOVPHZgP1imab27DGymcNeRrY=
X-Google-Smtp-Source: AGHT+IGI/4WHrEa7T5jRQ+6PZcoHRPQQ6LQr3X01yYrxlaUU0TSPb5yckYvKmtrIfFuzSjg3l4nQ/xjJh4yeZ6Ld0FY=
X-Received: by 2002:a2e:9902:0:b0:2cf:481b:9cc5 with SMTP id
 v2-20020a2e9902000000b002cf481b9cc5mr5285171lji.19.1708172694653; Sat, 17 Feb
 2024 04:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215141321.899675-1-max.kellermann@ionos.com>
In-Reply-To: <20240215141321.899675-1-max.kellermann@ionos.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 17 Feb 2024 21:24:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT772pZEV09nEYTLOyU_og73zPkKjjL54e8yor-tnnHtw@mail.gmail.com>
Message-ID: <CAK7LNAT772pZEV09nEYTLOyU_og73zPkKjjL54e8yor-tnnHtw@mail.gmail.com>
Subject: Re: [PATCH] scripts/mod/modpost: fix null pointer dereference
To: Max Kellermann <max.kellermann@ionos.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:13=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> If the find_fromsym() call fails and returns NULL, the warn() call
> will dereference this NULL pointer and cause the program to crash.
>
> This happened when I tried to build with "test_user_copy" module.


Can you describe the steps to reproduce it?


I set CONFIG_TEST_USER_COPY=3Dm, but I could not
reproduce it.




> With this fix, it prints lots of warnings like this:
>
>  WARNING: modpost: lib/test_user_copy: section mismatch in reference: (un=
known)+0x4 (section: .text.fixup) -> (unknown) (section: .init.text)
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  scripts/mod/modpost.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index bf7c4b4b5ff4..6b37039c9e92 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1050,7 +1050,9 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         sec_mismatch_count++;
>
>         warn("%s: section mismatch in reference: %s+0x%x (section: %s) ->=
 %s (section: %s)\n",
> -            modname, fromsym, (unsigned int)(faddr - from->st_value), fr=
omsec, tosym, tosec);
> +            modname, fromsym,
> +            (unsigned int)(faddr - (from ? from->st_value : 0)),
> +            fromsec, tosym, tosec);
>
>         if (mismatch->mismatch =3D=3D EXTABLE_TO_NON_TEXT) {
>                 if (match(tosec, mismatch->bad_tosec))
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

