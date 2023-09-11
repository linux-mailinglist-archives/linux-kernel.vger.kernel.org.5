Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001DE79A483
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjIKHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjIKHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:30:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC2D12C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:30:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CD5EC433C9;
        Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694417450;
        bh=WM/Let72K1wMRwb05Q5dSJO19Qx8XAwYxUcOvPl3aVI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IgyOQQajD2aHRq+JcNAxxLIAdTPiOJX6tiHAxrlsa/rOl9CZR0ygkhFiIHha48PVv
         UIZXBTDP8hQXPZsLuPn8RA+UYWAkaMmgSWMx5OnprjqiZilRA4h5oIwnnHWb+OzdBL
         Zmgd0YK4F/pe2bD4A0z7QMoFxuqW2VTY78NPkIXtnN6W+yEFJP2nIQRCHa74k1UdXM
         zqP7h+38qAKbPABBzlXRAkl98My7qmL6PcVKHsV0f5G0mU+NTRTbiunGe3LemNR6LX
         KH02KHr55lzk/GAuZExTu5FWqOlIWgFlK5n3JuHEC9KprIqWiWD0LbJ8qRWRhkA3f+
         b2n5ZJmFyRwfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0510C00446;
        Mon, 11 Sep 2023 07:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: fix handling of zero coalescing
 tx-usecs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169441744991.31104.1654820093252613008.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 07:30:49 +0000
References: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
In-Reply-To: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, nbd@nbd.name,
        maxtram95@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
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

On Thu, 7 Sep 2023 12:46:31 +0200 you wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: fix handling of zero coalescing tx-usecs
    https://git.kernel.org/netdev/net/c/fa60b8163816

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


