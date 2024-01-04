Return-Path: <linux-kernel+bounces-16761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88142824371
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3B1C21E74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52062224F8;
	Thu,  4 Jan 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJtyqJQx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1123224E8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704377849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1UIyHlxDpmjDXM7x4EJy2xqSUJiPyiytLAbTr6bgp0=;
	b=VJtyqJQxLKtxBS2SVfYiCgfhjEJ9Cznaia0sPjN93ddnhV7uEtH54pnWuOv1d0lHGTNGxI
	uLRe/iqojPwEHSXEYYlHm5qtRPAzOgPVEMeMST7gmW9wKDiMpfsyCzwbgPnWaRlVUsx28H
	dZFHI1FD8G4NIjliEdw1YSPXN+PQkIk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Sa2Jt_cKP9qOy3H9xqYNkA-1; Thu, 04 Jan 2024 09:17:27 -0500
X-MC-Unique: Sa2Jt_cKP9qOy3H9xqYNkA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28b88d79b87so405436a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377846; x=1704982646;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1UIyHlxDpmjDXM7x4EJy2xqSUJiPyiytLAbTr6bgp0=;
        b=ZKlv/VWdpMnj+qKZBJ31qeGQKnZJQWYNIuVX40Tl8LMiSRs8SgUrdS99GtL3uEmwZL
         4chon6zXzKbKMPgEz+LIUgR3axx9FxkRu6t8xII9sIR24N6MuELuXT/iwbGcMOSaQab0
         EAGdiqtA9yOfdzOVDdY9cArctzpYA7HTtaf6iGg+wIH4ZGC8IlpV7boSqRT6jJhBp5qE
         xbVCDCD0e7nGbK+gcTzTsQh8J+R9tzEiUAqWtx8xpefR7DaTDRUpLa687CJTFzndLOhR
         nOh2tTqbo7Care9ZM4ODdo4IA9x6NzTR0A8tZg4ErFQPxS+Fu9JjU1odrnYNNWCpZU23
         eX+g==
X-Gm-Message-State: AOJu0YwgCKjD6IVdFc2xsAd+q8fRBZOc4LCvapfQL6glwouIUxmzTywL
	d+DP1ZZWdEvSe/v5WX/ba9sc5lNdffZQi+dYySM0XZkjyifCSS1Tc6q5+Cx/BdYSYhN+bOT0nsd
	F2T+zfmF6mZx5u/1ddOrtfrdlm/qWWNOm
X-Received: by 2002:a17:90b:1281:b0:28c:137e:7a42 with SMTP id fw1-20020a17090b128100b0028c137e7a42mr506139pjb.2.1704377846128;
        Thu, 04 Jan 2024 06:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFhAuWGZ4F60Z7Iykwt9+suh/7YYZ8D8SvbeW+ZOfVpM5xAsWh6B+BCTKPnsJn6HjrKW5gQA==
X-Received: by 2002:a17:90b:1281:b0:28c:137e:7a42 with SMTP id fw1-20020a17090b128100b0028c137e7a42mr506116pjb.2.1704377845743;
        Thu, 04 Jan 2024 06:17:25 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3b60:7b8a:588b:5256:ce57])
        by smtp.gmail.com with ESMTPSA id er14-20020a17090af6ce00b0028be4e9b0a5sm3728103pjb.28.2024.01.04.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:17:25 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for sc.w
Date: Thu,  4 Jan 2024 11:17:12 -0300
Message-ID: <ZZa96DEQhYnnGi51@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTTT8QBEKtKOpriF=c8Y3g5MmM23MZxN7JCa65MbKeKNOQ@mail.gmail.com>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org> <20240102-81391283df04c430d76c0eb0@orel> <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com> <ZZW5Y85OdibCu58h@LeoBras> <CAJF2gTTpi5A+9KP5EyH9qhD_fwuZrWpx6zdCJyG+iv0Ez5q-gw@mail.gmail.com> <ZZYsdyKx8kmoDBGB@LeoBras> <CAJF2gTTT8QBEKtKOpriF=c8Y3g5MmM23MZxN7JCa65MbKeKNOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 04:14:27PM +0800, Guo Ren wrote:
> On Thu, Jan 4, 2024 at 11:56 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Thu, Jan 04, 2024 at 09:24:40AM +0800, Guo Ren wrote:
> > > On Thu, Jan 4, 2024 at 3:45 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > On Wed, Jan 03, 2024 at 02:15:45PM +0800, Guo Ren wrote:
> > > > > On Tue, Jan 2, 2024 at 7:19 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > > > >
> > > > > > On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote:
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > The cost of changing a cacheline from shared to exclusive state can be
> > > > > > > significant, especially when this is triggered by an exclusive store,
> > > > > > > since it may result in having to retry the transaction.
> > > > > > >
> > > > > > > This patch makes use of prefetch.w to prefetch cachelines for write
> > > > > > > prior to lr/sc loops when using the xchg_small atomic routine.
> > > > > > >
> > > > > > > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
> > > > > > > prefetch the destination word for write prior to stxr").
> > > > > > >
> > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > > > > > index 26cea2395aae..d7b9d7951f08 100644
> > > > > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > > > > @@ -10,6 +10,7 @@
> > > > > > >
> > > > > > >  #include <asm/barrier.h>
> > > > > > >  #include <asm/fence.h>
> > > > > > > +#include <asm/processor.h>
> > > > > > >
> > > > > > >  #define __arch_xchg_masked(prepend, append, r, p, n)                 \
> > > > > >
> > > > > > Are you sure this is based on v6.7-rc7? Because I don't see this macro.
> > > > > Oh, it is based on Leobras' patches. I would remove it in the next of version.
> > > >
> > > > I would say this next :)
> > > Thx for the grammar correction.
> >
> > Oh, I was not intending to correct grammar.
> > I just meant the next thing I would mention is that it was based on top of
> > my patchset instead of v6.7-rc7:
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >  ({                                                                   \
> > > > > > > @@ -23,6 +24,7 @@
> > > > > > >                                                                       \
> > > > > > >       __asm__ __volatile__ (                                          \
> > > > > > >              prepend                                                  \
> > > > > > > +            PREFETCHW_ASM(%5)                                        \
> > > > > > >              "0:      lr.w %0, %2\n"                                  \
> > > > > > >              "        and  %1, %0, %z4\n"                             \
> > > > > > >              "        or   %1, %1, %z3\n"                             \
> > > > > > > @@ -30,7 +32,7 @@
> > > > > > >              "        bnez %1, 0b\n"                                  \
> > > > > > >              append                                                   \
> > > > > > >              : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))       \
> > > > > > > -            : "rJ" (__newx), "rJ" (~__mask)                          \
> > > > > > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)         \
> > > > > >
> > > > > > I'm pretty sure we don't want to allow the J constraint for __ptr32b.
> > > > > >
> > > > > > >              : "memory");                                             \
> > > > > > >                                                                       \
> > > > > > >       r = (__typeof__(*(p)))((__retx & __mask) >> __s);               \
> > > > > > > --
> > > > > > > 2.40.1
> > > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > drew
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best Regards
> > > > >  Guo Ren
> > > > >
> > > >
> > > > Nice patch :)
> > > > Any reason it's not needed in __arch_cmpxchg_masked(), and __arch_cmpxchg() ?
> > > CAS is a conditional AMO, unlike xchg (Stand AMO). Arm64 is wrong, or
> > > they have a problem with the hardware.
> >
> > Sorry, I was unable to fully understand the reason here.
> >
> > You suggest that the PREFETCH.W was inserted on xchg_masked because it will
> > always switch the variable (no compare, blind CAS), but not on cmpxchg.
> >
> > Is this because cmpxchg will depend on a compare, and thus it does not
> > garantee a write? so it would be unwise to always prefetch cacheline
> Yes, it has a comparison, so a store may not exist there.
> 
> > exclusiveness for this cpu, where shared state would be enough.
> > Is that correct?
> Yes, exclusiveness would invalidate other harts' cache lines.

I see.

I recall a previous discussion on computer arch which stated that any LR 
would require to get a cacheline in exclusive state for lr/sc to work, but
I went through the RISC-V lr/sc documentation and could not find any info 
about its cacheline behavior. 

If this stands correct, the PREFETCH.W could be useful before every lr, 
right? 
(maybe that's the case for arm64 that you mentioned before)

Thanks!
Leo

> 
> >
> > Thanks!
> > Leo
> >
> >
> > >
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


