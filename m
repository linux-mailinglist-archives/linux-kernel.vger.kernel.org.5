Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9076C02C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjHAWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHAWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6631FC7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6757A61762
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E1CC433CA;
        Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690927824;
        bh=GxUDkSf6Hr/lFjnCqty6xdSEBRrcbNy0/iZGOnBIe6c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fg9tvmtNzukcZrcUjastiE0mkN1wzneav/c4Z92WyLUod2WtuhbiL0Le8ZjjTGQJb
         31rrZY9ZyXz8QE8SjXpppOW4tn3GopyQ9ekoc//pcqLiLDu346mHY6y4x/Nsk4CiAC
         vzS8VOlgmiSMHfXu4h70OtqE4B8XtYFIFKQq7YjQ3Ksu4I4Rd2gXThH+imBhErJ/iH
         wnwabcCynE0wcv26QuXrcCKpRPSscGUlSR0ER+H0t5NpFfNijD5MRFagyj09lURqXy
         KQ8qBOSJ48yHQzB4Y/kUSAZoJ5IKlGHd7MWABuUINTbL2Uxdt6QCx3d+NC/krTO/Jo
         KZemY8TkUL1Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3475E96AD8;
        Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169092782473.18672.14985341602368675273.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 22:10:24 +0000
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
In-Reply-To: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ardb@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 11:48:32 +0100 you wrote:
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> misconfiguration of the PHY, rendering the network unusable.
> 
> [...]

Here is the summary with links:
  - [v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
    https://git.kernel.org/netdev/net/c/f3bb7759a924

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


