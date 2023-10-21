Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8F7D1C93
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjJUKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUKuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:50:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC8D52
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:50:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B96C433C9;
        Sat, 21 Oct 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697885421;
        bh=UBLlCnEVvwYlCti4O20ZYEFk3yYjavGU3fi94jtFESQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dMMJJLi5OocQhNzCbIqur/k2IQdBdg2VWst9rkuINemJy2sKWdyxjfpbofKrKkiu8
         wSm5Vli7voSo5IAR+eXqPcp7LtjcVjUE9abQHeTlcBWeQ0hpUBc1j0mUnr4m02K+DA
         INjSsR99YMXLlE5rgGYX8QgUZB5ggaOXmAigUynYA4MldelmwyjI52pZ3D4inyzZ8Z
         WVWfdqHCoTSj5IDgttTM7lL+nUDmNFYz+rB+hPvuFe997IUtW8K6rI+7RZ8HbW1VK+
         T2xBLofRi61gW8aJycqE6LBIShsa/jmJo5jAVi7foiIAonuJ+IMgRfLPHYQIjx+WnJ
         QhhIMYNuCeK0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EBEFC04DD9;
        Sat, 21 Oct 2023 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: xgene: Fix unused xgene_enet_of_match warning for
 !CONFIG_OF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169788542145.19468.17978327279203895124.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 10:50:21 +0000
References: <20231019182338.832913-1-robh@kernel.org>
In-Reply-To: <20231019182338.832913-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lkp@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 19 Oct 2023 13:23:37 -0500 you wrote:
> Commit b0377116decd ("net: ethernet: Use device_get_match_data()") dropped
> the unconditional use of xgene_enet_of_match resulting in this warning:
> 
> drivers/net/ethernet/apm/xgene/xgene_enet_main.c:2004:34: warning: unused variable 'xgene_enet_of_match' [-Wunused-const-variable]
> 
> The fix is to drop of_match_ptr() which is not necessary because DT is
> always used for this driver (well, it could in theory support ACPI only,
> but CONFIG_OF is always enabled for arm64).
> 
> [...]

Here is the summary with links:
  - net: xgene: Fix unused xgene_enet_of_match warning for !CONFIG_OF
    https://git.kernel.org/netdev/net/c/d2ca43f30611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


