Return-Path: <linux-kernel+bounces-35396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282E839057
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A56C284096
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5515F550;
	Tue, 23 Jan 2024 13:43:14 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2E5EE9A;
	Tue, 23 Jan 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017393; cv=none; b=Kk8mLno/MlPTcIPmLTdeUEwYk/PqacWqMby04diCOxaG/hZTM0vnG18TRfPYXTlN7S+L9o0KJX2xjISKAjjJqn499lr3akVIC+n77E20SJ6Pn+fxr9fWmIv2BVKvWGH6br4+9oXg3tdl3jarWlGOt6XRhtqp2ue30v8bXKsK9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017393; c=relaxed/simple;
	bh=Jb9itl957EFVoNO5FWQy9uocQU42xFzLex48PwPhTqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2gFPXbDLsuiJeHhjryq6juw6GReeIbz6At4quHKJxOhnN7WvMhWY6jzvv/Q2vB9wW2uQY9FE7Wt2dwNsDphyWzHyw5xT6mWkeOcPuqpbba8orMLnD2tNJfLlRx9UK2GObCmUebGRw/HMVjciXMbQ2uQIPVJ0bIzTxpcYFwPQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so43988207b3.2;
        Tue, 23 Jan 2024 05:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017390; x=1706622190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta8VXhfkrMNIwJSy/HBWlj17p8HnvVLoiI7h5yLdjII=;
        b=GO9Rd3TbSJdxA+RJbUCZOXh/q7c4dclE73jVHDMqOG6fdKYhkOmSktHhVQROe0uidD
         Kpo+dDiJbZFJGCYUaPXXl2wRD6WSP8OvrAV7i94itz9bMReXqv1m9+i0pBat1KAbXBe/
         WHGIoUY0ba+tsdaOfzDz8Sq6Ksl5D1koPI2UuV3UN9Prvm/OJ0DBBOGo56LDriWlJL4i
         hYGKhRBAqlnOgyohEHHbwfs8381rocR79Rb7kDbsdvRyL4m7W/HkjVWkP/kSaMirzsYQ
         /TWjjAxf3Qdc/DN9TeGBbEq7e+p1d2zDNmjZRmfyP1AOg/Cnrl88kaFQKtS2Mi/F152U
         GlOw==
X-Gm-Message-State: AOJu0YyCSAOhfn8Yh9F//yH0JxF2lLkOlFdJ7hxt0AGA9aXD89wvOd+s
	senrQAdsc1WTPVT37iXBZd474kNrh45DgbodgVVryZrGhg4H9+HqIdxFKR8Wf6g=
X-Google-Smtp-Source: AGHT+IHxjorUYIUGj5cuOXZdUYvwecuOQnqM2naYCWagiysYPgxFGUzVgD0y3Fqucr9HLeE2hT20Ow==
X-Received: by 2002:a0d:cb8b:0:b0:5ff:5beb:d570 with SMTP id n133-20020a0dcb8b000000b005ff5bebd570mr4683025ywd.43.1706017390085;
        Tue, 23 Jan 2024 05:43:10 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w197-20020a0dd4ce000000b005ff9acf4683sm3296792ywd.123.2024.01.23.05.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 05:43:09 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso43943317b3.1;
        Tue, 23 Jan 2024 05:43:09 -0800 (PST)
X-Received: by 2002:a0d:f5c3:0:b0:5fb:da77:af07 with SMTP id
 e186-20020a0df5c3000000b005fbda77af07mr4704548ywf.32.1706017389477; Tue, 23
 Jan 2024 05:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-27-keescook@chromium.org>
 <CAMuHMdWa9tXQRHkkX-W+5n8kuCvEFZdsfStPtYGA0MZpTGX79Q@mail.gmail.com> <c915b476-784c-4d64-8063-f18837350568@helsinkinet.fi>
In-Reply-To: <c915b476-784c-4d64-8063-f18837350568@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jan 2024 14:42:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhPV0-BCe-90oh5tpwt1S8bOQsyRE+vemVGORSfS-gBg@mail.gmail.com>
Message-ID: <CAMuHMdVhPV0-BCe-90oh5tpwt1S8bOQsyRE+vemVGORSfS-gBg@mail.gmail.com>
Subject: Re: [PATCH 27/82] m68k: Refactor intentional wrap-around calculation
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Liam Howlett <liam.howlett@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, linux-m68k@lists.linux-m68k.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eero,

On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Eero Tamminen <oak@helsinkinet.fi> =
wrote:
> On 23.1.2024 10.13, Geert Uytterhoeven wrote:
> > On Tue, Jan 23, 2024 at 1:35=E2=80=AFAM Kees Cook <keescook@chromium.or=
g> wrote:
> >> In an effort to separate intentional arithmetic wrap-around from
> >> unexpected wrap-around, we need to refactor places that depend on this
> >> kind of math. One of the most common code patterns of this is:
> >>
> >>          VAR + value < VAR
> >>
> >> Notably, this is considered "undefined behavior" for signed and pointe=
r
> >> types, which the kernel works around by using the -fno-strict-overflow
> >> option in the build[1] (which used to just be -fwrapv). Regardless, we
> >> want to get the kernel source to the position where we can meaningfull=
y
> >> instrument arithmetic wrap-around conditions and catch them when they
> >> are unexpected, regardless of whether they are signed[2], unsigned[3],
> >> or pointer[4] types.
> >>
> >> Refactor open-coded unsigned wrap-around addition test to use
> >> check_add_overflow(), retaining the result for later usage (which remo=
ves
> >> the redundant open-coded addition). This paves the way to enabling the
> >> unsigned wrap-around sanitizer[2] in the future.
> >>
> >> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185=
36594 [1]
> >> Link: https://github.com/KSPP/linux/issues/26 [2]
> >> Link: https://github.com/KSPP/linux/issues/27 [3]
> >> Link: https://github.com/KSPP/linux/issues/344 [4]
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Liam Howlett <liam.howlett@oracle.com>
> >> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Cc: linux-m68k@lists.linux-m68k.org
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/m68k/kernel/sys_m68k.c
> >> +++ b/arch/m68k/kernel/sys_m68k.c
> >> @@ -391,10 +391,11 @@ sys_cacheflush (unsigned long addr, int scope, i=
nt cache, unsigned long len)
> >>
> >>                  mmap_read_lock(current->mm);
> >>          } else {
> >> +               unsigned long sum;
> >
> > "sum" sounds like this is a dummy variable, to please the third
> > parameter of check_add_overflow()...
> >
> >>                  struct vm_area_struct *vma;
> >>
> >>                  /* Check for overflow.  */
> >
> > I agree with Liam: please drop the comment.
> >
> >> -               if (addr + len < addr)
> >> +               if (check_add_overflow(addr, len, &sum))
> >>                          goto out;
> >>
> >>                  /*
> >> @@ -403,7 +404,7 @@ sys_cacheflush (unsigned long addr, int scope, int=
 cache, unsigned long len)
> >>                   */
> >>                  mmap_read_lock(current->mm);
> >>                  vma =3D vma_lookup(current->mm, addr);
> >> -               if (!vma || addr + len > vma->vm_end)
> >> +               if (!vma || sum > vma->vm_end)
> >
> > ... Oh, it is actually used. What about renaming it to "end" instead?
>
> IMHO this is more descriptive:
> +               if (check_add_overflow(addr, len, &sum))
>
> than this:
> +               if (check_add_overflow(addr, len, &end))
>
> "sum" is IMHO quite obviously sum of the preceding args, whereas I do
> not know what "end" would be.

"end" is the end of the block of size "len" pointed to by "addr".

IMHO "if (sum > vma->vm_end)" is less descriptive...

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

