Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994B7BFBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJJMo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:44:25 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7528DB4;
        Tue, 10 Oct 2023 05:44:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vtsrq3Q_1696941857;
Received: from 30.221.148.233(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vtsrq3Q_1696941857)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 20:44:18 +0800
Message-ID: <d32b6812-8b54-564b-17d0-5bc6d0661fe1@linux.alibaba.com>
Date:   Tue, 10 Oct 2023 20:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To:     Tiwei Bie <tiwei.btw@antgroup.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org
Cc:     ayushranjan@google.com, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
Content-Language: en-US
In-Reply-To: <20231010113915.436591-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 7:39 PM, Tiwei Bie wrote:
> Xattrs, extents, data inline are _placed after_, not _followed by_ the
> corresponding inode. This patch fixes it.
> 
> Fixes: fdb0536469cb ("staging: erofs: add document")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>  Documentation/filesystems/erofs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index f200d7874495..57c6ae23b3fc 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
>                                          |                  |
>                                          |__________________| 64 bytes
>  
> -    Xattrs, extents, data inline are followed by the corresponding inode with
> +    Xattrs, extents, data inline are placed after the corresponding inode with
>      proper alignment, and they could be optional for different data mappings.
>      _currently_ total 5 data layouts are supported:
>  

Thanks for catching it!

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
