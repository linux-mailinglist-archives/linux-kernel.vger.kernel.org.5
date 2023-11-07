Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047987E492B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjKGT1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKGT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B6AF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699385214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KhVltzxTUgNwTVBGGCSdHtHwIpM3sIzdg58kbC5wd/E=;
        b=K/LqoHha1FsWX2vZJVmEhO9PBDpXJV+a7KSs2rCfiNGi08YxbX7NhG9VXH+qj8Cm0XotAP
        etT1+89A0Hz3ec+FVd4hNHu84r1cCq9AXM9waOV7XldRK44R/CB8sibGxCcTx1i3DoRXy9
        yndI/XzjA17T0b/gaAAf2vY79eZm5CA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-H2_j5JZgO-qPXckEwhdbAg-1; Tue,
 07 Nov 2023 14:26:49 -0500
X-MC-Unique: H2_j5JZgO-qPXckEwhdbAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FA9D28237C0;
        Tue,  7 Nov 2023 19:26:49 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C3625C0;
        Tue,  7 Nov 2023 19:26:48 +0000 (UTC)
Date:   Tue, 7 Nov 2023 13:26:46 -0600
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     chandan.babu@oracle.com, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove unused function
Message-ID: <ZUqPdhc4RQxL8TVB@redhat.com>
References: <20231103073040.649-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103073040.649-1-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 03:30:40PM +0800, Jiapeng Chong wrote:
> The function are defined in the bitmap.c file, but not called
> elsewhere, so delete the unused function.
> 
> fs/xfs/scrub/bitmap.c:55:1: warning: unused function 'xbitmap_tree_iter_next'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7137
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Makes sense.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> ---
>  fs/xfs/scrub/bitmap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/xfs/scrub/bitmap.c b/fs/xfs/scrub/bitmap.c
> index e0c89a9a0ca0..ba4b18e40faa 100644
> --- a/fs/xfs/scrub/bitmap.c
> +++ b/fs/xfs/scrub/bitmap.c
> @@ -48,10 +48,6 @@ static inline struct xbitmap_node *
>  xbitmap_tree_iter_first(struct rb_root_cached *root, uint64_t start,
>  			uint64_t last);
>  
> -static inline struct xbitmap_node *
> -xbitmap_tree_iter_next(struct xbitmap_node *node, uint64_t start,
> -		       uint64_t last);
> -
>  INTERVAL_TREE_DEFINE(struct xbitmap_node, bn_rbnode, uint64_t,
>  		__bn_subtree_last, START, LAST, static inline, xbitmap_tree)
>  
> -- 
> 2.20.1.7.g153144c
> 

