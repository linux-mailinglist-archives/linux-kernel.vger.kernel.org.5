Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B654F7D45DB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjJXDSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:18:28 -0400
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [IPv6:2001:41d0:203:375::bf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF021BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:18:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698117505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jv5wXdaC3y/S8EnSqXGexSgMX0Jo/OO/p9IJYjDjWjI=;
        b=pb/4pTPTJob6cVNmJP/eiunXtJq5Nj5DXabg0FA+SZ0gGWycYhyNiaXuLeIh0yf97FmDjH
        Xtfe+JhVp+2N3C9rq1xwxHzYD83Fx4ULAFI81ZFrlSfuGfP6x8WWWJHaQDSzMK7ukhvm4/
        qqyf3b8qDHbLy6ZMi5pXfoSAt/UxikY=
Mime-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix reference to nonexistent file
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231022185619.919397-1-vegard.nossum@oracle.com>
Date:   Tue, 24 Oct 2023 11:17:43 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <3D383A26-5F91-43E7-8969-C2A3E380D2AA@linux.dev>
References: <20231022185619.919397-1-vegard.nossum@oracle.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2023, at 02:56, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> 
> The directory this file is in was renamed but the reference didn't
> get updated. Fix it.
> 
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Wu XiangCheng <bobwxc@email.cn>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

