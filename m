Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B228180861A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjLGKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjLGKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA5D44
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB676C433C9;
        Thu,  7 Dec 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701945024;
        bh=pFq7j9bon22etyXf7357E7ITfs/y8T8hPp68MYGgsiA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s3mHWfUKPYNJHk5O/3Q3wAceBPtFFF+wY1g+7puzKxTD8GvT0Behe870JMZOGAAs/
         g38w4QBBpTxCjdG8J6Nt1fpJ+EDIt9xPN/6l9OQ5iLpX4Nn5ZsJa/pCHhNVefCxglo
         /X5Int80ZxfAohDqrWe8HQZY33xAGGFOBxQJvZo7oEwiI3fGUvDTWtqxdCwy4pjEVQ
         +QmC2yPnODNy2D3Hz2T2gYMnziIbe6tMAZoQ4Em9HfNPSnxO6kj8rEx5u4f49wgYb3
         g+nWeafi2jwbXpmsps2JEPaaIA9niqlXxviMWGUbZLuXAkQnfj/hxlZuVnsT5tJ269
         fuYmWrbTC2dPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D22DC43170;
        Thu,  7 Dec 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] net: dsa: microchip: enable setting rmii
 reference
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170194502463.8570.266673785548513310.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 10:30:24 +0000
References: <cover.1701770394.git.ante.knezic@helmholz.de>
In-Reply-To: <cover.1701770394.git.ante.knezic@helmholz.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
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

On Tue, 5 Dec 2023 11:03:37 +0100 you wrote:
> KSZ88X3 devices can select between internal and external RMII reference clock.
> This patch series introduces new device tree property for setting reference
> clock to internal.
> 
> ---
> V7:
>   - adapt dt schema as suggested by Rob Herring
> V6:
>   - use dev->cpu_port and dsa_to_port() instead of parsing the device tree.
> V5:
>   - move rmii-clk-internal to be a port device tree property.
> V4:
>   - remove rmii_clk_internal from ksz_device, as its not needed any more
>   - move rmii clk config as well as ksz8795_cpu_interface_select to
>     ksz8_config_cpu_port
> V3:
>   - move ksz_cfg from global switch config to port config as suggested by Vladimir
>     Oltean
>   - reverse patch order as suggested by Vladimir Oltean
>   - adapt dt schema as suggested by Conor Dooley
> V2:
>   - don't rely on default register settings - enforce set/clear property as
>     suggested by Andrew Lunn
>   - enforce dt schema as suggested by Conor Dooley
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
    https://git.kernel.org/netdev/net-next/c/8e3bfaab2ad9
  - [net-next,v7,2/2] net: dsa: microchip: add property to select internal RMII reference clock
    https://git.kernel.org/netdev/net-next/c/9f19a4ebc80a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


