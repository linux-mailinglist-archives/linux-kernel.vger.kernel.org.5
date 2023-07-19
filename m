Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A94758A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGSBA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGSBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E070D3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C917C6160B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33EE2C433D9;
        Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689728423;
        bh=T//e2pfQDKWOAe1HJ27LKkSwaU+uIiZkMChAZ58CtAA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E1F7olaR4BCHYFgAN+enpj8qXdDxTtnlNpslqBeJYa1BahCneI2RcHV/J/2FYN1O/
         NYlTmC0ZHoAfzuD9+3kDVZddTLPQ/iA6jKkkHZEncEY+2gKEuvCJYo52kdWis85abU
         82yMDgzbHwsUU5PGw3NIIo6mDxGR4WnrSvYt35KAT9NdMzDqa5mv8dEuhrZecXvafz
         4Qdd3SUlnxf/wdy07eExPypSljj6LbiRpv/FtWe/o2DQ4FumkCybPJChjjD6girwxy
         DzcBc81e3WM98TueJE9JesVt//SerogbqIJQCSTxznHeZZjRUzi49jGow0NSdFgeTV
         +voN87V9ZuvPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F65FE22AE5;
        Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mvpp2: debugfs: remove redundant parameter check in
 three functions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168972842312.21294.6659811622444707479.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 01:00:23 +0000
References: <20230717025538.2848-1-duminjie@vivo.com>
In-Reply-To: <20230717025538.2848-1-duminjie@vivo.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     simon.horman@corigine.com, mw@semihalf.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 10:55:37 +0800 you wrote:
> As per the comment above debugfs_create_dir(), it is not expected to
> return an error, so an extra error check is not needed.
> Drop the return check of debugfs_create_dir() in
> mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
> and mvpp2_dbgfs_cls_init().
> 
> Fixes: b607cc61be41 ("net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs")
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: mvpp2: debugfs: remove redundant parameter check in three functions
    https://git.kernel.org/netdev/net-next/c/f8e343326c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


