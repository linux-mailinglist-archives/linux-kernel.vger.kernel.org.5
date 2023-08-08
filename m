Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3147749FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjHHUJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHHUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638971F18
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A51762A29
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8D6C433C7;
        Tue,  8 Aug 2023 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520072;
        bh=6VD6KFzW7DJTqaWY79jF9GAl8AF9p1AZkcFnQqzYAdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV4p4AUl6cJ03spnOKSGuL4mpk8Szhw9JfWLI5lJmI8JeK3H+NSSADheC4BBaY/Er
         v0BSsSIG0g2znSFo39C01W/NClpvBY4Wpm8YqJ3tJX9Yt+XRdFTNpjiuCCbqTNBsON
         g4vxgy50YR2JpFcN40MISuU2EmcyDsaKV/lbW9BAEYH9MtbWmPYpak/xrVVYhyl8pd
         0ONF3Q/EQ9J2SIuzokbNj0h++DJCSbeJJPpueYJNTBeNz74icCUg+8UpwPSPGI0eEc
         6gcU75eSdtmofrTDWiYiH/enU19/9Dzv/AmX6ArjCvcatXWuSyXi3r9GZeOPKc5DSW
         yWQbkDYHoN12g==
Date:   Tue, 8 Aug 2023 21:41:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 3/4] net: hns3: add wait until mac link down
Message-ID: <20230808184105.GE94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-4-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-4-shaojijie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:34:51PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> In some configure flow of hns3 driver, for example, change mtu, it will
> disable MAC through firmware before configuration. But firmware disables
> MAC asynchronously. The rx traffic may be not stopped in this case.
> 
> So fixes it by waiting until mac link is down.
> 
> Fixes: a9775bb64aa7 ("net: hns3: fix set and get link ksettings issue")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
