Return-Path: <linux-kernel+bounces-49091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B798465CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA8289B74
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B125320D;
	Fri,  2 Feb 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BJzDeN4w"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCEBA25
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840892; cv=none; b=Vm80P3tM8u96Mt6DP46opPcXUH9UdwYqzyOWnlfawRoaLH+q3ghB9axgOwtK0rN5vbfE899FToIRaJuKvzE+zaB7fG4p7RkfcityZkhZ5g4nyotnHYyg/zQggGYTUWMGYz2kSi1uDwaFQ4ZJhavcq4PJOVIeC0+ozm5AlsvRs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840892; c=relaxed/simple;
	bh=rpDe5b+V/4D+ojZKAKLnU3kGC0FGFddkWQWVw2UB06A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bfx1fu7CBUKLiidF2n4fG8Jsz50DIadDcCcpeyOyx1D+4n0xWgB8TvQ7+6dhrifPETJYfGxBNHryr/gMw6iibJ08HI8PxLXO4UT3f52QBUSh/DSHM5lWEYWPcbmpnK3yMSli5RQTQpz+kvhTXPGlILQk1pKVd/bIUKEihDHCd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BJzDeN4w; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e11cda9f6fso940944a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706840889; x=1707445689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nH6kvi7IzHM1HjT9d3ebo606kaCmtup5eOU1YOyCeeQ=;
        b=BJzDeN4wHlZUpyJsHUvQuvMd93OWPeQhvpwM8dvkW2/Pu0WCqhedjZOoIwWkZesuL0
         fmrbQEnLB2GY1EX9lfdRpQM/ZfrMDyzumGFjHheU3Hf8PnawGCM5/9gkgYGJLmrWIqlp
         7KrTXNDMOmssAkXyDr7PPA9zMcndgrLjfxqLLxAx1lyaUnZzvjeoKsGc0dP9VykxiKl8
         5Kf8fWr99v92MCWVRIeoyhM/hIWZSiHe8Uw81CVGhb2ZR2IGAnaMIddd/ziYPbBWu0ms
         4iAhd3ZnredVIXW3FwJr4QDtx8gXCfBMKiPiKCeFK02ITbKlwhdIDoKic3nKSjDMEay6
         RkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840889; x=1707445689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH6kvi7IzHM1HjT9d3ebo606kaCmtup5eOU1YOyCeeQ=;
        b=MOUQJzxI9UKwjup6I+i2ijvxfhtx8/na4M2mxNPUMPe+tp9yG2M469itSMl3YtWZbV
         6v/nVNXIXLA/MenNW7Ux5KxGJRPV9ga3OQo2FmqjZTO9ykgo/UCJVqUISMRn5sckbmmw
         9GMLpYv60uu1Fh73/lShEC8NoJzH6tMeAK2fNryLHU6gdIUP9zt5WwHvNWEwPoGxCnk7
         JGZlAeQRg4j3nmnh4aFhtKbGMyl7mjDhUnNC+AeJ/JRJs0YEHE+X19izUeJnz6QUEFr1
         GeOYzcsKL2YEprVEsyhPB+D/lfiAhEnSBUcL/F9CqVxID91onfJ0F+j21rTyT7BQvQMt
         tbSg==
X-Gm-Message-State: AOJu0YyXarKX5wSM2ZJ+5MnUhvcBvHn6q2hQUS2huLkFudGGZPHvElNG
	vnGvlRRzK3DyMY84w7LL55bYqbTbQftEF6UqTmib8350lq/5yfQ84mMZ+ivXZmk=
X-Google-Smtp-Source: AGHT+IFp062ooy/IHYTf+Z1OQbUuwLGyLVscZ2fxBHLPNsW3kl1YytnGZuKwPGTv6LdCdXItOvcJDA==
X-Received: by 2002:a05:6358:6f9e:b0:175:f9b8:89bf with SMTP id s30-20020a0563586f9e00b00175f9b889bfmr754264rwn.22.1706840888844;
        Thu, 01 Feb 2024 18:28:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzW8HfzfBFndPbvvprCc2R3w70/c3RF57w2kO5sNhkjXiUc1+iJh25RmbGSpHdo5iPTXeHAnAB7skw2x1KEoPntxLdqUFcfINGL9DWhTDZaEPfW02nxrhVVq93LOqGqNgq0r2qw1V7QZ4yQQb9qzK9vG4gCQm+HEhoLTBwLMa67+YJOLZ31OGsXEicpDP0DEqDcubfynAm/g8XPvNWtIf9b3BlmflK4EEeYcg2uN/vMC9b1V1V3JenxQ0f8Fdb7boDEqhfd/fOEWa8BjnidQ1VNbmJzh8ygiJqy/NzNF8GnnxzaQLPE/xjCNrGBSeDM8QyHJD2o/RIpcqCU7zdkZSx+UdVKZjT1sw6QR6wH8bkgpWrrk+HXWDd54eS+Qerhkl4EURj
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm524464pgg.73.2024.02.01.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:28:08 -0800 (PST)
Date: Thu, 1 Feb 2024 18:28:06 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <ZbxTNjQPFKBatMq+@ghost>
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
 <20240130-use_mmap_hint_address-v3-1-8a655cfa8bcb@rivosinc.com>
 <tencent_83E0AB36A9A3032E5A4C4AC864A311DF9406@qq.com>
 <tencent_068B3B7AE01AC67885E4369AF14109CE6A0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_068B3B7AE01AC67885E4369AF14109CE6A0A@qq.com>

On Wed, Jan 31, 2024 at 11:59:43PM +0800, Yangyu Chen wrote:
> On Wed, 2024-01-31 at 22:41 +0800, Yangyu Chen wrote:
> > On Tue, 2024-01-30 at 17:07 -0800, Charlie Jenkins wrote:
> > > On riscv it is guaranteed that the address returned by mmap is less
> > > than
> > > the hint address. Allow mmap to return an address all the way up to
> > > addr, if provided, rather than just up to the lower address space.
> > > 
> > > This provides a performance benefit as well, allowing mmap to exit
> > > after
> > > checking that the address is in range rather than searching for a
> > > valid
> > > address.
> > > 
> > > It is possible to provide an address that uses at most the same
> > > number
> > > of bits, however it is significantly more computationally expensive
> > > to
> > > provide that number rather than setting the max to be the hint
> > > address.
> > > There is the instruction clz/clzw in Zbb that returns the highest
> > > set
> > > bit
> > > which could be used to performantly implement this, but it would
> > > still
> > > be slower than the current implementation. At worst case, half of
> > > the
> > > address would not be able to be allocated when a hint address is
> > > provided.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/processor.h | 27 +++++++++++---------------
> > > -
> > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/processor.h
> > > b/arch/riscv/include/asm/processor.h
> > > index f19f861cda54..8ece7a8f0e18 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -14,22 +14,16 @@
> > >  
> > >  #include <asm/ptrace.h>
> > >  
> > > -#ifdef CONFIG_64BIT
> > > -#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > -#define STACK_TOP_MAX		TASK_SIZE_64
> > > -
> > >  #define arch_get_mmap_end(addr, len, flags)			\
> > >  ({								\
> > >  	unsigned long
> > > mmap_end;					\
> > >  	typeof(addr) _addr = (addr);				\
> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > is_compat_task())) \
> > > +	if ((_addr) == 0 ||					\
> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> > > +	    ((_addr + len) > BIT(VA_BITS -
> > > 1)))			\
> > >  		mmap_end = STACK_TOP_MAX;			\
> > > -	else if ((_addr) >= VA_USER_SV57)			\
> > > -		mmap_end = STACK_TOP_MAX;			\
> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > VA_BITS_SV48)) \
> > > -		mmap_end = VA_USER_SV48;			\
> > >  	else							\
> > > -		mmap_end = VA_USER_SV39;			\
> > > +		mmap_end = (_addr + len);			\
> > >  	mmap_end;						\
> > >  })
> > >  
> > > @@ -39,17 +33,18 @@
> > >  	typeof(addr) _addr = (addr);				\
> > >  	typeof(base) _base = (base);				\
> > >  	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
> > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) &&
> > > is_compat_task())) \
> > > +	if ((_addr) == 0 ||					\
> > > +	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
> > > +	    ((_addr + len) > BIT(VA_BITS -
> > > 1)))			\
> > >  		mmap_base = (_base);				\
> > > -	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >=
> > > VA_BITS_SV57)) \
> > > -		mmap_base = VA_USER_SV57 - rnd_gap;		\
> > > -	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >=
> > > VA_BITS_SV48)) \
> > > -		mmap_base = VA_USER_SV48 - rnd_gap;		\
> > >  	else							\
> > > -		mmap_base = VA_USER_SV39 - rnd_gap;		\
> > > +		mmap_base = (_addr + len) - rnd_gap;		\
> > >  	mmap_base;						\
> > >  })
> > >  
> > > +#ifdef CONFIG_64BIT
> > > +#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > +#define STACK_TOP_MAX		TASK_SIZE_64
> > >  #else
> > >  #define DEFAULT_MAP_WINDOW	TASK_SIZE
> > >  #define STACK_TOP_MAX		TASK_SIZE
> > > 
> > 
> > I have carefully tested your patch on qemu with sv57. A bug that
> > needs
> > to be solved is that mmap with the same hint address without
> > MAP_FIXED
> > set will fail the second time.
> > 
> > Userspace code to reproduce the bug:
> > 
> > #include <sys/mman.h>
> > #include <stdio.h>
> > #include <stdint.h>
> > 
> > void test(char *addr) {
> >     char *res = mmap(addr, 4096, PROT_READ | PROT_WRITE,
> > MAP_ANONYMOUS
> > > MAP_PRIVATE, -1, 0);
> >     printf("hint %p got %p.\n", addr, res);
> > }
> > 
> > int main (void) {
> >     test(1<<30);
> >     test(1<<30);
> >     test(1<<30);
> >     return 0;
> > }
> > 
> > output:
> > 
> > hint 0x40000000 got 0x40000000.
> > hint 0x40000000 got 0xffffffffffffffff.
> > hint 0x40000000 got 0xffffffffffffffff.
> > 
> > output on x86:
> > 
> > hint 0x40000000 got 0x40000000.
> > hint 0x40000000 got 0x7f9171363000.
> > hint 0x40000000 got 0x7f9171362000.
> > 
> > It may need to implement a special arch_get_unmapped_area and
> > arch_get_unmapped_area_topdown function.
> > 
> 
> This is because hint address < rnd_gap. I have tried to let mmap_base =
> min((_addr + len), (base) + TASK_SIZE - DEFAULT_MAP_WINDOW). However it
> does not work for bottom-up while ulimit -s is unlimited. You said this
> behavior is expected from patch v2 review. However it brings a new
> regression even on sv39 systems.
> 
> I still don't know the reason why use addr+len as the upper-bound. I
> think solution like x86/arm64/powerpc provide two address space switch
> based on whether hint address above the default map window is enough.
> 

Yep this is expected. It is up to the maintainers to decide.

- Charlie


