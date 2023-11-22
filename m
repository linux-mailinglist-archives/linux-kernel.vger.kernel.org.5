Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283B7F3B82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjKVBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79910C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 294B7C433C9;
        Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700617823;
        bh=ytwSLqGynDoxV3L8iE9r2IClifLUP14wvoD8499FKVQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lKFkl7MdEVR7qGp1syXYGejcOz6XMvPmUT2MAP6Nw+Jno0b4llFUGUrwv0HFcLZ+8
         k1wRmybSeLl4j90Xwnb0R8+ZyZfNFHFHrzvA+zPuuDpPtYDQ9+axWl48ZJz2lPEvxq
         lX6KP1y4wa5ASs+aMtTsN+aSjE17vshV6lPQEfy/HJjaZumoVrbYoTZ20KjPsaxZZk
         Mw1GIlm8j8B0ZDILW+PY9novEg73+Tg1hwbR/7ODIC4rJD78uXTv4FvAhVS+BoiLwF
         EZBwYmVF/8nwyBB2qc345+A5524P0W2lniy8aRoVJkdZEil2zyEx+bhP+PO66yXBsJ
         OYzpMme4QBRsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DFCCC595D0;
        Wed, 22 Nov 2023 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dpll: Fix potential msg memleak when genlmsg_put_reply
 failed
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170061782305.9000.12246694056316498356.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Nov 2023 01:50:23 +0000
References: <20231121013709.73323-1-gehao@kylinos.cn>
In-Reply-To: <20231121013709.73323-1-gehao@kylinos.cn>
To:     Hao Ge <gehao@kylinos.cn>
Cc:     vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
        jiri@resnulli.us, michal.michalik@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 09:37:09 +0800 you wrote:
> We should clean the skb resource if genlmsg_put_reply failed.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v1 -> v2: change title due to add some similar fix for some similar cases
> 
> [...]

Here is the summary with links:
  - [v2] dpll: Fix potential msg memleak when genlmsg_put_reply failed
    https://git.kernel.org/netdev/net/c/b6fe6f03716d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


