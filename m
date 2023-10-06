Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1717BC2BD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjJFXAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjJFXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:00:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE9C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 120BDC433C8;
        Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633225;
        bh=MI+XKg/LdzdUZV0k2jCaAZ13tSOTPvUQCpOe/gCDRcg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LfYmjsJfGP3PP1t6b4RnoeNCs+o3KJh/297MaVZ5S3yQ5HHzps8kILGLG7ZYRLnoB
         rGDj75ao52iXZQcEWnSgZnY8SSGsBEUPEhJsReGcDxg51PmgiWYtceeoHav/TSJtF+
         g3i9msA+/g6yMPYlZt5H/XLP3Q0kanZ7lJuz9GyXpFj6bp4xnGrnyL5VmgZ/H71Vxe
         jNxSqKa7/I9kIup4NVWHDefYCLCnnO2esdyEf3M/h0CZnfWVgaZIm5ESCoyVtbyXrq
         KaRDt4Yz5Z0z6NQgepN+aVIcRYGMa4y+LVHgZGfFrBPPJ4URSPRQMu7nwJ5rtoUB5t
         JWbgLFLlZx5IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC89FE632D2;
        Fri,  6 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] devlink: Hold devlink lock on health reporter dump get
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663322496.31337.14047004680576589561.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 23:00:24 +0000
References: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
In-Reply-To: <1696510216-189379-1-git-send-email-moshe@nvidia.com>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        jiri@nvidia.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Oct 2023 15:50:16 +0300 you wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Otherwise, since devlink_mutex was removed, this
> callback is not protected from a race of the reporter being destroyed
> while handling the callback.
> 
> Add devlink lock to the callback and to any call for
> devlink_health_do_dump(). This should be safe as non of the drivers dump
> callback implementation takes devlink lock.
> 
> [...]

Here is the summary with links:
  - [net,v2] devlink: Hold devlink lock on health reporter dump get
    https://git.kernel.org/netdev/net/c/aba0e909dc20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


