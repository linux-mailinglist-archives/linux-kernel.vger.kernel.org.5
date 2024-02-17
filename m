Return-Path: <linux-kernel+bounces-69664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35E858D04
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DE41C21346
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A61B7F4;
	Sat, 17 Feb 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CUOArUJ0"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA3DF4D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708138823; cv=none; b=B5gxuktzQrln1HUcRIONpYv0RpaL28Cy+nNlzWvxV08lVyPFN3Jb+PLMjyhIok8pALl5LEcbZWKCdjrBTcTnnQQ0oCqyq0Sna6brAfBcYQIDLlcn15HPwEANIO5uUc3gmmnIjZZ+WvPRvZjHhAwRv9WnMsRK82Q1MS0broI5py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708138823; c=relaxed/simple;
	bh=qgkpfT2dllQwjlXb085TtMFS8z+8mhTM9Ojpyug1qGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLj6mUO0MLvmgdSs8UbwTrsmZ4gzeKy/rzBur232kk22kGerz194gHU3s1XxWR2Zue5AGE7q58CmxztdW8qJJdWHjR+2vugvB51RXVYB3WcDwUwwwnWdC26I/lXlGsFQ8iHDZKuV3neERB8KZLqjXDsF2G4W4HyLLl8VLg6WmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CUOArUJ0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607e705f745so19828287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708138819; x=1708743619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEy7zfxQRzTMFXYNNf+BB1fFRHE5O3uG9FLicsX+Uj4=;
        b=CUOArUJ04ReBqzT8/JHEO5Js6SYqlhm8QyDJX3MXPpck1p1rvf+0LNAohLmfH7lssT
         FzoFCmDHGVfbcxxOznBGm8nTSqvClPoATfOZ2jYQcHK/owp2IzfH03tBGuB3sazd3FOx
         U+vsJZfbwK2PUa+5XYHkSlMt+WqsrzqLNdi4LAjfMbA9pW5yvnqmm9cWheMXfOpnRuNN
         n3N3WhCyh8oLfMrMeHSDy+gi4bx2YClUmlEg5qgnb5T7tepEIGjk7oH8Y2I0OZcTGWnK
         TVFsFj73WMuuTVl4qx6NarkQNWkazT8RLzupbO5nbf833LONLL31r3SNMKOiaqz7XB+R
         Ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708138819; x=1708743619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEy7zfxQRzTMFXYNNf+BB1fFRHE5O3uG9FLicsX+Uj4=;
        b=lHgsSje52dF8q6BStqZ16I1Vr24qdXIC2Xl9zZtpc5QoTOTnmb33HYcH+DzRkcEKvM
         /gPtfA3CwmYX6lQLDXBI5ZlsvEvL1cD4nJo89WjRp74JP9nqyYJi0P0/6u1XAgX7DR24
         mjbEOXkQUSqTml2EGUrxtqOmyearPJvR4fD9Y9lFhanwX7hiKUJTWwyKPfx6FKO9sTXw
         At0eQ7NIKCKCAQio/+fIO/QHwZ1O20rAQVJSUki4LVi7mNixvgqEpuMCwbLI/ow414KK
         tokpcyTtgGhI5Aaf3QCGts6tzaATKTyMU0GWSRHLzgeSQdbngIoDK745EwD0j6I4O2x5
         Ixng==
X-Forwarded-Encrypted: i=1; AJvYcCVTtpxiBuAdwRlbqCUwZi7ZoPz/RrvULHAmNhToemUiamHLf6njHTscBuRj4d5D45PjFYgMlI+OxlpPHdbjhnP6c0PDBIvb+hJvGFU1
X-Gm-Message-State: AOJu0YzAOit6BGTFFRLAFwk7LWa9TlLjWmZQ0fkk53HgoK+Z/0L9ylGy
	gNBGdvIJTkH6nyMSPtQ6SHseDE4+aG7baZMdKAjaQy+2hntq4dwoaarVnzyiF9w=
X-Google-Smtp-Source: AGHT+IFnXRQpsexRiIeOXS1mU/eZNNF1eqewuyyeyvM8+T/LUlpBRmmjKfr1n/zJZTk+PaicDrb1Sg==
X-Received: by 2002:a81:4ec5:0:b0:607:951d:4318 with SMTP id c188-20020a814ec5000000b00607951d4318mr6956225ywb.4.1708138819154;
        Fri, 16 Feb 2024 19:00:19 -0800 (PST)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id y69-20020a0dd648000000b006079e8f3572sm623420ywd.85.2024.02.16.19.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 19:00:18 -0800 (PST)
Date: Fri, 16 Feb 2024 22:00:16 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Helge Deller <deller@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Message-ID: <ZdAhQHFXUF7wEWea@ghost>
References: <20240213234631.940055-1-linux@roeck-us.net>
 <Zc9XW-TxQKp84vMt@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9XW-TxQKp84vMt@p100>

On Fri, Feb 16, 2024 at 01:38:51PM +0100, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
> > hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
> > operations. The last add folds protocol and length fields into the 64-bit
> > result. While unlikely, this operation can overflow. The overflow can be
> > triggered with a code sequence such as the following.
> > 
> > 	/* try to trigger massive overflows */
> > 	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
> > 	csum_result = csum_ipv6_magic((struct in6_addr *)tmp_buf,
> > 				      (struct in6_addr *)tmp_buf,
> > 				      0xffff, 0xff, 0xffffffff);
> > 
> > Fix the problem by adding any overflows from the final add operation into
> > the calculated checksum. Fortunately, we can do this without additional
> > cost by replacing the add operation used to fold the checksum into 32 bit
> > with "add,dc" to add in the missing carry.
> 
> 
> Gunter,
> 
> Thanks for your patch for 32- and 64-bit systems.
> But I think it's time to sunset the parisc inline assembly for ipv4/ipv6
> checksumming.
> The patch below converts the code to use standard C-coding (taken from the
> s390 header file) and it survives the v8 lib/checksum patch.
> 
> Opinions?
> 
> Helge
> 
> Subject: [PATCH] parisc: Fix csum_ipv6_magic on 32- and 64-bit machines
> 
> Guenter noticed that the 32- and 64-bit checksum functions may calculate
> wrong values under certain circumstances. He fixed it by usining
> corrected carry-flags added, but overall I think it's better to convert
> away from inline assembly to generic C-coding.  That way the code is
> much cleaner and the compiler can do much better optimizations based on
> the target architecture (32- vs. 64-bit). Furthermore, the compiler
> generates nowadays much better code, so inline assembly usually won't
> give any benefit any longer.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Guenter Roeck <linux@roeck-us.net>
> 
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
> index 3c43baca7b39..c72f14536353 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -18,160 +18,93 @@
>   */
>  extern __wsum csum_partial(const void *, int, __wsum);
>  
> +
>  /*
> - *	Optimized for IP headers, which always checksum on 4 octet boundaries.
> - *
> - *	Written by Randolph Chung <tausq@debian.org>, and then mucked with by
> - *	LaMont Jones <lamont@debian.org>
> + * Fold a partial checksum without adding pseudo headers.
>   */
> -static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +static inline __sum16 csum_fold(__wsum sum)
>  {
> -	unsigned int sum;
> -	unsigned long t0, t1, t2;
> +	u32 csum = (__force u32) sum;
>  
> -	__asm__ __volatile__ (
> -"	ldws,ma		4(%1), %0\n"
> -"	addib,<=	-4, %2, 2f\n"
> -"\n"
> -"	ldws		4(%1), %4\n"
> -"	ldws		8(%1), %5\n"
> -"	add		%0, %4, %0\n"
> -"	ldws,ma		12(%1), %3\n"
> -"	addc		%0, %5, %0\n"
> -"	addc		%0, %3, %0\n"
> -"1:	ldws,ma		4(%1), %3\n"
> -"	addib,<		0, %2, 1b\n"
> -"	addc		%0, %3, %0\n"
> -"\n"
> -"	extru		%0, 31, 16, %4\n"
> -"	extru		%0, 15, 16, %5\n"
> -"	addc		%4, %5, %0\n"
> -"	extru		%0, 15, 16, %5\n"
> -"	add		%0, %5, %0\n"
> -"	subi		-1, %0, %0\n"
> -"2:\n"
> -	: "=r" (sum), "=r" (iph), "=r" (ihl), "=r" (t0), "=r" (t1), "=r" (t2)
> -	: "1" (iph), "2" (ihl)
> -	: "memory");
> -
> -	return (__force __sum16)sum;
> +	csum += (csum >> 16) | (csum << 16);
> +	csum >>= 16;
> +	return (__force __sum16) ~csum;
>  }

For all of my analysis I am using gcc 12.3.0.

We can do better than this! By inspection this looks like a performance
regression. The generic version of csum_fold in
include/asm-generic/checksum.h is better than this so should be used
instead.

I am not familiar with hppa assembly but this is the assembly for the
original csum_fold here:

0000000000000000 <csum_fold>:
   0:	08 03 02 41 	copy r3,r1
   4:	08 1e 02 43 	copy sp,r3
   8:	73 c1 00 88 	std,ma r1,40(sp)
   c:	d3 5a 09 fc 	shrpw r26,r26,16,ret0
  10:	0b 9a 0a 1c 	add,l r26,ret0,ret0
  14:	0b 80 09 9c 	uaddcm r0,ret0,ret0
  18:	db 9c 09 f0 	extrd,u,* ret0,47,16,ret0
  1c:	34 7e 00 80 	ldo 40(r3),sp
  20:	e8 40 d0 00 	bve (rp)
  24:	53 c3 3f 8d 	ldd,mb -40(sp),r3

This is the assembly for the generic version:
0000000000000000 <csum_fold_generic>:
   0:	08 03 02 41 	copy r3,r1
   4:	08 1e 02 43 	copy sp,r3
   8:	73 c1 00 88 	std,ma r1,40(sp)
   c:	0b 40 09 9c 	uaddcm r0,r26,ret0
  10:	d3 5a 09 fa 	shrpw r26,r26,16,r26
  14:	0b 5c 04 1c 	sub ret0,r26,ret0
  18:	db 9c 09 f0 	extrd,u,* ret0,47,16,ret0
  1c:	34 7e 00 80 	ldo 40(r3),sp
  20:	e8 40 d0 00 	bve (rp)
  24:	53 c3 3f 8d 	ldd,mb -40(sp),r3

This is the assembly for yours:
0000000000000028 <csum_fold_new>:
  28:	08 03 02 41 	copy r3,r1
  2c:	08 1e 02 43 	copy sp,r3
  30:	73 c1 00 88 	std,ma r1,40(sp)
  34:	d3 5a 09 fc 	shrpw r26,r26,16,ret0
  38:	0b 9a 0a 1c 	add,l r26,ret0,ret0
  3c:	d3 9c 19 f0 	extrw,u ret0,15,16,ret0
  40:	0b 80 09 9c 	uaddcm r0,ret0,ret0
  44:	db 9c 0b f0 	extrd,u,* ret0,63,16,ret0
  48:	34 7e 00 80 	ldo 40(r3),sp
  4c:	e8 40 d0 00 	bve (rp)
  50:	53 c3 3f 8d 	ldd,mb -40(sp),r3
  54:	00 00 00 00 	break 0,0

 The assembly is almost the same for the generic and the original code,
 except for rearranging the shift and add operation which allows the
 addition to become a subtraction and shortens the dependency chain on
 some architectures (looks like it doesn't change much here). However,
 this new code introduces an additional extrw instruction.

>  
>  /*
> - *	Fold a partial checksum
> + * This is a version of ip_compute_csum() optimized for IP headers,
> + * which always checksums on 4 octet boundaries.
>   */
> -static inline __sum16 csum_fold(__wsum csum)
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  {
> -	u32 sum = (__force u32)csum;
> -	/* add the swapped two 16-bit halves of sum,
> -	   a possible carry from adding the two 16-bit halves,
> -	   will carry from the lower half into the upper half,
> -	   giving us the correct sum in the upper half. */
> -	sum += (sum << 16) + (sum >> 16);
> -	return (__force __sum16)(~sum >> 16);
> +	__u64 csum = 0;
> +	__u32 *ptr = (u32 *)iph;
> +
> +	csum += *ptr++;
> +	csum += *ptr++;
> +	csum += *ptr++;
> +	csum += *ptr++;
> +	ihl -= 4;
> +	while (ihl--)
> +		csum += *ptr++;
> +	csum += (csum >> 32) | (csum << 32);
> +	return csum_fold((__force __wsum)(csum >> 32));
>  }

This doesn't leverage add with carry well. This causes the code size of this
to be dramatically larger than the original assembly, which I assume
nicely correlates to an increased execution time.

This is the original assembly in 64-bit (almost the same in 32-bit):
0000000000000028 <ip_fast_csum>:
  28:	08 03 02 41 	copy r3,r1
  2c:	08 1e 02 43 	copy sp,r3
  30:	73 c1 00 88 	std,ma r1,40(sp)
  34:	0f 48 10 bc 	ldw,ma 4(r26),ret0
  38:	a7 39 60 70 	addib,<= -4,r25,78 <ip_fast_csum+0x50>
  3c:	0f 48 10 93 	ldw 4(r26),r19
  40:	0f 50 10 94 	ldw 8(r26),r20
  44:	0a 7c 06 1c 	add ret0,r19,ret0
  48:	0f 58 10 bf 	ldw,ma c(r26),r31
  4c:	0a 9c 07 1c 	add,c ret0,r20,ret0
  50:	0b fc 07 1c 	add,c ret0,r31,ret0
  54:	0f 48 10 bf 	ldw,ma 4(r26),r31
  58:	a7 20 5f ed 	addib,< 0,r25,54 <ip_fast_csum+0x2c>
  5c:	0b fc 07 1c 	add,c ret0,r31,ret0
  60:	d3 93 1b f0 	extrw,u ret0,31,16,r19
  64:	d3 94 19 f0 	extrw,u ret0,15,16,r20
  68:	0a 93 07 1c 	add,c r19,r20,ret0
  6c:	d3 94 19 f0 	extrw,u ret0,15,16,r20
  70:	0a 9c 06 1c 	add ret0,r20,ret0
  74:	97 9c 07 ff 	subi -1,ret0,ret0
  78:	db 9c 0b f0 	extrd,u,* ret0,63,16,ret0
  7c:	34 7e 00 80 	ldo 40(r3),sp
  80:	e8 40 d0 00 	bve (rp)
  84:	53 c3 3f 8d 	ldd,mb -40(sp),r3

This is the 64-bit assembly of your proposal:

0000000000000058 <ip_fast_csum_new>:
  58:	08 03 02 41 	copy r3,r1
  5c:	0f c2 12 c1 	std rp,-10(sp)
  60:	08 1e 02 43 	copy sp,r3
  64:	73 c1 01 08 	std,ma r1,80(sp)
  68:	37 39 3f f9 	ldo -4(r25),r25
  6c:	0c 64 12 d0 	std r4,8(r3)
  70:	0f 48 10 9f 	ldw 4(r26),r31
  74:	db 39 0b e0 	extrd,u,* r25,63,32,r25
  78:	37 5a 00 20 	ldo 10(r26),r26
  7c:	0f 41 10 9c 	ldw -10(r26),ret0
  80:	0b fc 0a 1c 	add,l ret0,r31,ret0
  84:	0f 51 10 9f 	ldw -8(r26),r31
  88:	0b 9f 0a 1f 	add,l r31,ret0,r31
  8c:	0f 59 10 9c 	ldw -4(r26),ret0
  90:	0b fc 0a 1c 	add,l ret0,r31,ret0
  94:	37 3f 3f ff 	ldo -1(r25),r31
  98:	8f ff 20 68 	cmpib,<> -1,r31,d4 <ip_fast_csum_new+0x7c>
  9c:	db f9 0b e0 	extrd,u,* r31,63,32,r25
  a0:	d3 9c 07 fa 	shrpd,* ret0,ret0,32,r26
  a4:	37 dd 3f a1 	ldo -30(sp),ret1
  a8:	0b 9a 0a 1a 	add,l r26,ret0,r26
  ac:	00 00 14 a1 	mfia r1
  b0:	28 20 00 00 	addil L%0,r1,r1
  b4:	34 21 00 00 	ldo 0(r1),r1
  b8:	e8 20 f0 00 	bve,l (r1),rp
  bc:	db 5a 03 e0 	extrd,u,* r26,31,32,r26
  c0:	0c 70 10 c4 	ldd 8(r3),r4
  c4:	0c 61 10 c2 	ldd -10(r3),rp
  c8:	34 7e 00 80 	ldo 40(r3),sp
  cc:	e8 40 d0 00 	bve (rp)
  d0:	53 c3 3f 8d 	ldd,mb -40(sp),r3
  d4:	0f 40 10 9f 	ldw 0(r26),r31
  d8:	37 5a 00 08 	ldo 4(r26),r26
  dc:	e8 1f 1f 65 	b,l 94 <ip_fast_csum_new+0x3c>,r0
  e0:	0b fc 0a 1c 	add,l ret0,r31,ret0
  e4:	00 00 00 00 	break 0,0

The 32-bit assembly is even longer.

Maybe you can get some inspiration from my riscv implementation
arch/riscv/include/asm/checksum.h. You can swap out the line:
csum += csum < ((const unsigned int *)iph)[pos];
With the addc macro defined in arch/parisc/lib/checksum.c.

I will guess that this will improve the code but I haven't checked.

> - 
> -static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
> -					__u32 len, __u8 proto,
> -					__wsum sum)
> +
> +/*
> + * Computes the checksum of the TCP/UDP pseudo-header.
> + * Returns a 32-bit checksum.
> + */
> +static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
> +					__u8 proto, __wsum sum)
>  {
> -	__asm__(
> -	"	add  %1, %0, %0\n"
> -	"	addc %2, %0, %0\n"
> -	"	addc %3, %0, %0\n"
> -	"	addc %%r0, %0, %0\n"
> -		: "=r" (sum)
> -		: "r" (daddr), "r"(saddr), "r"(proto+len), "0"(sum));
> -	return sum;
> +	__u64 csum = (__force __u64)sum;
> +
> +	csum += (__force __u32)saddr;
> +	csum += (__force __u32)daddr;
> +	csum += len;
> +	csum += proto;
> +	csum += (csum >> 32) | (csum << 32);
> +	return (__force __wsum)(csum >> 32);
>  }

The assembly from the original:

0000000000000088 <csum_tcpudp_nofold>:
  88:	08 03 02 41 	copy r3,r1
  8c:	08 1e 02 43 	copy sp,r3
  90:	73 c1 00 88 	std,ma r1,40(sp)
  94:	da f7 0b f8 	extrd,u,* r23,63,8,r23
  98:	0a f8 0a 17 	add,l r24,r23,r23
  9c:	0a d9 06 16 	add r25,r22,r22
  a0:	0a da 07 16 	add,c r26,r22,r22
  a4:	0a d7 07 16 	add,c r23,r22,r22
  a8:	0a c0 07 16 	add,c r0,r22,r22
  ac:	da dc 0b e0 	extrd,u,* r22,63,32,ret0
  b0:	34 7e 00 80 	ldo 40(r3),sp
  b4:	e8 40 d0 00 	bve (rp)
  b8:	53 c3 3f 8d 	ldd,mb -40(sp),r3
  bc:	00 00 00 00 	break 0,0

The 64-bit assembly from your proposal:

0000000000000140 <csum_tcpudp_nofold_new>:
 140:	08 03 02 41 	copy r3,r1
 144:	08 1e 02 43 	copy sp,r3
 148:	73 c1 00 88 	std,ma r1,40(sp)
 14c:	db 5a 0b e0 	extrd,u,* r26,63,32,r26
 150:	db 39 0b e0 	extrd,u,* r25,63,32,r25
 154:	da f7 0b f8 	extrd,u,* r23,63,8,r23
 158:	db 18 0b e0 	extrd,u,* r24,63,32,r24
 15c:	da d6 0b e0 	extrd,u,* r22,63,32,r22
 160:	0a f8 0a 18 	add,l r24,r23,r24
 164:	0b 38 0a 18 	add,l r24,r25,r24
 168:	0b 58 0a 18 	add,l r24,r26,r24
 16c:	0a d8 0a 16 	add,l r24,r22,r22
 170:	d2 d6 07 fc 	shrpd,* r22,r22,32,ret0
 174:	0a dc 0a 1c 	add,l ret0,r22,ret0
 178:	db 9c 03 e0 	extrd,u,* ret0,31,32,ret0
 17c:	34 7e 00 80 	ldo 40(r3),sp
 180:	e8 40 d0 00 	bve (rp)
 184:	53 c3 3f 8d 	ldd,mb -40(sp),r3

There are a lot of extra extrd instructions, and again is really bad on
32-bit parisc.

Maybe there is a good way to represent this in C, but the assembly is
so simple and clean for this function already.

>  
>  /*
> - * computes the checksum of the TCP/UDP pseudo-header
> - * returns a 16-bit checksum, already complemented
> + * Computes the checksum of the TCP/UDP pseudo-header.
> + * Returns a 16-bit checksum, already complemented.
>   */
> -static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
> -					__u32 len, __u8 proto,
> -					__wsum sum)
> +static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
> +					__u8 proto, __wsum sum)
>  {
> -	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
> +	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
>  }
>  
The implementation of csum_tcpudp_magic is the same as the generic, so
the generic version should be used instead.

>  /*
> - * this routine is used for miscellaneous IP-like checksums, mainly
> - * in icmp.c
> + * Used for miscellaneous IP-like checksums, mainly icmp.
>   */
> -static inline __sum16 ip_compute_csum(const void *buf, int len)
> +static inline __sum16 ip_compute_csum(const void *buff, int len)
>  {
> -	 return csum_fold (csum_partial(buf, len, 0));
> +	return csum_fold(csum_partial(buff, len, 0));
>  }

The generic version is better than this so it should be used instead.

>  
> -
>  #define _HAVE_ARCH_IPV6_CSUM
> -static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> -					  const struct in6_addr *daddr,
> -					  __u32 len, __u8 proto,
> -					  __wsum sum)
> +static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +				      const struct in6_addr *daddr,
> +				      __u32 len, __u8 proto, __wsum csum)
>  {
> -	unsigned long t0, t1, t2, t3;
> -
> -	len += proto;	/* add 16-bit proto + len */
> -
> -	__asm__ __volatile__ (
> -
> -#if BITS_PER_LONG > 32
> -
> -	/*
> -	** We can execute two loads and two adds per cycle on PA 8000.
> -	** But add insn's get serialized waiting for the carry bit.
> -	** Try to keep 4 registers with "live" values ahead of the ALU.
> -	*/
> -
> -"	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
> -"	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
> -"	add		%4, %0, %0\n"
> -"	ldd,ma		8(%1), %6\n"	/* 2nd saddr */
> -"	ldd,ma		8(%2), %7\n"	/* 2nd daddr */
> -"	add,dc		%5, %0, %0\n"
> -"	add,dc		%6, %0, %0\n"
> -"	add,dc		%7, %0, %0\n"
> -"	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
> -"	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
> -"	depdi		0, 31, 32, %0\n"/* clear upper half */
> -"	add		%4, %0, %0\n"	/* fold into 32-bits */
> -"	addc		0, %0, %0\n"	/* add carry */
> -
> -#else
> -
> -	/*
> -	** For PA 1.x, the insn order doesn't matter as much.
> -	** Insn stream is serialized on the carry bit here too.
> -	** result from the previous operation (eg r0 + x)
> -	*/
> -"	ldw,ma		4(%1), %4\n"	/* get 1st saddr word */
> -"	ldw,ma		4(%2), %5\n"	/* get 1st daddr word */
> -"	add		%4, %0, %0\n"
> -"	ldw,ma		4(%1), %6\n"	/* 2nd saddr */
> -"	addc		%5, %0, %0\n"
> -"	ldw,ma		4(%2), %7\n"	/* 2nd daddr */
> -"	addc		%6, %0, %0\n"
> -"	ldw,ma		4(%1), %4\n"	/* 3rd saddr */
> -"	addc		%7, %0, %0\n"
> -"	ldw,ma		4(%2), %5\n"	/* 3rd daddr */
> -"	addc		%4, %0, %0\n"
> -"	ldw,ma		4(%1), %6\n"	/* 4th saddr */
> -"	addc		%5, %0, %0\n"
> -"	ldw,ma		4(%2), %7\n"	/* 4th daddr */
> -"	addc		%6, %0, %0\n"
> -"	addc		%7, %0, %0\n"
> -"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
> -
> -#endif
> -	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
> -	  "=r" (t0), "=r" (t1), "=r" (t2), "=r" (t3)
> -	: "0" (sum), "1" (saddr), "2" (daddr), "3" (len)
> -	: "memory");
> -	return csum_fold(sum);
> +	__u64 sum = (__force __u64)csum;
> +
> +	sum += (__force __u32)saddr->s6_addr32[0];
> +	sum += (__force __u32)saddr->s6_addr32[1];
> +	sum += (__force __u32)saddr->s6_addr32[2];
> +	sum += (__force __u32)saddr->s6_addr32[3];
> +	sum += (__force __u32)daddr->s6_addr32[0];
> +	sum += (__force __u32)daddr->s6_addr32[1];
> +	sum += (__force __u32)daddr->s6_addr32[2];
> +	sum += (__force __u32)daddr->s6_addr32[3];
> +	sum += len;
> +	sum += proto;
> +	sum += (sum >> 32) | (sum << 32);
> +	return csum_fold((__force __wsum)(sum >> 32));
>  }
>  
>  #endif
> -

Similar story again here where the add with carry is not well translated
into C, resulting in significantly worse assembly. Using __u64 seems to
be a big contributing factor for why the 32-bit assembly is worse.

I am not sure the best way to represent this in a clean way in C.

add with carry is not well understood by GCC 12.3 it seems. These
functions are generally heavily optimized on every architecture, so I
think it is worth it to default to assembly if you aren't able to
achieve comparable performance in C.

- Charlie


