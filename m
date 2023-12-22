Return-Path: <linux-kernel+bounces-9372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093C81C4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3AC287969
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671426120;
	Fri, 22 Dec 2023 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uSq/xtFj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D853A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1063320a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703223729; x=1703828529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tshARWagRRHxlEAjYIN29OCOP9SHjMXaawfRGNvVCMk=;
        b=uSq/xtFjp1MZW/GQolvTeipl2Zd/m1GFoUGqs2XglaT8rUx+ljR8e33CVwCGCHzEx4
         z8kYMlfZwUl+VhC85gz+Ku4jPEtsdrody8Qlhe9TJSBgjBzjytl1VSDbWSLoPFnuNLk8
         EjjxLHXsdYeNvhPcWZsD/73scShRP/ykW/svFoGreaYjFFUmljHekpTJrUIV3rkel19N
         osTruUbqCQGRL6mApXJ5s/Q/oBrtyWQ+Jo4pcWZhbIspy9TKnYzzfYBT+1tMVP03vtrL
         /7HmVFDxTvyQTSLEg3NJwrEauhc6lDiWRsK4rBVFi8Oz25v8UZ4WRb/ssyyZDCyfg8vp
         NEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703223729; x=1703828529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tshARWagRRHxlEAjYIN29OCOP9SHjMXaawfRGNvVCMk=;
        b=Liz9NjpFZ9s9KqGgMAjYKe3B02TD3KzAIChT1zZcmbAGYL0FVfWv0CKu3cyNvkC2iU
         IfX7CAmxMSboHu0XjBQiYM6vBJFVSpjO2epr3+Me+F1RvycS7nVNcg9Ddwibl2tamQzG
         4HGmrHYDBrwIdcIK91VLHUwODuCObjcsgeU8rk/RSOTdHgDLyN6GTd02LLU7fp8Wov2K
         F1FhqIcmuOwyS9O4wmM88rj6fLawMCPPSOmeENODCJbiBpc0nQz+6dXKEQyP+kn7tSO6
         W/06ahcFfV7gCsGMDGvoRTpLLdSpUTm1VDo/2R/HUrv4ttseJhvI8M9HOEemMAcgfcPj
         CtzQ==
X-Gm-Message-State: AOJu0YyDJ9Cei7nV4PfT8il7lABSJjMhuc2t+gsKX53nkXm7sq3Ab2QH
	5edz7709f31zi8OGOfIIKF0tjIdFMhY+BVsS6IZOtYDfc0o=
X-Google-Smtp-Source: AGHT+IFPYN93FpZrSP6JEuX0E8+Rz/2HUmp3SPiiY3k73uCyVJqHwo4hbyYd5MYmWGrJPBD7tMIC/A==
X-Received: by 2002:a05:6a20:8404:b0:194:7c07:5f55 with SMTP id c4-20020a056a20840400b001947c075f55mr958883pzd.54.1703223729146;
        Thu, 21 Dec 2023 21:42:09 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:f06:7450:7dd4:fc1d])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78d1a000000b006d974fe1b0esm2127879pfe.7.2023.12.21.21.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:42:08 -0800 (PST)
Date: Thu, 21 Dec 2023 21:42:05 -0800
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
Message-ID: <ZYUhrTaXMqyRchyP@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras>
 <ZYUK2zUHjYBL0zO7@ghost>
 <ZYUPQIJ070BYDzJJ@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYUPQIJ070BYDzJJ@LeoBras>

On Fri, Dec 22, 2023 at 01:23:29AM -0300, Leonardo Bras wrote:
> On Thu, Dec 21, 2023 at 08:04:43PM -0800, Charlie Jenkins wrote:
> > On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > 
> > > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > > directly.
> > > 
> > > ok
> > > 
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > > index f19f861cda54..1f538fc4448d 100644
> > > > --- a/arch/riscv/include/asm/processor.h
> > > > +++ b/arch/riscv/include/asm/processor.h
> > > > @@ -16,15 +16,13 @@
> > > >  
> > > >  #ifdef CONFIG_64BIT
> > > >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > > -#define STACK_TOP_MAX		TASK_SIZE_64
> > > > +#define STACK_TOP_MAX		TASK_SIZE
> > > 
> > > It means STACK_TOP_MAX will be in 64BIT:
> > > - TASK_SIZE_32 if compat_mode=y
> > > - TASK_SIZE_64 if compat_mode=n
> > > 
> > > Makes sense for me.
> > > 
> > > >  
> > > >  #define arch_get_mmap_end(addr, len, flags)			\
> > > >  ({								\
> > > >  	unsigned long mmap_end;					\
> > > >  	typeof(addr) _addr = (addr);				\
> > > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > -		mmap_end = STACK_TOP_MAX;			\
> > > > -	else if ((_addr) >= VA_USER_SV57)			\
> > > > +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
> > > >  		mmap_end = STACK_TOP_MAX;			\
> > > >  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > >  		mmap_end = VA_USER_SV48;			\
> > > 
> > > 
> > > I don't think I got this change, or how it's connected to the commit msg.
> > > 
> > > Before:
> > > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > 
> > > Now:
> > > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > 
> > > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
> > > if addr != 0. Is that desireable? 
> > > (if not, above change is unneeded)
> > 
> > I agree, this change does not make sense for compat mode. Compat mode
> > should never return an address that is greater than 2^32, but this
> > change allows that.
> > 
> > > 
> > > Also, unrelated to the change:
> > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > Is the above correct?
> > > It looks like it should be 2^57 instead, and a new if clause for 
> > > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> > 
> > That is not the case. I documented this behavior and reasoning in
> > Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.
> > 
> > I can reiterate here though. The hint address to mmap (defined here as
> > "addr") is the maximum userspace address that mmap should provide. What
> > you are describing is a minimum. The purpose of this change was to allow
> > applications that are not compatible with a larger virtual address (such
> > as applications like Java that use the upper bits of the VA to store
> > data) to have a consistent way of specifying how many bits they would
> > like to be left free in the VA. This requires to take the next lowest
> > address space to guaruntee that all of the most-significant bits left
> > clear in hint address do not end up populated in the virtual address
> > returned by mmap.
> > 
> > - Charlie
> 
> Hello Charlie, thank you for helping me understand!
> 
> Ok, that does make sense now! The addr value hints "don't allocate > addr"
> and thus:
> 
> - 0 < addr < 2^48 : mmap_end = 2^39
> - 2^48 < addr < 2^57: mmap_end = 2^48
> 
> Ok, but then
> - addr > 2^57: mmap_end = 2^57
> right?
> 
> I mean, probably STACK_TOP_MAX in non-compat mode means 2^57 already, but 
> having it explicitly like:
> 
>  else if ((_addr) >= VA_USER_SV57)                       \
>          mmap_end = VA_USER_SV57;                        \
> 
> would not be better for a future full 64-bit addressing?
> (since it's already on a different if clause)

I agree, that does make more sense.

> 
> I could add comment on top of the macro with a short version on your addr 
> hint description above. Would that be ok?

Sure :)

- Charlie

> 
> Thanks!
> Leo
> 
> 
> 
> 
> 
> > 
> > > 
> > > Do I get it wrong?
> > > 
> > > (I will send an RFC 'fixing' the code the way I am whinking it should look 
> > > like)
> > > 
> > > Thanks, 
> > > Leo
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > -- 
> > > > 2.40.1
> > > > 
> > > 
> > 
> 

