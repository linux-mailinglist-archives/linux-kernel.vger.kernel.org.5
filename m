Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E077C4CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjJKIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJKIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58AEBC433C7;
        Wed, 11 Oct 2023 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697012425;
        bh=xhjx77AOww0zaMqOJztfw0YnYbpmxbJJ3eRelw351Rk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g1yMgPqW29fE2pSOFlR91UkuVCsWgkoGyj87OwRCsaQvnqoaNclWRVWK3ykG1qN5v
         4Y6e9EMIGQHBOk2eyANbGbUrbdtkC1AZSANTpyE9NLPCQ8XhzOQD8yHfmmO0XEWYE6
         AXnq2HoEqwkRTmOJnmOycztNQ62lsvTIVSfGmRTIRV1bgZO0Dt/6HwcTN0efToSTrM
         3/5ElagCHsaSuL1XJlz2+54M0r/9NXsExPaiDloPKTTIsJ6zDL3NXdcczi1QR5N68P
         XY1y85vOzK54ZP/9wAbfCYtupyOeTUXngzyI0nEIoxDar0egeVA2vfDnBeKEiW7qvr
         TNBkrJN3T+nbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40DC0C595C4;
        Wed, 11 Oct 2023 08:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] hv_netvsc: fix netvsc_send_completion to avoid
 multiple message length checks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169701242526.2065.3732761512312039309.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 08:20:25 +0000
References: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 01:00:16 -0700 you wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
    https://git.kernel.org/netdev/net-next/c/9bae5b055022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


