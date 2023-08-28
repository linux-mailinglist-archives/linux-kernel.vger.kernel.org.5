Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674F78A891
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjH1JLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjH1JK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F32113
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8757634A0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A34FC433C9;
        Mon, 28 Aug 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693213824;
        bh=KqiTlzeQrD493HFW++WGvh1xnvxMjSlAuoKf9o2Lneg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LQRW6lHPNL3g5PADzx6MJrXXEtsVSwTn8+P9sfuuKjEmlBLn5UXq7WBJdV9cHPrL6
         pMKtZMjJ9qTYAvzXK7d6I+nEPJULQ9hbXgV4K3erfgRyMpTiPzeWcOJ94hL0dDAQev
         EWtFXLqS7BQ64ubHIYz1rvc4XpoXDQFbmokcCj0ytt5YH1E7kL8lgG+8nm2CIfjOx5
         Wgxh4Jn4UTrmzDGxgXCD3Uo2eWNecea9MXj+aKE8drjQa6mtPxNZVty348rMn6fFEE
         0gS6CopEU0cae1Ze+OEQCXRFnioXT2HL+d9Di4Jh/gpik+A6omZsRXtYre1Pk2XlAn
         y6kGvzPqnyGVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14DD1C3959E;
        Mon, 28 Aug 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PatchV2 0/4] octeontx2-af: misc MAC block changes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169321382408.1934.3958163855321355962.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 09:10:24 +0000
References: <20230825104022.16288-1-hkelam@marvell.com>
In-Reply-To: <20230825104022.16288-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 16:10:18 +0530 you wrote:
> This series of patches adds recent changes added in MAC (CGX/RPM) block.
> 
> Patch1: Adds new LMAC mode supported by CN10KB silicon
> 
> Patch2: In a scenario where system boots with no cgx devices, currently
>         AF driver treats this as error as a result no interfaces will work.
>         This patch relaxes this check, such that non cgx mapped netdev
>         devices will work.
> 
> [...]

Here is the summary with links:
  - [net-next,PatchV2,1/4] octeontx2-af: CN10KB: Add USGMII LMAC mode
    https://git.kernel.org/netdev/net-next/c/5266733c7986
  - [net-next,PatchV2,2/4] octeontx2-af: Don't treat lack of CGX interfaces as error
    https://git.kernel.org/netdev/net-next/c/f027fd51edeb
  - [net-next,PatchV2,3/4] octeontx2-af: Add validation of lmac
    https://git.kernel.org/netdev/net-next/c/2f387525d484
  - [net-next,PatchV2,4/4] octeontx2-af: print error message incase of invalid pf mapping
    https://git.kernel.org/netdev/net-next/c/17d1368f4f19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


