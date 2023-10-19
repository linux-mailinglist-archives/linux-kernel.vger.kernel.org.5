Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB17CF5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjJSLAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjJSLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD42124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78ACC433C7;
        Thu, 19 Oct 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697713224;
        bh=xR9lGrNoIYXivbzzFkK5ayJiO+oyc+Q4ICPjEexkzcE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oBQqtl+lBhBfimEtNmnfYRYfRIJaP9+FYUOfXOlVmZFtVgQbnWTU2fqPdn+j/3p2P
         8K01j99NzMtw7x1LU2kVBQLFYSJIXUWP02ug9pAphAMiR9OIpAO0zCryMI2+oQ7Kla
         +6GEXgbgRX8H3Hm4abOsYasnSdOyYZXdNrm6sYxeFzL0/9NQPKLziW3Dkf5Tv6Obxg
         p3NNJQDAEkKsXebWIceRfATPtESIU5uQuybzHC20k6wXh1bHK+3Hj7hxgB4bWIJarR
         Na+DeBDWmARGsoi3TwDzSqYp1gdjEn2c50m+OChtdXj3JYP1pntOh8NKgK6EuSs7hw
         0FELRM/gRtUMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D941C04DD9;
        Thu, 19 Oct 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: Fix mixed module-builtin object
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169771322457.21860.12161979997200225746.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 11:00:24 +0000
References: <20231018064936.3146846-1-danishanwar@ti.com>
In-Reply-To: <20231018064936.3146846-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     andrew@lunn.ch, arnd@arndb.de, horms@kernel.org, vigneshr@ti.com,
        rogerq@ti.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org,
        aleksander.lobakin@intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 12:19:36 +0530 you wrote:
> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
> 
> The build system is complaining about the following:
> 
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: Fix mixed module-builtin object
    https://git.kernel.org/netdev/net/c/a602ee3176a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


