Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFD7A475E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjIRKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbjIRKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:41:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2F123
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB70CC433CA;
        Mon, 18 Sep 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695033623;
        bh=/rpJw4blscres1SH9Zd4BIBgxuOh6y7bC27y4ZB68YQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gJI1peO3zt+gO8WpdZdzPjd7qONwLmBJkn2VIBjA8c9ZURKJdkTPJG9ltqIjaMnu2
         G5s4tFd6+vHj5+Rw8kIfNrXjCnq26QpSkBQIiKywS5RaIx2CWTiAVOaKNwrme3J7cP
         qTaZJHQ34x9oWnwBwmMAqBpHuZ/vqzCMKd1L5HxczrVyEMfCPH4Iiz0hiwLcEveQIw
         NRKViL1DFyJGebuhWdfycZ4LYwdytBEOY17EtP6MPYqj2USFfdkop1nM/uu+864HUg
         YM8p9mJc22GWhCnl4/ZxqCyiGWHjouvBGM2MGxkzhqWUDoi/sFTiwijQsEimU0qcPy
         2ZUBY7C9oq5OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3867E11F41;
        Mon, 18 Sep 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] net: stmmac: Tx coe sw fallback
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169503362373.26042.16292520553887987397.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 10:40:23 +0000
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230916063312.7011-1-rohan.g.thomas@intel.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, fancer.lancer@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Sep 2023 14:33:10 +0800 you wrote:
> Hi,
> DW xGMAC IP can be synthesized such that it can support tx checksum
> offloading only for a few initial tx queues. Also as Serge pointed
> out, for the DW QoS IP, tx coe can be individually configured for
> each tx queue. This patchset adds support for tx coe sw fallback for
> those queues that don't support tx coe. Also, add binding for
> snps,coe-unsupported property.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: net: snps,dwmac: Tx coe unsupported
    https://git.kernel.org/netdev/net-next/c/6fb8c20a04be
  - [net-next,v7,2/2] net: stmmac: Tx coe sw fallback
    https://git.kernel.org/netdev/net-next/c/8452a05b2c63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


