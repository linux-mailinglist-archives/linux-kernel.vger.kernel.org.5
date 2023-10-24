Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ACC7D4C74
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjJXJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjJXJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D660F30D1;
        Tue, 24 Oct 2023 02:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A348C433CA;
        Tue, 24 Oct 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698139823;
        bh=/K67zN9KD+hd62et4aqubU4Up8mDmO4SmA8qCGpWotc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DD71QzUe/E4YmJFDhc2Tqk9q6pegHTnMspnQM2xZEsM0dlOsmQwckbS9OH2Zf+EoK
         6T5klBlTsp8RiD8xGOv91cND5NsH0W8QbuIWGrxCp6zDJjRE1Ba07vLqD9Q4+rvZoE
         Ct0vBYPKvLICP+0ikJtDngcCgdBxAlnOTnBQlFuC4ClxxiLg+vRIe93sj41+EfNhKA
         hc8FTLi/pHRatabJVZTX43uQGnbtCf3BPFbsDMV5aciWAZoJCcfrkbDz9zO+a5NGU/
         00Th3xOZndReHD/rp9iIz+rMKMIg1k6RQ79s3BU1okJG+uZ3dJMxawsdKIB9e9Bv7c
         ikOsLO37Fo3Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4A26C3959F;
        Tue, 24 Oct 2023 09:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from Device
 Tree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169813982293.23458.3683909591766240051.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 09:30:22 +0000
References: <20231022151911.4279-1-aford173@gmail.com>
In-Reply-To: <20231022151911.4279-1-aford173@gmail.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     netdev@vger.kernel.org, aford@beaconembedded.com, andrew@lunn.ch,
        grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Oct 2023 10:19:11 -0500 you wrote:
> Currently there is a device tree entry called "local-mac-address"
> which can be filled by the bootloader or manually set.This is
> useful when the user does not want to use the MAC address
> programmed into the SoC.
> 
> Currently, the davinci_emac reads the MAC from the DT, copies
> it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> it by reading from registers in the SoC, and falls back to a
> random MAC if it's still not valid.  This completely ignores any
> MAC address in the device tree.
> 
> [...]

Here is the summary with links:
  - [V2] net: ethernet: davinci_emac: Use MAC Address from Device Tree
    https://git.kernel.org/netdev/net-next/c/f30a51a41828

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


