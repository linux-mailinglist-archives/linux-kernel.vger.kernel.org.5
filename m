Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30775DE78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGVUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:19:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B6E53;
        Sat, 22 Jul 2023 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zlKBQlo+spEK7fOXagOjfqBhrZHU9x6qjF2zofp+Ezk=; b=LUi4ybPqoqArTKIN+u6U7J9ZLB
        DIq7hxqyfdnm74ilU627CYFM8SdZb2oAUQFnP1HCitDhDQK/5DMfkE24KPaYE6r/nGRXemUix/CjX
        y5KK8w6vTjnY4NVVoBMqd8GbLhn+y5N4bgUnU9X5MenVhc8vPL08E0/UC0uzbYD/YkxFMNQIc3VMm
        fSiC3apI+reAqq7IkQstFrnWzQ51TNlDSFqC2a2O4kjjh4NfrTz1niuyGrVmgJV2iWrjeS3DlSUNf
        KuWG7iDB3xtiDhgpQx/xOQ6n6ejMOd2gTL2b4nBuNnXRyqk+uDAB4Swglh6QkLHEphR8HeVZsW+BD
        PZLs0Xzg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNJ4L-00HF3Y-2L;
        Sat, 22 Jul 2023 20:19:13 +0000
Message-ID: <b0826064-0cd6-dfd0-a377-5cd56c4035be@infradead.org>
Date:   Sat, 22 Jul 2023 13:19:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/3] Documentation: riscv: Add early boot document
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
References: <20230722113445.630714-1-alexghiti@rivosinc.com>
 <20230722113445.630714-2-alexghiti@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230722113445.630714-2-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/23 04:34, Alexandre Ghiti wrote:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> - Changes in v5:
>   * Rebase on top of docs-next
> 
>  Documentation/riscv/boot-image-header.rst |   3 -
>  Documentation/riscv/boot.rst              | 169 ++++++++++++++++++++++
>  Documentation/riscv/index.rst             |   1 +
>  3 files changed, 170 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/riscv/boot.rst
> 

> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> new file mode 100644
> index 000000000000..f890ac442c91
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,169 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +RISC-V Kernel Boot Requirements and Constraints
> +===============================================
> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from bootloaders and
> +firmware, but also the constraints that any developer must have in mind when

I would s/but/and/.

> +touching the early boot process. For the purposes of this document, the
> +``early boot process`` refers to any code that runs before the final virtual
> +mapping is set up.
> +
> +Pre-kernel Requirements and Constraints
> +=======================================
> +
> +The RISC-V kernel expects the following of bootloaders and platform firmware:
> +
> +Register state
> +--------------
> +
> +The RISC-V kernel expects:
> +
> +  * ``$a0`` to contain the hartid of the current core.
> +  * ``$a1`` to contain the address of the devicetree in memory.
> +
> +CSR state
> +---------
> +
> +The RISC-V kernel expects:
> +
> +  * ``$satp = 0``: the MMU, if present, must be disabled.
> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel must not map any resident memory, or memory protected with
> +PMPs, in the direct mapping, so the firmware must correctly mark those regions
> +as per the devicetree specification and/or the UEFI specification.
> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
> +and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
> +kernel if that's not the case.
> +
> +Hardware description
> +--------------------
> +
> +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
> +
> +The devicetree is either passed directly to the kernel from the previous stage
> +using the ``$a1`` register, or when booting with UEFI, it can be passed using the
> +EFI configuration table.
> +
> +The ACPI tables are passed to the kernel using the EFI configuration table. In
> +this case, a tiny devicetree is still created by the EFI stub. Please refer to
> +"EFI stub and devicetree" section below for details about this devicetree.
> +
> +Kernel entrance
> +---------------

How about "entry" instead of "entrance"?

> +
> +On SMP systems, there are 2 methods to enter the kernel:
> +
> +- ``RISCV_BOOT_SPINWAIT``: the firmware releases all harts in the kernel, one hart
> +  wins a lottery and executes the early boot code while the other harts are
> +  parked waiting for the initialization to finish. This method is mostly used to
> +  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
> +- ``Ordered booting``: the firmware releases only one hart that will execute the
> +  initialization phase and then will start all other harts using the SBI HSM
> +  extension. The ordered booting method is the preferred booting method for
> +  booting the RISC-V kernel because it can support cpu hotplug and kexec.

preferably s/cpu/CPU/

> +
> +UEFI
> +----

[snip]

I can't say how correct the documentation is, but it is well-written
and has no issues with punctuation, grammar, or spelling AFAICT, so
you can take this if you want it:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
