Return-Path: <linux-kernel+bounces-9297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9281C3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C861C23B85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3D23B1;
	Fri, 22 Dec 2023 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="15vgExlf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D901C01
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-202ffc46e15so663643fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703217031; x=1703821831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYYQ0eaJfGl5fZFAc7fvgOmI29R64LQaVNr4Dz/XHbI=;
        b=15vgExlfTIbaOUamvsbOl1n7yJsYOrsvPAgpazryg18sWQPGsibvy4nhRqdc1/hbM+
         PskQkzS1RncV9XLdahmnYfpyQp9kMsSRJX4vOreWAz1KPEcqs8VOyg8w3wps/zecBAbq
         2r73Q6bq69SVpoDsQ99NpemZNf9PIkr+wlPrWt/EnLcb5d1dGKicZ9wF4/CVsWnMST48
         kdgKbqNhDsAMcDodzyA6i9DAnjVgl/QafQnUeWBfPCK8Vd1+to/Pc9W/qRzd9FkBxdCl
         ut35A9NGof9HjcC4vewVMhR6JMRa7bxQfgBI7UQAdKjn1gGjBSvYCyQhga914Bq22rlH
         HhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217031; x=1703821831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYYQ0eaJfGl5fZFAc7fvgOmI29R64LQaVNr4Dz/XHbI=;
        b=gl1a0YzTolI6dUuBpEt5oBbg+JU7UEwAZ+2zl8xr/rroST89QBsukYepo9NwqR+KZD
         cvQT/6FGv46okniLotpPEXKzaSFPBVcfhYnUCsQsWAKRXQZgyAdtpErz/2HoOcCMDN/p
         2sMRqwKJiWSmLy6HrUkvw31PBGOt8/9AI9FCDSNBeXW9A3dKibiOs064ZacL0NQWLfab
         F84EyIiFhWyMbkQfL+1vB768M8VwPYbf4Oxuzk+2HlrQ0lk4h+6hruTWPDpWqHHk/Yq3
         C9IndZPSux2cfXunKuaRLiiL2mgMDBHCE9wsGbl/rkwM8Kkj0FJCbI3gSkF3ffN8uoWU
         5z4A==
X-Gm-Message-State: AOJu0Yy5JC47txSTvx/x33I1/wREcm6kC7k5glsE5aIASxjOt9FAiQHS
	qdXKWs0iMJfIygpT0QW+oLXBznr/Y/DcsA==
X-Google-Smtp-Source: AGHT+IFt6GCsozB3jubH8uMt2MuLURJ3WSZcuhVSkJZ1iUth4pRyozMtRy8W9XYff73N9paT7hdKcQ==
X-Received: by 2002:a4a:98c4:0:b0:594:1bb4:93e9 with SMTP id b4-20020a4a98c4000000b005941bb493e9mr353161ooj.5.1703217031371;
        Thu, 21 Dec 2023 19:50:31 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:9585:2e30:5aba:e80c])
        by smtp.gmail.com with ESMTPSA id d9-20020a4aaa89000000b005912a3b64adsm602152oon.43.2023.12.21.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:50:30 -0800 (PST)
Date: Thu, 21 Dec 2023 19:50:27 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	alexghiti@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com,
	panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com,
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
Message-ID: <ZYUHg3kIMYdNSOSr@ghost>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-2-guoren@kernel.org>
 <ZYTriK9hjOFQou9Z@LeoBras>
 <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>

On Fri, Dec 22, 2023 at 10:57:16AM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 9:51 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > Hello Guo Ren,
> >
> > On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> > > 0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
> > > segment fault. Sometimes, it would cause boot failure when the whole
> > > rootfs is rv32.
> >
> > Checking if I get the scenario:
> >
> > In pgtable.h:
> > #ifdef CONFIG_64BIT
> > #define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > #define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> >
> > #ifdef CONFIG_COMPAT
> > #define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
> > #define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
> >                          TASK_SIZE_32 : TASK_SIZE_64)
> > #else
> > [...]
> >
> > Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_SIZE in
> > compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the thread_flag.
> >
> > from processor.h:
> > #ifdef CONFIG_64BIT
> > #define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
> > #define STACK_TOP_MAX           TASK_SIZE_64
> > [...]
> > #define STACK_TOP               DEFAULT_MAP_WINDOW
> >
> >
> > where:
> > #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
> > with MMAP_VA_BITS_64 being either 48 or 37.
> >
> > In compat mode,
> > STACK_TOP = 1 << (32 - 1)       -> 0x80000000
> > TASK_SIZE = 0x8000000 - 4k      -> 0x7ffff000
> >
> > IIUC, your suggestion is to make TASK_SIZE = STACK_TOP in compat mode only.
> Yes, it causes the problem, which causes the boot to fail.

I think what Leonardo is getting at is that it is odd that it would
cause boot issues if TASK_SIZE is not equal STACK_TOP. This seems
indicative of a different problem. While this may fix the issue, it
should be valid for TASK_SIZE to be less than STACK_TOP.

- Charlie

> 
> >
> > Then why not:
> > #ifdef CONFIG_COMPAT
> > #define TASK_SIZE_32    STACK_TOP
> Yes, it's the solution that I think at first. But I didn't find any
> problem with 0x7ffff000 ~ 0x80000000, and then I removed this gap to
> unify it with Sv39 and Sv48.
> 
> >
> > With some comments explaining why there is no need to reserve a PAGE_SIZE
> > in the TASK_SIZE_32.
> At first, I wanted to put a invalid page between the user & kernel
> space, but it seems useless.
> 
> >
> > Does that make sense?
> >
> > Thanks!
> > Leo
> >
> > >
> > > Freeing unused kernel image (initmem) memory: 2236K
> > > Run /sbin/init as init process
> > > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > > Run /etc/init as init process
> > > ...
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/pgtable.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > index ab00235b018f..74ffb2178f54 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> > >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > >
> > >  #ifdef CONFIG_COMPAT
> > > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
> >
> >
> >
> >
> > >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > >  #else
> > > --
> > > 2.40.1
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren

