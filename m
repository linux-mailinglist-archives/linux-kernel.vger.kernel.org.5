Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB67BCF4A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbjJHQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjJHQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD29F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:52:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D19E8C433C9;
        Sun,  8 Oct 2023 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696783929;
        bh=XpWAoOiXXqi8yhNSs8TLF1to5sTFQ9pjTT1uSc+d1IA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dsnJ7eo1uxCtIarB3FqPjAmcpWHf3+w8g+RJmojV/aY/O+fQiCINa0DVxW71N0Vra
         LYl6JxHwovVfSx6WPhpciZbdjh/qZUITdUtNlcuynrZoYtxcRoUMFjczn8pJC9hbXb
         bPQqAReXoVO8zUndOEez0OnksEC89pPgKYj/cvBYtk6Av1sbKz6MuriKqsRGQb3Jik
         eBDv/PvS+qYvd30Q/BGfdiAAw/Xu+D0zFPHJsC7VTrZRdksCHoKZxM3sQCfhnkN5bZ
         w3eMF0P8/EQRLYyeMV9mzXULz+bjIjYv6vps9OxcOdbuPgVdLm2hJ5f7IG9fOY8U46
         LGTnfNRzElFFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B62E0C64459;
        Sun,  8 Oct 2023 16:52:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: Remove custom ndo_poll_controller()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169678392974.1974.11968305394752351326.git-patchwork-notify@kernel.org>
Date:   Sun, 08 Oct 2023 16:52:09 +0000
References: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  5 Oct 2023 11:17:47 -0700 you wrote:
> The driver gained a .ndo_poll_controller() at a time where the TX
> cleaning process was always done from NAPI which makes this unnecessary.
> See commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> for more background.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: bcmgenet: Remove custom ndo_poll_controller()
    https://git.kernel.org/netdev/net-next/c/19537e125cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


