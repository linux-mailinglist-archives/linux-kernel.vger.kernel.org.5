Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B1788C44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjHYPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjHYPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73486212A;
        Fri, 25 Aug 2023 08:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B78655D3;
        Fri, 25 Aug 2023 15:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC8EC433C8;
        Fri, 25 Aug 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692976502;
        bh=6DMQCZbZ+UizhzDWoKS3qOjSB+JIh/P9g7AHQPjx3zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6ZooxvDWg9sQQq89Kv+P1kZPnVCYjeoLUDGi0I7c+4R/vEVKhGvwZPqKb+ie3GDW
         gnQ/ugkoNkke68/VTkdtbIP23bLHxBvuUZoYtgGpm4GcGlKJbH242oyPQ+qFHSHeFy
         Yc2xIhav0xIA97T4GJM/F5ooVx+H+bddxw7zSPqKPrBTjsKrQBRv1IJCzRAXnqrCRu
         BXQDa7HtshBHNanVMTtzzycO1YNcucTcZeApaSfn2eDTRbnf73y5K0d/qvWlSteV19
         vV5LjZmvi14B2P1fjGITNC9+POBcKqFa2eIEiNdO7fcv0GSg0ho8lSgKy4UCzFGx1D
         vIFxzUaACY3lQ==
Date:   Fri, 25 Aug 2023 08:15:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs: fix select in config XFS_ONLINE_SCRUB_STATS
Message-ID: <20230825151501.GJ17912@frogsfrogsfrogs>
References: <20230825120513.29235-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825120513.29235-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:05:13PM +0200, Lukas Bulwahn wrote:
> Commit d7a74cad8f45 ("xfs: track usage statistics of online fsck")
> introduces config XFS_ONLINE_SCRUB_STATS, which selects the non-existing
> config FS_DEBUG. It is probably intended to select the existing config
> XFS_DEBUG.
> 
> Fix the select in config XFS_ONLINE_SCRUB_STATS.
> 
> Fixes: d7a74cad8f45 ("xfs: track usage statistics of online fsck")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Oops.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

> ---
> Darrick, please pick this quick 'typo' fix.

  ^^^^ isn't the maintainer anymore. ;)

--D

> v2: removed a stupid last-minute insert on my Signed-off-by line.
> 
>  fs/xfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> index c9d653168ad0..ed0bc8cbc703 100644
> --- a/fs/xfs/Kconfig
> +++ b/fs/xfs/Kconfig
> @@ -147,7 +147,7 @@ config XFS_ONLINE_SCRUB_STATS
>  	bool "XFS online metadata check usage data collection"
>  	default y
>  	depends on XFS_ONLINE_SCRUB
> -	select FS_DEBUG
> +	select XFS_DEBUG
>  	help
>  	  If you say Y here, the kernel will gather usage data about
>  	  the online metadata check subsystem.  This includes the number
> -- 
> 2.17.1
> 
