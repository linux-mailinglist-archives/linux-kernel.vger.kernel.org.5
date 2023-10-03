Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4157B6D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbjJCPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJCPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF6A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B6DEC433C7;
        Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696347626;
        bh=4+yCcSXsHd4MoVdHEC0vZG1u38JdAj+K8E7ian4dU50=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KNRUf2+O982oI0YZStrKSg7NLTF/nckCdyzp0lC3uT/zepAJ0yubT6igXCerIQuIS
         uaccbYO08cGhksLHIAWIvLCzafHkMzwgn3YBnPEeD8g5kpIGqOyk9hiMljT01T9+DO
         pIkUf2FNIcnwUcJ9TPT+YoJ04xhZr7s9NyL1bMeALMLvtHfcro/g/FEUwFFRrjQSRs
         EzyCaWMSasHLeaMFAtgxqmOwnnvFJFK6sDaaREkK8q7XI7NOMdqkllVzHnFtDDQaOG
         kn57Hy2ozFuVKzCGZrFAshPk3RqsCFvnOTE2lVXZIA3JEpZvz0f8NBPzyy4JlBtTVt
         SdLBAC1jVAi6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F89BE270EF;
        Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: nfc: llcp: Add lock when modifying device list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169634762619.3806.17902886441122676535.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 15:40:26 +0000
References: <20230925192351.40744-1-jeremy@jcline.org>
In-Reply-To: <20230925192351.40744-1-jeremy@jcline.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linma@zju.edu.cn, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
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

On Mon, 25 Sep 2023 15:23:51 -0400 you wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: nfc: llcp: Add lock when modifying device list
    https://git.kernel.org/netdev/net/c/dfc7f7a988da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


