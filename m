Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953977C91D0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJNAam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjJNAa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010BC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35C51C4339A;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=qXHcb+8ArQUczUJqaU2Tky+9gId0V5ZhXHayMa6wpfA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Eay5vYTJTdIAwdF69vMwbD/Nm3g9UzhqHBA5b/6blwgekYREvJfMAphHN7/mxutCZ
         7q3NDXWqUKl5ATZ8TCZWrt639W3pez389oP+ZfBm3fDuknPufwgU5AMFBLsPn9Ma4/
         BYxkzQs1vz4lq4uNMmSjmb0G2TZ5MDbQVcryN/aYqQ2F6wQOxcVsItRIgo3ZuvAqZ5
         00etRf00Jzz23f/78mTNmHLZJk32J4vDU+3peDcK40ynbWtBFyq5NkESimYI8f6hYX
         KzK/oHBVTuDdsTH3cvEdwY2G5CXmUwU/jxI13krd+j72vfiJSr+D02s0SumsRnTYmC
         qGyrRvsmjSsTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BE08E1F66E;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342704.24435.10662096936331983951.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:27 +0000
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Thu, 12 Oct 2023 22:25:12 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> [...]

Here is the summary with links:
  - net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/c3983d5e99b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


