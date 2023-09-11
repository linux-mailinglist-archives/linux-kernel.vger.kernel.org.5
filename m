Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4879B66C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjIKUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjIKJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:40:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC3EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2922C433C9;
        Mon, 11 Sep 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694425226;
        bh=VexeRoFIErq8J/8XR03dPblD5jykwUeFBd2AKAgeJqM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iD8Gs+/zUl7AJMEAIqzv4fLwwsC/hjuq+KuN7Yjv3QLFuQmkjZLawgQUGB/P6UAnC
         GlsV01t+ReHoEO5R23c4od0MQA4mS58cI7Mio6nU++NieWhV3xKLAMHUN2hfgQbDBM
         5fM8ghU0AMeSNGQcvkkCfjo56KwB994dDDJXRoLrzIEy9Fa2Z42+7svf+CT/5cV5bV
         PsEtAOqX8+5elt/qZxW/PTIxSG2zNL4UZy/b1tG/W6fakeDbh9UYCRl42oaZ3r624z
         63oNifE/zTko5AqRQIPfAJyXDluxsx6KYcn/lsNKRZQ2GybM0oA2h1ygKVnbJBtcLD
         zGsGnsAj4DIsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6F1BC00446;
        Mon, 11 Sep 2023 09:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix uninitialized variable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169442522587.29871.12263337568524186830.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 09:40:25 +0000
References: <30044cf16ff83f73e5ef852c25682e9fde63af51.1694376191.git.daniel@makrotopia.org>
In-Reply-To: <30044cf16ff83f73e5ef852c25682e9fde63af51.1694376191.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     dan.carpenter@linaro.org, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 10 Sep 2023 22:40:30 +0100 you wrote:
> Variable dma_addr in function mtk_poll_rx can be uninitialized on
> some of the error paths. In practise this doesn't matter, even random
> data present in uninitialized stack memory can safely be used in the
> way it happens in the error path.
> 
> However, in order to make Smatch happy make sure the variable is
> always initialized.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: fix uninitialized variable
    https://git.kernel.org/netdev/net/c/e10a35abb3da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


