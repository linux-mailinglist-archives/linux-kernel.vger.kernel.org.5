Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB3783835
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHVCx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjHVCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:53:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F7193
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jYGxiXul/OsHywEa/PwLHkLUEo7yxAHOM0d7Mx6a6jY=; b=ixevZgDmJOlmQfPhwXDUwRYThZ
        jdRd9BVHc/HefkIn/EFzXNWdCXvcu6bLpQsx0VolL6GaSda7Rf+TIzCFjH2HSPEOAhoNUiwcLHxQT
        AcYs5R8Mj2h7puPrrg8eBmYc2l1Y9dkrl2jjZwEQxJE0sNnUw2fqhalkflCKS4A6KWPLxTGsTVXy4
        smGkndNFnIP92/ngVWmdA13THo2Z2yjDLKO0R5GNrbSE66ODq3Y2BWwlPLq63LJK/P3GR+md2AdgI
        x774B6bFydtLVKdPznyPsE7v8b0I5SI03rVTDApDSCjGkY1QecwM1o+yfZBpy1N5bF5rpJssgGWpp
        dcA5FPnA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYHWh-00F0st-1L;
        Tue, 22 Aug 2023 02:53:51 +0000
Message-ID: <6ab538a1-45ce-5905-0ff3-c5990598e6ab@infradead.org>
Date:   Mon, 21 Aug 2023 19:53:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next] freevxfs: Fix comment on vxfs_readdir
Content-Language: en-US
To:     GUO Zihua <guozihua@huawei.com>, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20230822014010.26817-1-guozihua@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822014010.26817-1-guozihua@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 18:40, GUO Zihua wrote:
> As vxfs_readdir now switches to iterate_shared interface, the parameter
> of the function is changed. However, the comment of has not been
> updated.
> 
> This patch updates function doc to reflect this change.
> 
> Fixes: 9b5d5a170781 ("[readdir] convert freevxfs")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/freevxfs/vxfs_lookup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
> index f04ba2ed1e1a..53cbb7209324 100644
> --- a/fs/freevxfs/vxfs_lookup.c
> +++ b/fs/freevxfs/vxfs_lookup.c
> @@ -177,12 +177,11 @@ vxfs_lookup(struct inode *dip, struct dentry *dp, unsigned int flags)
>  /**
>   * vxfs_readdir - read a directory
>   * @fp:		the directory to read
> - * @retp:	return buffer
> - * @filler:	filldir callback
> + * @ctx:	Dir context
>   *
>   * Description:
> - *   vxfs_readdir fills @retp with directory entries from @fp
> - *   using the VFS supplied callback @filler.
> + *   vxfs_readdir emits directory entries from @fp using the
> + *   VFS supplied @ctx.
>   *
>   * Returns:
>   *   Zero.

-- 
~Randy
