Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD878458F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjHVPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjHVPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:31:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC74CDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:30:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fef56e85edso83675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692718257; x=1693323057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7rvpiaBmdaWESCzJVCBdhucf56RoNv7C/zYiNdqugw=;
        b=1wJYwF/XUeBhFNuVLT9M6HxNx22zvWEOGkabOBprp3VPK7ecH6H8+WQb+PZ7C/NCpt
         Ck5ii8Mz711rRiDKPqlGnX/A/fC8hzKhoGaSLeXlK9RiTR3yPUlaVATQ4tR1Evqow1XZ
         6truoiONXUoJXKQRJm1T7EVAuC/tr7RAC8LolwaT4w6uct3C9G/LHCao8Kvcj06I7f8u
         eDaGKuBZhqGT8KibcEIVeVLhn5DZX6+OupQi/a1pu/hNrXF5HQ/UOn6EFCRqpqY64qup
         zJqW1TqWuAN5jMj9xCzbC8AwDj59mQbkBi01tS5+mEMcOpKjVh+FpJ1T1dOf9nzgWhxh
         QEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718257; x=1693323057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7rvpiaBmdaWESCzJVCBdhucf56RoNv7C/zYiNdqugw=;
        b=HY+UK42P3zF4KrksXczOhRYhudUnnD3kRaY6S0wv2WPl9LvIhcH+UbjepPqpzNRt7O
         ERcgA/g/GtRyh05ygUDFQ1BqK7sejfYYHfwNFQRkLvxaHclAXjyWtJ51rH08uklwl4Zf
         gV8Tw28k8mTO/XmYFpuaIhuLn5MBPbzWDcesPU3C6sXCOTTM6hzVvnbdShYqMc+rbUkJ
         Pjk2bQVQl0wQ88gYOJY2ULvr0nOW8+F5ehMcsm//E03o+S+usHU/VU8bkg3mvicxx38x
         RwNQ2zq/q5VFEfIiJv5rwrN0bBRR4DSElrxN8toxNCCOncXYPVTLG6xNCYci50HeUU9X
         6xnA==
X-Gm-Message-State: AOJu0YxzuuOFbWZyEZmM0jNicC5j3Jxux1FgGo7Wg/yJOmcs1QiBsbmK
        wTvRuBncVPhRTt00082wzpSE8sHP6xCSLacQPa0NJw==
X-Google-Smtp-Source: AGHT+IFyMgkMgYPE+lsjqN8nfI8yOuu8gDBvx8ZWd4M7BOWwoDnsNIcZ50kelsgmgyRcsCUSHPMH6DyCCbSZ5fwKiiA=
X-Received: by 2002:a05:600c:1716:b0:3fe:5228:b7a2 with SMTP id
 c22-20020a05600c171600b003fe5228b7a2mr96047wmn.5.1692718256744; Tue, 22 Aug
 2023 08:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com> <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
 <ZOTSyv6fuC1pkt76@casper.infradead.org>
In-Reply-To: <ZOTSyv6fuC1pkt76@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Aug 2023 17:30:19 +0200
Message-ID: <CAG48ez2NrQjB5T5++uJSZ8-id5-H2mbSRX8c36gAJ5p_BMHOFw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Tue, Aug 22, 2023 at 5:23=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Tue, Aug 22, 2023 at 04:39:43PM +0200, Jann Horn wrote:
> > > Perhaps something else will want that same behaviour in future (it's
> > > tempting, but difficult to guarantee correctness); for now, it is jus=
t
> > > userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
> > > expecting uffd to add more such exceptional modes in future).
> >
> > Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
> > wanted to make it possible to reliably install PTE markers with
> > madvise() or something like that, which might be nice for allowing
> > userspace to create guard pages without unnecessary extra VMAs...)
>
> I don't know what a userspace API for this would look like, but I have
> a dream of creating guard VMAs which only live in the maple tree and
> don't require the allocation of a struct VMA.  Use some magic reserved
> pointer value like XA_ZERO_ENTRY to represent them ... seems more
> robust than putting a PTE marker in the page tables?

Chrome currently uses a lot of VMAs for its heap, which I think are
basically alternating PROT_NONE and PROT_READ|PROT_WRITE anonymous
VMAs. Like this:

[...]
3a10002cf000-3a10002d0000 ---p 00000000 00:00 0
3a10002d0000-3a10002e6000 rw-p 00000000 00:00 0
3a10002e6000-3a10002e8000 ---p 00000000 00:00 0
3a10002e8000-3a10002f2000 rw-p 00000000 00:00 0
3a10002f2000-3a10002f4000 ---p 00000000 00:00 0
3a10002f4000-3a10002fb000 rw-p 00000000 00:00 0
3a10002fb000-3a10002fc000 ---p 00000000 00:00 0
3a10002fc000-3a1000303000 rw-p 00000000 00:00 0
3a1000303000-3a1000304000 ---p 00000000 00:00 0
3a1000304000-3a100031b000 rw-p 00000000 00:00 0
3a100031b000-3a100031c000 ---p 00000000 00:00 0
3a100031c000-3a1000326000 rw-p 00000000 00:00 0
3a1000326000-3a1000328000 ---p 00000000 00:00 0
3a1000328000-3a100033a000 rw-p 00000000 00:00 0
3a100033a000-3a100033c000 ---p 00000000 00:00 0
3a100033c000-3a100038b000 rw-p 00000000 00:00 0
3a100038b000-3a100038c000 ---p 00000000 00:00 0
3a100038c000-3a100039b000 rw-p 00000000 00:00 0
3a100039b000-3a100039c000 ---p 00000000 00:00 0
3a100039c000-3a10003af000 rw-p 00000000 00:00 0
3a10003af000-3a10003b0000 ---p 00000000 00:00 0
3a10003b0000-3a10003e8000 rw-p 00000000 00:00 0
3a10003e8000-3a1000401000 ---p 00000000 00:00 0
3a1000401000-3a1000402000 rw-p 00000000 00:00 0
3a1000402000-3a100040c000 ---p 00000000 00:00 0
3a100040c000-3a100046f000 rw-p 00000000 00:00 0
3a100046f000-3a1000470000 ---p 00000000 00:00 0
3a1000470000-3a100047a000 rw-p 00000000 00:00 0
3a100047a000-3a100047c000 ---p 00000000 00:00 0
3a100047c000-3a1000492000 rw-p 00000000 00:00 0
3a1000492000-3a1000494000 ---p 00000000 00:00 0
3a1000494000-3a10004a2000 rw-p 00000000 00:00 0
3a10004a2000-3a10004a4000 ---p 00000000 00:00 0
3a10004a4000-3a10004b6000 rw-p 00000000 00:00 0
3a10004b6000-3a10004b8000 ---p 00000000 00:00 0
3a10004b8000-3a10004ea000 rw-p 00000000 00:00 0
3a10004ea000-3a10004ec000 ---p 00000000 00:00 0
3a10004ec000-3a10005f4000 rw-p 00000000 00:00 0
3a10005f4000-3a1000601000 ---p 00000000 00:00 0
3a1000601000-3a1000602000 rw-p 00000000 00:00 0
3a1000602000-3a1000604000 ---p 00000000 00:00 0
3a1000604000-3a100062b000 rw-p 00000000 00:00 0
3a100062b000-3a1000801000 ---p 00000000 00:00 0
[...]

I was thinking if you used PTE markers as guards, you could maybe turn
all that into more or less a single VMA?
