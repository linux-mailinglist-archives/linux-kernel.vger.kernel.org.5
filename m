Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF376A24B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGaVA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGaVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9334198C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671BD612DC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C39E0C433C9;
        Mon, 31 Jul 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837223;
        bh=hM4O6rd3rl2nwdrbPLh8e5AU2fMHoSthFtiO7uEZj/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DPedMuDbMyQ1WoVFNvox8yvkEgD6C6Ml10kIE3g2XgLeIwwxeI6xs6Xg18nKVWayw
         FqjjZkcP9a7aW5hpwGur4GWzysoL8jgGU+rC4l3VrAQB/HNWU7s4A0M0imuSci8gFx
         fpA8pJ8nWC46FGGv/HmQlBKgbyzcdT+qhdhhiG0SzsIWAVHWAGccjawM2036gcdN4h
         bcoWa7a7b/GEnN7b835EPcIfV+HJpsDWrMRMbe6X/YK8E/o72pRBpV23oVd9HFM6oM
         CHdW48Ff5iysxrYSYy1iFy4e7QmK1XQd0sGE1gjMHhTBwOctkL1P1UZwQS/Un8EL2s
         1nWD4oGKbL79w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E9BFC595C0;
        Mon, 31 Jul 2023 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE
 of udp[6]_ehashfn
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169083722364.15571.7926775828310116758.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:00:23 +0000
References: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
In-Reply-To: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 31 Jul 2023 11:42:53 +0200 you wrote:
> There are already INDIRECT_CALLABLE_DECLARE in the hashtable
> headers, no need to declare them again.
> 
> Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
> Suggested-by: Martin Lau <martin.lau@linux.dev>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
    https://git.kernel.org/bpf/bpf-next/c/74bdfab4fd7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


