Return-Path: <linux-kernel+bounces-16643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9D8241D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EC41C23CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0821A09;
	Thu,  4 Jan 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HRHzg9OK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B7219EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28bf46ea11so74809366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704371648; x=1704976448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik4uyCYv2TQarb31EWuXmmWrYINJlUytsNJyudVrGMk=;
        b=HRHzg9OK4sAdYUHQdMm3ZE6PoEL19W/Tz6Cj99EkH2SW8VKHWUcJTY6Jw/jxt59Z5/
         66pjWDS7J3fASiUj+HvVMNM4JcuRGbywFGXhzgUHkSdtETfDB+6fToN2rrUdVYe419o3
         VWFTUK8ANGglsN/MeQPysApFjFBFYhqs7QeFWrUYpIL6W+/1cabKKlTvzEmNTZclLSIT
         iC0E6e0ryjrUACeOc7AkgJLX0gzxR+PjYrkRefHr7JqhwmQFQGFrHx0luCXuKpNFNpGV
         7If/Kaf/styKSNJxTd2eNjDPrczG5ZLD+5XALBvX81sStU3zhmQGIkjl6XA6aYj498XP
         +I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371648; x=1704976448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik4uyCYv2TQarb31EWuXmmWrYINJlUytsNJyudVrGMk=;
        b=dacrtNmfwcPbWgMgmMTT31gpM3j/Gh1Pdcq1G0LyPQBqr12GWkuMitzL0pTWmtDvZX
         9Q8WqBcOjChPcrPBphm4FP4eL30fFermNM3dwG0VjCJJpr9jZ/BWZT8TTkKjHH8pD0w+
         sy0hKmMEmQW8k04Gew/ywJsRopynzkOPhyfHuA7i/pG2uc7VpkPb9++/hJbV9X8GYUnd
         Npt+BR22AjPyjJn6o0lrvrOy8jkXn1IZvtidHKcNIPdKFZp8/Ocav9IZNeScS+F9sRM9
         ziFgrBfTkt6HiFizEGzH4A2h+3TCTM+RntWHrdNZNRW+UHljR3yFoLkIeP0L5gOJJZNx
         +QDw==
X-Gm-Message-State: AOJu0YylTsrWmjL3wVCsDehqLDppDjcP3IYlD3naNBcehll2AlCE6Nq3
	mr8KhGDO+shDaTOIkxhVZUMMJ7BPcxbvKfPR0Vi9JyberF52b83GeFpT+5khAok=
X-Google-Smtp-Source: AGHT+IERCr09H6KSLmfFQXyDrlFQIYorvDwOvmuf00b1qBW8NX0+J9jeWqyUIre3qPyVI8Wbm7Z5IHlV/zHPZA4aVyk=
X-Received: by 2002:a17:906:56d3:b0:a23:5893:1ac8 with SMTP id
 an19-20020a17090656d300b00a2358931ac8mr587088ejc.27.1704371648530; Thu, 04
 Jan 2024 04:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-5-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-5-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:33:57 +0100
Message-ID: <CAHVXubh+qnJCF1e6u8G0h+5fnfoGDHz0jjBr+KW11WZbKt3F9A@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] riscv: Only send remote fences when some other
 CPU is online
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> If no other CPU is online, a local cache or TLB flush is sufficient.
> These checks can be constant-folded when SMP is disabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/mm/cacheflush.c | 4 +++-
>  arch/riscv/mm/tlbflush.c   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 47c485bc7df0..f7933ae88a55 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>  {
>         local_flush_icache_all();
>
> -       if (riscv_use_sbi_for_rfence())
> +       if (num_online_cpus() < 2)
> +               return;
> +       else if (riscv_use_sbi_for_rfence())
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 2f18fe6fc4f3..37b3c93e3c30 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -73,7 +73,9 @@ static void __ipi_flush_tlb_all(void *info)
>
>  void flush_tlb_all(void)
>  {
> -       if (riscv_use_sbi_for_rfence())
> +       if (num_online_cpus() < 2)
> +               local_flush_tlb_all();
> +       else if (riscv_use_sbi_for_rfence())
>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
>         else
>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> --
> 2.42.0
>

on_each_cpu() already deals correctly with a single online cpu, the
only thing to optimize here is the SBI rfence. So I'd move this new
test in sbi_remote_sfence_vma_asid() and sbi_remote_fence_i() to avoid
the superfluous M-mode entry when only one cpu is online by checking
the cpumask. And since sbi_remote_fence_i() is used in another
function (flush_icache_mm()), we could also take advantage of this
optimization when only the local cpu must be flushed.

