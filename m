Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C142A7B4B60
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjJBGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJBGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B024C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3096C433C9;
        Mon,  2 Oct 2023 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696227625;
        bh=wXzmAfRshjqAnDdD5iHtUmmoeWAJ02bWuV6zzoV/B0s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TH4iD6OOE0tOITdK4gCSwJ7EgpBJ7StewarDgDmFfEXYpWaDvwlctIZEbA0fnu7jO
         WvIaaY+4MGz4FSNRTp8O+Ylr55jODK/6lAjy0UNcRF+u/zb1WcM+184yRdBJ+KurjR
         sF2a2Mr0+vcYTnpyi1xzAhFJJIWa8iJAje1q6PFQl731l2YcdR6/UYvc5fSHtM5E83
         /KHExxHBjHE6pKzwfxGSgSv8LKzNMeWSeSBAzktPVGaU/4zhCMbb3mnbOBUeXRuXJw
         TGeqdlhkLVLHlRH17A3RrDYQwkcR5gWjVrwCBZQwzvStvfdq75tLbd+oPsYS0i35TX
         3fiUFUniJLqow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBF47E632CD;
        Mon,  2 Oct 2023 06:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Fix error handling in ptp_ocp_device_init
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169622762489.27578.3892409434532929889.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 06:20:24 +0000
References: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 22 Sep 2023 17:40:44 +0800 you wrote:
> When device_add() fails, ptp_ocp_dev_release() will be called
> after put_device(). Therefore, it seems that the
> ptp_ocp_dev_release() before put_device() is redundant.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Fix error handling in ptp_ocp_device_init
    https://git.kernel.org/netdev/net/c/caa0578c1d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


