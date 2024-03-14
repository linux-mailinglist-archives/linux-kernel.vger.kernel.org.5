Return-Path: <linux-kernel+bounces-102726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931687B68D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF61B23631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E058C10;
	Thu, 14 Mar 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z9rqQ07i"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A48BF0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384714; cv=none; b=Tg3HmHnCBtfLwFvy1/yI4V6eV/v2xSRzf9d313/npHBxvFU8Ewj1GJXcQF04mc+UUPUEdY16n28Rw2Dg112JXA+YbsITBxp+dSp7OBMbuZyMqejVKfPyZmh+FdvF/BjlYa2nGRexxsnZp+2BPgkEfyZijXjjR6jWJ4OUdCl35ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384714; c=relaxed/simple;
	bh=+EYNV8FrSEdqFajoOG29EBcLyHxVLuhvwJUsa3vaiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqT3xmtyRgFyG21KjuJx6U7T0vk7ovCpzfgZb0YvVa+kZom4faSq8KwhM5oEYSxVipQ1qR3GU9A5NjaAN47nhFKUJiLXIq84hvZSRTWpZR6m5b1DOqvpmWUWIuid3LFygQLFZbpiTO9qkALsJKALTCLcTSGHcr+8W6i6xkk8eHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z9rqQ07i; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21fb368b468so343520fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710384711; x=1710989511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmPhMoh7yooYD/bXkTsN1nBpv6o1eZl498h/YwZndzA=;
        b=Z9rqQ07iWpwFbifbQ6InlTvNOHrAxRPhWKPZlQ5TT/bTy286jjHHJ4n9RHiqEgDFyq
         cjum62fS8nLBrXJWZt9dx+rkVv5x+G057MzxHdhPjtellxknz1gZsmwRAZkKnKbkQTNv
         NnQIx+5iTrBC+fWVb4pRdEdCt3UDom2s5RRWzG9pqQDDoCVF3PJ4ef2UJEDbc1C6hXOB
         Kinivi+SAQXes5Ns0DH42+MRqoE+o7WEMYSVQxxadTVBjwGCbZGIJ//8oHFUYyN33aGZ
         /hJJNuW7Q0IOkWSIh2zxLHcSNa+YE2j0FSOSII24EoHvEVz0CAV6+V9iiXr3UvyaHVe5
         uZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710384711; x=1710989511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmPhMoh7yooYD/bXkTsN1nBpv6o1eZl498h/YwZndzA=;
        b=J8wbuHR2YPYM64y8MSbGORcbX2jhQdlcMjvHM0X/9aV5p9CH/UdnquIOmM3L5JHvyS
         fN/UDnarUCMLv/hBOzNbPr15GkjwsToTjEXE4qextvXUjzQKUB3atoUPFF3JY93Op/n2
         0FpugzllRmhdP06lZLECNINqW+zcraMKrJYmCFy2rQG0mUg9GStF4QsGh1mZSIqYO5Pl
         RqoE0bGXRtPWbK7kwFgLLGvJVdM7Th+EBZNyh2vfMcCX7z7C/PelHn7gG9jCoWlCNL2x
         HcHEhiXcZZMAbL4/NolXapcbLufLBqusJks4Gl5Tl/Zy/FgX59EoJF0m4qOpMkilkIle
         5Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCUa3PhWKebzXeG95A+/8cunVpE/pJh7d5MK0SvUDZrszf3mTo7dKBmTSnL8p0mzN4CdD9b0bL6TCwHfr6H7aGFI179OK6N8Jv7pxAoO
X-Gm-Message-State: AOJu0YweAAZtoKbFDrOqfCsS6jPApCqH7hhLGX2XoNmsD6RTz002KJpS
	s7N1Brgu663Qg8PO25cS6byay6ZLh1PiEcjXDA/MOKIYEBqLqenfz9NS+c2u2OM=
X-Google-Smtp-Source: AGHT+IGCHNssxZ0wWF82FsWC9RxpZCLhW0D1wkXR00VIe/SijvydBz0DRqvVYF4Nf3e5Z+748JriDQ==
X-Received: by 2002:a05:6870:818e:b0:222:61c9:3e8b with SMTP id k14-20020a056870818e00b0022261c93e8bmr572811oae.23.1710384710806;
        Wed, 13 Mar 2024 19:51:50 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:c3a2:fcab:1ebb:b50c])
        by smtp.gmail.com with ESMTPSA id n64-20020a634043000000b005d8b2f04eb7sm343931pga.62.2024.03.13.19.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:51:44 -0700 (PDT)
Date: Wed, 13 Mar 2024 19:51:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"david.laight@aculab.com" <david.laight@aculab.com>,
	"Li, Haicheng" <haicheng.li@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] riscv: Optimize crc32 with Zbc extension
Message-ID: <ZfJmPiD/FrDbL1kE@ghost>
References: <20240313032139.3763427-1-xiao.w.wang@intel.com>
 <ZfIs5ND0S08N2zLd@ghost>
 <DM8PR11MB57514B86A2C1AA40973AF705B8292@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57514B86A2C1AA40973AF705B8292@DM8PR11MB5751.namprd11.prod.outlook.com>

On Thu, Mar 14, 2024 at 02:32:57AM +0000, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > Sent: Thursday, March 14, 2024 6:47 AM
> > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; ajones@ventanamicro.com;
> > conor.dooley@microchip.com; heiko@sntech.de; david.laight@aculab.com;
> > Li, Haicheng <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] riscv: Optimize crc32 with Zbc extension
> > 
> > On Wed, Mar 13, 2024 at 11:21:39AM +0800, Xiao Wang wrote:
> > > As suggested by the B-ext spec, the Zbc (carry-less multiplication)
> > > instructions can be used to accelerate CRC calculations. Currently, the
> > > crc32 is the most widely used crc function inside kernel, so this patch
> > > focuses on the optimization of just the crc32 APIs.
> > >
> > > Compared with the current table-lookup based optimization, Zbc based
> > > optimization can also achieve large stride during CRC calculation loop,
> > > meantime, it avoids the memory access latency of the table-lookup based
> > > implementation and it reduces memory footprint.
> > >
> > > If Zbc feature is not supported in a runtime environment, then the
> > > table-lookup based implementation would serve as fallback via alternative
> > > mechanism.
> > >
> > > By inspecting the vmlinux built by gcc v12.2.0 with default optimization
> > > level (-O2), we can see below instruction count change for each 8-byte
> > > stride in the CRC32 loop:
> > >
> > > rv64: crc32_be (54->31), crc32_le (54->13), __crc32c_le (54->13)
> > > rv32: crc32_be (50->32), crc32_le (50->16), __crc32c_le (50->16)
> > 
> > Even though this loop is optimized, there are a lot of other
> > instructions being executed else where for these tests. When running the
> > test-case in QEMU with ZBC enabled, I get these results:
> > 
> > [    0.353444] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
> > [    0.353470] crc32: self tests passed, processed 225944 bytes in 2044700
> > nsec
> > [    0.354098] crc32c: CRC_LE_BITS = 64
> > [    0.354114] crc32c: self tests passed, processed 112972 bytes in 289000
> > nsec
> > [    0.387204] crc32_combine: 8373 self tests passed
> > [    0.419881] crc32c_combine: 8373 self tests passed
> > 
> > Then when running with ZBC disabled I get:
> > 
> > [    0.351331] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
> > [    0.351359] crc32: self tests passed, processed 225944 bytes in 567500
> > nsec
> > [    0.352071] crc32c: CRC_LE_BITS = 64
> > [    0.352090] crc32c: self tests passed, processed 112972 bytes in 289900
> > nsec
> > [    0.385395] crc32_combine: 8373 self tests passed
> > [    0.418180] crc32c_combine: 8373 self tests passed
> > 
> > This is QEMU so it's not a perfect representation of hardware, but being
> > 4 times slower with ZBC seems suspicious. I ran these tests numerous
> > times and got similar results. Do you know why these tests would perform
> > 4 times better without ZBC?
> 
> ZBC instruction' functionality is relatively more complex, so QEMU tcg uses the
> helper function mechanism to emulate these ZBC instructions. Helper function
> gets called for each ZBC instruction within tcg JIT code, which is inefficient. I see
> similar issue about the Vector extension, the optimized RVV implementation runs
> actually much slower than the scalar implementation on QEMU tcg.

Okay I will take your word for it :)

> 
> > 
> > >
> > > The compile target CPU is little endian, extra effort is needed for byte
> > > swapping for the crc32_be API, thus, the instruction count change is not
> > > as significant as that in the *_le cases.
> > >
> > > This patch is tested on QEMU VM with the kernel CRC32 selftest for both
> > > rv64 and rv32.
> > >
> > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > ---
> > > v3:
> > > - Use Zbc to handle also the data head and tail bytes, instead of calling
> > >   fallback function.
> > > - Misc changes due to the new design.
> > >
> > > v2:
> > > - Fix sparse warnings about type casting. (lkp)
> > > - Add info about instruction count change in commit log. (Andrew)
> > > - Use the min() helper from linux/minmax.h. (Andrew)
> > > - Use "#if __riscv_xlen == 64" macro check to differentiate rv64 and rv32.
> > (Andrew)
> > > - Line up several macro values by tab. (Andrew)
> > > - Make poly_qt as "unsigned long" to unify the code for rv64 and rv32.
> > (David)
> > > - Fix the style of comment wing. (Andrew)
> > > - Add function wrappers for the asm code for the *_le cases. (Andrew)
> > > ---
> > >  arch/riscv/Kconfig      |  23 ++++
> > >  arch/riscv/lib/Makefile |   1 +
> > >  arch/riscv/lib/crc32.c  | 294
> 
> [...]
> > > +static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
> > > +					  size_t len, u32 poly,
> > > +					  unsigned long poly_qt,
> > > +					  fallback crc_fb)
> > > +{
> > > +	size_t offset, head_len, tail_len;
> > > +	unsigned long const *p_ul;
> > > +	unsigned long s;
> > > +
> > > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > 
> > This needs to be changed to be asm goto:
> > 
> > 4356e9f841f7f ("work around gcc bugs with 'asm goto' with outputs")
> > 
> 
> Thanks for the pointer. Will change it.
> 
> > > +				      RISCV_ISA_EXT_ZBC, 1)
> > > +			  : : : : legacy);
> > > +
> > > +	/* Handle the unaligned head. */
> > > +	offset = (unsigned long)p & OFFSET_MASK;
> > > +	if (offset && len) {
> > 
> > If len is 0 nothing in the function seems like it will modify crc. Is there
> > a reason to not break out immediately if len is 0?
> > 
> 
> Yeah, if len is 0, then crc won't be modified.
> Normally in scenarios like hash value calculation and packets CRC check,
> the "len" can hardly be zero. And software usually avoids unaligned buf
> addr, which means the "offset" here mostly is false.
> 
> So if we add a "len == 0" check at the beginning of this function, it will
> introduce a branch overhead for the most cases.

That makes sense thank you. 

> 
> > > +		head_len = min(STEP - offset, len);
> > > +		crc = crc32_le_unaligned(crc, p, head_len, poly, poly_qt);
> > > +		p += head_len;
> > > +		len -= head_len;
> > > +	}
> > > +
> > > +	tail_len = len & OFFSET_MASK;
> > > +	len = len >> STEP_ORDER;
> > > +	p_ul = (unsigned long const *)p;
> > > +
> > > +	for (int i = 0; i < len; i++) {
> > > +		s = crc32_le_prep(crc, p_ul);
> > > +		crc = crc32_le_zbc(s, poly, poly_qt);
> > > +		p_ul++;
> > > +	}
> > > +
> > > +	/* Handle the tail bytes. */
> > > +	p = (unsigned char const *)p_ul;
> > > +	if (tail_len)
> > > +		crc = crc32_le_unaligned(crc, p, tail_len, poly, poly_qt);
> > > +
> > > +	return crc;
> > > +
> > > +legacy:
> > > +	return crc_fb(crc, p, len);
> > > +}
> > > +
> > > +u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
> > > +{
> > > +	return crc32_le_generic(crc, p, len, CRC32_POLY_LE,
> > CRC32_POLY_QT_LE,
> > > +				crc32_le_base);
> > > +}
> > > +
> > > +u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
> > > +{
> > > +	return crc32_le_generic(crc, p, len, CRC32C_POLY_LE,
> > > +				CRC32C_POLY_QT_LE, __crc32c_le_base);
> > > +}
> > > +
> > > +static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
> > > +				     size_t len)
> > > +{
> > > +	size_t bits = len * 8;
> > > +	unsigned long s = 0;
> > > +	u32 crc_low = 0;
> > > +
> > > +	s = 0;
> > > +	for (int i = 0; i < len; i++)
> > > +		s = *p++ | (s << 8);
> > > +
> > > +	if (__riscv_xlen == 32 || len < sizeof(u32)) {
> > > +		s ^= crc >> (32 - bits);
> > > +		crc_low = crc << bits;
> > > +	} else {
> > > +		s ^= (unsigned long)crc << (bits - 32);
> > > +	}
> > > +
> > > +	crc = crc32_be_zbc(s);
> > > +	crc ^= crc_low;
> > > +
> > > +	return crc;
> > > +}
> > > +
> > > +u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
> > > +{
> > > +	size_t offset, head_len, tail_len;
> > > +	unsigned long const *p_ul;
> > > +	unsigned long s;
> > > +
> > > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > 
> > Same here
> > 
> 
> Will change it.
> 
> Thanks for the comments.
> -Xiao
> 

I am not familiar with this algorithm but this does seem like it should
show an improvement in hardware with ZBC, so there is no reason to hold
this from being merged.

When you change the asm goto so it will compile with 6.8 you can add my
tag:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

- Charlie


