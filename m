Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059E77CF69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjHOPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbjHOPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:42:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7D10C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:41:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58c531d9a4aso16834827b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692114118; x=1692718918;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TsLh4UpmerFxSf2LHp//sOCj39QtIaP8NhFu7Ity0=;
        b=v/t1rSu7IOqD7zsEvHxRPZ8PsCIFzAnrAyhA1GeAnqzR3gqcLYYTCisHr6LsT22vfP
         4laXof+eVPcmpLgSaUurUglySIUk5wTKrOXJIVrfFuzCfybCzb0/0AVfQMVJ0iJIRG4H
         0geKl/MMV99hPY+b1UkztXinVcOvwL2sVflQuURKZUXygILqXy0hylwT5O5AGgmvPpyb
         srYr1if/5tuZjeqAnbfWF3gwfEMlVFJI+jpZVbFzcg3JYBWEdRGg/oIVxBn0/AdWjomv
         dLXCkhljXHfLN7Qp8CgGrb1wPb2fkkHuSPRQ+VOFXR8Uhg34HjYmVoNDAYs3GRvk+rOp
         M2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114118; x=1692718918;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TsLh4UpmerFxSf2LHp//sOCj39QtIaP8NhFu7Ity0=;
        b=iRRDK2KB4X89WxNT+YOSXC4kaOVe3hn1bycIFlOBEc/9W7q5gbpcJ+iKnqEl2bmOwq
         +nQwzDqcYxSiPlERDyQRMivcRiLr4pTlOp6mqNe0mvkTv+dSRSfWS7t2Pc+F/PhFzNYt
         f3+9innZrn74N48l9HYqdPjSL7xcGLYWKHj67aa9++JqwESldZ5NH/rwYZ8ey/EDEo8m
         K5DfTooXmqitECTe4sApEttuejro7AsfhskzBM6OdgKPARIQyJzb/FsxNfBLBLayJZlu
         aS5eVLL4WuyOZnfoCxZcqCjo9HsCo0SbWsIl5Io63+Ycewo9tojeJekFjYMypLmcfAfR
         MAwQ==
X-Gm-Message-State: AOJu0YzqCsBDokvLAeQHlftlD7NPbmaZnqNCmM7U6XzlPnSORZVIsEOE
        Nx2a54VSq83UjegGdpkaEv71mQ==
X-Google-Smtp-Source: AGHT+IFym1gqMNFckrS6y/rCULvNhW2b/lORvGgm0DCRSg/pwTXV+un25GqW0LvhUjQm8jbcdgknTw==
X-Received: by 2002:a0d:cc92:0:b0:589:a4c7:ee40 with SMTP id o140-20020a0dcc92000000b00589a4c7ee40mr2727997ywd.2.1692114117698;
        Tue, 15 Aug 2023 08:41:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x206-20020a814ad7000000b005707fb5110bsm3475226ywa.58.2023.08.15.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:41:57 -0700 (PDT)
Date:   Tue, 15 Aug 2023 08:41:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp()
 with mmap_read_lock()
In-Reply-To: <76e6b2ad-4e1e-2ad3-95df-00b4d33ec9d2@redhat.com>
Message-ID: <35d52c74-9ba9-211e-a4f-ade6ed318e76@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com> <cacd4a19-386d-8bea-400-e99778dbc3b@google.com>
 <76e6b2ad-4e1e-2ad3-95df-00b4d33ec9d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 15 Aug 2023, David Hildenbrand wrote:
> On 15.08.23 08:34, Hugh Dickins wrote:
> > On Mon, 14 Aug 2023, Jann Horn wrote:
> >>
> >>          /* step 4: remove page table */
> >> +       if (strcmp(current->comm, "DELAYME") == 0) {
> >> +               pr_warn("%s: BEGIN DELAY INJECTION\n", __func__);
> >> +               mdelay(5000);
> >> +               pr_warn("%s: END DELAY INJECTION\n", __func__);
> >> +       }
> >>
> >>          /* Huge page lock is still held, so page table must remain empty
> >>          */
> >>          pml = pmd_lock(mm, pmd);
> >>
> >>
> >> And then run the attached reproducer against mm/mm-everything. You
> >> should get this in dmesg:
> >>
> >> [  206.578096] BUG: Bad rss-counter state mm:000000000942ebea
> >> type:MM_ANONPAGES val:1
> > 
> > Thanks a lot, Jann. I haven't thought about it at all yet; and just
> > tried to reproduce, but haven't yet got the "BUG: Bad rss-counter":
> > just see "Invalid argument" on the UFFDIO_COPY ioctl.
> > Will investigate tomorrow.
> 
> Maybe you're missing a fixup:
> 
> https://lkml.kernel.org/r/20230810192128.1855570-1-axelrasmussen@google.com
> 
> When the src address is not page aligned, UFFDIO_COPY in mm-unstable would
> erroneously fail.

You got it, many thanks David: I had assumed that my next-20230808 tree
would be up-to-date enough, but it wasn't.  Reproduced now.

Hugh 
