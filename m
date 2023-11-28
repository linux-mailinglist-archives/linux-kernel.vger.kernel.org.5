Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6B7FB9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjK1Luq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbjK1Lun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:50:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E4D56
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:50:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28555b0c7afso4841247a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701172249; x=1701777049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2kulW1geAfZxX/JQH9MeV9uEi0C8/RyxeovxkcDG50=;
        b=JwnOHGti2JVCIXEkrgtE2UseDFa/IPDI8qxQjoxfEYNOIwItUjGGbSfmx50uiKXO27
         j3GKtjAJwt6REEaYi46pyQrm0qWWc3wbDZ65xYM1SxHJXg7iB1g5BOyLpJ7qRVTmCd6w
         mlX0rR/jY+DjRavqmgobrBA/kLrERHrTOnV+NGAIOO28aswOVtsjbgf9P8nHANfRywOL
         cZbd7yxSV2CcIPX8j45cokjVJ9oL2NwKxBieVzN4GGpEhG1m2o7xjxaOUrE9RbW+v52t
         4MTfaLJj6LXCxw5wAupKpqiiTApjREN0qiJecronFYOq3dC3L/dso/z3x/DNZgQnJA/3
         Eegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172249; x=1701777049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2kulW1geAfZxX/JQH9MeV9uEi0C8/RyxeovxkcDG50=;
        b=aaNo1+fOnhlzRTikiN+mscTF4kqGYMmnfM5ut8auC0U5O1c16XE9K5uRSS+vkpjM3v
         QVC9bU7xBBImulibtGj+qPnHTAJ6wfQLXhIuqjfvCqefsTpGNpDybuawNBvFVw9ffmwN
         i3O+DYRzJm0ScYxPyHdJj6LMtWEbZhr148PeRk1zc7ei/cxxYLC8vRBEaf0kCLibkjqL
         VnnKiEacryZquzKNozqHvtEPoriUaiE6X8WW7PmAzJGGTZDsn/3z4LXleKS497w4bms4
         MHjP+M+d4ws7Z6Z95etNFG1OQJEb3BqdNlmXbzDsJi7LI/4LvmQG1YzWJXMt2+//wy4D
         UPQg==
X-Gm-Message-State: AOJu0YyUFT4RcMqAcUGn9am8PuE5LbqtZsVk52q3XM/bRxd8VX/WNzoi
        PGAIBWR7wIXEe/5jeDbnXkup8pheAoUfGPaSGAilYA==
X-Google-Smtp-Source: AGHT+IEtIjr1f86Ll4Q97bmD9els2k6l3+wPfKL80sqsMUtZTff8dRmGfiY+mR8L+d5C9cxh35gQ+qwZwdcx8Fbii8I=
X-Received: by 2002:a17:90b:3884:b0:285:d803:8945 with SMTP id
 mu4-20020a17090b388400b00285d8038945mr6030411pjb.46.1701172248917; Tue, 28
 Nov 2023 03:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128054457.659452-1-bhe@redhat.com>
In-Reply-To: <20231128054457.659452-1-bhe@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 28 Nov 2023 11:50:38 +0000
Message-ID: <CALrw=nEe195PSJywrkr5sPh_PnrLXG+ytvryG8CB-LHvmXpJkg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        eric_devolder@yahoo.com, agordeev@linux.ibm.com,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:45=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Ignat Korchagin complained that a potential config regression was
> introduced by commit 89cde455915f ("kexec: consolidate kexec and
> crash options into kernel/Kconfig.kexec"). Before the commit,
> CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
> CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=3Dy
> as long as CONFIG_CRASH_DUMP=3DY which people may not want.
>
> In Ignat's case, he sets CONFIG_CRASH_DUMP=3Dy, CONFIG_KEXEC_FILE=3Dy and
> CONFIG_KEXEC=3Dn because kexec_load interface could have security issue i=
f
> kernel/initrd has no chance to be signed and verified.
>
> CRASH_DUMP has select of KEXEC because Eric, author of above commit,
> met a LKP report of build failure when posting patch of earlier version.
> Please see below link to get detail of the LKP report:
>
>     https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@orac=
le.com/T/#u
>
> In fact, that LKP report is triggered because arm's <asm/kexec.h> is
> wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
> controls the enabling/disabling of kexec_load interface, but not kexec
> feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
> <asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.
> Meanwhile, change arch/arm/kernel/Makefile to let machine_kexec.o
> relocate_kernel.o depend on KEXEC_CORE.
>
> Fixes: commit 89cde455915f ("kexec: consolidate kexec and crash options i=
nto kernel/Kconfig.kexec")
> Reported-by: Ignat Korchagin <ignat@cloudflare.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Tested-by: Ignat Korchagin <ignat@cloudflare.com> # compile-time only
for x86 and arm

> ---
>  arch/arm/include/asm/kexec.h | 4 ----
>  arch/arm/kernel/Makefile     | 2 +-
>  kernel/Kconfig.kexec         | 1 -
>  3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
> index e62832dcba76..a8287e7ab9d4 100644
> --- a/arch/arm/include/asm/kexec.h
> +++ b/arch/arm/include/asm/kexec.h
> @@ -2,8 +2,6 @@
>  #ifndef _ARM_KEXEC_H
>  #define _ARM_KEXEC_H
>
> -#ifdef CONFIG_KEXEC
> -
>  /* Maximum physical address we can use pages from */
>  #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
>  /* Maximum address we can reach in physical address mode */
> @@ -82,6 +80,4 @@ static inline struct page *boot_pfn_to_page(unsigned lo=
ng boot_pfn)
>
>  #endif /* __ASSEMBLY__ */
>
> -#endif /* CONFIG_KEXEC */
> -
>  #endif /* _ARM_KEXEC_H */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index d53f56d6f840..771264d4726a 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -59,7 +59,7 @@ obj-$(CONFIG_FUNCTION_TRACER) +=3D entry-ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)   +=3D ftrace.o insn.o patch.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    +=3D ftrace.o insn.o patch.o
>  obj-$(CONFIG_JUMP_LABEL)       +=3D jump_label.o insn.o patch.o
> -obj-$(CONFIG_KEXEC)            +=3D machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
>  # Main staffs in KPROBES are in arch/arm/probes/ .
>  obj-$(CONFIG_KPROBES)          +=3D patch.o insn.o
>  obj-$(CONFIG_OABI_COMPAT)      +=3D sys_oabi-compat.o
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 7aff28ded2f4..1cc3b1c595d7 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,6 @@ config CRASH_DUMP
>         depends on ARCH_SUPPORTS_KEXEC
>         select CRASH_CORE
>         select KEXEC_CORE
> -       select KEXEC
>         help
>           Generate crash dump after being started by kexec.
>           This should be normally only set in special crash dump kernels
> --
> 2.41.0
>
