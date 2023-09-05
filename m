Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C62792F94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbjIEUIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbjIEUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
X-Greylist: delayed 3481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:08:37 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8CAB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 038B6C433CD;
        Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936900;
        bh=sxrm7GJYYpa53mKmtigjhDSiMnrnMSAQumGhA5aO1xI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IkuSqaZ3jsxxd5mBuTGiUsrl/p3vBXzC/Jag5WBoQBWGAwaqurUtS9d8lBn//m5EN
         h+F5dmK+yf1kmNUq9ZgvoCfymFxcCLnu6uPfIv0RM6+PAnlFf96DKbSz3ICoRtQhYk
         mRbLEa8ntb8Jl651VeMwv2B9dlmMNnQ0/AF4GYcX6o639p+p5G4uCN7QTAjWDz0a4O
         /V1yWePTZZwErTF6hYnL5VozzCsVd91zaKIo/lxY+vFUOCDkqrGrRDN+uOVMQSelXY
         EakmAIt8Hs3L4GYSGn9FN1idjqsq0qEKR9XsFMas7gNGBPiZMwT1lJXV2+hfZehVQN
         mKSViMyyzySjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7155C595CB;
        Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix truncation of smq in CN10K NIX AQ
 enqueue  mbox handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169393689987.22693.11325949462948037796.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Sep 2023 18:01:39 +0000
References: <20230905064816.27514-1-gakula@marvell.com>
In-Reply-To: <20230905064816.27514-1-gakula@marvell.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Sep 2023 12:18:16 +0530 you wrote:
> The smq value used in the CN10K NIX AQ instruction enqueue mailbox
> handler was truncated to 9-bit value from 10-bit value because of
> typecasting the CN10K mbox request structure to the CN9K structure.
> Though this hasn't caused any problems when programming the NIX SQ
> context to the HW because the context structure is the same size.
> However, this causes a problem when accessing the structure parameters.
> This patch reads the right smq value for each platform.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
    https://git.kernel.org/netdev/net/c/29fe7a1b6271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


