Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C27C91CC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNAaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNAa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C3CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18603C43395;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=FzTtcAKUWEbdKPYDmJ8HdxMqckUGXa+85ouyCmBblj8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dmU7OCJS34LdFPJov/Hl8cZsx84Is4guicLy+j81W2feW3DoEkoQVkeF8iK/U0kW1
         MGKZ48XBKt++4v9WCFc25fFDtp1dSt/3dxdpXlPxW3Zx1eBl0hlYW7O1ceN5gZVuWP
         LLS47Xn0Io7GcKnmiaaNvhhqVEQWKNlr/Boh/8wBwrcs4MoHb7Qr8rprT3v9H8PsIV
         eVHmJq8HJ2H4Kc6ymBEE0g9p7BhA7Qo1+BVIcQ7utMUQO5QpwNvxcGtBbgI3fYIZ75
         7EQluos3YP8qQN+j1+2pbASzk2IYv0P4vrZvpplcTLhEKFJ1vIn3UUOk07JZDQDRfW
         Papeb7nWmeibg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2F29E1F66D;
        Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342698.24435.5110584850065672168.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:26 +0000
References: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 20:38:19 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `desc` is expected to be NUL-terminated as evident by the manual
> NUL-byte assignment. Moreover, NUL-padding does not seem to be
> necessary.
> 
> [...]

Here is the summary with links:
  - sfc: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/220dd227ca3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


