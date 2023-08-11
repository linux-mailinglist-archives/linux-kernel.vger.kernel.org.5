Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E73778590
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHKCk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHKCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE92D60
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F204D627A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55483C433C8;
        Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691721622;
        bh=YndZcHJCV/o6mRr0NKkn4QmiusTlRpbegp99anOFoBE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AQyvlO30I0XiZ267clyidO57KQbHYuTbwf6St9AIG7KnE5ceUoo8+9h1qPpOHMVeR
         6ho6EQSJy47bzqUMMTh+5cfVG5mcwhuMbbVnrsZ0GoiqksqtxUvTkbDLlB2skUmusD
         9fTbjpWJxPIEEgZ6RjPACGaRt2Iq3iXtxtYKd3fAkrnsSnvTn5eMjzpjXYXfDynC8y
         gKLsCCEtF2gXn3o4dO6N6znXQgLZE4VCqNmNntvsRWuuZgw1qUz7W9smSE8scX9tyH
         CEj0t7mcTFo7N7sLucMiuEMD87doi+qKrUjIO3WXWx4z9m/B2Gu2Gxjv9ruIyK8Kz8
         kPDVeKftwiruw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36742C39562;
        Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169172162221.18522.12671280608585780104.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 02:40:22 +0000
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 09:47:52 -0700 you wrote:
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
> 
> Note that sendmsg() code path limits the linear copy length, so this change
> makes write()/writev() and sendmsg() paths more consistent.
> 
> [...]

Here is the summary with links:
  - [v4] tun: avoid high-order page allocation for packet header
    https://git.kernel.org/netdev/net-next/c/6231e47b6fad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


