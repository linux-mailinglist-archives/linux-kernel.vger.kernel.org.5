Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA27B6AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjJCNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjJCNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB91AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 468F2C433C9;
        Tue,  3 Oct 2023 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696341025;
        bh=YxifJ1Z73CgHj4OSVngWsMFOdhHCFakmIXaPX8loJAg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U3w+v3OQt67baH5tcXryivMpQhVCwD8oQN6LenlOVd/tiQFTo1ax/WdcMEBtQsDHh
         +yBo0RIMDAcueVsMGMRUedq0wOtScqvo4CXbB1iReUrhrl7/q+vdjk3/lpvrubOKiN
         du8ffYp/SHwmfdQCN+RHl6eBCRIGB3JgcccOyWIK6cqlHUX+7VmRsrDSf1fn/rSuJe
         Moax/XZW2C8AE8vinreKc01GNosceeMDvi+cyJDNUwi8UQEVfEqkCpfzZfxzwJwD80
         3sfyvGw0x4PiiKUhaMGlEwGK8iJu3jcdItVjVoCHM327wf+L5n7GbG+zQEHNmHCx3m
         zKt4HidNINc0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29F01E632D0;
        Tue,  3 Oct 2023 13:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading for
 KSZ9477
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169634102516.4627.9648416567742706220.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 13:50:25 +0000
References: <20230922133108.2090612-1-lukma@denx.de>
In-Reply-To: <20230922133108.2090612-1-lukma@denx.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, edumazet@google.com, andrew@lunn.ch,
        davem@davemloft.net, woojung.huh@microchip.com, olteanv@gmail.com,
        o.rempel@pengutronix.de, f.fainelli@gmail.com, kuba@kernel.org,
        pabeni@redhat.com, UNGLinuxDriver@microchip.com,
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Sep 2023 15:31:03 +0200 you wrote:
> This patch series provides support for HSR HW offloading in KSZ9477
> switch IC.
> 
> To test this feature:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link set dev lan1 up
> ip link set dev lan2 up
> ip a add 192.168.0.1/24 dev hsr0
> ip link set dev hsr0 up
> 
> [...]

Here is the summary with links:
  - [v6,net-next,1/5] net: dsa: propagate extack to ds->ops->port_hsr_join()
    https://git.kernel.org/netdev/net-next/c/fefe5dc4afea
  - [v6,net-next,2/5] net: dsa: notify drivers of MAC address changes on user ports
    https://git.kernel.org/netdev/net-next/c/6715042cd112
  - [v6,net-next,3/5] net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
    https://git.kernel.org/netdev/net-next/c/5e5db71a92c5
  - [v6,net-next,4/5] net: dsa: microchip: move REG_SW_MAC_ADDR to dev->info->regs[]
    https://git.kernel.org/netdev/net-next/c/e5de2ad163e7
  - [v6,net-next,5/5] net: dsa: microchip: Enable HSR offloading for KSZ9477
    https://git.kernel.org/netdev/net-next/c/2d61298fdd7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


