Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E77BFCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJJNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:06:20 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E6AF;
        Tue, 10 Oct 2023 06:06:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vtsp-iy_1696943168;
Received: from 30.25.224.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vtsp-iy_1696943168)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 21:06:11 +0800
Message-ID: <9a6ccef5-3a35-ae0d-2a9c-1703c5038c81@linux.alibaba.com>
Date:   Tue, 10 Oct 2023 21:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix inode metadata space layout description in
 documentation
To:     Tiwei Bie <tiwei.btw@antgroup.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ayushranjan@google.com, Yue Hu <huyue2@coolpad.com>
References: <20231010113915.436591-1-tiwei.btw@antgroup.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231010113915.436591-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tiwei,

On 2023/10/10 19:39, Tiwei Bie via Linux-erofs wrote:
> Xattrs, extents, data inline are _placed after_, not _followed by_ the
> corresponding inode. This patch fixes it

Thanks for the patch and sorry about my terrible English...

> 
> Fixes: fdb0536469cb ("staging: erofs: add document")

I'm not sure if it's necessary to tag document fixes anyway
since docs.kernel.org already uses the latest version and
`.rst` format is adapted much later..

I will drop this tag for the next merge window if not urgent.

> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   Documentation/filesystems/erofs.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index f200d7874495..57c6ae23b3fc 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
>                                           |                  |
>                                           |__________________| 64 bytes
>   
> -    Xattrs, extents, data inline are followed by the corresponding inode with
> +    Xattrs, extents, data inline are placed after the corresponding inode with
>       proper alignment, and they could be optional for different data mappings.
>       _currently_ total 5 data layouts are supported:
>   
