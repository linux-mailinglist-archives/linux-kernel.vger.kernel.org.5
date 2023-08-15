Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2477C63D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjHODO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjHODN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9A1987;
        Mon, 14 Aug 2023 20:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D0C618CD;
        Tue, 15 Aug 2023 03:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB1C433C8;
        Tue, 15 Aug 2023 03:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692069127;
        bh=OMqKbUb5Z6H+wBW/auUjyZMEYXJpKnpvS6GlVzJnka0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S6rt+hAuiJV63P1B4FxfZ3NkAMEZaMsUzvqMbltFVK9UvK3EVj82UoXZcMbY2Lcu/
         vrW3u3PD5MbNGnLCKp3N5e76dPvsAOZpPZTJ54OAG2dha1MC6qHiNxFkMemOIK8Ed7
         W2J0DELDonLghGJlSWJffW2kQDo46XYSYQAQ+Mpg2ofWH/nY6a1OrdYxs3kvSLa1bS
         SnWI72RAmHM+/jUJ4o5OTCCWaVQzYwOjVBwQWEUOPjRYe4qYyJY2TfarZpeAFQbv9g
         3jfJNdU9jQ3wqGrx4pe7S9O/C7XafPQ7rmMlxX7lS6gUlY6l58tkXFqLtHQLnR3sxI
         wRB+1w9v46+1A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fe0c566788so7834064e87.0;
        Mon, 14 Aug 2023 20:12:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxjX660rul9/cMV7y4SAzmutsbJgFkQH2Pqz7FfFEDtV7r+Qnx
        zZF0eTXplOH7HImWTR8sSjUraLbmY0dz69Itu24=
X-Google-Smtp-Source: AGHT+IHLO2l2Hzw4JAJnD4ugJfISr9EG03Lgo5HMyI2u2yjH1FtGDSdelHreBc6cS9H/iMVmKoIVS8YOxBXfylTlElU=
X-Received: by 2002:ac2:4e04:0:b0:4fd:f7b8:555 with SMTP id
 e4-20020ac24e04000000b004fdf7b80555mr9118198lfr.19.1692069125012; Mon, 14 Aug
 2023 20:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230815104604.54f65293@canb.auug.org.au>
In-Reply-To: <20230815104604.54f65293@canb.auug.org.au>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 15 Aug 2023 11:11:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRVG+yX7fktLru4U=OVKrTg73kTR5hirw1hh1P9c+MNOQ@mail.gmail.com>
Message-ID: <CAJF2gTRVG+yX7fktLru4U=OVKrTg73kTR5hirw1hh1P9c+MNOQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the csky tree with the mm tree
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:46=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the csky tree got a conflict in:
>
>   arch/csky/abiv2/cacheflush.c
>
> between commit:
>
>   1222e1310d64 ("csky: implement the new page table range API")
Could I take this patch into csky next tree to solve the conflict.

>
> from the mm tree and commit:
>
>   1362d15ffb59 ("csky: pgtable: Invalidate stale I-cache lines in update_=
mmu_cache")
>
> from the csky tree.
>
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/csky/abiv2/cacheflush.c
> index d05a551af5d5,500eb8f69397..000000000000
> --- a/arch/csky/abiv2/cacheflush.c
> +++ b/arch/csky/abiv2/cacheflush.c
> @@@ -16,23 -15,22 +16,22 @@@ void update_mmu_cache_range(struct vm_f
>
>         flush_tlb_page(vma, address);
>
>  -      if (!pfn_valid(pte_pfn(*pte)))
>  +      if (!pfn_valid(pfn))
>                 return;
>
>  -      page =3D pfn_to_page(pte_pfn(*pte));
>  -      if (page =3D=3D ZERO_PAGE(0))
>  +      folio =3D page_folio(pfn_to_page(pfn));
>  +
>  +      if (test_and_set_bit(PG_dcache_clean, &folio->flags))
>                 return;
>
>  -      if (test_and_set_bit(PG_dcache_clean, &page->flags))
>  -              return;
>  +      for (i =3D 0; i < folio_nr_pages(folio); i++) {
>  +              unsigned long addr =3D (unsigned long) kmap_local_folio(f=
olio,
>  +                                                              i * PAGE_=
SIZE);
>
>  -      addr =3D (unsigned long) kmap_atomic(page);
>  -
>  -      icache_inv_range(address, address + PAGE_SIZE);
>  -      dcache_wb_range(addr, addr + PAGE_SIZE);
>  -
>  -      kunmap_atomic((void *) addr);
> ++              icache_inv_range(address, address + PAGE_SIZE);
>  +              dcache_wb_range(addr, addr + PAGE_SIZE);
> -               if (vma->vm_flags & VM_EXEC)
> -                       icache_inv_range(addr, addr + PAGE_SIZE);
>  +              kunmap_local((void *) addr);
>  +      }
>   }
>
>   void flush_icache_deferred(struct mm_struct *mm)



--=20
Best Regards
 Guo Ren
