Return-Path: <linux-kernel+bounces-121289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE688E4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F9F1C2BEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AD12EBD5;
	Wed, 27 Mar 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l876FPUt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FB12D21F;
	Wed, 27 Mar 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543081; cv=none; b=fEMUWym1t6C+4J0sZocNkY/oLCArX+HxrIfDhs9U5CifeBpFGufW3uYy7AFcfQMbrqRmvIm1znX+meYhX7ltlAAmD3KMTTM17dBGE4Cnn5pQxpknxi0h0LMETOAwenFQyszfK7vN4y3c7jiA2he8GHSw2eaH0VETtXQQhXMFjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543081; c=relaxed/simple;
	bh=w3PLZnikB5D6UTd4FpLoVA8ANIIdiv9ggsdwhf7gnt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjKtXTmhVBBY/6eQYKtKOvWeukUMVZ8YJNWbC2LLO8dvTCFqkrBB999jE9P7I51qeEv2COsRzaB6gka0SzM+ICbFjFyH7s+cDj94lNfj3a21b66OMfw+T4XJtKsAlz3ssSrjvd1O2QkAlsD2MYYCf0lajVlsiSYP2nbu7TBP7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l876FPUt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e89d0816so8240936e87.0;
        Wed, 27 Mar 2024 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711543078; x=1712147878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0po7APVfo9kM+XbLWx6GEab2u7wM60kpsN8Mny+gdt4=;
        b=l876FPUtOe3ylw/H+D36UdclzbOX0RoxMvqcSlJ1gUMf3IpNtANf7O8edUWRhxAITV
         waT4zlcONddr2Uc7pIBw3MWUsTdoViqiHkN0Ekc2R5c7KTAmvuqtNkFOx9nNCqOX/czE
         FJrPIn11fBLOJaysL7OJD2tw9fD0P0QQrJQILX6LK9/SqZb2ZW60QPiflwweydFUUbho
         Cp24vgR6GkaEqNiGtmTF+GrrGSkuWhNS30555ijdwiHJnYMX/4FgVmwkVXXtupLJhY/u
         smGciy7sbkrO2qLDaSTHhsROaAQN6q7l++gZbSKQHujIV4OoRQcePH9aaMCDpEI0gf1C
         YnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543078; x=1712147878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0po7APVfo9kM+XbLWx6GEab2u7wM60kpsN8Mny+gdt4=;
        b=gGhe4P86X96VcMc4tEyubsRI8G7amBL/Ugf+LgulSonp65ExAHrpwiWyUp8G1kByu7
         cmL503XfLn7O1W7RIsYwTL26odgNV3aJbseCuH800Ruan0R4XuyXizSxe+N2L871JlNO
         3WHdzbzV929uu16BB8sA7NB+X8KUeewDnj3K7sI5USM6WC7xwxSjNCC+XV4/dGhvgMcK
         j6g9McgA5OL1376VwmwW+kHMVayFlmcNpGFyq8QxVRXZoWjDaG8KaEK9GVIuJitN70IH
         jpRItC/sW//Af/c2zQdQplkjmfOSc8PbjxW5RZg+30PmGqtFxBw8BOTqWzTMIApgbFjH
         pX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUrazCHhNyxFvP4ln1pq1P2Nwy6dNQbGga4fOeq4vTKCr7qQCIHDTieiiNfROJX8rVxFTuN9Y+iub2V+klIDdvVHcCyPlebztGAmiGIOQ9+nZedUIo0FZl/2173Xc9vApaK/SYZu+T84w==
X-Gm-Message-State: AOJu0YyJqrE98eWI1jj8wtyZqL9TvdxIV1A5FX9CzO9jJAY9S5/D3K/o
	CO9qWSKsp4zHpjS5F/CftxCOFo0nL5J+OBdaEYp7NeLEfBXwqPuVxYXIbw5ppGJ4XOURCv/qrVa
	7iO7MAmfZIjjNbD/T38Ce6jM/Wqc=
X-Google-Smtp-Source: AGHT+IHIxVrFBKdjortdCaXll+rW/cxfYre9UbgLvzS6HpqyTBrl0+F2wyXvbhXRUqf/MzeIE2guDffkK63zJwVnRHA=
X-Received: by 2002:a19:910f:0:b0:515:bf75:1b99 with SMTP id
 t15-20020a19910f000000b00515bf751b99mr784393lfd.40.1711543077124; Wed, 27 Mar
 2024 05:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1709780590.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 27 Mar 2024 20:37:45 +0800
Message-ID: <CAJve8onUQTL2C5m4WQqkvFcANEiv+gzMBfmmJnRA1REE5XFgbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add ACPI NUMA support for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Baoquan He <bhe@redhat.com>, Evan Green <evan@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <apatel@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Sunil V L,

Could you please have a review on this patch set?

Thanks,
Haibo

On Thu, Mar 7, 2024 at 4:34=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrote=
:
>
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
>
> Patch 1/6 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 5 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
>
> Patch 2/6 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 3/6 add the common SRAT RINTC affinity structure handler.
> Patch 4/6 remove the '#if defined(CONFIG_ARCH)' condition to make some NU=
MA
> related parse functions common for all current architectures that support
> ACPI_NUMA
> Patch 5/6 remove ARCH depends option in ACPI_NUMA Kconfig which was no
> longer needed since all the current architectures that support ACPI would
> select ACPI_NUMA by default.
> Patch 6/6 add corresponding ACPI_NUMA config for RISC-V Kconfig.
>
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
>
> [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/vie=
w?usp=3Dsharing
> [2] https://github.com/acpica/acpica/pull/926
>
> Testing:
> Since the ACPI AIA/PLIC support patch set is still under upstream review,
> hence it is tested using the poll based HVC SBI console and RAM disk.
> 1) Build latest Qemu with the following patch backported
>    https://lore.kernel.org/all/20240129094200.3581037-1-haibo1.xu@intel.c=
om/
>    https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406=
d8a1269b0
>
> 2) Build latest EDK-II
>    https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README=
md
>
> 3) Build Linux with the following configs enabled
>    CONFIG_RISCV_SBI_V01=3Dy
>    CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
>    CONFIG_HVC_RISCV_SBI=3Dy
>    CONFIG_NUMA=3Dy
>    CONFIG_ACPI_NUMA=3Dy
>
> 4) Build buildroot rootfs.cpio
>
> 5) Launch the Qemu machine
>    qemu-system-riscv64 -nographic \
>    -machine virt,pflash0=3Dpflash0,pflash1=3Dpflash1 -smp 4 -m 8G \
>    -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=3D=
RISCV_VIRT_CODE.fd \
>    -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VARS=
fd \
>    -object memory-backend-ram,size=3D4G,id=3Dm0 \
>    -object memory-backend-ram,size=3D4G,id=3Dm1 \
>    -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
>    -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
>    -numa dist,src=3D0,dst=3D1,val=3D30 \
>    -kernel linux/arch/riscv/boot/Image \
>    -initrd buildroot/output/images/rootfs.cpio \
>    -append "root=3D/dev/ram ro console=3Dhvc0 earlycon=3Dsbi"
>
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
> [    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
> ...
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1
>
> ---
> Changes since v1
>   - Switch the order of patch 2/4 and 3/4 - Per Sunil's suggestion
>   - Add a new patch 4/6 to make some NUMA related parse functions common
>     for all the architectures that support ACPI NUMA - Per Sunil's sugges=
tion
>   - Add a new patch 5/6 to remove ARCH depends option in ACPI_NUMA
>     Kconfig since all the current architectures that support ACPI
>     would select ACPI_NUMA by default - Per Arnd and Sunil's suggestion
>   - Other minor fix for code format - Per Sunil's comments
>
> Haibo Xu (6):
>   ACPICA: SRAT: Add RISC-V RINTC affinity structure
>   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
>   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
>   ACPI: NUMA: Make some NUMA related parse functions common
>   ACPI: NUMA: Remove ARCH depends option in ACPI_NUMA Kconfig
>   ACPI: RISCV: Enable ACPI based NUMA
>
>  arch/riscv/Kconfig            |   1 +
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  drivers/acpi/numa/Kconfig     |   1 -
>  drivers/acpi/numa/srat.c      |  40 ++++++++---
>  include/acpi/actbl3.h         |  18 ++++-
>  include/linux/acpi.h          |   6 ++
>  11 files changed, 203 insertions(+), 21 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c
>
> --
> 2.34.1
>

