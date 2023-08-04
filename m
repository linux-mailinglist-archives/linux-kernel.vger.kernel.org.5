Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC876FE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjHDKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHDKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:38:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C33046B2;
        Fri,  4 Aug 2023 03:38:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43E5E68AA6; Fri,  4 Aug 2023 12:38:06 +0200 (CEST)
Date:   Fri, 4 Aug 2023 12:38:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, lizetao1@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] romfs: only select BUFFER_HEAD for the block based path
Message-ID: <20230804103805.GA23794@lst.de>
References: <20230804102648.78683-1-hch@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804102648.78683-1-hch@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this should be:

From: Christoph Hellwig <hch@lst.de>

to match the signoff.  I managed to mess my mail setup, but it should
be fixed now.


On Fri, Aug 04, 2023 at 12:26:48PM +0200, Christoph Hellwig wrote:
> selecting BUFFER_HEAD unconditionally does not work as romfs can also
> be built with only the MTD backend and thus without CONFIG_BLOCK.
> 
> Fixes: 0f842210d97a ("fs/Kconfig: Fix compile error for romfs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/romfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/romfs/Kconfig b/fs/romfs/Kconfig
> index 3f6b550eee6192..f24a96a331af1b 100644
> --- a/fs/romfs/Kconfig
> +++ b/fs/romfs/Kconfig
> @@ -2,7 +2,6 @@
>  config ROMFS_FS
>  	tristate "ROM file system support"
>  	depends on BLOCK || MTD
> -	select BUFFER_HEAD
>  	help
>  	  This is a very small read-only file system mainly intended for
>  	  initial ram disks of installation disks, but it could be used for
> @@ -58,6 +57,7 @@ endchoice
>  config ROMFS_ON_BLOCK
>  	bool
>  	default y if ROMFS_BACKED_BY_BLOCK || ROMFS_BACKED_BY_BOTH
> +	select BUFFER_HEAD
>  
>  config ROMFS_ON_MTD
>  	bool
> -- 
> 2.39.2
---end quoted text---
