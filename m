Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7680A786565
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbjHXCaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbjHXCa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3480B10FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B597A65278
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 163D0C433CA;
        Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692844224;
        bh=9Xb37OSDJN57bJvKF/3cFqqWU91ZHJ/cqmbZ1guvma4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FC/V84pP4Kluj8GF5Bg5IHVBAJWd1OJdu1XutdSouErp7c4EsaiT5lBnMFBkivf5f
         /ewPNVv9XoGBEzn4ZwrrXYesNAB9oY00GoKL2UohT+TDrY49CtDl/sK3TkNb15zibx
         +qOxyyVE0kGU1MPXBZgWXX2B1cBNZXwh390fqAF1lmS6Pqc3iK+LoYCMp1xIuHeehI
         ynCVw2Knv7xDCTxzma72q9ydJEsqRWGvtV+aYx7av2GuTr06HmaMbo867mgP7rj1tP
         v1dsPn1JpgHJYEfbx5HIdgOBCDd47P9a977LLAN2ubgBygoONPWrsDQqHnohivzCJ1
         PHuVEjRp3MxiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB4A7E4EAF6;
        Thu, 24 Aug 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: ethernet: mtk_eth_soc: improve support
 for MT7988
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169284422395.2546.12287101492552231894.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 02:30:23 +0000
References: <cover.1692721443.git.daniel@makrotopia.org>
In-Reply-To: <cover.1692721443.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 17:30:56 +0100 you wrote:
> This series fixes and completes commit 445eb6448ed3b ("net: ethernet:
> mtk_eth_soc: add basic support for MT7988 SoC") and also adds support
> for using the in-SoC SRAM to previous MT7986 and MT7981 SoCs.
> 
> Changes since v2:
>  * fold changes to commit they were supposed to go into
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: ethernet: mtk_eth_soc: fix register definitions for MT7988
    https://git.kernel.org/netdev/net-next/c/cfb5677de5ba
  - [net-next,v3,2/4] net: ethernet: mtk_eth_soc: add reset bits for MT7988
    https://git.kernel.org/netdev/net-next/c/88c1e6efb7a5
  - [net-next,v3,3/4] net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
    https://git.kernel.org/netdev/net-next/c/ebb1e4f9cf38
  - [net-next,v3,4/4] net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988
    https://git.kernel.org/netdev/net-next/c/2d75891ebc09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


