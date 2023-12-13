Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD5810A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378564AbjLMGQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378566AbjLMGQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:16:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CADFE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:16:33 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ca03103155so82884381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702448192; x=1703052992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCLT5UxX3ic1D8SnaFGchw7AZpD/VDB8rMNC+FjYo/c=;
        b=WEvFf2MmdMn+WJSArm/FVitURHRMi/rCtct2eF47Gz0sJjoTkb6lxlwaXLqNY6WP7J
         uSVqLTg9M2K2J95jvqnUMWl8Q8B394Stf0UnePzFqLYGvA0BygkUQDxdQtPyVmR5XcEs
         eCbPxGBkHbMJMYecqqsZF8SvkaCsb0rTdQgrORjsuO9EGTch3AUr7+2x4tEvmfPziz9w
         zRwyXzuCTxSiQAFiGVSpULPkSzyfksaA7Gb+6MbApGzpNSciBLHCX372iJy4mdfRAJtc
         /bwIntx1TwfP3e362IScBzdFhp1zZly9gcRy2exCwjZ6Z5i3qg/kdeSvHBEWBOJZbwft
         TrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448192; x=1703052992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCLT5UxX3ic1D8SnaFGchw7AZpD/VDB8rMNC+FjYo/c=;
        b=vImPJ4fwP/QLLTSy0wcP0GieGbIj6XOfNVw+rSxM39Qre6aY/rzkRSqXFGJtLYk8uT
         lDQLMycE/3QUqoD4okq8J11WNs5uWTfdMe1TxAvoCD72IGJ5VKSV2DVXeLg2D28z7s3M
         V9oCHnWLXsT+EK6oitGPNJLfh8P451ix1y7qghPYXrZ1KInVmBcifwrXxB0kbfmmx05T
         nIkZL87I4C8Ox3s0j1renACw1ZvcHn8f3HyxZHPqVB5KWSA8IhmaCQXT5X40Ftab5Jh5
         VwmLBuN87llZBVqEAeZkcYaTTF1IeGa7bQekrfpBe7/tVf6UNivD4sVTcH7mYn8bPMtw
         kI+g==
X-Gm-Message-State: AOJu0YwktdfQLdWvPGGVFd4zs0MnsuisJkC65xEBpTYSV/iV6Lopzt2R
        IsT6OlM/Jn8EI6RIn+WAbKtqdL6rzBBYZfvZUEP8SQ==
X-Google-Smtp-Source: AGHT+IGyghldClfn31V0MQMWGLZzCGALUHqlVVAMFgcmDYeLOD49X5FAOoL1dW4PLVS+GqzsYn0uP2igPy0TYL4nAIk=
X-Received: by 2002:a19:f717:0:b0:50b:e576:ea2b with SMTP id
 z23-20020a19f717000000b0050be576ea2bmr2067249lfe.126.1702448191950; Tue, 12
 Dec 2023 22:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20231024132655.730417-1-cleger@rivosinc.com> <20231024132655.730417-5-cleger@rivosinc.com>
In-Reply-To: <20231024132655.730417-5-cleger@rivosinc.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 13 Dec 2023 11:46:19 +0530
Message-ID: <CAK9=C2WJv4PX5FAAPUcttK4UDDNWdyNWmLG_zXwx60WrMgXO8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] riscv: kvm: Use SYM_*() assembly macros instead of
 deprecated ones
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 6:58=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> ENTRY()/END()/WEAK() macros are deprecated and we should make use of the
> new SYM_*() macros [1] for better annotation of symbols. Replace the
> deprecated ones with the new ones and fix wrong usage of END()/ENDPROC()
> to correctly describe the symbols.
>
> [1] https://docs.kernel.org/core-api/asm-annotations.html
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Queued this patch for Linux-6.8

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_switch.S | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
> index d74df8eb4d71..8b18473780ac 100644
> --- a/arch/riscv/kvm/vcpu_switch.S
> +++ b/arch/riscv/kvm/vcpu_switch.S
> @@ -15,7 +15,7 @@
>         .altmacro
>         .option norelax
>
> -ENTRY(__kvm_riscv_switch_to)
> +SYM_FUNC_START(__kvm_riscv_switch_to)
>         /* Save Host GPRs (except A0 and T0-T6) */
>         REG_S   ra, (KVM_ARCH_HOST_RA)(a0)
>         REG_S   sp, (KVM_ARCH_HOST_SP)(a0)
> @@ -208,9 +208,9 @@ __kvm_switch_return:
>
>         /* Return to C code */
>         ret
> -ENDPROC(__kvm_riscv_switch_to)
> +SYM_FUNC_END(__kvm_riscv_switch_to)
>
> -ENTRY(__kvm_riscv_unpriv_trap)
> +SYM_CODE_START(__kvm_riscv_unpriv_trap)
>         /*
>          * We assume that faulting unpriv load/store instruction is
>          * 4-byte long and blindly increment SEPC by 4.
> @@ -231,12 +231,10 @@ ENTRY(__kvm_riscv_unpriv_trap)
>         csrr    a1, CSR_HTINST
>         REG_S   a1, (KVM_ARCH_TRAP_HTINST)(a0)
>         sret
> -ENDPROC(__kvm_riscv_unpriv_trap)
> +SYM_CODE_END(__kvm_riscv_unpriv_trap)
>
>  #ifdef CONFIG_FPU
> -       .align 3
> -       .global __kvm_riscv_fp_f_save
> -__kvm_riscv_fp_f_save:
> +SYM_FUNC_START(__kvm_riscv_fp_f_save)
>         csrr t2, CSR_SSTATUS
>         li t1, SR_FS
>         csrs CSR_SSTATUS, t1
> @@ -276,10 +274,9 @@ __kvm_riscv_fp_f_save:
>         sw t0, KVM_ARCH_FP_F_FCSR(a0)
>         csrw CSR_SSTATUS, t2
>         ret
> +SYM_FUNC_END(__kvm_riscv_fp_f_save)
>
> -       .align 3
> -       .global __kvm_riscv_fp_d_save
> -__kvm_riscv_fp_d_save:
> +SYM_FUNC_START(__kvm_riscv_fp_d_save)
>         csrr t2, CSR_SSTATUS
>         li t1, SR_FS
>         csrs CSR_SSTATUS, t1
> @@ -319,10 +316,9 @@ __kvm_riscv_fp_d_save:
>         sw t0, KVM_ARCH_FP_D_FCSR(a0)
>         csrw CSR_SSTATUS, t2
>         ret
> +SYM_FUNC_END(__kvm_riscv_fp_d_save)
>
> -       .align 3
> -       .global __kvm_riscv_fp_f_restore
> -__kvm_riscv_fp_f_restore:
> +SYM_FUNC_START(__kvm_riscv_fp_f_restore)
>         csrr t2, CSR_SSTATUS
>         li t1, SR_FS
>         lw t0, KVM_ARCH_FP_F_FCSR(a0)
> @@ -362,10 +358,9 @@ __kvm_riscv_fp_f_restore:
>         fscsr t0
>         csrw CSR_SSTATUS, t2
>         ret
> +SYM_FUNC_END(__kvm_riscv_fp_f_restore)
>
> -       .align 3
> -       .global __kvm_riscv_fp_d_restore
> -__kvm_riscv_fp_d_restore:
> +SYM_FUNC_START(__kvm_riscv_fp_d_restore)
>         csrr t2, CSR_SSTATUS
>         li t1, SR_FS
>         lw t0, KVM_ARCH_FP_D_FCSR(a0)
> @@ -405,4 +400,5 @@ __kvm_riscv_fp_d_restore:
>         fscsr t0
>         csrw CSR_SSTATUS, t2
>         ret
> +SYM_FUNC_END(__kvm_riscv_fp_d_restore)
>  #endif
> --
> 2.42.0
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
