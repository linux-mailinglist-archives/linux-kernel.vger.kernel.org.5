Return-Path: <linux-kernel+bounces-160283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE48B3B61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF889282455
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953F14A4D4;
	Fri, 26 Apr 2024 15:27:26 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6976BFBC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145246; cv=none; b=TOAo+gn4U9X+1w6G/HPuU2c+LOzNwP+ByKNvSDV5S/hTv4XcS2LePi1nYOMUf271eLeB0v8LCcgMDDYz6csMcyrm7h8e7/d9XlNUo6Jb8Mc03Nc8F13ProB9w/bO6itQp/xpOFjBAWDUTKdGplPTDRHVOmKdCujTbMNsbjO2Zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145246; c=relaxed/simple;
	bh=ZZ+RnJlJbAkfYlZ7sIg3Yx8WUTcSSyzOy2QNd/ilGJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2KwbzNkS3JOJgZw+/t7Ke09ecXOSlrRLrhUMxU22QWtOYO8eacFVqrxnIwvb2jUDCK87MVjUrCkkeXy1L1VNhbTFGYMOtztaKwyY4Q4Zr51t1k3urIsFUZF0iUnykwqyt8N0YjRMn/5YChYd3QhrPRDgWjN+ObTLN/NLa024Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61ab6faf179so22350767b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145241; x=1714750041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFoJsTVO578QAmPNPRqBRhs1rZBCXCjYAZQiDdaNowM=;
        b=Ji6QXA+qcldKJWWPLU8qo4I7BXN6xLToBViLZxAjwSU/tvXBd+7RjCQHs5NIdvo4a/
         h/7v/qOj9gNfAPxc6eDN2ff5J7ZpTygvCoOqpHYqKoX/zt/BOM4I5wpk9MgNCkr2XEIE
         mFyGgCZLuhn13vNgQJ2VYDzqFIkzohsdoT6CAHEIQyyFLewK7zLmrq9/2s+zvscXWlbN
         d6HQquTUwnS6/6XOKshuzUR9wLrN9iTB7xX9U0bBtKUjOENTqtiCjSdCX5hfsAwtKfBw
         AXj1Ig3xCvyI6gesaKx1Nwy4Nhd3NF2BKVd6LJ4CYcEpoOHdjQwrdnpwBrpY4SsRI4KL
         f6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWECW5pNXHwujbiRZl3EKD4R+8ZUIorcOHrW/7mfJIPz+4m9PPQg+vX3zLQuOqda/q4o9uzWicHdHLHM52T0mnatYsnOgozcr4hAbVI
X-Gm-Message-State: AOJu0YzNZ/2Y/88w8e3BvwstYHiV1wdADJdqKXMR7H5iwtS3Xr5qQWFk
	O17ZH93FfnFBqFgHu0iTWY2ldPfwVRXMotOcgA4kR7oTLSkQUJpN9bt7DZX8
X-Google-Smtp-Source: AGHT+IFD4rR8Esa8BSTO6xQFt89jkDLO1PCl42waXGhFRhVCTgETYMbWjm9ANbz2NbS+WwxOtW+F0w==
X-Received: by 2002:a05:690c:f88:b0:61a:d455:3dc6 with SMTP id df8-20020a05690c0f8800b0061ad4553dc6mr3929669ywb.11.1714145241258;
        Fri, 26 Apr 2024 08:27:21 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o19-20020a0dcc13000000b00617e3c07229sm4062116ywd.20.2024.04.26.08.27.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:27:20 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617cd7bd929so23898827b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:27:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgHfGl3C3i11orQ6MrOuJXPI+wlfx2hZuzxkmsxGGW9nPKZ/rbQnbRw9mfJ+5TdLsjN7+/eo6IfFBJOjNgOx9nyjiK0htG7PsKWMUG
X-Received: by 2002:a25:83c6:0:b0:de4:8061:48c5 with SMTP id
 v6-20020a2583c6000000b00de4806148c5mr3868976ybm.15.1714145240522; Fri, 26 Apr
 2024 08:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org> <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
In-Reply-To: <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Apr 2024 17:27:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>
Message-ID: <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>
Subject: Re: [RFC] Printing numbers in SI units
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rasmus,

On Wed, Jan 24, 2024 at 11:43=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 24/01/2024 19.58, Matthew Wilcox wrote:
> > I was looking at hugetlbfs and it has several snippets of code like
> > this:
> >
> >         string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> >         pr_warn("HugeTLB: allocating %u of page size %s failed node%d. =
 Only allocated %lu hugepages.\n",
> >                 h->max_huge_pages_node[nid], buf, nid, i);
> >
> > That's not terribly ergonomic, so I wondered if I could do better.
> > Unfortunately, I decided to do it using the SPECIAL flag which GCC
> > warns about.  But I've written the code now, so I'm sending it out in
> > case anybody has a better idea for how to incorporate it.
>
> Well, something that gcc will warn about with Wformat isn't gonna fly,
> obviously. But my man page also mentions ' as a possible flag for d
> conversions:
>
>        '      For decimal conversion (i, d, u, f, F, g, G) the output is
> to be grouped with thousands'
>               grouping characters if the locale information indicates any=
.

> Obviously, our printf wouldn't implement that, [...]

Why not? ;-)

Old Gmail-white-space-damaged patch below, which I wrote when I got
fed up with meticulously counting zeros in GHz-range clock
frequencies...

Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Thu Aug 11 13:52:46 2016 +0200

    lib/vsprintf.c: Add support for thousands' grouping

    Use an underscore as the grouping character.

    TODO:
      - Documentation
      - Self test
      - Do we want to use this in /sys/kernel/debug/clk/clk_summary ?
        RFC patch, compatibility was already broken by commit
        e55a839a7a1c561b ("clk: add clock protection mechanism to clk
        core")

    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    ---
    Originally I wanted to use grouping by 4 for octal and hexadecimal
    numbers.  Unfortunately gcc prints a warning when using the grouping
    character with octal and hexadecimal numbers:

        warning: ''' flag used with '%x' gnu_printf format [-Wformat=3D]
        warning: ''' flag used with '%o' gnu_printf format [-Wformat=3D]

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f4a8bfacb70befbc..51e516cf4cc68156 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -414,6 +414,9 @@ int num_to_str(char *buf, int size, unsigned long
long num, unsigned int width)
 #define ZEROPAD        16              /* pad with zero, must be 16
=3D=3D '0' - ' ' */
 #define SMALL  32              /* use lowercase in hex (must be 32 =3D=3D =
0x20) */
 #define SPECIAL        64              /* prefix hex with "0x", octal
with "0" */
+#define GROUP  128             /* thousands' grouping */
+// warning: ''' flag used with '%x' gnu_printf format [-Wformat=3D]
+// warning: ''' flag used with '%o' gnu_printf format [-Wformat=3D]

 static_assert(SIGN =3D=3D 1);
 static_assert(ZEROPAD =3D=3D ('0' - ' '));
@@ -462,7 +465,7 @@ char *number(char *buf, char *end, unsigned long long n=
um,
        char sign;
        char locase;
        int need_pfx =3D ((spec.flags & SPECIAL) && spec.base !=3D 10);
-       int i;
+       int i, j;
        bool is_zero =3D num =3D=3D 0LL;
        int field_width =3D spec.field_width;
        int precision =3D spec.precision;
@@ -511,6 +514,11 @@ char *number(char *buf, char *end, unsigned long long =
num,
                i =3D put_dec(tmp, num) - tmp;
        }

+       /* take into account grouping characters */
+       j =3D i;
+       if (spec.flags & GROUP)
+               i +=3D (j - 1) / 3;
+
        /* printing 100 using %2d gives "100", not "00" */
        if (i > precision)
                precision =3D i;
@@ -559,10 +567,16 @@ char *number(char *buf, char *end, unsigned long long=
 num,
                ++buf;
        }
        /* actual digits of result */
-       while (--i >=3D 0) {
+       while (--j >=3D 0) {
                if (buf < end)
-                       *buf =3D tmp[i];
+                       *buf =3D tmp[j];
                ++buf;
+               if ((spec.flags & GROUP) && j && !(j % 3)) {
+                       if (buf < end)
+                               // FIXME '\''
+                               *buf =3D '_';
+                       ++buf;
+               }
        }
        /* trailing space padding */
        while (--field_width >=3D 0) {
@@ -2567,6 +2581,7 @@ int format_decode(const char *fmt, struct
printf_spec *spec)
                case ' ': spec->flags |=3D SPACE;   break;
                case '#': spec->flags |=3D SPECIAL; break;
                case '0': spec->flags |=3D ZEROPAD; break;
+               case '\'': spec->flags |=3D GROUP;  break;
                default:  found =3D false;
                }

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

