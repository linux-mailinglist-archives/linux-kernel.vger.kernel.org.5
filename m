Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C47D4BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJXJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJXJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46F118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F203CC433C9;
        Tue, 24 Oct 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698139223;
        bh=zF2/iQq0LgEinTw9z1FURusMG9SsNO7Ov6RH+huvW8U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ocaz5KYDczYkRstA0gUbGfpRGgNnId2OYdmsYMbzOMxOQI2r+XCFZuuAjrvoQ+iS1
         30t58Qb2roxv5njqPdLTfO4MK0N8PXV2cYs6UsWtZjgxOKP8XajXtnshLAAJ4YeHAB
         Ufktd2XZX8PgtrFBCGDbnYRZZMI7oEqoEz0JeEjeHkwV8XPzDKC92K2bJ7HAg8wfTz
         ZkyoiloKuSaxeuOESb+mvFSvvmlvkjN0CA8IilAh+BSxczvDSflB2aPca+2Qt325Lo
         NgZz0RDHNJfu035Hz/FgWg5pp89yE4rfVC9OkXnqTp9LRjKg/OG/9TpSyaOtXwOe8m
         6lm+VBfBmpvWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8EE6C3959F;
        Tue, 24 Oct 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Fix NULL pointer dereference in cn_filter()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169813922287.17100.10372385661953821118.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 09:20:22 +0000
References: <20231020234058.2232347-1-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20231020234058.2232347-1-anjali.k.kulkarni@oracle.com>
To:     Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        Liam.Howlett@oracle.com, netdev@vger.kernel.org,
        oliver.sang@intel.com, kuba@kernel.org, horms@kernel.org,
        anjali.k.kulkarni@oracle.com
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Oct 2023 16:40:58 -0700 you wrote:
> Check that sk_user_data is not NULL, else return from cn_filter().
> Could not reproduce this issue, but Oliver Sang verified it has fixed
> the "Closes" problem below.
> 
> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v2] Fix NULL pointer dereference in cn_filter()
    https://git.kernel.org/netdev/net/c/9644bc497057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


