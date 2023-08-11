Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8DA7788F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjHKIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A72D43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB9663E12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8808C433C7;
        Fri, 11 Aug 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691742625;
        bh=8EiBU0dz3H/OF6RAEDWOyCtT82/SNchJZhI3Ln0ixxs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hj/thrbdncW4krp955lsmSzCPrQeXps4r2tIa1V//XZ7NfK1XUxl0JcJsf4h9UJ4n
         k1cTFAGBWzfrsnQe2KxN4k/r1G99rPIKNLL1MlDtLFatEadJixv6CnJfUDP2A4UDoO
         Gfn4ZEFytofAnZwg1x/ppJXg50ecvyHVb6MUp1SoVjfZwUY0eVudJQ0RkTgSn5MHEE
         H0ZP4QNnpLc5x5kiX00ZS+G93rFUffWC/14Isx2xyx/4Z2dE11Gr0rQ8AJzkOkhjZp
         i8inZdAyQzT+PPLZr1ZwQ4xF9gmRHSNoxmQWfvLfco3C89l6mpYQFDnABqHIWLyGKy
         ZWlMF8KhoW3pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 881B9C395C5;
        Fri, 11 Aug 2023 08:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Harden rule validation.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169174262555.27025.15639158467197706342.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 08:30:25 +0000
References: <20230809064039.1167803-1-rkannoth@marvell.com>
In-Reply-To: <20230809064039.1167803-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
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

On Wed, 9 Aug 2023 12:10:39 +0530 you wrote:
> Accept TC offload classifier rule only if SPI field
> can be extracted by HW.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] octeontx2-af: Harden rule validation.
    https://git.kernel.org/netdev/net-next/c/12aa0a3b93f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


