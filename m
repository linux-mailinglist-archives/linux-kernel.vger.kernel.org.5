Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35126764514
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjG0Eu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG0EuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE12724
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C35614A8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B4EC433C9;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690433419;
        bh=MkujO+AHnKa+uJ0U9wZ9p1P1wFZ14Hb6A67Wo9vtzxA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WfYz5HxsGEL+ZESXhE5rvdM5h5AbH9Wp/xzTKt+6KziGrF/HLkSIjeLcoGyj9yL/P
         HiztTbQ565EfcnXZcvaSd3bo2mvLFnxJACNLQAJ1CId5PDiZEEV1HhUsxIXLcIH2/F
         q5KqmwryEd2z3taSXJoExDusp5MTK4eYTkggyYl5NoCX+iuK7mK/fi7Wu+PQ/i1BMo
         ddHdHSQne79INxqzMP9Ur5kuwLYxp2SKv/BylGHhODyWp2J/W6VK3bj1Ww80NJ6Zyd
         m/gEnk49dqm1g6/SsVH7d91fpxebfwm5EwRWGWgCsvnwbAqn5EL3mZ6anEB4MFHD+e
         +3mpM2WmBdfwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94AF9C595D0;
        Thu, 27 Jul 2023 04:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043341959.19452.10457255901157094054.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 04:50:19 +0000
References: <1690329270-2873-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1690329270-2873-1-git-send-email-Tristram.Ha@microchip.com>
To:     <Tristram.Ha@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, f.fainelli@gmail.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 16:54:30 -0700 you wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>
> 
> Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
> Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
> of frame data, which can be used to implement ARP or multicast WoL.
> 
> ARP WoL matches any ARP frame with broadcast address.
> 
> [...]

Here is the summary with links:
  - [v6,net-next] net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs
    https://git.kernel.org/netdev/net-next/c/8b305ee2a91c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


