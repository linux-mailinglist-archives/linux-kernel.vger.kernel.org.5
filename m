Return-Path: <linux-kernel+bounces-108242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0734088084F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F8B1F22D59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2925FBB1;
	Tue, 19 Mar 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UygK9Tel"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E583FBAF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892561; cv=none; b=E7lEXxzEwlk25yXZYrIqc3wxmaO819IIrEBvtqdfjkkmE0F7jAxGTArwE3Uk48nytqoEDt3FRb+p/gZu8AUcvih+VBFMmYhZx9LJXQtph0yPe/g046RMxj8mTz3akqMrZUaT2bIEY3VfmrkwthWxTNykxOhGblDFmpAUxXiMN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892561; c=relaxed/simple;
	bh=5HtWc/ds2naXVekfaRBDXHy+hVJPDW7lSLhvTD5oX1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci7rKCbmScaNAqLd3jQo3p7AF8XFvwIQoDkEXaIYEPX/kmN4JlxrMiHWF/A8L/DXVjhLPax5uZYfcdHw46LwJVoNgjHKy+5POZU9YoLTB93Fd+WOZX43RT+PuNBz1g2iv9AFYgid86NFXlN7xD6Sh4UWVNK2Pbtu65W2fhTJuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UygK9Tel; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd161eb03afso5457759276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710892558; x=1711497358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frQ+kwCuCCJ3eDZ6Belhj/LKRwCvmbaO9rNQmp6RZGY=;
        b=UygK9TelQHa2C0nVzSXVu6zOLaFPmYABW9BfFaZ7Ls7tuLZ0i2AQKPKs6saUgXBw81
         QyQanLjCFBr2bn0tGgYLn9xVsXMWyms2okrWOMXtY3qUViVTSld50FqQqJWvOT9lrTp1
         sYKB0nPloouRo/sEYY3hiqfpuCNcRT512+WB5/JrxTdYnlUd3oYNjBXfwGfRXQEE6KlJ
         9vZWlXglyKyhiXjJfy9t7KuRhPqrWFEXmRUNFLYrc0SdbRl60S8i3tvfoc6Ll6ida7k6
         2WVMbMA8+icfnCMEWl5KaVf8MKAv2lvduGzuaZlRqbT/EE+/up8rhTRKf9rzna8m3jCL
         mZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710892558; x=1711497358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frQ+kwCuCCJ3eDZ6Belhj/LKRwCvmbaO9rNQmp6RZGY=;
        b=Yib77COz6yyxgYXOFQ7DA6JeTUdpMsDVeO4oNhyGldnfOAPjPcA8tCOy2S5PUf7PJL
         VUq//ixJNwcIUowpRkiEgt7TRMBIIWYXus6jrUMW/PeToKUkQldPQlhAISicrvp/cpmW
         rkaRKc/OtwfIDlr3rfdbpkoZqIvcLoG3ZRah1aBI828MLNB2KGEmGcYY1QdTZJwhNV7l
         0jzknLn2svi7QK7zlrrOiR0unrB4nmoXpbGzegRCxn+h1l/y+7XrYAjKwbDimtC890tm
         KkfLml8RSu2AK5AFb8t1J/jOr025/iIO9Nd2ZxtWf09JeVMEGKNLjjRYdyFFI2iSUry0
         ZMaw==
X-Forwarded-Encrypted: i=1; AJvYcCVPlUE9zZQsc0zCrbNZtGDHryC1gmvrqakbpS4wFcrqi/mUE0Zh8rQGUDk6lgApaMLaXndaoGoWy2wRufLtH9yqLvMa7BrXF8UOtN7O
X-Gm-Message-State: AOJu0YzjQfyyh6jSxL3aKlvPjUZt3CBulAxaL0nPefCz29b3VSEwnvaz
	gdP2V58RBYh5wI0oTIz3OBRmYNU7dp4eV3A2uB0zl4mk4WGqIxWe3ZJc5MFed1ql6oY0Z1M/gIf
	q7ctsCH/C+WqMFNoZNi52bRTldeS5R3faSPGnlw==
X-Google-Smtp-Source: AGHT+IG8CEb5Ytu01FVI8jWzno3ZalgsXxFiYD/SFGczvQ19FRdvfeY4fGbHx+H+E+NYkk+ncwi6hA8ltk20WFREucc=
X-Received: by 2002:a25:2fc2:0:b0:dd0:e439:cec6 with SMTP id
 v185-20020a252fc2000000b00dd0e439cec6mr14153797ybv.18.1710892558409; Tue, 19
 Mar 2024 16:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319215915.832127-1-samuel.holland@sifive.com> <20240319215915.832127-6-samuel.holland@sifive.com>
In-Reply-To: <20240319215915.832127-6-samuel.holland@sifive.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 19 Mar 2024 16:55:47 -0700
Message-ID: <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: samuel.holland@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:59=E2=80=AFPM Samuel Holland via lists.riscv.org
<samuel.holland=3Dsifive.com@lists.riscv.org> wrote:
>
> Some envcfg bits need to be controlled on a per-thread basis, such as
> the pointer masking mode. However, the envcfg CSR value cannot simply be
> stored in struct thread_struct, because some hardware may implement a
> different subset of envcfg CSR bits is across CPUs. As a result, we need
> to combine the per-CPU and per-thread bits whenever we switch threads.
>

Why not do something like this

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index b3400517b0a9..01ba87954da2 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -202,6 +202,8 @@
 #define ENVCFG_CBIE_FLUSH              _AC(0x1, UL)
 #define ENVCFG_CBIE_INV                        _AC(0x3, UL)
 #define ENVCFG_FIOM                    _AC(0x1, UL)
+/* by default all threads should be able to zero cache */
+#define ENVCFG_BASE                    ENVCFG_CBZE

 /* Smstateen bits */
 #define SMSTATEEN0_AIA_IMSIC_SHIFT     58
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4f21d970a129..2420123444c4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -152,6 +152,7 @@ void start_thread(struct pt_regs *regs, unsigned long p=
c,
        else
                regs->status |=3D SR_UXL_64;
 #endif
+       current->thread_info.envcfg =3D ENVCFG_BASE;
 }

And instead of context switching in `_switch_to`,
In `entry.S` pick up `envcfg` from `thread_info` and write it into CSR.

This construction avoids
- declaring per cpu riscv_cpu_envcfg
- syncing up
- collection of *envcfg bits.


> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/include/asm/processor.h  |  1 +
>  arch/riscv/include/asm/switch_to.h  | 12 ++++++++++++
>  arch/riscv/kernel/cpufeature.c      |  4 +++-
>  4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 0bd11862b760..b1ad8d0b4599 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -33,6 +33,8 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>
> +DECLARE_PER_CPU(unsigned long, riscv_cpu_envcfg);
> +
>  void riscv_user_isa_enable(void);
>
>  #ifdef CONFIG_RISCV_MISALIGNED
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index a8509cc31ab2..06b87402a4d8 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -118,6 +118,7 @@ struct thread_struct {
>         unsigned long s[12];    /* s[0]: frame pointer */
>         struct __riscv_d_ext_state fstate;
>         unsigned long bad_cause;
> +       unsigned long envcfg;
>         u32 riscv_v_flags;
>         u32 vstate_ctrl;
>         struct __riscv_v_ext_state vstate;
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 7efdb0584d47..256a354a5c4a 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return fal=
se; }
>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
>
> +static inline void sync_envcfg(struct task_struct *task)
> +{
> +       csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->thr=
ead.envcfg);
> +}
> +
> +static inline void __switch_to_envcfg(struct task_struct *next)
> +{
> +       if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_IS=
A_EXT_XLINUXENVCFG))

I've seen `riscv_cpu_has_extension_unlikely` generating branchy code
even if ALTERNATIVES was turned on.
Can you check disasm on your end as well.  IMHO, `entry.S` is a better
place to pick up *envcfg.

> +               sync_envcfg(next);
> +}
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>                                        struct task_struct *);
>
> @@ -80,6 +91,7 @@ do {                                                  \
>                 __switch_to_fpu(__prev, __next);        \
>         if (has_vector())                                       \
>                 __switch_to_vector(__prev, __next);     \
> +       __switch_to_envcfg(__next);                     \
>         ((last) =3D __switch_to(__prev, __next));         \
>  } while (0)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index d1846aab1f78..32aaaf41f8a8 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -44,6 +44,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> +DEFINE_PER_CPU(unsigned long, riscv_cpu_envcfg);
> +
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
>
> @@ -978,7 +980,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>  void riscv_user_isa_enable(void)
>  {
>         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_IS=
A_EXT_ZICBOZ))
> -               csr_set(CSR_ENVCFG, ENVCFG_CBZE);
> +               this_cpu_or(riscv_cpu_envcfg, ENVCFG_CBZE);
>  }
>
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> --
> 2.43.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#659): https://lists.riscv.org/g/tech-j-ext/message/65=
9
> Mute This Topic: https://lists.riscv.org/mt/105033914/7300952
> Group Owner: tech-j-ext+owner@lists.riscv.org
> Unsubscribe: https://lists.riscv.org/g/tech-j-ext/unsub [debug@rivosinc.c=
om]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

