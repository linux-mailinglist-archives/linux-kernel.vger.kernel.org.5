Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9B7A5F57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjISKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjISKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FCF0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD81BC433C8;
        Tue, 19 Sep 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695118823;
        bh=qqeF1t+aH5aNEKTxzWsZ3xvz/bvHp6L6xuIECCmBhj4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LAuVtHbHaMDkGyohq09nOuuW8r5VNJpc102mH76gG8VKF2Sj1K0W/PEP2urzF819d
         Kd8pZq9cs1EST7QN/3G4eZBrR9bY9CmbikpkQ7hFwDwOF3DWMoD951da8AGQ4cy2uM
         UFwLl+Uj5Vp0/ZlBgYYAopFPVYLvByk0aNAW7br/44QvAra7q1Ga7cAjQkFfiMedYt
         ZSh1firVEcq08I2z2kMDzSxj38n8TN6yTvtPjlqEcZA6gP4q5WF+VnfeeLyQ84JvUn
         NMiqXQgr7wEjEiRSSOps1svC3V+oBMzQM7ssGHDZUWT0SRNAV50T6ORMG53ThoPC5f
         pmsNbMv39mXZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A21FBE11F42;
        Tue, 19 Sep 2023 10:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/5] There are some bugfix for the HNS3 ethernet driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169511882366.4546.6244271992953408805.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Sep 2023 10:20:23 +0000
References: <20230918074840.2650978-1-shaojijie@huawei.com>
In-Reply-To: <20230918074840.2650978-1-shaojijie@huawei.com>
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 15:48:35 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v1->v2:
>   add Fixes tag for bugfix patch suggested by Simon Horman
>   v1: https://lore.kernel.org/all/20230915095305.422328-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/5] net: hns3: add cmdq check for vf periodic service task
    https://git.kernel.org/netdev/net/c/bd3caddf299a
  - [V2,net,2/5] net: hns3: fix GRE checksum offload issue
    https://git.kernel.org/netdev/net/c/f9f651261130
  - [V2,net,3/5] net: hns3: only enable unicast promisc when mac table full
    https://git.kernel.org/netdev/net/c/f2ed304922a5
  - [V2,net,4/5] net: hns3: fix fail to delete tc flower rules during reset issue
    https://git.kernel.org/netdev/net/c/1a7be66e4685
  - [V2,net,5/5] net: hns3: add 5ms delay before clear firmware reset irq source
    https://git.kernel.org/netdev/net/c/0770063096d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


