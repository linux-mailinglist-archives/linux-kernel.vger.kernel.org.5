Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BC7C6742
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjJLHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjJLHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709CEB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:40:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65793C433C8;
        Thu, 12 Oct 2023 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697096422;
        bh=BKKA39C9Tt0Yl5gbHxH7plgRTiuALht33EVt+0dZXs8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W0f3kzq10SC8Yrp7aB0WV20UVG9lh827u9S/TSvFKN3qLm9lubyiYhqXr2tUrALBH
         jRLlkxTZshwBqVvsW6Y4aC7yazqE3TLu6UuGhHhXAQQEtMhKEJ0NirgE+AV30TGMZ2
         1/kx+hQnc6qOr3fiiNvxMwvONJp8kvhyRXwBMNlygsONWqgSUFdhoLYB4fW8FnGGmD
         3tPID4ZYRm2t2kTu1RKwC8awVEhapuDupKGjMOCWad6xwhPKeKuEkPavaErtg0ZSRq
         cSdjbnL/20B2Cq/gK9drJYe85nJykcgNYK18BeIYXZVcjrXUxnbXQ9UjQZPzU+tzlO
         SWaC17X0uS9xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C83C595C3;
        Thu, 12 Oct 2023 07:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] nfc: nci: assert requested protocol is valid
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169709642227.8662.4260240100354019441.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 07:40:22 +0000
References: <20231009200054.82557-1-jeremy@jcline.org>
In-Reply-To: <20231009200054.82557-1-jeremy@jcline.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        dvyukov@google.com, linma@zju.edu.cn, ilane@ti.com,
        linville@tuxdriver.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Oct 2023 16:00:54 -0400 you wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> [...]

Here is the summary with links:
  - [v2,net] nfc: nci: assert requested protocol is valid
    https://git.kernel.org/netdev/net/c/354a6e707e29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


