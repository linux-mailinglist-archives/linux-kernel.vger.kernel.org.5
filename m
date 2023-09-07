Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B30796E94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjIGBg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjIGBgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:36:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD110FC;
        Wed,  6 Sep 2023 18:36:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DEFC433D9;
        Thu,  7 Sep 2023 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694050581;
        bh=D3nVWOHhkmhoY1EX23mvCZ4eZ9Olrv5+jxHtY3gqvxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P1gtcAM6iZmE3GfcXb/9pte/84Tcj3t9MNhDtQFy5LOEur+TW95AAuWBqWTh4Noic
         Akj2UjAmkTR6IGsppAc9MXTeexO/ZY7yojVVm1cuD+IEWYV9cPmIRszAqz/JpiG6q3
         v4TkGwFB9nhHnAL3U/uMcPdz9bqQgO8p31885G22WufqWvRuuvey3naVHR+Uz2u4fK
         E7nKI4HiJYIxTCpcMbL9mFSMWvfjT1wByHyENPRwO4cV/iEDcVjiZEofU05Qq0z/Gl
         T9IP35rvHmuucaHlbDSgrRPz0h4sth/6EMTy6VW74tebPe+Tv7Ta+yzy2sqzSfu18e
         jnUh1xztmKtPQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-500b66f8b27so662409e87.3;
        Wed, 06 Sep 2023 18:36:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywq2OLBKTeKmwLwNJ/7cQN8HaJYml9BJDTp/VcmRZ/QNaoeAK/d
        jSh8RXGmBr0RFk4gSIQLCKkdXgLymdsB4wCbc4I=
X-Google-Smtp-Source: AGHT+IEE0i+eB6sNRcbbEyXiXfFXLSIfEkkJMaD0vlDSf4gvKImXgs9G/kfMt+ocLBAs/OSMT/+a3RH2B95xohcvqbM=
X-Received: by 2002:a19:6514:0:b0:500:a0a3:80ff with SMTP id
 z20-20020a196514000000b00500a0a380ffmr3615526lfb.58.1694050579372; Wed, 06
 Sep 2023 18:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230906092019.4681-1-zhanghongchen@loongson.cn>
In-Reply-To: <20230906092019.4681-1-zhanghongchen@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 7 Sep 2023 09:36:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54scsYV_jCVY_SQ8VVRpjuDreTtJ5d1JvQFNmr59_5hQ@mail.gmail.com>
Message-ID: <CAAhV-H54scsYV_jCVY_SQ8VVRpjuDreTtJ5d1JvQFNmr59_5hQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: add p?d_leaf() definitions
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Wed, Sep 6, 2023 at 5:20=E2=80=AFPM Hongchen Zhang <zhanghongchen@loongs=
on.cn> wrote:
>
> When I do LTP test, LTP test case ksm06 caused panic at
>         break_ksm_pmd_entry
>           -> pmd_leaf (Huge page table but False)
>           -> pte_present (panic)
>
> The reason is pmd_leaf is not defined, So like
> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
> add p?d_leaf() definition for LoongArch.
>
> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
> v2->v3: add Cc: stable@vger.kernel.org
> v1->v2: add Fixes in commit message
> ---
>  arch/loongarch/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 370c6568ceb8..ea54653b7aab 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
>
>  #define pmd_phys(pmd)          PHYSADDR(pmd_val(pmd))
>
> +#define pmd_leaf(pmd)          ((pmd_val(pmd) & _PAGE_HUGE) !=3D 0)
> +#define pud_leaf(pud)          ((pud_val(pud) & _PAGE_HUGE) !=3D 0)
> +
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_page(pmd)          (pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT)=
)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
> --
> 2.33.0
>
>
