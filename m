Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322887D888D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJZSvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJZSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:51:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C410A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:51:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd644a96so1840988e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698346273; x=1698951073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjgIP3/RFXj237O05z3snhsyWeDqmW3TRwFtEyuVOqk=;
        b=Z8ZwAL43j4TQLlWJzhDu14EMiU0mstUjkhjb0T5w5PVxgbOhjX63/45h1ZWfkWi2vt
         oWgfKMzwuAyRPiEvv5MXbxHJGu85UxjpveXWpuPn4sJ6EptJyr7T0LE86LpqMTsk+vvz
         zzarmpJImPdxL3iWVs8iPP9W+lywUplqyyIW2b7F5MlHbid1iHs++6D/uXokWF9DXhB1
         qpnWAbseTCAtrQDkrt8Y/rFYuFkqPofkQigP5EGZryEte2FEwQFqHixfpjJ4u/Eu20SF
         H26NircbNF0r/9n9VGrVFPuaBesexucMqZxENjBAre9rzMtmdxoppKGG8HHgdUwxTMFm
         akCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346273; x=1698951073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjgIP3/RFXj237O05z3snhsyWeDqmW3TRwFtEyuVOqk=;
        b=O/YjYX6GnkQ+oE/KL6vtASw0fvppfxDiQaQFTd3AH1BGnLKF0Fautm+oFEVkw7n9os
         tOJ9zokxb26+quhtK3u6bDWCLtl2tU7QQ6oh2TbCIzMxn2BNiQib6Qe9egTBu8A3a8P/
         hOZywd4Grc3cc5SFdxcxhUQvmOyjibv+7a49oCKIKt7SUvIE3BvEf65x1oLdxIe68jDI
         6vPgxt7yU0nb0M3XKH/P2JpIeejwoB3yi5amNLIg1LPWvur0pio+xrkZhiPXkDV47a5W
         7kJnEvS+6PC+RavCRht1Cic2HUBP3ZCgl7fs7wHOiD8ggode39Z8eIhYpnQU4lJC5Qut
         ES+w==
X-Gm-Message-State: AOJu0YzRJzwNWZYVTEy8XBUgLjHqmj2mtuzeAP15rLLoI0RlZW6MBthw
        Lg22WkLJUfxOj6dtubQWs0kCYu5za8aqVC4cMl0=
X-Google-Smtp-Source: AGHT+IHxBylJsTfrxqMHBKxmMPf3QuYDUIfDHr4dq2aV3ffIgf3vZ2Aj5jzif8I2Ijoinsw2ABFVX5lct33MossJfUY=
X-Received: by 2002:ac2:5618:0:b0:506:93a0:777a with SMTP id
 v24-20020ac25618000000b0050693a0777amr162433lfd.2.1698346272795; Thu, 26 Oct
 2023 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-11-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-11-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:51:01 +0200
Message-ID: <CAFULd4Z14P5SkQxzLBFfbpmXh9dEi+4NX-NWBjsLxnU1_aZ=yw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] percpu: Remove PER_CPU_FIRST_SECTION
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> x86-64 was the only user.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  include/asm-generic/vmlinux.lds.h |  1 -
>  include/linux/percpu-defs.h       | 12 ------------
>  2 files changed, 13 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 67d8dd2f1bde..23d8acc72760 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -1032,7 +1032,6 @@
>   */
>  #define PERCPU_INPUT(cacheline)                                         =
       \
>         __per_cpu_start =3D .;                                           =
 \
> -       *(.data..percpu..first)                                         \
>         . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         *(.data..percpu..page_aligned)                                  \
>         . =3D ALIGN(cacheline);                                          =
 \
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index ec3573119923..b9ddee91e6c7 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -26,13 +26,11 @@
>  #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
>  #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
>  #endif
> -#define PER_CPU_FIRST_SECTION "..first"
>
>  #else
>
>  #define PER_CPU_SHARED_ALIGNED_SECTION ""
>  #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
> -#define PER_CPU_FIRST_SECTION ""
>
>  #endif
>
> @@ -114,16 +112,6 @@
>  #define DEFINE_PER_CPU(type, name)                                     \
>         DEFINE_PER_CPU_SECTION(type, name, "")
>
> -/*
> - * Declaration/definition used for per-CPU variables that must come firs=
t in
> - * the set of variables.
> - */
> -#define DECLARE_PER_CPU_FIRST(type, name)                              \
> -       DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
> -
> -#define DEFINE_PER_CPU_FIRST(type, name)                               \
> -       DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
> -
>  /*
>   * Declaration/definition used for per-CPU variables that must be cachel=
ine
>   * aligned under SMP conditions so that, whilst a particular instance of=
 the
> --
> 2.41.0
>
