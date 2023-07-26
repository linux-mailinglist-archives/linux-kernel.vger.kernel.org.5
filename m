Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2487F76291C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGZDKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGZDKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B42689
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF291611A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F5E5C433C9;
        Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690341020;
        bh=hMCPvZFKLanrr69pIj6onTahy0FPfqQtFdYlgvZi8yY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YimEVX3V/lBXfT96mJNBU5jx32jZYm5v4zTE705PjphtYXL2qupJSdfsRy2BevZ3u
         3duXn+r4F2YEpcfAsD8TT29XmLB/N7Dfzcpp+YHtsEBHftnD3bs1eNMd721M/kbYi8
         AtT/P50rsFFJgNCNiQ4NHh2UMp6pTRpGKFbBzBA2+twecVWj7sXcmJI54SDVp/z3xA
         P8YmG+ZH8PJfYpD+38kc4IyMHRuLeUYJ8U7A0XLCmad1oA85W7Z3L28DD40ITTcahc
         XScC9P1kymg2ix0UziIX9xLFBwsFLjeGI0rTtIlctyuquJoDOcXzMmnaivcjrQjpmy
         b+RUFwz1fnP7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B4A7C73FE2;
        Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] macvlan: add forgotten nla_policy for
 IFLA_MACVLAN_BC_CUTOFF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169034102003.18310.5663605946528991892.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Jul 2023 03:10:20 +0000
References: <20230723080205.3715164-1-linma@zju.edu.cn>
In-Reply-To: <20230723080205.3715164-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, 23 Jul 2023 16:02:05 +0800 you wrote:
> The previous commit 954d1fa1ac93 ("macvlan: Add netlink attribute for
> broadcast cutoff") added one additional attribute named
> IFLA_MACVLAN_BC_CUTOFF to allow broadcast cutfoff.
> 
> However, it forgot to describe the nla_policy at macvlan_policy
> (drivers/net/macvlan.c). Hence, this suppose NLA_S32 (4 bytes) integer
> can be faked as empty (0 bytes) by a malicious user, which could leads
> to OOB in heap just like CVE-2023-3773.
> 
> [...]

Here is the summary with links:
  - [v1] macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
    https://git.kernel.org/netdev/net/c/55cef78c244d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


