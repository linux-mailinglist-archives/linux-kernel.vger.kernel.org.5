Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B47C81A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjJMJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjJMJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:12:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD091FCB;
        Fri, 13 Oct 2023 02:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEDC8C433CB;
        Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188231;
        bh=x7mc+kQYSsekJK4vlCye+6KPOUJkFZpCl0x3sxdgaaw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AQtTwPCmajOmNNQPHtTr/zoA/M7SdwCrA5V9FAtAtdm7Ym6xjJjw7WotI6tBpMCpM
         MyVA/dkPX2f9eKdrX0iFiy9ikBV2W2VDPlNKUFZ8eMx9ZmhJxej7QyBa8B18SbMGv5
         qSC6fuBbLr1aYasdO92fsMbZJ7T8gtFwgCtgBkHb337NFEyvLcivFYDSTAVpENqPfi
         rKTXLxmnF43ghcQfVDVluH/VqcQ6iZ9Xu+3MCZpKld29GOou5Hxl0hyL6TCagn+Jah
         NifCVuHcJH3km9jk78Jz6A6enfGvNufLaykR9nKnZWYPzTjSmmuYLJhppVGPHklyhR
         PIGjkkXd6p94A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3F2AE1F669;
        Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: Use device_get_match_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718823086.32613.16429893280352977849.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009172923.2457844-3-robh@kernel.org>
In-Reply-To: <20231009172923.2457844-3-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     joyce.ooi@intel.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
        iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, wei.fang@nxp.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, linux-imx@nxp.com,
        pantelis.antoniou@gmail.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        grygorii.strashko@ti.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
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

On Mon,  9 Oct 2023 12:28:58 -0500 you wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/ethernet/altera/altera_tse.h      |  2 +-
>  drivers/net/ethernet/altera/altera_tse_main.c | 13 ++----
>  drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 42 +------------------
>  .../net/ethernet/apm/xgene/xgene_enet_main.c  | 15 +------
>  .../net/ethernet/apm/xgene/xgene_enet_main.h  |  3 +-
>  drivers/net/ethernet/freescale/fec_main.c     | 12 +++---
>  .../ethernet/freescale/fs_enet/fs_enet-main.c | 18 ++++----
>  .../net/ethernet/freescale/fs_enet/mii-fec.c  | 10 ++---
>  drivers/net/ethernet/freescale/fsl_pq_mdio.c  | 12 ++----
>  drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 11 ++---
>  .../stmicro/stmmac/dwmac-intel-plat.c         |  9 ++--
>  drivers/net/ethernet/ti/davinci_emac.c        | 12 ++----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 13 ++----
>  13 files changed, 40 insertions(+), 132 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: Use device_get_match_data()
    https://git.kernel.org/netdev/net-next/c/b0377116decd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


