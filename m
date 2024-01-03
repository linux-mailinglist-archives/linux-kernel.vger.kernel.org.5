Return-Path: <linux-kernel+bounces-15920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9798235AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB515287317
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928DE1CFBC;
	Wed,  3 Jan 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmH2hjhT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41D1CA8C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so10080033f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704310611; x=1704915411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtOCSs+zS7pCxIWPYL0byeaqRdSRUhQEohn2x6Wrgag=;
        b=QmH2hjhT0sUYoZb9U3dk9d0TNxx+A44rPhjyot1FRy8C3w5VntOw4ODCxFQXOE3P4p
         TiZfrSck4S1sG+a9R2QqwT6tuo7BqlARI6O91IfuC9Vq2h/4JG28rm7Fum3JLm6QU4u+
         9tY7h1Q7FhRWKT5e8bou+yzU7LvCBRPIavmQ/le6aINUab2cl0KCG9oQaX8/9/PHwCVp
         fNRpkunDN6b0tovviTWpbQW1OK2h4w3gEVnZt5Jw1DW3VCUKiLjdI4VlqRsUmkBwtywh
         4WODGI4ebVYs4xZtm1/puTGMiSKw496YP/y0xh5tGRohD51BmxobBXbN+3gyOJiDnXmR
         kUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704310611; x=1704915411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtOCSs+zS7pCxIWPYL0byeaqRdSRUhQEohn2x6Wrgag=;
        b=bHoe24ZNhWlW5HyS8jxKWeSWm0tcrBKzD5qvbzuYJkQO6ZAgBq0ANFfs5i7RS3K51u
         cKuCz2WyVYL0mWpsw1oOQilULZLEsokJI5Yomy4yJ0Qq5hMWPeQAOlIHRD0/TKL9mLCZ
         Ic6zCo4ybDUTFBqOQ26w9BGx1iBW+/hfNV0wxJWWX4yZCxB7fzYIQw24j9zqLXs/jSW9
         2OeJnqa4iOEwpYas5DEsCvHmZ60eIeHCnyAsENRH+iIrFd3UfQU8uTlO+XnatTDvdOpa
         gYIWm2G/QOklyoEhIqx+JPeXEUNCL0KpezaMUPdzfLePZqU2k/19f8jPx62js/at1qY1
         C+lg==
X-Gm-Message-State: AOJu0YxQD7bRYBVcgbfCeFwZDB5wSqdE33xKoURnA00B1dPnpkQDQSEG
	hm1sytGcmoW8J5MksCtn53GfRJxXVkynFtCV+ooEVLR02a9T
X-Google-Smtp-Source: AGHT+IHPdS2RG0NHG8BUbvx6wZODqbbNqX9sf6ycjjQEY8K0jSs88XfOA68pFnw5LnaGyF5XFM9wJuOGUnqJixBxaJ0=
X-Received: by 2002:adf:a4dd:0:b0:336:6c32:12e7 with SMTP id
 h29-20020adfa4dd000000b003366c3212e7mr6368231wrb.72.1704310610701; Wed, 03
 Jan 2024 11:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228-extable-v1-1-32a18c66b440@google.com>
In-Reply-To: <20231228-extable-v1-1-32a18c66b440@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 3 Jan 2024 11:36:39 -0800
Message-ID: <CAKwvOdnZPo9FvMtB5jxg9bt5t3BtirzZw92CgrtJuDqVfBNH_Q@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 12:56=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> =
wrote:
>
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
>
> This change to vdso/extable.c resulted in a preprocessed size of
> vdso/extable.i from 64332 lines to 45377 lines (-27%) for the x86
> defconfig.
>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  arch/x86/entry/vdso/extable.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.=
c
> index afcf5b65beef..8221231917ec 100644
> --- a/arch/x86/entry/vdso/extable.c
> +++ b/arch/x86/entry/vdso/extable.c
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/err.h>
>  #include <linux/mm.h>

^ I think we can get more aggressive about avoiding linux/mm.h even.
I think you could replace linux/mm.h with

#include <linux/mm_types.h>  // for mm_struct, mm_struct::(anonymous)
#include <asm/mmu.h>         // for mm_context_t

assuming it's ok to include asm/* files in .c files under arch/* (more belo=
w).

> +#include <linux/sched.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
>  #include <asm/current.h>
> -#include <asm/traps.h>
> +#include <asm/trapnr.h>
>  #include <asm/vdso.h>
>
> +struct pt_regs;
> +

^ This forward declaration shouldn't be necessary and looks wrong;
pt_regs is not used as an opaque type in this TU.

What I suspect is happening:
1. debug output from your tooling seems to think pt_regs should come
from linux/ptrace.h.
2. your tooling has a rule to replace recommendations for asm/ptrace.h
with linux/ptrace.h.  I may have misunderstood Al's point in an
earlier thread; perhaps it's ok to use asm/*.h in .c files under
arch/*/, but linux/*.h should be used everywhere else?  If that's the
case then perhaps we can break up that table such that asm-generic/*.h
-> asm/*.h is one table that's always used, and asm/*.h -> linux/*.h
is another table that's conditionally used when the .c file is not
under arch/*/?

To avoid pinging maintainers too many times, why don't we do an
internal code review for v2 before sending it publicly?  I appreciate
you making progress by sending a v1 while I was on holiday; for v2,
let's review internally first.
--=20
Thanks,
~Nick Desaulniers

