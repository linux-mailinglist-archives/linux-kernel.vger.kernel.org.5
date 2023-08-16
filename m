Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447A977DCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbjHPJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbjHPJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2341990
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9806168A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A05FC433CA;
        Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692176424;
        bh=F/rNh/pWufFSeeYbf819D/PW9ficslBX3e3RS8IcVAg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UK/m7C8boCaUAPEr+IxztQ8uogbd9lDrOtt3+coHsxzgn7cwIXf/VCRSDZ05EowZT
         vM+pCuPV66d+yP3llG8tzY7jUiEmj2C4SEX/ZAWK1ui6mLqW+KFLr+p0qW6Bphomew
         5Rd8Bcj21U7Sqcj/gNcq6vJINCBjmK1d0tSJkx/+dx5BIRSX16MNHeyf2IsHhnpNYI
         c7zc+OuL+12mgQIBsorA1uredmhnRlygM9LGyFz01nS/5bvAHh+apFBDCuairRVzTm
         MgPNMBe0IGAwwF8fV40pwEQYEllkT1CjgYT65dolDX+KMM48RecUODuvWSMPQE3JOW
         1FXPRjFSY9uUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04257C395C5;
        Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] refactor registers information for ethtool -d
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169217642401.25260.16017787272530906946.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 09:00:24 +0000
References: <20230815060641.3551665-1-shaojijie@huawei.com>
In-Reply-To: <20230815060641.3551665-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 14:06:37 +0800 you wrote:
> refactor registers information for ethtool -d
> 
> Jijie Shao (4):
>   net: hns3: move dump regs function to a separate file
>   net: hns3: Support tlv in regs data for HNS3 PF driver
>   net: hns3: Support tlv in regs data for HNS3 VF driver
>   net: hns3: fix wrong rpu tln reg issue
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: hns3: move dump regs function to a separate file
    https://git.kernel.org/netdev/net-next/c/939ccd107ffc
  - [net-next,2/4] net: hns3: Support tlv in regs data for HNS3 PF driver
    https://git.kernel.org/netdev/net-next/c/d8634b7c3f62
  - [net-next,3/4] net: hns3: Support tlv in regs data for HNS3 VF driver
    https://git.kernel.org/netdev/net-next/c/3ef5d70b82ad
  - [net-next,4/4] net: hns3: fix wrong rpu tln reg issue
    https://git.kernel.org/netdev/net-next/c/36122201eeae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


