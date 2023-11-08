Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4767E4F52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjKHDK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:10:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9010EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FD5C433C7;
        Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699413024;
        bh=rvO7jgle+mBgmeKkpTDDNi586VSWjG2AZorz5TM46Fo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PJWt7UVn2GlE0Ilk3Bc7/fvgogLAUVoTja/zp8MMHEYU1UdyrWmovEqP0+Gv80cAD
         A1lU2L9bHKELNvtWSQbgKS42MBO9QkuCPl4nMj7jBuiJKbESSfDWfXr9vYk2pfq1iV
         LgoDq0PElvrxrAgDCeDgNdRbdVAUU2yxVyybWNipk0/SmW07km73mI7vaNp2uD94qP
         a/UTz0vsqYtPwh9rip5mmKIcjBZ74Sjt5g5jY4hgHLakrdvisBoKQHb3+NGHMyeQdo
         zmxvsBtDYAJW0jWHXa9KZCG6uoenqKkSsRTZe3MmO15cf0bRgeZgEW1iZYZ3JQj/IB
         JqJ2r4kO+K5Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D5FFE00089;
        Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: shorten enetc_setup_xdp_prog() error message
 to fit NETLINK_MAX_FMTMSG_LEN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169941302444.21503.2410496259259680243.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 03:10:24 +0000
References: <20231106160311.616118-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231106160311.616118-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com,
        claudiu.manoil@nxp.com, lkp@intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Nov 2023 18:03:11 +0200 you wrote:
> NETLINK_MAX_FMTMSG_LEN is currently hardcoded to 80, and we provide an
> error printf-formatted string having 96 characters including the
> terminating \0. Assuming each %d (representing a queue) gets replaced by
> a number having at most 2 digits (a reasonable assumption), the final
> string is also 96 characters wide, which is too much.
> 
> Reduce the verbiage a bit by removing some (partially) redundant words,
> which makes the new printf-formatted string be 73 characters wide with
> the trailing newline.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN
    https://git.kernel.org/netdev/net/c/f968c56417f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


