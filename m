Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087217FE833
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjK3EPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjK3EPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:15:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65681A5;
        Wed, 29 Nov 2023 20:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ciUUDyS6UwVOmfcKRVNErpTKeITmISSd1ZTQAam+P4Y=; b=VcdQj8LE7sb+q+PxGpYs9UlZRY
        a11xy9N2IbqlspcfzGHIiVFK/PaZJsXVyWbxIVBfys+cXQEQ8O1aJenrL9CtmvAePK8G6EeZTCB1Y
        Z2dC+VRv1L1/V+r07n3UsLYmmASvKt63s43YZUxJvikd8jCF7cFhh7NZHsgLuKNZ+Raanf1J6xeOj
        lyEbROpRKnQzlvrKQk9Wye65azyjyn1CLFtzJdXEGqm8Qj/qezo+e/Vi3vNkbtDCsnnPgu8aC0a5D
        iVO9rMulaBKZkyj/biE9tU3PMBrCqf880ZWL1NcOXPFQQbn3cyTsSrzIoAmNf2JWjB6Pa/t2IJRTJ
        myxQHmXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8YSQ-00E4dE-37; Thu, 30 Nov 2023 04:15:22 +0000
Date:   Thu, 30 Nov 2023 04:15:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, tony.luck@intel.com, jiaqiyan@google.com,
        pcc@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] highmem: fix a memory copy problem in memcpy_from_folio
Message-ID: <ZWgMWricKKnwhWPh@casper.infradead.org>
References: <20231130034017.1210429-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130034017.1210429-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:40:18AM +0800, Su Hui wrote:
> Clang static checker complains that value stored to 'from' is never read.
> And memcpy_from_folio() only copy the last chunk memory from folio to
> destination.
> Using 'to += chunk' to replace 'from += chunk' to fix this typo problem.
> 
> Fixes: b23d03ef7af5 ("highmem: add memcpy_to_folio() and memcpy_from_folio()")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
