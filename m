Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922E78ECE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjHaMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbjHaMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44DCFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AAQZT6NKxzau1CUdnFj23oTMysnJNnnlYeofFG/iiGw=; b=XOXt4ShcRnJtTsuqMfQslsY4xM
        DD0DvT1wwTghea7KvXwHizLVhW6C3NswNalIvHtHFd0+3SP8stTwj2w80cg9xbi743zPgXiPywLoi
        k50iF0ytirfP3BRCdRkbqaucjvpUxp7Sp7KRS+jz2UpkfGA+3c4ZqWGRso457TtVoPIMlOZfZ0D2P
        SUVdbpOt5ItQA+IyFXzAEw6mtpOagkYESGQjKRiV0ns8AN/+RjWmISqvfphyFfnKMKXJrbDtNpFsw
        NIdOq0KU70pAj7BVSyb7qBqc9M2y7SXpeSHzB5MTl0MOZwKJjFkqXm92zPhUcaZbS8xWs9Lkn5BKc
        +/vt0ThA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbgao-001Eod-Bf; Thu, 31 Aug 2023 12:16:10 +0000
Date:   Thu, 31 Aug 2023 13:16:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Message-ID: <ZPCEim0AZG5hTSYH@casper.infradead.org>
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:52:52PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> There is no explicit gfp flags to let the allocation skip zero
> operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. I would like to make
> __GFP_SKIP_ZERO be visible even if kasan is not configured.

This bypasses a security feature so you're going to have to do a little
better than "I want it".

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/gfp_types.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>  mode change 100644 => 100755 include/linux/gfp_types.h

What is this garbage?  Header files should not be executable.
