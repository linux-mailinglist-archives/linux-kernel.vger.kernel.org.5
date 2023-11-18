Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014B7F003C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjKRPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKRPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:10:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843BA10F9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:10:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E63C2C433C9;
        Sat, 18 Nov 2023 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700320227;
        bh=6UWsJkvAEvj2H3Wa8RCVwzYqgNc80avR/IIJi1BMIxc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vB7gC/q6cSSItaBEdfFLGgUZ4LAJ7iImYmiosOdJoKcKeiJ+q8bxAiSCZAXieWjjo
         E4AlPbH/t7vv+kGSG+dRLVfLLFmUmbJ1eZ906enyR3i/1WVopgqar8oCTkuY3A63Bf
         xVenYLpdN/4nuI1rPOnxytOlTc43FtNJHyU6xjLbuax+OIlNcDbnXAjAXpQT1nrZ5A
         HA1B4H+cw9+ga75ZSlOW5l37URKqtskwYdoyxk5GdLKu0kz+nW5D9F0KNJJN6zwZUs
         iqy6DH+5H59qkF2V8hCcY4uolwn5yNfBd3lClJRWE3FATJO0LcWHUyDe6qCE5LTNBG
         mk0vq1gBsEvdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCCA0EA6305;
        Sat, 18 Nov 2023 15:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/16] net: Make timestamping selectable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170032022683.7145.6992267439143242783.git-patchwork-notify@kernel.org>
Date:   Sat, 18 Nov 2023 15:10:26 +0000
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, radu-nicolae.pirea@oss.nxp.com,
        j.vosburgh@gmail.com, andy@greyhouse.net,
        nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
        willemdebruijn.kernel@gmail.com, corbet@lwn.net,
        horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        horms@kernel.org, vladimir.oltean@nxp.com,
        thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        maxime.chevallier@bootlin.com, jay.vosburgh@canonical.com
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
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 12:28:28 +0100 you wrote:
> Up until now, there was no way to let the user select the layer at
> which time stamping occurs. The stack assumed that PHY time stamping
> is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired layer administratively.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/16] net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
    https://git.kernel.org/netdev/net-next/c/446e2305827b
  - [net-next,v7,02/16] net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
    https://git.kernel.org/netdev/net-next/c/430dc3256d57
  - [net-next,v7,03/16] net: ethtool: Refactor identical get_ts_info implementations.
    https://git.kernel.org/netdev/net-next/c/b8768dc40777
  - [net-next,v7,04/16] net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/202cb220026e
  - [net-next,v7,05/16] net: Make dev_set_hwtstamp_phylib accessible
    https://git.kernel.org/netdev/net-next/c/011dd3b3f83f
  - [net-next,v7,06/16] net: phy: micrel: fix ts_info value in case of no phc
    https://git.kernel.org/netdev/net-next/c/915d25a9d69b
  - [net-next,v7,07/16] net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
    https://git.kernel.org/netdev/net-next/c/acec05fb78ab
  - [net-next,v7,08/16] net: ethtool: Add a command to expose current time stamping layer
    https://git.kernel.org/netdev/net-next/c/11d55be06df0
  - [net-next,v7,09/16] netlink: specs: Introduce new netlink command to get current timestamp
    https://git.kernel.org/netdev/net-next/c/bb8645b00ced
  - [net-next,v7,10/16] net: ethtool: Add a command to list available time stamping layers
    https://git.kernel.org/netdev/net-next/c/d905f9c75329
  - [net-next,v7,11/16] netlink: specs: Introduce new netlink command to list available time stamping layers
    https://git.kernel.org/netdev/net-next/c/aed5004ee7a0
  - [net-next,v7,12/16] net: Replace hwtstamp_source by timestamping layer
    https://git.kernel.org/netdev/net-next/c/51bdf3165f01
  - [net-next,v7,13/16] net: Change the API of PHY default timestamp to MAC
    https://git.kernel.org/netdev/net-next/c/0f7f463d4821
  - [net-next,v7,14/16] net: ethtool: ts: Update GET_TS to reply the current selected timestamp
    https://git.kernel.org/netdev/net-next/c/091fab122869
  - [net-next,v7,15/16] net: ethtool: ts: Let the active time stamping layer be selectable
    https://git.kernel.org/netdev/net-next/c/152c75e1d002
  - [net-next,v7,16/16] netlink: specs: Introduce time stamping set command
    https://git.kernel.org/netdev/net-next/c/ee60ea6be0d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


