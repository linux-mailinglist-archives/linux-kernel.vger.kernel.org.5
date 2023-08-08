Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D07749FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjHHUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjHHUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05C627EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E028162A3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236AC433C8;
        Tue,  8 Aug 2023 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520065;
        bh=+f2YihxhO0jWYS9TiQ7dwe3/Y5WOlZkCJXUozzMIN8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiwXfQp81mCOTX+fFaQs+SOTfJsofSr468SdjRQtV85L2YcuvTNnoQX2lZ53e5v85
         k85N3sWyxQI7nn21CzQajNtkWevT/dXOLvyV/wBCGhDSFQoDObTk+nc+sN2NRkeXsm
         VQ8qvyp2BkLrZ15kgHRf0Eh0jYRDZcrLOdfzj4eIVEsTLKdqLRHth/QRpRJ3U4CYJ8
         jAtiL9CxnfyiDN5+nWFtOyG9wWkZn5+cWjLTsMtPH+wx13Ab+Rhc3wwDQAf2511OSY
         ubaQAG4KKsRufmhzlnXH91rfTCVKzNIrgx26SmYFUykP4Q/wVMnPabi2AWKIciCquk
         WjQ/PKTF0oTtw==
Date:   Tue, 8 Aug 2023 21:40:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 2/4] net: hns3: refactor
 hclge_mac_link_status_wait for interface reuse
Message-ID: <20230808184058.GD94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-3-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-3-shaojijie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:34:50PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Some nic configurations could only be performed after link is down. So this
> patch refactor this API for reuse.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
