Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF27CF55A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbjJSKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJSKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:30:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4AFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C948C433CB;
        Thu, 19 Oct 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697711423;
        bh=ISlzwNBz4S/jH+y76V1s9eoZT46G5gS6n3EopdgQWHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MS7usoPGfOXtFgpfdTA4GpSCDCKwDC2R+9mnJT0e3cISZPXFPK8kFSxrbYKmZDQJy
         x1t4PYCaUCYoh1mdWlO2za66uoHDtV0qEkYR+h5ynkiCbVv8HHgB7DBIe6tKs5TUP5
         Or6bJeHYQ+fEZuUjC1iNcEN+huiuJcmH9j0R6NcxcyDNCbLQfuwXwsUTFS3NZhQCW1
         TJWyV6/FhXtxRP0rfhTqdVhSH9IQTE1YJ97Hz1yqyGtM5I0RPSBwDIEablfKGrQZB9
         TlJnDwH8ZaS4efuYH+BuXpr5F/3D4h7m00/3Mux7Bv0SjxXVAg8ufvMzr2V+4mKdzF
         4rRqsIp945Ivw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51100C73FE1;
        Thu, 19 Oct 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Remove redundant checking for
 rx_coalesce_usecs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169771142332.4277.11760009172331855104.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 10:30:23 +0000
References: <20231018030802.741923-1-yi.fang.gan@intel.com>
In-Reply-To: <20231018030802.741923-1-yi.fang.gan@intel.com>
To:     Gan@ci.codeaurora.org, Yi Fang <yi.fang.gan@intel.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hong.aun.looi@intel.com, weifeng.voon@intel.com,
        yoong.siang.song@intel.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 11:08:02 +0800 you wrote:
> From: Gan Yi Fang <yi.fang.gan@intel.com>
> 
> The datatype of rx_coalesce_usecs is u32, always larger or equal to zero.
> Previous checking does not include value 0, this patch removes the
> checking to handle the value 0. This change in behaviour making the
> value of 0 cause an error is not a problem because 0 is out of
> range of rx_coalesce_usecs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: stmmac: Remove redundant checking for rx_coalesce_usecs
    https://git.kernel.org/netdev/net-next/c/392c226cda94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


