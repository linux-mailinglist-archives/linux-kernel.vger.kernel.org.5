Return-Path: <linux-kernel+bounces-9938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5381CD81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B73B1C226C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395228DC4;
	Fri, 22 Dec 2023 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0oLBRWT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0728DB9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703265284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cqFAbdxj/IpuKwhr/dOiRTwiBgTE3bII6IeIMBlh9I=;
	b=A0oLBRWTSeKbrRXFGRqocks8WbwSOiFJW3IBFFwkz1k/R8QKVwT/Qlq508BLUhc5GQ3Xq2
	B/+yRDJlZM27UJCTxXp1jR0Bchaebw2jUE2AiZSje1/wZ99ZO0C4eIk4PuZcnNG4gFbEc7
	4lh2WustgbaENTNkYPUAKK+k71efjeQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-EAg--q8OMIe4nQlFM2B3oA-1; Fri, 22 Dec 2023 12:14:41 -0500
X-MC-Unique: EAg--q8OMIe4nQlFM2B3oA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d8d059a790so2252270b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703265280; x=1703870080;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cqFAbdxj/IpuKwhr/dOiRTwiBgTE3bII6IeIMBlh9I=;
        b=bRASjgt1EQDt9UWfXdzZFcCmDZ9i3GJqatqW2des+7q+oDz6NWVie+KUWa9d/7kvxT
         boldNf3E+jsHbxv+5Vpsdl+med3j32KDziv0RGrIQs74UpoC1EYxy2p2M64FWrugTW26
         kD/XXBqC/ByPl10L3sEZ747RbWYarDTHc+hXrrya5EvE+7brRSpqW0RQWD74D8SXvyU/
         4D+napeQaRPmksFRUtm8gD0Ahfev8oE9013bAYcvqQPk65fHvav/ltj6YnCoj4fEmdVJ
         boTqFQFwB4tpGhpSyF6fO+xUYWsPZGKB93DL9OVj02SAK+I8GC1gjB8NyZ0CnMTWSNXF
         w0/g==
X-Gm-Message-State: AOJu0Yy0yA+JDysN186QYbSbJ1dA+pRKKrsqQ2DDUEzr6zs5hZey/aXS
	PfIGvNTdNGZTSNuVIiiIEvSeLtJPUGoksQ99nvxBwWFpDpGddYB3HPaRN1Zitm5JDzDMiIyMpzs
	3A+RVWlUocImojreg3KACu3vQ/Xei6L/+
X-Received: by 2002:aa7:8611:0:b0:6d9:83a8:658a with SMTP id p17-20020aa78611000000b006d983a8658amr1601753pfn.43.1703265280012;
        Fri, 22 Dec 2023 09:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOb39+DJdojm7AE5y4BjhsDq+FHLdKJbJ61vcHGPwAVIRmEbCs30urzlKL/nvpj4gZy9icNQ==
X-Received: by 2002:aa7:8611:0:b0:6d9:83a8:658a with SMTP id p17-20020aa78611000000b006d983a8658amr1601741pfn.43.1703265279717;
        Fri, 22 Dec 2023 09:14:39 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b006d98f584ad5sm1180812pfh.199.2023.12.22.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:14:39 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greg Ungerer <gerg@kernel.org>,
	Vincent Chen <vincent.chen@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
Date: Fri, 22 Dec 2023 14:14:21 -0300
Message-ID: <ZYXD7XU8dXrE31Sq@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTSdrGhAihjYSn_9u8_Yup86GgLDELZSmHnYRc5K1BESBA@mail.gmail.com>
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-4-leobras@redhat.com> <CAJF2gTSdrGhAihjYSn_9u8_Yup86GgLDELZSmHnYRc5K1BESBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 07:20:36PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 3:47 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > task_user_regset_view() makes use of a function very similar to
> > is_compat_task(), but pointing to a any thread.
> >
> > In arm64 asm/compat.h there is a function very similar to that:
> > is_compat_thread(struct thread_info *thread)
> >
> > Copy this function to riscv asm/compat.h and make use of it into
> > task_user_regset_view().
> >
> > Also, introduce a compile-time test for CONFIG_COMPAT and simplify the
> > function code by removing the #ifdef.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/compat.h | 8 ++++++++
> >  arch/riscv/kernel/ptrace.c      | 6 +++---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> > index 91517b51b8e27..da4b28cd01a95 100644
> > --- a/arch/riscv/include/asm/compat.h
> > +++ b/arch/riscv/include/asm/compat.h
> > @@ -20,6 +20,14 @@ static inline int is_compat_task(void)
> >         return test_thread_flag(TIF_32BIT);
> >  }
> >
> > +static inline int is_compat_thread(struct thread_info *thread)
> > +{
> > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > +               return 0;
> We also could put this into is_compat_task().
> 

Yeah! it's done in a previous patch. :)

> > +
> > +       return test_ti_thread_flag(thread, TIF_32BIT);
> > +}
> > +
> >  struct compat_user_regs_struct {
> >         compat_ulong_t pc;
> >         compat_ulong_t ra;
> > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > index 2afe460de16a6..f362832123616 100644
> > --- a/arch/riscv/kernel/ptrace.c
> > +++ b/arch/riscv/kernel/ptrace.c
> > @@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
> >
> >         return ret;
> >  }
> > +#else
> > +static const struct user_regset_view compat_riscv_user_native_view = {};
> >  #endif /* CONFIG_COMPAT */
> >
> >  const struct user_regset_view *task_user_regset_view(struct task_struct *task)
> >  {
> > -#ifdef CONFIG_COMPAT
> > -       if (test_tsk_thread_flag(task, TIF_32BIT))
> > +       if (is_compat_thread(&task->thread_info))
> >                 return &compat_riscv_user_native_view;
> >         else
> > -#endif
> >                 return &riscv_user_native_view;
> >  }
> > --
> > 2.43.0
> >
> LGTM
> 
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks!
Leo

> 
> -- 
> Best Regards
>  Guo Ren
> 


