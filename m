Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DADE769BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjGaQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjGaQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:04:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DAE5D;
        Mon, 31 Jul 2023 09:03:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C174E2B0;
        Mon, 31 Jul 2023 16:03:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C174E2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690819423; bh=t76V9ls2c8xjoyYF1+jcwVKxcijch8MBGbQhBn9hxGw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Drrxwcs9FW/rnfjzA2yYZS/QeTp9EeVUwtl1BDfo5uoEujoZJwIr+021ktZGUFEby
         AkxPt3Mh2L3jP5yS3rJh79rTd5BK2NkUJ3EdtePWQ6i9UkquULjhSMFZjz99Y4LzB8
         8s4kZH8gZOhAMJwGvEgmAK7kK37ujBxfpqN+IRURceR6q5JPv94l045bK884PKo2U+
         TOmeeWa3cZ3zoCUHrKKyz3e43kTI3dVMPP/xhG4OXbxG4McKzjRG5tqHTK5bCbzyi5
         0RUAuUju49NSgqhZhaOPKzGtTAMs10UYh57oeahbpr3Tcmj7Jj5ewAYB5Xn2L9mC5e
         Cj3qjeoIjLUeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>,
        Usama Arif <usama.arif@bytedance.com>
Cc:     songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com
Subject: Re: [External] Re: [PATCH] docs: mm: Fix number of base pages for
 1GB HugeTLB
In-Reply-To: <ZL9msij+DaXiDHbq@kernel.org>
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
 <Y+NwkCsDnOBSCqVu@kernel.org>
 <463c960e-1d3b-edc0-edbb-d5ecbf7fc3b1@bytedance.com>
 <ZL9msij+DaXiDHbq@kernel.org>
Date:   Mon, 31 Jul 2023 10:03:42 -0600
Message-ID: <87bkfsdq5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> (adding Jon)
>
> On Mon, Jul 24, 2023 at 03:05:29PM +0100, Usama Arif wrote:
>> 
>> 
>> On 08/02/2023 09:51, Mike Rapoport wrote:
>> > On Tue, Feb 07, 2023 at 11:44:56AM +0000, Usama Arif wrote:
>> > > 1GB HugeTLB page consists of 262144 base pages.
>> > > 
>> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> > 
>> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>> > 
>> > > ---
>> > >   Documentation/mm/vmemmap_dedup.rst | 3 ++-
>> > >   1 file changed, 2 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
>> > > index a4b12ff906c4..689a6907c70b 100644
>> > > --- a/Documentation/mm/vmemmap_dedup.rst
>> > > +++ b/Documentation/mm/vmemmap_dedup.rst
>> > > @@ -1,3 +1,4 @@
>> > > +
>> > >   .. SPDX-License-Identifier: GPL-2.0
>> > >   =========================================
>> > > @@ -17,7 +18,7 @@ HugeTLB pages consist of multiple base page size pages and is supported by many
>> > >   architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
>> > >   details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
>> > >   currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
>> > > -consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
>> > > +consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
>> > >   For each base page, there is a corresponding ``struct page``.
>> > >   Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
>> > > -- 
>> > > 2.25.1
>> > > 
>> > 
>> 
>> Hi,
>> 
>> Was just reading vmemmap_dedup.rst for something and realized that its still
>> 4096 pages for 1G, maybe this patch got missed?

Dug out of the archives and applied, thanks.

jon
