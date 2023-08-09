Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395A776C88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjHIXA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjHIXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C10E76
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D959262872
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438B3C43395;
        Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622024;
        bh=SC28URfATJ/48zq55kLBaKJ4jexX3dzrTDKzwwnOLDc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W9rlgpJDHEMDOmZlpYkXRFJmV7mD4fSfy0yuGEem6gd3BThUduO4h+QFOdNB6ec4c
         EohIwyW6oQ7Ox0Kk8Rge6Hdm1VH60dy1hmV51xivlK36zquJmbjyqxX8ngTV5SNFWr
         efVZsgZG3S50EBhKkX9FiuZVt1QY8ZIlRINgbmIvjUJ4f+NveJlEJcbJZWV1uzjw2Z
         GY206shRvfwsAHs4dPG9Ir31jWTCx7YTx+NHcSp6GbmH9a2mTo9Pbt52a/NlaHDq8Y
         NTIXvT/YjLq3Pk2vTloVaCTBuyQeFaiBfLNzEy1of0LfMdmve1zxqNphhFH/IRINNJ
         WdJ8kcNHD9gCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24041E33093;
        Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/llc/llc_conn.c: fix 4 instances of
 -Wmissing-variable-declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169162202414.2325.16732635656228825555.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 23:00:24 +0000
References: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
In-Reply-To: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, trix@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, lkp@intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Aug 2023 09:43:09 -0700 you wrote:
> I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> bot spotted the following instances:
> 
>   net/llc/llc_conn.c:44:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_ack_timeout'
>   [-Wmissing-variable-declarations]
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:44:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:45:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_p_timeout'
>   [-Wmissing-variable-declarations]
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:45:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:46:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_rej_timeout'
>   [-Wmissing-variable-declarations]
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:46:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:47:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_busy_timeout'
>   [-Wmissing-variable-declarations]
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:47:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      | ^
> 
> [...]

Here is the summary with links:
  - net/llc/llc_conn.c: fix 4 instances of -Wmissing-variable-declarations
    https://git.kernel.org/netdev/net-next/c/fa1891aeb762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


