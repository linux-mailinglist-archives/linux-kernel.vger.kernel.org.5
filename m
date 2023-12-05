Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A68804555
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376333AbjLECuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjLECuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE7CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:50:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2114DC433C7;
        Tue,  5 Dec 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744625;
        bh=0bZHE1UC4zNYDt6+dzC6pa74YJUhHbXyySy8ouGxeeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O/ZZ+2A4/LzMqjFfdifSg7FmWp8IuaJaF5goYRtggUZr2FxlhxL74HAHQHvY678k+
         cErMQHndtAXNRr69OrECzH8FLEX42TWGVIxNmCdxX23HlzvVrhJPmiSRInNBLcAtzC
         XFQVTzPjrooMd4Cvv8gQf5FfjwDpvT+sBgMBSnY+MhHvSneX5FFOF9ZMjbqt7MLaC1
         Q6at5rKPopJg7k0LyhKzPB+KsiPDe0SzVo+fs+b8ZWCeEyEue1TQW3NrI9qdqbfIed
         SL9wX5hjlJ8Ru6xYi7A//WGIuLpw5//1iNses7v5B6WynAw4jVcDW4Q5/movhACe7G
         kh/SQ0yNRWvFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08101C41677;
        Tue,  5 Dec 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: EST implementation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170174462502.4521.5357100428466208009.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Dec 2023 02:50:25 +0000
References: <20231201055252.1302-1-rohan.g.thomas@intel.com>
In-Reply-To: <20231201055252.1302-1-rohan.g.thomas@intel.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        peppe.cavallaro@st.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Dec 2023 13:52:49 +0800 you wrote:
> Hi,
> This patchset extends EST interrupt handling support to DWXGMAC IP
> followed by refactoring of EST implementation. Added a separate
> module for EST and moved all EST related functions to the new module.
> 
> Also added support for EST cycle-time-extension.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: stmmac: xgmac: EST interrupts handling
    https://git.kernel.org/netdev/net-next/c/58f3240b3b93
  - [net-next,v2,2/3] net: stmmac: Refactor EST implementation
    https://git.kernel.org/netdev/net-next/c/c3f3b97238f6
  - [net-next,v2,3/3] net: stmmac: Add support for EST cycle-time-extension
    https://git.kernel.org/netdev/net-next/c/9e95505fecb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


