Return-Path: <linux-kernel+bounces-91558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3387139F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54555B2131F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF80286B3;
	Tue,  5 Mar 2024 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaOJAuEc"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6223CE;
	Tue,  5 Mar 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605861; cv=none; b=q1E32GzPwsfb6F//r7qdM7g7cjKD8ySKCYy5rtJEk9rdIRMeW9T7t0GKs6FavZ7AqGlrbS4G03gat7hosxTWCh3C+R4C0zq1+sQcRZxSvrKc+AigzACo/Au7EK40LEj01DX27RVyTUbN5+9zYRYIK2XbZ98QSlwGWf5gAIjOT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605861; c=relaxed/simple;
	bh=pSsvsuUlut4jPJp7g2dGTj1A/pEOdbw7dEeVXx61AJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS6pbEfwOa/RTAACeRdqcg3A7xcNSvqIjJGRCnMmGfwpk3nbPVJbiH8+crKCh14cEtF3vVYYumemMePPVnxrCZVB6BsxSnR+pD74sdgTwTFXmmYNw+tSjtuz+xoemSPXkFxlzUYEvB2gSAwpumNkSNMQIKdRncCL3VWoP3vLRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaOJAuEc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so5196373e87.0;
        Mon, 04 Mar 2024 18:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709605857; x=1710210657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJxBJuXmvGHQUImyHIJdK0gOdBp3H9ixn+SkaIN8FCM=;
        b=CaOJAuEc7tsgCr9+j7UU4ejSxi7nAB9TlUnZWzDBe0/jL260iYg9qSCADbZ6gbiHs3
         zb3QwSX0kT3ot9a5l+XEkO5h+0KW0f3zr9X+dEo+PACo28cpnNsgEfTsPth5Z7tQ9/gw
         OHj265jsVvfJzBaa/HYmtOrN7LurKrUTFkQfqm8yvJ+50eMSWR0Oxr77gVp3/sVQxR/B
         qjSAikfTtOtPOb9HzY1knEno4P0AEz9yFd7s+9paA78pL4EU9BsPkAVDWEO8q71t4GYl
         FCPV6+49lapnlSw3Bl94ZOOZUrIo1POqWSnp5Yc6pP+wlaHItpXlgDEM3e+KNEUCaDVj
         LZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709605857; x=1710210657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJxBJuXmvGHQUImyHIJdK0gOdBp3H9ixn+SkaIN8FCM=;
        b=qZsmAqQSc/Kz+Eyv6eoIxDjyNcx0cmO9rq1ZDsc0jgIbPNx+hhknkXBI+me3TBvKfw
         +RuV68b0cd9QCDJ8mpcehUkoOgXb+iaCOQv2aPVqf1i3dSJrJOv33K0zt+QAHGcK/w0v
         o0WTTNY+KLmR0nKqZyqAqK2dA3yZ6JXkVKhYfijgjwWi4roskeVcVdKeaR6rvh7FAutf
         EITJDv392v3R83s3VWYsU3cJ9VoNWcV16PaGPg1mvhmhq2tHKjZ68I6Txn/pYW+QC08D
         LkiYz8RkFRCqTjwkzsJhGpOgDeTDr7+RAvN5iW/VEBnNJG71w30eNX0k9vYZNN75UEoE
         VFUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJO/YtqrQwOhLTL8IlMY8qlnBkHQMyenkwGFVmx0yz0gJ6KIFHWGROnaDyLTMaE5DpDGWJFfzd9rjf4KOnfPqa3S/RuICNEr85ZOiGFovKV8t2xLo0laWu8LCXqAth7BwBvWoEhzijpw==
X-Gm-Message-State: AOJu0YyhczQE8BzRP2SfabaexAmn1y9cFdIYPkhFIZpqsEXtL5g/ng4+
	+QsigzOMjSfXHh90Il917gKSc1wm/iFtREIoAC7WtYYGk2/Xlk6lPzc0gklypObFZAd2cDIWWjM
	J4WcE6BBgfrMM3mcga2Kbri9Yzu8=
X-Google-Smtp-Source: AGHT+IGdw1R5rJC4pZeyLtaquozmyyYFWlB0fEy+eGf175BBa5M1tKyVDX4YV/pAnGtKDEywU6f1ZMxAAXweNheWd18=
X-Received: by 2002:a05:6512:36d0:b0:512:e220:d3ab with SMTP id
 e16-20020a05651236d000b00512e220d3abmr275796lfs.65.1709605857043; Mon, 04 Mar
 2024 18:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 10:30:45 +0800
Message-ID: <CAJve8o=H+VVyQH6crAvnTUSjRV2pFDmEpy4ykpFBYSB3pOeiZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

Could you help review this patch set?

Thanks,
Haibo

On Wed, Jan 31, 2024 at 10:18=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wro=
te:
>
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
>
> Patch 1/4 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 3 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
>
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig.
>
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
>
> [1] https://mantis.uefi.org/mantis/view.php?id=3D2433
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
> Haibo Xu (4):
>   ACPICA: SRAT: Add RISC-V RINTC affinity structure
>   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
>   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
>   ACPI: RISCV: Enable ACPI based NUMA
>
>  arch/riscv/Kconfig            |   1 +
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  drivers/acpi/numa/Kconfig     |   2 +-
>  drivers/acpi/numa/srat.c      |  35 ++++++++-
>  include/acpi/actbl3.h         |  18 ++++-
>  include/linux/acpi.h          |   7 ++
>  11 files changed, 209 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c
>
> --
> 2.34.1
>

