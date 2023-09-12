Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6FD79CCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjILKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjILKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BDF1980
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E14C433CA;
        Tue, 12 Sep 2023 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694512825;
        bh=DGowEOYUWbmWAlu4sfavxnuNY8MphrKdfJFFwomgHbc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G8p/fsq3Ie8NLsY5qc2I0IpfNSluzjQTGLKJEPRg1fuxmEdlEGvx1kfcWdDu//g0A
         uiMj7oPaQ9+5b1qzb9AoAC5Jp6y3iR/I1VfGj9v5c2ZOUDC752QRuh1miZ1a5mq5yz
         uBZKLGLgyOHdYEQTm0yY7Up09sk6BS+Pzoe2avynMy+mvefD1uO4zdSa6nxwXycmV0
         06WeGuCh0zRGCJx6oEyteNBhTQo2rb8WilmGBPHTWcBChsuWxpza2NkXwnKLJK6bw7
         NvIjDDl37yBTx6auDo9vkeSG9MVFXfOD0DRL/qnYWpXPsPI65WsjWOlbk6m85lzzrj
         CKkpbBoLUgPew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7F0DE1C282;
        Tue, 12 Sep 2023 10:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] wwan: core: Use the bitmap API to allocate bitmaps
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169451282488.7239.12895349010079709401.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 10:00:24 +0000
References: <20230911131618.4159437-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230911131618.4159437-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     haozhe.chang@mediatek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 16:16:18 +0300 you wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] wwan: core: Use the bitmap API to allocate bitmaps
    https://git.kernel.org/netdev/net-next/c/cd8bae858154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


