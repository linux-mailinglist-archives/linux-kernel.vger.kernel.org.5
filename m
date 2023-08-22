Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C77839CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjHVGQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHVGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:16:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E411C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:16:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5257e2b5d12so4846007a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1692684994; x=1693289794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etm+is1Vk1OwDhQBIivpxr/NaVYXAexKvYiz/4v9WQ0=;
        b=hnvji7WGGO1c3o007SYql5xd9g063Oin/FtbXmcNNt+bhkBhgs9G3s6YBU4NcfgwLi
         BUtrVlZ51MWSPiE2FN7YKLqo1rgjFh5nwRUz/TKltIRtPSnisRBi3rjCu6+94lMsJnL9
         HDQP/Sbzcoi8D2tCLzHS+oHSLv/P2Q1dybK4gxAtjKXDM6KYX/QkWdGLY1yqc1ZuQm/m
         M/IJQhXbXvK6czGCFzmCjOEMiuPLqRicNreDn85Ku4YHdgYFGUDtjjC3Zgr65uSHgNAe
         jslmA+Qr1i+OP4dyO2zvbtDT8RCNqzsJJ4piCsVy5Rae8MJvEi0qnhQeg3YUKNNLDraG
         FxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692684994; x=1693289794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Etm+is1Vk1OwDhQBIivpxr/NaVYXAexKvYiz/4v9WQ0=;
        b=C74zxXd8TjY7nyp8+MSMmtzdyxHaaqswDGJAHZYLUdCVrswBQ0hYzBH72kvSJV1YHd
         10VkBumOF571GlpmkU+RNRuMHKEvLf+jpYRF78Wph4hGBX8XXIBwDGC5sU5WUe/nbaks
         euWOUjE52Izi4f4luWssPmjRAo/Pd0SrJPSDlDpXjlkPyT6r0WsNeuGm5wLPf7oceMX4
         6bHDizUROcAlV9Lx6TLhQ15hODzt3zzw/1D51D/D91GbZ8BKbKHP/Xvpm4ydw4hlbfNO
         618PLHeaYe/i60/eSxBQLVjCahOazz7z5x1O6n9kKntHqQiWqwtraf4KbY2BggfLyEqo
         nBEA==
X-Gm-Message-State: AOJu0Yzmppm+1yQT9LcXwgEVzMmLAJQZ8RnFmEmRq3euCLPY3rhNfy1z
        zibzn+CoAyMyNPCvzO+BIW26pPXCMBV+bx4DrIxdBQ==
X-Google-Smtp-Source: AGHT+IED6jSpdp0uBNdtBG9rgNloUIIG/FgjpAiBY9v7dmhpX1qTswjR6JdQcrlQLJ239YUFyanJLxo/y/E6FCdSAvU=
X-Received: by 2002:a17:906:2d1:b0:98d:e605:2bce with SMTP id
 17-20020a17090602d100b0098de6052bcemr7413238ejk.46.1692684993483; Mon, 21 Aug
 2023 23:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com>
In-Reply-To: <20230822054739.33552-1-nick.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 22 Aug 2023 11:46:22 +0530
Message-ID: <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: suspend: Add syscore ops for suspend
To:     Nick Hu <nick.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> If a task is the one who performs the suspend flow and it also do some
> floating or vector operations before the suspend, we might lose the FPU
> and vector states when it goes to the non-retention system suspend state.
> Add syscore ops to save and restore the FPU and vector states of the
> current task to fix the issue above.

This only applies to non-retentive system suspend so why do we need
this before SBI system suspend is merged ?

Regards,
Anup


>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
> Changes in v2:
> a) Add Co-developed-by and adjust the order of signed-off
> b) Rephrase the commit message
>
>  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 3c89b8ec69c4..ff69ff8a1974 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -4,9 +4,14 @@
>   * Copyright (c) 2022 Ventana Micro Systems Inc.
>   */
>
> +#include <linux/cpu_pm.h>
>  #include <linux/ftrace.h>
> +#include <linux/thread_info.h>
> +#include <linux/syscore_ops.h>
>  #include <asm/csr.h>
>  #include <asm/suspend.h>
> +#include <asm/switch_to.h>
> +#include <asm/vector.h>
>
>  void suspend_save_csrs(struct suspend_context *context)
>  {
> @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
>
>         return rc;
>  }
> +
> +static int riscv_cpu_suspend(void)
> +{
> +       struct task_struct *cur_task =3D get_current();
> +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> +
> +       if (has_fpu()) {
> +               if (unlikely(regs->status & SR_SD))
> +                       fstate_save(cur_task, regs);
> +       }
> +       if (has_vector()) {
> +               if (unlikely(regs->status & SR_SD))
> +                       riscv_v_vstate_save(cur_task, regs);
> +       }
> +
> +       return 0;
> +}
> +
> +static void riscv_cpu_resume(void)
> +{
> +       struct task_struct *cur_task =3D get_current();
> +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> +
> +       if (has_fpu())
> +               fstate_restore(cur_task, regs);
> +       if (has_vector())
> +               riscv_v_vstate_restore(cur_task, regs);
> +}
> +
> +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> +       .suspend        =3D riscv_cpu_suspend,
> +       .resume         =3D riscv_cpu_resume,
> +};
> +
> +static int __init riscv_cpu_suspend_init(void)
> +{
> +       register_syscore_ops(&riscv_cpu_syscore_ops);
> +       return 0;
> +}
> +arch_initcall(riscv_cpu_suspend_init);
> --
> 2.34.1
>
