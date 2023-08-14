Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4983677B21A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjHNHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjHNHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE70E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C09562F9E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67F33C433D9;
        Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691997023;
        bh=HVwZ5wQmMpQjBYIgbnBdLCimB2FJTBsZAHAd8NHFlwU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D6N0ZqGBtjjYTYg0BF0LJnUeCjtg4w3jWMYjtw95+kfNBjRFWx5QaHFRpbQM8IdRa
         ytiRdQFPHo9pe/GESoSk5fhjP1RjVDtqKJhAew4iFqQaSHBgKYPgg6CWANE9xTh/ZD
         vbQe6jQwufRhXDioJqe2ObFcC++cB0HT1ElEK+VoI0aO9Fy6r9hN9wPEUTHsd4q2cI
         CYhiJl2Lvsm4mY4G7Nwj5y+evn9AhXRzDZXoZpH6tPW+MpiHBfFM7coiy86B0fe+9A
         NOVsmpYrWaGDY4v03RvUpxwyiG4Rl/iD6tY5IubxpvYJe31RpA1zjP/kS7WRezAxO0
         qCbCFCsh4oywQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DBFAC395F3;
        Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: stmmac: xgmac: show more MAC HW features
 in debugfs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169199702331.11756.17114238819765963207.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 07:10:23 +0000
References: <20230811125139.284272-1-0x1207@gmail.com>
In-Reply-To: <20230811125139.284272-1-0x1207@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, jpinto@synopsys.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 20:51:39 +0800 you wrote:
> 1. Show TSSTSSEL(Timestamp System Time Source),
> ADDMACADRSEL(additional MAC addresses), SMASEL(SMA/MDIO Interface),
> HDSEL(Half-duplex Support) in debugfs.
> 2. Show exact number of additional MAC address registers for XGMAC2 core.
> 3. XGMAC2 core does not have different IP checksum offload types, so just
> show rx_coe instead of rx_coe_type1 or rx_coe_type2.
> 4. XGMAC2 core does not have rxfifo_over_2048 definition, skip it.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: stmmac: xgmac: show more MAC HW features in debugfs
    https://git.kernel.org/netdev/net-next/c/58c1e0bace59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


