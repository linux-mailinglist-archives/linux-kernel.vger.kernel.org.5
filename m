Return-Path: <linux-kernel+bounces-17528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B6824EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154C71F23729
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1D11CA0;
	Fri,  5 Jan 2024 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BntroNFV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45C5CBE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704437995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQVueAH6b8OhMM6ibqLC2xO4nUW7aQbo88ztAYelySE=;
	b=BntroNFVIPmty/r2u21bT0EhzjbWiAwa51lCZ9lcKU/qd4GwDTNbdbrmyqseSnuXkaOPxu
	Ni5URWOc04RiXgttIt5Np8kCQ0HgT20g3iJTzwMDQobOClmzQJCVlKaWv9ARZJv5VMy/rs
	FOA65HBSi0vlVNB8O/70TeuJOfcvO5U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-03VOQCrYNRKYi5Va9wbzvw-1; Fri, 05 Jan 2024 01:59:54 -0500
X-MC-Unique: 03VOQCrYNRKYi5Va9wbzvw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28b88d79b87so988871a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 22:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704437993; x=1705042793;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQVueAH6b8OhMM6ibqLC2xO4nUW7aQbo88ztAYelySE=;
        b=J/RrnkNzfwXCn0Vzo/TFbdrhS3xQRwDZygES7sseLGLkVSRINuTQA/P+AXAlsQz4EI
         bQGF1znir8Npzsj5xwSP69RNBslpgoKNjFVYbp1JnWATJEXWaGF2KhK3XWM/7uXDVpNx
         7YemqarAu3+gwL51Y2P41axY5yOOb3PVDpp+JTRS0IwV/GRZelSYzpE9M/xpHlPUwcGl
         Y/SZgyk8yW2QyHFYtJp6wKOnpmeqnBFor6n6TjUNpEPHiFYvSWauBDf1NDqB7HOWZSJc
         JXGn258t+oEhW5tQ0Sq+buarwWVGuehZ5IxCw2HwbdMoYO7VKVgtJj+ybY5soNLQU4lm
         55mQ==
X-Gm-Message-State: AOJu0Yz7ClIuqBBG94snq96kOhwaAMbGuX5Bh1+rcicaGX86EHf/q0qk
	dXCtVQjrzDVcDyzv/t+J+R3q1TtNLb2N8mqXhSyBWWRsZtWlf+9aCyVnFuDGeWYxcz8ae761jVo
	YfzlT18xaaKg9Z5b/EgB3QPBnTzwQIHjk
X-Received: by 2002:a17:90b:81:b0:28c:f163:4884 with SMTP id bb1-20020a17090b008100b0028cf1634884mr1362128pjb.50.1704437993338;
        Thu, 04 Jan 2024 22:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7q8OltVswbziyk5VXAXNj9YieqSpXs4x4sIMJ4dv8668MQdkAFbsWlf3g0mBjEwPXX7tMvg==
X-Received: by 2002:a17:90b:81:b0:28c:f163:4884 with SMTP id bb1-20020a17090b008100b0028cf1634884mr1362118pjb.50.1704437992956;
        Thu, 04 Jan 2024 22:59:52 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3efd:1dbc:859f:ecb4:d775])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001d33e6521b9sm693032plz.14.2024.01.04.22.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:59:52 -0800 (PST)
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
Date: Fri,  5 Jan 2024 03:59:44 -0300
Message-ID: <ZZeo3-XzV9GBZuMe@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZeRF2GX6sLLxgrM@Boquns-Mac-mini.home>
References: <20240103163203.72768-2-leobras@redhat.com> <20240103163203.72768-3-leobras@redhat.com> <ZZcMycoHUqzBmGFs@boqun-archlinux> <ZZcX9vwk1dsZOfYu@LeoBras> <ZZcoWB_8dumgUn5K@boqun-archlinux> <ZZeJdjP2gUnTQCl-@LeoBras> <ZZeRF2GX6sLLxgrM@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 09:18:15PM -0800, Boqun Feng wrote:
> On Fri, Jan 05, 2024 at 01:45:42AM -0300, Leonardo Bras wrote:
> [...]
> > > > According to gcc.gnu.org:
> > > > 
> > > > ---
> > > > "memory" [clobber]:
> > > > 
> > > >     The "memory" clobber tells the compiler that the assembly code 
> > > >     performs memory reads or writes to items other than those listed in 
> > > >     the input and output operands (for example, accessing the memory 
> > > >     pointed to by one of the input parameters). To ensure memory contains 
> > > 
> > > Note here it says "other than those listed in the input and output
> > > operands", and in the above asm block, the memory pointed by "__ptr" is
> > > already marked as read-and-write by the asm block via "+A" (*__ptr), so
> > > the compiler knows the asm block may modify the memory pointed by
> > > "__ptr", therefore in _relaxed() case, "memory" clobber can be avoided.
> > 
> > Thanks for pointing that out! 
> > That helped me improve my understanding on constraints for asm operands :)
> > (I ended up getting even more info from the gcc manual)
> > 
> > So "+A" constraints means the operand will get read/write and it's an 
> > address stored into a register.
> > 
> > > 
> > > Here is an example showing the difference, considering the follow case:
> > > 
> > > 	this_val = *this;
> > > 	that_val = *that;
> > > 	xchg_relaxed(this, 1);
> > > 	reread_this = *this;
> > > 
> > > by the semantics of _relaxed, compilers can optimize the above into
> > > 
> > > 	this_val = *this;
> > > 	xchg_relaxed(this, 1);
> > > 	that_val = *that;
> > > 	reread_this = *this;
> > > 
> > 
> > Seems correct, since there is no barrier().
> > 
> > > but the "memory" clobber in the xchg_relexed() will provide this.
> > 
> > By 'this' here you mean the barrier? I mean, IIUC "memory" clobber will 
> > avoid the above optimization, right?
> > 
> 
> Right, seems I mis-typed "provide" (I meant "prevent")
> 
> > > Needless to say the '"+A" (*__ptr)' prevents compiler from the following
> > > optimization:
> > > 
> > > 	this_val = *this;
> > > 	that_val = *that;
> > > 	xchg_relaxed(this, 1);
> > > 	reread_this = this_val;
> > > 
> > > since the compiler knows the asm block will read and write *this.
> >  
> > Right, the compiler knows that address will be wrote by the asm block, and 
> > so it reloads the value instead of re-using the old one.
> > 
> 
> Correct.
> 
> > 
> > A question, though:
> 
> Good question ;-)
> 
> > Do we need the "memory" clobber in any other xchg / cmpxchg asm?
> 
> The "memory" clobber is needed for others, see below:
> 
> > I mean, usually the only write to memory will happen in the *__ptr, which 
> > should be safe by "+A".
> > 
> > I understand that since the others are not "relaxed" they will need to 
> > have a barrier, but is not the compiler supposed to understand the barrier 
> > instruction and avoid compiler reordering / optimizations across given 
> > instruction ?  
> > 
> 
> The barrier semantics (ACQUIRE/RELEASE/FULL) is provided by the combined
> effort of both 1) preventing compiler optimization by "memory" clobber
> and 2) preventing CPU/memory reordering by arch-specific instructions.
> 
> In other words, an asm block contains a hardware barrier instruction
> should always have the "memory" clobber, otherwise, there are
> possiblities that compilers reorder the asm block therefore break the
> ordering provided by the hardware instructions.

Oh, I see.
So this means the compiler does not check for memory barrier instructions 
before reordering loads/stores. Right?

Meaning it needs a way to signal a compiler barrier, on top of the barrier 
instructions. 

Thanks for helping me improve my understanding of this!
Leo

> 
> Regards,
> Boqun
> 
> > 
> > Thanks!
> > Leo
> > 
> > > Regards,
> > > Boqun
> > > 
> > > >     correct values, GCC may need to flush specific register values to 
> > > >     memory before executing the asm. Further, the compiler does not assume 
> > > >     that any values read from memory before an asm remain unchanged after 
> > > >     that asm ; it reloads them as needed. Using the "memory" clobber 
> > > >     effectively forms a read/write memory barrier for the compiler.
> > > > 
> > > >     Note that this clobber does not prevent the processor from doing 
> > > >     speculative reads past the asm statement. To prevent that, you need 
> > > >     processor-specific fence instructions.
> > > > ---
> > > > 
> > > > IIUC above text says that having memory accesses to *__ptr would require 
> > > > above asm to have the "memory" clobber, so memory accesses don't get 
> > > > reordered by the compiler. 
> > > > 
> > > > By above affirmation, all asm in this file should have the "memory" 
> > > > clobber, since all atomic operations will change memory pointed by an input 
> > > > ptr. Is that correct?
> > > > 
> > > > Thanks!
> > > > Leo
> > > > 
> > > > 
> > > > > 
> > > > > Regards,
> > > > > Boqun
> > > > > 
> > > > > > -		break;							\
> > > > > > -	case 8:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > -		break;							\
> > > > > > -	default:							\
> > > > > > -		BUILD_BUG();						\
> > > > > > -	}								\
> > > > > > -	__ret;								\
> > > > > > -})
> > > > > > -
> > > > > > -#define arch_xchg_relaxed(ptr, x)					\
> > > > > > -({									\
> > > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > > -	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> > > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > > +	__asm__ __volatile__ (						\
> > > > > > +		prepend							\
> > > > > > +		"	amoswap" sfx " %0, %2, %1\n"			\
> > > > > > +		append							\
> > > > > > +		: "=r" (r), "+A" (*(p))					\
> > > > > > +		: "r" (n)						\
> > > > > > +		: "memory");						\
> > > > > >  })
> > > > > >  
> > > > > > -#define __xchg_acquire(ptr, new, size)					\
> > > > > > +#define _arch_xchg(ptr, new, sfx, prepend, append)			\
> > > > > >  ({									\
> > > > > >  	__typeof__(ptr) __ptr = (ptr);					\
> > > > > > -	__typeof__(new) __new = (new);					\
> > > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > > -	switch (size) {							\
> > > > > > +	__typeof__(*(__ptr)) __new = (new);				\
> > > > > > +	__typeof__(*(__ptr)) __ret;					\
> > > > > > +	switch (sizeof(*__ptr)) {					\
> > > > > >  	case 4:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > +		__arch_xchg(".w" sfx, prepend, append,			\
> > > > > > +			      __ret, __ptr, __new);			\
> > > > > >  		break;							\
> > > > > >  	case 8:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > +		__arch_xchg(".d" sfx, prepend, append,			\
> > > > > > +			      __ret, __ptr, __new);			\
> > > > > >  		break;							\
> > > > > >  	default:							\
> > > > > >  		BUILD_BUG();						\
> > > > > >  	}								\
> > > > > > -	__ret;								\
> > > > > > +	(__typeof__(*(__ptr)))__ret;					\
> > > > > >  })
> > > > > >  
> > > > > > -#define arch_xchg_acquire(ptr, x)					\
> > > > > > -({									\
> > > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > > -	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> > > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > > -})
> > > > > > +#define arch_xchg_relaxed(ptr, x)					\
> > > > > > +	_arch_xchg(ptr, x, "", "", "")
> > > > > >  
> > > > > > -#define __xchg_release(ptr, new, size)					\
> > > > > > -({									\
> > > > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > > > -	__typeof__(new) __new = (new);					\
> > > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > > -	switch (size) {							\
> > > > > > -	case 4:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			RISCV_RELEASE_BARRIER				\
> > > > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > -		break;							\
> > > > > > -	case 8:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			RISCV_RELEASE_BARRIER				\
> > > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > -		break;							\
> > > > > > -	default:							\
> > > > > > -		BUILD_BUG();						\
> > > > > > -	}								\
> > > > > > -	__ret;								\
> > > > > > -})
> > > > > > +#define arch_xchg_acquire(ptr, x)					\
> > > > > > +	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> > > > > >  
> > > > > >  #define arch_xchg_release(ptr, x)					\
> > > > > > -({									\
> > > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > > -	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> > > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > > -})
> > > > > > -
> > > > > > -#define __arch_xchg(ptr, new, size)					\
> > > > > > -({									\
> > > > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > > > -	__typeof__(new) __new = (new);					\
> > > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > > -	switch (size) {							\
> > > > > > -	case 4:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			"	amoswap.w.aqrl %0, %2, %1\n"		\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > -		break;							\
> > > > > > -	case 8:								\
> > > > > > -		__asm__ __volatile__ (					\
> > > > > > -			"	amoswap.d.aqrl %0, %2, %1\n"		\
> > > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > > -			: "r" (__new)					\
> > > > > > -			: "memory");					\
> > > > > > -		break;							\
> > > > > > -	default:							\
> > > > > > -		BUILD_BUG();						\
> > > > > > -	}								\
> > > > > > -	__ret;								\
> > > > > > -})
> > > > > > +	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> > > > > >  
> > > > > >  #define arch_xchg(ptr, x)						\
> > > > > > -({									\
> > > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > > -	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
> > > > > > -})
> > > > > > +	_arch_xchg(ptr, x, ".aqrl", "", "")
> > > > > >  
> > > > > >  #define xchg32(ptr, x)							\
> > > > > >  ({									\
> > > > > > -- 
> > > > > > 2.43.0
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> 


