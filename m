Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17BE7BC2BB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJFXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjJFXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE8CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B764FC43397;
        Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633225;
        bh=DWOqHoTdvRiOVK1Inct3f6wJqwRA89lb9uBtVVNrdW0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DAW6pH5VNEyblPYq35HyL0Jb3PQCwZfvmeRygE8QNnLZJwZAHOizTRunjEx1i/sFt
         kP7jDzjYHxHqiGUVwBadWPbT7hjzJXlQ9CwQjvq2Nw1psWv2dYBbDNP5U55AiHEBKl
         qf509DD9x+6O0W9TTyOlATjBl57JKT8t4LhguXu4HYVWx0bXxmtnq9LwvXQwgZ146F
         4WmAEfhPvNONx+ua1cAXOTt+rN6BwXsiZHrYD2Fr1kkjKdBpG9kCZKr0jarFpwFXBi
         MOTGhKABXwe4KxigEp65K+u0pMQQY893wsIs0YknOmkdCQoPo+3zU4Gz3KZVai0rX4
         KxE8YA1NQOhAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1625E22AE3;
        Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atheros: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663322565.31337.8644310026514977480.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 23:00:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 01:29:45 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect netdev->name to be NUL-terminated based on its use with format
> strings and dev_info():
> |     dev_info(&adapter->pdev->dev,
> |             "%s link is up %d Mbps %s\n",
> |             netdev->name, adapter->link_speed,
> |             adapter->link_duplex == FULL_DUPLEX ?
> |             "full duplex" : "half duplex");
> 
> [...]

Here is the summary with links:
  - net: atheros: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/9814ec70fccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


