Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E68784090
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjHVMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjHVMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:17:24 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB3CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:17:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VqMVnFR_1692706630;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqMVnFR_1692706630)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 20:17:12 +0800
Message-ID: <539d44d0-2a00-767e-9889-b2f5bf410190@linux.alibaba.com>
Date:   Tue, 22 Aug 2023 20:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: release ztailpacking pclusters properly
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/22 19:05, Jingbo Xu wrote:
> Currently ztailpacking pclusters are chained with FOLLOWED_NOINPLACE and
> not recorded into the managed_pslots XArray.
> 
> After commit 7674a42f35ea ("erofs: use struct lockref to replace
> handcrafted approach"), ztailpacking pclusters won't be freed with
> erofs_workgroup_put() anymore, which will cause the following issue:
> 
> BUG erofs_pcluster-1 (Tainted: G           OE     ): Objects remaining in erofs_pcluster-1 on __kmem_cache_shutdown()
> 
> Use z_erofs_free_pcluster() directly to free ztailpacking pclusters.
> 
> Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
