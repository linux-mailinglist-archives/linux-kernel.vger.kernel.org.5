Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC4775719
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHIKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHIKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F81999;
        Wed,  9 Aug 2023 03:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB566310D;
        Wed,  9 Aug 2023 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7516FC433C9;
        Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691577021;
        bh=LyTyAYcCWhy9P1GM54GMnaf4Zhfavzu7QLAWbY47FA8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W0GqgS7sx+m94LDu/2FtqmN0I/VrpMU+lcjinEdW/yiYvzh1KWPjE+Uqb7uw04oPB
         aB0U9jttBb3uZTUv9yZN1cmZbp236k6lQeSYhHvA0wqXs139UOBeziJWiX1G3xOabj
         Z6n3g4i89DTWDhGCBQs5YA26ADJu6guVYWNd0apJo+l2GVKtpJB8wYUNCVg4ZzIoFf
         Ow30ss0aT9IVD8JVJNf68REM0p4MAq/YK/hZRb2sUyvspbCjVqExB6wiCbQdoMpC/j
         PJg+wrjHNoKrWVo8TgVj2MyzmiRrIuz40K3px1IxJOSsScctMMB4XTVZ/7mySCEfAZ
         TIHrf0ggW5lLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AEA0E505D5;
        Wed,  9 Aug 2023 10:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net/smc: Fix effective buffer size
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169157702136.3448.10286079156198080744.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 10:30:21 +0000
References: <20230804170624.940883-1-gbayer@linux.ibm.com>
In-Reply-To: <20230804170624.940883-1-gbayer@linux.ibm.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
        pabeni@redhat.com, kgraul@linux.ibm.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 19:06:22 +0200 you wrote:
> Hi all,
> 
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") started to derive the effective buffer size for
> SMC connections inconsistently in case a TCP fallback was used and
> memory consumption of SMC with the default settings was doubled when
> a connection negotiated SMC. That was not what we want.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/smc: Fix setsockopt and sysctl to specify same buffer size again
    https://git.kernel.org/netdev/net/c/833bac7ec392
  - [net,v3,2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
    https://git.kernel.org/netdev/net/c/30c3c4a4497c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


