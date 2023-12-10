Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02C80BCAA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjLJTKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjLJTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB1E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FAD5C433C8;
        Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235424;
        bh=QFEYl2GTyzHL8G65W9eJVUzDQs+Qo+xNhychBgwOuYo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oIvC1+1r85XwLS2pRdluom39HUorF+6mdub69rN1BLGNJnrx6AC5crfMk0ANe14lE
         PGSNqdRl7pa23j+EWBx8fPaoO5Oy0GrNaJC+GATP6L1l8K+rn0g4dQC/Bujz8rE+W6
         QcRr//SRqJYnnJLTW4ADFTTJBTRF6/ql+KGXH866vfgnE6IduQzXfFm7GzzQE0UE6h
         Z3b/DoI73uMOzURoP2BiKcZjyIK+Y4YMVj+F6rFOK0xB2U/wyp/eH/EEMvZ0GXgbKy
         BEgzt1xEwtfMi4Mol3lbDIE+hDC6n6sIpG5jkZAv+eGR6hIAdXuPUOPMoEV1twaoRh
         8PWtYEKDA5/qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 557A5DD4F1D;
        Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170223542434.32670.6160588807079213491.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Dec 2023 19:10:24 +0000
References: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
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
by David S. Miller <davem@davemloft.net>:

On Thu, 07 Dec 2023 21:57:50 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> [...]

Here is the summary with links:
  - [v2] net: mdio_bus: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/1674110c0dd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


