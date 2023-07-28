Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DE76628D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjG1Dkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG1DkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A6271E;
        Thu, 27 Jul 2023 20:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0013D61FC3;
        Fri, 28 Jul 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F83BC433C8;
        Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690515623;
        bh=j68cQbaROJUzWuEyrIA7FjWkBHFT7+vx0pq6TM5mFdA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jV7NtV4MJomK4uQuDChlFl6SS8gaqadVCPjeSQxFkkILdxMLASvGp+vr6ieXqe9h2
         AoCUQXMrrINJcoIWILnRaeR6YZcJ4HufDazNoQLOXJgdLVZ3akxqmCFjc0nI5u0XAJ
         rSPpADuDOJHPRwWmRazZkhcMVLGpr7qB7asej8LMTjvX5gq6zMTZ4ZKfssWON5G/we
         3onzcCh88/gVMsHC1oOOD2jmuZXjYQZW3HcWBEW/axNBLRtM/5//RWZdHTSVD5CmUz
         MD9fJSJL4Q/k6nJ+241n/CRXcq511JhnjYZ3en7c3qoE8VoYbV/epKx33MiE4g6k0l
         E+0Zc4RcICwAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 354BBC691D7;
        Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Increase clk_ptp_ref rate
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169051562321.23821.5865219947273364361.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 03:40:23 +0000
References: <20230725211853.895832-2-ahalaney@redhat.com>
In-Reply-To: <20230725211853.895832-2-ahalaney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 16:04:24 -0500 you wrote:
> This series aims to increase the clk_ptp_ref rate to get the best
> possible PTP timestamping resolution possible. Some modified disclosure
> about my development/testing process from the RFC/RFT v1 follows.
> 
> Disclosure: I don't know much about PTP beyond what you can google in an
> afternoon, don't have access to documentation about the stmmac IP,
> and have only tested that (based on code comments and git commit
> history) the programming of the subsecond register (and the clock rate)
> makes more sense with these changes. Qualcomm has tested a similar
> change offlist, verifying PTP more formally as I understand it.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: Make ptp_clk_freq_config variable type explicit
    https://git.kernel.org/netdev/net-next/c/d928d14be651
  - [net-next,v2,2/2] net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
    https://git.kernel.org/netdev/net-next/c/db845b9b2040

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


