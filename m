Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F5797C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjIGShV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIGShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B7CCC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC52CC433CA;
        Thu,  7 Sep 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694111424;
        bh=tPFCro4n4XqbzbiVH/c6S+dFL87j2IymQ5QNMO7GpnA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q6Uql2sI+pjR+2RawyCVkn6PrmAL3ckHOnxI1qEQ2N6P0MnQepCQ8j5WoRBKn4WCu
         mAocpfL3E0NiZuSeVMKHyoEXEqTOqRyVoxe1dK69uUAjL832v3IWSRVgCqHw7YfAK1
         AF/Zz8IpZnepTbKqAt+38NOhH+5+S1Id0iGac2qbmqcKPonuFqfT04FyKBM6mUApv6
         DPRMXSm4PgZToZK5nu3d/pA1f6BI8vc1tW5YO6iMt6MqrG2klCniz8T1xuZja4FWSW
         FWuHSOOkgiwIQQnRWrmC/rKNUSBXKJZqLDTUqp/dkWVk/o+QIL9MuqujFlzydUw2Xm
         9cWgXAugeQVDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE3D8C4166F;
        Thu,  7 Sep 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: distinguish error from valid pointers in
 enetc_fixup_clear_rss_rfs()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169411142477.4092.10947806557916457815.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Sep 2023 18:30:24 +0000
References: <20230906141609.247579-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230906141609.247579-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, claudiu.manoil@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org
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

On Wed,  6 Sep 2023 17:16:09 +0300 you wrote:
> enetc_psi_create() returns an ERR_PTR() or a valid station interface
> pointer, but checking for the non-NULL quality of the return code blurs
> that difference away. So if enetc_psi_create() fails, we call
> enetc_psi_destroy() when we shouldn't. This will likely result in
> crashes, since enetc_psi_create() cleans up everything after itself when
> it returns an ERR_PTR().
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()
    https://git.kernel.org/netdev/net/c/1b36955cc048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


