Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E578065DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376453AbjLFDuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324D188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A8CC433C9;
        Wed,  6 Dec 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701834623;
        bh=XyQIABCNi5zpRVstxuXOFJ+WV83AbjHAvJa3U9iW7QE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fjbrmU/1FaZ/D2I8gDXv/NiU/+DM6VuxFi/YiAmceHGX2ljpmtYyZ8J8UY+eeyDUG
         OEv6Nhvpk7VeESnZd3/DbZzWE9QMzJLYJr5ojGzzVS1i6j+ckYJDzN90L+Oi9kTdix
         l+kRHX8EShwl9u03DLWANFW+0VdjLuO7ouRD1F4SvVmJ+b1Jz4MUp8PjNO2lUACLvI
         K83dCdEuNVBImY21ulqI6IUdc5Ri7YWpxFoHFRacEI+kKBdbye0ZbZm3h6oA5b3agf
         g5R+esy3tkqu1W8pTBJOT2gJUzc4ftNwr51eAxh36lZW5BPmnao6QRg5sd8cWca7CE
         xs2aA694oIFZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B493C41671;
        Wed,  6 Dec 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bnxt: fix a potential use-after-free in bnxt_init_tc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170183462343.27566.10798748391554489332.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 03:50:23 +0000
References: <20231204024004.8245-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231204024004.8245-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sriharsha.basavapatna@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 10:40:04 +0800 you wrote:
> When flow_indr_dev_register() fails, bnxt_init_tc will free
> bp->tc_info through kfree(). However, the caller function
> bnxt_init_one() will ignore this failure and call
> bnxt_shutdown_tc() on failure of bnxt_dl_register(), where
> a use-after-free happens. Fix this issue by setting
> bp->tc_info to NULL after kfree().
> 
> [...]

Here is the summary with links:
  - net: bnxt: fix a potential use-after-free in bnxt_init_tc
    https://git.kernel.org/netdev/net/c/d007caaaf052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


