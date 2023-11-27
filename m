Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CA7F9B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjK0ION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjK0IOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:14:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA3BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:14:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so3263945b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701072855; x=1701677655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdH2jyu800OfUGXIQJ9d4watjXtBqJ+y351M+NsN6Fw=;
        b=TFLcZrFnTU0lcWmYbilODFCaz5TKc/flv6Fd8/sGL+XxYlpvmvw6cZI5PXgHe/bs88
         Ow3NYvaxIL1WTyMdg+boEyVP9TpmiLHKe/9o72vslXg1AzG9o0e2eFLAow8o2it43NvR
         Bi5+dURT8gDdZLKI7eEqY5zMaKJTj+vWOSyybY9SyEA1xKiI05mFBnFlQYsSLThAMqoI
         n+OjSM9zn6yRplS3hm8HU4U/01xPAoDlxtaxUH/uXI4YWkKGxxOl+j1ef9xWMONIq5KG
         DaB9a1C+9kT25r2NOVlKWJuajc9ffadfL26HSmXj0lhUvNvSYxQ6dy5iu71gtgemociS
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072855; x=1701677655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdH2jyu800OfUGXIQJ9d4watjXtBqJ+y351M+NsN6Fw=;
        b=UewVBL3pS3RxWudImPVLlICVYWebLpnu6K4/9i19aRi5ME/1gZQ4+1UiKjDKry8J2Q
         7G25yrRarv3eFiD8SvrBuChoxVyWiS6BJ4wV5OOXx/3Zl6E+Etqvl7JbBumjeqgK1H18
         LR8A0mV6VrwcS3nPO4kyqT7V2DcLmgTk8BIsFLPMXCMzjDfQQ96a3tZn5w0t07vGQDT8
         pydfjjYAvCd13FbmOhqkepHz1ew9pE4XQmHw1n9XkfK7pwDtWPCcl72hQryHKMYklPB7
         FTHIRMpWY5tQ2Ve5y14XY4LpjyMtRNWiT/KWO/eNO2ZuRjxP3R4mCkOcpKptN7Yvc2HZ
         WB9g==
X-Gm-Message-State: AOJu0YxWzOJb1LRswf9A0P8pzR/p64af05Ws7rG2lFUPnv6igyqNSvhU
        ZbvQFa1nXZYxCOxnToxfMF33F+0SyncsnJcxfsbmgQ==
X-Google-Smtp-Source: AGHT+IHkgubfh/fHMuR2jP4q4vvT0yJIadwEZTafa6tTobyBu+zFukrQFhvDnBXklybJ5CrJ20pPAiuRPPmKkuEgtJI=
X-Received: by 2002:a05:6a20:9e4d:b0:14c:c511:387d with SMTP id
 mt13-20020a056a209e4d00b0014cc511387dmr11710221pzb.9.1701072855207; Mon, 27
 Nov 2023 00:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20231123065708.91345-1-luxu.kernel@bytedance.com> <94c2e04c-4c62-4ee1-8ae7-cbd675c5064e@app.fastmail.com>
In-Reply-To: <94c2e04c-4c62-4ee1-8ae7-cbd675c5064e@app.fastmail.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Mon, 27 Nov 2023 16:14:03 +0800
Message-ID: <CAPYmKFtA7XuDR3vzd1aw_RC1YY3hDgo-aw-DHw368mdDUtyW6A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH V1 00/11] riscv: Introduce 64K base page
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        dengliang.1214@bytedance.com, Xie Yongji <xieyongji@bytedance.com>,
        lihangjing@bytedance.com, Muchun Song <songmuchun@bytedance.com>,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your reply! And sorry for replying so late.

On Thu, Nov 23, 2023 at 5:30=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Nov 23, 2023, at 07:56, Xu Lu wrote:
> > Some existing architectures like ARM supports base page larger than 4K
> > as their MMU supports more page sizes. Thus, besides hugetlb page and
> > transparent huge page, there is another way for these architectures to
> > enjoy the benefits of fewer TLB misses without worrying about cost of
> > splitting and merging huge pages. However, on architectures with only
> > 4K MMU, larger base page is unavailable now.
> >
> > This patch series attempts to break through the limitation of MMU and
> > supports larger base page on RISC-V, which only supports 4K page size
> > now.
> >
> > The key idea to implement larger base page based on 4K MMU is to
> > decouple the MMU page from the base page in view of kernel mm, which we
> > denote as software page. In contrary to software page, we denote the MM=
U
> > page as hardware page. Below is the difference between these two kinds
> > of pages.
>
> We have played with this on arm32, but the conclusion is that it's
> almost never worth the memory overhead, as most workloads end up
> using several times the amount of physical RAM after each small
> file in the page cache and any sparse populated anonymous memory
> area explodes to up to 16 times the size.
>
> On ppc64, using 64KB pages was way to get around limitations in
> their hashed MMU design, which had a much bigger performance impact
> because any page table access ends up being a cache miss. On arm64,
> there are some CPUs like the Fujitsu A64FX that are really bad at
> 4KB pages and don't support 16KB pages, so this is the only real
> option.
>
> You will see a notable performance benefit in synthetic benchmarks
> like speccpu with 64KB pages, or on specific computational
> workloads that have large densely packed memory chunks, but for
> real workloads, the usual answer is to just use transparent
> hugepages for larger mappings and a page size of no more than
> 16KB for the page cache.

Actually we did find actual performance benefits brought by 64K page
size in real business scenarios.
On the Ampere ARM server, when applying 64K base page size, we saw an
improvement of 2.5x for both qps and latency on redis, a performance
improvement of 10~20% on our own newsql database and 50% on object
storage.
For mysql, the qps increases about 14%, 17.5% and 20% for read-only,
write-only and random read/write workloads respectively. And the
latency reduces about 13.7%, 15.8% and 14.5% on average.
This is also why we chose to implement a similar feature on RISC-V in
the beginning.

>
> With the work going into using folios in the kernel (see e.g.
> https://lwn.net/Articles/932386/), even the workloads that
> benefit from 64KB base pages should be better off with 4KB
> pages and just using the TLB hints for large folios.

Maybe 64K page size combined with large folios can achieve more benefits.
As is mentioned in this patch[1], a 64K page size kernel combined with
large folios and THPs via cont pte can achieve speedup of 10.5x on
some memory-intensive workloads on arm64 SBSA server.

[1] https://lore.kernel.org/all/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia=
.com/

>
>      Arnd
