Return-Path: <linux-kernel+bounces-139955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B98A0991
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3141C224D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0513E04A;
	Thu, 11 Apr 2024 07:19:47 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7B13B5B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819987; cv=none; b=sW+XNXE3pj7y2FprLLh0GPa3tnholWzE/KIrJr009B57ABHATaUKpu+EuNqFNGbSaPO3Aq4icbGDooTSFpPQ/iukIKl6kdWAbDtXqxqWCHXTdgW3I6OCEHl10b82d/Oq8owG7eCmxT9UO+b9RKBhht3KajTDqnpuRYxspMa1j8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819987; c=relaxed/simple;
	bh=KYHdcL3h4VaEXu/6ZpOx1/hFfG5qFf2vdZGlVzX2idk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+/zQCw0meDnGXM6Z15tvqIc550Jdl0S/q0MvgRyYH4rpMaxjF19KeVxuzofpXRqcQTSCy1cCp3PdGJ6fq0UWvMt6z3/Npi16osBA1lrSbf4DIevbPiknkWcsEQGMKRaGXUwnFo6rEIEc1C7GJJn/VKmu4qmgcKY6+98+ZwO8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-617ddc988f5so67664547b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819984; x=1713424784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsbbRBY6j5jPYAvkVgBZjQe5d259H73L5jEnLP58+HU=;
        b=oxYyFMlSja+L+K4V7vZM6c5iByZNxns6mjYfgPbrsD/cJrSm8vnE7+CzCO0DsZ0NO/
         36pAqxAfsr8DM5mmqDgv4v3TKsqKxmQkNzpMD1ctl21g3/8+Zxfthk39sn+xrb7y7YD8
         zWCZeKPRtQLuNip0csns34phyVXlCocX9nrOCjUY0VzjZzYaBobsXeoaLbf8OxTJfV3J
         fjvOOWsP5D7yplO8F9HYrMwYV3uEq39qNe+ySpqLgwJnwGkxhBo6iwCQKgV8l75q+Wtb
         gcFlybIDDH4H5JKfMxSi43hLV20chlydjQzmPraOyyDuPAnCyjuycq7lCelhFEIcJ9RR
         88dQ==
X-Gm-Message-State: AOJu0YxvVzKTYJhuZaSg6pY2WTMd6zG3EzSx4K9JJ51Xrh606O+NYy5t
	F1XxlX86YQkMlmnqPnqRqnmq+d39XAywlBz66wLu4RRZl1Sn1c2Cui5PCJu1
X-Google-Smtp-Source: AGHT+IFlkFsJU2dE5pXyEgyhzo5W8YdrTOGlr+2nux7qIXJWWc5Gua+cgrJTEzPfoamnKsY2nnk0mQ==
X-Received: by 2002:a0d:d451:0:b0:615:3624:f7e3 with SMTP id w78-20020a0dd451000000b006153624f7e3mr5590268ywd.22.1712819984065;
        Thu, 11 Apr 2024 00:19:44 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s2-20020a81c442000000b006184d7943casm194659ywj.33.2024.04.11.00.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:19:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd045349d42so6958357276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:19:43 -0700 (PDT)
X-Received: by 2002:a25:8a10:0:b0:dcd:1b8f:e6d3 with SMTP id
 g16-20020a258a10000000b00dcd1b8fe6d3mr4876400ybl.48.1712819983645; Thu, 11
 Apr 2024 00:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411041200.225356-1-ytcoode@gmail.com>
In-Reply-To: <20240411041200.225356-1-ytcoode@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:19:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1-F0eZAXUyVCt2ik2w9J+vTm1DnvTVwx2hNz1CDZc1g@mail.gmail.com>
Message-ID: <CAMuHMdU1-F0eZAXUyVCt2ik2w9J+vTm1DnvTVwx2hNz1CDZc1g@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Remove redundant space from saved_command_line
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "ndesaulniers@google.com" <ndesaulniers@google.com>, Tejun Heo <tj@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krister Johansen <kjlx@templeofstupid.com>, 
	Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Hiramatsu-san (now for real :-)

On Thu, Apr 11, 2024 at 6:13=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
> extra_init_args ends with a space, so when concatenating extra_init_args
> to saved_command_line, be sure to remove the extra space.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/init/main.c b/init/main.c
> index 2ca52474d0c3..cf2c22aa0e8c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command=
_line)
>                         strcpy(saved_command_line + len, extra_init_args)=
;
>                         len +=3D ilen - 4;        /* strlen(extra_init_ar=
gs) */
>                         strcpy(saved_command_line + len,
> -                               boot_command_line + initargs_offs - 1);
> +                               boot_command_line + initargs_offs);
>                 } else {
>                         len =3D strlen(saved_command_line);
>                         strcpy(saved_command_line + len, " -- ");
>                         len +=3D 4;
>                         strcpy(saved_command_line + len, extra_init_args)=
;
> +                       len +=3D ilen - 4; /* strlen(extra_init_args) */
> +                       saved_command_line[len-1] =3D '\0'; /* remove tra=
iling space */
>                 }
>         }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

