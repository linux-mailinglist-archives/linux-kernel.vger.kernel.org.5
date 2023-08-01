Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1676B2D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjHALOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHALOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDDC1982
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C006150F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB020C433C7;
        Tue,  1 Aug 2023 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690888222;
        bh=tDDjBG4k8p3k5cshMKtGYLcDzFTrMecdGBGijZFcAPM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rbUn9SKwDHp1HnMc5Rwmuj8pd7OPJ1eYsslIlozcROIyUyZ8Tq5HC3UnmHryYhbvh
         8KmDJqmkXFAaU8vFyyBUq9v0c/+5HLO7BcweH1a7W6876aWgM+07FD+08zqA5md1WM
         u0VxHVAio60IAAhpPh9WP0fF1F3sTfzz8O47u9zxdj5itI2MV0Q+Q/qmRo+ieedWiv
         kM23Tq3eaRDGuo6z9gQ90DrYON6Nt3P0kn2O5Xs7/X23et4r4umNii3G4L6fCNTvJi
         Jk8cuoHTY5QNzxWzsgVcefdU06HjMHpDtUY57i9SVf3BKbuqZmB3Ar/56o2wCGsXJD
         gJwKp0wpzoHTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF5A2C43162;
        Tue,  1 Aug 2023 11:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3 1/5] net: dsa: tag_qca: return early if dev is not
 found
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169088822271.3908.11780275328908049417.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 11:10:22 +0000
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
In-Reply-To: <20230730074113.21889-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yangyingliang@huawei.com,
        rmk+kernel@armlinux.org.uk, hi@atinb.me, michal.kubiak@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@corigine.com, florian.fainelli@broadcom.com
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 30 Jul 2023 09:41:09 +0200 you wrote:
> Currently checksum is recalculated and dsa tag stripped even if we later
> don't find the dev.
> 
> To improve code, exit early if we don't find the dev and skip additional
> operation on the skb since it will be freed anyway.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: dsa: tag_qca: return early if dev is not found
    https://git.kernel.org/netdev/net-next/c/de9db136dcc3
  - [net-next,v3,2/5] net: dsa: qca8k: make learning configurable and keep off if standalone
    https://git.kernel.org/netdev/net-next/c/23cfc7172e52
  - [net-next,v3,3/5] net: dsa: qca8k: limit user ports access to the first CPU port on setup
    https://git.kernel.org/netdev/net-next/c/18e8feae4a80
  - [net-next,v3,4/5] net: dsa: qca8k: move qca8xxx hol fixup to separate function
    https://git.kernel.org/netdev/net-next/c/a9108b0712bf
  - [net-next,v3,5/5] net: dsa: qca8k: use dsa_for_each macro instead of for loop
    https://git.kernel.org/netdev/net-next/c/01e6f8ad8d26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


