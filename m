Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E67AA9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjIVHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIVHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAC4C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2506C433C7;
        Fri, 22 Sep 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695367223;
        bh=5hO3aI2VEexFfns3lA0Y+k0/kuTBVoUzUD98Od7nlTA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Atu0Tq/PtuTxuaHw/uaAPqCVh4WYpjYInukeDnGzB1Y3UcAojbBeir9m753InRXVY
         mhPy3jKSxiTUXfphd7kR820Z1bOZ8vMlSEOdNYhwpgozXiUDTLhwQOyDjvKSnfunuA
         4zCpA97fHtIlILwvKK3TNbkcSWpoiOgszB3SY1wJpZfDp5tgMljL3sdihe/tW5fWKz
         dJjCQCeyQk6D+zAqmvin8RSmRxEet44wWBrTMqXXhAx6QQTRLDtU1q0PrufvNdHKfL
         odYA25hDMnTeQi/tgw4LtJk+3meW/OzNsdBASw0pzsp8WahC2YGnKi3TtSXiDANHYF
         igU/U0SDRFw6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3763E11F5C;
        Fri, 22 Sep 2023 07:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] drivers/net: process the result of hdlc_open() and add
 call of hdlc_close() in uhdlc_close()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169536722279.5471.17948488671485747315.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Sep 2023 07:20:22 +0000
References: <20230919142502.13898-1-adiupina@astralinux.ru>
In-Reply-To: <20230919142502.13898-1-adiupina@astralinux.ru>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     qiang.zhao@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 17:25:02 +0300 you wrote:
> Process the result of hdlc_open() and call uhdlc_close()
> in case of an error. It is necessary to pass the error
> code up the control flow, similar to a possible
> error in request_irq().
> Also add a hdlc_close() call to the uhdlc_close()
> because the comment to hdlc_close() says it must be called
> by the hardware driver when the HDLC device is being closed
> 
> [...]

Here is the summary with links:
  - [v5] drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
    https://git.kernel.org/netdev/net/c/a59addacf899

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


