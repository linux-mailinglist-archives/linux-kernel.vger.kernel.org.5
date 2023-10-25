Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299147D671B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjJYJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjJYJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F0ECE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5B43C4339A;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698226823;
        bh=R40SvOBaAzyQCF+k5DFHQ5r8C9Pe2q2/Ct1mYoAEFAs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JMMhqh7lTesw1IPWDMNbczynMhRjX8fJ2jaKAg98AxuPiEywWwJnt5ceVAmKBeiz2
         wO2G6iTmdCSU1RCh+rn+1WjuBLyVYb0ZV7nOtD+Jy9r4S/80u7Izg8HN2oqjxclwOY
         WeGGuFmcaxQ7+ul0MYN8vVuNGgfIydWKKY4T++gB5T96QWfNgP2V6rEVSyBWtNTfD0
         Q9K6xXStf5bzHZlUeMCzRQe1bGJiQ+VEvUpqH7d+alNvOvVdweeDk3ktMW4xJ/8zhJ
         bEGvukAfZMX7Sr21vQ1vhjEDdT+A+o23B3QyI2UyMXfiyxft9GlTT/msSR7OGsEzE2
         aXEtLT+98nOgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD944C00446;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] amd/pds_core: core: No need for Null pointer check before
 kfree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169822682383.18837.12141561827417952269.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 09:40:23 +0000
References: <20231024182051.48513-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231024182051.48513-1-bragathemanick0908@gmail.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 23:50:51 +0530 you wrote:
> kfree()/vfree() internally perform NULL check on the
> pointer handed to it and take no action if it indeed is
> NULL. Hence there is no need for a pre-check of the memory
> pointer before handing it to kfree()/vfree().
> 
> Issue reported by ifnullfree.cocci Coccinelle semantic
> patch script.
> 
> [...]

Here is the summary with links:
  - amd/pds_core: core: No need for Null pointer check before kfree
    https://git.kernel.org/netdev/net-next/c/d0110443cf4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


