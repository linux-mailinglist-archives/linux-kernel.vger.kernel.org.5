Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E807C7FE82D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbjK3EK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbjK3EKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3CCCA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:10:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAEACC433C9;
        Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701317430;
        bh=7JVNHmT810vuDew3NxLvYmkKo0/YnDg0jFaNOHL8u+g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uhbqsAoxmu5vEe0xV3DJhCd++IlwkOXPhcH19aQxuyNntYDW+9HT96G+LGofeLhOa
         +5LGtz1vwZn1gWE5oofrIUkMiqxlBlT4pNervZvZW3uEyugMDnrB2ajubG4I0SOjr1
         XNVVpTDu7EvPLyap0TVUIhkw/PVV4gHqKr3PM+Wm1+3nrbPO5/FTxRjE9IXAspLRSN
         2SlU3Q1o+E9qGc/qL5CyjiT6KIukbgAGLKt3y8mz3aRA3k/EryqCwd+cahlaAr4kw9
         zLiPU5RuZI1ouPJSSGs9xstYx5AgtN7gNjLSpdGjicvenO/e6BdRPzAeRttRM82MUv
         9aBZ3OwrEONdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD97EE00092;
        Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170131743070.26382.14989467541066978129.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 04:10:30 +0000
References: <20231128135928.9841-1-ansuelsmth@gmail.com>
In-Reply-To: <20231128135928.9841-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robimarko@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 14:59:28 +0100 you wrote:
> On further testing on BE target with kernel test robot, it was notice
> that the endianness conversion for addr and CRC in fw_load_memory was
> wrong.
> 
> Drop the cpu_to_le32 conversion for addr load as it's not needed.
> 
> Use get_unaligned_le32 instead of get_unaligned for FW data word load to
> correctly convert data in the correct order to follow system endian.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: aquantia: drop wrong endianness conversion for addr and CRC
    https://git.kernel.org/netdev/net-next/c/7edce370d87a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


