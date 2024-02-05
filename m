Return-Path: <linux-kernel+bounces-52685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D45849B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0966B2AC5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0D1CA86;
	Mon,  5 Feb 2024 13:08:14 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B867210ED;
	Mon,  5 Feb 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138494; cv=none; b=OAGD8MyKUz+uxj17ai3s1WffOfQF9pV9XmZsw6IQ780ylQcgTSZhmFLAqF3+oVJcJOLAj+phZ0BzjeTovf5o0ChpcB3DTAQpuzDZAeU/IO3qYT3b4lbESt38W/goYdjPAbMjJIlSDQsajCvFN0RZKIe5Ou3+KQXhMojjt+3H2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138494; c=relaxed/simple;
	bh=+ZPky9xnTQzGgCRR2NBciIVFyd2Dd5HNgtKm3n+j7Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di74C/eBSkEw3qVZw6YO+ZDv6baXGrS4lO1olwlj3zqn+aOdLiwzpUXZT+hdYsDEvZcEh+qZHgtZd8d3hXaJufOYsPzRlxieZsVuBCSq/9SJwdDZu5kjHvDbPuFy+5Rd41mjPKX+oHXKTgN4+odkwNDlNX/NEZnQ7NA2FRUSgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2191dc7079aso1584740fac.0;
        Mon, 05 Feb 2024 05:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138489; x=1707743289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4l7mcaaxoys3/2icFPJqDxqSgWMH+oMeBEXylz/8J8=;
        b=DDP4Xi8byo7PzrRVh9zAFxPbpgULundN5qR9M1Esmxrr3NhnSeZ2j6Ggu170t07tXW
         dkTJz0bMwXK8dRLgWcIbhFmrQ25ZnHZRBGGxg4LVKyMz1ke6IqvSELeic5aS+yUrU8xQ
         jg3usUajTW4NR+9cWddf40PL5RAX0unxsMxoJSUO4zoCI4DD1UKW3EnQEzt/Wa+FNufP
         L+VhxGnQULmZLEfkjSIbaM5u1R+8C2zHpw7pYxfYIyZpyxLbTN2f9pzZvvqnYHch5NMX
         SeQRsyGngRRK3lKilD54DY/4L3OR50oSb+z/K/uuUyiVaXRUSUjdm8kXX7Zpto9y3Dxp
         F6QQ==
X-Gm-Message-State: AOJu0YzuOc7pdy3hRLkmMTrp9ScY9/CC4JAyUKkdTYhrwOr3OFESI8FE
	unjGrU9kii7p0d6Ye4n/DsTDNUWTe/3kILJJhI0Lwiz3VX6rpKFeVy+oOFyHPeU=
X-Google-Smtp-Source: AGHT+IHqSNO03gZFsceBWqkTbSH1g3ZZ0pbhNITFzI2kv7c/Sz9DL/veXPIA9eLEZUsx7rPYnfc9eQ==
X-Received: by 2002:a05:6870:1cd:b0:219:97e7:a99a with SMTP id n13-20020a05687001cd00b0021997e7a99amr1199470oad.12.1707138489556;
        Mon, 05 Feb 2024 05:08:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFc+gI29+8c7m3iF/m45Djx97MH7sDr+Fb/K+2VnnbYeXZkgE8D/39+bBW7JoElmki0IlE5Nancsm7T7ycBvr1dhbs4mGlC7YTIq0xc5DQrmahiJ8V3A5/je9N4XpH+WcCun7JmClUy9DDpOz7
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id mm14-20020a0568700e8e00b0021892d2f44dsm1908729oab.55.2024.02.05.05.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:08:09 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a9304aef0so2467352eaf.1;
        Mon, 05 Feb 2024 05:08:08 -0800 (PST)
X-Received: by 2002:a05:6358:1901:b0:178:a295:996 with SMTP id
 w1-20020a056358190100b00178a2950996mr18933522rwm.22.1707138488274; Mon, 05
 Feb 2024 05:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-2-keescook@chromium.org>
 <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com> <202402050459.892907C59C@keescook>
In-Reply-To: <202402050459.892907C59C@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 14:07:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYri0tkVDORL468hc7_AXx4qnrT6wjKO69FpujbEehUQ@mail.gmail.com>
Message-ID: <CAMuHMdXYri0tkVDORL468hc7_AXx4qnrT6wjKO69FpujbEehUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, Feb 5, 2024 at 2:01=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Mon, Feb 05, 2024 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> > > +/*
> > > + * The 2 argument style can only be used when dst is an array with a
> > > + * known size.
> > > + */
> > > +#define __strscpy0(dst, src, ...)      \
> > > +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> > > +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
> >
> > (dst), (src), (size) etc.
>
> I normally don't do this when macro args are being expanded into
> function arguments. I've only done it for when macro args are used in
> expressions. Am I missing a side-effect here, or is this more about
> stylistic consistency?

I'm not 100% sure it is needed, but I'm always wary when using macro
parameters without parentheses, except in the most simple use-cases.

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

