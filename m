Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C3758B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGSCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGSCKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5B1FD8;
        Tue, 18 Jul 2023 19:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5AE616D1;
        Wed, 19 Jul 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70763C43391;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689732622;
        bh=GZrsVklu6wW9LRIDBIigNtrV62SEsXbQ+xxiZOxft5s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FIb0s6XXYq/T55KzIt+Av0wBEgHCjwPJAodcts8fRWJ6J1jZQlNGPkMQ1tiKO550I
         xFyhtK8xnKYn/XakGD5CBsTPo0I2nXhjALNanhNdzHENLOUM0ANe3usMv+BTjJtAEt
         vtE0WTDDk5w7gifeqCH4SMDAZp5zfq3WiAu84Rh79RrX8vtSLpWdWR1LR1QkwgbGTa
         pDNfcbZE/UuKWCwUcSnnP0eLPRh6sVJ+/wtlaKRyYke1BW3+M4+Xv0gxDOEU7rdu0W
         GHWh9+Y6WPmZv8dy2n2CsUClZTnhEf85MNfMIVA1uq1IfW8hBv6HzjPO+JtpjWndbD
         Q9KUAIcKtF3fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44377E22AE5;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] Remove unnecessary (void*) conversions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168973262227.24960.1211431370018888838.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717030937.53818-1-yunchuan@nfschina.com>
In-Reply-To: <20230717030937.53818-1-yunchuan@nfschina.com>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        irusskikh@marvell.com, rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, steve.glendinning@shawell.net,
        iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, mostrows@earthlink.net, xeb@mail.ru,
        uttenthaler@ems-wuensche.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 11:09:37 +0800 you wrote:
> Remove (void*) conversions under "drivers/net" directory.
> 
> Changes in v3:
> 	change the author name to my full name "Wu Yunchuan".
> 	improve the commit message to be more clearly.
> 
> Changes in v2:
>         move declarations to be reverse xmas tree.
>         compile it in net and net-next branch.
>         remove some error patches in v1.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] net: atlantic: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/f15fbe46f5ed
  - [net-next,v3,2/9] net: ppp: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/89c04d6c49c3
  - [net-next,v3,3/9] net: hns3: remove unnecessary (void*) conversions.
    https://git.kernel.org/netdev/net-next/c/14fbcad00fe5
  - [net-next,v3,4/9] net: hns: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/406eb9cf6f6f
  - [net-next,v3,5/9] ice: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/c59cc2679acc
  - [net-next,v3,6/9] ethernet: smsc: remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/099090c6effc
  - [net-next,v3,7/9] net: mdio: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/04115debedce
  - [net-next,v3,8/9] can: ems_pci: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/9235e3bcc613
  - [net-next,v3,9/9] net: bna: Remove unnecessary (void*) conversions
    https://git.kernel.org/netdev/net-next/c/1d5123efdb91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


