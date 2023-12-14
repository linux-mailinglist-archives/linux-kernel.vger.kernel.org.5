Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5796812548
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443049AbjLNCaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA363BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:30:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45A2FC433C9;
        Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702521024;
        bh=y2EG/KCgi10FK3ZjxuBE7voXPUxlA3BWrqZZbqiJ5Oo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AdgUcm+RBxdeixXwNYvhBeQgFJ3ag5pzjVKRfxRgFoX1/SvisIwal+nsp5IvjDLNi
         uLSSz0Y+etp1gJeJhXfZPJ52TvnYSnRQG8+3851k6MvOsvEwNHN05vEvcqMiFM+c+6
         qRxrbPWf+/el5giVZel4x0curTIHgUUWhj5oUiUcip3noH3zSMtP4G8g+1MHLEGqZ6
         nwCw4520GyA089w+RJqo4Kv2fqU9rE3y64le9ghPkKznMlFzLaOTbN+rotd9D/B25e
         QDEgfFKlf5Aw3k1YnWkBZM8r7VknUWzspCfvLUKffEPGCzxmwFMDI+UlSpHJKD6QhN
         eNbXBHSNwUbeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C62AC4314C;
        Thu, 14 Dec 2023 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170252102417.28832.15985840662984348558.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 02:30:24 +0000
References: <20231211162317.4116625-1-kniv@yandex-team.ru>
In-Reply-To: <20231211162317.4116625-1-kniv@yandex-team.ru>
To:     Nikolay Kuratov <kniv@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        kvm@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 19:23:17 +0300 you wrote:
> We need to do signed arithmetic if we expect condition
> `if (bytes < 0)` to be possible
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> 
> [...]

Here is the summary with links:
  - [v2] vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()
    https://git.kernel.org/netdev/net/c/60316d7f10b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


