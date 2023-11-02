Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699C7DF270
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376305AbjKBMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347476AbjKBMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035391A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91504C433B9;
        Thu,  2 Nov 2023 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698928223;
        bh=9ZFkjK8joE0DrTuUP9Z7RKa5d1tIRR1miySEmmgwcuc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MfUgaVpVKEFN+0GmWGjWYx4+7kOWPQvrDi02LZyCGLvaYJaKKo81Uba2TI+tr51tD
         6jbxtliQrV3IFK/Vsl7/cyan87Id7QBEuWBgT0GW7xlWKbQFRKSCp2tytNMBdyKEan
         wnMbeow0S0ceBMsFnllzI+pZsJ3/uqHeEphYMl6UKun/MoqYHSrlwaPM6uDnFysk0F
         1tky3ErYda/wUfOzmammznqhx86+E4QOxEtEQer1B3Huhf+Xg1WUhHKilCO6xAKlCz
         1Qd9gTXLFNVtwKwK+PS5NLbvwQViwjCxlPE1PigtVC2h9F4vYtC761zZ4K9hGoSz6q
         YLzzyKp03fBiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 772C3EAB08B;
        Thu,  2 Nov 2023 12:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and
 RTL8107E
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169892822348.20787.14826789912068070095.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 12:30:23 +0000
References: <20231030205031.177855-1-ptf@google.com>
In-Reply-To: <20231030205031.177855-1-ptf@google.com>
To:     Patrick Thompson <ptf@google.com>
Cc:     netdev@vger.kernel.org, hau@realtek.com, davem@davemloft.net,
        edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 16:50:14 -0400 you wrote:
> RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
> eapol packets unless allmulti is enabled. These devices correspond to
> RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
> in the same way that VER_35 has an exception.
> 
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: r8169: Disable multicast filter for RTL8168H and RTL8107E
    https://git.kernel.org/netdev/net/c/efa5f1311c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


