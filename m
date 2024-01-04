Return-Path: <linux-kernel+bounces-17202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BDB8249B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0332875B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4262C69B;
	Thu,  4 Jan 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGfiKOQX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD228E0C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704400942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAmQvLaF2jO2nEcpKJ+aB+e3AH0L/O+kz07dDjvJ2J4=;
	b=UGfiKOQXJjctOkUS3xBxw9aTqMYhDwuvNmqaHdyIszV3KDMk4iR81j0QE1O9lSO0C8e/5G
	xfRrFxPClNedXDKh7BeTypEXqgt+1KgqK0nxt2eDsch/WTLjv8NAkjkRxYbNBM9J+CWyCI
	GVQkDIObIm+f6Jdd1h8sfoSTMJfqcYI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-R2vev4JVPBe8Jn1nDDwikg-1; Thu, 04 Jan 2024 15:42:15 -0500
X-MC-Unique: R2vev4JVPBe8Jn1nDDwikg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce0d2a64edso519194a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704400930; x=1705005730;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAmQvLaF2jO2nEcpKJ+aB+e3AH0L/O+kz07dDjvJ2J4=;
        b=TH9PEgItA/mr33GDl0W0Gb6n2rBKZEFQHnGKferf2PtX3v3jnppqOfmyEObrfb3eqp
         eqq4+KywDO01qWuSSXP6oYXgqtu9tcmeWiUZEzMD9iU0KEL2ld1Z4SIBsZMoCiiTL5+1
         z0WAsbgbM2Hl6k1nh3EpeyTGv7UVC9Vm/xxJHw38v9SuSJfDUmPKm2bT4T45PnrkuYLi
         DRHlIj5OBp/Fh12FcWH5owPjBPTpQ0huTbOK6OqZcwREzcN3X+r9EK6XAlbdn1v0KYGm
         lRuchTlHjtEmME3Cry4MXSf4MZfGuqceJbtA0byv02Hh+MaU4ur5xo3YWyq1vnvUfDxH
         lARA==
X-Gm-Message-State: AOJu0YxNSSMDKxzTZsaiRpHbrgAS4cTPh6ME6QM1B1eVvUj5wgLf4Eb0
	xlLK1SOxzK9IJ3ptYl9msGMQtyv6z2+84HOiYIzQ+z+/3zn760Fuhy2PF3qtEmByqG30ron2JuV
	Xy3yj2VwIlhkvYpfqLfPR07yQAy3SaT9wM+6pav/a
X-Received: by 2002:a17:902:6946:b0:1d4:b6e9:9e42 with SMTP id k6-20020a170902694600b001d4b6e99e42mr970241plt.21.1704400930232;
        Thu, 04 Jan 2024 12:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4k1+6bEArfLc4KJe1Y4BM1WpQOEYufqPMfLPjtLZCpfhiodfznVwuXXmndPOhZDdINaUI/A==
X-Received: by 2002:a17:902:6946:b0:1d4:b6e9:9e42 with SMTP id k6-20020a170902694600b001d4b6e99e42mr969743plt.21.1704400899999;
        Thu, 04 Jan 2024 12:41:39 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:3c39:8a36:75f0:8b6e:b898])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902a50d00b001d1d1ef8be6sm24508plq.267.2024.01.04.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 12:41:39 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Date: Thu,  4 Jan 2024 17:41:26 -0300
Message-ID: <ZZcX9vwk1dsZOfYu@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZcMycoHUqzBmGFs@boqun-archlinux>
References: <20240103163203.72768-2-leobras@redhat.com> <20240103163203.72768-3-leobras@redhat.com> <ZZcMycoHUqzBmGFs@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 11:53:45AM -0800, Boqun Feng wrote:
> On Wed, Jan 03, 2024 at 01:31:59PM -0300, Leonardo Bras wrote:
> > In this header every xchg define (_relaxed, _acquire, _release, vanilla)
> > contain it's own asm file, both for 4-byte variables an 8-byte variables,
> > on a total of 8 versions of mostly the same asm.
> > 
> > This is usually bad, as it means any change may be done in up to 8
> > different places.
> > 
> > Unify those versions by creating a new define with enough parameters to
> > generate any version of the previous 8.
> > 
> > Then unify the result under a more general define, and simplify
> > arch_xchg* generation.
> > 
> > (This did not cause any change in generated asm)
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 138 ++++++-------------------------
> >  1 file changed, 23 insertions(+), 115 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 2f4726d3cfcc2..48478a8eecee7 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -11,140 +11,48 @@
> >  #include <asm/barrier.h>
> >  #include <asm/fence.h>
> >  
> > -#define __xchg_relaxed(ptr, new, size)					\
> > +#define __arch_xchg(sfx, prepend, append, r, p, n)			\
> >  ({									\
> > -	__typeof__(ptr) __ptr = (ptr);					\
> > -	__typeof__(new) __new = (new);					\
> > -	__typeof__(*(ptr)) __ret;					\
> > -	switch (size) {							\
> > -	case 4:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.w %0, %2, %1\n"			\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\

Hello Boqun, thanks for reviewing!

>
> Hmm... actually xchg_relaxed() doesn't need to be a barrier(), so the
> "memory" clobber here is not needed here. Of course, it's out of the
> scope of this series, but I'm curious to see what would happen if we
> remove the "memory" clobber _relaxed() ;-)

Nice question :)
I am happy my patch can help bring up those ideas :) 


According to gcc.gnu.org:

---
"memory" [clobber]:

    The "memory" clobber tells the compiler that the assembly code 
    performs memory reads or writes to items other than those listed in 
    the input and output operands (for example, accessing the memory 
    pointed to by one of the input parameters). To ensure memory contains 
    correct values, GCC may need to flush specific register values to 
    memory before executing the asm. Further, the compiler does not assume 
    that any values read from memory before an asm remain unchanged after 
    that asm ; it reloads them as needed. Using the "memory" clobber 
    effectively forms a read/write memory barrier for the compiler.

    Note that this clobber does not prevent the processor from doing 
    speculative reads past the asm statement. To prevent that, you need 
    processor-specific fence instructions.
---

IIUC above text says that having memory accesses to *__ptr would require 
above asm to have the "memory" clobber, so memory accesses don't get 
reordered by the compiler. 

By above affirmation, all asm in this file should have the "memory" 
clobber, since all atomic operations will change memory pointed by an input 
ptr. Is that correct?

Thanks!
Leo


> 
> Regards,
> Boqun
> 
> > -		break;							\
> > -	case 8:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.d %0, %2, %1\n"			\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > -		break;							\
> > -	default:							\
> > -		BUILD_BUG();						\
> > -	}								\
> > -	__ret;								\
> > -})
> > -
> > -#define arch_xchg_relaxed(ptr, x)					\
> > -({									\
> > -	__typeof__(*(ptr)) _x_ = (x);					\
> > -	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> > -					    _x_, sizeof(*(ptr)));	\
> > +	__asm__ __volatile__ (						\
> > +		prepend							\
> > +		"	amoswap" sfx " %0, %2, %1\n"			\
> > +		append							\
> > +		: "=r" (r), "+A" (*(p))					\
> > +		: "r" (n)						\
> > +		: "memory");						\
> >  })
> >  
> > -#define __xchg_acquire(ptr, new, size)					\
> > +#define _arch_xchg(ptr, new, sfx, prepend, append)			\
> >  ({									\
> >  	__typeof__(ptr) __ptr = (ptr);					\
> > -	__typeof__(new) __new = (new);					\
> > -	__typeof__(*(ptr)) __ret;					\
> > -	switch (size) {							\
> > +	__typeof__(*(__ptr)) __new = (new);				\
> > +	__typeof__(*(__ptr)) __ret;					\
> > +	switch (sizeof(*__ptr)) {					\
> >  	case 4:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.w %0, %2, %1\n"			\
> > -			RISCV_ACQUIRE_BARRIER				\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > +		__arch_xchg(".w" sfx, prepend, append,			\
> > +			      __ret, __ptr, __new);			\
> >  		break;							\
> >  	case 8:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.d %0, %2, %1\n"			\
> > -			RISCV_ACQUIRE_BARRIER				\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > +		__arch_xchg(".d" sfx, prepend, append,			\
> > +			      __ret, __ptr, __new);			\
> >  		break;							\
> >  	default:							\
> >  		BUILD_BUG();						\
> >  	}								\
> > -	__ret;								\
> > +	(__typeof__(*(__ptr)))__ret;					\
> >  })
> >  
> > -#define arch_xchg_acquire(ptr, x)					\
> > -({									\
> > -	__typeof__(*(ptr)) _x_ = (x);					\
> > -	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> > -					    _x_, sizeof(*(ptr)));	\
> > -})
> > +#define arch_xchg_relaxed(ptr, x)					\
> > +	_arch_xchg(ptr, x, "", "", "")
> >  
> > -#define __xchg_release(ptr, new, size)					\
> > -({									\
> > -	__typeof__(ptr) __ptr = (ptr);					\
> > -	__typeof__(new) __new = (new);					\
> > -	__typeof__(*(ptr)) __ret;					\
> > -	switch (size) {							\
> > -	case 4:								\
> > -		__asm__ __volatile__ (					\
> > -			RISCV_RELEASE_BARRIER				\
> > -			"	amoswap.w %0, %2, %1\n"			\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > -		break;							\
> > -	case 8:								\
> > -		__asm__ __volatile__ (					\
> > -			RISCV_RELEASE_BARRIER				\
> > -			"	amoswap.d %0, %2, %1\n"			\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > -		break;							\
> > -	default:							\
> > -		BUILD_BUG();						\
> > -	}								\
> > -	__ret;								\
> > -})
> > +#define arch_xchg_acquire(ptr, x)					\
> > +	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> >  
> >  #define arch_xchg_release(ptr, x)					\
> > -({									\
> > -	__typeof__(*(ptr)) _x_ = (x);					\
> > -	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> > -					    _x_, sizeof(*(ptr)));	\
> > -})
> > -
> > -#define __arch_xchg(ptr, new, size)					\
> > -({									\
> > -	__typeof__(ptr) __ptr = (ptr);					\
> > -	__typeof__(new) __new = (new);					\
> > -	__typeof__(*(ptr)) __ret;					\
> > -	switch (size) {							\
> > -	case 4:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.w.aqrl %0, %2, %1\n"		\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > -		break;							\
> > -	case 8:								\
> > -		__asm__ __volatile__ (					\
> > -			"	amoswap.d.aqrl %0, %2, %1\n"		\
> > -			: "=r" (__ret), "+A" (*__ptr)			\
> > -			: "r" (__new)					\
> > -			: "memory");					\
> > -		break;							\
> > -	default:							\
> > -		BUILD_BUG();						\
> > -	}								\
> > -	__ret;								\
> > -})
> > +	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> >  
> >  #define arch_xchg(ptr, x)						\
> > -({									\
> > -	__typeof__(*(ptr)) _x_ = (x);					\
> > -	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
> > -})
> > +	_arch_xchg(ptr, x, ".aqrl", "", "")
> >  
> >  #define xchg32(ptr, x)							\
> >  ({									\
> > -- 
> > 2.43.0
> > 
> 


