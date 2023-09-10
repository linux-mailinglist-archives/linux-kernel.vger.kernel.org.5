Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA320799F55
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjIJSab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjIJSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B416A19C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31250C433C8;
        Sun, 10 Sep 2023 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694370622;
        bh=mZ54+PLc9IhlxDCovXeQUxgZe/yoX7FCotx5+2XnyxI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hGjYraTNgwz9pL5z1mc0tIopgmeUev+KZjP5U+GpiZtmlzqFJB2+3EIDF4uC7GkYy
         +8Xwh47ggzWpGGP8nvCEuJ+0WwFJCb3N3+xP29hO+68Ncdja8nm1zUywZaJw5ZWkrW
         2yeM9qVOZTD90D4w8WtFW+fjZi/tvAKlirIDXd9+42tXBqysV1cK3Jh5ABla+GYyIi
         B+sqGbeKsJpC0fmu76xy9YsHCEpwoprB9u/0GlxM26Rcie0d6mjXIJYrd8KdQTakvl
         K6BLEo/R9qyL9da+1yUfXcxoD7mcnzLXKMGOw7kwZjWMWa/8EvsDQCBAHnSvenwzGk
         bxk430cmkMT4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17947E505B7;
        Sun, 10 Sep 2023 18:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool cache index corruption.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169437062209.3953.12683727128957272697.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Sep 2023 18:30:22 +0000
References: <20230908025309.45096-1-rkannoth@marvell.com>
In-Reply-To: <20230908025309.45096-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com, bigeasy@linutronix.de
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
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Sep 2023 08:23:09 +0530 you wrote:
> The access to page pool `cache' array and the `count' variable
> is not locked. Page pool cache access is fine as long as there
> is only one consumer per pool.
> 
> octeontx2 driver fills in rx buffers from page pool in NAPI context.
> If system is stressed and could not allocate buffers, refiiling work
> will be delegated to a delayed workqueue. This means that there are
> two cosumers to the page pool cache.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: Fix page pool cache index corruption.
    https://git.kernel.org/netdev/net/c/88e69af061f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


