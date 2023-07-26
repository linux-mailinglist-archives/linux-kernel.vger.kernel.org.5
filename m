Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C151376306F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGZItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjGZItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:49:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC8722688
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:42:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD45A11FB;
        Wed, 26 Jul 2023 01:42:58 -0700 (PDT)
Received: from [10.57.77.6] (unknown [10.57.77.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 074E83F67D;
        Wed, 26 Jul 2023 01:42:12 -0700 (PDT)
Message-ID: <6978a045-c786-3dc2-d2e3-476b4933db96@arm.com>
Date:   Wed, 26 Jul 2023 09:42:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/4] variable-order, large folios for anonymous memory
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <83bb1b99-81d3-0f32-4bf2-032cb512a1a1@arm.com>
 <2FCD9E8A-D38A-40C4-9825-AE7ECEEFC715@nvidia.com>
 <34979a4c-0bab-fbb9-f8dd-ab3da816de52@arm.com>
 <CANW9uysFm4c+zsFMUdZ8_d30rS23tHh45GJBqxdtjUFcpSjOOw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANW9uysFm4c+zsFMUdZ8_d30rS23tHh45GJBqxdtjUFcpSjOOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 08:36, Itaru Kitayama wrote:
> Ryan,
> Do you have a kselfrest code for this new feature?
> I’d like to test it out on FVP when I have the chance.

A very timely question! I have modified the mm/cow tests to additionally test
large anon folios. That patch is part of v4, which I am about to start writing
the cover letter for. So look out for that in around an hour.
