Return-Path: <linux-kernel+bounces-16960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B956582468B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAB41C222E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56325112;
	Thu,  4 Jan 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSHdxR+f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FE250F1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336c5b5c163so401409f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704386757; x=1704991557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg07B/b+PmSMf2FD05P3T9dr6e/iVE+Fl7KD2hAHB3o=;
        b=KSHdxR+fHvrHghzjPHY5JgQ9rxXl1a8h/YkP4P8a9svzltts8cMfJAxI6+ygYzxAwJ
         Gq/cWF7S5B2FCAbgmaCohACnQigfG3IGqL/Gjivb3/ogmPX5TRz6bLN9KJhOaoVRjPLp
         ovsJrR0bcQytRp4tVB+536f1rTuLxMtbzAaMpuwuOAl8SkgD36L23NIjCaiMZXQ2i1OX
         5BiFD6cEXPsG2lTHX8WXDxJ4K2kdGc+L4JwLQ36ymN3IdbnVQEffvu9QPbijiA+vq320
         51zc7mEoucaM8EuSzhfGCThDDpcQlPVWkdWoXgLgJwau++zXD8v0HWBVqpj8dr545DXs
         C9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386757; x=1704991557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg07B/b+PmSMf2FD05P3T9dr6e/iVE+Fl7KD2hAHB3o=;
        b=L9T+gLFV18cmEqPkY/INiqeCcYNg3KCwGWxlAisIUV8aAlGj+yTRNkxWRnKncGTQM2
         ifHAYMpAIvNjD8c9asgeD0pFDjqh9icy8K8enPLXK6s/tcuCXnBHSYxnRxxyyf3Yf7eW
         L4k0SLWNv8NXOIubD3LczIhFBaLMkstX/fKPkZU+CyEbgrrQ3QSE1HxEUkPFx4UyLtQo
         zCynljbfvauq8fr9n2P7uo6DUi7NPu363gnYPxaopcje49QG4nH2NHLNejXWGBORTsKd
         MJFf4djOW2VxN4qOqW0sunT1tpKCTg97HwRooLmMseMkm4yZ0MW3ktobsifdUItdtoYv
         rpwA==
X-Gm-Message-State: AOJu0YwQs/Bi7NUcuP6d4EnN8r+fVXX3DrUv8Aao4Af/6m0T2IpaUHe9
	3wV0gUnNdCGCFGUZhWN0k9BSsV8FTzp4rV3diL5tosCWz07z
X-Google-Smtp-Source: AGHT+IFPYq0eI3raaaSjoMhfB3lze8Iq4DULARw0RWc47y1DscUKSAHtO7PITg/8/KpSF8Yph0LCzn71nxt6s+u2saU=
X-Received: by 2002:adf:d1e2:0:b0:337:a2f:a823 with SMTP id
 g2-20020adfd1e2000000b003370a2fa823mr516802wrd.8.1704386756997; Thu, 04 Jan
 2024 08:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-extable-v2-1-6fdcb64abcb2@google.com> <20240104011419.GN1674809@ZenIV>
In-Reply-To: <20240104011419.GN1674809@ZenIV>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 4 Jan 2024 08:45:42 -0800
Message-ID: <CAKwvOdmDh=kAnRVDX-Qhg4KAoPDi7STfU5Ga5f+jZPb8fyyN8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/vdso: shrink vdso/extable.i via IWYU
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tanzir Hasan <tanzirh@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nick Desaulniers <nnn@google.com>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:14=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Jan 04, 2024 at 12:02:40AM +0000, Tanzir Hasan wrote:
>
> *ugh*
>
> > +#include <linux/stddef.h>
> > +#include <linux/types.h>

Tanzir's tooling is pretty neat; it can print //why// certain indirect
includes were made direct.  In this case:

#include <linux/stddef.h>    // for false, true
#include <linux/types.h>     // for bool

So it's kind of sad that the use of bools like this will depend on two
different headers.  Perhaps it's worth making an include/linux/bool.h
header; at least that naming convention would better match userspace C
programming (I feel the same about not having a stdint.h, too).  Also,
one of the more recent C standards standardized bool, so if we ever
plan to move off -std=3Dgnu11, we will need to adjust the kernel's
definitions of bool anyways.  Doing so in one place rather than two
might be nice.  Adding Arnd, who I think looked at that recently
(can't recall precisely).

>
> Do we have _anything_ that would not want stddef.h?  Seriously -
> NULL, true, false, offsetof...   At that point I'd rather have
> it via -include...

No!  No more -include!  That should never have been allowed in the
kernel.  That pessimizes every translation unit which now must parse
those entire files regardless of whether they are actually used or
not.  And undoing the 3 existing ones is going to be painful.  And we
can't even use precompiled headers easily for those because the x86
kernel uses like 3+ ABIs when building different parts of the kernel
image (and precompiled headers need to have the same compiler flags
for the translation unit as was used to precompile the header).

>
> Are we going to spam that include all over the tree?  Because
> it'd really be just about everything...

We could try to take the tact with these changes of "removing as many
explicit header inclusions as possible while still being able to
build," but I strongly recommend against that.  (Some C or C++
projects do take that approach, some explicitly don't)

Basically, if you can scrape by by building with a minimal number of
headers (because let's say one of the explicit includes happens to
already include stddef.h; that's what I'm referring to as an
"indirect" inclusion or dependency), it makes it harder to refactor
headers in the future, since you can end up with build breakages in .c
files due to such indirect inclusions.  If you make your indirect
includes direct (by explicitly including them, like this patch), then
that becomes a non-issue.

If an indirect dependency is made direct, it doesn't change the number
of tokens to parse, assuming your compiler has the header guard
optimization.

And we don't plan to send patches that make every indirect include
direct unless it results in some amount of reduction in code size for
the parser (as is measured in the commit message of this patch).

I don't buy that include lists are somehow an eyesore, but if they
ever got too long, one could make a new .h file just for that one .c
file which contains the full include list such that the .c file only
includes the one newly created .h file.

--
Anyways, it would be nice to retain these 2 headers explicitly.  One
goal of automating this is that the process and results are
reproducible between two different developers.  If we have automation
that tries to help developers avoid indirect dependencies, and devs
manually touch up the results to remove includes (going back to
relying on indirect dependencies), then someone else runs the
automation, that will result in the manual touch ups being undone.
For this file without too many #ifdef CONFIG_FOO's, it's more obvious
what can be made indirect.  But for other larger translation units, I
worry that having such a posture (of favoring indirect dependencies)
will break randconfigs when attempting to refactor headers or include
lists.

My advice; rely on automation and move on.  (I feel the same about
clang-format btw)
--=20
Thanks,
~Nick Desaulniers

