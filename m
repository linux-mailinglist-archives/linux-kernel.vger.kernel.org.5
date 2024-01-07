Return-Path: <linux-kernel+bounces-18851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DF826400
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF528231E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751112E72;
	Sun,  7 Jan 2024 12:01:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7B12E54;
	Sun,  7 Jan 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d4c3393f99so7400865ad.0;
        Sun, 07 Jan 2024 04:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704628907; x=1705233707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QnGROJ1oWVw3/Pa8uoXPLukkVuGGFCJD+vSnZeWEEA=;
        b=kZYQqnveL1wwDOGtzVN7svMP1ROQ/FSR5H3nypZSCcH7N+qPEQXwcxymIGxWmMWgb/
         h5OaOY8++Wgk2MAcoNOm8jA9q906P8Hz9UNdwHFMPk3ZAgB6SVHgznla7JxsID8iu1ih
         3/d8hjntz1ORkhAzbAg0t00mP9gxr3pnbaxA1vdOfmLwRu3ALFeeItPMdw2KvfuIUDL0
         ZWsvrj3uQTef7zIwIIf1lmddGMak3lIGy+T3p83AGh6CWKkRMSS/vZz2jC1h2u6/Rwwa
         9/ExXv8bHTAyftOS1Nob8m8+hLjLBdgz3qGZX5zUg9B6djKTYS9IHVSkoMlcL5zXV3s2
         LKDw==
X-Gm-Message-State: AOJu0YwRA2IUtsz9e1kxgwkXPbf7fQdVSk+N1Asc7x+raTuw9fAAZHBA
	tdD7gN+oY4mvzO+2DSahO5RMpzqgwFPEfhXvyUc=
X-Google-Smtp-Source: AGHT+IHLPAYIJC36BTu95hJWkiiM7l4wuMzpp++PtD979TuU3xLZ9t8ZJYI6QTGlSxDEqq4T5BatXjsFjWmrrB2CkY0=
X-Received: by 2002:a17:903:41ce:b0:1d3:ec14:10f0 with SMTP id
 u14-20020a17090341ce00b001d3ec1410f0mr2738441ple.52.1704628906763; Sun, 07
 Jan 2024 04:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20231217071250.892867-1-mailhol.vincent@wanadoo.fr> <20231217071250.892867-2-mailhol.vincent@wanadoo.fr>
 <CAMuHMdUvqY4VLDS0mW2VbSzTmef9xt+F3FCpRj5-Mv+KeOqyXg@mail.gmail.com>
In-Reply-To: <CAMuHMdUvqY4VLDS0mW2VbSzTmef9xt+F3FCpRj5-Mv+KeOqyXg@mail.gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 7 Jan 2024 21:01:34 +0900
Message-ID: <CAMZ6RqJyJsucRHnuwj87gC9H9hZm9UwC8vAxEJHEPvM-sY=5DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] m68k/bitops: force inlining of all bitops functions
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Kees Cook <keescook@chromium.org>, 
	Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 2 janv. 2024 at 19:28, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Vincent,
>
> Thanks for your patch!

Thanks for the review and for running the benchmark.

> On Sun, Dec 17, 2023 at 8:13=E2=80=AFAM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> > The inline keyword actually does not guarantee that the compiler will
> > inline a functions. Whenever the goal is to actually inline a
> > function, __always_inline should always be preferred instead.
> >
> > On an allyesconfig, with GCC 13.2.1, it saves roughly 5 KB.
> >
> >   $ size --format=3DGNU vmlinux.before vmlinux.after
> >         text       data        bss      total filename
> >     60449738   70975612    2288988  133714338 vmlinux.before
> >     60446534   70972412    2289596  133708542 vmlinux.after
>
> With gcc 9.5.0-1ubuntu1~22.04, the figures are completely different
> (i.e. a size increase):

Those results are not normal, there should not be such a big
discrepancy between two versions of the same compiler. I double
checked everything and found out that I made a mistake when computing
the figures: not sure what exactly, but at some point, the ASLR seeds
(or other similar randomization feature) got reset and so, the
decrease I witnessed was just a "lucky roll".

After rerunning the benchmark (making sure to keep every seeds), I got
similar results as you:

        text       data        bss      total filename
    60449738   70975356    2288988  133714082
vmlinux_allyesconfig.before_this_series
    60446534   70979068    2289596  133715198
vmlinux_allyesconfig.after_first_patch
    60429746   70979132    2291676  133700554
vmlinux_allyesconfig.final_second_patch

Note that there are still some kind of randomness on the data segment
as shown in those other benchmarks I run:

        text       data        bss      total filename
    60449738   70976124    2288988  133714850
vmlinux_allyesconfig.before_this_series
    60446534   70980092    2289596  133716222
vmlinux_allyesconfig.after_first_patch
    60429746   70979388    2291676  133700810
vmlinux_allyesconfig.after_second_patch

        text       data        bss      total filename
    60449738   70975612    2288988  133714338
vmlinux_allyesconfig.before_this_series
    60446534   70980348    2289596  133716478
vmlinux_allyesconfig.after_first_patch
    60429746   70979900    2291676  133701322
vmlinux_allyesconfig.after_second_patch

But the error margin is within 1K.

So, in short, I inlined some functions which I shouldn't have. I am
preparing a v4 in which I will only inline the bit-find functions
(namely: __ffs(), ffs(), ffz(), __fls(), fls() and fls64()). Here are
the new figures:

        text       data        bss      total filename
    60453552   70955485    2288620  133697657
vmlinux_allyesconfig.before_this_series
    60450304   70953085    2289260  133692649
vmlinux_allyesconfig.after_first_patch
    60433536   70952637    2291340  133677513
vmlinux_allyesconfig.after_second_patch

N.B. The new figures were after a rebase, so do not try to compare
with the previous benchmarks. I will send the v4 soon, after I finish
to update the patch comments and double check things.

Concerning the other functions in bitops.h, there may be some other
ones worth a __always_inline. But I will narrow the scope of this
series only to the bit-find function. If a good samaritan wants to
investigate the other functions, go ahead!

Yours sincerely,
Vincent Mailhol




> allyesconfig:
>
>       text       data        bss      total filename
>   58878600   72415994    2283652  133578246 vmlinux.before
>   58882250   72419706    2284004  133585960 vmlinux.after
>
> atari_defconfig:
>
>       text       data        bss      total filename
>    4112060    1579862     151680    5843602 vmlinux-v6.7-rc8
>    4117008    1579350     151680    5848038
> vmlinux-v6.7-rc8-1-m68k-bitops-force-inlining
>
> The next patch offsets that for allyesconfig, but not for atari_defconfig=
.
>
> > Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of
> > test_and_set_bit and friends")
>
> Please don't split lines containing tags.
>
> > Link: https://git.kernel.org/torvalds/c/8dd5032d9c54
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

