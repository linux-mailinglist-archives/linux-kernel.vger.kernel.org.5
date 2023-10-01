Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C062B7B48D1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjJARU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjJARU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3CC9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D0EAC433C9;
        Sun,  1 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696180823;
        bh=QYgny6PwNamG5NS8GHQ8VLOhaddeQzPUUx73boo7bBs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=K/piiXxbampS+I1nE0kyK+HeWXLbcdtdnG/g/neTS/MFDlM/HPyr1hcO2lwtb63wa
         rt1sGW494KFWSPkqQ/it+E9Y5RlwaTNsHF4Wp4enzX/PnvP0vh7qTg2tSdsdfptrQs
         ijCkeKQ4rOLMlT+gtrso3TSxicJaFN6Y9oDoz/f1GXLRwXTqIoIdo1d5tLykpqodML
         kCBuKeQZmnCNMyXKqD8tmSsNZKUJxi2oiAleAGaksmx2vUFzz6hFnAcMlCxiNq3Mrk
         RHDHIdlWtsOLPAPcRhhgl7Yyk7kMnqerTtuDL2j+pB5vFGdLHiDEdlOHSpErEC/566
         kqTAGos+F/MOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 019AAC64457;
        Sun,  1 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4,
 ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169618082300.17513.8154196586548656981.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 17:20:23 +0000
References: <730408.1695292879@warthog.procyon.org.uk>
In-Reply-To: <730408.1695292879@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com,
        edumazet@google.com, willemdebruijn.kernel@gmail.com,
        davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, bpf@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
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

On Thu, 21 Sep 2023 11:41:19 +0100 you wrote:
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
> 
> The symptom observed is a warning in __ip6_append_data():
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
    https://git.kernel.org/netdev/net/c/9d4c75800f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


