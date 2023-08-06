Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7237715F8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHFPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHFPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAE11B3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B62611C6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 15:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7324EC433C7;
        Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691337021;
        bh=wrBdZugugv5+bjCZftrtdQCrAT3kcIxzWUP4AzgC/oI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ImQVlEIdiGuUO0HPpBdXeOPV6GfNmfDyGqrYhewdECbUJ7MqUv71oY7LSN99A2I/5
         qgOnDIOvmwMh492MraYCxrnrQgW/sHAcUM4BwoZ1bNHUW5o7cIoZ6P1Rp9Qz2PB993
         DyyM4KG17eE947gaHwmL5llgpr1HSFA2Hl0fYkx02yNpyEx/iIgjr4K2a+jVithg9D
         SGZhnnqUP7H/6gPU0XJe2KsU2Lbvqar5kcLhU928/JF7zqVzV3YERC1wLhJV9z0U/1
         Kdu0mqpO+H1Lvacv3pmta55oejgAfFPWDIdsXEJMliG76xrZLYX8lsC2QtCdyf3gmn
         mI/cYv9JOkK7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DF70C6445B;
        Sun,  6 Aug 2023 15:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] drivers: vxlan: vnifilter: free percpu vni stats on
 error path
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169133702131.8913.17543544061792703834.git-patchwork-notify@kernel.org>
Date:   Sun, 06 Aug 2023 15:50:21 +0000
References: <20230804155337.18135-1-pchelkin@ispras.ru>
In-Reply-To: <20230804155337.18135-1-pchelkin@ispras.ru>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     idosch@idosch.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org,
        roopa@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
        lvc-project@linuxtesting.org
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
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 18:53:36 +0300 you wrote:
> In case rhashtable_lookup_insert_fast() fails inside vxlan_vni_add(), the
> allocated percpu vni stats are not freed on the error path.
> 
> Introduce vxlan_vni_free() which would work as a nice wrapper to free
> vxlan_vni_node resources properly.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> [...]

Here is the summary with links:
  - [net,v2] drivers: vxlan: vnifilter: free percpu vni stats on error path
    https://git.kernel.org/netdev/net/c/b1c936e9af5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


