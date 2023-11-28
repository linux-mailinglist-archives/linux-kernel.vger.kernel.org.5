Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA97FB8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjK1LA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjK1LAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:00:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6CA10D1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5A0DC433CA;
        Tue, 28 Nov 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701169226;
        bh=QOg3KVTER4epeAO54p/axbPEeNoukAl/3jVlyfyz5pA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LFFLS0Xz8X0pIlB57Xsfgt90E0QExzL9hJa7HWEiUpc/HddEdCCyjz71sgEgiJCOc
         GOEC22grZxMqOGDRg3tSAi1xhuQgzATZwyFefdVM9ucxBp+PJ32S7suBas2iy72Z4s
         xc4ZHLzkfPU1O/4Ru/wkKxQLcQfiKsRmpMw/XMuJlvhoxCJkbAY0rQz5dTqjsBAjFu
         1yv3HBx0s3ZVuu1l+JePwYNYUBvmSbLZ9Q7ocrQ1nz587G+oLXJs81jaNAXEWarh23
         eDcPkd1CnJ+Otl2VBGnqrFK5W0I663nqwFD66RQwpDnIX6dzY8+7CVxpTJbSH/czjC
         tVT1Qxlnf1zeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C79DCC39562;
        Tue, 28 Nov 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Disable FPE MMC interrupts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170116922581.4807.10674635347082642377.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Nov 2023 11:00:25 +0000
References: <20231125060126.2328690-1-0x1207@gmail.com>
In-Reply-To: <20231125060126.2328690-1-0x1207@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, jpinto@synopsys.com,
        horms@kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, larysa.zaremba@intel.com
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 14:01:26 +0800 you wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled, FPE MMC interrupts can cause the same problem.
> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: xgmac: Disable FPE MMC interrupts
    https://git.kernel.org/netdev/net/c/e54d628a2721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


