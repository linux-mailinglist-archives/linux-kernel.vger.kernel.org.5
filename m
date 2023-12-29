Return-Path: <linux-kernel+bounces-12953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B131081FD42
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA5E1F21A58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7798748C;
	Fri, 29 Dec 2023 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jq7qygXe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55CD747E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7f9fdc14dso355708739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 22:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703831694; x=1704436494; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4fxdxmEtIFysGtrQ7NwRVJRTpTS+SS/+oWoKGj9FOU=;
        b=jq7qygXehKDyWtV7NUX0N4eVRc0mbdlzZeI2jf4anL+L/lR6TvABH9NIY/2gW3OJIe
         hCJvgSibJbTXGWLEXfK7bVno8zR8IZxuVQMsgJyk1SutQW8fga3UYPfx8Wo4WsvfkHAM
         Mfz5RRmjRBN855hIyUS9132/5EdnSBxXm0R9Z8GCwjvU/nVk2Ng+WrCfVZJURBKJkX/B
         12RGBt1sahuOQykBiBrGA+BrKojxvnCLjjJRbQLe+3yH2R4WrSKltsz8oHTwWqDkQyf7
         08egh8BtxLh2jqLvuXX8N/b07AOHy2kOZT+F01q1FUzvuobIkGBKxsWknGLj6DYuHvQI
         OO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703831694; x=1704436494;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4fxdxmEtIFysGtrQ7NwRVJRTpTS+SS/+oWoKGj9FOU=;
        b=Jg5bEeJuXQKSw9hNw6AHsbLlHKTh5kI3j8TEWjKRKP5GwwUR4l2928PFvkBwo85zxU
         Ew5bwwXOSyf3+MZJXTX491v5F3oMygtafAUudaCWTuwM9S+4/kiftQiySdf21iBr/9eQ
         agM1gW18zGBYoQPPC0Kz1s5jxMEZcqw3IVzucbiOqnUA/mRCqBWkk6ob1ocy/53cszxo
         ZhJpXL3QUgBWUb8VqU67gP6eC24logeO/zrO2vB/LEyaa0peYSDyrfJsZukKbdJLDfOP
         fd7igmOSgfGOIdLnKCT5U6wFORNf8ixiEgrwWMXfPPrjh5tAz4TBtjUGr04VyMIE8dHQ
         zQeA==
X-Gm-Message-State: AOJu0Yw6+I6SHCk8xwtJJRzfXhzELjbkCIrU17mltohE+hZ936nGgsLH
	zIi2A9c95UDg/ga9NIDxEkpWh0ICOmexdSKVxB552IiB0cP/eQ==
X-Google-Smtp-Source: AGHT+IFEZdsZZnSUh+m3xzxHBI40M9F3hKuiKUuTXOsXYxca0ywV7LDrEpu0ijjBXv3OeCC0Oa31vlLGasT/LG+acQo=
X-Received: by 2002:a05:6602:4a:b0:7ba:94dd:fd89 with SMTP id
 z10-20020a056602004a00b007ba94ddfd89mr8581340ioz.41.1703831694654; Thu, 28
 Dec 2023 22:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com>
In-Reply-To: <20231205085959.32177-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 29 Dec 2023 14:34:43 +0800
Message-ID: <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:00=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> CALLER_ADDRx returns caller's address at specified level, they are used
> for several tracers. These macros eventually use
> __builtin_return_address(n) to get the caller's address if arch doesn't
> define their own implementation.
>
> In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, we nee=
d
> to walk the stack frame to get the caller's address at specified level.
>
> data.level started from 'level + 3' due to the call flow of getting
> caller's address in RISC-V implementation. If we don't have additional
> three iteration, the level is corresponding to follows:
>
> callsite -> return_address -> arch_stack_walk -> walk_stackframe
> |           |                 |                  |
> level 3     level 2           level 1            level 0
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/ftrace.h    |  5 ++++
>  arch/riscv/kernel/Makefile         |  2 ++
>  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 arch/riscv/kernel/return_address.c
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 2b2f5df7ef2c..42777f91a9c5 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -25,6 +25,11 @@
>
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #ifndef __ASSEMBLY__
> +
> +extern void *return_address(unsigned int level);
> +
> +#define ftrace_return_address(n) return_address(n)
> +
>  void MCOUNT_NAME(void);
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  {
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..40d054939ae2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
>  endif
>  CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
>  CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> @@ -46,6 +47,7 @@ obj-y +=3D irq.o
>  obj-y  +=3D process.o
>  obj-y  +=3D ptrace.o
>  obj-y  +=3D reset.o
> +obj-y  +=3D return_address.o
>  obj-y  +=3D setup.o
>  obj-y  +=3D signal.o
>  obj-y  +=3D syscall_table.o
> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/retur=
n_address.c
> new file mode 100644
> index 000000000000..c2008d4aa6e5
> --- /dev/null
> +++ b/arch/riscv/kernel/return_address.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This code come from arch/arm64/kernel/return_address.c
> + *
> + * Copyright (C) 2023 SiFive.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/kprobes.h>
> +#include <linux/stacktrace.h>
> +
> +struct return_address_data {
> +       unsigned int level;
> +       void *addr;
> +};
> +
> +static bool save_return_addr(void *d, unsigned long pc)
> +{
> +       struct return_address_data *data =3D d;
> +
> +       if (!data->level) {
> +               data->addr =3D (void *)pc;
> +               return false;
> +       }
> +
> +       --data->level;
> +
> +       return true;
> +}
> +NOKPROBE_SYMBOL(save_return_addr);
> +
> +void *return_address(unsigned int level)
> +{
> +       struct return_address_data data;
> +
> +       data.level =3D level + 3;
> +       data.addr =3D NULL;
> +
> +       arch_stack_walk(save_return_addr, &data, current, NULL);
> +
> +       if (!data.level)
> +               return data.addr;
> +       else
> +               return NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(return_address);
> +NOKPROBE_SYMBOL(return_address);
> --
> 2.17.1
>

Hi Palmer and all,
I was wondering whether this patch is good for everyone? Thanks

