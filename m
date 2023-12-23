Return-Path: <linux-kernel+bounces-10268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AE81D1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12E81C22EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4F15D1;
	Sat, 23 Dec 2023 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Coc+u9T/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCE1373
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bb89215406so1016182b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703302603; x=1703907403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gk7B3KrzxZzeHiI8miK48fRulREz0I4yE9Agea2Gg9U=;
        b=Coc+u9T/8dvxTivTI7N4X8SKFP7vBU/hLwhj/5BSA2rMCrwCxFsQsadSWePZQAY1Jg
         hd9HhP/1Ram83s5KKtI+eUl1annLYEEDGjYLaVTyJuxWMljOYHGneuB9hvqfNwzR60rq
         Jwix9xetr9sUQ72bfwMNEj7tC+4lMTrVr46xEuZOk9VAFeGumGGVT41AWZJnl8prBqm0
         3SQUAetjAMFeiHXz6/R2KvppDz4cb2DwliCZv431gDo07KAPYhOH86+EXszpGtuFCSvc
         PcJSGWMOWGyCQtNo8otyXwjZJ4M2FFF1ET1huWJgntHRhxPVsdPvlgSsqXcp08LuSRUR
         X0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703302603; x=1703907403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk7B3KrzxZzeHiI8miK48fRulREz0I4yE9Agea2Gg9U=;
        b=J5YupDWbtSWJatB986y07f5LG1jTfo6Dequz/l+OHT6yKDMm3tX6syz2siXHyj4BZn
         o5Fj6osanNBp9/HXMc+EKqMwYVLCn0uZepkRupgQyG6UmiGTdn//iyjyeBKiq//Jb47I
         OG8tag30OH4bSukjbpk/HiNaqhWuPNAZCfjVlaC2uEhYjgjBnIaC1S2L+ONwAAXzh+4w
         4EHCPB8I2UX3rxm+l4t3iwU0vuCNhtlP/FH6PCzUmANaZMeG6anSDbqmdhTYrhQI7GKZ
         7EnHayVaGX06PRzNESVYfT+V/E9UtlP96pFaDBDByrVrTWEx7JJMC2m9yfH9oZMEi4yd
         qEaw==
X-Gm-Message-State: AOJu0YywOKQ8yOg3RlHRO858zVaoooVpr57cyghRQFmGMoI+oayOsU7l
	ysM4veJCMjrkt6Q+9RcUnxFAynzb1N+RDA==
X-Google-Smtp-Source: AGHT+IEO5Ec5EkwzWH54J3IM8DaQZHy+XPgAcqVlCFHOsQy9QN6dPasA91RGiJdI57DVf/XdxwNHFA==
X-Received: by 2002:a05:6808:189d:b0:3b8:b063:9b52 with SMTP id bi29-20020a056808189d00b003b8b0639b52mr2825068oib.68.1703302603572;
        Fri, 22 Dec 2023 19:36:43 -0800 (PST)
Received: from ghost ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id cp15-20020a056808358f00b003b85bd22147sm806729oib.49.2023.12.22.19.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 19:36:43 -0800 (PST)
Date: Fri, 22 Dec 2023 19:36:39 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	alexghiti@rivosinc.com, xiao.w.wang@intel.com, david@redhat.com,
	panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com,
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH V3 1/4] riscv: mm: Fixup compat mode boot failure
Message-ID: <ZYZVx58W7f3inR7m@ghost>
References: <20231222115703.2404036-1-guoren@kernel.org>
 <20231222115703.2404036-2-guoren@kernel.org>
 <ZYZMsgL9Bcz1J_Bd@LeoBras>
 <CAJF2gTR7VvHhm4QUpEkk8P=b__HqbXZ7ggW9DvkD1fUpoKPTew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTR7VvHhm4QUpEkk8P=b__HqbXZ7ggW9DvkD1fUpoKPTew@mail.gmail.com>

On Sat, Dec 23, 2023 at 11:07:29AM +0800, Guo Ren wrote:
> On Sat, Dec 23, 2023 at 10:58 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 06:57:00AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > In COMPAT mode, the STACK_TOP is DEFAULT_MAP_WINDOW (0x80000000), but
> > > the TASK_SIZE is 0x7fff000. When the user stack is upon 0x7fff000, it
> > > will cause a user segment fault. Sometimes, it would cause boot
> > > failure when the whole rootfs is rv32.
> > >
> > > Freeing unused kernel image (initmem) memory: 2236K
> > > Run /sbin/init as init process
> > > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > > Run /etc/init as init process
> > > ...
> > >
> > > Increase the TASK_SIZE to cover STACK_TOP.
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
> > >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > >  #else
> > > --
> > > 2.40.1
> > >
> >
> > I am not really involved in the issue this is solving, so I have no
> > technical opinion on the solution.
> >
> > IIUC there should always be (TASK_SIZE >= STACK_TOP), so by itself this
> > is fixing an issue.
> >
> > I have reviewed the code and it does exactly as stated into the commit
> > message, so FWIW:
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Thx,
> 
> I found this problem because it can't boot my rv32 buildroot-rootfs in
> v6.6. But it's okay in v6.5. So I used git bisect and found commit:
> add2cc6b6515 ("RISC-V: mm: Restrict address space for
> sv39,sv48,sv57"), which caused that.
> 
> Ping Charlie, I hope it can be fixed in the v6.6 long-term version.

I have looked at this more I do agree that this change makes sense. I
was thinking that it was valid to have STACK_TOP that was greater than
TASK_SIZE but I am no longer convinced that is true. Thank you for
looking into this.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> >
> 
> 
> 
> --
> Best Regards
>  Guo Ren

