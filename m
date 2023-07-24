Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A989760340
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGXXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGXXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B8A1700
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60F5F61465
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E29DC433C8;
        Mon, 24 Jul 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690242019;
        bh=ZagSX846/VB+56WNwmLCa6W0VYBLzVVWnPbapOXzXkU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DkWalFaq28neAAlCnl5bdxjr0sMKVGsGJoHRTRqIC7BUc7vymJkBoEYzPZrnq/zjv
         KUzjTX6Y4JrrYbp0uQNZ3+K4hQ8MzfrEJ2+byHL7+cf8lxmsvX8k3yUx6L+sgVf0oF
         RxvFcx65G2B3C0vJ68njxNqq3jDSfx1k6pjzgEZ7MaRIMq5f4so93OolVgBZNsn2kk
         LpNVRIsnFBJGywT2JSCZmEDJ1O37hRXLSyqsZWX+B1wGhPrCX2ontvNvT8SyCaQqAd
         TBf57oS2PRLMi6fe/huXG9++Fx1NA0lJqkBmZqPL/gpa9zaNCxasWzMTqZtIHI4lAJ
         UKjs1iwhgfMAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 724E7E21EDD;
        Mon, 24 Jul 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] netconsole: Use sysfs_emit() instead of
 snprintf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169024201946.28598.11174713234443035562.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Jul 2023 23:40:19 +0000
References: <20230721092146.4036622-1-leitao@debian.org>
In-Reply-To: <20230721092146.4036622-1-leitao@debian.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leit@meta.com, pmladek@suse.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 02:21:44 -0700 you wrote:
> According to the sysfs.rst documentation, _show() functions should only
> use sysfs_emit() instead of snprintf().
> 
> Since snprintf() shouldn't be used in the sysfs _show() path, replace it
> by sysfs_emit().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netconsole: Use sysfs_emit() instead of snprintf()
    https://git.kernel.org/netdev/net-next/c/9f64b6e459d3
  - [net-next,2/2] netconsole: Use kstrtobool() instead of kstrtoint()
    https://git.kernel.org/netdev/net-next/c/004a04b97bbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


