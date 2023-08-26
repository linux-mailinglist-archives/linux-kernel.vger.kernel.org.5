Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46AC789347
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 04:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHZCKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHZCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBF7213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3746263F21
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C49CC433CB;
        Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693015825;
        bh=QMZbJji/e1fpxw1gZxdh2oLY8/oVBgJ4/K7tpiPZ+Z8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kiMRXmwPjzcoI3t4LeVjBtfpqfWqLyLkiZ/tGtWiTRrnxZi9Z4nO9oH4oX07oByrL
         ow3hn0SCQj0H5cQwKGWQBgW1Q4PxSwAeoTpsF8mblwoGX/fHmVOV3MSeYU0BD1Y6X4
         aHYkx26jSI+tuZXiAEPbN43ws8CkLeYjYzvDZtTCsPMrzaOLB63FpM+KXsea3X0dXh
         wkgJHs+cfZtFHqYdHCncsvQB0klhahIl2Hh1HvcQrBb8kOjN7euUHVNJgizlJdjo8G
         dHwSAyMH73BcJ1CsGhVvOEk+Iiuhyoe3ZYfoYL4VOrqiQDUH12JWRP4vDzmcjhHKgb
         tBI8FPInmrv+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70D3AE33083;
        Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: Check firmware supports Ethernet PTP filter
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169301582544.16053.2413651378313017401.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Aug 2023 02:10:25 +0000
References: <20230824164657.42379-1-alex.austin@amd.com>
In-Reply-To: <20230824164657.42379-1-alex.austin@amd.com>
To:     <alex.austin@amd.com>
Cc:     netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, ihuguet@redhat.com,
        ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 17:46:57 +0100 you wrote:
> From: Alex Austin <alex.austin@amd.com>
> 
> Not all firmware variants support RSS filters. Do not fail all PTP
> functionality when raw ethernet PTP filters fail to insert.
> 
> Fixes: e4616f64726b ("sfc: support PTP over Ethernet")
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] sfc: Check firmware supports Ethernet PTP filter
    https://git.kernel.org/netdev/net/c/c4413a20fa6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


