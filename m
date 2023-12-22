Return-Path: <linux-kernel+bounces-9502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5581C69C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB81B2881E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEFCA59;
	Fri, 22 Dec 2023 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUrjoBpX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92A1DA32
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw3RHEplm+3wKRo41JY1pGYHPKanZ6Jye+Vpi6iDAho=;
	b=aUrjoBpXElFgBWARAHFdO+sxzLpphmxhkkniwKp7KSt+uvblibwV4eBzwo5DmodN7w8XwS
	JcdJvwPGe8waXjjw0VRHOB0nNc/Ah09VN81fOvoIKBHsrAGnuAkz0+vgROHjB1/GH4U0GD
	Vn2Y9uyYg8mPyGJW1I9a1LnkvpwPs3k=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-KmVeYDizPHmWAlbPM0pzww-1; Fri, 22 Dec 2023 03:28:09 -0500
X-MC-Unique: KmVeYDizPHmWAlbPM0pzww-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9feae8dfdso1948553a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233688; x=1703838488;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw3RHEplm+3wKRo41JY1pGYHPKanZ6Jye+Vpi6iDAho=;
        b=cjg7eURanG4Fzm1xLAMqkO0zASZqnk9LAteVVrvfprPqYLKon9n2M5KyDZo55jtBsc
         bsMQMIqfsjuKIX+2YBGPKkcZ049/AhJ9VKo2nZjFXOBLNXUx0CjL8eOG9elsaEVwekAZ
         tPSnXM1TM5RJ1NT2I0JgULerBJtFvoJg4NCb827dz4znhdF2DV/+O8hzH3z1ecMrLMfS
         kTMcrfKyJOR8+pcTuNSSP/ANC99tiknhuCLIoLn03GbKp20XUGx9iw2y1Zh6brevl0sy
         NKgpx0xQ0Vs3RyFcV33/s9SOC4iHDo4noS1X7oJjPvytj5W9FhrJlNR+00lSmI/IVoiU
         XOQA==
X-Gm-Message-State: AOJu0YwAmS2z542S8w9DoLi9qEXWQVeeFSk8VeEXgm8P8gZ11HABHyPV
	4u94+vc9rkc4bTLfc4h3z/KIdZZQVwMYLDBOxOsVim0bN89kgCKQIA9zKzDT11RMXbrHpiWMk/d
	yDUWk4v55cYxUarBJfv02m5Aevh5EtJjY
X-Received: by 2002:a9d:6a19:0:b0:6d9:f4dd:190f with SMTP id g25-20020a9d6a19000000b006d9f4dd190fmr1214233otn.60.1703233688456;
        Fri, 22 Dec 2023 00:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo0yI0iJlF/BDgrjFZNiGJa7zRGJ+WeCVQE/5XG5PdcW5hwE/NS8oxdaiSqeh/JhKmViZiEw==
X-Received: by 2002:a9d:6a19:0:b0:6d9:f4dd:190f with SMTP id g25-20020a9d6a19000000b006d9f4dd190fmr1214228otn.60.1703233688211;
        Fri, 22 Dec 2023 00:28:08 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id f29-20020a63555d000000b005c60ad6c4absm2756348pgm.4.2023.12.22.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:28:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	guoren@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 05:27:52 -0300
Message-ID: <ZYVIiGJHOfLrVOIC@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYUhrTaXMqyRchyP@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <ZYUK2zUHjYBL0zO7@ghost> <ZYUPQIJ070BYDzJJ@LeoBras> <ZYUhrTaXMqyRchyP@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 09:42:05PM -0800, Charlie Jenkins wrote:
> On Fri, Dec 22, 2023 at 01:23:29AM -0300, Leonardo Bras wrote:
> > On Thu, Dec 21, 2023 at 08:04:43PM -0800, Charlie Jenkins wrote:
> > > On Fri, Dec 22, 2023 at 12:34:56AM -0300, Leonardo Bras wrote:
> > > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > 
> > > > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> > > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > > > directly.
> > > > 
> > > > ok
> > > > 
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > > > index f19f861cda54..1f538fc4448d 100644
> > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > @@ -16,15 +16,13 @@
> > > > >  
> > > > >  #ifdef CONFIG_64BIT
> > > > >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > > > > -#define STACK_TOP_MAX		TASK_SIZE_64
> > > > > +#define STACK_TOP_MAX		TASK_SIZE
> > > > 
> > > > It means STACK_TOP_MAX will be in 64BIT:
> > > > - TASK_SIZE_32 if compat_mode=y
> > > > - TASK_SIZE_64 if compat_mode=n
> > > > 
> > > > Makes sense for me.
> > > > 
> > > > >  
> > > > >  #define arch_get_mmap_end(addr, len, flags)			\
> > > > >  ({								\
> > > > >  	unsigned long mmap_end;					\
> > > > >  	typeof(addr) _addr = (addr);				\
> > > > > -	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > > -		mmap_end = STACK_TOP_MAX;			\
> > > > > -	else if ((_addr) >= VA_USER_SV57)			\
> > > > > +	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
> > > > >  		mmap_end = STACK_TOP_MAX;			\
> > > > >  	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > >  		mmap_end = VA_USER_SV48;			\
> > > > 
> > > > 
> > > > I don't think I got this change, or how it's connected to the commit msg.
> > > > 
> > > > Before:
> > > > - addr == 0, or addr > 2^57, or compat: mmap_end = STACK_TOP_MAX
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > 
> > > > Now:
> > > > - addr == 0, or addr > 2^57: mmap_end = STACK_TOP_MAX
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > - 0 < addr < 2^48 : mmap_end = 2^39
> > > > 
> > > > IIUC compat mode addr will be < 2^32, so will always have mmap_end = 2^39 
> > > > if addr != 0. Is that desireable? 
> > > > (if not, above change is unneeded)
> > > 
> > > I agree, this change does not make sense for compat mode. Compat mode
> > > should never return an address that is greater than 2^32, but this
> > > change allows that.
> > > 
> > > > 
> > > > Also, unrelated to the change:
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > Is the above correct?
> > > > It looks like it should be 2^57 instead, and a new if clause for 
> > > > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> > > 
> > > That is not the case. I documented this behavior and reasoning in
> > > Documentation/arch/riscv/vm-layout.rst in the "Userspace VAs" section.
> > > 
> > > I can reiterate here though. The hint address to mmap (defined here as
> > > "addr") is the maximum userspace address that mmap should provide. What
> > > you are describing is a minimum. The purpose of this change was to allow
> > > applications that are not compatible with a larger virtual address (such
> > > as applications like Java that use the upper bits of the VA to store
> > > data) to have a consistent way of specifying how many bits they would
> > > like to be left free in the VA. This requires to take the next lowest
> > > address space to guaruntee that all of the most-significant bits left
> > > clear in hint address do not end up populated in the virtual address
> > > returned by mmap.
> > > 
> > > - Charlie
> > 
> > Hello Charlie, thank you for helping me understand!
> > 
> > Ok, that does make sense now! The addr value hints "don't allocate > addr"
> > and thus:
> > 
> > - 0 < addr < 2^48 : mmap_end = 2^39
> > - 2^48 < addr < 2^57: mmap_end = 2^48
> > 
> > Ok, but then
> > - addr > 2^57: mmap_end = 2^57
> > right?
> > 
> > I mean, probably STACK_TOP_MAX in non-compat mode means 2^57 already, but 
> > having it explicitly like:
> > 
> >  else if ((_addr) >= VA_USER_SV57)                       \
> >          mmap_end = VA_USER_SV57;                        \
> > 
> > would not be better for a future full 64-bit addressing?
> > (since it's already on a different if clause)
> 
> I agree, that does make more sense.
> 
> > 
> > I could add comment on top of the macro with a short version on your addr 
> > hint description above. Would that be ok?
> 
> Sure :)

Sent, thanks!
Leo

> 
> - Charlie
> 
> > 
> > Thanks!
> > Leo
> > 
> > 
> > 
> > 
> > 
> > > 
> > > > 
> > > > Do I get it wrong?
> > > > 
> > > > (I will send an RFC 'fixing' the code the way I am whinking it should look 
> > > > like)
> > > > 
> > > > Thanks, 
> > > > Leo
> > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > -- 
> > > > > 2.40.1
> > > > > 
> > > > 
> > > 
> > 
> 


