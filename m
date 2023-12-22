Return-Path: <linux-kernel+bounces-9367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502281C4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE852871C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750C56120;
	Fri, 22 Dec 2023 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUYSVuGO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DB5390
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703222891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plbNf5A3ZlhXI2Ez9cBVzJuxB5rEcG2G+xtFHu5+tss=;
	b=BUYSVuGOuqZrycgGqvLhZkzA9YBKSLTc+GFbGI4ZI5MnVKwmeSBrpvZoBqOLIGq9IGYvk6
	sI93EcLJ5eCybcxCBit/OpGzY2JTI8RJhxzEuy5XBQWyYLHoszI9D1+DaqvUIqrM7oGRy6
	ck/j95X455rhTu5PYmr9sA+Btd33yhU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-p9Av6_HTN9iJKeQeaEpn0w-1; Fri, 22 Dec 2023 00:28:09 -0500
X-MC-Unique: p9Av6_HTN9iJKeQeaEpn0w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d82e9a60f6so1159450b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703222888; x=1703827688;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plbNf5A3ZlhXI2Ez9cBVzJuxB5rEcG2G+xtFHu5+tss=;
        b=JHYZFDnOpLEjPtCFF9yHWBu1p6M8RGudq7psk7RMiOsJF+S84l+L+egnL27jiouZlg
         rSkdz46fbhAQa0WZGLh8RZVY40HyH0FRq/JxdoXRtc/+GokwbEZ/dg+4Vx1lrbH94W7C
         UukWIVmyS/M/JCuR1A4guycnZqDqOyAqQzWAX1nQDCVYb8w5t2kiyfWeyhncfyoy7gVa
         lsCMQypHjs+B8If0EoDilNe6dkNV1yXUOXAQX8KB4YBfMSuMn13RMI5tTKHnU+ZZuBRv
         n3tlfFoATPP6y/osF77BCbWHpLH/Smpfk+UsURwOr4Ycl/QpRV0ffXDPhOpOGz8UqCGl
         6miQ==
X-Gm-Message-State: AOJu0Yy5DB3LvXGka9ZROLjS1EMZG9am1/ddqk7qteBukwKvCS2fKKWR
	qQ/s897VfgSfFG5m5hO/vaB9OI510qjxGnsX0DSg4SrK/rmh3NtMdXEWs3R0nJEeTpWGQMU3D8n
	jmNPz9dMKCMId5cqss6W+a2kdKNIF65Us
X-Received: by 2002:a05:6a20:978c:b0:195:1e04:11dc with SMTP id hx12-20020a056a20978c00b001951e0411dcmr547874pzc.46.1703222887957;
        Thu, 21 Dec 2023 21:28:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0cwpsBTtkI4cK5DOCiGcyzFp7iDmxf1j7x1Nho4sQzNtuZJWgQbbH2SgdZd8zDpJwHBxAIQ==
X-Received: by 2002:a05:6a20:978c:b0:195:1e04:11dc with SMTP id hx12-20020a056a20978c00b001951e0411dcmr547858pzc.46.1703222887605;
        Thu, 21 Dec 2023 21:28:07 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id bb5-20020a17090b008500b0028b0424a4bcsm129567pjb.54.2023.12.21.21.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:28:07 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
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
Date: Fri, 22 Dec 2023 02:27:47 -0300
Message-ID: <ZYUeU0URQvgw42jt@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com>
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org> <ZYUD4C1aXWt2oFJo@LeoBras> <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com> <ZYUT22KmGJ1tJSWx@LeoBras> <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 12:50:44PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 12:43 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 12:26:19PM +0800, Guo Ren wrote:
> > > On Fri, Dec 22, 2023 at 11:35 AM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
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
> > > > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > > > -#define STACK_TOP_MAX                TASK_SIZE_64
> > > > > +#define STACK_TOP_MAX                TASK_SIZE
> > > >
> > > > It means STACK_TOP_MAX will be in 64BIT:
> > > > - TASK_SIZE_32 if compat_mode=y
> > > > - TASK_SIZE_64 if compat_mode=n
> > > >
> > > > Makes sense for me.
> > > >
> > > > >
> > > > >  #define arch_get_mmap_end(addr, len, flags)                  \
> > > > >  ({                                                           \
> > > > >       unsigned long mmap_end;                                 \
> > > > >       typeof(addr) _addr = (addr);                            \
> > > > > -     if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > > > > -             mmap_end = STACK_TOP_MAX;                       \
> > > > > -     else if ((_addr) >= VA_USER_SV57)                       \
> > > > > +     if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \
> > > > >               mmap_end = STACK_TOP_MAX;                       \
> > > > >       else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> > > > >               mmap_end = VA_USER_SV48;                        \
> > > >
> > > >
> > > > I don't think I got this change, or how it's connected to the commit msg.
> > > The above is just code simplification; if STACK_TOP_MAX is TASK_SIZE, then
> > >
> > >      if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > >              mmap_end = STACK_TOP_MAX;                       \
> > >     else if ((_addr) >= VA_USER_SV57)                       \
> > >
> > > is equal to:
> > >
> > >      if ((_addr) == 0 || (_addr) >= VA_USER_SV57)            \
> >
> > I am failing to understand exactly how are they equal.
> > I mean, what in your STACK_TOP_MAX change made them equal?
> #define STACK_TOP_MAX TASK_SIZE
> #define TASK_SIZE       (is_compat_task() ? TASK_SIZE_32 : TASK_SIZE_64)
> 

yes, I am aware. Let's do a simple test with the new code and
addr = 2^27 (random 32-bit addr) and compat mode.

if ((_addr) == 0 || (_addr) >= VA_USER_SV57)
	// Evaluates to false: 2^27 != 0, and is < 2^57
else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) 
	// Evaluates to false: 2^27 < 2^48
else				
	mmap_end = VA_USER_SV39;	

mmap_end = VA_USER_SV39, even in compat_mode.

We need the extra is_compat_task() if we want to return 2^32.

Thanks!
Leo


> >
> > See below, the behavior changed:
> > >
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
> > > >
> >
> > ^
> >
> > With your change on STACK_TOP_MAX only (not changing arch_get_mmap_end),
> > you would have:
> >
> > - compat_mode & (0 < addr < 2^32)       -> mmap_end = 2^32
> compat_mode      -> mmap_end = 2^32
> 

This is correct! 
Yeah, since you changed STACK_TOP_MAX to be 2^32 in compat mode,
any addr value < 2^32 with compat value will return 2^32.
(without the change in arch_get_mmap_end(), that is.) 

> > - non-compat, addr == 0, or addr > 2^57 -> mmap_end = TASK_SIZE_64
> > - non-compat, (2^48 < addr < 2^57)      -> mmap_end = 2^48
> > - non-compat, (0 < addr < 2^48)         -> mmap_end = 2^39
> >
> > Which seems more likely, based on Charlie comments.
> >
> > Thanks,
> > Leo
> >
> > > > Also, unrelated to the change:
> > > > - 2^48 < addr < 2^57: mmap_end = 2^48
> > > > Is the above correct?
> > > > It looks like it should be 2^57 instead, and a new if clause for
> > > > 2^32 < addr < 2^48 should have mmap_end = 2^48.
> > > >
> > > > Do I get it wrong?
> > > Maybe I should move this into the optimization part.
> > >
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
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


