Return-Path: <linux-kernel+bounces-5588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42822818CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16EC28CCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6222331;
	Tue, 19 Dec 2023 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfB9vtnv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66877286A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso47581715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703004197; x=1703608997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yZxJx1cWmHeTwDIsoftViKVMbEIpjqlvBdK4HE8zHY=;
        b=jfB9vtnvcxj8y5BP99AVIfHK4kzBlutWbHv3trS/tqamUjt5F2iZMxkFrDWuIv85LY
         VhS8UzVmzDDiL/Bpa4LkFM82DsCL74V2N5G50zvqRgx2hN9f1f/v7xewbvvXXVTXIcdT
         8OSWJBhKOuP+kIeiPrPgjW9h6R9kf8Y93I/btevJqHpn4KX7Rh86q78iHSkytE3+tpaB
         fDKuM1gfOk5TNmvUJhnuTQrc1h6+7O3fQUemlEeP7IlFAjPFlHA2BwHc4lPgg5LBJNC0
         mpGhHc/NRm0GdrdVkrZ/9OhEBfteKYStjQrypmr8RhA0cPu7znMzpw8BVGxb9EUvAfB7
         bKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004197; x=1703608997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yZxJx1cWmHeTwDIsoftViKVMbEIpjqlvBdK4HE8zHY=;
        b=oDsNuN551eXwKDNhMXwbXSO2S6+Zyr6UhOZ18jHEWfIPegZVi3j32ErC7EDb1djAIH
         ZyQsTW5aFLTHJI3qWn0ZVwQM+1TCLfFZysUZrKDXOamCDVDfKHDH9FeMvzmSMHv5m+Pi
         HTEsoxnnKNgCm5wH2cNcO0cRu5wWIqsQUlR4HdU126mSOt++DXhTElKkbui7Gxj4tM/g
         anXtnExFpZ5FkL7T0o+oBD07xJTdyK4WVS+v+Qb5qrnFpy3JjQf4MjO3NREZ6gF6tijt
         NUirTuJFLJTNXAWoeazCIVcp6uwWqd4H0za0cTiRAovZoEU9DtkLzb15Gq4ER3KOqkHn
         ebtA==
X-Gm-Message-State: AOJu0YzwDO3KgmAWd2CchVeOMqZWLnP3pBn4NyGbcvd/Q54w5yGtTCw7
	e2zk+YwmBhlssmJFAl4Sxwoq8cl2Hdhg33W5t5W6gQ==
X-Google-Smtp-Source: AGHT+IFCEwQvWYi051sDKnZS/vCosn8IFK6NHq4Z3M2iWFR1+/WyPMNdvfFI1SH/zh+bt6YmFxNQvnhuIahxA/po9/w=
X-Received: by 2002:a05:600c:35c5:b0:40d:2399:e8ab with SMTP id
 r5-20020a05600c35c500b0040d2399e8abmr720646wmq.119.1703004197354; Tue, 19 Dec
 2023 08:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
 <20231218-libstringheader-v3-2-500bd58f0f75@google.com> <ZYG83l5AW_zVw2aR@smile.fi.intel.com>
In-Reply-To: <ZYG83l5AW_zVw2aR@smile.fi.intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 19 Dec 2023 08:43:01 -0800
Message-ID: <CAKwvOd=OXOHAiwue98jfqZ=TJSe21ecfgtf6jEihy8F=0EvWnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lib/string: shrink lib/string.i via IWYU
To: Andy Shevchenko <andy@kernel.org>
Cc: tanzirh@google.com, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick DeSaulniers <nnn@google.com>, Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Greg KH <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:55=E2=80=AFAM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Mon, Dec 18, 2023 at 06:44:48PM +0000, tanzirh@google.com wrote:
> > This diff uses an open source tool include-what-you-use (IWYU) to modif=
y
> > the include list changing indirect includes to direct includes.
> > IWYU is implemented using the IWYUScripts github repository which is a =
tool that is
> > currently undergoing development. These changes seek to improve build t=
imes.
> >
> > This change to lib/string.c resulted in a preprocessed size of
> > lib/string.i from 26371 lines to 5263 lines (-80%) for the x86
> > defconfig.
>
> ...
>
> >  #define __NO_FORTIFY
> >  #include <linux/types.h>
> > -#include <linux/string.h>
> > -#include <linux/ctype.h>
> > -#include <linux/kernel.h>
> > -#include <linux/export.h>
> > +#include <linux/bits.h>
> >  #include <linux/bug.h>
> >  #include <linux/errno.h>
> > -#include <linux/slab.h>
>
> > -
>
> Why this blank is removed?

The automation isn't aware of any convention around having blank lines
separate linux/* vs asm/*.  Is that a convention we have throughout
the kernel, or just this file?

If we rerun the automation on this file after Tanzir's patch here, we
get no further changes.  If we manually touch up the results, then
rerun the automation, it will undo the manual touch ups.

I don't mind saying "you might have to manually touch up the results
of the automation to comply with <link to documentation on stated
kernel policy/style guide>" but on the other hand I also think it
would be nice if other folks run the automation so that they don't get
additional changes.  I'd like to avoid drive-by patches that just undo
any manual touch ups.

>
> > +#include <linux/linkage.h>
> > +#include <linux/stddef.h>
> > +#include <linux/string.h>
> > +#include <linux/ctype.h>
> >  #include <asm/unaligned.h>
> > -#include <asm/byteorder.h>
> > +#include <asm/rwonce.h>
> >  #include <asm/word-at-a-time.h>
> >  #include <asm/page.h>
>
> Sort this group alphabetically as well.

By default the automation sorts the result.  I asked Tanzir to
explicitly disable that; otherwise the resulting diffstat is hard to
tell precisely what was removed/added vs simply moved.

If he kept the default behavior, I highly suspect the feedback would
have been along the lines of "please don't sort the result; I can't
tell what moved vs was added or removed."

Perhaps we should add another commit on the series that manually sorts
the results _after_ the automation?

Do we have anything in Documentation/process/coding-style.rst about
sorting headers? There's a blip about clang-format sorting them, but
we don't have strong guidance along the lines of "you ought to sort
your includes (when you don't have special cases like x-macros)."

>
> > +#include <vdso/limits.h>
>
> Just use linux/limits.h.
>
> VDSO is a very special UAPI case. So it's even stricter rule
> than for asm/ for using anything from there.

We can add a special rule for this, Tanzir, please add. And remember
to re-measure the results of that change for this patch's commit
message.

>
> Expected result:
>
> #include <linux/bits.h>
> #include <linux/bug.h>
> #include <linux/ctype.h>
> #include <linux/errno.h>
> #include <linux/limits.h>
> #include <linux/linkage.h>
> #include <linux/stddef.h>
> #include <linux/string.h>
> #include <linux/types.h>
>
> #include <asm/page.h>
> #include <asm/rwonce.h>
> #include <asm/unaligned.h>
> #include <asm/word-at-a-time.h>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Thanks,
~Nick Desaulniers

