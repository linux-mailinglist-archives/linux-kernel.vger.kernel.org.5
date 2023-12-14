Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A4812D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443746AbjLNKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443734AbjLNKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:50:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9C10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:50:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A038C433C9;
        Thu, 14 Dec 2023 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551027;
        bh=SXb2V+uKEU2n7t6G6weVcddYl7DHNgyGn9EjuAISZ7Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PMs44FOKJKKcMWG467I+UZQgz3KFimsU98HZCl35q+mJO5LR67yFuO82gv1ydWkez
         De5Nc9B950jcxgWtUGAbw4AXWLCRYDmTg3cckGFSKJV84PbaaFJrl85B+OZ4FYR2gW
         fJYj3gg9/cmcYZtmKOfI11348XmFmE4VL6Pv4sfBDbKw8eNWiEfrW/e7BbizKNsYTw
         7lrotZL3Lp/6ciGzPs/O/+wGHtX7D+mwyBdSNJ6mymn9I/bs+rYUy92kYSlcmD2tH8
         qKsGvLpap5Vo9be4H8AA1VYxT2t3bW0oOtF0oxLiClwGX/W1etEdfoLuPyEHYQeY22
         nQe5z3zxtHx0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E93C1DD4EFA;
        Thu, 14 Dec 2023 10:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII
 RX
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170255102695.29358.13778143091773009121.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 10:50:26 +0000
References: <20231212092208.22393-1-quic_snehshah@quicinc.com>
In-Reply-To: <20231212092208.22393-1-quic_snehshah@quicinc.com>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     vkoul@kernel.org, bhupesh.sharma@linaro.org,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, ahalaney@redhat.com
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

On Tue, 12 Dec 2023 14:52:08 +0530 you wrote:
> In 10M SGMII mode all the packets are being dropped due to wrong Rx clock.
> SGMII 10MBPS mode needs RX clock divider programmed to avoid drops in Rx.
> Update configure SGMII function with Rx clk divider programming.
> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII RX
    https://git.kernel.org/netdev/net/c/981d947bcd38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


