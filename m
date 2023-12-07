Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3A808FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443704AbjLGSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443669AbjLGSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555BF1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:20:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2DB0C433CA;
        Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973229;
        bh=LDm1+QHR8otPnvd5qanmORyB5Bf/LNhiYArxQO95HWE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f8lO6UP1Sqq41OawP3hmxO8XqLS5s4UDhBRVSnBqbluAh1Ie+BOkuf9+Wmn4+fFkP
         eyqdiS8t/eXheGxPdwxOoL+zK8fiQ4H8W66NyhFdCph2J/BQDtDAgpQxD7Ck2zEXwe
         yMaas11FNBS9gONxXvmfHXU/6BPEIe1IWulwoDjJH2SW2O3/6MaeS7j6TSdK+cSsXr
         EBCVF3PC3owTnoTvD+kecJ7iy7twB8eJMgd9Jz5XjBGAPShyhWnh/TdpPTAP946WLm
         fEX4k3dvbdQinHMt6ryFbv+1CDhzFWbZwgk5PuTa6woiMzWUSy+oDL/Ya35LTGXqT3
         0Ub9j3sE+hOdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D76C7C40C5E;
        Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix missing byte order conversion in CLC
 handshake
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170197322887.20147.8322709345682789955.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 18:20:28 +0000
References: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, ubraun@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 01:02:37 +0800 you wrote:
> The byte order conversions of ISM GID and DMB token are missing in
> process of CLC accept and confirm. So fix it.
> 
> Fixes: 3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/af_smc.c  | 4 ++--
>  net/smc/smc_clc.c | 9 ++++-----
>  net/smc/smc_clc.h | 4 ++--
>  3 files changed, 8 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net] net/smc: fix missing byte order conversion in CLC handshake
    https://git.kernel.org/netdev/net/c/c5a10397d457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


