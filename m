Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4764A766207
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjG1Cns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjG1Cnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:43:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A7C268B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:43:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-348c03de0e7so6383765ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690512161; x=1691116961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxMRcfdxOGe3ub5LISH0Ck1IwTgNg1DbmVIwAsu7gZQ=;
        b=BqhK1bEJIT2R9KpJf0PyZbGQgQskaZtaDyI0daJYPKmI+MUVZw0xJ1KFueCkp08bQW
         c5AokN03YKcvyabFAXabR1IqAxavlq+BO4oQ/ZeFukO78O8/18xQuCjbCmoGoYgNXVhK
         u4cdWoZU8sKWYwNkYt60DGhD4Nw99QWyzaf69nlcymjJYN9sX9i5L82yKr/R/nJLZZrD
         ++NmQq8iFsaJV5M/s7q4Ixl2OyNEpShx3I7xA3SPR0eNVAQAifpBul90RuJq+b42/GWw
         4+dbjLDRZfveEKRRHPfrsprasYzQXrZFzMurC9eiL4qiwyEOE8p+2W8ly2BkrexSGJKi
         7s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690512161; x=1691116961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxMRcfdxOGe3ub5LISH0Ck1IwTgNg1DbmVIwAsu7gZQ=;
        b=bBQ078rK4GvmN/fQu+rUaU273REsflsmA7H83QnVsbYhwH8OIyL4yJ0TAEaEasERVN
         QbHhR+wIld1MMIVCPp9UZDoVFj/5ebYV/lDIsGZmxfodo/pGaiIXR6Tb1FbIBnFAlAS8
         MTm48HI1M+UK0vewKQ4a9/jRXzh3iN4iYQ/+/pUo/XNW02qHjuvNfaC8XRnEiLbK1P54
         pzPgAZ2B241p5OzrB+8xwGVJUO/hawtD4kjiKmnyoyElJi7dfz2zcY9Wdj4GdY1ZQQjM
         Vk0ut52aNcSKJ5eTi+jP+XygFNJEiqeN7A02RZzN2fN3mYFWOOz7VKAHhhu6UjtXjc3z
         +dkg==
X-Gm-Message-State: ABy/qLbyw0j0UTh9xEeHiCbgXVTOhX7JGtrSaGn+5ZuuruTwvDSmK+Y6
        ZyWA89h57qZZo1sXonww5CAe6/fNqxmjQzslTePMlg==
X-Google-Smtp-Source: APBJJlH8taXDYFf/JfijsyuEhaWHSc03JbwgV9stD2bLog5ypS9Z+BK2HbT6euYRiOmCUyFmg8MSabYJRiUfBBew6Rk=
X-Received: by 2002:a05:6e02:e13:b0:347:7421:9d85 with SMTP id
 a19-20020a056e020e1300b0034774219d85mr1322058ilk.29.1690512161163; Thu, 27
 Jul 2023 19:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 28 Jul 2023 10:42:28 +0800
Message-ID: <CANXhq0qRYvTffMnep-aQyTq2tMxbP-s_Lunc+cZ2Rio+BvAE=g@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> The patch introduces skeleton IOMMU device driver implementation as defin=
ed
> by RISC-V IOMMU Architecture Specification, Version 1.0 [1], with minimal=
 support
> for pass-through mapping, basic initialization and bindings for platform =
and PCIe
> hardware implementations.
>
> Series of patches following specification evolution has been reorganized =
to provide
> functional separation of implemented blocks, compliant with ratified spec=
ification.
>
> This and following patch series includes code contributed by: Nick Kossif=
idis
> <mick@ics.forth.gr> (iommu-platform device, number of specification clari=
fication
> and bugfixes and readability improvements), Sebastien Boeuf <seb@rivosinc=
.com> (page
> table creation, ATS/PGR flow).
>
> Complete history can be found at the maintainer's repository branch [2].
>
> Device driver enables RISC-V 32/64 support for memory translation for DMA=
 capable
> PCI and platform devices, multilevel device directory table, process dire=
ctory,
> shared virtual address support, wired and message signaled interrupt for =
translation
> I/O fault, page request interface and command processing.
>
> Matching RISCV-V IOMMU device emulation implementation is available for Q=
EMU project,
> along with educational device extensions for PASID ATS/PRI support [3].
>
> References:
>  - [1] https://github.com/riscv-non-isa/riscv-iommu
>  - [2] https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
>  - [3] https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu
>
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/Kconfig                |   1 +
>  drivers/iommu/Makefile               |   2 +-
>  drivers/iommu/riscv/Kconfig          |  22 +
>  drivers/iommu/riscv/Makefile         |   1 +
>  drivers/iommu/riscv/iommu-bits.h     | 704 +++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu-pci.c      | 134 +++++
>  drivers/iommu/riscv/iommu-platform.c |  94 ++++
>  drivers/iommu/riscv/iommu.c          | 660 +++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h          | 115 +++++
>  9 files changed, 1732 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/riscv/Kconfig
>  create mode 100644 drivers/iommu/riscv/Makefile
>  create mode 100644 drivers/iommu/riscv/iommu-bits.h
>  create mode 100644 drivers/iommu/riscv/iommu-pci.c
>  create mode 100644 drivers/iommu/riscv/iommu-platform.c
>  create mode 100644 drivers/iommu/riscv/iommu.c
>  create mode 100644 drivers/iommu/riscv/iommu.h
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2b12b583ef4b..36fcc6fd5b4e 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -187,6 +187,7 @@ config MSM_IOMMU
>  source "drivers/iommu/amd/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
>  source "drivers/iommu/iommufd/Kconfig"
> +source "drivers/iommu/riscv/Kconfig"
>
>  config IRQ_REMAP
>         bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 769e43d780ce..8f57110a9fb1 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y +=3D amd/ intel/ arm/ iommufd/
> +obj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
>  obj-$(CONFIG_IOMMU_API) +=3D iommu.o
>  obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> new file mode 100644
> index 000000000000..01d4043849d4
> --- /dev/null
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# RISC-V IOMMU support
> +
> +config RISCV_IOMMU
> +       bool "RISC-V IOMMU driver"
> +       depends on RISCV
> +       select IOMMU_API
> +       select IOMMU_DMA
> +       select IOMMU_SVA
> +       select IOMMU_IOVA
> +       select IOMMU_IO_PGTABLE
> +       select IOASID
> +       select PCI_MSI
> +       select PCI_ATS
> +       select PCI_PRI
> +       select PCI_PASID
> +       select MMU_NOTIFIER
> +       help
> +         Support for devices following RISC-V IOMMU specification.
> +
> +         If unsure, say N here.
> +
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> new file mode 100644
> index 000000000000..38730c11e4a8
> --- /dev/null
> +++ b/drivers/iommu/riscv/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-pci.o iommu-platform.o
> \ No newline at end of file
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu=
-bits.h
> new file mode 100644
> index 000000000000..b2946793a73d
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -0,0 +1,704 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + * Copyright =C2=A9 2023 RISC-V IOMMU Task Group
> + *
> + * RISC-V Ziommu - Register Layout and Data Structures.
> + *
> + * Based on the 'RISC-V IOMMU Architecture Specification', Version 1.0
> + * Published at  https://github.com/riscv-non-isa/riscv-iommu
> + *
> + */
> +
> +#ifndef _RISCV_IOMMU_BITS_H_
> +#define _RISCV_IOMMU_BITS_H_
> +
> +#include <linux/types.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +/*
> + * Chapter 5: Memory Mapped register interface
> + */
> +
> +/* Common field positions */
> +#define RISCV_IOMMU_PPN_FIELD          GENMASK_ULL(53, 10)
> +#define RISCV_IOMMU_QUEUE_LOGSZ_FIELD  GENMASK_ULL(4, 0)
> +#define RISCV_IOMMU_QUEUE_INDEX_FIELD  GENMASK_ULL(31, 0)
> +#define RISCV_IOMMU_QUEUE_ENABLE       BIT(0)
> +#define RISCV_IOMMU_QUEUE_INTR_ENABLE  BIT(1)
> +#define RISCV_IOMMU_QUEUE_MEM_FAULT    BIT(8)
> +#define RISCV_IOMMU_QUEUE_OVERFLOW     BIT(9)
> +#define RISCV_IOMMU_QUEUE_ACTIVE       BIT(16)
> +#define RISCV_IOMMU_QUEUE_BUSY         BIT(17)
> +
> +#define RISCV_IOMMU_ATP_PPN_FIELD      GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_ATP_MODE_FIELD     GENMASK_ULL(63, 60)
> +
> +/* 5.3 IOMMU Capabilities (64bits) */
> +#define RISCV_IOMMU_REG_CAP            0x0000
> +#define RISCV_IOMMU_CAP_VERSION                GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_S_SV32         BIT_ULL(8)
> +#define RISCV_IOMMU_CAP_S_SV39         BIT_ULL(9)
> +#define RISCV_IOMMU_CAP_S_SV48         BIT_ULL(10)
> +#define RISCV_IOMMU_CAP_S_SV57         BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SVPBMT         BIT_ULL(15)
> +#define RISCV_IOMMU_CAP_G_SV32         BIT_ULL(16)
> +#define RISCV_IOMMU_CAP_G_SV39         BIT_ULL(17)
> +#define RISCV_IOMMU_CAP_G_SV48         BIT_ULL(18)
> +#define RISCV_IOMMU_CAP_G_SV57         BIT_ULL(19)
> +#define RISCV_IOMMU_CAP_MSI_FLAT       BIT_ULL(22)
> +#define RISCV_IOMMU_CAP_MSI_MRIF       BIT_ULL(23)
> +#define RISCV_IOMMU_CAP_AMO            BIT_ULL(24)
> +#define RISCV_IOMMU_CAP_ATS            BIT_ULL(25)
> +#define RISCV_IOMMU_CAP_T2GPA          BIT_ULL(26)
> +#define RISCV_IOMMU_CAP_END            BIT_ULL(27)
> +#define RISCV_IOMMU_CAP_IGS            GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_HPM            BIT_ULL(30)
> +#define RISCV_IOMMU_CAP_DBG            BIT_ULL(31)
> +#define RISCV_IOMMU_CAP_PAS            GENMASK_ULL(37, 32)
> +#define RISCV_IOMMU_CAP_PD8            BIT_ULL(38)
> +#define RISCV_IOMMU_CAP_PD17           BIT_ULL(39)
> +#define RISCV_IOMMU_CAP_PD20           BIT_ULL(40)
> +
> +#define RISCV_IOMMU_CAP_VERSION_VER_MASK       0xF0
> +#define RISCV_IOMMU_CAP_VERSION_REV_MASK       0x0F
> +
> +/**
> + * enum riscv_iommu_igs_settings - Interrupt Generation Support Settings
> + * @RISCV_IOMMU_CAP_IGS_MSI: I/O MMU supports only MSI generation
> + * @RISCV_IOMMU_CAP_IGS_WSI: I/O MMU supports only Wired-Signaled interr=
upt
> + * @RISCV_IOMMU_CAP_IGS_BOTH: I/O MMU supports both MSI and WSI generati=
on
> + * @RISCV_IOMMU_CAP_IGS_RSRV: Reserved for standard use
> + */
> +enum riscv_iommu_igs_settings {
> +       RISCV_IOMMU_CAP_IGS_MSI =3D 0,
> +       RISCV_IOMMU_CAP_IGS_WSI =3D 1,
> +       RISCV_IOMMU_CAP_IGS_BOTH =3D 2,
> +       RISCV_IOMMU_CAP_IGS_RSRV =3D 3
> +};
> +
> +/* 5.4 Features control register (32bits) */
> +#define RISCV_IOMMU_REG_FCTL           0x0008
> +#define RISCV_IOMMU_FCTL_BE            BIT(0)
> +#define RISCV_IOMMU_FCTL_WSI           BIT(1)
> +#define RISCV_IOMMU_FCTL_GXL           BIT(2)
> +
> +/* 5.5 Device-directory-table pointer (64bits) */
> +#define RISCV_IOMMU_REG_DDTP           0x0010
> +#define RISCV_IOMMU_DDTP_MODE          GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_DDTP_BUSY          BIT_ULL(4)
> +#define RISCV_IOMMU_DDTP_PPN           RISCV_IOMMU_PPN_FIELD
> +
> +/**
> + * enum riscv_iommu_ddtp_modes - I/O MMU translation modes
> + * @RISCV_IOMMU_DDTP_MODE_OFF: No inbound transactions allowed
> + * @RISCV_IOMMU_DDTP_MODE_BARE: Pass-through mode
> + * @RISCV_IOMMU_DDTP_MODE_1LVL: One-level DDT
> + * @RISCV_IOMMU_DDTP_MODE_2LVL: Two-level DDT
> + * @RISCV_IOMMU_DDTP_MODE_3LVL: Three-level DDT
> + */
> +enum riscv_iommu_ddtp_modes {
> +       RISCV_IOMMU_DDTP_MODE_OFF =3D 0,
> +       RISCV_IOMMU_DDTP_MODE_BARE =3D 1,
> +       RISCV_IOMMU_DDTP_MODE_1LVL =3D 2,
> +       RISCV_IOMMU_DDTP_MODE_2LVL =3D 3,
> +       RISCV_IOMMU_DDTP_MODE_3LVL =3D 4,
> +       RISCV_IOMMU_DDTP_MODE_MAX =3D 4
> +};
> +
> +/* 5.6 Command Queue Base (64bits) */
> +#define RISCV_IOMMU_REG_CQB            0x0018
> +#define RISCV_IOMMU_CQB_ENTRIES                RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> +#define RISCV_IOMMU_CQB_PPN            RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.7 Command Queue head (32bits) */
> +#define RISCV_IOMMU_REG_CQH            0x0020
> +#define RISCV_IOMMU_CQH_INDEX          RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.8 Command Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_CQT            0x0024
> +#define RISCV_IOMMU_CQT_INDEX          RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.9 Fault Queue Base (64bits) */
> +#define RISCV_IOMMU_REG_FQB            0x0028
> +#define RISCV_IOMMU_FQB_ENTRIES                RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> +#define RISCV_IOMMU_FQB_PPN            RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.10 Fault Queue Head (32bits) */
> +#define RISCV_IOMMU_REG_FQH            0x0030
> +#define RISCV_IOMMU_FQH_INDEX          RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.11 Fault Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_FQT            0x0034
> +#define RISCV_IOMMU_FQT_INDEX          RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.12 Page Request Queue base (64bits) */
> +#define RISCV_IOMMU_REG_PQB            0x0038
> +#define RISCV_IOMMU_PQB_ENTRIES                RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> +#define RISCV_IOMMU_PQB_PPN            RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.13 Page Request Queue head (32bits) */
> +#define RISCV_IOMMU_REG_PQH            0x0040
> +#define RISCV_IOMMU_PQH_INDEX          RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.14 Page Request Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_PQT            0x0044
> +#define RISCV_IOMMU_PQT_INDEX_MASK     RISCV_IOMMU_QUEUE_INDEX_FIELD
> +
> +/* 5.15 Command Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_CQCSR          0x0048
> +#define RISCV_IOMMU_CQCSR_CQEN         RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_CQCSR_CIE          RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_CQCSR_CQMF         RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_CQCSR_CMD_TO       BIT(9)
> +#define RISCV_IOMMU_CQCSR_CMD_ILL      BIT(10)
> +#define RISCV_IOMMU_CQCSR_FENCE_W_IP   BIT(11)
> +#define RISCV_IOMMU_CQCSR_CQON         RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_CQCSR_BUSY         RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.16 Fault Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_FQCSR          0x004C
> +#define RISCV_IOMMU_FQCSR_FQEN         RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_FQCSR_FIE          RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_FQCSR_FQMF         RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_FQCSR_FQOF         RISCV_IOMMU_QUEUE_OVERFLOW
> +#define RISCV_IOMMU_FQCSR_FQON         RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_FQCSR_BUSY         RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.17 Page Request Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_PQCSR          0x0050
> +#define RISCV_IOMMU_PQCSR_PQEN         RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_PQCSR_PIE          RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_PQCSR_PQMF         RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_PQCSR_PQOF         RISCV_IOMMU_QUEUE_OVERFLOW
> +#define RISCV_IOMMU_PQCSR_PQON         RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_PQCSR_BUSY         RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.18 Interrupt Pending Status (32bits) */
> +#define RISCV_IOMMU_REG_IPSR           0x0054
> +
> +#define RISCV_IOMMU_INTR_CQ            0
> +#define RISCV_IOMMU_INTR_FQ            1
> +#define RISCV_IOMMU_INTR_PM            2
> +#define RISCV_IOMMU_INTR_PQ            3
> +#define RISCV_IOMMU_INTR_COUNT         4
> +
> +#define RISCV_IOMMU_IPSR_CIP           BIT(RISCV_IOMMU_INTR_CQ)
> +#define RISCV_IOMMU_IPSR_FIP           BIT(RISCV_IOMMU_INTR_FQ)
> +#define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_PM)
> +#define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_PQ)
> +
> +/* 5.19 Performance monitoring counter overflow status (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> +
> +/* 5.20 Performance monitoring counter inhibits (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> +
> +/* 5.21 Performance monitoring cycles counter (64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0)
> +#define RISCV_IOMMU_IOHPMCYCLES_OVF    BIT_ULL(63)
> +
> +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCTR_BASE + =
(_n * 0x8))
> +
> +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT_BASE + =
(_n * 0x8))
> +#define RISCV_IOMMU_IOHPMEVT_EVENT_ID  GENMASK_ULL(14, 0)
> +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> +
> +/**
> + * enum riscv_iommu_hpmevent_id - Performance-monitoring event identifie=
r
> + *
> + * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: S/VS-Stage page table walks
> + * @RISCV_IOMMU_HPMEVENT_G_WALKS: G-Stage page table walks
> + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> + */
> +enum riscv_iommu_hpmevent_id {
> +       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> +};
> +
> +/* 5.24 Translation request IOVA (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> +#define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> +
> +/* 5.25 Translation request control (64bits) */
> +#define RISCV_IOMMU_REG_TR_REQ_CTL     0x0260
> +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY BIT_ULL(0)
> +#define RISCV_IOMMU_TR_REQ_CTL_PRIV    BIT_ULL(1)
> +#define RISCV_IOMMU_TR_REQ_CTL_EXE     BIT_ULL(2)
> +#define RISCV_IOMMU_TR_REQ_CTL_NW      BIT_ULL(3)
> +#define RISCV_IOMMU_TR_REQ_CTL_PID     GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_TR_REQ_CTL_PV      BIT_ULL(32)
> +#define RISCV_IOMMU_TR_REQ_CTL_DID     GENMASK_ULL(63, 40)
> +
> +/* 5.26 Translation request response (64bits) */
> +#define RISCV_IOMMU_REG_TR_RESPONSE    0x0268
> +#define RISCV_IOMMU_TR_RESPONSE_FAULT  BIT_ULL(0)
> +#define RISCV_IOMMU_TR_RESPONSE_PBMT   GENMASK_ULL(8, 7)
> +#define RISCV_IOMMU_TR_RESPONSE_SZ     BIT_ULL(9)
> +#define RISCV_IOMMU_TR_RESPONSE_PPN    RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.27 Interrupt cause to vector (64bits) */
> +#define RISCV_IOMMU_REG_IVEC           0x02F8
> +#define RISCV_IOMMU_IVEC_CIV           GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_IVEC_FIV           GENMASK_ULL(7, 4)
> +#define RISCV_IOMMU_IVEC_PMIV          GENMASK_ULL(11, 8)
> +#define RISCV_IOMMU_IVEC_PIV           GENMASK_ULL(15,12)
> +
> +/* 5.28 MSI Configuration table (32 * 64bits) */
> +#define RISCV_IOMMU_REG_MSI_CONFIG     0x0300
> +#define RISCV_IOMMU_REG_MSI_ADDR(_n)   (RISCV_IOMMU_REG_MSI_CONFIG + (_n=
 * 0x10))
> +#define RISCV_IOMMU_MSI_ADDR           GENMASK_ULL(55, 2)
> +#define RISCV_IOMMU_REG_MSI_DATA(_n)   (RISCV_IOMMU_REG_MSI_CONFIG + (_n=
 * 0x10) + 0x08)
> +#define RISCV_IOMMU_MSI_DATA           GENMASK_ULL(31, 0)
> +#define RISCV_IOMMU_REG_MSI_VEC_CTL(_n)        (RISCV_IOMMU_REG_MSI_CONF=
IG + (_n * 0x10) + 0x0C)
> +#define RISCV_IOMMU_MSI_VEC_CTL_M      BIT_ULL(0)
> +
> +#define RISCV_IOMMU_REG_SIZE   0x1000
> +
> +/*
> + * Chapter 2: Data structures
> + */
> +
> +/*
> + * Device Directory Table macros for non-leaf nodes
> + */
> +#define RISCV_IOMMU_DDTE_VALID BIT_ULL(0)
> +#define RISCV_IOMMU_DDTE_PPN   RISCV_IOMMU_PPN_FIELD
> +
> +/**
> + * struct riscv_iommu_dc - Device Context
> + * @tc: Translation Control
> + * @iohgatp: I/O Hypervisor guest address translation and protection
> + *          (Second stage context)
> + * @ta: Translation Attributes
> + * @fsc: First stage context
> + * @msiptpt: MSI page table pointer
> + * @msi_addr_mask: MSI address mask
> + * @msi_addr_pattern: MSI address pattern
> + *
> + * This structure is used for leaf nodes on the Device Directory Table,
> + * in case RISCV_IOMMU_CAP_MSI_FLAT is not set, the bottom 4 fields are
> + * not present and are skipped with pointer arithmetic to avoid
> + * casting, check out riscv_iommu_get_dc().
> + * See section 2.1 for more details
> + */
> +struct riscv_iommu_dc {
> +       u64 tc;
> +       u64 iohgatp;
> +       u64 ta;
> +       u64 fsc;
> +       u64 msiptp;
> +       u64 msi_addr_mask;
> +       u64 msi_addr_pattern;
> +       u64 _reserved;
> +};
> +
> +/* Translation control fields */
> +#define RISCV_IOMMU_DC_TC_V            BIT_ULL(0)
> +#define RISCV_IOMMU_DC_TC_EN_ATS       BIT_ULL(1)
> +#define RISCV_IOMMU_DC_TC_EN_PRI       BIT_ULL(2)
> +#define RISCV_IOMMU_DC_TC_T2GPA                BIT_ULL(3)
> +#define RISCV_IOMMU_DC_TC_DTF          BIT_ULL(4)
> +#define RISCV_IOMMU_DC_TC_PDTV         BIT_ULL(5)
> +#define RISCV_IOMMU_DC_TC_PRPR         BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_GADE         BIT_ULL(7)
> +#define RISCV_IOMMU_DC_TC_SADE         BIT_ULL(8)
> +#define RISCV_IOMMU_DC_TC_DPE          BIT_ULL(9)
> +#define RISCV_IOMMU_DC_TC_SBE          BIT_ULL(10)
> +#define RISCV_IOMMU_DC_TC_SXL          BIT_ULL(11)
> +
> +/* Second-stage (aka G-stage) context fields */
> +#define RISCV_IOMMU_DC_IOHGATP_PPN     RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_IOHGATP_GSCID   GENMASK_ULL(59, 44)
> +#define RISCV_IOMMU_DC_IOHGATP_MODE    RISCV_IOMMU_ATP_MODE_FIELD
> +
> +/**
> + * enum riscv_iommu_dc_iohgatp_modes - Guest address translation/protect=
ion modes
> + * @RISCV_IOMMU_DC_IOHGATP_MODE_BARE: No translation/protection
> + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4: Sv32x4 (2-bit extension of Sv32)=
, when fctl.GXL =3D=3D 1
> + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4: Sv39x4 (2-bit extension of Sv39)=
, when fctl.GXL =3D=3D 0
> + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4: Sv48x4 (2-bit extension of Sv48)=
, when fctl.GXL =3D=3D 0
> + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4: Sv57x4 (2-bit extension of Sv57)=
, when fctl.GXL =3D=3D 0
> + */
> +enum riscv_iommu_dc_iohgatp_modes {
> +       RISCV_IOMMU_DC_IOHGATP_MODE_BARE =3D 0,
> +       RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 =3D 8,
> +       RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 =3D 8,
> +       RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 =3D 9,
> +       RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 =3D 10
> +};
> +
> +/* Translation attributes fields */
> +#define RISCV_IOMMU_DC_TA_PSCID                GENMASK_ULL(31,12)
> +
> +/* First-stage context fields */
> +#define RISCV_IOMMU_DC_FSC_PPN         RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_FSC_MODE                RISCV_IOMMU_ATP_MODE_FIEL=
D
> +
> +/**
> + * enum riscv_iommu_dc_fsc_atp_modes - First stage address translation/p=
rotection modes
> + * @RISCV_IOMMU_DC_FSC_MODE_BARE: No translation/protection
> + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32: Sv32, when dc.tc.SXL =3D=3D 1
> + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39: Sv39, when dc.tc.SXL =3D=3D 0
> + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48: Sv48, when dc.tc.SXL =3D=3D 0
> + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57: Sv57, when dc.tc.SXL =3D=3D 0
> + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8: 1lvl PDT, 8bit process ids
> + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17: 2lvl PDT, 17bit process ids
> + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20: 3lvl PDT, 20bit process ids
> + *
> + * FSC holds IOSATP when RISCV_IOMMU_DC_TC_PDTV is 0 and PDTP otherwise.
> + * IOSATP controls the first stage address translation (same as the satp=
 register on
> + * the RISC-V MMU), and PDTP holds the process directory table, used to =
select a
> + * first stage page table based on a process id (for devices that suppor=
t multiple
> + * process ids).
> + */
> +enum riscv_iommu_dc_fsc_atp_modes {
> +       RISCV_IOMMU_DC_FSC_MODE_BARE =3D 0,
> +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 =3D 8,
> +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 =3D 8,
> +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 =3D 9,
> +       RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 =3D 10,
> +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 =3D 1,
> +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 =3D 2,
> +       RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 =3D 3
> +};
> +
> +/* MSI page table pointer */
> +#define RISCV_IOMMU_DC_MSIPTP_PPN      RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_MSIPTP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
> +#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF 0
> +#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT        1
> +
> +/* MSI address mask */
> +#define RISCV_IOMMU_DC_MSI_ADDR_MASK   GENMASK_ULL(51, 0)
> +
> +/* MSI address pattern */
> +#define RISCV_IOMMU_DC_MSI_PATTERN     GENMASK_ULL(51, 0)
> +
> +/**
> + * struct riscv_iommu_pc - Process Context
> + * @ta: Translation Attributes
> + * @fsc: First stage context
> + *
> + * This structure is used for leaf nodes on the Process Directory Table
> + * See section 2.3 for more details
> + */
> +struct riscv_iommu_pc {
> +       u64 ta;
> +       u64 fsc;
> +};
> +
> +/* Translation attributes fields */
> +#define RISCV_IOMMU_PC_TA_V    BIT_ULL(0)
> +#define RISCV_IOMMU_PC_TA_ENS  BIT_ULL(1)
> +#define RISCV_IOMMU_PC_TA_SUM  BIT_ULL(2)
> +#define RISCV_IOMMU_PC_TA_PSCID        GENMASK_ULL(31, 12)
> +
> +/* First stage context fields */
> +#define RISCV_IOMMU_PC_FSC_PPN RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_PC_FSC_MODE        RISCV_IOMMU_ATP_MODE_FIELD
> +
> +/*
> + * Chapter 3: In-memory queue interface
> + */
> +
> +/**
> + * struct riscv_iommu_cmd - Generic I/O MMU command structure
> + * @dword0: Includes the opcode and the function identifier
> + * @dword1: Opcode specific data
> + *
> + * The commands are interpreted as two 64bit fields, where the first
> + * 7bits of the first field are the opcode which also defines the
> + * command's format, followed by a 3bit field that specifies the
> + * function invoked by that command, and the rest is opcode-specific.
> + * This is a generic struct which will be populated differently
> + * according to each command. For more infos on the commands and
> + * the command queue check section 3.1.
> + */
> +struct riscv_iommu_command {
> +       u64 dword0;
> +       u64 dword1;
> +};
> +
> +/* Fields on dword0, common for all commands */
> +#define RISCV_IOMMU_CMD_OPCODE GENMASK_ULL(6, 0)
> +#define        RISCV_IOMMU_CMD_FUNC    GENMASK_ULL(9, 7)
> +
> +/* 3.1.1 I/O MMU Page-table cache invalidation */
> +/* Fields on dword0 */
> +#define RISCV_IOMMU_CMD_IOTINVAL_OPCODE                1
> +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA      0
> +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA     1
> +#define RISCV_IOMMU_CMD_IOTINVAL_AV            BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOTINVAL_PSCID         GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_CMD_IOTINVAL_PSCV          BIT_ULL(32)
> +#define RISCV_IOMMU_CMD_IOTINVAL_GV            BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_IOTINVAL_GSCID         GENMASK_ULL(59, 44)
> +/* dword1 is the address, 4K-alligned and shifted to the right by
> + * two bits. */
> +
> +/* 3.1.2 I/O MMU Command Queue Fences */
> +/* Fields on dword0 */
> +#define RISCV_IOMMU_CMD_IOFENCE_OPCODE         2
> +#define RISCV_IOMMU_CMD_IOFENCE_FUNC_C         0
> +#define RISCV_IOMMU_CMD_IOFENCE_AV             BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOFENCE_WSI            BIT_ULL(11)
> +#define RISCV_IOMMU_CMD_IOFENCE_PR             BIT_ULL(12)
> +#define RISCV_IOMMU_CMD_IOFENCE_PW             BIT_ULL(13)
> +#define RISCV_IOMMU_CMD_IOFENCE_DATA           GENMASK_ULL(63, 32)
> +/* dword1 is the address, word-size alligned and shifted to the
> + * right by two bits. */
> +
> +/* 3.1.3 I/O MMU Directory cache invalidation */
> +/* Fields on dword0 */
> +#define RISCV_IOMMU_CMD_IODIR_OPCODE           3
> +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT   0
> +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT   1
> +#define RISCV_IOMMU_CMD_IODIR_PID              GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_CMD_IODIR_DV               BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_IODIR_DID              GENMASK_ULL(63, 40)
> +/* dword1 is reserved for standard use */
> +
> +/* 3.1.4 I/O MMU PCIe ATS */
> +/* Fields on dword0 */
> +#define RISCV_IOMMU_CMD_ATS_OPCODE             4
> +#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL         0
> +#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR          1
> +#define RISCV_IOMMU_CMD_ATS_PID                        GENMASK_ULL(31, 1=
2)
> +#define RISCV_IOMMU_CMD_ATS_PV                 BIT_ULL(32)
> +#define RISCV_IOMMU_CMD_ATS_DSV                        BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_ATS_RID                        GENMASK_ULL(55, 4=
0)
> +#define RISCV_IOMMU_CMD_ATS_DSEG               GENMASK_ULL(63, 56)
> +/* dword1 is the ATS payload, two different payload types for INVAL and =
PRGR */
> +
> +/* ATS.INVAL payload*/
> +#define RISCV_IOMMU_CMD_ATS_INVAL_G            BIT_ULL(0)
> +/* Bits 1 - 10 are zeroed */
> +#define RISCV_IOMMU_CMD_ATS_INVAL_S            BIT_ULL(11)
> +#define RISCV_IOMMU_CMD_ATS_INVAL_UADDR                GENMASK_ULL(63, 1=
2)
> +
> +/* ATS.PRGR payload */
> +/* Bits 0 - 31 are zeroed */
> +#define RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX     GENMASK_ULL(40, 32)
> +/* Bits 41 - 43 are zeroed */
> +#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE     GENMASK_ULL(47, 44)
> +#define RISCV_IOMMU_CMD_ATS_PRGR_DST_ID                GENMASK_ULL(63, 4=
8)
> +
> +/**
> + * struct riscv_iommu_fq_record - Fault/Event Queue Record
> + * @hdr: Header, includes fault/event cause, PID/DID, transaction type e=
tc
> + * @_reserved: Low 32bits for custom use, high 32bits for standard use
> + * @iotval: Transaction-type/cause specific format
> + * @iotval2: Cause specific format
> + *
> + * The fault/event queue reports events and failures raised when
> + * processing transactions. Each record is a 32byte structure where
> + * the first dword has a fixed format for providing generic infos
> + * regarding the fault/event, and two more dwords are there for
> + * fault/event-specific information. For more details see section
> + * 3.2.
> + */
> +struct riscv_iommu_fq_record {
> +       u64 hdr;
> +       u64 _reserved;
> +       u64 iotval;
> +       u64 iotval2;
> +};
> +
> +/* Fields on header */
> +#define RISCV_IOMMU_FQ_HDR_CAUSE       GENMASK_ULL(11, 0)
> +#define RISCV_IOMMU_FQ_HDR_PID         GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_FQ_HDR_PV          BIT_ULL(32)
> +#define RISCV_IOMMU_FQ_HDR_PRIV                BIT_ULL(33)
> +#define RISCV_IOMMU_FQ_HDR_TTYPE       GENMASK_ULL(39, 34)
> +#define RISCV_IOMMU_FQ_HDR_DID         GENMASK_ULL(63, 40)
> +
> +/**
> + * enum riscv_iommu_fq_causes - Fault/event cause values
> + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT: Instruction access fault
> + * @RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED: Read address misaligned
> + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT: Read load fault
> + * @RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED: Write/AMO address misaligne=
d
> + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT: Write/AMO access fault
> + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S: Instruction page fault
> + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S: Read page fault
> + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S: Write/AMO page fault
> + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS: Instruction guest page fault
> + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS: Read guest page fault
> + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS: Write/AMO guest page fault
> + * @RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED: All inbound transactions disallow=
ed
> + * @RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT: DDT entry load access fault
> + * @RISCV_IOMMU_FQ_CAUSE_DDT_INVALID: DDT entry invalid
> + * @RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED: DDT entry misconfigured
> + * @RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED: Transaction type disallowed
> + * @RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT: MSI PTE load access fault
> + * @RISCV_IOMMU_FQ_CAUSE_MSI_INVALID: MSI PTE invalid
> + * @RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED: MSI PTE misconfigured
> + * @RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT: MRIF access fault
> + * @RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT: PDT entry load access fault
> + * @RISCV_IOMMU_FQ_CAUSE_PDT_INVALID: PDT entry invalid
> + * @RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED: PDT entry misconfigured
> + * @RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED: DDT data corruption
> + * @RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED: PDT data corruption
> + * @RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED: MSI page table data corruptio=
n
> + * @RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED: MRIF data corruption
> + * @RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR: Internal data path error
> + * @RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT: IOMMU MSI write access fault
> + * @RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED: First/second stage page table dat=
a corruption
> + *
> + * Values are on table 11 of the spec, encodings 275 - 2047 are reserved=
 for standard
> + * use, and 2048 - 4095 for custom use.
> + */
> +enum riscv_iommu_fq_causes {
> +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT =3D 1,
> +       RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED =3D 4,
> +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT =3D 5,
> +       RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED =3D 6,
> +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT =3D 7,
> +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S =3D 12,
> +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S =3D 13,
> +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S =3D 15,
> +       RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS =3D 20,
> +       RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS =3D 21,
> +       RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS =3D 23,
> +       RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED =3D 256,
> +       RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT =3D 257,
> +       RISCV_IOMMU_FQ_CAUSE_DDT_INVALID =3D 258,
> +       RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED =3D 259,
> +       RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED =3D 260,
> +       RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT =3D 261,
> +       RISCV_IOMMU_FQ_CAUSE_MSI_INVALID =3D 262,
> +       RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED =3D 263,
> +       RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT =3D 264,
> +       RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT =3D 265,
> +       RISCV_IOMMU_FQ_CAUSE_PDT_INVALID =3D 266,
> +       RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED =3D 267,
> +       RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED =3D 268,
> +       RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED =3D 269,
> +       RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED =3D 270,
> +       RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED =3D 271,
> +       RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR =3D 272,
> +       RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT =3D 273,
> +       RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED =3D 274
> +};
> +
> +/**
> + * enum riscv_iommu_fq_ttypes: Fault/event transaction types
> + * @RISCV_IOMMU_FQ_TTYPE_NONE: None. Fault not caused by an inbound tran=
saction.
> + * @RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH: Instruction fetch from untran=
slated address
> + * @RISCV_IOMMU_FQ_TTYPE_UADDR_RD: Read from untranslated address
> + * @RISCV_IOMMU_FQ_TTYPE_UADDR_WR: Write/AMO to untranslated address
> + * @RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH: Instruction fetch from transl=
ated address
> + * @RISCV_IOMMU_FQ_TTYPE_TADDR_RD: Read from translated address
> + * @RISCV_IOMMU_FQ_TTYPE_TADDR_WR: Write/AMO to translated address
> + * @RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ: PCIe ATS translation request
> + * @RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ: PCIe message request
> + *
> + * Values are on table 12 of the spec, type 4 and 10 - 31 are reserved f=
or standard use
> + * and 31 - 63 for custom use.
> + */
> +enum riscv_iommu_fq_ttypes {
> +       RISCV_IOMMU_FQ_TTYPE_NONE =3D 0,
> +       RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH =3D 1,
> +       RISCV_IOMMU_FQ_TTYPE_UADDR_RD =3D 2,
> +       RISCV_IOMMU_FQ_TTYPE_UADDR_WR =3D 3,
> +       RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH =3D 5,
> +       RISCV_IOMMU_FQ_TTYPE_TADDR_RD =3D 6,
> +       RISCV_IOMMU_FQ_TTYPE_TADDR_WR =3D 7,
> +       RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ =3D 8,
> +       RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 9,
> +};
> +
> +/**
> + * struct riscv_iommu_pq_record - PCIe Page Request record
> + * @hdr: Header, includes PID, DID etc
> + * @payload: Holds the page address, request group and permission bits
> + *
> + * For more infos on the PCIe Page Request queue see chapter 3.3.
> + */
> +struct riscv_iommu_pq_record {
> +       u64 hdr;
> +       u64 payload;
> +};
> +
> +/* Header fields */
> +#define RISCV_IOMMU_PREQ_HDR_PID       GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_PREQ_HDR_PV                BIT_ULL(32)
> +#define RISCV_IOMMU_PREQ_HDR_PRIV      BIT_ULL(33)
> +#define RISCV_IOMMU_PREQ_HDR_EXEC      BIT_ULL(34)
> +#define RISCV_IOMMU_PREQ_HDR_DID       GENMASK_ULL(63, 40)
> +
> +/* Payload fields */
> +#define RISCV_IOMMU_PREQ_PAYLOAD_R     BIT_ULL(0)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_W     BIT_ULL(1)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_L     BIT_ULL(2)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_M     GENMASK_ULL(2, 0)       /* Mask o=
f RWL for convenience */
> +#define RISCV_IOMMU_PREQ_PRG_INDEX     GENMASK_ULL(11, 3)
> +#define RISCV_IOMMU_PREQ_UADDR         GENMASK_ULL(63, 12)
> +
> +/**
> + * struct riscv_iommu_msi_pte - MSI Page Table Entry
> + * @pte: MSI PTE
> + * @mrif_info: Memory-resident interrupt file info
> + *
> + * The MSI Page Table is used for virtualizing MSIs, so that when
> + * a device sends an MSI to a guest, the IOMMU can reroute it
> + * by translating the MSI address, either to a guest interrupt file
> + * or a memory resident interrupt file (MRIF). Note that this page table
> + * is an array of MSI PTEs, not a multi-level pt, each entry
> + * is a leaf entry. For more infos check out the the AIA spec, chapter 9=
.5.
> + *
> + * Also in basic mode the mrif_info field is ignored by the IOMMU and ca=
n
> + * be used by software, any other reserved fields on pte must be zeroed-=
out
> + * by software.
> + */
> +struct riscv_iommu_msi_pte {
> +       u64 pte;
> +       u64 mrif_info;
> +};
> +
> +/* Fields on pte */
> +#define RISCV_IOMMU_MSI_PTE_V          BIT_ULL(0)
> +#define RISCV_IOMMU_MSI_PTE_M          GENMASK_ULL(2, 1)
> +#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR  GENMASK_ULL(53, 7)      /* When M=
 =3D=3D 1 (MRIF mode) */
> +#define RISCV_IOMMU_MSI_PTE_PPN                RISCV_IOMMU_PPN_FIELD   /=
* When M =3D=3D 3 (basic mode) */
> +#define RISCV_IOMMU_MSI_PTE_C          BIT_ULL(63)
> +
> +/* Fields on mrif_info */
> +#define RISCV_IOMMU_MSI_MRIF_NID       GENMASK_ULL(9, 0)
> +#define RISCV_IOMMU_MSI_MRIF_NPPN      RISCV_IOMMU_PPN_FIELD
> +#define RISCV_IOMMU_MSI_MRIF_NID_MSB   BIT_ULL(60)
> +
> +#endif /* _RISCV_IOMMU_BITS_H_ */
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-=
pci.c
> new file mode 100644
> index 000000000000..c91f963d7a29
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + *
> + * RISCV IOMMU as a PCIe device
> + *
> + * Authors
> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> + *     Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/iommu.h>
> +#include <linux/bitfield.h>
> +
> +#include "iommu.h"
> +
> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
> +#ifndef PCI_VENDOR_ID_RIVOS
> +#define PCI_VENDOR_ID_RIVOS             0x1efd
> +#endif
> +
> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
> +#endif
> +
> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_=
device_id *ent)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct riscv_iommu_device *iommu;
> +       int ret;
> +
> +       ret =3D pci_enable_device_mem(pdev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +       if (ret < 0)
> +               goto fail;
> +
> +       ret =3D -ENOMEM;
> +
> +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +       if (!iommu)
> +               goto fail;
> +
> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
> +               goto fail;
> +
> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
> +               goto fail;
> +
> +       iommu->reg_phys =3D pci_resource_start(pdev, 0);
> +       if (!iommu->reg_phys)
> +               goto fail;
> +
> +       iommu->reg =3D devm_ioremap(dev, iommu->reg_phys, RISCV_IOMMU_REG=
_SIZE);
> +       if (!iommu->reg)
> +               goto fail;
> +
> +       iommu->dev =3D dev;
> +       dev_set_drvdata(dev, iommu);
> +
> +       dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +       pci_set_master(pdev);
> +
> +       ret =3D riscv_iommu_init(iommu);
> +       if (!ret)
> +               return ret;
> +
> + fail:
> +       pci_clear_master(pdev);
> +       pci_release_regions(pdev);
> +       pci_disable_device(pdev);
> +       /* Note: devres_release_all() will release iommu and iommu->reg *=
/
> +       return ret;
> +}
> +
> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> +{
> +       riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +       pci_clear_master(pdev);
> +       pci_release_regions(pdev);
> +       pci_disable_device(pdev);
> +}
> +
> +static int riscv_iommu_suspend(struct device *dev)
> +{
> +       dev_warn(dev, "RISC-V IOMMU PM not implemented");
> +       return -ENODEV;
> +}
> +
> +static int riscv_iommu_resume(struct device *dev)
> +{
> +       dev_warn(dev, "RISC-V IOMMU PM not implemented");
> +       return -ENODEV;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(riscv_iommu_pm_ops, riscv_iommu_suspend,
> +                               riscv_iommu_resume);
> +
> +static const struct pci_device_id riscv_iommu_pci_tbl[] =3D {
> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +       {0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, riscv_iommu_pci_tbl);
> +
> +static const struct of_device_id riscv_iommu_of_match[] =3D {
> +       {.compatible =3D "riscv,pci-iommu",},
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
> +
> +static struct pci_driver riscv_iommu_pci_driver =3D {
> +       .name =3D KBUILD_MODNAME,
> +       .id_table =3D riscv_iommu_pci_tbl,
> +       .probe =3D riscv_iommu_pci_probe,
> +       .remove =3D riscv_iommu_pci_remove,
> +       .driver =3D {
> +                  .pm =3D pm_sleep_ptr(&riscv_iommu_pm_ops),
> +                  .of_match_table =3D riscv_iommu_of_match,
> +                  },
> +};
> +
> +module_driver(riscv_iommu_pci_driver, pci_register_driver, pci_unregiste=
r_driver);
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/i=
ommu-platform.c
> new file mode 100644
> index 000000000000..e4e8ca6711e7
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RISC-V IOMMU as a platform device
> + *
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + *
> + * Author: Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/bitfield.h>
> +
> +#include "iommu-bits.h"
> +#include "iommu.h"
> +
> +static int riscv_iommu_platform_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct riscv_iommu_device *iommu =3D NULL;
> +       struct resource *res =3D NULL;
> +       int ret =3D 0;
> +
> +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +       if (!iommu)
> +               return -ENOMEM;
> +
> +       iommu->dev =3D dev;
> +       dev_set_drvdata(dev, iommu);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(dev, "could not find resource for register region=
\n");
> +               return -EINVAL;
> +       }
> +
> +       iommu->reg =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r=
es);
> +       if (IS_ERR(iommu->reg)) {
> +               ret =3D dev_err_probe(dev, PTR_ERR(iommu->reg),
> +                                   "could not map register region\n");
> +               goto fail;
> +       };
> +
> +       iommu->reg_phys =3D res->start;
> +
> +       ret =3D -ENODEV;
> +
> +       /* Sanity check: Did we get the whole register space ? */
> +       if ((res->end - res->start + 1) < RISCV_IOMMU_REG_SIZE) {
> +               dev_err(dev, "device region smaller than register file (0=
x%llx)\n",
> +                       res->end - res->start);
> +               goto fail;
> +       }

Could we assume that DT should be responsible for specifying the right size=
?

> +
> +       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +
> +       return riscv_iommu_init(iommu);
> +
> + fail:
> +       /* Note: devres_release_all() will release iommu and iommu->reg *=
/
> +       return ret;
> +};
> +
> +static void riscv_iommu_platform_remove(struct platform_device *pdev)
> +{
> +       riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +};
> +
> +static void riscv_iommu_platform_shutdown(struct platform_device *pdev)
> +{
> +       return;
> +};
> +
> +static const struct of_device_id riscv_iommu_of_match[] =3D {
> +       {.compatible =3D "riscv,iommu",},
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
> +
> +static struct platform_driver riscv_iommu_platform_driver =3D {
> +       .driver =3D {
> +                  .name =3D "riscv,iommu",
> +                  .of_match_table =3D riscv_iommu_of_match,
> +                  .suppress_bind_attrs =3D true,
> +                  },
> +       .probe =3D riscv_iommu_platform_probe,
> +       .remove_new =3D riscv_iommu_platform_remove,
> +       .shutdown =3D riscv_iommu_platform_shutdown,
> +};
> +
> +module_driver(riscv_iommu_platform_driver, platform_driver_register,
> +             platform_driver_unregister);
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> new file mode 100644
> index 000000000000..8c236242e2cc
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IOMMU API for RISC-V architected Ziommu implementations.
> + *
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + *
> + * Authors
> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> + *     Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ats.h>
> +#include <linux/init.h>
> +#include <linux/completion.h>
> +#include <linux/uaccess.h>
> +#include <linux/iommu.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-map-ops.h>
> +#include <asm/page.h>
> +
> +#include "../dma-iommu.h"
> +#include "../iommu-sva.h"
> +#include "iommu.h"
> +
> +#include <asm/csr.h>
> +#include <asm/delay.h>
> +
> +MODULE_DESCRIPTION("IOMMU driver for RISC-V architected Ziommu implement=
ations");
> +MODULE_AUTHOR("Tomasz Jeznach <tjeznach@rivosinc.com>");
> +MODULE_AUTHOR("Nick Kossifidis <mick@ics.forth.gr>");
> +MODULE_ALIAS("riscv-iommu");
> +MODULE_LICENSE("GPL v2");
> +
> +/* Global IOMMU params. */
> +static int ddt_mode =3D RISCV_IOMMU_DDTP_MODE_BARE;
> +module_param(ddt_mode, int, 0644);
> +MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
> +
> +/* IOMMU PSCID allocation namespace. */
> +#define RISCV_IOMMU_MAX_PSCID  (1U << 20)
> +static DEFINE_IDA(riscv_iommu_pscids);
> +
> +/* 1 second */
> +#define RISCV_IOMMU_TIMEOUT    riscv_timebase
> +
> +/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=3D> PPN[53:10] *=
/
> +#define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
> +#define ppn_to_phys(pn)         (((pn) << 2) & (((1ULL << 44) - 1) << 12=
))
> +
> +#define iommu_domain_to_riscv(iommu_domain) \
> +    container_of(iommu_domain, struct riscv_iommu_domain, domain)
> +
> +#define iommu_device_to_riscv(iommu_device) \
> +    container_of(iommu_device, struct riscv_iommu, iommu)
> +
> +static const struct iommu_domain_ops riscv_iommu_domain_ops;
> +static const struct iommu_ops riscv_iommu_ops;
> +
> +/*
> + * Register device for IOMMU tracking.
> + */
> +static void riscv_iommu_add_device(struct riscv_iommu_device *iommu, str=
uct device *dev)
> +{
> +       struct riscv_iommu_endpoint *ep, *rb_ep;
> +       struct rb_node **new_node, *parent_node =3D NULL;
> +
> +       mutex_lock(&iommu->eps_mutex);
> +
> +       ep =3D dev_iommu_priv_get(dev);
> +
> +       new_node =3D &(iommu->eps.rb_node);
> +       while (*new_node) {
> +               rb_ep =3D rb_entry(*new_node, struct riscv_iommu_endpoint=
, node);
> +               parent_node =3D *new_node;
> +               if (rb_ep->devid > ep->devid) {
> +                       new_node =3D &((*new_node)->rb_left);
> +               } else if (rb_ep->devid < ep->devid) {
> +                       new_node =3D &((*new_node)->rb_right);
> +               } else {
> +                       dev_warn(dev, "device %u already in the tree\n", =
ep->devid);
> +                       break;
> +               }
> +       }
> +
> +       rb_link_node(&ep->node, parent_node, new_node);
> +       rb_insert_color(&ep->node, &iommu->eps);
> +
> +       mutex_unlock(&iommu->eps_mutex);
> +}
> +
> +/*
> + * Endpoint management
> + */
> +
> +static int riscv_iommu_of_xlate(struct device *dev, struct of_phandle_ar=
gs *args)
> +{
> +       return iommu_fwspec_add_ids(dev, args->args, 1);
> +}
> +
> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +       switch (cap) {
> +       case IOMMU_CAP_CACHE_COHERENCY:
> +       case IOMMU_CAP_PRE_BOOT_PROTECTION:
> +               return true;
> +
> +       default:
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
> +{
> +       struct riscv_iommu_device *iommu;
> +       struct riscv_iommu_endpoint *ep;
> +       struct iommu_fwspec *fwspec;
> +
> +       fwspec =3D dev_iommu_fwspec_get(dev);
> +       if (!fwspec || fwspec->ops !=3D &riscv_iommu_ops ||
> +           !fwspec->iommu_fwnode || !fwspec->iommu_fwnode->dev)
> +               return ERR_PTR(-ENODEV);
> +
> +       iommu =3D dev_get_drvdata(fwspec->iommu_fwnode->dev);
> +       if (!iommu)
> +               return ERR_PTR(-ENODEV);
> +
> +       if (dev_iommu_priv_get(dev))
> +               return &iommu->iommu;
> +
> +       ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> +       if (!ep)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_init(&ep->lock);
> +       INIT_LIST_HEAD(&ep->domain);
> +
> +       if (dev_is_pci(dev)) {
> +               ep->devid =3D pci_dev_id(to_pci_dev(dev));
> +               ep->domid =3D pci_domain_nr(to_pci_dev(dev)->bus);
> +       } else {
> +               /* TODO: Make this generic, for now hardcode domain id to=
 0 */
> +               ep->devid =3D fwspec->ids[0];
> +               ep->domid =3D 0;
> +       }
> +
> +       ep->iommu =3D iommu;
> +       ep->dev =3D dev;
> +
> +       dev_info(iommu->dev, "adding device to iommu with devid %i in dom=
ain %i\n",
> +               ep->devid, ep->domid);
> +
> +       dev_iommu_priv_set(dev, ep);
> +       riscv_iommu_add_device(iommu, dev);
> +
> +       return &iommu->iommu;
> +}
> +
> +static void riscv_iommu_probe_finalize(struct device *dev)
> +{
> +       set_dma_ops(dev, NULL);
> +       iommu_setup_dma_ops(dev, 0, U64_MAX);
> +}
> +
> +static void riscv_iommu_release_device(struct device *dev)
> +{
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +       struct riscv_iommu_device *iommu =3D ep->iommu;
> +
> +       dev_info(dev, "device with devid %i released\n", ep->devid);
> +
> +       mutex_lock(&ep->lock);
> +       list_del(&ep->domain);
> +       mutex_unlock(&ep->lock);
> +
> +       /* Remove endpoint from IOMMU tracking structures */
> +       mutex_lock(&iommu->eps_mutex);
> +       rb_erase(&ep->node, &iommu->eps);
> +       mutex_unlock(&iommu->eps_mutex);
> +
> +       set_dma_ops(dev, NULL);
> +       dev_iommu_priv_set(dev, NULL);
> +
> +       kfree(ep);
> +}
> +
> +static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> +{
> +       if (dev_is_pci(dev))
> +               return pci_device_group(dev);
> +       return generic_device_group(dev);
> +}
> +
> +static void riscv_iommu_get_resv_regions(struct device *dev, struct list=
_head *head)
> +{
> +       iommu_dma_get_resv_regions(dev, head);
> +}
> +
> +/*
> + * Domain management
> + */
> +
> +static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
> +{
> +       struct riscv_iommu_domain *domain;
> +
> +       if (type !=3D IOMMU_DOMAIN_IDENTITY &&
> +           type !=3D IOMMU_DOMAIN_BLOCKED)
> +               return NULL;
> +
> +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> +       if (!domain)
> +               return NULL;
> +
> +       mutex_init(&domain->lock);
> +       INIT_LIST_HEAD(&domain->endpoints);
> +
> +       domain->domain.ops =3D &riscv_iommu_domain_ops;
> +       domain->mode =3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> +                                       RISCV_IOMMU_MAX_PSCID, GFP_KERNEL=
);
> +
> +       printk("domain type %x alloc %u\n", type, domain->pscid);
> +

Could it uses pr_xxx instead of printk?

> +       return &domain->domain;
> +}
> +
> +static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       if (!list_empty(&domain->endpoints)) {
> +               pr_warn("IOMMU domain is not empty!\n");
> +       }
> +
> +       if (domain->pgd_root)
> +               free_pages((unsigned long)domain->pgd_root, 0);
> +
> +       if ((int)domain->pscid > 0)
> +               ida_free(&riscv_iommu_pscids, domain->pscid);
> +
> +       printk("domain free %u\n", domain->pscid);
> +

Could it uses pr_xxx instead of printk?

> +       kfree(domain);
> +}
> +
> +static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain=
,
> +                                      struct riscv_iommu_device *iommu)
> +{
> +       struct iommu_domain_geometry *geometry;
> +
> +       /* Domain assigned to another iommu */
> +       if (domain->iommu && domain->iommu !=3D iommu)
> +               return -EINVAL;
> +       /* Domain already initialized */
> +       else if (domain->iommu)
> +               return 0;
> +
> +       /*
> +        * TODO: Before using VA_BITS and satp_mode here, verify they
> +        * are supported by the iommu, through the capabilities register.
> +        */
> +
> +       geometry =3D &domain->domain.geometry;
> +
> +       /*
> +        * Note: RISC-V Privilege spec mandates that virtual addresses
> +        * need to be sign-extended, so if (VA_BITS - 1) is set, all
> +        * bits >=3D VA_BITS need to also be set or else we'll get a
> +        * page fault. However the code that creates the mappings
> +        * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> +        * for now, so we'll end up with invalid virtual addresses
> +        * to map. As a workaround until we get this sorted out
> +        * limit the available virtual addresses to VA_BITS - 1.
> +        */
> +       geometry->aperture_start =3D 0;
> +       geometry->aperture_end =3D DMA_BIT_MASK(VA_BITS - 1);
> +       geometry->force_aperture =3D true;
> +
> +       domain->iommu =3D iommu;
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +               return 0;
> +
> +       /* TODO: Fix this for RV32 */
> +       domain->mode =3D satp_mode >> 60;
> +       domain->pgd_root =3D (pgd_t *) __get_free_pages(GFP_KERNEL | __GF=
P_ZERO, 0);
> +
> +       if (!domain->pgd_root)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, str=
uct device *dev)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +       int ret;
> +
> +       /* PSCID not valid */
> +       if ((int)domain->pscid < 0)
> +               return -ENOMEM;
> +
> +       mutex_lock(&domain->lock);
> +       mutex_lock(&ep->lock);
> +
> +       if (!list_empty(&ep->domain)) {
> +               dev_warn(dev, "endpoint already attached to a domain. dro=
pping\n");
> +               list_del_init(&ep->domain);
> +       }
> +
> +       /* allocate root pages, initialize io-pgtable ops, etc. */
> +       ret =3D riscv_iommu_domain_finalize(domain, ep->iommu);
> +       if (ret < 0) {
> +               dev_err(dev, "can not finalize domain: %d\n", ret);
> +               mutex_unlock(&ep->lock);
> +               mutex_unlock(&domain->lock);
> +               return ret;
> +       }
> +
> +       if (ep->iommu->ddt_mode !=3D RISCV_IOMMU_DDTP_MODE_BARE ||
> +           domain->domain.type !=3D IOMMU_DOMAIN_IDENTITY) {
> +               dev_warn(dev, "domain type %d not supported\n",
> +                   domain->domain.type);
> +               return -ENODEV;
> +       }
> +
> +       list_add_tail(&ep->domain, &domain->endpoints);
> +       mutex_unlock(&ep->lock);
> +       mutex_unlock(&domain->lock);
> +
> +       dev_info(dev, "domain type %d attached w/ PSCID %u\n",
> +           domain->domain.type, domain->pscid);
> +
> +       return 0;
> +}
> +
> +static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_dom=
ain,
> +                                         unsigned long *start, unsigned =
long *end,
> +                                         size_t *pgsize)
> +{
> +       /* Command interface not implemented */
> +}
> +
> +static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domai=
n)
> +{
> +       riscv_iommu_flush_iotlb_range(iommu_domain, NULL, NULL, NULL);
> +}
> +
> +static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
> +                                  struct iommu_iotlb_gather *gather)
> +{
> +       riscv_iommu_flush_iotlb_range(iommu_domain, &gather->start, &gath=
er->end,
> +                                     &gather->pgsize);
> +}
> +
> +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain=
,
> +                                      unsigned long iova, size_t size)
> +{
> +       unsigned long end =3D iova + size - 1;
> +       /*
> +        * Given we don't know the page size used by this range, we assum=
e the
> +        * smallest page size to ensure all possible entries are flushed =
from
> +        * the IOATC.
> +        */
> +       size_t pgsize =3D PAGE_SIZE;
> +       riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize)=
;
> +}
> +
> +static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
> +                                unsigned long iova, phys_addr_t phys,
> +                                size_t pgsize, size_t pgcount, int prot,
> +                                gfp_t gfp, size_t *mapped)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +               *mapped =3D pgsize * pgcount;
> +               return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> +                                     unsigned long iova, size_t pgsize,
> +                                     size_t pgcount, struct iommu_iotlb_=
gather *gather)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +               return pgsize * pgcount;
> +
> +       return 0;
> +}
> +
> +static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_d=
omain,
> +                                           dma_addr_t iova)
> +{
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +               return (phys_addr_t) iova;
> +
> +       return 0;
> +}
> +
> +/*
> + * Translation mode setup
> + */
> +
> +static u64 riscv_iommu_get_ddtp(struct riscv_iommu_device *iommu)
> +{
> +       u64 ddtp;
> +       cycles_t end_cycles =3D RISCV_IOMMU_TIMEOUT + get_cycles();
> +
> +       /* Wait for DDTP.BUSY to be cleared and return latest value */
> +       do {
> +               ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> +               if (!(ddtp & RISCV_IOMMU_DDTP_BUSY))
> +                       break;
> +               cpu_relax();
> +       } while (get_cycles() < end_cycles);
> +
> +       return ddtp;
> +}
> +
> +static void riscv_iommu_ddt_cleanup(struct riscv_iommu_device *iommu)
> +{
> +       /* TODO: teardown whole device directory tree. */
> +       if (iommu->ddtp) {
> +               if (iommu->ddtp_in_iomem) {
> +                       iounmap((void *)iommu->ddtp);
> +               } else
> +                       free_page(iommu->ddtp);
> +               iommu->ddtp =3D 0;
> +       }
> +}
> +
> +static int riscv_iommu_enable(struct riscv_iommu_device *iommu, unsigned=
 requested_mode)
> +{
> +       struct device *dev =3D iommu->dev;
> +       u64 ddtp =3D 0;
> +       u64 ddtp_paddr =3D 0;
> +       unsigned mode =3D requested_mode;
> +       unsigned mode_readback =3D 0;
> +
> +       ddtp =3D riscv_iommu_get_ddtp(iommu);
> +       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> +               return -EBUSY;
> +
> +       /* Disallow state transtion from xLVL to xLVL. */
> +       switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> +       case RISCV_IOMMU_DDTP_MODE_BARE:
> +       case RISCV_IOMMU_DDTP_MODE_OFF:
> +               break;
> +       default:
> +               if ((mode !=3D RISCV_IOMMU_DDTP_MODE_BARE)
> +                   && (mode !=3D RISCV_IOMMU_DDTP_MODE_OFF))
> +                       return -EINVAL;
> +               break;
> +       }
> +
> + retry:

We need to consider the `iommu.passthrough` before we set up the mode
in switch case, something like

if (iommu_default_passthrough()) {
        /* set ddtp to bare mode */
}

> +       switch (mode) {
> +       case RISCV_IOMMU_DDTP_MODE_BARE:
> +       case RISCV_IOMMU_DDTP_MODE_OFF:
> +               riscv_iommu_ddt_cleanup(iommu);
> +               ddtp =3D FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode);
> +               break;
> +       case RISCV_IOMMU_DDTP_MODE_1LVL:
> +       case RISCV_IOMMU_DDTP_MODE_2LVL:
> +       case RISCV_IOMMU_DDTP_MODE_3LVL:
> +               if (!iommu->ddtp) {
> +                       /*
> +                        * We haven't initialized ddtp yet, since it's WA=
RL make
> +                        * sure that we don't have a hardwired PPN field =
there
> +                        * that points to i/o memory instead.
> +                        */
> +                       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, 0=
);
> +                       ddtp =3D riscv_iommu_get_ddtp(iommu);
> +                       ddtp_paddr =3D ppn_to_phys(ddtp);
> +                       if (ddtp_paddr) {
> +                               dev_warn(dev, "ddtp at 0x%llx\n", ddtp_pa=
ddr);
> +                               iommu->ddtp =3D
> +                                   (unsigned long)ioremap(ddtp_paddr, PA=
GE_SIZE);
> +                               iommu->ddtp_in_iomem =3D true;
> +                       } else {
> +                               iommu->ddtp =3D get_zeroed_page(GFP_KERNE=
L);
> +                       }
> +               }
> +               if (!iommu->ddtp)
> +                       return -ENOMEM;
> +
> +               ddtp =3D FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode) |
> +                   phys_to_ppn(__pa(iommu->ddtp));
> +
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, ddtp);
> +       ddtp =3D riscv_iommu_get_ddtp(iommu);
> +       if (ddtp & RISCV_IOMMU_DDTP_BUSY) {
> +               dev_warn(dev, "timeout when setting ddtp (ddt mode: %i)\n=
", mode);
> +               return -EBUSY;
> +       }
> +
> +       mode_readback =3D FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
> +       dev_info(dev, "mode_readback: %i, mode: %i\n", mode_readback, mod=
e);
> +       if (mode_readback !=3D mode) {
> +               /*
> +                * Mode field is WARL, an I/O MMU may support a subset of
> +                * directory table levels in which case if we tried to se=
t
> +                * an unsupported number of levels we'll readback either
> +                * a valid xLVL or off/bare. If we got off/bare, try agai=
n
> +                * with a smaller xLVL.
> +                */
> +               if (mode_readback < RISCV_IOMMU_DDTP_MODE_1LVL &&
> +                   mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
> +                       mode--;
> +                       goto retry;
> +               }
> +
> +               /*
> +                * We tried all supported xLVL modes and still got off/ba=
re instead,
> +                * an I/O MMU must support at least one supported xLVL mo=
de so something
> +                * went very wrong.
> +                */
> +               if (mode_readback < RISCV_IOMMU_DDTP_MODE_1LVL &&
> +                   mode =3D=3D RISCV_IOMMU_DDTP_MODE_1LVL)
> +                       goto fail;
> +
> +               /*
> +                * We tried setting off or bare and got something else ba=
ck, something
> +                * went very wrong since off/bare is always legal.
> +                */
> +               if (mode < RISCV_IOMMU_DDTP_MODE_1LVL)
> +                       goto fail;
> +
> +               /*
> +                * We tried setting an xLVL mode but got another xLVL mod=
e that
> +                * we don't support (e.g. a custom one).
> +                */
> +               if (mode_readback > RISCV_IOMMU_DDTP_MODE_MAX)
> +                       goto fail;
> +
> +               /* We tried setting an xLVL mode but got another supporte=
d xLVL mode */
> +               mode =3D mode_readback;
> +       }
> +
> +       if (mode !=3D requested_mode)
> +               dev_warn(dev, "unsupported DDT mode requested (%i), using=
 %i instead\n",
> +                        requested_mode, mode);
> +
> +       iommu->ddt_mode =3D mode;
> +       dev_info(dev, "ddt_mode: %i\n", iommu->ddt_mode);
> +       return 0;
> +
> + fail:
> +       dev_err(dev, "failed to set DDT mode, tried: %i and got %i\n", mo=
de,
> +               mode_readback);
> +       riscv_iommu_ddt_cleanup(iommu);
> +       return -EINVAL;
> +}
> +
> +/*
> + * Common I/O MMU driver probe/teardown
> + */
> +
> +static const struct iommu_domain_ops riscv_iommu_domain_ops =3D {
> +       .free =3D riscv_iommu_domain_free,
> +       .attach_dev =3D riscv_iommu_attach_dev,
> +       .map_pages =3D riscv_iommu_map_pages,
> +       .unmap_pages =3D riscv_iommu_unmap_pages,
> +       .iova_to_phys =3D riscv_iommu_iova_to_phys,
> +       .iotlb_sync =3D riscv_iommu_iotlb_sync,
> +       .iotlb_sync_map =3D riscv_iommu_iotlb_sync_map,
> +       .flush_iotlb_all =3D riscv_iommu_flush_iotlb_all,
> +};
> +
> +static const struct iommu_ops riscv_iommu_ops =3D {
> +       .owner =3D THIS_MODULE,
> +       .pgsize_bitmap =3D SZ_4K | SZ_2M | SZ_512M,
> +       .capable =3D riscv_iommu_capable,
> +       .domain_alloc =3D riscv_iommu_domain_alloc,
> +       .probe_device =3D riscv_iommu_probe_device,
> +       .probe_finalize =3D riscv_iommu_probe_finalize,
> +       .release_device =3D riscv_iommu_release_device,
> +       .device_group =3D riscv_iommu_device_group,
> +       .get_resv_regions =3D riscv_iommu_get_resv_regions,
> +       .of_xlate =3D riscv_iommu_of_xlate,
> +       .default_domain_ops =3D &riscv_iommu_domain_ops,
> +};
> +
> +void riscv_iommu_remove(struct riscv_iommu_device *iommu)
> +{
> +       iommu_device_unregister(&iommu->iommu);
> +       riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +}
> +
> +int riscv_iommu_init(struct riscv_iommu_device *iommu)
> +{
> +       struct device *dev =3D iommu->dev;
> +       u32 fctl =3D 0;
> +       int ret;
> +
> +       iommu->eps =3D RB_ROOT;
> +
> +       fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +       if (!(cap & RISCV_IOMMU_CAP_END)) {
> +               dev_err(dev, "IOMMU doesn't support Big Endian\n");
> +               return -EIO;
> +       } else if (!(fctl & RISCV_IOMMU_FCTL_BE)) {
> +               fctl |=3D FIELD_PREP(RISCV_IOMMU_FCTL_BE, 1);
> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> +       }
> +#endif
> +
> +       /* Clear any pending interrupt flag. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
> +                          RISCV_IOMMU_IPSR_CIP |
> +                          RISCV_IOMMU_IPSR_FIP |
> +                          RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP);
> +       spin_lock_init(&iommu->cq_lock);
> +       mutex_init(&iommu->eps_mutex);
> +
> +       ret =3D riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
> +
> +       if (ret) {
> +               dev_err(dev, "cannot enable iommu device (%d)\n", ret);
> +               goto fail;
> +       }
> +
> +       ret =3D iommu_device_register(&iommu->iommu, &riscv_iommu_ops, de=
v);
> +       if (ret) {
> +               dev_err(dev, "cannot register iommu interface (%d)\n", re=
t);
> +               iommu_device_sysfs_remove(&iommu->iommu);
> +               goto fail;
> +       }
> +
> +       return 0;
> + fail:
> +       riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +       return ret;
> +}
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> new file mode 100644
> index 000000000000..7baefd3630b3
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + *
> + * RISC-V Ziommu - IOMMU Interface Specification.
> + *
> + * Authors
> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> + *     Nick Kossifidis <mick@ics.forth.gr>
> + */
> +
> +#ifndef _RISCV_IOMMU_H_
> +#define _RISCV_IOMMU_H_
> +
> +#include <linux/types.h>
> +#include <linux/iova.h>
> +#include <linux/io.h>
> +#include <linux/idr.h>
> +#include <linux/list.h>
> +#include <linux/iommu.h>
> +#include <linux/io-pgtable.h>
> +
> +#include "iommu-bits.h"
> +
> +#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
> +#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
> +#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
> +#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
> +
> +struct riscv_iommu_device {
> +       struct iommu_device iommu;      /* iommu core interface */
> +       struct device *dev;             /* iommu hardware */
> +
> +       /* hardware control register space */
> +       void __iomem *reg;
> +       resource_size_t reg_phys;
> +
> +       /* IRQs for the various queues */
> +       int irq_cmdq;
> +       int irq_fltq;
> +       int irq_pm;
> +       int irq_priq;
> +
> +       /* supported and enabled hardware capabilities */
> +       u64 cap;
> +
> +       /* global lock, to be removed */
> +       spinlock_t cq_lock;
> +
> +       /* device directory table root pointer and mode */
> +       unsigned long ddtp;
> +       unsigned ddt_mode;
> +       bool ddtp_in_iomem;
> +
> +       /* Connected end-points */
> +       struct rb_root eps;
> +       struct mutex eps_mutex;
> +};
> +
> +struct riscv_iommu_domain {
> +       struct iommu_domain domain;
> +
> +       struct list_head endpoints;
> +       struct mutex lock;
> +       struct riscv_iommu_device *iommu;
> +
> +       unsigned mode;          /* RIO_ATP_MODE_* enum */
> +       unsigned pscid;         /* RISC-V IOMMU PSCID */
> +
> +       pgd_t *pgd_root;        /* page table root pointer */
> +};
> +
> +/* Private dev_iommu_priv object, device-domain relationship. */
> +struct riscv_iommu_endpoint {
> +       struct device *dev;                     /* platform or PCI endpoi=
nt device */
> +       unsigned devid;                         /* PCI bus:device:functio=
n number */
> +       unsigned domid;                         /* PCI domain number, seg=
ment */
> +       struct rb_node node;                    /* device tracking node (=
lookup by devid) */
> +       struct riscv_iommu_device *iommu;       /* parent iommu device */
> +
> +       struct mutex lock;
> +       struct list_head domain;                /* endpoint attached mana=
ged domain */
> +};
> +
> +/* Helper functions and macros */
> +
> +static inline u32 riscv_iommu_readl(struct riscv_iommu_device *iommu,
> +                                   unsigned offset)
> +{
> +       return readl_relaxed(iommu->reg + offset);
> +}
> +
> +static inline void riscv_iommu_writel(struct riscv_iommu_device *iommu,
> +                                     unsigned offset, u32 val)
> +{
> +       writel_relaxed(val, iommu->reg + offset);
> +}
> +
> +static inline u64 riscv_iommu_readq(struct riscv_iommu_device *iommu,
> +                                   unsigned offset)
> +{
> +       return readq_relaxed(iommu->reg + offset);
> +}
> +
> +static inline void riscv_iommu_writeq(struct riscv_iommu_device *iommu,
> +                                     unsigned offset, u64 val)
> +{
> +       writeq_relaxed(val, iommu->reg + offset);
> +}
> +
> +int riscv_iommu_init(struct riscv_iommu_device *iommu);
> +void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> +
> +#endif
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
