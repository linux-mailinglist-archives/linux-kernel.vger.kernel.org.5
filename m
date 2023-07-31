Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14491769102
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjGaJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGaJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC38E43;
        Mon, 31 Jul 2023 02:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A7960E15;
        Mon, 31 Jul 2023 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBD4CC433BB;
        Mon, 31 Jul 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794019;
        bh=JgCRzdweZ5zFpfF5Al/HYmMZ4ccc1nyLaeGu4f+nfdk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F8/Tr1pqR4qgR+TjizvFhyGyzMXICtx8vdppGkvM4mBIOLUKgoT7w6ck5oA7Ro/wG
         /zzirGrVpTy3PuFGmerf9ZAbehh9rv/fv86aU2KHE6WwIfPeWSHYkzLBGuarWNYiMT
         l1NBRWBr06XUij9da9kP9wLkrVP2jXTGc3kuXfHYW7WNdgKdCidSUimivsO0U8OXwV
         TJB0p5kCgewskEx0PbjvLLpuATzUPtBItw+YgDnTFizicgznY22pEHt0awOx6uxbm2
         lIWOCkux8ZP24QBpfpzIZl32otduNN+lwpu3pD+wpa9jwa6nQaGtcLNdmrk4Q41iev
         LWPcjVul2tjxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B84C8E96AC0;
        Mon, 31 Jul 2023 09:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: lan78xx: reorder cleanup operations to avoid
 UAF bugs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169079401974.32402.6450872761583182908.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 09:00:19 +0000
References: <20230726081407.18977-1-duoming@zju.edu.cn>
In-Reply-To: <20230726081407.18977-1-duoming@zju.edu.cn>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        UNGLinuxDriver@microchip.com, woojung.huh@microchip.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jul 2023 16:14:07 +0800 you wrote:
> The timer dev->stat_monitor can schedule the delayed work dev->wq and
> the delayed work dev->wq can also arm the dev->stat_monitor timer.
> 
> When the device is detaching, the net_device will be deallocated. but
> the net_device private data could still be dereferenced in delayed work
> or timer handler. As a result, the UAF bugs will happen.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs
    https://git.kernel.org/netdev/net/c/1e7417c188d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


