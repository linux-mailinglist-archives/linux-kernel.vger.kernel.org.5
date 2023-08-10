Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97D7780BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHJSu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbjHJSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E82724;
        Thu, 10 Aug 2023 11:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1745652F8;
        Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A436C433CA;
        Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691693422;
        bh=83pI7ohsf9XQ96NY9vRh0auNjVEOrdk1c9s0zdDol+M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l3ahX9KgKthfG7/mhbLFtUet5Thg/nytPpir8Y6ONdcI3tFlLpV8Cr7VNAzg3Kg29
         FArdryOyCvw/izI8LPB9h1arKjkRZcVMY1iZX+hz/0H1B7ypayHraFUp0WLnHBLE8h
         IGCghtFT2ydeyVi+T7oYvxEUeeewXcZAAcpWX5hr6nzwJHtbLD8lyNDdZA+3EBVXcf
         BvTQi3zwpQFUuf0DDi4aW5Sxk05ZyubPGLIHnBSElZKKLVuYTCbRoqt/r5jHsjSY+L
         vuHVitmNRn+1Gdm48f2WM7AMq+OHpsolPiP8EKMD6OD/NAXWbYLdg7wKqOdStmGIcY
         3OsrXTtzGH+hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF37C64459;
        Thu, 10 Aug 2023 18:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169169342191.7825.8966149905125404687.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 18:50:21 +0000
References: <20230809020902.1941471-1-shaojijie@huawei.com>
In-Reply-To: <20230809020902.1941471-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 10:09:02 +0800 you wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> items to a string for content, and we add '\n' and '\0' in the last
> two bytes of content.
> 
> strscpy() will add '\0' in the last byte of destination buffer(one of
> items), it result in finishing content print ahead of schedule and some
> dump content truncation.
> 
> [...]

Here is the summary with links:
  - [net] net: hns3: fix strscpy causing content truncation issue
    https://git.kernel.org/netdev/net/c/5e3d20617b05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


