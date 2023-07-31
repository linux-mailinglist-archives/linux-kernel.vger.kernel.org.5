Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CA76992F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGaOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGaOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14701B6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F3261168
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A50C433D9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690812933;
        bh=LmZUftagqaDLewC2gJ5Gis/7ee8BS+nDnAymgdUOikc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nK1Q+ttzf35vCM6MTZzsp0AV4NhsE/TtBn8gAM9ByNqga+10sGxjqFBdQ1Bodhblu
         FCfhp3azrUneGM87uEPgYZ3V4L6htGsZVvp9+TJeXyYDtF7aiOu0CNNYqC6dwNXvoE
         Jnv1GwfTEGiezyhg5pLXVVWAyW46DHaDf+EWez6q9L2XrmPviSRlUaXBY5ftq7RwEr
         PJTKmqC5P4Ue4L32tRrXWdBM8fyce9xhJCrdMXiCXdSCG1j5N/Sl5nRiOzS5an0b/I
         ewN+3WY4FCDZFZyYY2TO9YXvT3HxCoCA/wJZikn3ESDM85i70duS0WxpYsKOzxk9yC
         eHA/IwwgDw4Qw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so7374554e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:15:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLaxoqifhW6GG4bM2pb3TzT73PFTJCLRrGd3QhFlSnp8ybGvimxu
        5RQgrpPhuBU7nuqCjiWqmqYKTKG8WCralwRbVag=
X-Google-Smtp-Source: APBJJlFpLPRz577cv4QSkr4hDX4QySnQO4PMueRqhtcd2KnJMPROZUyrPat93etm6mbOXU8A3fYXqEll6MzgX4PrU0A=
X-Received: by 2002:a05:6512:2381:b0:4fe:958:88ad with SMTP id
 c1-20020a056512238100b004fe095888admr5672762lfv.10.1690812931924; Mon, 31 Jul
 2023 07:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230712031622.1888321-1-maobibo@loongson.cn> <20230712031622.1888321-3-maobibo@loongson.cn>
In-Reply-To: <20230712031622.1888321-3-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 31 Jul 2023 22:15:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4nG=vRqaU+q7j3Kp9v24u-NNEjdisF34QP-kM+_J2+tg@mail.gmail.com>
Message-ID: <CAAhV-H4nG=vRqaU+q7j3Kp9v24u-NNEjdisF34QP-kM+_J2+tg@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Code cleanup in function pcpu_populate_pte
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> There are some code cleanups in function pcpu_populate_pte:
> 1. Replace memblock_alloc with memblock_alloc_raw for pud and pmd since
> they will be reinitialized with pud_init and pmd_init.
>
> 2. Add memory allocation failure handling
>
> 3. Replace pgd_populate with p4d_populate, it will be useful if there
> four-level page tables.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kernel/numa.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 708665895b47..778e1c20bfb0 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -73,33 +73,40 @@ void __init pcpu_populate_pte(unsigned long addr)
>         pmd_t *pmd;
>
>         if (p4d_none(*p4d)) {
> -               pud_t *new;
> -
> -               new =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -               pgd_populate(&init_mm, pgd, new);
> +               pud =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
Don't use memblock_alloc_raw() here, it is better to keep consistency
with mm/percpu.c.


Huacai
> +               if (!pud)
> +                       goto err_alloc;
> +               p4d_populate(&init_mm, p4d, pud);
>  #ifndef __PAGETABLE_PUD_FOLDED
> -               pud_init(new);
> +               pud_init(pud);
>  #endif
>         }
>
>         pud =3D pud_offset(p4d, addr);
>         if (pud_none(*pud)) {
> -               pmd_t *new;
> -
> -               new =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -               pud_populate(&init_mm, pud, new);
> +               pmd =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +               if (!pmd)
> +                       goto err_alloc;
> +               pud_populate(&init_mm, pud, pmd);
>  #ifndef __PAGETABLE_PMD_FOLDED
> -               pmd_init(new);
> +               pmd_init(pmd);
>  #endif
>         }
>
>         pmd =3D pmd_offset(pud, addr);
>         if (!pmd_present(*pmd)) {
> -               pte_t *new;
> +               pte_t *pte;
>
> -               new =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -               pmd_populate_kernel(&init_mm, pmd, new);
> +               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +               if (!pte)
> +                       goto err_alloc;
> +               pmd_populate_kernel(&init_mm, pmd, pte);
>         }
> +
> +       return;
> +
> +err_alloc:
> +       panic("%s: Failed to allocate memory\n", __func__);
>  }
>
>  void __init setup_per_cpu_areas(void)
> --
> 2.27.0
>
