Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E77E2B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjKFRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:47:37 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D9D4D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:47:34 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3f938331fso2367181b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699292854; x=1699897654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ7f64Te7UV7a0eNfYVfXMNv7AxvSVBIgEq09gK/fAc=;
        b=fz5yibGAmSOGGQXwx12dx3LxWO2bp8J55mJCEqczDBslXz7pjzON2HfA3CFzbNM1VA
         Iy7gBR210sXoEGbaBJWSXxsRoe5WqtVDI0nUUcjs+Vjlu0kP+pqwk/gFzFqVUpMjZ5jk
         eqlV859MPshbiiczECmJfDrj2r70P6d2UN9aU0sQ+YFlUEO0zWqx82Gm4LmRGmbymFGt
         ZZQ1uJmWCOQpkAgmKL6l4sXmUJ7nzC0tW4hFYdJa2QRz3ND574b0vLsXnGxFRzvoBROT
         6BDwjCaLWdw4FDBdeBsDnip6k047jg+BfUDe2fHwGdELQFR+kX8ygf1HzjYujBZDSwCQ
         t19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292854; x=1699897654;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ7f64Te7UV7a0eNfYVfXMNv7AxvSVBIgEq09gK/fAc=;
        b=WSObWg0dfOOJvuVOk8nezw3tjRZWZmzoV0Nz8VdHLfaeRK8fcL5zmxN7xSoXhxzcKK
         7blw8fET/ylSE7vIKnDG3FsrLRrJbJF98BfNkQG8DQ3T6jiERyC0O+jKWIEqP5gzygxd
         mVAtLEX3LJR0bbx3ny5kv/mdCgFjI+kn2m+2/ML8hzYBkTkr9dFLD03X8YysAdFN1OXY
         e2X5yd5EUNRHsU8mOnwhmqTZZfPPaNsXat7vKWmnBTfp6X/nlDg55pmKOuh6Vv7v1Ojo
         Ql4HpLG02C16G3fB6+XL0Nt99Z+2H50FneZC+zhLX1vre93D1a5pfY1apZK5wjKyQ11L
         bfOA==
X-Gm-Message-State: AOJu0YzFdqvxQRhjIjNXDx0bbkFc2H3IkFZ/uI73oe5nPO41R4oDI+f1
        sQ1ohz8vncD+sYXhQVQOBFlS2g==
X-Google-Smtp-Source: AGHT+IFHr/vXxQwSi3zZsGer8PYd3xCCktoo3g0EmkZqDUpLHtQYEs84mYx4Iau+Vf6CFV9h7vqNkA==
X-Received: by 2002:a05:6808:3846:b0:3a7:33bb:e5e2 with SMTP id ej6-20020a056808384600b003a733bbe5e2mr128284oib.16.1699292853715;
        Mon, 06 Nov 2023 09:47:33 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id e23-20020aca1317000000b003a8560a9d34sm1291179oii.25.2023.11.06.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:47:33 -0800 (PST)
Date:   Mon, 06 Nov 2023 09:47:33 -0800 (PST)
X-Google-Original-Date: Mon, 06 Nov 2023 09:47:27 PST (-0800)
Subject:     Re: [PATCH] riscv: CONFIG_EFI should not depend on CONFIG_RISCV_ISA_C
In-Reply-To: <20231024192648.25527-1-bjorn@kernel.org>
CC:     aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
        Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Topel <bjorn@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>, sunilvl@ventanamicro.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-7bef396f-1601-4934-8c85-08196c54aa76@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 12:26:48 PDT (-0700), bjorn@kernel.org wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> UEFI/PE mandates that the kernel Image starts with "MZ" ASCII
> (0x5A4D). Convenient enough, "MZ" is a valid compressed RISC-V
> instruction. This means that a non-UEFI loader can simply jump to
> "code0" in the Image header [1] and start executing.
>
> The Image specification [1] says the following about "code0":
>   |   This header is also reused to support EFI stub for RISC-V. EFI
>   |   specification needs PE/COFF image header in the beginning of the
>   |   kernel image in order to load it as an EFI application. In order
>   |   to support EFI stub, code0 is replaced with "MZ" magic string
>   |   and res3(at offset 0x3c) points to the rest of the PE/COFF
>   |   header.
>
> "MZ" is not a valid instruction for implementations without the C
> extension.
>
> A non-UEFI loader, loading a non-C UEFI image have the following
> options:
>   1. Trap and emulate "code0"
>   2. Avoid "code0" if it is "MZ", and have the kernel entry at
>      "code1".
>
> Replace the compressed instruction with a hex code variant, that works
> for CONFIG_RISCV_ISA_C=n builds. Further, this change also make sure
> that the "code0" instruction is 32b aligned.

IMO this breaks the Image format on non-C systems: they'll jump straight 
to the start (as there's no symbols left or anything) and then just fail 
to execute the C instructions.

We could amend the Image format to require bootloaders to handle this 
(ie, look at the first instructions and emulate them if there's no C), 
that would require some bootloader updates but given this doesn't work 
maybe that's fine.

We could also just stop producing Image+PE binaries on non-C systems 
(ie, just produce PE).

> [1] Documentation/riscv/boot-image-header.rst
>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig       | 1 -
>  arch/riscv/kernel/head.S | 8 ++++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..9c5bbbc93951 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -799,7 +799,6 @@ config EFI
>  	select EFI_RUNTIME_WRAPPERS
>  	select EFI_STUB
>  	select LIBFDT
> -	select RISCV_ISA_C
>  	select UCS2_STRING
>  	help
>  	  This option provides support for runtime services provided
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 3710ea5d160f..33d69b569843 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -27,9 +27,13 @@ ENTRY(_start)
>  	 */
>  #ifdef CONFIG_EFI
>  	/*
> -	 * This instruction decodes to "MZ" ASCII required by UEFI.
> +	 * The compressed (C extension) "c.li s4,-13" instruction
> +	 * decodes to 0x5a4d/"MZ" (ASCII), which is required by UEFI.
> +	 *
> +	 * In order to support non-compressed EFI kernels, the
> +	 * instruction is written in hex.
>  	 */
> -	c.li s4,-13
> +	.word 0x5a4d5a4d
>  	j _start_kernel
>  #else
>  	/* jump to start kernel */
>
> base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
