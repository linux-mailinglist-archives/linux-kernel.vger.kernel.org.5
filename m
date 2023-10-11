Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53CB7C4830
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbjJKDKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbjJKDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B992
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590DEC433C7;
        Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696993826;
        bh=qYTdkncRzmHOiS9jUcZB43675WSOE6NXjgbzHK4ZwW0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DS7Xn5EX8HbO7muP+OSDVFik1rg0yLxtdfDInizQAcFe6x0Q47p9U8D0V6+6U84ts
         1XOO/jCa9xRtycBb4Gjf2kSUeV+woGctGTHf7AdLBIvfjsU3NgIHb7rTtwmlwbf2Z0
         dvybZTwTjszQoU2fD5e6mrRvEhr5tUE1w+lE/0EQ0ZhgX5AJcrHazRuFbJqCi8qynH
         PaIgrJoqrFKWtsjxaFlv4OElQ9kjJPfo2CE4E/RR/l5ewbLUbg/Em/Hkm2Jxt0RU1k
         TBRNNH7w8JClXVkgFuZ5m5/a+men58tW4C4X35vYnlZdEZS52YSp1Z/EpBA5/7r2L4
         nwe6pRd3gd8dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40FD8C595C5;
        Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169699382626.3301.16765588346169331676.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 03:10:26 +0000
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Mon, 09 Oct 2023 22:47:37 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/b0e4a14f5ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


