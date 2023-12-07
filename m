Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FF808765
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379163AbjLGMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjLGMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFF3C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:10:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EC96C433CA;
        Thu,  7 Dec 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701951023;
        bh=lGVbiwQgi6rVKUo0EVi7BxRmbqXizI4m0cqQ8rcLPPo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ErDL/9JQMrjRzMfeJbQctZcg2JXfGHGsLb+p2r0Z+jiQVqA0khLfGa+l0l5GzVxoo
         aDfGn38kioAlq8y/dGFPeKAPU1nj/0sbBNdtvUvAZ/lSeEEoMDpx3j35i2ub+ypZXC
         uDPTn6brZJ6IYACjV8+aPlj+SvLV8XVZvS/hlI6nxOQBCXnLT9xxzWgpjlKKTpnPMD
         Fv684nkeQFAZVnNcgX71k1L8hEQfFIDmUGrgjxr06g/JfD/Wgb8XToZ6IzfOoMUnI4
         1obapsaXwVU3R/5YDPAvmhB8LnKRg/ApAJ8cZiv8FXbBo6dFJVVo3BfMAthn9NuOA8
         YX7N3TPJBd0mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63BF7C43170;
        Thu,  7 Dec 2023 12:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: properly support
 platform_data probing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170195102340.30095.2050525382478340516.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 12:10:23 +0000
References: <20231205164231.1863020-1-dd@embedd.com>
In-Reply-To: <20231205164231.1863020-1-dd@embedd.com>
To:     Daniel Danzberger <dd@embedd.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Dec 2023 17:42:30 +0100 you wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The ksz driver has bits and pieces of platform_data probing support, but
> it doesn't work.
> 
> The conventional thing to do is to have an encapsulating structure for
> struct dsa_chip_data that gets put into dev->platform_data. This driver
> expects a struct ksz_platform_data, but that doesn't contain a struct
> dsa_chip_data as first element, which will obviously not work with
> dsa_switch_probe() -> dsa_switch_parse().
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: microchip: properly support platform_data probing
    https://git.kernel.org/netdev/net-next/c/3bc05faf3787
  - [net-next,2/2] net: dsa: microchip: move ksz_chip_id enum to platform include
    https://git.kernel.org/netdev/net-next/c/d16f1096b320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


