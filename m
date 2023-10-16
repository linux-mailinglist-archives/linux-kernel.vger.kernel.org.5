Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DED7CB71D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJPXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A992;
        Mon, 16 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B33C433C9;
        Mon, 16 Oct 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697499624;
        bh=yAE3WCFOI0yZilWtjGaUmPJMyDPKdTzBz1qnAUBk1sw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OGg0wTDygQcdc2yqeKGX9YoFB9/l2bejjMKfPwnv/NSkWkrdZbHYTAN2xw9EgPlXL
         zSAJDBcjidkyxLMkAtycSL4afWm6NBHYtZPVhoFPolrCRqa5otceqSqhOuuYAN76MO
         r6qgGbBOFzK191o0RX7GZW9Lly8SOCRkQ3q7JwQngOiKgKbYz2+rMZ/7Big9E1uJjD
         GBeilFKSjjTKqMCR03AjBXm3p3b0RtfGLm+da2M4CroOX+hVrRhXyItzckmMoZ15hA
         gdbqH9NEWofCKx3+uwBmz21hZnE0EwaoHydXp5vZsGtcHtE5fC8BDg12NCYReh2K4t
         1xZfJtTxhJNRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96638E4E9B6;
        Mon, 16 Oct 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749962461.28594.523885663724959725.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:40:24 +0000
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
In-Reply-To: <20231012123729.29307-1-dust.li@linux.alibaba.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 12 Oct 2023 20:37:29 +0800 you wrote:
> In the smc_listen_work(), if smc_listen_prfx_check() failed,
> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
> SMC_CLC_DECL_NOSMCDEV was returned.
> 
> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
> the real reason is much friendly for debugging.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: return the right falback reason when prefix checks fail
    https://git.kernel.org/netdev/net/c/4abbd2e3c1db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


