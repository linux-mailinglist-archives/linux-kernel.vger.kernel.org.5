Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9787849F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjHVTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHVTH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:07:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC7137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:07:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee2ba9d09so20025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692731273; x=1693336073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRiBUzL8spKRB1tclE82+u46hrJ1Ih197R4YOzksonI=;
        b=lMsfT5hx0tLwk2rlaqeI5mSDZwJSP9BkWsHVQo71FW7LKCx8tvIRUuniCr8vZv1pTR
         vHXATpyKDAkjxKMb1fyNJgYHuXcgcu9oOrQKPMNm0gcohAfiJDoljNpdWErX6OXwP7ej
         G7rBd82bGdsJXmkhDSUA3nzA0wFkZdDtJzDwG2zKxBoKE4/A0ZNv+HXMbPQZ123shwex
         vbVcb4kpmwEZjv5e1tWPjpsTmGx+uws9r7k9zU20nwgQ+E8c6cH7kT7S1aNh6M5PYMlW
         r0ofN2tuS06QEliLcqsX/YwzKyqMfhqNwpGphR1Pyffwu6qvQ73IRtR+h+DudVZkggBA
         r3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731273; x=1693336073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRiBUzL8spKRB1tclE82+u46hrJ1Ih197R4YOzksonI=;
        b=Z344nRX1V6K+hUrM9X1jRdelOdzKayu3JXWAILuD1aRgDWjMo05UjfLQklUEOIDvmV
         bKzdFxTe1cMxW1aq7V7JZkIuHkRMQRWamOSQSv2doxLKVSbdvJFV8IIExbFufj4CbiaF
         RsiAVJ4hl6L/48gvPStatzUgdTKck7pgEWuLX0P4p+evDl5p+Im0rU6DCTyVq3uNBC6+
         DCBzyoVzWMuXBNrVwBtYiYZohFqfsL+e0Iyk4Ql+yeoqdAZztG1QZC6MQrLY0P5v4e98
         xfjAjVp49mUuiu/yYzAh2q1PkNnhw5idy9HgW0zbBMOAjY97WeNsJKwzz+Z679EOk/Qj
         JwWw==
X-Gm-Message-State: AOJu0YyVKFhU0EcqLwBrxwAZFcGyta1GrZNRX8OfIzczLBwM8fG61Ctv
        a5e+s7xtIn1zwR+wWgnyl7yuC9GDI2a9iq8a3pCh8Q==
X-Google-Smtp-Source: AGHT+IGfBnrr77bQYEkOr6KDUL9/HGHICAg72c/uYHb0YNbCMBrO15aEsh2D/Hbolo0yCEKJUgZU8+XffH3Fzjw2Mp0=
X-Received: by 2002:a7b:c4d9:0:b0:3f4:fb7:48d4 with SMTP id
 g25-20020a7bc4d9000000b003f40fb748d4mr129596wmk.3.1692731272816; Tue, 22 Aug
 2023 12:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com> <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
 <82d294-c9b0-d7b4-71c9-cfed3925c47b@google.com>
In-Reply-To: <82d294-c9b0-d7b4-71c9-cfed3925c47b@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Aug 2023 21:07:15 +0200
Message-ID: <CAG48ez0dwYCxMv+e9-Y9XcQjZsXNqjdzhu31k84KoowD9rL+RQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:54=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
> But rather than reworking it, please let's just go with v1 for now.

Sounds good to me.
