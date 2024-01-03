Return-Path: <linux-kernel+bounces-15931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48578235C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7581C24389
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA511CF90;
	Wed,  3 Jan 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWDNfOW2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30261CF80
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704311156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN23VlrrOb22VS37aOVQIQ8RkupXeUp9J0UVd6x/4lk=;
	b=cWDNfOW2TBczlMX9CW2JZU1FjcujdQdK77v7pIOyFNOsGi0Oj+d8nDbpQlNkAgwbDkGQ+A
	yYhaMSNK2W0VBs7W8sRiQrUDWbq2YkfK/JWKueGn3V2vOENFB6kXAQyOXbOWpQKfVyupax
	ya+V5K/qaIshTJlO+A/jcUmbJhZj+e0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-aY8nSd17PF-8BUchSBetDQ-1; Wed, 03 Jan 2024 14:45:55 -0500
X-MC-Unique: aY8nSd17PF-8BUchSBetDQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d4c36e9507so13348205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311154; x=1704915954;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MN23VlrrOb22VS37aOVQIQ8RkupXeUp9J0UVd6x/4lk=;
        b=llPO4/2Hw+xFRkr1SsaI8M3Z0CTM30gukSXqfvOvZHK6eGvtFpjg+i7iH92DZ7rrK4
         Y4KwvNAW7fzca85hspGj13lX7XEyKsBOilDokc5mL+dZrwRsWsTCh1AAMDJTssGf868k
         UYRwCLhrC6ENToyqybQsRuO0JeVyNkYYNYesrvltUm2ZrJ/kXGMHX/pACJqCB+ARzD8Y
         rqlqJ9F0GRC+hoyI09+6j/du3hOX05QrEKiKUMBzqPxo5fHIfTpqr5FxdsTbp4GL2u0l
         T2EyoQWfso9CqLNdLhSJzYNTQbaK+kNN2FPtvD64nbV75rDuPH4fFa0cT11FfXEMpOx3
         wrfQ==
X-Gm-Message-State: AOJu0Yzm5bmEHdvOVUQCUYdfJkUiz74slqd6q968rX/ZXe/hr7ZUkpEb
	VT4VlM1g5Azb9Ywm1XlsfsK/tnQHG8Jd5q3YHJ1+DjaFkYuLBl7WmUjYaudYBCcOxOYQKzpURZf
	eN995uYUdUAYvHaH6D6rRVfsWbtQiuZid
X-Received: by 2002:a17:903:192:b0:1d4:2d8d:3537 with SMTP id z18-20020a170903019200b001d42d8d3537mr9435133plg.44.1704311154372;
        Wed, 03 Jan 2024 11:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVTkymOGkrkQkIBnXFJiY9sblp/xEmSwfRK0FgAp5VgnmrgNU5MGI6Jk37yHZKnSKxsdslrA==
X-Received: by 2002:a17:903:192:b0:1d4:2d8d:3537 with SMTP id z18-20020a170903019200b001d42d8d3537mr9435106plg.44.1704311154076;
        Wed, 03 Jan 2024 11:45:54 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id ju13-20020a170903428d00b001d4301325a6sm20735475plb.247.2024.01.03.11.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:45:53 -0800 (PST)
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
Date: Wed,  3 Jan 2024 16:45:39 -0300
Message-ID: <ZZW5Y85OdibCu58h@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org> <20240102-81391283df04c430d76c0eb0@orel> <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 03, 2024 at 02:15:45PM +0800, Guo Ren wrote:
> On Tue, Jan 2, 2024 at 7:19 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The cost of changing a cacheline from shared to exclusive state can be
> > > significant, especially when this is triggered by an exclusive store,
> > > since it may result in having to retry the transaction.
> > >
> > > This patch makes use of prefetch.w to prefetch cachelines for write
> > > prior to lr/sc loops when using the xchg_small atomic routine.
> > >
> > > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
> > > prefetch the destination word for write prior to stxr").
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > index 26cea2395aae..d7b9d7951f08 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -10,6 +10,7 @@
> > >
> > >  #include <asm/barrier.h>
> > >  #include <asm/fence.h>
> > > +#include <asm/processor.h>
> > >
> > >  #define __arch_xchg_masked(prepend, append, r, p, n)                 \
> >
> > Are you sure this is based on v6.7-rc7? Because I don't see this macro.
> Oh, it is based on Leobras' patches. I would remove it in the next of version.

I would say this next :)

> 
> >
> > >  ({                                                                   \
> > > @@ -23,6 +24,7 @@
> > >                                                                       \
> > >       __asm__ __volatile__ (                                          \
> > >              prepend                                                  \
> > > +            PREFETCHW_ASM(%5)                                        \
> > >              "0:      lr.w %0, %2\n"                                  \
> > >              "        and  %1, %0, %z4\n"                             \
> > >              "        or   %1, %1, %z3\n"                             \
> > > @@ -30,7 +32,7 @@
> > >              "        bnez %1, 0b\n"                                  \
> > >              append                                                   \
> > >              : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))       \
> > > -            : "rJ" (__newx), "rJ" (~__mask)                          \
> > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)         \
> >
> > I'm pretty sure we don't want to allow the J constraint for __ptr32b.
> >
> > >              : "memory");                                             \
> > >                                                                       \
> > >       r = (__typeof__(*(p)))((__retx & __mask) >> __s);               \
> > > --
> > > 2.40.1
> > >
> >
> > Thanks,
> > drew
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

Nice patch :)
Any reason it's not needed in __arch_cmpxchg_masked(), and __arch_cmpxchg() ?

Thanks!
Leo


