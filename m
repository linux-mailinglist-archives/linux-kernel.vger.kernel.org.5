Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6076C845
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjHBIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHBIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3EDA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA19961886
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 054BCC433CC;
        Wed,  2 Aug 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690964423;
        bh=VuSMhTQ/OQWlzez2CcMsKBO1M8l3TUcs11autt3WxxM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ove5y8kF9dvVQqA4LTEn+xRUq88JSCOg7OGORbQgR9CnbvgVYQpO7YFM9Q5Y3Zgga
         yLFcZu+lcdkfsxx5MmsXOx7AbV8K0/cgTd1gspZavkVnAAuptv/ZrM1nqh4kQ5qMYR
         7nIuJ+/j9ZSZapwIwi7mXMue7aAnOKn8cekBBzNy2ZQQTW3YTt+dSeIgGGjyxWOx8n
         FxZCQemhjPwlMoHGET/7qdcmIp1qFrsnEdHgNQeRSYBOZS4iTDoi30IYBpzOfAJO/m
         qBnI7QeTJhv7twnlkpsY1CJ7hn5iM0taYYQzyOtzVUKygRayGgUqTGae9t92peH3An
         i0wb+nC+HOvpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E039FE270D2;
        Wed,  2 Aug 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169096442291.23876.736146422814364637.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 08:20:22 +0000
References: <20230731115041.13893-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230731115041.13893-1-rohan.g.thomas@intel.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, 31 Jul 2023 19:50:41 +0800 you wrote:
> For XGMAC versions < 2.2 number of supported mdio C22 addresses is
> restricted to 3. From XGMAC version 2.2 there are no restrictions on
> the C22 addresses, it supports all valid mdio addresses(0 to 31).
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 36 ++++++++++++-------
>  2 files changed, 25 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
    https://git.kernel.org/netdev/net-next/c/10857e677905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


