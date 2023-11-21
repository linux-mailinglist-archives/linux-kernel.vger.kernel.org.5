Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA837F347D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjKURGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjKURGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:06:14 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E5C12A;
        Tue, 21 Nov 2023 09:06:09 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so60756267b3.1;
        Tue, 21 Nov 2023 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700586368; x=1701191168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yvtQ4Ebo/Kb44aEbWh7yd1BLC9SYBFw1dHgRjmsTHQ=;
        b=i2tz4qIVWVkOJ6TDKRMadqmHcJ283aprr/uBoHXtSSwKjHb2G2ng2V6oH4WL2sm+z7
         pq7feLAoECK+gfj9//495/2aV/dZHHpHTGLQ8OkOgzeXD5HofRzt2jjqpYLdkh33fq+B
         up7fDiv1tG7F95MLKtiaSdUUkl9UaWNbz8Ds7wRxvkqnZQXx2Lev2jSgvqfc1tgWYq3n
         GjrPc6JnqONJfbf+tfCDjfm8XaXARnafMIXpQChpKuNoR2wzFaUrQeZI7imAmRyFIz33
         BQJxWn9YiNkIgJ/8ZaU7nurYq4WdPUYTlEneRtWyKCk8d9cjeqSkCUF2Jnjt+g4hl/Jt
         oYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586368; x=1701191168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yvtQ4Ebo/Kb44aEbWh7yd1BLC9SYBFw1dHgRjmsTHQ=;
        b=RoHNim6wFdSI+BF6bMcO8ELm3pRnwSqWBQyBF5h6XlgnpW3r+lAEM1kYFkq9MAHYfl
         R2rVebFjL8sWrxH8nbIW5XrJ+XZVM3kCPjLVEXJaWnslB9Px7hsa3Vi93SNiFwULitSR
         3pUtIcNC9UuWDCzMxZeBkkhdYZuCxETGInPoCnHCvK43GFGrQqk2LpP5qwiR7gscy3Tp
         kVFSWDPbuSFPZLsRYEk8iGzFd+4rpjpot9/H/UC+lQKC0Iu7Ds7uGjou5JiN+K5kSXbM
         CSjfPnyS+rIYfEODttq2eUxuWUSMTH87uWQtZl9mxxWbbkNAA5LTBqqeYuvxk79WO44C
         ngkQ==
X-Gm-Message-State: AOJu0YyC5kYCsYzlHWyDdaLQ5e0f3hJgU965DjrLgXs04WZe4GGnpNZf
        vcRB04qUFhx+WBlhdb/26bE=
X-Google-Smtp-Source: AGHT+IGgYGW74+xEboeRnBl++DsL5KBqe1zC/1Rgzefx/B1dmv/vwJy33R/2Fsyv4huD1plo9vANQQ==
X-Received: by 2002:a05:690c:b19:b0:5ca:d579:52f with SMTP id cj25-20020a05690c0b1900b005cad579052fmr5902440ywb.35.1700586368016;
        Tue, 21 Nov 2023 09:06:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id o81-20020a817354000000b005b37c6e01f9sm3122576ywc.90.2023.11.21.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:06:07 -0800 (PST)
Date:   Tue, 21 Nov 2023 09:06:06 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH 22/30] lib: Implement
 find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
Message-ID: <ZVzjfpEfT2mz6B59@yury-ThinkPad>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <20221122203932.231377-23-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203932.231377-23-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:39:24PM -0500, Mathieu Desnoyers wrote:
> Allow finding the first, next, or nth bit within two input bitmasks
> which is zero in both masks.
> 
> Allow fiding the first bit within two input bitmasks which is set in
> first mask and cleared in the second mask. find_next_andnot_bit and
> find_nth_andnot_bit already exist, so find the first bit appears to be
> missing.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/find.h | 123 +++++++++++++++++++++++++++++++++++++++++--
>  lib/find_bit.c       |  42 +++++++++++++++
>  2 files changed, 161 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index ccaf61a0f5fd..43c3db92a096 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
>  					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start);
> +unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long nbits, unsigned long start);
>  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
>  					 unsigned long start);
>  extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
> @@ -22,8 +24,14 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
>  				unsigned long size, unsigned long n);
>  unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long size, unsigned long n);
> +unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long size, unsigned long n);
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>  					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
> +extern unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
> +					 const unsigned long *addr2, unsigned long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
>  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
>  
> @@ -95,15 +103,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>  
>  #ifndef find_next_andnot_bit
>  /**
> - * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
> - *                        in *addr2
> + * find_next_andnot_bit - find the next bit set in *addr1, cleared in *addr2
>   * @addr1: The first address to base the search on
>   * @addr2: The second address to base the search on
>   * @size: The bitmap size in bits
>   * @offset: The bitnumber to start searching at
>   *
> - * Returns the bit number for the next set bit
> - * If no bits are set, returns @size.
> + * Returns the bit number for the next bit set in *addr1, cleared in *addr2
> + * If no such bits are found, returns @size.
>   */
>  static inline
>  unsigned long find_next_andnot_bit(const unsigned long *addr1,
> @@ -124,6 +131,37 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +#ifndef find_next_notandnot_bit

You don't need ifdefs for new functions. If arch people will add their
implementations, they will protect generic version themself.

> +/**
> + * find_next_notandnot_bit - find the next bit cleared in both *addr1 and *addr2
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
> + *
> + * Returns the bit number for the next bit cleared in both *addr1 and *addr2
> + * If no such bits are found, returns @size.
> + */
> +static inline
> +unsigned long find_next_notandnot_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset)

This should be find_next_zero_or_bit(). That way you'll avoid
negation for both maps and be consistent with existing API.

> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val;
> +
> +		if (unlikely(offset >= size))
> +			return size;
> +
> +		val = ~*addr1 & ~*addr2 & GENMASK(size - 1, offset);
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_next_notandnot_bit(addr1, addr2, size, offset);
> +}
> +#endif
> +
> +
>  #ifndef find_next_zero_bit
>  /**
>   * find_next_zero_bit - find the next cleared bit in a memory region
> @@ -255,6 +293,32 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
>  	return __find_nth_andnot_bit(addr1, addr2, size, n);
>  }
>  
> +/**
> + * find_nth_notandnot_bit - find N'th cleared bit in 2 memory regions.
> + * @addr1: The 1st address to start the search at
> + * @addr2: The 2nd address to start the search at
> + * @size: The maximum number of bits to search
> + * @n: The number of set bit, which position is needed, counting from 0
> + *
> + * Returns the bit number of the N'th cleared bit.
> + * If no such, returns @size.
> + */
> +static inline
> +unsigned long find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				unsigned long size, unsigned long n)

Same here. find_nth_zero_or_bit()

Thanks,
Yury

> +{
> +	if (n >= size)
> +		return size;
> +
> +	if (small_const_nbits(size)) {
> +		unsigned long val =  (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? fns(val, n) : size;
> +	}
> +
> +	return __find_nth_notandnot_bit(addr1, addr2, size, n);
> +}
> +
>  #ifndef find_first_and_bit
>  /**
>   * find_first_and_bit - find the first set bit in both memory regions
> @@ -280,6 +344,57 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
>  }
>  #endif
>  
> +#ifndef find_first_andnot_bit
> +/**
> + * find_first_andnot_bit - find first set bit in 2 memory regions,
> + *			   flipping bits in 2nd region
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next set bit
> + * If no bits are set, returns @size.
> + */
> +static inline
> +unsigned long find_first_andnot_bit(const unsigned long *addr1,
> +				 const unsigned long *addr2,
> +				 unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_first_andnot_bit(addr1, addr2, size);
> +}
> +#endif
> +
> +#ifndef find_first_notandnot_bit
> +/**
> + * find_first_notandnot_bit - find first cleared bit in 2 memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next cleared bit
> + * If no bits are set, returns @size.
> + */
> +static inline
> +unsigned long find_first_notandnot_bit(const unsigned long *addr1,
> +				 const unsigned long *addr2,
> +				 unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
> +
> +		return val ? __ffs(val) : size;
> +	}
> +
> +	return _find_first_notandnot_bit(addr1, addr2, size);
> +}
> +#endif
> +
>  #ifndef find_first_zero_bit
>  /**
>   * find_first_zero_bit - find the first cleared bit in a memory region
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 18bc0a7ac8ee..a1f592f2437e 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -116,6 +116,32 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>  EXPORT_SYMBOL(_find_first_and_bit);
>  #endif
>  
> +#ifndef find_first_andnot_bit
> +/*
> + * Find the first set bit in two memory regions, flipping bits in 2nd region.
> + */
> +unsigned long _find_first_andnot_bit(const unsigned long *addr1,
> +				  const unsigned long *addr2,
> +				  unsigned long size)
> +{
> +	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
> +}
> +EXPORT_SYMBOL(_find_first_andnot_bit);
> +#endif
> +
> +#ifndef find_first_notandnot_bit
> +/*
> + * Find the first cleared bit in two memory regions.
> + */
> +unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
> +				  const unsigned long *addr2,
> +				  unsigned long size)
> +{
> +	return FIND_FIRST_BIT(~addr1[idx] & ~addr2[idx], /* nop */, size);
> +}
> +EXPORT_SYMBOL(_find_first_notandnot_bit);
> +#endif
> +
>  #ifndef find_first_zero_bit
>  /*
>   * Find the first cleared bit in a memory region.
> @@ -155,6 +181,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
>  }
>  EXPORT_SYMBOL(__find_nth_andnot_bit);
>  
> +unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				 unsigned long size, unsigned long n)
> +{
> +	return FIND_NTH_BIT(~addr1[idx] & ~addr2[idx], size, n);
> +}
> +EXPORT_SYMBOL(__find_nth_notandnot_bit);
> +
>  #ifndef find_next_and_bit
>  unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>  					unsigned long nbits, unsigned long start)
> @@ -173,6 +206,15 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
>  EXPORT_SYMBOL(_find_next_andnot_bit);
>  #endif
>  
> +#ifndef find_next_notandnot_bit
> +unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
> +					unsigned long nbits, unsigned long start)
> +{
> +	return FIND_NEXT_BIT(~addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
> +}
> +EXPORT_SYMBOL(_find_next_notandnot_bit);
> +#endif
> +
>  #ifndef find_next_zero_bit
>  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
>  					 unsigned long start)
> -- 
> 2.25.1
> 
