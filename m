Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA47AD3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjIYI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjIYI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:58:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 399CC139;
        Mon, 25 Sep 2023 01:58:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30167DA7;
        Mon, 25 Sep 2023 01:58:46 -0700 (PDT)
Received: from [10.57.65.13] (unknown [10.57.65.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 649243F5A1;
        Mon, 25 Sep 2023 01:58:07 -0700 (PDT)
Message-ID: <a6513431-0a69-445e-9211-28a9dc9691d1@arm.com>
Date:   Mon, 25 Sep 2023 09:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-bys missing for commit in the mm-hotfixes
 tree
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230925075026.2a6b4e65@canb.auug.org.au>
 <20230924164201.863ad5e63a2d555f6d33254c@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230924164201.863ad5e63a2d555f6d33254c@linux-foundation.org>
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

On 25/09/2023 00:42, Andrew Morton wrote:
> On Mon, 25 Sep 2023 07:50:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Hi all,
>>
>> Commit
>>
>>   48248e468270 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
>>
>> is missing Signed-off-bys from its author and committer.
>>
>> It looks like the commit message has been truncated.
> 
> Ah, thanks.  The changelog has a stray ^---$:
> 
> : If CONFIG_DEBUG_VM is enabled, we do at least get a BUG(), but otherwise,
> : it will dereference a bad pointer in page_folio():
> : 
> :     static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
> :     {
> :         VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
> : 
> :         return page_folio(pfn_to_page(swp_offset_pfn(entry)));
> :     }
> : 
> : 
> : Fix
> 
> <chomp>
> 
> : ---
> : 
> : The simplest fix would have been to revert the dodgy cleanup commit
> : 18f3962953e4 ("mm: hugetlb: kill set_huge_swap_pte_at()"), but since
> : things have moved on, this would have required an audit of all the new
> : set_huge_pte_at() call sites to see if they should be converted to
> : set_huge_swap_pte_at().  As per the original intent of the change, it
> : would also leave us open to future bugs when people invariably get it
> : wrong and call the wrong helper.
> 
> That's actually from the [0/n] intro, which I pasted into the [1/n]
> changelog.
> 
> It gets through my scripts OK
> (https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-add-huge-page-size-param-to-set_huge_pte_at.patch),
> but it looks like git-quiltimport did the deed.
> 
> Let me add a check for that...

I don't think there is any action for me here? (except possibly, never use 3
dashes in a row on any future email correspondence). Shout if you need anything.

