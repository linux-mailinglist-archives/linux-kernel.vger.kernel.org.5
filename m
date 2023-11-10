Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C877E8217
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjKJS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjKJS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:57:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C6BA7514
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AYzXs18KczHZZgfg88rn8pPaVIFEs8IAZXIRxaB4Caw=; b=eHOalM+l0ZQToM45Svil6GXFwt
        w+IMyi49T45a4BoKquvpt7Mu94nLpmGGhGXZf8GpqlSC1wWPsy/CzKUZ10R/fxxW5QmJT8ukHZ7L0
        B4jk5h8yfHRbjUOFsEatlzwWVoN335hKdKKC+0B98J84/CKP/LT3JHw4W5eVXK/DjYM00lGVQ4VRL
        zhGVNalB6eKGVI6na+OL1TINTSN4N5Rr45O7M/wdAo1tOcRAuNJIOXpc5wB8a+i83pBBBCDPuBv32
        aEyRo2L24noyOb89ECBHxtBNmqbqxqZPU2ahYl68Xc+hrTfzXe/HUv8qV4PgzpBgnJxURivQZl2xC
        q1RBVs6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1W6v-00EtIL-Bx; Fri, 10 Nov 2023 18:20:05 +0000
Date:   Fri, 10 Nov 2023 18:20:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2 4/7] mm: huge_memory: use more folio api in
 __split_huge_page_tail()
Message-ID: <ZU50VbssgjiLC3Iu@casper.infradead.org>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:21AM +0800, Kefeng Wang wrote:
> Use more folio APIs to save six compound_head() calls in
> __split_huge_page_tail().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
