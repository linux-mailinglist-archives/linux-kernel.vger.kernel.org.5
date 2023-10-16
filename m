Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C77CB697
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjJPWa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJPWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB98A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C073C433C9;
        Mon, 16 Oct 2023 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697495424;
        bh=zyaih1aLU0Z/zC+xrxo25u6WFywDrPfg8S4GMbOxMCg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E4tL1BQpltynZXWCi+j244SzczT4/v4E8/PCraoReQlSdeqw35vL0bQ4A/5fughJD
         GwOHt0odil7cQZskFcAFuWABO1mFYPTSJBrnEtz5HKsMMAzlgud9foJHR7WkzoIYEg
         ifHWwfAel3qmMljsN3TAxWPSSqxfZu+J8pr10GWXvHWapHeE3FlAXHAs4EgxWQHtiv
         OCYaQtfod45livXvxvjR+TmmoDaiFUZQoDR5AkMT7JvcM7vzFK934Xfw//+cXmxZ+P
         Igmy0q/AysAYv8KOSh6xbY+aQlI/FzseWHpwdzf6l50qfg2o7ea669OZ3T8k2taoHq
         ERcj4cGE4LjMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CFEBC43170;
        Mon, 16 Oct 2023 22:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749542418.25064.17965944702112966328.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 22:30:24 +0000
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
        dsahern@kernel.org, ncardwell@google.com, ycheng@google.com,
        kuniyu@amazon.com, morleyd@google.com, mfreemon@cloudflare.com,
        mubashirq@google.com, linux-doc@vger.kernel.org, weiwan@google.com,
        linux-kernel@vger.kernel.org
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

On Wed, 11 Oct 2023 13:30:44 -0700 you wrote:
> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: Set pingpong threshold via sysctl
    https://git.kernel.org/netdev/net-next/c/562b1fdf061b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


