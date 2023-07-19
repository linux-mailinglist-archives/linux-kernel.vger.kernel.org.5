Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531BC758B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGSCuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B1E5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3967616C5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECA81C433C7;
        Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689735022;
        bh=MU2H0nLRw+9Y2mDegD6YHP/+GM/stj6hIzwuzR+Mo0s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mf0K/sCS/o5nupPbQGuPGRI/eb63WNHYKa7VryxIt0sqknOjqidO+2nc6LgXcPb2y
         5JQV/jIZ8gnPIPYZp359Nwd2vSOxp8EfVi8R09x1O+p8EjrHiIN7/UUkm5VH0DfmJb
         wXAytvsskQuaP+5XohoWrQ4cNCs2BdlsSWQz900sCPdP2tnVa75BJhvv8xIGRYgA/G
         7e7jp3PwMKG2/GWmxvH4y4hIopEP+rjA5USIhBbQiXwsiYxl+2M45v6gNjb/bh7upn
         eaipulnIf0bSTA5qfqxQ3OYUxRrF2HIj02VDt0hk3sLmtF0x8gzqykkXxNl+vSu78U
         tR5hqBGONOV8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C87E1E22AE6;
        Wed, 19 Jul 2023 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: mcs: Generate hash key using ecb(aes)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168973502181.11704.3601716273746740478.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 02:50:21 +0000
References: <1689574603-28093-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1689574603-28093-1-git-send-email-sbhatta@marvell.com>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com, naveenm@marvell.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 11:46:43 +0530 you wrote:
> Hardware generated encryption and ICV tags are found to
> be wrong when tested with IEEE MACSEC test vectors.
> This is because as per the HRM, the hash key (derived by
> AES-ECB block encryption of an all 0s block with the SAK)
> has to be programmed by the software in
> MCSX_RS_MCS_CPM_TX_SLAVE_SA_PLCY_MEM_4X register.
> Hence fix this by generating hash key in software and
> configuring in hardware.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: mcs: Generate hash key using ecb(aes)
    https://git.kernel.org/netdev/net/c/e7002b3b20c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


