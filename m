Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED577FE47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjHQTAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjHQTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE6271B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BACE62EFB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 730F3C433AD;
        Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692298825;
        bh=qd4n0CwObW1GrqqS6S0NdzYHkRtYwMp0AzwZh9N0zUk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uTtT3J8iHn4N3ryK2YjrGYDup6UhY+ygOsPpAwbuGhorF6oymWn+PvV9MkoxSMtiJ
         M9GWaOCmriH83ApDpBBxIXA0DY/woG3SB6am/54jQ4bzd3g71czPjimcBrLrwYeJ8Q
         zfo8mJibKhvVbl/bkEjkif/uEqP+gpAo5BBXir/iD9xC+0IHVid9P8kHTuYYzLaPli
         lDzth//n4agU1+rirbUe6dYmplrAWWqoAA2mEJgFJvg7SlBptGdFHFwRMd30vnR2j9
         3hjcC2Ex3pHaSfQB1/zdTLOcs8IgF/Fi88ix1zRmvFxbXEerm2eHN3AL0qh/8Q/wEC
         QpVjBRzXxQ81g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 550B5E26D3C;
        Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sock: Fix misuse of sk_under_memory_pressure()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169229882534.13479.15705873404005032657.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816091226.1542-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230816091226.1542-1-wuyun.abel@bytedance.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     shakeelb@google.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com,
        ast@kernel.org, martin.lau@kernel.org, leitao@debian.org,
        alexander@mihalicyn.com, dhowells@redhat.com,
        kernelxing@tencent.com, glommer@parallels.com,
        kamezawa.hiroyu@jp.fujtsu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 16 Aug 2023 17:12:22 +0800 you wrote:
> The status of global socket memory pressure is updated when:
> 
>   a) __sk_mem_raise_allocated():
> 
> 	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
> 	leave: sk_memory_allocated(sk) <= sysctl_mem[0]
> 
> [...]

Here is the summary with links:
  - [net] sock: Fix misuse of sk_under_memory_pressure()
    https://git.kernel.org/netdev/net/c/2d0c88e84e48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


