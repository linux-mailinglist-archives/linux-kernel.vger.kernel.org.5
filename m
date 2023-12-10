Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFB80BC96
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjLJSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF495
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:50:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F2BFC433C8;
        Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702234223;
        bh=r81y3LPrVfor8l0bPVhIMjaxMbB/s8W5wUO/t5r4/Vk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q2TNZaNaGdFUxUq2B8VXArbmn1RvVgiE3BgfhK+yshz16MH+0kWcMAygV4RXmI8Ga
         hiu6g8H125eGuWd2M9OqECAyzzy9Hgd9L+zykXW6TZkX+pyZl9WrJ4p8xwo9m3TlNU
         Z5/lWH2/UgQLebAt5oMSkEGnm6kjbesA3i5vtySD3N6EdKcWqCl9n6XxIWiOvcRdB6
         YAPSLGDiVCIwakwU9jphWeDZW1dx9F0c38i27+4vJO/Ntga/V2rC36LUWSetrh6jK4
         /z53nteUZx9U5wmLMGR7jkSZLh2mMjBpnygpNH8o0vkCDnENJ39Z3MQ5Wds0MJ6eA4
         IBErnv66tl1dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25423DD4F1D;
        Sun, 10 Dec 2023 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: correct queue selection
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170223422314.23610.8672879447453941206.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Dec 2023 18:50:23 +0000
References: <20231207083801.233704-1-wei.fang@nxp.com>
In-Reply-To: <20231207083801.233704-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org, radu-andrei.bulie@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Dec 2023 16:38:01 +0800 you wrote:
> From: Radu Bulie <radu-andrei.bulie@nxp.com>
> 
> The old implementation extracted VLAN TCI info from the payload
> before the VLAN tag has been pushed in the payload.
> 
> Another problem was that the VLAN TCI was extracted even if the
> packet did not have VLAN protocol header.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: correct queue selection
    https://git.kernel.org/netdev/net/c/9fc95fe95c3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


