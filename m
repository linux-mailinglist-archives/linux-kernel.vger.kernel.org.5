Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9D79A481
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjIKHa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjIKHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:30:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED6CD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:30:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BCA3C433CB;
        Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694417450;
        bh=F/eFclIfgLF5FOW+UKQadQ3L0RVkLh2WomP2znmNaJU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=agBSx1b5pRY8gRBVMkDFhXrwuIybXtjtk6RGZGXVFY7R/fiso+PDPq9+SnlkbooSw
         Mra3cFK+szkmxvErQw7Rlp6tXC77v1mUHnhxkPDQyP7N/4pK/wEedjl5br4ucNfmQW
         F+3GrVH4kb9M40T9cfqDPm2g9mj0Vx6kitZYYX2e7PoO9iYo47HDeseguOGky5C/U/
         TEJdzjWNxFo8otLAqJQP0bT5FOEVKlzneezGIQ1wwx4OP6AxYekAdljTrYyUlPQu5y
         rA1tE4rO2DnG9BnXMAD0XVT9vqKscSoA5lAsvHJWI1SU6CiEjQte9ehLt2UrSgY7aK
         4XC/a1PIuekZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBF86E1C282;
        Mon, 11 Sep 2023 07:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Fix possible OOB write when using rule_buf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169441744996.31104.2679100450916464813.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 07:30:49 +0000
References: <20230908061950.20287-1-hbh25y@gmail.com>
In-Reply-To: <20230908061950.20287-1-hbh25y@gmail.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Sep 2023 14:19:47 +0800 you wrote:
> ADD bounds checks in bcmasp_netfilt_get_all_active and
> mvpp2_ethtool_get_rxnfc and mtk_hwlro_get_fdir_all when
> using rule_buf from ethtool_get_rxnfc.
> 
> v2:
> [PATCH v2 1/3]: use -EMSGSIZE instead of truncating the list sliently.
> [PATCH v2 3/3]: drop the brackets.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()
    https://git.kernel.org/netdev/net/c/9b90aca97f6d
  - [v2,2/3] net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
    https://git.kernel.org/netdev/net/c/51fe0a470543
  - [v2,3/3] net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
    https://git.kernel.org/netdev/net/c/e4c79810755f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


