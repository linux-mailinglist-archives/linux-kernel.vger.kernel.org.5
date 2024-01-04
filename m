Return-Path: <linux-kernel+bounces-17185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C706824949
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DE91F234DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFC2C691;
	Thu,  4 Jan 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgxrzYFh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D52C686
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42836658198so4098231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704398095; x=1705002895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dn8vRr4qHHYrzVumxZ4mBTr1b1gKVQEBFS3/J0er3M=;
        b=cgxrzYFh8nf+SZC6N3AaQa7aCExplSg3Puguu8OYB+qEe/w/+SGUBVChBcG1Y+4Zmy
         OrpNtKBDViFMfRZkaXPDWKq8VTan9mXXypKKp+ofdDDc6/rEQYQ+NKEqlFxal9aRtet+
         1LH7zNLBuwmHIrTfl//YgjkLgD2yvp29nnEU59q+YfJbAznSfocg5vpFA5Zygfd93Cqf
         MznkkxsIE7zuBlCiBODgBTpHjlpmZ4g4v1uvMpTte1dMyjkmjgg3Wv92sY07PwZEX4UR
         6IoInc45mITynJvnk8yrrodKcyDl/k2fGkPVc9CnPwlRmXhfQTNDqIULhG2xLDYru4t1
         FebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398095; x=1705002895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dn8vRr4qHHYrzVumxZ4mBTr1b1gKVQEBFS3/J0er3M=;
        b=Kgc/xJogHQRii1C1gR+zizg5VXyjc9/h5ith7D/CfyXd0ntgkJ6IbM7gfg4eMsIK0A
         OAWC+hW2Dt5HyWZCyG4VF3WsUfPgM+0rCSAAt+Q82T/UnSzLPY1htnnQ/dJb5sZa/srd
         3OTah4LEiBHbNJj4NmppLd4ePIuzzTQxEL3aPTFFA8UKydLpVQFOIUnmFWC3nCjOc1eY
         JW0BDCYgL6MgNZuk4eSqiDiGZhLDBlp6/K5/9xvLfdzQmApOgkJZ4RDLUqW5eUPDrcuW
         6yWUjrsnruwl6LkPZ/ZvFvrp3YqxojsS2GGZdETUpTSfCgPjhv+xzKweEJisYO4zyNAn
         +RPw==
X-Gm-Message-State: AOJu0YwxOhP4HnjlJFz4eJM+YvMcXHIV0+VFHi+VaSEQjJDvplv+HlKt
	UEgGp/ynTvi3Z3gcEN/MgCc=
X-Google-Smtp-Source: AGHT+IEWMHx0NRm7Ofa64/ajW0gGqYNY7Y6W6RYK4KQsQdXRbMrhRDOEadMtMmC/laUz9klEtQWoDw==
X-Received: by 2002:ac8:7c41:0:b0:427:921b:af98 with SMTP id o1-20020ac87c41000000b00427921baf98mr1028926qtv.87.1704398095086;
        Thu, 04 Jan 2024 11:54:55 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ch11-20020a05622a40cb00b00427f42aadedsm83600qtb.9.2024.01.04.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:54:54 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 3963627C0061;
	Thu,  4 Jan 2024 14:54:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 04 Jan 2024 14:54:54 -0500
X-ME-Sender: <xms:DQ2XZTDzS5thTNXjEKrfzfJhX35F7PPnf4vXzWcPdkh35FrVQWHB2Q>
    <xme:DQ2XZZjHCXRCc7nfUbY8_wK-Bvv-AG74S-TfzjrhtWCq4Kfv0dcuHWJUNv7Mq2hA0
    FvNnqM7IH3qZOoPWQ>
X-ME-Received: <xmr:DQ2XZenj_PiyQ1VpdiR7_S5IXD_h_ysh6NWCI9E3xgCstt_LDvN3gYIZE3PZRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedt
    vdetvedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:DQ2XZVzMH6ZLMegFt4GezmnCpl629CH-eTpGspGqGQYZUPdwbgqsog>
    <xmx:DQ2XZYRvOLYOoRZYBTARSPn0KI7_mvVfz6lnIP65QnForzD5RNCWLg>
    <xmx:DQ2XZYavzhA0IZvlMI2u-XYUjvz10-XMat_XwjkmB2zaIrKzyCR6Lg>
    <xmx:Dg2XZaC0dV71R6kpcGpdIe8DJZnWMDUYsozFrkNYhKE5BMVu5hiUgg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 14:54:52 -0500 (EST)
Date: Thu, 4 Jan 2024 11:53:45 -0800
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
Message-ID: <ZZcMycoHUqzBmGFs@boqun-archlinux>
References: <20240103163203.72768-2-leobras@redhat.com>
 <20240103163203.72768-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103163203.72768-3-leobras@redhat.com>

On Wed, Jan 03, 2024 at 01:31:59PM -0300, Leonardo Bras wrote:
> In this header every xchg define (_relaxed, _acquire, _release, vanilla)
> contain it's own asm file, both for 4-byte variables an 8-byte variables,
> on a total of 8 versions of mostly the same asm.
> 
> This is usually bad, as it means any change may be done in up to 8
> different places.
> 
> Unify those versions by creating a new define with enough parameters to
> generate any version of the previous 8.
> 
> Then unify the result under a more general define, and simplify
> arch_xchg* generation.
> 
> (This did not cause any change in generated asm)
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 138 ++++++-------------------------
>  1 file changed, 23 insertions(+), 115 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 2f4726d3cfcc2..48478a8eecee7 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -11,140 +11,48 @@
>  #include <asm/barrier.h>
>  #include <asm/fence.h>
>  
> -#define __xchg_relaxed(ptr, new, size)					\
> +#define __arch_xchg(sfx, prepend, append, r, p, n)			\
>  ({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(new) __new = (new);					\
> -	__typeof__(*(ptr)) __ret;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.w %0, %2, %1\n"			\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\

Hmm... actually xchg_relaxed() doesn't need to be a barrier(), so the
"memory" clobber here is not needed here. Of course, it's out of the
scope of this series, but I'm curious to see what would happen if we
remove the "memory" clobber _relaxed() ;-)

Regards,
Boqun

> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.d %0, %2, %1\n"			\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> -
> -#define arch_xchg_relaxed(ptr, x)					\
> -({									\
> -	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> -					    _x_, sizeof(*(ptr)));	\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amoswap" sfx " %0, %2, %1\n"			\
> +		append							\
> +		: "=r" (r), "+A" (*(p))					\
> +		: "r" (n)						\
> +		: "memory");						\
>  })
>  
> -#define __xchg_acquire(ptr, new, size)					\
> +#define _arch_xchg(ptr, new, sfx, prepend, append)			\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(new) __new = (new);					\
> -	__typeof__(*(ptr)) __ret;					\
> -	switch (size) {							\
> +	__typeof__(*(__ptr)) __new = (new);				\
> +	__typeof__(*(__ptr)) __ret;					\
> +	switch (sizeof(*__ptr)) {					\
>  	case 4:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.w %0, %2, %1\n"			\
> -			RISCV_ACQUIRE_BARRIER				\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> +		__arch_xchg(".w" sfx, prepend, append,			\
> +			      __ret, __ptr, __new);			\
>  		break;							\
>  	case 8:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.d %0, %2, %1\n"			\
> -			RISCV_ACQUIRE_BARRIER				\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> +		__arch_xchg(".d" sfx, prepend, append,			\
> +			      __ret, __ptr, __new);			\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
>  	}								\
> -	__ret;								\
> +	(__typeof__(*(__ptr)))__ret;					\
>  })
>  
> -#define arch_xchg_acquire(ptr, x)					\
> -({									\
> -	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> -					    _x_, sizeof(*(ptr)));	\
> -})
> +#define arch_xchg_relaxed(ptr, x)					\
> +	_arch_xchg(ptr, x, "", "", "")
>  
> -#define __xchg_release(ptr, new, size)					\
> -({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(new) __new = (new);					\
> -	__typeof__(*(ptr)) __ret;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"	amoswap.w %0, %2, %1\n"			\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"	amoswap.d %0, %2, %1\n"			\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> +#define arch_xchg_acquire(ptr, x)					\
> +	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
>  
>  #define arch_xchg_release(ptr, x)					\
> -({									\
> -	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> -					    _x_, sizeof(*(ptr)));	\
> -})
> -
> -#define __arch_xchg(ptr, new, size)					\
> -({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(new) __new = (new);					\
> -	__typeof__(*(ptr)) __ret;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.w.aqrl %0, %2, %1\n"		\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			"	amoswap.d.aqrl %0, %2, %1\n"		\
> -			: "=r" (__ret), "+A" (*__ptr)			\
> -			: "r" (__new)					\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> +	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
>  
>  #define arch_xchg(ptr, x)						\
> -({									\
> -	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
> -})
> +	_arch_xchg(ptr, x, ".aqrl", "", "")
>  
>  #define xchg32(ptr, x)							\
>  ({									\
> -- 
> 2.43.0
> 

