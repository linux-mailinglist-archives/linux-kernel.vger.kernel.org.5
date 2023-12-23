Return-Path: <linux-kernel+bounces-10282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C987881D21E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BCB2387F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242A515BD;
	Sat, 23 Dec 2023 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cd+xbLL/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747451368
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5095834aso334805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 20:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703304917; x=1703909717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkfSo8ZTFHLoFLmvhQ6WyvO6NSzYvB7Vfz6jJY7OI8E=;
        b=Cd+xbLL/WU1dN+bq8//1E+13HvVkHmbLQcxQ+uVR1KfE03tbCmIRwK4zKfjAZrw9zM
         s80CLaNz2L89kpzxCxQxiwitXNCCYyBZIzJ2kAixI7z+HrDcbYmzgRlOVZdRO+AmISWX
         DhmVFjA7vRT/rqGsBVGO4xziTBv62rw8Jk83wH7YEuuoL4EVmOOud5nyrl3mqZS+KSUB
         mbtadkVorWoA5rvJfMXCWFXUKiXGZlKbLlGOli9D2whijn3dZaRTgjY3bZhtmwSG8Hzy
         aKOcyMYTsf0/cRpHma/0UptV4X3hdgWQtT3ZG0xDo/s3e2O8iKpBX58QQ3q2kdq01T2E
         PPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703304917; x=1703909717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkfSo8ZTFHLoFLmvhQ6WyvO6NSzYvB7Vfz6jJY7OI8E=;
        b=W+Z+5f3cKXFfhDWtmioaPwOLq7SlIbBsUzW8Lp+kwRtdqJoB/+0HxoApFPreCUJkcs
         ssPvmcml0YSShmei0Y/r7X4WtpA8p2MBokfRiAmAYP8gxGXvNx54WweFDOI+mlDkUHIX
         EuffG3SOqVv8UEKCqljr6en8er3mC9QiWz4QsFLX96RZR3d11Ql5oIYIQxj5q2lMvNra
         DAL1XdxIGB3y9w3LdN0FsKCbNNDZkTnfwKi3cVD4H7zjLW79M5FslT7zP658MHL/VIgd
         Fn+UQ7ozrafRTrhd+aICS8bhKLczSGrfwPKMtN82MWidwQ+baWh3Fy5DVqtFm7njcXhE
         EA2Q==
X-Gm-Message-State: AOJu0YyJISSopCzUcWEMNmuBHzmZ1Z21GsceRiPNhZjYA7BK3uAWktSJ
	h5xdPtNHf3FAqJB5QRtR7i96l1gtYXydQ4gPmYE8QlAerEa6tA==
X-Google-Smtp-Source: AGHT+IGaYGYDyJONneRP0Uzt2aGrgYnVBE/mhONMmNVoQkuHi7atohlfvV19NWg29CRxdGSdP2laoTU53gWTjTUIIQ0=
X-Received: by 2002:a05:600c:3147:b0:40c:53c2:d7f7 with SMTP id
 h7-20020a05600c314700b0040c53c2d7f7mr623972wmo.114.1703304917448; Fri, 22 Dec
 2023 20:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-3-leobras@redhat.com>
 <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com> <ZYXDdlF1CFNpDdiV@LeoBras>
In-Reply-To: <ZYXDdlF1CFNpDdiV@LeoBras>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Sat, 23 Dec 2023 12:15:06 +0800
Message-ID: <CABgGipWmidzhf3PqyK9FWQCmKAuS9H31XECTL5XYjSL5m1Es4g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] riscv: add compile-time test into is_compat_task()
To: Leonardo Bras <leobras@redhat.com>
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

On Sat, Dec 23, 2023 at 1:12=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Fri, Dec 22, 2023 at 05:35:20PM +0800, Guo Ren wrote:
> > On Fri, Dec 22, 2023 at 5:02=E2=80=AFPM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > Currently several places will test for CONFIG_COMPAT before testing
> > > is_compat_task(), probably in order to avoid a run-time test into the=
 task
> > > structure.
> > >
> > > Since is_compat_task() is an inlined function, it would be helpful to=
 add a
> > > compile-time test of CONFIG_COMPAT, making sure it always returns zer=
o when
> > > the option is not enabled during the kernel build.
> > >
> > > With this, the compiler is able to understand in build-time that
> > > is_compat_task() will always return 0, and optimize-out some of the e=
xtra
> > > code introduced by the option.
> > >
> > > This will also allow removing a lot #ifdefs that were introduced, and=
 make
> > > the code more clean.
> > >
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  arch/riscv/include/asm/compat.h    | 3 +++
> > >  arch/riscv/include/asm/elf.h       | 4 ----
> > >  arch/riscv/include/asm/pgtable.h   | 6 ------
> > >  arch/riscv/include/asm/processor.h | 4 ++--
> > >  4 files changed, 5 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm=
/compat.h
> > > index 2ac955b51148f..91517b51b8e27 100644
> > > --- a/arch/riscv/include/asm/compat.h
> > > +++ b/arch/riscv/include/asm/compat.h
> > > @@ -14,6 +14,9 @@
> > >
> > >  static inline int is_compat_task(void)
> > >  {
> > > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > > +               return 0;
> > > +
> > >         return test_thread_flag(TIF_32BIT);
> > >  }
> > >
> > > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/el=
f.h
> > > index 59a08367fddd7..2e88257cafaea 100644
> > > --- a/arch/riscv/include/asm/elf.h
> > > +++ b/arch/riscv/include/asm/elf.h
> > > @@ -53,13 +53,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr)=
;
> > >  #define ELF_ET_DYN_BASE                ((DEFAULT_MAP_WINDOW / 3) * 2=
)
> > >
> > >  #ifdef CONFIG_64BIT
> > > -#ifdef CONFIG_COMPAT
> > >  #define STACK_RND_MASK         (is_compat_task() ? \
> > >                                  0x7ff >> (PAGE_SHIFT - 12) : \
> > >                                  0x3ffff >> (PAGE_SHIFT - 12))
> > > -#else
> > > -#define STACK_RND_MASK         (0x3ffff >> (PAGE_SHIFT - 12))
> > > -#endif
> > >  #endif
> > >
> > >  /*
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index 1d472b31e0cfe..ea5b269be223a 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -127,16 +127,10 @@
> > >  #define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> > >  #define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> > >
> > > -#ifdef CONFIG_COMPAT
> > >  #define MMAP_VA_BITS_64 ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 =
: VA_BITS)
> > >  #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
> > >  #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS=
_64)
> > >  #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN=
_VA_BITS_64)
> > > -#else
> > > -#define MMAP_VA_BITS ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 : V=
A_BITS)
> > > -#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
> > > -#endif /* CONFIG_COMPAT */
> > > -
> > >  #else
> > >  #include <asm/pgtable-32.h>
> > >  #endif /* CONFIG_64BIT */
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/=
asm/processor.h
> > > index f19f861cda549..ed32e53e55999 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -22,7 +22,7 @@
> > >  ({                                                             \
> > >         unsigned long mmap_end;                                 \
> > >         typeof(addr) _addr =3D (addr);                            \
> > > -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_comp=
at_task())) \
> > > +       if ((_addr) =3D=3D 0 || is_compat_task())                   \
> > >                 mmap_end =3D STACK_TOP_MAX;                       \
> > >         else if ((_addr) >=3D VA_USER_SV57)                       \
> > >                 mmap_end =3D STACK_TOP_MAX;                       \
> > > @@ -39,7 +39,7 @@
> > >         typeof(addr) _addr =3D (addr);                            \
> > >         typeof(base) _base =3D (base);                            \
> > >         unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base);   \
> > > -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_comp=
at_task())) \
> > > +       if ((_addr) =3D=3D 0 || is_compat_task())                   \
> > >                 mmap_base =3D (_base);                            \
> > >         else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS=
_SV57)) \
> > >                 mmap_base =3D VA_USER_SV57 - rnd_gap;             \
> > > --
> > > 2.43.0
> > >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
>
> Thanks!
> Leo
>
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

