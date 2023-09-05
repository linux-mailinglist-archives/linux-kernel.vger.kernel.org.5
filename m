Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D247927AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbjIEQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354358AbjIEK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:59:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AB199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0599B811DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F05CC433CD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693911539;
        bh=79TkLJodoCPEQAJcz0Moo8+UMv5TsS+bIcz1TUl2nWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UPiAsuAVVgoqF0/+7umxpSJPuy3vId12aZ9ItJ8pT157KQj1qIdSDjrrOLnKZQMX6
         TfquVGL4kj+wTxPkehZHY2jwkHxjXIJlpSqvLl2pSMfDEnH8nEOGcPMpZhHpXESplC
         H0u8VFXJA7lmKsuRLjFUwcV0CGLvmmROKZ9aDloBosICXA6kf3qruwm794StJfA6x/
         yxUqBXCvOhg4zuneRcO7mLfLq9uZpxAHzmfg2eIOGwqQSq7CikzVktNUw4ZPpzvhgk
         TJxZSybxLBugv+NfVOsfRL0WVd0QLixk82jdGrjBWt2dYas/TZLw/Rw2Z9/3rIoBlI
         7B00ZBcIcJNdA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so34442721fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:58:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywwb7qIkRQ5o6QsnX1mZ57nwIdPNmXepPMuQxQ6Rd+lZrGMOPRZ
        /i9MDo43BdvEkpYN3ipadazn1NWI2cPd0EQiwVA=
X-Google-Smtp-Source: AGHT+IGe/YTwaykmN060K8FMOXvM0fNJJoeiXEB/h+IAQFUntz4rJCvV+58r769qk2gSzp54xb8Zy/y/ZlUq4wZpchU=
X-Received: by 2002:a05:651c:238:b0:2b9:36d5:729c with SMTP id
 z24-20020a05651c023800b002b936d5729cmr9549657ljn.47.1693911537433; Tue, 05
 Sep 2023 03:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230905080147.1625448-1-maobibo@loongson.cn> <20230905080147.1625448-2-maobibo@loongson.cn>
In-Reply-To: <20230905080147.1625448-2-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 5 Sep 2023 18:58:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VK+XkpCJUjX8vE2MtHDqzteCeDkvdxurKMbCZ6brSFg@mail.gmail.com>
Message-ID: <CAAhV-H7VK+XkpCJUjX8vE2MtHDqzteCeDkvdxurKMbCZ6brSFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: Remove zero_page_mask symbol
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

On Tue, Sep 5, 2023 at 4:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> On LoongArch system, there is only one page for zero page, and
> there is no COLOR_ZERO_PAGE, so zero_page_mask is useless and
> macro __HAVE_COLOR_ZERO_PAGE is not necessary. This patch removes
> zero_page_mask and macro __HAVE_COLOR_ZERO_PAGE.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 4 +---
>  arch/loongarch/mm/init.c             | 9 +--------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 06963a172319..342c5f9c25d2 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -71,11 +71,9 @@ struct vm_area_struct;
>   */
>
>  extern unsigned long empty_zero_page;
> -extern unsigned long zero_page_mask;
>
>  #define ZERO_PAGE(vaddr) \
> -       (virt_to_page((void *)(empty_zero_page + (((unsigned long)(vaddr)=
) & zero_page_mask))))
> -#define __HAVE_COLOR_ZERO_PAGE
> +       (virt_to_page((void *)(empty_zero_page)))
>
>  /*
>   * TLB refill handlers may also map the vmalloc area into xkvrange.
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 3b7d8129570b..8ec668f97b00 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -35,14 +35,8 @@
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
>
> -/*
> - * We have up to 8 empty zeroed pages so we can map one of the right col=
our
> - * when needed.         Since page is never written to after the initial=
ization we
> - * don't have to care about aliases on other CPUs.
> - */
> -unsigned long empty_zero_page, zero_page_mask;
> +unsigned long empty_zero_page;
>  EXPORT_SYMBOL(empty_zero_page);
> -EXPORT_SYMBOL(zero_page_mask);
>
>  void setup_zero_pages(void)
>  {
> @@ -60,7 +54,6 @@ void setup_zero_pages(void)
>         for (i =3D 0; i < (1 << order); i++, page++)
>                 mark_page_reserved(page);
>
> -       zero_page_mask =3D ((PAGE_SIZE << order) - 1) & PAGE_MASK;
In my opinion it is better to combine two patches to one. Because this
patch can only work *accidently* when 'order' is zero.

Huacai
>  }
>
>  void copy_user_highpage(struct page *to, struct page *from,
> --
> 2.27.0
>
>
