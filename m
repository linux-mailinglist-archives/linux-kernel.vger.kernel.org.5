Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02685774DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHHWAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjHHWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4054E51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2DF62D97
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF9E2C433CB;
        Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691532022;
        bh=H6UWqzU2AtwovdQuQS5G8WAzsJds3IvG2UNfFhZJfAg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E3ON4tiaRAylgJGe38dMiWj32Pmz+4NoEAivrb3Ed8D9FjNkV9tpCqtYMO+1ym4Lq
         6ZV/aIswSBDzjV0r5Fp8l4Xkt5dJIy7IaRWLkWuNMow0XtQ9EjO2gBZunB3MZknLK5
         vNP/kwP+oRw7ruqTnmRVvVMTbj37tMzzudAgaAa9ssU9JdMUXt1477c9jCWWhXSsEm
         t1HTmzQiZY12s4b1DcEbuw4gv7n81SEXeu2C4PRYNxfDNcrM8pXX6L6Q8uu4m3twTV
         5A/z7nY/TuiMlArO/tWjXiGgdtkBQ555o6mSA2mJRSPqiVcz1J+J2NYVwbNTs+uUp9
         8K6MX2oir/TKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C643DE270C1;
        Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: marvell: prestera: fix handling IPv4 routes with nhid
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153202180.6931.3528754559838850676.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 22:00:21 +0000
References: <20230804101220.247515-1-jonas.gorski@bisdn.de>
In-Reply-To: <20230804101220.247515-1-jonas.gorski@bisdn.de>
To:     Jonas Gorski <jonas.gorski@bisdn.de>
Cc:     enachman@marvell.com, taras.chornyi@plvision.eu,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yevhen.orlov@plvision.eu,
        oleksandr.mazur@plvision.eu, tchornyi@marvell.com,
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Aug 2023 12:12:20 +0200 you wrote:
> Fix handling IPv4 routes referencing a nexthop via its id by replacing
> calls to fib_info_nh() with fib_info_nhc().
> 
> Trying to add an IPv4 route referencing a nextop via nhid:
> 
>     $ ip link set up swp5
>     $ ip a a 10.0.0.1/24 dev swp5
>     $ ip nexthop add dev swp5 id 20 via 10.0.0.2
>     $ ip route add 10.0.1.0/24 nhid 20
> 
> [...]

Here is the summary with links:
  - net: marvell: prestera: fix handling IPv4 routes with nhid
    https://git.kernel.org/netdev/net/c/2aa71b4b294e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


