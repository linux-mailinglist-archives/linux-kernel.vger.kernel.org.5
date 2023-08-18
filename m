Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC027780438
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357445AbjHRDKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357520AbjHRDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526CC3A8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C2062FC5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33D18C433C7;
        Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692328222;
        bh=y9P/3/WGyEw+CQqUCiUgiFpqMBL0DcUQoe8g58/Afs8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TdlFlxaGNnjEfkiv09QR0t1UyigA/lOjQGICLQESx/jXozINFKPufb3Y+LE+CL0WQ
         ihdW7FWGXOoWwrYDhwz7SrTRXhcIB3N5DexWMqvqeVfMo91H3dw/vk7frXk6HqIYVS
         fsnxFTitJmXR/UwmsAR5IsyIW/HWvNN9oRfaMCkIyRfgqnSkY3Q85JT0s/s649Vejf
         rgoYNt7Rs2A3fqilQyEW7WCUnPMtqm+CPzFJ6uZIpTV2fNpj/d2GpeybVXr1T6f72y
         SOa1utSyGSIWviOUrYLv2C7ugLiHp7AUQjCOCk/fDFcI1YtfRu0EpCAP40+BA+cDEE
         KoEeKnQc86DVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1616BC395C5;
        Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mdio: fix -Wvoid-pointer-to-enum-cast warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169232822208.13423.9185597276539868139.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Aug 2023 03:10:22 +0000
References: <20230815-void-drivers-net-mdio-mdio-xgene-v1-1-5304342e0659@google.com>
In-Reply-To: <20230815-void-drivers-net-mdio-mdio-xgene-v1-1-5304342e0659@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, 15 Aug 2023 20:35:59 +0000 you wrote:
> When building with clang 18 I see the following warning:
> |       drivers/net/mdio/mdio-xgene.c:338:13: warning: cast to smaller integer
> |               type 'enum xgene_mdio_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         338 |                 mdio_id = (enum xgene_mdio_id)of_id->data;
> 
> This is due to the fact that `of_id->data` is a void* while `enum
> xgene_mdio_id` has the size of an int. This leads to truncation and
> possible data loss.
> 
> [...]

Here is the summary with links:
  - net: mdio: fix -Wvoid-pointer-to-enum-cast warning
    https://git.kernel.org/netdev/net-next/c/f3add6dec36d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


