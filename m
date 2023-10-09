Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231337BE326
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJIOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjJIOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:40:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1F9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5923EC433CA;
        Mon,  9 Oct 2023 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696862423;
        bh=Qi8x1VMzL9xY8Ggs+lCxTdXpkKrxNatc88uic+xNA0c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pM7oO7mwOvaqH+hHooZ9UcwrUtxALjCYc/GKb6Cn+njhtUCBJeFyU3y8KOaskiYjB
         DQ6PTB3xDjNvDjureoSXN8aLI2pLqoqx1oL72m0/N0uOECa0BpHKRCoVT1ppYrNazN
         OwulwYbeJTDDVkBd6zMlaM1HME6ESZObVRbFoBJEL8AsBr8vMYVJtyHESD04Prh1Aj
         +SzQFvCgGqpGymE36VHIKwbKbFfADGMg6VCaiQquPUHLT10EOkNVRtdmRq9d2mwB4o
         Hb5uaCm4pZW02MjUM3bxh0bGGO99cDIKSYJMd/7sBESb4Nm0tm63KAKClrymDsmvCF
         5OLJQ/96lirQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41FDEE11F46;
        Mon,  9 Oct 2023 14:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add ability to pin bpf timer to calling
 CPU
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169686242326.26391.4445179958402601494.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Oct 2023 14:40:23 +0000
References: <20231004162339.200702-1-void@manifault.com>
In-Reply-To: <20231004162339.200702-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  4 Oct 2023 11:23:37 -0500 you wrote:
> BPF supports creating high resolution timers using bpf_timer_* helper
> functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
> specifies that the timeout should be interpreted as absolute time. It
> would also be useful to be able to pin that timer to a core. For
> example, if you wanted to make a subset of cores run without timer
> interrupts, and only have the timer be invoked on a single core.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Add ability to pin bpf timer to calling CPU
    https://git.kernel.org/bpf/bpf-next/c/d6247ecb6c1e
  - [bpf-next,v2,2/2] bpf/selftests: Test pinning bpf timer to a core
    https://git.kernel.org/bpf/bpf-next/c/0d7ae0686075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


