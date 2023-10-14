Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7B7C91C1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjJNAU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNAU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E0EB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E68AC433C9;
        Sat, 14 Oct 2023 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242825;
        bh=cfRnollf93GlHOWzLc4/JD5iRWpUYQRm38D3NguFwmY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PY68IhxNr7JF9rn7y9V501IfKAKXIjMdOPJfj2HJNewGGSYvH7XQuQue3s+tAYjFM
         Hn9gFyfY7C5XpM7Xl6l4RDGT8atOIIUU+Xqj+qC5NNeDVEjLRu5+k8UL7dOmuWwrB+
         +EO9JSbMQbIGGrI49j/Bleq4gFB8Pm7bBnl/2usFfI6XJTUAdQ1KeoTbwYpC1qhBrB
         AxMS1ZmFF/naDs3iEynF6zeYHuFIlFyDd/ic5+dk8QeJbmULv1TDvNCVaT9RkUiPN0
         2riEIhWvyCvkdkCEuOUO0djfhm1qrNgPO2VRuAqH1K38w7Abjg+qttkt9U9LqCHPY0
         DAEwcopkkzAMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA824E1F666;
        Sat, 14 Oct 2023 00:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724282495.20328.14649814507738116651.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:20:24 +0000
References: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, 11 Oct 2023 21:48:39 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect res->name to be NUL-terminated based on its usage with format
> strings:
> |       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
> |               NFP_CPP_ID_TARGET_of(res->cpp_id),
> |               NFP_CPP_ID_ACTION_of(res->cpp_id),
> |               NFP_CPP_ID_TOKEN_of(res->cpp_id),
> |               res->start, res->end,
> |               res->name ? " " : "",
> |               res->name ? res->name : "");
> ... and with strcmp()
> |       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {
> 
> [...]

Here is the summary with links:
  - nfp: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/d273e99b5623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


