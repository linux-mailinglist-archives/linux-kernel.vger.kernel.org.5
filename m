Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF57F4485
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbjKVLAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjKVLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:00:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2E1A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54F11C433CD;
        Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700650824;
        bh=6rDBMi5vgLk/ikFlm2Flmd2RJXRdkqlpNTaFELNVkxA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lgJpHh0BBZoQxh5EBJJitx62aSBpmxszlWFaNBqG7sPgKJTuHZxRZXwSnmgXM7wwz
         GrxBiJBRM3ynio2/WZ2hebqMPbBlgLedkmOLPHOdKnVS0lXBTh5SA7/HBK2PCcd/2O
         7N4nc4sYo119ckB1y/i58vJU0FMBgM9AaADWKjpxLH6jteiV12u5zfn34slxz8V4G2
         d8p1hu7L2S9KkpWqBf2Gp4V1+mpj65JQMV7gx/qR44rBt5a/r6xuKLp/YbZW6wW+wD
         stQo6bH8mMg0sME1TJW10vw6fLtfigpxDmWENwhOviB5vEy5V+aa2OI/vygphV12Ze
         4T/3dUzPUns9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38CC5EAA958;
        Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Add support for HW-accelerated
 VLAN stripping
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170065082422.4259.15356814369119039927.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Nov 2023 11:00:24 +0000
References: <20231121053842.719531-1-yi.fang.gan@intel.com>
In-Reply-To: <20231121053842.719531-1-yi.fang.gan@intel.com>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hong.aun.looi@intel.com, weifeng.voon@intel.com,
        yoong.siang.song@intel.com, jun.ann.lai@intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 13:38:42 +0800 you wrote:
> From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
> 
> Current implementation supports driver level VLAN tag stripping only.
> The features is always on if CONFIG_VLAN_8021Q is enabled in kernel
> config and is not user configurable.
> 
> This patch add support to MAC level VLAN tag stripping and can be
> configured through ethtool. If the rx-vlan-offload is off, the VLAN tag
> will be stripped by driver. If the rx-vlan-offload is on, the VLAN tag
> will be stripped by MAC.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: stmmac: Add support for HW-accelerated VLAN stripping
    https://git.kernel.org/netdev/net-next/c/750011e239a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


