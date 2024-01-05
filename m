Return-Path: <linux-kernel+bounces-17472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273CA824DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B321B284C11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCB524B;
	Fri,  5 Jan 2024 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI2wR42K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2F5225
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704429957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gCHPbzKxxZdm0rXXdb7LMI6sZxhhhsFujNk7n3OB9k=;
	b=PI2wR42KFr7Nmea7hpO1QeKGHQ4VA3kySnUjYBwAkiwyP06AfF/y3+jp7/hp3TT7/sxFcR
	Wjz0Dbvvj2XRmHqfMUaNSS4Hfydk/dbcY6OXTQtTgciMeOSSinhBWIaedbiweC4fIG9EO5
	UJ6e09OFQ98qKzx0vg4MX4WvPNTRmLM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-XGN5FntiMKyuifz_v6QPXw-1; Thu, 04 Jan 2024 23:45:56 -0500
X-MC-Unique: XGN5FntiMKyuifz_v6QPXw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9c07b2372so210156b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 20:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704429955; x=1705034755;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gCHPbzKxxZdm0rXXdb7LMI6sZxhhhsFujNk7n3OB9k=;
        b=kG775TPcTgfSfzoEXi8whZXvOQef55u+Djgc8SPvl/FUdIKlUS3YREcQUjQvLFaCyM
         Felxzv4KvhW+VmVgT0bbLigbk71Y5hq54V13h4Gpboq56CxziE3A8u0hB6Lik2S1dMOQ
         PyFREQzP82ALVFM+JwpjncgmDaIdH7c8O9R9uDDT+WDbte9zIWas8g+FMn542rGPkE22
         cB0b68W1OgvwS9ilhxwRGNeVCIyIj+PgksfJEqxaaCxMiFpDopTpDnP4nK85YQ1jNAnJ
         sE9yxN2wI6UUaXy2bLN7yEo8lT8XXO8vmWCWM5N7ip3iGTfZPor+ViH8F8zO3BcvT46b
         hr4w==
X-Gm-Message-State: AOJu0YylvmHHIrXmwmxxsWEXRiF1VhIIGj470pKbMgKokznFzFZMsC71
	MYKMXS7Yz5VJaC2dBjU9XkO7dwFw7blWCCtSuUSbyk4yx/xQdvXz+HLfTeTH004yUkPXmyl4xGL
	WUEplAk+FaTpaoxyAAzRFBIeSO8EGFeB7FFC94l4B
X-Received: by 2002:a05:6a20:158a:b0:199:2c16:cbf7 with SMTP id h10-20020a056a20158a00b001992c16cbf7mr1183100pzj.14.1704429954720;
        Thu, 04 Jan 2024 20:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc2sarifblykqbJU9N1a3e6+A2wNmKesa/PhNh3XT1AxNwJq39B3g2l/OmTNhD6Kftz6LNhQ==
X-Received: by 2002:a05:6a20:158a:b0:199:2c16:cbf7 with SMTP id h10-20020a056a20158a00b001992c16cbf7mr1183087pzj.14.1704429954369;
        Thu, 04 Jan 2024 20:45:54 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3efd:1dbc:859f:ecb4:d775])
        by smtp.gmail.com with ESMTPSA id e15-20020a63e00f000000b005c2967852c5sm481924pgh.30.2024.01.04.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 20:45:53 -0800 (PST)
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
Date: Fri,  5 Jan 2024 01:45:42 -0300
Message-ID: <ZZeJdjP2gUnTQCl-@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZcoWB_8dumgUn5K@boqun-archlinux>
References: <20240103163203.72768-2-leobras@redhat.com> <20240103163203.72768-3-leobras@redhat.com> <ZZcMycoHUqzBmGFs@boqun-archlinux> <ZZcX9vwk1dsZOfYu@LeoBras> <ZZcoWB_8dumgUn5K@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 01:51:20PM -0800, Boqun Feng wrote:
> On Thu, Jan 04, 2024 at 05:41:26PM -0300, Leonardo Bras wrote:
> > On Thu, Jan 04, 2024 at 11:53:45AM -0800, Boqun Feng wrote:
> > > On Wed, Jan 03, 2024 at 01:31:59PM -0300, Leonardo Bras wrote:
> > > > In this header every xchg define (_relaxed, _acquire, _release, vanilla)
> > > > contain it's own asm file, both for 4-byte variables an 8-byte variables,
> > > > on a total of 8 versions of mostly the same asm.
> > > > 
> > > > This is usually bad, as it means any change may be done in up to 8
> > > > different places.
> > > > 
> > > > Unify those versions by creating a new define with enough parameters to
> > > > generate any version of the previous 8.
> > > > 
> > > > Then unify the result under a more general define, and simplify
> > > > arch_xchg* generation.
> > > > 
> > > > (This did not cause any change in generated asm)
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > Reviewed-by: Guo Ren <guoren@kernel.org>
> > > > Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> > > > Tested-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/cmpxchg.h | 138 ++++++-------------------------
> > > >  1 file changed, 23 insertions(+), 115 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > > index 2f4726d3cfcc2..48478a8eecee7 100644
> > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > @@ -11,140 +11,48 @@
> > > >  #include <asm/barrier.h>
> > > >  #include <asm/fence.h>
> > > >  
> > > > -#define __xchg_relaxed(ptr, new, size)					\
> > > > +#define __arch_xchg(sfx, prepend, append, r, p, n)			\
> > > >  ({									\
> > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > -	__typeof__(new) __new = (new);					\
> > > > -	__typeof__(*(ptr)) __ret;					\
> > > > -	switch (size) {							\
> > > > -	case 4:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > 
> > Hello Boqun, thanks for reviewing!
> > 
> > >
> > > Hmm... actually xchg_relaxed() doesn't need to be a barrier(), so the
> > > "memory" clobber here is not needed here. Of course, it's out of the
> > > scope of this series, but I'm curious to see what would happen if we
> > > remove the "memory" clobber _relaxed() ;-)
> > 
> > Nice question :)
> > I am happy my patch can help bring up those ideas :) 
> > 
> > 
> > According to gcc.gnu.org:
> > 
> > ---
> > "memory" [clobber]:
> > 
> >     The "memory" clobber tells the compiler that the assembly code 
> >     performs memory reads or writes to items other than those listed in 
> >     the input and output operands (for example, accessing the memory 
> >     pointed to by one of the input parameters). To ensure memory contains 
> 
> Note here it says "other than those listed in the input and output
> operands", and in the above asm block, the memory pointed by "__ptr" is
> already marked as read-and-write by the asm block via "+A" (*__ptr), so
> the compiler knows the asm block may modify the memory pointed by
> "__ptr", therefore in _relaxed() case, "memory" clobber can be avoided.

Thanks for pointing that out! 
That helped me improve my understanding on constraints for asm operands :)
(I ended up getting even more info from the gcc manual)

So "+A" constraints means the operand will get read/write and it's an 
address stored into a register.

> 
> Here is an example showing the difference, considering the follow case:
> 
> 	this_val = *this;
> 	that_val = *that;
> 	xchg_relaxed(this, 1);
> 	reread_this = *this;
> 
> by the semantics of _relaxed, compilers can optimize the above into
> 
> 	this_val = *this;
> 	xchg_relaxed(this, 1);
> 	that_val = *that;
> 	reread_this = *this;
> 

Seems correct, since there is no barrier().

> but the "memory" clobber in the xchg_relexed() will provide this.

By 'this' here you mean the barrier? I mean, IIUC "memory" clobber will 
avoid the above optimization, right?

> Needless to say the '"+A" (*__ptr)' prevents compiler from the following
> optimization:
> 
> 	this_val = *this;
> 	that_val = *that;
> 	xchg_relaxed(this, 1);
> 	reread_this = this_val;
> 
> since the compiler knows the asm block will read and write *this.
 
Right, the compiler knows that address will be wrote by the asm block, and 
so it reloads the value instead of re-using the old one.


A question, though:
Do we need the "memory" clobber in any other xchg / cmpxchg asm?
I mean, usually the only write to memory will happen in the *__ptr, which 
should be safe by "+A".

I understand that since the others are not "relaxed" they will need to 
have a barrier, but is not the compiler supposed to understand the barrier 
instruction and avoid compiler reordering / optimizations across given 
instruction ?  


Thanks!
Leo

> Regards,
> Boqun
> 
> >     correct values, GCC may need to flush specific register values to 
> >     memory before executing the asm. Further, the compiler does not assume 
> >     that any values read from memory before an asm remain unchanged after 
> >     that asm ; it reloads them as needed. Using the "memory" clobber 
> >     effectively forms a read/write memory barrier for the compiler.
> > 
> >     Note that this clobber does not prevent the processor from doing 
> >     speculative reads past the asm statement. To prevent that, you need 
> >     processor-specific fence instructions.
> > ---
> > 
> > IIUC above text says that having memory accesses to *__ptr would require 
> > above asm to have the "memory" clobber, so memory accesses don't get 
> > reordered by the compiler. 
> > 
> > By above affirmation, all asm in this file should have the "memory" 
> > clobber, since all atomic operations will change memory pointed by an input 
> > ptr. Is that correct?
> > 
> > Thanks!
> > Leo
> > 
> > 
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > > -		break;							\
> > > > -	case 8:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > -		break;							\
> > > > -	default:							\
> > > > -		BUILD_BUG();						\
> > > > -	}								\
> > > > -	__ret;								\
> > > > -})
> > > > -
> > > > -#define arch_xchg_relaxed(ptr, x)					\
> > > > -({									\
> > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > -	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> > > > -					    _x_, sizeof(*(ptr)));	\
> > > > +	__asm__ __volatile__ (						\
> > > > +		prepend							\
> > > > +		"	amoswap" sfx " %0, %2, %1\n"			\
> > > > +		append							\
> > > > +		: "=r" (r), "+A" (*(p))					\
> > > > +		: "r" (n)						\
> > > > +		: "memory");						\
> > > >  })
> > > >  
> > > > -#define __xchg_acquire(ptr, new, size)					\
> > > > +#define _arch_xchg(ptr, new, sfx, prepend, append)			\
> > > >  ({									\
> > > >  	__typeof__(ptr) __ptr = (ptr);					\
> > > > -	__typeof__(new) __new = (new);					\
> > > > -	__typeof__(*(ptr)) __ret;					\
> > > > -	switch (size) {							\
> > > > +	__typeof__(*(__ptr)) __new = (new);				\
> > > > +	__typeof__(*(__ptr)) __ret;					\
> > > > +	switch (sizeof(*__ptr)) {					\
> > > >  	case 4:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > +		__arch_xchg(".w" sfx, prepend, append,			\
> > > > +			      __ret, __ptr, __new);			\
> > > >  		break;							\
> > > >  	case 8:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > +		__arch_xchg(".d" sfx, prepend, append,			\
> > > > +			      __ret, __ptr, __new);			\
> > > >  		break;							\
> > > >  	default:							\
> > > >  		BUILD_BUG();						\
> > > >  	}								\
> > > > -	__ret;								\
> > > > +	(__typeof__(*(__ptr)))__ret;					\
> > > >  })
> > > >  
> > > > -#define arch_xchg_acquire(ptr, x)					\
> > > > -({									\
> > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > -	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> > > > -					    _x_, sizeof(*(ptr)));	\
> > > > -})
> > > > +#define arch_xchg_relaxed(ptr, x)					\
> > > > +	_arch_xchg(ptr, x, "", "", "")
> > > >  
> > > > -#define __xchg_release(ptr, new, size)					\
> > > > -({									\
> > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > -	__typeof__(new) __new = (new);					\
> > > > -	__typeof__(*(ptr)) __ret;					\
> > > > -	switch (size) {							\
> > > > -	case 4:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			RISCV_RELEASE_BARRIER				\
> > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > -		break;							\
> > > > -	case 8:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			RISCV_RELEASE_BARRIER				\
> > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > -		break;							\
> > > > -	default:							\
> > > > -		BUILD_BUG();						\
> > > > -	}								\
> > > > -	__ret;								\
> > > > -})
> > > > +#define arch_xchg_acquire(ptr, x)					\
> > > > +	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> > > >  
> > > >  #define arch_xchg_release(ptr, x)					\
> > > > -({									\
> > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > -	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> > > > -					    _x_, sizeof(*(ptr)));	\
> > > > -})
> > > > -
> > > > -#define __arch_xchg(ptr, new, size)					\
> > > > -({									\
> > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > -	__typeof__(new) __new = (new);					\
> > > > -	__typeof__(*(ptr)) __ret;					\
> > > > -	switch (size) {							\
> > > > -	case 4:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.w.aqrl %0, %2, %1\n"		\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > -		break;							\
> > > > -	case 8:								\
> > > > -		__asm__ __volatile__ (					\
> > > > -			"	amoswap.d.aqrl %0, %2, %1\n"		\
> > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > -			: "r" (__new)					\
> > > > -			: "memory");					\
> > > > -		break;							\
> > > > -	default:							\
> > > > -		BUILD_BUG();						\
> > > > -	}								\
> > > > -	__ret;								\
> > > > -})
> > > > +	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> > > >  
> > > >  #define arch_xchg(ptr, x)						\
> > > > -({									\
> > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > -	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
> > > > -})
> > > > +	_arch_xchg(ptr, x, ".aqrl", "", "")
> > > >  
> > > >  #define xchg32(ptr, x)							\
> > > >  ({									\
> > > > -- 
> > > > 2.43.0
> > > > 
> > > 
> > 
> 


