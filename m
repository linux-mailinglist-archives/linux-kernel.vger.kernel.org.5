Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C177B9865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbjJDWue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjJDWud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C73C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:50:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C0CC433C8;
        Wed,  4 Oct 2023 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696459829;
        bh=29qFIdltgl6F0PKskAEDQDppIMvIB/Uobyguual+LQg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LEmpmqIlpgtWsaiXKVqzHc4G0I3TbO96VrUbSHaL0oeWWqWihAN0y2vaYQLoL/5pc
         FqNWOByLj+tTstlBaAf7AJIdyl0kUY3fsr884/RytG+u+Z76Zdfg31ZAcqDy31ROMY
         /fQxpefVfwO1lB/rxR8torCl0v5e/h643xIYz3B6X6huf67kwEpC2j2MN0nVwWxMdi
         lRvVtl7X67gGmOnKFhhGiyLSm6Tngrq8Ax2K253XVVSZoy11zewSd/qMDUKQS86/e8
         mM4Uu77Ng8b30wBFUDDDpC9XREAzQ+7ms7bRJHCyBz/3/MrHdpC+I0RGs/Ropu1LR/
         S5P2QKs+M6hFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78DADE632D6;
        Wed,  4 Oct 2023 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645982948.18987.9169162380776342631.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 22:50:29 +0000
References: <20230929181042.work.990-kees@kernel.org>
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gustavoars@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Sep 2023 11:11:44 -0700 you wrote:
> Hi,
> 
> This annotates several chelsio structures with the coming __counted_by
> attribute for bounds checking of flexible arrays at run-time. For more details,
> see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> [...]

Here is the summary with links:
  - [1/5] chelsio/l2t: Annotate struct l2t_data with __counted_by
    https://git.kernel.org/netdev/net-next/c/3bbae5f1c651
  - [2/5] cxgb4: Annotate struct clip_tbl with __counted_by
    https://git.kernel.org/netdev/net-next/c/c3db467b0822
  - [3/5] cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/157c56a4fede
  - [4/5] cxgb4: Annotate struct sched_table with __counted_by
    https://git.kernel.org/netdev/net-next/c/ceba9725fb45
  - [5/5] cxgb4: Annotate struct smt_data with __counted_by
    https://git.kernel.org/netdev/net-next/c/1508cb7e0752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


