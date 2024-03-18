Return-Path: <linux-kernel+bounces-106652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7426987F18E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436871C2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558EC4AEF5;
	Mon, 18 Mar 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lrr3gBsa"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048958222
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795021; cv=none; b=nxEutOPnePSZRMhEJLUlHUtLoB/YhBYjGEm1pcjeBHu0HCfMBElw9/PGsVQ0RzZ0LhQieIO8+6Q4CLBWhz+oGt2orUEFgaJH6oF6MMILC6Fmct+0zHmLAFqJDVJws56rihjkNhND15O2R11unmIJfI3WNYFkUJS9zdorc3RKFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795021; c=relaxed/simple;
	bh=Qd7YbeOXRP3LYyZMrZHv6ZCirwOMuup8ebeyXXCaf54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktwgDDS1CoaMG7+rIBK3lF3QbYl477Ep0yDaQFlo34Us3hzNEb3HQzl9Gx2QlSriWoGyBCUQS5l1t+33mrGPcGApBCDNFh7thYef76xR3CU983sb+WFUxHJ8baZOCou+tr20XQFumHVyTgqdRgQBcTEdleoIU118aYLY+1ANAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lrr3gBsa; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so61997951fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710795017; x=1711399817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHRgE6/IgctR0Ep2SgF+2Hfez6Kkw0CgJoJ87vaI93w=;
        b=Lrr3gBsaes8LmS5ZFSiFA/mObB1EEvVGVo/wQ24MdJHQ/S5CD/YR7YJZNjxivSRoHg
         L0l+iaeejZRfXYSUjaAweMLNw1r8jefuqhSWQpCIn/JWWp+CgQu9EMwejxzXV9Xawtu7
         Cu0L/v/Jiq+eLxXO/oqB3+eUDHDdwAYvRRIr9UsCPg0cAaBy7Nss9BJ73JfRVDdYPCMb
         7S5v7pp27qMchMtwZSYs8p7fKIqj7BDJQMNle5Rowjf8tEVMfWBCeAXjV3mxZ2wR+4ZK
         P8NqHw5bcpf5HfC1PnyC7R72BqpPhIxfZg26NCTWDqDJa7DMDe35YvHyCeQbHjKSQ8Dn
         Kt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795017; x=1711399817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHRgE6/IgctR0Ep2SgF+2Hfez6Kkw0CgJoJ87vaI93w=;
        b=NnJWGpEz9DMR0jKxPyi7iRFmg591EqfyMXmUmzN+ruRE9hm51uhghQX/kUR88uM+i1
         Mx21Dfn6+FnJxBHPTod+ublJAbfOMZo/WLNLyNb3FKiXEHQwIObEI/ZYhOSN6q1vhrub
         WEm0hQYW30Dymfj1Hj8cdSQdFVOPwMvJpEpUdnzMkfPAHwF0u8C0Td+yXMD5CnzMEHqS
         WbrQ0a71lJ15lPjn7LQZGt5HZDEyS0AlIREulmLfNhbSbwp1BL74KXlK1Y7agX9zkmo9
         wfdYx5E0F+Ijyi4FDY29MsjgOTqdGhSMK4Eyvi1jX2KDFOI16WRfT4giylRKkk+78ULQ
         OobQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqKUhPh3QtOn3V6DxmobQPfgyBauijOOBfhvHVNyf50UtQs2HwWRl9a4r4fu34Xto//BuvjxGJZEuBHzKm5RnqQz3BrztmxuaX1xP6
X-Gm-Message-State: AOJu0YwGwWoTuLA7cLNsfmWsxlh0A6oCEJ2UAoBnlXGbYbD/+xVbqMU7
	xslfFwEgeWIZyO+PNvpP3WAshdFaD4kAX7TTNzqDzTHd3oFdsSii8y69UgvL9Fv4S/Ey+odd0Wm
	52pJ+jRqOIJ121Ej3kUgsnCabg8PgTTsku6gjcw==
X-Google-Smtp-Source: AGHT+IG4mZw/msBlmDYdTb/X+VBE0lSzurU7xQsnOumWDXXMy3rl8xZjx6ZQSxAzilNKkMA+kWJK9c4rb204HPimdiQ=
X-Received: by 2002:a05:651c:333:b0:2d4:5a99:8b73 with SMTP id
 b19-20020a05651c033300b002d45a998b73mr7544077ljp.38.1710795017252; Mon, 18
 Mar 2024 13:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313180010.295747-1-samuel.holland@sifive.com>
In-Reply-To: <20240313180010.295747-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 18 Mar 2024 21:50:06 +0100
Message-ID: <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Guo Ren <guoren@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Yangyu Chen <cyy@cyyself.name>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 13, 2024 at 7:00=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> TASK_SIZE_MAX should be set to the largest userspace address under any
> runtime configuration. This optimizes the check in __access_ok(), which
> no longer needs to compute the current value of TASK_SIZE. It is still
> safe because addresses between TASK_SIZE and TASK_SIZE_MAX are invalid
> at the hardware level.
>
> This removes about half of the references to pgtable_l[45]_enabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/include/asm/pgtable-64.h | 1 +
>  arch/riscv/include/asm/pgtable.h    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index b99bd66107a6..a677ef3c0fe2 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -17,6 +17,7 @@ extern bool pgtable_l5_enabled;
>  #define PGDIR_SHIFT_L4  39
>  #define PGDIR_SHIFT_L5  48
>  #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
> +#define PGDIR_SIZE_L5   (_AC(1, UL) << PGDIR_SHIFT_L5)
>
>  #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
>                 (pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 6066822e7396..2032f8ac5fc5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -867,6 +867,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte=
)
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64   (PGDIR_SIZE * PTRS_PER_PGD / 2)
>  #define TASK_SIZE_MIN  (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> +#define TASK_SIZE_MAX  (PGDIR_SIZE_L5 * PTRS_PER_PGD / 2)
>
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32   (_AC(0x80000000, UL))
> --
> 2.43.1
>

I think you also need to change the check in handle_page_fault() by
using TASK_SIZE_MAX instead of TASK_SIZE, otherwise the fixup can't
happen (https://elixir.bootlin.com/linux/latest/source/arch/riscv/mm/fault.=
c#L273).

Or I was wondering if it would not be better to do like x86 and use an
alternative, it would be more correct (even though I believe your
solution works)
https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64=
h#L82.

Thanks,

Alex

