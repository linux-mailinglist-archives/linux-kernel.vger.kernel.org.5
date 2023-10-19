Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938B7CF63D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJSLKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjJSLKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:10:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E835119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D1E5C433C9;
        Thu, 19 Oct 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697713823;
        bh=x7Vilo7RVB7QrsjGzn3PXT/f0rYR4arJfWxCuscoZPg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YUHwUD67GFqAZErgK2PsBHJHYFywVrz/3RhS5IEsXOBhnpObUjzKkvLNaOtp5U8PH
         5qV3dkDsiIpjPosl+ExsOGjAv02lBzl4rktcyBzrsmY1Dl5kJxigayP0/hAT9RWXi7
         +TlrgPH+Esr+o2otftIZx/jLKIHWDA1SrvmBGIHJ4mXfsjRxjSnkjhDOdHV20U/0mp
         J1YqNXbDq9DlnhU/kJ5cgBZHJyDbQKjvQzUeenAlUsM49LAXf+23EbAJZQ1CbMiA5f
         HY2r6vjAYmxKQUa80Lf+8GBRqZqYErF5gH/DG16bghgwzikGuY0d1bPVQdd4dgvLK+
         Wvt7h5lnXul0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E8FAC595CE;
        Thu, 19 Oct 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: stmmac: use correct PPS input
 indexing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169771382351.28433.15969551932352859252.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 11:10:23 +0000
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, kurt@linutronix.de,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, vee.khee.wong@linux.intel.com,
        tee.min.tan@intel.com, rmk+kernel@armlinux.org.uk,
        bartosz.golaszewski@linaro.org, ahalaney@redhat.com,
        horms@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 09:09:52 +0200 you wrote:
> The stmmac can have 0 to 4 auxiliary snapshot in channels, which can be
> used for capturing external triggers with respect to the eqos PTP timer.
> 
> Previously when enabling the auxiliary snapshot, an invalid request was
> written to the hardware register, except for the Intel variant of this
> driver, where the only snapshot available was hardcoded.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: stmmac: simplify debug message on stmmac_enable()
    https://git.kernel.org/netdev/net-next/c/3fba82343955
  - [net-next,v2,2/5] net: stmmac: use correct PPS capture input index
    https://git.kernel.org/netdev/net-next/c/7e62ac24b57a
  - [net-next,v2,3/5] net: stmmac: intel: remove unnecessary field struct plat_stmmacenet_data::ext_snapshot_num
    https://git.kernel.org/netdev/net-next/c/1dbfe73bd648
  - [net-next,v2,4/5] net: stmmac: ptp: stmmac_enable(): move change of plat->flags into mutex
    https://git.kernel.org/netdev/net-next/c/7d3077482578
  - [net-next,v2,5/5] net: stmmac: do not silently change auxiliary snapshot capture channel
    https://git.kernel.org/netdev/net-next/c/2ddd05d1d5ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


