Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9E7C61B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjJLAa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjJLAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5090
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 980C4C433CC;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070625;
        bh=IvJA5+/1A+oM3Zbf+KWTHlj+YZ6HcUH+DTBEV/43keg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sw0Sk+KSPrRRR8xtwZ4nK7l4zDBWMYBvOWApGoK3eIMAhVdVaeZMdKqX/wpP8mQbO
         cLKpGhX3OClgSTBlZ38ECkn6JFFRzUw4z74y8+hsTSbDumicAS/u0QNv9VbdPB/IiK
         Iwy1mKJAWa65MgA9pLXBJnzDNE9Wn2HDIlLXoSjuKdzBneInft+CJBk/kdu0kijYUV
         b24xEqFAFxAxFxJdimzxA0NNQejb4LJjLaLZZ8QDjVs1iQdmUhk5GQBKvsg0se5yDk
         BYHzP3otNyNT9hLAX2u3N4eAAkVsrNYLgMXBVUs+zhdawD2e2ffq3oz/U8EnIpxA5j
         4g9jQhHf0jsyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84CA3C595C5;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvpp2: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707062553.15864.15839733815188901404.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:30:25 +0000
References: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
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

On Tue, 10 Oct 2023 21:24:42 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `irqname` to be NUL-terminated based on its use with
> of_irq_get_byname() -> of_property_match_string() wherein it is used
> with a format string and a `strcmp`:
> |       pr_debug("comparing %s with %s\n", string, p);
> |       if (strcmp(string, p) == 0)
> |               return i; /* Found it; return index */
> 
> [...]

Here is the summary with links:
  - net: mvpp2: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/fda9e465a9d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


