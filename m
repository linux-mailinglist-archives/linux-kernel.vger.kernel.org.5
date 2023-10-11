Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708E7C5E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjJKUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjJKUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D756D9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6772C433CB;
        Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697056824;
        bh=jHEi0Y6xyy53cF6gScEchm6fo51MjVaNLYsLSKHwAyo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jFeze8RF2KedqhitWGxTE5Mkxl5PUoaz2URA4BwCCSoCGe85fg6AnpIjo2oRBp579
         rlqbjV6ZVxYIjKHjE7r42PVM5J2PjT6Snp/4Zd4b3pfyQVp+FOd2UCdQDv4hT8ieVC
         jhuIisyfd6aVpWehuxTiPzKjvCQi2gvyf2tT7tGo+CWl4LZ4RKSp5RtZzB1BozFupv
         IiKwjR1zCSD1tsDW0q+kY5/FftPn+qRuFta7s1zZ3TKTxyB6wV4NsbT/5gU3qmA9e6
         9RraZMqLQ+hrjFJyzDakaL7EinJwKps8I9x0EPYRL9r7VZF/AsCFloyddz7Yv8rOoS
         Oi9p8yy1NWp1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0726E21EDC;
        Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next 0/2] add vf fault detect support for HNS3 ethernet
 driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169705682465.25671.17446960049901806583.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 20:40:24 +0000
References: <20231007031215.1067758-1-shaojijie@huawei.com>
In-Reply-To: <20231007031215.1067758-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 7 Oct 2023 11:12:13 +0800 you wrote:
> add vf fault detect support for HNS3 ethernet driver
> 
> Jie Wang (2):
>   net: hns3: add hns3 vf fault detect cap bit support
>   net: hns3: add vf fault detect support
> 
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   5 +
>  .../hns3/hns3_common/hclge_comm_cmd.c         |   1 +
>  .../hns3/hns3_common/hclge_comm_cmd.h         |   2 +
>  .../ethernet/hisilicon/hns3/hns3_debugfs.c    |   3 +
>  .../hisilicon/hns3/hns3pf/hclge_err.c         | 116 +++++++++++++++++-
>  .../hisilicon/hns3/hns3pf/hclge_err.h         |   2 +
>  .../hisilicon/hns3/hns3pf/hclge_main.c        |   3 +-
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 +
>  .../hisilicon/hns3/hns3pf/hclge_mbx.c         |   2 +-
>  9 files changed, 129 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [V2,net-next,1/2] net: hns3: add hns3 vf fault detect cap bit support
    https://git.kernel.org/netdev/net-next/c/f1bc63aa6e11
  - [V2,net-next,2/2] net: hns3: add vf fault detect support
    https://git.kernel.org/netdev/net-next/c/8a45c4f9e159

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


