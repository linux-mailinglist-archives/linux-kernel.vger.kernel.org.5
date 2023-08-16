Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8D77D814
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjHPCBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjHPCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32A81FE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D8161049
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E670C433C9;
        Wed, 16 Aug 2023 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692151221;
        bh=8zy9tuJEYtTlTlsmU6yw8DxWnd3M4qAqXB5IZSXtOWM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jkyl5thNvoc2mEJC4kDmAiQcYEAOJ82knh1SV9Uyk1vXBiJwogLh8vmwvL+wyd20l
         HvqpIbuhmEYDZ3oAyogaGV//PRTfZ4XFb8AeqYr6KfAxNuER4Ur1Dn9YrFDF1pEmOF
         Zp0l2ZI82rUdo28tiJy5In92xwQSEunxB2rjUpcmvGzdVB0jErnKiZVFWN4JwRa4Lh
         +RituYE2rOIG57q6y/Df2kgtfFz9WP+jCasjTIp7ywhA/ShyJbJg43rbBpJMNQYc2t
         Wh/Ap4QTnY4L7wktJMsJVRsWDwca9p0eVcd78PYs0wmekHojjZIr7JMmUruwoWjI8K
         gwW2V6ZzZp+GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D5BC395C5;
        Wed, 16 Aug 2023 02:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: broadcom: stub c45 read/write for 54810
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169215122153.15326.4625429367970352671.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 02:00:21 +0000
References: <1691901708-28650-1-git-send-email-justin.chen@broadcom.com>
In-Reply-To: <1691901708-28650-1-git-send-email-justin.chen@broadcom.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jon.mason@broadcom.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Aug 2023 21:41:47 -0700 you wrote:
> The 54810 does not support c45. The mmd_phy_indirect accesses return
> arbirtary values leading to odd behavior like saying it supports EEE
> when it doesn't. We also see that reading/writing these non-existent
> MMD registers leads to phy instability in some cases.
> 
> Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: broadcom: stub c45 read/write for 54810
    https://git.kernel.org/netdev/net/c/096516d092d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


