Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BED76CB2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjHBKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjHBKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008944B1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9600F618FE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB2C433C8;
        Wed,  2 Aug 2023 10:41:45 +0000 (UTC)
Date:   Wed, 2 Aug 2023 11:41:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com
Subject: Re: [PATCH v4] arm64: hugetlb: enable
 __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
Message-ID: <ZMoy56mk20mP972A@arm.com>
References: <20230801135616.165067-1-wangkefeng.wang@huawei.com>
 <20230802012731.62512-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802012731.62512-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:27:31AM +0800, Kefeng Wang wrote:
> It is better to use huge page size instead of PAGE_SIZE
> for stride when flush hugepage, which reduces the loop
> in __flush_tlb_range().
> 
> Let's support arch's flush_hugetlb_tlb_range(), which is
> used in hugetlb_unshare_all_pmds(), move_hugetlb_page_tables()
> and hugetlb_change_protection() for now.
> 
> Note, for hugepages based on contiguous bit, it has to be
> invalidated individually since the contiguous PTE bit is
> just a hint, the hardware may or may not take it into account.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
