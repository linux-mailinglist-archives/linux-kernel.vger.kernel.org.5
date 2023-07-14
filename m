Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69E754252
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjGNSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjGNSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:11:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E06A41980
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:10:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B931576;
        Fri, 14 Jul 2023 11:01:57 -0700 (PDT)
Received: from [10.57.76.27] (unknown [10.57.76.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656823F67D;
        Fri, 14 Jul 2023 11:01:13 -0700 (PDT)
Message-ID: <496d82e3-6a84-3a97-8865-1fdd8f41b867@arm.com>
Date:   Fri, 14 Jul 2023 19:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/4] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-1-ryan.roberts@arm.com>
 <CAOUHufZdMjXP6vu1q+pXT8o5uhu5O0w_Fm5ccDvv2dzMiQv_=g@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZdMjXP6vu1q+pXT8o5uhu5O0w_Fm5ccDvv2dzMiQv_=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 17:52, Yu Zhao wrote:
> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> In preparation for FLEXIBLE_THP support, improve
>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>> passed to it. In this case, all contained pages are accounted using the
>> order-0 folio (or base page) scheme.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> 
> This patch doesn't depend on the rest of the series and therefore can
> be merged separately in case the rest needs more discussion.
> 
> Ryan, please feel free to post other code paths (those from v1) you've
> optimized for large anon folios at any time, since each code path can
> be reviewed and merged individually as well.

Will do. Hoping to get the "batch zap" series out on Monday. Others need a bit
more time to bake as they will need to be aligned to the changes from the review
of this series first.
