Return-Path: <linux-kernel+bounces-17481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BFD824E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249E7B23EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2E53AB;
	Fri,  5 Jan 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCdYigKO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153C5396
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f85fe5632so2077386d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 21:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704431899; x=1705036699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMEJFS/riWQam7td2D41ciBjS/JvFKXcDNVzpMi7ZmA=;
        b=XCdYigKOFo5RcV3T2qKxVkmKUU4lLjJfr16mNuURa/5MBrDLyFhStBZKASH+wPxOo3
         cJBjhgl0Il1hMoKkWj3H+oLtoPHvoTLVDj7O+hnu579MRsV0ipLZi2o8fWtWIYiNaQqj
         KmDU9aexdm+fXtmUyLUC9hxUc/pJ5xcm7J/Og7LtyduZH6rUF+Iizz7vXun+PXX6z0/C
         I59eKd6telWPUsZU1DWHpHmXsY0MBAxsALTU1CsxhWwcylQYEV0rCA9PuoXwAoah5HFh
         V+N989/QeAjVIasTHZwtFYTJb0XykhflUeeyR7rQi18cTAw87ZUHtn16xLuExPGnfQPK
         jdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704431899; x=1705036699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMEJFS/riWQam7td2D41ciBjS/JvFKXcDNVzpMi7ZmA=;
        b=bgorgSKd3P7h7K/ns3zOAGAYVGj3eqct5Tf5NwMWWy+ALl6So3ZAkETxDaeoFVBTrU
         o+6DblwMQXGcovn/J/zlJo/IZy3U0NdBLV4IPsHAA/h60s+Epke33+rx6lFgJKFZzhdi
         UKsu4vxK6UfK4gqI5UIQBanPsvB8kvRRD2yBMikFiJvslgns89ig06vccmsJapvLAuYo
         HW5ADYqJJXWh2Pb3RhndACBgj8bXrs1tmzrcjYStVSO3achvbSnpTlY7cBgpSSrIWWRm
         IHGfGIbLcEe1PCDjjzTHDBQtd4edib+ufO16u0mCIC0m5Y2ycRwiE1pyLwOWoC8VWZ8W
         Pm/g==
X-Gm-Message-State: AOJu0YzNF5j5enSh6gAD3ypc5NxFmM6/JuMzAKuNChfaiLL8FLawUAFx
	UyVqO0U4Y8P0UcCDeci8kS4=
X-Google-Smtp-Source: AGHT+IGkM6joCNdDgoMqCcvXN++bqn6+2R3Rwbx1UiWguB1t5onVGKoR+rUISMOyuNyXJ/M3BdNCIw==
X-Received: by 2002:a05:6214:c86:b0:67f:40eb:bfa7 with SMTP id r6-20020a0562140c8600b0067f40ebbfa7mr2349819qvr.48.1704431898995;
        Thu, 04 Jan 2024 21:18:18 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t3-20020a05621405c300b006809d6fc192sm346295qvz.3.2024.01.04.21.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 21:18:18 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 01C7C27C005A;
	Fri,  5 Jan 2024 00:18:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Jan 2024 00:18:18 -0500
X-ME-Sender: <xms:GJGXZRfoch5lnwsg6c6AzSGA-8zVbbEmrnjIfRZAjeJRHHI3ppJONQ>
    <xme:GJGXZfOXm2Knn565ZkbfIKTUu-Hv7qAhzHpgsEFwDnFtQVU9sWrrvBl9O_qEVW9s9
    zPFTJiEDYFbjMivvA>
X-ME-Received: <xmr:GJGXZahcKIxwOdBY59IWyKKIDFVsRJaEF0V4rwDwke2kzEvfYn-bf91WtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffheekuefhieegveevjeevffdtheeuveefteelveefgfduieetvdduveei
    veekudenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:GZGXZa_PMVCAlewKEQ9VFRleCCZWGyQ6qvl0D7GCxdRhX-mzukPO7w>
    <xmx:GZGXZdtrZFle6Tn5jrqRvxqSU_P6oRMl6Y-UhdnuS0z0FlL6m-rIGA>
    <xmx:GZGXZZFKcyE8uuny55AZ_K8EDnskt5BUxaBnZ1a8bgUnxkXAexq7Mw>
    <xmx:GZGXZeMgEPBaVg6JKHu1z2QbyQ432cu43lzDf-5Ggmeuf1bpDgSeUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jan 2024 00:18:16 -0500 (EST)
Date: Thu, 4 Jan 2024 21:18:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Message-ID: <ZZeRF2GX6sLLxgrM@Boquns-Mac-mini.home>
References: <20240103163203.72768-2-leobras@redhat.com>
 <20240103163203.72768-3-leobras@redhat.com>
 <ZZcMycoHUqzBmGFs@boqun-archlinux>
 <ZZcX9vwk1dsZOfYu@LeoBras>
 <ZZcoWB_8dumgUn5K@boqun-archlinux>
 <ZZeJdjP2gUnTQCl-@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZeJdjP2gUnTQCl-@LeoBras>

On Fri, Jan 05, 2024 at 01:45:42AM -0300, Leonardo Bras wrote:
[...]
> > > According to gcc.gnu.org:
> > > 
> > > ---
> > > "memory" [clobber]:
> > > 
> > >     The "memory" clobber tells the compiler that the assembly code 
> > >     performs memory reads or writes to items other than those listed in 
> > >     the input and output operands (for example, accessing the memory 
> > >     pointed to by one of the input parameters). To ensure memory contains 
> > 
> > Note here it says "other than those listed in the input and output
> > operands", and in the above asm block, the memory pointed by "__ptr" is
> > already marked as read-and-write by the asm block via "+A" (*__ptr), so
> > the compiler knows the asm block may modify the memory pointed by
> > "__ptr", therefore in _relaxed() case, "memory" clobber can be avoided.
> 
> Thanks for pointing that out! 
> That helped me improve my understanding on constraints for asm operands :)
> (I ended up getting even more info from the gcc manual)
> 
> So "+A" constraints means the operand will get read/write and it's an 
> address stored into a register.
> 
> > 
> > Here is an example showing the difference, considering the follow case:
> > 
> > 	this_val = *this;
> > 	that_val = *that;
> > 	xchg_relaxed(this, 1);
> > 	reread_this = *this;
> > 
> > by the semantics of _relaxed, compilers can optimize the above into
> > 
> > 	this_val = *this;
> > 	xchg_relaxed(this, 1);
> > 	that_val = *that;
> > 	reread_this = *this;
> > 
> 
> Seems correct, since there is no barrier().
> 
> > but the "memory" clobber in the xchg_relexed() will provide this.
> 
> By 'this' here you mean the barrier? I mean, IIUC "memory" clobber will 
> avoid the above optimization, right?
> 

Right, seems I mis-typed "provide" (I meant "prevent")

> > Needless to say the '"+A" (*__ptr)' prevents compiler from the following
> > optimization:
> > 
> > 	this_val = *this;
> > 	that_val = *that;
> > 	xchg_relaxed(this, 1);
> > 	reread_this = this_val;
> > 
> > since the compiler knows the asm block will read and write *this.
>  
> Right, the compiler knows that address will be wrote by the asm block, and 
> so it reloads the value instead of re-using the old one.
> 

Correct.

> 
> A question, though:

Good question ;-)

> Do we need the "memory" clobber in any other xchg / cmpxchg asm?

The "memory" clobber is needed for others, see below:

> I mean, usually the only write to memory will happen in the *__ptr, which 
> should be safe by "+A".
> 
> I understand that since the others are not "relaxed" they will need to 
> have a barrier, but is not the compiler supposed to understand the barrier 
> instruction and avoid compiler reordering / optimizations across given 
> instruction ?  
> 

The barrier semantics (ACQUIRE/RELEASE/FULL) is provided by the combined
effort of both 1) preventing compiler optimization by "memory" clobber
and 2) preventing CPU/memory reordering by arch-specific instructions.

In other words, an asm block contains a hardware barrier instruction
should always have the "memory" clobber, otherwise, there are
possiblities that compilers reorder the asm block therefore break the
ordering provided by the hardware instructions.

Regards,
Boqun

> 
> Thanks!
> Leo
> 
> > Regards,
> > Boqun
> > 
> > >     correct values, GCC may need to flush specific register values to 
> > >     memory before executing the asm. Further, the compiler does not assume 
> > >     that any values read from memory before an asm remain unchanged after 
> > >     that asm ; it reloads them as needed. Using the "memory" clobber 
> > >     effectively forms a read/write memory barrier for the compiler.
> > > 
> > >     Note that this clobber does not prevent the processor from doing 
> > >     speculative reads past the asm statement. To prevent that, you need 
> > >     processor-specific fence instructions.
> > > ---
> > > 
> > > IIUC above text says that having memory accesses to *__ptr would require 
> > > above asm to have the "memory" clobber, so memory accesses don't get 
> > > reordered by the compiler. 
> > > 
> > > By above affirmation, all asm in this file should have the "memory" 
> > > clobber, since all atomic operations will change memory pointed by an input 
> > > ptr. Is that correct?
> > > 
> > > Thanks!
> > > Leo
> > > 
> > > 
> > > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > > -		break;							\
> > > > > -	case 8:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > -		break;							\
> > > > > -	default:							\
> > > > > -		BUILD_BUG();						\
> > > > > -	}								\
> > > > > -	__ret;								\
> > > > > -})
> > > > > -
> > > > > -#define arch_xchg_relaxed(ptr, x)					\
> > > > > -({									\
> > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > -	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > +	__asm__ __volatile__ (						\
> > > > > +		prepend							\
> > > > > +		"	amoswap" sfx " %0, %2, %1\n"			\
> > > > > +		append							\
> > > > > +		: "=r" (r), "+A" (*(p))					\
> > > > > +		: "r" (n)						\
> > > > > +		: "memory");						\
> > > > >  })
> > > > >  
> > > > > -#define __xchg_acquire(ptr, new, size)					\
> > > > > +#define _arch_xchg(ptr, new, sfx, prepend, append)			\
> > > > >  ({									\
> > > > >  	__typeof__(ptr) __ptr = (ptr);					\
> > > > > -	__typeof__(new) __new = (new);					\
> > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > -	switch (size) {							\
> > > > > +	__typeof__(*(__ptr)) __new = (new);				\
> > > > > +	__typeof__(*(__ptr)) __ret;					\
> > > > > +	switch (sizeof(*__ptr)) {					\
> > > > >  	case 4:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > +		__arch_xchg(".w" sfx, prepend, append,			\
> > > > > +			      __ret, __ptr, __new);			\
> > > > >  		break;							\
> > > > >  	case 8:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > -			RISCV_ACQUIRE_BARRIER				\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > +		__arch_xchg(".d" sfx, prepend, append,			\
> > > > > +			      __ret, __ptr, __new);			\
> > > > >  		break;							\
> > > > >  	default:							\
> > > > >  		BUILD_BUG();						\
> > > > >  	}								\
> > > > > -	__ret;								\
> > > > > +	(__typeof__(*(__ptr)))__ret;					\
> > > > >  })
> > > > >  
> > > > > -#define arch_xchg_acquire(ptr, x)					\
> > > > > -({									\
> > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > -	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > -})
> > > > > +#define arch_xchg_relaxed(ptr, x)					\
> > > > > +	_arch_xchg(ptr, x, "", "", "")
> > > > >  
> > > > > -#define __xchg_release(ptr, new, size)					\
> > > > > -({									\
> > > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > > -	__typeof__(new) __new = (new);					\
> > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > -	switch (size) {							\
> > > > > -	case 4:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			RISCV_RELEASE_BARRIER				\
> > > > > -			"	amoswap.w %0, %2, %1\n"			\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > -		break;							\
> > > > > -	case 8:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			RISCV_RELEASE_BARRIER				\
> > > > > -			"	amoswap.d %0, %2, %1\n"			\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > -		break;							\
> > > > > -	default:							\
> > > > > -		BUILD_BUG();						\
> > > > > -	}								\
> > > > > -	__ret;								\
> > > > > -})
> > > > > +#define arch_xchg_acquire(ptr, x)					\
> > > > > +	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> > > > >  
> > > > >  #define arch_xchg_release(ptr, x)					\
> > > > > -({									\
> > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > -	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> > > > > -					    _x_, sizeof(*(ptr)));	\
> > > > > -})
> > > > > -
> > > > > -#define __arch_xchg(ptr, new, size)					\
> > > > > -({									\
> > > > > -	__typeof__(ptr) __ptr = (ptr);					\
> > > > > -	__typeof__(new) __new = (new);					\
> > > > > -	__typeof__(*(ptr)) __ret;					\
> > > > > -	switch (size) {							\
> > > > > -	case 4:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			"	amoswap.w.aqrl %0, %2, %1\n"		\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > -		break;							\
> > > > > -	case 8:								\
> > > > > -		__asm__ __volatile__ (					\
> > > > > -			"	amoswap.d.aqrl %0, %2, %1\n"		\
> > > > > -			: "=r" (__ret), "+A" (*__ptr)			\
> > > > > -			: "r" (__new)					\
> > > > > -			: "memory");					\
> > > > > -		break;							\
> > > > > -	default:							\
> > > > > -		BUILD_BUG();						\
> > > > > -	}								\
> > > > > -	__ret;								\
> > > > > -})
> > > > > +	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> > > > >  
> > > > >  #define arch_xchg(ptr, x)						\
> > > > > -({									\
> > > > > -	__typeof__(*(ptr)) _x_ = (x);					\
> > > > > -	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
> > > > > -})
> > > > > +	_arch_xchg(ptr, x, ".aqrl", "", "")
> > > > >  
> > > > >  #define xchg32(ptr, x)							\
> > > > >  ({									\
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > 
> > > 
> > 
> 

