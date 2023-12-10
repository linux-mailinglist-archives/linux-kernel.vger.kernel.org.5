Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FE80BCAC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjLJTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjLJTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB68F0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83C3DC433C9;
        Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235424;
        bh=xtoKuB/V5aQTclBE1TijIXIA5MMvFsOIUDUePA15oJ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fTn5fYSwkkUvrDxP4edGPar1kTbyUg/lSDWLQpE0fO7MjAH2qRbaseAw1YYic51oE
         7M7VMoUcbhvtVSQq/ez59JfxOpcGYbaBbTFWGBHd3ukUsv7YiB15mnxg3ATsFw7Ce5
         38jd2tAq9tV+Lcn87qWGpMnLT6bhfmwlEn34ZuzEJoVg6zDjTm84CoSDfCZt7jI6sq
         5LP6m8M/2IL556tt7xMTTvJWTCazbBIWh6ya2+GwVJYIqYq4tdpL0LgL4oRflqdGnJ
         3L2lKexfdgLLwkrKJOL60p/5oYkBoB51V0RPtHtXRLbGyLqkSzdW49ZlEXd80xdXnP
         6z1v1rQhhwEHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 694FDC595CE;
        Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170223542442.32670.11976049465072620330.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Dec 2023 19:10:24 +0000
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
        ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 07 Dec 2023 21:34:42 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - [v2] net: ena: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/378bc9a40ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


