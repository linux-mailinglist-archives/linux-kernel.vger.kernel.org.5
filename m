Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60712751571
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjGMAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjGMAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E771BFB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58405619E3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A97E4C433CA;
        Thu, 13 Jul 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689208822;
        bh=MKVDwMvsaB/7qukJAVscIEMm08I8b8A2RhUMORjA8ls=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EQ0yx5gVpMKY2u7ulNqdrViPYDQ6L1kgiJiL3AiWq9XMdAt5cZJzpuDWeTD9mXjB9
         tmYY7DCTOXdloeBZD5kCtEVSfG1P1+Lx154H97QPB/iO3pHO7JfaDMr4EJKNUNw3u3
         Fznm6UoL06yOEx/DwOpIsdSfKS/4C/jCA+kGecbvBXERBChaL7cZiWMBAfNDD+JgBG
         9K3aGQ+dsgGfpLUmknGvgzO9bzmPwXq1J2M/PnwjF6uQnDeJdPQ0nmZYJ7nabtaEgn
         YBNMwDvkVZjPCmayuSd57QQ9DOTrWommtFHvLKTCCRJOeBb7j0cAjT9mEcobmfcXyD
         de6vLXCM7ypEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90971E29F44;
        Thu, 13 Jul 2023 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Add AP CLDMA
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168920882258.29480.12412613673820050231.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 00:40:22 +0000
References: <20230711062817.6108-1-jtornosm@redhat.com>
In-Reply-To: <20230711062817.6108-1-jtornosm@redhat.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jinjian.song@fibocom.com, haijun.liu@mediatek.com
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

On Tue, 11 Jul 2023 08:28:13 +0200 you wrote:
> At this moment with the current status, t7xx is not functional due to
> problems like this after connection, if there is no activity:
> [   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
> [   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
>     (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
> because after this, the traffic no longer works.
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: Add AP CLDMA
    https://git.kernel.org/netdev/net-next/c/ba2274dcfda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


