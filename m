Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADB764692
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjG0GQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjG0GQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2CB1731
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0083361D14
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672BDC433CA;
        Thu, 27 Jul 2023 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690438614;
        bh=0u5dKLdzEDZbgSk/MVboHGJ1y2URwAqm+KVO+8/WIc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YjMOO7/zK1ptmQ2eJZY2/w1CylXNT51YJPf7GZkK3Avtd16Eidc1G91BrftdPvVyj
         PL6aMz+yZPq7hWCYLeJ+PYlL3/C4StQB971Lsr7Eepc+66vDP1kADVUlKq/Aro4vBH
         lOZo0aU7lMGxU01RNg2C+j3g09HfCie5PFqVLcKmRQTab/iGVNOR6h6mTLcW4yZdXw
         0EGhkSVtk67TMN/kkg2mkgLD1dbvfCfzkAoxpiWe3Wk6b/06QWV1Ht7VY16eacSHIL
         yc4F/NbDaYXlXp/o8jGSPSsUTcDMo6GyauvyYJSyo5OdXw4HIgD6GfYcDlu46NCvKX
         cb8Ey2/uFzLbw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so698555a12.2;
        Wed, 26 Jul 2023 23:16:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYNdtNkR6l/LEHHvyopc8tQhFdJ3NVKHrrNtnkd07vw0jKmPh4K
        0OrXFxNrVSz5MGUpfPcOGqJgpt94LWG8SQhVz2w=
X-Google-Smtp-Source: APBJJlGYnWtVs+fnABK57qFLoh/r+fFmn/JbZgwI3j6LEHG8OqFrjDwoQz1ZzQcxB6MJncvN/eFqINTm625RMLy8zRY=
X-Received: by 2002:a05:6402:31e8:b0:51e:4bd6:ce4a with SMTP id
 dy8-20020a05640231e800b0051e4bd6ce4amr1059655edb.11.1690438612612; Wed, 26
 Jul 2023 23:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230727042125.884988-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20230727042125.884988-1-zhaochenguang@kylinos.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 27 Jul 2023 14:16:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Vn1Mf8L_+QaCJJaQLLxKe5Sg9tJ4A5KkDuupdnfQHDw@mail.gmail.com>
Message-ID: <CAAhV-H4Vn1Mf8L_+QaCJJaQLLxKe5Sg9tJ4A5KkDuupdnfQHDw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/bpf: Enable bpf_probe_read{, str}() on LoongArch
To:     Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc:     kernel@xen0n.name, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Thu, Jul 27, 2023 at 12:21=E2=80=AFPM Chenguang Zhao
<zhaochenguang@kylinos.cn> wrote:
>
> Currently nettrace does not work on LoongArch due to missing
> bpf_probe_read{,str}() support, with the error message:
>
>      ERROR: failed to load kprobe-based eBPF
>      ERROR: failed to load kprobe-based bpf
>
> According to commit 0ebeea8ca8a4d ("bpf: Restrict bpf_probe_read{,
> str}() only to archs where they work"), we only need to select
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to add said support,
> because LoongArch does have non-overlapping address ranges for kernel
> and userspace.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 903096bd87f8..4a156875e9cc 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -11,6 +11,7 @@ config LOONGARCH
>         select ARCH_ENABLE_MEMORY_HOTREMOVE
>         select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
>         select ARCH_HAS_PTE_SPECIAL
> +       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_INLINE_READ_LOCK if !PREEMPTION
>         select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
> --
> 2.25.1
>
