Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC17943A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbjIFTOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjIFTOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:14:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500C185;
        Wed,  6 Sep 2023 12:14:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26f57f02442so140971a91.0;
        Wed, 06 Sep 2023 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694027645; x=1694632445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RD1cBDwzQS7RHR7A8DsRWlW49ZPHUgxJFs6IoxvXlZM=;
        b=TzHwJq/BpbfDN4qmB+VXqRPbSG3ZEMs97aTWDSAFJj4K+BUOYOkh16VQPuU0xm0AjX
         6QJbnxKYRF13892E4Ly1eqnrrAz1YlLufDTEtLnOmYwB3CrXR1lnAx4+uN4FrAPk9q1A
         GK2Fa0P1YsudfEJ7NUv7lP+29k1hmKPO8x4pqC7izM84EiNJi9JZqoIJIblbvjeEmOT2
         L7WQRsAX2WHlqY3OSJKyWeHjiTu2ZJp9zNUFKqbSPsv/44CmA6Vdo6CTxZSlmqoo+4Wn
         Ee0pbwS4L8C0u5L9b8JNMc5nxQwj0DhoiIp+893tiV8uS+51tgtghRO4RuOOo9dH1zXq
         IXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027645; x=1694632445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD1cBDwzQS7RHR7A8DsRWlW49ZPHUgxJFs6IoxvXlZM=;
        b=QOHRUo/EVogNKM2uuAmxZwSSzLvWQR1Pf0SotHB5qA2oTW3en0y5neFkpqNkak68ay
         dcFJ/jRS+IbgJx29vUqk0V5pDkc/OuMqZdfrtQnkhzpFLIwmN8OzTcV2I1eZDWcqsS0q
         30GF775HUsYbFQcSCBwNhx77xtZFr2h3g4zJN8CZ2a/oE/qfPBV02F6paeondR3zxFy3
         QcN+AvD7J7qMlb/FxGOnn4aFRxSo6+gY/74D/TOe0DV8bJopmKUVJPbTNTBTooNl+GBI
         d5E2LQudHu6AGG+6Pw4QIQAeZp4wb9vNe7RGQnVssh7+aychjuhLq738UEvyb6gjRW2J
         4rFQ==
X-Gm-Message-State: AOJu0YylcrS/2Nn8MyG8Oht7dOUoq/L21s03C6sfJnnbDVvgtWx3dEvd
        0q8aktowf1GVCtyJpG80cex2ciJZ78EwCqQufV2WehVM
X-Google-Smtp-Source: AGHT+IG+XGUeEHNmXhMlyzE5FZt9081fD0ungmbnMpKKY7l1v+6U0cj0QS2dgx/SqNJPkjEEBIOvf9QmRKdbh6Af1XU=
X-Received: by 2002:a17:90b:3c6:b0:268:38f5:86ac with SMTP id
 go6-20020a17090b03c600b0026838f586acmr13283165pjb.24.1694027645546; Wed, 06
 Sep 2023 12:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230905171451.4A04DC433C7@smtp.kernel.org>
In-Reply-To: <20230905171451.4A04DC433C7@smtp.kernel.org>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Wed, 6 Sep 2023 20:13:54 +0100
Message-ID: <CAA5enKZDKA9=gHJL1J=UVGFiB_LLBuR_4XHTasHauaFjeORHCQ@mail.gmail.com>
Subject: Re: [merged mm-hotfixes-stable] mm-vmalloc-add-a-safer-version-of-find_vm_area-for-debug.patch
 removed from -mm tree
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, willy@infradead.org, urezki@gmail.com,
        thunder.leizhen@huaweicloud.com, stable@vger.kernel.org,
        qiang.zhang1211@gmail.com, paulmck@kernel.org,
        joel@joelfernandes.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 16:09, Andrew Morton <akpm@linux-foundation.org> wrote:
>
>
> The quilt patch titled
>      Subject: mm/vmalloc: add a safer version of find_vm_area() for debug
> has been removed from the -mm tree.  Its filename was
>      mm-vmalloc-add-a-safer-version-of-find_vm_area-for-debug.patch
>
> This patch was dropped because it was merged into the mm-hotfixes-stable branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Hmm, I had outstanding review on this :/ I guess I will have to send a
follow up patch to address those concerns...


>
> ------------------------------------------------------
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: mm/vmalloc: add a safer version of find_vm_area() for debug
> Date: Mon, 4 Sep 2023 18:08:04 +0000
>
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts.  Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().
>
> [applied test robot feedback on unused function fix.]
> [applied Uladzislau feedback on locking.]
> Link: https://lkml.kernel.org/r/20230904180806.1002832-1-joel@joelfernandes.org
> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: <stable@vger.kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/vmalloc.c |   26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> --- a/mm/vmalloc.c~mm-vmalloc-add-a-safer-version-of-find_vm_area-for-debug
> +++ a/mm/vmalloc.c
> @@ -4278,14 +4278,32 @@ void pcpu_free_vm_areas(struct vm_struct
>  #ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
> -       struct vm_struct *vm;
>         void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> +       const void *caller;
> +       struct vm_struct *vm;
> +       struct vmap_area *va;
> +       unsigned long addr;
> +       unsigned int nr_pages;
> +
> +       if (!spin_trylock(&vmap_area_lock))
> +               return false;
> +       va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> +       if (!va) {
> +               spin_unlock(&vmap_area_lock);
> +               return false;
> +       }
>
> -       vm = find_vm_area(objp);
> -       if (!vm)
> +       vm = va->vm;
> +       if (!vm) {
> +               spin_unlock(&vmap_area_lock);
>                 return false;
> +       }
> +       addr = (unsigned long)vm->addr;
> +       caller = vm->caller;
> +       nr_pages = vm->nr_pages;
> +       spin_unlock(&vmap_area_lock);
>         pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> -               vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> +               nr_pages, addr, caller);
>         return true;
>  }
>  #endif
> _
>
> Patches currently in -mm which might be from joel@joelfernandes.org are
>
>


--
Lorenzo Stoakes
https://ljs.io
