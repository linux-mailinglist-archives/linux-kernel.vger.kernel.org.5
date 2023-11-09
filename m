Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF57E6C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjKIOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:12:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CD72D73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8gAs0BtsM8utUDlNE+Hxk/kuj0OGhH5k7BA44pz9JDg=; b=EIZ8VK/OxomSYDgAtwf/qnI5hY
        rX8FJgL/tuHwHWyeI5NHG/PkSBCQdULKd2gqeBqcl2K+rCk5TgLIHb4sGyIC60knmdLLWcFJZuTWI
        4PNcSnyUOfTYN8Lu6K1GyEm0DGd7HDOWLvq5pxKMxkrziw8PW7hetkiyoJMkTR6E86M3klIVCYP+M
        7Dj65vaByr9FKMy/xw8YXTgZLIIkxoIU1ANGZLt/DAsDBG+a5xbp57bgYvIdqqDmtUA3h2tLnuKTx
        ygk1buGY/Vk7dhe5NtZXL8rcBM51n75Ww5jkZSq+xqYoWfj3RPTTDwJpTo68jrp/llQLvp1HU33Yz
        737p6LgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r15l0-00EUCj-0s;
        Thu, 09 Nov 2023 14:11:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8629300454; Thu,  9 Nov 2023 15:11:41 +0100 (CET)
Date:   Thu, 9 Nov 2023 15:11:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        fengwei.yin@intel.com, vbabka@suse.cz, mgorman@suse.de,
        mingo@redhat.com, riel@redhat.com, ying.huang@intel.com,
        hannes@cmpxchg.org, Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Message-ID: <20231109141141.GC8683@noisy.programming.kicks-ass.net>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
> Is there any way to avoid such a major fault?

man madvise
