Return-Path: <linux-kernel+bounces-9304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7581C3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3D91F25A14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8D6FC2;
	Fri, 22 Dec 2023 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g5QKOqVi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39163B5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb6e8708b7so977078b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703217886; x=1703822686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMbuyICQl6nMe9y2KZW9tM4PAnxgLD1bGygk69Ul4qI=;
        b=g5QKOqViMBUMoSnUGY6JKMgdzR3U/sqCDPGURtAoExF++rWUxnFTf+USoFYxklzUwK
         0fbnXqg7WL9KQQXoeQ/iYR+Q8sveyGT917KTkEX7qpeTisjlcuBhj5FPYLA15SXvoieR
         1PMbam61yIMw1NFGc/71tVbAlgO2maGZw5npimCNOv/LolX+S0FXQw8t9mLqluGwgdR8
         xEml8jpAHN4197KV7ge38wyO6DuvBKBltWOsh/ASohiOCfbigkXzrG51e5ueMK+B/3h4
         oGHzF+7SUN/PeRMtnnvMqC4k+VQu/03ADsoiY5k3atbOnYXqY5a58i2DsIMJc2dP9aJP
         Ldqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217886; x=1703822686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMbuyICQl6nMe9y2KZW9tM4PAnxgLD1bGygk69Ul4qI=;
        b=ao7MP8dQVSBvOGyt59PRFFPSk8YyFzuJJAOZBC2v/l2bfLyHAIs2js+9vhno55NYpS
         goLOPB4TybGIcuKA2hHwYIJ+J2EDhpHI3yuiWGnhVqsmbuoqNDazmyE+qVwCR0/Z6ZMM
         Zr8UKpbzrFGK+89HG1dKFrv7ZH8XPNAYiwciJzDNg6TlKVRsLY3rT6r/AfM0TcoheDr9
         9qYxN7v2AWmMJK5C8zgtKFAAhGIFmIkVS8RZZCdq7z8WI32kykrGvwCJbJ3i4DUlXRVP
         /3qYO7owtsx7/rAT/YLIa/dfe+4eFPaBeMvow6XVVi9hlNP5zndHtlTmUp7uAls0rxCJ
         6o2A==
X-Gm-Message-State: AOJu0YxIWXEVX4OErjHP9n1WnQAMy0JIowMEPV3YCVaMhncKIWka6zzo
	0QB/HUAdKi79ZYviniwXitRVBsWXI/2JqA==
X-Google-Smtp-Source: AGHT+IHXq5Glvort/8zooZ1cONqbJxMUnI4QjEEM2kI4kr0xLRxYvX/XwiS3CJjJ1rCS66QRkiGFCQ==
X-Received: by 2002:a05:6359:4c27:b0:170:c2d0:7236 with SMTP id kj39-20020a0563594c2700b00170c2d07236mr872470rwc.27.1703217885712;
        Thu, 21 Dec 2023 20:04:45 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:9585:2e30:5aba:e80c])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a001ac700b006d7310a683dsm2356295pfv.80.2023.12.21.20.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:04:45 -0800 (PST)
Date: Thu, 21 Dec 2023 20:04:43 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	alexghiti@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com,
	panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com,
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Message-ID: <ZYUK2zUHjYBL0zO7@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYUD4C1aXWt2oFJo@LeoBras>

On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > directly.
> 
> ok
> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..1f538fc4448d 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -16,15 +16,13 @@
> >  
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > -#define STACK_TOP_MAX		TASK_SIZE_64
> > +#define STACK_TOP_MAX		TASK_SIZE
> 
> It means STACK_TOP_MAX will be in 64BIT:
> - TASK_SIZE_32 if compat_mode=y
> - TASK_SIZE_64 if compat_mode=n
> 
> Makes sense for me.
> 
> >  
> >  #define arch_get_mmap_end(addr, len, flags)			\
> >  ({								\
> >  	unsigned long mmap_end;					\
> >  	typeof(addr) _addr = (addr);				\
> > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > -		mmap_end = STACK_TOP_MAX;			\
> > -	else if ((_addr) >= VA_USER_SV57)			\
> > +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
> >  		mmap_end = STACK_TOP_MAX;			\
> >  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> >  		mmap_end = VA_USER_SV48;			\
> 
> 
> I don't think I got this change, or how it's connected to the commit msg.
> 
> Before:
> - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> - 2^48 < addr < 2^57: mmap_end = 2^48
> - 0 < addr < 2^48 : mmap_end = 2^39
> 
> Now:
> - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> - 2^48 < addr < 2^57: mmap_end = 2^48
> - 0 < addr < 2^48 : mmap_end = 2^39
> 
> IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
> if addr != 0. Is that desireable? 
> (if not, above change is unneeded)

I agree, this change does not make sense for compat mode. Compat mode
should never return an address that is greater than 2^32, but this
change allows that.

> 
> Also, unrelated to the change:
> - 2^48 < addr < 2^57: mmap_end = 2^48
> Is the above correct?
> It looks like it should be 2^57 instead, and a new if clause for 
> 2^32 < addr < 2^48 should have mmap_end = 2^48.

That is not the case. I documented this behavior and reasoning in
Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.

I can reiterate here though. The hint address to mmap (defined here as
"addr") is the maximum userspace address that mmap should provide. What
you are describing is a minimum. The purpose of this change was to allow
applications that are not compatible with a larger virtual address (such
as applications like Java that use the upper bits of the VA to store
data) to have a consistent way of specifying how many bits they would
like to be left free in the VA. This requires to take the next lowest
address space to guaruntee that all of the most-significant bits left
clear in hint address do not end up populated in the virtual address
returned by mmap.

- Charlie

> 
> Do I get it wrong?
> 
> (I will send an RFC 'fixing' the code the way I am whinking it should look 
> like)
> 
> Thanks, 
> Leo
> 
> 
> 
> 
> 
> > -- 
> > 2.40.1
> > 
> 

