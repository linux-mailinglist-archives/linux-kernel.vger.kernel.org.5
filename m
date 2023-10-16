Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F397CB6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjJPXUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB5AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F07A0C433C9;
        Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697498422;
        bh=lOIpGqgibN8/nbIwE0LnrrmupkivmhXyXtxTDswu3IU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JxDCc/ZRxj55oYIWPMqbVlMhSI1jAk/wVz34Cg8X+aDwT9mCxprAAEQEddTPjsx0U
         LpmgMjzE7Lt1UV/btjCLfcT2PJB/nQaCj3dMzHb7ui/ni2lY6VX0TA+HbekE1nJnFO
         prj1PMRtVBGjGYQgzb/SdB/Gew0x4zeDogDkomtZg/dZmXHwm4pYHH38BwvGdANhsP
         bKuWgd/r+rmMJnMPaOR6UYNZ138HsloqwKaVIWMRqMMOBOHEDQJyBA+NA+aRSdWtp2
         dnpTYrjcT7GJJbPFSMH+uC8mfCEGvehd+OOdWLLJzdDHAo1Mqr7TDm5WARmEK/nijh
         6ukjPUV92obew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D57B3C04E27;
        Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: smsc: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749842186.17995.9195946058362636123.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:20:21 +0000
References: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Thu, 12 Oct 2023 22:27:52 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> [...]

Here is the summary with links:
  - net: phy: smsc: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/4ddc1f1f7339

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


