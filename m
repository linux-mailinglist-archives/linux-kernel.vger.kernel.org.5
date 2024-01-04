Return-Path: <linux-kernel+bounces-16660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCCB824201
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344E52877DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B222316;
	Thu,  4 Jan 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ii/+bW9/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FD2230A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so56742266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704372448; x=1704977248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4/T6LM2cR9BhRuyec6i7dIzoBYTu6Jc/wC4bPpGSrs=;
        b=ii/+bW9/idj/DilkxFAxnkzTTWDAiN2efGWQ9qLpYhZ8ozp/1ZyO0Wqu9ZYrttiJGP
         hQe7z2DvVRIaMeJLL1kP4CU7/ZlQo6nPTUKLNvDIqEZlAIGsMuwJbLv0bN0h15x3cM3K
         R0hQ2he3h9k1dCt530uxDkIuYHu82hxzsRDLswVKBjqurEx871MznsBE9Rn4rO8dctRk
         vJlm/ZhA5XE9RcjE8BomGoCOTq1L7pPInG3It219wciiQkIXTddZQgI7QLDoGsNwrpmY
         IgTM9EyOiZ82EawM/OzSgDtBKetC1cUGWlXTfIGqOJTP7XLuf9WHYmHXqgf3TH+GRqrX
         s6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372448; x=1704977248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4/T6LM2cR9BhRuyec6i7dIzoBYTu6Jc/wC4bPpGSrs=;
        b=khZRVwb7hAawOOw2Y5j0jolydZVSZYcaL5zWI9aH/AE12++kC0slL+G3mgnMvrAMR3
         I5+8lTDkDskLbqLgltIoCoNq0hSqvMaXquTU3WwKP6UBL9G5oLgseMQDgckHnVS9XVJd
         jX8/163oHyumzVuXB8NR/18p19rmZm/ENJojDSQ786yHKPKETkoB0ZuDIcFN6K0UpS1l
         gb4FZeEDkelX2L7ZkeTvlvLdHJWuVJnLM5tlAtvCGJm3RTAR4c0ZAd5875jfM5RR04zW
         15SUwZN8B6tsLi0EuJD8jrI18Cxw1XEodmlN0mtzj3XxR9Elg8WTTLxmetkPT7jDL4lG
         WTeg==
X-Gm-Message-State: AOJu0YxUSfTtYdEjAPnko7LrouB82BH2MY3KP5rmbi4T7FP6a7QoufrJ
	dIubQxj6fToqR00taiXnB7jSYojJ30j5HtYY3TC2KcVe4j0ypQ==
X-Google-Smtp-Source: AGHT+IHUQ3YoVaFmv46BhHeLVQ5EJ1NE0eAcs7J5rojOmYSHjoP6iLNHAvk7t77NJdQ/bytQn9xnJQcuGL/1iBdPOgY=
X-Received: by 2002:a17:906:f34c:b0:a28:b7e1:e24b with SMTP id
 hg12-20020a170906f34c00b00a28b7e1e24bmr195383ejb.162.1704372448064; Thu, 04
 Jan 2024 04:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-11-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-11-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:47:17 +0100
Message-ID: <CAHVXubg4T8ViOvEzd-WoQww_z=CpHetSjjAscfw2qXVCv2zx2g@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] riscv: mm: Make asid_bits a local variable
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This variable is only used inside asids_init().
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/mm/context.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index b5170ac1b742..43a8bc2d5af4 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -20,7 +20,6 @@
>
>  DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
> -static unsigned long asid_bits;
>  static unsigned long num_asids;
>
>  static atomic_long_t current_version;
> @@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
>
>  static int __init asids_init(void)
>  {
> -       unsigned long old;
> +       unsigned long asid_bits, old;
>
>         /* Figure-out number of ASID bits in HW */
>         old =3D csr_read(CSR_SATP);
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

