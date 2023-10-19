Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963D77CFFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJSQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJSQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1B126;
        Thu, 19 Oct 2023 09:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 812F8C433C7;
        Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697733026;
        bh=alzRBJBaWdAUIW2ABZ3W5+qDNybK9OSXuWMCqmQDjno=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rsnWKQdh1speLpg+8MHXsy7XsxX7M6ydZGHxAQk19/1hfzcU//sAfXck21GHYSgx3
         q4jpKLTVgDOOJXXdfwhBM+u8IEcao7JIMFG1p0+tXB9tUMrFzAqH7LCzmKT6kcEXiJ
         r3j6KzsFOad34HB0lErOrXZP4NNbYAiplql+4NbShGq8znc0n6VO8GFXysuDZaxMSx
         x+qqkseta3fDS6Rb8BhbpCkjxpysdPgwSxKWkvFuEbsZ4bEmtcEZnietEkW6xvPdfK
         ZAP+RMOQBuY5LaWt5FQIX+T7j7AwM/8YZW4zUh8R4uRegfXjgy3EKQQD5dZOs99PLM
         jweuilgZ+yv2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6609CC04DD9;
        Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "ethtool: Fix mod state of verbose no_mask
 bitset"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773302641.11126.3411409282171593715.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 16:30:26 +0000
References: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
In-Reply-To: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
        thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
        mkubecek@suse.cz, stable@vger.kernel.org, linux@rempel-privat.de
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 15:16:41 +0200 you wrote:
> This reverts commit 108a36d07c01edbc5942d27c92494d1c6e4d45a0.
> 
> It was reported that this fix breaks the possibility to remove existing WoL
> flags. For example:
> ~$ ethtool lan2
> ...
>         Supports Wake-on: pg
>         Wake-on: d
> ...
> ~$ ethtool -s lan2 wol gp
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> ~$ ethtool -s lan2 wol d
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> 
> [...]

Here is the summary with links:
  - [net] Revert "ethtool: Fix mod state of verbose no_mask bitset"
    https://git.kernel.org/netdev/net/c/524515020f25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


