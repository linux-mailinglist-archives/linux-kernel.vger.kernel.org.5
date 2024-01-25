Return-Path: <linux-kernel+bounces-38681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D083C405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC891C22521
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFD5A0FE;
	Thu, 25 Jan 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmYHH8WZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320259B73
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190466; cv=none; b=Ch6vgcESHBnIUW5bzzIUHNLENxYyLuHCc40fw+7gPjxssjd8GbCgQOfT24XMN4XYt+/ulYZvvHcLJlLoZK8BNvl2HnMkMNe5bBf3cgK5C4m0strGeoAjs3G7KPzyzlkMnHu/15dIJ4l6127JEbIgv2YK1b5yILKmjIku6Al8MvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190466; c=relaxed/simple;
	bh=HKDrkAxnm0v4E+WqvxXk+env0lFY8iQSHSbv6vYGCno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7wVlWrS7kKxQEGKzJPLE3FihCsvZigYjCoQ3odD+pzQ2HWzOGs2ZKus2a2gL/u7l704xMvTNOlFI+2Bi8yO3kIlT/WcTA/jvZn+M38WM/FD4fJQnkGHMeY1HMo6cSi57RXQ9UjZTPnCKt7xr1QJ58LPcJI6j/tRE+LaMB3JqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmYHH8WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C83C43390;
	Thu, 25 Jan 2024 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706190465;
	bh=HKDrkAxnm0v4E+WqvxXk+env0lFY8iQSHSbv6vYGCno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fmYHH8WZQnbZVmOwtFZdPjwwSgnJ0e0MFVcP4jY0512jQufSsvx6y1xpl6w75ZACi
	 w+rMR58BzCjyEIytTw2RKtM6sqk6hzEsoZfjbmfZrxx8yRaYFt43X5jySgqZSfC4Fp
	 lVamrsla7/V5ZFjeRhg4gxkHxKmPUx2sWb5V4asqJrUyfT+Dl/2pDmSQLcUQZfyi4/
	 jR/M/QLL66z6ovtj1l4BD2QT9Qw/88eZ2ncN0npRMnpe/3zvwvZbe6hxsoxSc0xAqM
	 y4aqmkEDXfCiDhmfzo7GO7bCxgF0qrAij6kq4L7XckohlHe87lfoCB7HthLanolyFH
	 VrKza+Ez5PkXw==
Message-ID: <e017718b-d385-41de-9139-0265cf3e6149@kernel.org>
Date: Thu, 25 Jan 2024 19:17:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm/hash: Code cleanup
To: Kunwu Chan <chentao@kylinos.cn>, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240125094636.539372-1-chentao@kylinos.cn>
Content-Language: en-US
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <20240125094636.539372-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 3:16 PM, Kunwu Chan wrote:
> This part was commented in about 17 years before.
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 22 -------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 1c4eebbc69c9..d39ec7134a78 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -731,26 +731,6 @@ struct hash_mm_context {
>  #endif /* CONFIG_PPC_SUBPAGE_PROT */
>  };
>  
> -#if 0
> -/*
> - * The code below is equivalent to this function for arguments
> - * < 2^VSID_BITS, which is all this should ever be called
> - * with.  However gcc is not clever enough to compute the
> - * modulus (2^n-1) without a second multiply.
> - */
> -#define vsid_scramble(protovsid, size) \
> -	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
> -
> -/* simplified form avoiding mod operation */
> -#define vsid_scramble(protovsid, size) \
> -	({								 \
> -		unsigned long x;					 \
> -		x = (protovsid) * VSID_MULTIPLIER_##size;		 \
> -		x = (x >> VSID_BITS_##size) + (x & VSID_MODULUS_##size); \
> -		(x + ((x+1) >> VSID_BITS_##size)) & VSID_MODULUS_##size; \
> -	})
> -
> -#else /* 1 */
>  static inline unsigned long vsid_scramble(unsigned long protovsid,
>  				  unsigned long vsid_multiplier, int vsid_bits)
>  {
> @@ -764,8 +744,6 @@ static inline unsigned long vsid_scramble(unsigned long protovsid,
>  	return (vsid + ((vsid + 1) >> vsid_bits)) & vsid_modulus;
>  }
>  
> -#endif /* 1 */
> -
>  /* Returns the segment size indicator for a user address */
>  static inline int user_segment_size(unsigned long addr)
>  {

That was done to make sure one can follow the actual compiled code better. 

-aneesh


