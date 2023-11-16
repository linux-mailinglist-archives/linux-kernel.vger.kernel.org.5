Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D057EDA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbjKPEAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 23:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPEAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:00:13 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF3192;
        Wed, 15 Nov 2023 20:00:10 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 1BF32160B3E;
        Thu, 16 Nov 2023 04:00:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 028B46000A;
        Thu, 16 Nov 2023 04:00:00 +0000 (UTC)
Message-ID: <2d5db599144596bdc12533a366d5d2d8f375014e.camel@perches.com>
Subject: Re: [PATCH v3 01/10] iov_iter: Fix some checkpatch complaints in
 kunit tests
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Date:   Wed, 15 Nov 2023 20:00:00 -0800
In-Reply-To: <20231115154946.3933808-2-dhowells@redhat.com>
References: <20231115154946.3933808-1-dhowells@redhat.com>
         <20231115154946.3933808-2-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 351xofsuni5kanig7iiz4sjma1jzxkft
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 028B46000A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18a7JS4BL8h7HLIdDXMm2YCe3xiJn/hEoo=
X-HE-Tag: 1700107200-315216
X-HE-Meta: U2FsdGVkX18LEi6bPNImGq+TG8DpnNDiieNtyzLyawftOGFa1xnL3e2LfgJJyTLmLwogrMHbv17rz+M/8vJb8yVNQ1eCzPPOqKmiLWnXkWH0Z4A9nMD1IG6Np+PP3yRiu6HzLDt5vFNdyg6DurWOPJlIDfPWoBPm7Ey6IGQrJB9nzzek/4SHhy/NFXArWdJKtMpL5kSDR4003ihhuhR+s+TvBzrKMZcNgv7yMLgzT5KBcOkBLwkUfhN4pz6HD8ADTd57MGw8Q0+siSvVmwP7pkzt/Zvq1GRUig7ERppizdBVNRIz92TiEZDE+AHJ9Ti8
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-15 at 15:49 +0000, David Howells wrote:
> Fix some checkpatch complaints in the new iov_iter kunit tests:
> 
>  (1) Some lines had eight spaces instead of a tab at the start.
> 
>  (2) Checkpatch doesn't like (void*)(unsigned long)0xnnnnnULL, so switch to
>      using POISON_POINTER_DELTA plus an offset instead.

That's because checkpatch is fundamentally stupid and
that's a false positive.

> diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
[]
> @@ -548,7 +548,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
>  		size_t offset0 = LONG_MAX;
>  
>  		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
> -			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
> +			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;

I think the original is easier to understand
or would best be replaced by a single #define
without the addition.

> @@ -626,7 +626,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
>  		size_t offset0 = LONG_MAX;
>  
>  		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
> -			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
> +			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;

etc...

