Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546AB7EAAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjKNHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKNHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:41:09 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599DD1A3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:41:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VwOoltt_1699947662;
Received: from 30.97.49.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwOoltt_1699947662)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 15:41:03 +0800
Message-ID: <d997f776-2b20-f38c-1347-c8734cc4e467@linux.alibaba.com>
Date:   Tue, 14 Nov 2023 15:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/14 15:07, Jingbo Xu wrote:
> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:erofs_map_dev+0xbd/0x1c0
>   Call Trace:
>    <TASK>
>    erofs_fscache_data_read_slice+0xa7/0x340
>    erofs_fscache_data_read+0x11/0x30
>    erofs_fscache_readahead+0xd9/0x100
>    read_pages+0x47/0x1f0
>    page_cache_ra_order+0x1e5/0x270
>    filemap_get_pages+0xf2/0x5f0
>    filemap_read+0xb8/0x2e0
>    vfs_read+0x18d/0x2b0
>    ksys_read+0x53/0xd0
>    do_syscall_64+0x42/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
