Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D477849A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHKAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHKAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B322D57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4769E65562
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E8FEC433CB;
        Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691714423;
        bh=AxES2D/fGndvMKLCPqObZNt8VvTIG5vKlDN8rPWTa6g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l5bQZVqBIkDaOzsFj1Z1Pr04+rjgxWr3xp3QsCCajgXwQmyE4ATLyNnxUcsy5Eo6t
         dbaf+n/PE3VgpRATvBmBitfK07n04kN8614vR53uMGlq3i0Amuf8X/FQ5g++rkiScs
         w8g0E7oGFqFxycTVfIqQTCwFO+lh1M2fTPDhc/OycMi7NxV/+EWNQa0FZyqFyF4Iml
         OplgTCINlaH+3E+Vqnhi+PlsYEDuDFcjON7CApuaDrCAlaUUyzQO0ITEmKM7yVuSop
         yEBUma0jYChxu1nYA+69NT/csznpXPFafST/P48G9HnhaWmDHyWIhaH7qTdTU+jvyO
         5YJiGYG0piN4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84FB3C595D0;
        Fri, 11 Aug 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: stmmac: xgmac: RX queue routing
 configuration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169171442354.25552.8986058252469165360.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 00:40:23 +0000
References: <20230809020238.1136732-1-0x1207@gmail.com>
In-Reply-To: <20230809020238.1136732-1-0x1207@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, jpinto@synopsys.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
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

On Wed,  9 Aug 2023 10:02:38 +0800 you wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Clean unused defines
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: stmmac: xgmac: RX queue routing configuration
    https://git.kernel.org/netdev/net-next/c/0c2910ae7fa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


