Return-Path: <linux-kernel+bounces-13355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53F8203F1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4533D1C20BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B532912;
	Sat, 30 Dec 2023 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="YjTnz5vq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FE20EA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so530247339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 23:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1703922970; x=1704527770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sMoecNT/vWFjebRTXppuzNrFLVfC8SMHVt9ayXTH6k=;
        b=YjTnz5vqYjXD9uWfhPY8YnkkRgzhDhN2y9d7vlQGRw7CHQMAf+O8Z+b7Kg/i69+yzH
         l4jZqBP3R+yUcrYNguRxR4IEq8E2T3rwvcqJqvbHW1hJgv86ltbemSEjuIuvIlnfO58V
         UGal3kIHvvScdZZ6LHsXy9nsSH/STUOFgwIIyeqgC7I0+OiWo5AhQv2CTVB4kYo/mZ5o
         tLZjKI6t3XR6kwP0yPajDo5Zsclu9Wt2TfaU00Xwd6OvaczPXWwLGex502t5Vi7RALIP
         bck+OJCQ5OfjlVoulo7gsTfMkCZfG8voNlMblPeFWlBNvyV7BCGB/V5oaEoh2QlOPUko
         3FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703922970; x=1704527770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sMoecNT/vWFjebRTXppuzNrFLVfC8SMHVt9ayXTH6k=;
        b=TqVAVGbW0e1R5X7EQhbw99SwC80uQ+ukAxrX0NelC/orR1sPhJ45bFgmxj9Jyv8LT0
         N6mXtsINlylsOOnVU/WEXob0THgZxaaCkTT0Jrdl8nEslk1D3o3VF4Atyd5CO2rinckQ
         NDOHexptTuyCJSPyVfappLwT1bZVP8f4Ng7TuI9TCz2cQ+fczxDSmWCbwSqMrOACV+AR
         FrlnU4RbWcI2tfSM+0fveRxkeD/v2IMqQpRClL9erh1rUVbzLYLJt9UetOtwzhh8DEY8
         OKvzYQJBjSP9oaBOZ//3K7ghNu2UFc3aayCITlC3rNJCYRweirBC0eL1YlBqODfA2/sm
         viOQ==
X-Gm-Message-State: AOJu0Yx61PwsekmIpDEndAiec56zT0zBCDP0QRXskpJf5cf1/uW2Ol+R
	8TbtxLVVIIJS7aMHGeA6JITB8HWQkyVIjGJy4A5kypDZJxKahA==
X-Google-Smtp-Source: AGHT+IGVmlE2QFQ0+dx8lrqZJ+DFVfKaIOwaq4FTrn+jPUMeUqrIhNxtpGBrKoQi6J3FUQbOs5JpKftu96beacssVUk=
X-Received: by 2002:a05:6e02:184b:b0:35f:f59d:f334 with SMTP id
 b11-20020a056e02184b00b0035ff59df334mr17011843ilv.35.1703922970107; Fri, 29
 Dec 2023 23:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229214950.4061381-1-atishp@rivosinc.com> <20231229214950.4061381-4-atishp@rivosinc.com>
In-Reply-To: <20231229214950.4061381-4-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 30 Dec 2023 13:25:59 +0530
Message-ID: <CAAhSdy3HgqPVCjnie-TtOC5uRWVXoZMRAKigvKK1+z0b7VHA2w@mail.gmail.com>
Subject: Re: [v2 03/10] drivers/perf: riscv: Read upper bits of a firmware counter
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@atishpatra.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 3:20=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> SBI v2.0 introduced a explicit function to read the upper 32 bits
> for any firmwar counter width that is longer than 32bits.
> This is only applicable for RV32 where firmware counter can be
> 64 bit.
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..646604f8c0a5 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -35,6 +35,8 @@
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>
> +static bool sbi_v2_available;
> +
>  static struct attribute *riscv_arch_formats_attr[] =3D {
>         &format_attr_event.attr,
>         &format_attr_firmware.attr,
> @@ -488,16 +490,23 @@ static u64 pmu_sbi_ctr_read(struct perf_event *even=
t)
>         struct hw_perf_event *hwc =3D &event->hw;
>         int idx =3D hwc->idx;
>         struct sbiret ret;
> -       union sbi_pmu_ctr_info info;
>         u64 val =3D 0;
> +       union sbi_pmu_ctr_info info =3D pmu_ctr_list[idx];
>
>         if (pmu_sbi_is_fw_event(event)) {
>                 ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D,
>                                 hwc->idx, 0, 0, 0, 0, 0);
> -               if (!ret.error)
> -                       val =3D ret.value;
> +               if (ret.error)
> +                       return val;
> +
> +               val =3D ret.value;
> +               if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.=
width >=3D 32) {
> +                       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTE=
R_FW_READ_HI,
> +                                       hwc->idx, 0, 0, 0, 0, 0);
> +                       if (!ret.error)
> +                               val |=3D ((u64)ret.value << 32);
> +               }
>         } else {
> -               info =3D pmu_ctr_list[idx];
>                 val =3D riscv_pmu_ctr_read_csr(info.csr);
>                 if (IS_ENABLED(CONFIG_32BIT))
>                         val =3D ((u64)riscv_pmu_ctr_read_csr(info.csr + 0=
x80)) << 31 | val;
> @@ -1108,6 +1117,9 @@ static int __init pmu_sbi_devinit(void)
>                 return 0;
>         }
>
> +       if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> +               sbi_v2_available =3D true;
> +
>         ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>                                       "perf/riscv/pmu:starting",
>                                       pmu_sbi_starting_cpu, pmu_sbi_dying=
_cpu);
> --
> 2.34.1
>

