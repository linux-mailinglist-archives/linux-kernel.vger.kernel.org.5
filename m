Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF77874FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbjHXQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbjHXQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:13:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC319A8;
        Thu, 24 Aug 2023 09:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8897964542;
        Thu, 24 Aug 2023 16:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E373DC433C8;
        Thu, 24 Aug 2023 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692893596;
        bh=Zr8yoYZ5kihDdLp+868G9i8fRwxltBN0FF3XX0SbLNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrHSDo/Yp7h9YBbWhHUhSQoipiYPzQsU4vpjeOxAG5gu1nqZGpqEOr5ZF9AJoMLgF
         wr8cbu+L/pmqwlHC105B1lnI6pfJRBzCbFrvwfK5LxPvcm51Y+VTblpamuK5J0kcoj
         yPtxyjU1w2Bo7uKqgI7+JD6Elnwx2esvODm+nUQSSKLofqW9o6cSXZQr2NTmKqfhfR
         7WtKapBiiWHTkjNwiPeby/emxrMjJj8SWo27ymzo02VPSLCtg4XDN84cX0E1vEMf0Z
         KXu+RaSTY5LKA/y2Tk7fvoxDt0e/ydRZbxG8DLrFFsFy9u2+dMBddNdf9zzHrMDuX0
         dFXxyHbRJBi4w==
Date:   Thu, 24 Aug 2023 09:13:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove duplicate include
Message-ID: <20230824161315.GN11263@frogsfrogsfrogs>
References: <20230824074723.57244-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824074723.57244-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:47:23PM +0800, Jiapeng Chong wrote:
> ./fs/xfs/scrub/xfile.c: xfs_format.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6209
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/xfile.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index d98e8e77c684..090c3ead43fd 100644
> --- a/fs/xfs/scrub/xfile.c
> +++ b/fs/xfs/scrub/xfile.c
> @@ -10,7 +10,6 @@
>  #include "xfs_log_format.h"
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"
> -#include "xfs_format.h"
>  #include "scrub/xfile.h"
>  #include "scrub/xfarray.h"
>  #include "scrub/scrub.h"
> -- 
> 2.20.1.7.g153144c
> 
