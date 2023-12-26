Return-Path: <linux-kernel+bounces-11627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E481E92E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79562828D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2801852;
	Tue, 26 Dec 2023 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLQdKftO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B917F8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703618252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdK0f/0c2zILkHBv6UT22HiRXjmxzbBvzXxtAPGfC4Y=;
	b=LLQdKftOEMzOTrhnzdIxi/DP37vNXi+A+ffql3hZcvO0/PdWE1wTyjmZcsleBwmXcC20qt
	9nYzctwcmZebrDjtAs+Lnk/jFebRYPptnW7Z0cWqg64DtmHFYXb8z8Atgat80mE0wpLPCW
	bHcd//rS0Fv0tdqHl9cOM08PYH9H0Ew=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-FZGXB0SdPvqQSFR39E-cXA-1; Tue, 26 Dec 2023 14:17:31 -0500
X-MC-Unique: FZGXB0SdPvqQSFR39E-cXA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-427a1de4fe5so85521631cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618251; x=1704223051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdK0f/0c2zILkHBv6UT22HiRXjmxzbBvzXxtAPGfC4Y=;
        b=RvQDre4TIMR9PGsMIl7ORiM98LILV0GF8goaYrwqtWPof6E9C62UseAN7Mntx+Kh4F
         k2nMId4ZrLPmXd8zxSdm5uZhsfTpQuH3mIRxQi4l4wixSSMX0uE5HQsM7GZTdVtr/s7R
         EiYKM8HoECIhF6QUV086UKYnA1wlkPnOiDkbf2/Bu041q2hqxfoiPSNfIx1lARtoKAGg
         mihvc+Pz67FvCTcbAWp9ujyIU0s0f9i0C202iQqx0b/Cw6adeEH53a56KR3zaEHGXjx6
         YC+nZaYGHiss3O0JHPZckW41ZtwyebQDrnn3wNc4QbfAbhuiawdlyMPGwsHMSfe3TY4v
         jSAA==
X-Gm-Message-State: AOJu0YywXviuYXNbFpDYuD90j0UyzsFew3l3wtgpF+654y3mVx5jakdH
	aYSpwqCUI0j68jgmLNpKhW7y0POv8DRiWeLXrT6G2wYB8JkMEi4xQ1ls3rqxJD+EBjDptCXacrr
	hhLpiX0EttjRFMIBwF88uwE3cPEK/Ankwy5vnKuQbCkW+AmTCtVXCP2Qs
X-Received: by 2002:a05:622a:1208:b0:427:96be:c4e with SMTP id y8-20020a05622a120800b0042796be0c4emr11564727qtx.66.1703618250932;
        Tue, 26 Dec 2023 11:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1eLOcp+E0yHa8VriPMM/d17V5DFXgjeZMlmedQhw8c1Be94njKTay/7N0fFvPLqfEvqTfpb42Dh35qfEwkPQ=
X-Received: by 2002:a05:622a:1208:b0:427:96be:c4e with SMTP id
 y8-20020a05622a120800b0042796be0c4emr11564704qtx.66.1703618250614; Tue, 26
 Dec 2023 11:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-3-leobras@redhat.com>
 <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com>
 <ZYXDdlF1CFNpDdiV@LeoBras> <CABgGipWmidzhf3PqyK9FWQCmKAuS9H31XECTL5XYjSL5m1Es4g@mail.gmail.com>
In-Reply-To: <CABgGipWmidzhf3PqyK9FWQCmKAuS9H31XECTL5XYjSL5m1Es4g@mail.gmail.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Tue, 26 Dec 2023 16:17:19 -0300
Message-ID: <CAJ6HWG5ooodxwi0HE7GVu4ffVETYPdTQJBzvsMcC6MJ6x1Ja_w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] riscv: add compile-time test into is_compat_task()
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Greg Ungerer <gerg@kernel.org>, Vincent Chen <vincent.chen@sifive.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Qinglin Pan <panqinglin2020@iscas.ac.cn>, 
	Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:15=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> On Sat, Dec 23, 2023 at 1:12=E2=80=AFAM Leonardo Bras <leobras@redhat.com=
> wrote:
> >
> > On Fri, Dec 22, 2023 at 05:35:20PM +0800, Guo Ren wrote:
> > > On Fri, Dec 22, 2023 at 5:02=E2=80=AFPM Leonardo Bras <leobras@redhat=
.com> wrote:
> > > >
> > > > Currently several places will test for CONFIG_COMPAT before testing
> > > > is_compat_task(), probably in order to avoid a run-time test into t=
he task
> > > > structure.
> > > >
> > > > Since is_compat_task() is an inlined function, it would be helpful =
to add a
> > > > compile-time test of CONFIG_COMPAT, making sure it always returns z=
ero when
> > > > the option is not enabled during the kernel build.
> > > >
> > > > With this, the compiler is able to understand in build-time that
> > > > is_compat_task() will always return 0, and optimize-out some of the=
 extra
> > > > code introduced by the option.
> > > >
> > > > This will also allow removing a lot #ifdefs that were introduced, a=
nd make
> > > > the code more clean.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >  arch/riscv/include/asm/compat.h    | 3 +++
> > > >  arch/riscv/include/asm/elf.h       | 4 ----
> > > >  arch/riscv/include/asm/pgtable.h   | 6 ------
> > > >  arch/riscv/include/asm/processor.h | 4 ++--
> > > >  4 files changed, 5 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/a=
sm/compat.h
> > > > index 2ac955b51148f..91517b51b8e27 100644
> > > > --- a/arch/riscv/include/asm/compat.h
> > > > +++ b/arch/riscv/include/asm/compat.h
> > > > @@ -14,6 +14,9 @@
> > > >
> > > >  static inline int is_compat_task(void)
> > > >  {
> > > > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > > > +               return 0;
> > > > +
> > > >         return test_thread_flag(TIF_32BIT);
> > > >  }
> > > >
> > > > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/=
elf.h
> > > > index 59a08367fddd7..2e88257cafaea 100644
> > > > --- a/arch/riscv/include/asm/elf.h
> > > > +++ b/arch/riscv/include/asm/elf.h
> > > > @@ -53,13 +53,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hd=
r);
> > > >  #define ELF_ET_DYN_BASE                ((DEFAULT_MAP_WINDOW / 3) *=
 2)
> > > >
> > > >  #ifdef CONFIG_64BIT
> > > > -#ifdef CONFIG_COMPAT
> > > >  #define STACK_RND_MASK         (is_compat_task() ? \
> > > >                                  0x7ff >> (PAGE_SHIFT - 12) : \
> > > >                                  0x3ffff >> (PAGE_SHIFT - 12))
> > > > -#else
> > > > -#define STACK_RND_MASK         (0x3ffff >> (PAGE_SHIFT - 12))
> > > > -#endif
> > > >  #endif
> > > >
> > > >  /*
> > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/=
asm/pgtable.h
> > > > index 1d472b31e0cfe..ea5b269be223a 100644
> > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > @@ -127,16 +127,10 @@
> > > >  #define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> > > >  #define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> > > >
> > > > -#ifdef CONFIG_COMPAT
> > > >  #define MMAP_VA_BITS_64 ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV4=
8 : VA_BITS)
> > > >  #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
> > > >  #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BI=
TS_64)
> > > >  #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_M=
IN_VA_BITS_64)
> > > > -#else
> > > > -#define MMAP_VA_BITS ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 :=
 VA_BITS)
> > > > -#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
> > > > -#endif /* CONFIG_COMPAT */
> > > > -
> > > >  #else
> > > >  #include <asm/pgtable-32.h>
> > > >  #endif /* CONFIG_64BIT */
> > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/includ=
e/asm/processor.h
> > > > index f19f861cda549..ed32e53e55999 100644
> > > > --- a/arch/riscv/include/asm/processor.h
> > > > +++ b/arch/riscv/include/asm/processor.h
> > > > @@ -22,7 +22,7 @@
> > > >  ({                                                             \
> > > >         unsigned long mmap_end;                                 \
> > > >         typeof(addr) _addr =3D (addr);                            \
> > > > -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_co=
mpat_task())) \
> > > > +       if ((_addr) =3D=3D 0 || is_compat_task())                  =
 \
> > > >                 mmap_end =3D STACK_TOP_MAX;                       \
> > > >         else if ((_addr) >=3D VA_USER_SV57)                       \
> > > >                 mmap_end =3D STACK_TOP_MAX;                       \
> > > > @@ -39,7 +39,7 @@
> > > >         typeof(addr) _addr =3D (addr);                            \
> > > >         typeof(base) _base =3D (base);                            \
> > > >         unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base);   \
> > > > -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_co=
mpat_task())) \
> > > > +       if ((_addr) =3D=3D 0 || is_compat_task())                  =
 \
> > > >                 mmap_base =3D (_base);                            \
> > > >         else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BI=
TS_SV57)) \
> > > >                 mmap_base =3D VA_USER_SV57 - rnd_gap;             \
> > > > --
> > > > 2.43.0
> > > >
> > > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > Thanks!
> > Leo
> >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
>
> Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
>

Thanks Andy!


