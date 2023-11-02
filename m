Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE67DF870
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjKBRMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjKBRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:12:18 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D2B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:12:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41e1974783cso6253321cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698945132; x=1699549932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hH8SjbUIXGq+UF4UxExRqQ+IVCN5t4ykfPIyUiPH38=;
        b=FWvTot97iNaUk34pLKY6RcPdDB6uB+6Nkxu/1gNnBoQMYWZhraEWEno08JMoD+icya
         /4sa8SzCHvQSVHuPDCv1gYrwugQh4kj1g6dkDloI2TLJFjvRWdXwtoSi7GKHcVriN6Dh
         zm5qbeTHTxZBfNmXW5ldlq1oHsjcNBXMgVUQSj9JzEXPRzeGOWggi7DYYJ4VlOnRDuXF
         P7kC0rjAZLAa4pmlnwK8hgJHJsXXRLB2NJDB6d8uQm8NcL8SJbGOsyk08OG0ElWfDzWd
         kINNf7HlpxAA2dVoCBf2cjxCM8zXjz2H7/PtWfCYyq9/u/sSeIrrFbqMVOjCE/oB1oDl
         cxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945132; x=1699549932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hH8SjbUIXGq+UF4UxExRqQ+IVCN5t4ykfPIyUiPH38=;
        b=nsnNybjl/4q8hgLKTj9hTE/xhNpghgAC2YGqbac62yLX/5zHrDhUOwvuvalEy6C1g8
         d0I6EcdBPR/+29w1lWh6fB0FMrSreTiBxGmoeGTE5+UlosEuSqGt5GceX659mIh7vttE
         K7+fi/p3afEZOE5peDJsX4OKuVtdc1oeQI3nRZEVBy3KFWVqMbOnCXWpXmK1Cz+He99c
         FpwDEpwrnabLfSfVsCFeIH48QgLtw1RqE3qdMY+3Dp71DrotPPAtEKnfhlkn/LMGIZvR
         GYc/8WzOL852XXPyRxRjbMpFn/flRl7CTsh1DA4AbdeRsKZDTBwEfYcd83L7diYXsRGc
         EzOQ==
X-Gm-Message-State: AOJu0YwCcL4xQzcpEK0gZ+wdMM10Q8MgfJwHbUrdB5uV5GXHN+k4lOMY
        ceZCwZlPFZXuSpNF8qE9u3Rc+kjnDOGBahu0Yx4QLg==
X-Google-Smtp-Source: AGHT+IHAJDw6t6f/1p5DCXhVNF5ZYBOAfpGF1Lzb87c+hYmXwYQhEflST5W0X8DLq3sBT2hMJLQQMPPBAaeVNc99U4k=
X-Received: by 2002:ac8:5bc6:0:b0:41e:2db3:a066 with SMTP id
 b6-20020ac85bc6000000b0041e2db3a066mr23182516qtb.45.1698945131763; Thu, 02
 Nov 2023 10:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com>
In-Reply-To: <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Nov 2023 13:11:34 -0400
Message-ID: <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Xu <weixugc@google.com>, Sourav Panda <souravpanda@google.com>,
        corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wei, noticed that all other fields in /proc/meminfo are part of
> > MemTotal, but this new field may be not (depending where struct pages
>
> I could have sworn that I pointed that out in a previous version and
> requested to document that special case in the patch description. :)

Sounds, good we will document that parts of per-page may not be part
of MemTotal.

> > are allocated), so what would be the best way to export page metadata
> > without redefining MemTotal? Keep the new field in /proc/meminfo but
> > be ok that it is not part of MemTotal or do two counters? If we do two
> > counters, we will still need to keep one that is a buddy allocator in
> > /proc/meminfo and the other one somewhere outside?
>
> IMHO, we should just leave MemTotal alone ("memory managed by the buddy
> that could actually mostly get freed up and reused -- although that's
> not completely true") and have a new counter that includes any system
> memory (MemSystem? but as we learned, as separate files), including most
> memblock allocations/reservations as well (metadata, early pagetables,
> initrd, kernel, ...).
>
> The you would actually know how much memory the system is using
> (exclusing things like crashmem, mem=, ...).
>
> That part is tricky, though -- I recall there are memblock reservations
> that are similar to the crashkernel -- which is why the current state is
> to account memory when it's handed to the buddy under MemTotal -- which
> is straight forward and simply.

It may be simplified if we define MemSystem as all the usable memory
provided by firmware to Linux kernel.
For BIOS it would be the "usable" ranges in the original e820 memory
list before it's been modified by the kernel based on the parameters.

For device-tree architectures, it would be the memory binding provided
by the original device tree from the firmware.

Pasha
