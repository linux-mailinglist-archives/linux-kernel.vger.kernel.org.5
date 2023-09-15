Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27637A1ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjIOJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjIOJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC52701
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B5CCC433C9;
        Fri, 15 Sep 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694770825;
        bh=gcU20BJEN7Gm0vzOHOzHJmfBEJWw/hAN5vM5YrC3p2Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=trS7DUvPJITd77iqNUwBXemZqwl0d3FACxmvEh8F3Y0uDycA21naekIMO5/bR8Szi
         HuBK8/jGyk8qJN4mczKwYbpcPnWqASIXJotr8Xq2pp9p+gKB9x93alArZZY+GynzNU
         l6ltpqSmSG4dUZwVTSppt9x/Rak41BmDuyabg94Dz+HHJMvFf9Yz3649holbIJS6br
         Md3vzyKL5GGwnfZlSry/bxp/rFY4XmjxhbpVu0bxrSYiv7mKY/9BC6wKYrFkPyvtNw
         XxqVIGQY/2wEpy0D8yc9ODXDipesNoGQO2ztsCaK4iNTylO6fV7nRePMHe8VX25RhV
         IucwedZCeuFAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A993E22AF3;
        Fri, 15 Sep 2023 09:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: add PTP dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169477082530.23365.278837331642360033.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 09:40:25 +0000
References: <20230912185509.2430563-1-arnd@kernel.org>
In-Reply-To: <20230912185509.2430563-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, vigneshr@ti.com,
        grygorii.strashko@ti.com, danishanwar@ti.com, rogerq@ti.com,
        arnd@arndb.de, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 20:54:51 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver can now use PTP if enabled but fails to link built-in
> if PTP is a loadable module:
> 
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
> icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: add PTP dependency
    https://git.kernel.org/netdev/net/c/a8f367f7e131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


