Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F975774937
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHHTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjHHTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AF1A838
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BA262A44
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714BC433C7;
        Tue,  8 Aug 2023 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520057;
        bh=izSNwFnda6h0Un6PypnWGVheuJkWo9/X0Ob6dyB+nIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEk8gebSl+EOpmPGjpsUFZUwrNfkbhTdSgL61ucTkGe+upaditmqfLn+sbFtG2toQ
         LZAHIdTm52x917COSvVBwd1pVcBcdAig+JE3YqRdBfUGc+e8cH5f3yo/ivRJq9iUJg
         ItthR9DoWmhZWuHv7XOEqgoXuY2cOBuInQP+NyxX28juQE6YCVVlAxRigvcbXYYbmo
         YjLiWFZIfTKoP9vOrnoHES4ls3zl6ub0UDzfAsUVvBTykKQXCT29apCfk8RjegvPBO
         yvhukPtfN+PaFiSqGjH0+tWDZKyA9ducYoPIKBh+qtHnFAyyMkYDMlXQDOfbOYHN5E
         f0zm1BOi1s/EA==
Date:   Tue, 8 Aug 2023 21:40:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 1/4] net: hns3: restore user pause configure when
 disable autoneg
Message-ID: <20230808184049.GC94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-2-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-2-shaojijie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:34:49PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Restore the mac pause state to user configuration when autoneg is disabled
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
