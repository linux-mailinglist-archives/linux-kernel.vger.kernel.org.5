Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287C7571F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGRCtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGRCtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:49:16 -0400
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 19:49:15 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A267E6C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:49:15 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 17821C01E; Tue, 18 Jul 2023 04:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1689648554; bh=gXC7lZsciCoVW9famNK4Ly0sIVABug3pge3MST1GSU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5n0AKr2E598uHNpVs4UymLGion7uATI9j916d46cgv+0dw2xTmhk+WD5Vmc0GSYa
         KYRwU495TfoeFmR6t/SQQ64TN+i1OjteT3eDJcXsRy/ptgmP2CH1bGejfU6eZmVdU8
         1NvolZlqSC6yhmLFvcc9qsk8lXjqp4dNiOO0uEqKJNVY3nm9xly0L7LkIQys4OVpJ1
         7VUQcg5wOcuwCN8w5BH9WSrHgQwkqrj/QLU4bbXayCoHDwOEpsBT5kokoU6OncpuG4
         AMHXSmjNumY+mTCDLhV4PFvBnkn6HzEfnceBaHa1XXbKdVB7MMVUdHNG+7kXx+EReB
         woN2d/ZTHlxBw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7089CC01A;
        Tue, 18 Jul 2023 04:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1689648553; bh=gXC7lZsciCoVW9famNK4Ly0sIVABug3pge3MST1GSU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeoOe1FO8/AIW8dork5GxRbvcHabHTqzNBr3UBe1qbs9HJNsybNQ11hJD3i+9SPiy
         wfUojKTQEsxYI9RYET2dj5wpsWX7qnaTqTzpOQ9q3u8aErRg7MFpn9Q4R/tIpB5nNr
         c8mZJbrplzWLGc1Rxdyu141+J+cFXlvhviDgn0wMScRdh7/gQH9cavt0tWTg1nL7Nt
         9UFPVD/RbKVqL6LeJE0m4osKotnVwJCUGAVlLD4bTna8rUsDw41u/nMfOSkQPicFl9
         utiH8vWpJJfIfemZMt3IBeabKZ7tlz+iZAePANC/2L+ooBinCy3J4EA3LFQYSKWtEy
         Pg0g4fP1+fTIQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 3f7d9a9a;
        Tue, 18 Jul 2023 02:49:09 +0000 (UTC)
Date:   Tue, 18 Jul 2023 11:48:53 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 2/3] fs/9p: fix typo in comparison logic for cache mode
Message-ID: <ZLX9lUnIwLYT-Oc4@codewreck.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-2-0683b283b932@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-2-0683b283b932@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:01PM +0000:
> There appears to be a typo in the comparison statement for the logic
> which sets a file's cache mode based on mount flags.

Shouldn't break anything, but good fix nevertheless, thanks!

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>


> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 0c51889a60b33..297c2c377e3dd 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
>  	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
>  		fid->mode |= P9L_DIRECT; /* no read or write cache */
>  	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
> -				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
> +				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
>  		fid->mode |= P9L_NOWRITECACHE;
>  	}
>  }
> 

-- 
Dominique Martinet | Asmadeus
