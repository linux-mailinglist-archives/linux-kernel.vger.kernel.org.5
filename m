Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915076C999
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjHBJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjHBJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F8198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 484BF618D1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6993C433CC;
        Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690969221;
        bh=FBBL9+tJkGHRFnkoEinohSYS2cAKuA1dAftMpfPbhzg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dx0WB3xtey32WkEdoiknOTNzn6iFRtcvpz1iqA+t6SmPRuPOS80Z9HsH2+NHoswpN
         Jl3XblJPbTn08DB8F5puNHStWSL7mXeGq7LfpskOuw1VLL6wBcvXycp2RwDUBwm7Mj
         04rNtxPICCglqA7/skRR5GgOjnZ5mRpo528eSsNfnr3X/jujfUpIAC9j59nXPGed8Y
         YFUHVenzvVezuu3ifrNeTtBVx0BQ0/zwYK5aYbO5X+N72/Mv2NN8FsDXBUyIAtquJD
         Wtepk2Dgy6rMOQ1iSxWRfPa/xZxgRXnrc11FSNeDasrPPxx9joQDGxqnnN24hssm4R
         ZGoW2VFY1Hytg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 900C7E96ABD;
        Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169096922158.16759.5782706555046601595.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 09:40:21 +0000
References: <20230801064815.25694-1-ante.knezic@helmholz.de>
In-Reply-To: <20230801064815.25694-1-ante.knezic@helmholz.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
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

On Tue, 1 Aug 2023 08:48:15 +0200 you wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
    https://git.kernel.org/netdev/net-next/c/745d7e38e95d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


