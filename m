Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4BC78F22B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjHaRub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjHaRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:50:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA04CF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:50:27 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64f92ca5d8bso5894386d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693504226; x=1694109026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAaq4M/VDghokHx9XglV0KLWVzagv+CSyJGYQuIXX6U=;
        b=ZO/YeP8GsmZE8ghici5HE/xEqA3BQIHTF9BGg9LYwke4bYmCr0PTqacWmtFlU1dlWu
         jCK6FIhlh3ZN8JZ2j+a8PEH46m+8A5T8DZTpPQQw2H5BQCg38Ncnge46T7cyaDVk5ljJ
         0CyzVzJ8mLdrOGmtHCgQ7lhF4p6u1pLYzGFYlnM9jPf6e6RcwsKq/CqPN0NHi6YIk4cM
         PrTkWRChTtpxZo+NPZaAk/l7EJ2R/zjmcHhR1NYxmZuxGUedKfFF65cMZ2K23+MvvC2D
         +4nBqjEDatz9IlZZToNQR3LgvYmHQVwCHJoudoUoNO6P6srgYrbi/VXyK2Ol2e9ck+Az
         b/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504226; x=1694109026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAaq4M/VDghokHx9XglV0KLWVzagv+CSyJGYQuIXX6U=;
        b=QTK6OvfaAw5uoGje2vWT79BUYiYZDigl3SRlTyzI57x01jenp2Fg10QoXNGctfZ+nU
         +crAxPxu9YHCyHMVgr7OdFqm2nKuuk7KidggxBMnOAS+Efo9QkFTMuHZoE1TfmTAtMW9
         DSVAqyUBAAkf48tvaWA3wJBlyDrYk368rCpkk1OySECuB9fSZjPKIOlBoGxKBjD1GJuL
         Ej2ggW+3N3eKAyBvOTKVoQnQBNHd0ILB4TMsDFtIf1r++boySeGHpKJIHfMvMdlh4uvO
         PVopFfXf5K4QK2+uKEEFMjSpX9CDu3aUiyasZrfa/oiV22ZNJvI88e9ktdwhvGk6XUvk
         FGlw==
X-Gm-Message-State: AOJu0YyeFqijnm2Ac3azygXHFicDPtQYokQSSDVmvUL866vsmP3LqhvR
        +rI33gjR/5f5tGjrUPcsvEgWaokfpK896jmBWH1rxf1QhTyLMG2v3+g=
X-Google-Smtp-Source: AGHT+IERDqgHTy1OPBKV+u4pwMh3RA7LYDtELJWSEiaaVVYU4ZFq618KhLHw5ib8SvC8rKqISfLxCv1Xhc3isE/qA4Q=
X-Received: by 2002:a05:6214:4119:b0:641:8d17:96fd with SMTP id
 kc25-20020a056214411900b006418d1796fdmr3965481qvb.41.1693504226415; Thu, 31
 Aug 2023 10:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230831092914.4f91cd33@canb.auug.org.au>
In-Reply-To: <20230831092914.4f91cd33@canb.auug.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Aug 2023 10:50:15 -0700
Message-ID: <CAKwvOd=buFcfe3Ho7EfdTPQwDF06K90onCHaeCtd=w0Y2NQm7w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the risc-v tree with Linus' tree
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 4:29=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the risc-v tree got a conflict in:
>
>   arch/riscv/mm/kasan_init.c
>
> between commit:
>
>   d2402048bc8a ("riscv: mm: fix 2 instances of -Wmissing-variable-declara=
tions")
>
> from Linus' tree and commit:
>
>   56e1803d9de0 ("riscv: Mark KASAN tmp* page tables variables as static")
>
> from the risc-v tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Fix LGTM; I guess Palmer you may need to rebase that branch on mainline?

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/riscv/mm/kasan_init.c
> index a01bc15dce24,435e94a5b1bb..000000000000
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@@ -22,9 -22,10 +22,9 @@@
>    * region is not and then we have to go down to the PUD level.
>    */
>
> - pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> - p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
> - pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
>  -extern pgd_t early_pg_dir[PTRS_PER_PGD];
> + static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> + static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
> + static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
>
>   static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, =
unsigned long end)
>   {



--=20
Thanks,
~Nick Desaulniers
