Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6E7BB4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjJFKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjJFKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3ECEA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19889C433C9;
        Fri,  6 Oct 2023 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696587026;
        bh=TyMA7QWGzHqpaOo8yRqAooHEF0/hM+J1QpQ1B6n7uP0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=npO1I9xdhKl1rbvIEs7thvNZLqBhEreQi31ZWB8hbWycZfTGXLSqBY3wKTszi2EeH
         NhshrnUj7JSUCM0L+mP8u3aHDH1af955xsVBTOoTOgP+sbwCXAjxfwwH+ydl0N/wr0
         iTEEeHuWvpD4bPdukXyQD0kOepHD1VXBE0dfX1l1EUSSQ34MjHBlpUwmEspbIp4YGD
         7ke8r9Gjz29GygfhqzMa4UZK3DZjZgySdXHZyRQFWSj/1qC36u5RmrJMWVOG1sLsU+
         ezfdNwwgPTxFqHUr98uA548CpQ/LsPgkksuKLBbmrLQJDJ4qWMM/tZjO6mTjgu2PqM
         mSF53uDcTOW6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1EF9E11F50;
        Fri,  6 Oct 2023 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] Fixes for lynx-28g PHY driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169658702598.26383.13479730802203078272.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 10:10:25 +0000
References: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, linux-phy@lists.infradead.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        ioana.ciornei@nxp.com, vkoul@kernel.org, kishon@kernel.org,
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
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Oct 2023 14:17:05 +0300 you wrote:
> This series fixes some issues in the Lynx 28G SerDes driver, namely an
> oops when unloading the module, a race between the periodic workqueue
> and the PHY API, and a race between phy_set_mode_ext() calls on multiple
> lanes on the same SerDes.
> 
> Ioana Ciornei (1):
>   phy: lynx-28g: cancel the CDR check work item on the remove path
> 
> [...]

Here is the summary with links:
  - [net,1/3] phy: lynx-28g: cancel the CDR check work item on the remove path
    https://git.kernel.org/netdev/net/c/f200bab3756f
  - [net,2/3] phy: lynx-28g: lock PHY while performing CDR lock workaround
    https://git.kernel.org/netdev/net/c/0ac87fe54a17
  - [net,3/3] phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers
    https://git.kernel.org/netdev/net/c/139ad1143151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


