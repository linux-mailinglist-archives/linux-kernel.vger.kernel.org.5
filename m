Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9E80FC03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377734AbjLMAKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377647AbjLMAKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:10:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C9B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:10:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 256BCC43395;
        Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702426229;
        bh=VXosqkC/e3GEGFUuiG+gcRBbUiW7ZCrLw2sUasKp4+I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oicnRBSEmUG3ZpI42PyXQAtLa6H7MTNb2FnNttW3Oo+i7JxTulntzLvQF3YxPIl8O
         1P6q3MjBRXcKMjx0PFm6YKCnnvdznvaTF/cuALk6s1Uf8HwEgVkB5Wciydb1XojQcC
         Chk41fY9PcquLLZszFpAZIhyFRcSoEUDKb+w06fWMm/B6toQ+eqeTHicNiXMVzhWHL
         dYhe2ET4YqmVKhlErTpWw3/EwWEm0nWWwZL8i9rzN9ElMpuTmfcxH7T1LD83oYEYU+
         U9E2skaETZ6Qbw/uYxxSGQqAKBwDPRu1R/qhKnYduLlC6L5plNgxzt1Ah3GeEB2AJw
         nEPbcF85jdajQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11808DFC907;
        Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170242622906.31821.7118921876028610861.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Dec 2023 00:10:29 +0000
References: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
In-Reply-To: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 19:10:00 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> [...]

Here is the summary with links:
  - [v3] net: mdio-gpio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/79ac11393328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


