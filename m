Return-Path: <linux-kernel+bounces-61697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC59851577
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03871C22BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81103C48D;
	Mon, 12 Feb 2024 13:31:23 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C83A29F;
	Mon, 12 Feb 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744683; cv=none; b=EKPoJ9IypEbalNHXNfVPc1Bs5Pb4UliJ44Wfq+miyuDIae5G7wPetGDgA+B5N8DFvi1DWQDJVCUDdNs9ZbYy2wPKegKVU9fw0YhCnj/aYeoq20eVsq12hakVzUs5SSiK1vabWTt6cX4TFRP5jqhA/Pj2pz+KdVEU7rrZZsaZQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744683; c=relaxed/simple;
	bh=hmHWArXdSRm8lzxAU2DSg7y55ObF8/5Uyi8EajxtD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olZxGK79dWSxPq3+N1UWa2xceyQIYMD8TZ1b+RE7Ljy1Y5bhV5OLxpZtVsCb9URA4a5l4JWNiKOtW8rWhJigt54ytUei/1q0RrAX4QMymIHKGIieYytEf8GXj6WQY6d2ZU4LMiaM4JXfu4GO5s0Je4CSG2+em7go9Be7+RrnNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59ceb5a0593so231761eaf.0;
        Mon, 12 Feb 2024 05:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744681; x=1708349481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSLFuMbhZo80/vA+2tLJsi3KFlBp1PmoUoosHnk2JEU=;
        b=k2OxwSsBA65q3frQ19p/JEL34hZJkNfWf/I4pB2LjpT+zyvRnIeuGST09E43IlOszk
         y0wb4PLOpRQG136zmrL1V2dB+gxarzzsCTMaqjetxMFPSpHiOVCYgz2yE6QHzdGoJudP
         YunXS5+UxwSRdeK6a0DAXJ2eb6AAZ+uxMU37JYgko8tqjfq/WysBLkoFBj792OWH0TvG
         /EbMwqZ8ElJdRu2/7YV0J+m2JlqvrjG3x3etrzACN87K+J7hZs1Hn0a8UNQVBl9eGY5O
         MU1ttieLf7qoa6fi4maDjjug2+AUEcv0ErqPF+44V2cjQ0Ktuj3ZvEiBMAqNL9tq6LTJ
         ewpg==
X-Gm-Message-State: AOJu0YwrS1XT/NcimRIDsm+Bpp57rX0WWT7UepnAL1b/dJJJg5y+AZ0D
	RnWcFsoj/Cnt+P6vbSVI58wj9/49lECWFmRhEWIYYGwPi2csL/DQKL1SPBsbuSijiv6eCmQRtzd
	LDUROwk4r2cCvzOiqLhOG3+dccUY=
X-Google-Smtp-Source: AGHT+IHHpZHr/EW3Ix32BZGoEiN9Cir64v4CICrnzC68lWclc4B701GZMfD08kwttgpi43EZD+xjbebNgNWXp66eI8c=
X-Received: by 2002:a4a:a6cd:0:b0:59c:d8cd:ecee with SMTP id
 i13-20020a4aa6cd000000b0059cd8cdeceemr5502224oom.1.1707744680881; Mon, 12 Feb
 2024 05:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <6473e0bb42524e4f29112290a92539d1a800eb69.1706603678.git.haibo1.xu@intel.com>
In-Reply-To: <6473e0bb42524e4f29112290a92539d1a800eb69.1706603678.git.haibo1.xu@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:31:09 +0100
Message-ID: <CAJZ5v0hC7gxoJK0kszw9GgRjxjrKgh7q0sC1L1FdVfOb-TCSRw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: SRAT: Add RISC-V RINTC affinity structure
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:18=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24

Not really.

> Add definition of RISC-V Interrupt Controller(RINTC)
> affinity structure which was approved by UEFI forum
> and will be part of next ACPI spec version(6.6).
>
> Link: https://github.com/acpica/acpica/commit/93caddbf

And this doesn't point to an upstream ACPICA PR.

> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  include/acpi/actbl3.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index c080d579a546..5202e3fc9b41 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -192,7 +192,8 @@ enum acpi_srat_type {
>         ACPI_SRAT_TYPE_GIC_ITS_AFFINITY =3D 4,    /* ACPI 6.2 */
>         ACPI_SRAT_TYPE_GENERIC_AFFINITY =3D 5,    /* ACPI 6.3 */
>         ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY =3D 6,       /* ACPI 6.4 */
> -       ACPI_SRAT_TYPE_RESERVED =3D 7     /* 7 and greater are reserved *=
/
> +       ACPI_SRAT_TYPE_RINTC_AFFINITY =3D 7,      /* ACPI 6.6 */
> +       ACPI_SRAT_TYPE_RESERVED =3D 8     /* 8 and greater are reserved *=
/
>  };
>
>  /*
> @@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
>  #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)     /* 00: Use affini=
ty structure */
>  #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)  /* ACPI 6.4 */
>
> +/* 7: RINTC Affinity (ACPI 6.6) */
> +
> +struct acpi_srat_rintc_affinity {
> +       struct acpi_subtable_header header;
> +       u16 reserved;           /* Reserved, must be zero */
> +       u32 proximity_domain;
> +       u32 acpi_processor_uid;
> +       u32 flags;
> +       u32 clock_domain;
> +};
> +
> +/* Flags for struct acpi_srat_rintc_affinity */
> +
> +#define ACPI_SRAT_RINTC_ENABLED     (1)        /* 00: Use affinity struc=
ture */
> +
>  /***********************************************************************=
********
>   *
>   * STAO - Status Override Table (_STA override) - ACPI 6.0
> --
> 2.34.1
>

