Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCC77D82E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjHPCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbjHPCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C642128
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5788E64B5B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB7CC4339A;
        Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692151822;
        bh=LEZiyAZvEFf3DpLJrZwKPIG/qGDBJjfBRWr7FWdg6v4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JoOoEOO8DdvoFLVXg0WWZwr2HzVw1Tp6xisYS2s61PcO6pHtdD+Z2+9ysQm9Y/d8d
         hScf63lQjbCqNflmQvPLRZIGqD63balgLlZkB7XMIzDUgiL5moEveLQQJljPFTq4vD
         1Vr2+QbJPPFBF0B27lxVuVqjtPNicCPdIJ8qsBXbNgi5vij1QFRLjPQ/5azjfomfU2
         +bfGgMFdc3mxWqXBGDuhOcFdPEbMMAwZLrS91lm8tis0hTk+Vdkqx7zUM5+Ue2ypBb
         GyCcthQbC3MALJ83ktiZ58vN3ClJ1tUVqsezMLEpeqToJhcZJ8kxe6qefsBIOOYfWY
         EIYl+WtKPVaZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92F15C395C5;
        Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qed: remove unused 'resp_size' calculation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169215182259.21752.4980057098192603283.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 02:10:22 +0000
References: <20230814074512.1067715-1-arnd@kernel.org>
In-Reply-To: <20230814074512.1067715-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     aelior@marvell.com, manishc@marvell.com, arnd@arndb.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, Yuval.Mintz@qlogic.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 09:45:03 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Newer versions of clang warn about this variable being assigned but
> never used:
> 
> drivers/net/ethernet/qlogic/qed/qed_vf.c:63:67: error: parameter 'resp_size' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> [...]

Here is the summary with links:
  - qed: remove unused 'resp_size' calculation
    https://git.kernel.org/netdev/net-next/c/7a456b894ea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


