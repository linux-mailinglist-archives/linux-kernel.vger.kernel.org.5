Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655B575963F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGSNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGSNJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:09:08 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDA198D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=06wAJOif646+VyAqs5qKhAGpFfRMMbjLh19j1Z+a+JA=; b=b8k7YhgAsq7OiZSetYiSTETcU0
        ARwYiYFPH43QKiugOI1ZQQz7BkNmXgsjMB5hTpET/RkMwmW0kkyyBnbt2b3S4oLVCLS2MeCPcgiIA
        unJmeOcB6Y0Wk0KJAqaEJ1PUq+6z4NBmWY5Z7GyozEQbjhtEYGvak52lNF/n5PeOA25bQp4gPzLgu
        xBAUZOOVAPnqxEoDfiR5iMKX0djN/okfVNaQ8B2MPhF1S5jGNqdEnIL0A//SQ6kW+70BDf73Eqd6c
        HlbjDBS7DrsBoRHTtNQg+Pupm/UhzgV/JAfJNogtQqFfTpEa8GpvBWul6Bry92y2wqDKE6EBEoar5
        w9Z7qn3U/56SpFgz3bK+D5Mo2rBpbBRZyTnzwh26r+pzyNada6wdQNiZTRePKiZlIZmwlnoKfz5Ve
        krprNmE0byQ1hQY3Le9TpcAlaH3g/01EH4v21Jpnx/JhIB66UgjEMFtIeai/pEPcz8F+y5G2zjClU
        wqGbVsxroxjm+1BCrKmijN3NloYYdL8VoC4ytsHSiF+XlucC5KSQHsZDPD3w+Pw16JDWiN/pDBaPq
        aORg6Rivvy61ULSld5gqMEU5UrzEDUqAt9w1pCzB8KqlfAFn5ctKsYdjfSF4Kf9N2Sb86VwdSFYkc
        j+e9Lt/0lnMqSv/WBA7Eq6WZJOBs4gtym2sB0hVj4=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH v2 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
Date:   Wed, 19 Jul 2023 15:08:58 +0200
Message-ID: <9712791.GGSLJcCJDP@silver>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v2-4-147d6b93f699@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v2-4-147d6b93f699@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 18, 2023 10:50:18 PM CEST Eric Van Hensbergen wrote:
> There was an invalidate_inode_pages2
> added to mmap that is unnecessary.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  fs/9p/vfs_file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index bda3abd6646b8..3809f3a531499 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -506,7 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	if (!(v9ses->cache & CACHE_WRITEBACK)) {
>  		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
> -		invalidate_inode_pages2(filp->f_mapping);
>  		return generic_file_readonly_mmap(filp, vma);
>  	}
>  
> 
> 


