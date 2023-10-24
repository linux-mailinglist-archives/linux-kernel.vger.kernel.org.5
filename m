Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41217D4ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjJXIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjJXIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC05C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDD81C433C8;
        Tue, 24 Oct 2023 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698137424;
        bh=j4HL2aupPBACZEv/S/x7M5eQl4uU26MAymTGtHLc+8A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NZYB6nucGCi3fCtKKh33IznbS2fs8ZV6bEXn3gtMPo+Qo/R68YHP2lhyl1gUNAr+F
         mlf3yfXP0VHhNryLhc0LmFqZ84n5JjWnjX5g30TS9TIWlcvAm0tbJXaei7pKlks6H6
         K9/OP6EY1EwId2LOhEicGkORn/gStS+iuK/TU/6MNxOiVH+4U4AuRGm021zH36ogF2
         fPpuIdVNNd9frixcJawjNhA6B6PK7/6Kl4L7tK5dzGeseH2ZJD35mlW8WmVV5QliMa
         G5yfIcx5mpp772jLXYkhS8DxcWQGy8/RdxjWUehhr+GJEXiO2YOZ+W2wFwI/Lq5WA+
         rwC5P0EJhJsdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BC3C41620;
        Tue, 24 Oct 2023 08:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169813742388.16775.7785724351431638461.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 08:50:23 +0000
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shakeelb@google.com, netdev@vger.kernel.org,
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Oct 2023 20:00:24 +0800 you wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/core/sock.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net,v3,1/3] sock: Code cleanup on __sk_mem_raise_allocated()
    https://git.kernel.org/netdev/net-next/c/2def8ff3fdb6
  - [net,v3,2/3] sock: Doc behaviors for pressure heurisitics
    https://git.kernel.org/netdev/net-next/c/2e12072c67b5
  - [net,v3,3/3] sock: Ignore memcg pressure heuristics when raising allocated
    https://git.kernel.org/netdev/net-next/c/66e6369e312d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


