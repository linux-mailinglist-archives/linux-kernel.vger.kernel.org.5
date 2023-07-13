Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429F775214C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjGMMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjGMMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:32:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A856171D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HzjbEBiBfxFIYqWgScZMrkPWsocac35r5l3aCsEY5+U=; b=g1BCpxrXAj7Q9uPY/O2RKOoZKQ
        KozhtvUI5hgmArBtce4PuKfrYUfmhvNN+vrbky4PNKALDTeW6sf73zZzt+tr2CgT/MNBOqQcs3E33
        nU8FvIiCzQ30ms1KCYEd+T8JZPrdWK4kZ0FitnAwoZfUTz6P4fD/Pt6nZmYnCBHFRac8F84ZO1uv0
        Fe8SI1AcnHYiE0stZXk3hmx6vZwoI3SeViFu5o8q5prmz9oLavgbU8tssHE4Sv8LC8eMWjWl7cRbQ
        wO23E4h/2lV8fuKeBtaSWt+pCFFR02QoiOi30Ccmy7Yr8ohVUWDNXZT0Lm7qguDEGU1qa532VkwG5
        +069hkFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJvUA-0008V7-IL; Thu, 13 Jul 2023 12:31:54 +0000
Date:   Thu, 13 Jul 2023 13:31:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove some useless comments of node_stat_item
Message-ID: <ZK/uukqNMQYyyNif@casper.infradead.org>
References: <20230713114915.74671-1-linmiaohe@huawei.com>
 <ZK/ppvBO00rbspa8@casper.infradead.org>
 <55c255df-9c7c-744f-e1a1-27602fcb5509@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c255df-9c7c-744f-e1a1-27602fcb5509@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:18:29PM +0800, Miaohe Lin wrote:
> On 2023/7/13 20:10, Matthew Wilcox wrote:
> > On Thu, Jul 13, 2023 at 07:49:15PM +0800, Miaohe Lin wrote:
> >> Some comments of node_stat_item are not that helpful and even confusing,
> >> so remove them. No functional change intended.
> > 
> > No, that's very useful and important.  Why does it confuse you?
> 
> Thanks for your quick respond.
> 
> I just can't figure out what these comments want to tell. Could you help explain these?

Don't snip the thing you want explained to you!

        NR_INACTIVE_ANON = NR_LRU_BASE, /* must match order of LRU_[IN]ACTIVE */
-       NR_ACTIVE_ANON,         /*  "     "     "   "       "         */
-       NR_INACTIVE_FILE,       /*  "     "     "   "       "         */
-       NR_ACTIVE_FILE,         /*  "     "     "   "       "         */
-       NR_UNEVICTABLE,         /*  "     "     "   "       "         */
+	NR_ACTIVE_ANON,
+       NR_INACTIVE_FILE,
+       NR_ACTIVE_FILE,
+	NR_UNEVICTABLE,

What this is communicating to me is that these five items
(NR_INACTIVE_ANON to NR_UNEVICTABLE) must stay in the same order with
LRU_INACTIVE and LRU_ACTIVE.  By removing the ditto-marks from the
subsequent four lines, you've made the comment say that this one line
must stay in the same order as LRU_INACTIVE and LRU_ACTIVE ... which
makes no sense at all.
