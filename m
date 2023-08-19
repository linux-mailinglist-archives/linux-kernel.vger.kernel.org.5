Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B28781965
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHSLxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjHSLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50CCA79
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 04:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5597F623A4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FECC433C9;
        Sat, 19 Aug 2023 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445899;
        bh=TEW/UkmWKofUATAX/yySTM8Wa+yZwEIV33TCwdjld18=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tv1lmSO/TVyV1qk+b05FXg51PegCrsqOnON2yZ4OABvEVrcd47XD9jGPml7ZYtQH8
         0yT/X7t3q1JCfiju9/mxisNUehHccSarNn79ThJhyy9NS69TgSxuRVUi927bfJGEjT
         B+MZnHOaBW4YfW2vy9Bx0hsHD3nSFF4RZXF3OWXwJok7345WM1VUYeuOdk1h04YVCG
         Vm8MSpczgIZK50R32kBZ6s7IqdvPQVAksgSYtwfu0EOVCVCIG2xVV/KXMZRX/+ciab
         v86bGwmj7T2vI0I7WCKUbl4kQpwK02EYL78CnY9NCJ5Q3LtjaUs9WLauHFoed7+rfm
         163hjsbsHmDlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EC72E1F65A;
        Sat, 19 Aug 2023 11:51:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169244589958.30754.16676422230846280985.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 11:51:39 +0000
References: <20230816180656.18780-1-fancer.lancer@gmail.com>
In-Reply-To: <20230816180656.18780-1-fancer.lancer@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, geert+renesas@glider.be, michael@walle.cc,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 16 Aug 2023 21:06:52 +0300 you wrote:
> Based on the original code semantic in case of Clause 45 MDIO, the address
> command is supposed to be followed by the command sending the MMD address,
> not the CSR address. The commit 002dd3de097c ("net: mdio: mdio-bitbang:
> Separate C22 and C45 transactions") has erroneously broken that. So most
> likely due to an unfortunate variable name it switched the code to sending
> the CSR address. In our case it caused the protocol malfunction so the
> read operation always failed with the turnaround bit always been driven to
> one by PHY instead of zero. Fix that by getting back the correct
> behaviour: sending MMD address command right after the regular address
> command.
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
    https://git.kernel.org/netdev/net/c/2572ce62415c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


