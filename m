Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7947EC873
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjKOQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjKOQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:22:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061AE6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:22:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so5646000b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700065366; x=1700670166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBJZJ6bkQq1mUBhOd//h5NnrzLlmIp6ZHxXr9VhrfWw=;
        b=pJUiDQdZUVkUfR74TmmHVyCk5zDZMh4Em0SybYE03F1Sa8UIIpnftKIbVPfudN55Kl
         5BL1FGvrEcQD2fZN04tkfrA43UXvEAu1xboXS45Cr8q7rtsfWf790c/fpq3GpMX2R68N
         t5Y7Ejz0VmUZUNpHxilPMWTADBBUewRY9vAmgIPnsAj0gxLJc6+MPIV6AFoBnK9aGHcF
         6oPcdPF0h968LVSnBZr1pdWKXiORnU/xsUlbdhJ2INbEDEqB6W2RHnBF/EX+yR79LU9b
         V1z18iLeycEQPGA7ja+DOzowBFMae9/1Oc8XqefN2H9KEcxWhZa6W5WUg7DdxJnoICXz
         NtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065366; x=1700670166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBJZJ6bkQq1mUBhOd//h5NnrzLlmIp6ZHxXr9VhrfWw=;
        b=lQAMmvtw4s/NXRVV5tXJklPRCiLtbqyKE4WVy+SI28jXVdeYMKxsPaHK1/hEZuw7Yl
         NFUVSoGaAa8XKlHqv3pQD8yjuuoauiXUR/WxNCAD75rG68jkCzuWMB4GZjmKTZ1W25HO
         wm7LNgJKKFW1Y0jWBgeVqn7BpsoVVIDITX4OHbarBu2sjuldzi5odHJX6YaTkrGyUo2S
         owQ6wTOSgu87RoTcUsbqT25H0JKt19oNnJYw6JN230/whKobk5Ry+/EBsusTp8hVkCIQ
         kIaq+RMJtP8ViHhIc2RjXGCED4yctm2uRk2ZIJqxJhw8y5c4MlEzOF6fEHCIViZB92x3
         OB3w==
X-Gm-Message-State: AOJu0Yz3F7t8axc5yyyGIP6CvytWllTKyGcEN1SfWDjhz0BkBhVtyX8s
        7XYJ0PjuMOAw6TdTqgKVA8pbzmY+tLgwBN8i+ms4Ug==
X-Google-Smtp-Source: AGHT+IEVxNUiSjjWM4GsZR8s0OEvIr+4VSShN4Neeu2xUy7A7sAsIBpzFFrbU6BYbzZ63zZn4PS+Fz6RtdFJuCoY67k=
X-Received: by 2002:a05:6a00:1ca9:b0:6c4:d5ee:c6 with SMTP id
 y41-20020a056a001ca900b006c4d5ee00c6mr12052350pfw.1.1700065366217; Wed, 15
 Nov 2023 08:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20231115133127.107575-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231115133127.107575-1-heinrich.schuchardt@canonical.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 15 Nov 2023 21:52:34 +0530
Message-ID: <CAK9=C2WV81L697Dw6ccXMnEbKvo2wiR8A_=yxuLGP6TXraOBwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tty/serial: RISC-V SBI earlycon via DBCN extension
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 7:01=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Up to now an SBI based early console was limited to SBI version 0.1.
> With the DBCN SBI extension we can provide an early console on systems th=
at
> have a recent SBI implementation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

There is already a series in-flight adding SBI DBCN support.
Refer, https://lore.kernel.org/lkml/20231020072140.900967-1-apatel@ventanam=
icro.com/

Regards,
Anup

> ---
>  arch/riscv/kernel/sbi.c    | 14 ++++++++++++++
>  drivers/tty/serial/Kconfig |  1 -
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5a62ed1da453..6e1644a95bb7 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -195,6 +195,20 @@ static void sbi_set_power_off(void)
>         pm_power_off =3D sbi_shutdown;
>  }
>  #else
> +
> +/**
> + * sbi_console_putchar() - Writes given character to the console device.
> + * @ch: The data to be written to the console.
> + *
> + * Return: None
> + */
> +void sbi_console_putchar(int ch)
> +{
> +       sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
> +                 ch, 0, 0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL(sbi_console_putchar);
> +
>  static void __sbi_set_timer_v01(uint64_t stime_value)
>  {
>         pr_warn("Timer extension is not available in SBI v%lu.%lu\n",
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 732c893c8d16..454c2a612389 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -87,7 +87,6 @@ config SERIAL_EARLYCON_SEMIHOST
>
>  config SERIAL_EARLYCON_RISCV_SBI
>         bool "Early console using RISC-V SBI"
> -       depends on RISCV_SBI_V01
>         select SERIAL_CORE
>         select SERIAL_CORE_CONSOLE
>         select SERIAL_EARLYCON
> --
> 2.40.1
>
