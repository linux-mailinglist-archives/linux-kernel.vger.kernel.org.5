Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D290783834
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjHVCx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjHVCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:53:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91E189
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=crY6R4t3UpM/CBvrbtD+t94OLXGWKbli7KlzpxBuRe4=; b=iQhrp+yvUcsuQCp7CRd/YYKY1E
        gtkJThXqFWdU353IGZUwSEmdh3wOffzXdXKVv4RPaBLiz/fzk28hOeb++g1pPEeBuw0HqWBfVpsFR
        OOd/1hT6lbtvrcHYvEfL7ZPrQROO025LEKCfF/1tvqvYLAvYxKeMTWPunDT2XVyX6pv3Owkxe9hBa
        JWIvm2PhC2nOSKiw0zSLbDRzmZpKxrc9bAntsRGY/bgFenVwbvFOJWjkWJAP9WM3loqUbpvf7tvJa
        2jA/KFRKeLCFJJfliPsMNsZE0ThvlOrnTJMRvoibGFOBAmG0m6EqSoF6b4I1vJBwXqfWAhR+gArn0
        9dkzLALQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYHWd-00F0sV-32;
        Tue, 22 Aug 2023 02:53:48 +0000
Message-ID: <cf669dd1-5382-a1d1-cc4b-7c0109cb65f8@infradead.org>
Date:   Mon, 21 Aug 2023 19:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next] freevxfs: Fixed comment for parameter of
 vxfs_immed_read_folio and vxfs_bmap_ext4
Content-Language: en-US
To:     GUO Zihua <guozihua@huawei.com>, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20230822014350.27591-1-guozihua@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822014350.27591-1-guozihua@huawei.com>
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



On 8/21/23 18:43, GUO Zihua wrote:
> Fixed comment for parameter of vxfs_immed_read_folio and vxfs_bmap_ext4.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/freevxfs/vxfs_bmap.c  | 2 +-
>  fs/freevxfs/vxfs_immed.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
> index de2a5bccb930..9615f9fea54f 100644
> --- a/fs/freevxfs/vxfs_bmap.c
> +++ b/fs/freevxfs/vxfs_bmap.c
> @@ -29,7 +29,7 @@ vxfs_typdump(struct vxfs_typed *typ)
>  /**
>   * vxfs_bmap_ext4 - do bmap for ext4 extents
>   * @ip:		pointer to the inode we do bmap for
> - * @iblock:	logical block.
> + * @bn:	logical block.
>   *
>   * Description:
>   *   vxfs_bmap_ext4 performs the bmap operation for inodes with
> diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
> index 9b49ec36e667..01cded39ade2 100644
> --- a/fs/freevxfs/vxfs_immed.c
> +++ b/fs/freevxfs/vxfs_immed.c
> @@ -15,7 +15,7 @@
>  
>  /**
>   * vxfs_immed_read_folio - read part of an immed inode into pagecache
> - * @file:	file context (unused)
> + * @fp:	file context (unused)
>   * @folio:	folio to fill in.
>   *
>   * Description:

-- 
~Randy
