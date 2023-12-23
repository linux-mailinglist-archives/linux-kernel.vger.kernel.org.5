Return-Path: <linux-kernel+bounces-10285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4319D81D236
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F971F23054
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FA610B;
	Sat, 23 Dec 2023 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LOlNAYby"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484624C69
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e72e3d435so301450e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703305556; x=1703910356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh1r+51kM+XQXoePZoBYVvIPaqSuNTim190BEuHTp1w=;
        b=LOlNAYbyftVc9hewL9cw2dzj39ChYUye/cjog9IW1UyX/BVz+Rl82WAy29CD0lJN6V
         dbBN5eTniK+iKgonvsjo5aCy6fh52qB/39zlpHPxOmaD1IhtiKGFYSdPdlPPYwaYSo+E
         WgEaXrFUCD88q5RC5Kp8xpbBc6FHYpfNiCqpZRetQ6MW3JvTyvVBOek3MhK0AJeQ84g1
         jQNi7QNqCp2HWd9mGLsitZ0dPBpZANyZaESKNNMq1jRwbG1Gx/0Mkv6vjrSZaLUIWA9c
         6YrXxVISVYpjAzUMslCU/yFDguBM43crcHXPssD9rjXPTbj8QWaQC56D7bXEm8L4+2Tm
         1DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305556; x=1703910356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh1r+51kM+XQXoePZoBYVvIPaqSuNTim190BEuHTp1w=;
        b=mcPH4SsaNLcu1t0/IUG4zNmmriL0MnF2Ocex62nXHnFEgETmCR7MsLO4Df4B7ET+GW
         dUNrXZ0trzDpLwc0deOfhuuxLFnLMgyrqGMnxipky8/pLZ1dExjkJeAG1xl5w5sgnjlv
         MLu4KtqWdB8zgGPI13IX507hULUqAE+xD0ZUXk+mJGDGZoBpQ6MPqzbx8K2lVixgMdB0
         IItzTx7ma5bkH/24g4ZO06cNxGvZKShJc9Uu+Vvl3JmLsl8gD9p2oU65tvwPZKxGRhcg
         TnkYjL+sMnPraR0jdoIU63Npm2h9g+KWGzVyhAV96d7ExgZftvouO7WKJDwV+V2LXEum
         185w==
X-Gm-Message-State: AOJu0YxQ1KjNhBEgso+1MuT/qJ7tnRhVm6FqmUwke9/SYafgihHp3Kjb
	0xl1ToRL3NdBeT3rW2uAeYyXjjKKEa2OjSsW+z5c34bvKw94Vg==
X-Google-Smtp-Source: AGHT+IFU3Q6ZEG+67oRWk4/KqL1ZNE9mgkQzAdPAehzdj9SVKh47NEVRI4+S5DVshfifQlG9dZi7NeI4A7pFy9IUZ7I=
X-Received: by 2002:a19:5f14:0:b0:50e:6f20:8e40 with SMTP id
 t20-20020a195f14000000b0050e6f208e40mr298244lfb.207.1703305556174; Fri, 22
 Dec 2023 20:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-4-leobras@redhat.com>
In-Reply-To: <20231222074605.452452-4-leobras@redhat.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Sat, 23 Dec 2023 12:25:44 +0800
Message-ID: <CABgGipXLe7MxP076CJ=BLAaChAQug5X7qkNxxm9eEnyy92nEJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
To: Leonardo Bras <leobras@redhat.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Greg Ungerer <gerg@kernel.org>, 
	Vincent Chen <vincent.chen@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Qinglin Pan <panqinglin2020@iscas.ac.cn>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:46=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> task_user_regset_view() makes use of a function very similar to
> is_compat_task(), but pointing to a any thread.
>
> In arm64 asm/compat.h there is a function very similar to that:
> is_compat_thread(struct thread_info *thread)
>
> Copy this function to riscv asm/compat.h and make use of it into
> task_user_regset_view().
>
> Also, introduce a compile-time test for CONFIG_COMPAT and simplify the
> function code by removing the #ifdef.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/compat.h | 8 ++++++++
>  arch/riscv/kernel/ptrace.c      | 6 +++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/com=
pat.h
> index 91517b51b8e27..da4b28cd01a95 100644
> --- a/arch/riscv/include/asm/compat.h
> +++ b/arch/riscv/include/asm/compat.h
> @@ -20,6 +20,14 @@ static inline int is_compat_task(void)
>         return test_thread_flag(TIF_32BIT);
>  }
>
> +static inline int is_compat_thread(struct thread_info *thread)
> +{
> +       if (!IS_ENABLED(CONFIG_COMPAT))
> +               return 0;
> +
> +       return test_ti_thread_flag(thread, TIF_32BIT);
> +}
> +

Does it make sense to use a #ifdef CONFIG_COMPAT clause to group
is_compat_thread() and is_compat_flag()? For example,

#ifdef CONFIG_COMPAT
static inline int is_compat_thread(struct thread_info *thread)
{
 return test_ti_thread_flag(thread, TIF_32BIT);
}
static inline int is_compat_task(void)
{
 return is_compat_thread(current);
}
#else
static inline int is_compat_thread(struct thread_info *thread) { return 0; =
}
static inline int is_compat_task(void) { return 0; }
#endif

>  struct compat_user_regs_struct {
>         compat_ulong_t pc;
>         compat_ulong_t ra;
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 2afe460de16a6..f362832123616 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *child, =
compat_long_t request,
>
>         return ret;
>  }
> +#else
> +static const struct user_regset_view compat_riscv_user_native_view =3D {=
};
>  #endif /* CONFIG_COMPAT */
>
>  const struct user_regset_view *task_user_regset_view(struct task_struct =
*task)
>  {
> -#ifdef CONFIG_COMPAT
> -       if (test_tsk_thread_flag(task, TIF_32BIT))
> +       if (is_compat_thread(&task->thread_info))
>                 return &compat_riscv_user_native_view;
>         else
> -#endif
>                 return &riscv_user_native_view;
>  }
> --
> 2.43.0
>

