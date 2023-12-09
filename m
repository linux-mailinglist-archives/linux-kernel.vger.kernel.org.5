Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3874780B0E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjLIAUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:20:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D681705
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:20:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43626C433C9;
        Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702081229;
        bh=JUpRHMdkb4y7BJvcT7lF2H+EfHcoSe7p6Xwoi54/epk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kaztp95a0TeWk6y5yOaOUtQxL4OebMGzT4nkLyOowrQQ5nAmi3srYPEWhfyZfVYie
         XD/OdPoxwQCZrTshUFavcZYMMh/1EwFADD2rwoLidJN1zoRAvEKgrdC8a6kPb4tbZ5
         tmjybdkthakoM3H65G/j23rEphZ72Nvbj9tdV+TKdUd2REpKAdc8TC2h8CJ5t2+9gD
         /BZ6REELfmw6QnX396aNEzHXHQG/fINeS/kTAtMpwNAPeJFxeBn4kXR8xoHdN3krMw
         hv472llEWU/Y7IWGRJgR5QUBO9MHO7wPhQ+qYwCI9Xms/GQSPFuciXOfjkvJ8Z11o6
         f9JtSS0HreAgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29DB2C04E32;
        Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 0/3] qca_spi: collection of major fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170208122916.21357.8920685426589017304.git-patchwork-notify@kernel.org>
Date:   Sat, 09 Dec 2023 00:20:29 +0000
References: <20231206141222.52029-1-wahrenst@gmx.net>
In-Reply-To: <20231206141222.52029-1-wahrenst@gmx.net>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 15:12:19 +0100 you wrote:
> This series contains a collection of major fixes for the qca_spi driver,
> which has been recently discovered.
> 
> Changes in V3:
> - Avoid race condition in qcaspi_set_ringparam() as reported by Jakub and
>   move all traffic handling within qcaspi_spi_thread
> - use netif_tx_disable instead of netif_stop_queue
> 
> [...]

Here is the summary with links:
  - [V3,1/3] qca_debug: Prevent crash on TX ring changes
    https://git.kernel.org/netdev/net/c/f4e6064c97c0
  - [V3,2/3] qca_debug: Fix ethtool -G iface tx behavior
    https://git.kernel.org/netdev/net/c/96a7e861d9e0
  - [V3,3/3] qca_spi: Fix reset behavior
    https://git.kernel.org/netdev/net/c/1057812d146d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


