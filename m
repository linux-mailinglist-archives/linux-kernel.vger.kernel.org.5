Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15547BCE6B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjJHNBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbjJHNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE4B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:01:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56AD9C433C9;
        Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696770105;
        bh=DQk+Uo1Aj7m6CN1WR/ZmAdwJnWTi1NCYCK8zikDFlOk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QAvRQ3ao3Vl8wpZWph0A/wBAApb3xqHFpF7ki5GRsl+xTA7nthe5xhWDBpgosTwG2
         /tb2JuNL2BbJl/E6L/Ax5jN7e9rjv2ZUW8db1aqZDV26h9PeEyfvoBhZBVK2y/MX0s
         kTC8+y5jNEVT3NPidyvqQlHDRFj7TLx2GMVZkVP6EqG5XBdhOH6fyW+orqX2pafaiH
         mstHg4cV0hsaEvx+QMElQAZeot2u0hnGoW0DmA7Uk5iYnY36AVgkPP+pkCjgRBalAm
         +Xm6r5irjkQzrywjH/v57LuOlhTcxWgQr1CT/S5KPoJN29iEzzoAcdtrgVgMCY5Noz
         jOg+boJA5StrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37774E11F5C;
        Sun,  8 Oct 2023 13:01:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] xen-netback: use default TX queue size for vifs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169677010522.31796.399436279906419737.git-patchwork-notify@kernel.org>
Date:   Sun, 08 Oct 2023 13:01:45 +0000
References: <20231005140831.89117-1-roger.pau@citrix.com>
In-Reply-To: <20231005140831.89117-1-roger.pau@citrix.com>
To:     =?utf-8?b?Um9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+?=@ci.codeaurora.org
Cc:     linux-kernel@vger.kernel.org, ross.lagerwall@citrix.com,
        wei.liu@kernel.org, paul@xen.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Ian.Campbell@citrix.com, bhutchings@solarflare.com,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
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

On Thu,  5 Oct 2023 16:08:31 +0200 you wrote:
> Do not set netback interfaces (vifs) default TX queue size to the ring size.
> The TX queue size is not related to the ring size, and using the ring size (32)
> as the queue size can lead to packet drops.  Note the TX side of the vif
> interface in the netback domain is the one receiving packets to be injected
> to the guest.
> 
> Do not explicitly set the TX queue length to any value when creating the
> interface, and instead use the system default.  Note that the queue length can
> also be adjusted at runtime.
> 
> [...]

Here is the summary with links:
  - xen-netback: use default TX queue size for vifs
    https://git.kernel.org/netdev/net/c/66cf7435a269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


