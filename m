Return-Path: <linux-kernel+bounces-9936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B117C81CD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D51F22B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC9128DB7;
	Fri, 22 Dec 2023 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFcZlwXd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804828DB1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703265163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJPw/6f1GAMSCdMx7JeeVoOTC8jzwbxE2TLobbWNwIc=;
	b=PFcZlwXd/cGC9tNVxB9nKPkVIgEuenPZAOR6IiE0T5Gva1ziBz6kJdyB9i4j0OR/qW65lz
	KlktrM5HMWhBEoHJPfK26jC3vhu5NJ0a+AoV0Kox00k+eQL0G2ioam5dmQ4MSqDc7Myb2R
	y9NF4RkL1piRZguInNvQIO3ib4RZBOQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-S5grENxUOYmDLdPEHudkyQ-1; Fri, 22 Dec 2023 12:12:41 -0500
X-MC-Unique: S5grENxUOYmDLdPEHudkyQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d8668f2d43so1051924b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703265160; x=1703869960;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJPw/6f1GAMSCdMx7JeeVoOTC8jzwbxE2TLobbWNwIc=;
        b=mxhJg3CxThkYfstObJ6KAhagkGeRSMUThdgbmuN68bKxdJnWYyyOZxxLppw5PAT46D
         xb24b0QMTxpdqEzlx3OyFOpTe4lw1NU+UZ/1w14hn269qJ/QTJaRWkpCb0u1sM73Pdja
         yZbx29ZmJmm8EduakheV1j7/kGUSbOKUVjwr5qWJ883mtyXDgf2jaU6PUe5/TbST2x9x
         O7t1LXTX1y2cTBp3//adDF47K1RDZC6obQPm+CBDxbPI1iyZZbJzcYXvfa/h+3pornEo
         oY1POF2PuWNXLTq4t+Tuz0R87FDxN5DB6Pf7VV6KD9Y20jRnKTBJ55dEy2GwE1oTOCl9
         ELLA==
X-Gm-Message-State: AOJu0YweyHYiHqibnmCuFNHgr40OIwkzoKOXo5f6PhYT9FLCNKx39sO5
	xHOizUKNqhKT8TblOW8niV+sEXL/ECP0+CGEHfNYNCgUYg/EG4WaMIrMLHfX8qugqhNtYLP/LwO
	nA6Zu+h8h1jBuUtVjMU0rqH6/Bqhc6Kcp
X-Received: by 2002:a05:6a00:d4a:b0:6d9:8d88:f22d with SMTP id n10-20020a056a000d4a00b006d98d88f22dmr746229pfv.58.1703265160659;
        Fri, 22 Dec 2023 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7wNapKmlISZasLTcF4quOdp7zfHeY3L6ZGyiqpO82xhVsohRw7uAy6lOP4gSXhFEz2yNRwg==
X-Received: by 2002:a05:6a00:d4a:b0:6d9:8d88:f22d with SMTP id n10-20020a056a000d4a00b006d98d88f22dmr746213pfv.58.1703265160316;
        Fri, 22 Dec 2023 09:12:40 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id jw1-20020a056a00928100b006d9771857c4sm3163611pfb.27.2023.12.22.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:12:39 -0800 (PST)
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
Subject: Re: [RFC PATCH 2/4] riscv: add compile-time test into is_compat_task()
Date: Fri, 22 Dec 2023 14:12:22 -0300
Message-ID: <ZYXDdlF1CFNpDdiV@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com>
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-3-leobras@redhat.com> <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 05:35:20PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 5:02 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > Currently several places will test for CONFIG_COMPAT before testing
> > is_compat_task(), probably in order to avoid a run-time test into the task
> > structure.
> >
> > Since is_compat_task() is an inlined function, it would be helpful to add a
> > compile-time test of CONFIG_COMPAT, making sure it always returns zero when
> > the option is not enabled during the kernel build.
> >
> > With this, the compiler is able to understand in build-time that
> > is_compat_task() will always return 0, and optimize-out some of the extra
> > code introduced by the option.
> >
> > This will also allow removing a lot #ifdefs that were introduced, and make
> > the code more clean.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/compat.h    | 3 +++
> >  arch/riscv/include/asm/elf.h       | 4 ----
> >  arch/riscv/include/asm/pgtable.h   | 6 ------
> >  arch/riscv/include/asm/processor.h | 4 ++--
> >  4 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> > index 2ac955b51148f..91517b51b8e27 100644
> > --- a/arch/riscv/include/asm/compat.h
> > +++ b/arch/riscv/include/asm/compat.h
> > @@ -14,6 +14,9 @@
> >
> >  static inline int is_compat_task(void)
> >  {
> > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > +               return 0;
> > +
> >         return test_thread_flag(TIF_32BIT);
> >  }
> >
> > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> > index 59a08367fddd7..2e88257cafaea 100644
> > --- a/arch/riscv/include/asm/elf.h
> > +++ b/arch/riscv/include/asm/elf.h
> > @@ -53,13 +53,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> >  #define ELF_ET_DYN_BASE                ((DEFAULT_MAP_WINDOW / 3) * 2)
> >
> >  #ifdef CONFIG_64BIT
> > -#ifdef CONFIG_COMPAT
> >  #define STACK_RND_MASK         (is_compat_task() ? \
> >                                  0x7ff >> (PAGE_SHIFT - 12) : \
> >                                  0x3ffff >> (PAGE_SHIFT - 12))
> > -#else
> > -#define STACK_RND_MASK         (0x3ffff >> (PAGE_SHIFT - 12))
> > -#endif
> >  #endif
> >
> >  /*
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 1d472b31e0cfe..ea5b269be223a 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -127,16 +127,10 @@
> >  #define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> >  #define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> >
> > -#ifdef CONFIG_COMPAT
> >  #define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
> >  #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
> >  #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
> >  #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_BITS_64)
> > -#else
> > -#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
> > -#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
> > -#endif /* CONFIG_COMPAT */
> > -
> >  #else
> >  #include <asm/pgtable-32.h>
> >  #endif /* CONFIG_64BIT */
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda549..ed32e53e55999 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -22,7 +22,7 @@
> >  ({                                                             \
> >         unsigned long mmap_end;                                 \
> >         typeof(addr) _addr = (addr);                            \
> > -       if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > +       if ((_addr) == 0 || is_compat_task())                   \
> >                 mmap_end = STACK_TOP_MAX;                       \
> >         else if ((_addr) >= VA_USER_SV57)                       \
> >                 mmap_end = STACK_TOP_MAX;                       \
> > @@ -39,7 +39,7 @@
> >         typeof(addr) _addr = (addr);                            \
> >         typeof(base) _base = (base);                            \
> >         unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);   \
> > -       if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
> > +       if ((_addr) == 0 || is_compat_task())                   \
> >                 mmap_base = (_base);                            \
> >         else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> >                 mmap_base = VA_USER_SV57 - rnd_gap;             \
> > --
> > 2.43.0
> >
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks!
Leo

> 
> -- 
> Best Regards
>  Guo Ren
> 


