Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB97B8E12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbjJDUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbjJDUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:30:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B9AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFB1C433CA;
        Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696451426;
        bh=oh6xitWr++z2BIqUUKyYoq+1pyDthWDaQ3PK0sgNako=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oMGKvZpaBvxQD5YCtn1K/jw3uH/X/6jhyla+2+lhS/thzFy1z3Vi8G/IULw6tvG2t
         hUEntopqfUzCM3+aPTCZAwiTzrQA7iM8LMHghGXBtdTaKsDXq0YPOKXZegP23kquuO
         wr2sQvl8dwgBPO6cmvLLBhd5PquqD81YH95HPOOy14dDELpzZGiNo3PDvTLcj55SGr
         YHN0hoH14q8XYeC8/0GjrCGdIkk/n30j99naw/itrcWe+6il3pXuW1m33F8wCDUDYV
         38SRCwhm70/AKDGxZIXfau/9EqfKgai87WJ/ybXTO/swyYAMu781SZbh20h6LAKk7m
         nviI9wY12MDYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F697E632D6;
        Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645142664.7929.9991674504549336321.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 20:30:26 +0000
References: <20230927181414.59928-1-dg573847474@gmail.com>
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 18:14:14 +0000 you wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> [...]

Here is the summary with links:
  - tipc: fix a potential deadlock on &tx->lock
    https://git.kernel.org/netdev/net/c/08e50cf07184

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


