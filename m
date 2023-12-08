Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF380AC74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjLHSuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B829E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A9FEC433C9;
        Fri,  8 Dec 2023 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702061424;
        bh=sOzOiCooIHWv8JwLcQOBgic7AA/i/2hi5qBpmG99UAQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OUjDBMGBJIUBC6ckaV9Gmqu7y85/wcFFGAMz0R00eJ9mf/a5NWt9KcjofdBXnXQB+
         qj28jcFigGux3yc8FWmKsS2iQycF9hKj0LxjP6kPxVWs7avWpd5htby0gMABGNBOGJ
         zTOvmn/BoMftYVhSRfqN5QuOK59vvp29g7s38B+mNJxdnobhcqPTnMkOdyBlHOJjKz
         onX836BQUzUueQR8m5SrxkqSfDb33I3xFtxa1m+XyFSeysM4k48qgj5HGBOxmyIqwc
         zV8TrwL6+WaCJ8hJn9T+Jlob75GjvWPThThZJczI4hu5SoejK68TWdi5ukl+W84rQD
         nPEAA3kRrdsvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F572C04E24;
        Fri,  8 Dec 2023 18:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] team: Fix use-after-free when an option instance allocation
 fails
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170206142405.6428.2927511697282770717.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 18:50:24 +0000
References: <20231206123719.1963153-1-revest@chromium.org>
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 13:37:18 +0100 you wrote:
> In __team_options_register, team_options are allocated and appended to
> the team's option_list.
> If one option instance allocation fails, the "inst_rollback" cleanup
> path frees the previously allocated options but doesn't remove them from
> the team's option_list.
> This leaves dangling pointers that can be dereferenced later by other
> parts of the team driver that iterate over options.
> 
> [...]

Here is the summary with links:
  - team: Fix use-after-free when an option instance allocation fails
    https://git.kernel.org/netdev/net/c/c12296bbecc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


