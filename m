Return-Path: <linux-kernel+bounces-5985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05801819282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A17B24FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3313C46E;
	Tue, 19 Dec 2023 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixkhdDCP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAF3B194;
	Tue, 19 Dec 2023 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67ee17ab697so39276186d6.0;
        Tue, 19 Dec 2023 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703022498; x=1703627298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1JR2619YMG5mo1u6s9CGtT+m7a20YcNHq4R9VhkzMY=;
        b=ixkhdDCP4RnxpzsQK2x09S32X3/9FaX5/m88WERcvoWDEiWgc/432tr+iVV6mI5zpT
         AyuoT0NwPsZMrpbEz0M+FYhToRKOrtzFyjAc5zrfjiP5qh0KVRi+v+QQis8Uov1wZuA3
         VlcPIakQZrmOt4uWACxq5AIbKZjFMsHreCWVvVmV3TVnDA+2xjBMFJb/bKOyKJN33mhY
         2+BFvoBRwZDht89RRXaZjeiW9SIb9EZNQMOgpvxYU4/0SIrzUAJlAOw3Y2kI/dvsZXX9
         gVF1e3SDeaZV60mw8GvqJW8z4USMos/79ESotR9C3iyzVLm+aVlr6zQ7dCz9T50ET+lZ
         7Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022498; x=1703627298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1JR2619YMG5mo1u6s9CGtT+m7a20YcNHq4R9VhkzMY=;
        b=Ft0YLNtQu3hg8EInzFG4u2oe6uW57fKarB6RcmaxdoO2EY/RNKxn4g4FhdSm9xsxbB
         y9mNP9oXnE43kWML86Um9FLQ3dxOFpQmknI/ys8b3kCdyzS/uh+mRWcG7MUvNUeVcVTn
         oCWw3yibK2LaxlBAUJex6Z8ealFA4GoY2oQuqtPOnjzKLck3tGn3l2pM7IKmyT4HBGy/
         ef5SDKzWXZmfxWYWnL5DQuhRHEkf8fsGxe+1yq2VzHHTG9Bpv58MGTS0dk9LAN6d9Zy6
         TZgcE9ZpSR3e6SbvewqSm4Ia18l3KbUeg6rX0TB6fIXncHU8sfNQCkKsXjbW2fOYg6MN
         wEnw==
X-Gm-Message-State: AOJu0YzWaBYmrxxFt7Cjlf5AOvROGpbbZBrEr6J/8c/6QjlLJLlD1PMb
	TevJD1X9pcUUojxNKYX+eM6JKglHvN705l3GIP4=
X-Google-Smtp-Source: AGHT+IEuvOxivrGVKXoBh8W4o6i+lQHNJN5ZZNaEp5+HZ5Cw1Mu1UB3uQjBUlayK5Rax9O7HaOG6biGrh8l54QSI5PE=
X-Received: by 2002:a05:6214:1c09:b0:67f:30ad:26c0 with SMTP id
 u9-20020a0562141c0900b0067f30ad26c0mr7483675qvc.55.1703022498521; Tue, 19 Dec
 2023 13:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com> <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
In-Reply-To: <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 23:47:42 +0200
Message-ID: <CAHp75VdCb7FX31LkaJg3+a6mttvRGECPt6JS9fNp0SCxqbuqJQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:10=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> w=
rote:
>
> This patch creates wordpart.h and includes it in asm/word-at-a-time.h
> for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h

for all

("all" doesn't go with article)

> because of REPEAT_BYTE. Moving this to another header and including it
> where necessary allows us to not include the bloated kernel.h. Making
> this implicit dependency on REPEAT_BYTE explicit allows for later
> improvements in the lib/string.c inclusion list.

...

> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h

> -#include <linux/kernel.h>
> +#include <linux/wordpart.h>

No, please, read what I told you carefully.

...

> --- a/arch/x86/include/asm/word-at-a-time.h
> +++ b/arch/x86/include/asm/word-at-a-time.h
> @@ -3,6 +3,7 @@
>  #define _ASM_WORD_AT_A_TIME_H
>
>  #include <linux/kernel.h>

No, the macros used in this file doesn't require (after your patch)
the kernel.h, these are in particular in asm/asm.h and
asm/extable_fixup_types.h. I haven't looked at this closely to find a
common header that kinda guarantees those two to be included.
Otherwise we can use them directly.

> +#include <linux/wordpart.h>

...

>  #include <linux/init.h>
>  #include <linux/export.h>
> -#include <linux/kernel.h>
> +#include <linux/wordpart.h>

Try to keep it more or less ordered. At list with given context it
goes either after the slab.h or below (after those starting with 'f').

>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/filelock.h>

...

> --- a/include/asm-generic/word-at-a-time.h
> +++ b/include/asm-generic/word-at-a-time.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_WORD_AT_A_TIME_H
>  #define _ASM_WORD_AT_A_TIME_H
>
> -#include <linux/kernel.h>
> +#include <linux/wordpart.h>
>  #include <asm/byteorder.h>

Same as in the above remark, read what I said in the previous round of revi=
ews.

--=20
With Best Regards,
Andy Shevchenko

