Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF27B6D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjJCPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7BA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EA2FC433C9;
        Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696347626;
        bh=QWYGNwW/V1wgTpFxNGUJLG1mfQOTAYw6SAsIRoE2RfI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y6CeS+lYmvPOXnDYZZ57DjGCLW5MEq1zryjvdGyIuYNGAzTIhz+rKNY6DTeRwg7QF
         o3+pissUnap5Ch9BLFkEk3rljDjtYq8fRWyO+WLx5EzgLXh5sw0Y188mAMOk3m4Vau
         xT/Q1DRT5mxjJcq5uBRZBX+wzK0vd6YGD/4YxM5fuM+Fa3i88frJmh+1jIkuOlS6c5
         4T0A3lzh6FTt+23O6jgcGYVRd5yAyJbTU1BQToRi5be+GmAeBeQw4NQ58gJfEjAQKj
         OoLWD33YyfFuo+kmDkdxaBSI+FSJUO5AEYzHTlFmCUhTFrcYxCfzIK8Kfj3R2trkNk
         FcsWYMQ5KUI5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25E82E632D0;
        Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169634762615.3806.18178372938217488177.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 15:40:26 +0000
References: <20230908235853.1319596-1-jeremy@jcline.org>
In-Reply-To: <20230908235853.1319596-1-jeremy@jcline.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
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

On Fri,  8 Sep 2023 19:58:53 -0400 you wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> [...]

Here is the summary with links:
  - [net] net: nfc: llcp: Add lock when modifying device list
    https://git.kernel.org/netdev/net/c/dfc7f7a988da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


