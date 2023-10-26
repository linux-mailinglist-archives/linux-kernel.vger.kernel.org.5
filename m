Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DD7D8BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjJZWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B61A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0EFEC433C8;
        Thu, 26 Oct 2023 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698360626;
        bh=Zy6E/Q+H/X4NEFmVkmaU5sDSLwMcCrTBPG8UA9Z56SA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ltSS0b8OUBWJWGGCafuNFvnu/DsT/hpkrV0Q9pd9+6gqnIOppUomQysr3EJZjkzrX
         DN/o/Ft937+AlDTjC00qRoP3Nb6RcVSW8Cg92lBKeE74y7NfQEstTbh4EY1UdZm517
         d2Y7hYAgTpVfQ3AAxnyKSIC63JWoJl+0+LXnN8C0kHfohj7rVtetGWenldURKd7xOC
         coLa2U29MQHxYSbdRkV7yHBzemtWlQOsmIXZcBdxVjpdAb7/Fc63o46G+XsWVAhZ6p
         aMRMVoGZeTpeTmPfLAeUHdX1yKE/olO9TORSGuGqmMQEU6HE43ZendWhVW6bqV0AAx
         mJECl08JoBMcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A39EFE11F52;
        Thu, 26 Oct 2023 22:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169836062666.25008.3760960827662370668.git-patchwork-notify@kernel.org>
Date:   Thu, 26 Oct 2023 22:50:26 +0000
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jiri@resnulli.us, linux-kernel@vger.kernel.org, leon@kernel.org,
        tariqt@nvidia.com, danieller@nvidia.com, idosch@nvidia.com,
        petrm@nvidia.com, moshe@nvidia.com, eranbe@nvidia.com,
        ayal@mellanox.com, horms@kernel.org, dan.carpenter@linaro.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 16:50:50 +0200 you wrote:
> Avoid use of uninitialized state variable.
> 
> In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
> to still collect other data than bail out entirely.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
> Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: fix uninit value use
    https://git.kernel.org/netdev/net-next/c/5af8d8ce6434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


