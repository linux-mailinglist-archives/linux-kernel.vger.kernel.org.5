Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A0E7F08B7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKSUAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:00:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862012D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 12:00:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 792F9C433C9;
        Sun, 19 Nov 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700424025;
        bh=LY+pkwLAcEc+ElIOO4CBS95Gfp2RHMXsLkanNcnKQ+8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=btuISsfmuSCocr8c2/xqwi3+c2MvzRXf/Gd9S99LMyxTGvI523hky18FJa2b9hSPt
         ZDlqdchbRiHTvXrPmf+sxmSBCzMmj8PER5ECMb8TKyhElvvFE46kMPLOws1YkfW+nv
         9D0e3bpyzDJ3RoffDkkV2X3lHEpMGGQZ3us0WdT916M5wTNHs2nsRw33IYqnbJVys7
         RvbdwdsNV1a7jGyRGWjidnGD6gMtVpRl0KdgyrMzCGArM1WJG4qZI3S4TsPCXTUEnO
         YiDvis69I35TxFA81KEKLAXaYGpI7Pvb0BisA4kQI8j+3xyAlnDgdNFgOvPrNA0uUG
         I6dJwxDYNidqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61E55C4316B;
        Sun, 19 Nov 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse next_thread()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170042402539.15900.10514585865955411623.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Nov 2023 20:00:25 +0000
References: <20231114163211.GA874@redhat.com>
In-Reply-To: <20231114163211.GA874@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     ast@kernel.org, yonghong.song@linux.dev, zhouchuyi@bytedance.com,
        daniel@iogearbox.net, kuifeng@fb.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Nov 2023 17:32:11 +0100 you wrote:
> Compile tested.
> 
> Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
> the last user and is no exception.
> 
> Oleg.
> 
> [...]

Here is the summary with links:
  - [1/3] bpf: task_group_seq_get_next: use __next_thread() rather than next_thread()
    https://git.kernel.org/bpf/bpf-next/c/2d1618054f25
  - [2/3] bpf: bpf_iter_task_next: use __next_thread() rather than next_thread()
    https://git.kernel.org/bpf/bpf-next/c/5a34f9dabd9a
  - [3/3] bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)
    https://git.kernel.org/bpf/bpf-next/c/ac8148d957f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


