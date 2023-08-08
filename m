Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2914774F72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHHXk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHHXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281F19A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C5562D2E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B16C433CD;
        Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691538024;
        bh=RpkfSsTj63Ao0/zLN6DzdQtPy3uqu9XlwAbYoRpejGU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l6eyH3DEFyPLZqhoKX6LAs4QPnRRV+X2e9nZFwjwlSKuQX7JNuyI12pFaHsa24LsB
         QlOkX1G/4uCT8aM5Vxkhh3D+/DGKqYKlup8DyjTef1tIMspFozk3ko6hDQR1B9gYsx
         Wx2gLbg6L0g61Ft7+yC7xztqhMf46ZwD93fvfAL6sWUdzeFDjRGs5wqsw4ls7LrvYz
         VRRl2iI4B6C7nE8UEWnDJbHUKqJ/yV9iAgsIuCcJ8YMuj37sfbPety+uF11WYaazIw
         Y/8f09WWzU0FjLs481uZX52OA20EkoEpNunyNdlm/X51JkbT04GPj2ZnrjNMZnTL5C
         57Hs4CbmUdNgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FB53C395C5;
        Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153802424.28457.4555959031610597293.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 23:40:24 +0000
References: <20230807113452.474224-1-shaojijie@huawei.com>
In-Reply-To: <20230807113452.474224-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 19:34:48 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ChangeLog:
> v1->v2:
>   delete two patches in this patchset:
>     net: hns3: fix wrong print link down up
>     - This patch is being analyzed according to Andrew Lunn's suggestion
>     net: hns3: fix side effects passed to min_t()
>     - This patch is unnecessary suggested by David Laight
>   v1: https://lore.kernel.org/all/20230728075840.4022760-2-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: hns3: restore user pause configure when disable autoneg
    https://git.kernel.org/netdev/net/c/15159ec0c831
  - [V2,net,2/4] net: hns3: refactor hclge_mac_link_status_wait for interface reuse
    https://git.kernel.org/netdev/net/c/08469dacfad2
  - [V2,net,3/4] net: hns3: add wait until mac link down
    https://git.kernel.org/netdev/net/c/6265e242f7b9
  - [V2,net,4/4] net: hns3: fix deadlock issue when externel_lb and reset are executed together
    https://git.kernel.org/netdev/net/c/ac6257a3ae5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


