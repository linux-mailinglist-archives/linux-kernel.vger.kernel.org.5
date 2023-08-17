Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47277EF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbjHQDUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347874AbjHQDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBC02D59
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A90D61B01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2ACCC433C9;
        Thu, 17 Aug 2023 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692242420;
        bh=p6lUxhyQUbyuIxDV6nWA70lZY3wzRKThzFrdN604Ng4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rmx0kg/jkszFkuEp3LlYuNA6YDQfNKjZoN89rbsildmdXbTlofZ8zzoNhjyMYduPi
         16uRTDDsQoO3c4bMrXJXZXoGf7z+W4pwr6JK6UEPwOllL4olsP8z8OZMRxG1WG2uzU
         yTcBwavimjv2gI0gVjld+B/O2G4oOcJBL1co+Qg0f0rw5OBQi0vZwBT4g1UCmqtTCA
         gwFBdNQQxlvb9M3l/1ZxJzm9sASKd1+zx7DsVdqxwERAE8GXM57Z/smyNRfeJ8Ovxm
         cpBhOIy9zK03IOaN4a+GMzZbEdmeiQQP94CwQA5QWPyS6SGg4sSH6IPqxmHOrPndkW
         Sqq3bsUIL0U7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4D34C395DF;
        Thu, 17 Aug 2023 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW
 reset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169224242073.22058.9512114729208930656.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 03:20:20 +0000
References: <20230815001323.24739-1-l00g33k@gmail.com>
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru
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

On Mon, 14 Aug 2023 17:13:23 -0700 you wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
    https://git.kernel.org/netdev/net/c/23d775f12dcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


