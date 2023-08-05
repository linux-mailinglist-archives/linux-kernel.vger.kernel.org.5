Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018F077106A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHEQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:06:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A3E70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:06:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d05a63946e0so3167233276.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691251600; x=1691856400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUC7hGh6qWIThNH4Y7Zx7/EPitpQqojAFQsIWWs+CoI=;
        b=w8Aj8qAsosbRzUMt2ECW46TyqC0Gdyvyl+8r7lBeqF0ua8QQKCBE5E1zQGJ2FqqVrY
         IWxJiR+PHr3TYG9C2wIzVQX0vTC/dTQIMFLSzMhCC4fc2iu4z+KOYx4q/EAt+r2VYcsQ
         ljmEuYDM/aEp8ZaC3Ipn5VD4XvHWZnnmo7V4EVd3zKBxQmzVwNwbOLRTfsWf9eWLvgYJ
         acklIdGosROzxvEoOgMaFLt02K60UXl2jNnD4Y1nKC4Pm8qYNJP57MpPfVMS4RAcceH5
         CI1f/w7lAC5yfC49EUEm34IrwYx9pkrJ/W1wn29U0E+XXkryfH22U94PYoY0ASg7qzDx
         Tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691251600; x=1691856400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUC7hGh6qWIThNH4Y7Zx7/EPitpQqojAFQsIWWs+CoI=;
        b=bo/TnYgHwlQY5O7FRhA8itn5cj7ws1bLPqzJoOINwnAVeZryRcHm9Hx4i5IiZFS8dx
         PNVlVbyiscdaIUcUWTBt+QI7U4KJh0j2M7VZRCvCp9UfSPnyrUmufqJOakh1twXP8v21
         RNIWpHtsz/BRIjJ8BSfJ6Ax2RoYE9UL4qI9H3Qz6UWNfnHphnBePqw9dg8ffVrUFNJQv
         HgBAmkcc6YpWOo3I8OD4EmRIvDuqOLSu7WkaESsvlaBnhP3enNJyu1lECUS8EYg8RO8O
         5EiMhz4w6pSN2DIL0+EAmMIDDi/QQlQDb0V/SA5ToNiaHZh0z2jf4yL/1xbAX0e1sZYf
         B1JA==
X-Gm-Message-State: AOJu0YxRJGJ+AmJyp/v8p0cBFE/li6EDxbBMLew85wBBhsy1+HrKB3cY
        h/LVc1kY4HhwNqfU43O0OqDtemJVWuWz5l90NfCotQ==
X-Google-Smtp-Source: AGHT+IEXUM4q2tosVwitR5AuzqfGOAsWLX3RMlI0jzEdL0gZFzU0pYbDkEpMbjYQX87lDwP1ZwDc2PpSdxAmkmBsMCQ=
X-Received: by 2002:a05:6902:392:b0:d07:87b0:f2a8 with SMTP id
 f18-20020a056902039200b00d0787b0f2a8mr4271442ybs.21.1691251600297; Sat, 05
 Aug 2023 09:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com> <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
 <ZMPLFqJ192j0loCV@casper.infradead.org> <da591261-26f1-5cf7-1435-a98ae21f5141@google.com>
In-Reply-To: <da591261-26f1-5cf7-1435-a98ae21f5141@google.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Sun, 6 Aug 2023 00:06:28 +0800
Message-ID: <CAMSo37UxxZ6dc9cY=TArOP01jTuBHuLT1BGv0d=y_hJA1_7Zvw@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to fail
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 at 00:58, Hugh Dickins <hughd@google.com> wrote:
>
> On Fri, 28 Jul 2023, Matthew Wilcox wrote:
> > On Fri, Jul 28, 2023 at 09:53:29PM +0800, Yongqin Liu wrote:
> > > Hi, Hugh
> > >
> > > It seems this change makes pte_offset_map_lock not possible to be
> > > called in out of tree modules,
> > > otherwise it will report error like this:
> > >         ERROR: modpost: "__pte_offset_map_lock"
> > > [../omap-modules/android-mainline/pvr/pvrsrvkm.ko] undefined!
> > >
> > > Not sure if you have any idea about it, and any suggestions on how to
> > > resolve it?
> >
> > Please explain why this module needs to map page tables
>
> +1
Sorry, I am not able to give any explanation here,
I am not familiar with the pvrsrvkm source, I just use it to have one
working AOSP build.

here is the source file where pte_offset_map_lock is called,
    https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/services4/srvkm/env/linux/osfunc.c?h=android-mainline#n3508
in case you could know something with a quick look.

Otherwise, it has to wait for another one to report the problem again.

> Thank you for testing 6.5-rc, and I am sorry to have inconvenienced you.
>
> But there is not one example of an in-tree module needing that,
> which is a very strong hint that no module should be needing that.
>
> Sounds like pvrsrvkm.ko wants to muck around with page table entries,
> without the core mm knowing.  Not something core mm can encourage!
>
> If what pvrsrvkm.ko is aiming to do there would be useful for others,
> maybe its owner can share that, and work with core mm developers to
> expose a generally useful interface - but that is not likely to be
> __pte_offset_map_lock itself.
>

Thanks for the explanation!
Let's see if any other pvrsrvkm engineer or other out of tree modules could help
give some explanations on this case or similar cases.

Thanks,
Yongqin Liu


--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
