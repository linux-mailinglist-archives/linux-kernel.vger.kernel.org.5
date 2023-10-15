Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44B57C9933
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjJONkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJONkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:40:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD14A6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3734EC433C8;
        Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697377223;
        bh=6Mewa66v8BFCchHUq3fJshoDXWM7XvqrgL6LOYfNQ5A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D3XCGPD7hW8kYrTPpM3j/FV684hSxNCdzR68EEKgdmGKo4/IMY1NjVw0E5XeIRzTl
         nUNLyqFGY8ENnHfbYa5jCjY1D/DXwkUozUGcR2X1TaGM5wCUa51++tCcwilSORamAd
         kIrrGvpcTqa3fHR7p/g5r1mIM0g70897IMU+Ll6lqPFYPgqnX38RPrN7VRyNvOfrGJ
         myjVkiHGuUf4vBfvv8pBU49Q0Z9NujCptSHdaxLLOVTCTZRmjymdZndVP0q2fv9aYJ
         UOxLuGoJTm3zMGR3lU/5X1NgKho1V19gjGhue79drxXN9f0ZIYZOLIpolXljY1pady
         1jonfls8tmvFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F6A5C595D0;
        Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] i40e: Add basic devlink support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169737722312.30429.981395182996753709.git-patchwork-notify@kernel.org>
Date:   Sun, 15 Oct 2023 13:40:23 +0000
References: <20231013170755.2367410-1-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 13 Oct 2023 19:07:50 +0200 you wrote:
> The series adds initial support for devlink to i40e driver.
> 
> Patch-set overview:
> Patch 1: Adds initial devlink support (devlink and port registration)
> Patch 2: Refactors and split i40e_nvm_version_str()
> Patch 3: Adds support for 'devlink dev info'
> Patch 4: Refactors existing helper function to read PBA ID
> Patch 5: Adds 'board.id' to 'devlink dev info' using PBA ID
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] i40e: Add initial devlink support
    https://git.kernel.org/netdev/net-next/c/9e479d64dc58
  - [net-next,2/5] i40e: Split and refactor i40e_nvm_version_str()
    https://git.kernel.org/netdev/net-next/c/7aabde397683
  - [net-next,3/5] i40e: Add handler for devlink .info_get
    https://git.kernel.org/netdev/net-next/c/5a423552e0d9
  - [net-next,4/5] i40e: Refactor and rename i40e_read_pba_string()
    https://git.kernel.org/netdev/net-next/c/df19ea696644
  - [net-next,5/5] i40e: Add PBA as board id info to devlink .info_get
    https://git.kernel.org/netdev/net-next/c/3e02480d5e38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


