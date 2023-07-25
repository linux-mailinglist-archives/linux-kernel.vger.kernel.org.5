Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74678760369
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGYAAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7331729
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6467E61479
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F449C433C7;
        Tue, 25 Jul 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690243220;
        bh=YnBNSvvhsIKAeaQcEhRqGz0G48K6Iim/cBdm/agpyn0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j/ss5wd2p7a1Rs4H2VDhfJaVF1yQg5EiAfDu9Zpfjn5zOM1XjPlRi97P3y6kQ+4k5
         zjTxrk85pqd5Rp5AIizlE5WTcbyUw7rqOK/6HIu0dFKKUSjkYrVQKXwBzdRWQr1O4c
         OKjWcRlAsdJ1z1VJ+uzNnQZNbsZNCApDIuuxfcDuf71mMIEtPl85DvAw2hdkEKsgIy
         Q/1c6NhyWnB3/Wi3NYtOCpDYEXm+Vr6idVYyF5fwUbixLvTs9OJ5I1x++otx8rYu8m
         HdQ88K43gEBE6dBBjyrzYlA3FfUuPawZ+xUP08JBX6wKt6vz80TmliAvXqJwRK3LlF
         BRKmZywygUwlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C6B3E1F65A;
        Tue, 25 Jul 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: avoid tx queue timeout when XDP is enabled
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169024322024.4284.8373418017846162224.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 00:00:20 +0000
References: <20230721083559.2857312-1-wei.fang@nxp.com>
In-Reply-To: <20230721083559.2857312-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 16:35:59 +0800 you wrote:
> According to the implementation of XDP of FEC driver, the XDP path
> shares the transmit queues with the kernel network stack, so it is
> possible to lead to a tx timeout event when XDP uses the tx queue
> pretty much exclusively. And this event will cause the reset of the
> FEC hardware.
> To avoid timeout in this case, we use the txq_trans_cond_update()
> interface to update txq->trans_start to jiffies so that watchdog
> won't generate a transmit timeout warning.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: avoid tx queue timeout when XDP is enabled
    https://git.kernel.org/netdev/net/c/bb7a0156365d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


