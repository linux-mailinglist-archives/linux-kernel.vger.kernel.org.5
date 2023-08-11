Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8868377895D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjHKJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHKJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCEF10F6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364C5631E1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C16C433C9;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691744424;
        bh=qLF7YlZrtiwbNwFp51qWg89Le3oLDBKUtjdyQOi9qXQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m/s7XLhO43bruPdqhby3sHMscz0+GSDU3xevXRxqEG/OmP8BE9As+N9IcjsWsBAZM
         pkD1ObJLy3h8ZExeEkQVuaXFCF8OPKvOUUx2wYpf4XIYK6C7PQ3wFgHShS/UtxMuJM
         YHr7VMUAGOfeodGJYT331jnZ7+VS44NRIrRjSG2EkxOnrsTekokgH4KGmCpFAQXSiR
         Vwl5PoXdJCbNXeVLt6/r4dmQ/KONcE3jXfTDWTT731jrzD5j0/8433jKz7OcoZHI5x
         +7PNZMR1eRORb2NmUlthrTiC7+Ci+t+UjpPdKPVggHn0zgJANvIlLXtUHecPhq3wcC
         mNQypC4xsdVXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70031C3274B;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast
 warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169174442445.10902.2590537294686225131.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 09:00:24 +0000
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andi.shyti@kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 12:39:22 +0200 you wrote:
> 'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/xgene: fix Wvoid-pointer-to-enum-cast warning
    https://git.kernel.org/netdev/net-next/c/c5b0c34fae1e
  - [net-next,2/2] net/marvell: fix Wvoid-pointer-to-enum-cast warning
    https://git.kernel.org/netdev/net-next/c/e5cd429e7928

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


