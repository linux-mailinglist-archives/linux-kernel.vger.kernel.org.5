Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176278194C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHSLnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHSLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF36CA7E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 04:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D9360B09
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA02BC433C9;
        Sat, 19 Aug 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445307;
        bh=LKmKQ0xSbZIzIwfqFbMR61HP7pVuNaLztMJQtV/tx80=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s5ho89sUA59BNYnbFy+CaxKsuPq+fZY12YuNl9s+og6HoVU6PEIkMUbfXd2yc1L2v
         Dop3+9w5ELa6Y3pxNuAYQ3r4U3sUmw4fhEg4tH9VKflvpFTDfjMMxb3awOc65PjpTz
         PdnUgY5h9mHkIqh3/3McptNr5ea2tPv19qUtvo+o5rfrylvF1w0llbu0QVUjTxZep3
         7FBEqwrfxqtkiX+PpMKX32ss+vI2x26QNTSHu2xV3O/pauFp5p086X+t4yBrr1d3kw
         B0YfLITqWRRhGBDHsZWYrsIdvm1YfUDJS6L3qUuU9bpllD4rm2OPuLWPC0tot2yzg9
         54wTk6SHXRQQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A759FC59A4C;
        Sat, 19 Aug 2023 11:41:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mt7530: fix handling of 802.1X PAE frames
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169244530768.26291.13426375569408099631.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 11:41:47 +0000
References: <20230813105917.32102-1-arinc.unal@arinc9.com>
In-Reply-To: <20230813105917.32102-1-arinc.unal@arinc9.com>
To:     =?utf-8?b?QXLEsW7DpyDDnE5BTCA8YXJpbmMudW5hbEBhcmluYzkuY29tPg==?=@ci.codeaurora.org
Cc:     daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
        sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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
by David S. Miller <davem@davemloft.net>:

On Sun, 13 Aug 2023 13:59:17 +0300 you wrote:
> 802.1X PAE frames are link-local frames, therefore they must be trapped to
> the CPU port. Currently, the MT753X switches treat 802.1X PAE frames as
> regular multicast frames, therefore flooding them to user ports. To fix
> this, set 802.1X PAE frames to be trapped to the CPU port(s).
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mt7530: fix handling of 802.1X PAE frames
    https://git.kernel.org/netdev/net/c/e94b590abfff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


