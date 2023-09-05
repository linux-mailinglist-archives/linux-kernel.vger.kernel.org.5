Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F19792A63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjIEQgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353860AbjIEIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:23:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741FCC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5EADCE10BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 134FBC433C9;
        Tue,  5 Sep 2023 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693902230;
        bh=lXgtoW/7ZdWLp7FupnW2/nPdUn4Mb393H1EvaAlnsTA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SUUG93egXO/DO13piGEm1UfiUSBNgLW9xLH8XL50Un5yjkOG0XZfJEzUrFxeRv+Ad
         5LYN0R8VFlFRc+VDGsFU4BBHcWK3MZ/vDa1+LDJ8sfoyWqx+3Ljv1s2xMFf+epM5Gr
         9I+Txcr5KyysFjenjHXeXYwtzjBP/iuHoY7OvYBikaMZdsfuAZKPgGRr3D0jCMsk0m
         A7mqQ23SpwnSG1jKZ7bjibXOZvdjoiuQTVnYbe4beFd5h6/v1Gu5ATaJAqcq6eUX3U
         XgUl49oR7ydL4yF2tUsV5g52erS2v4qCgeZnD2WnaQHVeE4ErfumS/58lRjCjCYqDo
         U1sl3Kxtk1YTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9AADC2BBF6;
        Tue,  5 Sep 2023 08:23:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kcm: Destroy mutex in kcm_exit_net()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169390222995.8228.1309168830800797310.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Sep 2023 08:23:49 +0000
References: <20230902170708.1727999-1-syoshida@redhat.com>
In-Reply-To: <20230902170708.1727999-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Sep 2023 02:07:08 +0900 you wrote:
> kcm_exit_net() should call mutex_destroy() on knet->mutex. This is especially
> needed if CONFIG_DEBUG_MUTEXES is enabled.
> 
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/kcm/kcmsock.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] kcm: Destroy mutex in kcm_exit_net()
    https://git.kernel.org/netdev/net/c/6ad40b36cd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


