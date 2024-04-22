Return-Path: <linux-kernel+bounces-152741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AB8AC3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915CBB21A69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD601865C;
	Mon, 22 Apr 2024 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ZNQFo+xY"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DE17C68
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763685; cv=none; b=RNCE8iWTE2brLI+C1Ffob98Zi3tyorMGKGV0rp3pEdnnGXhiFlRMQqIQjI8E0vhp8yrwb+XKaRPCD1w4naP2rKfVn4k2Gd0Zx4p+w4M3OktiUzQta+S91IURQaVUgrl3yDvH5p6LnBPTsbs1DGpHU/7h1LuY6blFkqu9GRU6DuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763685; c=relaxed/simple;
	bh=V2+wR1VquizoISUogbMZX4hsB+MQCVKsXvKepUwkfXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrki7q00WX4dE6a+mGc9Habre/PBwgHS5kbX89b3GrEz4TLvn8AChvxu5++uXLdeqyX+vyvob3iP83Qtp3LFGVmZ8AwryfLczAnh1vOnWHS/46VYy5DHB7pVHVPY3BEaq75+4WJvWZpSkfVzZtK9aqveqE2x5z2QqI+4nqV8aks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ZNQFo+xY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a15df0f8cso18058825ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763682; x=1714368482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPFOp2DnZ2SqsScIHARn1DLTXZkW+97s6tf/2J2vkiU=;
        b=ZNQFo+xY/bdtU9CgDE2IjUfyf5GPMuD9GqPHLD0ZDD5QmLHbIB4/muxUxrCqhU13l+
         i2KsnMcE5ZVZa5eTI/yc7kgKJDTCOsyRraT1RXAj4GgcwQs9J5NNCLRgFljlQo8l3R8/
         o8PEf2kolbc/UWH5/LheSziBMstrNK2v3Y/nDJ46d/hUY/4FLyNX9wFLAs40gul8JQMc
         g7agwFEdxSWnYPXgR2Za/eNTbo1sUq2O7Eezj3+haPIEow84LoQcGnF1Q6rd2vFQnrXl
         RbSlynOHQpOV6khAJ2aNuyLMX9OGVElDoQm6U7rFNi8BYJ141ME5WNUYsTWTk7SW1HwP
         IKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763682; x=1714368482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPFOp2DnZ2SqsScIHARn1DLTXZkW+97s6tf/2J2vkiU=;
        b=eg+u0GB9YGcfoLGgRB2GzR+Xzhio+R/0J57gsKZ+jTVN/tUTd5tmFlHpfkT1aqc94S
         9T14q+WclVVZEaAXW7nfCSOgmVg0KpK4a8sXORc9JC4ExHZCkcIGXZGeI5IwUFpo4cnn
         xQezzNEbUyGa1TlD91iHyYWwHxFfluLYc4N20Ftl40DzsxnAe+hoCO7OiwlSLNMsaSqe
         C5NlusPqWdaUjYjTq7Mwe/D3fcDRYr0ue5e0H849mjc4WWEJheO21YVQ8d3rK8FLlv00
         kL9xTxiunPlTBmSMfNfkIsAYJJLtmKLqzZdxMaa+i45N+RZ56JAO0OseVyo5K1ffwojE
         neow==
X-Gm-Message-State: AOJu0YyZXaQZbhZOaLBMS+//Lynfm6hku6Rkz99trBeiIG2NKEO1ORVJ
	zYyBdPbEkhPn4AgrLhQdQprOCmaKFI+/y6MrWGj9D3NN2mfjkc74gRHb2ARXDd3eQVm1/a3zPAD
	hN/hYTGZPkeZazCg4ej6mdR7Bnoa9faY2Kh4FIQ==
X-Google-Smtp-Source: AGHT+IF2fN1BF/BA5zZpPH9awO2iybqu2/U//6hw9xuoA3CAPNDIqio5oxlctD7wg/x5fuL+ITh10xGQjApKCSUO04E=
X-Received: by 2002:a05:6e02:b26:b0:36a:3ef4:aa0a with SMTP id
 e6-20020a056e020b2600b0036a3ef4aa0amr12065915ilu.24.1713763682385; Sun, 21
 Apr 2024 22:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-18-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-18-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:57:51 +0530
Message-ID: <CAAhSdy0KMApgSh4q1zxgv1AKrT44bSEL3+GaFbA8M1XL6UMoJw@mail.gmail.com>
Subject: Re: [PATCH v8 17/24] KVM: riscv: selftests: Move sbi definitions to
 its own header file
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The SBI definitions will continue to grow. Move the sbi related
> definitions to its own header file from processor.h
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
>  .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
>  .../selftests/kvm/include/riscv/ucall.h       |  1 +
>  tools/testing/selftests/kvm/steal_time.c      |  4 +-
>  4 files changed, 54 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index ce473fe251dd..3b9cb39327ff 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm,=
 exception_handler_fn handle
>  #define PGTBL_PAGE_SIZE                                PGTBL_L0_BLOCK_SI=
ZE
>  #define PGTBL_PAGE_SIZE_SHIFT                  PGTBL_L0_BLOCK_SHIFT
>
> -/* SBI return error codes */
> -#define SBI_SUCCESS                            0
> -#define SBI_ERR_FAILURE                                -1
> -#define SBI_ERR_NOT_SUPPORTED                  -2
> -#define SBI_ERR_INVALID_PARAM                  -3
> -#define SBI_ERR_DENIED                         -4
> -#define SBI_ERR_INVALID_ADDRESS                        -5
> -#define SBI_ERR_ALREADY_AVAILABLE              -6
> -#define SBI_ERR_ALREADY_STARTED                        -7
> -#define SBI_ERR_ALREADY_STOPPED                        -8
> -
> -#define SBI_EXT_EXPERIMENTAL_START             0x08000000
> -#define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
> -
> -#define KVM_RISCV_SELFTESTS_SBI_EXT            SBI_EXT_EXPERIMENTAL_END
> -#define KVM_RISCV_SELFTESTS_SBI_UCALL          0
> -#define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
> -
> -enum sbi_ext_id {
> -       SBI_EXT_BASE =3D 0x10,
> -       SBI_EXT_STA =3D 0x535441,
> -};
> -
> -enum sbi_ext_base_fid {
> -       SBI_EXT_BASE_PROBE_EXT =3D 3,
> -};
> -
> -struct sbiret {
> -       long error;
> -       long value;
> -};
> -
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -                       unsigned long arg1, unsigned long arg2,
> -                       unsigned long arg3, unsigned long arg4,
> -                       unsigned long arg5);
> -
> -bool guest_sbi_probe_extension(int extid, long *out_val);
> -
>  static inline void local_irq_enable(void)
>  {
>         csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/test=
ing/selftests/kvm/include/riscv/sbi.h
> new file mode 100644
> index 000000000000..ba04f2dec7b5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RISC-V SBI specific definitions
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef SELFTEST_KVM_SBI_H
> +#define SELFTEST_KVM_SBI_H
> +
> +/* SBI return error codes */
> +#define SBI_SUCCESS                             0
> +#define SBI_ERR_FAILURE                                -1
> +#define SBI_ERR_NOT_SUPPORTED                  -2
> +#define SBI_ERR_INVALID_PARAM                  -3
> +#define SBI_ERR_DENIED                         -4
> +#define SBI_ERR_INVALID_ADDRESS                        -5
> +#define SBI_ERR_ALREADY_AVAILABLE              -6
> +#define SBI_ERR_ALREADY_STARTED                        -7
> +#define SBI_ERR_ALREADY_STOPPED                        -8
> +
> +#define SBI_EXT_EXPERIMENTAL_START             0x08000000
> +#define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
> +
> +#define KVM_RISCV_SELFTESTS_SBI_EXT            SBI_EXT_EXPERIMENTAL_END
> +#define KVM_RISCV_SELFTESTS_SBI_UCALL          0
> +#define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
> +
> +enum sbi_ext_id {
> +       SBI_EXT_BASE =3D 0x10,
> +       SBI_EXT_STA =3D 0x535441,
> +};
> +
> +enum sbi_ext_base_fid {
> +       SBI_EXT_BASE_PROBE_EXT =3D 3,
> +};
> +
> +struct sbiret {
> +       long error;
> +       long value;
> +};
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                       unsigned long arg1, unsigned long arg2,
> +                       unsigned long arg3, unsigned long arg4,
> +                       unsigned long arg5);
> +
> +bool guest_sbi_probe_extension(int extid, long *out_val);
> +
> +#endif /* SELFTEST_KVM_SBI_H */
> diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/te=
sting/selftests/kvm/include/riscv/ucall.h
> index be46eb32ec27..a695ae36f3e0 100644
> --- a/tools/testing/selftests/kvm/include/riscv/ucall.h
> +++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
> @@ -3,6 +3,7 @@
>  #define SELFTEST_KVM_UCALL_H
>
>  #include "processor.h"
> +#include "sbi.h"
>
>  #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
>
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index bae0c5026f82..2ff82c7fd926 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -11,7 +11,9 @@
>  #include <pthread.h>
>  #include <linux/kernel.h>
>  #include <asm/kvm.h>
> -#ifndef __riscv
> +#ifdef __riscv
> +#include "sbi.h"
> +#else
>  #include <asm/kvm_para.h>
>  #endif
>
> --
> 2.34.1
>

