Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6D78384F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHVDK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVDKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A1185;
        Mon, 21 Aug 2023 20:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E7163589;
        Tue, 22 Aug 2023 03:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFCEC433C8;
        Tue, 22 Aug 2023 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692673823;
        bh=MqMjNGXXKE+fnG8FGeTFISuoCtqfCuM1rjajbejYzzQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tWE8qg5xyqnDrMUIACOj5EhA7whUDPYtDQ2C14P5v/LknPK1Pk9d2/71IlydbuHF6
         DMkqCrxQFWLRDpK+Alg/0OYV2LqxiLBqrDKLuQXw0qBheR/F9pEbbRZ8zIipkJR4dj
         cl8dKFgP5rIEbMP195kRSjof9TXkPrVJ23/ZbIYvCTVgpQzeXg7rPVJ7T4+JP8VNJJ
         TSdYdaqMrH6zNeDDqrb4BsXMGQQUFTyNj0G20LfBzxHkwq3RXFV16SrdXjAoA69JoF
         zXKT4G9wTgZiSiGV2eRigq6SLr4IV1GgurFKNyzn9nQyzoDeOst2DQms9e13rjGgEs
         1toYkdh5ac2Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D00B0E4EAFB;
        Tue, 22 Aug 2023 03:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tg3: Use slab_build_skb() when needed
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169267382284.21798.14870275848532968526.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Aug 2023 03:10:22 +0000
References: <20230818175417.never.273-kees@kernel.org>
In-Reply-To: <20230818175417.never.273-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     siva.kallam@broadcom.com, f.ebner@proxmox.com,
        prashant@broadcom.com, mchan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        bagasdotme@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Fri, 18 Aug 2023 10:54:21 -0700 you wrote:
> The tg3 driver will use kmalloc() under some conditions. Check the
> frag_size and use slab_build_skb() when frag_size is 0. Silences
> the warning introduced by commit ce098da1497c ("skbuff: Introduce
> slab_build_skb()"):
> 
> 	Use slab_build_skb() instead
> 	...
> 	tg3_poll_work+0x638/0xf90 [tg3]
> 
> [...]

Here is the summary with links:
  - tg3: Use slab_build_skb() when needed
    https://git.kernel.org/netdev/net/c/99b415fe8986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


