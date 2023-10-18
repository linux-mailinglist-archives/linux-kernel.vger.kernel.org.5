Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6F7CE975
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJRUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJRUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:55:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FAEFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:55:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f8a093so67871085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697662507; x=1698267307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM7Lcg58eaICcI7n9hqCMKVzpyeJKHwBAKrGqarbnys=;
        b=Jt1MunVfc6TYsSYjLZaO2H1XWruP/8h1fnCn4kvyuDEWf31xEENH/AW37PEijBO/H5
         vHlcPazuPSeNfkq3Dhi/Hd59NcDn5oJ1LAoB/vL5U0Gp+FRC4PcCI27xcTzJ4IXRd/QP
         K7nxT1fxAHpR856s/X/gjevA6yqovE1LZAx8cYsywN7H4ID6rjcuEQiDy/BzxxXzjwHV
         H1PRw1A8XuXJo3VNYK+jR5V9wrbwI2pzzeepqlzthuVqWS+dQtWLIngdKHoUIoRnPW5p
         v/hb0+uPCVHzu5ZH3BMCv4iBZIzGDZkRxeET5AmR4lMRJTAXKe4xRC3C8/zmGs53Utqw
         U/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662507; x=1698267307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM7Lcg58eaICcI7n9hqCMKVzpyeJKHwBAKrGqarbnys=;
        b=UCsGEez3YqQGo7ZDBQuFbTe5dEb/ZTlUyhmd4doNvHBAO99slwzdv/1j208Ja0K5S9
         /AJvDSzqzMAtTBpvRrK3MacpfewziMHZT8NCjE3CBlMcYOyUAxMM305L99l7/CGw4jeG
         YbchvnY8h5lvs2YkboLzc9ITaK4APW6ksMumuFlqdZSf1Twr2tDsTirMy1zUFG0y6TrP
         hU0bYZHkUFdT6Qnr+59mMTOJ3OA9wZ3u4eEre9VKRHDNzaiI0cJMuqYsMtmkTgRW8Vgw
         WKYDFtglHOY42tgKmBFKD7NH9WClbBX2CWqFA1/7d837OI3tj9wItFWV2WFUYJxnrcEW
         NmYA==
X-Gm-Message-State: AOJu0YyTzFXxMarbX5xcDcHheSSOjJp/OCnBnxlLbBKcfUGeBYODqeV5
        UnSiV05IjLpqD+obZdj9yLSl3nCNcmMmQUQsfeydQw==
X-Google-Smtp-Source: AGHT+IGMqUrVfV+dz/gW9YaHJqOGThqNoUvNg3dX8yRlXQiXmYJ84aNlFY5GFAPOcqrTuilhkUJIA1J5zqNQf0x+Iq8=
X-Received: by 2002:a05:6000:45:b0:32d:96a7:9551 with SMTP id
 k5-20020a056000004500b0032d96a79551mr137837wrx.36.1697662506602; Wed, 18 Oct
 2023 13:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey> <20231012000327.GA1855399@dev-arch.thelio-3990X>
 <20231012145318.GA5127@monkey> <20231013001203.GA3812@monkey> <20231014000450.GA253713@monkey>
In-Reply-To: <20231014000450.GA253713@monkey>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Oct 2023 13:54:52 -0700
Message-ID: <CAKwvOdm9xKGQzi6_j=gGZCEmKJe6b9o8+jen1oEeAhyjcaSnxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 5:05=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 10/12/23 17:12, Mike Kravetz wrote:
> > On 10/12/23 07:53, Mike Kravetz wrote:
> > > On 10/11/23 17:03, Nathan Chancellor wrote:
> > > > On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> > > > > On 10/09/23 15:56, Usama Arif wrote:
> > >
> > > Thank you Nathan!  That is very helpful.
> > >
> > > I will use this information to try and recreate.  If I can recreate, =
I
> > > should be able to get to root cause.
> >
> > I could easily recreate the issue using the provided instructions.  Fir=
st
> > thing I did was add a few printk's to check/verify state.  The beginnin=
g
> > of gather_bootmem_prealloc looked like this:
>
> Hi Nathan,
>
> This is looking more and more like a Clang issue to me.  I did a little
> more problem isolation today.  Here is what I did:
>
> - Check out commit "hugetlb: restructure pool allocations" in linux-next
> - Fix the known issue with early disable/enable IRQs via locking by
>   applying:
>
> commit 266789498210dff6cf9a14b64fa3a5cb2fcc5858
> Author: Mike Kravetz <mike.kravetz@oracle.com>
> Date:   Fri Oct 13 13:14:15 2023 -0700
>
>     fix prep_and_add_allocated_folios locking
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c843506654f8..d8ab2d9b391b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2246,15 +2246,16 @@ static struct folio *alloc_fresh_hugetlb_folio(st=
ruct hstate *h,
>  static void prep_and_add_allocated_folios(struct hstate *h,
>                                         struct list_head *folio_list)
>  {
> +       unsigned long flags;
>         struct folio *folio, *tmp_f;
>
>         /* Add all new pool pages to free lists in one lock cycle */
> -       spin_lock_irq(&hugetlb_lock);
> +       spin_lock_irqsave(&hugetlb_lock, flags);
>         list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>                 __prep_account_new_huge_page(h, folio_nid(folio));
>                 enqueue_hugetlb_folio(h, folio);
>         }
> -       spin_unlock_irq(&hugetlb_lock);
> +       spin_unlock_irqrestore(&hugetlb_lock, flags);
>  }
>
>  /*
>
> - Add the following code which would only trigger a BUG if we were to
>   traverse an empty list; which should NEVER happen.
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d8ab2d9b391b..be234831b33f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3294,11 +3294,21 @@ static void __init gather_bootmem_prealloc(void)
>         LIST_HEAD(folio_list);
>         struct huge_bootmem_page *m;
>         struct hstate *h, *prev_h =3D NULL;
> +       bool empty;
> +
> +       empty =3D list_empty(&huge_boot_pages);
> +       if (empty)
> +               printk("gather_bootmem_prealloc: huge_boot_pages list emp=
ty\n");
>
>         list_for_each_entry(m, &huge_boot_pages, list) {
>                 struct page *page =3D virt_to_page(m);
>                 struct folio *folio =3D (void *)page;
>
> +               if (empty) {
> +                       printk("    Traversing an empty list as if not em=
pty!!!\n");
> +                       BUG();
> +               }
> +
>                 h =3D m->hstate;
>                 /*
>                  * It is possible to have multiple huge page sizes (hstat=
es)
>
> - As you have experienced, this will BUG if built with LLVM 17.0.2 and
>   CONFIG_INIT_STACK_NONE
>
> - It will NOT BUG if built with LLVM 13.0.1 but will BUG if built with
>   LLVM llvm-14.0.6-x86_64 and later.
>
> As mentioned in the previous email, the generated code for loop entry
> looks wrong to my untrained eyes.  Can you or someone on the llvm team
> take a look?

I think you need to initialize h, otherwise what value is passed to
prep_and_add_bootmem_folios if the loop is not run because the list is
empty.  The compiler sees `h` is only given a value in the loop, so
the loop must be run.  That's obviously hazardous, but the compiler
assumes there's no UB. At least that's my limited understanding
looking at the IR diff Nathan got me in
https://github.com/ClangBuiltLinux/linux/issues/1946.
--=20
Thanks,
~Nick Desaulniers
