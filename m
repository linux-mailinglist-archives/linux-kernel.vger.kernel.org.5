Return-Path: <linux-kernel+bounces-108926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA45881214
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D71F23851
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA4040877;
	Wed, 20 Mar 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFo+KMnu"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781F3B185;
	Wed, 20 Mar 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940350; cv=none; b=Cyjwct/MYPuDwCL0L3FfNBRp97aXX24uJ4hWt1EaOrjZWjGP8Pb2diT9PRVLhbBra4wHchmjDm+2aRklDYtuj4Mx1aIHN/6W1FJqFTbaaxmYarGz4Yt6MVuMmwTokclOfPVFEjUwo6IUqI5HptQ7Uc8WqksTJ9D22a4fefCuEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940350; c=relaxed/simple;
	bh=IvTX9esV4P4La+jMPHTzyI2Iu053Bz2GjxkeKu1Aqwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9jokY9DwsrWtEvdoJ5u3u3G2W9tg8yaYPF/uXsDfefIAY5DApE9BKI20Mg4ZoAPWGif1si3Y0nO0Q4GWfVGrRhbbacE4vn2Wv0Ma869qSxq/oRZejw8/Vh5BvRAfv8FbSVlb3+vqPnBRPFDHyiaxzQfYZOmbJgc38K7l9ISGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFo+KMnu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d485886545so111753131fa.2;
        Wed, 20 Mar 2024 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710940346; x=1711545146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogeDDNddqM9zHY2Gjf+myE4/yQB3YtKUwvsl5I4eJwQ=;
        b=nFo+KMnuFX/bwT+UZGcY0v819iuM+akTsVvq0L0NAiDhW6dhcE9OTewEONbv4kjCGO
         QAWv8fmEQpKzMa9OUUQ0jG2+FSTSGloQjRZ2XVdTF47nSbhxKsPllLQVWrReFMU0CFWX
         5KkmE7uSvFGyQQbYL9WeSsjxZVU1WpYFMPTkyJsoJGtPD8xWauZs2NefrDCLmkx11pyw
         BgGvv5HIEQ5zW0jpBZX4ympey+RnG2haUloVFxsga0F89ZdmzlfKaYC/gqUL1WIVBB7t
         JMPuZn2fuaEhCQsBmCzDSatc/ZG01adk7XWh3zCfzN2LIWFkUVF8UpqURqmoxT0WE96y
         OJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940346; x=1711545146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogeDDNddqM9zHY2Gjf+myE4/yQB3YtKUwvsl5I4eJwQ=;
        b=u7q8lNlCHUlrvM3tnK0iA1/shQf4TASFfQAm25UiUyBhe0Y3s8Kcz+xFiVPJkBpRNE
         3SUwba8dJiuyVQTNziQms8fUYGVcGyhtRnM+9bjptyi4aV++H8eO6giJqRQb76E8KlZA
         2sRnjiQhbNo+Zm+m465ikV3T5tpCK0mEGSUr7+TozZG/B28hS9aY25jf1QZQMFbTuSxq
         FynHrTqzZ+c+A8qqM0oSEUsXbasfo1P0O3Rkd723K/eVbUjWLlIxFMwkd1Ae1bZ39/CA
         gD8MYKL2Mw7EueI6bwN5MfLEZI4T/9REX7xW9PlNXwR4do7EBRF03iCvar04gztqVV9x
         jrnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/oK2/t7OekWg2f6A33j2K2VrmjO59+tWsl0FxJuUnNqjWOvihEBwLMN2YaOC1IyWVJlZvTt8IsedPoyHiVhdb1kUYqrHcF4gOg8T9nT/Rcc4=
X-Gm-Message-State: AOJu0Yw8pAO1DFGZ0G37RMTBFb3KITlkAeBiN4p+dPrZCBK63OgxtpYh
	SN283zKZQmMiRbmGps+VALZzFA1zaThubnowwV4vGy0tYezF2PmT4GBTw3iTsY7riJ4/y5OmHGv
	9iSKM0tCsNEGCkrvmqXO24DMlzWM=
X-Google-Smtp-Source: AGHT+IFq9EmS3s1YLRlHzEWYMzaLV2xDhvfREZxkCVd/HKsRFiqxou7BzExgzvocaJsNz1FqdGGhG/nrH+rAULxv+oI=
X-Received: by 2002:a2e:bb82:0:b0:2d4:6bab:15eb with SMTP id
 y2-20020a2ebb82000000b002d46bab15ebmr9202499lje.12.1710940346206; Wed, 20 Mar
 2024 06:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320083127.493250-1-ubizjak@gmail.com> <171093476000.10875.14076471223590027773.tip-bot2@tip-bot2>
 <ZfrMcyZXCBQD/sE8@gmail.com>
In-Reply-To: <ZfrMcyZXCBQD/sE8@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 20 Mar 2024 14:12:14 +0100
Message-ID: <CAFULd4bNETbtP3VTGao4o3mtfpw6d=rhcWp5N+pnzp-f3fjXAw@mail.gmail.com>
Subject: Re: [tip: x86/percpu] x86/percpu: Convert this_percpu_xchg_op() from
 asm() to C code, to generate better code
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:45=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de> wrote:
>
> > The following commit has been merged into the x86/percpu branch of tip:
> >
> > Commit-ID:     0539084639f3835c8d0b798e6659ec14a266b4f1
> > Gitweb:        https://git.kernel.org/tip/0539084639f3835c8d0b798e6659e=
c14a266b4f1
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Wed, 20 Mar 2024 09:30:40 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 20 Mar 2024 12:29:02 +01:00
> >
> > x86/percpu: Convert this_percpu_xchg_op() from asm() to C code, to gene=
rate better code
> >
> > Rewrite percpu_xchg_op() using generic percpu primitives instead
> > of using asm. The new implementation is similar to local_xchg() and
> > allows the compiler to perform various optimizations: e.g. the
> > compiler is able to create fast path through the loop, according
> > to likely/unlikely annotations in percpu_try_cmpxchg_op().
>
> So, while at it, there's two other x86 percpu code generation details I w=
as
> wondering about:
>
> 1)
>
> Right now it's GCC-only:
>
>   config CC_HAS_NAMED_AS
>           def_bool CC_IS_GCC && GCC_VERSION >=3D 120100
>
> Because we wanted to create a stable core of known-working functionality.
>
> I suppose we have already established that with the current merge window,
> so it might be time to expand it.

Please note the KASAN incompatibility issue with GCC < 13.3. This
issue was fixed in the meantime, so I have posted a patch to re-enable
the named AS feature for gcc-13.3+ [1].

[1] https://lore.kernel.org/lkml/20240320124603.566923-1-ubizjak@gmail.com/

> Clang claims to be compatible:
>
>   https://releases.llvm.org/9.0.0/tools/clang/docs/LanguageExtensions.htm=
l
>
>   "You can also use the GCC compatibility macros __seg_fs and __seg_gs fo=
r the
>    same purpose. The preprocessor symbols __SEG_FS and __SEG_GS indicate =
their
>    support."
>
> I haven't tried it yet though.

In the RFC submission, the support was determined by the functional
check [2]. Perhaps we should re-introduce this instead of checking for
known compiler versions:

+config CC_HAS_NAMED_AS
+ def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC)
-x c - -c -o /dev/null)

[2] https://lore.kernel.org/lkml/20231001131620.112484-3-ubizjak@gmail.com/

> 2)
>
> Also, is the GCC_VERSION cutoff accurate - are previous GCC versions
> known-buggy, or was it primarily a risk-reduction cutoff?

This approach was chosen from our discussion [3]. The version cutoff
is arbitrary, it was later set to gcc-12.1, because it is the version
of the compiler you used at the time ;) I have also tried gcc-11 and
gcc-10 in the past, and the compiler produced bootable image. Saying
that, the usage of named address spaces in the kernel is somehow basic
(from the compiler PoV), so I think we could try the above approach
with the functional check and see if and what breaks. We can always
disable the USE_X86_SEG_SUPPORT config variable for known bad compiler
versions.

[3] https://lore.kernel.org/lkml/ZRwZOtANkcwtL+5B@gmail.com/

BTW: Related to percpu series is the patch that fixes the issue with
%rip-relative addressing for PER_CPU_VAR in BPF. IMHO, this issue
should be fixed before rc1, otherwise call thunks will be unusable
with BPF.

[4] https://lore.kernel.org/lkml/20240316232104.368561-1-joanbrugueram@gmai=
l.com/

Thanks,
Uros.

