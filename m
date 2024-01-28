Return-Path: <linux-kernel+bounces-41627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9983F594
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA30D282AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19A23763;
	Sun, 28 Jan 2024 13:27:48 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0723748
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706448468; cv=none; b=rLSRsPgEQpcb6UpbdSsKKVc/TLt/MmrbbNw2zlBtSr8A/Zh78+/aTwaOu2+87NE52bQ+dIarWeyHOjMZ6H0YB7b+vMAtekjiBvHvhJ64ZH7o308SAsmQTwbt9xamXmyYNzIHtN6HJ6URRKzAr5xOLBXdI8iq5nqJfVqME0ibuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706448468; c=relaxed/simple;
	bh=69eUiVcVjXP8yf48feB6h5T6KQMxfGOSRyaTvN+mWZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqn7AjzTMTXVqHRKjwGwBWEXLTuQ7bm24HTHiUrsJDTBGLtjXzYLzxOJEurWbsHt/+9SvaGWoVZZxGH+fXu1JStW+m4BmRwffzy6/tKD5m3LJKmZHyNimZgrmB9hHWqLbL9PtszzRzKBroBd6uvw4kI6tiEeTRow0zFl30k62jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29567ec5a6cso90823a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706448465; x=1707053265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBSmUuPziI7/ip1tnYbDPWClv7tgzD2lgVrD1csa1/c=;
        b=uy/6RWqKEyWPpHRA2AGKhSHf2eNwC3dB7lZZozpF1kfkDo8uA7RX1mGtnkSGQhf0Bt
         pQziizwJte7abXUJC84vv/dhKFvRGGD1babJGtrdpvMGv+n3o1fSYHTZg7z+vGAEMaVo
         W2QYwFDwEEhr2aaVlnTST+tGlC08D67VpeWuIJ2MD4LCVqu+oa+zmvgnhkYuOz8CuDp8
         iT4XgKXp6KJKe2Jk+cCEl+8A+n9T4Yy3DPhti4ZgKboOKoDFu7MtPG/YjdfNSO8ScawG
         fASHEyFdYTAm/u4pqm3rEcxf8KEJksTpPFDPrFkKarlli6/ZoOn0UhTGXhJTZnKcyExX
         pk6g==
X-Gm-Message-State: AOJu0YybOPUdnKmgl/WedM1mtZ2MukRnjJmQFpnZFCg/cs7pKIKWOUpK
	9K4yFmDNN7SkRi1QTzNJHPpLHGGvCVR/epA6H74alrA45rU2qAMsVEh1/CRgzv6aTysQ5mvxAsh
	bVjpc95dDPdTeGKq7Rd6wiyXKKgA=
X-Google-Smtp-Source: AGHT+IHW0ZpztywsQvrDPSCwTjVGTYnJgRy2DkCv0hgE9/FYo3FSlfokv9bExQHNddeY613XOZtAJtBw5wKNj+ZPyt4=
X-Received: by 2002:a17:90b:3c8:b0:28d:c2ec:8950 with SMTP id
 go8-20020a17090b03c800b0028dc2ec8950mr4703902pjb.2.1706448465441; Sun, 28 Jan
 2024 05:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
 <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org> <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
 <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com>
In-Reply-To: <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 28 Jan 2024 22:27:33 +0900
Message-ID: <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
To: David Laight <David.Laight@aculab.com>
Cc: Finn Thain <fthain@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Marco Elver <elver@google.com>, 
	Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Sun. 28 janv. 2024 at 21:16, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent MAILHOL
> > Sent: 28 January 2024 06:27
> >
> > On Sun. 28 Jan. 2024 at 14:39, Finn Thain <fthain@linux-m68k.org> wrote:
> > > On Sun, 28 Jan 2024, Vincent Mailhol wrote:
> > >
> > > > The compiler is not able to do constant folding on "asm volatile" code.
> > > >
> > > > Evaluate whether or not the function argument is a constant expression
> > > > and if this is the case, return an equivalent builtin expression.
> > > >
> ...
> > > If the builtin has the desired behaviour, why do we reimplement it in asm?
> > > Shouldn't we abandon one or the other to avoid having to prove (and
> > > maintain) their equivalence?
> >
> > The asm is meant to produce better results when the argument is not a
> > constant expression. Below commit is a good illustration of why we
> > want both the asm and the built:
> >
> >   https://git.kernel.org/torvalds/c/146034fed6ee
> >
> > I say "is meant", because I did not assert whether this is still true.
> > Note that there are some cases in which the asm is not better anymore,
> > for example, see this thread:
> >
> >   https://lore.kernel.org/lkml/20221106095106.849154-2-mailhol.vincent@wanadoo.fr/
> >
> > but I did not receive more answers, so I stopped trying to investigate
> > the subject.
> >
> > If you want, you can check the produced assembly of both the asm and
> > the builtin for both clang and gcc, and if the builtin is always
> > either better or equivalent, then the asm can be removed. That said, I
> > am not spending more effort there after being ghosted once (c.f. above
> > thread).
>
> I don't see any example there of why the __builtin_xxx() versions
> shouldn't be used all the time.
> (The x86-64 asm blocks contain unrelated call instructions and objdump
> wasn't passed -d to show what they were.
> One even has the 'return thunk pessimisation showing.)

Fair. My goal was not to point to the assembly code but to this sentence:

  However, for non constant expressions, the kernel's ffs() asm
  version remains better for x86_64 because, contrary to GCC, it
  doesn't emit the CMOV assembly instruction

I should have been more clear. Sorry for that.

But the fact remains, on x86, some of the asm produced more optimized
code than the builtin.

> I actually suspect the asm versions predate the builtins.

This seems true. The __bultins were introduced in:

  generic: Implement generic ffs/fls using __builtin_* functions
  https://git.kernel.org/torvalds/c/048fa2df92c3

when the asm implementation already existed in m68k.

> Does (or can) the outer common header use the __builtin functions
> if no asm version exists?

Yes, this would be extremely easy. You just need to

  #include/asm-generic/bitops/builtin-__ffs.h
  #include/asm-generic/bitops/builtin-ffs.h
  #include/asm-generic/bitops/builtin-__fls.h
  #include/asm-generic/bitops/builtin-fls.h

and remove all the asm implementations. If you give me your green
light, I can do that change. This is trivial. The only thing I am not
ready to do is to compare the produced assembly code and confirm
whether or not it is better to remove asm code.

Thoughts?

Yours sincerely,
Vincent Mailhol

