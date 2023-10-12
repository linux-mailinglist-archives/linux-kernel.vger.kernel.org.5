Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF87C6853
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377857AbjJLIAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347098AbjJLIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC283A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 920A1C433CA;
        Thu, 12 Oct 2023 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097625;
        bh=O882kTatJUIM5yahWX6nBR4fl+n08XtCK8x0rge5Tzs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FoEoRUpv0D/OgBLUrBqYj0zvAa8cLdYa4aesDkNN/CeguSM7ockT2ygBguR3kffJk
         RTuEpwLWJ9dvFLWJ8wjDbQG4dqK+gdzA/2qWoSSfQEqb5PwKgiSO0xlKoZ2zbkvz8w
         QQuT3vMQm0rGns1FVYQ1/Recy/KMD+xqa1x+LntRTWrU4qrEU3/M9DYcOXBOjzP/9W
         i/1X5aqRWQet/Umxi0ubGBgraESv73mqBgFQeKtsq7IpfrEkKoSFBhN2OcgBHsTh+t
         Wz+iczAEVc4WNltH+Q7iE4OxhRUdULEp36nQKGnoFBrGRmN+POxWpz5G3ZXPYVlNzd
         A1D36YHcjGwbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76684E11F70;
        Thu, 12 Oct 2023 08:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool frag allocation warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169709762547.19292.7784236842180734581.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 08:00:25 +0000
References: <20231010034842.3807816-1-rkannoth@marvell.com>
In-Reply-To: <20231010034842.3807816-1-rkannoth@marvell.com>
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Oct 2023 09:18:42 +0530 you wrote:
> Since page pool param's "order" is set to 0, will result
> in below warn message if interface is configured with higher
> rx buffer size.
> 
> Steps to reproduce the issue.
> 1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
>    value 8196 cmode runtime
> 2. ifconfig eth0 up
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: Fix page pool frag allocation warning
    https://git.kernel.org/netdev/net/c/50e492143374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


