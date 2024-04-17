Return-Path: <linux-kernel+bounces-148906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDD8A88CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F6C1C21776
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D236148FF6;
	Wed, 17 Apr 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWTqY4Ev"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF74147C9E;
	Wed, 17 Apr 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371077; cv=none; b=pmzte0hgkIDyhT+JTsuJsAUwwqHUN3gKv2tfKnIJc24WfO0dh40LfSHO+P5EGTPK0LRhigliFqnHAHtGV3WVz6h6uulr+/8mZ3QrVaVo60QGu0l+ITOpY01wkBO92rOqwg1cvL0uqeX6zmmW2sQEpqHwtReXbm0Cmsc2oY40kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371077; c=relaxed/simple;
	bh=eFcR1ClTRCzhSOvXK9etsUGvcNigPYVMTluCVcHakAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4BFo5N/6VJSeOH1o5bhEEmAVpPzaDdlnLmzIaJvw4nEUO3bxVpgKmlDO36wWyVUK7+VtkCv3T7eXyUmrn7boJNo3gkJrmmoX8Ys8mf4T4ecQZri9xQdQ6wmdtRQlGoXcJk0O4GlKgo0xwE5FNWTojyXO1HuzUlhILGMVowP9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWTqY4Ev; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso43854811fa.3;
        Wed, 17 Apr 2024 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713371074; x=1713975874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WOI+RzbMVLEsygvuyMdeIyAFatAUtSWu8oi4PGxMg4=;
        b=CWTqY4EvmZfh0gz3nO6YYi982v2q20hZ23/oHoOn/+b3BaGNFSb3p3aRHGm7YzY59U
         usV6xOr0E0rSRguwVtvoURd3bbfa2mA3Ug+e9KjmCtxnwwyZmpaC9FzQ4RGgTGxI+Zgr
         +4P4kv1US9FEX3E8b8tcErpj5+2XRHnxbhIXZlBf5NgM5Qg6evyNWd0r8jA/Swyc1lcR
         /jaGqEqUyFXDS8dUlFons6tEAGPeBIFDMnjbkzJI5mPnihedYtDym8o9sEUDpKMu+HTr
         9fqxB1kRRupqZmNmvwBXNrCfQm8fqA2bX9lTEjxMYB8Z0fCeXR9nLgANfqXESIe4E9Hv
         8iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713371074; x=1713975874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WOI+RzbMVLEsygvuyMdeIyAFatAUtSWu8oi4PGxMg4=;
        b=fsi2ucBI/bUv5QZoFbpxVPbddK2hbfti5ZJgt8IQaaw4PWTNTgOMuFheqJGp6A5OcG
         gr+B0rnJMGh/yE232twVYF28PCn/DAFiqO6Es/YFXYhAQGJoymwuIT7uprZEIXnMJ3gX
         mX9EVp7oq0+vjfAm/W7idnyKEPpGDOelrsmELMY0h5xsy+AoEse5mGMLfM6NS7JMiFrv
         f7iVEaUSVkbD1PsUA574MCmBSheDBC4wNVfTleTmArQkVsTKZTClpAYtpT9Se2ufLiH+
         HgM5w90GLKAk60BHr9L5FgS7IwNXhpWYSutCb3rPGn1OuIVIPABemBsACn+aEWtGch5k
         ts9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTNgK2ecaRinWrknp5+c1VdI5KDRO7eeNNRcEc7XbeuAv6pRh4R0E7Tds9r3vdtKAVKRTlFfJucmla8UyVMEGr31h0lm3k6FlMifbUiHAELYo=
X-Gm-Message-State: AOJu0Yxwo0I5U1dfHz99C6o5qQShh8lCAn/XvcHjhyJ0UCkaTDAeQZO/
	NCFDh6wAN4UpEpFiY+OdUpecJgPuwMCFs/GtD1LVMwg74FPsc7ajkxJMeOcr8PSRnmYYOyXA8Qp
	6Zhtz51tbGu31Jwus9UgPIXOrG/c=
X-Google-Smtp-Source: AGHT+IFQnHGsRMwv4AUxL+R7AzcZf67YjifD3w2HzOOsEdI4u6wAr+JO4jdO7/yunKcXRQ6CZYzHkIhvHuKgv1BdLgk=
X-Received: by 2002:a2e:9c4f:0:b0:2d8:408c:3f5b with SMTP id
 t15-20020a2e9c4f000000b002d8408c3f5bmr11619304ljj.5.1713371073507; Wed, 17
 Apr 2024 09:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414161257.49145-1-ubizjak@gmail.com> <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>
 <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local>
In-Reply-To: <20240415201119.GBZh2J57f3aouPE_JR@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 17 Apr 2024 18:24:21 +0200
Message-ID: <CAFULd4aFSBHNxyVyVt9soPnJXDgiOu6qCCNMLoenFNXtk0W4wA@mail.gmail.com>
Subject: Re: [tip: locking/core] locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Waiman Long <longman@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:

> > locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
> >
> > Introduce arch_try_cmpxchg64_local() for 64-bit and 32-bit targets
> > to improve code using cmpxchg64_local().  On 64-bit targets, the
> > generated assembly improves from:
> >
> >     3e28:     31 c0                   xor    %eax,%eax
> >     3e2a:     4d 0f b1 7d 00          cmpxchg %r15,0x0(%r13)
> >     3e2f:     48 85 c0                test   %rax,%rax
> >     3e32:     0f 85 9f 00 00 00       jne    3ed7 <...>
> >
> > to:
> >
> >     3e28:     31 c0                   xor    %eax,%eax
> >     3e2a:     4d 0f b1 7d 00          cmpxchg %r15,0x0(%r13)
> >     3e2f:     0f 85 9f 00 00 00       jne    3ed4 <...>
> >
> > where a TEST instruction after CMPXCHG is saved.  The improvements
> > for 32-bit targets are even more noticeable, because double-word
> > compare after CMPXCHG8B gets eliminated.
>
> Ok, maybe I'm missing the point here or maybe the commit message doesn't
> explain but how does this big diffstat justify one less insn?

We are dealing with locking primitives, probably the hottest part of
the kernel. For 64-bits, the patch is effectively a couple of lines,
reusing and extending existing macros, the line count for a modern
32-bit target is also a couple of lines, but there the saved insn
count is much higher, around 10 instructions.

What bothers you is the line count of cmpxchg8b emulation, necessary
to handle !CONFIG_X86_CMPXCHG64 targets. They are still alive, and
cmpxchg8b emulation code was recently improved (not by me!) to
correctly handle the ZF flag. The added code just builds on that.

> And no, 32-bit doesn't matter.

Really? Was this decision reached by the community consensus?

The linux kernel has many uses, and using it for servers by a big
company, you are the voice of, is only one part of the whole picture.
I'm sure that 32-bit is quite relevant for embedded users and more
than relevant to a student or an enthusiast in some remote part of the
world. As a maintainer, you should also take care of the communities
that are somehow neglected, where unilateral decisions like the one
above can have unwanted consequences.

> This looks like too crazy micro-optimization to me to be worth the 40
> insertions.

If the line count is the problem, I can easily parametrize new and
existing big macro descriptions in a follow-up patch. However, I was
advised to not mix everything together in one patch, but rest assured,
the creation and testing of the follow-up patch would take me less
time than writing the message you are reading.

> But I could be wrong and I'd gladly read explanations for why I am.

I would understand if someone asked you to write some new
functionality for a seemingly obsolete target. Everybody would
understand your rejection. But this improvement was written by me in
my time, and demonstrated some benefit to the existing code. The patch
is almost trivial and it took maybe 5 minutes of the maintainer's time
to approve it. It brings no future maintenance burden, but it perhaps
improves someone's life a tiny bit.

Last, but not least, I'm bringing some ideas from the compiler
development community, where the attitude to redundant instructions is
totally different. It could take weeks of effort and considerable
rewrite of compiler functionality just to remove one instruction ;)
Micro-optimizations add up!

Thanks for reading this,
Uros.

