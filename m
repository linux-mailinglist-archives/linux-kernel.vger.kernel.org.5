Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039547780CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjHJSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjHJSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:54:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05EE926B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:54:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219BED75;
        Thu, 10 Aug 2023 11:55:06 -0700 (PDT)
Received: from [192.168.0.23] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A153F6C4;
        Thu, 10 Aug 2023 11:54:21 -0700 (PDT)
Message-ID: <4f4d0cc0-6e56-4608-bed0-4bad3adc3c7b@arm.com>
Date:   Thu, 10 Aug 2023 19:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] mm/mmu_gather: Remove encoded_page infrastructure
Content-Language: en-GB
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-4-ryan.roberts@arm.com>
 <CAOUHufZatMprwzaT+=Lb6jSw60DN_Br=Og+N6krK3OQZiGyAYA@mail.gmail.com>
 <CAHk-=wiPp3DquE4A4FaWjgmS4wx7BT4MEFj5AOQie=tnK1N6yg@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHk-=wiPp3DquE4A4FaWjgmS4wx7BT4MEFj5AOQie=tnK1N6yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 19:31, Linus Torvalds wrote:
> On Thu, 10 Aug 2023 at 10:35, Yu Zhao <yuzhao@google.com> wrote:
>>
>> Adding the original author and reviewers... They might want (need) to
>> take a look at this series.
> 
> It looks fine to me. The important part is that the rmap removal has
> to be done after the TLB flush, but before the page table lock is
> released.

Yes, we still abide by this rule for the !PageAnon(page) pages.

> 
> That used to be a special thing for anonymous pages and thus needed
> that special flag. But if it's done for *all* pages the need to flag
> pages goes away.

I think you misstyped - assuming you meant pagecache pages rather than anonymous
pages?

> 
> I see no issues with this, although obviously I might have missed something.

Thanks for looking so quickly - really appreciate it. And sorry not to have
included you initially.

Thanks,
Ryan

> 
>                 Linus

