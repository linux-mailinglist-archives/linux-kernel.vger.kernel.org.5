Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884DB7816D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbjHSCu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbjHSCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113904228
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CDDA62CDF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2EC4C433CB;
        Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692413425;
        bh=PhfRIEz1S0Jg3MoXhK7iolerhlMr6r0OudB70E+1gig=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DWj0hq7bu3Ta8B8oZZlzC3xIGt+yDTvVP/8iknwRlf88URPk+8p3j7jM34IRUQsmF
         3yZFzfzOzvrcwfl4C8utpNYOn/1HEyN9Dy0m5nhA7le4LR5xeqYYDgmym+Flruuek2
         dnNPLBgoKVIcqyiXjAEjersY3SD/MOENM16YKX3CQePzt9nwWzxrIUgwZ+i1Rmu4BX
         5Bq0/TfbueK/L/Kr4+EcXWY/0PbrK0MfLWpHXtV3iUreSQRCKztLVD9ErAxIU0fHcI
         GTcAP57ZqvB4ptTJ0f0YO3YtW0mOZ47si2i+7k1EAD64acrcpl32qaFWJh+FsRgkmQ
         ipakJx94WItJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8D00E26D34;
        Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvlan: Fix a reference count leak warning in
 ipvlan_ns_exit()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169241342488.21912.14677082854350120327.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 02:50:24 +0000
References: <20230817145449.141827-1-luwei32@huawei.com>
In-Reply-To: <20230817145449.141827-1-luwei32@huawei.com>
To:     Lu Wei <luwei32@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wsa+renesas@sang-engineering.com,
        tglx@linutronix.de, peterz@infradead.org, maheshb@google.com,
        fw@strlen.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 17 Aug 2023 22:54:49 +0800 you wrote:
> There are two network devices(veth1 and veth3) in ns1, and ipvlan1 with
> L3S mode and ipvlan2 with L2 mode are created based on them as
> figure (1). In this case, ipvlan_register_nf_hook() will be called to
> register nf hook which is needed by ipvlans in L3S mode in ns1 and value
> of ipvl_nf_hook_refcnt is set to 1.
> 
> (1)
>            ns1                           ns2
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()
    https://git.kernel.org/netdev/net/c/043d5f68d0cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


