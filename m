Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A277C5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjHOCKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjHOCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102110F9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C0563A76
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E7DC433C9;
        Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692065421;
        bh=AtLBI3iumOo8oPgLPTi8eq44LXo2RRL7ckhDTfH+OxA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DEj73u2QEThS50btGejfOymb4HiXls3RSvU2zkt2OQF4H81iglvalPU5L0qmo2Jui
         12xfA0KFFnE6NvM/sHPHh1fKoRn8nVgx/1LRKuKzKD8UwgDiCV7BOyAej944ElTO46
         RzyrD25z2JaSRkTom7Y44jie39X/srr/bidlmRKVf4RGLA5JQMWN6lTAsypiKfUhcs
         77M63owi2qK49hK5GKkg6iOntaQbu8KDv6lP8eMdhhPjGMaVOhF9+ifjwHpQJFofwn
         iAZMI/MqIOPbtRgTNvqXSdWluqVUg9iyPDInTfF1g1spr+mtN0Tv+eWI6BfcP/SdMv
         2IzxbZWErpygQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78922E93B37;
        Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: In ZynqMP resume always configure PS GTR for
 non-wakeup source
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169206542149.7478.10606104390007198232.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Aug 2023 02:10:21 +0000
References: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
To:     Pandey@ci.codeaurora.org,
        Radhey Shyam <radhey.shyam.pandey@amd.com>
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux@armlinux.org.uk,
        robert.hancock@calian.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 18:44:51 +0530 you wrote:
> On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
> network manager bring down the interface and goes into suspend. When it
> wakes up it again enables the interface.
> 
> This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
> the power management controller power down the entire FPD (including
> SERDES) if none of the FPD devices are in use and serdes is not
> initialized on resume.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source
    https://git.kernel.org/netdev/net/c/6c461e394d11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


