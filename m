Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D667E056E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjKCPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjKCPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:19:38 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC7123
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:19:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2ea7cc821so1320512b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1699024771; x=1699629571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=liLeXSkpooaWOUPaSwHhbbjwtzRLYBJW04zYO+tuOmo=;
        b=eo5HRjTi09AnDl2eHY6t9MzZGSw4diEPGBBKUnl0ywju9f+kwsTvc5k4SL+uqH/JLF
         62UwlNbCk50u1itPbc4NtvUXu7wxZZg8Ao/T3dZ6zcyHd1sJHMpBddk/Iq7UPM5iyDMF
         jzMdxWd5DMCxG7HbR1pnU9vZ4kqQEBN0kbJlF1YtstuWX7CttkF2G4Cu5EksbxQ/HJ7u
         EGf1qOEXNxglfcCK2jIXOSYriUmcGBlF7ykVnYmsLSMXWMZDYCz4sQIz5IFCG5nUxY7l
         3H8dso//uiuq+POHmm74MdW7SJJ2FJ8B0sgprFO8EEQMGezcpPc3UqEA44RaLIxhLsxg
         vGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024771; x=1699629571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liLeXSkpooaWOUPaSwHhbbjwtzRLYBJW04zYO+tuOmo=;
        b=RvxXs3+iiaBPhb0O8Gxc54JklqFRCg/ZXlO6wiXkfBUiQ2ZHJ3MjHXSR3ecW5kU8Rg
         wXEzrgXn1V4ANGt631D7+Jl0OZEVeaaXL2T8nuq/gs41ikRKZ09klWVNJ3XfahZTOalf
         g+NSLAhUIxDpyHMu8iC4/wq5L78OxmJ15TnfvqW7MYItvjEZoMZX0HjBOXfdqYcAYXJY
         YJZuxmmrcp9sQ2SoZsqMKwJYBIw0z6kknWhIGNsydM1ohKGOneOg+pBePx51PRuAouCe
         /xJrI0vw+b7p5fTTmCaWSHggH1PrqGV4OQEsaNY6p8c5Bw3eloy0CDH+EebHcgT0Qzun
         a6Fw==
X-Gm-Message-State: AOJu0YwGfn6fteQ2g1EuUkah3pB4kp1bqn16zmmWz/rtHqztWhhFogzN
        +BVc8ZQ+QjeIiKBsFumQ7CpaoNw74BRCb8pTKlVWbA==
X-Google-Smtp-Source: AGHT+IHPzOa9iAe+GlV7Tg9JGtkM0A7QgdUDBavOwv9+9DuGS+xM5/s6EzR1YL7nknthcj0uI8QJut9DydQ7Bvbd21w=
X-Received: by 2002:a05:6808:1986:b0:3ab:84f0:b49d with SMTP id
 bj6-20020a056808198600b003ab84f0b49dmr26946069oib.3.1699024770996; Fri, 03
 Nov 2023 08:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
 <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com>
 <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
 <CA+CK2bAv6okHVigjCyDODm5VELi7gtQHOUy9kH5J4jTBpnGPxw@mail.gmail.com> <CAAPL-u-nSLiObCC9Vbtdv1m8-87K-M6FcVcgnruGzRkAAucRTA@mail.gmail.com>
In-Reply-To: <CAAPL-u-nSLiObCC9Vbtdv1m8-87K-M6FcVcgnruGzRkAAucRTA@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 3 Nov 2023 11:18:53 -0400
Message-ID: <CA+CK2bAWbnapxXvOwHFXFJNqzKP-_=vroyLaeWBQ=d-ZJ4_R3w@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     Wei Xu <weixugc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, rdunlap@infradead.org,
        chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since we are going to use two independent interfaces
> > /proc/meminfo/PageMetadata and nodeN/page_metadata (in a separate file
> > as requested by Greg) How about if in /proc/meminfo we provide only
> > the buddy allocator part, and in nodeN/page_metadata we provide the
> > total per-page overhead in the given node that include memblock
> > reserves, and buddy allocator memory?
>
> What we want is the system-wide breakdown of kernel memory usage. It
> works for this use case with the new PageMetadata counter in
> /proc/meminfo to report only buddy-allocated per-page metadata.

We want to report all PageMetadata, otherwise this effort is going to
be useless for the majority of users.

As you noted, /proc/meminfo allows us to report only the part of
per-page metadata that was allocated by the buddy allocator because of
an existing MemTotal bug that does not include memblock reserves.
However, we do not have this limitation when we create a new
nodeN/page_metadata interface, and we can document that in the sysfs
ABI documentation: sum(nodeN/page_metadata)  contains all per-page
metadata and is superset of /proc/meminfo.

The only question is how to name PageMetadata in the /proc/meminfo
appropriately, so users can understand that not all page metadata is
included? (of course we will also document that only the MemTotal part
of page metadata is reported in /proc/meminfo)

Pasha
