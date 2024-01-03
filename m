Return-Path: <linux-kernel+bounces-15900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BD82354D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453B3B23E58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8C1CF9B;
	Wed,  3 Jan 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+A0L8y7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26E1CF89
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704308677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Sk8miiHF/d2ya2q7kYXl8D7bd/oZPlQyy/ElPudR44=;
	b=Y+A0L8y7OyE3Oz9ubJGFQ/BxYPgf0iU0EenjVGcCRS7RO0MiLB/tCX92su9wTaR3KWujzP
	1YZ2rvEES8K/vl6G0P/1KdKgqawCF/hjq/VDXHyDcdDxle83Ekat+VLacyADcJG28LfugK
	EOon8lAR3RLh8sq7Uze77E9YLCue9X0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-T2iJvoI_OU6CB0DU2kKsfg-1; Wed, 03 Jan 2024 14:04:35 -0500
X-MC-Unique: T2iJvoI_OU6CB0DU2kKsfg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so1144894a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308674; x=1704913474;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sk8miiHF/d2ya2q7kYXl8D7bd/oZPlQyy/ElPudR44=;
        b=BZ5fX/f4mpk3oVfyhln1IVluwIVxb7SSreOy4p2wrnXceqdQ0e2C5KudVO1IsG7Ueo
         60iYC7jjuHAxU6E+ORWK4WK3vvunZRbbdTgItqfGapRR3PguT4mGdD6QE04geYxgyRl7
         voNSg31CHsb2rOWHkg+n4IhHmSMlZVYCTU7BFLHQJ27SAaF+9sZRr4/z0HwBGFf9kW9O
         F0mjZEsWyv4Hb6x3UUCJDho/ox2QAom57T/X+MmzD2BdC6+M1BYku6R1fWlkJLlFPPBd
         UpBRWIpWe8qSNcs4ZZMmol8iyVAjPn9xHIAw7IfBbx3p6qgFNzwmcsnpiIYcJp6+N6Hw
         bwYQ==
X-Gm-Message-State: AOJu0YzJWcnnqVQl9K4gWiRadnKa9HNrFPcbqTdjAPKn32XYpZGvMqfd
	sb+L558q884BHLGTz4Vn5bYRUNjmfAL+uouE4aISx+2T2yi50GQ8hZ7wVTqchzKfJTDJFVe64fB
	xNL368RZgEANM/p+vamz9fVk/LqeUMo1Q
X-Received: by 2002:a17:903:1251:b0:1d3:b308:ad9c with SMTP id u17-20020a170903125100b001d3b308ad9cmr9386188plh.80.1704308673984;
        Wed, 03 Jan 2024 11:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPHqiwKr7qkMiDorzX91GY7F09uOlrak6QKhMSD7AKHawP9SCvQwH7Z+HT1U6vepc4nhnGuw==
X-Received: by 2002:a17:903:1251:b0:1d3:b308:ad9c with SMTP id u17-20020a170903125100b001d3b308ad9cmr9386167plh.80.1704308673715;
        Wed, 03 Jan 2024 11:04:33 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b001d4c955cc00sm3410994plg.271.2024.01.03.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:04:32 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	ajones@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
Date: Wed,  3 Jan 2024 16:04:20 -0300
Message-ID: <ZZWvtFaF5KPLt8Aw@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTTZeN+rfG6szdB+J1QySQ2tAadwpG_zt2cRir7Bn+Yh4g@mail.gmail.com>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-3-guoren@kernel.org> <CAJF2gTTZeN+rfG6szdB+J1QySQ2tAadwpG_zt2cRir7Bn+Yh4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 01, 2024 at 10:29:21AM +0800, Guo Ren wrote:
> On Sun, Dec 31, 2023 at 4:30 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Enable Linux prefetchw primitive with Zibop cpufeature, which preloads
> > cache line into L1 cache for the next write operation.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..8d3a2ab37678 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -13,6 +13,9 @@
> >  #include <vdso/processor.h>
> >
> >  #include <asm/ptrace.h>
> > +#include <asm/insn-def.h>
> > +#include <asm/alternative-macros.h>
> > +#include <asm/hwcap.h>
> >
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
> > @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> >  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->epc)
> >  #define KSTK_ESP(tsk)          (task_pt_regs(tsk)->sp)
> >
> > +#ifdef CONFIG_RISCV_ISA_ZICBOP
> > +#define ARCH_HAS_PREFETCHW
> > +
> > +#define PREFETCHW_ASM(x)                                               \
> > +       ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,                 \
> > +                   RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
> The PREFETCHW_ASM(x) definition should be out of "ifdef
> CONFIG_RISCV_ISA_ZICBOP... #endif", because xchg_small may use this
> macro without CONFIG_RISCV_ISA_ZICBOP.
> 

Agree :)

> > +
> > +
> > +static inline void prefetchw(const void *x)
> > +{
> > +       __asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> > +}
> > +#endif /* CONFIG_RISCV_ISA_ZICBOP */
> >
> >  /* Do necessary setup to start up a newly executed thread. */
> >  extern void start_thread(struct pt_regs *regs,
> > --
> > 2.40.1
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


