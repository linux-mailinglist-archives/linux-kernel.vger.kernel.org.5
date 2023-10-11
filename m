Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A67C482E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbjJKDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbjJKDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61349C433CC;
        Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696993826;
        bh=OmfMysb2I1m4wQt9oCwoXkgaur3Ia1ti7igGfmNp7Wg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JeZXDjgiFK17sJYMmFdTMLwyXqY2eq82ui7+lhiMF9Bd3utoKv4NCtSmPnfbSaDjY
         Kgth5Au6V7o2SAqwXR87PGPUF9ophQOJ9KvPYsq8kpaIlBR/EUTIYFCKT0uBqHzZuv
         wlz10rYR2W00VvQY49Fv2GARrdt9r4EyT+kwTqqAUyPQtLpQsWhq4J3UHAzZv9/fJl
         gqCZYzYXXRB5P7AxF78ep51DrixrFi2lWXubT4lQKGzyoPNRU/WjAWPVUyywRq9e65
         uQk5EvsGVa4qs/7xxS+xhtzPSwITa4PBMReLzT+P2z22koFpu24merq/35KomtyffN
         3e4uNY8GG4QEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48C8DE0009E;
        Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: qca8k: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169699382629.3301.16130210765800603828.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 03:10:26 +0000
References: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 18:34:45 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: qca8k: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/382bb32d3865

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


