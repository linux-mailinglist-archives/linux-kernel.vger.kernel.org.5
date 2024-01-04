Return-Path: <linux-kernel+bounces-16611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7780E824127
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD631C21BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A821364;
	Thu,  4 Jan 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bTFtGKa7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E82135B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so522352a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704369521; x=1704974321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biEC4RdBheGrNbgmPXjbRT8tBxezcZaF2c5NyP81mLc=;
        b=bTFtGKa7j/eL4yfMpnt798Q2XLBBgVdCll7ZxSHSM4mLiUF6L2PW6Oh76PEw/1aFO/
         FXWV0oh8slXrI5JbxSLhx1EaCYZpRrkpH+7FmwEVWmjm6RiE/sz9fd7i++U5rtQCBVMo
         YqRdHm3tcWJ+ZwKMghS42a8Y60EUh5qdAey9XuMpXcOZ3xZ0A7sCi/QA8vRuqqtameeH
         fSP3BCWmAUtYxRpUtxg1iqUWc0zo46qn0nnp+oCEogjwKQnoKgO8ZRr4cIkskNkZjX/p
         66jROeLKs0TZ6OOKgFMj+JxU1wYS0wZ6RxnxQMipDU+EODphdvNc1Am6hLndkw7003gm
         YtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369521; x=1704974321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biEC4RdBheGrNbgmPXjbRT8tBxezcZaF2c5NyP81mLc=;
        b=tj+47uYGP4EGWannxGtsm1gfWSUGuWoM35XVUFwE68yQSyTqmGxhQvu7YKKCWSGiJg
         5g/i82b5o2WMZy6/00R9Ri5iS2MXrJq4AurJTjbmzmaj9nvEfEDyCl/S5Z5REb2TZ5Nv
         FP7JFGE6ziq4z6PH0Ycbq77dOSW0zH9ZV6v/kWo5uHMB4RwlipsXcacDVoVx6zZXTGI3
         6UBJWTAgyQiaJqOHxUEYmyt5NZfX8ptw66WZedepkz+EVK7Aq9lQepWhtx698XUQ/zV5
         vTbWAz9Vtnd/GWgfp5lDtKb98e8Sb4RRrglJSMS4hEMQEpl6chsLszCBi+WTmTicpu6B
         mvSg==
X-Gm-Message-State: AOJu0YwoNYX97YZqPHamMfJubCyhgcV7+4tOHX0o+qEL3rwkq5KE7ZCS
	nxJmwWIdgkwh8TbkjSBdETWUJcZiTLIb9nrG5x4amDw6/SblDg==
X-Google-Smtp-Source: AGHT+IH9leLmV7SjLOc/Li9cgWIvDV0khEwPnd3n91ththizegEoLyva2lAScUcn+idPmK2OepoE4yqrYtFzFpwYVN0=
X-Received: by 2002:a17:907:1b25:b0:a24:8deb:3524 with SMTP id
 mp37-20020a1709071b2500b00a248deb3524mr374427ejc.54.1704369521084; Thu, 04
 Jan 2024 03:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-2-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-2-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 12:58:30 +0100
Message-ID: <CAHVXubidnfCKwSBwD-U6NzBU2PE9Etz1n367swrcZvA2=a_FTg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] riscv: Flush the instruction cache during SMP bringup
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Instruction cache flush IPIs are sent only to CPUs in cpu_online_mask,
> so they will not target a CPU until it calls set_cpu_online() earlier in
> smp_callin(). As a result, if instruction memory is modified between the
> CPU coming out of reset and that point, then its instruction cache may
> contain stale data. Therefore, the instruction cache must be flushed
> after the set_cpu_online() synchronization point.
>
> Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executabl=
e")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/kernel/smpboot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index d162bf339beb..48af5bd3ec30 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -26,7 +26,7 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/mm.h>
>
> -#include <asm/cpufeature.h>
> +#include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/cpufeature.h>
>  #include <asm/irq.h>
> @@ -257,9 +257,10 @@ asmlinkage __visible void smp_callin(void)
>         riscv_user_isa_enable();
>
>         /*
> -        * Remote TLB flushes are ignored while the CPU is offline, so em=
it
> -        * a local TLB flush right now just in case.
> +        * Remote cache and TLB flushes are ignored while the CPU is offl=
ine,
> +        * so flush them both right now just in case.
>          */
> +       local_flush_icache_all();
>         local_flush_tlb_all();
>         complete(&cpu_running);
>         /*
> --
> 2.42.0
>

This looks good to me, so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

